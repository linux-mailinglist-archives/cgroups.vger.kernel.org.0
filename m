Return-Path: <cgroups+bounces-4481-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AA095FD98
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 00:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478611C21F44
	for <lists+cgroups@lfdr.de>; Mon, 26 Aug 2024 22:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535ED19E7EB;
	Mon, 26 Aug 2024 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSyxvLZO"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F05F19E7DF;
	Mon, 26 Aug 2024 22:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724713112; cv=none; b=Kf2guNZqzApyOTvB4ZLmP36GwgoU4s1ZODfy5EEQFApNypeqhKd/1BtaCGb9NcEJUZ1CXPxMOEkSp0R6j6azeJIqdGHq8CstbSIxTJI6mpu0XJBenwGvbYkSDMZORM6LQhGMzjmRbGKuzrrr3Y7GlnXEH2Sc9nPwXLB5rA2G2ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724713112; c=relaxed/simple;
	bh=zNYeyEfpjzXUSL/bDGHUvmOgEHgQLRN0D+YLMECdml8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyzhPjvYEcelrmTUaPif+IWxsnt1olO1lvVz6qAD6QvBerBQ0ra4az+0aPcVb5U4ZBSdyv1ADLf94bZScMOVkRAtjijV4bP2G5TZNV/Wc1AcwfhRkv1xVYvOGnmfHpDIGRHCbl42Rp6vVlHllWV67dWuZTt9avAviqcigrOSEXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSyxvLZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26E5C8B7A6;
	Mon, 26 Aug 2024 22:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724713111;
	bh=zNYeyEfpjzXUSL/bDGHUvmOgEHgQLRN0D+YLMECdml8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSyxvLZOMDCxZ6OaBBEi/qaGsPy+Cr1NZCXsloUgXB+sL9aGv17gljwlb4b/O4fR5
	 CIlFHwdDyNZtZsi+XO8KxTD7RgX0b33XC9hlpai5PnjARP9cFf+dFsqjmEpkHKs+I5
	 xsEcdEFLrt7cXtr3ejjoJudzgYaoFRIGsieYvTlXUavu7pWn8+E1TpyDUdj3lXqXeG
	 Krqr95KxnpQbg5TV+bdspKrJgL5ibRMuaw07f6RZ92ZexGFvsaCbJlBZ3OuV1/rVZE
	 aX2653IOO1v8NKm8FYGbKoHTBGbCPHtL3NKHBH0kSrra8mTk9Mj7oQWJtjm1syPevW
	 +9VKyhNezakOw==
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: cgroups@vger.kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	Josh Don <joshdon@google.com>,
	Hao Luo <haoluo@google.com>,
	Barret Rhoden <brho@google.com>,
	kernel test robot <lkp@intel.com>,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH 4/5] sched_ext: Add cgroup support
Date: Mon, 26 Aug 2024 12:57:42 -1000
Message-ID: <20240826225822.791578-5-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240826225822.791578-1-tj@kernel.org>
References: <20240826225822.791578-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sched_ext_ops operations to init/exit cgroups, and track task migrations
and config changes. A BPF scheduler may not implement or implement only
subset of cgroup features. The implemented features can be indicated using
%SCX_OPS_HAS_CGOUP_* flags. If cgroup configuration makes use of features
that are not implemented, a warning is triggered.

While a BPF scheduler is being enabled and disabled, relevant cgroup
operations are locked out using scx_cgroup_rwsem. This avoids situations
like task prep taking place while the task is being moved across cgroups,
making things easier for BPF schedulers.

v7: - cgroup interface file visibility toggling is dropped in favor just
      warning messages. Dynamically changing interface visiblity caused more
      confusion than helping.

v6: - Updated to reflect the removal of SCX_KF_SLEEPABLE.

    - Updated to use CONFIG_GROUP_SCHED_WEIGHT and fixes for
      !CONFIG_FAIR_GROUP_SCHED && CONFIG_EXT_GROUP_SCHED.

v5: - Flipped the locking order between scx_cgroup_rwsem and
      cpus_read_lock() to avoid locking order conflict w/ cpuset. Better
      documentation around locking.

    - sched_move_task() takes an early exit if the source and destination
      are identical. This triggered the warning in scx_cgroup_can_attach()
      as it left p->scx.cgrp_moving_from uncleared. Updated the cgroup
      migration path so that ops.cgroup_prep_move() is skipped for identity
      migrations so that its invocations always match ops.cgroup_move()
      one-to-one.

v4: - Example schedulers moved into their own patches.

    - Fix build failure when !CONFIG_CGROUP_SCHED, reported by Andrea Righi.

v3: - Make scx_example_pair switch all tasks by default.

    - Convert to BPF inline iterators.

    - scx_bpf_task_cgroup() is added to determine the current cgroup from
      CPU controller's POV. This allows BPF schedulers to accurately track
      CPU cgroup membership.

    - scx_example_flatcg added. This demonstrates flattened hierarchy
      implementation of CPU cgroup control and shows significant performance
      improvement when cgroups which are nested multiple levels are under
      competition.

