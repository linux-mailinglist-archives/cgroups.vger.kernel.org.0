Return-Path: <cgroups+bounces-14291-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEt6IoeGnmnRVwQAu9opvQ
	(envelope-from <cgroups+bounces-14291-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:20:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 410B6191F57
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:20:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D48316F950
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732336F407;
	Wed, 25 Feb 2026 05:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2xStsNX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9936D507;
	Wed, 25 Feb 2026 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995733; cv=none; b=QQXmkXkNxbnT2TQyb/IWH5pDQ9zGajAM7iOexrSblqjyFUYhAbjWC+KhuDAAlSMbKyFyvXzksLF0dIQK5jbpvzB8syR2o9d23TfwRuWHNiPNhlugJnmj2DV2hcdxgI0Dbx2t3TRsZZEfNx5HhijGnH2j77IL55giW2ElW+esJaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995733; c=relaxed/simple;
	bh=BPYEQh6tFPKhvYRZrfn7N/dHHUB82pNZyGgYiuihD3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmX1uQKIIzJ528RIssJi5K6ZhQqqZEeqSRWHxC5pPYmMPDLfv+wX6jMYZMCeOK3fvyMa7RskkjdRiH7z282R7PTKWOpwdtnXXCIZZN0YbKeKGmrYUBxSwFpg04EagEp2fznxOVP6Ok+VC4y8/m0vhyN3MANRPMWMeZ5/HZzJGLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2xStsNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A6EC19422;
	Wed, 25 Feb 2026 05:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995732;
	bh=BPYEQh6tFPKhvYRZrfn7N/dHHUB82pNZyGgYiuihD3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E2xStsNXPJIHgPBIUAr0zsqHQMsB9iJqlem72W21gFYHoFnfJvuHHlCBc9uvDZU5I
	 0XycTExivce7W2rx2ZBGYwIixlF2uBnm5DjiHYGUWj0m3nzghVg7261vtzRLndsCyD
	 1EG1Hpufqt4/vtaw4+AwMYdOLf8+uydZ9+J9sNzkAG9V2MH/uBNb9zEwzSAm41ViZ/
	 t822nT7HYb4QawozOi3CF/k1ywgPeYQzGzpjh+2M1uFBMX8Fko+l2Cmb9W3Ex8mDR2
	 YXsj/CbXn8ALnAe/e4HLjF7kYdirKPcSl+R/V3DijNEV+BlUu1v9S+qeGiqDPRijaU
	 RmbcrqsHvLwOw==
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
Subject: [PATCH 17/34] sched_ext: Move bypass_dsq into scx_sched_pcpu
Date: Tue, 24 Feb 2026 19:01:35 -1000
Message-ID: <20260225050152.1070601-18-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14291-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 410B6191F57
X-Rspamd-Action: no action

To support bypass mode for sub-schedulers, move bypass_dsq from struct scx_rq
to struct scx_sched_pcpu. Add bypass_dsq() helper. Move bypass_dsq
initialization from init_sched_ext_class() to scx_alloc_and_attach_sched().
bypass_lb_cpu() now takes a CPU number instead of rq pointer. All callers
updated. No behavior change as all tasks use the root scheduler.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 52 +++++++++++++++++++------------------
 kernel/sched/ext_internal.h |  2 ++
 kernel/sched/sched.h        |  1 -
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ef11a537acc5..a68f97befcf1 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -359,6 +359,11 @@ static const struct sched_class *scx_setscheduler_class(struct task_struct *p)
 	return __setscheduler_class(p->policy, p->prio);
 }
 
