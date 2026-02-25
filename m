Return-Path: <cgroups+bounces-14305-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPTSCQ+HnmnsVwQAu9opvQ
	(envelope-from <cgroups+bounces-14305-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:22:23 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9B191FDE
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2BCD3203ABA
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479C13815D3;
	Wed, 25 Feb 2026 05:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/M5QalI"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D743815C6;
	Wed, 25 Feb 2026 05:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995748; cv=none; b=JeyyUMk7bEWGhnZddcFKXp8usO2pw8qCCiuVpU1L3/gJPHTHiMT2DC5ndRc+yxDyehK9TJJx5wTlvx7482RMI0g21eUAq+mTt3YI5spHSWOlgdmae1aZarn0O47eD1aZInfgy5sYI7z5vugtM3Q2qDh5bx7G5Om7++QFTxKwKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995748; c=relaxed/simple;
	bh=7qSEfYnDdhjWu7vAvOuXyoBesVREg5Nj2oRlU31JUp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1hWsNsgK/3Jf7gY6Ykj5p2VGAAdEX9HIX40i0OT7oNNSdoQuUTXQ4B1rbvyg1fPOWX2fO5qyVE8DuMSjlVNcXpZl0fcDmIPQCWZ0LTBsdUKbGw/QjdtOm7FjatzWd4cOaCazpwQWfOOD12M1R697hcF/8yB8iEVqSD+qCuVH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/M5QalI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4A1C116D0;
	Wed, 25 Feb 2026 05:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995747;
	bh=7qSEfYnDdhjWu7vAvOuXyoBesVREg5Nj2oRlU31JUp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K/M5QalIQLY7pCclWAoMy933La4vJ9CbOBcXOGVVsMPTA0jNHJXAigoq5SM41T1Cx
	 POyKuceYXd34yPBGuXUQpmpcooV78wnlfhdffnbSCXV9VV7J+AbLYyMgzZLpZN9lVz
	 SbRjf8lPi8rarTI7IT5LS5HyYen/z8z2MoCOe8KvkelS80iH2gt2uTdMxXnSe8UB7Z
	 2eq701QmBGI2Zvkm2BOYQPlO/VNUda68CFKVyg328Sm2dkYqTwPIwbrJp3/uA60AjW
	 9u6V3F8pSMGUaZBXM2qGlavhG3eVA90wGNwfYXhM7b3TX9g9NdBRXRUsjGBHCWCGDe
	 mneWnlF3j24nw==
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
Subject: [PATCH 31/34] sched_ext: Make scx_bpf_reenqueue_local() sub-sched aware
Date: Tue, 24 Feb 2026 19:01:49 -1000
Message-ID: <20260225050152.1070601-32-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225050152.1070601-1-tj@kernel.org>
References: <20260225050152.1070601-1-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14305-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ED9B191FDE
X-Rspamd-Action: no action

scx_bpf_reenqueue_local() currently re-enqueues all tasks on the local DSQ
regardless of which sub-scheduler owns them. With multiple sub-schedulers,
each should only re-enqueue tasks it owns or are owned by its descendants.

Replace the per-rq boolean flag with a lock-free linked list to track
per-scheduler reenqueue requests. Filter tasks in reenq_local() using
hierarchical ownership checks and block deferrals during bypass to prevent
use on dead schedulers.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 73 ++++++++++++++++++++++++++++++-------
 kernel/sched/ext_internal.h |  1 +
 kernel/sched/sched.h        |  2 +-
 3 files changed, 62 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 131fc275f10a..39c5f22862b0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -183,7 +183,7 @@ MODULE_PARM_DESC(bypass_lb_intv_us, "bypass load balance interval in microsecond
 
 static void process_ddsp_deferred_locals(struct rq *rq);
 static bool task_dead_and_done(struct task_struct *p);
-static u32 reenq_local(struct rq *rq);
+static u32 reenq_local(struct scx_sched *sch, struct rq *rq);
 static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
 static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
 static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
@@ -989,9 +989,16 @@ static void run_deferred(struct rq *rq)
 {
 	process_ddsp_deferred_locals(rq);
 
-	if (local_read(&rq->scx.reenq_local_deferred)) {
-		local_set(&rq->scx.reenq_local_deferred, 0);
-		reenq_local(rq);
+	if (!llist_empty(&rq->scx.deferred_reenq_locals)) {
+		struct llist_node *llist =
+			llist_del_all(&rq->scx.deferred_reenq_locals);
+		struct scx_sched_pcpu *pos, *next;
+
+		llist_for_each_entry_safe(pos, next, llist,
+					  deferred_reenq_locals_node) {
+			init_llist_node(&pos->deferred_reenq_locals_node);
+			reenq_local(pos->sch, rq);
+		}
 	}
 }
 
@@ -4061,7 +4068,7 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 	struct scx_sched *sch = container_of(rcu_work, struct scx_sched, rcu_work);
 	struct rhashtable_iter rht_iter;
 	struct scx_dispatch_q *dsq;
-	int node;
+	int cpu, node;
 
 	irq_work_sync(&sch->error_irq_work);
 	kthread_destroy_worker(sch->helper);
@@ -4073,6 +4080,17 @@ static void scx_sched_free_rcu_work(struct work_struct *work)
 		cgroup_put(sch->cgrp);
 #endif	/* CONFIG_EXT_SUB_SCHED */
 
+	/*
+	 * $sch would have entered bypass mode before the RCU grace period. As
+	 * that blocks new deferrals, all deferred_reenq_locals_node's must be
+	 * off-list by now.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		WARN_ON_ONCE(llist_on_list(&pcpu->deferred_reenq_locals_node));
+	}
+
 	free_percpu(sch->pcpu);
 
 	for_each_node_state(node, N_POSSIBLE)
@@ -5631,8 +5649,12 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	for_each_possible_cpu(cpu)
 		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
 
-	for_each_possible_cpu(cpu)
-		per_cpu_ptr(sch->pcpu, cpu)->sch = sch;
+	for_each_possible_cpu(cpu) {
+		struct scx_sched_pcpu *pcpu = per_cpu_ptr(sch->pcpu, cpu);
+
+		pcpu->sch = sch;
+		init_llist_node(&pcpu->deferred_reenq_locals_node);
+	}
 
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
@@ -6883,6 +6905,7 @@ void __init init_sched_ext_class(void)
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_kick_if_idle, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_preempt, GFP_KERNEL, n));
 		BUG_ON(!zalloc_cpumask_var_node(&rq->scx.cpus_to_wait, GFP_KERNEL, n));
+		init_llist_head(&rq->scx.deferred_reenq_locals);
 		rq->scx.deferred_irq_work = IRQ_WORK_INIT_HARD(deferred_irq_workfn);
 		rq->scx.kick_cpus_irq_work = IRQ_WORK_INIT_HARD(kick_cpus_irq_workfn);
 
@@ -7454,7 +7477,7 @@ static const struct btf_kfunc_id_set scx_kfunc_set_dispatch = {
 	.set			= &scx_kfunc_ids_dispatch,
 };
 
-static u32 reenq_local(struct rq *rq)
+static u32 reenq_local(struct scx_sched *sch, struct rq *rq)
 {
 	LIST_HEAD(tasks);
 	u32 nr_enqueued = 0;
@@ -7469,6 +7492,8 @@ static u32 reenq_local(struct rq *rq)
 	 */
 	list_for_each_entry_safe(p, n, &rq->scx.local_dsq.list,
 				 scx.dsq_list.node) {
+		struct scx_sched *task_sch = scx_task_sched(p);
+
 		/*
 		 * If @p is being migrated, @p's current CPU may not agree with
 		 * its allowed CPUs and the migration_cpu_stop is about to
@@ -7483,6 +7508,9 @@ static u32 reenq_local(struct rq *rq)
 		if (p->migration_pending)
 			continue;
 
+		if (!scx_is_descendant(task_sch, sch))
+			continue;
+
 		dispatch_dequeue(rq, p);
 		list_add_tail(&p->scx.dsq_list.node, &tasks);
 	}
@@ -7525,7 +7553,7 @@ __bpf_kfunc u32 scx_bpf_reenqueue_local(const struct bpf_prog_aux *aux)
 	rq = cpu_rq(smp_processor_id());
 	lockdep_assert_rq_held(rq);
 
-	return reenq_local(rq);
+	return reenq_local(sch, rq);
 }
 
 __bpf_kfunc_end_defs();
@@ -8096,20 +8124,39 @@ __bpf_kfunc void scx_bpf_dump_bstr(char *fmt, unsigned long long *data,
 
 /**
  * scx_bpf_reenqueue_local - Re-enqueue tasks on a local DSQ
+ * @aux: implicit BPF argument to access bpf_prog_aux hidden from BPF progs
  *
  * Iterate over all of the tasks currently enqueued on the local DSQ of the
  * caller's CPU, and re-enqueue them in the BPF scheduler. Can be called from
  * anywhere.
  */
-__bpf_kfunc void scx_bpf_reenqueue_local___v2(void)
+__bpf_kfunc void scx_bpf_reenqueue_local___v2(const struct bpf_prog_aux *aux)
 {
+	unsigned long flags;
+	struct scx_sched *sch;
 	struct rq *rq;
+	struct llist_node *lnode;
 
-	guard(preempt)();
+	raw_local_irq_save(flags);
+
+	sch = scx_prog_sched(aux);
+	if (unlikely(!sch))
+		goto out_irq_restore;
+
+	/*
+	 * Allowing reenqueue-locals doesn't make sense while bypassing. This
+	 * also blocks from new reenqueues to be scheduled on dead scheds.
+	 */
+	if (unlikely(sch->bypass_depth))
+		goto out_irq_restore;
 
 	rq = this_rq();
-	local_set(&rq->scx.reenq_local_deferred, 1);
+	lnode = &this_cpu_ptr(sch->pcpu)->deferred_reenq_locals_node;
+	if (!llist_on_list(lnode))
+		llist_add(lnode, &rq->scx.deferred_reenq_locals);
 	schedule_deferred(rq);
+out_irq_restore:
+	raw_local_irq_restore(flags);
 }
 
 /**
@@ -8534,7 +8581,7 @@ BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, scx_bpf_exit_bstr, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_error_bstr, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_dump_bstr, KF_IMPLICIT_ARGS)
-BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2)
+BTF_ID_FLAGS(func, scx_bpf_reenqueue_local___v2, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cap, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_cur, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, scx_bpf_cpuperf_set, KF_IMPLICIT_ARGS)
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index cd5bd70fe30c..99c8a304b726 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -965,6 +965,7 @@ struct scx_sched_pcpu {
 	 */
 	struct scx_event_stats	event_stats;
 
+	struct llist_node	deferred_reenq_locals_node;
 	struct scx_dispatch_q	bypass_dsq;
 #ifdef CONFIG_EXT_SUB_SCHED
 	u32			bypass_host_seq;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 715c921698c7..6934dbd1f96e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -805,7 +805,7 @@ struct scx_rq {
 	cpumask_var_t		cpus_to_preempt;
 	cpumask_var_t		cpus_to_wait;
 	unsigned long		kick_sync;
-	local_t			reenq_local_deferred;
+	struct llist_head	deferred_reenq_locals;
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
-- 
2.53.0


