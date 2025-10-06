Return-Path: <cgroups+bounces-10558-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB1FBBDC1C
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C94BD34B05D
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F9271441;
	Mon,  6 Oct 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UlBzfxpF"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA826A0F8;
	Mon,  6 Oct 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747564; cv=none; b=p47f5KoaktD/zsxPJUbtJ4CMnswP2p7uRapbOjJXsVcapthC1hEBW36FhCCjzABnuXN4z3cUUTJUGM6OhfZtVmb/M3pc2IZSy6XAmKgZtydRwmDky7FTcpPGDN4YIbqqU7J1WOIy2gbDDurIPcrq3U3JpaTWSi4pz69kXdQ1wto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747564; c=relaxed/simple;
	bh=2jRxNfwlvsjHZBs8OKl5EwWe4QmjriuanSnkxBCGgok=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G3BIGU2GyN1VOekQFZsXJkLJlchKRu64oAAn/fcKYaNdLMbJBDShoPiDmFxB1MJJiD1nJK67PDRSavbixIXzFKy4dTACXCOZ5yARx3RJpjeN2O68XcFVul1X930ek51yGzHcUHS4wS1xT53AeVLlGbuS18eT/6N+yDENgUzYMy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UlBzfxpF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=7IaiVVcZxMwyJAC7lakJaxXx69OYQoV3ZOcsSQpZ6Uc=; b=UlBzfxpFdxOIDttduGz2XGzKRK
	MGLhdTEo/ek/vWaorsQg7oJ1oO5YYuXEZViQ0lw2dkBd2anXPVm2w9+zsqmM1Iblw5eZccLPMLT/s
	jwttxli0sxWOXFLVhThL70V30CFMk8nu/nzaWWFtEGoEkwj5VoUVkRTLUNMxVXa4Uxi0wdvTZf/2v
	fZZH7DRiDOUvpr1FExlRAgVYRGUrYCW1E2AhrQ+J8lfFbV/nilMwC9OVTSMiyKFBNOXQM1JjITeKp
	7PxQRhVW2rUwdxTbSzQQIEGLaA6r+3qhblGB41CUPaOzYfmCro/0cD/bEG/pUmNMGmam5cDRsDc7V
	Fs1lnwVg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iiz-0000000Grdq-0HUJ;
	Mon, 06 Oct 2025 10:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D08BD301142; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.083607521@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@kernel.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev,
 liuwenfang@honor.com,
 tglx@linutronix.de
Subject: [PATCH 05/12] sched: Move sched_class::prio_changed() into the change pattern
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Move sched_class::prio_changed() into the change pattern.

And while there, extend it with sched_class::get_prio() in order to
fix the deadline sitation.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c      |   24 +++++++++++++-----------
 kernel/sched/deadline.c  |   20 +++++++++++---------
 kernel/sched/ext.c       |    8 +-------
 kernel/sched/fair.c      |    8 ++++++--
 kernel/sched/idle.c      |    5 ++++-
 kernel/sched/rt.c        |    5 ++++-
 kernel/sched/sched.h     |    7 ++++---
 kernel/sched/stop_task.c |    5 ++++-
 kernel/sched/syscalls.c  |    9 ---------
 9 files changed, 47 insertions(+), 44 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2169,12 +2169,6 @@ inline int task_curr(const struct task_s
 	return cpu_curr(task_cpu(p)) == p;
 }
 
-void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio)
-{
-	if (oldprio != p->prio || dl_task(p))
-		p->sched_class->prio_changed(rq, p, oldprio);
-}
-
 void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct task_struct *donor = rq->donor;
@@ -7402,9 +7396,6 @@ void rt_mutex_setprio(struct task_struct
 		p->sched_class = next_class;
 		p->prio = prio;
 	}
-
-	if (!(queue_flag & DEQUEUE_CLASS))
-		check_prio_changed(rq, p, oldprio);
 out_unlock:
 	/* Avoid rq from going away on us: */
 	preempt_disable();
@@ -10860,6 +10851,13 @@ struct sched_change_ctx *sched_change_be
 		.running = task_current(rq, p),
 	};
 
+	if (!(flags & DEQUEUE_CLASS)) {
+		if (p->sched_class->get_prio)
+			ctx->prio = p->sched_class->get_prio(rq, p);
+		else
+			ctx->prio = p->prio;
+	}
+
 	if (ctx->queued)
 		dequeue_task(rq, p, flags);
 	if (ctx->running)
@@ -10886,6 +10884,10 @@ void sched_change_end(struct sched_chang
 	if (ctx->running)
 		set_next_task(rq, p);
 
-	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switched_to)
-		p->sched_class->switched_to(rq, p);
+	if (ctx->flags & ENQUEUE_CLASS) {
+		if (p->sched_class->switched_to)
+			p->sched_class->switched_to(rq, p);
+	} else {
+		p->sched_class->prio_changed(rq, p, ctx->prio);
+	}
 }
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3042,23 +3042,24 @@ static void switched_to_dl(struct rq *rq
 	}
 }
 
+static u64 get_prio_dl(struct rq *rq, struct task_struct *p)
+{
+	return p->dl.deadline;
+}
+
 /*
  * If the scheduling parameters of a -deadline task changed,
  * a push or pull operation might be needed.
  */
