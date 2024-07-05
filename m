Return-Path: <cgroups+bounces-3549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9349288E6
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 14:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54EDA1C223EC
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 12:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB21494BA;
	Fri,  5 Jul 2024 12:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2pgFoxA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89A41E867;
	Fri,  5 Jul 2024 12:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720183562; cv=none; b=fHqJG9ZuQHCVqHKOgbVcAnl42ya5kqkpSJV24TD/r0rE8Q5TfZhT1qotsbpH3mSv4FkCwaMurMwbXS1xHgqY6Wti1Z9EnU1nnroIuJHg/0hB3shwEs1S3hZJubI19vvH4m+/mjNEJbcVlPLzAhe0/f1sxT/ueyy7v4Yu1Md55Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720183562; c=relaxed/simple;
	bh=YnlMZWJ2dnf8MfW4QrYMu87iaU5CcHc9yot2NDnHNT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ql3M9QRGiGnml1ZdoW+IfbHxp3ns0Q8sHQv2WD3d0KxTJIHSRXSBrRvdFRzVCPYfYgNk7hVf8kGcfqu/Eo05zaL/SG1XBcmbOxqlkazaJKUSBvlbOticc3H8ALOJh9ov3JVY91zPLl7E5kMcmpi75pAWpUFx2MNU5HEvVKylHME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2pgFoxA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7292BC116B1;
	Fri,  5 Jul 2024 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720183561;
	bh=YnlMZWJ2dnf8MfW4QrYMu87iaU5CcHc9yot2NDnHNT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b2pgFoxA+TLxGoOJP3AoWJyhqN6ruoHdlE4w1QqPeXMfPikTBSkwVyIuM8r2JG9IA
	 OhB5VR1atbGOJDWDdKoQ2ljI6tOlLY+m2E3QPABN5IKTvaMNflHg7gbgLAYTY5oBpQ
	 GVyTq7Ysad4o9YxNK9xRb4RuGpf4XoRl45F3SiiBCzHu3JF7EUVOrhE3vEHW66FJlb
	 PlQ0QL5KRE+tzo02pWmRpbKlJfVD+gfP/9/nJAsOYmXa1HTfZwPD01JUmoRwi6DrUY
	 ayQ7FsY6Fsz+NHienEmK+XLcR3aOGoNbat5bRPv5+z2tY6mF5i0Z7TjighVbNweumi
	 +7A4BpnVjUWbQ==
Message-ID: <31ed22b4-4b6f-4a1d-96ae-930d1c19da85@kernel.org>
Date: Fri, 5 Jul 2024 14:45:57 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <171956951930.1897969.8709279863947931285.stgit@firesoul>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <171956951930.1897969.8709279863947931285.stgit@firesoul>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

(production results below)

On 28/06/2024 12.12, Jesper Dangaard Brouer wrote:
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
> V5:
>   Dropped trylock helper
> 
> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
> 
>   include/linux/cgroup-defs.h |    2 ++
>   kernel/cgroup/rstat.c       |   57 +++++++++++++++++++++++++++++++++++++++----
>   2 files changed, 54 insertions(+), 5 deletions(-)
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
> index fb8b49437573..e9d3e2aff698 100644
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
> @@ -299,6 +301,44 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>   	spin_unlock_irq(&cgroup_rstat_lock);
>   }
>   
> +#define MAX_WAIT	msecs_to_jiffies(100)
> +/* Trylock helper that also checks for on ongoing flusher */
> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
> +{
> +	struct cgroup *cgrp_ongoing;
> +
> +	/* Check if ongoing flusher is already taking care of this, if
> +	 * we are a descendant skip work, but wait for ongoing flusher
> +	 * to complete work.
> +	 */
> +	cgrp_ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> +	if (cgrp_ongoing && cgroup_is_descendant(cgrp, cgrp_ongoing)) {
> +		wait_for_completion_interruptible_timeout(
> +			&cgrp_ongoing->flush_done, MAX_WAIT);
> +		/* TODO: Add tracepoint here */
> +		return false;
> +	}
> +
> +	__cgroup_rstat_lock(cgrp, -1);
> +	/* Obtained lock, record this cgrp as the ongoing flusher */
> +	if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> +		reinit_completion(&cgrp->flush_done);
> +		WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
> +	}
> +
> +	return true; /* locked */
> +}
> +

This scheme doesn't fully stop the kswapd thundering herd problem.
Below bpftrace script look at cgroup_rstat_trylock_flusher() return
values.  If false (0) is returned then we avoided a flush operation and
locking.

[Data from production- AMD with 12 NUMA nodes]

bpftrace -e 'kretfunc:cgroup_rstat_trylock_flusher {@cnt = hist(retval)}
     interval:s:10 {time("%H:%M:%S "); print(@cnt); clear(@cnt)}'
Attaching 2 probes...
11:42:28 @cnt:
[0]    467 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]    203 |@@@@@@@@@@@@@@@@@@@@@@                              |

11:42:38 @cnt:
[0]    320 |@@@@@@@@@@@@@                                       |
[1]   1217 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

11:42:48 @cnt:
[0]    256 |@@@@@@@@@@@@@                                       |
[1]    969 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

Above data shows that, the success rate (for avoiding concurrent
flushing) isn't as high as we would expect and had hoped for.

I'm not sure what is the reason for this?
I can only spegulate.

