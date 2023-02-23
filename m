Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470EE6A103A
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 20:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjBWTLT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 14:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjBWTLQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 14:11:16 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00448515C6
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:53 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l1so11274746wry.10
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NluA/bvTWT8jzIvRWktAUoRtEbCr/07FC+kKT5m9N3I=;
        b=kw78y2KVnNJoUZnD4zI6GVsCHvyVdY93lLGKA1NCdTdt3FT+3bkurVHBIe+RmbmIa1
         5bROHr/BHmYMte0ASjklXWEdCr0zKO1sBwq+3Iu0/eU3wpX1nqKWM7XCEasOWZDUvXB7
         ULp8AnWIvDJ/kw6MXyRdxGFycji40Pqy2TRfoA1HmhwcDm+rJV5lFU2/m2hTSWcwWMRy
         NA62YUJJxM910FoDCWST7drK6e9d3J3xqf6M9JrQ5iaQEtU4mnXmIF43T16rGcux+IrW
         FSzISb/STAGsBAZk5GElagk9AS9V4QXoJeaP6O1PLiYvjMxC/n9jrFInEZmmebmKBNvC
         Hmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NluA/bvTWT8jzIvRWktAUoRtEbCr/07FC+kKT5m9N3I=;
        b=vhskd705so6TjvQwlzTjy7otEE3n+8jn9Tj1oA5M1ou7MUXv5S9TT/7NQ6SU6v73lH
         MrgrtxhyHzpDd2n32jZ1H42HUbN3tR8cyQVktmhv2OmQd7tHADWCTTGvW4vWirsUk7P6
         ILm1JR/w1hdrFthOO7qEPdfoxsBhpf4zLAqdv19/aF7s1jCdXIo6duh31+acz332aSQD
         8dK6XZNL4yUZOMi/DyL5W5GhUmSeTeRiKpmodOcA3gwYYhXin7CyjlV7g38AFoAg1UGP
         1bj2t6/UpZpn5RpB11y7Qy0tWnG8R9IBCw5FmvkmEq64l2pZ+exDcRXUSgJswmCLbRZI
         gw9A==
X-Gm-Message-State: AO0yUKXSJlOi217V7JcVlqoWCtbxmEL3/T/v1SSwzYPQad3siM7p33wG
        H60Thx+0BsqaOIRSV1ybdNr6nw==
X-Google-Smtp-Source: AK7set/n+sL8It9KafnyEsOKB0eJyeZI2LF+IQduoh/8+pmqP2Zo5lSEY5JkRcF8ViClilPm3BkyZg==
X-Received: by 2002:a5d:4692:0:b0:2c7:16c3:1756 with SMTP id u18-20020a5d4692000000b002c716c31756mr1581580wrq.61.1677179452287;
        Thu, 23 Feb 2023 11:10:52 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm9844481wro.92.2023.02.23.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:10:51 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v11 5/8] sched/fair: Take into account latency priority at wakeup
Date:   Thu, 23 Feb 2023 20:10:38 +0100
Message-Id: <20230223191041.577305-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223191041.577305-1-vincent.guittot@linaro.org>
References: <20230223191041.577305-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Take into account the latency priority of a thread when deciding to
preempt the current running thread. We don't want to provide more CPU
bandwidth to a thread but reorder the scheduling to run latency sensitive
task first whenever possible.

As long as a thread didn't use its bandwidth, it will be able to preempt
the current thread.

At the opposite, a thread with a low latency priority will preempt current
thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
wait for the tick to get its sched slice.

                                   curr vruntime
                                       |
                      sysctl_sched_wakeup_granularity
                                   <-->
----------------------------------|----|-----------------------|---------------
                                  |    |<--------------------->
                                  |    .  sysctl_sched_latency
                                  |    .
default/current latency entity    |    .
                                  |    .
1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
                                  |    .
                                  |    .
                                  |    .
low latency entity                |    .
                                   ---------------------->|
                               % of sysctl_sched_latency  |
1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
preempt ------------------------------------------------->|<- do not preempt --
                                  |    .
                                  |    .
                                  |    .
high latency entity               |    .
         |<-----------------------|----.
         | % of sysctl_sched_latency   .
111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
preempt->|<- se doesn't preempt curr ------------------------------------------

