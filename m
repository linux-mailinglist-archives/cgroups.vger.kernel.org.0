Return-Path: <cgroups+bounces-12741-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE832CDE45C
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 04:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65C903005FD4
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 03:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0632C22578A;
	Fri, 26 Dec 2025 03:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F1rcE0X5"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DF53A1E7A
	for <cgroups@vger.kernel.org>; Fri, 26 Dec 2025 03:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766718655; cv=none; b=pReLbacNr7L7L01T1TeN17IHKZ/xWHvstUi13zNWLtkhJh2PR8Wjwpl4wzIo1N1HnlrP1C/4AdcVTqkbWrkwN7FOst4lZkkSkRvaRy1pztkibfpks36pnvli0sco34q3hmpV5B2xRWQu2redBTZ47cdMKlIut82YnrpwI8KvfgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766718655; c=relaxed/simple;
	bh=0wpdNrJHQmXsNJxVPIP03HysavvSEwl4jlCMs3777as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SndGD+/k4yRRGAbVHiqGQP7hupYhGuvdOoQodA+z/8pzQseA2gu6dHlkCde1NJttR7x0suXZPw2WgkeCSz/4LAMb+WERZmC9r6nyUkjj2YlZ7ZjKw3UDdrFKevvqFGcOVEc+6EktgAGtl2oNrlMohP0linGuY5VCo0pGM/WP7js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F1rcE0X5; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a055507f-9c4d-4fb1-b5a6-bda9c2dc20ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766718645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oakc8UIltDCqM50pbiDVUP88U4Bwxm69FCpdnnX3hns=;
	b=F1rcE0X51B4tiRn0V9OLndqsZkOiOeIoMejY+ZIBYwnNfFhgrjbtHaTIXc8Mp7ONsrsfkf
	7CCxsZJFda1viXd/0vFCv4ULvpZcwyEWRrQn7Q73ooh7h+9eChDvuYHHRlh3hBEDu8vEB4
	cYiXwFGZqDn2zaP8MSwF7Lav6dxbZwU=
Date: Fri, 26 Dec 2025 11:10:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/28] mm: memcontrol: return root object cgroup for
 root memory cgroup
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>, Qi Zheng <qi.zheng@linux.dev>,
 hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, david@kernel.org,
 lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com,
 imran.f.khan@oracle.com, kamalesh.babulal@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <3e454b151f3926dbd67d5df6dc2b129edd927101.1765956025.git.zhengqi.arch@bytedance.com>
 <05500a05-aa90-4b60-a324-2819dc2c5805@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <05500a05-aa90-4b60-a324-2819dc2c5805@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2025/12/26 09:03, Chen Ridong wrote:
