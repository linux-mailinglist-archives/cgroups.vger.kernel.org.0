Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 291984A2B74
	for <lists+cgroups@lfdr.de>; Sat, 29 Jan 2022 04:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352304AbiA2Dff (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Jan 2022 22:35:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352303AbiA2Dff (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Jan 2022 22:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643427334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQBH9GHjqS+rcFX3pcvUpks72KYFeedJ6djvUFY0Gn8=;
        b=O7dSL0+11b9DTlW18CTRntnV/jiLt1yGGixh/y7pMWhIyUJpvZ2Y9IwtMM9/plTA2XN6If
        cRi3iKONbWyGXlomtfCNaW9hy9xTOFhP/theZ1Hg7D75c9KBPdh4avG9YMlG8mlwVpRqE/
        BAJvuH34o0HYkMCniQx4p/KV8+KyETk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-z98i_43JPHSrFhuU4R2vnw-1; Fri, 28 Jan 2022 22:35:31 -0500
X-MC-Unique: z98i_43JPHSrFhuU4R2vnw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A06EF1006AA5;
        Sat, 29 Jan 2022 03:35:29 +0000 (UTC)
Received: from [10.22.32.53] (unknown [10.22.32.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 357EE60BD8;
        Sat, 29 Jan 2022 03:35:22 +0000 (UTC)
Message-ID: <1badb3ac-6631-68ac-364d-69dee237583c@redhat.com>
Date:   Fri, 28 Jan 2022 22:35:22 -0500
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
 <e14e8c96-b2e3-cb57-2c35-284116798225@redhat.com>
 <20220128214843.GJ785175@iweiny-DESK2.sc.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220128214843.GJ785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/28/22 16:48, Ira Weiny wrote:
> On Fri, Jan 28, 2022 at 04:31:07PM -0500, Waiman Long wrote:
>> On 1/28/22 16:22, Ira Weiny wrote:
>>> On Fri, Jan 28, 2022 at 02:56:42PM -0500, Waiman Long wrote:
>>>> It was found that a number of offlined memcgs were not freed because
>>>> they were pinned by some charged pages that were present. Even "echo
>>>> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
>>>> offlined but not freed memcgs tend to increase in number over time with
>>>> the side effect that percpu memory consumption as shown in /proc/meminfo
>>>> also increases over time.
>>>>
>>>> In order to find out more information about those pages that pin
>>>> offlined memcgs, the page_owner feature is extended to dump memory
>>>> cgroup information especially whether the cgroup is offlined or not.
>>>>
>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>> ---
>>>>    mm/page_owner.c | 28 ++++++++++++++++++++++++++++
>>>>    1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>>>> index c52ce9d6bc3b..e5d8c642296b 100644
>>>> --- a/mm/page_owner.c
>>>> +++ b/mm/page_owner.c
>>>> @@ -10,6 +10,7 @@
>>>>    #include <linux/migrate.h>
>>>>    #include <linux/stackdepot.h>
>>>>    #include <linux/seq_file.h>
>>>> +#include <linux/memcontrol.h>
>>>>    #include <linux/sched/clock.h>
>>>>    #include "internal.h"
>>>> @@ -339,6 +340,7 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>>>    		depot_stack_handle_t handle)
>>>>    {
>>>>    	int ret = 0, pageblock_mt, page_mt;
>>>> +	unsigned long __maybe_unused memcg_data;
>>>>    	char *kbuf;
>>>>    	count = min_t(size_t, count, PAGE_SIZE);
>>>> @@ -371,6 +373,32 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>>>    			"Page has been migrated, last migrate reason: %s\n",
>>>>    			migrate_reason_names[page_owner->last_migrate_reason]);
>>>> +#ifdef CONFIG_MEMCG
>>>> +	/*
>>>> +	 * Look for memcg information and print it out
>>>> +	 */
>>>> +	memcg_data = READ_ONCE(page->memcg_data);
>>>> +	if (memcg_data) {
>>>> +		struct mem_cgroup *memcg = page_memcg_check(page);
>>>> +		bool onlined;
>>>> +		char name[80];
>>>> +
>>>> +		if (memcg_data & MEMCG_DATA_OBJCGS)
>>>> +			SNPRINTF(kbuf, count, ret, err, "Slab cache page\n");
>>>> +
>>>> +		if (!memcg)
>>>> +			goto copy_out;
>>>> +
>>>> +		onlined = (memcg->css.flags & CSS_ONLINE);
>>>> +		cgroup_name(memcg->css.cgroup, name, sizeof(name) - 1);
>>>> +		SNPRINTF(kbuf, count, ret, err, "Charged %sto %smemcg %s\n",
>>>                                                           ^^^
>>> 						Extra specifier?
>>>
>>> Did this compile without warnings?
>> Yes, there was no warning.
> But isn't that an extra specifier?

There are 3 arguments to the format string that match the 3 "%s" in it:

1) PageMemcgKmem(page) ? "(via objcg) " : ""
2) onlined ? "" : "offlined
3) name

Cheers,
Longman

