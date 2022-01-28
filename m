Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3D14A02B0
	for <lists+cgroups@lfdr.de>; Fri, 28 Jan 2022 22:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345002AbiA1Vb3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 16:31:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49390 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243179AbiA1Vb3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 16:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643405488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cPaaPTwaHnrZy5BBxHC8AwDN/oX7cxF5Nc5fiuL/xAs=;
        b=PHd3l7IV9C0n1kSscexU/ZktKHCfEB0V3V6JQXZoRRIcRTvaebO29a6dx49J9siz8HXpDz
        WZ0YYnhLNggADShGHcedq+mjhRkKUXSawWYPPOv00HBUuSeYjM+nRUspiYkSG+oUnwLOH2
        VXe4bLrEniot1kgeZYQ4i3zGz5bh3ZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-vIGYNqzuMMah-cPnGiTNJQ-1; Fri, 28 Jan 2022 16:31:23 -0500
X-MC-Unique: vIGYNqzuMMah-cPnGiTNJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84FD5814243;
        Fri, 28 Jan 2022 21:31:21 +0000 (UTC)
Received: from [10.22.33.1] (unknown [10.22.33.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 42AE8E2FE;
        Fri, 28 Jan 2022 21:31:08 +0000 (UTC)
Message-ID: <e14e8c96-b2e3-cb57-2c35-284116798225@redhat.com>
Date:   Fri, 28 Jan 2022 16:31:07 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] mm/page_owner: Dump memcg information
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Rafael Aquini <aquini@redhat.com>
References: <20220128195642.416743-1-longman@redhat.com>
 <20220128195642.416743-3-longman@redhat.com>
 <20220128212249.GI785175@iweiny-DESK2.sc.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220128212249.GI785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/28/22 16:22, Ira Weiny wrote:
> On Fri, Jan 28, 2022 at 02:56:42PM -0500, Waiman Long wrote:
>> It was found that a number of offlined memcgs were not freed because
>> they were pinned by some charged pages that were present. Even "echo
>> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
>> offlined but not freed memcgs tend to increase in number over time with
>> the side effect that percpu memory consumption as shown in /proc/meminfo
>> also increases over time.
>>
>> In order to find out more information about those pages that pin
>> offlined memcgs, the page_owner feature is extended to dump memory
>> cgroup information especially whether the cgroup is offlined or not.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/page_owner.c | 28 ++++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index c52ce9d6bc3b..e5d8c642296b 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/migrate.h>
>>   #include <linux/stackdepot.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/memcontrol.h>
>>   #include <linux/sched/clock.h>
>>   
>>   #include "internal.h"
>> @@ -339,6 +340,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   		depot_stack_handle_t handle)
>>   {
>>   	int ret = 0, pageblock_mt, page_mt;
>> +	unsigned long __maybe_unused memcg_data;
>>   	char *kbuf;
>>   
>>   	count = min_t(size_t, count, PAGE_SIZE);
>> @@ -371,6 +373,32 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   			"Page has been migrated, last migrate reason: %s\n",
>>   			migrate_reason_names[page_owner->last_migrate_reason]);
>>   
>> +#ifdef CONFIG_MEMCG
>> +	/*
>> +	 * Look for memcg information and print it out
>> +	 */
>> +	memcg_data = READ_ONCE(page->memcg_data);
>> +	if (memcg_data) {
>> +		struct mem_cgroup *memcg = page_memcg_check(page);
>> +		bool onlined;
>> +		char name[80];
>> +
>> +		if (memcg_data & MEMCG_DATA_OBJCGS)
>> +			SNPRINTF(kbuf, count, ret, err, "Slab cache page\n");
>> +
>> +		if (!memcg)
>> +			goto copy_out;
>> +
>> +		onlined = (memcg->css.flags & CSS_ONLINE);
>> +		cgroup_name(memcg->css.cgroup, name, sizeof(name) - 1);
>> +		SNPRINTF(kbuf, count, ret, err, "Charged %sto %smemcg %s\n",
>                                                          ^^^
> 						Extra specifier?
>
> Did this compile without warnings?

Yes, there was no warning.

Cheers,
Longmna

> Ira
>
>> +			PageMemcgKmem(page) ? "(via objcg) " : "",
>> +			onlined ? "" : "offlined ", name);
>> +	}
>> +
>> +copy_out:
>> +#endif
>> +
>>   	SNPRINTF(kbuf, count, ret, err, "\n");
>>   
>>   	if (copy_to_user(buf, kbuf, ret))
>> -- 
>> 2.27.0
>>
>>

