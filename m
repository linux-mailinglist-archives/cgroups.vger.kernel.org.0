Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CACE58C725
	for <lists+cgroups@lfdr.de>; Mon,  8 Aug 2022 13:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242774AbiHHLFF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Aug 2022 07:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242766AbiHHLEw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Aug 2022 07:04:52 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF01D14D3C
        for <cgroups@vger.kernel.org>; Mon,  8 Aug 2022 04:04:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so8739856pjk.1
        for <cgroups@vger.kernel.org>; Mon, 08 Aug 2022 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yw8m7GYV4skWBTfKn2U9wJeMtXyACoICOaijkM7fL+0=;
        b=j3R7fzmwyeJeXJGoIudYJOvfyOUazjXFVpsCll1fn7GdOr4joFVmKLRNh6f3+AbuUu
         vXnythEvo3kboS3OlUY6wBMJRrVuyKospm268JH+5HgLaK7RK1EfwcB0sACHJyxwLlHO
         ZwMq8gKjZ8xUtNWLkrdcHdyTB4RFtlaiawiZqFWmtkFAqV2yt78Cd2+N1VlO5SeDFu1t
         9/p/jqzBBL5SNUfAWPJ6XIxbeWR2CHNLmwxngRWDntRjpAWFLECFV7tP5Iq5jZIH1e/H
         uJjQIL5UdTEx086i9lEz4+v+uCDzc1j+76k0PEWX/P2E41E6wUOejKVVRee5xBrnmFQv
         82SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yw8m7GYV4skWBTfKn2U9wJeMtXyACoICOaijkM7fL+0=;
        b=AeMUqmHEQJL9KasmAUpzKcPnbidYqnPX5Koe7afnTKsDA0L+nuW568XG+Aq1hLMmxK
         Np+Ph558b1TndRfQ1gq4AkEfhE2/5nhQKvSiw4Zo4cKdu9BMb5/YrrGfm+/fVkCliGeK
         tRplWTKFDmyYWOUeuaD7BSDRMlKzvQImuLAMJlG7+faaA32AX4Nzs4ANAXTM6BZxsoR1
         KMy/4hUo0ZDDPSLOBl5V8Mx/Jp4el67RDcNQaCUj9andSm9QoMGDLVDmjJ6kIZ7Q/Hyx
         kAppgiIiWv8wCtlYlDcb6ei+uMTLtxn1N94IUAf/bELtUEyVFtTfePVIMAwIb635eFBK
         Gw0w==
X-Gm-Message-State: ACgBeo1CYn3m/3Dp5HqbagZsk5CNX2Mc6BoawJtyqX8sGIDQaY+lpED+
        FIvUjyujJSuGiCk3e6Kc4g+H9A==
X-Google-Smtp-Source: AA6agR5i3CJjRs4D5crOMEcY8rIRCmV4PpvNMPxksURR+QO2WWL3FnYfwx3AxQZrb75dnmnekIQ6hA==
X-Received: by 2002:a17:902:db0f:b0:16f:24e4:15ff with SMTP id m15-20020a170902db0f00b0016f24e415ffmr18247195plx.10.1659956690224;
        Mon, 08 Aug 2022 04:04:50 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:04:49 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 04/10] sched/psi: don't change task psi_flags when migrate CPU/group
Date:   Mon,  8 Aug 2022 19:03:35 +0800
Message-Id: <20220808110341.15799-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808110341.15799-1-zhouchengming@bytedance.com>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The current code use psi_task_change() at every scheduling point,
in which change task psi_flags then change all its psi_groups.

So we have to heavily rely on the task scheduling states to calculate
what to set and what to clear at every scheduling point, which make
the PSI stats tracking code much complex and error prone.

In fact, the task psi_flags only change at wakeup and sleep (except
ONCPU state at switch), it doesn't change at all when migrate CPU/group.

If we keep its psi_flags unchanged when migrate CPU/group, we can
just use task->psi_flags to clear(migrate out) or set(migrate in),
which will make PSI stats tracking much simplier and more efficient.

Note: ENQUEUE_WAKEUP only means wakeup task from sleep state, don't
include wakeup new task, so add psi_enqueue() in wake_up_new_task().

Performance test on Intel Xeon Platinum with 3 levels of cgroup:

1. before the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.034 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 8.210 [sec]

       8.210600 usecs/op
         121793 ops/sec

2. after the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.032 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 8.077 [sec]

       8.077648 usecs/op
         123798 ops/sec

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/sched.h |  3 ---
 kernel/sched/core.c   |  1 +
 kernel/sched/psi.c    | 24 ++++++++++---------
 kernel/sched/stats.h  | 54 +++++++++++++++++++++----------------------
 4 files changed, 40 insertions(+), 42 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 88b8817b827d..20a94786cad8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -879,9 +879,6 @@ struct task_struct {
 	unsigned			sched_reset_on_fork:1;
 	unsigned			sched_contributes_to_load:1;
 	unsigned			sched_migrated:1;
-#ifdef CONFIG_PSI
-	unsigned			sched_psi_wake_requeue:1;
-#endif
 
 	/* Force alignment to the next boundary: */
 	unsigned			:0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 64c08993221b..3aa401689f7e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4642,6 +4642,7 @@ void wake_up_new_task(struct task_struct *p)
 	post_init_entity_util_avg(p);
 
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
+	psi_enqueue(p, true);
 	trace_sched_wakeup_new(p);
 	check_preempt_curr(rq, p, WF_FORK);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9e8c5d9e585c..974471f212a3 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -796,22 +796,24 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 	task->psi_flags |= set;
 }
 
