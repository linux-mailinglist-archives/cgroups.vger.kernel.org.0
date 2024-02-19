Return-Path: <cgroups+bounces-1689-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B0859EB5
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 09:48:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10172B22042
	for <lists+cgroups@lfdr.de>; Mon, 19 Feb 2024 08:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E002261D;
	Mon, 19 Feb 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mTlpOubX"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8E23753;
	Mon, 19 Feb 2024 08:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708332434; cv=none; b=BXIq6SL6RPXOekofAGm463tQln+etAvYgHEdPAOb5PcSoQ8ej6beA919+K7rip99dnugx2yQBp/6ITnh45SdT8cjWi8UlPgY1418HSOeDRBPzxyAn9glAzADUBxSzctYeZo0RIBeW7YqhNYZDz6UsQeaTkePEKlXYoO2/Mu69kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708332434; c=relaxed/simple;
	bh=ihWIssvJkQncC+jC2TB4WDCuknRtKoLzr4zqJVQ0yLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=keS2foHYETWtSH2qcV+YH7h/8jWFxuOdtd1L3G8NPBgu1KwLWb7y6uu9e/hWwRtvzx+D9GGgFFoT3wocdeYQrH4E5zRABPaQjUZt39RvH2KYXHKlsENn8KXzRhUtDhRwWPL3lXMZp5XQnLIc5j0m7s1KNA0Eu91vj2mQvPNvn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mTlpOubX; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708332424; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vheM6dezHF54wbosvNGNx9wvbnqGuhfcY5ROdrS8jUc=;
	b=mTlpOubXPHzxbuj6jbnJtzCXGCGvBvd/gg/gvrRlCyi9mDBfceSUmWU6sEzniC+y0H3iZBCGAs2dDQ8Z0imjEXCe/NRMuAWdMa24mhP02kAFGsGTTpq12yeJwekTCV7h2RI7MHYP/4nSiV3SLjb+aommPRGwJnJLLj8jGWI//n0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W0rp62u_1708332094;
Received: from localhost.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0W0rp62u_1708332094)
          by smtp.aliyun-inc.com;
          Mon, 19 Feb 2024 16:41:44 +0800
From: Cruz Zhao <CruzZhao@linux.alibaba.com>
To: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched/core: introduce CPUTIME_FORCEIDLE_TASK
Date: Mon, 19 Feb 2024 16:41:34 +0800
Message-Id: <20240219084134.10673-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As core sched uses rq_clock() as clock source to account forceidle
time, irq time will be accounted into forceidle time. However, in
some scenarios, forceidle sum will be much larger than exec runtime,
e.g., we observed that forceidle time of task calling futex_wake()
is 50% larger than exec runtime, which is confusing.

We introduce cpustat[CPUTIME_FORCEIDLE_TASK] to account the time
that a task is actually running while the SMT siblings are forced
idle, using rq_clock_task() as clock source.

     |<---------------------forceidle time--------------------->|
     |<--forceidle task time-->|      |<--forceidle task time-->|
     |<------exec runtime----->|      |<-----exec runtime------>|
ht0  |          A running      | irq  |         A running       |

ht1  |                          idle                            |
     |                        B queuing                         |

Interfaces:
 - task level: /proc/$pid/sched, row core_forceidle_task_sum.
 - cgroup level: /sys/fs/cgroup/$cg/cpu.stat, row
     core_sched.force_idle_task_usec.
Reported-by: Lawrence Zou <lawrence.zx@alibaba-inc.com>
Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 include/linux/cgroup-defs.h |  1 +
 include/linux/kernel_stat.h |  3 ++-
 include/linux/sched.h       |  1 +
 kernel/cgroup/rstat.c       | 11 +++++++++++
 kernel/sched/core.c         |  5 +++++
 kernel/sched/core_sched.c   |  5 ++++-
 kernel/sched/cputime.c      |  4 +++-
 kernel/sched/debug.c        |  1 +
 kernel/sched/sched.h        |  1 +
 9 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ea48c861cd36..5576ca7df8a2 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -309,6 +309,7 @@ struct cgroup_base_stat {
 
 #ifdef CONFIG_SCHED_CORE
 	u64 forceidle_sum;
+	u64 forceidle_task_sum;
 #endif
 };
 
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 9935f7ecbfb9..841b8306901c 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -30,6 +30,7 @@ enum cpu_usage_stat {
 	CPUTIME_GUEST_NICE,
 #ifdef CONFIG_SCHED_CORE
 	CPUTIME_FORCEIDLE,
+	CPUTIME_FORCEIDLE_TASK,
 #endif
 	NR_STATS,
 };
