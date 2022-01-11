Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B5A48AAEC
	for <lists+cgroups@lfdr.de>; Tue, 11 Jan 2022 10:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347502AbiAKJ4S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 11 Jan 2022 04:56:18 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:52043 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237328AbiAKJ4O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 11 Jan 2022 04:56:14 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=cruzzhao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0V1ZVy34_1641894961;
Received: from AliYun.localdomain(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0V1ZVy34_1641894961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Jan 2022 17:56:10 +0800
From:   Cruz Zhao <CruzZhao@linux.alibaba.com>
To:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, joshdon@google.com
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] sched/core: Force idle accounting per cgroup
Date:   Tue, 11 Jan 2022 17:56:01 +0800
Message-Id: <1641894961-9241-4-git-send-email-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
References: <1641894961-9241-1-git-send-email-CruzZhao@linux.alibaba.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Accounting for "force idle" time per cgroup, which is the time the tasks
of the cgroup forced its SMT siblings into idle.

Force idle time per cgroup is displayed via
  /sys/fs/cgroup/cpuacct/$cg/cpuacct.forceidle.
Force idle time per cgroup per cpu is displayed via
  /sys/fs/cgroup/cpuacct/$cg/cpuacct.forceidle_percpu.
The unit is ns.
It also requires that schedstats is enabled.

We can get the total system forced idle time by looking at the root cgroup,
and we can get how long the cgroup forced it SMT siblings into idle. If the
force idle time of a cgroup is high, that can be rectified by making some
changes(ie. affinity, cpu budget, etc.) to the cgroup.

Signed-off-by: Cruz Zhao <CruzZhao@linux.alibaba.com>
---
 include/linux/cgroup.h    |  7 +++++
 kernel/sched/core_sched.c |  1 +
 kernel/sched/cpuacct.c    | 79 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 75c1514..0c1b616 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -774,10 +774,17 @@ static inline struct cgroup *cgroup_get_from_id(u64 id)
 #ifdef CONFIG_CGROUP_CPUACCT
 void cpuacct_charge(struct task_struct *tsk, u64 cputime);
 void cpuacct_account_field(struct task_struct *tsk, int index, u64 val);
+#ifdef CONFIG_SCHED_CORE
+void cpuacct_account_forceidle(int cpu, struct task_struct *task, u64 cputime);
+#endif
 #else
 static inline void cpuacct_charge(struct task_struct *tsk, u64 cputime) {}
 static inline void cpuacct_account_field(struct task_struct *tsk, int index,
 					 u64 val) {}
+#ifdef CONFIG_SCHED_CORE
+static inline void cpuacct_account_forceidle(int cpu, struct task_struct *task,
+					     u64 cputime) {}
+#endif
 #endif
 
 void __cgroup_account_cputime(struct cgroup *cgrp, u64 delta_exec);
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index fe04805..add8672 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -284,6 +284,7 @@ void __sched_core_account_forceidle(struct rq *rq)
 			continue;
 
 		__schedstat_add(p->stats.core_forceidle_sum, delta);
+		cpuacct_account_forceidle(i, p, delta);
 	}
 }
 
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 3d06c5e..b5c5d99 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -27,6 +27,9 @@ struct cpuacct {
 	/* cpuusage holds pointer to a u64-type object on every CPU */
 	u64 __percpu	*cpuusage;
 	struct kernel_cpustat __percpu	*cpustat;
+#ifdef CONFIG_SCHED_CORE
+	u64 __percpu	*forceidle;
+#endif
 };
 
 static inline struct cpuacct *css_ca(struct cgroup_subsys_state *css)
@@ -46,9 +49,15 @@ static inline struct cpuacct *parent_ca(struct cpuacct *ca)
 }
 
 static DEFINE_PER_CPU(u64, root_cpuacct_cpuusage);
+#ifdef CONFIG_SCHED_CORE
+static DEFINE_PER_CPU(u64, root_cpuacct_forceidle);
+#endif
 static struct cpuacct root_cpuacct = {
 	.cpustat	= &kernel_cpustat,
 	.cpuusage	= &root_cpuacct_cpuusage,
+#ifdef CONFIG_SCHED_CORE
+	.forceidle	= &root_cpuacct_forceidle,
+#endif
 };
 
 /* Create a new CPU accounting group */
@@ -72,8 +81,18 @@ static inline struct cpuacct *parent_ca(struct cpuacct *ca)
 	if (!ca->cpustat)
 		goto out_free_cpuusage;
 
+#ifdef CONFIG_SCHED_CORE
+	ca->forceidle = alloc_percpu(u64);
+	if (!ca->forceidle)
+		goto out_free_cpustat;
+#endif
+
 	return &ca->css;
 
+#ifdef CONFIG_SCHED_CORE
+out_free_cpustat:
+	free_percpu(ca->cpustat);
+#endif
 out_free_cpuusage:
 	free_percpu(ca->cpuusage);
 out_free_ca:
@@ -290,6 +309,37 @@ static int cpuacct_stats_show(struct seq_file *sf, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_SCHED_CORE
+static u64 __forceidle_read(struct cpuacct *ca, int cpu)
+{
+	return *per_cpu_ptr(ca->forceidle, cpu);
+}
+static int cpuacct_percpu_forceidle_seq_show(struct seq_file *m, void *V)
+{
+	struct cpuacct *ca = css_ca(seq_css(m));
+	u64 percpu;
+	int i;
+
+	for_each_possible_cpu(i) {
+		percpu = __forceidle_read(ca, i);
+		seq_printf(m, "%llu ", (unsigned long long) percpu);
+	}
+	seq_printf(m, "\n");
+	return 0;
+}
+static u64 cpuacct_forceidle_read(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	struct cpuacct *ca = css_ca(css);
+	u64 totalforceidle = 0;
+	int i;
+
+	for_each_possible_cpu(i)
+		totalforceidle += __forceidle_read(ca, i);
+	return totalforceidle;
+}
+#endif
+
 static struct cftype files[] = {
 	{
 		.name = "usage",
@@ -324,6 +374,16 @@ static int cpuacct_stats_show(struct seq_file *sf, void *v)
 		.name = "stat",
 		.seq_show = cpuacct_stats_show,
 	},
+#ifdef CONFIG_SCHED_CORE
+	{
+		.name = "forceidle",
+		.read_u64 = cpuacct_forceidle_read,
+	},
+	{
+		.name = "forceidle_percpu",
+		.seq_show = cpuacct_percpu_forceidle_seq_show,
+	},
+#endif
 	{ }	/* terminate */
 };
 
@@ -359,6 +419,25 @@ void cpuacct_account_field(struct task_struct *tsk, int index, u64 val)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_SCHED_CORE
+void cpuacct_account_forceidle(int cpu, struct task_struct *tsk, u64 cputime)
+{
+	struct cpuacct *ca;
+	u64 *fi;
+
+	rcu_read_lock();
+	/*
+	 * We have hold rq->core->__lock here, which protects ca->forceidle
+	 * percpu.
+	 */
+	for (ca = task_ca(tsk); ca; ca = parent_ca(ca)) {
+		fi = per_cpu_ptr(ca->forceidle, cpu);
+		*fi += cputime;
+	}
+	rcu_read_unlock();
+}
+#endif
+
 struct cgroup_subsys cpuacct_cgrp_subsys = {
 	.css_alloc	= cpuacct_css_alloc,
 	.css_free	= cpuacct_css_free,
-- 
1.8.3.1

