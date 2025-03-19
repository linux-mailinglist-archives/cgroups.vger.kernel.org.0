Return-Path: <cgroups+bounces-7158-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B31A6962C
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 18:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752B1188892E
	for <lists+cgroups@lfdr.de>; Wed, 19 Mar 2025 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7851F09B0;
	Wed, 19 Mar 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vCsluCwr"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B693987D
	for <cgroups@vger.kernel.org>; Wed, 19 Mar 2025 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742404583; cv=none; b=cQ9a2kFqzeIcInP479aQTVKiWug8pn0wPn/brdnov0MrL/Q2gY2JoRjF+PNQlO74KLArwC2LBPuz9fBmzYbVBXk5rrEjse+z0LynT7B9coOOOURwVbU3S/fKhDWeerhYZl28i//YVBsfJf2o9sjTrT5r0TnHTTRMZ2DmjV/LtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742404583; c=relaxed/simple;
	bh=W89XYRa8gD+Q4lCE8HNh55XT/qwbdK9QbpP3sLHcgdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKo9Shj6ZfLZsdDCr5wmdKGG6dsN9DEWIhfd526Un981Sy1g/HME05/Xd8mK/BS5ybb4GhyMZgkErVXDbKuh0WqfpXX5mmFdfm5RCsy/S782jWoj3veNQxZaIyTK44JJl5Pc5ZjDgedCPQ9BwRAYiFzRq3Cx4NYgaLg2LD9cRd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vCsluCwr; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 19 Mar 2025 17:16:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742404568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/VcydtPIyQryEARYQuxcXq/5lnJ15R6BGejdmXYWpLo=;
	b=vCsluCwrMYQKurrUymPjNi+PWht0yf6WCq5C7Vpnx6eq26wk4iS/U0noV0cPjN+2qNNW7g
	9t9G4SCMxnIy1x0V4UpW1EP097/COthlpcxjgtgWvKE7mGhTMOZm60lD+93DPYt4wUTgwi
	F/RWkEzB2FHEfz0dO0TaIitQRsxi1YY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Greg Thelen <gthelen@google.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Dumazet <edumzaet@google.com>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <Z9r70jKJLPdHyihM@google.com>
References: <20250319071330.898763-1-gthelen@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319071330.898763-1-gthelen@google.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 19, 2025 at 12:13:30AM -0700, Greg Thelen wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> cgroup_rstat_flush_locked() grabs the irq safe cgroup_rstat_lock while
> iterating all possible cpus. It only drops the lock if there is
> scheduler or spin lock contention. If neither, then interrupts can be
> disabled for a long time. On large machines this can disable interrupts
> for a long enough time to drop network packets. On 400+ CPU machines
> I've seen interrupt disabled for over 40 msec.
> 
> Prevent rstat from disabling interrupts while processing all possible
> cpus. Instead drop and reacquire cgroup_rstat_lock for each cpu. This
> approach was previously discussed in
> https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/,
> though this was in the context of an non-irq rstat spin lock.
> 
> Benchmark this change with:
> 1) a single stat_reader process with 400 threads, each reading a test
>    memcg's memory.stat repeatedly for 10 seconds.
> 2) 400 memory hog processes running in the test memcg and repeatedly
>    charging memory until oom killed. Then they repeat charging and oom
>    killing.
> 
> v6.14-rc6 with CONFIG_IRQSOFF_TRACER with stat_reader and hogs, finds
> interrupts are disabled by rstat for 45341 usec:
>   #  => started at: _raw_spin_lock_irq
>   #  => ended at:   cgroup_rstat_flush
>   #
>   #
>   #                    _------=> CPU#
>   #                   / _-----=> irqs-off/BH-disabled
>   #                  | / _----=> need-resched
>   #                  || / _---=> hardirq/softirq
>   #                  ||| / _--=> preempt-depth
>   #                  |||| / _-=> migrate-disable
>   #                  ||||| /     delay
>   #  cmd     pid     |||||| time  |   caller
>   #     \   /        ||||||  \    |    /
>   stat_rea-96532    52d....    0us*: _raw_spin_lock_irq
>   stat_rea-96532    52d.... 45342us : cgroup_rstat_flush
>   stat_rea-96532    52d.... 45342us : tracer_hardirqs_on <-cgroup_rstat_flush
>   stat_rea-96532    52d.... 45343us : <stack trace>
>    => memcg1_stat_format
>    => memory_stat_format
>    => memory_stat_show
>    => seq_read_iter
>    => vfs_read
>    => ksys_read
>    => do_syscall_64
>    => entry_SYSCALL_64_after_hwframe
> 
> With this patch the CONFIG_IRQSOFF_TRACER doesn't find rstat to be the
> longest holder. The longest irqs-off holder has irqs disabled for
> 4142 usec, a huge reduction from previous 45341 usec rstat finding.
> 
> Running stat_reader memory.stat reader for 10 seconds:
> - without memory hogs: 9.84M accesses => 12.7M accesses
> -    with memory hogs: 9.46M accesses => 11.1M accesses
> The throughput of memory.stat access improves.
> 
> The mode of memory.stat access latency after grouping by of 2 buckets:
> - without memory hogs: 64 usec => 16 usec
> -    with memory hogs: 64 usec =>  8 usec
> The memory.stat latency improves.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Greg Thelen <gthelen@google.com>
> Tested-by: Greg Thelen <gthelen@google.com>
> ---
>  kernel/cgroup/rstat.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index aac91466279f..976c24b3671a 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -323,13 +323,11 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>  			rcu_read_unlock();
>  		}
>  
> -		/* play nice and yield if necessary */
> -		if (need_resched() || spin_needbreak(&cgroup_rstat_lock)) {
> -			__cgroup_rstat_unlock(cgrp, cpu);
> -			if (!cond_resched())
> -				cpu_relax();
> -			__cgroup_rstat_lock(cgrp, cpu);
> -		}
> +		/* play nice and avoid disabling interrupts for a long time */
> +		__cgroup_rstat_unlock(cgrp, cpu);
> +		if (!cond_resched())
> +			cpu_relax();
> +		__cgroup_rstat_lock(cgrp, cpu);

