Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5262F52CFBB
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiESJvS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 05:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbiESJvR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 05:51:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FECB1C125;
        Thu, 19 May 2022 02:51:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4AA302188C;
        Thu, 19 May 2022 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652953874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I8DbhN/hmOIXXZ4piaGn9jvuXkaTo8VWp7TEEneSWwU=;
        b=YFxzBTOtJeatYq35CXez5bOlSjNY4j0o3mtivxShrX3+r3OGxsUKu4LeTD5d/SWLBWQHZw
        et1F5ekV2CK0+dO/rT6Z6P3Tc3mMmVNGUJuW4ovJIawZLb0vaTZXSIG2mclSWc4xLg67TK
        pvtcYKhsS9GpnIBCVqgNTN5bQGKNjh4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7FA8F2C141;
        Thu, 19 May 2022 09:51:13 +0000 (UTC)
Date:   Thu, 19 May 2022 11:51:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Zi Yan <ziy@nvidia.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
Message-ID: <YoYTEDD+c4GT0xYY@dhcp22.suse.cz>
References: <20220518190911.82400-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518190911.82400-1-hannes@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed 18-05-22 15:09:11, Johannes Weiner wrote:
> This reverts commit 3a235693d3930e1276c8d9cc0ca5807ef292cf0a.
> 
> Its premise was that cgroup reclaim cares about freeing memory inside
> the cgroup, and demotion just moves them around within the cgroup
> limit. Hence, pages from toptier nodes should be reclaimed directly.
> 
> However, with NUMA balancing now doing tier promotions, demotion is
> part of the page aging process. Global reclaim demotes the coldest
> toptier pages to secondary memory, where their life continues and from
> which they have a chance to get promoted back. Essentially, tiered
> memory systems have an LRU order that spans multiple nodes.
> 
> When cgroup reclaims pages coming off the toptier directly, there can
> be colder pages on lower tier nodes that were demoted by global
> reclaim. This is an aging inversion, not unlike if cgroups were to
> reclaim directly from the active lists while there are inactive pages.
> 
> Proactive reclaim is another factor. The goal of that it is to offload
> colder pages from expensive RAM to cheaper storage. When lower tier
> memory is available as an intermediate layer, we want offloading to
> take advantage of it instead of bypassing to storage.
> 
> Revert the patch so that cgroups respect the LRU order spanning the
> memory hierarchy.

I do agree with your reasoning.

> Of note is a specific undercommit scenario, where all cgroup limits in
> the system add up to <= available toptier memory. In that case,
> shuffling pages out to lower tiers first to reclaim them from there is
> inefficient. This is something could be optimized/short-circuited
> later on (although care must be taken not to accidentally recreate the
> aging inversion). Let's ensure correctness first.

My slight concern with demotion is that there is no actual "guarantee"
to reclaim any charges which try_charge depends on to make a forward
progress. I suspect this is rather unlikely situation, though. The last
tear (without any fallback) should have some memory to reclaim most of
the time. Retries should push some pages out but low effort allocation
requests like GFP_NORETRY might fail but callers should be prepared for
that.

All that being said the agin inversion is much more real of a problem
than this.

> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/vmscan.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c6918fff06e1..7a4090712177 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -528,13 +528,8 @@ static bool can_demote(int nid, struct scan_control *sc)
>  {
>  	if (!numa_demotion_enabled)
>  		return false;
> -	if (sc) {
> -		if (sc->no_demotion)
> -			return false;
> -		/* It is pointless to do demotion in memcg reclaim */
> -		if (cgroup_reclaim(sc))
> -			return false;
> -	}
> +	if (sc && sc->no_demotion)
> +		return false;
>  	if (next_demotion_node(nid) == NUMA_NO_NODE)
>  		return false;
>  
> -- 
> 2.36.1

-- 
Michal Hocko
SUSE Labs
