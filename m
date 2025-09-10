Return-Path: <cgroups+bounces-9933-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBE3B51CC5
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D94E7B5689
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 15:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B9334376;
	Wed, 10 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="huXY/J11"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894DE27FD76;
	Wed, 10 Sep 2025 16:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520042; cv=none; b=KysK0HYmI5lMu2bwVdyHqJk6VPk5q5A5gAu05Tjch5zUCSoyXsKx/baneNWu+ZL5zArARL5VQOoMDcm8fJGpEq+CzEMzM6QwAl/rIVFYCihnef/oGR4QB7kYymf4LAQteY+wtP6/P+NYtk3N1/YJxuSeNInzr1t7V5aXelZiJ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520042; c=relaxed/simple;
	bh=ez4YCv5vbah9NEmQRbnqaVJy8liiti6yFa2mJFPFaeQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GDg0rV94fRxzdhLpay3EXjL9xLKZH3jxzQnRYOvIQhGQpgyeb+6Ryq2WvEbcslr8gHdljK3bFwZBwyufX5qDd438HzD2U1CzGCeFvldThZYnE5wv+AStSkxHUUowz2/x4gW9jT2CK3qRk1nc1ieVoxuvUG/NNGf1Yo286F8Gquc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=huXY/J11; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=6HCkL6pDdwM+l3KCDVSNPOCM5Jj8sjUY/Qzwb+O256w=; b=huXY/J118POEIqYFDc1P50Gvwo
	OzR2l37ochnVBUh/hM1gCtQeLM2c1jlYaKW83a8UIzHQcBswLLcnH6rlgnfzWvAAncAvygSBeOElY
	G3B7u4QUWX4rBSTMM9iRd/5/5LCUgDXMgNcavFbdGBmouFibtIO0v6JPCShalqr2nQ+r3HDWwcLYR
	5nxNA6ZbfQPpozrNLoMXU0QYnszOvRi6sZLxlrMtDqIoh5hVWzt6x8QXPGSxTTuxTMf6KzjM7HwMH
	jkrcdCrvCAnKSqyLjKsKBHJHdx5uJASFWKv/wfOclWgKxwV08dNDmuw8gwd9vFjnbqvHG3yFdj3pE
	itv05B1w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFH-0000000BXpG-0TbN;
	Wed, 10 Sep 2025 16:00:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id A3FFF302F8A; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.571531402@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:20 +0200
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
Subject: [PATCH 11/14] sched: Add flags to {put_prev,set_next}_task() methods
References: <20250910154409.446470175@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |    4 ++--
 kernel/sched/deadline.c  |    6 ++++--
 kernel/sched/ext.c       |    4 ++--
 kernel/sched/fair.c      |    8 +++++---
 kernel/sched/idle.c      |    5 +++--
 kernel/sched/rt.c        |    6 ++++--
 kernel/sched/sched.h     |   18 ++++++++++--------
 kernel/sched/stop_task.c |    5 +++--
 8 files changed, 33 insertions(+), 23 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10857,7 +10857,7 @@ struct sched_change_ctx *sched_change_be
 	if (ctx->queued)
 		dequeue_task(rq, p, flags);
 	if (ctx->running)
-		put_prev_task(rq, p);
+		put_prev_task(rq, p, flags);
 
 	if ((flags & DEQUEUE_CLASS) && p->sched_class->switched_from)
 		p->sched_class->switched_from(rq, p);
@@ -10878,7 +10878,7 @@ void sched_change_end(struct sched_chang
 	if (ctx->queued)
 		enqueue_task(rq, p, ctx->flags | ENQUEUE_NOCLOCK);
 	if (ctx->running)
-		set_next_task(rq, p);
+		set_next_task(rq, p, ctx->flags);
 
 	if (ctx->flags & ENQUEUE_CLASS) {
 		if (p->sched_class->switched_to)
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2340,10 +2340,11 @@ static void start_hrtick_dl(struct rq *r
 }
 #endif /* !CONFIG_SCHED_HRTICK */
 
-static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
+static void set_next_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
 	struct dl_rq *dl_rq = &rq->dl;
+	bool first = flags & ENQUEUE_FIRST;
 
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_dl_rq(&p->dl))
@@ -2413,7 +2414,8 @@ static struct task_struct *pick_task_dl(
 	return __pick_task_dl(rq);
 }
 
-static void put_prev_task_dl(struct rq *rq, struct task_struct *p, struct task_struct *next)
+static void put_prev_task_dl(struct rq *rq, struct task_struct *p,
+			     struct task_struct *next, int flags)
 {
 	struct sched_dl_entity *dl_se = &p->dl;
 	struct dl_rq *dl_rq = &rq->dl;
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3243,7 +3243,7 @@ static void process_ddsp_deferred_locals
 	}
 }
 
