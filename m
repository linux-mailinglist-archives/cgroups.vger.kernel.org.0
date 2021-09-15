Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246A240BF5A
	for <lists+cgroups@lfdr.de>; Wed, 15 Sep 2021 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhIOFeT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Sep 2021 01:34:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:12090 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230304AbhIOFeS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 15 Sep 2021 01:34:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10107"; a="222278693"
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="222278693"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2021 22:32:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,294,1624345200"; 
   d="scan'208";a="552927349"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Sep 2021 22:32:47 -0700
Date:   Wed, 15 Sep 2021 13:32:47 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/page_alloc: detect allocation forbidden by cpuset
 and bail out early
Message-ID: <20210915053247.GG56674@shbuild999.sh.intel.com>
References: <1631590828-25565-1-git-send-email-feng.tang@intel.com>
 <3bd87d8a-d09e-ac7-1d1d-25ad1b9d5ed9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bd87d8a-d09e-ac7-1d1d-25ad1b9d5ed9@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 14, 2021 at 05:30:03PM -0700, David Rientjes wrote:
> On Tue, 14 Sep 2021, Feng Tang wrote:
> 
> > diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
> > index d2b9c41..d58e047 100644
> > --- a/include/linux/cpuset.h
> > +++ b/include/linux/cpuset.h
> > @@ -34,6 +34,8 @@
> >   */
> >  extern struct static_key_false cpusets_pre_enable_key;
> >  extern struct static_key_false cpusets_enabled_key;
> > +extern struct static_key_false cpusets_insane_config_key;
> > +
> >  static inline bool cpusets_enabled(void)
> >  {
> >  	return static_branch_unlikely(&cpusets_enabled_key);
> > @@ -51,6 +53,19 @@ static inline void cpuset_dec(void)
> >  	static_branch_dec_cpuslocked(&cpusets_pre_enable_key);
> >  }
> >  
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
> > @@ -167,6 +182,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
> >  
> >  static inline bool cpusets_enabled(void) { return false; }
> >  
> > +static inline bool cpusets_insane_config(void) { return false; }
> > +
> >  static inline int cpuset_init(void) { return 0; }
> >  static inline void cpuset_init_smp(void) {}
> >  
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index 6a1d79d..a455333 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -1220,6 +1220,22 @@ static inline struct zoneref *first_zones_zonelist(struct zonelist *zonelist,
> >  #define for_each_zone_zonelist(zone, z, zlist, highidx) \
> >  	for_each_zone_zonelist_nodemask(zone, z, zlist, highidx, NULL)
> >  
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
> > +
> > +
> >  #ifdef CONFIG_SPARSEMEM
> >  #include <asm/sparsemem.h>
> >  #endif
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index df1ccf4..7fa633e 100644
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
> > @@ -1868,6 +1875,14 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
> >  	if (retval < 0)
> >  		goto done;
> >  
> > +	if (!cpusets_insane_config() &&
> > +		movable_only_nodes(&trialcs->mems_allowed)) {
> > +		static_branch_enable(&cpusets_insane_config_key);
> > +		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl)! "
> > +			"Cpuset allocations might fail even with a lot of memory available.\n",
> > +			nodemask_pr_args(&trialcs->mems_allowed));
> > +	}
> > +
> >  	spin_lock_irq(&callback_lock);
> >  	cs->mems_allowed = trialcs->mems_allowed;
> >  	spin_unlock_irq(&callback_lock);
> 
> Is this the only time that the state of the nodemask may change?
> 
> I'm wondering about a single node nodemask, for example, where all 
> ZONE_NORMAL memory is hot-removed.

Thanks for the reminding! Yes, memory hot remove can change the
cpuset's effective nodemask, we may need to add similar check inside
cpuset_hotplug_update_tasks() which is called by cpuset_hotplug_workfn(), 
something like below?

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7fa633e..d5f6776 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3186,6 +3186,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	cpus_updated = !cpumask_equal(&new_cpus, cs->effective_cpus);
 	mems_updated = !nodes_equal(new_mems, cs->effective_mems);
 
+	if (mems_updated && !cpusets_insane_config() &&
+		movable_only_nodes(new_mems)) {
+		static_branch_enable(&cpusets_insane_config_key);
+		pr_info("Unsupported (movable nodes only) cpuset configuration detected (nmask=%*pbl) after memory hotplug."
+			"Cpuset allocations might fail even with a lot of memory available.\n",
+			nodemask_pr_args(new_mems);
+	}
+
 	if (is_in_v2_mode())
 		hotplug_update_tasks(cs, &new_cpus, &new_mems,
 				     cpus_updated, mems_updated);

Thanks,
Feng
