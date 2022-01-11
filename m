Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0B148AAE9
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237061AbiAKJ4O (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 04:56:14 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57500 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237268AbiAKJ4N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 04:56:13 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V1ZVy34_1641894961;
Received: from AliYun.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0V1ZVy34_1641894961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Jan 2022 17:56:09 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] sched/core: Forced idle accounting per-cpu
Date:   Tue, 11 Jan 2022 17:56:00 +0800
Message-Id: <1641894961-9241-3-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Accounting for "forced idle" time per cpu, which is the time a cpu is
forced to idle by its SMT sibling.

As it's not accurate to measure the capacity loss only by cookie'd forced
idle time, and it's hard to trace the forced idle time caused by all the
uncookie'd tasks, we account the forced idle time from the perspective of
the cpu.

Forced idle time per cpu is displayed via /proc/schedstat, we can get the
forced idle time of cpu x from the 10th column of the row for cpu x. The
unit is ns. It also requires that schedstats is enabled.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 kernel/sched/core.c       |  7 ++++++-
 kernel/sched/core_sched.c |  7 +++++--
 kernel/sched/sched.h      |  4 ++++
 kernel/sched/stats.c      | 17 +++++++++++++++--
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e8187e7..a224b916 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -285,8 +285,10 @@ static void __sched_core_flip(bool enabled)
 
 		sched_core_lock(cpu, &flags);
 
-		for_each_cpu(t, smt_mask)
+		for_each_cpu(t, smt_mask) {
 			cpu_rq(t)->core_enabled = enabled;
+			cpu_rq(t)->in_forcedidle = false;
+		}
 
 		cpu_rq(cpu)->core->core_forceidle_start = 0;
 
@@ -5690,6 +5692,7 @@ static inline struct task_struct *pick_task(struct rq *rq)
 		 * another cpu during offline.
 		 */
 		rq->core_pick = NULL;
+		rq->in_forcedidle = false;
 		return __pick_next_task(rq, prev, rf);
 	}
 
@@ -5810,9 +5813,11 @@ static inline struct task_struct *pick_task(struct rq *rq)
 
 		rq_i->core_pick = p;
 
+		rq->in_forcedidle = false;
 		if (p == rq_i->idle) {
 			if (rq_i->nr_running) {
 				rq->core->core_forceidle_count++;
+				rq_i->in_forcedidle = true;
 				if (!fi_before)
 					rq->core->core_forceidle_seq++;
 			}
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index c8746a9..fe04805 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -242,7 +242,7 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 void __sched_core_account_forceidle(struct rq *rq)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
-	u64 delta, now = rq_clock(rq->core);
+	u64 delta_per_idlecpu, delta, now = rq_clock(rq->core);
 	struct rq *rq_i;
 	struct task_struct *p;
 	int i;
@@ -254,7 +254,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 	if (rq->core->core_forceidle_start == 0)
 		return;
 
-	delta = now - rq->core->core_forceidle_start;
+	delta_per_idlecpu = delta = now - rq->core->core_forceidle_start;
 	if (unlikely((s64)delta <= 0))
 		return;
 
@@ -277,6 +277,9 @@ void __sched_core_account_forceidle(struct rq *rq)
 		rq_i = cpu_rq(i);
 		p = rq_i->core_pick ?: rq_i->curr;
 
+		if (rq_i->in_forcedidle)
+			rq->rq_forceidle_time += delta_per_idlecpu;
+
 		if (p == rq_i->idle)
 			continue;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be9..9377d91 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1086,6 +1086,9 @@ struct rq {
 	/* try_to_wake_up() stats */
 	unsigned int		ttwu_count;
 	unsigned int		ttwu_local;
+#ifdef CONFIG_SCHED_CORE
+	u64			rq_forceidle_time;
+#endif
 #endif
 
 #ifdef CONFIG_CPU_IDLE
@@ -1115,6 +1118,7 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
+	bool			in_forcedidle;
 #endif
 };
 
diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 07dde29..ea22a8c 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -108,6 +108,16 @@ void __update_stats_enqueue_sleeper(struct rq *rq, struct task_struct *p,
 	}
 }
 
+#ifdef CONFIG_SCHED_CORE
+static inline u64 get_rq_forceidle_time(struct rq *rq) {
+	return rq->rq_forceidle_time;
+}
+#else
+static inline u64 get_rq_forceidle_time(struct rq *rq) {
+	return 0;
+}
+#endif
+
 /*
  * Current schedstat API version.
  *
@@ -125,21 +135,24 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		seq_printf(seq, "timestamp %lu\n", jiffies);
 	} else {
 		struct rq *rq;
+		u64 rq_forceidle_time;
 #ifdef CONFIG_SMP
 		struct sched_domain *sd;
 		int dcount = 0;
 #endif
 		cpu = (unsigned long)(v - 2);
 		rq = cpu_rq(cpu);
+		rq_forceidle_time = get_rq_forceidle_time(rq);
 
 		/* runqueue-specific stats */
 		seq_printf(seq,
-		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu",
+		    "cpu%d %u 0 %u %u %u %u %llu %llu %lu %llu",
 		    cpu, rq->yld_count,
 		    rq->sched_count, rq->sched_goidle,
 		    rq->ttwu_count, rq->ttwu_local,
 		    rq->rq_cpu_time,
-		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
+		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount,
+		    rq_forceidle_time);
 
 		seq_printf(seq, "\n");
 
-- 
1.8.3.1

