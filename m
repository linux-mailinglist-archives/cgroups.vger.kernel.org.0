Return-Path: <cgroups+bounces-12151-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA95C77D77
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 09:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7E8B34014D
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 08:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2893833BBAE;
	Fri, 21 Nov 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l9cINglt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAF33B96D
	for <cgroups@vger.kernel.org>; Fri, 21 Nov 2025 08:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713095; cv=none; b=Y40+aWmi6cf+tShtdAtnw5442Q+OKmhqIAuSxho73U+cmkGJtFehT/uNQGtlm97mnIcGvRJPxg4ikBhreg5AzIgq6X+ng8AhmAuIy7A3nsFbd+yyFUrTnO5TM84lk/8XOpvQBXzUzIVhSuGJvvX0dOFKfivHxyyAIjhRtuIPqRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713095; c=relaxed/simple;
	bh=WnTPt8wuqcGBFvPOaOIvOJFtAEJbuOKn1WNGNugp2UM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TclQ7camzwdojDPyvBJZ1FpRU2dcH91Rnkb9Xx7yseIXTu2e4U5RB4voeugBTU1w/WtqzlR+VDGzTMk5/PpJT76OCvXLloy8hVla9OgoHIvEacPNvJk+vlVSEUDAD/602sz/7gtqI81eNBpOZRXi6Weii4GaIjncLrwAnJIx1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l9cINglt; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b2a64a62-9cf2-4d81-bcd0-1af7e64a34db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763713087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6j/lGFm/xWvuyqpIw5QwOUGYGHYdfUywDo5MBgkolKk=;
	b=l9cINgltohrtcBrc+2AtYmFNx8lZUo78oRgRikFYsusMSs99QnTpPxcYIQXUPu1wyugYP8
	iJkure1G943I4FPT/NCqiPEGjQaOP5goQgwlF5oWncxnldZqeUfOCLb1/dg3cED7tv6hL8
	kQQWjvNpP0As3m+DftnL7if3nTiV5hc=
Date: Fri, 21 Nov 2025 16:17:52 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 05/26] mm: memcontrol: allocate object cgroup for
 non-kmem case
To: Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org,
 hughd@google.com, mhocko@suse.com, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, david@redhat.com,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <05ef300193bbe5bb7d2d97723efe928dab60429b.1761658310.git.zhengqi.arch@bytedance.com>
 <f31661d8-21e4-4626-86bb-8a8daa5d47ef@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <f31661d8-21e4-4626-86bb-8a8daa5d47ef@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 11/21/25 11:58 AM, Chen Ridong wrote:
