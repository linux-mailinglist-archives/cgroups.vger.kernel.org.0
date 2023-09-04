Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E642B7919EA
	for <lists+cgroups@lfdr.de>; Mon,  4 Sep 2023 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbjIDOot (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Sep 2023 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350471AbjIDOoq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Sep 2023 10:44:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F983CFD;
        Mon,  4 Sep 2023 07:44:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3F2381F38C;
        Mon,  4 Sep 2023 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1693838677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yRti4eS6h3ds+ua4XRbdy3or4N8UEPxmGmuDg2l8Yqs=;
        b=j0jISTWt6fizUTKOBtBbCi4m8tJcXc72iVoZJm1xtKrmtOXmTlGdcDd9MoBsrbZ5zVJ2yI
        Vlh01lE14lO8K3wlUMXaaot0mgdoZY2KbCgLOCWY21Vd8ev5rtFwMMiPyKJm0c1Q9gXBwO
        G7DtLDSVeRSiFnR3HbAN4UuIEHn20Cg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1320A13425;
        Mon,  4 Sep 2023 14:44:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NYzuAVXt9WQINwAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 04 Sep 2023 14:44:37 +0000
Date:   Mon, 4 Sep 2023 16:44:36 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] mm: memcg: properly name and document unified
 stats flushing
Message-ID: <ZPXtVLNIXk8trj2k@dhcp22.suse.cz>
References: <20230831165611.2610118-1-yosryahmed@google.com>
 <20230831165611.2610118-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831165611.2610118-2-yosryahmed@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 31-08-23 16:56:08, Yosry Ahmed wrote:
> Most contexts that flush memcg stats use "unified" flushing, where
> basically all flushers attempt to flush the entire hierarchy, but only
> one flusher is allowed at a time, others skip flushing.
> 
> This is needed because we need to flush the stats from paths such as
> reclaim or refaults, which may have high concurrency, especially on
> large systems. Serializing such performance-sensitive paths can
> introduce regressions, hence, unified flushing offers a tradeoff between
> stats staleness and the performance impact of flushing stats.
> 
> Document this properly and explicitly by renaming the common flushing
> helper from do_flush_stats() to do_unified_stats_flush(), and adding
> documentation to describe unified flushing. Additionally, rename
> flushing APIs to add "try" in the name, which implies that flushing will
> not always happen. Also add proper documentation.
> 
> No functional change intended.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