>
> On 2025/12/17 15:27, Qi Zheng wrote:
>> From: Muchun Song <songmuchun@bytedance.com>
>>
>> Memory cgroup functions such as get_mem_cgroup_from_folio() and
>> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
>> even for the root memory cgroup. In contrast, the situation for
>> object cgroups has been different.
>>
>> Previously, the root object cgroup couldn't be returned because
>> it didn't exist. Now that a valid root object cgroup exists, for
>> the sake of consistency, it's necessary to align the behavior of
>> object-cgroup-related operations with that of memory cgroup APIs.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   include/linux/memcontrol.h | 26 +++++++++++++++++-----
>>   mm/memcontrol.c            | 45 ++++++++++++++++++++------------------
>>   mm/percpu.c                |  2 +-
>>   3 files changed, 45 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 288dd6337f80f..776d9be1f446a 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -332,6 +332,7 @@ struct mem_cgroup {
>>   #define MEMCG_CHARGE_BATCH 64U
>>   
>>   extern struct mem_cgroup *root_mem_cgroup;
>> +extern struct obj_cgroup *root_obj_cgroup;
>>   
>>   enum page_memcg_data_flags {
>>   	/* page->memcg_data is a pointer to an slabobj_ext vector */
>> @@ -549,6 +550,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>>   	return (memcg == root_mem_cgroup);
>>   }
>>   
>> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
>> +{
>> +	return objcg == root_obj_cgroup;
>> +}
>> +
>>   static inline bool mem_cgroup_disabled(void)
>>   {
>>   	return !cgroup_subsys_enabled(memory_cgrp_subsys);
>> @@ -773,23 +779,26 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
>>   
>>   static inline bool obj_cgroup_tryget(struct obj_cgroup *objcg)
>>   {
>> +	if (obj_cgroup_is_root(objcg))
>> +		return true;
>>   	return percpu_ref_tryget(&objcg->refcnt);
>>   }
>>   
>> -static inline void obj_cgroup_get(struct obj_cgroup *objcg)
>> +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
>> +				       unsigned long nr)
>>   {
>> -	percpu_ref_get(&objcg->refcnt);
>> +	if (!obj_cgroup_is_root(objcg))
>> +		percpu_ref_get_many(&objcg->refcnt, nr);
>>   }
>>   
>> -static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
>> -				       unsigned long nr)
>> +static inline void obj_cgroup_get(struct obj_cgroup *objcg)
>>   {
>> -	percpu_ref_get_many(&objcg->refcnt, nr);
>> +	obj_cgroup_get_many(objcg, 1);
>>   }
>>   
>>   static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>>   {
>> -	if (objcg)
>> +	if (objcg && !obj_cgroup_is_root(objcg))
>>   		percpu_ref_put(&objcg->refcnt);
>>   }
>>   
>> @@ -1084,6 +1093,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>>   	return true;
>>   }
>>   
>> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
>> +{
>> +	return true;
>> +}
>> +
>>   static inline bool mem_cgroup_disabled(void)
>>   {
>>   	return true;
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>> index 544b3200db12d..21b5aad34cae7 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -83,6 +83,8 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
>>   struct mem_cgroup *root_mem_cgroup __read_mostly;
>>   EXPORT_SYMBOL(root_mem_cgroup);
>>   
>> +struct obj_cgroup *root_obj_cgroup __read_mostly;
>> +
>>   /* Active memory cgroup to use from an interrupt context */
>>   DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
>>   EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
>> @@ -2634,15 +2636,14 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
>>   
>>   static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>>   {
>> -	struct obj_cgroup *objcg = NULL;
>> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
>> +		struct obj_cgroup *objcg = rcu_dereference(memcg->objcg);
>>   
>> -	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>> -		objcg = rcu_dereference(memcg->objcg);
>>   		if (likely(objcg && obj_cgroup_tryget(objcg)))
>> -			break;
>> -		objcg = NULL;
>> +			return objcg;
>>   	}
>> -	return objcg;
>> +
>> +	return NULL;
>>   }
>>   
>>   static struct obj_cgroup *current_objcg_update(void)
>> @@ -2716,18 +2717,17 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>>   		 * Objcg reference is kept by the task, so it's safe
>>   		 * to use the objcg by the current task.
>>   		 */
>> -		return objcg;
>> +		return objcg ? : root_obj_cgroup;
>>   	}
>>   
>>   	memcg = this_cpu_read(int_active_memcg);
>>   	if (unlikely(memcg))
>>   		goto from_memcg;
>>   
>> -	return NULL;
>> +	return root_obj_cgroup;
>>   
>>   from_memcg:
>> -	objcg = NULL;
>> -	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
>> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
>>   		/*
>>   		 * Memcg pointer is protected by scope (see set_active_memcg())
>>   		 * and is pinning the corresponding objcg, so objcg can't go
>> @@ -2736,10 +2736,10 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>>   		 */
>>   		objcg = rcu_dereference_check(memcg->objcg, 1);
>>   		if (likely(objcg))
>> -			break;
>> +			return objcg;
>>   	}
>>   
>> -	return objcg;
>> +	return root_obj_cgroup;
>>   }
>>   
>>   struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
>> @@ -2753,14 +2753,8 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
>>   		objcg = __folio_objcg(folio);
>>   		obj_cgroup_get(objcg);
>>   	} else {
>> -		struct mem_cgroup *memcg;
>> -
>>   		rcu_read_lock();
>> -		memcg = __folio_memcg(folio);
>> -		if (memcg)
>> -			objcg = __get_obj_cgroup_from_memcg(memcg);
>> -		else
>> -			objcg = NULL;
>> +		objcg = __get_obj_cgroup_from_memcg(__folio_memcg(folio));
>>   		rcu_read_unlock();
>>   	}
>>   	return objcg;
>> @@ -2863,7 +2857,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>>   	int ret = 0;
>>   
>>   	objcg = current_obj_cgroup();
>> -	if (objcg) {
>> +	if (objcg && !obj_cgroup_is_root(objcg)) {
>>   		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
>>   		if (!ret) {
>>   			obj_cgroup_get(objcg);
>> @@ -3164,7 +3158,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>>   	 * obj_cgroup_get() is used to get a permanent reference.
>>   	 */
>>   	objcg = current_obj_cgroup();
>> -	if (!objcg)
>> +	if (!objcg || obj_cgroup_is_root(objcg))
>>   		return true;
>>   
>>   	/*
>> @@ -3851,6 +3845,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>>   	if (!objcg)
>>   		goto free_shrinker;
>>   
>> +	if (unlikely(mem_cgroup_is_root(memcg)))
>> +		root_obj_cgroup = objcg;
>> +
>>   	objcg->memcg = memcg;
>>   	rcu_assign_pointer(memcg->objcg, objcg);
>>   	obj_cgroup_get(objcg);
>> @@ -5471,6 +5468,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>>   	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>   		return;
>>   
>> +	if (obj_cgroup_is_root(objcg))
>> +		return;
>> +
>>   	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
>>   
>>   	/* PF_MEMALLOC context, charging must succeed */
>> @@ -5498,6 +5498,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
>>   	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>>   		return;
>>   
>> +	if (obj_cgroup_is_root(objcg))
>> +		return;
>> +
>>   	obj_cgroup_uncharge(objcg, size);
>>   
> If we modify zswap by adding MEMCG_ZSWAP_B and MEMCG_ZSWAPPED with obj_cgroup_charge_zswap , then
> remove a control group (via rmdir) and reparent its objects to the root cgroup, then for the root
> cgroup, obj_cgroup_uncharge_zswap will return directly due to the obj_cgroup_is_root check. Would
> this cause us to miss decrementing MEMCG_ZSWAP_B and MEMCG_ZSWAPPED?

I'm not sure I fully understand the problem—how could this happen, given 
that
obj_cgroup_charge_zswap also checks for the root objcg?

Muchun,
Thanks.
>
>>   	rcu_read_lock();
>> diff --git a/mm/percpu.c b/mm/percpu.c
>> index 81462ce5866e1..5c1a9b77d6b93 100644
>> --- a/mm/percpu.c
>> +++ b/mm/percpu.c
>> @@ -1616,7 +1616,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
>>   		return true;
>>   
>>   	objcg = current_obj_cgroup();
>> -	if (!objcg)
>> +	if (!objcg || obj_cgroup_is_root(objcg))
>>   		return true;
>>   
>>   	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))


