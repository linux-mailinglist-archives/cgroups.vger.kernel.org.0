Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47B030F3E7
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 14:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhBDNa3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 08:30:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:48668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236274AbhBDNaJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 4 Feb 2021 08:30:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612445361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dZkOuW12hIR53DrmAky88GTVjhYI+Daf3Iw2dbiv0LQ=;
        b=TdbJToAsUkuon6LIfJS/gfcAF3TmZpV0MAwilOEN7hAXoGPPHVm9hxn6QvDBt+tZqz9EWZ
        YLGFA6bNDh1XbUHvzc6eHHJ4diAUPi5gHxG3whr4HO69VvU9F5kZNtSKHBSFXoSVf6fSQi
        02kWp38rqG2N7IDfrUyXstGHHbb5y+M=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BC3D3AC43;
        Thu,  4 Feb 2021 13:29:21 +0000 (UTC)
Date:   Thu, 4 Feb 2021 14:29:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 2/7] mm: memcontrol: kill mem_cgroup_nodeinfo()
Message-ID: <YBv2sYiMmPhYmW3h@dhcp22.suse.cz>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-3-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 02-02-21 13:47:41, Johannes Weiner wrote:
> No need to encapsulate a simple struct member access.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  8 +-------
>  mm/memcontrol.c            | 21 +++++++++++----------
>  2 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 7a38a1517a05..c7f387a6233e 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -602,12 +602,6 @@ void mem_cgroup_uncharge_list(struct list_head *page_list);
>  
>  void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
>  
> -static struct mem_cgroup_per_node *
> -mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> -{
> -	return memcg->nodeinfo[nid];
> -}
> -
>  /**
>   * mem_cgroup_lruvec - get the lru list vector for a memcg & node
>   * @memcg: memcg of the wanted lruvec
> @@ -631,7 +625,7 @@ static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
>  	if (!memcg)
>  		memcg = root_mem_cgroup;
>  
> -	mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> +	mz = memcg->nodeinfo[pgdat->node_id];
>  	lruvec = &mz->lruvec;
>  out:
>  	/*
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8120d565dd79..7e05a4ebf80f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -414,13 +414,14 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  					 int size, int old_size)
>  {
>  	struct memcg_shrinker_map *new, *old;
> +	struct mem_cgroup_per_node *pn;
>  	int nid;
>  
>  	lockdep_assert_held(&memcg_shrinker_map_mutex);
>  
>  	for_each_node(nid) {
> -		old = rcu_dereference_protected(
> -			mem_cgroup_nodeinfo(memcg, nid)->shrinker_map, true);
> +		pn = memcg->nodeinfo[nid];
> +		old = rcu_dereference_protected(pn->shrinker_map, true);
>  		/* Not yet online memcg */
>  		if (!old)
>  			return 0;
> @@ -433,7 +434,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		memset(new->map, (int)0xff, old_size);
>  		memset((void *)new->map + old_size, 0, size - old_size);
>  
> -		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_map, new);
> +		rcu_assign_pointer(pn->shrinker_map, new);
>  		call_rcu(&old->rcu, memcg_free_shrinker_map_rcu);
>  	}
>  
> @@ -450,7 +451,7 @@ static void memcg_free_shrinker_maps(struct mem_cgroup *memcg)
>  		return;
>  
>  	for_each_node(nid) {
> -		pn = mem_cgroup_nodeinfo(memcg, nid);
> +		pn = memcg->nodeinfo[nid];
>  		map = rcu_dereference_protected(pn->shrinker_map, true);
>  		kvfree(map);
>  		rcu_assign_pointer(pn->shrinker_map, NULL);
> @@ -713,7 +714,7 @@ static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
>  	int nid;
>  
>  	for_each_node(nid) {
> -		mz = mem_cgroup_nodeinfo(memcg, nid);
> +		mz = memcg->nodeinfo[nid];
>  		mctz = soft_limit_tree_node(nid);
>  		if (mctz)
>  			mem_cgroup_remove_exceeded(mz, mctz);
> @@ -796,7 +797,7 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
>  	parent = parent_mem_cgroup(pn->memcg);
>  	if (!parent)
>  		return NULL;
> -	return mem_cgroup_nodeinfo(parent, nid);
> +	return parent->nodeinfo[nid];
>  }
>  
>  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> @@ -1163,7 +1164,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
>  	if (reclaim) {
>  		struct mem_cgroup_per_node *mz;
>  
> -		mz = mem_cgroup_nodeinfo(root, reclaim->pgdat->node_id);
> +		mz = root->nodeinfo[reclaim->pgdat->node_id];
>  		iter = &mz->iter;
>  
>  		if (prev && reclaim->generation != iter->generation)
> @@ -1265,7 +1266,7 @@ static void __invalidate_reclaim_iterators(struct mem_cgroup *from,
>  	int nid;
>  
>  	for_each_node(nid) {
> -		mz = mem_cgroup_nodeinfo(from, nid);
> +		mz = from->nodeinfo[nid];
>  		iter = &mz->iter;
>  		cmpxchg(&iter->position, dead_memcg, NULL);
>  	}
> @@ -2438,7 +2439,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  				struct mem_cgroup_per_node *pn;
>  				long x;
>  
> -				pn = mem_cgroup_nodeinfo(memcg, nid);
> +				pn = memcg->nodeinfo[nid];
>  				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
>  
>  				x = lstatc->count[i];
> @@ -4145,7 +4146,7 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  		unsigned long file_cost = 0;
>  
>  		for_each_online_pgdat(pgdat) {
> -			mz = mem_cgroup_nodeinfo(memcg, pgdat->node_id);
> +			mz = memcg->nodeinfo[pgdat->node_id];
>  
>  			anon_cost += mz->lruvec.anon_cost;
>  			file_cost += mz->lruvec.file_cost;
> -- 
> 2.30.0
> 

-- 
Michal Hocko
SUSE Labs