Tests results of nice latency impact on heavy load like hackbench:

hackbench -l (2560 / group) -g group
group        latency 0             latency 19
1            1.378(+/-  1%)      1.337(+/- 1%) + 3%
4            1.393(+/-  3%)      1.312(+/- 3%) + 6%
8            1.308(+/-  2%)      1.279(+/- 1%) + 2%
16           1.347(+/-  1%)      1.317(+/- 1%) + 2%

hackbench -p -l (2560 / group) -g group
group
1            1.836(+/- 17%)      1.148(+/- 5%) +37%
4            1.586(+/-  6%)      1.109(+/- 8%) +30%
8            1.209(+/-  4%)      0.780(+/- 4%) +35%
16           0.805(+/-  5%)      0.728(+/- 4%) +10%

By deacreasing the latency prio, we reduce the number of preemption at
wakeup and help hackbench making progress.

Test results of nice latency impact on short live load like cyclictest
while competing with heavy load like hackbench:

hackbench -l 10000 -g $group &
cyclictest --policy other -D 5 -q -n
        latency 0           latency -20
group   min  avg    max     min  avg    max
0       16    19     29      17   18     29
1       43   299   7359      63   84   3422
4       56   449  14806      45   83    284
8       63   820  51123      63   83    283
16      64  1326  70684      41  157  26852

group = 0 means that hackbench is not running.

The avg is significantly improved with nice latency -20 especially with
large number of groups but min and max remain quite similar. If we add the
histogram parameter to get details of latency, we have :

hackbench -l 10000 -g 16 &
cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
              latency 0    latency -20
Min Latencies:    64           62
Avg Latencies:  1170          107
Max Latencies: 88069        10417
50% latencies:   122           86
75% latencies:   614           91
85% latencies:   961           94
90% latencies:  1225           97
95% latencies:  6120          102
99% latencies: 18328          159

