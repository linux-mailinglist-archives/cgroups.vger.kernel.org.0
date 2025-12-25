Return-Path: <cgroups+bounces-12692-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36517CDD5CC
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 07:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 035103017F1E
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 06:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060102D8362;
	Thu, 25 Dec 2025 06:23:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9EA247280;
	Thu, 25 Dec 2025 06:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766643831; cv=none; b=C74pgPQ2ZyYHpUqFw72ax2jjMe7qd7k+2qMQ8I9PO+1ZtYlsD+u+EJacXVGPxf427987/9N2u1zVRJRyzSwHJ4vcVEgZaFxERXxY3JUEwZY4IGMqUiNT8MzhSgstBcTWDVFyq0gijf0z3lW/JU35RgbB9kJ+kknADzqqXo2SPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766643831; c=relaxed/simple;
	bh=IfPk9vsLXIaezG+bYlzWKQdFSsp2ueV4zEnCnbLHWRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+yjY/vHUkOh6l4tIz8jufhQTxYORBtRHwW6yY5xKOIgijLq+G5N8/zeczPrb9/RjOlg8PbL5M4T9lPYjCJEOlecEnK2LITnP38CIZvE1LDh9+BidnKdoFw84nBN7GvSi2I1ooMPp7qSUwCjpp+YS6FACX2gD0MYNDC5BLp+Eok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dcJZx0GPnzYQtGK;
	Thu, 25 Dec 2025 14:23:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E20A440573;
	Thu, 25 Dec 2025 14:23:44 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAn1vZv2Exp596fBQ--.65098S2;
	Thu, 25 Dec 2025 14:23:44 +0800 (CST)
Message-ID: <644493f5-46df-45f7-a071-9ae7faae1f5c@huaweicloud.com>
Date: Thu, 25 Dec 2025 14:23:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/28] mm: memcontrol: allocate object cgroup for
 non-kmem case
To: Qi Zheng <qi.zheng@linux.dev>, hannes@cmpxchg.org, hughd@google.com,
 mhocko@suse.com, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, david@kernel.org, lorenzo.stoakes@oracle.com,
 ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, mkoutny@suse.com, akpm@linux-foundation.org,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765956025.git.zhengqi.arch@bytedance.com>
 <897be76398cb2027d08d1bcda05260ede54dc134.1765956025.git.zhengqi.arch@bytedance.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <897be76398cb2027d08d1bcda05260ede54dc134.1765956025.git.zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAn1vZv2Exp596fBQ--.65098S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ary3CFyrJw4rGryfZF4kCrg_yoW7Ar1kpF
	sxGFy3Aw4rArWUGr1Ska9FvFyFka18XrW5K34xGw1xZrsIqw15tr12kw1UAFyrAFyfGr1x
	Jrs0yw1kGa1Yya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/12/17 15:27, Qi Zheng wrote:
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
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  mm/memcontrol.c | 51 +++++++++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 27 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index ae234518d023c..544b3200db12d 100644
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
> @@ -3294,30 +3294,17 @@ unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
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

Not about this patch.

Should we add?
	if (!memcg_kmem_online())
		static_branch_enable(&memcg_kmem_online_key);

>  	memcg->kmemcg_id = memcg->id.id;
> -
> -	return 0;
>  }
>  
>  static void memcg_offline_kmem(struct mem_cgroup *memcg)
> @@ -3332,12 +3319,6 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
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
> @@ -3854,9 +3835,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
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
> @@ -3866,6 +3847,15 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
>  	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
>  		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
>  				   FLUSH_TIME);
> @@ -3888,9 +3878,10 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
> @@ -3908,6 +3899,12 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
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


Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


