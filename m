Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247EE68A94A
	for <lists+cgroups@lfdr.de>; Sat,  4 Feb 2023 11:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjBDKBl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 4 Feb 2023 05:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBDKBj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 4 Feb 2023 05:01:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408955FF5;
        Sat,  4 Feb 2023 02:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1CILfoEi2sLKOY/pCvvQ82YwMOdadBhYba5yUkzOQF4=; b=ZJpSGJ2Gm7UKIQyW7E+HUvnADc
        Y0cBs4LCGAakZUibVz2HRJJXcHWFFbZqobqrG9ZvNbMxE/mp40jOFj72+zfb2mCIzezK2tdFCvjcr
        KifjCmqGtgCm7yhZrJTy7ICh16810d7c3BVP1v34SUi718dAz3QPVzuoDD/dGCpOtClfuveM4Ebe8
        MERsMl7a04e5L2cBJN8jPgcnfOImMseg6e9d+aEfpl4ovLwChRxraRssx/KP0hdEvBUyhblK2qtwv
        eayZoOGpY9u7koRpkx5HLi7+cudW+1FAXiZd/wqklwz08N58MF5gykplMguJR4OoWJt56fDAJxWw6
        0+TntN9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pOFMJ-00F5N8-0U; Sat, 04 Feb 2023 10:01:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AF85D30068D;
        Sat,  4 Feb 2023 11:01:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 98BEF2C7FDC52; Sat,  4 Feb 2023 11:01:22 +0100 (CET)
Date:   Sat, 4 Feb 2023 11:01:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] cgroup/cpuset: Don't filter offline CPUs in
 cpuset_cpus_allowed() for top cpuset tasks
Message-ID: <Y94s8mzrE9VyUJLa@hirez.programming.kicks-ass.net>
References: <20230203164040.213437-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203164040.213437-1-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 11:40:40AM -0500, Waiman Long wrote:
> Since commit 8f9ea86fdf99 ("sched: Always preserve the user
> requested cpumask"), relax_compatible_cpus_allowed_ptr() is calling
> __sched_setaffinity() unconditionally. This helps to expose a bug in
> the current cpuset hotplug code where the cpumasks of the tasks in
> the top cpuset are not updated at all when some CPUs become online or
> offline. It is likely caused by the fact that some of the tasks in the
> top cpuset, like percpu kthreads, cannot have their cpu affinity changed.
> 
> One way to reproduce this as suggested by Peter is:
>  - boot machine
>  - offline all CPUs except one
>  - taskset -p ffffffff $$
>  - online all CPUs
> 
> Fix this by allowing cpuset_cpus_allowed() to return a wider mask that
> includes offline CPUs for those tasks that are in the top cpuset. For
> tasks not in the top cpuset, the old rule applies and only online CPUs
> will be returned in the mask since hotplug events will update their
> cpumasks accordingly.

So you get the task_cpu_possible_mask() interaction vs cpusets horribly
wrong here, but given the very sorry state of task_cpu_possible_mask()
correctness of cpuset as a whole that might just not matter at this
point.

I do very much hate how you add exceptions on exceptions instead of
looking to do something right :-(

Fixing that parition case in my patch is 1 extra line and then I think
it fundamentally does the right thing and can serve as a basis for
fixing cpuset as a whole.

> Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> Reported-by: Will Deacon <will@kernel.org>
> Originally-from: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/cgroup/cpuset.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 207bafdb05e8..11554e5845f7 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3707,15 +3707,38 @@ void __init cpuset_init_smp(void)
>   * Description: Returns the cpumask_var_t cpus_allowed of the cpuset
>   * attached to the specified @tsk.  Guaranteed to return some non-empty
>   * subset of cpu_online_mask, even if this means going outside the
> - * tasks cpuset.
> + * tasks cpuset, except when the task is in the top cpuset.
>   **/
>  
>  void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>  {
>  	unsigned long flags;
> +	struct cpuset *cs;
>  
>  	spin_lock_irqsave(&callback_lock, flags);
> -	guarantee_online_cpus(tsk, pmask);
> +	rcu_read_lock();
> +
> +	cs = task_cs(tsk);
> +	if (cs != &top_cpuset)
> +		guarantee_online_cpus(tsk, pmask);
> +	/*
> +	 * TODO: Tasks in the top cpuset won't get update to their cpumasks
> +	 * when a hotplug online/offline event happens. So we include all
> +	 * offline cpus in the allowed cpu list.
> +	 */

I don't like TODO there, I really don't think CPUSET should update root
tasks, that means yet another fundamental difference between
CPUSET={y,n}.

> +	if ((cs == &top_cpuset) || cpumask_empty(pmask)) {
> +		const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
> +		/*
> +		 * We first exclude cpus allocated to partitions. If there is no
> +		 * allowable online cpu left, we fall back to all possible cpus.
> +		 */
> +		cpumask_andnot(pmask, possible_mask, top_cpuset.subparts_cpus);
> +		if (!cpumask_intersects(pmask, cpu_online_mask))
> +			cpumask_copy(pmask, possible_mask);
> +	}
> +
> +	rcu_read_unlock();
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  }

I really detest this patch, but if you insist it might just do :-/
