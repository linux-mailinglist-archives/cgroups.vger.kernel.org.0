Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97143408A51
	for <lists+cgroups@lfdr.de>; Mon, 13 Sep 2021 13:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbhIMLfr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Sep 2021 07:35:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:52976 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239498AbhIMLfr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Sep 2021 07:35:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="219772103"
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="219772103"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 04:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,288,1624345200"; 
   d="scan'208";a="507254149"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Sep 2021 04:34:23 -0700
Date:   Mon, 13 Sep 2021 19:34:23 +0800
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
Message-ID: <20210913113423.GC56674@shbuild999.sh.intel.com>
References: <1631518709-42881-1-git-send-email-feng.tang@intel.com>
 <YT8WygPhuORJC6Pn@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YT8WygPhuORJC6Pn@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Sep 13, 2021 at 11:15:54AM +0200, Michal Hocko wrote:
[...] 
> > +/*
> > + * This will get enabled whenever a cpuset configuration is considered
> > + * unsupportable in general. E.g. movable only node which cannot satisfy
> > + * any non movable allocations (see update_nodemask). Page allocator
> > + * needs to make additional checks for those configurations and this
> > + * check is meant to guard those checks without any overhead for sane
> > + * configurations.
> > + */
> > +static inline bool cpusets_insane_config(void)
> > +{
> > +	return static_branch_unlikely(&cpusets_insane_config_key);
> > +}
> > +
> >  extern int cpuset_init(void);
> >  extern void cpuset_init_smp(void);
> >  extern void cpuset_force_rebuild(void);
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 6a1d79d..b69b871 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1220,6 +1220,18 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
> >  #define for_each_zone_zonelist(zone, z, zlist, highidx) \
> >  	for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
> >  
> > +/* Whether the 'nodes' are all movable nodes */
> > +static inline bool movable_only_nodes(nodemask_t *nodes)
> > +{
> > +	struct zonelist *zonelist;
> > +	struct zoneref *z;
> > +
> > +	zonelist = &(first_online_pgdat())->node_zonelists[ZONELIST_FALLBACK];
> 
> This will work but it just begs a question why you haven't chosen a node
> from the given nodemask. So I believe it would be easier to read if you
> did
> 	zonelist = NODE_DATA(first_node(nodes))->node_zonelists[ZONELIST_FALLBACK]

This was also my first try to get the 'zonelist', but from the
update_nodemask(), the nodemask could be NULL.

	/*
	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
	 * Since nodelist_parse() fails on an empty mask, we special case
	 * that parsing.  The validate_change() call ensures that cpusets
	 * with tasks have memory.
	 */
	if (!*buf) {
		nodes_clear(trialcs->mems_allowed);
	
> > +	z = first_zones_zonelist(zonelist, ZONE_NORMAL,	nodes);
> > +	return (!z->zone) ? true : false;
> > +}
> > +
> > +
> >  #ifdef CONFIG_SPARSEMEM
> >  #include <asm/sparsemem.h>
> >  #endif
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index df1ccf4..03eb40c 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -69,6 +69,13 @@
> >  DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
> >  DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
> >  
> > +/*
> > + * There could be abnormal cpuset configurations for cpu or memory
> > + * node binding, add this key to provide a quick low-cost judgement
> > + * of the situation.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
> > +
> >  /* See "Frequency meter" comments, below. */
> >  
> >  struct fmeter {
> > @@ -1868,6 +1875,13 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
> >  	if (retval < 0)
> >  		goto done;
> >  
> > +	if (movable_only_nodes(&trialcs->mems_allowed)) {
> 
> You can skip the check if cpusets_insane_config(). The question is
> whether you want to report all potential users or only the first one.

Yes, I missed that, will add this check

> > +		static_branch_enable(&cpusets_insane_config_key);
> > +		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)! "
> > +			"Cpuset allocations might fail even with a lot of memory available.\n",
> > +			nodemask_pr_args(&trialcs->mems_allowed));
> > +	}
> > +
> >  	spin_lock_irq(&callback_lock);
> >  	cs->mems_allowed = trialcs->mems_allowed;
> >  	spin_unlock_irq(&callback_lock);
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b37435c..a7e0854 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -4914,6 +4914,19 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
> >  	if (!ac->preferred_zoneref->zone)
> >  		goto nopage;
> >  
> > +	/*
> > +	 * Check for insane configurations where the cpuset doesn't contain
> > +	 * any suitable zone to satisfy the request - e.g. non-movable
> > +	 * GFP_HIGHUSER allocations from MOVABLE nodes only.
> > +	 */
> > +	if (cpusets_insane_config() && (gfp_mask & __GFP_HARDWALL)) {
> > +		struct zoneref *z = first_zones_zonelist(ac->zonelist,
> > +					ac->highest_zoneidx,
> > +					&cpuset_current_mems_allowed);
> > +		if (!z->zone)
> > +			goto nopage;
> > +	}
> > +
> >  	if (alloc_flags & ALLOC_KSWAPD)
> >  		wake_all_kswapds(order, gfp_mask, ac);
> 
> The rest looks sensible to me.

Thanks for the review!

- Feng

> -- 
> Michal Hocko
> SUSE Labs
