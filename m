Return-Path: <cgroups+bounces-9939-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA29AB51CD3
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DEED7B0ED9
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3493376A3;
	Wed, 10 Sep 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lny8shyH"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91E1334375;
	Wed, 10 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520044; cv=none; b=udxh0w3vxvdPvq9wLKUnuHkrj4JF25mtird0FvkpF3/JEjowp5rdd7bpwobZ8k7CcpegnayTrBBpowrhZhpDPcxOxCLcVWi4KRV/R+5/FbHyVaHEQe2Mbhhb1x9kUbwwqklINGgu5KtLBD1ZW6slUIuzKoJol+CH/+qTQ7WFV1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520044; c=relaxed/simple;
	bh=PmRp8XW4Z8YyfaN/EKoesgC7XksetQTnuq0iyfQMVmw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Wu/SCMTANXaJ8j5pJwM7ps4UPz1qiC7ZqHKzGReOjWOsGcjxDQKQ/U2saUl0EPE3mH9chg+tbawlikPfioxpopcb8gtzNa/L6XFxTsTin2CofyxZTw1bLCxGipDUkLx9hzi5/stNxzwTKB8o7N4UxpKnuud23AarddZ7lCx/O14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lny8shyH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=8vR+1d+dAYzwiQmuRl68SeQrWl74OXubMqH95iJkoXk=; b=Lny8shyHL0DcOeja3lfUQs2MQA
	xKHpgltAtqn6wIN2VmQ44rsdFqQN0x3iuYk40rEom6xglktWMIB2SVsdnXbDEmXQZX88RAmojhG+c
	uC/s27iR+m0gvnosKCj6gZMp7UFd4VkChTynAZBPWus97VqMVKU8lHbpsVVCR9z+ob5RrPNHtTLYY
	ubhawpenIqJ3SfEpEk5BR+wfm1V7LbtIm4Bcc0XGkIoueBNj5Vw5TazqLMtB+LZsrOGxTVeGGqDIm
	JS8g50842bDWanV6OiH/ScGLpp05yiz+vUnPMnS42gwH8/LjWFukGokvC/Z43OlbY4zCH2JIYZFnm
	XMpVUWBg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFH-00000005ufO-0WGg;
	Wed, 10 Sep 2025 16:00:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id AC282302FFB; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.800554594@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
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
Subject: [PATCH 13/14] sched: Add {DE,EN}QUEUE_LOCKED
References: <20250910154409.446470175@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Provide a LOCKED queue flag, indicating that the {en,de}queue()
operation is in task_rq_lock() context.

