Return-Path: <cgroups+bounces-12938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AB8ECFB98C
	for <lists+cgroups@lfdr.de>; Wed, 07 Jan 2026 02:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A25DD301AD2F
	for <lists+cgroups@lfdr.de>; Wed,  7 Jan 2026 01:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A451F9F70;
	Wed,  7 Jan 2026 01:27:21 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6CD1B87C9;
	Wed,  7 Jan 2026 01:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767749241; cv=none; b=NiHspg25CEzW87sVsKhZKNGaCD83iiAhVns3yshJnCXumUvn+mcZo2ZlJqdxwEPBx/I0Pwp+aiNNfsH2oOBYezhopIX05/s+O4Yy5kqI44riveYB2exMMy1UCt+Diehf24QdeqYJzqzt3YqjdbyQfNsp0BhlKV32bwz7E8wfPLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767749241; c=relaxed/simple;
	bh=8whjmx4pynwluDZb23k1l+vwvBucyaXrR+JTYv/1BYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BXzJLfFEoKBiQ1bz30/TENXcj2SX4n+mfypAaCJqt3ZjZmzC4Nkpp6esrE4CAegF1O6+IQIp/hBio4dNuPT+IYOieSs1VVDNRK5PBuJnIws+b94fwBdVgieEer843jP9KxCCRwdQHwgtStVX11Cp9gPnmBQ2dBWSjv/7jcYiMi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dm9Np1klhzKHMPt;
	Wed,  7 Jan 2026 09:26:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C5EF64056B;
	Wed,  7 Jan 2026 09:27:14 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPlxtl1pELuZCw--.61804S2;
	Wed, 07 Jan 2026 09:27:14 +0800 (CST)
Message-ID: <b1f3f967-5243-41ae-af20-0cb3b47c1ad6@huaweicloud.com>
Date: Wed, 7 Jan 2026 09:27:12 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] mm/vmscan: fix demotion targets checks in
 reclaim/demotion
To: Bing Jiao <bingjiao@google.com>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 gourry@gourry.net, longman@redhat.com, hannes@cmpxchg.org,
 mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
 muchun.song@linux.dev, tj@kernel.org, mkoutny@suse.com, david@kernel.org,
 zhengqi.arch@bytedance.com, lorenzo.stoakes@oracle.com,
 axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
 cgroups@vger.kernel.org
References: <20260105050203.328095-1-bingjiao@google.com>
 <20260106075703.1420072-1-bingjiao@google.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260106075703.1420072-1-bingjiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCnCPlxtl1pELuZCw--.61804S2
