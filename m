Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66C284E16C
	for <lists+cgroups@lfdr.de>; Fri, 21 Jun 2019 09:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbfFUHzK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 21 Jun 2019 03:55:10 -0400
Received: from mail4.tencent.com ([183.57.53.109]:44579 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfFUHzK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 21 Jun 2019 03:55:10 -0400
X-Greylist: delayed 458 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Jun 2019 03:55:09 EDT
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail4.tencent.com (Postfix) with ESMTP id 3E3635022C;
        Fri, 21 Jun 2019 15:47:25 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.22.120.143) by
 EXHUB-SZMail01.tencent.com (10.14.6.21) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Jun 2019 15:47:24 +0800
From:   <xiaoggchen@tencent.com>
To:     <jasperwang@tencent.com>, <heddchen@tencent.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>, <tj@kernel.org>,
        <lizefan@huawei.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, chen xiaoguang <xiaoggchen@tencent.com>,
        Newton Gao <newtongao@tencent.com>,
        Shook Liu <shookliu@tencent.com>,
        Zhiguang Peng <zgpeng@tencent.com>
Subject: [PATCH 5/5] sched/BT: add debug information for BT scheduling class
Date:   Fri, 21 Jun 2019 15:45:57 +0800
Message-ID: <1561103157-11246-6-git-send-email-xiaoggchen@tencent.com>
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
 kernel/sched/bt.c    | 11 +++++++++++
 kernel/sched/debug.c | 37 +++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 51 insertions(+)

diff --git a/kernel/sched/bt.c b/kernel/sched/bt.c
index 87eb04f..11b4abd 100644
--- a/kernel/sched/bt.c
+++ b/kernel/sched/bt.c
@@ -1027,3 +1027,14 @@ static unsigned int get_rr_interval_bt(struct rq *rq, struct task_struct *task)
 	.update_curr            = update_curr_bt,
 };
 
+#ifdef CONFIG_SCHED_DEBUG
+void print_bt_stats(struct seq_file *m, int cpu)
+{
+	struct bt_rq *bt_rq;
+
+	rcu_read_lock();
+	bt_rq = &cpu_rq(cpu)->bt;
+	print_bt_rq(m, cpu, bt_rq);
+	rcu_read_unlock();
+}
+#endif
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 678bfb9..44d0859 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -497,6 +497,43 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 	rcu_read_unlock();
 }
 
+void print_bt_rq(struct seq_file *m, int cpu, struct bt_rq *bt_rq)
+{
+	s64 MIN_vruntime = -1, min_vruntime, max_vruntime = -1,
+		spread, rq0_min_vruntime, spread0;
+	struct rq *rq = cpu_rq(cpu);
+	unsigned long flags;
+
+	SEQ_printf(m, "\nbt_rq[%d]:\n", cpu);
+
+	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", "exec_clock",
+			SPLIT_NS(bt_rq->exec_clock));
+
+	raw_spin_lock_irqsave(&rq->lock, flags);
+	if (bt_rq->rb_leftmost)
+		MIN_vruntime = (__pick_first_bt_entity(bt_rq))->vruntime;
+	min_vruntime = bt_rq->min_vruntime;
+	rq0_min_vruntime = cpu_rq(0)->bt.min_vruntime;
+	raw_spin_unlock_irqrestore(&rq->lock, flags);
+	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", "MIN_vruntime",
+		SPLIT_NS(MIN_vruntime));
+	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", "min_vruntime",
+		SPLIT_NS(min_vruntime));
+	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", "max_vruntime",
+		SPLIT_NS(max_vruntime));
+	spread = max_vruntime - MIN_vruntime;
+	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", "spread",
+		SPLIT_NS(spread));
+	spread0 = min_vruntime - rq0_min_vruntime;
+	SEQ_printf(m, "  .%-30s: %lld.%06ld\n", "spread0",
+		SPLIT_NS(spread0));
+	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
+		bt_rq->nr_spread_over);
+	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", bt_rq->bt_nr_running);
+	SEQ_printf(m, "  .%-30s: %ld\n", "load", bt_rq->load.weight);
+}
+
+
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
 	s64 MIN_vruntime = -1, min_vruntime, max_vruntime = -1,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 403eec6..749f580 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2120,6 +2120,8 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 
+extern struct sched_bt_entity *__pick_first_bt_entity(struct bt_rq *bt_rq);
+
 #ifdef	CONFIG_SCHED_DEBUG
 extern bool sched_debug_enabled;
 
@@ -2129,6 +2131,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 extern void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq);
 extern void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq);
 extern void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq);
+extern void print_bt_rq(struct seq_file *m, int cpu, struct bt_rq *bt_rq);
 #ifdef CONFIG_NUMA_BALANCING
 extern void
 show_numa_stats(struct task_struct *p, struct seq_file *m);
-- 
1.8.3.1

