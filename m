Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D99168AA30
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 14:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbjBDNdZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Feb 2023 08:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbjBDNcw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Feb 2023 08:32:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4574037B53;
        Sat,  4 Feb 2023 05:32:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B5E960C48;
        Sat,  4 Feb 2023 13:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E65EC433EF;
        Sat,  4 Feb 2023 13:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675517527;
        bh=17CiUO1UyH6W1fq26d58HeXspJzNDH/jlO4gOkRWLxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pAshbA9Kxu11NsZWAHcPgX4M81vjwvWvjlOsFBKTTgm6t5ytBUfXYKncFaiFCJ/LT
         bWZAxr+ZKPHYD0ZnjwkPSJmPIMK8XE0ghH0fzzT8tsYyeiNYD9ColrdVyYgEVNcl/b
         p1ntsspsMjXQgXdyXf3DCPgjXiyn51cNTBnp6AqS3LbnshfZW6zncbWRuKbKqa1+wD
         BKNlgttmpN9emS2hdJoLFIEfEQBYbAi1hi/sC5MpOETAyy+BkJYYWazAI0x092zMAo
         auzfyuhrUss5HYsLYzj2EOUotHpiuBCRY32StsXuad0ipBlnaYZGOcIgeijHfIIzf9
         ODG5ZXlyWY61A==
Date:   Sat, 4 Feb 2023 13:32:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Message-ID: <20230204133201.GA7765@willie-the-truck>
References: <20230203164040.213437-1-longman@redhat.com>
 <Y9116OLfP6GoZ0ez@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9116OLfP6GoZ0ez@slm.duckdns.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 11:00:24AM -1000, Tejun Heo wrote:
> On Fri, Feb 03, 2023 at 11:40:40AM -0500, Waiman Long wrote:
> > Since commit 8f9ea86fdf99 ("sched: Always preserve the user
> > requested cpumask"), relax_compatible_cpus_allowed_ptr() is calling
> > __sched_setaffinity() unconditionally. This helps to expose a bug in
> > the current cpuset hotplug code where the cpumasks of the tasks in
> > the top cpuset are not updated at all when some CPUs become online or
> > offline. It is likely caused by the fact that some of the tasks in the
> > top cpuset, like percpu kthreads, cannot have their cpu affinity changed.
> > 
> > One way to reproduce this as suggested by Peter is:
> >  - boot machine
> >  - offline all CPUs except one
> >  - taskset -p ffffffff $$
> >  - online all CPUs
> > 
> > Fix this by allowing cpuset_cpus_allowed() to return a wider mask that
> > includes offline CPUs for those tasks that are in the top cpuset. For
> > tasks not in the top cpuset, the old rule applies and only online CPUs
> > will be returned in the mask since hotplug events will update their
> > cpumasks accordingly.
> > 
> > Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> > Reported-by: Will Deacon <will@kernel.org>
> > Originally-from: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Waiman Long <longman@redhat.com>
> 
> So, this is the replacement for the first patch[1] Will posted, right?
> 
> >  void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> >  {
> >  	unsigned long flags;
> > +	struct cpuset *cs;
> >  
> >  	spin_lock_irqsave(&callback_lock, flags);
> > -	guarantee_online_cpus(tsk, pmask);
> > +	rcu_read_lock();
> > +
> > +	cs = task_cs(tsk);
> > +	if (cs != &top_cpuset)
> > +		guarantee_online_cpus(tsk, pmask);
> > +	/*
> > +	 * TODO: Tasks in the top cpuset won't get update to their cpumasks
> > +	 * when a hotplug online/offline event happens. So we include all
> > +	 * offline cpus in the allowed cpu list.
> > +	 */
> > +	if ((cs == &top_cpuset) || cpumask_empty(pmask)) {
> > +		const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> > +
> > +		/*
> > +		 * We first exclude cpus allocated to partitions. If there is no
> > +		 * allowable online cpu left, we fall back to all possible cpus.
> > +		 */
> > +		cpumask_andnot(pmask, possible_mask, top_cpuset.subparts_cpus);
> 
> and the differences are that
> 
> * It's only applied to the root cgroup.
> 
> * Cpus taken up by partitions are excluded.
> 
> Is my understanding correct?
> 
> > +		if (!cpumask_intersects(pmask, cpu_online_mask))
> > +			cpumask_copy(pmask, possible_mask);
> > +	}
> > +
> > +	rcu_read_unlock();
> >  	spin_unlock_irqrestore(&callback_lock, flags);
> 
> So, I suppose you're suggesting applying this patch instead of the one Will
> Deacon posted[1] and we need Will's second patch[2] on top, right?
> 
> [1] http://lkml.kernel.org/r/20230131221719.3176-3-will@kernel.org
> [2] http://lkml.kernel.org/r/20230131221719.3176-3-will@kernel.org

FWIW, although I tend to share Peter's sentiments in this thread, I took
this (+ my second patch) for a spin and my tests are giving the same
results when compared with Peter's patch.

Tested-by: Will Deacon <will@kernel.org>

Will
