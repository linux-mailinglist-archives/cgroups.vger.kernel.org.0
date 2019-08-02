Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B337F000
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 11:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387504AbfHBJJL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 05:09:11 -0400
Received: from foss.arm.com ([217.140.110.172]:47050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbfHBJJK (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 05:09:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ACE91596;
        Fri,  2 Aug 2019 02:09:10 -0700 (PDT)
Received: from e110439-lin.cambridge.arm.com (e110439-lin.cambridge.arm.com [10.1.194.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5AFA13F575;
        Fri,  2 Aug 2019 02:09:07 -0700 (PDT)
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
Subject: [PATCH v13 1/6] sched/core: uclamp: Extend CPU's cgroup controller
Date:   Fri,  2 Aug 2019 10:08:48 +0100
Message-Id: <20190802090853.4810-2-patrick.bellasi@arm.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802090853.4810-1-patrick.bellasi@arm.com>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The cgroup CPU bandwidth controller allows to assign a specified
(maximum) bandwidth to the tasks of a group. However this bandwidth is
defined and enforced only on a temporal base, without considering the
actual frequency a CPU is running on. Thus, the amount of computation
completed by a task within an allocated bandwidth can be very different
depending on the actual frequency the CPU is running that task.
The amount of computation can be affected also by the specific CPU a
task is running on, especially when running on asymmetric capacity
systems like Arm's big.LITTLE.

With the availability of schedutil, the scheduler is now able
to drive frequency selections based on actual task utilization.
Moreover, the utilization clamping support provides a mechanism to
bias the frequency selection operated by schedutil depending on
constraints assigned to the tasks currently RUNNABLE on a CPU.

Giving the mechanisms described above, it is now possible to extend the
cpu controller to specify the minimum (or maximum) utilization which
should be considered for tasks RUNNABLE on a cpu.
This makes it possible to better defined the actual computational
power assigned to task groups, thus improving the cgroup CPU bandwidth
controller which is currently based just on time constraints.

Extend the CPU controller with a couple of new attributes uclamp.{min,max}
which allow to enforce utilization boosting and capping for all the
tasks in a group.

Specifically:

- uclamp.min: defines the minimum utilization which should be considered
	      i.e. the RUNNABLE tasks of this group will run at least at a
	      	 minimum frequency which corresponds to the uclamp.min
	      	 utilization

- uclamp.max: defines the maximum utilization which should be considered
	      i.e. the RUNNABLE tasks of this group will run up to a
	      	 maximum frequency which corresponds to the uclamp.max
	      	 utilization

These attributes:

a) are available only for non-root nodes, both on default and legacy
   hierarchies, while system wide clamps are defined by a generic
   interface which does not depends on cgroups. This system wide
   interface enforces constraints on tasks in the root node.

b) enforce effective constraints at each level of the hierarchy which
   are a restriction of the group requests considering its parent's
   effective constraints. Root group effective constraints are defined
   by the system wide interface.
   This mechanism allows each (non-root) level of the hierarchy to:
   - request whatever clamp values it would like to get
   - effectively get only up to the maximum amount allowed by its parent

c) have higher priority than task-specific clamps, defined via
   sched_setattr(), thus allowing to control and restrict task requests.

Add two new attributes to the cpu controller to collect "requested"
clamp values. Allow that at each non-root level of the hierarchy.
Validate local consistency by enforcing uclamp.min < uclamp.max.
Keep it simple by not caring now about "effective" values computation
and propagation along the hierarchy.

Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tejun Heo <tj@kernel.org>

---
Changes in v13:
 Message-ID: <20190725114104.GA32159@blackbody.suse.cz>
 - move common code from cpu_uclamp_{min,max}_write() into cpu_uclamp_write(clamp_id)
---
 Documentation/admin-guide/cgroup-v2.rst |  34 +++++
 init/Kconfig                            |  22 ++++
 kernel/sched/core.c                     | 167 +++++++++++++++++++++++-
 kernel/sched/sched.h                    |   8 ++
 4 files changed, 230 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 3b29005aa981..5f1c266131b0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -951,6 +951,13 @@ controller implements weight and absolute bandwidth limit models for
 normal scheduling policy and absolute bandwidth allocation model for
 realtime scheduling policy.
 
+In all the above models, cycles distribution is defined only on a temporal
+base and it does not account for the frequency at which tasks are executed.
+The (optional) utilization clamping support allows to hint the schedutil
+cpufreq governor about the minimum desired frequency which should always be
+provided by a CPU, as well as the maximum desired frequency, which should not
+be exceeded by a CPU.
+
 WARNING: cgroup2 doesn't yet support control of realtime processes and
 the cpu controller can only be enabled when all RT processes are in
 the root cgroup.  Be aware that system management software may already
@@ -1016,6 +1023,33 @@ All time durations are in microseconds.
 	Shows pressure stall information for CPU. See
 	Documentation/accounting/psi.rst for details.
 
+  cpu.uclamp.min
+        A read-write single value file which exists on non-root cgroups.
+        The default is "0", i.e. no utilization boosting.
+
+        The requested minimum utilization (protection) as a percentage
+        rational number, e.g. 12.34 for 12.34%.
+
+        This interface allows reading and setting minimum utilization clamp
+        values similar to the sched_setattr(2). This minimum utilization
+        value is used to clamp the task specific minimum utilization clamp.
+
+        The requested minimum utilization (protection) is always capped by
+        the current value for the maximum utilization (limit), i.e.
+        `cpu.uclamp.max`.
+
+  cpu.uclamp.max
+        A read-write single value file which exists on non-root cgroups.
+        The default is "max". i.e. no utilization capping
+
+        The requested maximum utilization (limit) as a percentage rational
+        number, e.g. 98.76 for 98.76%.
+
+        This interface allows reading and setting maximum utilization clamp
+        values similar to the sched_setattr(2). This maximum utilization
+        value is used to clamp the task specific maximum utilization clamp.
+
+
 
 Memory
 ------
diff --git a/init/Kconfig b/init/Kconfig
index bd7d650d4a99..ac285cfa78b6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -928,6 +928,28 @@ config RT_GROUP_SCHED
 
 endif #CGROUP_SCHED
 
+config UCLAMP_TASK_GROUP
+	bool "Utilization clamping per group of tasks"
+	depends on CGROUP_SCHED
+	depends on UCLAMP_TASK
+	default n
+	help
+	  This feature enables the scheduler to track the clamped utilization
+	  of each CPU based on RUNNABLE tasks currently scheduled on that CPU.
+
+	  When this option is enabled, the user can specify a min and max
+	  CPU bandwidth which is allowed for each single task in a group.
+	  The max bandwidth allows to clamp the maximum frequency a task
+	  can use, while the min bandwidth allows to define a minimum
+	  frequency a task will always use.
+
+	  When task group based utilization clamping is enabled, an eventually
+	  specified task-specific clamp value is constrained by the cgroup
+	  specified clamp value. Both minimum and maximum task clamping cannot
+	  be bigger than the corresponding clamping defined at task group level.
+
+	  If in doubt, say N.
+
 config CGROUP_PIDS
 	bool "PIDs controller"
 	help
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 46f3ca9e392a..40cd7567e4d9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1149,8 +1149,12 @@ static void __init init_uclamp(void)
 
 	/* System defaults allow max clamp values for both indexes */
 	uclamp_se_set(&uc_max, uclamp_none(UCLAMP_MAX), false);
-	for_each_clamp_id(clamp_id)
+	for_each_clamp_id(clamp_id) {
 		uclamp_default[clamp_id] = uc_max;
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+		root_task_group.uclamp_req[clamp_id] = uc_max;
+#endif
+	}
 }
 
 #else /* CONFIG_UCLAMP_TASK */
