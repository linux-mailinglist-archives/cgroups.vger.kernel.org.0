Return-Path: <cgroups+bounces-8649-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FB1AEC467
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 05:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD03AC8D5
	for <lists+cgroups@lfdr.de>; Sat, 28 Jun 2025 03:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF43215F7D;
	Sat, 28 Jun 2025 03:09:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080F2B9BF;
	Sat, 28 Jun 2025 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751080186; cv=none; b=D2D8zifZHTHIVDC8s8JWQZ5uTgSIqSMIfUj6II0VW5yhGCuGKUMYDXoQX0gXq2Jd7Q6yK4BQ7E9FereetWS9HuCTnfYVl0ZxMoq50phjK/saj0ug0t3M+4o79D4UJYgwADAWPYfNgbTL9UjbKYsUIbbBzf0652pJGOASbkoHLKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751080186; c=relaxed/simple;
	bh=Q7q9S/xhkDWWI8fBhvNJklMqJ6k6atlOZOnlJ72aLkU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WfN1iBCucbqeVE+J5wuAZsi7rGsZXsrLque4ylKBShZIFRO5j2o1lC52srNZpnMD6nL8ugnV/PZL2XPWB4GfEn3az5YB1iMCOwqjH9EXzQc+nCMiADaRQSWHMk22Ol18G9AnBrX41MN2C1iLdUmy14qrx+OL32tarVzOUye691k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bTcpt4X5PzKHMkd;
	Sat, 28 Jun 2025 11:09:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 0643A1A13BD;
	Sat, 28 Jun 2025 11:09:41 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAHWcPzXF9oEV2CQg--.34775S2;
	Sat, 28 Jun 2025 11:09:40 +0800 (CST)
Message-ID: <d84092a7-fc3d-4c3c-98b3-341d63a21b18@huaweicloud.com>
Date: Sat, 28 Jun 2025 11:09:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/28] mm: memcontrol: return root object cgroup for
 root memory cgroup
To: Muchun Song <songmuchun@bytedance.com>, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, akpm@linux-foundation.org, david@fromorbit.com,
 zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com,
 chengming.zhou@linux.dev
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-mm@kvack.org, hamzamahfooz@linux.microsoft.com,
 apais@linux.microsoft.com
References: <20250415024532.26632-1-songmuchun@bytedance.com>
 <20250415024532.26632-11-songmuchun@bytedance.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250415024532.26632-11-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAHWcPzXF9oEV2CQg--.34775S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4DWry7KF1xuF13Cw4DArb_yoW3CF4xpa
	nrCF9xtw4rA3yDGr4Sgayqva4rZa18Xr45JryxGwn7AF4aq3ZxJr1ayr1jyFyrAFZxGry7
	Jrs0yF43CFW2yFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/4/15 10:45, Muchun Song wrote:
