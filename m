Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7F531818
	for <lists+cgroups@lfdr.de>; Mon, 23 May 2022 22:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiEWTWL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 23 May 2022 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiEWTVQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 23 May 2022 15:21:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B27229;
        Mon, 23 May 2022 11:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653332399; x=1684868399;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NFWQ8Vo8BSVG/1PeY8TJCl1o40zJKtLANlhbW40DMqw=;
  b=j2XRB2r2esDM94H2dph0KnwiPmAtHlrriT/EZz1eC5T6vEcWRPKSv/cC
   9HzvHQLwZ6eWl+FiaqSpYDpB4tdLlyKVi1qhVPj01deaZwLp5ogGmg1hF
   PBFQF7kiIsG76rEfqKjYmQK4m5NbRDwz/PYj4ThTMrsKV+zz/K4/QAFAF
   jDvjeGppF98iLY/gahKhEQ3nWzzW0UUR+U0PR3/XQutZ3Yoi4TV+FTINr
   cbINWyGXfTbfla7GNXR9xhCIrGND0rbR/VnNfc/WZC8coQMUKaKlwRalJ
   alN+tYHhNZBWPiYCdI/1FNIUEDzTJgcbnHka+64c3V87DvxXhJG2n5Jaf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="272142633"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="272142633"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:59:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="548122603"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.3.38])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:59:57 -0700
Message-ID: <3d6d559e9a23dc2dc79cf453fd64488a4a45cc1b.camel@linux.intel.com>
Subject: Re: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
Date:   Mon, 23 May 2022 11:59:57 -0700
In-Reply-To: <ee1408cb15dbd2e979fe637e2ab91644f6190d0e.camel@intel.com>
References: <20220518190911.82400-1-hannes@cmpxchg.org>
         <ee1408cb15dbd2e979fe637e2ab91644f6190d0e.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, 2022-05-19 at 15:42 +0800, ying.huang@intel.com wrote:
> On Wed, 2022-05-18 at 15:09 -0400, Johannes Weiner wrote:
> > This reverts commit 3a235693d3930e1276c8d9cc0ca5807ef292cf0a.
> > 
> > Its premise was that cgroup reclaim cares about freeing memory inside
> > the cgroup, and demotion just moves them around within the cgroup
> > limit. Hence, pages from toptier nodes should be reclaimed directly.
> > 
> > However, with NUMA balancing now doing tier promotions, demotion is
> > part of the page aging process. Global reclaim demotes the coldest
> > toptier pages to secondary memory, where their life continues and from
> > which they have a chance to get promoted back. Essentially, tiered
> > memory systems have an LRU order that spans multiple nodes.
> > 
> > When cgroup reclaims pages coming off the toptier directly, there can
> > be colder pages on lower tier nodes that were demoted by global
> > reclaim. This is an aging inversion, not unlike if cgroups were to
> > reclaim directly from the active lists while there are inactive pages.
> > 
> > Proactive reclaim is another factor. The goal of that it is to offload
> > colder pages from expensive RAM to cheaper storage. When lower tier
> > memory is available as an intermediate layer, we want offloading to
> > take advantage of it instead of bypassing to storage.
> > 
> > Revert the patch so that cgroups respect the LRU order spanning the
> > memory hierarchy.
> > 
> > Of note is a specific undercommit scenario, where all cgroup limits in
> > the system add up to <= available toptier memory. In that case,
> > shuffling pages out to lower tiers first to reclaim them from there is
> > inefficient. This is something could be optimized/short-circuited
> > later on (although care must be taken not to accidentally recreate the
> > aging inversion). Let's ensure correctness first.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: "Huang, Ying" <ying.huang@intel.com>
> > Cc: Yang Shi <yang.shi@linux.alibaba.com>
> > Cc: Zi Yan <ziy@nvidia.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Roman Gushchin <guro@fb.com>
> 
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> 
> This is also required by Tim's DRAM partition among cgroups in tiered
> sytstem.

Yes, while testing cgroup demotion, I also have to revert
the commit in question.
 
Acked-by: Tim Chen <tim.c.chen@linux.intel.com>
> 
> Best Regards,
> Huang, Ying
> 
> > ---
> >  mm/vmscan.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index c6918fff06e1..7a4090712177 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -528,13 +528,8 @@ static bool can_demote(int nid, struct scan_control *sc)
> >  {
> >  	if (!numa_demotion_enabled)
> >  		return false;
> > -	if (sc) {
> > -		if (sc->no_demotion)
> > -			return false;
> > -		/* It is pointless to do demotion in memcg reclaim */
> > -		if (cgroup_reclaim(sc))
> > -			return false;
> > -	}
> > +	if (sc && sc->no_demotion)
> > +		return false;
> >  	if (next_demotion_node(nid) == NUMA_NO_NODE)
> >  		return false;
> >  
> > 
> > 
> > 
> 
> 

