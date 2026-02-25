Return-Path: <cgroups+bounces-14264-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNhTE1ODnmmGVwQAu9opvQ
	(envelope-from <cgroups+bounces-14264-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:06:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08671191BFA
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C31D30AAC24
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683DC314B77;
	Wed, 25 Feb 2026 05:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnapOF37"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2606F314A9B;
	Wed, 25 Feb 2026 05:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995697; cv=none; b=LJxi6zHvjtec7aYhySS06BtWnehixIKpvk87dHWM2ZgX72Box9kT5XnV/9F106Uxcls0+qp53sLbMqcM+yP4SmfI1uzPegXctca7PUn8n3myZ9T1mpxpffiimKgKgcoZsB7jEjPgqH36E1hegR4JjpXSMx6OiHMXS51Ip7WQJI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995697; c=relaxed/simple;
	bh=q8rQC39D7F4DwE8ePIiXOw6FTEBBVr+DtUQ+B2Gtb1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm05croXPHUmG+jT/TkA5oNKjPPm+toB2XLpspR9AmZ9l0cdPB3PsfJZ3tSqvOF2e1AfrRHHmMpC1UfrPCxEgDtEx1VHMYglCk2UeKsWwVZO2FwxoJQOIwXViOd0wx/6hNxAQEv5sow4cyzIPKCw3qsYkedCM+cNZkYoS+ZXXWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnapOF37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52A8C116D0;
	Wed, 25 Feb 2026 05:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995696;
	bh=q8rQC39D7F4DwE8ePIiXOw6FTEBBVr+DtUQ+B2Gtb1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OnapOF37KKcEPmvOJ9+cPtZVD0yWvRQU6C8kAdX8rGt+AXbNCvpAtZk+EFiymQtXI
	 wEl/a9wqnZ+S5fc+rl/5Qu/5jXDTLwEjPgOsZi5M4bSaMGqmIpe09R7j+vy7Jo/nqw
	 8nETEwJzf4mRqQCIbq7djwTuJ5fYRx6wGsOT2flaGRRvCREH/j3W6DcMMwaKwDKbY5
	 +A2xCzdoEj+OgvLgcUJSESPUyfYB5MtuHqKNCmu8dZ1WwOEIV1xhfO0Gn6f47DZt3k
	 BcoQbB/Dri5EcQpiMfgfyRxrBlD2b6aeyR7EsmclgxfQTJjnS1gJssq/oJiHRM2sk1
	 hUfHYu090un/g==
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
Subject: [PATCH 25/34] sched_ext: Move scx_dsp_ctx and scx_dsp_max_batch into scx_sched
Date: Tue, 24 Feb 2026 19:01:00 -1000
Message-ID: <20260225050109.1070059-26-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14264-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 08671191BFA
X-Rspamd-Action: no action

scx_dsp_ctx and scx_dsp_max_batch are global variables used in the dispatch
path. In prepration for multiple scheduler support, move the former into
scx_sched_pcpu and the latter into scx_sched. No user-visible behavior
changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c          | 55 ++++++++++---------------------------
 kernel/sched/ext_internal.h | 19 +++++++++++++
 2 files changed, 34 insertions(+), 40 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 9551bfb0567b..0c1b27ab00a0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -106,25 +106,6 @@ static const struct rhashtable_params dsq_hash_params = {
 
 static LLIST_HEAD(dsqs_to_free);
 
-/* dispatch buf */
-struct scx_dsp_buf_ent {
-	struct task_struct	*task;
-	unsigned long		qseq;
-	u64			dsq_id;
-	u64			enq_flags;
-};
-
-static u32 scx_dsp_max_batch;
-
-struct scx_dsp_ctx {
-	struct rq		*rq;
-	u32			cursor;
-	u32			nr_tasks;
-	struct scx_dsp_buf_ent	buf[];
-};
-
-static struct scx_dsp_ctx __percpu *scx_dsp_ctx;
-
 /* string formatting from BPF */
 struct scx_bstr_buf {
 	u64			data[MAX_BPRINTF_VARARGS];
@@ -2398,7 +2379,7 @@ static void finish_dispatch(struct scx_sched *sch, struct rq *rq,
 
 static void flush_dispatch_buf(struct scx_sched *sch, struct rq *rq)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	u32 u;
 
 	for (u = 0; u < dspc->cursor; u++) {
@@ -2428,7 +2409,7 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
 			       struct task_struct *prev)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
 	bool prev_on_sch = (prev->sched_class == &ext_sched_class) &&
@@ -4953,9 +4934,6 @@ static void scx_root_disable(struct scx_sched *sch)
 	 */
 	kobject_del(&sch->kobj);
 
-	free_percpu(scx_dsp_ctx);
-	scx_dsp_ctx = NULL;
-	scx_dsp_max_batch = 0;
 	free_kick_syncs();
 
 	mutex_unlock(&scx_enable_mutex);
@@ -5450,7 +5428,10 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		sch->global_dsqs[node] = dsq;
 	}
 
-	sch->pcpu = alloc_percpu(struct scx_sched_pcpu);
+	sch->dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
+	sch->pcpu = __alloc_percpu(struct_size_t(struct scx_sched_pcpu,
+						 dsp_ctx.buf, sch->dsp_max_batch),
+				   __alignof__(struct scx_sched_pcpu));
 	if (!sch->pcpu) {
 		ret = -ENOMEM;
 		goto err_free_gdsqs;
@@ -5688,16 +5669,6 @@ static s32 scx_root_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	if (ret)
 		goto err_disable;
 
-	WARN_ON_ONCE(scx_dsp_ctx);
-	scx_dsp_max_batch = ops->dispatch_max_batch ?: SCX_DSP_DFL_MAX_BATCH;
-	scx_dsp_ctx = __alloc_percpu(struct_size_t(struct scx_dsp_ctx, buf,
-						   scx_dsp_max_batch),
-				     __alignof__(struct scx_dsp_ctx));
-	if (!scx_dsp_ctx) {
-		ret = -ENOMEM;
-		goto err_disable;
-	}
-
 	if (ops->timeout_ms)
 		timeout = msecs_to_jiffies(ops->timeout_ms);
 	else
@@ -6636,7 +6607,7 @@ static bool scx_dsq_insert_preamble(struct scx_sched *sch, struct task_struct *p
 static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 				  u64 dsq_id, u64 enq_flags)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
+	struct scx_dsp_ctx *dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
 	struct task_struct *ddsp_task;
 
 	ddsp_task = __this_cpu_read(direct_dispatch_task);
@@ -6645,7 +6616,7 @@ static void scx_dsq_insert_commit(struct scx_sched *sch, struct task_struct *p,
 		return;
 	}
 
-	if (unlikely(dspc->cursor >= scx_dsp_max_batch)) {
+	if (unlikely(dspc->cursor >= sch->dsp_max_batch)) {
 		scx_error(sch, "dispatch buffer overflow");
 		return;
 	}
@@ -6963,7 +6934,7 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return 0;
 
-	return scx_dsp_max_batch - __this_cpu_read(scx_dsp_ctx->cursor);
+	return sch->dsp_max_batch - __this_cpu_read(sch->pcpu->dsp_ctx.cursor);
 }
 
 /**
@@ -6975,8 +6946,8 @@ __bpf_kfunc u32 scx_bpf_dispatch_nr_slots(const struct bpf_prog_aux *aux)
  */
 __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -6987,6 +6958,8 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	if (dspc->cursor > 0)
 		dspc->cursor--;
 	else
@@ -7010,9 +6983,9 @@ __bpf_kfunc void scx_bpf_dispatch_cancel(const struct bpf_prog_aux *aux)
  */
 __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux *aux)
 {
-	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	struct scx_dispatch_q *dsq;
 	struct scx_sched *sch;
+	struct scx_dsp_ctx *dspc;
 
 	guard(rcu)();
 
@@ -7023,6 +6996,8 @@ __bpf_kfunc bool scx_bpf_dsq_move_to_local(u64 dsq_id, const struct bpf_prog_aux
 	if (!scx_kf_allowed(sch, SCX_KF_DISPATCH))
 		return false;
 
+	dspc = &this_cpu_ptr(sch->pcpu)->dsp_ctx;
+
 	flush_dispatch_buf(sch, dspc->rq);
 
 	dsq = find_user_dsq(sch, dsq_id);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index a447183c0bba..cce8dfbbdada 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -937,6 +937,21 @@ enum scx_sched_pcpu_flags {
 	SCX_SCHED_PCPU_BYPASSING	= 1LLU << 0,
 };
 
+/* dispatch buf */
+struct scx_dsp_buf_ent {
+	struct task_struct	*task;
+	unsigned long		qseq;
+	u64			dsq_id;
+	u64			enq_flags;
+};
+
+struct scx_dsp_ctx {
+	struct rq		*rq;
+	u32			cursor;
+	u32			nr_tasks;
+	struct scx_dsp_buf_ent	buf[];
+};
+
 struct scx_sched_pcpu {
 	u64			flags;	/* protected by rq lock */
 
@@ -951,6 +966,9 @@ struct scx_sched_pcpu {
 #ifdef CONFIG_EXT_SUB_SCHED
 	u32			bypass_host_seq;
 #endif
+
+	/* must be the last entry - contains flex array */
+	struct scx_dsp_ctx	dsp_ctx;
 };
 
 struct scx_sched {
@@ -978,6 +996,7 @@ struct scx_sched {
 	atomic_t		bypass_dsp_enable_depth;
 
 	bool			aborting;
+	u32			dsp_max_batch;
 	s32			level;
 
 	/*
-- 
2.53.0


