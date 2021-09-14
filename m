Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6D240A905
	for <lists+cgroups@lfdr.de>; Tue, 14 Sep 2021 10:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbhINITY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Sep 2021 04:19:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59132 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhINITN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Sep 2021 04:19:13 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 33098200DA;
        Tue, 14 Sep 2021 08:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631607473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FmdG8PcnuIQuqHtdoYXiNJLHdhDIQt4J2A8/AC35I5c=;
        b=IEJQ2TEznajvCNl1nH6A7iIwCu5Yz2J4O6kJpMm04Zzijue7NO/Y3POHnHOX/b/kVKP4jV
        J+NBflkpoVjrX5prgNDVxIDkMc5fP1DKHCuipbUuWPRYs87/FbhXcV/LjmatEWuDCKSPaZ
        sC94sWIZJ7yhH2Qaf8zqyF2fSfFK1d4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94D58A3B88;
        Tue, 14 Sep 2021 08:17:52 +0000 (UTC)
Date:   Tue, 14 Sep 2021 10:17:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Feng Tang <feng.tang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <YUBasMWLAjzcgtt9@dhcp22.suse.cz>
References: <1631590828-25565-1-git-send-email-feng.tang@intel.com>
 <24d89efa-502f-e31a-5d45-536352485bbb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24d89efa-502f-e31a-5d45-536352485bbb@suse.cz>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 14-09-21 10:01:26, Vlastimil Babka wrote:
> On 9/14/21 05:40, Feng Tang wrote:
[...]
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
> > +}
> 
> Hmm, could all that become just this?
> 
> !nodes_intersects(&node_states[N_NORMAL_MEMORY], nodes)

Maybe yes but I find the zonelist approach much easier to follow even
though the code looks more complex at first sight. It talks about an
empty zone list for ZONE_NORMAL request which is quite clear from the
scribble. I always have to re-learn how the N*MEMORY works TBH. Maybe
this is just me though.
-- 
Michal Hocko
SUSE Labs