-void psi_task_change(struct task_struct *task, int clear, int set)
+void psi_change_groups(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
 	void *iter = NULL;
-	u64 now;
+	u64 now = cpu_clock(cpu);
+
+	while ((group = iterate_groups(task, &iter)))
+		psi_group_change(group, cpu, clear, set, now, true);
+}
 
+void psi_task_change(struct task_struct *task, int clear, int set)
+{
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
-
-	now = cpu_clock(cpu);
-
-	while ((group = iterate_groups(task, &iter)))
-		psi_group_change(group, cpu, clear, set, now, true);
+	psi_change_groups(task, clear, set);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
@@ -1015,9 +1017,9 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	 *   pick_next_task()
 	 *     rq_unlock()
 	 *                                rq_lock()
-	 *                                psi_task_change() // old cgroup
+	 *                                psi_change_groups() // old cgroup
 	 *                                task->cgroups = to
-	 *                                psi_task_change() // new cgroup
+	 *                                psi_change_groups() // new cgroup
 	 *                                rq_unlock()
 	 *     rq_lock()
 	 *   psi_sched_switch() // does deferred updates in new cgroup
@@ -1027,13 +1029,13 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	task_flags = task->psi_flags;
 
 	if (task_flags)
-		psi_task_change(task, task_flags, 0);
+		psi_change_groups(task, task_flags, 0);
 
 	/* See comment above */
 	rcu_assign_pointer(task->cgroups, to);
 
 	if (task_flags)
-		psi_task_change(task, 0, task_flags);
+		psi_change_groups(task, 0, task_flags);
 
 	task_rq_unlock(rq, task, &rf);
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index c39b467ece43..e930b8fa6253 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -107,6 +107,7 @@ __schedstats_from_se(struct sched_entity *se)
 }
 
 #ifdef CONFIG_PSI
+void psi_change_groups(struct task_struct *task, int clear, int set);
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
@@ -124,42 +125,46 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (p->in_memstall)
-		set |= TSK_MEMSTALL_RUNNING;
+	if (!wakeup) {
+		if (p->psi_flags)
+			psi_change_groups(p, 0, p->psi_flags);
+		return;
+	}
 
-	if (!wakeup || p->sched_psi_wake_requeue) {
-		if (p->in_memstall)
+	/*
+	 * wakeup (including wakeup migrate) need to change task psi_flags,
+	 * specifically need to set TSK_RUNNING or TSK_MEMSTALL_RUNNING.
+	 * Since we clear task->psi_flags for wakeup migrated task, we need
+	 * to check task->psi_flags to see what should be set and clear.
+	 */
+	if (unlikely(p->in_memstall)) {
+		set |= TSK_MEMSTALL_RUNNING;
+		if (!(p->psi_flags & TSK_MEMSTALL))
 			set |= TSK_MEMSTALL;
-		if (p->sched_psi_wake_requeue)
-			p->sched_psi_wake_requeue = 0;
-	} else {
-		if (p->in_iowait)
-			clear |= TSK_IOWAIT;
 	}
+	if (p->psi_flags & TSK_IOWAIT)
+		clear |= TSK_IOWAIT;
 
 	psi_task_change(p, clear, set);
 }
 
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
-	int clear = TSK_RUNNING;
-
 	if (static_branch_likely(&psi_disabled))
 		return;
 
+	if (!sleep) {
+		if (p->psi_flags)
+			psi_change_groups(p, p->psi_flags, 0);
+		return;
+	}
+
 	/*
 	 * A voluntary sleep is a dequeue followed by a task switch. To
 	 * avoid walking all ancestors twice, psi_task_switch() handles
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
 	 */
-	if (sleep)
-		return;
-
-	if (p->in_memstall)
-		clear |= (TSK_MEMSTALL | TSK_MEMSTALL_RUNNING);
-
-	psi_task_change(p, clear, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
@@ -169,21 +174,14 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	/*
 	 * Is the task being migrated during a wakeup? Make sure to
 	 * deregister its sleep-persistent psi states from the old
-	 * queue, and let psi_enqueue() know it has to requeue.
+	 * queue.
 	 */
-	if (unlikely(p->in_iowait || p->in_memstall)) {
+	if (unlikely(p->psi_flags)) {
 		struct rq_flags rf;
 		struct rq *rq;
-		int clear = 0;
-
-		if (p->in_iowait)
-			clear |= TSK_IOWAIT;
-		if (p->in_memstall)
-			clear |= TSK_MEMSTALL;
 
 		rq = __task_rq_lock(p, &rf);
-		psi_task_change(p, clear, 0);
-		p->sched_psi_wake_requeue = 1;
+		psi_task_change(p, p->psi_flags, 0);
 		__task_rq_unlock(rq, &rf);
 	}
 }
-- 
2.36.1

