Return-Path: <cgroups+bounces-4204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D0494EFD2
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360AE1F233EA
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 14:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D665518132A;
	Mon, 12 Aug 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDt991gA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AD14C5A4;
	Mon, 12 Aug 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473690; cv=none; b=KmiKss/xgRJN7wjBuNI2Wut7KubdVy9cFHygVauk9OcB3JFDB6+ht3Vy997Zs65zjFeisUAJiitwNIV+t353Unt0j3z5ZoZjUl/QYkth49reJNzF8GMzwHdAhzmjJf6YDXIZJQ3/eplH2yFKXad8nkt0tjQkoEWF3tv8W9t6KrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473690; c=relaxed/simple;
	bh=6kRnKXC8ZWBXeu1SrJ69LeK8v5L7MzOYhhDtPffcaFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFz5bSgW/D71WTtAnEfYKEbz3IgzXCLGYYEMft0MxvxBONcesdO2i+MIegtpphErwprxbRyMDsbZkBazzc6Lw6J3Bq9U3Nj98JBVnJHTZAsPRfhHyGLFPheDtga9EJ8MrCctbX4F4L7kHXS/t2aso+FBhZKZzTSly1/c9q9KWOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDt991gA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43511C32782;
	Mon, 12 Aug 2024 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723473690;
	bh=6kRnKXC8ZWBXeu1SrJ69LeK8v5L7MzOYhhDtPffcaFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PDt991gAdhARwtSG028BsrlJ10WbrEQwNhss/mxR1yBr6l/a+Z8m34Fo7RKfDs5tR
	 KhZr7qEVVvPQS/Y1WX0PTpPYszdJzKRKfaG0wkdoV+pxda4btL/PKDPpA51GRYeWPY
	 OmCi3VKWtjE1Mp/SSg1fo8wYDah+NlB7R2+8tycy5rxHbX/Nga9L6FdZ8/QAB8w8pZ
	 151xQ+g0I8dit3yMiiwjyNjY9OASAn/yoFQZQPLbPnb0B4rXJ1fGeUqeoKKtcJVxxR
	 DTimYohOdxEGGcCx6dr/tJXqSqqoSw+lhVp/MTjyXuenGmwQqSf77abvDVU9UNvdbn
	 vk2KRlG1CXgVw==
