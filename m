Return-Path: <cgroups+bounces-6735-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1982AA48C08
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 23:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0193E3AFD00
	for <lists+cgroups@lfdr.de>; Thu, 27 Feb 2025 22:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6B921CC53;
	Thu, 27 Feb 2025 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EO4zcRQG"
X-Original-To: cgroups@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE80727781F
	for <cgroups@vger.kernel.org>; Thu, 27 Feb 2025 22:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740696761; cv=none; b=NGioZfuCA162z/yuBywrwrVbWAlehntMA2Ix7AmQa8e7sK8BhpJENaywDml7JQwZwTvtMZcT/d3TmmMOUjQc2qL1nnnvzHz6+/IIMRkw6ZSj4saT2WoVoAdToZfBqQt+eGGx9+g5FjTFlT2ll1gVSoDt7weOtFvwImAw/60x/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740696761; c=relaxed/simple;
	bh=t2iOk5LkYcPiE7IzzCiojMgEbgqomiH4PuLl/6mjmoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSXA5GviuZALvU6TVJv5t6ouY2tbA/FMfR+hfXKuLspe4Sdaf/BXAbxK5PT8CFDeH6PhTMNOtQRfFAjN/wGSfoiJwjbvVI0+LDVmS9SVZAAUg3joOfUW52bzVJnAi/JFiqDHC925b2eJvo3eQK3TaF2190wCdnzHXtqq82awATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EO4zcRQG; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 14:52:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740696756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EzrrEOdP7tby5qwkwQSlCjJg0w9qK7j+XV3Tszu1ts4=;
	b=EO4zcRQGRiF4DR9jSr+DaXP5BduNdf1oWUCGZrJAl8B4N5YWdzB/PrwT+/psRK4yzhPau9
	V7PWgDIWQ9EGd20xNxRDz4ux/WF8I81fuAF+XcWRdUCy0RuzWVfJAt+wDD8x6E/tAOCt4g
	rRZVBofg6Idn3uUpmoI2dNmt1gxqfxw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: inwardvessel <inwardvessel@gmail.com>
Cc: tj@kernel.org, yosryahmed@google.com, mhocko@kernel.org, 
	hannes@cmpxchg.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 3/4 v2] cgroup: separate rstat locks for subsystems
Message-ID: <wr4gupwwb3dinb6wanadgbitpowa4ffvmsei4r7riq6ialpp3k@kebmsx62a4op>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <20250227215543.49928-4-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227215543.49928-4-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:55:42PM -0800, inwardvessel wrote:
> From: JP Kobryn <inwardvessel@gmail.com>
> 
> Let the existing locks be dedicated to the base stats and rename them as
> such. Also add new rstat locks for each enabled subsystem. When handling
> cgroup subsystem states, distinguish between formal subsystems (memory,
> io, etc) and the base stats subsystem state (represented by
> cgroup::self) to decide on which locks to take. This change is made to
> prevent contention between subsystems when updating/flushing stats.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>

Couple of nits below otherwise:

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

> ---
>  kernel/cgroup/rstat.c | 93 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 72 insertions(+), 21 deletions(-)
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 88908ef9212d..b3eaefc1fd07 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -9,8 +9,12 @@
>  
>  #include <trace/events/cgroup.h>
>  
> -static DEFINE_SPINLOCK(cgroup_rstat_lock);
> -static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static DEFINE_SPINLOCK(cgroup_rstat_base_lock);
> +static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_base_cpu_lock);
> +
> +static spinlock_t cgroup_rstat_subsys_lock[CGROUP_SUBSYS_COUNT];
> +static DEFINE_PER_CPU(raw_spinlock_t,
> +		cgroup_rstat_subsys_cpu_lock[CGROUP_SUBSYS_COUNT]);
>  

The name of these locks are too long and you had to go multi-line.
Please just reduce the size of the names. These are local to this file,
so maybe you can drop cgroup_rstat_ from them or keep the rstat.

