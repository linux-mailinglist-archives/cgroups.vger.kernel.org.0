Return-Path: <cgroups+bounces-3698-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF3B932211
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D2E1F22A43
	for <lists+cgroups@lfdr.de>; Tue, 16 Jul 2024 08:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A96517CA09;
	Tue, 16 Jul 2024 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gP4+x07F"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0811B947;
	Tue, 16 Jul 2024 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721119359; cv=none; b=KjXrgm/cGYYqqZGWX4Qltf3wAo37Yvuh0OPC8DRSiLgReW2Jm/kuKPgqhgTNztNgE4quCt/neeQmOu7kr4aN/PPGnqXnHHvuEGJIYBVjl8SDjFbKCiiF+DmJbPMJ/gq2+DKSxBOt4x1ZOSInYxNUHfNO5noRDVIneYRa1DzMoN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721119359; c=relaxed/simple;
	bh=418fr13udianuUYqtvPQ+iZLBEydDGoXIrE96bSmGac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u2rkILJnhXazOTDSs1sw9TA5sHHhklnVeKWXWr6nRwIlKOYrlAmwzUwL3fv/SYBZk/iNeUS5f2oqw99mTNWh3IISPfggZtsKpn1brPLveHJGPizh+TTh3Z2en+sb/5egvBRPUBXkdHKsiR0jIdJmOmpumWgNlE1XsncqIQU0kUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gP4+x07F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A024C116B1;
	Tue, 16 Jul 2024 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721119358;
	bh=418fr13udianuUYqtvPQ+iZLBEydDGoXIrE96bSmGac=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gP4+x07FS6zBDtumJERTPZ0rbAhvgPOhOsw4iRNYwCwyyhf2H0q6GJpH9NtpCSg84
	 KtA7nRx565rJy2iHJe/i8N2Kilu6RpdgY3kXKDBx7rGurRsS4fiB5uS9O43GNgE4oe
	 WP57cp1bDbx1WpR0XF0AxvSsrW5UdJ1KMzbLdF4m4QPhAixIGG2N6T+IIi469f05Nj
	 2FUrvZ5IEoVZqwxKYyYUf/aYXhCKBHklpPXmWVbakDsw3t7mqt4q7gWE3WJWl4QFJL
	 9uPdLC7wQsocYEDzBVY2Rgh+atO9EaH0mjhbImWnpj+c5psygrtCmmjxcNMlIkhZFf
	 SkIHElhWPIYig==
Message-ID: <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org>
Date: Tue, 16 Jul 2024 10:42:34 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <172070450139.2992819.13210624094367257881.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


Production results below.
  - On AMD CPU with 12 NUMA nodes and 192 cores.

Using this bpftrace (looong) oneliner:

  sudo bpftrace -e '
   tracepoint:cgroup:cgroup_rstat_locked {@cnt[probe]=count();
    if (args->contended) {
      @lock_contended["after_obtaining_lock", args->level]=count();
    } else {
      if (args->cpu == -1) { @lock_contended["no_ongoing_flusher", 
args->level]}
    }}
   tracepoint:cgroup:cgroup_rstat_lock_contended {@cnt[probe]=count();
    if (args->cpu == -1) {@lock_contended["normal", args->level] = count();}
    else {@lock_contended["yield", args->level] = count();}}
   kfunc:cgroup_rstat_flush_locked {@cnt[probe]=count()}
   tracepoint:cgroup:cgroup_ongoing_flusher {@start[tid]=nsecs;
   if (args->race) {
     printf(" - XXXXXXX[%d]: Handled RACE(%d) for ongoing flusher\n", 
tid, args->race);
     @ongoing_flusher_cnt["handled_race"]=count(); }
   }
   tracepoint:cgroup:cgroup_ongoing_flusher_wait {
    $now=nsecs; $start=@start[tid]; $diff=$now-$start;
    @res=hist(args->res);
    @wait=hist($diff);
    @cnt[probe]=count();
    @ongoing_flusher_cnt[comm]=count();
    @ongoing_flusher_cnt["all"]=count();
    $r=args->race;
    if ($r) {
     printf(" - Success[%d]: Handled RACE(%d) for ongoing flusher\n", 
tid, $r) }
    }
   interval:s:1 {time("%H:%M:%S ");
    print(@ongoing_flusher_cnt);
    print(@cnt);
    print(@lock_contended);
    clear (@cnt);
    clear (@ongoing_flusher_cnt);
    clear (@lock_contended); }
   END {clear(@start)}'

