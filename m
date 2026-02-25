Return-Path: <cgroups+bounces-14273-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA/DMfaEnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14273-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:13:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A150191D79
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4BB231A9157
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92A83328E3;
	Wed, 25 Feb 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpYZe0br"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967A7331A44;
	Wed, 25 Feb 2026 05:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995706; cv=none; b=ThO7XxnBDfcT4TC2F/jpPcsDDJ3NG3fuUr597uT7iBb9Wgc7IwvGcwJdeq4QA9LJ+Ypb6zrmKR4U7sBE9LPq0zgQ4L1ul1YVpFC/ARcoSKtbVEvIc0PMzYme/zVKoNOhX5ond2bpBWpX226VdMwFUFyLhFlCw6Fymekdf3hJnYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995706; c=relaxed/simple;
	bh=TWBQxhFPGrs+5HCdxpA8HGWg9/Gq7atg6NcaDwONa18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdtqF+Bun1Ah4A+zP8qgvx4aGCpDDKTxnQlwsZglG0Ozm4+BMwvVgjv+xDijET7OxmfmY5O1FWw2Js4gtg7y/CD06Abx2IvNw8WITP3JJW3eizzX6T2RQZYngZR4SEHvf32wmSbEhYazW+krz6YUWSvZE/4XiOVqLnz+1YAk4xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpYZe0br; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326A4C116D0;
	Wed, 25 Feb 2026 05:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995706;
	bh=TWBQxhFPGrs+5HCdxpA8HGWg9/Gq7atg6NcaDwONa18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpYZe0brGyttvYboVcLhBjRmFkyoU8Vlg4Ewh822ZbMuNoj4y3cjMdw0NprVe4QGA
	 xQ6OZcUrh19B6StUsbEXU+pOFh5yAookm95FTps2A38Rir8sScL6myWzN8s7xWeZwi
	 FaFzMz9kzlZbu99DSDuW7/9mVc/WzJNnlZwkQN9T/zMTv2uVmy18MdCXtfdGLniIHd
	 CJBT5O7JQpUi1EVQiM3UBMHC0ehhi9Am7Qb319gG6uIwuQoVeswTCN41P0V+dF0DwM
	 Ro3aE3S+BCA9kDc854FdsqtK5oT6RIhHxXaPOUNivM8Qo8bSq1CGuxlDkv20BETvCG
	 mhz4sOw3bLqmw==
From: Tejun Heo <tj@kernel.org>
To: linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	cgroups@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 34/34] sched_ext: Add basic building blocks for nested sub-scheduler dispatching
Date: Tue, 24 Feb 2026 19:01:09 -1000
Message-ID: <20260225050109.1070059-35-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050109.1070059-1-tj@kernel.org>
References: <20260225050109.1070059-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14273-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A150191D79
X-Rspamd-Action: no action

This is an early-stage partial implementation that demonstrates the core
building blocks for nested sub-scheduler dispatching. While significant
work remains in the enqueue path and other areas, this patch establishes
the fundamental mechanisms needed for hierarchical scheduler operation.

The key building blocks introduced include:

- Private stack support for ops.dispatch() to prevent stack overflow when
  walking down nested schedulers during dispatch operations

- scx_bpf_sub_dispatch() kfunc that allows parent schedulers to trigger
  dispatch operations on their direct child schedulers

- Proper parent-child relationship validation to ensure dispatch requests
  are only made to legitimate child schedulers

- Updated scx_dispatch_sched() to handle both nested and non-nested
  invocations with appropriate kf_mask handling

The qmap scheduler is updated to demonstrate the functionality by calling
scx_bpf_sub_dispatch() on registered child schedulers when it has no
tasks in its own queues.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c                       | 120 ++++++++++++++++++++---
 kernel/sched/sched.h                     |   3 +
 tools/sched_ext/include/scx/common.bpf.h |   1 +
 tools/sched_ext/scx_qmap.bpf.c           |  37 ++++++-
 4 files changed, 145 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index eccb67a78e90..7255eab3acc3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2438,8 +2438,14 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 	rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
 }
 
