Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43D68E1DEE
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404433AbfJWOTB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 10:19:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:37182 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404423AbfJWOTB (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 23 Oct 2019 10:19:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 03332ACA8;
        Wed, 23 Oct 2019 14:18:58 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:18:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Message-ID: <20191023141857.GF17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-6-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-6-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-10-19 10:48:00, Johannes Weiner wrote:
> Most of the function body is inside a loop, which imposes an
> additional indentation and scoping level that makes the code a bit
> hard to follow and modify.

I do agree!

> The looping only happens in case of reclaim-compaction, which isn't
> the common case. So rather than adding yet another function level to
> the reclaim path and have every reclaim invocation go through a level
> that only exists for one specific cornercase, use a retry goto.

I would just keep the core logic in its own function and do the loop
around it rather than a goto retry. This is certainly a matter of taste
but I like a loop with an explicit condition much more than a if with
goto.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 231 ++++++++++++++++++++++++++--------------------------
>  1 file changed, 115 insertions(+), 116 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 302dad112f75..235d1fc72311 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2729,144 +2729,143 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
>  static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  {
>  	struct reclaim_state *reclaim_state = current->reclaim_state;
> +	struct mem_cgroup *root = sc->target_mem_cgroup;
>  	unsigned long nr_reclaimed, nr_scanned;
>  	bool reclaimable = false;
> +	struct mem_cgroup *memcg;
> +again:
> +	memset(&sc->nr, 0, sizeof(sc->nr));
>  
> -	do {
> -		struct mem_cgroup *root = sc->target_mem_cgroup;
> -		struct mem_cgroup *memcg;
> -
> -		memset(&sc->nr, 0, sizeof(sc->nr));
> -
> -		nr_reclaimed = sc->nr_reclaimed;
> -		nr_scanned = sc->nr_scanned;
> +	nr_reclaimed = sc->nr_reclaimed;
> +	nr_scanned = sc->nr_scanned;
>  
> -		memcg = mem_cgroup_iter(root, NULL, NULL);
> -		do {
> -			unsigned long reclaimed;
> -			unsigned long scanned;
> +	memcg = mem_cgroup_iter(root, NULL, NULL);
> +	do {
> +		unsigned long reclaimed;
> +		unsigned long scanned;
>  
> -			switch (mem_cgroup_protected(root, memcg)) {
> -			case MEMCG_PROT_MIN:
> -				/*
> -				 * Hard protection.
> -				 * If there is no reclaimable memory, OOM.
> -				 */
> +		switch (mem_cgroup_protected(root, memcg)) {
> +		case MEMCG_PROT_MIN:
> +			/*
> +			 * Hard protection.
> +			 * If there is no reclaimable memory, OOM.
> +			 */
> +			continue;
> +		case MEMCG_PROT_LOW:
> +			/*
> +			 * Soft protection.
> +			 * Respect the protection only as long as
> +			 * there is an unprotected supply
> +			 * of reclaimable memory from other cgroups.
> +			 */
> +			if (!sc->memcg_low_reclaim) {
> +				sc->memcg_low_skipped = 1;
>  				continue;
> -			case MEMCG_PROT_LOW:
> -				/*
> -				 * Soft protection.
> -				 * Respect the protection only as long as
> -				 * there is an unprotected supply
> -				 * of reclaimable memory from other cgroups.
> -				 */
> -				if (!sc->memcg_low_reclaim) {
> -					sc->memcg_low_skipped = 1;
> -					continue;
> -				}
> -				memcg_memory_event(memcg, MEMCG_LOW);
> -				break;
> -			case MEMCG_PROT_NONE:
> -				/*
> -				 * All protection thresholds breached. We may
> -				 * still choose to vary the scan pressure
> -				 * applied based on by how much the cgroup in
> -				 * question has exceeded its protection
> -				 * thresholds (see get_scan_count).
> -				 */
> -				break;
>  			}
> +			memcg_memory_event(memcg, MEMCG_LOW);
> +			break;
> +		case MEMCG_PROT_NONE:
> +			/*
> +			 * All protection thresholds breached. We may
> +			 * still choose to vary the scan pressure
> +			 * applied based on by how much the cgroup in
> +			 * question has exceeded its protection
> +			 * thresholds (see get_scan_count).
> +			 */
> +			break;
> +		}
>  
> -			reclaimed = sc->nr_reclaimed;
> -			scanned = sc->nr_scanned;
> -			shrink_node_memcg(pgdat, memcg, sc);
> -
> -			shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> -					sc->priority);
> -
> -			/* Record the group's reclaim efficiency */
> -			vmpressure(sc->gfp_mask, memcg, false,
> -				   sc->nr_scanned - scanned,
> -				   sc->nr_reclaimed - reclaimed);
> -
> -		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> +		reclaimed = sc->nr_reclaimed;
> +		scanned = sc->nr_scanned;
> +		shrink_node_memcg(pgdat, memcg, sc);
>  
> -		if (reclaim_state) {
> -			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> -			reclaim_state->reclaimed_slab = 0;
> -		}
> +		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> +			    sc->priority);
>  
> -		/* Record the subtree's reclaim efficiency */
> -		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> -			   sc->nr_scanned - nr_scanned,
> -			   sc->nr_reclaimed - nr_reclaimed);
> +		/* Record the group's reclaim efficiency */
> +		vmpressure(sc->gfp_mask, memcg, false,
> +			   sc->nr_scanned - scanned,
> +			   sc->nr_reclaimed - reclaimed);
>  
> -		if (sc->nr_reclaimed - nr_reclaimed)
> -			reclaimable = true;
> +	} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
>  
> -		if (current_is_kswapd()) {
> -			/*
> -			 * If reclaim is isolating dirty pages under writeback,
> -			 * it implies that the long-lived page allocation rate
> -			 * is exceeding the page laundering rate. Either the
> -			 * global limits are not being effective at throttling
> -			 * processes due to the page distribution throughout
> -			 * zones or there is heavy usage of a slow backing
> -			 * device. The only option is to throttle from reclaim
> -			 * context which is not ideal as there is no guarantee
> -			 * the dirtying process is throttled in the same way
> -			 * balance_dirty_pages() manages.
> -			 *
> -			 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
> -			 * count the number of pages under pages flagged for
> -			 * immediate reclaim and stall if any are encountered
> -			 * in the nr_immediate check below.
> -			 */
> -			if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
> -				set_bit(PGDAT_WRITEBACK, &pgdat->flags);
> +	if (reclaim_state) {
> +		sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> +		reclaim_state->reclaimed_slab = 0;
> +	}
>  
> -			/*
> -			 * Tag a node as congested if all the dirty pages
> -			 * scanned were backed by a congested BDI and
> -			 * wait_iff_congested will stall.
> -			 */
> -			if (sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
> -				set_bit(PGDAT_CONGESTED, &pgdat->flags);
> +	/* Record the subtree's reclaim efficiency */
> +	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +		   sc->nr_scanned - nr_scanned,
> +		   sc->nr_reclaimed - nr_reclaimed);
>  
> -			/* Allow kswapd to start writing pages during reclaim.*/
> -			if (sc->nr.unqueued_dirty == sc->nr.file_taken)
> -				set_bit(PGDAT_DIRTY, &pgdat->flags);
> +	if (sc->nr_reclaimed - nr_reclaimed)
> +		reclaimable = true;
>  
> -			/*
> -			 * If kswapd scans pages marked marked for immediate
> -			 * reclaim and under writeback (nr_immediate), it
> -			 * implies that pages are cycling through the LRU
> -			 * faster than they are written so also forcibly stall.
> -			 */
> -			if (sc->nr.immediate)
> -				congestion_wait(BLK_RW_ASYNC, HZ/10);
> -		}
> +	if (current_is_kswapd()) {
> +		/*
> +		 * If reclaim is isolating dirty pages under writeback,
> +		 * it implies that the long-lived page allocation rate
> +		 * is exceeding the page laundering rate. Either the
> +		 * global limits are not being effective at throttling
> +		 * processes due to the page distribution throughout
> +		 * zones or there is heavy usage of a slow backing
> +		 * device. The only option is to throttle from reclaim
> +		 * context which is not ideal as there is no guarantee
> +		 * the dirtying process is throttled in the same way
> +		 * balance_dirty_pages() manages.
> +		 *
> +		 * Once a node is flagged PGDAT_WRITEBACK, kswapd will
> +		 * count the number of pages under pages flagged for
> +		 * immediate reclaim and stall if any are encountered
> +		 * in the nr_immediate check below.
> +		 */
> +		if (sc->nr.writeback && sc->nr.writeback == sc->nr.taken)
> +			set_bit(PGDAT_WRITEBACK, &pgdat->flags);
>  
>  		/*
> -		 * Legacy memcg will stall in page writeback so avoid forcibly
> -		 * stalling in wait_iff_congested().
> +		 * Tag a node as congested if all the dirty pages
> +		 * scanned were backed by a congested BDI and
> +		 * wait_iff_congested will stall.
>  		 */
> -		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
> -		    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
> -			set_memcg_congestion(pgdat, root, true);
> +		if (sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
> +			set_bit(PGDAT_CONGESTED, &pgdat->flags);
> +
> +		/* Allow kswapd to start writing pages during reclaim.*/
> +		if (sc->nr.unqueued_dirty == sc->nr.file_taken)
> +			set_bit(PGDAT_DIRTY, &pgdat->flags);
>  
>  		/*
> -		 * Stall direct reclaim for IO completions if underlying BDIs
> -		 * and node is congested. Allow kswapd to continue until it
> -		 * starts encountering unqueued dirty pages or cycling through
> -		 * the LRU too quickly.
> +		 * If kswapd scans pages marked marked for immediate
> +		 * reclaim and under writeback (nr_immediate), it
> +		 * implies that pages are cycling through the LRU
> +		 * faster than they are written so also forcibly stall.
>  		 */
> -		if (!sc->hibernation_mode && !current_is_kswapd() &&
> -		   current_may_throttle() && pgdat_memcg_congested(pgdat, root))
> -			wait_iff_congested(BLK_RW_ASYNC, HZ/10);
> +		if (sc->nr.immediate)
> +			congestion_wait(BLK_RW_ASYNC, HZ/10);
> +	}
> +
> +	/*
> +	 * Legacy memcg will stall in page writeback so avoid forcibly
> +	 * stalling in wait_iff_congested().
> +	 */
> +	if (cgroup_reclaim(sc) && writeback_throttling_sane(sc) &&
> +	    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
> +		set_memcg_congestion(pgdat, root, true);
> +
> +	/*
> +	 * Stall direct reclaim for IO completions if underlying BDIs
> +	 * and node is congested. Allow kswapd to continue until it
> +	 * starts encountering unqueued dirty pages or cycling through
> +	 * the LRU too quickly.
> +	 */
> +	if (!sc->hibernation_mode && !current_is_kswapd() &&
> +	    current_may_throttle() && pgdat_memcg_congested(pgdat, root))
> +		wait_iff_congested(BLK_RW_ASYNC, HZ/10);
>  
> -	} while (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
> -					 sc));
> +	if (should_continue_reclaim(pgdat, sc->nr_reclaimed - nr_reclaimed,
> +				    sc))
> +		goto again;
>  
>  	/*
>  	 * Kswapd gives up on balancing particular nodes after too
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
