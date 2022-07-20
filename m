Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0BE57B3C0
	for <lists+cgroups@lfdr.de>; Wed, 20 Jul 2022 11:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiGTJYQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Jul 2022 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238778AbiGTJYO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Jul 2022 05:24:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80ED44B48A;
        Wed, 20 Jul 2022 02:24:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2014720720;
        Wed, 20 Jul 2022 09:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658309051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Su3HLAuy7lHq0rdQpeNwNVroUq7F2bc2C0CpI11UKgk=;
        b=IPBQ63dpffvjumpNL7egBgA3pT4P2hB9jwBDQAA7O/J1ymTnxLQyb8tCHIn6jUxaFK/lJ3
        LPFdMoZicNGvesr364u2snSh9MsfW0jm4pGacRFCIbfvfHvGfwObCpq7qIXdV1gTh322FP
        1kmnMo1qYUR23pCiqDF4i+hlT8BaKDg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8EC382C141;
        Wed, 20 Jul 2022 09:24:10 +0000 (UTC)
Date:   Wed, 20 Jul 2022 11:24:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in
 vmpressure
Message-ID: <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
References: <20220714064918.2576464-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714064918.2576464-1-yosryahmed@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 14-07-22 06:49:18, Yosry Ahmed wrote:
> vmpressure is used in cgroup v1 to notify userspace of reclaim
> efficiency events, and is also used in both cgroup v1 and v2 as a signal
> for memory pressure for networking, see
> mem_cgroup_under_socket_pressure().
> 
> Proactive reclaim intends to probe memcgs for cold memory, without
> affecting their performance. Hence, reclaim caused by writing to
> memory.reclaim should not trigger vmpressure.

I am not against the change but this is rather vague statement. Please
be more specific. You are not really explaining what kind of side effect
this does and why that is really desirable. Sure pro-active reclaim can
be used to probe for a cold memory but it can also be used to balance
the memory consumption or other potential usecases.

I think what we are missing here is
- explain that this doesn't have any effect on existing users of
  vmpressure user interface because that is cgroup v1 and memory.reclaim
  is v2 feature. This is a trivial statement but quite useful for future
  readers of this commit
- explain the effect on the networking layer and typical usecases
  memory.reclaim is used for currently and ideally document that.
- how are we going to deal with users who would really want to use
  memory.reclaim interface as a replacement for existing hard/high
  memory reclaim? Is that even something that the interface is intended
  for?

> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Shakeel Butt <shakeelb@google.com>

The patch itself looks good to me.

