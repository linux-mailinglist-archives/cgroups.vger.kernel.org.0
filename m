Return-Path: <cgroups+bounces-4001-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B28941B14
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B0B1C2093C
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4AE189502;
	Tue, 30 Jul 2024 16:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blrOVJ+Q"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEE155CB3;
	Tue, 30 Jul 2024 16:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358248; cv=none; b=UWMkCG31FKtCA7ffZtEz/qA4mimN8DfC4GfK3IrzMMDEOL7GpsM+7XebeyDZVD+ZF7ygvlw6uojFzCvnhy9NumZ7Y/iylnFKKtYWC7h3xjGmdFm+Tmin2vHRtysLkN84832pPnxV73gwb2Pn+9Gv7DczJ5xGuO1NnWj6jAnAqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358248; c=relaxed/simple;
	bh=Lgbn3vkbb+BMChdfm+ori3tgqCyUMdjPnkHCLWyAxS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyRBSqk0T7rG6rjyrzWWjPHmoqnn0xDoDmdKKWsuqImxWrA3xktPsVnTDwu4FGUyZIxdrwkAS1o7HtOu6Fde4a05aIy6+TjkQT+pfxZVkpgEbhnPNMHGV6dPQUsJ1rMGVZN7eTciOKUhHHBxcG5XZL3IEUbBUqy/rKOZ2d3nY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blrOVJ+Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A91C4AF0E;
	Tue, 30 Jul 2024 16:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722358247;
	bh=Lgbn3vkbb+BMChdfm+ori3tgqCyUMdjPnkHCLWyAxS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=blrOVJ+QuPZ2ZNEGGASgGP8DGggFMs3++3Du9ejHbfwFD/HeUxpTjvDbhBMvN0Z/I
	 6UzguZqc/HA5Dj4ZeYQjUYRyq4Wif4Z1+VXZlOjQB0Sse5AdJRSfqhUwu/vRjwSbql
	 sbwQeU38K/d9IH6UBrLOQNHAn/sMXhcbQOy9LlQp5OUwpx06cxMdLe3hod+MzRFrBZ
	 r7hWIvemh0jRN0mwGkO/89FiwmluFTO++kz4UcmcA7Z1RhkRDO3tCXoNGBjQnTUdHy
	 141XxIO8OAAIbd/C2bGRRp25zCGJkSBzHWc8mDnanS0/XwaGjqncPunuyTsNdRBWR0
	 Tp2/8NfjMoqcQ==
Message-ID: <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org>
Date: Tue, 30 Jul 2024 18:50:43 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
 <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 22/07/2024 19.02, Yosry Ahmed wrote:
> On Fri, Jul 19, 2024 at 6:06 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>> This patch reintroduces and generalizes the "stats_flush_ongoing" concept
>> to avoid redundant flushes if there is an ongoing flush, addressing lock
>> contention issues on the global cgroup rstat lock.
>>
>> At Cloudflare, we observed significant performance degradation due to
>> lock contention on the rstat lock, primarily caused by kswapd. The
>> specific mem_cgroup_flush_stats() call inlined in shrink_node, which
>> takes the rstat lock, is particularly problematic.
>>
>> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node, we
>> noted severe lock contention on the rstat lock, causing 12 CPUs to waste
>> cycles spinning every time kswapd runs. Fleet-wide stats (/proc/N/schedstat)
>> for kthreads revealed that we are burning an average of 20,000 CPU cores
>> fleet-wide on kswapd, primarily due to spinning on the rstat lock.
>>
>> Here's a brief overview of the issue:
>> - __alloc_pages_slowpath calls wake_all_kswapds, causing all kswapdN threads
>>    to wake up simultaneously.
>> - The kswapd thread invokes shrink_node (via balance_pgdat), triggering the
>>    cgroup rstat flush operation as part of its work.
>> - balance_pgdat() has a NULL value in target_mem_cgroup, causing
>>    mem_cgroup_flush_stats() to flush with root_mem_cgroup.
>>
>> The kernel previously addressed this with a "stats_flush_ongoing" concept,
>> which was removed in commit 7d7ef0a4686a ("mm: memcg: restore subtree stats
>> flushing"). This patch reintroduces and generalizes the concept to apply to
>> all users of cgroup rstat, not just memcg.
>>
>> If there is an ongoing rstat flush and the current cgroup is a descendant, a
>> new flush is unnecessary. To ensure callers still receive updated stats,
>> they wait for the ongoing flush to complete before returning, but with a
>> timeout, as stats may already be inaccurate due to continuous updates.
>>
>> Lock yielding causes complications for ongoing flushers. Therefore, we limit
>> which cgroup can become ongoing flusher to top-level, as lock yielding
>> allows others to obtain the lock without being the ongoing flusher, leading
>> to a situation where a cgroup that isn't a descendant obtains the lock via
>> yielding. Thus, we prefer an ongoing flusher with many descendants. If and
>> when the lock yielding is removed, such as when changing this to a mutex,
>> we can simplify this code.
>>
>> This change significantly reduces lock contention, especially in
>> environments with multiple NUMA nodes, thereby improving overall system
>> performance.
>>
>> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
>> ---
>> V8:
>>   - Updated subject+desc based on Yosry's feedback
>>   - Explain lock yielding challenges in comments
>>   - Limit ongoing flushers to cgrp level 0 and 1
>>
>> V7: https://lore.kernel.org/all/172070450139.2992819.13210624094367257881.stgit@firesoul
>> V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.stgit@firesoul/
>> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
>> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
>> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
>> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
>> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
>> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
>>
>>   include/linux/cgroup-defs.h |    2 +
>>   kernel/cgroup/rstat.c       |  114 ++++++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 104 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
>> index b36690ca0d3f..a33b37514c29 100644
>> --- a/include/linux/cgroup-defs.h
>> +++ b/include/linux/cgroup-defs.h
>> @@ -548,6 +548,8 @@ struct cgroup {
>>   #ifdef CONFIG_BPF_SYSCALL
>>          struct bpf_local_storage __rcu  *bpf_cgrp_storage;
>>   #endif
>> +       /* completion queue for cgrp_rstat_ongoing_flusher */
>> +       struct completion flush_done;
>>
>>          /* All ancestors including self */
>>          struct cgroup *ancestors[];
>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>> index fb8b49437573..eaa138f2da2f 100644
>> --- a/kernel/cgroup/rstat.c
>> +++ b/kernel/cgroup/rstat.c
>> @@ -2,6 +2,7 @@
>>   #include "cgroup-internal.h"
>>
>>   #include <linux/sched/cputime.h>
>> +#include <linux/completion.h>
>>
>>   #include <linux/bpf.h>
>>   #include <linux/btf.h>
>> @@ -11,6 +12,7 @@
>>
>>   static DEFINE_SPINLOCK(cgroup_rstat_lock);
>>   static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
>> +static struct cgroup *cgrp_rstat_ongoing_flusher = NULL;
>>
>>   static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
>>
>> @@ -279,17 +281,32 @@ __bpf_hook_end();
>>    * value -1 is used when obtaining the main lock else this is the CPU
>>    * number processed last.
>>    */
>> -static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop)
>> +static inline bool __cgroup_rstat_trylock(struct cgroup *cgrp, int cpu_in_loop)
>> +{
>> +       bool locked;
>> +
>> +       locked = spin_trylock_irq(&cgroup_rstat_lock);
>> +       if (!locked)
>> +               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, true);
>> +       else
>> +               trace_cgroup_rstat_locked(cgrp, cpu_in_loop, false);
>> +
>> +       return locked;
>> +}
>> +
>> +static inline void __cgroup_rstat_lock(struct cgroup *cgrp, int cpu_in_loop,
>> +                                      bool already_contended)
>>          __acquires(&cgroup_rstat_lock)
>>   {
>> -       bool contended;
>> +       bool locked = false;
>>
>> -       contended = !spin_trylock_irq(&cgroup_rstat_lock);
>> -       if (contended) {
>> -               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
>> +       if (already_contended) /* Skip trylock if already contended */
>> +               locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
> 
> Should this be the other way around?
> 

I think it is correct, but I used it wrong in once place, in
cgroup_rstat_flush_hold(), as cgroup_rstat_trylock_flusher() returning
false doesn't mean it was already_contended, but that ongoing flusher
"skipped" (and waited for) a flush.  I need to correct this.


>> +
>> +       if (!locked) {
>>                  spin_lock_irq(&cgroup_rstat_lock);
>> +               trace_cgroup_rstat_locked(cgrp, cpu_in_loop, true);
>>          }
>> -       trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>>   }
>>
>>   static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>> @@ -299,6 +316,72 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>          spin_unlock_irq(&cgroup_rstat_lock);
>>   }
>>
>> +#define MAX_WAIT       msecs_to_jiffies(100)
>> +/**
>> + * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
>> + * @cgrp: target cgroup
>> + *
>> + * Function return value follow trylock semantics. Returning true when lock is
>> + * obtained. Returning false when not locked and it detected flushing can be
>> + * skipped as another ongoing flusher took care of the flush.
>> + */
>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
>> +{
>> +       struct cgroup *ongoing;
>> +       bool locked;
>> +
>> +       /*
>> +        * Check if ongoing flusher is already taking care of this, if
>> +        * we are a descendant skip work, but wait for ongoing flusher
>> +        * to complete work.
>> +        */
>> +retry:
>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
> 
> The discussion about cgrp_rstat_ongoing_flusher possibly going away in
> parallel never reached a conclusion AFAICT. Should we use
> cgroup_tryget() here to get a ref on 'ongoing' until wait completes?

I like the cgroup_tryget() idea, but I though we needed to do this on
the 'cgrp' that will be waiting in the completion queue on 'ongoing'?

> This shouldn't add much complexity AFAICT.

> 
> I think just using RCU here wouldn't be enough as we can flush rstat
> after the RCU grace period when a cgroup is being freed.
> 
>> +               wait_for_completion_interruptible_timeout(
>> +                       &ongoing->flush_done, MAX_WAIT);
>> +               /* TODO: Add tracepoint here */
>> +               return false;
>> +       }
>> +
>> +       locked = __cgroup_rstat_trylock(cgrp, -1);
>> +       if (!locked) {
>> +               /* Contended: Handle losing race for ongoing flusher */
>> +               if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
>> +                       goto retry;
>> +
>> +               __cgroup_rstat_lock(cgrp, -1, true);
>> +       }
>> +       /*
>> +        * Obtained lock, record this cgrp as the ongoing flusher.
>> +        * Due to lock yielding, we might obtain lock while another
>> +        * ongoing flusher (that isn't a parent) owns ongoing_flusher.
>> +        */
>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>> +       if (!ongoing) {
> 
> I think we don't need protection here since we never dereference
> 'cgrp_rstat_ongoing_flusher', but I think it may be clearer to
> directly check it to make this obvious:
> 
> if (!READ_ONCE(cgrp_rstat_ongoing_flusher)) {
> 

Makes sense, but I use the 'ongoing' variable in the next patch in a
tracepoint to diagnose this happening.

> Perhaps we can also explicitly mention in the comment why we do not
> need any protection here, but I am not sure how helpful that will be.
> 
>> +               /*
>> +                * Limit to top-level as lock yielding allows others to obtain
>> +                * lock without being ongoing_flusher. Leading to cgroup that
>> +                * isn't descendant to obtain lock via yielding. So, prefer
>> +                * ongoing_flusher with many descendants.
>> +                */
>> +               if (cgrp->level < 2) {
> 
> This covers roots and top-level cgroups under them, right? Did them
> improve the numbers you were observing?
> 

The numbers from prod improved significantly, then cadvisor and kswapd
collide.
But cadvisor still flush a couple of level 1 cgroups, and can still
cause lock contention for level 0 and other non-decendent cgroups.

11:30:08 @ongoing_flusher_yield[0]: 68
@ongoing_flusher_cnt[kswapd11]: 4
@ongoing_flusher_cnt[kswapd2]: 4
@ongoing_flusher_cnt[kswapd5]: 4
@ongoing_flusher_cnt[handled_race]: 4
@ongoing_flusher_cnt[kswapd9]: 5
@ongoing_flusher_cnt[kswapd7]: 5
@ongoing_flusher_cnt[kswapd4]: 5
@ongoing_flusher_cnt[kswapd6]: 5
@ongoing_flusher_cnt[kswapd1]: 5
@ongoing_flusher_cnt[kswapd8]: 6
@ongoing_flusher_cnt[kswapd10]: 6
@ongoing_flusher_cnt[kswapd3]: 6
@ongoing_flusher_cnt[kswapd0]: 6
@ongoing_flusher_cnt[cadvisor]: 8
@ongoing_flusher_cnt[all]: 65
@cnt[tracepoint:cgroup:cgroup_ongoing_flusher_yield]: 4
@cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 26
@cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 60
@cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 475
@cnt[tracepoint:cgroup:cgroup_rstat_locked]: 1953
@lock_contended[normal, 1]: 2
@lock_contended[normal, 3]: 8
@lock_contended[normal, 0]: 16

We see that level 0 observe lock_contended 16 times, but we should
subtract 4 as that was "handled_race" cases. So 12 times, the root-cgrp
was spinning on the lock. In total (26-4) 22 times flushers contented on
the lock.  Given 475 flushes happen within this 1 sec period, every 2.1
ms, then I do call it it a significant reduction for lock contention.


> AFAICT, we can remove this restriction completely if/when we use a
> mutex and support a single ongoing flusher. If so, let's explicitly
> mention this, perhaps:
> 

Well... I'm still not convinced that it makes sense to have level >= 2
be the ongoing flusher.

E.g. if a level 2 cgroup becomes ongoing flusher, and kswapd starts 12
NUMA flushes at the same time, then the code will have these 12 kswapd
threads spin on the lock, until ongoing flusher finishes. That is likely
what happened above (for a level 1).  These 12 spinning (root) flushers
will not recheck ongoing_flusher and will all flush the root
(unnecessarily 11 times).

So, I don't think it is a good idea to have anything else that the root
as the ongoing flusher.

Can you explain/convince me why having sub-cgroups as ongoing flusher is
an advantage?

--Jesper

> XXX: Remove this restriction if/when lock yielding is removed
> 
>> +                       reinit_completion(&cgrp->flush_done);
>> +                       WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
>> +               }
>> +       }
>> +       return true;
>> +}
>> +
>> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
>> +{
>> +       if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher)) {
>> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
>> +               complete_all(&cgrp->flush_done);
>> +       }
>> +       __cgroup_rstat_unlock(cgrp, -1);
>> +}
>> +
>>   /* see cgroup_rstat_flush() */
>>   static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>>          __releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
>> @@ -328,7 +411,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>>                          __cgroup_rstat_unlock(cgrp, cpu);
>>                          if (!cond_resched())
>>                                  cpu_relax();
>> -                       __cgroup_rstat_lock(cgrp, cpu);
>> +                       __cgroup_rstat_lock(cgrp, cpu, false);
>>                  }
>>          }
>>   }
>> @@ -350,9 +433,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
>>   {
>>          might_sleep();
>>
>> -       __cgroup_rstat_lock(cgrp, -1);
>> +       if (!cgroup_rstat_trylock_flusher(cgrp))
>> +               return;
>> +
>>          cgroup_rstat_flush_locked(cgrp);
>> -       __cgroup_rstat_unlock(cgrp, -1);
>> +       cgroup_rstat_unlock_flusher(cgrp);
>>   }
>>
>>   /**
>> @@ -368,8 +453,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>          __acquires(&cgroup_rstat_lock)
>>   {
>>          might_sleep();
>> -       __cgroup_rstat_lock(cgrp, -1);
>> -       cgroup_rstat_flush_locked(cgrp);
>> +
>> +       if (cgroup_rstat_trylock_flusher(cgrp))
>> +               cgroup_rstat_flush_locked(cgrp);
>> +       else
>> +               __cgroup_rstat_lock(cgrp, -1, true);
>>   }
>>
>>   /**
>> @@ -379,7 +467,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>>          __releases(&cgroup_rstat_lock)
>>   {
>> -       __cgroup_rstat_unlock(cgrp, -1);
>> +       cgroup_rstat_unlock_flusher(cgrp);
>>   }
>>
>>   int cgroup_rstat_init(struct cgroup *cgrp)
>> @@ -401,6 +489,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
>>                  u64_stats_init(&rstatc->bsync);
>>          }
>>
>> +       init_completion(&cgrp->flush_done);
>> +
>>          return 0;
>>   }
>>
>>
>>
>>