@@ -131,7 +132,7 @@ extern void account_process_tick(struct task_struct *, int user);
 extern void account_idle_ticks(unsigned long ticks);
 
 #ifdef CONFIG_SCHED_CORE
-extern void __account_forceidle_time(struct task_struct *tsk, u64 delta);
+extern void __account_forceidle_time(struct task_struct *tsk, u64 delta, u64 delta_task);
 #endif
 
 #endif /* _LINUX_KERNEL_STAT_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ffe8f618ab86..88e77892d209 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -529,6 +529,7 @@ struct sched_statistics {
 
 #ifdef CONFIG_SCHED_CORE
 	u64				core_forceidle_sum;
+	u64				core_forceidle_task_sum;
 #endif
 #endif /* CONFIG_SCHEDSTATS */
 } ____cacheline_aligned;
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a8350d2d63e6..c065c7baccae 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -365,6 +365,7 @@ static void cgroup_base_stat_add(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->cputime.sum_exec_runtime += src_bstat->cputime.sum_exec_runtime;
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum += src_bstat->forceidle_sum;
+	dst_bstat->forceidle_task_sum += src_bstat->forceidle_task_sum;
 #endif
 }
 
@@ -376,6 +377,7 @@ static void cgroup_base_stat_sub(struct cgroup_base_stat *dst_bstat,
 	dst_bstat->cputime.sum_exec_runtime -= src_bstat->cputime.sum_exec_runtime;
 #ifdef CONFIG_SCHED_CORE
 	dst_bstat->forceidle_sum -= src_bstat->forceidle_sum;
+	dst_bstat->forceidle_task_sum -= src_bstat->forceidle_task_sum;
 #endif
 }
 
@@ -469,6 +471,9 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	case CPUTIME_FORCEIDLE:
 		rstatc->bstat.forceidle_sum += delta_exec;
 		break;
+	case CPUTIME_FORCEIDLE_TASK:
+		rstatc->bstat.forceidle_task_sum += delta_exec;
+		break;
 #endif
 	default:
 		break;
@@ -512,6 +517,7 @@ static void root_cgroup_cputime(struct cgroup_base_stat *bstat)
 
 #ifdef CONFIG_SCHED_CORE
 		bstat->forceidle_sum += cpustat[CPUTIME_FORCEIDLE];
+		bstat->forceidle_task_sum += cpustat[CPUTIME_FORCEIDLE_TASK];
 #endif
 	}
 }
@@ -523,6 +529,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	struct cgroup_base_stat bstat;
 #ifdef CONFIG_SCHED_CORE
 	u64 forceidle_time;
+	u64 forceidle_task_time;
 #endif
 
 	if (cgroup_parent(cgrp)) {
@@ -532,6 +539,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 			       &utime, &stime);
 #ifdef CONFIG_SCHED_CORE
 		forceidle_time = cgrp->bstat.forceidle_sum;
+		forceidle_task_time = cgrp->bstat.forceidle_task_sum;
 #endif
 		cgroup_rstat_flush_release();
 	} else {
@@ -541,6 +549,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		stime = bstat.cputime.stime;
 #ifdef CONFIG_SCHED_CORE
 		forceidle_time = bstat.forceidle_sum;
+		forceidle_task_time = bstat.forceidle_task_sum;
 #endif
 	}
 
@@ -549,6 +558,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 	do_div(stime, NSEC_PER_USEC);
 #ifdef CONFIG_SCHED_CORE
 	do_div(forceidle_time, NSEC_PER_USEC);