-static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
-			       struct task_struct *prev)
+/*
+ * One user of this function is scx_bpf_dispatch() which can be called
+ * recursively as sub-sched dispatches nest. Always inline to reduce stack usage
+ * from the call frame.
+ */
+static __always_inline bool
+scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
+		   struct task_struct *prev, bool nested)
 {
 	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
@@ -2491,8 +2497,23 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 	do {
 		dspc->nr_tasks = 0;
 
-		SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq, cpu,
-			    prev_on_sch ? prev : NULL);
+		if (nested) {
+			/*
+			 * If nested, don't update kf_mask as the originating
+			 * invocation would already have set it up.
+			 */
+			SCX_CALL_OP(sch, 0, dispatch, rq, cpu,
+				    prev_on_sch ? prev : NULL);
+		} else {
+			/*
+			 * If not nested, stash @prev so that nested invocations
+			 * can access it.
+			 */
+			rq->scx.sub_dispatch_prev = prev;
+			SCX_CALL_OP(sch, SCX_KF_DISPATCH, dispatch, rq, cpu,
+				    prev_on_sch ? prev : NULL);
+			rq->scx.sub_dispatch_prev = NULL;
+		}
 
 		flush_dispatch_buf(sch, rq);
 
@@ -2533,7 +2554,7 @@ static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 
 static int balance_one(struct rq *rq, struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root, *pos;
+	struct scx_sched *sch = scx_root;
 	s32 cpu = cpu_of(rq);
 
 	lockdep_assert_rq_held(rq);
@@ -2577,13 +2598,8 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 	if (rq->scx.local_dsq.nr)
 		goto has_tasks;
 
-	/*
-	 * TEMPORARY - Dispatch all scheds. This will be replaced by BPF-driven
-	 * hierarchical operation.
-	 */
-	list_for_each_entry_rcu(pos, &scx_sched_all, all)
-		if (scx_dispatch_sched(pos, rq, prev))
-			goto has_tasks;
+	if (scx_dispatch_sched(sch, rq, prev, false))
+		goto has_tasks;
 
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
@@ -4918,9 +4934,8 @@ static void scx_sub_disable(struct scx_sched *sch)
 
 	/*
 	 * Guarantee forward progress and wait for descendants to be disabled.
-	 * To limit
-	 * disruptions, $parent is not bypassed. Tasks are fully prepped and
-	 * then inserted back into $parent.
+	 * To limit disruptions, $parent is not bypassed. Tasks are fully
+	 * prepped and then inserted back into $parent.
 	 */
 	scx_bypass(sch, true);
 	drain_descendants(sch);
@@ -6500,6 +6515,20 @@ static int bpf_scx_init_member(const struct btf_type *t,
 	return 0;
 }
 
+#ifdef CONFIG_EXT_SUB_SCHED
+static void scx_pstack_recursion_on_dispatch(struct bpf_prog *prog)
+{
+	struct scx_sched *sch;
+
+	guard(rcu)();
+	sch = scx_prog_sched(prog->aux);
+	if (unlikely(!sch))
+		return;
+
+	scx_error(sch, "dispatch recursion detected");
+}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 static int bpf_scx_check_member(const struct btf_type *t,
 				const struct btf_member *member,
 				const struct bpf_prog *prog)
@@ -6525,6 +6554,22 @@ static int bpf_scx_check_member(const struct btf_type *t,
 			return -EINVAL;
 	}
 
+#ifdef CONFIG_EXT_SUB_SCHED
+	/*
+	 * Enable private stack for operations that can nest along the
+	 * hierarchy.
+	 *
+	 * XXX - Ideally, we should only do this for scheds that allow
+	 * sub-scheds and sub-scheds themselves but I don't know how to access
+	 * struct_ops from here.
+	 */
+	switch (moff) {
+	case offsetof(struct sched_ext_ops, dispatch):
+		prog->aux->priv_stack_requested = true;
+		prog->aux->recursion_detected = scx_pstack_recursion_on_dispatch;
+	}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 	return 0;
 }
 
@@ -7509,6 +7554,48 @@ __bpf_kfunc bool scx_bpf_dsq_move_vtime(struct bpf_iter_scx_dsq *it__iter,
 			    p, dsq_id, enq_flags | SCX_ENQ_DSQ_PRIQ);
 }
 
