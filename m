Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B063014B
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 19:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfE3RyK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 13:54:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36030 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfE3RyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 13:54:04 -0400
Received: by mail-it1-f195.google.com with SMTP id e184so10831996ite.1
        for <cgroups@vger.kernel.org>; Thu, 30 May 2019 10:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GuxcT4bNE7Lanuh6HBPPFB8YOlbNRYRQt9yxyQj+Xf4=;
        b=tIyoSAMNQKihKq0XyVCx7ExyCL+KbWQErT3Pr6vbWiL8Ve+1visWW3DAUyOry/zGpU
         +HwNcVdCrXF9Kzgr8gsRW0AhZhoZ+n5q8ZGdQFKCrASp6D5KxtAUH0e6rQ9eXiG2Z7dv
         TfHhAkrNfrt2LDcEqaD12uez5QTXOKfuFmB5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GuxcT4bNE7Lanuh6HBPPFB8YOlbNRYRQt9yxyQj+Xf4=;
        b=RVn7p8jpAs8MJvjklXmJpBNCmTCumQe9L3GzKVVcrTKUikL2pQbFp8O2Hon5CrA5Jm
         UvzeCc6XN1TvX4Ho9mcnE3J70T9kynei7MgFfSxy2S+gZ0hPfeBKQ/FAmx3e+K3h7+kO
         I9+kAzzkOzwUz4qxKeHG/yvNOBb38nRBZJbFZkFpBUuwpGNPcjfWpuwn1FDYtAnNkaDU
         OjdeTjA81G3cSkb4LC+JMLAzTV6GrgEg3GukB0E6YMVvkx30mDTcCZmmqyZDHygnLVx6
         wy69wIgwKguqVZ1MTlKczqwHZi7q1aZbboRvFjYxc0nOduVyLnxjRCDk6DIOmHHwbNpQ
         O/gQ==
X-Gm-Message-State: APjAAAVguLgkeQcdiOfJxoESdVZODtYJtqI8MGkAHWOGtXIHN3yt7i/V
        AgAE+s2GRSBpVnRo3mh0OPj5EC3Ymv3kz+0WTVtSpQ==
X-Google-Smtp-Source: APXvYqwF9Y3/c0yi205TGCahwX97qwEwu4iwRt88jl9FlE+jOQfq3E3QeOdk+UxhXaA4JUHng04qr3twtUBWIS40d0Q=
X-Received: by 2002:a24:4453:: with SMTP id o80mr3845078ita.160.1559238843258;
 Thu, 30 May 2019 10:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1559156926-31336-1-git-send-email-chiluk+linux@indeed.com>
 <1559156926-31336-2-git-send-email-chiluk+linux@indeed.com> <xm264l5dynrg.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm264l5dynrg.fsf@bsegall-linux.svl.corp.google.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Thu, 30 May 2019 12:53:37 -0500
Message-ID: <CAC=E7cU9GetuKVQE1HxXsSuOKgyxezXUmSH2ZDHOrLio_YZi1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] sched/fair: Fix low cpu usage with high throttling
 by removing expiration of cpu-local slices
To:     bsegall@google.com
Cc:     Phil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        pjt@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 29, 2019 at 02:05:55PM -0700, bsegall@google.com wrote:
> Dave Chiluk <chiluk+linux@indeed.com> writes:
>
> Yeah, having run the test, stranding only 1 ms per cpu rather than 5
> doesn't help if you only have 10 ms of quota and even 10 threads/cpus.
> The slack timer isn't important in this test, though I think it probably
> should be changed.
My min_cfs_rq_runtime was already set to 1ms.

Additionally raising the amount of quota from 10ms to 50ms or even
100ms, still results in throttling without full quota usage.

> Decreasing min_cfs_rq_runtime helps, but would mean that we have to pull
> quota more often / always. The worst case here I think is where you
> run/sleep for ~1ns, so you wind up taking the lock twice every
> min_cfs_rq_runtime: once for assign and once to return all but min,
> which you then use up doing short run/sleep. I suppose that determines
> how much we care about this overhead at all.
I'm not so concerned about how inefficiently the user-space application
runs, as that's up to the invidual developer.  The fibtest testcase, is
purely my approximation of what a java application with lots of worker
threads might do, as I didn't have a great deterministic java
reproducer, and I feared posting java to LKML.  I'm more concerned with
the fact that the user requested 10ms/period or 100ms/period and they
hit throttling while simultaneously not seeing that amount of cpu usage.
i.e. on an 8 core machine if I
$ ./runfibtest 1
Iterations Completed(M): 1886
Throttled for: 51
CPU Usage (msecs) = 507
$ ./runfibtest 8
Iterations Completed(M): 1274
Throttled for: 52
CPU Usage (msecs) = 380

You see that in the 8 core case where we have 7 do nothing threads on
cpu's 1-7, we see only 380 ms of usage, and 52 periods of throttling
when we should have received ~500ms of cpu usage.

