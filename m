Return-Path: <cgroups+bounces-3729-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A193380A
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 09:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800CA1F24C98
	for <lists+cgroups@lfdr.de>; Wed, 17 Jul 2024 07:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45191862A;
	Wed, 17 Jul 2024 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7OTDohT"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9C2156E4;
	Wed, 17 Jul 2024 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721201562; cv=none; b=GRP3H3Z+S/iyZLqADY6XWKroq56T7srjuL9aNl77cbfNJmOLqwrz67+02OPZjwgnPJXaSUOjD0PFFKga9Av7fKIxD8mUN7a0me2C/yv6cjmU83AfIhnLn/Aspt/qJgyXvDOfnr79jhQrcIU8QuWED/qDER7K+nrQe0Xaai3E1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721201562; c=relaxed/simple;
	bh=i27nxcDyiHOvPztArrC6qi+r4NctKNPp2sdUHmF2UlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LM6VLL6010Tx5qBlZnHaJXG3amW1Ns3hiI8rPgXvV3fB72A26zTotnL8m77rox9AH3Gc4ACg9+VCjM4OyuqD3g40tQq+mSBK2We/CQ1fuMpfGuJKnKwqsZGEKeIdPvD6uDThwTpgafPFAHiN8ph3Gqk3Rrczwr87eNVicQLR3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7OTDohT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6D6C32782;
	Wed, 17 Jul 2024 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721201562;
	bh=i27nxcDyiHOvPztArrC6qi+r4NctKNPp2sdUHmF2UlY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=E7OTDohTWPDcX0XWI1qjz9eM53TKC7tPxswuRA9Q18fE3szJmGa/WeGodbhj9ufdx
	 teEnkPW6D+qesX2mAiqco5B6n4YjMWp1SR9cqni1ocTJmwB+G7EE0Chn9JnXedZhX3
	 IUuWOSgQoPWozO6kcKha+aiUk/1whj2WLfnqt00EjhMU6FQZbC8m8GWKORkZR4NMD5
	 4stR8pIHxcANxVhuIdVq+9NBDt8fzTx2qMhBjLDtn37ZFfketb5JxQklATcTLvd+7T
	 h9lHq/AVZ6K1skj9H5FJQCV+Y8QPTYnfkw0lSarpqOGdv7qIJK5IkzdgdHh+4ExVRY
	 wN+dq2TMKgr3g==
Message-ID: <8c123882-a5c5-409a-938b-cb5aec9b9ab5@kernel.org>
Date: Wed, 17 Jul 2024 09:32:38 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Yosry Ahmed <yosryahmed@google.com>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev,
 hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com,
 kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <CAJD7tkYFwz_=kxCk-Tp4QfwKgK0C26+QzZQvbVxkAx8m9CLSFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/07/2024 02.30, Yosry Ahmed wrote:
> On Thu, Jul 11, 2024 at 6:28 AM Jesper Dangaard Brouer <hawk@kernel.org> wrote:
>>
>> Avoid lock contention on the global cgroup rstat lock caused by kswapd
>> starting on all NUMA nodes simultaneously. At Cloudflare, we observed
>> massive issues due to kswapd and the specific mem_cgroup_flush_stats()
>> call inlined in shrink_node, which takes the rstat lock.
>>
>> On our 12 NUMA node machines, each with a kswapd kthread per NUMA node,
>> we noted severe lock contention on the rstat lock. This contention
>> causes 12 CPUs to waste cycles spinning every time kswapd runs.
>> Fleet-wide stats (/proc/N/schedstat) for kthreads revealed that we are
>> burning an average of 20,000 CPU cores fleet-wide on kswapd, primarily
>> due to spinning on the rstat lock.
>>
>> Help reviewers follow code: __alloc_pages_slowpath calls wake_all_kswapds
>> causing all kswapdN threads to wake up simultaneously. The kswapd thread
>> invokes shrink_node (via balance_pgdat) triggering the cgroup rstat flush
>> operation as part of its work. This results in kernel self-induced rstat
>> lock contention by waking up all kswapd threads simultaneously. Leveraging
>> this detail: balance_pgdat() have NULL value in target_mem_cgroup, this
>> cause mem_cgroup_flush_stats() to do flush with root_mem_cgroup.
>>
>> To avoid this kind of thundering herd problem, kernel previously had a
>> "stats_flush_ongoing" concept, but this was removed as part of commit
>> 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing"). This patch
>> reintroduce and generalized the concept to apply to all users of cgroup
>> rstat, not just memcg.
>>
>> If there is an ongoing rstat flush, and current cgroup is a descendant,
>> then it is unnecessary to do the flush. For callers to still see updated
>> stats, wait for ongoing flusher to complete before returning, but add
>> timeout as stats are already inaccurate given updaters keeps running.
>>
>> Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
>> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> 
> Thanks for working on this, Jesper! I love the data you collected here!
> 
> I think the commit subject and message should be changed to better
> describe the patch. This is a patch that exclusively modifies cgroup
> code, yet the subject is about kswapd. This change affects all users
> of rstat flushing.
> 
> I think a better subject would be:
> "cgroup/rstat: avoid flushing if there is an ongoing overlapping
> flush" or similar.
> 
> The commit message should first describe the cgroup change, and then
> use kswapd as a brief example/illustration of how the problem
> manifests in practice. You should also include a brief summary of the
> numbers you collected from prod.
> 

I agree that description should be updated as patch have evolved, and
you suggestions make sense, thanks.

But I'm not sure we are finished evolving this patch, because the scheme
of allowing all sub-cgroups to become the ongoing flusher (and only
avoiding lock-spinning when cgroup_is_descendant), is causing issues in
production.

We are using cadvisor in production for collecting metrics, which walks
all the cgroups reading stat files e.g. io.stat, cpu.stat , memory.stat
(doing 3 flushes of same cgroup in short timespan), but individual
cgroups don't overlap much to benefit from ongoing_flusher scheme.

Below is (1 sec) production data, where cadvisor and kswapd collide:

 > 02:01:33 @ongoing_flusher_cnt[kworker/u395:14]: 1
 > @ongoing_flusher_cnt[kswapd5]: 3
 > @ongoing_flusher_cnt[kswapd7]: 4
 > @ongoing_flusher_cnt[kswapd6]: 4
 > @ongoing_flusher_cnt[kswapd8]: 4
 > @ongoing_flusher_cnt[kswapd9]: 5
 > @ongoing_flusher_cnt[kswapd2]: 5
 > @ongoing_flusher_cnt[kswapd10]: 5
 > @ongoing_flusher_cnt[kswapd3]: 5
 > @ongoing_flusher_cnt[kswapd11]: 5
 > @ongoing_flusher_cnt[kswapd0]: 5
 > @ongoing_flusher_cnt[kswapd4]: 6
 > @ongoing_flusher_cnt[kswapd1]: 7
 > @ongoing_flusher_cnt[cadvisor]: 9

For cadvisor ongoing_flusher only helps 9 times to avoid flush.

 > @ongoing_flusher_cnt[handled_race]: 18
 > @ongoing_flusher_cnt[all]: 61

Our ongoing_flusher scheme detects overlap and avoid 61 out of 462 flushes.

 > @cnt[tracepoint:cgroup:cgroup_ongoing_flusher_wait]: 61
 > @cnt[kfunc:vmlinux:cgroup_rstat_flush_locked]: 462
 > @cnt[tracepoint:cgroup:cgroup_rstat_lock_contended]: 9032

This is bad: Lock is contended 9032 time within this 1 sec period.
Below, lock_contended cases is captured in more detail.

 > @cnt[tracepoint:cgroup:cgroup_rstat_locked]: 9435
 > @lock_contended[normal, 4]: 1
 > @lock_contended[normal, 1]: 2
 > @lock_contended[normal, 3]: 6
 > @lock_contended[normal, 2]: 15
 > @lock_contended[yield, 4]: 49
 > @lock_contended[after_obtaining_lock, 4]: 49
 > @lock_contended[normal, 0]: 59

The "normal" lock_contended for level 0,
meaning the cgroup root is contended 59 times within this 1 sec period.

 > @lock_contended[after_obtaining_lock, 1]: 117
 > @lock_contended[yield, 1]: 118
 > @lock_contended[yield, 3]: 258
 > @lock_contended[after_obtaining_lock, 3]: 258
 > @lock_contended[after_obtaining_lock, 2]: 946
 > @lock_contended[yield, 2]: 946

Lock contention for 'yielded' case for level 2.
Goes crazy with 946/sec.

 > @lock_contended[yield, 0]: 7579

Lock contention for 'yielded' case for level 0, the root.
Is really crazy with 7579/sec lock spin cases.

 > @lock_contended[after_obtaining_lock, 0]: 7579


IMHO this shows that, due to lock yielding, the scheme of
ongoing_flusher for sub-trees only cause issues.

IMHO we should go back to only doing ongoing_flusher for root-cgroup.
There is really low chance of sub-trees flushes being concurrent enough
to benefit from this, and it cause issues and needs (ugly) race handling.

Further more sub-tree flushing doesn't take as long time as level 0
flushing, which further lower the chance of concurrent flushes.