> 
> 
> On 2025/10/28 21:58, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> Pagecache pages are charged at allocation time and hold a reference
>> to the original memory cgroup until reclaimed. Depending on memory
>> pressure, page sharing patterns between different cgroups and cgroup
>> creation/destruction rates, many dying memory cgroups can be pinned
>> by pagecache pages, reducing page reclaim efficiency and wasting
>> memory. Converting LRU folios and most other raw memory cgroup pins
>> to the object cgroup direction can fix this long-living problem.
>>
>> As a result, the objcg infrastructure is no longer solely applicable
>> to the kmem case. In this patch, we extend the scope of the objcg
>> infrastructure beyond the kmem case, enabling LRU folios to reuse
>> it for folio charging purposes.
>>
>> It should be noted that LRU folios are not accounted for at the root
>> level, yet the folio->memcg_data points to the root_mem_cgroup. Hence,
>> the folio->memcg_data of LRU folios always points to a valid pointer.
>> However, the root_mem_cgroup does not possess an object cgroup.
>> Therefore, we also allocate an object cgroup for the root_mem_cgroup.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/memcontrol.c | 51 +++++++++++++++++++++++--------------------------
>>   1 file changed, 24 insertions(+), 27 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index d5257465c9d75..2afd7f99ca101 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -204,10 +204,10 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
>>   	return objcg;
>>   }
>>   
>> -static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
>> -				  struct mem_cgroup *parent)
>> +static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
>>   {
>>   	struct obj_cgroup *objcg, *iter;
>> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>>   
>>   	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
>>   
>> @@ -3302,30 +3302,17 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>>   	return val;
>>   }
>>   
>> -static int memcg_online_kmem(struct mem_cgroup *memcg)
>> +static void memcg_online_kmem(struct mem_cgroup *memcg)
>>   {
>> -	struct obj_cgroup *objcg;
>> -
>>   	if (mem_cgroup_kmem_disabled())
>> -		return 0;
>> +		return;
>>   
>>   	if (unlikely(mem_cgroup_is_root(memcg)))
>> -		return 0;
>> -
>> -	objcg = obj_cgroup_alloc();
>> -	if (!objcg)
>> -		return -ENOMEM;
>> -
>> -	objcg->memcg = memcg;
>> -	rcu_assign_pointer(memcg->objcg, objcg);
>> -	obj_cgroup_get(objcg);
>> -	memcg->orig_objcg = objcg;
>> +		return;
>>   
>>   	static_branch_enable(&memcg_kmem_online_key);
>>   
>>   	memcg->kmemcg_id = memcg->id.id;
>> -
>> -	return 0;
>>   }
>>   
>>   static void memcg_offline_kmem(struct mem_cgroup *memcg)
>> @@ -3340,12 +3327,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>>   
>>   	parent = parent_mem_cgroup(memcg);
>>   	memcg_reparent_list_lrus(memcg, parent);
>> -
>> -	/*
>> -	 * Objcg's reparenting must be after list_lru's, make sure list_lru
>> -	 * helpers won't use parent's list_lru until child is drained.
>> -	 */
>> -	memcg_reparent_objcgs(memcg, parent);
>>   }
>>   
>>   #ifdef CONFIG_CGROUP_WRITEBACK
>> @@ -3862,9 +3843,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>>   static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>   {
>>   	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
>> +	struct obj_cgroup *objcg;
>>   
>> -	if (memcg_online_kmem(memcg))
>> -		goto remove_id;
>> +	memcg_online_kmem(memcg);
>>   
>>   	/*
>>   	 * A memcg must be visible for expand_shrinker_info()
>> @@ -3874,6 +3855,15 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>   	if (alloc_shrinker_info(memcg))
>>   		goto offline_kmem;
>>   
>> +	objcg = obj_cgroup_alloc();
>> +	if (!objcg)
>> +		goto free_shrinker;
>> +
>> +	objcg->memcg = memcg;
>> +	rcu_assign_pointer(memcg->objcg, objcg);
>> +	obj_cgroup_get(objcg);
>> +	memcg->orig_objcg = objcg;
>> +
> 
> Will it be better to add a helper function like obj_cgroup_init()?

This part is not complicated, and it is only called in this one place,
so perhaps there is no need to add a helper function?

Of course, it doesn't matter, I'm fine with either method.

> 
>>   	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
>>   		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
>>   				   FLUSH_TIME);
>> @@ -3896,9 +3886,10 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>   	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
>>   
>>   	return 0;
>> +free_shrinker:
>> +	free_shrinker_info(memcg);
>>   offline_kmem:
>>   	memcg_offline_kmem(memcg);
>> -remove_id:
>>   	mem_cgroup_id_remove(memcg);
>>   	return -ENOMEM;
>>   }
>> @@ -3916,6 +3907,12 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>>   
>>   	memcg_offline_kmem(memcg);
>>   	reparent_deferred_split_queue(memcg);
>> +	/*
>> +	 * The reparenting of objcg must be after the reparenting of the
>> +	 * list_lru and deferred_split_queue above, which ensures that they will
>> +	 * not mistakenly get the parent list_lru and deferred_split_queue.
>> +	 */
>> +	memcg_reparent_objcgs(memcg);
>>   	reparent_shrinker_deferred(memcg);
>>   	wb_memcg_offline(memcg);
>>   	lru_gen_offline_memcg(memcg);
> 