> ---
> Changes in v4:
> - Removed unneeded reclaim_options local variables (Andrew).
> 
> Changes in v3:
> - Limited the vmpressure change to memory.reclaim, dropped psi changes,
>   updated changelog to reflect new behavior (Michal, Shakeel)
> 
> Changes in v2:
> - Removed unnecessary initializations to zero (Andrew).
> - Separate declarations and initializations when it causes line wrapping
>   (Andrew).
> 
> ---
>  include/linux/swap.h |  5 ++++-
>  mm/memcontrol.c      | 24 ++++++++++++++----------
>  mm/vmscan.c          | 27 +++++++++++++++++----------
>  3 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 0c0fed1b348f..f6e9eaa2339f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -411,10 +411,13 @@ extern void lru_cache_add_inactive_or_unevictable(struct page *page,
>  extern unsigned long zone_reclaimable_pages(struct zone *zone);
>  extern unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>  					gfp_t gfp_mask, nodemask_t *mask);
> +
> +#define MEMCG_RECLAIM_MAY_SWAP (1 << 1)
> +#define MEMCG_RECLAIM_PROACTIVE (1 << 2)
>  extern unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  						  unsigned long nr_pages,
>  						  gfp_t gfp_mask,
> -						  bool may_swap);
> +						  unsigned int reclaim_options);
>  extern unsigned long mem_cgroup_shrink_node(struct mem_cgroup *mem,
>  						gfp_t gfp_mask, bool noswap,
>  						pg_data_t *pgdat,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index a550042d88c3..b668224142c7 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2331,7 +2331,8 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
>  
>  		psi_memstall_enter(&pflags);
>  		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
> -							     gfp_mask, true);
> +							gfp_mask,
> +							MEMCG_RECLAIM_MAY_SWAP);
>  		psi_memstall_leave(&pflags);
>  	} while ((memcg = parent_mem_cgroup(memcg)) &&
>  		 !mem_cgroup_is_root(memcg));
> @@ -2576,7 +2577,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	struct page_counter *counter;
>  	unsigned long nr_reclaimed;
>  	bool passed_oom = false;
> -	bool may_swap = true;
> +	unsigned int reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
>  	bool drained = false;
>  	unsigned long pflags;
>  
> @@ -2593,7 +2594,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  		mem_over_limit = mem_cgroup_from_counter(counter, memory);
>  	} else {
>  		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
> -		may_swap = false;
> +		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
>  	}
>  
>  	if (batch > nr_pages) {
> @@ -2620,7 +2621,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  
>  	psi_memstall_enter(&pflags);
>  	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
> -						    gfp_mask, may_swap);
> +						    gfp_mask, reclaim_options);
>  	psi_memstall_leave(&pflags);
>  
>  	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
> @@ -3402,8 +3403,8 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  			continue;
>  		}
>  
> -		if (!try_to_free_mem_cgroup_pages(memcg, 1,
> -					GFP_KERNEL, !memsw)) {
> +		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> +					memsw ? 0 : MEMCG_RECLAIM_MAY_SWAP)) {
>  			ret = -EBUSY;
>  			break;
>  		}
> @@ -3513,7 +3514,8 @@ static int mem_cgroup_force_empty(struct mem_cgroup *memcg)
>  		if (signal_pending(current))
>  			return -EINTR;
>  
> -		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL, true))
> +		if (!try_to_free_mem_cgroup_pages(memcg, 1, GFP_KERNEL,
> +						  MEMCG_RECLAIM_MAY_SWAP))
>  			nr_retries--;
>  	}
>  
> @@ -6248,7 +6250,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  		}
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg, nr_pages - high,
> -							 GFP_KERNEL, true);
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP);
>  
>  		if (!reclaimed && !nr_retries--)
>  			break;
> @@ -6297,7 +6299,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
>  
>  		if (nr_reclaims) {
>  			if (!try_to_free_mem_cgroup_pages(memcg, nr_pages - max,
> -							  GFP_KERNEL, true))
> +					GFP_KERNEL, MEMCG_RECLAIM_MAY_SWAP))
>  				nr_reclaims--;
>  			continue;
>  		}
> @@ -6426,6 +6428,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
>  	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
>  	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	unsigned int reclaim_options;
>  	int err;
>  
>  	buf = strstrip(buf);
> @@ -6433,6 +6436,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  	if (err)
>  		return err;
>  
> +	reclaim_options	= MEMCG_RECLAIM_MAY_SWAP | MEMCG_RECLAIM_PROACTIVE;
>  	while (nr_reclaimed < nr_to_reclaim) {
>  		unsigned long reclaimed;
>  
> @@ -6449,7 +6453,7 @@ static ssize_t memory_reclaim(struct kernfs_open_file *of, char *buf,
>  
>  		reclaimed = try_to_free_mem_cgroup_pages(memcg,
>  						nr_to_reclaim - nr_reclaimed,
> -						GFP_KERNEL, true);
> +						GFP_KERNEL, reclaim_options);
>  
>  		if (!reclaimed && !nr_retries--)
>  			return -EAGAIN;
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f7d9a683e3a7..0969e6408a53 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -102,6 +102,9 @@ struct scan_control {
>  	/* Can pages be swapped as part of reclaim? */
>  	unsigned int may_swap:1;
>  
> +	/* Proactive reclaim invoked by userspace through memory.reclaim */
> +	unsigned int proactive:1;
> +
>  	/*
>  	 * Cgroup memory below memory.low is protected as long as we
>  	 * don't threaten to OOM. If any cgroup is reclaimed at
> @@ -3125,9 +3128,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  			    sc->priority);
>  
>  		/* Record the group's reclaim efficiency */
> -		vmpressure(sc->gfp_mask, memcg, false,
> -			   sc->nr_scanned - scanned,
> -			   sc->nr_reclaimed - reclaimed);
> +		if (!sc->proactive)
> +			vmpressure(sc->gfp_mask, memcg, false,
> +				   sc->nr_scanned - scanned,
> +				   sc->nr_reclaimed - reclaimed);
>  
>  	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, NULL)));
>  }
> @@ -3250,9 +3254,10 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  	}
>  
>  	/* Record the subtree's reclaim efficiency */
> -	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> -		   sc->nr_scanned - nr_scanned,
> -		   sc->nr_reclaimed - nr_reclaimed);
> +	if (!sc->proactive)
> +		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +			   sc->nr_scanned - nr_scanned,
> +			   sc->nr_reclaimed - nr_reclaimed);
>  
>  	if (sc->nr_reclaimed - nr_reclaimed)
>  		reclaimable = true;
> @@ -3534,8 +3539,9 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
>  		__count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
>  
>  	do {
> -		vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
> -				sc->priority);
> +		if (!sc->proactive)
> +			vmpressure_prio(sc->gfp_mask, sc->target_mem_cgroup,
> +					sc->priority);
>  		sc->nr_scanned = 0;
>  		shrink_zones(zonelist, sc);
>  
> @@ -3825,7 +3831,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
>  unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  					   unsigned long nr_pages,
>  					   gfp_t gfp_mask,
> -					   bool may_swap)
> +					   unsigned int reclaim_options)
>  {
>  	unsigned long nr_reclaimed;
>  	unsigned int noreclaim_flag;
> @@ -3838,7 +3844,8 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
>  		.priority = DEF_PRIORITY,
>  		.may_writepage = !laptop_mode,
>  		.may_unmap = 1,
> -		.may_swap = may_swap,
> +		.may_swap = !!(reclaim_options & MEMCG_RECLAIM_MAY_SWAP),
> +		.proactive = !!(reclaim_options & MEMCG_RECLAIM_PROACTIVE),
>  	};
>  	/*
>  	 * Traverse the ZONELIST_FALLBACK zonelist of the current node to put
> -- 
> 2.37.0.144.g8ac04bfd2-goog

-- 
Michal Hocko
SUSE Labs