No objections to renaming but it would be really nice to simplify this.
It is just "funny" to see 4 different flushing methods (flush from
userspace, flush, try_flush_with_ratelimit_1 and try_flush_with_ratelimit_2).
This is all internal so I am not all that worried that this would get
confused but it surely is rather convoluted.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  8 ++---
>  mm/memcontrol.c            | 61 +++++++++++++++++++++++++-------------
>  mm/vmscan.c                |  2 +-
>  mm/workingset.c            |  4 +--
>  4 files changed, 47 insertions(+), 28 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 11810a2cfd2d..d517b0cc5221 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1034,8 +1034,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return x;
>  }
>  
> -void mem_cgroup_flush_stats(void);
> -void mem_cgroup_flush_stats_ratelimited(void);
> +void mem_cgroup_try_flush_stats(void);
> +void mem_cgroup_try_flush_stats_ratelimited(void);
>  
>  void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  			      int val);
> @@ -1519,11 +1519,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return node_page_state(lruvec_pgdat(lruvec), idx);
>  }
>  
> -static inline void mem_cgroup_flush_stats(void)
> +static inline void mem_cgroup_try_flush_stats(void)
>  {
>  }
>  
> -static inline void mem_cgroup_flush_stats_ratelimited(void)
> +static inline void mem_cgroup_try_flush_stats_ratelimited(void)
>  {
>  }
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index cf57fe9318d5..2d0ec828a1c4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -588,7 +588,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
>  static void flush_memcg_stats_dwork(struct work_struct *w);
>  static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
> -static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
> +static atomic_t stats_unified_flush_ongoing = ATOMIC_INIT(0);
>  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
>  static u64 flush_next_time;
>  
> @@ -630,7 +630,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  		/*
>  		 * If stats_flush_threshold exceeds the threshold
>  		 * (>num_online_cpus()), cgroup stats update will be triggered
> -		 * in __mem_cgroup_flush_stats(). Increasing this var further
> +		 * in mem_cgroup_try_flush_stats(). Increasing this var further
>  		 * is redundant and simply adds overhead in atomic update.
>  		 */
>  		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
> @@ -639,15 +639,19 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  	}
>  }
>  
> -static void do_flush_stats(void)
> +/*
> + * do_unified_stats_flush - do a unified flush of memory cgroup statistics
> + *
> + * A unified flush tries to flush the entire hierarchy, but skips if there is
> + * another ongoing flush. This is meant for flushers that may have a lot of
> + * concurrency (e.g. reclaim, refault, etc), and should not be serialized to
> + * avoid slowing down performance-sensitive paths. A unified flush may skip, and
> + * hence may yield stale stats.
> + */
> +static void do_unified_stats_flush(void)
>  {
> -	/*
> -	 * We always flush the entire tree, so concurrent flushers can just
> -	 * skip. This avoids a thundering herd problem on the rstat global lock
> -	 * from memcg flushers (e.g. reclaim, refault, etc).
> -	 */
> -	if (atomic_read(&stats_flush_ongoing) ||
> -	    atomic_xchg(&stats_flush_ongoing, 1))
> +	if (atomic_read(&stats_unified_flush_ongoing) ||
> +	    atomic_xchg(&stats_unified_flush_ongoing, 1))
>  		return;
>  
>  	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
> @@ -655,19 +659,34 @@ static void do_flush_stats(void)
>  	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
>  
>  	atomic_set(&stats_flush_threshold, 0);
> -	atomic_set(&stats_flush_ongoing, 0);
> +	atomic_set(&stats_unified_flush_ongoing, 0);
>  }
>  
> -void mem_cgroup_flush_stats(void)
> +/*
> + * mem_cgroup_try_flush_stats - try to flush memory cgroup statistics
> + *
> + * Try to flush the stats of all memcgs that have stat updates since the last
> + * flush. We do not flush the stats if:
> + * - The magnitude of the pending updates is below a certain threshold.
> + * - There is another ongoing unified flush (see do_unified_stats_flush()).
> + *
> + * Hence, the stats may be stale, but ideally by less than FLUSH_TIME due to
> + * periodic flushing.
> + */
> +void mem_cgroup_try_flush_stats(void)
>  {
>  	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
> -		do_flush_stats();
> +		do_unified_stats_flush();
>  }
>  
> -void mem_cgroup_flush_stats_ratelimited(void)
> +/*
> + * Like mem_cgroup_try_flush_stats(), but only flushes if the periodic flusher
> + * is late.
> + */
> +void mem_cgroup_try_flush_stats_ratelimited(void)
>  {
>  	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
> -		mem_cgroup_flush_stats();
> +		mem_cgroup_try_flush_stats();
>  }
>  
>  static void flush_memcg_stats_dwork(struct work_struct *w)
> @@ -676,7 +695,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
>  	 * Always flush here so that flushing in latency-sensitive paths is
>  	 * as cheap as possible.
>  	 */
> -	do_flush_stats();
> +	do_unified_stats_flush();
>  	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
>  }
>  
> @@ -1576,7 +1595,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  	 *
>  	 * Current memory state:
>  	 */
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_try_flush_stats();
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		u64 size;
> @@ -4018,7 +4037,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
>  	int nid;
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_try_flush_stats();
>  
>  	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
>  		seq_printf(m, "%s=%lu", stat->name,
> @@ -4093,7 +4112,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
>  
>  	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
>  
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_try_flush_stats();
>  
>  	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
>  		unsigned long nr;
> @@ -4595,7 +4614,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
>  	struct mem_cgroup *parent;
>  
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_try_flush_stats();
>  
>  	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
>  	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
> @@ -6610,7 +6629,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
>  	int i;
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
>  
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_try_flush_stats();
>  
>  	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
>  		int nid;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c7c149cb8d66..457a18921fda 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2923,7 +2923,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
>  	 * Flush the memory cgroup stats, so that we read accurate per-memcg
>  	 * lruvec stats for heuristics.
>  	 */
> -	mem_cgroup_flush_stats();
> +	mem_cgroup_try_flush_stats();
>  
>  	/*
>  	 * Determine the scan balance between anon and file LRUs.
> diff --git a/mm/workingset.c b/mm/workingset.c
> index da58a26d0d4d..affb8699e58d 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -520,7 +520,7 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	}
>  
>  	/* Flush stats (and potentially sleep) before holding RCU read lock */
> -	mem_cgroup_flush_stats_ratelimited();
> +	mem_cgroup_try_flush_stats_ratelimited();
>  
>  	rcu_read_lock();
>  
> @@ -664,7 +664,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
>  		struct lruvec *lruvec;
>  		int i;
>  
> -		mem_cgroup_flush_stats();
> +		mem_cgroup_try_flush_stats();
>  		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
>  		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
>  			pages += lruvec_page_state_local(lruvec,
> -- 
> 2.42.0.rc2.253.gd59a3bf2b4-goog

-- 
Michal Hocko
SUSE Labs
