Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A694C408AC7
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 14:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237134AbhIMMNx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 08:13:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:61287 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236304AbhIMMNx (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Sep 2021 08:13:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="307204607"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="307204607"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 05:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="543150497"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Sep 2021 05:12:33 -0700
Date:   Mon, 13 Sep 2021 20:12:33 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <20210913121233.GD56674@shbuild999.sh.intel.com>
References: <1631518709-42881-1-git-send-email-feng.tang@intel.com>
 <YT8WygPhuORJC6Pn@dhcp22.suse.cz>
 <20210913113423.GC56674@shbuild999.sh.intel.com>
 <YT8576cL4tSqmUKI@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT8576cL4tSqmUKI@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 13, 2021 at 01:45:51PM +0200, Michal Hocko wrote:
> On Mon 13-09-21 19:34:23, Feng Tang wrote:
> > On Mon, Sep 13, 2021 at 11:15:54AM +0200, Michal Hocko wrote:
> [...] 
> > > > +/* Whether the 'nodes' are all movable nodes */
> > > > +static inline bool movable_only_nodes(nodemask_t *nodes)
> > > > +{
> > > > +	struct zonelist *zonelist;
> > > > +	struct zoneref *z;
> > > > +
> > > > +	zonelist = &(first_online_pgdat())->node_zonelists[ZONELIST_FALLBACK];
> > > 
> > > This will work but it just begs a question why you haven't chosen a node
> > > from the given nodemask. So I believe it would be easier to read if you
> > > did
> > > 	zonelist = NODE_DATA(first_node(nodes))->node_zonelists[ZONELIST_FALLBACK]
> > 
> > This was also my first try to get the 'zonelist', but from the
> > update_nodemask(), the nodemask could be NULL.
> 
> I guess you meant to say s@NULL@empty@
> While this complicates things a bit it is nothing really hard to work
> around. You simply check for nodes_empty() and return false because such
> a nodemask cannot by definition be movable only.

Yes, a nodes_empty() check can solve it, thanks,

- Feng

> -- 
> Michal Hocko
> SUSE Labs
