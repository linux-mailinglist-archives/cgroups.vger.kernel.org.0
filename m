Return-Path: <cgroups+bounces-11239-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AEBC13AD1
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 10:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0941A25FBF
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E502DF14A;
	Tue, 28 Oct 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CGNB3GBc"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0906C2D978C;
	Tue, 28 Oct 2025 09:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642221; cv=none; b=DdTff1ov4PgJEQpNYJu2G4H5+S+58XwEz9q4t6kQkyPxSeom/fQK5qLYZpzy7/HWEI41TLJ/4BfN4qfovRwzmoWaNwxDwYt0K/Rgq63HLNnYXqD8DPRCrukEqycY7UtnjxBs44znW8HxR8yhpHpln+odHI9V9qGgt8tuGv0f2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642221; c=relaxed/simple;
	bh=FYchjVqAMBQv9LBq46poc1KVyQCj9SBIi0pkPIA8Og4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rFX4Hrkoe8o4vkMLJOUqWL6Sii49fGjeDAS9dUGY4kQ6FZMj0+AIEJT5W211pL5HbPdkA7xhWq6EwyJLTo1yAQkb0y8mWA2pkDKD1m7a2CKcBiz8FmAtI3yeWYp2/UodXT6CCnrpmXue2C4mqs/gU9K8NfHmuihPY7Kn3+yqVNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CGNB3GBc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+9Ze56vyjrFGBBLikcAq8sc6beALo9Z6C9Ec7GUdfW4=; b=CGNB3GBcvuX2cPKZk+73pjOZX+
	QJKofhcWvyXNpepFZwC9YNGrYs+AzjkJX2Avt31iCqWoGx+ffgp43DbWt5D0zUKp+0mlknxdwlh6p
	F2+X/4gILWHSJL7jg5yYffwUl0BpaBJXkr7Hd9DzKOWlv5sSuXs5MiQQ64AKYrDPHwvU5aUqhB5Ob
	A5957Y+8KSfhPv0zh1Xh1gPqD6A60ZncX4t5rcoVD6YSrFnf+nzGusyCOtYW/A8e1F5v5GyjWO/Ft
	Xq6jR3jlZ7MjOE3yH0GqKv1TqDn1ux8ATJm0Y9MhRRCculYdQZsggQsvwHM7yg/eEJvtx+FsmL3rI
	ODQPG1KQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDfbw-00000009xri-12M5;
	Tue, 28 Oct 2025 09:03:25 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 47151300289; Tue, 28 Oct 2025 10:03:24 +0100 (CET)
Date: Tue, 28 Oct 2025 10:03:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kernel test robot <oliver.sang@intel.com>, japo@linux.ibm.com
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	x86@kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	cgroups@vger.kernel.org, aubrey.li@linux.intel.com,
	yu.c.chen@intel.com
Subject: Re: [tip:sched/core] [sched]  b079d93796:
 WARNING:possible_recursive_locking_detected_migration_is_trying_to_acquire_lock:at:set_cpus_allowed_force_but_task_is_already_holding_lock:at:cpu_stopper_thread
Message-ID: <20251028090324.GQ4068168@noisy.programming.kicks-ass.net>
References: <202510271206.24495a68-lkp@intel.com>
 <20251027110133.GI3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027110133.GI3245006@noisy.programming.kicks-ass.net>

On Mon, Oct 27, 2025 at 12:01:33PM +0100, Peter Zijlstra wrote:

Could someone confirm this fixes the problem?

> ---
> Subject: sched: Fix the do_set_cpus_allowed() locking fix
> 
> Commit abfc01077df6 ("sched: Fix do_set_cpus_allowed() locking")
> overlooked that __balance_push_cpu_stop() calls select_fallback_rq()
> with rq->lock held. This makes that set_cpus_allowed_force() will
> recursively take rq->lock and the machine locks up.
> 
> Run select_fallback_rq() earlier, without holding rq->lock. This opens
> up a race window where a task could get migrated out from under us, but
> that is harmless, we want the task migrated.
> 
> select_fallback_rq() itself will not be subject to concurrency as it
> will be fully serialized by p->pi_lock, so there is no chance of
> set_cpus_allowed_force() getting called with different arguments and
> selecting different fallback CPUs for one task.
> 
> Fixes: abfc01077df6 ("sched: Fix do_set_cpus_allowed() locking")
> Reported-by: Jan Polensky <japo@linux.ibm.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Closes: https://lore.kernel.org/oe-lkp/202510271206.24495a68-lkp@intel.com
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1842285eac1e..67b5f2faab36 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8044,18 +8044,15 @@ static int __balance_push_cpu_stop(void *arg)
>  	struct rq_flags rf;
>  	int cpu;
>  
> -	raw_spin_lock_irq(&p->pi_lock);
> -	rq_lock(rq, &rf);
> -
> -	update_rq_clock(rq);
> -
> -	if (task_rq(p) == rq && task_on_rq_queued(p)) {
> +	scoped_guard (raw_spinlock_irq, &p->pi_lock) {
>  		cpu = select_fallback_rq(rq->cpu, p);
> -		rq = __migrate_task(rq, &rf, p, cpu);
> -	}
>  
> -	rq_unlock(rq, &rf);
> -	raw_spin_unlock_irq(&p->pi_lock);
> +		rq_lock(rq, &rf);
> +		update_rq_clock(rq);
> +		if (task_rq(p) == rq && task_on_rq_queued(p))
> +			rq = __migrate_task(rq, &rf, p, cpu);
> +		rq_unlock(rq, &rf);
> +	}
>  
>  	put_task_struct(p);
>  