Let's get some quick data on flush times from production, to support my
claim:

The bpftrace onliner:
  sudo bpftrace -e '
   tracepoint:cgroup:cgroup_rstat_locked {
    if (args->cpu == -1) { @start[tid]=nsecs; }
    @cnt[probe]=count();
    if (args->contended) {
      @lock_contended["after_obtaining_lock", args->level]=count();
    }}
   tracepoint:cgroup:cgroup_rstat_unlock {
    if (args->cpu == -1) {
     $now=nsecs; $start=@start[tid]; $diff=$now-$start;
     @locked_time_level[args->level]=hist($diff);
    }
    @cnt[probe]=count()}
   kfunc:cgroup_rstat_flush_locked {@cnt[probe]=count()}
   interval:s:1 {time("%H:%M:%S ");
    print(@cnt);
    print(@lock_contended);
    print(@locked_time_level);
    clear (@cnt);
    clear (@lock_contended); }
   END {clear(@start)}'

Time below is in nanosec.

@locked_time_level[0]:
[4M, 8M)             623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[8M, 16M)            860 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[16M, 32M)           295 |@@@@@@@@@@@@@@@@@ 
      |
[32M, 64M)           275 |@@@@@@@@@@@@@@@@ 
      |


@locked_time_level[1]:
[4K, 8K)               6 |@@@@ 
      |
[8K, 16K)             65 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[16K, 32K)            52 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[32K, 64K)            23 |@@@@@@@@@@@@@@@@@@ 
      |
[64K, 128K)           15 |@@@@@@@@@@@@ 
      |
[128K, 256K)          10 |@@@@@@@@ 
      |
[256K, 512K)           6 |@@@@ 
      |
[512K, 1M)            15 |@@@@@@@@@@@@ 
      |
[1M, 2M)               2 |@ 
      |
[2M, 4M)              14 |@@@@@@@@@@@ 
      |
[4M, 8M)               6 |@@@@ 
      |
[8M, 16M)              7 |@@@@@ 
      |
[16M, 32M)             1 | 
      |


@locked_time_level[2]:
[2K, 4K)               1 | 
      |
[4K, 8K)             160 |@@@@@@@@@ 
      |
[8K, 16K)            733 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
      |
[16K, 32K)           901 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)           191 |@@@@@@@@@@@ 
      |
[64K, 128K)          115 |@@@@@@ 
      |
[128K, 256K)          61 |@@@ 
      |
[256K, 512K)          70 |@@@@ 
      |
[512K, 1M)            59 |@@@ 
      |
[1M, 2M)              27 |@ 
      |
[2M, 4M)               9 | 
      |


@locked_time_level[3]:
[1K, 2K)               3 | 
      |
[2K, 4K)               2 | 
      |
[4K, 8K)               5 | 
      |
[8K, 16K)            147 |@@@@@@ 
      |
[16K, 32K)          1222 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)           266 |@@@@@@@@@@@ 
      |
[64K, 128K)          199 |@@@@@@@@ 
      |
[128K, 256K)         146 |@@@@@@ 
      |
[256K, 512K)         124 |@@@@@ 
      |
[512K, 1M)            17 | 
      |
[1M, 2M)               0 | 
      |
[2M, 4M)               0 | 
      |
[4M, 8M)               1 | 
      |


@locked_time_level[4]:
[4K, 8K)               2 |@@ 
      |
[8K, 16K)             17 |@@@@@@@@@@@@@@@@@@@@@@ 
      |
[16K, 32K)            40 
|@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32K, 64K)             4 |@@@@@ 
      |

--Jesper