v2: - Build fixes for different CONFIG combinations.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Andrea Righi <andrea.righi@canonical.com>
---
 include/linux/sched/ext.h                     |   3 +
 init/Kconfig                                  |   6 +
 kernel/sched/core.c                           |  67 ++-
 kernel/sched/ext.c                            | 519 +++++++++++++++++-
 kernel/sched/ext.h                            |  22 +
 kernel/sched/sched.h                          |   5 +
 tools/sched_ext/include/scx/common.bpf.h      |   1 +
 .../testing/selftests/sched_ext/maximal.bpf.c |  32 ++
 8 files changed, 636 insertions(+), 19 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 69f68e2121a8..7a90e6a3c9cd 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -189,6 +189,9 @@ struct sched_ext_entity {
 	bool			disallow;	/* reject switching into SCX */
 
 	/* cold fields */
+#ifdef CONFIG_EXT_GROUP_SCHED
+	struct cgroup		*cgrp_moving_from;
+#endif
 	/* must be the last field, see init_scx_entity() */
 	struct list_head	tasks_node;
 };
diff --git a/init/Kconfig b/init/Kconfig
index 84332d3594d0..8c11ed61ca67 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1055,6 +1055,12 @@ config RT_GROUP_SCHED
 	  realtime bandwidth for them.
 	  See Documentation/scheduler/sched-rt-group.rst for more information.
 
+config EXT_GROUP_SCHED
+	bool
+	depends on SCHED_CLASS_EXT && CGROUP_SCHED
+	select GROUP_SCHED_WEIGHT
+	default y
+
 endif #CGROUP_SCHED
 
 config SCHED_MM_CID
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5cdf7b6a40f7..bd91bb3054fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8380,6 +8380,9 @@ void __init sched_init(void)
 		root_task_group.shares = ROOT_TASK_GROUP_LOAD;
 		init_cfs_bandwidth(&root_task_group.cfs_bandwidth, NULL);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
+#ifdef CONFIG_EXT_GROUP_SCHED
+		root_task_group.scx_weight = CGROUP_WEIGHT_DFL;
+#endif /* CONFIG_EXT_GROUP_SCHED */
 #ifdef CONFIG_RT_GROUP_SCHED
 		root_task_group.rt_se = (struct sched_rt_entity **)ptr;
 		ptr += nr_cpu_ids * sizeof(void **);
@@ -8816,6 +8819,7 @@ struct task_group *sched_create_group(struct task_group *parent)
 	if (!alloc_rt_sched_group(tg, parent))
 		goto err;
 
+	scx_group_set_weight(tg, CGROUP_WEIGHT_DFL);
 	alloc_uclamp_sched_group(tg, parent);
 
 	return tg;
@@ -8943,6 +8947,7 @@ void sched_move_task(struct task_struct *tsk)
 		put_prev_task(rq, tsk);
 
 	sched_change_group(tsk, group);
+	scx_move_task(tsk);
 
 	if (queued)
 		enqueue_task(rq, tsk, queue_flags);
@@ -8980,6 +8985,11 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
 	struct task_group *parent = css_tg(css->parent);
+	int ret;
+
+	ret = scx_tg_online(tg);
+	if (ret)
+		return ret;
 
 	if (parent)
 		sched_online_group(tg, parent);
@@ -8994,6 +9004,13 @@ static int cpu_cgroup_css_online(struct cgroup_subsys_state *css)
 	return 0;
 }
 
+static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
+{
+	struct task_group *tg = css_tg(css);
+
+	scx_tg_offline(tg);
+}
+
 static void cpu_cgroup_css_released(struct cgroup_subsys_state *css)
 {
 	struct task_group *tg = css_tg(css);
@@ -9011,9 +9028,9 @@ static void cpu_cgroup_css_free(struct cgroup_subsys_state *css)
 	sched_unregister_group(tg);
 }
 
-#ifdef CONFIG_RT_GROUP_SCHED
 static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 {
+#ifdef CONFIG_RT_GROUP_SCHED
 	struct task_struct *task;
 	struct cgroup_subsys_state *css;
 
@@ -9021,9 +9038,9 @@ static int cpu_cgroup_can_attach(struct cgroup_taskset *tset)
 		if (!sched_rt_can_attach(css_tg(css), task))
 			return -EINVAL;
 	}
-	return 0;
-}
 #endif
