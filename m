Return-Path: <cgroups+bounces-12146-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2618BC77337
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 05:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id D39D82C057
	for <lists+cgroups@lfdr.de>; Fri, 21 Nov 2025 03:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43D27FD49;
	Fri, 21 Nov 2025 03:59:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14A244661;
	Fri, 21 Nov 2025 03:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763697542; cv=none; b=h6ZpEGCDVmC9fcER4dheYayGD9q7BVzagln4CDFH4RdaaKC9leOUD+nxoCh3FMj66cO+ZxRxlvka6JZTqR5qE1PPL/RJ1YeKY9oz/OfkZvnaqcHJ9+Z4NujYyyt3NHGdPJBp+VhC3BgLBve0RwxuFH1UNRhL40vdvNDpQC+qwOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763697542; c=relaxed/simple;
	bh=ojaFMEdAu27CBY90NnpMExcnwYGI2Cc6ptqMQOwLBYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FaY/MpgifkPxbIFdnCn1xpPuZMkDr/PHoOLG6Rwe6h3mBS3DryfLpLJGwDAhpJpYsy3iwi6NrKYS5j7/aY27Mbm6JYs7A06dDwb9kpSds/SO+kNpNf4Qntod9kDzeDGyISLH6XqCoGyNWWXpTa33kuaUsRWNQf3oCVOhnDGdyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dCLzM1mJkzYQtgk;
	Fri, 21 Nov 2025 11:58:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 248271A0359;
	Fri, 21 Nov 2025 11:58:50 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgA3ARN44x9pgwPPBQ--.14892S2;
	Fri, 21 Nov 2025 11:58:49 +0800 (CST)
Message-ID: <f31661d8-21e4-4626-86bb-8a8daa5d47ef@huaweicloud.com>
Date: Fri, 21 Nov 2025 11:58:48 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/26] mm: memcontrol: allocate object cgroup for
 non-kmem case
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@redhat.com, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <05ef300193bbe5bb7d2d97723efe928dab60429b.1761658310.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <05ef300193bbe5bb7d2d97723efe928dab60429b.1761658310.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA3ARN44x9pgwPPBQ--.14892S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary3CFyrJw4rGFyDAr18Krg_yoW7XFWDpF
	sxJFy3Aw4rArW7Gr1Ska9FvFyFka18XFW5K34xGw1xArsIqw15Jr12kw18AFyrAFyfGr1x
	Jrs0yw1kGF4Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/28 21:58, Qi Zheng wrote:
> From: Muchun Song <songmuchun@bytedance.com>
> 
> Pagecache pages are charged at allocation time and hold a reference
> to the original memory cgroup until reclaimed. Depending on memory
> pressure, page sharing patterns between different cgroups and cgroup
> creation/destruction rates, many dying memory cgroups can be pinned
> by pagecache pages, reducing page reclaim efficiency and wasting
> memory. Converting LRU folios and most other raw memory cgroup pins
> to the object cgroup direction can fix this long-living problem.
> 
> As a result, the objcg infrastructure is no longer solely applicable
> to the kmem case. In this patch, we extend the scope of the objcg
> infrastructure beyond the kmem case, enabling LRU folios to reuse
> it for folio charging purposes.
> 
> It should be noted that LRU folios are not accounted for at the root
> level, yet the folio->memcg_data points to the root_mem_cgroup. Hence,
> the folio->memcg_data of LRU folios always points to a valid pointer.
> However, the root_mem_cgroup does not possess an object cgroup.
> Therefore, we also allocate an object cgroup for the root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  mm/memcontrol.c | 51 +++++++++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d5257465c9d75..2afd7f99ca101 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -204,10 +204,10 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
>  	return objcg;
>  }
>  
> -static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> -				  struct mem_cgroup *parent)
> +static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
>  {
>  	struct obj_cgroup *objcg, *iter;
> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
>  
>  	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
>  
> @@ -3302,30 +3302,17 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  	return val;
>  }
>  
> -static int memcg_online_kmem(struct mem_cgroup *memcg)
> +static void memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> -	struct obj_cgroup *objcg;
> -
>  	if (mem_cgroup_kmem_disabled())
> -		return 0;
> +		return;
>  
>  	if (unlikely(mem_cgroup_is_root(memcg)))
> -		return 0;
> -
> -	objcg = obj_cgroup_alloc();
> -	if (!objcg)
> -		return -ENOMEM;
> -
> -	objcg->memcg = memcg;
> -	rcu_assign_pointer(memcg->objcg, objcg);
> -	obj_cgroup_get(objcg);
> -	memcg->orig_objcg = objcg;
> +		return;
>  
>  	static_branch_enable(&memcg_kmem_online_key);
>  
>  	memcg->kmemcg_id = memcg->id.id;
> -
> -	return 0;
>  }
>  
>  static void memcg_offline_kmem(struct mem_cgroup *memcg)
> @@ -3340,12 +3327,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  
>  	parent = parent_mem_cgroup(memcg);
>  	memcg_reparent_list_lrus(memcg, parent);
> -
> -	/*
> -	 * Objcg's reparenting must be after list_lru's, make sure list_lru
> -	 * helpers won't use parent's list_lru until child is drained.
> -	 */
> -	memcg_reparent_objcgs(memcg, parent);
>  }
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -3862,9 +3843,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	struct obj_cgroup *objcg;
>  
> -	if (memcg_online_kmem(memcg))
> -		goto remove_id;
> +	memcg_online_kmem(memcg);
>  
>  	/*
>  	 * A memcg must be visible for expand_shrinker_info()
> @@ -3874,6 +3855,15 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	if (alloc_shrinker_info(memcg))
>  		goto offline_kmem;
>  
> +	objcg = obj_cgroup_alloc();
> +	if (!objcg)
> +		goto free_shrinker;
> +
> +	objcg->memcg = memcg;
> +	rcu_assign_pointer(memcg->objcg, objcg);
> +	obj_cgroup_get(objcg);
> +	memcg->orig_objcg = objcg;
> +

Will it be better to add a helper function like obj_cgroup_init()?

>  	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
>  		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
>  				   FLUSH_TIME);
> @@ -3896,9 +3886,10 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  	xa_store(&mem_cgroup_ids, memcg->id.id, memcg, GFP_KERNEL);
>  
>  	return 0;
> +free_shrinker:
> +	free_shrinker_info(memcg);
>  offline_kmem:
>  	memcg_offline_kmem(memcg);
> -remove_id:
>  	mem_cgroup_id_remove(memcg);
>  	return -ENOMEM;
>  }
> @@ -3916,6 +3907,12 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  
>  	memcg_offline_kmem(memcg);
>  	reparent_deferred_split_queue(memcg);
> +	/*
> +	 * The reparenting of objcg must be after the reparenting of the
> +	 * list_lru and deferred_split_queue above, which ensures that they will
> +	 * not mistakenly get the parent list_lru and deferred_split_queue.
> +	 */
> +	memcg_reparent_objcgs(memcg);
>  	reparent_shrinker_deferred(memcg);
>  	wb_memcg_offline(memcg);
>  	lru_gen_offline_memcg(memcg);

-- 
Best regards,
Ridong


