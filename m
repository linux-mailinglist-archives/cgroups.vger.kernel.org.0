Return-Path: <cgroups+bounces-3429-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7510991B2D6
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 01:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFF7B222AE
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2024 23:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055D91A2FC2;
	Thu, 27 Jun 2024 23:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wg5kRHy/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFD11A2C35
	for <cgroups@vger.kernel.org>; Thu, 27 Jun 2024 23:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719531271; cv=none; b=L8jEhmVqW8LfJ7jKxPLyvE476Pqw/usMRTd6unxKHFP34DAbHN71+o/wkUikBuBcuFkeTb7oI/iFQhb1ry/VeYN8tLDDTHcqrIEj+YIO/rNsNUyOMCpibhLFn9RrLiLGsrfKNxzCJQEsJgkwyWhnUwF0j7deRFyDV+sg+XZCTrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719531271; c=relaxed/simple;
	bh=vlu87FoUUsGQMD4iscqLZ1GYaFUjC5nG7aYPk6GJeAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ts0Y0TirbXh81YFo8avVAhzRkaNwt4gJIxLfcm2YkQewEhAq2/XYCpfqt9Z7B3qX4FACFXLA+7ogl2Es/Dqk7JTGb0QQu6AhSm3dp//5I7OWTDoQkR0EsoaRo6QYmYJy8791JwRU7YHW8ubhTptI0RY0zUJJKqwf0Zq2n6BmWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wg5kRHy/; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: hawk@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719531267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlKYYvcrAhje7I3jr3QA/EGpapoyOIv7xLn5q2CRVCc=;
	b=Wg5kRHy/H+aJGY3Lu99Av7zHqOzqYCUgh19hcBVLpA3b3SHO/iMH6mjIjflbx5X4vgfVcR
	fWpc+deoyN3nVhVfx9h+JqEVK+8u+drcKEcIKAOXOamuSRvfUcGU9WuBMS/dcQKia9AlTq
	kN2bW+XxAWfAcXF+IbgEkt8LKtLWwjM=
X-Envelope-To: tj@kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: yosryahmed@google.com
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: lizefan.x@bytedance.com
X-Envelope-To: longman@redhat.com
X-Envelope-To: kernel-team@cloudflare.com
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Thu, 27 Jun 2024 16:34:21 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
Message-ID: <4n3qu75efpznkomxytm7irwfiq44hhi4hb5igjbd55ooxgmvwa@tbgmwvcqsy75>
References: <171952310959.1810550.17003659816794335660.stgit@firesoul>
 <171952312320.1810550.13209360603489797077.stgit@firesoul>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171952312320.1810550.13209360603489797077.stgit@firesoul>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 27, 2024 at 11:18:56PM GMT, Jesper Dangaard Brouer wrote:
> Avoid lock contention on the global cgroup rstat lock caused by kswapd
> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
> call inlined in shrink_node, which takes the rstat lock.
> 
> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
> we noted severe lock contention on the rstat lock. This contention
> causes 12 CPUs to waste cycles spinning every time kswapd runs.
> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
> due to spinning on the rstat lock.
> 
> To help reviewer follow code: When the Per-CPU-Pages (PCP) freelist is
> empty,

Remove the "When the Per-CPU-Pages (PCP) freelist is empty" as there are
a lot more conditions needed for the waking up kswapds which are not
needed to be explained here. Just "__alloc_pages_slowpath waking up
kswapds given the allocation context" or similar text should suffice.

