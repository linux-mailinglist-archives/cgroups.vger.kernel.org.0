Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BF8364EC5
	for <lists+cgroups@lfdr.de>; Tue, 20 Apr 2021 01:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhDSXmn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 19:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30782 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229664AbhDSXmm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 19:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618875732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x2fbpuknZ4GBkIrJZ+q/s36SJDLlw3O5/8yiMZIDB2k=;
        b=GnAI3uplwwEtQaxYKWV3BshepSSwTbas5xE8Bv1PLIrtNt87pYKw11qsZr5/LfUH+gR5uS
        Swq8xgb6yV9jIZwMKQ4sqJnA9TgsnUrh3cygGu9XIG2ay45LLUapTDLxPDIej5eGrEh3EO
        Jk5xdUUAek9hwPPKlSRjLw4FHx1qTjU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-JD4qxHjyO6uavvxgXfptSA-1; Mon, 19 Apr 2021 19:42:10 -0400
X-MC-Unique: JD4qxHjyO6uavvxgXfptSA-1
Received: by mail-qv1-f70.google.com with SMTP id e20-20020ad442b40000b029019aa511c767so10344727qvr.18
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 16:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=x2fbpuknZ4GBkIrJZ+q/s36SJDLlw3O5/8yiMZIDB2k=;
        b=WO3mULOT9G71W99OWum6P+LVzip4e9EFB7wll2JgRsKQTedu8cbZdHBuhuWkcSDxjv
         WDFUI/i4y8lGKPi0rSqn9pDRW7BiCYdbXy30AqNNtGBeP3rLZ4uDsMty4yMbOtE0U91u
         OAOnwhOdrCx/lHyeekx9+GyFToEgZTAufHeXGJbwVozrzxC6FRzDTnMd3q2y/9vLGeNe
         rLsj/0UWyWOID/BLXJ3DPOKErsR5HbnpV3/nrB+o/qeUm8GJcvPNeBGbHhKQSjDqgDUB
         fSu60R3+KL1fV982TMExkVKMnSpzX1YWAulVPhQro+/V5G+AZbRS3d1/qf05wmjj83qk
         7NCw==
X-Gm-Message-State: AOAM532U3qK4pEEsk3huJW2AVvgEOBVYs/O+Z2wMyKFSrrZrHFWZcVus
        tSqgiI18m8f07zTjM8Lh0OEhZKYPpWS/PMo+gfisUe8FbWPd2sc5UfxA9X+8y9RIAXwVo48OG1o
        d/URKDifSVeDNYhKHNg==
X-Received: by 2002:a05:620a:44ce:: with SMTP id y14mr14496782qkp.171.1618875729765;
        Mon, 19 Apr 2021 16:42:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9fC71GXWYH36qmAJMjWJoLcPTXWY88zaRU+br2/4wzu/F8zydzIcPi0q1wOkOFH+5QU+zCQ==
X-Received: by 2002:a05:620a:44ce:: with SMTP id y14mr14496759qkp.171.1618875729551;
        Mon, 19 Apr 2021 16:42:09 -0700 (PDT)
Received: from llong.remote.csb ([2601:191:8500:76c0::cdbc])
        by smtp.gmail.com with ESMTPSA id n6sm10102518qtx.22.2021.04.19.16.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Apr 2021 16:42:09 -0700 (PDT)
From:   Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 2/5] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-3-longman@redhat.com> <YH2yA1oZoyQoMhAH@cmpxchg.org>
Message-ID: <09ea1749-8978-091b-7727-d86f8e6c49cc@redhat.com>
Date:   Mon, 19 Apr 2021 19:42:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YH2yA1oZoyQoMhAH@cmpxchg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 4/19/21 12:38 PM, Johannes Weiner wrote:
> On Sun, Apr 18, 2021 at 08:00:29PM -0400, Waiman Long wrote:
>> Before the new slab memory controller with per object byte charging,
>> charging and vmstat data update happen only when new slab pages are
>> allocated or freed. Now they are done with every kmem_cache_alloc()
>> and kmem_cache_free(). This causes additional overhead for workloads
>> that generate a lot of alloc and free calls.
>>
>> The memcg_stock_pcp is used to cache byte charge for a specific
>> obj_cgroup to reduce that overhead. To further reducing it, this patch
>> makes the vmstat data cached in the memcg_stock_pcp structure as well
>> until it accumulates a page size worth of update or when other cached
>> data change. Caching the vmstat data in the per-cpu stock eliminates two
>> writes to non-hot cachelines for memcg specific as well as memcg-lruvecs
>> specific vmstat data by a write to a hot local stock cacheline.
>>
>> On a 2-socket Cascade Lake server with instrumentation enabled and this
>> patch applied, it was found that about 20% (634400 out of 3243830)
>> of the time when mod_objcg_state() is called leads to an actual call
>> to __mod_objcg_state() after initial boot. When doing parallel kernel
>> build, the figure was about 17% (24329265 out of 142512465). So caching
>> the vmstat data reduces the number of calls to __mod_objcg_state()
>> by more than 80%.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> Reviewed-by: Shakeel Butt <shakeelb@google.com>
>> ---
>>   mm/memcontrol.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 61 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index dc9032f28f2e..693453f95d99 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -2213,7 +2213,10 @@ struct memcg_stock_pcp {
>>   
>>   #ifdef CONFIG_MEMCG_KMEM
>>   	struct obj_cgroup *cached_objcg;
>> +	struct pglist_data *cached_pgdat;
>>   	unsigned int nr_bytes;
>> +	int vmstat_idx;
>> +	int vmstat_bytes;
>>   #endif
>>   
>>   	struct work_struct work;
>> @@ -3150,8 +3153,9 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>>   	css_put(&memcg->css);
>>   }
>>   
>> -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>> -		     enum node_stat_item idx, int nr)
>> +static inline void __mod_objcg_state(struct obj_cgroup *objcg,
>> +				     struct pglist_data *pgdat,
>> +				     enum node_stat_item idx, int nr)
> This naming is dangerous, as the __mod_foo naming scheme we use
> everywhere else suggests it's the same function as mod_foo() just with
> preemption/irqs disabled.
>
I will change its name to, say, mod_objcg_mlstate() to indicate that it 
is something different. Actually, it is hard to come up with a good name 
which is not too long.


