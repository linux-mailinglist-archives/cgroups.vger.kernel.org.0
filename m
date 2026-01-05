Return-Path: <cgroups+bounces-12897-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C40CF1ACD
	for <lists+cgroups@lfdr.de>; Mon, 05 Jan 2026 03:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 365863005A8D
	for <lists+cgroups@lfdr.de>; Mon,  5 Jan 2026 02:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0825030C366;
	Mon,  5 Jan 2026 02:48:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDF12D7D30;
	Mon,  5 Jan 2026 02:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767581303; cv=none; b=AJ6RJtkEGGiym/h1rrFJ5X12cH15kfe1hgX+nCcDMsLSQgMHzsYyHZwg2jePTgkjalZDFeBkt5cgsU2QwZ+bVkwgO0+LOiANo9Fdny26sjcWHYjYACsFy68S5XjU8GtqUulb+HpVmIsQ4G9YAr7dkwLyY79jpK+fFI5HXBoInyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767581303; c=relaxed/simple;
	bh=AU8XBsx9SOS6FVdoIsOKf76XbcUjQMzKP/4SWWulqk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C64DCz8oyW/FLMUIJiS4ov+sPuK2ENccOmpV465NNNnh+ZnkB+bUl3VkWrKnIK5EdvlARr55RTcQC+2Ty3Gv+5be6zLsbQA6872XInO2MnVWi7Da3+gWrjUiQvyf7Dd+jzkxiCXzfDqpLtzDIvctY8xNWooZfwreRlku60i7+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dkzGn6bMlzYQtsT;
	Mon,  5 Jan 2026 10:47:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 157B440599;
	Mon,  5 Jan 2026 10:48:12 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBH9vZqJltpcVSxCg--.65049S2;
	Mon, 05 Jan 2026 10:48:11 +0800 (CST)
Message-ID: <b55451ff-b861-4e4f-bc79-6de0c802d64e@huaweicloud.com>
Date: Mon, 5 Jan 2026 10:48:09 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
To: Bing Jiao <bingjiao@google.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gourry@gourry.net, longman@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 cgroups@vger.kernel.org
References: <20251223212032.665731-1-bingjiao@google.com>
 <20260104085439.4076810-1-bingjiao@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260104085439.4076810-1-bingjiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBH9vZqJltpcVSxCg--.65049S2
X-Coremail-Antispam: 1UD129KBjvJXoW3uF45Ar47WrWxCw4kZF43KFg_yoWkGr47pF
	s5Gw1rCr4rArW7Gr4Svayq9a4Fvw1kXF45A3WxWrn7AF9IqF1jgr1Dtwn3XFWUCFyrur12
	qF13Aw18u3yqya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2026/1/4 16:54, Bing Jiao wrote:
> Fix two bugs in demote_folio_list() and can_demote() due to incorrect
> demotion target checks in reclaim/demotion.
> 
> Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> introduces the cpuset.mems_effective check and applies it to
> can_demote(). However:
> 
>   1. It does not apply this check in demote_folio_list(), which leads
>      to situations where pages are demoted to nodes that are
>      explicitly excluded from the task's cpuset.mems.
> 
>   2. It checks only the nodes in the immediate next demotion hierarchy
>      and does not check all allowed demotion targets in can_demote().
>      This can cause pages to never be demoted if the nodes in the next
>      demotion hierarchy are not set in mems_effective.
> 
> These bugs break resource isolation provided by cpuset.mems.
> This is visible from userspace because pages can either fail to be
> demoted entirely or are demoted to nodes that are not allowed
> in multi-tier memory systems.
> 
> To address these bugs, update cpuset_node_allowed() and
> mem_cgroup_node_allowed() to return effective_mems, allowing directly
> logic-and operation against demotion targets. Also update can_demote()
> and demote_folio_list() accordingly.
> 
> Bug 1 reproduction:
>   Assume a system with 4 nodes, where nodes 0-1 are top-tier and
>   nodes 2-3 are far-tier memory. All nodes have equal capacity.
> 
>   Test script:
>     echo 1 > /sys/kernel/mm/numa/demotion_enabled
>     mkdir /sys/fs/cgroup/test
>     echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>     echo "0-2" > /sys/fs/cgroup/test/cpuset.mems
>     echo $$ > /sys/fs/cgroup/test/cgroup.procs
>     swapoff -a
>     # Expectation: Should respect node 0-2 limit.
>     # Observation: Node 3 shows significant allocation (MemFree drops)
>     stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1
> 
> Bug 2 reproduction:
>   Assume a system with 6 nodes, where nodes 0-2 are top-tier,
>   node 3 is a far-tier node, and nodes 4-5 are the farthest-tier nodes.
>   All nodes have equal capacity.
> 
>   Test script:
>     echo 1 > /sys/kernel/mm/numa/demotion_enabled
>     mkdir /sys/fs/cgroup/test
>     echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
>     echo "0-2,4-5" > /sys/fs/cgroup/test/cpuset.mems
>     echo $$ > /sys/fs/cgroup/test/cgroup.procs
>     swapoff -a
>     # Expectation: Pages are demoted to Nodes 4-5
>     # Observation: No pages are demoted before oom.
>     stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1,2
> 
> Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bing Jiao <bingjiao@google.com>
> 
> ---
> v3 -> v4:
> Update functions to filter out nodes that are not in cgroup's
> mems_allowed rather than returning mems_allowed directly.
> It minimizes stack usage and remains versatile enough to return
> mems_allowed when all possible nodes are set in the passed
> nodemask_t pointer.
> ---
> 
>  include/linux/cpuset.h     |  7 ++++---
>  include/linux/memcontrol.h |  6 +++---
>  kernel/cgroup/cpuset.c     | 24 +++++++++++++++---------
>  mm/memcontrol.c            |  5 +++--
>  mm/vmscan.c                | 32 +++++++++++++++++++++-----------
>  5 files changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index a98d3330385c..c937537f318a 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -174,7 +174,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
> 
> -extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
> +extern void cpuset_nodes_filter_allowed(struct cgroup *cgroup,
> +					nodemask_t *mask);
>  #else /* !CONFIG_CPUSETS */
> 
>  static inline bool cpusets_enabled(void) { return false; }
> @@ -301,9 +302,9 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>  	return false;
>  }
> 
> -static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +static inline void cpuset_nodes_filter_allowed(struct cgroup *cgroup,
> +					       nodemask_t *mask)
>  {
> -	return true;
>  }
>  #endif /* !CONFIG_CPUSETS */
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index fd400082313a..911e0c71453e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1740,7 +1740,7 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>  	rcu_read_unlock();
>  }
> 
> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
> +void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask);
> 
>  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
> 
> @@ -1811,9 +1811,9 @@ static inline ino_t page_cgroup_ino(struct page *page)
>  	return 0;
>  }
> 
> -static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +static inline void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg,
> +						  nodemask_t *mask)
>  {
> -	return true;
>  }
> 
>  static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 6e6eb09b8db6..cc0e1d42611c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4416,27 +4416,34 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>  	return allowed;
>  }
> 
> -bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +/**
> + * cpuset_nodes_filter_allowed - filter out nodes not in cgroup's mems_allowed.
> + * @cgroup: pointer to struct cgroup.
> + * @mask: pointer to struct nodemask_t to be filtered.
> + *
> + * Description: Filters out nodes that are not in mems_allowed for @cgroup.
> + * Nodes returned in @mask are not guaranteed to be online.
> + **/
> +void cpuset_nodes_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
>  {
>  	struct cgroup_subsys_state *css;
>  	struct cpuset *cs;
> -	bool allowed;
> 
>  	/*
>  	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
>  	 * and mems_allowed is likely to be empty even if we could get to it,
> -	 * so return true to avoid taking a global lock on the empty check.
> +	 * so return directly to avoid taking a global lock on the empty check.
>  	 */
> -	if (!cpuset_v2())
> -		return true;
> +	if (!cgroup || !cpuset_v2())
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
> +	 * or callback_lock - but not doing so is acceptable and the reference
>  	 * taken via cgroup_get_e_css is sufficient to protect css.
>  	 *
>  	 * Since this interface is intended for use by migration paths, we
> @@ -4447,9 +4454,8 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
>  	 * cannot make strong isolation guarantees, so this is acceptable.
>  	 */
>  	cs = container_of(css, struct cpuset, css);
> -	allowed = node_isset(nid, cs->effective_mems);
> +	nodes_and(*mask, *mask, cs->effective_mems);

Why do we need the and operation? Can't we just copy cs->effective_mems to mask directly?

Per Longman's suggestion, name it cpuset_nodes_allowed and handle the filtering in
mem_cgroup_node_filter_allowed. Please keep the allowed nodes retrieval logic common.

>  	css_put(css);
> -	return allowed;
>  }
> 
>  /**
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 75fc22a33b28..4c850805b7a9 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5597,9 +5597,10 @@ subsys_initcall(mem_cgroup_swap_init);
> 
>  #endif /* CONFIG_SWAP */
> 
> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
>  {
> -	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
> +	if (memcg)
> +		cpuset_nodes_filter_allowed(memcg->css.cgroup, mask);
>  }
> 
>  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ac16b6b984ab..919e116ddaf3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -345,18 +345,24 @@ static bool can_demote(int nid, struct scan_control *sc,
>  		       struct mem_cgroup *memcg)
>  {
>  	int demotion_nid;
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
> +		return false;
> +
> +	/* Filter out nodes that are not in cgroup's mems_allowed. */
> +	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
> +	if (nodes_empty(allowed_mask))
>  		return false;
> 
> -	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
> -	if (mem_cgroup_node_allowed(memcg, demotion_nid)) {
> +	for_each_node_mask(demotion_nid, allowed_mask) {
>  		int z;
>  		struct zone *zone;
>  		struct pglist_data *pgdat = NODE_DATA(demotion_nid);
> @@ -1029,7 +1035,8 @@ static struct folio *alloc_demote_folio(struct folio *src,
>   * Folios which are not demoted are left on @demote_folios.
>   */
>  static unsigned int demote_folio_list(struct list_head *demote_folios,
> -				     struct pglist_data *pgdat)
> +				      struct pglist_data *pgdat,
> +				      struct mem_cgroup *memcg)
>  {
>  	int target_nid = next_demotion_node(pgdat->node_id);
>  	unsigned int nr_succeeded;
> @@ -1043,7 +1050,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  		 */
>  		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>  			__GFP_NOMEMALLOC | GFP_NOWAIT,
> -		.nid = target_nid,
>  		.nmask = &allowed_mask,
>  		.reason = MR_DEMOTION,
>  	};
> @@ -1051,10 +1057,14 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  	if (list_empty(demote_folios))
>  		return 0;
> 
> -	if (target_nid == NUMA_NO_NODE)
> -		return 0;
> -
>  	node_get_allowed_targets(pgdat, &allowed_mask);
> +	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
> +	if (nodes_empty(allowed_mask))
> +		return false;
> +
> +	if (!node_isset(target_nid, allowed_mask))
> +		target_nid = node_random(&allowed_mask);
> +	mtc.nid = target_nid;
> 
>  	/* Demotion ignores all cpuset and mempolicy settings */
>  	migrate_pages(demote_folios, alloc_demote_folio, NULL,
> @@ -1576,7 +1586,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  	/* 'folio_list' is always empty here */
> 
>  	/* Migrate folios selected for demotion */
> -	nr_demoted = demote_folio_list(&demote_folios, pgdat);
> +	nr_demoted = demote_folio_list(&demote_folios, pgdat, memcg);
>  	nr_reclaimed += nr_demoted;
>  	stat->nr_demoted += nr_demoted;
>  	/* Folios that could not be demoted are still in @demote_folios */
> --
> 2.52.0.358.g0dd7633a29-goog

-- 
Best regards,
Ridong