Looking more closely at the __return_cfs_rq_runtime logic I noticed
        if (cfs_b->quota != RUNTIME_INF &&
            cfs_rq->runtime_expires == cfs_b->runtime_expires) {

Which is awfully similar to the logic that was fixed by 512ac999.  Is it
possible that we are just not ever returning runtime back to the cfs_b
because of the runtime_expires comparison here?

Early on in my testing I created a patch that would report via sysfs the
amount of quota that was expired at the end of a period in
expire_cfs_rq_runtime, and it roughly equalled the difference in quota
between the actual cpu usage and the alloted quota.  That leads me to
believe that something is not going quite correct in the slack return
logic __return_cfs_rq_runtime.  I'll attach that patch at the bottom of
this e-mail in case you'd like to reproduce my tests.

> Removing expiration means that in the worst case period and quota can be
> effectively twice what the user specified, but only on very particular
> workloads.
I'm only removing expiration of slices that have already been assigned
to individual cfs_rq.  My understanding is that there is at most one
cfs_rq per cpu, and each of those can have at most one slice of
available runtime.  So the worst case burst is slice_ms * cpus.  Please
help me understand how you get to twice user specified quota and period
as it's not obvious to me *(I've only been looking at this for a few
months).

> I think we should at least think about instead lowering
> min_cfs_rq_runtime to some smaller value
Do you mean lower than 1ms?

Thanks
Dave.

From: Dave Chiluk <chiluk+linux@indeed.com>
Date: Thu, 30 May 2019 12:47:12 -0500
Subject: [PATCH] Add expired_time sysfs entry

Signed-off-by: Dave Chiluk <chiluk+linux@indeed.com>
---
 kernel/sched/core.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c  |  4 ++++
 kernel/sched/sched.h |  1 +
 3 files changed, 46 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427..3c06df9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6655,6 +6655,30 @@ static long tg_get_cfs_period(struct task_group *tg)
        return cfs_period_us;
 }

+static int tg_set_cfs_expired_runtime(struct task_group *tg, long
slice_expiration)
+{
+       struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
+
+       if (slice_expiration == 0)
+       {
+               raw_spin_lock_irq(&cfs_b->lock);
+               cfs_b->expired_runtime= 0;
+               raw_spin_unlock_irq(&cfs_b->lock);
+               return 0;
+       }
+       return 1;
+}
+
+static u64 tg_get_cfs_expired_runtime(struct task_group *tg)
+{
+       u64 expired_runtime;
+
+       expired_runtime = tg->cfs_bandwidth.expired_runtime;
+       do_div(expired_runtime, NSEC_PER_USEC);
+
+       return expired_runtime;
+}
+
 static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
                                  struct cftype *cft)
 {
@@ -6679,6 +6703,18 @@ static int cpu_cfs_period_write_u64(struct
cgroup_subsys_state *css,
        return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }

+static u64 cpu_cfs_expired_runtime_read_u64(struct cgroup_subsys_state *css,
+                                 struct cftype *cft)
+{
+       return tg_get_cfs_expired_runtime(css_tg(css));
+}
+
+static int cpu_cfs_expired_runtime_write_s64(struct cgroup_subsys_state *css,
+                                  struct cftype *cftype, s64
cfs_slice_expiration_us)
+{
+       return tg_set_cfs_expired_runtime(css_tg(css), cfs_slice_expiration_us);
+}
+
 struct cfs_schedulable_data {
        struct task_group *tg;
        u64 period, quota;
@@ -6832,6 +6868,11 @@ static u64 cpu_rt_period_read_uint(struct
cgroup_subsys_state *css,
                .write_u64 = cpu_cfs_period_write_u64,
        },
        {
+               .name = "cfs_expired_runtime",
+               .read_u64 = cpu_cfs_expired_runtime_read_u64,
+               .write_s64 = cpu_cfs_expired_runtime_write_s64,
+       },
+       {
                .name = "stat",
                .seq_show = cpu_cfs_stat_show,
        },
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f35930f..bcbd4ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4382,6 +4382,9 @@ static void expire_cfs_rq_runtime(struct cfs_rq *cfs_rq)
                cfs_rq->runtime_expires += TICK_NSEC;
        } else {
                /* global deadline is ahead, expiration has passed */
+               raw_spin_lock_irq(&cfs_b->lock);
+               cfs_b->expired_runtime += cfs_rq->runtime_remaining;
+               raw_spin_unlock_irq(&cfs_b->lock);
                cfs_rq->runtime_remaining = 0;
        }
 }
@@ -4943,6 +4946,7 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
        cfs_b->runtime = 0;
        cfs_b->quota = RUNTIME_INF;
        cfs_b->period = ns_to_ktime(default_cfs_period());
+       cfs_b->expired_runtime = 0;

        INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
        hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC,
HRTIMER_MODE_ABS_PINNED);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1a..499d2e2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -343,6 +343,7 @@ struct cfs_bandwidth {
        s64                     hierarchical_quota;
        u64                     runtime_expires;
        int                     expires_seq;
+       u64                     expired_runtime;

        short                   idle;
        short                   period_active;

--
1.8.3.1
