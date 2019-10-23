Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81BF3E1DAE
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390356AbfJWOGq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 10:06:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:49678 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390333AbfJWOGp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 23 Oct 2019 10:06:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EEFC7AE04;
        Wed, 23 Oct 2019 14:06:43 +0000 (UTC)
Date:   Wed, 23 Oct 2019 16:06:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 3/8] mm: vmscan: move inactive_list_is_low() swap check
 to the caller
Message-ID: <20191023140642.GD17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-4-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-4-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-10-19 10:47:58, Johannes Weiner wrote:
> inactive_list_is_low() should be about one thing: checking the ratio
> between inactive and active list. Kitchensink checks like the one for
> swap space makes the function hard to use and modify its
> callsites. Luckly, most callers already have an understanding of the
> swap situation, so it's easy to clean up.
> 
> get_scan_count() has its own, memcg-aware swap check, and doesn't even
> get to the inactive_list_is_low() check on the anon list when there is
> no swap space available.
> 
> shrink_list() is called on the results of get_scan_count(), so that
> check is redundant too.
> 
> age_active_anon() has its own totalswap_pages check right before it
> checks the list proportions.
> 
> The shrink_node_memcg() site is the only one that doesn't do its own
> swap check. Add it there.
> 
> Then delete the swap check from inactive_list_is_low().
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

OK, makes sense to me.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index be3c22c274c1..622b77488144 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2226,13 +2226,6 @@ static bool inactive_list_is_low(struct lruvec *lruvec, bool file,
>  	unsigned long refaults;
>  	unsigned long gb;
>  
> -	/*
> -	 * If we don't have swap space, anonymous page deactivation
> -	 * is pointless.
> -	 */
> -	if (!file && !total_swap_pages)
> -		return false;
> -
>  	inactive = lruvec_lru_size(lruvec, inactive_lru, sc->reclaim_idx);
>  	active = lruvec_lru_size(lruvec, active_lru, sc->reclaim_idx);
>  
> @@ -2653,7 +2646,7 @@ static void shrink_node_memcg(struct pglist_data *pgdat, struct mem_cgroup *memc
>  	 * Even if we did not try to evict anon pages at all, we want to
>  	 * rebalance the anon lru active/inactive ratio.
>  	 */
> -	if (inactive_list_is_low(lruvec, false, sc, true))
> +	if (total_swap_pages && inactive_list_is_low(lruvec, false, sc, true))
>  		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
>  				   sc, LRU_ACTIVE_ANON);
>  }
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
