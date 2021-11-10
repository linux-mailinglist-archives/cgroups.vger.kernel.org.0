Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6015444C47F
	for <lists+cgroups@lfdr.de>; Wed, 10 Nov 2021 16:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhKJPjp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Nov 2021 10:39:45 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:35838 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231408AbhKJPjo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Nov 2021 10:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636558617; x=1668094617;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=EUi56rhv+Kceit5Thj41AVtzJb0GZGzTGk+fxka13fc=;
  b=gHLZPjbM3SijhLzmHIMZF89AsroNZksWFkrmYertX+bsm9k/o0lt419U
   glbnaiIYjmKoHB7uwzt6g6wu4P4AK0G+AilZPUb/ILEI+7RUphMRAn7su
   ucPJshNMSySWG9IEHq5mxWxw/Rdug3oYZ20DX4LssjojwfM7MpiXVP5zY
   w=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Nov 2021 07:36:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 07:36:55 -0800
Received: from th-lint-040.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 07:36:55 -0800
From:   Georgi Djakov <quic_c_gdjako@quicinc.com>
To:     <hannes@cmpxchg.org>, <vincent.guittot@linaro.org>,
        <juri.lelli@redhat.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <rostedt@goodmis.org>
CC:     <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <mhocko@kernel.org>, <vdavydov.dev@gmail.com>, <tj@kernel.org>,
        <axboe@kernel.dk>, <cgroups@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <djakov@kernel.org>
Subject: [RFC] psi: Add additional PSI counters for each type of memory pressure
Date:   Wed, 10 Nov 2021 07:36:37 -0800
Message-ID: <1636558597-248294-1-git-send-email-quic_c_gdjako@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Carlos Ramirez <carlrami@codeaurora.org>

Calculates psi totals for memory pressure subevents:
compaction, thrashing, direct compaction, direct reclaim, and kswapd0.
Uses upper 16 bits of psi_flags to track memory subevents.

Signed-off-by: Carlos Ramirez <carlrami@codeaurora.org>
Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
---
 block/blk-cgroup.c        |   4 +-
 block/blk-core.c          |   4 +-
 include/linux/psi.h       |   9 ++--
 include/linux/psi_types.h |  48 +++++++++++++++--
 kernel/sched/psi.c        | 132 ++++++++++++++++++++++++++++++++++++++++++----
 kernel/sched/stats.h      |  18 ++++---
 mm/compaction.c           |   4 +-
 mm/filemap.c              |   4 +-
 mm/memcontrol.c           |  12 ++---
 mm/page_alloc.c           |   8 +--
 mm/page_io.c              |   4 +-
 mm/vmscan.c               |   8 +--
 12 files changed, 207 insertions(+), 48 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 88b1fce90520..6f36fe2891db 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1678,7 +1678,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 		delay_nsec = min_t(u64, delay_nsec, 250 * NSEC_PER_MSEC);
 
 	if (use_memdelay)
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_BLK_CGROUP_THROTTLE);
 
 	exp = ktime_add_ns(now, delay_nsec);
 	tok = io_schedule_prepare();
