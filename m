Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E325D416B70
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 08:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244189AbhIXGMi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 02:12:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:6019 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244146AbhIXGMi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 24 Sep 2021 02:12:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211085588"
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="211085588"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 23:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="534865769"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2021 23:10:54 -0700
Date:   Fri, 24 Sep 2021 14:10:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <20210924061054.GA72911@shbuild999.sh.intel.com>
References: <1631590828-25565-1-git-send-email-feng.tang@intel.com>
 <YUBiYgXWSoKSG7f2@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUBiYgXWSoKSG7f2@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Michal,

On Tue, Sep 14, 2021 at 10:50:42AM +0200, Michal Hocko wrote:
> On Tue 14-09-21 11:40:28, Feng Tang wrote:
[SPIN]
> > The OOM killer cannot help to resolve the situation as there is no
> > usable memory for the request in the cpuset scope. The only reasonable
> > measure to take is to fail the allocation right away and have the caller
> > to deal with it.
> > 
> > So add a check for cases like this in the slowpath of allocation, and
> > bail out early returning NULL for the allocation.
> > 
> > As page allocation is one of the hottest path in kernel, this check
> > will hurt all users with sane cpuset configuration, add a static branch
> > check and detect the abnormal config in cpuset memory binding setup so
> > that the extra check in page allocation is not paid by everyone.
> > 
> > [thanks to Micho Hocko and David Rientjes for suggesting not handle
> >  it inside OOM code, adding cpuset check, refining comments]
> > 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
 
Thank you!

> Minor nit below
> [...]
> > +/* Whether the 'nodes' are all movable nodes */
> > +static inline bool movable_only_nodes(nodemask_t *nodes)
> > +{
> > +	struct zonelist *zonelist;
> > +	struct zoneref *z;
> > +
> > +	if (nodes_empty(*nodes))
> > +		return false;
> > +
> > +	zonelist =
> > +	    &NODE_DATA(first_node(*nodes))->node_zonelists[ZONELIST_FALLBACK];
> > +	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
> > +	return (!z->zone) ? true : false;
> 
> This would read easier to me
> 	/*
> 	 * We can chose arbitrary node from the nodemask to get a
> 	 * zonelist as they are interlinked. We just need to find
> 	 * at least one zone that can satisfy kernel allocations.
> 	 */
> 	node = NODE_DATA(first_node(*nodes));
> 	zonelist = node_zonelist(node, GFP_KERNEL);
> 	z = first_zones_zonelist(zonelist, ZONE_NORMAL, nodes);

When working on the v4 patch, I see some compile warning
that 'node_zonelist()' and 'GFP_KERNEL' are either implicit
or undeclared, as they are from "gfp.h".

So we may need to move this function to gfp.h or keep the
current code with slight modification?

	nid = first_node(*nodes);
	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
	return (!z->zone) ? true : false;

Thanks,
Feng

