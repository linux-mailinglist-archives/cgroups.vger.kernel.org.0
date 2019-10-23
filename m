Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02038E1D87
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfJWOAW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 10:00:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:42882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725789AbfJWOAW (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 23 Oct 2019 10:00:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A744B40D;
        Wed, 23 Oct 2019 14:00:17 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:00:15 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/8] mm: clean up and clarify lruvec lookup procedure
Message-ID: <20191023140015.GC17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-3-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-3-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-10-19 10:47:57, Johannes Weiner wrote:
> There is a per-memcg lruvec and a NUMA node lruvec. Which one is being
> used is somewhat confusing right now, and it's easy to make mistakes -
> especially when it comes to global reclaim.
> 
> How it works: when memory cgroups are enabled, we always use the
> root_mem_cgroup's per-node lruvecs. When memory cgroups are not
> compiled in or disabled at runtime, we use pgdat->lruvec.
> 
> Document that in a comment.
> 
> Due to the way the reclaim code is generalized, all lookups use the
> mem_cgroup_lruvec() helper function, and nobody should have to find
> the right lruvec manually right now. But to avoid future mistakes,
> rename the pgdat->lruvec member to pgdat->__lruvec and delete the
> convenience wrapper that suggests it's a commonly accessed member.
> 
> While in this area, swap the mem_cgroup_lruvec() argument order. The
> name suggests a memcg operation, yet it takes a pgdat first and a
> memcg second. I have to double take every time I call this. Fix that.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