+static struct scx_dispatch_q *bypass_dsq(struct scx_sched *sch, s32 cpu)
+{
+	return &per_cpu_ptr(sch->pcpu, cpu)->bypass_dsq;
+}
+
 /*
  * scx_kf_mask enforcement. Some kfuncs can only be called from specific SCX
  * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to indicate
@@ -1628,7 +1633,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dsq = find_global_dsq(sch, p);
 	goto enqueue;
 bypass:
-	dsq = &task_rq(p)->scx.bypass_dsq;
+	dsq = bypass_dsq(sch, task_cpu(p));
 	goto enqueue;
 
 enqueue:
@@ -2439,7 +2444,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		goto has_tasks;
 
 	if (scx_rq_bypassing(rq)) {
-		if (consume_dispatch_q(sch, rq, &rq->scx.bypass_dsq))
+		if (consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu_of(rq))))
 			goto has_tasks;
 		else
 			goto no_tasks;
@@ -4192,11 +4197,12 @@ bool scx_hardlockup(int cpu)
 	return true;
 }
 
-static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
+static u32 bypass_lb_cpu(struct scx_sched *sch, s32 donor,
 			 struct cpumask *donee_mask, struct cpumask *resched_mask,
 			 u32 nr_donor_target, u32 nr_donee_target)
 {
-	struct scx_dispatch_q *donor_dsq = &rq->scx.bypass_dsq;
+	struct rq *donor_rq = cpu_rq(donor);
+	struct scx_dispatch_q *donor_dsq = bypass_dsq(sch, donor);
 	struct task_struct *p, *n;
 	struct scx_dsq_list_node cursor = INIT_DSQ_LIST_CURSOR(cursor, 0, 0);
 	s32 delta = READ_ONCE(donor_dsq->nr) - nr_donor_target;
@@ -4212,7 +4218,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 	if (delta < DIV_ROUND_UP(min_delta_us, scx_slice_bypass_us))
 		return 0;
 
-	raw_spin_rq_lock_irq(rq);
+	raw_spin_rq_lock_irq(donor_rq);
 	raw_spin_lock(&donor_dsq->lock);
 	list_add(&cursor.node, &donor_dsq->list);
 resume:
@@ -4220,7 +4226,6 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 	n = nldsq_next_task(donor_dsq, n, false);
 
 	while ((p = n)) {
-		struct rq *donee_rq;
 		struct scx_dispatch_q *donee_dsq;
 		int donee;
 
@@ -4236,14 +4241,13 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		if (donee >= nr_cpu_ids)
 			continue;
 
-		donee_rq = cpu_rq(donee);
-		donee_dsq = &donee_rq->scx.bypass_dsq;
+		donee_dsq = bypass_dsq(sch, donee);
 
 		/*
 		 * $p's rq is not locked but $p's DSQ lock protects its
 		 * scheduling properties making this test safe.
 		 */
-		if (!task_can_run_on_remote_rq(sch, p, donee_rq, false))
+		if (!task_can_run_on_remote_rq(sch, p, cpu_rq(donee), false))
 			continue;
 
 		/*
@@ -4258,7 +4262,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		 * between bypass DSQs.
 		 */
 		dispatch_dequeue_locked(p, donor_dsq);
-		dispatch_enqueue(sch, donee_rq, donee_dsq, p, SCX_ENQ_NESTED);
+		dispatch_enqueue(sch, cpu_rq(donee), donee_dsq, p, SCX_ENQ_NESTED);
 
 		/*
 		 * $donee might have been idle and need to be woken up. No need
@@ -4273,9 +4277,9 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 		if (!(nr_balanced % SCX_BYPASS_LB_BATCH) && n) {
 			list_move_tail(&cursor.node, &n->scx.dsq_list.node);
 			raw_spin_unlock(&donor_dsq->lock);
-			raw_spin_rq_unlock_irq(rq);
+			raw_spin_rq_unlock_irq(donor_rq);
 			cpu_relax();
-			raw_spin_rq_lock_irq(rq);
+			raw_spin_rq_lock_irq(donor_rq);
 			raw_spin_lock(&donor_dsq->lock);
 			goto resume;
 		}
@@ -4283,7 +4287,7 @@ static u32 bypass_lb_cpu(struct scx_sched *sch, struct rq *rq,
 
 	list_del_init(&cursor.node);
 	raw_spin_unlock(&donor_dsq->lock);
-	raw_spin_rq_unlock_irq(rq);
+	raw_spin_rq_unlock_irq(donor_rq);
 
 	return nr_balanced;
 }
@@ -4301,7 +4305,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	/* count the target tasks and CPUs */
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
+		u32 nr = READ_ONCE(bypass_dsq(sch, cpu)->nr);
 
 		nr_tasks += nr;
 		nr_cpus++;
