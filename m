Return-Path: <cgroups+bounces-10565-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CDFBBDD0D
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4CD3ABFE4
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55DD269AEE;
	Mon,  6 Oct 2025 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PvsGXnwS"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A772638B2;
	Mon,  6 Oct 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748232; cv=none; b=IJiST+WqlO82lMNIqLhCNbPCfavHxdCUB5qfv3A/kUp06Vw5V+4hussBzEPmuGEx48cUmn8GfGr1/YMsPTLWNjT2oJDYRJcvjo5y1Pm8qZlNRXweIX0nWgHFV5O8UQ8QN/7yaJ2Du9/qhvM3qH4tOtgwoR0/ZUZqCJkmOBhIelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748232; c=relaxed/simple;
	bh=S305arjsIN8bedo8fDXrbc1tCTzW1OktXvsWEmzEPRo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=q/erCwNIoaMK03fuE4XhPSOscLa1SQGDuGLxgDRVDcZRtSDt/pW97KntUqSjyR3LVPeToa1bKwRMsfq8kb4INk7WcJ7ZxRp3D87WqXD3EWLNXLMAzoY1OluKJGOu8WFVyRbNPheCC/q8ixF+YrvVNKuk8m5YfXfRoiUfgQalnHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PvsGXnwS; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=1C2VdFRZu2PsJI4zgJ4CUAg7pUvXeT6mj9c9BOfbZBQ=; b=PvsGXnwSuIuvPnhex3Fcy7SnW+
	iRDUvtDDc1k9vMiyAYa8SL3ltAqjpcx/oBoc0b8XoSEwgaREn3rxpCKo4uxERTUVsSWKus83P7QHf
	fJor25csZE8ktO0W4aUtL27yplW2gvkaUFwd8VS3kIwr6Y1ooiU4wE6RlIQ3K9hpboic/NRgWR5l2
	Uqumcy+6UvlqUzz+uXfrj1M+yye5KXGhOSSHdojEAz9HBU7EhgYZdvt+oj2wXylViSR5uDsW4IuET
	YAiTwiv0/JX1irYzOQjgjh2CQNx8DXwFSFnqq4f8+leaaO1Mx89YIFQQW1Aitmv7mWeP67G+1giOG
	74s6Alrw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ito-0000000GrzG-3bk5;
	Mon, 06 Oct 2025 10:57:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 677D0300462; Mon, 06 Oct 2025 12:57:00 +0200 (CEST)
Message-ID: <20251006105453.648473106@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:46:54 +0200
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
 tglx@linutronix.de,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [RFC][PATCH 2/3] sched: Add support to pick functions to take rf
References: <20251006104652.630431579@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Joel Fernandes <joelagnelf@nvidia.com>

Some pick functions like the internal pick_next_task_fair() already take
rf but some others dont. We need this for scx's server pick function.
Prepare for this by having pick functions accept it.

[peterz: - added RETRY_TASK handling
         - removed pick_next_task_fair indirection]
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
SubmissionLink: https://lkml.kernel.org/r/20250809184800.129831-6-joelagnelf@nvidia.com
---
 include/linux/sched.h    |    7 ++-----
 kernel/sched/core.c      |   35 ++++++++++++++++++++++++++---------
 kernel/sched/deadline.c  |    8 ++++----
 kernel/sched/ext.c       |    2 +-
 kernel/sched/fair.c      |   16 ++++++----------
 kernel/sched/idle.c      |    2 +-
 kernel/sched/rt.c        |    2 +-
 kernel/sched/sched.h     |   10 ++++++----
 kernel/sched/stop_task.c |    2 +-
 9 files changed, 48 insertions(+), 36 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -637,8 +637,8 @@ struct sched_rt_entity {
 #endif
 } __randomize_layout;
 
-typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
-typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+struct rq_flags;
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *, struct rq_flags *rf);
 
 struct sched_dl_entity {
 	struct rb_node			rb_node;
@@ -730,9 +730,6 @@ struct sched_dl_entity {
 	 * dl_server_update().
 	 *
 	 * @rq the runqueue this server is for
-	 *
-	 * @server_has_tasks() returns true if @server_pick return a
-	 * runnable task.
 	 */
 	struct rq			*rq;
 	dl_server_pick_f		server_pick_task;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5901,7 +5901,7 @@ __pick_next_task(struct rq *rq, struct t
 
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
-			p = pick_task_idle(rq);
+			p = pick_task_idle(rq, rf);
 			put_prev_set_next_task(rq, prev, p);
 		}
 
@@ -5913,11 +5913,15 @@ __pick_next_task(struct rq *rq, struct t
 
 	for_each_active_class(class) {
 		if (class->pick_next_task) {
-			p = class->pick_next_task(rq, prev);
+			p = class->pick_next_task(rq, prev, rf);
+			if (unlikely(p == RETRY_TASK))
+				goto restart;
 			if (p)
 				return p;
 		} else {
-			p = class->pick_task(rq);
+			p = class->pick_task(rq, rf);
+			if (unlikely(p == RETRY_TASK))
+				goto restart;
 			if (p) {
 				put_prev_set_next_task(rq, prev, p);
 				return p;
@@ -5947,7 +5951,11 @@ static inline bool cookie_match(struct t
 	return a->core_cookie == b->core_cookie;
 }
 
-static inline struct task_struct *pick_task(struct rq *rq)
+/*
+ * Careful; this can return RETRY_TASK, it does not include the retry-loop
+ * itself due to the whole SMT pick retry thing below.
+ */
+static inline struct task_struct *pick_task(struct rq *rq, struct rq_flags *rf)
 {
 	const struct sched_class *class;
 	struct task_struct *p;
@@ -5955,7 +5963,7 @@ static inline struct task_struct *pick_t
 	rq->dl_server = NULL;
 
 	for_each_active_class(class) {
-		p = class->pick_task(rq);
+		p = class->pick_task(rq, rf);
 		if (p)
 			return p;
 	}
@@ -5970,7 +5978,7 @@ static void queue_core_balance(struct rq
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
-	struct task_struct *next, *p, *max = NULL;
+	struct task_struct *next, *p, *max;
 	const struct cpumask *smt_mask;
 	bool fi_before = false;
 	bool core_clock_updated = (rq == rq->core);
@@ -6055,7 +6063,10 @@ pick_next_task(struct rq *rq, struct tas
 	 * and there are no cookied tasks running on siblings.
 	 */
 	if (!need_sync) {
-		next = pick_task(rq);
+restart_single:
+		next = pick_task(rq, rf);
+		if (unlikely(next == RETRY_TASK))
+			goto restart_single;
 		if (!next->core_cookie) {
 			rq->core_pick = NULL;
 			rq->core_dl_server = NULL;
@@ -6075,6 +6086,8 @@ pick_next_task(struct rq *rq, struct tas
 	 *
 	 * Tie-break prio towards the current CPU
 	 */
+restart_multi:
+	max = NULL;
 	for_each_cpu_wrap(i, smt_mask, cpu) {
 		rq_i = cpu_rq(i);
 
@@ -6086,7 +6099,11 @@ pick_next_task(struct rq *rq, struct tas
 		if (i != cpu && (rq_i != rq->core || !core_clock_updated))
 			update_rq_clock(rq_i);
 
-		rq_i->core_pick = p = pick_task(rq_i);
+		p = pick_task(rq_i, rf);
+		if (unlikely(p == RETRY_TASK))
+			goto restart_multi;
+
+		rq_i->core_pick = p;
 		rq_i->core_dl_server = rq_i->dl_server;
 
 		if (!max || prio_less(max, p, fi_before))
@@ -6108,7 +6125,7 @@ pick_next_task(struct rq *rq, struct tas
 			if (cookie)
 				p = sched_core_find(rq_i, cookie);
 			if (!p)
-				p = idle_sched_class.pick_task(rq_i);
+				p = idle_sched_class.pick_task(rq_i, rf);
 		}
 
 		rq_i->core_pick = p;
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2352,7 +2352,7 @@ static struct sched_dl_entity *pick_next
  * __pick_next_task_dl - Helper to pick the next -deadline task to run.
  * @rq: The runqueue to pick the next task from.
  */
-static struct task_struct *__pick_task_dl(struct rq *rq)
+static struct task_struct *__pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_dl_entity *dl_se;
 	struct dl_rq *dl_rq = &rq->dl;
@@ -2366,7 +2366,7 @@ static struct task_struct *__pick_task_d
 	WARN_ON_ONCE(!dl_se);
 
 	if (dl_server(dl_se)) {
-		p = dl_se->server_pick_task(dl_se);
+		p = dl_se->server_pick_task(dl_se, rf);
 		if (!p) {
 			dl_server_stop(dl_se);
 			goto again;
@@ -2379,9 +2379,9 @@ static struct task_struct *__pick_task_d
 	return p;
 }
 
-static struct task_struct *pick_task_dl(struct rq *rq)
+static struct task_struct *pick_task_dl(struct rq *rq, struct rq_flags *rf)
 {
-	return __pick_task_dl(rq);
+	return __pick_task_dl(rq, rf);
 }
 
 static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2332,7 +2332,7 @@ static struct task_struct *first_local_t
 					struct task_struct, scx.dsq_list.node);
 }
 
-static struct task_struct *pick_task_scx(struct rq *rq)
+static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev = rq->curr;
 	struct task_struct *p;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8822,7 +8822,7 @@ static void check_preempt_wakeup_fair(st
 	resched_curr_lazy(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq)
+static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
@@ -8866,7 +8866,7 @@ pick_next_task_fair(struct rq *rq, struc
 	int new_tasks;
 
 again:
-	p = pick_task_fair(rq);
+	p = pick_task_fair(rq, rf);
 	if (!p)
 		goto idle;
 	se = &p->se;
@@ -8945,14 +8945,10 @@ pick_next_task_fair(struct rq *rq, struc
 	return NULL;
 }
 
-static struct task_struct *__pick_next_task_fair(struct rq *rq, struct task_struct *prev)
+static struct task_struct *
+fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 {
-	return pick_next_task_fair(rq, prev, NULL);
-}
-
-static struct task_struct *fair_server_pick_task(struct sched_dl_entity *dl_se)
-{
-	return pick_task_fair(dl_se->rq);
+	return pick_task_fair(dl_se->rq, rf);
 }
 
 void fair_server_init(struct rq *rq)
@@ -13632,7 +13628,7 @@ DEFINE_SCHED_CLASS(fair) = {
 	.wakeup_preempt		= check_preempt_wakeup_fair,
 
 	.pick_task		= pick_task_fair,
-	.pick_next_task		= __pick_next_task_fair,
+	.pick_next_task		= pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -466,7 +466,7 @@ static void set_next_task_idle(struct rq
 	next->se.exec_start = rq_clock_task(rq);
 }
 
-struct task_struct *pick_task_idle(struct rq *rq)
+struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf)
 {
 	scx_update_idle(rq, true, false);
 	return rq->idle;
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1695,7 +1695,7 @@ static struct task_struct *_pick_next_ta
 	return rt_task_of(rt_se);
 }
 
-static struct task_struct *pick_task_rt(struct rq *rq)
+static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *p;
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2467,7 +2467,7 @@ struct sched_class {
 	/*
 	 * schedule/pick_next_task: rq->lock
 	 */
-	struct task_struct *(*pick_task)(struct rq *rq);
+	struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
 	/*
 	 * Optional! When implemented pick_next_task() should be equivalent to:
 	 *
@@ -2477,7 +2477,8 @@ struct sched_class {
 	 *       set_next_task_first(next);
 	 *   }
 	 */
-	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev);
+	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
+					      struct rq_flags *rf);
 
 	/*
 	 * sched_change:
@@ -2690,8 +2691,9 @@ static inline bool sched_fair_runnable(s
 	return rq->cfs.nr_queued > 0;
 }
 
-extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf);
-extern struct task_struct *pick_task_idle(struct rq *rq);
+extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev,
+					       struct rq_flags *rf);
+extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 
 #define SCA_CHECK		0x01
 #define SCA_MIGRATE_DISABLE	0x02
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -32,7 +32,7 @@ static void set_next_task_stop(struct rq
 	stop->se.exec_start = rq_clock_task(rq);
 }
 
-static struct task_struct *pick_task_stop(struct rq *rq)
+static struct task_struct *pick_task_stop(struct rq *rq, struct rq_flags *rf)
 {
 	if (!sched_stop_runnable(rq))
 		return NULL;



