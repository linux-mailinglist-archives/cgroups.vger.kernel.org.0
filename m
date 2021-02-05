Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07491311442
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 23:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhBEWCb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 17:02:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:48140 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhBEO4U (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 5 Feb 2021 09:56:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612537521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfKdaHOvVs5iFtPROdik4Lbs78duEywwdGqYgkka++0=;
        b=h1ZZ1kooAJ79BzwOLtEGKCvuPFJs3V4x6txqFV34QTn7Q0XHXK4fzGlJji9rcdk57dlI4q
        dm4/59PwtqdI8SSaq/RCGSuex2B4ZzKJFv4PPhQyg7lWxgTSF4sjdKx0jyyB+3DVuWI8Pt
        DuICVN1rXc3W4MQ1i0XmgKaZ/jeEZQg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A809FAE95;
        Fri,  5 Feb 2021 15:05:21 +0000 (UTC)
Date:   Fri, 5 Feb 2021 16:05:20 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 6/7] mm: memcontrol: switch to rstat
Message-ID: <YB1esMKg3QhBDFG2@dhcp22.suse.cz>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202184746.119084-7-hannes@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 02-02-21 13:47:45, Johannes Weiner wrote:
> Replace the memory controller's custom hierarchical stats code with
> the generic rstat infrastructure provided by the cgroup core.
> 
> The current implementation does batched upward propagation from the
> write side (i.e. as stats change). The per-cpu batches introduce an
> error, which is multiplied by the number of subgroups in a tree. In
> systems with many CPUs and sizable cgroup trees, the error can be
> large enough to confuse users (e.g. 32 batch pages * 32 CPUs * 32
> subgroups results in an error of up to 128M per stat item). This can
> entirely swallow allocation bursts inside a workload that the user is
> expecting to see reflected in the statistics.
> 
> In the past, we've done read-side aggregation, where a memory.stat
> read would have to walk the entire subtree and add up per-cpu
> counts. This became problematic with lazily-freed cgroups: we could
> have large subtrees where most cgroups were entirely idle. Hence the
> switch to change-driven upward propagation. Unfortunately, it needed
> to trade accuracy for speed due to the write side being so hot.
> 
> Rstat combines the best of both worlds: from the write side, it
> cheaply maintains a queue of cgroups that have pending changes, so
> that the read side can do selective tree aggregation. This way the
> reported stats will always be precise and recent as can be, while the
> aggregation can skip over potentially large numbers of idle cgroups.
> 
> This adds a second vmstats to struct mem_cgroup (MEMCG_NR_STAT +
> NR_VM_EVENT_ITEMS) to track pending subtree deltas during upward
> aggregation. It removes 3 words from the per-cpu data. It eliminates
> memcg_exact_page_state(), since memcg_page_state() is now exact.

The above confused me a bit. I can see the pcp data size increased by
adding _prev.  The resulting memory footprint should be increased by
sizeof(long) * (MEMCG_NR_STAT + NR_VM_EVENT_ITEMS) * (CPUS + 1)
which is roughly 1kB per CPU per memcg unless I have made any
mistake. This is a quite a lot and it should be mentioned in the
changelog.
 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Although the memory overhead is quite large and it scales both with
memcg count and CPUs so it can grow quite a bit I do not think this is
prohibitive. Although it would be really nice if this could be optimized
in the future.

