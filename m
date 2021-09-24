Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F51416CB0
	for <lists+cgroups@lfdr.de>; Fri, 24 Sep 2021 09:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244284AbhIXHT0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Sep 2021 03:19:26 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:50860 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244324AbhIXHT0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Sep 2021 03:19:26 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out1.suse.de (Postfix) with ESMTP id A5F0622420;
        Fri, 24 Sep 2021 07:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632467872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/xNUhf/YAAfEBLYbmN30IOswNJKEbij/dzXJ1d79KM=;
        b=G1cdx9jma92fDdbcKp5DT/9xi4SVGP8sPLb8LJwbQxxgwr6wUWPAlDbwTIAQZO4bQBnzMN
        rfTlQZe27fVS7CYHqxOq59hhqHzUaLz3bUB4DlTtaTJh71pDy0bVhb1nyZRPYfNRA3P++Q
        5z9fCqb4HIcwRLesLHhPYS8MXjb4QDo=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay1.suse.de (Postfix) with ESMTPS id 15AEC25D3F;
        Fri, 24 Sep 2021 07:17:51 +0000 (UTC)
Date:   Fri, 24 Sep 2021 09:17:49 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <YU17nUx+yE8ie38s@dhcp22.suse.cz>
References: <1631590828-25565-1-git-send-email-feng.tang@intel.com>
 <YUBiYgXWSoKSG7f2@dhcp22.suse.cz>
 <20210924061054.GA72911@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924061054.GA72911@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 24-09-21 14:10:54, Feng Tang wrote:
> Hi Michal,
> 
> On Tue, Sep 14, 2021 at 10:50:42AM +0200, Michal Hocko wrote:
> > On Tue 14-09-21 11:40:28, Feng Tang wrote:
> [SPIN]
> > > The OOM killer cannot help to resolve the situation as there is no
> > > usable memory for the request in the cpuset scope. The only reasonable
> > > measure to take is to fail the allocation right away and have the caller
> > > to deal with it.
> > > 
> > > So add a check for cases like this in the slowpath of allocation, and
> > > bail out early returning NULL for the allocation.
> > > 
> > > As page allocation is one of the hottest path in kernel, this check
> > > will hurt all users with sane cpuset configuration, add a static branch
> > > check and detect the abnormal config in cpuset memory binding setup so
> > > that the extra check in page allocation is not paid by everyone.
> > > 
> > > [thanks to Micho Hocko and David Rientjes for suggesting not handle
> > >  it inside OOM code, adding cpuset check, refining comments]
> > > 
> > > Suggested-by: Michal Hocko <mhocko@suse.com>
> > > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
>  
> Thank you!
> 
> > Minor nit below
> > [...]
> > > +/* Whether the 'nodes' are all movable nodes */
> > > +static inline bool movable_only_nodes(nodemask_t *nodes)
> > > +{
> > > +	struct zonelist *zonelist;
> > > +	struct zoneref *z;
> > > +
> > > +	if (nodes_empty(*nodes))
> > > +		return false;
> > > +
> > > +	zonelist =
> > > +	    &NODE_DATA(first_node(*nodes))->node_zonelists[ZONELIST_FALLBACK];
> > > +	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
> > > +	return (!z->zone) ? true : false;
> > 
> > This would read easier to me
> > 	/*
> > 	 * We can chose arbitrary node from the nodemask to get a
> > 	 * zonelist as they are interlinked. We just need to find
> > 	 * at least one zone that can satisfy kernel allocations.
> > 	 */
> > 	node = NODE_DATA(first_node(*nodes));
> > 	zonelist = node_zonelist(node, GFP_KERNEL);
> > 	z = first_zones_zonelist(zonelist, ZONE_NORMAL, nodes);
> 
> When working on the v4 patch, I see some compile warning
> that 'node_zonelist()' and 'GFP_KERNEL' are either implicit
> or undeclared, as they are from "gfp.h".
> 
> So we may need to move this function to gfp.h or keep the
> current code with slight modification?
> 
> 	nid = first_node(*nodes);
> 	zonelist = &NODE_DATA(nid)->node_zonelists[ZONELIST_FALLBACK];
> 	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
> 	return (!z->zone) ? true : false;

I would put it into gfp.h but I can see how this might be not really
loved there. Both ways work with me.
-- 
Michal Hocko
SUSE Labs