+	do_div(forceidle_task_time, NSEC_PER_USEC);
 #endif
 
 	seq_printf(seq, "usage_usec %llu\n"
@@ -558,6 +568,7 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 
 #ifdef CONFIG_SCHED_CORE
 	seq_printf(seq, "core_sched.force_idle_usec %llu\n", forceidle_time);
+	seq_printf(seq, "core_sched.force_idle_task_usec %llu\n", forceidle_task_time);
 #endif
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9116bcc90346..1b2c32db5849 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -370,6 +370,7 @@ static void __sched_core_flip(bool enabled)
 			cpu_rq(t)->core_enabled = enabled;
 
 		cpu_rq(cpu)->core->core_forceidle_start = 0;
+		cpu_rq(cpu)->core->core_forceidle_start_task = 0;
 
 		sched_core_unlock(cpu, &flags);
 
@@ -6162,6 +6163,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		sched_core_account_forceidle(rq);
 		/* reset after accounting force idle */
 		rq->core->core_forceidle_start = 0;
+		rq->core->core_forceidle_start_task = 0;
 		rq->core->core_forceidle_count = 0;
 		rq->core->core_forceidle_occupation = 0;
 		need_sync = true;
@@ -6253,6 +6255,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 
 	if (schedstat_enabled() && rq->core->core_forceidle_count) {
 		rq->core->core_forceidle_start = rq_clock(rq->core);
+		rq->core->core_forceidle_start_task = rq_clock_task(rq->core);
 		rq->core->core_forceidle_occupation = occ;
 	}
 
@@ -6517,6 +6520,7 @@ static void sched_core_cpu_deactivate(unsigned int cpu)
 	 * have a cookie.
 	 */
 	core_rq->core_forceidle_start = 0;
+	core_rq->core_forceidle_start_task = 0;
 
 	/* install new leader */
 	for_each_cpu(t, smt_mask) {
@@ -10039,6 +10043,7 @@ void __init sched_init(void)
 		rq->core_forceidle_count = 0;
 		rq->core_forceidle_occupation = 0;
 		rq->core_forceidle_start = 0;
+		rq->core_forceidle_start_task = 0;
 
 		rq->core_cookie = 0UL;
 #endif
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index a57fd8f27498..9b7b2f8f8166 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -241,6 +241,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu_of(rq));
 	u64 delta, now = rq_clock(rq->core);
+	u64 delta_task, now_task = rq_clock_task(rq->core);
 	struct rq *rq_i;
 	struct task_struct *p;
 	int i;
@@ -253,10 +254,12 @@ void __sched_core_account_forceidle(struct rq *rq)
 		return;
 
 	delta = now - rq->core->core_forceidle_start;
+	delta_task = now_task - rq->core->core_forceidle_start_task;
 	if (unlikely((s64)delta <= 0))
 		return;
 
 	rq->core->core_forceidle_start = now;
+	rq->core->core_forceidle_start_task = now_task;
 
 	if (WARN_ON_ONCE(!rq->core->core_forceidle_occupation)) {
 		/* can't be forced idle without a running task */
@@ -282,7 +285,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 		 * Note: this will account forceidle to the current cpu, even
 		 * if it comes from our SMT sibling.
 		 */
-		__account_forceidle_time(p, delta);
+		__account_forceidle_time(p, delta, delta_task);
 	}
 }
 
diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index af7952f12e6c..1087d221a890 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -237,11 +237,13 @@ void account_idle_time(u64 cputime)
  *
  * REQUIRES: schedstat is enabled.
  */
-void __account_forceidle_time(struct task_struct *p, u64 delta)
+void __account_forceidle_time(struct task_struct *p, u64 delta, u64 delta_task)
 {
 	__schedstat_add(p->stats.core_forceidle_sum, delta);
+	__schedstat_add(p->stats.core_forceidle_task_sum, delta_task);
 
 	task_group_account_field(p, CPUTIME_FORCEIDLE, delta);
+	task_group_account_field(p, CPUTIME_FORCEIDLE_TASK, delta_task);
 }
 #endif
 
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..00b16b74307a 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1059,6 +1059,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 
 #ifdef CONFIG_SCHED_CORE
 		PN_SCHEDSTAT(core_forceidle_sum);
+		PN_SCHEDSTAT(core_forceidle_task_sum);
 #endif
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 001fe047bd5d..ddf55739bb0e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1170,6 +1170,7 @@ struct rq {
 	unsigned int		core_forceidle_seq;
 	unsigned int		core_forceidle_occupation;
 	u64			core_forceidle_start;
+	u64			core_forceidle_start_task;
 #endif
 
 	/* Scratch cpumask to be temporarily used under rq_lock */
-- 
2.39.3