I do agree that node_lruvec() adds confusion and it is better to get rid
of it.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h | 26 +++++++++++++-------------
>  include/linux/mmzone.h     | 15 ++++++++-------
>  mm/memcontrol.c            | 12 ++++++------
>  mm/page_alloc.c            |  2 +-
>  mm/slab.h                  |  4 ++--
>  mm/vmscan.c                |  6 +++---
>  mm/workingset.c            |  8 ++++----
>  7 files changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 2b34925fc19d..498cea07cbb1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -393,22 +393,22 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
>  }
>  
>  /**
> - * mem_cgroup_lruvec - get the lru list vector for a node or a memcg zone
> - * @node: node of the wanted lruvec
> + * mem_cgroup_lruvec - get the lru list vector for a memcg & node
>   * @memcg: memcg of the wanted lruvec
> + * @node: node of the wanted lruvec
>   *
> - * Returns the lru list vector holding pages for a given @node or a given
> - * @memcg and @zone. This can be the node lruvec, if the memory controller
> - * is disabled.
> + * Returns the lru list vector holding pages for a given @memcg &
> + * @node combination. This can be the node lruvec, if the memory
> + * controller is disabled.
>   */
> -static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
> -				struct mem_cgroup *memcg)
> +static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> +					       struct pglist_data *pgdat)
>  {
>  	struct mem_cgroup_per_node *mz;
>  	struct lruvec *lruvec;
>  
>  	if (mem_cgroup_disabled()) {
> -		lruvec = node_lruvec(pgdat);
> +		lruvec = &pgdat->__lruvec;
>  		goto out;
>  	}
>  
> @@ -727,7 +727,7 @@ static inline void __mod_lruvec_page_state(struct page *page,
>  		return;
>  	}
>  
> -	lruvec = mem_cgroup_lruvec(pgdat, page->mem_cgroup);
> +	lruvec = mem_cgroup_lruvec(page->mem_cgroup, pgdat);
>  	__mod_lruvec_state(lruvec, idx, val);
>  }
>  
> @@ -898,16 +898,16 @@ static inline void mem_cgroup_migrate(struct page *old, struct page *new)
>  {
>  }
>  
> -static inline struct lruvec *mem_cgroup_lruvec(struct pglist_data *pgdat,
> -				struct mem_cgroup *memcg)
> +static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> +					       struct pglist_data *pgdat)
>  {
> -	return node_lruvec(pgdat);
> +	return &pgdat->__lruvec;
>  }
>  
>  static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page,
>  						    struct pglist_data *pgdat)
>  {
> -	return &pgdat->lruvec;
> +	return &pgdat->__lruvec;
>  }
>  
>  static inline bool mm_match_cgroup(struct mm_struct *mm,
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index d4ca03b93373..449a44171026 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -777,7 +777,13 @@ typedef struct pglist_data {
>  #endif
>  
>  	/* Fields commonly accessed by the page reclaim scanner */
> -	struct lruvec		lruvec;
> +
> +	/*
> +	 * NOTE: THIS IS UNUSED IF MEMCG IS ENABLED.
> +	 *
> +	 * Use mem_cgroup_lruvec() to look up lruvecs.
> +	 */
> +	struct lruvec		__lruvec;
>  
>  	unsigned long		flags;
>  
> @@ -800,11 +806,6 @@ typedef struct pglist_data {
>  #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
>  #define node_end_pfn(nid) pgdat_end_pfn(NODE_DATA(nid))
>  
> -static inline struct lruvec *node_lruvec(struct pglist_data *pgdat)
> -{
> -	return &pgdat->lruvec;
> -}
> -
>  static inline unsigned long pgdat_end_pfn(pg_data_t *pgdat)
>  {
>  	return pgdat->node_start_pfn + pgdat->node_spanned_pages;
> @@ -842,7 +843,7 @@ static inline struct pglist_data *lruvec_pgdat(struct lruvec *lruvec)
>  #ifdef CONFIG_MEMCG
>  	return lruvec->pgdat;
>  #else
> -	return container_of(lruvec, struct pglist_data, lruvec);
> +	return container_of(lruvec, struct pglist_data, __lruvec);
>  #endif
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 98c2fd902533..055975b0b3a3 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -770,7 +770,7 @@ void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
>  	if (!memcg || memcg == root_mem_cgroup) {
>  		__mod_node_page_state(pgdat, idx, val);
>  	} else {
> -		lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  		__mod_lruvec_state(lruvec, idx, val);
>  	}
>  	rcu_read_unlock();
> @@ -1226,7 +1226,7 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
>  	struct lruvec *lruvec;
>  
>  	if (mem_cgroup_disabled()) {
> -		lruvec = &pgdat->lruvec;
> +		lruvec = &pgdat->__lruvec;
>  		goto out;
>  	}
>  
> @@ -1605,7 +1605,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  static bool test_mem_cgroup_node_reclaimable(struct mem_cgroup *memcg,
>  		int nid, bool noswap)
>  {
> -	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
> +	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>  
>  	if (lruvec_page_state(lruvec, NR_INACTIVE_FILE) ||
>  	    lruvec_page_state(lruvec, NR_ACTIVE_FILE))
> @@ -3735,7 +3735,7 @@ static int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
>  static unsigned long mem_cgroup_node_nr_lru_pages(struct mem_cgroup *memcg,
>  					   int nid, unsigned int lru_mask)
>  {
> -	struct lruvec *lruvec = mem_cgroup_lruvec(NODE_DATA(nid), memcg);
> +	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
>  	unsigned long nr = 0;
>  	enum lru_list lru;
>  
> @@ -5433,8 +5433,8 @@ static int mem_cgroup_move_account(struct page *page,
>  	anon = PageAnon(page);
>  
>  	pgdat = page_pgdat(page);
> -	from_vec = mem_cgroup_lruvec(pgdat, from);
> -	to_vec = mem_cgroup_lruvec(pgdat, to);
> +	from_vec = mem_cgroup_lruvec(from, pgdat);
> +	to_vec = mem_cgroup_lruvec(to, pgdat);
>  
>  	spin_lock_irqsave(&from->move_lock, flags);
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index fe76be55c9d5..791c018314b3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6708,7 +6708,7 @@ static void __meminit pgdat_init_internals(struct pglist_data *pgdat)
>  
>  	pgdat_page_ext_init(pgdat);
>  	spin_lock_init(&pgdat->lru_lock);
> -	lruvec_init(node_lruvec(pgdat));
> +	lruvec_init(&pgdat->__lruvec);
>  }
>  
>  static void __meminit zone_init_internals(struct zone *zone, enum zone_type idx, int nid,
> diff --git a/mm/slab.h b/mm/slab.h
> index 3eb29ae75743..2bbecf28688d 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -369,7 +369,7 @@ static __always_inline int memcg_charge_slab(struct page *page,
>  	if (ret)
>  		goto out;
>  
> -	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
>  	mod_lruvec_state(lruvec, cache_vmstat_idx(s), 1 << order);
>  
>  	/* transer try_charge() page references to kmem_cache */
> @@ -393,7 +393,7 @@ static __always_inline void memcg_uncharge_slab(struct page *page, int order,
>  	rcu_read_lock();
>  	memcg = READ_ONCE(s->memcg_params.memcg);
>  	if (likely(!mem_cgroup_is_root(memcg))) {
> -		lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +		lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
>  		mod_lruvec_state(lruvec, cache_vmstat_idx(s), -(1 << order));
>  		memcg_kmem_uncharge_memcg(page, order, memcg);
>  	} else {
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 57f533b808f2..be3c22c274c1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2545,7 +2545,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memcg,
>  			      struct scan_control *sc)
>  {
> -	struct lruvec *lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	unsigned long nr[NR_LRU_LISTS];
>  	unsigned long targets[NR_LRU_LISTS];
>  	unsigned long nr_to_scan;
> @@ -3023,7 +3023,7 @@ static void snapshot_refaults(struct mem_cgroup *root_memcg, pg_data_t *pgdat)
>  		unsigned long refaults;
>  		struct lruvec *lruvec;
>  
> -		lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  		refaults = lruvec_page_state_local(lruvec, WORKINGSET_ACTIVATE);
>  		lruvec->refaults = refaults;
>  	} while ((memcg = mem_cgroup_iter(root_memcg, memcg, NULL)));
> @@ -3391,7 +3391,7 @@ static void age_active_anon(struct pglist_data *pgdat,
>  
>  	memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  	do {
> -		struct lruvec *lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  
>  		if (inactive_list_is_low(lruvec, false, sc, true))
>  			shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
> diff --git a/mm/workingset.c b/mm/workingset.c
> index c963831d354f..e8212123c1c3 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -233,7 +233,7 @@ void *workingset_eviction(struct page *page)
>  	VM_BUG_ON_PAGE(page_count(page), page);
>  	VM_BUG_ON_PAGE(!PageLocked(page), page);
>  
> -	lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	eviction = atomic_long_inc_return(&lruvec->inactive_age);
>  	return pack_shadow(memcgid, pgdat, eviction, PageWorkingset(page));
>  }
> @@ -280,7 +280,7 @@ void workingset_refault(struct page *page, void *shadow)
>  	memcg = mem_cgroup_from_id(memcgid);
>  	if (!mem_cgroup_disabled() && !memcg)
>  		goto out;
> -	lruvec = mem_cgroup_lruvec(pgdat, memcg);
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
>  	refault = atomic_long_read(&lruvec->inactive_age);
>  	active_file = lruvec_lru_size(lruvec, LRU_ACTIVE_FILE, MAX_NR_ZONES);
>  
> @@ -345,7 +345,7 @@ void workingset_activation(struct page *page)
>  	memcg = page_memcg_rcu(page);
>  	if (!mem_cgroup_disabled() && !memcg)
>  		goto out;
> -	lruvec = mem_cgroup_lruvec(page_pgdat(page), memcg);
> +	lruvec = mem_cgroup_lruvec(memcg, page_pgdat(page));
>  	atomic_long_inc(&lruvec->inactive_age);
>  out:
>  	rcu_read_unlock();
> @@ -426,7 +426,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
>  		struct lruvec *lruvec;
>  		int i;
>  
> -		lruvec = mem_cgroup_lruvec(NODE_DATA(sc->nid), sc->memcg);
> +		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
>  		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
>  			pages += lruvec_page_state_local(lruvec,
>  							 NR_LRU_BASE + i);
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