-static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
+static void set_next_task_scx(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct scx_sched *sch = scx_root;
 
@@ -3346,7 +3346,7 @@ static void switch_class(struct rq *rq,
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
-			      struct task_struct *next)
+			      struct task_struct *next, int flags)
 {
 	struct scx_sched *sch = scx_root;
 	update_curr_scx(rq);
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8839,7 +8839,7 @@ static struct task_struct *pick_task_fai
 }
 
 static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
-static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, int flags);
 
 struct task_struct *
 pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
@@ -8955,7 +8955,8 @@ void fair_server_init(struct rq *rq)
 /*
  * Account for a descheduled task:
  */
-static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct task_struct *next)
+static void put_prev_task_fair(struct rq *rq, struct task_struct *prev,
+			       struct task_struct *next, int flags)
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
@@ -13286,9 +13287,10 @@ static void __set_next_task_fair(struct
  * This routine is mostly called to set cfs_rq->curr field when a task
  * migrates between groups/classes.
  */
-static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_entity *se = &p->se;
+	bool first = flags & ENQUEUE_FIRST;
 
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -452,13 +452,14 @@ static void wakeup_preempt_idle(struct r
 	resched_curr(rq);
 }
 
-static void put_prev_task_idle(struct rq *rq, struct task_struct *prev, struct task_struct *next)
+static void put_prev_task_idle(struct rq *rq, struct task_struct *prev,
+			       struct task_struct *next, int flags)
 {
 	dl_server_update_idle_time(rq, prev);
 	scx_update_idle(rq, false, true);
 }
 
-static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
+static void set_next_task_idle(struct rq *rq, struct task_struct *next, int flags)
 {
 	update_idle_core(rq);
 	scx_update_idle(rq, true, true);
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1636,10 +1636,11 @@ static void wakeup_preempt_rt(struct rq
 		check_preempt_equal_prio(rq, p);
 }
 
-static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
+static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 	struct rt_rq *rt_rq = &rq->rt;
+	bool first = flags & ENQUEUE_FIRST;
 
 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
@@ -1707,7 +1708,8 @@ static struct task_struct *pick_task_rt(
 	return p;
 }
 
-static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_struct *next)
+static void put_prev_task_rt(struct rq *rq, struct task_struct *p,
+			     struct task_struct *next, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
 	struct rt_rq *rt_rq = &rq->rt;
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2370,7 +2370,9 @@ extern const u32		sched_prio_to_wmult[40
 #define ENQUEUE_REPLENISH	0x00020000
 #define ENQUEUE_MIGRATED	0x00040000
 #define ENQUEUE_INITIAL		0x00080000
+
 #define ENQUEUE_RQ_SELECTED	0x00100000
+#define ENQUEUE_FIRST		0x00200000
 
 #define RETRY_TASK		((void *)-1UL)
 
@@ -2448,8 +2450,8 @@ struct sched_class {
 	 * sched_change:
 	 * __schedule: rq->lock
 	 */
-	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next);
-	void (*set_next_task)(struct rq *rq, struct task_struct *p, bool first);
+	void (*put_prev_task)(struct rq *rq, struct task_struct *p, struct task_struct *next, int flags);
+	void (*set_next_task)(struct rq *rq, struct task_struct *p, int flags);
 
 	/*
 	 * select_task_rq: p->pi_lock
@@ -2544,15 +2546,15 @@ struct sched_class {
 #endif
 };
 
-static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
+static inline void put_prev_task(struct rq *rq, struct task_struct *prev, int flags)
 {
 	WARN_ON_ONCE(rq->donor != prev);
-	prev->sched_class->put_prev_task(rq, prev, NULL);
+	prev->sched_class->put_prev_task(rq, prev, NULL, flags);
 }
 
-static inline void set_next_task(struct rq *rq, struct task_struct *next)
+static inline void set_next_task(struct rq *rq, struct task_struct *next, int flags)
 {
-	next->sched_class->set_next_task(rq, next, false);
+	next->sched_class->set_next_task(rq, next, flags);
 }
 
 static inline void
@@ -2576,8 +2578,8 @@ static inline void put_prev_set_next_tas
 	if (next == prev)
 		return;
 
-	prev->sched_class->put_prev_task(rq, prev, next);
-	next->sched_class->set_next_task(rq, next, true);
+	prev->sched_class->put_prev_task(rq, prev, next, 0);
+	next->sched_class->set_next_task(rq, next, ENQUEUE_FIRST);
 }
 
 /*
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -27,7 +27,7 @@ wakeup_preempt_stop(struct rq *rq, struc
 	/* we're never preempted */
 }
 
-static void set_next_task_stop(struct rq *rq, struct task_struct *stop, bool first)
+static void set_next_task_stop(struct rq *rq, struct task_struct *stop, int flags)
 {
 	stop->se.exec_start = rq_clock_task(rq);
 }
@@ -58,7 +58,8 @@ static void yield_task_stop(struct rq *r
 	BUG(); /* the stop task should never yield, its pointless. */
 }
 
-static void put_prev_task_stop(struct rq *rq, struct task_struct *prev, struct task_struct *next)
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev,
+			       struct task_struct *next, int flags)
 {
 	update_curr_common(rq);
 }



