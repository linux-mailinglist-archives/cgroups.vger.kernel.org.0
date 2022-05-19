Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C952CD64
	for <lists+cgroups@lfdr.de>; Thu, 19 May 2022 09:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbiESHmr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 19 May 2022 03:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbiESHmn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 19 May 2022 03:42:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AF5AEE35;
        Thu, 19 May 2022 00:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652946158; x=1684482158;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2Ojw62lZylIf6juVQUL8OPlwJ0l8Bpb1S6O2GhP47Ls=;
  b=LE8/RwUyIr7sU+GGUAvpxQKw4TxUKRY+CGm+NTtSxa2Z9+gvNoazLCt+
   VmBMvDuSJhqbH1R71K1VRtHq9U4oFxf8aJ2frI9sLfjFW9SmW80MBKXoj
   SA6M2icuYkHL70lmt0FvQz/BBYWA2qnxKli9gnL9uTXehO99KQ4c4LOJD
   SF8gRz5R18Ep/HYJEBcSzb/riVXUGJHtXLZve80J0/194N+K/BjhX/mf+
   C/xSyQDQrwhAOy35RyWE2XfLFrMJSOjbFgmFbUwMKp2IQ2T0xbrs54mHD
   Q/oDlc+xcE5vEtHbrhlX/r79kW7etXtAHCCDWCp4ak9BjX1qxLVfJji8g
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="332695724"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="332695724"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 00:42:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="545950159"
Received: from xiaominc-mobl1.ccr.corp.intel.com ([10.254.213.242])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 00:42:34 -0700
Message-ID: <ee1408cb15dbd2e979fe637e2ab91644f6190d0e.camel@intel.com>
Subject: Re: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
Date:   Thu, 19 May 2022 15:42:31 +0800
In-Reply-To: <20220518190911.82400-1-hannes@cmpxchg.org>
References: <20220518190911.82400-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, 2022-05-18 at 15:09 -0400, Johannes Weiner wrote:
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
> 
> Of note is a specific undercommit scenario, where all cgroup limits in
> the system add up to <= available toptier memory. In that case,
> shuffling pages out to lower tiers first to reclaim them from there is
> inefficient. This is something could be optimized/short-circuited
> later on (although care must be taken not to accidentally recreate the
> aging inversion). Let's ensure correctness first.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "Huang, Ying" <ying.huang@intel.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Roman Gushchin <guro@fb.com>

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

This is also required by Tim's DRAM partition among cgroups in tiered
sytstem.

Best Regards,
Huang, Ying

> ---
>  mm/vmscan.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index c6918fff06e1..7a4090712177 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -528,13 +528,8 @@ static bool can_demote(int nid, struct scan_control *sc)
>  {
>  	if (!numa_demotion_enabled)
>  		return false;
> -	if (sc) {
> -		if (sc->no_demotion)
> -			return false;
> -		/* It is pointless to do demotion in memcg reclaim */
> -		if (cgroup_reclaim(sc))
> -			return false;
> -	}
> +	if (sc && sc->no_demotion)
> +		return false;
>  	if (next_demotion_node(nid) == NUMA_NO_NODE)
>  		return false;
>  
> 
> 
> 