@@ -4323,24 +4327,21 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 
 	cpumask_clear(donee_mask);
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		if (READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr) < nr_target)
+		if (READ_ONCE(bypass_dsq(sch, cpu)->nr) < nr_target)
 			cpumask_set_cpu(cpu, donee_mask);
 	}
 
 	/* iterate !donee CPUs and see if they should be offloaded */
 	cpumask_clear(resched_mask);
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		struct rq *rq = cpu_rq(cpu);
-		struct scx_dispatch_q *donor_dsq = &rq->scx.bypass_dsq;
-
 		if (cpumask_empty(donee_mask))
 			break;
 		if (cpumask_test_cpu(cpu, donee_mask))
 			continue;
-		if (READ_ONCE(donor_dsq->nr) <= nr_donor_target)
+		if (READ_ONCE(bypass_dsq(sch, cpu)->nr) <= nr_donor_target)
 			continue;
 
-		nr_balanced += bypass_lb_cpu(sch, rq, donee_mask, resched_mask,
+		nr_balanced += bypass_lb_cpu(sch, cpu, donee_mask, resched_mask,
 					     nr_donor_target, nr_target);
 	}
 
@@ -4348,7 +4349,7 @@ static void bypass_lb_node(struct scx_sched *sch, int node)
 		resched_cpu(cpu);
 
 	for_each_cpu_and(cpu, cpu_online_mask, node_mask) {
-		u32 nr = READ_ONCE(cpu_rq(cpu)->scx.bypass_dsq.nr);
+		u32 nr = READ_ONCE(bypass_dsq(sch, cpu)->nr);
 
 		after_min = min(nr, after_min);
 		after_max = max(nr, after_max);
@@ -5243,7 +5244,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 {
 	struct scx_sched *sch;
 	s32 level = parent ? parent->level + 1 : 0;
-	int node, ret;
+	s32 node, cpu, ret;
 
 	sch = kzalloc_flex(*sch, ancestors, level);
 	if (!sch)
@@ -5284,6 +5285,9 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		goto err_free_gdsqs;
 	}
 
+	for_each_possible_cpu(cpu)
+		init_dsq(bypass_dsq(sch, cpu), SCX_DSQ_BYPASS, sch);
+
 	sch->helper = kthread_run_worker(0, "sched_ext_helper");
 	if (IS_ERR(sch->helper)) {
 		ret = PTR_ERR(sch->helper);
@@ -5463,7 +5467,6 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 		struct rq *rq = cpu_rq(cpu);
 
 		rq->scx.local_dsq.sched = sch;
-		rq->scx.bypass_dsq.sched = sch;
 		rq->scx.cpuperf_target = SCX_CPUPERF_ONE;
 	}
 
@@ -6399,9 +6402,8 @@ void __init init_sched_ext_class(void)
 		struct rq *rq = cpu_rq(cpu);
 		int  n = cpu_to_node(cpu);
 
-		/* local/bypass dsq's sch will be set during scx_root_enable() */
+		/* local_dsq's sch will be set during scx_root_enable() */
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL, NULL);
-		init_dsq(&rq->scx.bypass_dsq, SCX_DSQ_BYPASS, NULL);
 
 		INIT_LIST_HEAD(&rq->scx.runnable_list);
 		INIT_LIST_HEAD(&rq->scx.ddsp_deferred_locals);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 96c8e75f2930..2fccd65067b8 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -932,6 +932,8 @@ struct scx_sched_pcpu {
 	 * constructed when requested by scx_bpf_events().
 	 */
 	struct scx_event_stats	event_stats;
+
+	struct scx_dispatch_q	bypass_dsq;
 };
 
 struct scx_sched {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b82fb70a9d54..d9921d743467 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -810,7 +810,6 @@ struct scx_rq {
 	struct balance_callback	deferred_bal_cb;
 	struct irq_work		deferred_irq_work;
 	struct irq_work		kick_cpus_irq_work;
-	struct scx_dispatch_q	bypass_dsq;
 };
 #endif /* CONFIG_SCHED_CLASS_EXT */
 
-- 
2.53.0