> Memory cgroup functions such as get_mem_cgroup_from_folio() and
> get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
> even for the root memory cgroup. In contrast, the situation for
> object cgroups has been different.
> 
> Previously, the root object cgroup couldn't be returned because
> it didn't exist. Now that a valid root object cgroup exists, for
> the sake of consistency, it's necessary to align the behavior of
> object-cgroup-related operations with that of memory cgroup APIs.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  include/linux/memcontrol.h | 29 ++++++++++++++++++-------
>  mm/memcontrol.c            | 44 ++++++++++++++++++++------------------
>  mm/percpu.c                |  2 +-
>  3 files changed, 45 insertions(+), 30 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bb4f203733f3..e74922d5755d 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -319,6 +319,7 @@ struct mem_cgroup {
>  #define MEMCG_CHARGE_BATCH 64U
>  
>  extern struct mem_cgroup *root_mem_cgroup;
> +extern struct obj_cgroup *root_obj_cgroup;
>  
>  enum page_memcg_data_flags {
>  	/* page->memcg_data is a pointer to an slabobj_ext vector */
> @@ -528,6 +529,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>  	return (memcg == root_mem_cgroup);
>  }
>  
> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
> +{
> +	return objcg == root_obj_cgroup;
> +}
> +
>  static inline bool mem_cgroup_disabled(void)
>  {
>  	return !cgroup_subsys_enabled(memory_cgrp_subsys);
> @@ -752,23 +758,26 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
>  
>  static inline bool obj_cgroup_tryget(struct obj_cgroup *objcg)
>  {
> +	if (obj_cgroup_is_root(objcg))
> +		return true;
>  	return percpu_ref_tryget(&objcg->refcnt);
>  }
>  
> -static inline void obj_cgroup_get(struct obj_cgroup *objcg)
> +static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> +				       unsigned long nr)
>  {
> -	percpu_ref_get(&objcg->refcnt);
> +	if (!obj_cgroup_is_root(objcg))
> +		percpu_ref_get_many(&objcg->refcnt, nr);
>  }
>  
> -static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
> -				       unsigned long nr)
> +static inline void obj_cgroup_get(struct obj_cgroup *objcg)
>  {
> -	percpu_ref_get_many(&objcg->refcnt, nr);
> +	obj_cgroup_get_many(objcg, 1);
>  }
>  
>  static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>  {
> -	if (objcg)
> +	if (objcg && !obj_cgroup_is_root(objcg))
>  		percpu_ref_put(&objcg->refcnt);
>  }
>  
> @@ -1101,6 +1110,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
>  	return true;
>  }
>  
> +static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
> +{
> +	return true;
> +}
> +
>  static inline bool mem_cgroup_disabled(void)
>  {
>  	return true;
> @@ -1684,8 +1698,7 @@ static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
>  {
>  	struct obj_cgroup *objcg = current_obj_cgroup();
>  
> -	if (objcg)
> -		obj_cgroup_get(objcg);
> +	obj_cgroup_get(objcg);
>  
>  	return objcg;
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a6362d11b46c..4aadc1b87db3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -81,6 +81,7 @@ struct cgroup_subsys memory_cgrp_subsys __read_mostly;
>  EXPORT_SYMBOL(memory_cgrp_subsys);
>  
>  struct mem_cgroup *root_mem_cgroup __read_mostly;
> +struct obj_cgroup *root_obj_cgroup __read_mostly;
>  
>  /* Active memory cgroup to use from an interrupt context */
>  DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> @@ -2525,15 +2526,14 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
>  
>  static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
>  {
> -	struct obj_cgroup *objcg = NULL;
> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> +		struct obj_cgroup *objcg = rcu_dereference(memcg->objcg);
>  
> -	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> -		objcg = rcu_dereference(memcg->objcg);
>  		if (likely(objcg && obj_cgroup_tryget(objcg)))
> -			break;
> -		objcg = NULL;
> +			return objcg;
>  	}
> -	return objcg;
> +
> +	return NULL;
>  }
>  

It appears that the return NULL statement might be dead code in this
context. And would it be preferable to use return root_obj_cgroup instead?

Best regards,
Ridong

>  static struct obj_cgroup *current_objcg_update(void)
> @@ -2604,18 +2604,17 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>  		 * Objcg reference is kept by the task, so it's safe
>  		 * to use the objcg by the current task.
>  		 */
> -		return objcg;
> +		return objcg ? : root_obj_cgroup;
>  	}
>  
>  	memcg = this_cpu_read(int_active_memcg);
>  	if (unlikely(memcg))
>  		goto from_memcg;
>  
> -	return NULL;
> +	return root_obj_cgroup;
>  
>  from_memcg:
> -	objcg = NULL;
> -	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
>  		/*
>  		 * Memcg pointer is protected by scope (see set_active_memcg())
>  		 * and is pinning the corresponding objcg, so objcg can't go
> @@ -2624,10 +2623,10 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
>  		 */
>  		objcg = rcu_dereference_check(memcg->objcg, 1);
>  		if (likely(objcg))
> -			break;
> +			return objcg;
>  	}
>  
> -	return objcg;
> +	return root_obj_cgroup;
>  }
>  
>  struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
> @@ -2641,14 +2640,8 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
>  		objcg = __folio_objcg(folio);
>  		obj_cgroup_get(objcg);
>  	} else {
> -		struct mem_cgroup *memcg;
> -
>  		rcu_read_lock();
> -		memcg = __folio_memcg(folio);
> -		if (memcg)
> -			objcg = __get_obj_cgroup_from_memcg(memcg);
> -		else
> -			objcg = NULL;
> +		objcg = __get_obj_cgroup_from_memcg(__folio_memcg(folio));
>  		rcu_read_unlock();
>  	}
>  	return objcg;
> @@ -2733,7 +2726,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  	int ret = 0;
>  
>  	objcg = current_obj_cgroup();
> -	if (objcg) {
> +	if (!obj_cgroup_is_root(objcg)) {
>  		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
>  		if (!ret) {
>  			obj_cgroup_get(objcg);
> @@ -3036,7 +3029,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
>  	 * obj_cgroup_get() is used to get a permanent reference.
>  	 */
>  	objcg = current_obj_cgroup();
> -	if (!objcg)
> +	if (obj_cgroup_is_root(objcg))
>  		return true;
>  
>  	/*
> @@ -3708,6 +3701,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	if (!objcg)
>  		goto free_shrinker;
>  
> +	if (unlikely(mem_cgroup_is_root(memcg)))
> +		root_obj_cgroup = objcg;
> +
>  	objcg->memcg = memcg;
>  	rcu_assign_pointer(memcg->objcg, objcg);
>  	obj_cgroup_get(objcg);
> @@ -5302,6 +5298,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return;
>  
> +	if (obj_cgroup_is_root(objcg))
> +		return;
> +
>  	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
>  
>  	/* PF_MEMALLOC context, charging must succeed */
> @@ -5329,6 +5328,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
>  	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>  		return;
>  
> +	if (obj_cgroup_is_root(objcg))
> +		return;
> +
>  	obj_cgroup_uncharge(objcg, size);
>  
>  	rcu_read_lock();
> diff --git a/mm/percpu.c b/mm/percpu.c
> index b35494c8ede2..3e54c6fca9bd 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1616,7 +1616,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
>  		return true;
>  
>  	objcg = current_obj_cgroup();
> -	if (!objcg)
> +	if (obj_cgroup_is_root(objcg))
>  		return true;
>  
>  	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))