This patch looks good as-is, so feel free to add:

Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>

That being said I think we can do further cleanups here now. We should
probably inline cgroup_rstat_flush_locked() into cgroup_rstat_flush(),
and move the lock hold and release into the loop.
cgroup_rstat_flush_hold() can simply call cgroup_rstat_flush() then hold
the lock.

Something like this on top:

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 976c24b3671a7..4f4b8d22555d7 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -299,17 +299,29 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
-/* see cgroup_rstat_flush() */
-static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
-	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
+/**
+ * cgroup_rstat_flush - flush stats in @cgrp's subtree
+ * @cgrp: target cgroup
+ *
+ * Collect all per-cpu stats in @cgrp's subtree into the global counters
+ * and propagate them upwards.  After this function returns, all cgroups in
+ * the subtree have up-to-date ->stat.
+ *
+ * This also gets all cgroups in the subtree including @cgrp off the
+ * ->updated_children lists.
+ *
+ * This function may block.
+ */
+__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
 	int cpu;
 
-	lockdep_assert_held(&cgroup_rstat_lock);
-
+	might_sleep();
 	for_each_possible_cpu(cpu) {
 		struct cgroup *pos = cgroup_rstat_updated_list(cgrp, cpu);
 
+		/* Reacquire for every CPU to avoiding disabing IRQs too long */
+		__cgroup_rstat_lock(cgrp, cpu);
 		for (; pos; pos = pos->rstat_flush_next) {
 			struct cgroup_subsys_state *css;
 
@@ -322,37 +334,12 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 				css->ss->css_rstat_flush(css, cpu);
 			rcu_read_unlock();
 		}
-
-		/* play nice and avoid disabling interrupts for a long time */
 		__cgroup_rstat_unlock(cgrp, cpu);
 		if (!cond_resched())
 			cpu_relax();
-		__cgroup_rstat_lock(cgrp, cpu);
 	}
 }
 
-/**
- * cgroup_rstat_flush - flush stats in @cgrp's subtree
- * @cgrp: target cgroup
- *
- * Collect all per-cpu stats in @cgrp's subtree into the global counters
- * and propagate them upwards.  After this function returns, all cgroups in
- * the subtree have up-to-date ->stat.
- *
- * This also gets all cgroups in the subtree including @cgrp off the
- * ->updated_children lists.
- *
- * This function may block.
- */
-__bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
-{
-	might_sleep();
-
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
-}
-
 /**
  * cgroup_rstat_flush_hold - flush stats in @cgrp's subtree and hold
  * @cgrp: target cgroup
@@ -365,9 +352,8 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
-	might_sleep();
+	cgroup_rstat_flush(cgrp);
 	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
 }
 
 /**