Note: the sched_change in scx_bypass() is the only one that does not
use task_rq_lock(). If that were fixed, we could have sched_change
imply LOCKED.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c     |   31 +++++++++++++++++++++++++------
 kernel/sched/sched.h    |    7 +++++++
 kernel/sched/syscalls.c |    4 ++--
 3 files changed, 34 insertions(+), 8 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2716,7 +2716,7 @@ void set_cpus_allowed_common(struct task
 static void
 do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
-	u32 flags = DEQUEUE_SAVE | DEQUEUE_NOCLOCK;
+	u32 flags = DEQUEUE_SAVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
 
 	scoped_guard (sched_change, p, flags) {
 		p->sched_class->set_cpus_allowed(p, ctx);
@@ -3749,7 +3749,7 @@ static int ttwu_runnable(struct task_str
 	if (task_on_rq_queued(p)) {
 		update_rq_clock(rq);
 		if (p->se.sched_delayed)
-			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
+			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED | ENQUEUE_LOCKED);
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
@@ -4816,7 +4816,7 @@ void wake_up_new_task(struct task_struct
 	update_rq_clock(rq);
 	post_init_entity_util_avg(p);
 
-	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
+	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL | ENQUEUE_LOCKED);
 	trace_sched_wakeup_new(p);
 	wakeup_preempt(rq, p, wake_flags);
 	if (p->sched_class->task_woken) {
@@ -7310,7 +7310,7 @@ void rt_mutex_post_schedule(void)
 void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 {
 	int prio, oldprio, queue_flag =
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
 	const struct sched_class *prev_class, *next_class;
 	struct rq_flags rf;
 	struct rq *rq;
@@ -8056,7 +8056,7 @@ int migrate_task_to(struct task_struct *
 void sched_setnuma(struct task_struct *p, int nid)
 {
 	guard(task_rq_lock)(p);
-	scoped_guard (sched_change, p, DEQUEUE_SAVE)
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_LOCKED)
 		p->numa_preferred_nid = nid;
 }
 #endif /* CONFIG_NUMA_BALANCING */
@@ -9160,7 +9160,7 @@ static void sched_change_group(struct ta
 void sched_move_task(struct task_struct *tsk, bool for_autogroup)
 {
 	unsigned int queue_flags =
-		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
 	bool resched = false;
 	struct rq *rq;
 
@@ -10841,6 +10841,13 @@ struct sched_change_ctx *sched_change_be
 	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
+#ifdef CONFIG_PROVE_LOCKING
+	if (flags & DEQUEUE_LOCKED) {
+		lockdep_assert_held(&p->pi_lock);
+		if (p->srq_lock)
+			lockdep_assert_held(p->srq_lock);
+	}
+#endif
 
 	if (flags & DEQUEUE_CLASS) {
 		if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
@@ -10862,6 +10869,9 @@ struct sched_change_ctx *sched_change_be
 		.flags = flags,
 		.queued = task_on_rq_queued(p),
 		.running = task_current(rq, p),
+#ifdef CONFIG_PROVE_LOCKING
+		.srq_lock = p->srq_lock,
+#endif
 	};
 
 	if (!(flags & DEQUEUE_CLASS)) {
@@ -10888,6 +10898,15 @@ void sched_change_end(struct sched_chang
 	struct rq *rq = task_rq(p);
 
 	lockdep_assert_rq_held(rq);
+#ifdef CONFIG_PROVE_LOCKING
+	if (ctx->flags & ENQUEUE_LOCKED) {
+		lockdep_assert_held(&p->pi_lock);
+		if (p->srq_lock)
+			lockdep_assert_held(p->srq_lock);
+		if (ctx->srq_lock && ctx->srq_lock != p->srq_lock)
+			lockdep_assert_not_held(ctx->srq_lock);
+	}
+#endif
 
 	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
 		p->sched_class->switching_to(rq, p);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2340,6 +2340,8 @@ extern const u32		sched_prio_to_wmult[40
  * CLASS - going to update p->sched_class; makes sched_change call the
  *         various switch methods.
  *
+ * LOCKED - task_rq_lock() context, implies p->srq_lock taken when set.
+ *
  * ENQUEUE_HEAD      - place at front of runqueue (tail if not specified)
  * ENQUEUE_REPLENISH - CBS (replenish runtime and postpone deadline)
  * ENQUEUE_MIGRATED  - the task was migrated during wakeup
@@ -2355,6 +2357,7 @@ extern const u32		sched_prio_to_wmult[40
 #define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
 #define DEQUEUE_CLASS		0x0040 /* Matches ENQUEUE_CLASS */
+#define DEQUEUE_LOCKED		0x0080 /* Matches ENQUEUE_LOCKED */
 
 #define DEQUEUE_SPECIAL		0x00010000
 #define DEQUEUE_THROTTLE	0x00020000
@@ -2367,6 +2370,7 @@ extern const u32		sched_prio_to_wmult[40
 #define ENQUEUE_MIGRATING	0x0010
 #define ENQUEUE_DELAYED		0x0020
 #define ENQUEUE_CLASS		0x0040
+#define ENQUEUE_LOCKED		0x0080
 
 #define ENQUEUE_HEAD		0x00010000
 #define ENQUEUE_REPLENISH	0x00020000
@@ -3963,6 +3967,9 @@ extern void balance_callbacks(struct rq
 struct sched_change_ctx {
 	u64			prio;
 	struct task_struct	*p;
+#ifdef CONFIG_PROVE_LOCKING
+	raw_spinlock_t		*srq_lock;
+#endif
 	int			flags;
 	bool			queued;
 	bool			running;
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -89,7 +89,7 @@ void set_user_nice(struct task_struct *p
 		return;
 	}
 
-	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK) {
+	scoped_guard (sched_change, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		set_load_weight(p, true);
 		old_prio = p->prio;
@@ -503,7 +503,7 @@ int __sched_setscheduler(struct task_str
 	struct balance_callback *head;
 	struct rq_flags rf;
 	int reset_on_fork;
-	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
+	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK | DEQUEUE_LOCKED;
 	struct rq *rq;
 	bool cpuset_locked = false;
 



