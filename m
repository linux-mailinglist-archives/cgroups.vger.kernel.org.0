Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03EE4A51CA
	for <lists+cgroups@lfdr.de>; Mon, 31 Jan 2022 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbiAaVnz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 31 Jan 2022 16:43:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43239 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234253AbiAaVny (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 31 Jan 2022 16:43:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643665433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2vOsI9mzkRFCto94nwtjznBsJWt/XMYQapLVHPa3ks=;
        b=eUpfWd6yHSn4oMKh/aTUYjlDhC7dvgWi1ZG2tHLW7gP7bY7zLDQtXx8JfGcN75h4Ge5wCL
        OtxhDp9e2ll243TwQhMCd0itQTBXrZxW0JeaC+NlkaS5Cay5nA7xZmc6gXTWfYohAgi7N+
        VZnHQzpHvNdE/+eeBSq6rAK3rcRkF38=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-661-aWHuSTTpNl-LHIiBlIK70A-1; Mon, 31 Jan 2022 16:43:50 -0500
X-MC-Unique: aWHuSTTpNl-LHIiBlIK70A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F30338143E5;
        Mon, 31 Jan 2022 21:43:47 +0000 (UTC)
Received: from [10.22.16.244] (unknown [10.22.16.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92BFA1037F4B;
        Mon, 31 Jan 2022 21:43:32 +0000 (UTC)
Message-ID: <4234fc60-5d65-1089-555a-734218aa6f9c@redhat.com>
Date:   Mon, 31 Jan 2022 16:43:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v3 3/4] mm/page_owner: Print memcg information
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <guro@fb.com>, Rafael Aquini <aquini@redhat.com>
References: <20220131192308.608837-1-longman@redhat.com>
 <20220131192308.608837-4-longman@redhat.com> <YfhLzI+RLRGgexmr@kernel.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YfhLzI+RLRGgexmr@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


On 1/31/22 15:51, Mike Rapoport wrote:
> On Mon, Jan 31, 2022 at 02:23:07PM -0500, Waiman Long wrote:
>> It was found that a number of offlined memcgs were not freed because
>> they were pinned by some charged pages that were present. Even "echo
>> 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
>> offlined but not freed memcgs tend to increase in number over time with
>> the side effect that percpu memory consumption as shown in /proc/meminfo
>> also increases over time.
>>
>> In order to find out more information about those pages that pin
>> offlined memcgs, the page_owner feature is extended to print memory
>> cgroup information especially whether the cgroup is offlined or not.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Acked-by: David Rientjes <rientjes@google.com>
>> ---
>>   mm/page_owner.c | 39 +++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 39 insertions(+)
>>
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 28dac73e0542..a471c74c7fe0 100644
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
>> @@ -325,6 +326,42 @@ void pagetypeinfo_showmixedcount_print(struct seq_file *m,
>>   	seq_putc(m, '\n');
>>   }
>>   
>> +#ifdef CONFIG_MEMCG
>> +/*
>> + * Looking for memcg information and print it out
>> + */
>> +static inline void print_page_owner_memcg(char *kbuf, size_t count, int *pret,
>> +					  struct page *page)
>> +{
>> +	unsigned long memcg_data = READ_ONCE(page->memcg_data);
>> +	struct mem_cgroup *memcg;
>> +	bool onlined;
>> +	char name[80];
>> +
>> +	if (!memcg_data)
>> +		return;
>> +
>> +	if (memcg_data & MEMCG_DATA_OBJCGS)
>> +		*pret += scnprintf(kbuf + *pret, count - *pret,
>> +				"Slab cache page\n");
> Don't we need to check for overflow here?

See my previous patch 2 and the reason I used scnprintf() is that it 
never return a length that is >= the given size. So overflow won't 
happen. The final snprintf() in print_page_owner() will detect buffer 
overflow.


>
>> +
>> +	memcg = page_memcg_check(page);
>> +	if (!memcg)
>> +		return;
>> +
>> +	onlined = (memcg->css.flags & CSS_ONLINE);
>> +	cgroup_name(memcg->css.cgroup, name, sizeof(name));
>> +	*pret += scnprintf(kbuf + *pret, count - *pret,
>> +			"Charged %sto %smemcg %s\n",
>> +			PageMemcgKmem(page) ? "(via objcg) " : "",
>> +			onlined ? "" : "offlined ",
>> +			name);
> Ditto
>
>> +}
>> +#else /* CONFIG_MEMCG */
>> +static inline void print_page_owner_memcg(char *kbuf, size_t count, int *pret,
>> +					  struct page *page) { }
> I think #ifdef inside the print_page_owner_memcg() functions will be
> simpler and clearer.
Yes, I see both styles used in kernel code though this style is probably 
more common. I will keep this unless there is a good reason to do otherwise.
>
>> +#endif /* CONFIG_MEMCG */
>> +
>>   static ssize_t
>>   print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   		struct page *page, struct page_owner *page_owner,
>> @@ -365,6 +402,8 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
>>   			migrate_reason_names[page_owner->last_migrate_reason]);
>>   	}
>>   
>> +	print_page_owner_memcg(kbuf, count, &ret, page);
>> +
> ret can go over count here.
> Why not make print_page_owner_memcg() an int so that the call will be
> consistent with other calls in print_page_owner():
>
> 	ret += print_page_owner_memcg(kbuf, count, page);
> 	if (ret >= count)
> 		goto err;

See my comments above.

Cheers,
Longman

