Return-Path: <cgroups+bounces-12562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEFECD4951
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 03:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD3F930019D2
	for <lists+cgroups@lfdr.de>; Mon, 22 Dec 2025 02:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F05B3242B7;
	Mon, 22 Dec 2025 02:51:58 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BFC2FE579;
	Mon, 22 Dec 2025 02:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766371918; cv=none; b=oVwAvyEqz1r6AB2KJGSslqAaDpD/qwZx+M48KExbSf1w9NxHkuRte74z79C4WD+kfvVISnG65DXNFhvatHZ24Cv5ybovgF0Y5ZvEFJRUVFRTW8P7l4S5aNzlFBINfbFN7GQGCGeR3TFvkiciTTj1vpL6fmoJequvwWRx7CoidB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766371918; c=relaxed/simple;
	bh=s0Rv4no/KtAgLKJ6gDgaVFO9vrdUHkl+5Tees1UotvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tiXSf3mQV3aR+au4+P28KBY0xYzlJYsC5Z92/dMFmEtu/7tHM2LSOpcdcqX/aU+yRvpykJ+mM8liH1wVj2ZI7hwi5XAFy0kxIIr1U5RMkivV6+yxQ3k0an/84uZcvNQAv3msIS/6rEvOZXGlkh93ZoT+t3ilgErHtWFfpgwJI6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dZN2G3xsYzKHMM2;
	Mon, 22 Dec 2025 10:51:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A4D9840562;
	Mon, 22 Dec 2025 10:51:50 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDHKPlFskhp_yArBA--.65468S2;
	Mon, 22 Dec 2025 10:51:50 +0800 (CST)
Message-ID: <d5df710a-e0e1-4254-b58f-60ddc5adcbd5@huaweicloud.com>
Date: Mon, 22 Dec 2025 10:51:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mm/vmscan: check all allowed targets in
 can_demote()
To: Bing Jiao <bingjiao@google.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 akpm@linux-foundation.org, gourry@gourry.net, longman@redhat.com,
 hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, tj@kernel.org,
 mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com,
 lorenzo.stoakes@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, cgroups@vger.kernel.org
References: <20251220061022.2726028-1-bingjiao@google.com>
 <20251221233635.3761887-1-bingjiao@google.com>
 <20251221233635.3761887-3-bingjiao@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251221233635.3761887-3-bingjiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHKPlFskhp_yArBA--.65468S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4rGrWkKFy7ury8JF1fJFb_yoWxCrWfpF
	s3G3W7Aa1rAFW7GrsIyayq9a4Svw4kJF45Ar18Wr1kAr9IqF1UZF1DXwn7JFy5AFyfurW7
	tFsxAr48u3yqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/22 7:36, Bing Jiao wrote:
> Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> introduces the cpuset.mems_effective check and applies it to
> can_demote(). However, it checks only the nodes in the immediate next
> demotion hierarchy and does not check all allowed demotion targets.
> This can cause pages to never be demoted if the nodes in the next
> demotion hierarchy are not set in mems_effective.
> 
> To address the bug, use mem_cgroup_filter_mems_allowed() to filter
> out allowed targets obtained from node_get_allowed_targets(). Also
> remove some unused functions.
> 
> Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> Signed-off-by: Bing Jiao <bingjiao@google.com>
> ---
>  include/linux/cpuset.h     |  6 ------
>  include/linux/memcontrol.h |  7 -------
>  kernel/cgroup/cpuset.c     | 28 ++++------------------------
>  mm/memcontrol.c            |  5 -----
>  mm/vmscan.c                | 14 ++++++++------
>  5 files changed, 12 insertions(+), 48 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index 0e94548e2d24..ed7c27276e71 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -174,7 +174,6 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
>  
> -extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
>  extern void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask);
>  #else /* !CONFIG_CPUSETS */
>  
> @@ -302,11 +301,6 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>  	return false;
>  }
>  
> -static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> -{
> -	return true;
> -}
> -
>  static inline void cpuset_node_filter_allowed(struct cgroup *cgroup,
>  					      nodemask_t *mask)
>  {
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7cfd71c57caa..41aab33499b5 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1740,8 +1740,6 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>  	rcu_read_unlock();
>  }
>  
> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
> -
>  void mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg, nodemask_t *mask);
>  
>  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
> @@ -1813,11 +1811,6 @@ static inline ino_t page_cgroup_ino(struct page *page)
>  	return 0;
>  }
>  
> -static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> -{
> -	return true;
> -}
> -
>  static inline bool mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg,
>  						  nodemask_t *mask)
>  {
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 2925bd6bca91..339779571508 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4416,11 +4416,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>  	return allowed;
>  }
>  
> -bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
>  {
>  	struct cgroup_subsys_state *css;
>  	struct cpuset *cs;
> -	bool allowed;
>  
>  	/*
>  	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
> @@ -4428,15 +4427,15 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>  	 * so return true to avoid taking a global lock on the empty check.
>  	 */
>  	if (!cpuset_v2())
> -		return true;
> +		return;
>  
>  	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
>  	if (!css)
> -		return true;
> +		return;
>  
>  	/*
>  	 * Normally, accessing effective_mems would require the cpuset_mutex
> -	 * or callback_lock - but node_isset is atomic and the reference
> +	 * or callback_lock - but it is acceptable and the reference
>  	 * taken via cgroup_get_e_css is sufficient to protect css.
>  	 *
>  	 * Since this interface is intended for use by migration paths, we
> @@ -4447,25 +4446,6 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>  	 * cannot make strong isolation guarantees, so this is acceptable.
>  	 */
>  	cs = container_of(css, struct cpuset, css);
> -	allowed = node_isset(nid, cs->effective_mems);
> -	css_put(css);
> -	return allowed;
> -}
> -
> -void cpuset_node_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
> -{
> -	struct cgroup_subsys_state *css;
> -	struct cpuset *cs;
> -
> -	if (!cpuset_v2())
> -		return;
> -
> -	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> -	if (!css)
> -		return;
> -
> -	/* Follows the same assumption in cpuset_node_allowed() */
> -	cs = container_of(css, struct cpuset, css);
>  	nodes_and(*mask, *mask, cs->effective_mems);
>  	css_put(css);
>  }

Oh, I see you merged these two functions here.

However, I think cpuset_get_mem_allowed would be more versatile in general use.

You can then check whether the returned nodemask intersects with your target mask. In the future,
there may be scenarios where users simply want to retrieve the effective masks directly.

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f414653867de..ebf5df3c8ca1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5597,11 +5597,6 @@ subsys_initcall(mem_cgroup_swap_init);
>  
>  #endif /* CONFIG_SWAP */
>  
> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> -{
> -	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
> -}
> -
>  void mem_cgroup_filter_mems_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
>  {
>  	if (memcg)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 4d23c491e914..fa4d51af7f44 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -344,19 +344,21 @@ static void flush_reclaim_state(struct scan_control *sc)
>  static bool can_demote(int nid, struct scan_control *sc,
>  		       struct mem_cgroup *memcg)
>  {
> -	int demotion_nid;
> +	struct pglist_data *pgdat = NODE_DATA(nid);
> +	nodemask_t allowed_mask;
>  
> -	if (!numa_demotion_enabled)
> +	if (!pgdat || !numa_demotion_enabled)
>  		return false;
>  	if (sc && sc->no_demotion)
>  		return false;
>  
> -	demotion_nid = next_demotion_node(nid);
> -	if (demotion_nid == NUMA_NO_NODE)
> +	node_get_allowed_targets(pgdat, &allowed_mask);
> +	if (nodes_empty(allowed_mask))
>  		return false;
>  
> -	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
> -	return mem_cgroup_node_allowed(memcg, demotion_nid);
> +	/* Filter the given nmask based on cpuset.mems.allowed */
> +	mem_cgroup_filter_mems_allowed(memcg, &allowed_mask);
> +	return !nodes_empty(allowed_mask);
>  }
>  
>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,

-- 
Best regards,
Ridong


