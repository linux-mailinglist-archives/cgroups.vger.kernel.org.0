Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF164E16E
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 09:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfFUHzQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 03:55:16 -0400
Received: from mail4.tencent.com ([183.57.53.109]:41450 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfFUHzQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 03:55:16 -0400
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail4.tencent.com (Postfix) with ESMTP id DE2845025D;
        Fri, 21 Jun 2019 15:47:22 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.22.120.143) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 15:47:22 +0800
From:   <xiaoggchen@tencent.com>
To:     <jasperwang@tencent.com>, <heddchen@tencent.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, chen xiaoguang <xiaoggchen@tencent.com>,
        Newton Gao <newtongao@tencent.com>,
        Shook Liu <shookliu@tencent.com>,
        Zhiguang Peng <zgpeng@tencent.com>
Subject: [PATCH 3/5] sched/BT: extend the priority for BT scheduling class
Date:   Fri, 21 Jun 2019 15:45:55 +0800
Message-ID: <1561103157-11246-4-git-send-email-xiaoggchen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
References: <1561103157-11246-1-git-send-email-xiaoggchen@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.22.120.143]
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: chen xiaoguang <xiaoggchen@tencent.com>

The priority of BT scheduler is from 140 to 179.

Signed-off-by: Newton Gao <newtongao@tencent.com>
Signed-off-by: Shook Liu <shookliu@tencent.com>
Signed-off-by: Zhiguang Peng <zgpeng@tencent.com>
Signed-off-by: Xiaoguang Chen <xiaoggchen@tencent.com>
---
 include/linux/ioprio.h     |  2 +-
 include/linux/sched/bt.h   | 30 ++++++++++++++++++++++++++++++
 include/linux/sched/prio.h |  5 ++++-
 init/init_task.c           |  6 +++---
 kernel/sched/core.c        | 15 ++++++++++++---
 kernel/sched/cputime.c     | 26 ++++++++++++++++++++------
 kernel/sched/sched.h       | 12 ++++++++++++
 7 files changed, 82 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/sched/bt.h

diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h
index e9bfe69..3adb9ad 100644
--- a/include/linux/ioprio.h
+++ b/include/linux/ioprio.h
@@ -62,7 +62,7 @@ static inline int task_nice_ioprio(struct task_struct *task)
  */
 static inline int task_nice_ioclass(struct task_struct *task)
 {
-	if (task->policy == SCHED_IDLE)
+	if (task->policy == SCHED_IDLE || task->policy == SCHED_BT)
 		return IOPRIO_CLASS_IDLE;
 	else if (task_is_realtime(task))
 		return IOPRIO_CLASS_RT;
diff --git a/include/linux/sched/bt.h b/include/linux/sched/bt.h
new file mode 100644
index 0000000..5f40600
--- /dev/null
+++ b/include/linux/sched/bt.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _SCHED_BT_H
+#define _SCHED_BT_H
+
+/*
+ * SCHED_BT tasks has 140~179 priorities, reflecting
+ * the fact that any of them has slower prio than RT and
+ * NORMAL/BATCH tasks.
+ */
+#define NICE_TO_BT_PRIO(nice)  (MAX_RT_PRIO + (nice) + 20 + 40)
+#define PRIO_TO_BT_NICE(prio)  ((prio) - MAX_RT_PRIO - 20 - 40)
+static inline int task_bt_nice(const struct task_struct *p)
+{
+	return PRIO_TO_BT_NICE((p)->static_prio);
+}
+
+static inline int bt_prio(int prio)
+{
+	if (unlikely(prio < MAX_PRIO && prio >= MIN_BT_PRIO))
+		return 1;
+	return 0;
+}
+
+static inline int bt_task(struct task_struct *p)
+{
+	return bt_prio(p->prio);
+}
+#endif /* _SCHED_BT_H */
+
+
diff --git a/include/linux/sched/prio.h b/include/linux/sched/prio.h
index 7d64fea..5c36ed2 100644
--- a/include/linux/sched/prio.h
+++ b/include/linux/sched/prio.h
@@ -22,9 +22,12 @@
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
-#define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH)
+#define MAX_PRIO		(MAX_RT_PRIO + NICE_WIDTH + 40)
 #define DEFAULT_PRIO		(MAX_RT_PRIO + NICE_WIDTH / 2)
 
+#define MIN_BT_PRIO		(MAX_RT_PRIO + 40)
+#define MAX_BT_PRIO		(MAX_PRIO - 1)
+
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
diff --git a/init/init_task.c b/init/init_task.c
index c70ef65..603ec4f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -68,9 +68,9 @@ struct task_struct init_task
 	.stack		= init_stack,
 	.usage		= REFCOUNT_INIT(2),
 	.flags		= PF_KTHREAD,
-	.prio		= MAX_PRIO - 20,
-	.static_prio	= MAX_PRIO - 20,
-	.normal_prio	= MAX_PRIO - 20,
+	.prio		= MAX_PRIO - 20 - 40,
+	.static_prio	= MAX_PRIO - 20 - 40,
+	.normal_prio	= MAX_PRIO - 20 - 40,
 	.policy		= SCHED_NORMAL,
 	.cpus_allowed	= CPU_MASK_ALL,
 	.nr_cpus_allowed= NR_CPUS,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3eb4723..b542c17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2312,7 +2312,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 * Revert to default priority/policy on fork if requested.
 	 */
 	if (unlikely(p->sched_reset_on_fork)) {
-		if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
+		if (task_has_dl_policy(p) || task_has_rt_policy(p) ||
+		    task_has_bt_policy(p)) {
 			p->policy = SCHED_NORMAL;
 			p->static_prio = NICE_TO_PRIO(0);
 			p->rt_priority = 0;
@@ -2333,6 +2334,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		return -EAGAIN;
 	else if (rt_prio(p->prio))
 		p->sched_class = &rt_sched_class;
+	else if (bt_prio(p->prio))
+		p->sched_class = &bt_sched_class;
 	else
 		p->sched_class = &fair_sched_class;
 
@@ -3833,6 +3836,12 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 		if (oldprio < prio)
 			queue_flag |= ENQUEUE_HEAD;
 		p->sched_class = &rt_sched_class;
+	} else if (bt_prio(prio)) {
+		if (dl_prio(oldprio))
+			p->dl.dl_boosted = 0;
+		if (rt_prio(oldprio))
+			p->rt.timeout = 0;
+		p->sched_class = &bt_sched_class;
 	} else {
 		if (dl_prio(oldprio))
 			p->dl.dl_boosted = 0;
@@ -3991,7 +4000,7 @@ int idle_cpu(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-	if (rq->curr != rq->idle)
+	if (rq->curr != rq->idle && !bt_prio(rq->curr->prio))
 		return 0;
 
 	if (rq->nr_running)
@@ -6200,7 +6209,7 @@ void normalize_rt_tasks(void)
 		schedstat_set(p->se.statistics.sleep_start, 0);
 		schedstat_set(p->se.statistics.block_start, 0);
 
-		if (!dl_task(p) && !rt_task(p)) {
+		if (!dl_task(p) && !rt_task(p) && !bt_task(p)) {
 			/*
 			 * Renice negative nice level userspace
 			 * tasks back to 0:
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 2305ce8..ca26a04 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -122,7 +122,10 @@ void account_user_time(struct task_struct *p, u64 cputime)
 	p->utime += cputime;
 	account_group_user_time(p, cputime);
 
-	index = (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;
+	if (bt_prio(p->static_prio))
+		index = (task_bt_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;
+	else
+		index = (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;
 
 	/* Add user time to cpustat. */
 	task_group_account_field(p, index, cputime);
@@ -146,13 +149,24 @@ void account_guest_time(struct task_struct *p, u64 cputime)
 	p->gtime += cputime;
 
 	/* Add guest time to cpustat. */
-	if (task_nice(p) > 0) {
-		cpustat[CPUTIME_NICE] += cputime;
-		cpustat[CPUTIME_GUEST_NICE] += cputime;
+	if (bt_prio(p->static_prio)) {
+		if (task_bt_nice(p) > 0) {
+			cpustat[CPUTIME_NICE] += cputime;
+			cpustat[CPUTIME_GUEST_NICE] += cputime;
+		} else {
+			cpustat[CPUTIME_USER] += cputime;
+			cpustat[CPUTIME_GUEST] += cputime;
+		}
 	} else {
-		cpustat[CPUTIME_USER] += cputime;
-		cpustat[CPUTIME_GUEST] += cputime;
+		if (task_nice(p) > 0) {
+			cpustat[CPUTIME_NICE] += cputime;
+			cpustat[CPUTIME_GUEST_NICE] += cputime;
+		} else {
+			cpustat[CPUTIME_USER] += cputime;
+			cpustat[CPUTIME_GUEST] += cputime;
+		}
 	}
+
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 68007be..403eec6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -32,6 +32,7 @@
 #include <linux/sched/user.h>
 #include <linux/sched/wake_q.h>
 #include <linux/sched/xacct.h>
+#include <linux/sched/bt.h>
 
 #include <uapi/linux/sched/types.h>
 
@@ -172,6 +173,12 @@ static inline int dl_policy(int policy)
 {
 	return policy == SCHED_DEADLINE;
 }
+
+static inline int bt_policy(int policy)
+{
+	return policy == SCHED_BT;
+}
+
 static inline bool valid_policy(int policy)
 {
 	return idle_policy(policy) || fair_policy(policy) ||
@@ -193,6 +200,11 @@ static inline int task_has_dl_policy(struct task_struct *p)
 	return dl_policy(p->policy);
 }
 
+static inline int task_has_bt_policy(struct task_struct *p)
+{
+	return bt_policy(p->policy);
+}
+
 #define cap_scale(v, s) ((v)*(s) >> SCHED_CAPACITY_SHIFT)
 
 /*
-- 
1.8.3.1