>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>  
> @@ -20,8 +24,13 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(
>  	return per_cpu_ptr(css->rstat_cpu, cpu);
>  }
>  
> +static inline bool is_base_css(struct cgroup_subsys_state *css)
> +{
> +	return css->ss == NULL;
> +}
> +
>  /*
> - * Helper functions for rstat per CPU lock (cgroup_rstat_cpu_lock).
> + * Helper functions for rstat per CPU locks.
>   *
>   * This makes it easier to diagnose locking issues and contention in
>   * production environments. The parameter @fast_path determine the
> @@ -36,12 +45,12 @@ unsigned long _cgroup_rstat_cpu_lock(raw_spinlock_t *cpu_lock, int cpu,
>  	bool contended;
>  
>  	/*
> -	 * The _irqsave() is needed because cgroup_rstat_lock is
> -	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring
> -	 * this lock with the _irq() suffix only disables interrupts on
> -	 * a non-PREEMPT_RT kernel. The raw_spinlock_t below disables
> -	 * interrupts on both configurations. The _irqsave() ensures
> -	 * that interrupts are always disabled and later restored.
> +	 * The _irqsave() is needed because the locks used for flushing are
> +	 * spinlock_t which is a sleeping lock on PREEMPT_RT. Acquiring this lock
> +	 * with the _irq() suffix only disables interrupts on a non-PREEMPT_RT
> +	 * kernel. The raw_spinlock_t below disables interrupts on both
> +	 * configurations. The _irqsave() ensures that interrupts are always
> +	 * disabled and later restored.
>  	 */
>  	contended = !raw_spin_trylock_irqsave(cpu_lock, flags);
>  	if (contended) {
> @@ -87,7 +96,7 @@ __bpf_kfunc void cgroup_rstat_updated(
>  		struct cgroup_subsys_state *css, int cpu)
>  {
>  	struct cgroup *cgrp = css->cgroup;
> -	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
> +	raw_spinlock_t *cpu_lock;
>  	unsigned long flags;
>  
>  	/*
> @@ -101,6 +110,12 @@ __bpf_kfunc void cgroup_rstat_updated(
>  	if (data_race(cgroup_rstat_cpu(css, cpu)->updated_next))
>  		return;
>  
> +	if (is_base_css(css))
> +		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
> +	else
> +		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
> +			css->ss->id;

Use the array index here like cgroup_rstat_subsys_cpu_lock[css->ss->id].

> +
>  	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, true);
>  
>  	/* put @css and all ancestors on the corresponding updated lists */
> @@ -208,11 +223,17 @@ static struct cgroup_subsys_state *cgroup_rstat_updated_list(
>  		struct cgroup_subsys_state *root, int cpu)
>  {
>  	struct cgroup *cgrp = root->cgroup;
> -	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>  	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(root, cpu);
>  	struct cgroup_subsys_state *head = NULL, *parent, *child;
> +	raw_spinlock_t *cpu_lock;
>  	unsigned long flags;
>  
> +	if (is_base_css(root))
> +		cpu_lock = per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu);
> +	else
> +		cpu_lock = per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) +
> +			root->ss->id;

Same here.

> +
>  	flags = _cgroup_rstat_cpu_lock(cpu_lock, cpu, cgrp, false);
>  
>  	/* Return NULL if this subtree is not on-list */
> @@ -315,7 +336,7 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
>  	struct cgroup *cgrp = css->cgroup;
>  	int cpu;
>  
> -	lockdep_assert_held(&cgroup_rstat_lock);
> +	lockdep_assert_held(&lock);
>  
>  	for_each_possible_cpu(cpu) {
>  		struct cgroup_subsys_state *pos;
> @@ -356,12 +377,18 @@ static void cgroup_rstat_flush_locked(struct cgroup_subsys_state *css,
>  __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
>  {
>  	struct cgroup *cgrp = css->cgroup;
> +	spinlock_t *lock;
> +
> +	if (is_base_css(css))
> +		lock = &cgroup_rstat_base_lock;
> +	else
> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
>  
>  	might_sleep();
>  
> -	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
> -	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
> -	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
> +	__cgroup_rstat_lock(lock, cgrp, -1);
> +	cgroup_rstat_flush_locked(css, lock);
> +	__cgroup_rstat_unlock(lock, cgrp, -1);
>  }
>  
>  /**
> @@ -376,10 +403,16 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup_subsys_state *css)
>  void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
>  {
>  	struct cgroup *cgrp = css->cgroup;
> +	spinlock_t *lock;
> +
> +	if (is_base_css(css))
> +		lock = &cgroup_rstat_base_lock;
> +	else
> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
>  
>  	might_sleep();
> -	__cgroup_rstat_lock(&cgroup_rstat_lock, cgrp, -1);
> -	cgroup_rstat_flush_locked(css, &cgroup_rstat_lock);
> +	__cgroup_rstat_lock(lock, cgrp, -1);
> +	cgroup_rstat_flush_locked(css, lock);
>  }
>  
>  /**
> @@ -389,7 +422,14 @@ void cgroup_rstat_flush_hold(struct cgroup_subsys_state *css)
>  void cgroup_rstat_flush_release(struct cgroup_subsys_state *css)
>  {
>  	struct cgroup *cgrp = css->cgroup;
> -	__cgroup_rstat_unlock(&cgroup_rstat_lock, cgrp, -1);
> +	spinlock_t *lock;
> +
> +	if (is_base_css(css))
> +		lock = &cgroup_rstat_base_lock;
> +	else
> +		lock = &cgroup_rstat_subsys_lock[css->ss->id];
> +
> +	__cgroup_rstat_unlock(lock, cgrp, -1);
>  }
>  
>  int cgroup_rstat_init(struct cgroup_subsys_state *css)
> @@ -435,10 +475,21 @@ void cgroup_rstat_exit(struct cgroup_subsys_state *css)
>  
>  void __init cgroup_rstat_boot(void)
>  {
> -	int cpu;
> +	struct cgroup_subsys *ss;
> +	int cpu, ssid;
>  
> -	for_each_possible_cpu(cpu)
> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> +	for_each_subsys(ss, ssid) {
> +		spin_lock_init(&cgroup_rstat_subsys_lock[ssid]);
> +	}
> +
> +	for_each_possible_cpu(cpu) {
> +		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_base_cpu_lock, cpu));
> +
> +		for_each_subsys(ss, ssid) {
> +			raw_spin_lock_init(
> +					per_cpu_ptr(cgroup_rstat_subsys_cpu_lock, cpu) + ssid);

Same here.

> +		}
> +	}
>  }
>  
>  /*
> -- 
> 2.43.5
> 

