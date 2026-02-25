Return-Path: <cgroups+bounces-14294-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI/FCAqHnmnsVwQAu9opvQ
	(envelope-from <cgroups+bounces-14294-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:22:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F25A191FD7
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 06:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 213583095C45
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 05:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F70374746;
	Wed, 25 Feb 2026 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+PNbULS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984836F43B;
	Wed, 25 Feb 2026 05:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771995736; cv=none; b=B6Mxb5qv8kKm0U+wyeTazkbtJlsrGEbzCZenTTNCuInGt5cdilxboZrdfz7OHIbiOMHPvql3i6hwOBxXIWhwt766WNPSsPUXm7rUjTmD5pcgXA1GTKgt42JBj5reeg2iBIquNUnFMb5F87Crtgikwp95wdhCVfDsaUG7il/FDIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771995736; c=relaxed/simple;
	bh=KrCNe9MtsfTl/3X60+z9H7/2VmsQLcP/cvf19g0VG3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hhhaKijsp8dRI/JEDI79gyjuA0j80/kPt25sp7sP3MpKYr8BrthV9KRY+2KmWJug7/2bQZlGHC2QPN5QbSPLdlR3Rh15VXe9jvWzRtMUk3zajmFvGPaNMREExDWCIx3y0O7AmNNXbYU3PJZIIgf3EDKFtImQj/+Kilnok3Mva40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+PNbULS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C516AC19425;
	Wed, 25 Feb 2026 05:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771995735;
	bh=KrCNe9MtsfTl/3X60+z9H7/2VmsQLcP/cvf19g0VG3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+PNbULSw4YOHSpzI3DYBP5QkGmkZtLmgXoGjamf5WMAyKOAjjhKqG371TOXLeVdv
	 ifOht2XkBOy+tq4YQutZ7rkG5wxYTQ/4lmy63yKVpLUVnGbqFV47MiI29rb0VR2V3c
	 KRj/3dBfGAPPFSYtlX2M8MkyXoJ8HJZbv387XOW+GYNeEbQ/1P78rnOAX3kBXfNuxo
	 UAXSSR/L8m09kId+4MHGk1W9L+iBpGZztSj+2gklhDmIzCqKuKrLxts7lU0SVzo585
	 BJzY9uBVgrWr7+wtBtrXE7UEabB9P6CeeSlzeUUdZ30pN95QBXAuzxbv363jCAQGgX
	 Kb0M/Y0V1zyFw==
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
Subject: [PATCH 20/34] sched_ext: Factor out scx_dispatch_sched()
Date: Tue, 24 Feb 2026 19:01:38 -1000
Message-ID: <20260225050152.1070601-21-tj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14294-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F25A191FD7
X-Rspamd-Action: no action

In preparation of multiple scheduler support, factor out
scx_dispatch_sched() from balance_one(). The function boundary makes
remembering $prev_on_scx and $prev_on_rq less useful. Open code $prev_on_scx
in balance_one() and $prev_on_rq in both balance_one() and
scx_dispatch_sched().

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 123 ++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 58 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2aab3ccbd3e3..99ef2a1cc3ac 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2384,67 +2384,22 @@ static inline void maybe_queue_balance_callback(struct rq *rq)
 	rq->scx.flags &= ~SCX_RQ_BAL_CB_PENDING;
 }
 
-static int balance_one(struct rq *rq, struct task_struct *prev)
+static bool scx_dispatch_sched(struct scx_sched *sch, struct rq *rq,
+			       struct task_struct *prev)
 {
-	struct scx_sched *sch = scx_root;
 	struct scx_dsp_ctx *dspc = this_cpu_ptr(scx_dsp_ctx);
 	bool prev_on_scx = prev->sched_class == &ext_sched_class;
-	bool prev_on_rq = prev->scx.flags & SCX_TASK_QUEUED;
 	int nr_loops = SCX_DSP_MAX_LOOPS;
 	s32 cpu = cpu_of(rq);
 
-	lockdep_assert_rq_held(rq);
-	rq->scx.flags |= SCX_RQ_IN_BALANCE;
-	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
-
-	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
-	    unlikely(rq->scx.cpu_released)) {
-		/*
-		 * If the previous sched_class for the current CPU was not SCX,
-		 * notify the BPF scheduler that it again has control of the
-		 * core. This callback complements ->cpu_release(), which is
-		 * emitted in switch_class().
-		 */
-		if (SCX_HAS_OP(sch, cpu_acquire))
-			SCX_CALL_OP(sch, SCX_KF_REST, cpu_acquire, rq, cpu, NULL);
-		rq->scx.cpu_released = false;
-	}
-
-	if (prev_on_scx) {
-		update_curr_scx(rq);
-
-		/*
-		 * If @prev is runnable & has slice left, it has priority and
-		 * fetching more just increases latency for the fetched tasks.
-		 * Tell pick_task_scx() to keep running @prev. If the BPF
-		 * scheduler wants to handle this explicitly, it should
-		 * implement ->cpu_release().
-		 *
-		 * See scx_disable_workfn() for the explanation on the bypassing
-		 * test.
-		 */
-		if (prev_on_rq && prev->scx.slice && !scx_bypassing(sch, cpu)) {
-			rq->scx.flags |= SCX_RQ_BAL_KEEP;
-			goto has_tasks;
-		}
-	}
-
-	/* if there already are tasks to run, nothing to do */
-	if (rq->scx.local_dsq.nr)
-		goto has_tasks;
-
 	if (consume_global_dsq(sch, rq))