+#ifdef CONFIG_EXT_SUB_SCHED
+/**
+ * scx_bpf_sub_dispatch - Trigger dispatching on a child scheduler
+ * @cgroup_id: cgroup ID of the child scheduler to dispatch
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
+ *
+ * Allows a parent scheduler to trigger dispatching on one of its direct
+ * child schedulers. The child scheduler runs its dispatch operation to
+ * move tasks from dispatch queues to the local runqueue.
+ *
+ * Returns: true on success, false if cgroup_id is invalid, not a direct
+ * child, or caller lacks dispatch permission.
+ */
+__bpf_kfunc bool scx_bpf_sub_dispatch(u64 cgroup_id, const struct bpf_prog_aux *aux)
+{
+	struct rq *this_rq = this_rq();
+	struct scx_sched *parent, *child;
+
+	guard(rcu)();
+	parent = scx_prog_sched(aux);
+	if (unlikely(!parent))
+		return false;
+
+	if (!scx_kf_allowed(parent, SCX_KF_DISPATCH))
+		return false;
+
+	child = scx_find_sub_sched(cgroup_id);
+
+	if (unlikely(!child))
+		return false;
+
+	if (unlikely(scx_parent(child) != parent)) {
+		scx_error(parent, "trying to dispatch a distant sub-sched on cgroup %llu",
+			  cgroup_id);
+		return false;
+	}
+
+	return scx_dispatch_sched(child, this_rq, this_rq->scx.sub_dispatch_prev,
+				  true);
+}
+#endif	/* CONFIG_EXT_SUB_SCHED */
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
@@ -7519,6 +7606,9 @@ BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_slice, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_set_vtime, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dsq_move_vtime, KF_RCU)
+#ifdef CONFIG_EXT_SUB_SCHED
+BTF_ID_FLAGS(func, scx_bpf_sub_dispatch, KF_IMPLICIT_ARGS)
+#endif
 BTF_KFUNCS_END(scx_kfunc_ids_dispatch)
 
 static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6934dbd1f96e..7324e4a8c99b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -805,6 +805,9 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
 	unsigned long		kick_sync;
+
+	struct task_struct	*sub_dispatch_prev;
+
 	struct llist_head	deferred_reenq_locals;
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 821d5791bd42..eba4d87345e0 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -101,6 +101,7 @@ struct rq *scx_bpf_locked_rq(void) __ksym;
 struct task_struct *scx_bpf_cpu_curr(s32 cpu) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
+bool scx_bpf_sub_dispatch(u64 cgroup_id) __ksym __weak;
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index ff6ff34177ab..91b8eac83f52 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -48,6 +48,9 @@ const volatile bool suppress_dump;
 u64 nr_highpri_queued;
 u32 test_error_cnt;
 
+#define MAX_SUB_SCHEDS		8
+u64 sub_sched_cgroup_ids[MAX_SUB_SCHEDS];
+
 UEI_DEFINE(uei);
 
 struct qmap {
@@ -451,6 +454,12 @@ void BPF_STRUCT_OPS(qmap_dispatch, s32 cpu, struct task_struct *prev)
 		cpuc->dsp_cnt = 0;
 	}
 
+	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
+		if (sub_sched_cgroup_ids[i] &&
+		    scx_bpf_sub_dispatch(sub_sched_cgroup_ids[i]))
+			return;
+	}
+
 	/*
 	 * No other tasks. @prev will keep running. Update its core_sched_seq as
 	 * if the task were enqueued and dispatched immediately.
@@ -895,7 +904,32 @@ void BPF_STRUCT_OPS(qmap_exit, struct scx_exit_info *ei)
 
 s32 BPF_STRUCT_OPS(qmap_sub_attach, struct scx_sub_attach_args *args)
 {
-	return 0;
+	s32 i;
+
+	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
+		if (!sub_sched_cgroup_ids[i]) {
+			sub_sched_cgroup_ids[i] = args->ops->sub_cgroup_id;
+			bpf_printk("attaching sub-sched[%d] on %s",
+				   i, args->cgroup_path);
+			return 0;
+		}
+	}
+
+	return -ENOSPC;
+}
+
+void BPF_STRUCT_OPS(qmap_sub_detach, struct scx_sub_detach_args *args)
+{
+	s32 i;
+
+	for (i = 0; i < MAX_SUB_SCHEDS; i++) {
+		if (sub_sched_cgroup_ids[i] == args->ops->sub_cgroup_id) {
+			sub_sched_cgroup_ids[i] = 0;
+			bpf_printk("detaching sub-sched[%d] on %s",
+				   i, args->cgroup_path);
+			break;
+		}
+	}
 }
 
 SCX_OPS_DEFINE(qmap_ops,
@@ -914,6 +948,7 @@ SCX_OPS_DEFINE(qmap_ops,
 	       .cgroup_set_weight	= (void *)qmap_cgroup_set_weight,
 	       .cgroup_set_bandwidth	= (void *)qmap_cgroup_set_bandwidth,
 	       .sub_attach		= (void *)qmap_sub_attach,
+	       .sub_detach		= (void *)qmap_sub_detach,
 	       .cpu_online		= (void *)qmap_cpu_online,
 	       .cpu_offline		= (void *)qmap_cpu_offline,
 	       .init			= (void *)qmap_init,
-- 
2.53.0


