Return-Path: <cgroups+bounces-7719-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0BAA96DD2
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 16:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DE1886FB9
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 14:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CCC27C158;
	Tue, 22 Apr 2025 14:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QBRFHDv1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF2283CA2
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330485; cv=none; b=UtXVj1UReXOWUjHvHj6i1hilDLUPmPrpglsP5autNefIw6T31nybnMu+zt6ZNDs32YNXPMhQuTnhOgmIIANFZ3ly6j1/aL5ETTtSZa71MtdYwQ0We1bnGI8yoPOyEPfhTgm7Kg6OYmcQMGccdPJVPbNxwAe7pOylBsFV1xEeREg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330485; c=relaxed/simple;
	bh=EUtVRZlknL+jkCp/Gy5Lt/cTLRVdSo6k3i4SLY6MZVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks27nc1JkkwvTHKPw1ibPpPgRJQG07LTiFmjBKYIWuvZvsC+bjtBGCoN0msLqnBGi7OpsNK/4DbRA8qNvMlGoYdZdsXiXLc3N60/fmGpzgZmr26FmLJQtpkoCt2Uo/55OTHbgNCdNLR68ZrrTJfiNPiduXO+FbGHNBnax10q5vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QBRFHDv1; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Apr 2025 07:01:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745330480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KZiyAKGmgRNuRBsZBpRX/xVMhFS+3p/30Wi1DCLvGIo=;
	b=QBRFHDv1EvPS1zuu6ArnOt8XsHWRYR3F8ozD+tjUPysKe5ofjqULjfrAJKg2qxBmlIHq3Q
	16+1tmHmJU9+znGcrRm1Z+G+p0nbgd8qdOvFgDh7VdhJBjeHqh2Sad9ZFxFZBEaBfCqzqV
	KCFEl/TZJIsbTdHKRdoNjok+Sfwq6fE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com,
	mkoutny@suse.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 5/5] cgroup: use subsystem-specific rstat locks to
 avoid contention
Message-ID: <aAehK23MNX1FsRjF@Asmaa.>
References: <20250404011050.121777-1-inwardvessel@gmail.com>
 <20250404011050.121777-6-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404011050.121777-6-inwardvessel@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 03, 2025 at 06:10:50PM -0700, JP Kobryn wrote:
> It is possible to eliminate contention between subsystems when
> updating/flushing stats by using subsystem-specific locks. Let the existing
> rstat locks be dedicated to the cgroup base stats and rename them to
> reflect that. Add similar locks to the cgroup_subsys struct for use with
> individual subsystems.
> 
> Lock initialization is done in the new function ss_rstat_init(ss) which
> replaces cgroup_rstat_boot(void). If NULL is passed to this function, the
> global base stat locks will be initialized. Otherwise, the subsystem locks
> will be initialized.
> 
> Change the existing lock helper functions to accept a reference to a css.
> Then within these functions, conditionally select the appropriate locks
> based on the subsystem affiliation of the given css. Add helper functions
> for this selection routine to avoid repeated code.
> 
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---
>  block/blk-cgroup.c              |   2 +-
>  include/linux/cgroup-defs.h     |  16 +++--
>  include/trace/events/cgroup.h   |  12 +++-
>  kernel/cgroup/cgroup-internal.h |   2 +-
>  kernel/cgroup/cgroup.c          |  10 +++-
>  kernel/cgroup/rstat.c           | 101 +++++++++++++++++++++++---------
>  6 files changed, 103 insertions(+), 40 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 0560ea402856..62d0bf1e1a04 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1074,7 +1074,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
>  	/*
>  	 * For covering concurrent parent blkg update from blkg_release().
>  	 *
> -	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
> +	 * When flushing from cgroup, the subsystem lock is always held, so
>  	 * this lock won't cause contention most of time.
>  	 */
>  	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index c58c21c2110a..bb5a355524d6 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -223,7 +223,10 @@ struct cgroup_subsys_state {
>  	/*
>  	 * A singly-linked list of css structures to be rstat flushed.
>  	 * This is a scratch field to be used exclusively by
> -	 * css_rstat_flush_locked() and protected by cgroup_rstat_lock.
> +	 * css_rstat_flush_locked().
> +	 *
> +	 * Protected by rstat_base_lock when css is cgroup::self.
> +	 * Protected by css->ss->rstat_ss_lock otherwise.
>  	 */
>  	struct cgroup_subsys_state *rstat_flush_next;
>  };
> @@ -359,11 +362,11 @@ struct css_rstat_cpu {
>  	 * are linked on the parent's ->updated_children through
>  	 * ->updated_next.
>  	 *
> -	 * In addition to being more compact, singly-linked list pointing
> -	 * to the cgroup makes it unnecessary for each per-cpu struct to
> -	 * point back to the associated cgroup.
> +	 * In addition to being more compact, singly-linked list pointing to
> +	 * the css makes it unnecessary for each per-cpu struct to point back
> +	 * to the associated css.
>  	 *
> -	 * Protected by per-cpu cgroup_rstat_cpu_lock.
> +	 * Protected by per-cpu css->ss->rstat_ss_cpu_lock.
>  	 */
>  	struct cgroup_subsys_state *updated_children;	/* terminated by self cgroup */

This rename belongs in the previous patch, also the comment about
updated_children should probably say "self css" now.

>  	struct cgroup_subsys_state *updated_next;	/* NULL iff not on the list */
> @@ -793,6 +796,9 @@ struct cgroup_subsys {
>  	 * specifies the mask of subsystems that this one depends on.
>  	 */
>  	unsigned int depends_on;
> +
> +	spinlock_t rstat_ss_lock;
> +	raw_spinlock_t __percpu *rstat_ss_cpu_lock;

Can we use local_lock_t here instead? I guess it would be annoying
because we won't be able to have common code for locking/unlocking. It's
annoying because the local lock is a spinlock under the hood for non-RT
kernels anyway..

>  };
>  
>  extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
[..]
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 37d9e5012b2d..bcc253aec774 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -9,8 +9,8 @@
>  
>  #include <trace/events/cgroup.h>
>  
> -static DEFINE_SPINLOCK(cgroup_rstat_lock);
> -static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static DEFINE_SPINLOCK(rstat_base_lock);
> +static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock);

Can we do something like this (not sure the macro usage is correct):

static DEFINE_PER_CPU(raw_spinlock_t, rstat_base_cpu_lock) = __SPIN_LOCK_UNLOCKED(rstat_base_cpu_lock);

This should initialize the per-CPU spinlocks the same way
DEFINE_SPINLOCK does IIUC.

>  
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>  
[..]
> @@ -422,12 +443,36 @@ void css_rstat_exit(struct cgroup_subsys_state *css)
>  	css->rstat_cpu = NULL;
>  }
>  
> -void __init cgroup_rstat_boot(void)
> +/**
> + * ss_rstat_init - subsystem-specific rstat initialization
> + * @ss: target subsystem
> + *
> + * If @ss is NULL, the static locks associated with the base stats
> + * are initialized. If @ss is non-NULL, the subsystem-specific locks
> + * are initialized.
> + */
> +int __init ss_rstat_init(struct cgroup_subsys *ss)
>  {
>  	int cpu;
>  
> +	if (!ss) {
> +		spin_lock_init(&rstat_base_lock);

IIUC locks defined with DEFINE_SPINLOCK() do not need to be initialized,
and I believe we can achieve the same for the per-CPU locks as I
described above and eliminate this branch completely.

> +
> +		for_each_possible_cpu(cpu)
> +			raw_spin_lock_init(per_cpu_ptr(&rstat_base_cpu_lock, cpu));
> +
> +		return 0;
> +	}
> +
> +	spin_lock_init(&ss->rstat_ss_lock);
> +	ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
> +	if (!ss->rstat_ss_cpu_lock)
> +		return -ENOMEM;
> +
>  	for_each_possible_cpu(cpu)
> -		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> +		raw_spin_lock_init(per_cpu_ptr(ss->rstat_ss_cpu_lock, cpu));
> +
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.47.1
> 
> 