Message-ID: <693177aa-16f0-432a-baa4-3b862dee48c9@kernel.org>
Date: Mon, 12 Aug 2024 16:41:26 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172245504313.3147408.12138439169548255896.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <172245504313.3147408.12138439169548255896.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2024 21.47, Jesper Dangaard Brouer wrote:
> This patch reintroduces and generalizes the "stats_flush_ongoing" concept
> to avoid redundant flushes if there is an ongoing flush, addressing lock
> contention issues on the global cgroup rstat lock.
> 
> At Cloudflare, we observed significant performance degradation due to
> lock contention on the rstat lock, primarily caused by kswapd. The
> specific mem_cgroup_flush_stats() call inlined in shrink_node, which
> takes the rstat lock, is particularly problematic.
> 
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node, we
> noted severe lock contention on the rstat lock, causing 12 CPUs to waste
> cycles spinning every time kswapd runs. Fleet-wide stats (/proc/N/schedstat)
> for kthreads revealed that we are burning an average of 20,000 CPU cores
> fleet-wide on kswapd, primarily due to spinning on the rstat lock.
> 
> Here's a brief overview of the issue:
> - __alloc_pages_slowpath calls wake_all_kswapds, causing all kswapdN threads
>    to wake up simultaneously.
> - The kswapd thread invokes shrink_node (via balance_pgdat), triggering the
>    cgroup rstat flush operation as part of its work.
> - balance_pgdat() has a NULL value in target_mem_cgroup, causing
>    mem_cgroup_flush_stats() to flush with root_mem_cgroup.
> 
> The kernel previously addressed this with a "stats_flush_ongoing" concept,
> which was removed in commit 7d7ef0a4686a ("mm: memcg: restore subtree stats
> flushing"). This patch reintroduces and generalizes the concept to apply to
> all users of cgroup rstat, not just memcg.
> 
> If there is an ongoing rstat flush and the current cgroup is a descendant, a
> new flush is unnecessary. To ensure callers still receive updated stats,
> they wait for the ongoing flush to complete before returning, but with a
> timeout, as stats may already be inaccurate due to continuous updates.
> 
> Lock yielding causes complications for ongoing flushers. Therefore, we limit
> which cgroup can become ongoing flusher to top-level, as lock yielding
> allows others to obtain the lock without being the ongoing flusher, leading
> to a situation where a cgroup that isn't a descendant obtains the lock via
> yielding. Thus, we prefer an ongoing flusher with many descendants. If and
> when the lock yielding is removed, such as when changing this to a mutex,
> we can simplify this code.
> 
> This change significantly reduces lock contention, especially in
> environments with multiple NUMA nodes, thereby improving overall system
> performance.
> 
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V9:
>   - Fix logic for 'already_contended'
>   - Didn't address the refcnt suggestion, need more input from experts
>   - I'll deploy this ASAP to my production experiment hosts and report back
> 
> V8: https://lore.kernel.org/all/172139415725.3084888.13770938453137383953.stgit@firesoul
> V7: https://lore.kernel.org/all/172070450139.2992819.13210624094367257881.stgit@firesoul
> V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.stgit@firesoul/
> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
> 
> 
>   include/linux/cgroup-defs.h |    2 +
>   kernel/cgroup/rstat.c       |  113 ++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 103 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b36690ca0d3f..a33b37514c29 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -548,6 +548,8 @@ struct cgroup {
>   #ifdef CONFIG_BPF_SYSCALL
>   	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>   #endif
> +	/* completion queue for cgrp_rstat_ongoing_flusher */
> +	struct completion flush_done;
>   
>   	/* All ancestors including self */
>   	struct cgroup *ancestors[];
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index fb8b49437573..463f9807ec7e 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -2,6 +2,7 @@
>   #include "cgroup-internal.h"
>   
>   #include <linux/sched/cputime.h>
> +#include <linux/completion.h>
>   
>   #include <linux/bpf.h>
>   #include <linux/btf.h>
> @@ -11,6 +12,7 @@
>   
>   static DEFINE_SPINLOCK(cgroup_rstat_lock);
>   static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static struct cgroup *cgrp_rstat_ongoing_flusher = NULL;
>   
>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>   
> @@ -279,17 +281,32 @@ __bpf_hook_end();
>    * value -1 is used when obtaining the main lock else this is the CPU
>    * number processed last.
>    */
> -static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
> +static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int cpu_in_loop)
> +{
> +	bool locked;
> +
> +	locked = spin_trylock_irq(&cgroup_rstat_lock);
> +	if (!locked)
> +		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, true);
> +	else
> +		trace_cgroup_rstat_locked(cgrp, cpu_in_loop, false);
> +
> +	return locked;
> +}
> +
> +static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
> +				       bool already_contended)
>   	__acquires(&cgroup_rstat_lock)
>   {
> -	bool contended;
> +	bool locked = false;
>   
> -	contended = !spin_trylock_irq(&cgroup_rstat_lock);
> -	if (contended) {
> -		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
> +	if (!already_contended) /* Skip trylock if already contended */
> +		locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
> +
> +	if (!locked) {
>   		spin_lock_irq(&cgroup_rstat_lock);
> +		trace_cgroup_rstat_locked(cgrp, cpu_in_loop, true);
>   	}
> -	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>   }
>   
>   static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> @@ -299,6 +316,71 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>   	spin_unlock_irq(&cgroup_rstat_lock);
>   }
>   
> +#define MAX_WAIT	msecs_to_jiffies(100)
> +/**
> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
> + * @cgrp: target cgroup
> + *
> + * Function return value follow trylock semantics. Returning true when lock is
> + * obtained. Returning false when not locked and it detected flushing can be
> + * skipped as another ongoing flusher took care of the flush.
> + */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> +{
> +	struct cgroup *ongoing;
> +	bool locked;
> +
> +	/*
> +	 * Check if ongoing flusher is already taking care of this, if
> +	 * we are a descendant skip work, but wait for ongoing flusher
> +	 * to complete work.
> +	 */
> +retry:
> +	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> +	if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
> +		wait_for_completion_interruptible_timeout(
> +			&ongoing->flush_done, MAX_WAIT);
> +		/* TODO: Add tracepoint here */
> +		return false;
> +	}
> +
> +	locked = __cgroup_rstat_trylock(cgrp, -1);

