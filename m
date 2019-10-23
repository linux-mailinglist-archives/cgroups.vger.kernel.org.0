Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F69E1DD7
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 16:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbfJWOOl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 10:14:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727194AbfJWOOl (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 23 Oct 2019 10:14:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83806B2BF;
        Wed, 23 Oct 2019 14:14:38 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:14:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/8] mm: vmscan: naming fixes: global_reclaim() and
 sane_reclaim()
Message-ID: <20191023141436.GE17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-5-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-5-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-10-19 10:47:59, Johannes Weiner wrote:
> Seven years after introducing the global_reclaim() function, I still
> have to double take when reading a callsite. I don't know how others
> do it, this is a terrible name.

I somehow never had problem with that but ...
> 
> Invert the meaning and rename it to cgroup_reclaim().
> 
> [ After all, "global reclaim" is just regular reclaim invoked from the
>   page allocator. It's reclaim on behalf of a cgroup limit that is a
>   special case of reclaim, and should be explicit - not the reverse. ]

... this is a valid point.

> sane_reclaim() isn't very descriptive either: it tests whether we can
> use the regular writeback throttling - available during regular page
> reclaim or cgroup2 limit reclaim - or need to use the broken
> wait_on_page_writeback() method. Use "writeback_throttling_sane()".

I do have a stronger opinion on this one. sane_reclaim is really a
terrible name. As you say the only thing this should really tell is
whether writeback throttling is available so I would rather go with
has_writeback_throttling() or writeba_throttling_{eabled,available}
If you insist on having sane in the name then I won't object but it just
raises a question whether we have some levels of throttling with a
different level of sanity.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 38 ++++++++++++++++++--------------------
>  1 file changed, 18 insertions(+), 20 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 622b77488144..302dad112f75 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -239,13 +239,13 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  	up_write(&shrinker_rwsem);
>  }
>  
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -	return !sc->target_mem_cgroup;
> +	return sc->target_mem_cgroup;
>  }
>  
>  /**
> - * sane_reclaim - is the usual dirty throttling mechanism operational?
> + * writeback_throttling_sane - is the usual dirty throttling mechanism available?
>   * @sc: scan_control in question
>   *
>   * The normal page dirty throttling mechanism in balance_dirty_pages() is
> @@ -257,11 +257,9 @@ static bool global_reclaim(struct scan_control *sc)
>   * This function tests whether the vmscan currently in progress can assume
>   * that the normal dirty throttling mechanism is operational.
>   */
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_throttling_sane(struct scan_control *sc)
>  {
> -	struct mem_cgroup *memcg = sc->target_mem_cgroup;
> -
> -	if (!memcg)
> +	if (!cgroup_reclaim(sc))
>  		return true;
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
> @@ -302,12 +300,12 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
>  {
>  }
>  
> -static bool global_reclaim(struct scan_control *sc)
> +static bool cgroup_reclaim(struct scan_control *sc)
>  {
> -	return true;
> +	return false;
>  }
>  
> -static bool sane_reclaim(struct scan_control *sc)
> +static bool writeback_throttling_sane(struct scan_control *sc)
>  {
>  	return true;
>  }
> @@ -1227,7 +1225,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>  				goto activate_locked;
>  
>  			/* Case 2 above */
> -			} else if (sane_reclaim(sc) ||
> +			} else if (writeback_throttling_sane(sc) ||
>  			    !PageReclaim(page) || !may_enter_fs) {
>  				/*
>  				 * This is slightly racy - end_page_writeback()
> @@ -1821,7 +1819,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
>  	if (current_is_kswapd())
>  		return 0;
>  
> -	if (!sane_reclaim(sc))
> +	if (!writeback_throttling_sane(sc))
>  		return 0;
>  
>  	if (file) {
> @@ -1971,7 +1969,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	reclaim_stat->recent_scanned[file] += nr_taken;
>  
>  	item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
> -	if (global_reclaim(sc))
> +	if (!cgroup_reclaim(sc))
>  		__count_vm_events(item, nr_scanned);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_scanned);
>  	spin_unlock_irq(&pgdat->lru_lock);
> @@ -1985,7 +1983,7 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
>  	spin_lock_irq(&pgdat->lru_lock);
>  
>  	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
> -	if (global_reclaim(sc))
> +	if (!cgroup_reclaim(sc))
>  		__count_vm_events(item, nr_reclaimed);
>  	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
>  	reclaim_stat->recent_rotated[0] += stat.nr_activate[0];
> @@ -2309,7 +2307,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  	 * using the memory controller's swap limit feature would be
>  	 * too expensive.
>  	 */
> -	if (!global_reclaim(sc) && !swappiness) {
> +	if (cgroup_reclaim(sc) && !swappiness) {
>  		scan_balance = SCAN_FILE;
>  		goto out;
>  	}
> @@ -2333,7 +2331,7 @@ static void get_scan_count(struct lruvec *lruvec, struct mem_cgroup *memcg,
>  	 * thrashing file LRU becomes infinitely more attractive than
>  	 * anon pages.  Try to detect this based on file LRU size.
>  	 */
> -	if (global_reclaim(sc)) {
> +	if (!cgroup_reclaim(sc)) {
>  		unsigned long pgdatfile;
>  		unsigned long pgdatfree;
>  		int z;
> @@ -2564,7 +2562,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>  	 * abort proportional reclaim if either the file or anon lru has already
>  	 * dropped to zero at the first pass.
>  	 */
> -	scan_adjusted = (global_reclaim(sc) && !current_is_kswapd() &&
> +	scan_adjusted = (!cgroup_reclaim(sc) && !current_is_kswapd() &&
>  			 sc->priority == DEF_PRIORITY);
>  
>  	blk_start_plug(&plug);
> @@ -2853,7 +2851,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  		 * Legacy memcg will stall in page writeback so avoid forcibly
>  		 * stalling in wait_iff_congested().
>  		 */
> -		if (!global_reclaim(sc) && sane_reclaim(sc) &&
> +		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
>  		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
>  			set_memcg_congestion(pgdat, root, true);
>  
> @@ -2948,7 +2946,7 @@ static void shrink_zones(struct zonelist *zonelist, struct scan_control *sc)
>  		 * Take care memory controller reclaiming has small influence
>  		 * to global LRU.
>  		 */
> -		if (global_reclaim(sc)) {
> +		if (!cgroup_reclaim(sc)) {
>  			if (!cpuset_zone_allowed(zone,
>  						 GFP_KERNEL | __GFP_HARDWALL))
>  				continue;
> @@ -3048,7 +3046,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  retry:
>  	delayacct_freepages_start();
>  
> -	if (global_reclaim(sc))
> +	if (!cgroup_reclaim(sc))
>  		__count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
>  
>  	do {
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