On 11/07/2024 15.28, Jesper Dangaard Brouer wrote:
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
> Help reviewers follow code: __alloc_pages_slowpath calls wake_all_kswapds
> causing all kswapdN threads to wake up simultaneously. The kswapd thread
> invokes shrink_node (via balance_pgdat) triggering the cgroup rstat flush
> operation as part of its work. This results in kernel self-induced rstat
> lock contention by waking up all kswapd threads simultaneously. Leveraging
> this detail: balance_pgdat() have NULL value in target_mem_cgroup, this
> cause mem_cgroup_flush_stats() to do flush with root_mem_cgroup.
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
> V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.stgit@firesoul/
> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
> 
>   include/linux/cgroup-defs.h |    2 +
>   kernel/cgroup/rstat.c       |   95 ++++++++++++++++++++++++++++++++++++++-----
>   2 files changed, 85 insertions(+), 12 deletions(-)
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
> index fb8b49437573..fe2a81a310bb 100644
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
> +				       bool check_contention)
>   	__acquires(&cgroup_rstat_lock)
>   {
> -	bool contended;
> +	bool locked = false;
>   
> -	contended = !spin_trylock_irq(&cgroup_rstat_lock);
> -	if (contended) {
> -		trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
> +	if (check_contention)
> +		locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
> +
> +	if (!locked) {
>   		spin_lock_irq(&cgroup_rstat_lock);
> +		trace_cgroup_rstat_locked(cgrp, cpu_in_loop, check_contention);
>   	}
> -	trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>   }
>   
>   static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
> @@ -299,6 +316,53 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>   	spin_unlock_irq(&cgroup_rstat_lock);
>   }
>   
> +#define MAX_WAIT	msecs_to_jiffies(100)
> +/* Trylock helper that also checks for on ongoing flusher */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> +{
> +	struct cgroup *ongoing;
> +	bool locked;
> +
> +	/* Check if ongoing flusher is already taking care of this, if
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
> +	if (!locked) {
> +		/* Contended: Handle loosing race for ongoing flusher */
> +		if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
> +			goto retry;

This race do happen in production:

  - XXXXXXX[1040]: Handled RACE(1) for ongoing flusher
  - Success[1040]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1038]: Handled RACE(1) for ongoing flusher
  - Success[1038]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1040]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1039]: Handled RACE(1) for ongoing flusher
  - Success[1039]: Handled RACE(1) for ongoing flusher
  - Success[1040]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1044]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1047]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1045]: Handled RACE(1) for ongoing flusher
  - Success[1047]: Handled RACE(1) for ongoing flusher
  - Success[1044]: Handled RACE(1) for ongoing flusher
  - Success[1045]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1039]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1043]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1042]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1037]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1044]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1047]: Handled RACE(1) for ongoing flusher
  - Success[1043]: Handled RACE(1) for ongoing flusher
  - Success[1037]: Handled RACE(1) for ongoing flusher
  - Success[1039]: Handled RACE(1) for ongoing flusher
  - Success[1044]: Handled RACE(1) for ongoing flusher
  - Success[1042]: Handled RACE(1) for ongoing flusher
  - Success[1047]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1038]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1039]: Handled RACE(1) for ongoing flusher
  - Success[1039]: Handled RACE(1) for ongoing flusher
  - Success[1038]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1048]: Handled RACE(1) for ongoing flusher
  - Success[1048]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1045]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1043]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1047]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1046]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1048]: Handled RACE(1) for ongoing flusher
  - Success[1045]: Handled RACE(1) for ongoing flusher
  - Success[1043]: Handled RACE(1) for ongoing flusher
  - Success[1047]: Handled RACE(1) for ongoing flusher
  - Success[1046]: Handled RACE(1) for ongoing flusher
  - Success[1048]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1045]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1043]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1042]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1041]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1044]: Handled RACE(1) for ongoing flusher
  - Success[1045]: Handled RACE(1) for ongoing flusher
  - Success[1041]: Handled RACE(1) for ongoing flusher
  - Success[1042]: Handled RACE(1) for ongoing flusher
  - Success[1043]: Handled RACE(1) for ongoing flusher
  - Success[1044]: Handled RACE(1) for ongoing flusher
  - XXXXXXX[1048]: Handled RACE(1) for ongoing flusher
  - Success[1048]: Handled RACE(1) for ongoing flusher
