Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE730FF8D
	for <lists+cgroups@lfdr.de>; Thu,  4 Feb 2021 22:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhBDVqv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 4 Feb 2021 16:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhBDVqO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 4 Feb 2021 16:46:14 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF48C0611C2
        for <cgroups@vger.kernel.org>; Thu,  4 Feb 2021 13:44:29 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id e15so3575694qte.9
        for <cgroups@vger.kernel.org>; Thu, 04 Feb 2021 13:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hdmCgZ393K7NtOVzWLjmvQGdGZBIWfOaVwai+rEw85I=;
        b=jkjnPSriyMdvqxobWFYWh3hZhn/hWIhTjYaTL23nTmILUBNx06PxjDyEFhcHo3iWYD
         jwIllcZpJuQ5PgSvBHL0IOBGorD7GQMPPFJFv1w5SNabwNOHMzCs9yEJVnoBTHM7meFO
         /7omOQveUP3Ai7kV3fiq23vkgXOVXF5zVgSRTwJAOqHZprFv7e1R7Gv0uU8R84aZn8JU
         CzhDjbVpy4501FG0M9xSxrhAUpzhKZ1/wMW2I3Qf/ot0lgiNbAAydZdDeWmeWC+fraOF
         AnjPpR7TihfJmYK7AxLuEPJVtazbqtt59rd80dPXKo0hwZHpgglyri+tKAiqmpQWsBTW
         Ag4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hdmCgZ393K7NtOVzWLjmvQGdGZBIWfOaVwai+rEw85I=;
        b=rBJX/oOaaDsWKDuzSxGrIVF1UDpDvPwJ9BAx4yWodovgJvZsK38UJ+TPob8ruvZsUz
         CCHRsfBIJjWE+GW3FALDUa1psL7kYPpRod/ZImKF+12uR7g+Aonc0wZG6/skorPdZGID
         3PGqgmyxhebyQelZ0XeRRmRxnuPsqG+gE+YlSj6idZ1Ujh0WoFH18FZVWT+pdhqwv2eI
         BXLdEyxrt13FXOZ8l2Xsi6d2v+LQY+2l30Y/54Rk1WABcAfR995y+8JXdoJk2CYALO9r
         SHooXrLHuvOHjTUm/U2mYmi1+2dvguMk4BVBr8HO2LrODLLPE1/sm1gmIymkhJPUfhs+
         qcDA==
X-Gm-Message-State: AOAM530T49FrQbloemrY5VKzD2N/EK+ZiT/4KXGxqzzmgA2asjBAc4h6
        mzL0BU/8gkab1oorpxji4nBPYQ==
X-Google-Smtp-Source: ABdhPJzI1jTQZBq+o0Y/ai6kkkQ0TaY0oCLymW7q3aOLrgtM0Cy+Vu9c2Z+AJxsx09a0O3HHMrGeuQ==
X-Received: by 2002:ac8:1408:: with SMTP id k8mr1653281qtj.204.1612475068796;
        Thu, 04 Feb 2021 13:44:28 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id t22sm5730090qtp.7.2021.02.04.13.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 13:44:27 -0800 (PST)
Date:   Thu, 4 Feb 2021 16:44:27 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 7/7] mm: memcontrol: consolidate lruvec stat flushing
Message-ID: <YBxquyq6XzWlV3Wv@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
 <20210202184746.119084-8-hannes@cmpxchg.org>
 <20210203022530.GF1812008@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203022530.GF1812008@carbon.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 02, 2021 at 06:25:30PM -0800, Roman Gushchin wrote:
> On Tue, Feb 02, 2021 at 01:47:46PM -0500, Johannes Weiner wrote:
> > There are two functions to flush the per-cpu data of an lruvec into
> > the rest of the cgroup tree: when the cgroup is being freed, and when
> > a CPU disappears during hotplug. The difference is whether all CPUs or
> > just one is being collected, but the rest of the flushing code is the
> > same. Merge them into one function and share the common code.
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  mm/memcontrol.c | 88 +++++++++++++++++++++++--------------------------
> >  1 file changed, 42 insertions(+), 46 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index b205b2413186..88e8afc49a46 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2410,39 +2410,56 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
> >  	mutex_unlock(&percpu_charge_mutex);
> >  }
> >  
> > -static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > +static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
> >  {
> > -	struct memcg_stock_pcp *stock;
> > -	struct mem_cgroup *memcg;
> > -
> > -	stock = &per_cpu(memcg_stock, cpu);
> > -	drain_stock(stock);
> > +	int nid;
> >  
> > -	for_each_mem_cgroup(memcg) {
> > +	for_each_node(nid) {
> > +		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
> > +		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0, };
>   			      				      ^^^^
> 							   Same here.
> 
> > +		struct batched_lruvec_stat *lstatc;
> >  		int i;
> >  
> > -		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> > -			int nid;
> > -
> > -			for_each_node(nid) {
> > -				struct batched_lruvec_stat *lstatc;
> > -				struct mem_cgroup_per_node *pn;
> > -				long x;
> > -
> > -				pn = memcg->nodeinfo[nid];
> > +		if (cpu == -1) {
> > +			int cpui;
> > +			/*
> > +			 * The memcg is about to be freed, collect all
> > +			 * CPUs, no need to zero anything out.
> > +			 */
> > +			for_each_online_cpu(cpui) {
> > +				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpui);
> > +				for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > +					stat[i] += lstatc->count[i];
> > +			}
> > +		} else {
> > +			/*
> > +			 * The CPU has gone away, collect and zero out
> > +			 * its stats, it may come back later.
> > +			 */
> > +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
> >  				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
> > -
> > -				x = lstatc->count[i];
> > +				stat[i] = lstatc->count[i];
> >  				lstatc->count[i] = 0;
> > -
> > -				if (x) {
> > -					do {
> > -						atomic_long_add(x, &pn->lruvec_stat[i]);
> > -					} while ((pn = parent_nodeinfo(pn, nid)));
> > -				}
> >  			}
> >  		}
> > +
> > +		do {
> > +			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > +				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
> > +		} while ((pn = parent_nodeinfo(pn, nid)));
> >  	}
> > +}
> > +
> > +static int memcg_hotplug_cpu_dead(unsigned int cpu)
> > +{
> > +	struct memcg_stock_pcp *stock;
> > +	struct mem_cgroup *memcg;
> > +
> > +	stock = &per_cpu(memcg_stock, cpu);
> > +	drain_stock(stock);
> > +
> > +	for_each_mem_cgroup(memcg)
> > +		memcg_flush_lruvec_page_state(memcg, cpu);
> >  
> >  	return 0;
> >  }
> > @@ -3636,27 +3653,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
> >  	}
> >  }
> >  
> > -static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
> > -{
> > -	int node;
> > -
> > -	for_each_node(node) {
> > -		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
> > -		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
> > -		struct mem_cgroup_per_node *pi;
> > -		int cpu, i;
> > -
> > -		for_each_online_cpu(cpu)
> > -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > -				stat[i] += per_cpu(
> > -					pn->lruvec_stat_cpu->count[i], cpu);
> > -
> > -		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
> > -			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
> > -				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
> > -	}
> > -}
> > -
> >  #ifdef CONFIG_MEMCG_KMEM
> >  static int memcg_online_kmem(struct mem_cgroup *memcg)
> >  {
> > @@ -5197,7 +5193,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
> >  	 * Flush percpu lruvec stats to guarantee the value
> >  	 * correctness on parent's and all ancestor levels.
> >  	 */
> > -	memcg_flush_lruvec_page_state(memcg);
> > +	memcg_flush_lruvec_page_state(memcg, -1);
> 
> I wonder if adding "cpu" or "percpu" into the function name will make clearer what -1 means?
> E.g. memcg_flush_(per)cpu_lruvec_stats(memcg, -1).

Yes, it's a bit ominous. I changed it to

	memcg_flush_lruvec_page_state_cpu(memcg, -1);

percpu would have pushed the function signature over 80 characters.

> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks
