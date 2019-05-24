Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45E9029A1A
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391470AbfEXOcW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 10:32:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25068 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391500AbfEXOcV (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 24 May 2019 10:32:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E7FB0317917B;
        Fri, 24 May 2019 14:32:10 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-116-199.phx2.redhat.com [10.3.116.199])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2CF7D90E;
        Fri, 24 May 2019 14:32:06 +0000 (UTC)
Date:   Fri, 24 May 2019 10:32:04 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Dave Chiluk <chiluk+linux@indeed.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] sched/fair: Fix low cpu usage with high
 throttling by removing expiration of cpu-local slices
Message-ID: <20190524143204.GB4684@lorien.usersys.redhat.com>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-2-git-send-email-chiluk+linux@indeed.com>
 <CAFTs51W0KdK4nw6wydn2HjNYvFRC8DYMmVeKX9FAe+4YUGEAZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51W0KdK4nw6wydn2HjNYvFRC8DYMmVeKX9FAe+4YUGEAZg@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Fri, 24 May 2019 14:32:21 +0000 (UTC)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 23, 2019 at 02:01:58PM -0700 Peter Oskolkov wrote:
> On Thu, May 23, 2019 at 11:44 AM Dave Chiluk <chiluk+linux@indeed.com> wrote:
> >
> > It has been observed, that highly-threaded, non-cpu-bound applications
> > running under cpu.cfs_quota_us constraints can hit a high percentage of
> > periods throttled while simultaneously not consuming the allocated
> > amount of quota.  This use case is typical of user-interactive non-cpu
> > bound applications, such as those running in kubernetes or mesos when
> > run on multiple cpu cores.
> >
> > This has been root caused to threads being allocated per cpu bandwidth
> > slices, and then not fully using that slice within the period. At which
> > point the slice and quota expires.  This expiration of unused slice
> > results in applications not being able to utilize the quota for which
> > they are allocated.
> >
> > The expiration of per-cpu slices was recently fixed by
> > 'commit 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift
> > condition")'.  Prior to that it appears that this has been broken since
> > at least 'commit 51f2176d74ac ("sched/fair: Fix unlocked reads of some
> > cfs_b->quota/period")' which was introduced in v3.16-rc1 in 2014.  That
> > added the following conditional which resulted in slices never being
> > expired.
> >
> > if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
> >         /* extend local deadline, drift is bounded above by 2 ticks */
> >         cfs_rq->runtime_expires += TICK_NSEC;
> >
> > Because this was broken for nearly 5 years, and has recently been fixed
> > and is now being noticed by many users running kubernetes
> > (https://github.com/kubernetes/kubernetes/issues/67577) it is my opinion
> > that the mechanisms around expiring runtime should be removed
> > altogether.
> >
> > This allows only per-cpu slices to live longer than the period boundary.
> > This allows threads on runqueues that do not use much CPU to continue to
> > use their remaining slice over a longer period of time than
> > cpu.cfs_period_us. However, this helps prevents the above condition of
> > hitting throttling while also not fully utilizing your cpu quota.
> >
> > This theoretically allows a machine to use slightly more than it's
> > allotted quota in some periods.  This overflow would be bounded by the
> > remaining per-cpu slice that was left un-used in the previous period.
> > For CPU bound tasks this will change nothing, as they should
> > theoretically fully utilize all of their quota and slices in each
> > period. For user-interactive tasks as described above this provides a
> > much better user/application experience as their cpu utilization will
> > more closely match the amount they requested when they hit throttling.
> >
> > This greatly improves performance of high-thread-count, non-cpu bound
> > applications with low cfs_quota_us allocation on high-core-count
> > machines. In the case of an artificial testcase, this performance
> > discrepancy has been observed to be almost 30x performance improvement,
> > while still maintaining correct cpu quota restrictions albeit over
> > longer time intervals than cpu.cfs_period_us.
> 
> If the machine runs at/close to capacity, won't the overallocation
> of the quota to bursty tasks necessarily negatively impact every other
> task? Should the "unused" quota be available only on idle CPUs?
> (Or maybe this is the behavior achieved here, and only the comment and
> the commit message should be fixed...)
>

It's bounded by the amount left unused from the previous period. So
theoretically a process could use almost twice its quota. But then it
would have nothing left over in the next period. To repeat it would have
to not use any that next period. Over a longer number of periods it's the
same amount of CPU usage.

I think that is more fair than throttling a process that has never used
its full quota.

And it removes complexity. 

Cheers,
Phil

> >  That testcase is
> > available at https://github.com/indeedeng/fibtest.
> >
> > Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
> > Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
> > ---
> >  Documentation/scheduler/sched-bwc.txt | 29 +++++++++++---
> >  kernel/sched/fair.c                   | 71 +++--------------------------------
> >  kernel/sched/sched.h                  |  4 --
> >  3 files changed, 29 insertions(+), 75 deletions(-)
> >
> > diff --git a/Documentation/scheduler/sched-bwc.txt b/Documentation/scheduler/sched-bwc.txt
> > index f6b1873..4ded8ae 100644
> > --- a/Documentation/scheduler/sched-bwc.txt
> > +++ b/Documentation/scheduler/sched-bwc.txt
> > @@ -8,16 +8,33 @@ CFS bandwidth control is a CONFIG_FAIR_GROUP_SCHED extension which allows the
> >  specification of the maximum CPU bandwidth available to a group or hierarchy.
> >
> >  The bandwidth allowed for a group is specified using a quota and period. Within
> > -each given "period" (microseconds), a group is allowed to consume only up to
> > -"quota" microseconds of CPU time.  When the CPU bandwidth consumption of a
> > -group exceeds this limit (for that period), the tasks belonging to its
> > -hierarchy will be throttled and are not allowed to run again until the next
> > -period.
> > +each given "period" (microseconds), a task group is allocated up to "quota"
> > +microseconds of CPU time.  When the CPU bandwidth consumption of a group
> > +exceeds this limit (for that period), the tasks belonging to its hierarchy will
> > +be throttled and are not allowed to run again until the next period.
> >
> >  A group's unused runtime is globally tracked, being refreshed with quota units
> >  above at each period boundary.  As threads consume this bandwidth it is
> >  transferred to cpu-local "silos" on a demand basis.  The amount transferred
> > -within each of these updates is tunable and described as the "slice".
> > +within each of these updates is tunable and described as the "slice".  Slices
> > +that are allocated to cpu-local silos do not expire at the end of the period,
> > +but unallocated quota does.  This doesn't affect cpu-bound applications as they
> > +by definition consume all of their bandwidth in each each period.
> > +
> > +However for highly-threaded user-interactive/non-cpu bound applications this
> > +non-expiration nuance allows applications to burst past their quota limits
> > +equal to the amount of unused slice per cpu that the task group is running on.
> > +This slight burst requires that quota had gone unused in previous periods.
> > +Additionally this burst amount is limited to the size of a slice for every cpu
> > +a task group is run on.  As a result, this mechanism still strictly limits the
> > +task group to quota average usage over a longer time windows.  This provides
> > +better more predictable user experience for highly threaded applications with
> > +small quota limits on high core count machines.  It also eliminates the
> > +propensity to throttle these applications while simultanously using less than
> > +quota amounts of cpu.  Another way to say this, is that by allowing the unused
> > +portion of a slice to be used in following periods we have decreased the
> > +possibility of wasting unused quota on cpu-local silos that don't need much cpu
> > +time.
> >
> >  Management
> >  ----------
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index f35930f..a675c69 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4295,8 +4295,6 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
> >
> >         now = sched_clock_cpu(smp_processor_id());
> >         cfs_b->runtime = cfs_b->quota;
> > -       cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
> > -       cfs_b->expires_seq++;
> >  }
> >
> >  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> > @@ -4318,8 +4316,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> >  {
> >         struct task_group *tg = cfs_rq->tg;
> >         struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
> > -       u64 amount = 0, min_amount, expires;
> > -       int expires_seq;
> > +       u64 amount = 0, min_amount;
> >
> >         /* note: this is a positive sum as runtime_remaining <= 0 */
> >         min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
> > @@ -4336,61 +4333,17 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> >                         cfs_b->idle = 0;
> >                 }
> >         }
> > -       expires_seq = cfs_b->expires_seq;
> > -       expires = cfs_b->runtime_expires;
> >         raw_spin_unlock(&cfs_b->lock);
> >
> >         cfs_rq->runtime_remaining += amount;
> > -       /*
> > -        * we may have advanced our local expiration to account for allowed
> > -        * spread between our sched_clock and the one on which runtime was
> > -        * issued.
> > -        */
> > -       if (cfs_rq->expires_seq != expires_seq) {
> > -               cfs_rq->expires_seq = expires_seq;
> > -               cfs_rq->runtime_expires = expires;
> > -       }
> >
> >         return cfs_rq->runtime_remaining > 0;
> >  }
> >
> > -/*
> > - * Note: This depends on the synchronization provided by sched_clock and the
> > - * fact that rq->clock snapshots this value.
> > - */
> > -static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> > -{
> > -       struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
> > -
> > -       /* if the deadline is ahead of our clock, nothing to do */
> > -       if (likely((s64)(rq_clock(rq_of(cfs_rq)) - cfs_rq->runtime_expires) < 0))
> > -               return;
> > -
> > -       if (cfs_rq->runtime_remaining < 0)
> > -               return;
> > -
> > -       /*
> > -        * If the local deadline has passed we have to consider the
> > -        * possibility that our sched_clock is 'fast' and the global deadline
> > -        * has not truly expired.
> > -        *
> > -        * Fortunately we can check determine whether this the case by checking
> > -        * whether the global deadline(cfs_b->expires_seq) has advanced.
> > -        */
> > -       if (cfs_rq->expires_seq == cfs_b->expires_seq) {
> > -               /* extend local deadline, drift is bounded above by 2 ticks */
> > -               cfs_rq->runtime_expires += TICK_NSEC;
> > -       } else {
> > -               /* global deadline is ahead, expiration has passed */
> > -               cfs_rq->runtime_remaining = 0;
> > -       }
> > -}
> > -
> >  static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
> >  {
> >         /* dock delta_exec before expiring quota (as it could span periods) */
> >         cfs_rq->runtime_remaining -= delta_exec;
> > -       expire_cfs_rq_runtime(cfs_rq);
> >
> >         if (likely(cfs_rq->runtime_remaining > 0))
> >                 return;
> > @@ -4581,8 +4534,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >                 resched_curr(rq);
> >  }
> >
> > -static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
> > -               u64 remaining, u64 expires)
> > +static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
> >  {
> >         struct cfs_rq *cfs_rq;
> >         u64 runtime;
> > @@ -4604,7 +4556,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
> >                 remaining -= runtime;
> >
> >                 cfs_rq->runtime_remaining += runtime;
> > -               cfs_rq->runtime_expires = expires;
> >
> >                 /* we check whether we're throttled above */
> >                 if (cfs_rq->runtime_remaining > 0)
> > @@ -4629,7 +4580,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
> >   */
> >  static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
> >  {
> > -       u64 runtime, runtime_expires;
> > +       u64 runtime;
> >         int throttled;
> >
> >         /* no need to continue the timer with no bandwidth constraint */
> > @@ -4657,8 +4608,6 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
> >         /* account preceding periods in which throttling occurred */
> >         cfs_b->nr_throttled += overrun;
> >
> > -       runtime_expires = cfs_b->runtime_expires;
> > -
> >         /*
> >          * This check is repeated as we are holding onto the new bandwidth while
> >          * we unthrottle. This can potentially race with an unthrottled group
> > @@ -4671,8 +4620,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
> >                 cfs_b->distribute_running = 1;
> >                 raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >                 /* we can't nest cfs_b->lock while distributing bandwidth */
> > -               runtime = distribute_cfs_runtime(cfs_b, runtime,
> > -                                                runtime_expires);
> > +               runtime = distribute_cfs_runtime(cfs_b, runtime);
> >                 raw_spin_lock_irqsave(&cfs_b->lock, flags);
> >
> >                 cfs_b->distribute_running = 0;
> > @@ -4749,8 +4697,7 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> >                 return;
> >
> >         raw_spin_lock(&cfs_b->lock);
> > -       if (cfs_b->quota != RUNTIME_INF &&
> > -           cfs_rq->runtime_expires == cfs_b->runtime_expires) {
> > +       if (cfs_b->quota != RUNTIME_INF) {
> >                 cfs_b->runtime += slack_runtime;
> >
> >                 /* we are under rq->lock, defer unthrottling using a timer */
> > @@ -4783,7 +4730,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >  {
> >         u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
> >         unsigned long flags;
> > -       u64 expires;
> >
> >         /* confirm we're still not at a refresh boundary */
> >         raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > @@ -4800,7 +4746,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >         if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
> >                 runtime = cfs_b->runtime;
> >
> > -       expires = cfs_b->runtime_expires;
> >         if (runtime)
> >                 cfs_b->distribute_running = 1;
> >
> > @@ -4809,11 +4754,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
> >         if (!runtime)
> >                 return;
> >
> > -       runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
> > +       runtime = distribute_cfs_runtime(cfs_b, runtime);
> >
> >         raw_spin_lock_irqsave(&cfs_b->lock, flags);
> > -       if (expires == cfs_b->runtime_expires)
> > -               lsub_positive(&cfs_b->runtime, runtime);
> >         cfs_b->distribute_running = 0;
> >         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
> >  }
> > @@ -4969,8 +4912,6 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> >
> >         cfs_b->period_active = 1;
> >         overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> > -       cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
> > -       cfs_b->expires_seq++;
> >         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> >  }
> >
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index b52ed1a..0c0ed23 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -341,8 +341,6 @@ struct cfs_bandwidth {
> >         u64                     quota;
> >         u64                     runtime;
> >         s64                     hierarchical_quota;
> > -       u64                     runtime_expires;
> > -       int                     expires_seq;
> >
> >         short                   idle;
> >         short                   period_active;
> > @@ -562,8 +560,6 @@ struct cfs_rq {
> >
> >  #ifdef CONFIG_CFS_BANDWIDTH
> >         int                     runtime_enabled;
> > -       int                     expires_seq;
> > -       u64                     runtime_expires;
> >         s64                     runtime_remaining;
> >
> >         u64                     throttled_clock;
> > --
> > 1.8.3.1
> >

-- 
