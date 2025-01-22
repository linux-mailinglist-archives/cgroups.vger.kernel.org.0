Return-Path: <cgroups+bounces-6245-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3A4A19736
	for <lists+cgroups@lfdr.de>; Wed, 22 Jan 2025 18:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE161160470
	for <lists+cgroups@lfdr.de>; Wed, 22 Jan 2025 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5C621516D;
	Wed, 22 Jan 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHmowr/Q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A21369B4;
	Wed, 22 Jan 2025 17:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737565880; cv=none; b=NS/h3zwEL3hfhke6LPt8THbNcUg5tfwVc/V2OVJwHdlrDwCVnJYOF60BGIEavRFVTNn+6waHPMih2I4xNTSF+UkIHBX5yLjFW9NEN3FFxaD4qmUmavjaWaaMOzTPbt7gbr5qdnItqG73io0qmf+fM6H5LjBbcj7pzDz9H364xFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737565880; c=relaxed/simple;
	bh=vrOcVfrtnQTE4mLP1ckCne1X0XXALsHqOEb6+eSyEdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hziysGee4DVCT/ZnNl+UrQ8jbTz7Y5soBW33krWCRe1FZn2bWOEqd/DbvNzwDkTCfkAPU5hjZrP8hqXQOH+zmsOpoAnm1rmYWIhKf96Lj4UdCTAWadKVtSAb7+8WKw+MMHgK5TH4MGrkYAHWALmKqwXnpsOYMkg88tlgzffaqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHmowr/Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5466AC4CED6;
	Wed, 22 Jan 2025 17:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565879;
	bh=vrOcVfrtnQTE4mLP1ckCne1X0XXALsHqOEb6+eSyEdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHmowr/QACR71pMgPQ+3ISG6Ptx3ISzssy7g1oPZws6K0Pk/tjVcWSHQ4deN5QZHW
	 2VLLZ9zNLhXtuegmHBBpwubGCSDh8xWkQqxP95HU0ktUyq+T/HwNkDyvioIe/55c8W
	 6ZkfBw73pnF4ANBNf3cdOwt+ggdUFeXfjju4wrH3lEOpTF30hSQc/3FXGt29hyM7X2
	 Ohq80MByU6xrJI/q3q2/Jdp5mcrWb53oXYKpe7qmgLKM3GdJHpHQsEPurS+oZ2lJeL
	 QkIchdZB4fuPtABT340CxZ0dfFGnPLti5HKvMIXOkZ1WO1zP3Cvv6/srPWiqd/RgPU
	 OOPaoweC0YShw==
Date: Wed, 22 Jan 2025 18:11:16 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chen Yu <yu.c.chen@intel.com>, Kees Cook <kees@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v1] Add kthreads_update_affinity()
Message-ID: <Z5EmtNh_lryVj0S3@localhost.localdomain>
References: <20250113190911.800623-1-costa.shul@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250113190911.800623-1-costa.shul@redhat.com>

Hi Costa,

Le Mon, Jan 13, 2025 at 09:08:54PM +0200, Costa Shulyupin a écrit :
> Changing and using housekeeping and isolated CPUs requires reboot.
> 
> The goal is to change CPU isolation dynamically without reboot.
> 
> This patch is based on the parent patch
> cgroup/cpuset: Exclude isolated CPUs from housekeeping CPU masks
> https://lore.kernel.org/lkml/20240821142312.236970-3-longman@redhat.com/
> Its purpose is to update isolation cpumasks.
> 
> However, some subsystems may use outdated housekeeping CPU masks. To
> prevent the use of these isolated CPUs, it is essential to explicitly
> propagate updates to the housekeeping masks across all subsystems that
> depend on them.
> 
> This patch is not intended to be merged and disrupt the kernel.
> It is still a proof-of-concept for research purposes.
> 
> The questions are:
> - Is this the right direction, or should I explore an alternative approach?
> - What factors need to be considered?
> - Any suggestions or advice?
> - Have similar attempts been made before?

Since the kthreads preferred affinity patchset just got merged,
I don't think anything needs to be done anymore in the kthreads front to toggle
nohz_full through cpusets safely. Let's see the details below:

> 
> Update the affinity of kthreadd and trigger the recalculation of kthread
> affinities using kthreads_online_cpu().
> 
> The argument passed to kthreads_online_cpu() is irrelevant, as the
> function reassigns affinities of kthreads based on their
> preferred_affinity and the updated housekeeping_cpumask(HK_TYPE_KTHREAD).
> 
> Currently only RCU uses kthread_affine_preferred().
> 
> I dare to try calling kthread_affine_preferred() from kthread_run() to
> set preferred_affinity as cpu_possible_mask for kthreads without a
> specific affinity, enabling their management through
> kthreads_online_cpu().
> 
> Any objections?
> 
> For details about kthreads affinity patterns please see:
> https://lore.kernel.org/lkml/20241211154035.75565-16-frederic@kernel.org/
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  include/linux/kthread.h | 5 ++++-
>  kernel/cgroup/cpuset.c  | 1 +
>  kernel/kthread.c        | 6 ++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/kthread.h b/include/linux/kthread.h
> index 8d27403888ce9..b43c5aeb2cfd7 100644
> --- a/include/linux/kthread.h
> +++ b/include/linux/kthread.h
> @@ -52,8 +52,10 @@ bool kthread_is_per_cpu(struct task_struct *k);
>  ({									   \
>  	struct task_struct *__k						   \
>  		= kthread_create(threadfn, data, namefmt, ## __VA_ARGS__); \
> -	if (!IS_ERR(__k))						   \
> +	if (!IS_ERR(__k)) {						   \
> +		kthread_affine_preferred(__k, cpu_possible_mask);	   \
>  		wake_up_process(__k);					   \
> +	}								   \
>  	__k;								   \
>  })
>  
> @@ -270,4 +272,5 @@ struct cgroup_subsys_state *kthread_blkcg(void);
>  #else
>  static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
>  #endif
> +void kthreads_update_affinity(void);
>  #endif /* _LINUX_KTHREAD_H */
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 65658a5c2ac81..7d71acc7f46b6 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1355,6 +1355,7 @@ static void update_isolation_cpumasks(bool isolcpus_updated)
>  	trl();
>  	ret = housekeeping_exlude_isolcpus(isolated_cpus, HOUSEKEEPING_FLAGS);
>  	WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
> +	kthreads_update_affinity();

A few things to consider:

1) update_isolation_cpumasks() will be called with cpus_read_lock()
  (cf: sched_partition_write() and cpuset_write_resmask()), therefore
  kthreads_online_cpu() can't run concurrently.

2) The constraint to turn on/off a CPU as nohz_full will be that the
   target CPU is offline.

So when the target CPU will later become offline, kthreads_online_cpu()
will take care of the newly modified housekeeping_mask() (which will be visible
because cpus_write_lock() is held) and apply accordingly the appropriate
effective affinity.

The only thing that might need to be done by update_isolation_cpumasks() is
to hold kthreads_hotplug_lock so that a subsequent call to
kthread_affine_preferred() sees the "freshest" update to housekeeping_mask().
But even that may not be mandatory because the concerned CPUs are offline
and kthreads_online_cpu() will fix the race when they boot.

Oh and the special case kthreadd might need a direct affinity update.

So the good news is that we have a lot of things sorted out to prepare
for that cpuset interface:

_ RCU NOCB is ready
_ kthreads are ready
_ timers are fine since we toggle only offline CPUs and timer_migration.c
  should work without changes.

Still some details need to be taken care of:

* scheduler (see the housekeeping_mask() references, especially the ilb which is
  my biggest worry, get_nohz_timer_target() shouldn't be an issue)
  
* posix cpu timers (make tick_dep unconditional ?)

* kernel/watchdog.c (make proc_watchdog_cpumask() and
  lockup_detector_online_cpu() safe against update_isolation_cpumasks()
  
* workqueue unbound mask (just apply the new one?)

* some RCU tick_dep to handle (make them unconditional since they
  apply on slow path anyway?)
  
* other things? (grep for tick_nohz_full_cpu(), housekeeping_* and tick_dep_* )

But we are getting closer!

Thanks!