-		goto has_tasks;
+		return true;
 
-	if (scx_bypassing(sch, cpu)) {
-		if (consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu)))
-			goto has_tasks;
-		else
-			goto no_tasks;
-	}
+	if (scx_bypassing(sch, cpu))
+		return consume_dispatch_q(sch, rq, bypass_dsq(sch, cpu));
 
 	if (unlikely(!SCX_HAS_OP(sch, dispatch)) || !scx_rq_online(rq))
-		goto no_tasks;
+		return false;
 
 	dspc->rq = rq;
 
@@ -2463,14 +2418,14 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 
 		flush_dispatch_buf(sch, rq);
 
-		if (prev_on_rq && prev->scx.slice) {
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice) {
 			rq->scx.flags |= SCX_RQ_BAL_KEEP;
-			goto has_tasks;
+			return true;
 		}
 		if (rq->scx.local_dsq.nr)
-			goto has_tasks;
+			return true;
 		if (consume_global_dsq(sch, rq))
-			goto has_tasks;
+			return true;
 
 		/*
 		 * ops.dispatch() can trap us in this loop by repeatedly
@@ -2479,7 +2434,7 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		 * balance(), we want to complete this scheduling cycle and then
 		 * start a new one. IOW, we want to call resched_curr() on the
 		 * next, most likely idle, task, not the current one. Use
-		 * scx_kick_cpu() for deferred kicking.
+		 * __scx_bpf_kick_cpu() for deferred kicking.
 		 */
 		if (unlikely(!--nr_loops)) {
 			scx_kick_cpu(sch, cpu, 0);
@@ -2487,12 +2442,64 @@ static int balance_one(struct rq *rq, struct task_struct *prev)
 		}
 	} while (dspc->nr_tasks);
 
-no_tasks:
+	return false;
+}
+
+static int balance_one(struct rq *rq, struct task_struct *prev)
+{
+	struct scx_sched *sch = scx_root;
+	s32 cpu = cpu_of(rq);
+
+	lockdep_assert_rq_held(rq);
+	rq->scx.flags |= SCX_RQ_IN_BALANCE;
+	rq->scx.flags &= ~SCX_RQ_BAL_KEEP;
+
+	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
+	    unlikely(rq->scx.cpu_released)) {
+		/*
+		 * If the previous sched_class for the current CPU was not SCX,
+		 * notify the BPF scheduler that it again has control of the
+		 * core. This callback complements ->cpu_release(), which is
+		 * emitted in switch_class().
+		 */
+		if (SCX_HAS_OP(sch, cpu_acquire))
+			SCX_CALL_OP(sch, SCX_KF_REST, cpu_acquire, rq, cpu, NULL);
+		rq->scx.cpu_released = false;
+	}
+
+	if (prev->sched_class == &ext_sched_class) {
+		update_curr_scx(rq);
+
+		/*
+		 * If @prev is runnable & has slice left, it has priority and
+		 * fetching more just increases latency for the fetched tasks.
+		 * Tell pick_task_scx() to keep running @prev. If the BPF
+		 * scheduler wants to handle this explicitly, it should
+		 * implement ->cpu_release().
+		 *
+		 * See scx_disable_workfn() for the explanation on the bypassing
+		 * test.
+		 */
+		if ((prev->scx.flags & SCX_TASK_QUEUED) && prev->scx.slice &&
+		    !scx_bypassing(sch, cpu)) {
+			rq->scx.flags |= SCX_RQ_BAL_KEEP;
+			goto has_tasks;
+		}
+	}
+
+	/* if there already are tasks to run, nothing to do */
+	if (rq->scx.local_dsq.nr)
+		goto has_tasks;
+
+	/* dispatch @sch */
+	if (scx_dispatch_sched(sch, rq, prev))
+		goto has_tasks;
+
 	/*
 	 * Didn't find another task to run. Keep running @prev unless
 	 * %SCX_OPS_ENQ_LAST is in effect.
 	 */
-	if (prev_on_rq &&
+	if ((prev->scx.flags & SCX_TASK_QUEUED) &&
 	    (!(sch->ops.flags & SCX_OPS_ENQ_LAST) || scx_bypassing(sch, cpu))) {
 		rq->scx.flags |= SCX_RQ_BAL_KEEP;
 		__scx_add_event(sch, SCX_EV_DISPATCH_KEEP_LAST, 1);
-- 
2.53.0


