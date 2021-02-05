Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB53B31157A
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbhBEWcm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:32:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:42522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232382AbhBEOQH (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 09:16:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612538248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r8wialKdheVOWKUm2V9AI1x41rtNkGlqL+YFxoW4NCY=;
        b=e9eORgSyJ69kSnIywPMO4ancKa6to5n2wceHlPgMzOSqkondXIZUfqhke6GyONiEL/h3Nz
        NMbd5LMcG9rxDAPy5FzdlY3YjW78TIe7aKolEGddszgWxwLEJI97ivP3Of9W5YMIbI8mYU
        zi0itQD0XQ3Ofa69Asm8BX4PN3W5ugE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 206C5AC9B;
        Fri,  5 Feb 2021 15:17:28 +0000 (UTC)
Date:   Fri, 5 Feb 2021 16:17:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/7] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <YB1hhwVybr0x5M2j@dhcp22.suse.cz>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-8-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-8-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 02-02-21 13:47:46, Johannes Weiner wrote:
> There are two functions to flush the per-cpu data of an lruvec into
> the rest of the cgroup tree: when the cgroup is being freed, and when
> a CPU disappears during hotplug. The difference is whether all CPUs or
> just one is being collected, but the rest of the flushing code is the
> same. Merge them into one function and share the common code.

IIUC the only reason for the cpu == -1 special case is to avoid
zeroying, right? Is this optimization worth the special case? The code
would be slightly easier to follow without this.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Anyway the above is not really a fundamental objection. It is more important
to unify the flushing.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 88 +++++++++++++++++++++++--------------------------
>  1 file changed, 42 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b205b2413186..88e8afc49a46 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2410,39 +2410,56 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>  	mutex_unlock(&percpu_charge_mutex);
>  }
>  
> -static int memcg_hotplug_cpu_dead(unsigned int cpu)
> +static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
>  {
> -	struct memcg_stock_pcp *stock;
> -	struct mem_cgroup *memcg;
> -
> -	stock = &per_cpu(memcg_stock, cpu);
> -	drain_stock(stock);
> +	int nid;
>  
> -	for_each_mem_cgroup(memcg) {
> +	for_each_node(nid) {
> +		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
> +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0, };
> +		struct batched_lruvec_stat *lstatc;
>  		int i;
>  
> -		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> -			int nid;
> -
> -			for_each_node(nid) {
> -				struct batched_lruvec_stat *lstatc;
> -				struct mem_cgroup_per_node *pn;
> -				long x;
> -
> -				pn = memcg->nodeinfo[nid];
> +		if (cpu == -1) {
> +			int cpui;
> +			/*
> +			 * The memcg is about to be freed, collect all
> +			 * CPUs, no need to zero anything out.
> +			 */
> +			for_each_online_cpu(cpui) {
> +				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpui);
> +				for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> +					stat[i] += lstatc->count[i];
> +			}
> +		} else {
> +			/*
> +			 * The CPU has gone away, collect and zero out
> +			 * its stats, it may come back later.
> +			 */
> +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
>  				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
> -
> -				x = lstatc->count[i];
> +				stat[i] = lstatc->count[i];
>  				lstatc->count[i] = 0;
> -
> -				if (x) {
> -					do {
> -						atomic_long_add(x, &pn->lruvec_stat[i]);
> -					} while ((pn = parent_nodeinfo(pn, nid)));
> -				}
>  			}
>  		}
> +
> +		do {
> +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> +				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
> +		} while ((pn = parent_nodeinfo(pn, nid)));
>  	}
> +}
> +
> +static int memcg_hotplug_cpu_dead(unsigned int cpu)
> +{
> +	struct memcg_stock_pcp *stock;
> +	struct mem_cgroup *memcg;
> +
> +	stock = &per_cpu(memcg_stock, cpu);
> +	drain_stock(stock);
> +
> +	for_each_mem_cgroup(memcg)
> +		memcg_flush_lruvec_page_state(memcg, cpu);
>  
>  	return 0;
>  }
> @@ -3636,27 +3653,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	}
>  }
>  
> -static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
> -{
> -	int node;
> -
> -	for_each_node(node) {
> -		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> -		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
> -		struct mem_cgroup_per_node *pi;
> -		int cpu, i;
> -
> -		for_each_online_cpu(cpu)
> -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -				stat[i] += per_cpu(
> -					pn->lruvec_stat_cpu->count[i], cpu);
> -
> -		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
> -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
> -	}
> -}
> -
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> @@ -5197,7 +5193,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
>  	 * Flush percpu lruvec stats to guarantee the value
>  	 * correctness on parent's and all ancestor levels.
>  	 */
> -	memcg_flush_lruvec_page_state(memcg);
> +	memcg_flush_lruvec_page_state(memcg, -1);
>  	__mem_cgroup_free(memcg);
>  }
>  
> -- 
> 2.30.0
> 

-- 
Michal Hocko
SUSE Labs