@@ -1690,7 +1690,7 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 	io_schedule_finish(tok);
 
 	if (use_memdelay)
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_BLK_CGROUP_THROTTLE);
 }
 
 /**
diff --git a/block/blk-core.c b/block/blk-core.c
index b043de2baaac..043a85a00920 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1004,9 +1004,9 @@ void submit_bio(struct bio *bio)
 	    bio_flagged(bio, BIO_WORKINGSET))) {
 		unsigned long pflags;
 
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_BIO);
 		submit_bio_noacct(bio);
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_BIO);
 		return;
 	}
 
diff --git a/include/linux/psi.h b/include/linux/psi.h
index 65eb1476ac70..aac221e9f6b8 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -20,8 +20,9 @@ void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
 
-void psi_memstall_enter(unsigned long *flags);
-void psi_memstall_leave(unsigned long *flags);
+void psi_memstall_tick(struct task_struct *task, int cpu);
+void psi_memstall_enter(unsigned long *flags, u32 set);
+void psi_memstall_leave(unsigned long *flags, u32 clear);
 
 int psi_show(struct seq_file *s, struct psi_group *group, enum psi_res res);
 
@@ -42,8 +43,8 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 
 static inline void psi_init(void) {}
 
-static inline void psi_memstall_enter(unsigned long *flags) {}
-static inline void psi_memstall_leave(unsigned long *flags) {}
+static inline void psi_memstall_enter(unsigned long *flags, u32 set) {}
+static inline void psi_memstall_leave(unsigned long *flags, u32 clear) {}
 
 #ifdef CONFIG_CGROUPS
 static inline int psi_cgroup_alloc(struct cgroup *cgrp)
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 0a23300d49af..4b71cde93095 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -7,8 +7,6 @@
 #include <linux/kref.h>
 #include <linux/wait.h>
 
-#ifdef CONFIG_PSI
-
 /* Tracked task states */
 enum psi_task_count {
 	NR_IOWAIT,
@@ -21,7 +19,18 @@ enum psi_task_count {
 	 * don't have to special case any state tracking for it.
 	 */
 	NR_ONCPU,
-	NR_PSI_TASK_COUNTS = 4,
+	NR_BLK_CGROUP_THROTTLE,
+	NR_BIO,
+	NR_COMPACTION,
+	NR_THRASHING,
+	NR_CGROUP_RECLAIM_HIGH,
+	NR_CGROUP_RECLAIM_HIGH_SLEEP,
+	NR_CGROUP_TRY_CHARGE,
+	NR_DIRECT_COMPACTION,
+	NR_DIRECT_RECLAIM,
+	NR_READ_SWAPPAGE,
+	NR_KSWAPD,
+	NR_PSI_TASK_COUNTS = 16,
 };
 
 /* Task state bitmasks */
@@ -29,6 +38,26 @@ enum psi_task_count {
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
 #define TSK_ONCPU	(1 << NR_ONCPU)
+#define TSK_BLK_CGROUP_THROTTLE	(1 << NR_BLK_CGROUP_THROTTLE)
+#define TSK_BIO			(1 << NR_BIO)
+#define TSK_COMPACTION		(1 << NR_COMPACTION)
+#define TSK_THRASHING		(1 << NR_THRASHING)
+#define TSK_CGROUP_RECLAIM_HIGH	(1 << NR_CGROUP_RECLAIM_HIGH)
+#define TSK_CGROUP_RECLAIM_HIGH_SLEEP	(1 << NR_CGROUP_RECLAIM_HIGH_SLEEP)
+#define TSK_CGROUP_TRY_CHARGE	(1 << NR_CGROUP_TRY_CHARGE)
+#define TSK_DIRECT_COMPACTION	(1 << NR_DIRECT_COMPACTION)
+#define TSK_DIRECT_RECLAIM	(1 << NR_DIRECT_RECLAIM)
+#define TSK_READ_SWAPPAGE	(1 << NR_READ_SWAPPAGE)
+#define TSK_KSWAPD		(1 << NR_KSWAPD)
+#define TSK_MEMSTALL_MASK	(TSK_KSWAPD | TSK_READ_SWAPPAGE | \
+				TSK_DIRECT_RECLAIM | TSK_DIRECT_COMPACTION | \
+				TSK_CGROUP_TRY_CHARGE | \
+				TSK_CGROUP_RECLAIM_HIGH_SLEEP | \
+				TSK_CGROUP_RECLAIM_HIGH | TSK_THRASHING | \
+				TSK_COMPACTION | TSK_BIO | \
+				TSK_BLK_CGROUP_THROTTLE)
+
+#ifdef CONFIG_PSI
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
@@ -51,9 +80,20 @@ enum psi_states {
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
 	PSI_CPU_FULL,
+	PSI_BLK_CGROUP_THROTTLE,
+	PSI_BIO,
+	PSI_COMPACTION,
+	PSI_THRASHING,
+	PSI_CGROUP_RECLAIM_HIGH,
+	PSI_CGROUP_RECLAIM_HIGH_SLEEP,
+	PSI_CGROUP_TRY_CHARGE,
+	PSI_DIRECT_COMPACTION,
+	PSI_DIRECT_RECLAIM,
+	PSI_READ_SWAPPAGE,
+	PSI_KSWAPD,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 7,
+	NR_PSI_STATES = 18,
 };
 
 enum psi_aggregators {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 1652f2bb54b7..fe3f0a36051d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -225,22 +225,53 @@ void __init psi_init(void)
 
 static bool test_state(unsigned int *tasks, enum psi_states state)
 {
+	int memstall;
+
+	memstall = tasks[NR_BLK_CGROUP_THROTTLE] || tasks[NR_BIO] ||
+		   tasks[NR_COMPACTION] || tasks[NR_THRASHING] ||
+		   tasks[NR_CGROUP_RECLAIM_HIGH] || tasks[NR_CGROUP_RECLAIM_HIGH_SLEEP] ||
+		   tasks[NR_CGROUP_TRY_CHARGE] ||
+		   tasks[NR_DIRECT_COMPACTION] || tasks[NR_DIRECT_RECLAIM] ||
+		   tasks[NR_READ_SWAPPAGE] || tasks[NR_KSWAPD];
+
 	switch (state) {
 	case PSI_IO_SOME:
 		return unlikely(tasks[NR_IOWAIT]);
 	case PSI_IO_FULL:
 		return unlikely(tasks[NR_IOWAIT] && !tasks[NR_RUNNING]);
 	case PSI_MEM_SOME:
-		return unlikely(tasks[NR_MEMSTALL]);
+		return memstall;
 	case PSI_MEM_FULL:
-		return unlikely(tasks[NR_MEMSTALL] && !tasks[NR_RUNNING]);
+		return !tasks[NR_RUNNING] && memstall;
 	case PSI_CPU_SOME:
 		return unlikely(tasks[NR_RUNNING] > tasks[NR_ONCPU]);
 	case PSI_CPU_FULL:
 		return unlikely(tasks[NR_RUNNING] && !tasks[NR_ONCPU]);
 	case PSI_NONIDLE:
-		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
+		return tasks[NR_IOWAIT] || memstall ||
 			tasks[NR_RUNNING];
+	case PSI_BLK_CGROUP_THROTTLE:
+		return tasks[NR_BLK_CGROUP_THROTTLE];
+	case PSI_BIO:
+		return tasks[NR_BIO];
+	case PSI_COMPACTION:
+		return tasks[NR_COMPACTION];
+	case PSI_THRASHING:
+		return tasks[NR_THRASHING];
+	case PSI_CGROUP_RECLAIM_HIGH:
+		return tasks[NR_CGROUP_RECLAIM_HIGH];
+	case PSI_CGROUP_RECLAIM_HIGH_SLEEP:
+		return tasks[NR_CGROUP_RECLAIM_HIGH_SLEEP];
+	case PSI_CGROUP_TRY_CHARGE:
+		return tasks[NR_CGROUP_TRY_CHARGE];
+	case PSI_DIRECT_COMPACTION:
+		return tasks[NR_DIRECT_COMPACTION];
+	case PSI_DIRECT_RECLAIM:
+		return tasks[NR_DIRECT_RECLAIM];
+	case PSI_READ_SWAPPAGE:
+		return tasks[NR_READ_SWAPPAGE];
+	case PSI_KSWAPD:
+		return tasks[NR_KSWAPD];
 	default:
 		return false;
 	}
@@ -679,6 +710,39 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
 
 	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
+
+	if (groupc->state_mask & (1 << PSI_BLK_CGROUP_THROTTLE))
+		groupc->times[PSI_BLK_CGROUP_THROTTLE] += delta;
+
+	if (groupc->state_mask & (1 << PSI_BIO))
+		groupc->times[PSI_BIO] += delta;
+
+	if (groupc->state_mask & (1 << PSI_COMPACTION))
+		groupc->times[PSI_COMPACTION] += delta;
+
+	if (groupc->state_mask & (1 << PSI_THRASHING))
+		groupc->times[PSI_THRASHING] += delta;
+
+	if (groupc->state_mask & (1 << PSI_CGROUP_RECLAIM_HIGH))
+		groupc->times[PSI_CGROUP_RECLAIM_HIGH] += delta;
+
+	if (groupc->state_mask & (1 << PSI_CGROUP_RECLAIM_HIGH_SLEEP))
+		groupc->times[PSI_CGROUP_RECLAIM_HIGH_SLEEP] += delta;
+
+	if (groupc->state_mask & (1 << PSI_CGROUP_TRY_CHARGE))
+		groupc->times[PSI_CGROUP_TRY_CHARGE] += delta;
+
+	if (groupc->state_mask & (1 << PSI_DIRECT_RECLAIM))
+		groupc->times[PSI_DIRECT_RECLAIM] += delta;
+
+	if (groupc->state_mask & (1 << PSI_DIRECT_COMPACTION))
+		groupc->times[PSI_DIRECT_COMPACTION] += delta;
+
+	if (groupc->state_mask & (1 << PSI_READ_SWAPPAGE))
+		groupc->times[PSI_READ_SWAPPAGE] += delta;
+
+	if (groupc->state_mask & (1 << PSI_KSWAPD))
+		groupc->times[PSI_KSWAPD] += delta;
 }
 
 static void psi_group_change(struct psi_group *group, int cpu,
@@ -889,7 +953,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
  * Marks the calling task as being stalled due to a lack of memory,
  * such as waiting for a refault or performing reclaim.
  */
-void psi_memstall_enter(unsigned long *flags)
+void psi_memstall_enter(unsigned long *flags, u32 set)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -908,7 +972,7 @@ void psi_memstall_enter(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->in_memstall = 1;
-	psi_task_change(current, 0, TSK_MEMSTALL);
+	psi_task_change(current, 0, set);
 
 	rq_unlock_irq(rq, &rf);
 }
@@ -919,7 +983,7 @@ void psi_memstall_enter(unsigned long *flags)
  *
  * Marks the calling task as no longer stalled due to lack of memory.
  */
-void psi_memstall_leave(unsigned long *flags)
+void psi_memstall_leave(unsigned long *flags, u32 clear)
 {
 	struct rq_flags rf;
 	struct rq *rq;
@@ -937,7 +1001,7 @@ void psi_memstall_leave(unsigned long *flags)
 	rq = this_rq_lock_irq(&rf);
 
 	current->in_memstall = 0;
-	psi_task_change(current, TSK_MEMSTALL, 0);
+	psi_task_change(current, clear, 0);
 
 	rq_unlock_irq(rq, &rf);
 }
@@ -1021,6 +1085,17 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 	 */
 	task_flags = task->psi_flags;
 
+	if (task_on_rq_queued(task)) {
+		task_flags = TSK_RUNNING;
+		if (task_current(rq, task))
+			task_flags |= TSK_ONCPU;
+	} else if (task->in_iowait) {
+		task_flags = TSK_IOWAIT;
+	}
+
+	if (task->psi_flags & TSK_MEMSTALL_MASK)
+		task_flags |= task->psi_flags & TSK_MEMSTALL_MASK;
+
 	if (task_flags)
 		psi_task_change(task, task_flags, 0);
 
@@ -1053,19 +1128,56 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 	for (full = 0; full < 2; full++) {
 		unsigned long avg[3];
 		u64 total;
+		u64 total_blk_cgroup_throttle;
+		u64 total_bio;
+		u64 total_compaction;
+		u64 total_thrashing;
+		u64 total_cgroup_reclaim_high;
+		u64 total_cgroup_reclaim_high_sleep;
+		u64 total_cgroup_try_charge;
+		u64 total_direct_compaction;
+		u64 total_direct_reclaim;
+		u64 total_read_swappage;
+		u64 total_kswapd;
 		int w;
 
 		for (w = 0; w < 3; w++)
 			avg[w] = group->avg[res * 2 + full][w];
 		total = div_u64(group->total[PSI_AVGS][res * 2 + full],
 				NSEC_PER_USEC);
-
-		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
+		total_blk_cgroup_throttle = div_u64(group->total[PSI_AVGS][PSI_BLK_CGROUP_THROTTLE],
+						    NSEC_PER_USEC);
+		total_bio = div_u64(group->total[PSI_AVGS][PSI_BIO],
+				    NSEC_PER_USEC);
+		total_compaction = div_u64(group->total[PSI_AVGS][PSI_COMPACTION],
+					   NSEC_PER_USEC);
+		total_thrashing = div_u64(group->total[PSI_AVGS][PSI_THRASHING],
+					  NSEC_PER_USEC);
+		total_cgroup_reclaim_high = div_u64(group->total[PSI_AVGS][PSI_CGROUP_RECLAIM_HIGH],
+						    NSEC_PER_USEC);
+		total_cgroup_reclaim_high_sleep = div_u64(group->total[PSI_AVGS][PSI_CGROUP_RECLAIM_HIGH_SLEEP],
+							  NSEC_PER_USEC);
+		total_cgroup_try_charge = div_u64(group->total[PSI_AVGS][PSI_CGROUP_TRY_CHARGE],
+						  NSEC_PER_USEC);
+		total_direct_compaction = div_u64(group->total[PSI_AVGS][PSI_DIRECT_COMPACTION],
+						  NSEC_PER_USEC);
+		total_direct_reclaim = div_u64(group->total[PSI_AVGS][PSI_DIRECT_RECLAIM],
+					       NSEC_PER_USEC);
+		total_read_swappage = div_u64(group->total[PSI_AVGS][PSI_READ_SWAPPAGE],
+					      NSEC_PER_USEC);
+		total_kswapd = div_u64(group->total[PSI_AVGS][PSI_KSWAPD],
+				       NSEC_PER_USEC);
+
+		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu %llu\n",
 			   full ? "full" : "some",
 			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
 			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
 			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
-			   total);
+			   total, total_blk_cgroup_throttle, total_bio, total_compaction,
+			   total_thrashing, total_cgroup_reclaim_high,
+			   total_cgroup_reclaim_high_sleep, total_cgroup_try_charge,
+			   total_direct_compaction, total_direct_reclaim, total_read_swappage,
+			   total_kswapd);
 	}
 
 	return 0;
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index cfb0893a83d4..02b9f2a71c2c 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -114,13 +114,15 @@ __schedstats_from_se(struct sched_entity *se)
 static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 {
 	int clear = 0, set = TSK_RUNNING;
+	int v;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
 	if (!wakeup || p->sched_psi_wake_requeue) {
-		if (p->in_memstall)
-			set |= TSK_MEMSTALL;
+		v = p->psi_flags & TSK_MEMSTALL_MASK;
+		if (v)
+			set |= v;
 		if (p->sched_psi_wake_requeue)
 			p->sched_psi_wake_requeue = 0;
 	} else {
@@ -134,6 +136,7 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
 	int clear = TSK_RUNNING;
+	int v;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
@@ -147,8 +150,9 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 	if (sleep)
 		return;
 
-	if (p->in_memstall)
-		clear |= TSK_MEMSTALL;
+	v = p->psi_flags & TSK_MEMSTALL_MASK;
+	if (v)
+		clear |= v;
 
 	psi_task_change(p, clear, 0);
 }
@@ -166,11 +170,13 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 		struct rq_flags rf;
 		struct rq *rq;
 		int clear = 0;
+		int v;
 
 		if (p->in_iowait)
 			clear |= TSK_IOWAIT;
-		if (p->in_memstall)
-			clear |= TSK_MEMSTALL;
+		v = p->psi_flags & TSK_MEMSTALL_MASK;
+		if (v)
+			clear |= v;
 
 		rq = __task_rq_lock(p, &rf);
 		psi_task_change(p, clear, 0);
diff --git a/mm/compaction.c b/mm/compaction.c
index 6e446094ce90..2653589a006f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2937,9 +2937,9 @@ static int kcompactd(void *p)
 			kcompactd_work_requested(pgdat), timeout) &&
 			!pgdat->proactive_compact_trigger) {
 
-			psi_memstall_enter(&pflags);
+			psi_memstall_enter(&pflags, TSK_COMPACTION);
 			kcompactd_do_work(pgdat);
-			psi_memstall_leave(&pflags);
+			psi_memstall_leave(&pflags, TSK_COMPACTION);
 			/*
 			 * Reset the timeout value. The defer timeout from
 			 * proactive compaction is lost here but that is fine
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..0de1941932f6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1303,7 +1303,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 			delayacct_thrashing_start();
 			delayacct = true;
 		}
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_THRASHING);
 		thrashing = true;
 	}
 
@@ -1404,7 +1404,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	if (thrashing) {
 		if (delayacct)
 			delayacct_thrashing_end();
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_THRASHING);
 	}
 
 	/*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..908a52a65c09 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2342,10 +2342,10 @@ static unsigned long reclaim_high(struct mem_cgroup *memcg,
 
 		memcg_memory_event(memcg, MEMCG_HIGH);
 
-		psi_memstall_enter(&pflags);
+		psi_memstall_enter(&pflags, TSK_CGROUP_RECLAIM_HIGH);
 		nr_reclaimed += try_to_free_mem_cgroup_pages(memcg, nr_pages,
 							     gfp_mask, true);
-		psi_memstall_leave(&pflags);
+		psi_memstall_leave(&pflags, TSK_CGROUP_RECLAIM_HIGH);
 	} while ((memcg = parent_mem_cgroup(memcg)) &&
 		 !mem_cgroup_is_root(memcg));
 
@@ -2572,9 +2572,9 @@ void mem_cgroup_handle_over_high(void)
 	 * schedule_timeout_killable sets TASK_KILLABLE). This means we don't
 	 * need to account for any ill-begotten jiffies to pay them off later.
 	 */
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_CGROUP_RECLAIM_HIGH_SLEEP);
 	schedule_timeout_killable(penalty_jiffies);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_CGROUP_RECLAIM_HIGH_SLEEP);
 
 out:
 	css_put(&memcg->css);