@@ -6786,6 +6790,19 @@ void ia64_set_curr_task(int cpu, struct task_struct *p)
 /* task_group_lock serializes the addition/removal of task groups */
 static DEFINE_SPINLOCK(task_group_lock);
 
+static inline void alloc_uclamp_sched_group(struct task_group *tg,
+					    struct task_group *parent)
+{
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	int clamp_id;
+
+	for_each_clamp_id(clamp_id) {
+		uclamp_se_set(&tg->uclamp_req[clamp_id],
+			      uclamp_none(clamp_id), false);
+	}
+#endif
+}
+
 static void sched_free_group(struct task_group *tg)
 {
 	free_fair_sched_group(tg);
@@ -6809,6 +6826,8 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	alloc_uclamp_sched_group(tg, parent);
+
 	return tg;
 
 err:
@@ -7025,6 +7044,124 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 		sched_move_task(task);
 }
 
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+
+#define _POW10(exp) ((unsigned int)1e##exp)
+#define POW10(exp) _POW10(exp)
+
+struct uclamp_request {
+#define UCLAMP_PERCENT_SHIFT	2
+#define UCLAMP_PERCENT_SCALE	(100 * POW10(UCLAMP_PERCENT_SHIFT))
+	s64 percent;
+	u64 util;
+	int ret;
+};
+
+static inline struct uclamp_request
+capacity_from_percent(char *buf)
+{
+	struct uclamp_request req = {
+		.percent = UCLAMP_PERCENT_SCALE,
+		.util = SCHED_CAPACITY_SCALE,
+		.ret = 0,
+	};
+
+	buf = strim(buf);
+	if (strncmp("max", buf, 4)) {
+		req.ret = cgroup_parse_float(buf, UCLAMP_PERCENT_SHIFT,
+					     &req.percent);
+		if (req.ret)
+			return req;
+		if (req.percent > UCLAMP_PERCENT_SCALE) {
+			req.ret = -ERANGE;
+			return req;
+		}
+
+		req.util = req.percent << SCHED_CAPACITY_SHIFT;
+		req.util = DIV_ROUND_CLOSEST_ULL(req.util, UCLAMP_PERCENT_SCALE);
+	}
+
+	return req;
+}
+
+static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
+				size_t nbytes, loff_t off,
+				enum uclamp_id clamp_id)
+{
+	struct uclamp_request req;
+	struct task_group *tg;
+
+	req = capacity_from_percent(buf);
+	if (req.ret)
+		return req.ret;
+
+	rcu_read_lock();
+
+	tg = css_tg(of_css(of));
+	if (tg->uclamp_req[clamp_id].value != req.util)
+		uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
+
+	/*
+	 * Because of not recoverable conversion rounding we keep track of the
+	 * exact requested value
+	 */
+	tg->uclamp_pct[clamp_id] = req.percent;
+
+	rcu_read_unlock();
+
+	return nbytes;
+}
+
+static ssize_t cpu_uclamp_min_write(struct kernfs_open_file *of,
+				    char *buf, size_t nbytes,
+				    loff_t off)
+{
+	return cpu_uclamp_write(of, buf, nbytes, off, UCLAMP_MIN);
+}
+
+static ssize_t cpu_uclamp_max_write(struct kernfs_open_file *of,
+				    char *buf, size_t nbytes,
+				    loff_t off)
+{
+	return cpu_uclamp_write(of, buf, nbytes, off, UCLAMP_MAX);
+}
+
+static inline void cpu_uclamp_print(struct seq_file *sf,
+				    enum uclamp_id clamp_id)
+{
+	struct task_group *tg;
+	u64 util_clamp;
+	u64 percent;
+	u32 rem;
+
+	rcu_read_lock();
+	tg = css_tg(seq_css(sf));
+	util_clamp = tg->uclamp_req[clamp_id].value;
+	rcu_read_unlock();
+
+	if (util_clamp == SCHED_CAPACITY_SCALE) {
+		seq_puts(sf, "max\n");
+		return;
+	}
+
+	percent = tg->uclamp_pct[clamp_id];
+	percent = div_u64_rem(percent, POW10(UCLAMP_PERCENT_SHIFT), &rem);
+	seq_printf(sf, "%llu.%0*u\n", percent, UCLAMP_PERCENT_SHIFT, rem);
+}
+
+static int cpu_uclamp_min_show(struct seq_file *sf, void *v)
+{
+	cpu_uclamp_print(sf, UCLAMP_MIN);
+	return 0;
+}
+
+static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
+{
+	cpu_uclamp_print(sf, UCLAMP_MAX);
+	return 0;
+}
+#endif /* CONFIG_UCLAMP_TASK_GROUP */
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
@@ -7369,6 +7506,20 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_rt_period_read_uint,
 		.write_u64 = cpu_rt_period_write_uint,
 	},
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "uclamp.min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_min_show,
+		.write = cpu_uclamp_min_write,
+	},
+	{
+		.name = "uclamp.max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_max_show,
+		.write = cpu_uclamp_max_write,
+	},
 #endif
 	{ }	/* Terminate */
 };
@@ -7536,6 +7687,20 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_max_show,
 		.write = cpu_max_write,
 	},
+#endif
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	{
+		.name = "uclamp.min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_min_show,
+		.write = cpu_uclamp_min_write,
+	},
+	{
+		.name = "uclamp.max",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpu_uclamp_max_show,
+		.write = cpu_uclamp_max_write,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7583faddba33..45c6d7e1e3ed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -393,6 +393,14 @@ struct task_group {
 #endif
 
 	struct cfs_bandwidth	cfs_bandwidth;
+
+#ifdef CONFIG_UCLAMP_TASK_GROUP
+	/* The two decimal precision [%] value requested from user-space */
+	unsigned int		uclamp_pct[UCLAMP_CNT];
+	/* Clamp values requested for a task group */
+	struct uclamp_se	uclamp_req[UCLAMP_CNT];
+#endif
+
 };
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.22.0