>> ---
>> V6: https://lore.kernel.org/all/172052399087.2357901.4955042377343593447.stgit@firesoul/
>> V5: https://lore.kernel.org/all/171956951930.1897969.8709279863947931285.stgit@firesoul/
>> V4: https://lore.kernel.org/all/171952312320.1810550.13209360603489797077.stgit@firesoul/
>> V3: https://lore.kernel.org/all/171943668946.1638606.1320095353103578332.stgit@firesoul/
>> V2: https://lore.kernel.org/all/171923011608.1500238.3591002573732683639.stgit@firesoul/
>> V1: https://lore.kernel.org/all/171898037079.1222367.13467317484793748519.stgit@firesoul/
>> RFC: https://lore.kernel.org/all/171895533185.1084853.3033751561302228252.stgit@firesoul/
>>
>>   include/linux/cgroup-defs.h |    2 +
>>   kernel/cgroup/rstat.c       |   95 ++++++++++++++++++++++++++++++++++++++-----
>>   2 files changed, 85 insertions(+), 12 deletions(-)
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
>> index fb8b49437573..fe2a81a310bb 100644
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
>> +                                      bool check_contention)
>>          __acquires(&cgroup_rstat_lock)
>>   {
>> -       bool contended;
>> +       bool locked = false;
>>
>> -       contended = !spin_trylock_irq(&cgroup_rstat_lock);
>> -       if (contended) {
>> -               trace_cgroup_rstat_lock_contended(cgrp, cpu_in_loop, contended);
>> +       if (check_contention)
>> +               locked = __cgroup_rstat_trylock(cgrp, cpu_in_loop);
>> +
>> +       if (!locked) {
>>                  spin_lock_irq(&cgroup_rstat_lock);
>> +               trace_cgroup_rstat_locked(cgrp, cpu_in_loop, check_contention);
>>          }
>> -       trace_cgroup_rstat_locked(cgrp, cpu_in_loop, contended);
>>   }
> 
> I will let Tejun and others weigh in about what tracepoints we should
> have going forward and how they should be structured (which also
> includes patch 2). I see the tremendous value they have to collect
> data from prod, but I do not see similar existing tracepoints, and I
> am not sure if the branching here could have an effect when the
> tracepoints are off.
> 
>>
>>   static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>> @@ -299,6 +316,53 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
>>          spin_unlock_irq(&cgroup_rstat_lock);
>>   }
>>
>> +#define MAX_WAIT       msecs_to_jiffies(100)
>> +/* Trylock helper that also checks for on ongoing flusher */
>> +static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp)
>> +{
>> +       struct cgroup *ongoing;
>> +       bool locked;
>> +
>> +       /* Check if ongoing flusher is already taking care of this, if
> 
> nit: I think commonly the comment would start on a new line after /*.
> 
>> +        * we are a descendant skip work, but wait for ongoing flusher
>> +        * to complete work.
>> +        */
>> +retry:
>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing)) {
>> +               wait_for_completion_interruptible_timeout(
>> +                       &ongoing->flush_done, MAX_WAIT);
>> +               /* TODO: Add tracepoint here */
>> +               return false;
>> +       }
>> +
>> +       locked = __cgroup_rstat_trylock(cgrp, -1);
>> +       if (!locked) {
>> +               /* Contended: Handle loosing race for ongoing flusher */
> 
> nit: losing
> 
>> +               if (!ongoing && READ_ONCE(cgrp_rstat_ongoing_flusher))
>> +                       goto retry;
>> +
>> +               __cgroup_rstat_lock(cgrp, -1, false);
>> +       }
>> +       /* Obtained lock, record this cgrp as the ongoing flusher */
> 
> Do we want a comment here to explain why there could be an existing
> ongoing flusher (i.e. due to multiple ongoing flushers)? I think it's
> not super obvious.
> 
>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
>> +       if (!ongoing) {
>> +               reinit_completion(&cgrp->flush_done);
>> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher, cgrp);
>> +       }
>> +       return true; /* locked */
> 
> Would it be better to explain the return value of the function in the
> comment above it?
> 
>> +}
>> +
>> +static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
>> +{
>> +       /* Detect if we are the ongoing flusher */
> 
> I think this is a bit obvious.
> 
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
>> @@ -328,7 +392,7 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
>>                          __cgroup_rstat_unlock(cgrp, cpu);
>>                          if (!cond_resched())
>>                                  cpu_relax();
>> -                       __cgroup_rstat_lock(cgrp, cpu);
>> +                       __cgroup_rstat_lock(cgrp, cpu, true);
>>                  }
>>          }
>>   }
>> @@ -350,9 +414,11 @@ __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
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
>> @@ -368,8 +434,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>          __acquires(&cgroup_rstat_lock)
>>   {
>>          might_sleep();
>> -       __cgroup_rstat_lock(cgrp, -1);
>> -       cgroup_rstat_flush_locked(cgrp);
>> +
>> +       if (cgroup_rstat_trylock_flusher(cgrp))
>> +               cgroup_rstat_flush_locked(cgrp);
>> +       else
>> +               __cgroup_rstat_lock(cgrp, -1, false);
>>   }
>>
>>   /**
>> @@ -379,7 +448,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
>>   void cgroup_rstat_flush_release(struct cgroup *cgrp)
>>          __releases(&cgroup_rstat_lock)
>>   {
>> -       __cgroup_rstat_unlock(cgrp, -1);
>> +       cgroup_rstat_unlock_flusher(cgrp);
>>   }
>>
>>   int cgroup_rstat_init(struct cgroup *cgrp)
>> @@ -401,6 +470,8 @@ int cgroup_rstat_init(struct cgroup *cgrp)
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

