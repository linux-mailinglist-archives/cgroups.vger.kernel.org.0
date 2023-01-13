Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1B46699C2
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 15:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241808AbjAMOOx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 09:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242043AbjAMONw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 09:13:52 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931C85D405
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:47 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk16so21167960wrb.11
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5xxDzbGl7sCo78cCnADO2gQFU/vv6X0hEszTOboieA=;
        b=sOcFHJRO3tzMdITMarIyeG54hQ9Z/8+xami3g461hCBYHEHEoaWYo6RoJbqK1aj3td
         vBaZqktAhE/Otrxe0Wi4OGxpmAOE3GJBPRMPzsVwTWBwA3uG0VXPLeaDk9wu62h2xmVz
         LUXMCyjeIsxjhD7AQJRkh9GcHeBKQyewpnbSe8TvoK1hgp+hpTEeWU9f9FNvWccw36I0
         uGHuW004HyfQN5eBLSIycAjFuNolTDQv8GoZbjaIMz0lOpmC1udBFAgfg7Z6jWM6D/Nh
         ZYHgmxSRcReFHB9Yp6UPFj0aof/Bmh7xlg7asRA4yX3HaMRDsFgUrDCZs9mqB93L9mf2
         QBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5xxDzbGl7sCo78cCnADO2gQFU/vv6X0hEszTOboieA=;
        b=XgNOV0t1o9jOAVn9L7BShZAQF1rsqExmC6lm/bsdANv6crcYfZY9T1YxRGa+wScdYR
         Xyryd4IfOqATC0g8iBPmUNjgT+IoDS6ov+mbvxIDWWgja7lCx4dn33u0s3K+b6WE9T+g
         MnED4Bdt/A56Zrk0gWsRpg2DCmz8bQ7nX29i6dyfs6nLhXjZURMUHgOkaOHSx4IpZ6HW
         EytTZ35m5istXmpfjLDwsfOtNkpC+OAwBfiUJrBJZ53uewvDLnkeUg9LeyyhQXOdOVzq
         Ep/grWKoejN6kgu3l6sUz1qiGNVJkaOTXvwjlWXmroy0V26xWa1YRbS4haZuveN7vpRn
         2HrQ==
X-Gm-Message-State: AFqh2kpMymHXAzFNus1xjA/Xwmy62qAtbvF1RpfKZeT1Q+xAhvgPc/f1
        aoIz+EoW/U+yaV5fn7kYqsPnEg==
X-Google-Smtp-Source: AMrXdXsuLKqRb4Mpuew+dasWV3cyNXBL8vBBLWn+lQnDDDLjEMT1movwsA5kuCsnYsLEQA/s6TlOxw==
X-Received: by 2002:adf:ffcd:0:b0:2bd:db3b:33f5 with SMTP id x13-20020adfffcd000000b002bddb3b33f5mr3501837wrs.3.1673619165957;
        Fri, 13 Jan 2023 06:12:45 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:45 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v10 5/9] sched/fair: Take into account latency priority at wakeup
Date:   Fri, 13 Jan 2023 15:12:30 +0100
Message-Id: <20230113141234.260128-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 include/linux/sched.h      |  4 ++-
 include/linux/sched/prio.h |  9 ++++++
 init/init_task.c           |  2 +-
 kernel/sched/core.c        | 38 +++++++++++++++++++---
 kernel/sched/debug.c       |  2 +-
 kernel/sched/fair.c        | 66 ++++++++++++++++++++++++++++++++++----
 kernel/sched/sched.h       |  6 ++++
 7 files changed, 112 insertions(+), 15 deletions(-)

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
index 981665550f8c..402c8d622b76 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1285,6 +1285,16 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 	}
 }
 