@@ -2641,10 +2641,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	memcg_memory_event(mem_over_limit, MEMCG_MAX);
 
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_CGROUP_TRY_CHARGE);
 	nr_reclaimed = try_to_free_mem_cgroup_pages(mem_over_limit, nr_pages,
 						    gfp_mask, may_swap);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_CGROUP_TRY_CHARGE);
 
 	if (mem_cgroup_margin(mem_over_limit) >= nr_pages)
 		goto retry;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..734ea00a0a72 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4347,14 +4347,14 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	if (!order)
 		return NULL;
 
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_DIRECT_COMPACTION);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	*compact_result = try_to_compact_pages(gfp_mask, order, alloc_flags, ac,
 								prio, &page);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_DIRECT_COMPACTION);
 
 	if (*compact_result == COMPACT_SKIPPED)
 		return NULL;
@@ -4581,7 +4581,7 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 
 	/* We now go into synchronous reclaim */
 	cpuset_memory_pressure_bump();
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_DIRECT_RECLAIM);
 	fs_reclaim_acquire(gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
 
@@ -4590,7 +4590,7 @@ __perform_reclaim(gfp_t gfp_mask, unsigned int order,
 
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(gfp_mask);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_DIRECT_RECLAIM);
 
 	cond_resched();
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 9725c7e1eeea..680d1a8d5d60 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -369,7 +369,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	 * or the submitting cgroup IO-throttled, submission can be a
 	 * significant part of overall IO time.
 	 */
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_READ_SWAPPAGE);
 
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
@@ -431,7 +431,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio_put(bio);
 
 out:
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_READ_SWAPPAGE);
 	return ret;
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index fb9584641ac7..baa29a6be6df 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4096,7 +4096,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	};
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_KSWAPD);
 	__fs_reclaim_acquire(_THIS_IP_);
 
 	count_vm_event(PAGEOUTRUN);
@@ -4278,7 +4278,7 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 
 	snapshot_refaults(NULL, pgdat);
 	__fs_reclaim_release(_THIS_IP_);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_KSWAPD);
 	set_task_reclaim_state(current, NULL);
 
 	/*
@@ -4713,7 +4713,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 					   sc.gfp_mask);
 
 	cond_resched();
-	psi_memstall_enter(&pflags);
+	psi_memstall_enter(&pflags, TSK_KSWAPD);
 	fs_reclaim_acquire(sc.gfp_mask);
 	/*
 	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
@@ -4738,7 +4738,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	current->flags &= ~PF_SWAPWRITE;
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc.gfp_mask);
-	psi_memstall_leave(&pflags);
+	psi_memstall_leave(&pflags, TSK_KSWAPD);
 
 	trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
 