-static void prio_changed_dl(struct rq *rq, struct task_struct *p,
-			    int oldprio)
+static void prio_changed_dl(struct rq *rq, struct task_struct *p, u64 old_deadline)
 {
 	if (!task_on_rq_queued(p))
 		return;
 
-	/*
-	 * This might be too much, but unfortunately
-	 * we don't have the old deadline value, and
-	 * we can't argue if the task is increasing
-	 * or lowering its prio, so...
-	 */
-	if (!rq->dl.overloaded)
+	if (p->dl.deadline == old_deadline)
+		return;
+
+	if (dl_time_before(old_deadline, p->dl.deadline))
 		deadline_queue_pull_task(rq);
 
 	if (task_current_donor(rq, p)) {
@@ -3113,6 +3114,7 @@ DEFINE_SCHED_CLASS(dl) = {
 	.task_tick		= task_tick_dl,
 	.task_fork              = task_fork_dl,
 
+	.get_prio		= get_prio_dl,
 	.prio_changed           = prio_changed_dl,
 	.switched_from		= switched_from_dl,
 	.switched_to		= switched_to_dl,
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2961,7 +2961,7 @@ static void reweight_task_scx(struct rq
 				 p, p->scx.weight);
 }
 
-static void prio_changed_scx(struct rq *rq, struct task_struct *p, int oldprio)
+static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 }
 
@@ -3928,9 +3928,6 @@ static void scx_disable_workfn(struct kt
 			p->sched_class = new_class;
 		}
 
-		if (!(queue_flags & DEQUEUE_CLASS))
-			check_prio_changed(task_rq(p), p, p->prio);
-
 		scx_exit_task(p);
 	}
 	scx_task_iter_stop(&sti);
@@ -4679,9 +4676,6 @@ static int scx_enable(struct sched_ext_o
 			p->sched_class = new_class;
 		}
 
-		if (!(queue_flags & DEQUEUE_CLASS))
-			check_prio_changed(task_rq(p), p, p->prio);
-
 		put_task_struct(p);
 	}
 	scx_task_iter_stop(&sti);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13138,11 +13138,14 @@ static void task_fork_fair(struct task_s
  * the current task.
  */
 static void
-prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_fair(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 	if (!task_on_rq_queued(p))
 		return;
 
+	if (p->prio == oldprio)
+		return;
+
 	if (rq->cfs.nr_queued == 1)
 		return;
 
@@ -13154,8 +13157,9 @@ prio_changed_fair(struct rq *rq, struct
 	if (task_current_donor(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
-	} else
+	} else {
 		wakeup_preempt(rq, p, 0);
+	}
 }
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -504,8 +504,11 @@ static void switching_to_idle(struct rq
 }
 
 static void
-prio_changed_idle(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_idle(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
+	if (p->prio == oldprio)
+		return;
+
 	BUG();
 }
 
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2437,11 +2437,14 @@ static void switched_to_rt(struct rq *rq
  * us to initiate a push or pull.
  */
 static void
-prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
 	if (!task_on_rq_queued(p))
 		return;
 
+	if (p->prio == oldprio)
+		return;
+
 	if (task_current_donor(rq, p)) {
 		/*
 		 * If our priority decreases while running, we
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2451,8 +2451,10 @@ struct sched_class {
 
 	void (*reweight_task)(struct rq *this_rq, struct task_struct *task,
 			      const struct load_weight *lw);
+
+	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
 	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
-			      int oldprio);
+			      u64 oldprio);
 
 	unsigned int (*get_rr_interval)(struct rq *rq,
 					struct task_struct *task);
@@ -3877,12 +3879,11 @@ extern void set_load_weight(struct task_
 extern void enqueue_task(struct rq *rq, struct task_struct *p, int flags);
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
-extern void check_prio_changed(struct rq *rq, struct task_struct *p, int oldprio);
-
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
 
 struct sched_change_ctx {
+	u64			prio;
 	struct task_struct	*p;
 	int			flags;
 	bool			queued;
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -81,8 +81,11 @@ static void switching_to_stop(struct rq
 }
 
 static void
-prio_changed_stop(struct rq *rq, struct task_struct *p, int oldprio)
+prio_changed_stop(struct rq *rq, struct task_struct *p, u64 oldprio)
 {
+	if (p->prio == oldprio)
+		return;
+
 	BUG(); /* how!?, what priority? */
 }
 
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -95,12 +95,6 @@ void set_user_nice(struct task_struct *p
 		old_prio = p->prio;
 		p->prio = effective_prio(p);
 	}
-
-	/*
-	 * If the task increased its priority or is running and
-	 * lowered its priority, then reschedule its CPU:
-	 */
-	p->sched_class->prio_changed(rq, p, old_prio);
 }
 EXPORT_SYMBOL(set_user_nice);
 
@@ -708,9 +702,6 @@ int __sched_setscheduler(struct task_str
 		}
 	}
 
-	if (!(queue_flags & DEQUEUE_CLASS))
-		check_prio_changed(rq, p, oldprio);
-
 	/* Avoid rq from going away on us: */
 	preempt_disable();
 	head = splice_balance_callbacks(rq);



