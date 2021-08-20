Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2443F2FE3
	for <lists+cgroups@lfdr.de>; Fri, 20 Aug 2021 17:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241020AbhHTPpe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Aug 2021 11:45:34 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45460 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbhHTPpe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Aug 2021 11:45:34 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 76D541FE2C;
        Fri, 20 Aug 2021 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629474295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ogYunvpZVJ/3GqmU2H+7Y5oXqBsYG05vVrhz9e8RiVA=;
        b=lp6617sFBwYD2Nii4xorvJxfjYSV8LrclKGB2WTnYrAWOtQilQXMmz/haWyv08xcbodjuG
        XYmUagb/VEJLqdlM0wrNEZzi1NgMpx5AweF9G0PDh7fS1trGoqV3CCCSy8q6aEsZ2bLdYa
        p7TbUYkg28fW0xG3j7ydNOkRrrnhMWM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2D26AA3B87;
        Fri, 20 Aug 2021 15:44:55 +0000 (UTC)
Date:   Fri, 20 Aug 2021 17:44:54 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Leon Yang <lnyng@fb.com>, Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: fix occasional OOMs due to proportional
 memory.low reclaim
Message-ID: <YR/N9lrUROSd6TCV@dhcp22.suse.cz>
References: <20210817180506.220056-1-hannes@cmpxchg.org>
 <YR5yUolPN+hSsUgJ@dhcp22.suse.cz>
 <YR7BY2Z0cXvW/uTO@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR7BY2Z0cXvW/uTO@cmpxchg.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 19-08-21 16:38:59, Johannes Weiner wrote:
> On Thu, Aug 19, 2021 at 05:01:38PM +0200, Michal Hocko wrote:
[...]
> > The logic is spread over 3 different places.
> > 
> > Would something like the following be more understandable?
> > 
> > 			/*
> > 			 * Low limit protected memcgs are already excluded at
> > 			 * a higher level (shrink_node_memcgs) but scaling
> > 			 * down the reclaim target can result in hard to
> > 			 * reclaim and premature OOM. We do not have a full
> > 			 * picture here so we cannot really judge this
> > 			 * sutuation here but pro-actively flag this scenario
> > 			 * and let do_try_to_free_pages to retry if
> > 			 * there is no progress.
> > 			 */
> 
> I've been drafting around with this, but it seems to say the same
> thing as the comment I put into struct scan_control already:
> 
> 	/*
> 	 * Cgroup memory below memory.low is protected as long as we
> 	 * don't threaten to OOM. If any cgroup is reclaimed at
> 	 * reduced force or passed over entirely due to its memory.low
> 	 * setting (memcg_low_skipped), and nothing is reclaimed as a
> 	 * result, then go back back for one more cycle that reclaims
> 	 * the protected memory (memcg_low_reclaim) to avert OOM.
> 	 */
> 
> How about a brief version of this with a pointer to the original?
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 701106e1829c..c32d686719d5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2580,7 +2580,12 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  			unsigned long cgroup_size = mem_cgroup_size(memcg);
>  			unsigned long protection;
>  
> -			/* memory.low scaling, make sure we retry before OOM */
> +			/*
> +			 * Soft protection must not cause reclaim failure. Let
> +			 * the upper level know if we skipped pages during the
> +			 * first pass, so it can retry if necessary. See the
> +			 * struct scan_control definition of those flags.
> +			 */
>  			if (!sc->memcg_low_reclaim && low > min) {
>  				protection = low;
>  				sc->memcg_low_skipped = 1;
> @@ -2853,16 +2858,16 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  
>  		if (mem_cgroup_below_min(memcg)) {
>  			/*
> -			 * Hard protection.
> -			 * If there is no reclaimable memory, OOM.
> +			 * Hard protection. Always respected. If there is not
> +			 * enough reclaimable memory elsewhere, it's an OOM.
>  			 */
>  			continue;
>  		} else if (mem_cgroup_below_low(memcg)) {
>  			/*
> -			 * Soft protection.
> -			 * Respect the protection only as long as
> -			 * there is an unprotected supply
> -			 * of reclaimable memory from other cgroups.
> +			 * Soft protection must not cause reclaim failure. Let
> +			 * the upper level know if we skipped pages during the
> +			 * first pass, so it can retry if necessary. See the
> +			 * struct scan_control definition of those flags.
>  			 */
>  			if (!sc->memcg_low_reclaim) {
>  				sc->memcg_low_skipped = 1;

Yes, this makes the situation more explicit. I still see some advantage
to be explicit about those other layers as this will be easier to follow
the code but I will certainly not insist.

Andrew has already sent your original patch to Linus so this will need
to go as a separate patch. For that
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

-- 
Michal Hocko
SUSE Labs