State "A": Obtaining lock here.

(Remember that userspace can attach a tracepoint program to the locked 
event.)

> +	if (!locked) {
> +		/* Contended: Handle losing race for ongoing flusher */

State "B": Seeing lock was held by someone else.

> +		if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
> +			goto retry;
> +

This race handling code isn't good enough.

> +		__cgroup_rstat_lock(cgrp, -1, true);
> +	}
> +	/*
> +	 * Obtained lock, record this cgrp as the ongoing flusher.
> +	 * Due to lock yielding, we might obtain lock while another
> +	 * ongoing flusher (that isn't a parent) owns ongoing_flusher.
> +	 */
> +	if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> +		/*
> +		 * Limit to top-level as lock yielding allows others to obtain
> +		 * lock without being ongoing_flusher. Leading to cgroup that
> +		 * isn't descendant to obtain lock via yielding. So, prefer
> +		 * ongoing_flusher with many descendants.
> +		 */
> +		if (cgrp->level < 2) {
> +			reinit_completion(&cgrp->flush_done);
> +			WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);

Time between State "A" and writing cgrp_rstat_ongoing_flusher, can be
easily be affected by loading BPF tracepoint programs.

E.g. when I in production load a bpftrace prog on tracepoint
cgroup_rstat_locked then the kswapd thundering herd problem comes back,
because BPF-prog delay State "A" updating ongoing, then State "B"
observe cgrp_rstat_ongoing_flusher is unset in race check.
(Note, due to lock yield, it is possible that no ongoing_flusher is set
and locked is held, so we cannot always goto retry when we observe lock
is held but no ongoing is set).

In [V2] we had a race free implementation that used cmpxchg().
I will go back to the drawing board with V2 as the inspiration.


[V2] 
https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/

> +		}
> +	}
> +	return true;
> +}
> +
> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
> +{
> +	if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> +		WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
> +		complete_all(&cgrp->flush_done);
> +	}
> +	__cgroup_rstat_unlock(cgrp, -1);
> +}
> +
>   /* see cgroup_rstat_flush() */
>   static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>   	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
> @@ -328,7 +410,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>   			__cgroup_rstat_unlock(cgrp, cpu);
>   			if (!cond_resched())
>   				cpu_relax();
> -			__cgroup_rstat_lock(cgrp, cpu);
> +			__cgroup_rstat_lock(cgrp, cpu, false);
>   		}
>   	}
>   }
> @@ -350,9 +432,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>   {
>   	might_sleep();
>   
> -	__cgroup_rstat_lock(cgrp, -1);
> +	if (!cgroup_rstat_trylock_flusher(cgrp))
> +		return;
> +
>   	cgroup_rstat_flush_locked(cgrp);
> -	__cgroup_rstat_unlock(cgrp, -1);
> +	cgroup_rstat_unlock_flusher(cgrp);
>   }
>   
>   /**
> @@ -368,8 +452,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   	__acquires(&cgroup_rstat_lock)
>   {
>   	might_sleep();
> -	__cgroup_rstat_lock(cgrp, -1);
> -	cgroup_rstat_flush_locked(cgrp);
> +
> +	if (cgroup_rstat_trylock_flusher(cgrp))
> +		cgroup_rstat_flush_locked(cgrp);
> +	else
> +		__cgroup_rstat_lock(cgrp, -1, false);
>   }
>   
>   /**
> @@ -379,7 +466,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>   	__releases(&cgroup_rstat_lock)
>   {
> -	__cgroup_rstat_unlock(cgrp, -1);
> +	cgroup_rstat_unlock_flusher(cgrp);
>   }
>   
>   int cgroup_rstat_init(struct cgroup *cgrp)
> @@ -401,6 +488,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>   		u64_stats_init(&rstatc->bsync);
>   	}
>   
> +	init_completion(&cgrp->flush_done);
> +
>   	return 0;
>   }
>   
> 
> 