(A) Pergaps the READ_ONCE() outside the lock isn't sufficient.
This would imply that wake_all_kswapds() wakes up at exactly same time.

(B) Perhaps wake_all_kswapds() is not exact and there isn't any
contention and ongoing flusher.
Unlikely, as we can measure contention (see below for more data), and
lockhold time is between 64 usec to 256 usec (with outliers around 32 ms).

(C) Sub-tree ongoing flusher could be blocking us.
This, can happen and I caught come cases of this happening when cadvisor
collects data.  But for cases where it is only kswapdN running this also
happens (see below data with 10 sec period with kswapd and periodic
flusher).

Idea are welcome for what I should try first?


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
> @@ -350,9 +390,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
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
> @@ -368,8 +410,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   	__acquires(&cgroup_rstat_lock)
>   {
>   	might_sleep();
> -	__cgroup_rstat_lock(cgrp, -1);
> -	cgroup_rstat_flush_locked(cgrp);
> +
> +	if (cgroup_rstat_trylock_flusher(cgrp))
> +		cgroup_rstat_flush_locked(cgrp);
> +	else
> +		__cgroup_rstat_lock(cgrp, -1);
>   }
>   
>   /**
> @@ -379,7 +424,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>   	__releases(&cgroup_rstat_lock)
>   {
> -	__cgroup_rstat_unlock(cgrp, -1);
> +	cgroup_rstat_unlock_flusher(cgrp);
>   }
>   
>   int cgroup_rstat_init(struct cgroup *cgrp)
> @@ -401,6 +446,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
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


Data including 'comm'

bpftrace -e 'kretfunc:cgroup_rstat_trylock_flusher 
{@total=hist(retval);@ret[comm] = hist(retval)} 

     interval:s:10 {time("%H:%M:%S "); print(@ret); print(@total); 
clear(@ret)}'
Attaching 2 probes...
12:13:21 @ret[kworker/u388:15]:
[1]                    1 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@ret[kworker/u389:20]:
[1]                    2 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@ret[kworker/u389:3]:
[1]                    2 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@ret[kswapd3]:
[0]                   10 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    1 |@@@@@ 
      |

@ret[kswapd11]:
[0]                   10 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    2 |@@@@@@@@@@ 
      |

@ret[kswapd2]:
[0]                   12 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    1 |@@@@ 
      |

@ret[kswapd10]:
[0]                   10 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    5 |@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |

@ret[kswapd9]:
[0]                   13 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    2 |@@@@@@@@ 
      |

@ret[kswapd0]:
[0]                   11 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    5 |@@@@@@@@@@@@@@@@@@@@@@@ 
      |

@ret[kswapd6]:
[0]                    9 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    8 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |

@ret[kswapd7]:
[0]                   13 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    5 |@@@@@@@@@@@@@@@@@@@@ 
      |

@ret[kswapd4]:
[0]                   12 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    7 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |

@ret[kswapd5]:
[0]                   13 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    6 |@@@@@@@@@@@@@@@@@@@@@@@@ 
      |

@ret[kswapd1]:
[0]                   16 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                    9 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |

@ret[kswapd8]:
[0]                   14 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                   14 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

@total:
[0]                  135 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[1]                   70 |@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |


How long time is the lock locked (@locked_ns)
and how long does lock contenders wait to obtain lock (@wait_ns).

bpftrace -e '
    tracepoint:cgroup:cgroup_rstat_lock_contended {@start[tid]=nsecs}
    tracepoint:cgroup:cgroup_rstat_locked { @locked[tid]=nsecs;
      if (args->contended) {
        @wait_ns=hist(nsecs-@start[tid]); delete(@start[tid]);}}
    tracepoint:cgroup:cgroup_rstat_unlock {
        @locked_ns=hist(nsecs-@locked[tid]); delete(@locked[tid]);}
    interval:s:1 {time("%H:%M:%S ");  print(@wait_ns);print(@locked_ns); }'


@locked_ns:
[256, 512)            94 | 
      |
[512, 1K)           5870 |@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[1K, 2K)            5353 |@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[2K, 4K)             439 |@ 
      |
[4K, 8K)             172 | 
      |
[8K, 16K)           6344 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[16K, 32K)          6954 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[32K, 64K)          2700 |@@@@@@@@@@@@ 
      |
[64K, 128K)        11451 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[128K, 256K)        8362 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[256K, 512K)        1167 |@@@@@ 
      |
[512K, 1M)           114 | 
      |
[1M, 2M)              32 | 
      |
[2M, 4M)              25 | 
      |
[4M, 8M)              55 | 
      |
[8M, 16M)            258 |@ 
      |
[16M, 32M)           221 |@ 
      |
[32M, 64M)            24 | 
      |


@wait_ns:
[512, 1K)             30 | 
      |
[1K, 2K)            2124 |@@@@@@@ 
      |
[2K, 4K)            3319 |@@@@@@@@@@@ 
      |
[4K, 8K)            1595 |@@@@@ 
      |
[8K, 16K)           3288 |@@@@@@@@@@@ 
      |
[16K, 32K)          5349 |@@@@@@@@@@@@@@@@@@ 
      |
[32K, 64K)          5069 |@@@@@@@@@@@@@@@@@ 
      |
[64K, 128K)        15451 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[128K, 256K)        9420 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[256K, 512K)         707 |@@ 
      |
[512K, 1M)             2 | 
      |



--Jesper

