Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7202E57C324
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiGUEF0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiGUEFQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:16 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4126267
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w185so644184pfb.4
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12xG6HFS4OSNQZJgcaaRecjswCM/r3YsLGrFXT03SBs=;
        b=JEvEzm4b+zcLaZwlGUiN8uUg5U4dgKq9px8l7ozjtYZO7DI8BBi184K34p2VDbFE49
         pM+qjrqpIrvkx4+EDe3g2XVKBqX1dTIZsjztUVcn9tkTKeOyfXWDbAkRetmWq5FTcb2Q
         +GUVuwIW6UnTAFLNC7k1ONRyHcqjAYYuAGT9zQ7IGNtJ+ppayBfzv1qBpS939kqj4tln
         7B2oixjMZCtam8tbl6gSdYETIglRYALB5WjyetEC3yynQYDY/3i5lPX6DD3WuJVlD/n1
         l5ySyrUO0G6XUpkb0CWi0jqYo/kme4VOXDoKeuVQQ29sjWR7TtQjEsYVdoG9N54CbKkl
         gsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12xG6HFS4OSNQZJgcaaRecjswCM/r3YsLGrFXT03SBs=;
        b=7P5/Am6wMd30xH5D1ZIKQPulq89I/6A++tmlIUuIcudb4zxQ8+uvE7wlL+7fdY5Hay
         IoOw4mn8/3g9ejT4/Nejk84OlF3swiPe4BaMw2WG6WacsDbHs2yXIv2pG7AT6BGBTqKC
         0HWjZv7YXntscsq2wD0GWlm0VI85OHH+w2PzsUeXOzXVH+9t2zAYbzB/WVIY7UScBq/l
         QKl652qw5YvIXdcFoP55yFcV8N1BAaUUHrZuX3Rc7ht+0du69OyuFvP+gkJtd0PHBold
         tx3+jyW0mtU2V7OThOGl+9F3bz2PYk4ClpoUgUwbHvJty0yUrkriFaRRst9E2Ld3DFYr
         ZdJw==
X-Gm-Message-State: AJIora8Ip3p/6qeJpcw9dSdgHwMJoXbtXHbDceHBkEJld+9FV49VeUma
        Sm8PqvTZetABOELk5gFXjyT92w==
X-Google-Smtp-Source: AGRyM1vzbxkuA/FTqeo6u/RdfuI10CNeR889oiD7WWMCed4ORc0Vc7IaL03+eUJ7UVcpuamVYhuOhw==
X-Received: by 2002:a05:6a00:150d:b0:52b:1ffb:503c with SMTP id q13-20020a056a00150d00b0052b1ffb503cmr36049121pfu.44.1658376314402;
        Wed, 20 Jul 2022 21:05:14 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:14 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 4/9] sched/psi: don't change task psi_flags when migrate CPU/group
Date:   Thu, 21 Jul 2022 12:04:34 +0800
Message-Id: <20220721040439.2651-5-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index a463dbc92fcd..f5f2d3542b05 100644
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
index e04041d8251b..6ba159fe2a4f 100644
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

