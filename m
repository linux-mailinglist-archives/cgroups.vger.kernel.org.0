Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38203E1D3B
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2019 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406116AbfJWNs2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 23 Oct 2019 09:48:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:57404 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405869AbfJWNs2 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 23 Oct 2019 09:48:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49913B239;
        Wed, 23 Oct 2019 13:48:26 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:48:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/8] mm: vmscan: simplify lruvec_lru_size()
Message-ID: <20191023134824.GB17610@dhcp22.suse.cz>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-2-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022144803.302233-2-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 22-10-19 10:47:56, Johannes Weiner wrote:
> This function currently takes the node or lruvec size and subtracts
> the zones that are excluded by the classzone index of the
> allocation. It uses four different types of counters to do this.
> 
> Just add up the eligible zones.

The original intention was to optimize this for GFP_KERNEL like
allocations by reducing the number of zones to reduce. But considering
this is not called from hot paths I do agree that a simpler code is more
preferable.
 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 1154b3a2b637..57f533b808f2 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -351,32 +351,21 @@ unsigned long zone_reclaimable_pages(struct zone *zone)
>   */
>  unsigned long lruvec_lru_size(struct lruvec *lruvec, enum lru_list lru, int zone_idx)
>  {
> -	unsigned long lru_size = 0;
> +	unsigned long size = 0;
>  	int zid;
>  
> -	if (!mem_cgroup_disabled()) {
> -		for (zid = 0; zid < MAX_NR_ZONES; zid++)
> -			lru_size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> -	} else
> -		lru_size = node_page_state(lruvec_pgdat(lruvec), NR_LRU_BASE + lru);
> -
> -	for (zid = zone_idx + 1; zid < MAX_NR_ZONES; zid++) {
> +	for (zid = 0; zid <= zone_idx; zid++) {
>  		struct zone *zone = &lruvec_pgdat(lruvec)->node_zones[zid];
> -		unsigned long size;
>  
>  		if (!managed_zone(zone))
>  			continue;
>  
>  		if (!mem_cgroup_disabled())
> -			size = mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
> +			size += mem_cgroup_get_zone_lru_size(lruvec, lru, zid);
>  		else
> -			size = zone_page_state(&lruvec_pgdat(lruvec)->node_zones[zid],
> -				       NR_ZONE_LRU_BASE + lru);
> -		lru_size -= min(size, lru_size);
> +			size += zone_page_state(zone, NR_ZONE_LRU_BASE + lru);
>  	}
> -
> -	return lru_size;
> -
> +	return size;
>  }
>  
>  /*
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
