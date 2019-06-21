Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BECB4E170
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfFUHzU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 03:55:20 -0400
Received: from mail4.tencent.com ([183.57.53.109]:54740 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfFUHzQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 03:55:16 -0400
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail4.tencent.com (Postfix) with ESMTP id 15DA4502D4;
        Fri, 21 Jun 2019 15:47:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.22.120.143) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 15:47:19 +0800
From:   <xiaoggchen@tencent.com>
To:     <jasperwang@tencent.com>, <heddchen@tencent.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, chen xiaoguang <xiaoggchen@tencent.com>,
        Newton Gao <newtongao@tencent.com>,
        Shook Liu <shookliu@tencent.com>,
        Zhiguang Peng <zgpeng@tencent.com>
Subject: [PATCH 1/5] sched/BT: add BT scheduling entity
Date:   Fri, 21 Jun 2019 15:45:53 +0800
Message-ID: <1561103157-11246-2-git-send-email-xiaoggchen@tencent.com>
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

Signed-off-by: Newton Gao <newtongao@tencent.com>
Signed-off-by: Shook Liu <shookliu@tencent.com>
Signed-off-by: Zhiguang Peng <zgpeng@tencent.com>
Signed-off-by: Xiaoguang Chen <xiaoggchen@tencent.com>
---
 include/linux/sched.h      | 18 ++++++++++++++++++
 include/uapi/linux/sched.h |  1 +
 kernel/sched/Makefile      |  2 +-
 kernel/sched/bt.c          | 17 +++++++++++++++++
 kernel/sched/core.c        | 10 ++++++++++
 kernel/sched/sched.h       | 22 ++++++++++++++++++++++
 6 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 kernel/sched/bt.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1183741..c0dfbb2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -560,6 +560,23 @@ struct sched_dl_entity {
 	struct hrtimer inactive_timer;
 };
 
+struct sched_bt_entity {
+	struct load_weight load;
+	struct rb_node          run_node;
+	unsigned int            on_rq;
+
+	u64                     exec_start;
+	u64                     sum_exec_runtime;
+	u64                     vruntime;
+	u64                     prev_sum_exec_runtime;
+
+	u64                     nr_migrations;
+
+#if defined(CONFIG_SCHEDSTATS) || defined(CONFIG_LATENCYTOP)
+	struct sched_statistics *statistics;
+#endif
+};
+
 union rcu_special {
 	struct {
 		u8			blocked;
@@ -639,6 +656,7 @@ struct task_struct {
 	struct task_group		*sched_task_group;
 #endif
 	struct sched_dl_entity		dl;
+	struct sched_bt_entity		bt;
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 	/* List of struct preempt_notifier: */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index ed4ee17..410042a 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -41,6 +41,7 @@
 /* SCHED_ISO: reserved but not implemented yet */
 #define SCHED_IDLE		5
 #define SCHED_DEADLINE		6
+#define SCHED_BT		7
 
 /* Can be ORed in to make sure the process is reverted back to SCHED_NORMAL on fork */
 #define SCHED_RESET_ON_FORK     0x40000000
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5..938e539 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -17,7 +17,7 @@ CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
 obj-y += core.o loadavg.o clock.o cputime.o
-obj-y += idle.o fair.o rt.o deadline.o
+obj-y += idle.o fair.o rt.o deadline.o bt.o
 obj-y += wait.o wait_bit.o swait.o completion.o
 
 obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
diff --git a/kernel/sched/bt.c b/kernel/sched/bt.c
new file mode 100644
index 0000000..56566e6
--- /dev/null
+++ b/kernel/sched/bt.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Background Scheduling Class
+ */
+
+#include "sched.h"
+
+void init_bt_rq(struct bt_rq *bt_rq)
+{
+	bt_rq->tasks_timeline = RB_ROOT;
+	bt_rq->min_vruntime = (u64)(-(1LL << 20));
+#ifndef CONFIG_64BIT
+	bt_rq->min_vruntime_copy = bt_rq->min_vruntime;
+#endif
+}
+
+
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 874c427..3eb4723 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2138,6 +2138,13 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
 
+	p->bt.on_rq			= 0;
+	p->bt.exec_start		= 0;
+	p->bt.sum_exec_runtime		= 0;
+	p->bt.prev_sum_exec_runtime	= 0;
+	p->bt.nr_migrations		= 0;
+	p->bt.vruntime			= 0;
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
@@ -2145,6 +2152,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->se.statistics, 0, sizeof(p->se.statistics));
+	p->bt.statistics = &p->se.statistics;
 #endif
 
 	RB_CLEAR_NODE(&p->dl.rb_node);
@@ -5974,6 +5982,7 @@ void __init sched_init(void)
 		init_cfs_rq(&rq->cfs);
 		init_rt_rq(&rq->rt);
 		init_dl_rq(&rq->dl);
+		init_bt_rq(&rq->bt);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		INIT_LIST_HEAD(&rq->leaf_cfs_rq_list);
@@ -6186,6 +6195,7 @@ void normalize_rt_tasks(void)
 			continue;
 
 		p->se.exec_start = 0;
+		p->bt.exec_start = 0;
 		schedstat_set(p->se.statistics.wait_start,  0);
 		schedstat_set(p->se.statistics.sleep_start, 0);
 		schedstat_set(p->se.statistics.block_start, 0);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b52ed1a..320c80d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -331,6 +331,7 @@ bool __dl_overflow(struct dl_bw *dl_b, int cpus, u64 old_bw, u64 new_bw)
 
 struct cfs_rq;
 struct rt_rq;
+struct bt_rq;
 
 extern struct list_head task_groups;
 
@@ -576,6 +577,25 @@ struct cfs_rq {
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
 
+struct bt_rq {
+	struct load_weight load;
+	unsigned int bt_nr_running;
+	unsigned long nr_uninterruptible;
+
+	u64 exec_clock;
+	u64 min_vruntime;
+#ifndef CONFIG_64BIT
+	u64 min_vruntime_copy;
+#endif
+#ifdef CONFIG_SCHED_DEBUG
+	unsigned int            nr_spread_over;
+#endif
+	struct rb_root tasks_timeline;
+	struct rb_node *rb_leftmost;
+
+	struct sched_bt_entity *curr, *next;
+};
+
 static inline int rt_bandwidth_enabled(void)
 {
 	return sysctl_sched_rt_runtime >= 0;
@@ -838,6 +858,7 @@ struct rq {
 	struct cfs_rq		cfs;
 	struct rt_rq		rt;
 	struct dl_rq		dl;
+	struct bt_rq		bt;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	/* list of leaf cfs_rq on this CPU: */
@@ -2107,6 +2128,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 extern void init_cfs_rq(struct cfs_rq *cfs_rq);
 extern void init_rt_rq(struct rt_rq *rt_rq);
 extern void init_dl_rq(struct dl_rq *dl_rq);
+extern void init_bt_rq(struct bt_rq *bt_rq);
 
 extern void cfs_bandwidth_usage_inc(void);
 extern void cfs_bandwidth_usage_dec(void);
-- 
1.8.3.1