>> @@ -3159,10 +3163,53 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>>   	rcu_read_lock();
>>   	memcg = obj_cgroup_memcg(objcg);
>>   	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>> -	mod_memcg_lruvec_state(lruvec, idx, nr);
>> +	__mod_memcg_lruvec_state(lruvec, idx, nr);
>>   	rcu_read_unlock();
>>   }
>>   
>> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>> +		     enum node_stat_item idx, int nr)
>> +{
>> +	struct memcg_stock_pcp *stock;
>> +	unsigned long flags;
>> +
>> +	local_irq_save(flags);
>> +	stock = this_cpu_ptr(&memcg_stock);
>> +
>> +	/*
>> +	 * Save vmstat data in stock and skip vmstat array update unless
>> +	 * accumulating over a page of vmstat data or when pgdat or idx
>> +	 * changes.
>> +	 */
>> +	if (stock->cached_objcg != objcg) {
>> +		/* Output the current data as is */
> When you get here with the wrong objcg and hit the cold path, it's
> usually immediately followed by an uncharge -> refill_obj_stock() that
> will then flush and reset cached_objcg.
>
> Instead of doing two cold paths, why not flush the old objcg right
> away and set the new so that refill_obj_stock() can use the fast path?

That is a good idea. Will do that.


>
>> +	} else if (!stock->vmstat_bytes) {
>> +		/* Save the current data */
>> +		stock->vmstat_bytes = nr;
>> +		stock->vmstat_idx = idx;
>> +		stock->cached_pgdat = pgdat;
>> +		nr = 0;
>> +	} else if ((stock->cached_pgdat != pgdat) ||
>> +		   (stock->vmstat_idx != idx)) {
>> +		/* Output the cached data & save the current data */
>> +		swap(nr, stock->vmstat_bytes);
>> +		swap(idx, stock->vmstat_idx);
>> +		swap(pgdat, stock->cached_pgdat);
> Is this optimization worth doing?
>
> You later split vmstat_bytes and idx doesn't change anymore.

I am going to merge patch 2 and patch 4 to avoid the confusion.


>
> How often does the pgdat change? This is a per-cpu cache after all,
> and the numa node a given cpu allocates from tends to not change that
> often. Even with interleaving mode, which I think is pretty rare, the
> interleaving happens at the slab/page level, not the object level, and
> the cache isn't bigger than a page anyway.

The testing done on a 2-socket system indicated that pgdat changes 
roughly 10-20% of time. So it does happen, especially on the kfree() 
path, I think. I have tried to cached vmstat update for those on the 
local node only, but I got more misses with that. So I am just going to 
change pgdat and flush out existing data for now.


>
>> +	} else {
>> +		stock->vmstat_bytes += nr;
>> +		if (abs(stock->vmstat_bytes) > PAGE_SIZE) {
>> +			nr = stock->vmstat_bytes;
>> +			stock->vmstat_bytes = 0;
>> +		} else {
>> +			nr = 0;
>> +		}
> ..and this is the regular overflow handling done by the objcg and
> memcg charge stock as well.
>
> How about this?
>
> 	if (stock->cached_objcg != objcg ||
> 	    stock->cached_pgdat != pgdat ||
> 	    stock->vmstat_idx != idx) {
> 		drain_obj_stock(stock);
> 		obj_cgroup_get(objcg);
> 		stock->cached_objcg = objcg;
> 		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
> 		stock->vmstat_idx = idx;
> 	}
> 	stock->vmstat_bytes += nr_bytes;
>
> 	if (abs(stock->vmstat_bytes > PAGE_SIZE))
> 		drain_obj_stock(stock);
>
> (Maybe we could be clever, here since the charge and stat caches are
> the same size: don't flush an oversized charge cache from
> refill_obj_stock in the charge path, but leave it to the
> mod_objcg_state() that follows; likewise don't flush an undersized
> vmstat stock from mod_objcg_state() in the uncharge path, but leave it
> to the refill_obj_stock() that follows. Could get a bit complicated...)

If you look at patch 5, I am trying to avoid doing drain_obj_stock() 
unless the objcg change. I am going to do the same here.

Cheers,
Longman