+	return scx_cgroup_can_attach(tset);
+}
 
 static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 {
@@ -9032,6 +9049,13 @@ static void cpu_cgroup_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_for_each(task, css, tset)
 		sched_move_task(task);
+
+	scx_cgroup_finish_attach();
+}
+
+static void cpu_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	scx_cgroup_cancel_attach(tset);
 }
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
@@ -9211,15 +9235,25 @@ static int cpu_uclamp_max_show(struct seq_file *sf, void *v)
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 static unsigned long tg_weight(struct task_group *tg)
 {
+#ifdef CONFIG_FAIR_GROUP_SCHED
 	return scale_load_down(tg->shares);
+#else
+	return sched_weight_from_cgroup(tg->scx_weight);
+#endif
 }
 
 static int cpu_shares_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cftype, u64 shareval)
 {
+	int ret;
+
 	if (shareval > scale_load_down(ULONG_MAX))
 		shareval = MAX_SHARES;
-	return sched_group_set_shares(css_tg(css), scale_load(shareval));
+	ret = sched_group_set_shares(css_tg(css), scale_load(shareval));
+	if (!ret)
+		scx_group_set_weight(css_tg(css),
+				     sched_weight_to_cgroup(shareval));
+	return ret;
 }
 
 static u64 cpu_shares_read_u64(struct cgroup_subsys_state *css,
@@ -9610,7 +9644,12 @@ static s64 cpu_idle_read_s64(struct cgroup_subsys_state *css,
 static int cpu_idle_write_s64(struct cgroup_subsys_state *css,
 				struct cftype *cft, s64 idle)
 {
-	return sched_group_set_idle(css_tg(css), idle);
+	int ret;
+
+	ret = sched_group_set_idle(css_tg(css), idle);
+	if (!ret)
+		scx_group_set_idle(css_tg(css), idle);
+	return ret;
 }
 #endif
 
@@ -9737,13 +9776,17 @@ static int cpu_weight_write_u64(struct cgroup_subsys_state *css,
 				struct cftype *cft, u64 cgrp_weight)
 {
 	unsigned long weight;
+	int ret;
 
 	if (cgrp_weight < CGROUP_WEIGHT_MIN || cgrp_weight > CGROUP_WEIGHT_MAX)
 		return -ERANGE;
 
 	weight = sched_weight_from_cgroup(cgrp_weight);
 
-	return sched_group_set_shares(css_tg(css), scale_load(weight));
+	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	if (!ret)
+		scx_group_set_weight(css_tg(css), cgrp_weight);
+	return ret;
 }
 
 static s64 cpu_weight_nice_read_s64(struct cgroup_subsys_state *css,
@@ -9768,7 +9811,7 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 				     struct cftype *cft, s64 nice)
 {
 	unsigned long weight;
-	int idx;
+	int idx, ret;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -ERANGE;
@@ -9777,7 +9820,11 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 	idx = array_index_nospec(idx, 40);
 	weight = sched_prio_to_weight[idx];
 
-	return sched_group_set_shares(css_tg(css), scale_load(weight));
+	ret = sched_group_set_shares(css_tg(css), scale_load(weight));
+	if (!ret)
+		scx_group_set_weight(css_tg(css),
+				     sched_weight_to_cgroup(weight));
+	return ret;
 }
 #endif /* CONFIG_GROUP_SCHED_WEIGHT */
 
@@ -9893,14 +9940,14 @@ static struct cftype cpu_files[] = {
 struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_alloc	= cpu_cgroup_css_alloc,
 	.css_online	= cpu_cgroup_css_online,
+	.css_offline	= cpu_cgroup_css_offline,
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
 	.css_local_stat_show = cpu_local_stat_show,
-#ifdef CONFIG_RT_GROUP_SCHED
 	.can_attach	= cpu_cgroup_can_attach,
-#endif
 	.attach		= cpu_cgroup_attach,
+	.cancel_attach	= cpu_cgroup_cancel_attach,
 	.legacy_cftypes	= cpu_legacy_files,
 	.dfl_cftypes	= cpu_files,
 	.early_init	= true,
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index b9bf9ee5ed01..c4d68d15485a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -116,10 +116,16 @@ enum scx_ops_flags {
 	 */
 	SCX_OPS_SWITCH_PARTIAL	= 1LLU << 3,
 
+	/*
+	 * CPU cgroup support flags
+	 */
+	SCX_OPS_HAS_CGROUP_WEIGHT = 1LLU << 16,	/* cpu.weight */
+
 	SCX_OPS_ALL_FLAGS	= SCX_OPS_KEEP_BUILTIN_IDLE |
 				  SCX_OPS_ENQ_LAST |
 				  SCX_OPS_ENQ_EXITING |
-				  SCX_OPS_SWITCH_PARTIAL,
+				  SCX_OPS_SWITCH_PARTIAL |
+				  SCX_OPS_HAS_CGROUP_WEIGHT,
 };
 
 /* argument container for ops.init_task() */
@@ -129,6 +135,10 @@ struct scx_init_task_args {
 	 * to the scheduler transition path.
 	 */
 	bool			fork;
+#ifdef CONFIG_EXT_GROUP_SCHED
+	/* the cgroup the task is joining */
+	struct cgroup		*cgroup;
+#endif
 };
 
 /* argument container for ops.exit_task() */
@@ -137,6 +147,12 @@ struct scx_exit_task_args {
 	bool cancelled;
 };
 
+/* argument container for ops->cgroup_init() */
+struct scx_cgroup_init_args {
+	/* the weight of the cgroup [1..10000] */
+	u32			weight;
+};
+
 enum scx_cpu_preempt_reason {
 	/* next task is being scheduled by &sched_class_rt */
 	SCX_CPU_PREEMPT_RT,
@@ -501,6 +517,79 @@ struct sched_ext_ops {
 	 */
 	void (*dump_task)(struct scx_dump_ctx *ctx, struct task_struct *p);
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	/**
+	 * cgroup_init - Initialize a cgroup
+	 * @cgrp: cgroup being initialized
+	 * @args: init arguments, see the struct definition
+	 *
+	 * Either the BPF scheduler is being loaded or @cgrp created, initialize
+	 * @cgrp for sched_ext. This operation may block.
+	 *
+	 * Return 0 for success, -errno for failure. An error return while
+	 * loading will abort loading of the BPF scheduler. During cgroup
+	 * creation, it will abort the specific cgroup creation.
+	 */
+	s32 (*cgroup_init)(struct cgroup *cgrp,
+			   struct scx_cgroup_init_args *args);
+
+	/**
+	 * cgroup_exit - Exit a cgroup
+	 * @cgrp: cgroup being exited
+	 *
+	 * Either the BPF scheduler is being unloaded or @cgrp destroyed, exit
+	 * @cgrp for sched_ext. This operation my block.
+	 */
+	void (*cgroup_exit)(struct cgroup *cgrp);
+
+	/**
+	 * cgroup_prep_move - Prepare a task to be moved to a different cgroup
+	 * @p: task being moved
+	 * @from: cgroup @p is being moved from
+	 * @to: cgroup @p is being moved to
+	 *
+	 * Prepare @p for move from cgroup @from to @to. This operation may
+	 * block and can be used for allocations.
+	 *
+	 * Return 0 for success, -errno for failure. An error return aborts the
+	 * migration.
+	 */
+	s32 (*cgroup_prep_move)(struct task_struct *p,
+				struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_move - Commit cgroup move
+	 * @p: task being moved
+	 * @from: cgroup @p is being moved from
+	 * @to: cgroup @p is being moved to
+	 *
+	 * Commit the move. @p is dequeued during this operation.
+	 */
+	void (*cgroup_move)(struct task_struct *p,
+			    struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_cancel_move - Cancel cgroup move
+	 * @p: task whose cgroup move is being canceled
+	 * @from: cgroup @p was being moved from
+	 * @to: cgroup @p was being moved to
+	 *
+	 * @p was cgroup_prep_move()'d but failed before reaching cgroup_move().
+	 * Undo the preparation.
+	 */
+	void (*cgroup_cancel_move)(struct task_struct *p,
+				   struct cgroup *from, struct cgroup *to);
+
+	/**
+	 * cgroup_set_weight - A cgroup's weight is being changed
+	 * @cgrp: cgroup whose weight is being updated
+	 * @weight: new weight [1..10000]
+	 *
+	 * Update @tg's weight to @weight.
+	 */
+	void (*cgroup_set_weight)(struct cgroup *cgrp, u32 weight);
+#endif	/* CONFIG_CGROUPS */
+
 	/*
 	 * All online ops must come before ops.cpu_online().
 	 */
@@ -686,6 +775,11 @@ enum scx_kick_flags {
 	SCX_KICK_WAIT		= 1LLU << 2,
 };
 
+enum scx_tg_flags {
+	SCX_TG_ONLINE		= 1U << 0,
+	SCX_TG_INITED		= 1U << 1,
+};
+
 enum scx_ops_enable_state {
 	SCX_OPS_PREPPING,
 	SCX_OPS_ENABLING,
@@ -3294,6 +3388,28 @@ static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 		resched_curr(rq);
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+static struct cgroup *tg_cgrp(struct task_group *tg)
+{
+	/*
+	 * If CGROUP_SCHED is disabled, @tg is NULL. If @tg is an autogroup,
+	 * @tg->css.cgroup is NULL. In both cases, @tg can be treated as the
+	 * root cgroup.
+	 */
+	if (tg && tg->css.cgroup)
+		return tg->css.cgroup;
+	else
+		return &cgrp_dfl_root.cgrp;
+}
+
+#define SCX_INIT_TASK_ARGS_CGROUP(tg)		.cgroup = tg_cgrp(tg),
+
+#else	/* CONFIG_EXT_GROUP_SCHED */
+
+#define SCX_INIT_TASK_ARGS_CGROUP(tg)
+
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+
 static enum scx_task_state scx_get_task_state(const struct task_struct *p)
 {
 	return (p->scx.flags & SCX_TASK_STATE_MASK) >> SCX_TASK_STATE_SHIFT;
@@ -3338,6 +3454,7 @@ static int scx_ops_init_task(struct task_struct *p, struct task_group *tg, bool
 
 	if (SCX_HAS_OP(init_task)) {
 		struct scx_init_task_args args = {
+			SCX_INIT_TASK_ARGS_CGROUP(tg)
 			.fork = fork,
 		};
 
@@ -3402,7 +3519,7 @@ static void scx_ops_enable_task(struct task_struct *p)
 	scx_set_task_state(p, SCX_TASK_ENABLED);
 
 	if (SCX_HAS_OP(set_weight))
-		SCX_CALL_OP(SCX_KF_REST, set_weight, p, p->scx.weight);
+		SCX_CALL_OP_TASK(SCX_KF_REST, set_weight, p, p->scx.weight);
 }
 
 static void scx_ops_disable_task(struct task_struct *p)
@@ -3614,6 +3731,219 @@ bool scx_can_stop_tick(struct rq *rq)
 }
 #endif
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+
+DEFINE_STATIC_PERCPU_RWSEM(scx_cgroup_rwsem);
+static bool cgroup_warned_missing_weight;
+static bool cgroup_warned_missing_idle;
+
+static void scx_cgroup_warn_missing_weight(struct task_group *tg)
+{
+	if (scx_ops_enable_state() == SCX_OPS_DISABLED ||
+	    cgroup_warned_missing_weight)
+		return;
+
+	if ((scx_ops.flags & SCX_OPS_HAS_CGROUP_WEIGHT) || !tg->css.parent)
+		return;
+
+	pr_warn("sched_ext: \"%s\" does not implement cgroup cpu.weight\n",
+		scx_ops.name);
+	cgroup_warned_missing_weight = true;
+}
+
+static void scx_cgroup_warn_missing_idle(struct task_group *tg)
+{
+	if (scx_ops_enable_state() == SCX_OPS_DISABLED ||
+	    cgroup_warned_missing_idle)
+		return;
+
+	if (!tg->idle)
+		return;
+
+	pr_warn("sched_ext: \"%s\" does not implement cgroup cpu.idle\n",
+		scx_ops.name);
+	cgroup_warned_missing_idle = true;
+}
+
+int scx_tg_online(struct task_group *tg)
+{
+	int ret = 0;
+
+	WARN_ON_ONCE(tg->scx_flags & (SCX_TG_ONLINE | SCX_TG_INITED));
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	scx_cgroup_warn_missing_weight(tg);
+
+	if (SCX_HAS_OP(cgroup_init)) {
+		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+
+		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
+				      tg->css.cgroup, &args);
+		if (!ret)
+			tg->scx_flags |= SCX_TG_ONLINE | SCX_TG_INITED;
+		else
+			ret = ops_sanitize_err("cgroup_init", ret);
+	} else {
+		tg->scx_flags |= SCX_TG_ONLINE;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+	return ret;
+}
+
+void scx_tg_offline(struct task_group *tg)
+{
+	WARN_ON_ONCE(!(tg->scx_flags & SCX_TG_ONLINE));
+
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (SCX_HAS_OP(cgroup_exit) && (tg->scx_flags & SCX_TG_INITED))
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, tg->css.cgroup);
+	tg->scx_flags &= ~(SCX_TG_ONLINE | SCX_TG_INITED);
+
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+int scx_cgroup_can_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *p;
+	int ret;
+
+	/* released in scx_finish/cancel_attach() */
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (!scx_enabled())
+		return 0;
+
+	cgroup_taskset_for_each(p, css, tset) {
+		struct cgroup *from = tg_cgrp(task_group(p));
+		struct cgroup *to = tg_cgrp(css_tg(css));
+
+		WARN_ON_ONCE(p->scx.cgrp_moving_from);
+
+		/*
+		 * sched_move_task() omits identity migrations. Let's match the
+		 * behavior so that ops.cgroup_prep_move() and ops.cgroup_move()
+		 * always match one-to-one.
+		 */
+		if (from == to)
+			continue;
+
+		if (SCX_HAS_OP(cgroup_prep_move)) {
+			ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_prep_move,
+					      p, from, css->cgroup);
+			if (ret)
+				goto err;
+		}
+
+		p->scx.cgrp_moving_from = from;
+	}
+
+	return 0;
+
+err:
+	cgroup_taskset_for_each(p, css, tset) {
+		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
+				    p->scx.cgrp_moving_from, css->cgroup);
+		p->scx.cgrp_moving_from = NULL;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+	return ops_sanitize_err("cgroup_prep_move", ret);
+}
+
+void scx_move_task(struct task_struct *p)
+{
+	if (!scx_enabled())
+		return;
+
+	/*
+	 * We're called from sched_move_task() which handles both cgroup and
+	 * autogroup moves. Ignore the latter.
+	 *
+	 * Also ignore exiting tasks, because in the exit path tasks transition
+	 * from the autogroup to the root group, so task_group_is_autogroup()
+	 * alone isn't able to catch exiting autogroup tasks. This is safe for
+	 * cgroup_move(), because cgroup migrations never happen for PF_EXITING
+	 * tasks.
+	 */
+	if (task_group_is_autogroup(task_group(p)) || (p->flags & PF_EXITING))
+		return;
+
+	/*
+	 * @p must have ops.cgroup_prep_move() called on it and thus
+	 * cgrp_moving_from set.
+	 */
+	if (SCX_HAS_OP(cgroup_move) && !WARN_ON_ONCE(!p->scx.cgrp_moving_from))
+		SCX_CALL_OP_TASK(SCX_KF_UNLOCKED, cgroup_move, p,
+			p->scx.cgrp_moving_from, tg_cgrp(task_group(p)));
+	p->scx.cgrp_moving_from = NULL;
+}
+
+void scx_cgroup_finish_attach(void)
+{
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+void scx_cgroup_cancel_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *css;
+	struct task_struct *p;
+
+	if (!scx_enabled())
+		goto out_unlock;
+
+	cgroup_taskset_for_each(p, css, tset) {
+		if (SCX_HAS_OP(cgroup_cancel_move) && p->scx.cgrp_moving_from)
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_cancel_move, p,
+				    p->scx.cgrp_moving_from, css->cgroup);
+		p->scx.cgrp_moving_from = NULL;
+	}
+out_unlock:
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+void scx_group_set_weight(struct task_group *tg, unsigned long weight)
+{
+	percpu_down_read(&scx_cgroup_rwsem);
+
+	if (tg->scx_weight != weight) {
+		if (SCX_HAS_OP(cgroup_set_weight))
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_set_weight,
+				    tg_cgrp(tg), weight);
+		tg->scx_weight = weight;
+	}
+
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+void scx_group_set_idle(struct task_group *tg, bool idle)
+{
+	percpu_down_read(&scx_cgroup_rwsem);
+	scx_cgroup_warn_missing_idle(tg);
+	percpu_up_read(&scx_cgroup_rwsem);
+}
+
+static void scx_cgroup_lock(void)
+{
+	percpu_down_write(&scx_cgroup_rwsem);
+}
+
+static void scx_cgroup_unlock(void)
+{
+	percpu_up_write(&scx_cgroup_rwsem);
+}
+
+#else	/* CONFIG_EXT_GROUP_SCHED */
+
+static inline void scx_cgroup_lock(void) {}
+static inline void scx_cgroup_unlock(void) {}
+
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+
 /*
  * Omitted operations:
  *
@@ -3751,6 +4081,96 @@ static void destroy_dsq(u64 dsq_id)
 	rcu_read_unlock();
 }
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+static void scx_cgroup_exit(void)
+{
+	struct cgroup_subsys_state *css;
+
+	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
+
+	/*
+	 * scx_tg_on/offline() are excluded through scx_cgroup_rwsem. If we walk
+	 * cgroups and exit all the inited ones, all online cgroups are exited.
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_post(css, &root_task_group.css) {
+		struct task_group *tg = css_tg(css);
+
+		if (!(tg->scx_flags & SCX_TG_INITED))
+			continue;
+		tg->scx_flags &= ~SCX_TG_INITED;
+
+		if (!scx_ops.cgroup_exit)
+			continue;
+
+		if (WARN_ON_ONCE(!css_tryget(css)))
+			continue;
+		rcu_read_unlock();
+
+		SCX_CALL_OP(SCX_KF_UNLOCKED, cgroup_exit, css->cgroup);
+
+		rcu_read_lock();
+		css_put(css);
+	}
+	rcu_read_unlock();
+}
+
+static int scx_cgroup_init(void)
+{
+	struct cgroup_subsys_state *css;
+	int ret;
+
+	percpu_rwsem_assert_held(&scx_cgroup_rwsem);
+
+	cgroup_warned_missing_weight = false;
+	cgroup_warned_missing_idle = false;
+
+	/*
+	 * scx_tg_on/offline() are excluded thorugh scx_cgroup_rwsem. If we walk
+	 * cgroups and init, all online cgroups are initialized.
+	 */
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, &root_task_group.css) {
+		struct task_group *tg = css_tg(css);
+		struct scx_cgroup_init_args args = { .weight = tg->scx_weight };
+
+		scx_cgroup_warn_missing_weight(tg);
+		scx_cgroup_warn_missing_idle(tg);
+
+		if ((tg->scx_flags &
+		     (SCX_TG_ONLINE | SCX_TG_INITED)) != SCX_TG_ONLINE)
+			continue;
+
+		if (!scx_ops.cgroup_init) {
+			tg->scx_flags |= SCX_TG_INITED;
+			continue;
+		}
+
+		if (WARN_ON_ONCE(!css_tryget(css)))
+			continue;
+		rcu_read_unlock();
+
+		ret = SCX_CALL_OP_RET(SCX_KF_UNLOCKED, cgroup_init,
+				      css->cgroup, &args);
+		if (ret) {
+			css_put(css);
+			return ret;
+		}
+		tg->scx_flags |= SCX_TG_INITED;
+
+		rcu_read_lock();
+		css_put(css);
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+#else
+static void scx_cgroup_exit(void) {}
+static int scx_cgroup_init(void) { return 0; }
+#endif
+
 
 /********************************************************************************
  * Sysfs interface and ops enable/disable.
@@ -4042,11 +4462,12 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	WRITE_ONCE(scx_switching_all, false);
 
 	/*
-	 * Avoid racing against fork. See scx_ops_enable() for explanation on
-	 * the locking order.
+	 * Avoid racing against fork and cgroup changes. See scx_ops_enable()
+	 * for explanation on the locking order.
 	 */
 	percpu_down_write(&scx_fork_rwsem);
 	cpus_read_lock();
+	scx_cgroup_lock();
 
 	spin_lock_irq(&scx_tasks_lock);
 	scx_task_iter_init(&sti);
@@ -4090,6 +4511,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	synchronize_rcu();
 
+	scx_cgroup_exit();
+
+	scx_cgroup_unlock();
 	cpus_read_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
@@ -4646,11 +5070,17 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 			   scx_watchdog_timeout / 2);
 
 	/*
-	 * Lock out forks before opening the floodgate so that they don't wander
-	 * into the operations prematurely.
+	 * Lock out forks, cgroup on/offlining and moves before opening the
+	 * floodgate so that they don't wander into the operations prematurely.
+	 *
+	 * We don't need to keep the CPUs stable but static_branch_*() requires
+	 * cpus_read_lock() and scx_cgroup_rwsem must nest inside
+	 * cpu_hotplug_lock because of the following dependency chain:
+	 *
+	 *   cpu_hotplug_lock --> cgroup_threadgroup_rwsem --> scx_cgroup_rwsem
 	 *
-	 * We don't need to keep the CPUs stable but grab cpus_read_lock() to
-	 * ease future locking changes for cgroup suport.
+	 * So, we need to do cpus_read_lock() before scx_cgroup_lock() and use
+	 * static_branch_*_cpuslocked().
 	 *
 	 * Note that cpu_hotplug_lock must nest inside scx_fork_rwsem due to the
 	 * following dependency chain:
@@ -4659,6 +5089,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	 */
 	percpu_down_write(&scx_fork_rwsem);
 	cpus_read_lock();
+	scx_cgroup_lock();
 
 	check_hotplug_seq(ops);
 
@@ -4681,6 +5112,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		static_branch_disable_cpuslocked(&scx_builtin_idle_enabled);
 	}
 
+	/*
+	 * All cgroups should be initialized before letting in tasks. cgroup
+	 * on/offlining and task migrations are already locked out.
+	 */
+	ret = scx_cgroup_init();
+	if (ret)
+		goto err_disable_unlock_all;
+
 	static_branch_enable_cpuslocked(&__scx_ops_enabled);
 
 	/*
@@ -4765,6 +5204,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 
 	spin_unlock_irq(&scx_tasks_lock);
 	preempt_enable();
+	scx_cgroup_unlock();
 	cpus_read_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 
@@ -4799,6 +5239,7 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	return ret;
 
 err_disable_unlock_all:
+	scx_cgroup_unlock();
 	percpu_up_write(&scx_fork_rwsem);
 err_disable_unlock_cpus:
 	cpus_read_unlock();
@@ -4993,6 +5434,11 @@ static int bpf_scx_check_member(const struct btf_type *t,
 
 	switch (moff) {
 	case offsetof(struct sched_ext_ops, init_task):
+#ifdef CONFIG_EXT_GROUP_SCHED
+	case offsetof(struct sched_ext_ops, cgroup_init):
+	case offsetof(struct sched_ext_ops, cgroup_exit):
+	case offsetof(struct sched_ext_ops, cgroup_prep_move):
+#endif
 	case offsetof(struct sched_ext_ops, cpu_online):
 	case offsetof(struct sched_ext_ops, cpu_offline):
 	case offsetof(struct sched_ext_ops, init):
@@ -5066,6 +5512,14 @@ static s32 init_task_stub(struct task_struct *p, struct scx_init_task_args *args
 static void exit_task_stub(struct task_struct *p, struct scx_exit_task_args *args) {}
 static void enable_stub(struct task_struct *p) {}
 static void disable_stub(struct task_struct *p) {}
+#ifdef CONFIG_EXT_GROUP_SCHED
+static s32 cgroup_init_stub(struct cgroup *cgrp, struct scx_cgroup_init_args *args) { return -EINVAL; }
+static void cgroup_exit_stub(struct cgroup *cgrp) {}
+static s32 cgroup_prep_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) { return -EINVAL; }
+static void cgroup_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
+static void cgroup_cancel_move_stub(struct task_struct *p, struct cgroup *from, struct cgroup *to) {}
+static void cgroup_set_weight_stub(struct cgroup *cgrp, u32 weight) {}
+#endif
 static void cpu_online_stub(s32 cpu) {}
 static void cpu_offline_stub(s32 cpu) {}
 static s32 init_stub(void) { return -EINVAL; }
@@ -5094,6 +5548,14 @@ static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.exit_task = exit_task_stub,
 	.enable = enable_stub,
 	.disable = disable_stub,
+#ifdef CONFIG_EXT_GROUP_SCHED
+	.cgroup_init = cgroup_init_stub,
+	.cgroup_exit = cgroup_exit_stub,
+	.cgroup_prep_move = cgroup_prep_move_stub,
+	.cgroup_move = cgroup_move_stub,
+	.cgroup_cancel_move = cgroup_cancel_move_stub,
+	.cgroup_set_weight = cgroup_set_weight_stub,
+#endif
 	.cpu_online = cpu_online_stub,
 	.cpu_offline = cpu_offline_stub,
 	.init = init_stub,
@@ -5343,7 +5805,8 @@ void __init init_sched_ext_class(void)
 	 * definitions so that BPF scheduler implementations can use them
 	 * through the generated vmlinux.h.
 	 */
-	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP | SCX_KICK_PREEMPT);
+	WRITE_ONCE(v, SCX_ENQ_WAKEUP | SCX_DEQ_SLEEP | SCX_KICK_PREEMPT |
+		   SCX_TG_ONLINE);
 
 	BUG_ON(rhashtable_init(&dsq_hash, &dsq_hash_params));
 	init_dsq(&scx_dsq_global, SCX_DSQ_GLOBAL);
@@ -6403,6 +6866,41 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
 	return cpu_rq(cpu);
 }
 
+/**
+ * scx_bpf_task_cgroup - Return the sched cgroup of a task
+ * @p: task of interest
+ *
+ * @p->sched_task_group->css.cgroup represents the cgroup @p is associated with
+ * from the scheduler's POV. SCX operations should use this function to
+ * determine @p's current cgroup as, unlike following @p->cgroups,
+ * @p->sched_task_group is protected by @p's rq lock and thus atomic w.r.t. all
+ * rq-locked operations. Can be called on the parameter tasks of rq-locked
+ * operations. The restriction guarantees that @p's rq is locked by the caller.
+ */
+#ifdef CONFIG_CGROUP_SCHED
+__bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
+{
+	struct task_group *tg = p->sched_task_group;
+	struct cgroup *cgrp = &cgrp_dfl_root.cgrp;
+
+	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
+		goto out;
+
+	/*
+	 * A task_group may either be a cgroup or an autogroup. In the latter
+	 * case, @tg->css.cgroup is %NULL. A task_group can't become the other
+	 * kind once created.
+	 */
+	if (tg && tg->css.cgroup)
+		cgrp = tg->css.cgroup;
+	else
+		cgrp = &cgrp_dfl_root.cgrp;
+out:
+	cgroup_get(cgrp);
+	return cgrp;
+}
+#endif
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_any)
@@ -6431,6 +6929,9 @@ BTF_ID_FLAGS(func, scx_bpf_pick_any_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_running, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_task_cpu, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_cpu_rq)
+#ifdef CONFIG_CGROUP_SCHED
+BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_RCU | KF_ACQUIRE)
+#endif
 BTF_KFUNCS_END(scx_kfunc_ids_any)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_any = {
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index 32d3a51f591a..246019519231 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -67,3 +67,25 @@ static inline void scx_update_idle(struct rq *rq, bool idle)
 #else
 static inline void scx_update_idle(struct rq *rq, bool idle) {}
 #endif
+
+#ifdef CONFIG_CGROUP_SCHED
+#ifdef CONFIG_EXT_GROUP_SCHED
+int scx_tg_online(struct task_group *tg);
+void scx_tg_offline(struct task_group *tg);
+int scx_cgroup_can_attach(struct cgroup_taskset *tset);
+void scx_move_task(struct task_struct *p);
+void scx_cgroup_finish_attach(void);
+void scx_cgroup_cancel_attach(struct cgroup_taskset *tset);
+void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight);
+void scx_group_set_idle(struct task_group *tg, bool idle);
+#else	/* CONFIG_EXT_GROUP_SCHED */
+static inline int scx_tg_online(struct task_group *tg) { return 0; }
+static inline void scx_tg_offline(struct task_group *tg) {}
+static inline int scx_cgroup_can_attach(struct cgroup_taskset *tset) { return 0; }
+static inline void scx_move_task(struct task_struct *p) {}
+static inline void scx_cgroup_finish_attach(void) {}
+static inline void scx_cgroup_cancel_attach(struct cgroup_taskset *tset) {}
+static inline void scx_group_set_weight(struct task_group *tg, unsigned long cgrp_weight) {}
+static inline void scx_group_set_idle(struct task_group *tg, bool idle) {}
+#endif	/* CONFIG_EXT_GROUP_SCHED */
+#endif	/* CONFIG_CGROUP_SCHED */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b471fcd5950c..4faef92c68ef 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -460,6 +460,11 @@ struct task_group {
 	struct rt_bandwidth	rt_bandwidth;
 #endif
 
+#ifdef CONFIG_EXT_GROUP_SCHED
+	u32			scx_flags;	/* SCX_TG_* */
+	u32			scx_weight;
+#endif
+
 	struct rcu_head		rcu;
 	struct list_head	list;
 
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 20280df62857..457462b19966 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -61,6 +61,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
 
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
diff --git a/tools/testing/selftests/sched_ext/maximal.bpf.c b/tools/testing/selftests/sched_ext/maximal.bpf.c
index 44612fdaf399..00bfa9cb95d3 100644
--- a/tools/testing/selftests/sched_ext/maximal.bpf.c
+++ b/tools/testing/selftests/sched_ext/maximal.bpf.c
@@ -95,6 +95,32 @@ void BPF_STRUCT_OPS(maximal_exit_task, struct task_struct *p,
 void BPF_STRUCT_OPS(maximal_disable, struct task_struct *p)
 {}
 
+s32 BPF_STRUCT_OPS(maximal_cgroup_init, struct cgroup *cgrp,
+		   struct scx_cgroup_init_args *args)
+{
+	return 0;
+}
+
+void BPF_STRUCT_OPS(maximal_cgroup_exit, struct cgroup *cgrp)
+{}
+
+s32 BPF_STRUCT_OPS(maximal_cgroup_prep_move, struct task_struct *p,
+		   struct cgroup *from, struct cgroup *to)
+{
+	return 0;
+}
+
+void BPF_STRUCT_OPS(maximal_cgroup_move, struct task_struct *p,
+		    struct cgroup *from, struct cgroup *to)
+{}
+
+void BPF_STRUCT_OPS(maximal_cgroup_cancel_move, struct task_struct *p,
+	       struct cgroup *from, struct cgroup *to)
+{}
+
+void BPF_STRUCT_OPS(maximal_cgroup_set_weight, struct cgroup *cgrp, u32 weight)
+{}
+
 s32 BPF_STRUCT_OPS_SLEEPABLE(maximal_init)
 {
 	return 0;
@@ -126,6 +152,12 @@ struct sched_ext_ops maximal_ops = {
 	.enable			= maximal_enable,
 	.exit_task		= maximal_exit_task,
 	.disable		= maximal_disable,
+	.cgroup_init		= maximal_cgroup_init,
+	.cgroup_exit		= maximal_cgroup_exit,
+	.cgroup_prep_move	= maximal_cgroup_prep_move,
+	.cgroup_move		= maximal_cgroup_move,
+	.cgroup_cancel_move	= maximal_cgroup_cancel_move,
+	.cgroup_set_weight	= maximal_cgroup_set_weight,
 	.init			= maximal_init,
 	.exit			= maximal_exit,
 	.name			= "maximal",
-- 
2.46.0


