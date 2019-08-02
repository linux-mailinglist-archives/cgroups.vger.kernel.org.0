Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68C627EFFC
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 11:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbfHBJJO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 05:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:47074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHBJJN (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 05:09:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E638D344;
        Fri,  2 Aug 2019 02:09:12 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 42A1C3F575;
        Fri,  2 Aug 2019 02:09:10 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>, Michal Koutny <mkoutny@suse.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: [PATCH v13 2/6] sched/core: uclamp: Propagate parent clamps
Date:   Fri,  2 Aug 2019 10:08:49 +0100
Message-Id: <20190802090853.4810-3-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802090853.4810-1-patrick.bellasi@arm.com>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In order to properly support hierarchical resources control, the cgroup
delegation model requires that attribute writes from a child group never
fail but still are locally consistent and constrained based on parent's
assigned resources. This requires to properly propagate and aggregate
parent attributes down to its descendants.

Implement this mechanism by adding a new "effective" clamp value for each
task group. The effective clamp value is defined as the smaller value
between the clamp value of a group and the effective clamp value of its
parent. This is the actual clamp value enforced on tasks in a task group.

Since it's possible for a cpu.uclamp.min value to be bigger than the
cpu.uclamp.max value, ensure local consistency by restricting each
"protection" (i.e. min utilization) with the corresponding "limit"
(i.e. max utilization).

Do that at effective clamps propagation to ensure all user-space write
never fails while still always tracking the most restrictive values.

Update sysctl_sched_uclamp_handler() to use the newly introduced
uclamp_mutex so that we serialize system default updates with cgroup
relate updates.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 65 ++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h |  2 ++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 40cd7567e4d9..de8886ce0f65 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -773,6 +773,18 @@ static void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+/*
+ * Serializes updates of utilization clamp values
+ *
+ * The (slow-path) user-space triggers utilization clamp value updates which
+ * can require updates on (fast-path) scheduler's data structures used to
+ * support enqueue/dequeue operations.
+ * While the per-CPU rq lock protects fast-path update operations, user-space
+ * requests are serialized using a mutex to reduce the risk of conflicting
+ * updates or API abuses.
+ */
+static DEFINE_MUTEX(uclamp_mutex);
+
 /* Max allowed minimum utilization */
 unsigned int sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
 
@@ -1010,10 +1022,9 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 				loff_t *ppos)
 {
 	int old_min, old_max;
-	static DEFINE_MUTEX(mutex);
 	int result;
 
-	mutex_lock(&mutex);
+	mutex_lock(&uclamp_mutex);
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
 
@@ -1048,7 +1059,7 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
 done:
-	mutex_unlock(&mutex);
+	mutex_unlock(&uclamp_mutex);
 
 	return result;
 }
@@ -1137,6 +1148,8 @@ static void __init init_uclamp(void)
 	unsigned int clamp_id;
 	int cpu;
 
+	mutex_init(&uclamp_mutex);
+
 	for_each_possible_cpu(cpu) {
 		memset(&cpu_rq(cpu)->uclamp, 0, sizeof(struct uclamp_rq));
 		cpu_rq(cpu)->uclamp_flags = 0;
@@ -1153,6 +1166,7 @@ static void __init init_uclamp(void)
 		uclamp_default[clamp_id] = uc_max;
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 		root_task_group.uclamp_req[clamp_id] = uc_max;
+		root_task_group.uclamp[clamp_id] = uc_max;
 #endif
 	}
 }
@@ -6799,6 +6813,7 @@ static inline void alloc_uclamp_sched_group(struct task_group *tg,
 	for_each_clamp_id(clamp_id) {
 		uclamp_se_set(&tg->uclamp_req[clamp_id],
 			      uclamp_none(clamp_id), false);
+		tg->uclamp[clamp_id] = parent->uclamp[clamp_id];
 	}
 #endif
 }
@@ -7045,6 +7060,45 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
+static void cpu_util_update_eff(struct cgroup_subsys_state *css)
+{
+	struct cgroup_subsys_state *top_css = css;
+	struct uclamp_se *uc_parent = NULL;
+	struct uclamp_se *uc_se = NULL;
+	unsigned int eff[UCLAMP_CNT];
+	unsigned int clamp_id;
+	unsigned int clamps;
+
+	css_for_each_descendant_pre(css, top_css) {
+		uc_parent = css_tg(css)->parent
+			? css_tg(css)->parent->uclamp : NULL;
+
+		for_each_clamp_id(clamp_id) {
+			/* Assume effective clamps matches requested clamps */
+			eff[clamp_id] = css_tg(css)->uclamp_req[clamp_id].value;
+			/* Cap effective clamps with parent's effective clamps */
+			if (uc_parent &&
+			    eff[clamp_id] > uc_parent[clamp_id].value) {
+				eff[clamp_id] = uc_parent[clamp_id].value;
+			}
+		}
+		/* Ensure protection is always capped by limit */
+		eff[UCLAMP_MIN] = min(eff[UCLAMP_MIN], eff[UCLAMP_MAX]);
+
+		/* Propagate most restrictive effective clamps */
+		clamps = 0x0;
+		uc_se = css_tg(css)->uclamp;
+		for_each_clamp_id(clamp_id) {
+			if (eff[clamp_id] == uc_se[clamp_id].value)
+				continue;
+			uc_se[clamp_id].value = eff[clamp_id];
+			uc_se[clamp_id].bucket_id = uclamp_bucket_id(eff[clamp_id]);
+			clamps |= (0x1 << clamp_id);
+		}
+		if (!clamps)
+			css = css_rightmost_descendant(css);
+	}
+}
 
 #define _POW10(exp) ((unsigned int)1e##exp)
 #define POW10(exp) _POW10(exp)
@@ -7095,6 +7149,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
+	mutex_lock(&uclamp_mutex);
 	rcu_read_lock();
 
 	tg = css_tg(of_css(of));
@@ -7107,7 +7162,11 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	 */
 	tg->uclamp_pct[clamp_id] = req.percent;
 
+	/* Update effective clamps to track the most restrictive value */
+	cpu_util_update_eff(of_css(of));
+
 	rcu_read_unlock();
+	mutex_unlock(&uclamp_mutex);
 
 	return nbytes;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 45c6d7e1e3ed..452541efdac1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -399,6 +399,8 @@ struct task_group {
 	unsigned int		uclamp_pct[UCLAMP_CNT];
 	/* Clamp values requested for a task group */
 	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+	/* Effective clamp values used for a task group */
+	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
 
 };
-- 
2.22.0