07:42:02 @ongoing_flusher_cnt[kswapd11]: 7
@ongoing_flusher_cnt[kswapd4]: 7
@ongoing_flusher_cnt[kswapd10]: 7
@ongoing_flusher_cnt[kswapd9]: 8
@ongoing_flusher_cnt[kswapd6]: 8
@ongoing_flusher_cnt[kswapd3]: 8
@ongoing_flusher_cnt[kswapd8]: 8
@ongoing_flusher_cnt[kswapd7]: 9
@ongoing_flusher_cnt[kswapd1]: 9
@ongoing_flusher_cnt[kswapd0]: 9
@ongoing_flusher_cnt[kswapd5]: 9
@ongoing_flusher_cnt[kswapd2]: 9
@ongoing_flusher_cnt[handled_race]: 27
@ongoing_flusher_cnt[all]: 98
@cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 27
@cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 37
@cnt[tracepoint:cgroup:cgroup_rstat_locked]: 45
@cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 98
@lock_contended[normal, 0]: 27


This is a clean (meaning no cadvisor interference) example of kswapd
starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
hit the race (which is handled in V6 and V7).

The BPF "cnt" maps are getting cleared every second, so this
approximates per sec numbers.  This patch reduce pressure on the lock,
but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
flushes approx 37 per sec (every 27 ms). On the positive side
ongoing_flusher mitigation stopped 98 per sec of these.

In this clean kswapd case the patch removes the lock contention issue
for kswapd. The lock_contended cases 27 seems to be all related to
handled_race cases 27.

The remaning high flush rate should also be addressed, and we should
also work on aproaches to limit this like my ealier proposal[1].

  [1] 
https://lore.kernel.org/all/171328990014.3930751.10674097155895405137.stgit@firesoul/#Z31kernel:cgroup:rstat.c


> +
> +		__cgroup_rstat_lock(cgrp, -1, false);
> +	}
> +	/* Obtained lock, record this cgrp as the ongoing flusher */
> +	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> +	if (!ongoing) {
> +		reinit_completion(&cgrp->flush_done);
> +		WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
> +	}
> +	return true; /* locked */
> +}
> +
> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
> +{
> +	/* Detect if we are the ongoing flusher */
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
> @@ -328,7 +392,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>   			__cgroup_rstat_unlock(cgrp, cpu);
>   			if (!cond_resched())
>   				cpu_relax();
> -			__cgroup_rstat_lock(cgrp, cpu);
> +			__cgroup_rstat_lock(cgrp, cpu, true);
>   		}
>   	}
>   }
> @@ -350,9 +414,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
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
> @@ -368,8 +434,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
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
> @@ -379,7 +448,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>   	__releases(&cgroup_rstat_lock)
>   {
> -	__cgroup_rstat_unlock(cgrp, -1);
> +	cgroup_rstat_unlock_flusher(cgrp);
>   }
>   
>   int cgroup_rstat_init(struct cgroup *cgrp)
> @@ -401,6 +470,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
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

