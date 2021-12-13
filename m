Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD3D473037
	for <lists+cgroups@lfdr.de>; Mon, 13 Dec 2021 16:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbhLMPNk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Dec 2021 10:13:40 -0500
Received: from mx2.didichuxing.com ([36.110.17.22]:12656 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S230072AbhLMPNk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 Dec 2021 10:13:40 -0500
X-Greylist: delayed 492 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Dec 2021 10:13:39 EST
Received: from mail.didiglobal.com (unknown [172.20.36.44])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id CD153D80AA819;
        Mon, 13 Dec 2021 23:05:14 +0800 (CST)
Received: from localhost.localdomain (172.31.1.96) by
 BJSGEXMBX11.didichuxing.com (172.20.15.141) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 13 Dec 2021 23:05:14 +0800
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.44
From:   Honglei Wang <wanghonglei@didichuxing.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jameshongleiwang@126.com>
Subject: [RESEND PATCH RFC] cgroup: support numabalancing disable in cgroup level
Date:   Mon, 13 Dec 2021 23:05:06 +0800
Message-ID: <20211213150506.61780-1-wanghonglei@didichuxing.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.1.96]
X-ClientProxiedBy: BJEXCAS05.didichuxing.com (172.20.36.127) To
 BJSGEXMBX11.didichuxing.com (172.20.15.141)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We have more and more containers run on same host in cloudnative
environment. While dealing with performance problems, I found some
containers get benefit from the numabalancing, but others get negative
influence. I'm thinking it would be better if we can support open/close
this feature in cgroup level.

Basically speaking, the idea is that the numabalancing for one task will
only happen when sched_numa_balancing is set ON and it's not disabled in
cgroup which the task is attached.

'cgroup.numabalancing_disable' is added for none-root cgroup to provide
an interface to disable the numabalancing for the cgroup and its
descendants. And I add an item 'numabalancing_disable' in cgroup.events
to show the actual numabalancing_disable state.

We just provide option to disable the numabalancing for specific cgroup.
The main purpose is to prevent the balancing happen for the tasks
attached to the cgroup when the sched_numa_balancing is set ON. The
balancing won't happen anyway if the sched_numa_balancing is set OFF.

The inheritance relationship is similar to freeze controller. I borrowed
the logic of freezer when did coding and add 'numa_cgrp_disable' in the
task_struct to track if the cgroup which the task's attached is
numabalancing disabled.

Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
---
 include/linux/cgroup-defs.h |  23 +++++++
 include/linux/sched.h       |   3 +
 kernel/cgroup/cgroup.c      | 145 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c         |  12 +++-
 4 files changed, 180 insertions(+), 3 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index db2e147e069f..bf141e9447e1 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -74,6 +74,11 @@ enum {
 
 	/* Control group has to be killed. */
 	CGRP_KILL,
+
+#ifdef CONFIG_NUMA_BALANCING
+	/* Control group set numabalaning disable. */
+	CGRP_NUMABALANCING_DISABLE,
+#endif
 };
 
 /* cgroup_root->flags */
@@ -357,6 +362,21 @@ struct cgroup_freezer_state {
 	int nr_frozen_tasks;
 };
 