X-Coremail-Antispam: 1UD129KBjvAXoW3uF45Ar47WrWxAF17uw17ZFb_yoW8JrW7Ao
	WxKF4Dua1kWF15ArsY9as7ta9xWayDKryfXF1DZrWjkF1av347Ja4Utw1q9ryfJF43XFW5
	J342vF1DGFZ5t3Zxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2026/1/6 15:56, Bing Jiao wrote:
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
> ---
> 
> Patch against the linux mainline.
> Tested on the mainline and passed.
> Tested on mm-everyting, after Akinobu Mita's series "mm: fix oom-killer
> not being invoked when demotion is enabled v2", and passed.
> 
> v5 -> v6: update cpuset_nodes_allowed()'s comments; move some comments
> from cpuset_nodes_allowed() to mem_cgroup_node_filter_allowed().
> 
> ---
>  include/linux/cpuset.h     |  6 ++---
>  include/linux/memcontrol.h |  6 ++---
>  kernel/cgroup/cpuset.c     | 54 +++++++++++++++++++++++++-------------
>  mm/memcontrol.c            | 16 +++++++++--
>  mm/vmscan.c                | 30 ++++++++++++---------
>  5 files changed, 74 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> index a98d3330385c..631577384677 100644
> --- a/include/linux/cpuset.h
> +++ b/include/linux/cpuset.h
> @@ -174,7 +174,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
>  	task_unlock(current);
>  }
> 
> -extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
> +extern void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask);
>  #else /* !CONFIG_CPUSETS */
> 
>  static inline bool cpusets_enabled(void) { return false; }
> @@ -301,9 +301,9 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
>  	return false;
>  }
> 
> -static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +static inline void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
>  {
> -	return true;
> +	nodes_copy(*mask, node_states[N_MEMORY]);
>  }
>  #endif /* !CONFIG_CPUSETS */
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0651865a4564..412db7663357 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1744,7 +1744,7 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
>  	rcu_read_unlock();
>  }
> 
> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
> +void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask);
> 
>  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
> 
> @@ -1815,9 +1815,9 @@ static inline ino_t page_cgroup_ino(struct page *page)
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
> index 3e8cc34d8d50..76d7d0fa8137 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4427,40 +4427,58 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>  	return allowed;
>  }
> 
> -bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
> +/**
> + * cpuset_nodes_allowed - return effective_mems mask from a cgroup cpuset.
> + * @cgroup: pointer to struct cgroup.
> + * @mask: pointer to struct nodemask_t to be returned.
> + *
> + * Returns effective_mems mask from a cgroup cpuset if it is cgroup v2 and
> + * has cpuset subsys. Otherwise, returns node_states[N_MEMORY].
> + *
> + * This function intentionally avoids taking the cpuset_mutex or callback_lock
> + * when accessing effective_mems. This is because the obtained effective_mems
> + * is stale immediately after the query anyway (e.g., effective_mems is updated
> + * immediately after releasing the lock but before returning).
> + *
> + * As a result, returned @mask may be empty because cs->effective_mems can be
> + * rebound during this call. Besides, nodes in @mask are not guaranteed to be
> + * online due to hot plugins. Callers should check the mask for validity on
> + * return based on its subsequent use.
> + **/
> +void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
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
> +	if (!cgroup || !cpuset_v2()) {
> +		nodes_copy(*mask, node_states[N_MEMORY]);
> +		return;
> +	}
> 
>  	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
> -	if (!css)
> -		return true;
> +	if (!css) {
> +		nodes_copy(*mask, node_states[N_MEMORY]);
> +		return;
> +	}
> 
>  	/*
> -	 * Normally, accessing effective_mems would require the cpuset_mutex
> -	 * or callback_lock - but node_isset is atomic and the reference
> -	 * taken via cgroup_get_e_css is sufficient to protect css.
> -	 *
> -	 * Since this interface is intended for use by migration paths, we
> -	 * relax locking here to avoid taking global locks - while accepting
> -	 * there may be rare scenarios where the result may be innaccurate.
> +	 * The reference taken via cgroup_get_e_css is sufficient to
> +	 * protect css, but it does not imply safe accesses to effective_mems.
>  	 *
> -	 * Reclaim and migration are subject to these same race conditions, and
> -	 * cannot make strong isolation guarantees, so this is acceptable.
> +	 * Normally, accessing effective_mems would require the cpuset_mutex
> +	 * or callback_lock - but the correctness of this information is stale
> +	 * immediately after the query anyway. We do not acquire the lock
> +	 * during this process to save lock contention in exchange for racing
> +	 * against mems_allowed rebinds.
>  	 */
>  	cs = container_of(css, struct cpuset, css);
> -	allowed = node_isset(nid, cs->effective_mems);
> +	nodes_copy(*mask, cs->effective_mems);
>  	css_put(css);
> -	return allowed;
>  }
> 
>  /**
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 86f43b7e5f71..702c3db624a0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5624,9 +5624,21 @@ subsys_initcall(mem_cgroup_swap_init);
> 
>  #endif /* CONFIG_SWAP */
> 
> -bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
> +void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
>  {
> -	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
> +	nodemask_t allowed;
> +
> +	if (!memcg)
> +		return;
> +
> +	/*
> +	 * Since this interface is intended for use by migration paths, and
> +	 * reclaim and migration are subject to race conditions such as changes
> +	 * in effective_mems and hot-unpluging of nodes, inaccurate allowed
> +	 * mask is acceptable.
> +	 */
> +	cpuset_nodes_allowed(memcg->css.cgroup, &allowed);
> +	nodes_and(*mask, *mask, allowed);
>  }
> 

If this is acceptable, it looks good to me.

>  void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 670fe9fae5ba..eed1becfcb34 100644
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
> +	/* Filter out nodes that are not in cgroup's mems_allowed. */
> +	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
> +	return !nodes_empty(allowed_mask);
>  }
> 
>  static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
> @@ -1019,7 +1021,8 @@ static struct folio *alloc_demote_folio(struct folio *src,
>   * Folios which are not demoted are left on @demote_folios.
>   */
>  static unsigned int demote_folio_list(struct list_head *demote_folios,
> -				     struct pglist_data *pgdat)
> +				      struct pglist_data *pgdat,
> +				      struct mem_cgroup *memcg)
>  {
>  	int target_nid = next_demotion_node(pgdat->node_id);
>  	unsigned int nr_succeeded;
> @@ -1033,7 +1036,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  		 */
>  		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>  			__GFP_NOMEMALLOC | GFP_NOWAIT,
> -		.nid = target_nid,
>  		.nmask = &allowed_mask,
>  		.reason = MR_DEMOTION,
>  	};
> @@ -1041,10 +1043,14 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
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
> @@ -1566,7 +1572,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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

Reviewed-by: Chen Ridong <chenridong@huawei.com>

-- 
Best regards,
Ridong