> __alloc_pages_slowpath calls wake_all_kswapds(), causing all
> kswapdN threads to wake up simultaneously. The kswapd thread invokes
> shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> operation as part of its work. This results in kernel self-induced rstat
> lock contention by waking up all kswapd threads simultaneously.
> Leveraging this detail: balance_pgdat() have NULL value in
> target_mem_cgroup, this cause mem_cgroup_flush_stats() to do flush with
> root_mem_cgroup.
> 
> To avoid this kind of thundering herd problem, kernel previously had a
> "stats_flush_ongoing" concept, but this was removed as part of commit
> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
> reintroduce and generalized the concept to apply to all users of cgroup
> rstat, not just memcg.
> 
> If there is an ongoing rstat flush, and current cgroup is a descendant,
> then it is unnecessary to do the flush. For callers to still see updated
> stats, wait for ongoing flusher to complete before returning, but add
> timeout as stats are already inaccurate given updaters keeps running.
> 
> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
> 
>  include/linux/cgroup-defs.h |    2 +
>  kernel/cgroup/rstat.c       |   64 ++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
> index b36690ca0d3f..a33b37514c29 100644
> --- a/include/linux/cgroup-defs.h
> +++ b/include/linux/cgroup-defs.h
> @@ -548,6 +548,8 @@ struct cgroup {
>  #ifdef CONFIG_BPF_SYSCALL
>  	struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>  #endif
> +	/* completion queue for cgrp_rstat_ongoing_flusher */
> +	struct completion flush_done;
>  
>  	/* All ancestors including self */
>  	struct cgroup *ancestors[];
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 2a42be3a9bb3..a98af43bdce7 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -2,6 +2,7 @@
>  #include "cgroup-internal.h"
>  
>  #include <linux/sched/cputime.h>
> +#include <linux/completion.h>
>  
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> @@ -11,6 +12,8 @@
>  
>  static DEFINE_SPINLOCK(cgroup_rstat_lock);
>  static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
> +static struct cgroup *cgrp_rstat_ongoing_flusher = NULL;
> +static DECLARE_COMPLETION(cgrp_rstat_flusher_done);

cgrp_rstat_flusher_done is not needed anymore.

>  
>  static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>  
> @@ -312,6 +315,45 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>  	spin_unlock_irq(&cgroup_rstat_lock);
>  }
>  
> +#define MAX_WAIT	msecs_to_jiffies(100)
> +/* Trylock helper that also checks for on ongoing flusher */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> +{
> +	bool locked = __cgroup_rstat_trylock(cgrp, -1);
> +	if (!locked) {
> +		struct cgroup *cgrp_ongoing;
> +
> +		/* Lock is contended, lets check if ongoing flusher is already
> +		 * taking care of this, if we are a descendant.
> +		 */
> +		cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> +		if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoing)) {

I wonder if READ_ONCE() and cgroup_is_descendant() needs to happen
within in rcu section. On a preemptable kernel, let's say we got
preempted in between them, the flusher was unrelated and got freed
before we get the CPU. In that case we are accessing freed memory.

> +			wait_for_completion_interruptible_timeout(
> +				&cgrp_ongoing->flush_done, MAX_WAIT);
> +
> +			return false;
> +		}
> +		__cgroup_rstat_lock(cgrp, -1, false);
> +	}
> +	/* Obtained lock, record this cgrp as the ongoing flusher */
> +	if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {

Can the above condition will ever be false?

> +		reinit_completion(&cgrp->flush_done);
> +		WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
> +	}
> +
> +	return true; /* locked */
> +}
> +
> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
> +{
> +	/* Detect if we are the ongoing flusher */
> +	if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher)) {

Same.

> +		WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
> +		complete_all(&cgrp->flush_done);
> +	}
> +	__cgroup_rstat_unlock(cgrp, -1);
> +}
> +
>  /* see cgroup_rstat_flush() */
>  static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>  	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
> @@ -361,18 +403,13 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>   */
>  __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>  {
> -	bool locked;
> -
>  	might_sleep();
>  
> -	locked = __cgroup_rstat_trylock(cgrp, -1);
> -	if (!locked) {
> -		/* Opportunity to ongoing flush detection */
> -		__cgroup_rstat_lock(cgrp, -1, false);
> -	}
> +	if (!cgroup_rstat_trylock_flusher(cgrp))
> +		return;
>  
>  	cgroup_rstat_flush_locked(cgrp);
> -	__cgroup_rstat_unlock(cgrp, -1);
> +	cgroup_rstat_unlock_flusher(cgrp);
>  }
>  
>  /**
> @@ -388,8 +425,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  	__acquires(&cgroup_rstat_lock)
>  {
>  	might_sleep();
> -	__cgroup_rstat_lock(cgrp, -1, true);
> -	cgroup_rstat_flush_locked(cgrp);
> +
> +	if (cgroup_rstat_trylock_flusher(cgrp))
> +		cgroup_rstat_flush_locked(cgrp);
> +	else
> +		__cgroup_rstat_lock(cgrp, -1, true);
>  }
>  
>  /**
> @@ -399,7 +439,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>  void cgroup_rstat_flush_release(struct cgroup *cgrp)
>  	__releases(&cgroup_rstat_lock)
>  {
> -	__cgroup_rstat_unlock(cgrp, -1);
> +	cgroup_rstat_unlock_flusher(cgrp);
>  }
>  
>  int cgroup_rstat_init(struct cgroup *cgrp)
> @@ -421,6 +461,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>  		u64_stats_init(&rstatc->bsync);
>  	}
>  
> +	init_completion(&cgrp->flush_done);
> +
>  	return 0;
>  }
>  
> 
> 