+#ifdef CONFIG_NUMA_BALANCING
+struct cgroup_numabalancing_state {
+	/* Should the cgroup and its descendants be changed state. */
+	bool nb_disable;
+
+	/* Should the cgroup actually be set as numabalancing disable? */
+	int e_nb_disable;
+};
+
+#else /* CONFIG_NUMA_BALANCING */
+
+struct cgroup_numabalancing_state { };
+
+#endif /* CONFIG_NUMA_BALANCING */
+
 struct cgroup {
 	/* self css with NULL ->ss, points back to this cgroup */
 	struct cgroup_subsys_state self;
@@ -486,6 +506,9 @@ struct cgroup {
 	/* Used to store internal freezer state */
 	struct cgroup_freezer_state freezer;
 
+	/* Used to store numabalancing state */
+	struct cgroup_numabalancing_state nb_state;
+
 	/* ids of the ancestors at each level including self */
 	u64 ancestor_ids[];
 };
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 78c351e35fec..1d2ae19568a0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1242,6 +1242,9 @@ struct task_struct {
 	u64				last_sum_exec_runtime;
 	struct callback_head		numa_work;
 
+	/* Mark if numabalancing is disabled in cgroup level */
+	int				numa_cgrp_disable;
+
 	/*
 	 * This pointer is only modified for current in syscall and
 	 * pagefault context (and for tasks being destroyed), so it can be read
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194de39c8..1e5d995141ea 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2495,6 +2495,13 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 			 */
 			cgroup_freezer_migrate_task(task, from_cset->dfl_cgrp,
 						    to_cset->dfl_cgrp);
+
+#ifdef CONFIG_NUMA_BALANCING
+			if (to_cset->dfl_cgrp->nb_state.nb_disable)
+				WRITE_ONCE(task->numa_cgrp_disable, 1);
+			else
+				WRITE_ONCE(task->numa_cgrp_disable, 0);
+#endif
 			put_css_set_locked(from_cset);
 
 		}
@@ -3558,6 +3565,11 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
 	seq_printf(seq, "populated %d\n", cgroup_is_populated(cgrp));
 	seq_printf(seq, "frozen %d\n", test_bit(CGRP_FROZEN, &cgrp->flags));
 
+#ifdef CONFIG_NUMA_BALANCING
+	seq_printf(seq, "numabalancing_disable %d\n",
+		   test_bit(CGRP_NUMABALANCING_DISABLE, &cgrp->flags));
+#endif
+
 	return 0;
 }
 
@@ -3700,6 +3712,118 @@ bool cgroup_psi_enabled(void)
 
 #endif /* CONFIG_PSI */
 
+#ifdef CONFIG_NUMA_BALANCING
+static void __cgroup_numabalancing_disable_set(struct cgroup *cgrp, bool nb_disable)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	spin_lock_irq(&css_set_lock);
+	if (nb_disable)
+		set_bit(CGRP_NUMABALANCING_DISABLE, &cgrp->flags);
+	else
+		clear_bit(CGRP_NUMABALANCING_DISABLE, &cgrp->flags);
+	spin_unlock_irq(&css_set_lock);
+
+	css_task_iter_start(&cgrp->self, 0, &it);
+	while ((task = css_task_iter_next(&it))) {
+		/*
+		 * We don't care about NUMA placement if the task is exiting.
+		 * And we don't NUMA balance for kthreads.
+		 */
+		if (task->flags & (PF_EXITING | PF_KTHREAD))
+			continue;
+		task->numa_cgrp_disable = nb_disable;
+	}
+	css_task_iter_end(&it);
+}
+
+static void cgroup_numabalancing_disable_set(struct cgroup *cgrp, bool nb_disable)
+{
+	struct cgroup_subsys_state *css;
+	struct cgroup *dsct;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	/*
+	 * Nothing changed? Just exit.
+	 */
+	if (cgrp->nb_state.nb_disable == nb_disable)
+		return;
+
+	cgrp->nb_state.nb_disable = nb_disable;
+
+	/*
+	 * Propagate changes downwards the cgroup tree.
+	 */
+	css_for_each_descendant_pre(css, &cgrp->self) {
+		dsct = css->cgroup;
+
+		if (cgroup_is_dead(dsct))
+			continue;
+
+		if (nb_disable) {
+			dsct->nb_state.e_nb_disable++;
+			/*
+			 * Already be set because of ancestor's settings?
+			 */
+			if (dsct->nb_state.e_nb_disable > 1)
+				continue;
+		} else {
+			dsct->nb_state.e_nb_disable--;
+			/*
+			 * Still keep numabalancing disable because of ancestor's settings?
+			 */
+			if (dsct->nb_state.e_nb_disable > 0)
+				continue;
+
+			WARN_ON_ONCE(dsct->nb_state.e_nb_disable < 0);
+		}
+
+		/*
+		 * Do change actual state: numabalancing disable or enable.
+		 */
+		__cgroup_numabalancing_disable_set(dsct, nb_disable);
+	}
+}
+
+static int cgroup_numabalancing_disable_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+
+	seq_printf(seq, "%d\n", cgrp->nb_state.nb_disable);
+
+	return 0;
+}
+
+static ssize_t cgroup_numabalancing_disable_write(struct kernfs_open_file *of,
+				   char *buf, size_t nbytes, loff_t off)
+{
+	struct cgroup *cgrp;
+	ssize_t ret;
+	int nb_disable;
+
+	ret = kstrtoint(strstrip(buf), 0, &nb_disable);
+	if (ret)
+		return ret;
+
+	if (nb_disable < 0 || nb_disable > 1)
+		return -ERANGE;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENOENT;
+
+	cgroup_numabalancing_disable_set(cgrp, nb_disable);
+
+	cgroup_kn_unlock(of->kn);
+
+	return nbytes;
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 static int cgroup_freeze_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgrp = seq_css(seq)->cgroup;
@@ -5040,6 +5164,14 @@ static struct cftype cgroup_base_files[] = {
 		.release = cgroup_pressure_release,
 	},
 #endif /* CONFIG_PSI */
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.name = "cgroup.numabalancing_disable",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cgroup_numabalancing_disable_show,
+		.write = cgroup_numabalancing_disable_write,
+	},
+#endif /* CONFIG_NUMA_BALANCING */
 	{ }	/* terminate */
 };
 