With percentile details, we see the benefit of nice latency -20 as
only 1% of the latencies are above 159us whereas the default latency
has got 15% around ~1ms or above and 5% over the 6ms.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h      |  4 +++-
 include/linux/sched/prio.h |  9 +++++++++
 init/init_task.c           |  2 +-
 kernel/sched/core.c        | 19 ++++++++++++++-----
 kernel/sched/debug.c       |  2 +-
 kernel/sched/fair.c        | 32 +++++++++++++++++++++++++++-----
 kernel/sched/sched.h       | 11 +++++++++++
 7 files changed, 66 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6c61bde49152..38decae3e156 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -568,6 +568,8 @@ struct sched_entity {
 	/* cached value of my_q->h_nr_running */
 	unsigned long			runnable_weight;
 #endif
+	/* preemption offset in ns */
+	long				latency_offset;
 
 #ifdef CONFIG_SMP
 	/*
@@ -784,7 +786,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
-	int				latency_nice;
+	int				latency_prio;
 
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index bfcd7f1d1e11..be79503d86af 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -59,5 +59,14 @@ static inline long rlimit_to_nice(long prio)
  * Default tasks should be treated as a task with latency_nice = 0.
  */
 #define DEFAULT_LATENCY_NICE	0
+#define DEFAULT_LATENCY_PRIO	(DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
+
+/*
+ * Convert user-nice values [ -20 ... 0 ... 19 ]
+ * to static latency [ 0..39 ],
+ * and back.
+ */
+#define NICE_TO_LATENCY(nice)	((nice) + DEFAULT_LATENCY_PRIO)
+#define LATENCY_TO_NICE(prio)	((prio) - DEFAULT_LATENCY_PRIO)
 
 #endif /* _LINUX_SCHED_PRIO_H */
diff --git a/init/init_task.c b/init/init_task.c
index 7dd71dd2d261..071deff8dbd1 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -78,7 +78,7 @@ struct task_struct init_task
 	.prio		= MAX_PRIO - 20,
 	.static_prio	= MAX_PRIO - 20,
 	.normal_prio	= MAX_PRIO - 20,
-	.latency_nice	= DEFAULT_LATENCY_NICE,
+	.latency_prio	= DEFAULT_LATENCY_PRIO,
 	.policy		= SCHED_NORMAL,
 	.cpus_ptr	= &init_task.cpus_mask,
 	.user_cpus_ptr	= NULL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d327614c70b0..d5b7e237d79b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1285,6 +1285,11 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+static void set_latency_offset(struct task_struct *p)
+{
+	p->se.latency_offset = calc_latency_offset(p->latency_prio);
+}
+
 #ifdef CONFIG_UCLAMP_TASK
 /*
  * Serializes updates of utilization clamp values
@@ -4681,7 +4686,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
-		p->latency_nice = DEFAULT_LATENCY_NICE;
+		p->latency_prio = NICE_TO_LATENCY(0);
+		set_latency_offset(p);
+
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -7449,8 +7456,10 @@ static void __setscheduler_params(struct task_struct *p,
 static void __setscheduler_latency(struct task_struct *p,
 		const struct sched_attr *attr)
 {
-	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE)
-		p->latency_nice = attr->sched_latency_nice;
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE) {
+		p->latency_prio = NICE_TO_LATENCY(attr->sched_latency_nice);
+		set_latency_offset(p);
+	}
 }
 
 /*
@@ -7635,7 +7644,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
-		    attr->sched_latency_nice != p->latency_nice)
+		    attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
@@ -8176,7 +8185,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
-	kattr.sched_latency_nice = p->latency_nice;
+	kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 68be7a3e42a3..b3922184af91 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1043,7 +1043,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 #endif
 	P(policy);
 	P(prio);
-	P(latency_nice);
+	P(latency_prio);
 	if (task_has_dl_policy(p)) {
 		P(dl.runtime);
 		P(dl.deadline);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 81bef11eb660..414b6243208b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4877,6 +4877,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
+static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -4885,7 +4887,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	unsigned long ideal_runtime, delta_exec;
 	struct sched_entity *se;
-	s64 delta;
+	s64 delta, offset;
 
 	/*
 	 * When many tasks blow up the sched_period; it is possible that
@@ -4916,10 +4918,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 	se = __pick_first_entity(cfs_rq);
 	delta = curr->vruntime - se->vruntime;
 
-	if (delta < 0)
+	offset = wakeup_latency_gran(curr, se);
+	if (delta < offset)
 		return;
 
-	if (delta > ideal_runtime)
+	if ((delta > ideal_runtime) ||
+	    (delta > get_latency_max()))
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -7662,6 +7666,23 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 }
 #endif /* CONFIG_SMP */
 
+static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se)
+{
+	long latency_offset = se->latency_offset;
+
+	/*
+	 * A negative latency offset means that the sched_entity has latency
+	 * requirement that needs to be evaluated versus other entity.
+	 * Otherwise, use the latency weight to evaluate how much scheduling
+	 * delay is acceptable by se.
+	 */
+	if ((latency_offset < 0) || (curr->latency_offset < 0))
+		latency_offset -= curr->latency_offset;
+	latency_offset = min_t(long, latency_offset, get_latency_max());
+
+	return latency_offset;
+}
+
 static unsigned long wakeup_gran(struct sched_entity *se)
 {
 	unsigned long gran = sysctl_sched_wakeup_granularity;
@@ -7700,11 +7721,12 @@ static int
 wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 {
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
+	s64 offset = wakeup_latency_gran(curr, se);
 
-	if (vdiff <= 0)
+	if (vdiff < offset)
 		return -1;
 
-	gran = wakeup_gran(se);
+	gran = offset + wakeup_gran(se);
 
 	/*
 	 * At wake up, the vruntime of a task is capped to not be older than
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 51ba0af7fb27..3f42f86105d4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2494,6 +2494,17 @@ static inline unsigned long get_sleep_latency(bool idle)
 	return thresh;
 }
 
+/*
+ * Calculate the latency offset for a priority level.
+ * We use a linear mapping of the priority in the range:
+ *     [-sysctl_sched_latency:sysctl_sched_latency]
+ */
+static inline long calc_latency_offset(int prio)
+{
+	return (long)get_sleep_latency(false) * LATENCY_TO_NICE(prio) /
+			(LATENCY_NICE_WIDTH/2);
+}
+
 static inline unsigned long get_latency_max(void)
 {
 	unsigned long thresh = get_sleep_latency(false);
-- 
2.34.1