+static void set_latency_offset(struct task_struct *p)
+{
+	long weight = sched_latency_to_weight[p->latency_prio];
+	s64 offset;
+
+	offset = weight * get_sleep_latency(false);
+	offset = div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
+	p->se.latency_offset = (long)offset;
+}
+
 #ifdef CONFIG_UCLAMP_TASK
 /*
  * Serializes updates of utilization clamp values
@@ -4632,7 +4642,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
 
-		p->latency_nice = DEFAULT_LATENCY_NICE;
+		p->latency_prio = NICE_TO_LATENCY(0);
+		set_latency_offset(p);
+
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
@@ -7398,8 +7410,10 @@ static void __setscheduler_params(struct task_struct *p,
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
@@ -7584,7 +7598,7 @@ static int __sched_setscheduler(struct task_struct *p,
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_LATENCY_NICE &&
-		    attr->sched_latency_nice != p->latency_nice)
+		    attr->sched_latency_nice != LATENCY_TO_NICE(p->latency_prio))
 			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
@@ -8125,7 +8139,7 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	get_params(p, &kattr);
 	kattr.sched_flags &= SCHED_FLAG_ALL;
 
-	kattr.sched_latency_nice = p->latency_nice;
+	kattr.sched_latency_nice = LATENCY_TO_NICE(p->latency_prio);
 
 #ifdef CONFIG_UCLAMP_TASK
 	/*
@@ -11334,6 +11348,20 @@ const u32 sched_prio_to_wmult[40] = {
  /*  15 */ 119304647, 148102320, 186737708, 238609294, 286331153,
 };
 
+/*
+ * latency weight for wakeup preemption
+ */
+const int sched_latency_to_weight[40] = {
+ /* -20 */     -1024,     -973,     -922,      -870,      -819,
+ /* -15 */      -768,     -717,     -666,      -614,      -563,
+ /* -10 */      -512,     -461,     -410,      -358,      -307,
+ /*  -5 */      -256,     -205,     -154,      -102,       -51,
+ /*   0 */         0,       51,      102,       154,       205,
+ /*   5 */       256,      307,      358,       410,       461,
+ /*  10 */       512,      563,      614,       666,       717,
+ /*  15 */       768,      819,      870,       922,       973,
+};
+
 void call_trace_sched_update_nr_running(struct rq *rq, int count)
 {
         trace_sched_update_nr_running_tp(rq, count);
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
index 8a85c6cf781e..e87a863a2aa6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4870,6 +4870,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
+static long wakeup_latency_gran(struct sched_entity *curr, struct sched_entity *se);
+
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -4878,7 +4880,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	unsigned long ideal_runtime, delta_exec;
 	struct sched_entity *se;
-	s64 delta;
+	s64 delta, offset;
 
 	ideal_runtime = sched_slice(cfs_rq, curr);
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
@@ -4903,10 +4905,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
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
 
@@ -6155,6 +6159,35 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+static void set_next_buddy(struct sched_entity *se);
+
+static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
+{
+	struct sched_entity *next;
+
+	if (se->latency_offset >= 0)
+		return;
+
+	if (cfs->nr_running <= 1)
+		return;
+	/*
+	 * When waking from another class, we don't need to check to preempt at
+	 * wakeup and don't set next buddy as a candidate for being picked in
+	 * priority.
+	 * In case of simultaneous wakeup when current is another class, the
+	 * latency sensitive tasks lost opportunity to preempt non sensitive
+	 * tasks which woke up simultaneously.
+	 */
+
+	if (cfs->next)
+		next = cfs->next;
+	else
+		next = __pick_first_entity(cfs);
+
+	if (next && wakeup_preempt_entity(next, se) == 1)
+		set_next_buddy(se);
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -6241,14 +6274,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!task_new)
 		update_overutilized_status(rq);
 
+	if (rq->curr->sched_class != &fair_sched_class)
+		check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
+
 enqueue_throttle:
 	assert_list_leaf_cfs_rq(rq);
 
 	hrtick_update(rq);
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * The dequeue_task method is called before nr_running is
  * decreased. We remove the task from the rbtree and
@@ -7597,6 +7631,23 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
@@ -7635,11 +7686,12 @@ static int
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
index df7db06c9943..fd099f3961e4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -125,6 +125,11 @@ extern int sched_rr_timeslice;
  */
 #define NS_TO_JIFFIES(TIME)	((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
 
+/* Maximum nice latency weight used to scale the latency_offset */
+
+#define NICE_LATENCY_SHIFT	(SCHED_FIXEDPOINT_SHIFT)
+#define NICE_LATENCY_WEIGHT_MAX	(1L << NICE_LATENCY_SHIFT)
+
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
  * The extra resolution improves shares distribution and load balancing of
@@ -2121,6 +2126,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
 
 extern const int		sched_prio_to_weight[40];
 extern const u32		sched_prio_to_wmult[40];
+extern const int		sched_latency_to_weight[40];
 
 /*
  * {de,en}queue flags:
-- 
2.34.1