@@ -5366,6 +5498,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent, const char *name,
 		set_bit(CGRP_FROZEN, &cgrp->flags);
 	}
 
+#ifdef CONFIG_NUMA_BALANCING
+	/*
+	 * New cgroup inherits effective numabalancing disable counter.
+	 */
+	cgrp->nb_state.e_nb_disable = parent->nb_state.e_nb_disable;
+	if (cgrp->nb_state.e_nb_disable)
+		set_bit(CGRP_NUMABALANCING_DISABLE, &cgrp->flags);
+#endif
 	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		cgrp->ancestor_ids[tcgrp->level] = cgroup_id(tcgrp);
@@ -6313,6 +6453,11 @@ void cgroup_post_fork(struct task_struct *child,
 		 * userspace.
 		 */
 		kill = test_bit(CGRP_KILL, &cgrp_flags);
+
+#ifdef CONFIG_NUMA_BALANCING
+		if (test_bit(CGRP_NUMABALANCING_DISABLE, &cgrp_flags))
+			child->numa_cgrp_disable = 1;
+#endif
 	}
 
 	spin_unlock_irq(&css_set_lock);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6e476f6d9435..837bc9308e8b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2585,7 +2585,8 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	struct numa_group *ng;
 	int priv;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!static_branch_likely(&sched_numa_balancing) ||
+		READ_ONCE(p->numa_cgrp_disable))
 		return;
 
 	/* for example, ksmd faulting in a user's mm */
@@ -2866,6 +2867,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
+	if (READ_ONCE(curr->numa_cgrp_disable))
+		return;
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
@@ -2890,7 +2894,8 @@ static void update_scan_period(struct task_struct *p, int new_cpu)
 	int src_nid = cpu_to_node(task_cpu(p));
 	int dst_nid = cpu_to_node(new_cpu);
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!static_branch_likely(&sched_numa_balancing) ||
+		READ_ONCE(p->numa_cgrp_disable))
 		return;
 
 	if (!p->mm || !p->numa_faults || (p->flags & PF_EXITING))
@@ -7695,7 +7700,8 @@ static int migrate_degrades_locality(struct task_struct *p, struct lb_env *env)
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
 
-	if (!static_branch_likely(&sched_numa_balancing))
+	if (!static_branch_likely(&sched_numa_balancing) ||
+		READ_ONCE(p->numa_cgrp_disable))
 		return -1;
 
 	if (!p->numa_faults || !(env->sd->flags & SD_NUMA))
-- 
2.14.1