All that being said, the code looks more manageable now.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  67 ++++++-----
>  mm/memcontrol.c            | 224 +++++++++++++++----------------------
>  2 files changed, 133 insertions(+), 158 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 20ecdfae3289..a8c7a0ccc759 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -76,10 +76,27 @@ enum mem_cgroup_events_target {
>  };
>  
>  struct memcg_vmstats_percpu {
> -	long stat[MEMCG_NR_STAT];
> -	unsigned long events[NR_VM_EVENT_ITEMS];
> -	unsigned long nr_page_events;
> -	unsigned long targets[MEM_CGROUP_NTARGETS];
> +	/* Local (CPU and cgroup) page state & events */
> +	long			state[MEMCG_NR_STAT];
> +	unsigned long		events[NR_VM_EVENT_ITEMS];
> +
> +	/* Delta calculation for lockless upward propagation */
> +	long			state_prev[MEMCG_NR_STAT];
> +	unsigned long		events_prev[NR_VM_EVENT_ITEMS];
> +
> +	/* Cgroup1: threshold notifications & softlimit tree updates */
> +	unsigned long		nr_page_events;
> +	unsigned long		targets[MEM_CGROUP_NTARGETS];
> +};
> +
> +struct memcg_vmstats {
> +	/* Aggregated (CPU and subtree) page state & events */
> +	long			state[MEMCG_NR_STAT];
> +	unsigned long		events[NR_VM_EVENT_ITEMS];
> +
> +	/* Pending child counts during tree propagation */
> +	long			state_pending[MEMCG_NR_STAT];
> +	unsigned long		events_pending[NR_VM_EVENT_ITEMS];
>  };
>  
>  struct mem_cgroup_reclaim_iter {
> @@ -287,8 +304,8 @@ struct mem_cgroup {
>  
>  	MEMCG_PADDING(_pad1_);
>  
> -	atomic_long_t		vmstats[MEMCG_NR_STAT];
> -	atomic_long_t		vmevents[NR_VM_EVENT_ITEMS];
> +	/* memory.stat */
> +	struct memcg_vmstats	vmstats;
>  
>  	/* memory.events */
>  	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
> @@ -315,10 +332,6 @@ struct mem_cgroup {
>  	atomic_t		moving_account;
>  	struct task_struct	*move_lock_task;
>  
> -	/* Legacy local VM stats and events */
> -	struct memcg_vmstats_percpu __percpu *vmstats_local;
> -
> -	/* Subtree VM stats and events (batched updates) */
>  	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
>  
>  #ifdef CONFIG_CGROUP_WRITEBACK
> @@ -942,10 +955,6 @@ static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
>  	local_irq_restore(flags);
>  }
>  
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -						gfp_t gfp_mask,
> -						unsigned long *total_scanned);
> -
>  void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  			  unsigned long count);
>  
> @@ -1028,6 +1037,10 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>  void mem_cgroup_split_huge_fixup(struct page *head);
>  #endif
>  
> +unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +						gfp_t gfp_mask,
> +						unsigned long *total_scanned);
> +
>  #else /* CONFIG_MEMCG */
>  
>  #define MEM_CGROUP_ID_SHIFT	0
> @@ -1136,6 +1149,10 @@ static inline bool lruvec_holds_page_lru_lock(struct page *page,
>  	return lruvec == &pgdat->__lruvec;
>  }
>  
> +static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +{
> +}
> +
>  static inline struct mem_cgroup *parent_mem_cgroup(struct mem_cgroup *memcg)
>  {
>  	return NULL;
> @@ -1349,18 +1366,6 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  	mod_node_page_state(page_pgdat(page), idx, val);
>  }
>  
> -static inline
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -					    gfp_t gfp_mask,
> -					    unsigned long *total_scanned)
> -{
> -	return 0;
> -}
> -
> -static inline void mem_cgroup_split_huge_fixup(struct page *head)
> -{
> -}
> -
>  static inline void count_memcg_events(struct mem_cgroup *memcg,
>  				      enum vm_event_item idx,
>  				      unsigned long count)
> @@ -1383,8 +1388,16 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
>  {
>  }
>  
> -static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
> +static inline void mem_cgroup_split_huge_fixup(struct page *head)
> +{
> +}
> +
> +static inline
> +unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +					    gfp_t gfp_mask,
> +					    unsigned long *total_scanned)
>  {
> +	return 0;
>  }
>  #endif /* CONFIG_MEMCG */
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 2f97cb4cef6d..b205b2413186 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -757,6 +757,11 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  	return mz;
>  }
>  
> +static void memcg_flush_vmstats(struct mem_cgroup *memcg)
> +{
> +	cgroup_rstat_flush(memcg->css.cgroup);
> +}
> +
>  /**
>   * __mod_memcg_state - update cgroup memory statistics
>   * @memcg: the memory cgroup
> @@ -765,37 +770,17 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>   */
>  void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
>  {
> -	long x, threshold = MEMCG_CHARGE_BATCH;
> -
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	if (memcg_stat_item_in_bytes(idx))
> -		threshold <<= PAGE_SHIFT;
> -
> -	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
> -	if (unlikely(abs(x) > threshold)) {
> -		struct mem_cgroup *mi;
> -
> -		/*
> -		 * Batch local counters to keep them in sync with
> -		 * the hierarchical ones.
> -		 */
> -		__this_cpu_add(memcg->vmstats_local->stat[idx], x);
> -		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -			atomic_long_add(x, &mi->vmstats[idx]);
> -		x = 0;
> -	}
> -	__this_cpu_write(memcg->vmstats_percpu->stat[idx], x);
> +	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
> +	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
>  }
>  
> -/*
> - * idx can be of type enum memcg_stat_item or node_stat_item.
> - * Keep in sync with memcg_exact_page_state().
> - */
> +/* idx can be of type enum memcg_stat_item or node_stat_item. */
>  static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  {
> -	long x = atomic_long_read(&memcg->vmstats[idx]);
> +	long x = READ_ONCE(memcg->vmstats.state[idx]);
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> @@ -803,17 +788,14 @@ static unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
>  	return x;
>  }
>  
> -/*
> - * idx can be of type enum memcg_stat_item or node_stat_item.
> - * Keep in sync with memcg_exact_page_state().
> - */
> +/* idx can be of type enum memcg_stat_item or node_stat_item. */
>  static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
>  {
>  	long x = 0;
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu)
> -		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
> +		x += per_cpu(memcg->vmstats_percpu->state[idx], cpu);
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> @@ -936,30 +918,16 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  			  unsigned long count)
>  {
> -	unsigned long x;
> -
>  	if (mem_cgroup_disabled())
>  		return;
>  
> -	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
> -	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
> -		struct mem_cgroup *mi;
> -
> -		/*
> -		 * Batch local counters to keep them in sync with
> -		 * the hierarchical ones.
> -		 */
> -		__this_cpu_add(memcg->vmstats_local->events[idx], x);
> -		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -			atomic_long_add(x, &mi->vmevents[idx]);
> -		x = 0;
> -	}
> -	__this_cpu_write(memcg->vmstats_percpu->events[idx], x);
> +	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
> +	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
>  }
>  
>  static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
>  {
> -	return atomic_long_read(&memcg->vmevents[event]);
> +	return READ_ONCE(memcg->vmstats.events[event]);
>  }
>  
>  static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
> @@ -968,7 +936,7 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
>  	int cpu;
>  
>  	for_each_possible_cpu(cpu)
> -		x += per_cpu(memcg->vmstats_local->events[event], cpu);
> +		x += per_cpu(memcg->vmstats_percpu->events[event], cpu);
>  	return x;
>  }
>  
> @@ -1631,6 +1599,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
>  	 *
>  	 * Current memory state:
>  	 */
> +	memcg_flush_vmstats(memcg);
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		u64 size;
> @@ -2450,22 +2419,11 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  	drain_stock(stock);
>  
>  	for_each_mem_cgroup(memcg) {
> -		struct memcg_vmstats_percpu *statc;
>  		int i;
>  
> -		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> -
> -		for (i = 0; i < MEMCG_NR_STAT; i++) {
> +		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
>  			int nid;
>  
> -			if (statc->stat[i]) {
> -				mod_memcg_state(memcg, i, statc->stat[i]);
> -				statc->stat[i] = 0;
> -			}
> -
> -			if (i >= NR_VM_NODE_STAT_ITEMS)
> -				continue;
> -
>  			for_each_node(nid) {
>  				struct batched_lruvec_stat *lstatc;
>  				struct mem_cgroup_per_node *pn;
> @@ -2484,13 +2442,6 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
>  				}
>  			}
>  		}
> -
> -		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> -			if (statc->events[i]) {
> -				count_memcg_events(memcg, i, statc->events[i]);
> -				statc->events[i] = 0;
> -			}
> -		}
>  	}
>  
>  	return 0;
> @@ -3618,6 +3569,8 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  {
>  	unsigned long val;
>  
> +	memcg_flush_vmstats(memcg);
> +
>  	if (mem_cgroup_is_root(memcg)) {
>  		val = memcg_page_state(memcg, NR_FILE_PAGES) +
>  			memcg_page_state(memcg, NR_ANON_MAPPED);
> @@ -3683,26 +3636,15 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  	}
>  }
>  
> -static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
> +static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
>  {
> -	unsigned long stat[MEMCG_NR_STAT] = {0};
> -	struct mem_cgroup *mi;
> -	int node, cpu, i;
> -
> -	for_each_online_cpu(cpu)
> -		for (i = 0; i < MEMCG_NR_STAT; i++)
> -			stat[i] += per_cpu(memcg->vmstats_percpu->stat[i], cpu);
> -
> -	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -		for (i = 0; i < MEMCG_NR_STAT; i++)
> -			atomic_long_add(stat[i], &mi->vmstats[i]);
> +	int node;
>  
>  	for_each_node(node) {
>  		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
>  		struct mem_cgroup_per_node *pi;
> -
> -		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> -			stat[i] = 0;
> +		int cpu, i;
>  
>  		for_each_online_cpu(cpu)
>  			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> @@ -3715,25 +3657,6 @@ static void memcg_flush_percpu_vmstats(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -static void memcg_flush_percpu_vmevents(struct mem_cgroup *memcg)
> -{
> -	unsigned long events[NR_VM_EVENT_ITEMS];
> -	struct mem_cgroup *mi;
> -	int cpu, i;
> -
> -	for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -		events[i] = 0;
> -
> -	for_each_online_cpu(cpu)
> -		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -			events[i] += per_cpu(memcg->vmstats_percpu->events[i],
> -					     cpu);
> -
> -	for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
> -		for (i = 0; i < NR_VM_EVENT_ITEMS; i++)
> -			atomic_long_add(events[i], &mi->vmevents[i]);
> -}
> -
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> @@ -4050,6 +3973,8 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  	int nid;
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> +	memcg_flush_vmstats(memcg);
> +
>  	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
>  		seq_printf(m, "%s=%lu", stat->name,
>  			   mem_cgroup_nr_lru_pages(memcg, stat->lru_mask,
> @@ -4120,6 +4045,8 @@ static int memcg_stat_show(struct seq_file *m, void *v)
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
>  
> +	memcg_flush_vmstats(memcg);
> +
>  	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>  		unsigned long nr;
>  
> @@ -4596,22 +4523,6 @@ struct wb_domain *mem_cgroup_wb_domain(struct bdi_writeback *wb)
>  	return &memcg->cgwb_domain;
>  }
>  
> -/*
> - * idx can be of type enum memcg_stat_item or node_stat_item.
> - * Keep in sync with memcg_exact_page().
> - */
> -static unsigned long memcg_exact_page_state(struct mem_cgroup *memcg, int idx)
> -{
> -	long x = atomic_long_read(&memcg->vmstats[idx]);
> -	int cpu;
> -
> -	for_each_online_cpu(cpu)
> -		x += per_cpu_ptr(memcg->vmstats_percpu, cpu)->stat[idx];
> -	if (x < 0)
> -		x = 0;
> -	return x;
> -}
> -
>  /**
>   * mem_cgroup_wb_stats - retrieve writeback related stats from its memcg
>   * @wb: bdi_writeback in question
> @@ -4637,13 +4548,14 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
>  
> -	*pdirty = memcg_exact_page_state(memcg, NR_FILE_DIRTY);
> +	memcg_flush_vmstats(memcg);
>  
> -	*pwriteback = memcg_exact_page_state(memcg, NR_WRITEBACK);
> -	*pfilepages = memcg_exact_page_state(memcg, NR_INACTIVE_FILE) +
> -			memcg_exact_page_state(memcg, NR_ACTIVE_FILE);
> -	*pheadroom = PAGE_COUNTER_MAX;
> +	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
> +	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> +	*pfilepages = memcg_page_state(memcg, NR_INACTIVE_FILE) +
> +			memcg_page_state(memcg, NR_ACTIVE_FILE);
>  
> +	*pheadroom = PAGE_COUNTER_MAX;
>  	while ((parent = parent_mem_cgroup(memcg))) {
>  		unsigned long ceiling = min(READ_ONCE(memcg->memory.max),
>  					    READ_ONCE(memcg->memory.high));
> @@ -5275,7 +5187,6 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
>  	for_each_node(node)
>  		free_mem_cgroup_per_node_info(memcg, node);
>  	free_percpu(memcg->vmstats_percpu);
> -	free_percpu(memcg->vmstats_local);
>  	kfree(memcg);
>  }
>  
> @@ -5283,11 +5194,10 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
>  {
>  	memcg_wb_domain_exit(memcg);
>  	/*
> -	 * Flush percpu vmstats and vmevents to guarantee the value correctness
> -	 * on parent's and all ancestor levels.
> +	 * Flush percpu lruvec stats to guarantee the value
> +	 * correctness on parent's and all ancestor levels.
>  	 */
> -	memcg_flush_percpu_vmstats(memcg);
> -	memcg_flush_percpu_vmevents(memcg);
> +	memcg_flush_lruvec_page_state(memcg);
>  	__mem_cgroup_free(memcg);
>  }
>  
> @@ -5314,11 +5224,6 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  		goto fail;
>  	}
>  
> -	memcg->vmstats_local = alloc_percpu_gfp(struct memcg_vmstats_percpu,
> -						GFP_KERNEL_ACCOUNT);
> -	if (!memcg->vmstats_local)
> -		goto fail;
> -
>  	memcg->vmstats_percpu = alloc_percpu_gfp(struct memcg_vmstats_percpu,
>  						 GFP_KERNEL_ACCOUNT);
>  	if (!memcg->vmstats_percpu)
> @@ -5518,6 +5423,62 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  	memcg_wb_domain_size_changed(memcg);
>  }
>  
> +static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
> +{
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
> +	struct memcg_vmstats_percpu *statc;
> +	long delta, v;
> +	int i;
> +
> +	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
> +
> +	for (i = 0; i < MEMCG_NR_STAT; i++) {
> +		/*
> +		 * Collect the aggregated propagation counts of groups
> +		 * below us. We're in a per-cpu loop here and this is
> +		 * a global counter, so the first cycle will get them.
> +		 */
> +		delta = memcg->vmstats.state_pending[i];
> +		if (delta)
> +			memcg->vmstats.state_pending[i] = 0;
> +
> +		/* Add CPU changes on this level since the last flush */
> +		v = READ_ONCE(statc->state[i]);
> +		if (v != statc->state_prev[i]) {
> +			delta += v - statc->state_prev[i];
> +			statc->state_prev[i] = v;
> +		}
> +
> +		if (!delta)
> +			continue;
> +
> +		/* Aggregate counts on this level and propagate upwards */
> +		memcg->vmstats.state[i] += delta;
> +		if (parent)
> +			parent->vmstats.state_pending[i] += delta;
> +	}
> +
> +	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
> +		delta = memcg->vmstats.events_pending[i];
> +		if (delta)
> +			memcg->vmstats.events_pending[i] = 0;
> +
> +		v = READ_ONCE(statc->events[i]);
> +		if (v != statc->events_prev[i]) {
> +			delta += v - statc->events_prev[i];
> +			statc->events_prev[i] = v;
> +		}
> +
> +		if (!delta)
> +			continue;
> +
> +		memcg->vmstats.events[i] += delta;
> +		if (parent)
> +			parent->vmstats.events_pending[i] += delta;
> +	}
> +}
> +
>  #ifdef CONFIG_MMU
>  /* Handlers for move charge at task migration. */
>  static int mem_cgroup_do_precharge(unsigned long count)
> @@ -6571,6 +6532,7 @@ struct cgroup_subsys memory_cgrp_subsys = {
>  	.css_released = mem_cgroup_css_released,
>  	.css_free = mem_cgroup_css_free,
>  	.css_reset = mem_cgroup_css_reset,
> +	.css_rstat_flush = mem_cgroup_css_rstat_flush,
>  	.can_attach = mem_cgroup_can_attach,
>  	.cancel_attach = mem_cgroup_cancel_attach,
>  	.post_attach = mem_cgroup_move_task,
> -- 
> 2.30.0

-- 
Michal Hocko
SUSE Labs
