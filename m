Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F917011
	for <lists+cgroups@lfdr.de>; Wed,  8 May 2019 06:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbfEHE0m (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 May 2019 00:26:42 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55455 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfEHE0m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 May 2019 00:26:42 -0400
Received: by mail-it1-f196.google.com with SMTP id q132so1870390itc.5
        for <cgroups@vger.kernel.org>; Tue, 07 May 2019 21:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=xKzx3zkj1Sp6PdbcGNd0a/ApQl4fGkKSYj9cS4BfMSk=;
        b=AVRq6Y+TCsLKX070hYsTfj2UvZI2fC2giRq/kgHidVsh+fC5xfp04CofqjK8VyJg4x
         tAsVZednIyttljvnBExPyDH41E8S/CHmm2DI+mn8n9Xq+e9nZ7z2KM0yPtWjz3YbpN72
         8ju9eAYRdLYhX3Bh6dmyOVZdwgpEA8PNYwO0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=xKzx3zkj1Sp6PdbcGNd0a/ApQl4fGkKSYj9cS4BfMSk=;
        b=QQG9zcft9hZswpIbMb0zs89QCHH7lHvv3rXFMZjbk576V1Sl2TLcE6Db3jkiGCkR7B
         XlRYNgaVd5nc210wpFrNVfBgEFbrfzofwaglrPMQ6Upjvv88e6Oq1PgGAdoKdh26jZbD
         Z3I0294dfgEIQ/6UrQL2rLZ3Lm6oaC1cnV1vrC89ONV3M91L155gu3p2jdnAoiVd0gYi
         Z4zAfYrrRq0ypE1y8eY82PatyVPlrDdSoBluLJaRvbsV0qPD4d3xHCtou605G5hwsh9F
         KMULMiCR36PwF8aSafPeexqxToAS/CDIDIrtlJlNzVhIvTAFYmCfDhTpyauoGKllWAqR
         Y83w==
X-Gm-Message-State: APjAAAUORucaUXA8Tao0485zpEm3+4uJJThEZ4PzYvodMjQ5DtyKRfXV
        glW63OIrDJamPTcEA4nq/rvzF1T0s7aDp6DWyXUMpA==
X-Google-Smtp-Source: APXvYqzl42uCS+d1uHNtnlQR2Q1wbrTYyT5+uKYCKrUp2wMkWVTzOb5OTgIYhJKvyU8JsM3Maeev7IgVh5Jg+/+PTGc=
X-Received: by 2002:a24:c455:: with SMTP id v82mr1902076itf.143.1557289600776;
 Tue, 07 May 2019 21:26:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAC=E7cV_2QtXQ-mx4-GfHLyAWxW+7Ub75UmMvOLxLXzot47TWw@mail.gmail.com>
 <1554934850-7002-1-git-send-email-chiluk+linux@indeed.com> <1554934850-7002-2-git-send-email-chiluk+linux@indeed.com>
In-Reply-To: <1554934850-7002-2-git-send-email-chiluk+linux@indeed.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Tue, 7 May 2019 23:26:14 -0500
Message-ID: <CAC=E7cVoiS=Z7fYCmgCe0iqHLx7hqo2ECZ3JC7pBOyvQu7yhQw@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Fix low cpu usage with high throttling by
 removing slice expiration
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

I'd really appreciate some attention on this.  Should I have marked
the subject as sched: instead?

I heard through some back-channels that there may be concern with the
ability to use more cpu than allocated in a given period.  To that I
say,
#1 The current behavior of an application hitting cpu throttling while
simultaneously accounting for much less cpu time than was allocated is
a very poor user experience. i.e. granted .5 cpu, but only used .1 cpu
while simultaneously hitting throttling.
#2 This has been broken like this since at least 3.16-rc1 which is why
I ripped out most of the logic instead of trying to patch it again.  I
proved this experimentally by adding a counter in
expire_cfs_rq_runtime when runtime is expired.  I can share the
patches if that would help.  That means that user-interactive
applications have been able to over-use quota in a similar manner
since June 2014, and no one has noticed or complained.  Now that the
mechanism is "fixed" people are starting to notice and they are
complaining loudly.  See
https://github.com/kubernetes/kubernetes/issues/67577 and the many
linked tickets to that one.
#3 Even though it's true that you can use more cpu than allocated in a
period, that would require that you under-use quota in previous
periods equal to the overage.  In effect you are still enforcing the
quota requirements albeit over longer time-frames than cfs_period_us
*(I'm amenable to a documentation update to fix this nuance).
Additionally any single cpu run queue can only over-use by as much as
sched_cfs_bandwidth_slice_us which defaults to 5ms.  So other
applications on the same processor will at most be hindered by that
amount.
#4 cpu-bound applications will not be able to over-use in any period,
as the entirety of their quota will be consumed every period.

Your review would be much appreciated.
Thank you,
Dave


On Wed, Apr 10, 2019 at 5:21 PM Dave Chiluk <chiluk+linux@indeed.com> wrote:
>
> It has been observed, that highly-threaded, non-cpu-bound applications
> running under cpu.cfs_quota_us constraints can hit a high percentage of
> periods throttled while simultaneously not consuming the allocated
> amount of quota.  This use case is typical of user-interactive non-cpu
> bound web services, such as those running in kubernetes or mesos.
>
> This has been root caused to threads being allocated per cpu bandwidth
> slices, and then not fully using that slice within the period, and then
> having that quota expire.  This constant expiration of unused quota
> results applications not being able to utilize the quota for which they
> are allocated.
>
> The expiration of quota was recently fixed by commit 512ac999d275
> ("sched/fair: Fix bandwidth timer clock drift condition"). Prior to that
> it appears that this has been broken since a least commit 51f2176d74ac
> ("sched/fair: Fix unlocked reads of some cfs_b->quota/period") which was
> introduced in v3.16-rc1 in 2014.  That commit added the following
> testcase which resulted in runtime never being expired.
>
> if (cfs_rq->runtime_expires != cfs_b->runtime_expires) {
>         /* extend local deadline, drift is bounded above by 2 ticks */
>         cfs_rq->runtime_expires += TICK_NSEC;
>
> Because this was broken for nearly 5 years, and has recently been fixed
> and is now being noticed by many users running kubernetes
> (https://github.com/kubernetes/kubernetes/issues/67577) it is my opinion
> that the mechanisms around expiring runtime should be removed
> altogether.
>
> This allows quota runtime slices allocated to per-cpu runqueues to live
> longer than the period boundary.  This allows threads on runqueues that
> do not use much CPU to continue to use their remaining slice over a
> longer period of time than cpu.cfs_period_us. However, this helps
> prevents the above condition of hitting throttling while also not fully
> utilizing your cpu quota.
>
> This theoretically allows a machine to use slightly more than it's
> allotted quota in some periods.  This overflow would be equal to the
> amount of quota that was left un-used on cfs_rq's in the previous
> period.  For CPU bound tasks this will change nothing, as they should
> theoretically fully utilize all of their quota in each period. For
> user-interactive tasks as described above this provides a much better
> user/application experience as their cpu utilization will more closely
> match the amount they requested when they hit throttling.
>
> This greatly improves performance of high-thread-count, interactive
> applications with low cfs_quota_us allocation on high-core-count
> machines. In the case of an artificial testcase, this performance
> discrepancy has been observed to be almost 30x performance improvement,
> while still maintaining correct cpu quota restrictions albeit over
> longer time intervals than cpu.cfs_period_us.
>
> Fixes: 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift condition")
> Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
> ---
>  kernel/sched/fair.c  | 71 +++++-----------------------------------------------
>  kernel/sched/sched.h |  4 ---
>  2 files changed, 6 insertions(+), 69 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index fdab7eb..b0c3d76 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4291,8 +4291,6 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>
>         now = sched_clock_cpu(smp_processor_id());
>         cfs_b->runtime = cfs_b->quota;
> -       cfs_b->runtime_expires = now + ktime_to_ns(cfs_b->period);
> -       cfs_b->expires_seq++;
>  }
>
>  static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
> @@ -4314,8 +4312,7 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>  {
>         struct task_group *tg = cfs_rq->tg;
>         struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(tg);
> -       u64 amount = 0, min_amount, expires;
> -       int expires_seq;
> +       u64 amount = 0, min_amount;
>
>         /* note: this is a positive sum as runtime_remaining <= 0 */
>         min_amount = sched_cfs_bandwidth_slice() - cfs_rq->runtime_remaining;
> @@ -4332,61 +4329,17 @@ static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>                         cfs_b->idle = 0;
>                 }
>         }
> -       expires_seq = cfs_b->expires_seq;
> -       expires = cfs_b->runtime_expires;
>         raw_spin_unlock(&cfs_b->lock);
>
>         cfs_rq->runtime_remaining += amount;
> -       /*
> -        * we may have advanced our local expiration to account for allowed
> -        * spread between our sched_clock and the one on which runtime was
> -        * issued.
> -        */
> -       if (cfs_rq->expires_seq != expires_seq) {
> -               cfs_rq->expires_seq = expires_seq;
> -               cfs_rq->runtime_expires = expires;
> -       }
>
>         return cfs_rq->runtime_remaining > 0;
>  }
>
> -/*
> - * Note: This depends on the synchronization provided by sched_clock and the
> - * fact that rq->clock snapshots this value.
> - */
> -static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
> -{
> -       struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
> -
> -       /* if the deadline is ahead of our clock, nothing to do */
> -       if (likely((s64)(rq_clock(rq_of(cfs_rq)) - cfs_rq->runtime_expires) < 0))
> -               return;
> -
> -       if (cfs_rq->runtime_remaining < 0)
> -               return;
> -
> -       /*
> -        * If the local deadline has passed we have to consider the
> -        * possibility that our sched_clock is 'fast' and the global deadline
> -        * has not truly expired.
> -        *
> -        * Fortunately we can check determine whether this the case by checking
> -        * whether the global deadline(cfs_b->expires_seq) has advanced.
> -        */
> -       if (cfs_rq->expires_seq == cfs_b->expires_seq) {
> -               /* extend local deadline, drift is bounded above by 2 ticks */
> -               cfs_rq->runtime_expires += TICK_NSEC;
> -       } else {
> -               /* global deadline is ahead, expiration has passed */
> -               cfs_rq->runtime_remaining = 0;
> -       }
> -}
> -
>  static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
>  {
>         /* dock delta_exec before expiring quota (as it could span periods) */
>         cfs_rq->runtime_remaining -= delta_exec;
> -       expire_cfs_rq_runtime(cfs_rq);
>
>         if (likely(cfs_rq->runtime_remaining > 0))
>                 return;
> @@ -4577,8 +4530,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
>                 resched_curr(rq);
>  }
>
> -static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
> -               u64 remaining, u64 expires)
> +static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b, u64 remaining)
>  {
>         struct cfs_rq *cfs_rq;
>         u64 runtime;
> @@ -4600,7 +4552,6 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>                 remaining -= runtime;
>
>                 cfs_rq->runtime_remaining += runtime;
> -               cfs_rq->runtime_expires = expires;
>
>                 /* we check whether we're throttled above */
>                 if (cfs_rq->runtime_remaining > 0)
> @@ -4625,7 +4576,7 @@ static u64 distribute_cfs_runtime(struct cfs_bandwidth *cfs_b,
>   */
>  static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, unsigned long flags)
>  {
> -       u64 runtime, runtime_expires;
> +       u64 runtime;
>         int throttled;
>
>         /* no need to continue the timer with no bandwidth constraint */
> @@ -4653,8 +4604,6 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
>         /* account preceding periods in which throttling occurred */
>         cfs_b->nr_throttled += overrun;
>
> -       runtime_expires = cfs_b->runtime_expires;
> -
>         /*
>          * This check is repeated as we are holding onto the new bandwidth while
>          * we unthrottle. This can potentially race with an unthrottled group
> @@ -4667,8 +4616,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
>                 cfs_b->distribute_running = 1;
>                 raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>                 /* we can't nest cfs_b->lock while distributing bandwidth */
> -               runtime = distribute_cfs_runtime(cfs_b, runtime,
> -                                                runtime_expires);
> +               runtime = distribute_cfs_runtime(cfs_b, runtime);
>                 raw_spin_lock_irqsave(&cfs_b->lock, flags);
>
>                 cfs_b->distribute_running = 0;
> @@ -4745,8 +4693,7 @@ static void __return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>                 return;
>
>         raw_spin_lock(&cfs_b->lock);
> -       if (cfs_b->quota != RUNTIME_INF &&
> -           cfs_rq->runtime_expires == cfs_b->runtime_expires) {
> +       if (cfs_b->quota != RUNTIME_INF) {
>                 cfs_b->runtime += slack_runtime;
>
>                 /* we are under rq->lock, defer unthrottling using a timer */
> @@ -4779,7 +4726,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  {
>         u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
>         unsigned long flags;
> -       u64 expires;
>
>         /* confirm we're still not at a refresh boundary */
>         raw_spin_lock_irqsave(&cfs_b->lock, flags);
> @@ -4796,7 +4742,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>         if (cfs_b->quota != RUNTIME_INF && cfs_b->runtime > slice)
>                 runtime = cfs_b->runtime;
>
> -       expires = cfs_b->runtime_expires;
>         if (runtime)
>                 cfs_b->distribute_running = 1;
>
> @@ -4805,11 +4750,9 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>         if (!runtime)
>                 return;
>
> -       runtime = distribute_cfs_runtime(cfs_b, runtime, expires);
> +       runtime = distribute_cfs_runtime(cfs_b, runtime);
>
>         raw_spin_lock_irqsave(&cfs_b->lock, flags);
> -       if (expires == cfs_b->runtime_expires)
> -               lsub_positive(&cfs_b->runtime, runtime);
>         cfs_b->distribute_running = 0;
>         raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
>  }
> @@ -4940,8 +4883,6 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
>
>         cfs_b->period_active = 1;
>         overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> -       cfs_b->runtime_expires += (overrun + 1) * ktime_to_ns(cfs_b->period);
> -       cfs_b->expires_seq++;
>         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index efa686e..69d9bf9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -341,8 +341,6 @@ struct cfs_bandwidth {
>         u64                     quota;
>         u64                     runtime;
>         s64                     hierarchical_quota;
> -       u64                     runtime_expires;
> -       int                     expires_seq;
>
>         short                   idle;
>         short                   period_active;
> @@ -562,8 +560,6 @@ struct cfs_rq {
>
>  #ifdef CONFIG_CFS_BANDWIDTH
>         int                     runtime_enabled;
> -       int                     expires_seq;
> -       u64                     runtime_expires;
>         s64                     runtime_remaining;
>
>         u64                     throttled_clock;
> --
> 1.8.3.1
>
