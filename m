Return-Path: <cgroups+bounces-10563-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10080BBDD04
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0564F1887E1D
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE412652A4;
	Mon,  6 Oct 2025 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="na8EOCfG"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB3825F994;
	Mon,  6 Oct 2025 10:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759748231; cv=none; b=m7uE2sX6p9PjTv0WjbK6Q73H4OcbI9v5yz+S5uL6paCP/1j6OhizcnNzZtW8UwS28FSgCHo+lBBEMa0o2gH5GaWRSDLtSopPcpVvqFTLa1y1y14A/zCvAtm6Mymxj9Z5+AxTpS1d43judpLohkHTZuGscCgetBiGqFU+chyR3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759748231; c=relaxed/simple;
	bh=hTkqjOUwssoqE9Y+21yNXjj6yOLQ8/pd/HIvKImwEHU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j696p2SEiRJ6L6vt3AirdZASueeFMZ/gv/a4TY3hhCBcyufBQUW9lSnXMVozEVyfweRZhL6X6VNLB1A0a79R/emxjw5CzCcaUF3FY9xByuCqRMZenN5ePZd5FFASE54gYXd62cNavFGKNDlEFHWd8bx5sHKVjpd8KzslTTUFuL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=na8EOCfG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=a4RFec0ECgHWZX4fjHNKOj05uJArohdi+KlynKwDsb0=; b=na8EOCfGmVDPEXvhOmvGK1S7DJ
	EvDFfxkqCBf56B7lzc+SQjpY//khIABWSJc1lAyshKmMWqPJEx0utlU20s6IYktpYAj6Isfx37qkK
	pye3YaFPlQQu7JI9icnnfgnR1C6L0v9lVDwCN/1v25VjdIIsgJYAcLkuGmIcJqFkUSCqAe8j1r/Z/
	kj8SCxgQ143Mq5K6QJyKb7g0Tfb0j9cZNaYilmVXndhoE35BSeqpBB+X6Owew1JdJN/nw7NyR8qYk
	mzSvsuuy2uJ7vb3DlisRUH5EhdDxlBxHvR5JLLF4wKBayRG8jkAsH1VGl3rP5Ch7uCrLhO/m6OkHF
	F/kYG8og==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5ito-0000000GrzF-3bnk;
	Mon, 06 Oct 2025 10:57:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 6339E30039F; Mon, 06 Oct 2025 12:57:00 +0200 (CEST)
Message-ID: <20251006105453.522934521@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:46:53 +0200
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
Subject: [RFC][PATCH 1/3] sched: Detect per-class runqueue changes
References: <20251006104652.630431579@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Have enqueue/dequeue set a per-class bit in rq->queue_mask. This then
enables easy tracking of which runqueues are modified over a
lock-break.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c      |    2 ++
 kernel/sched/deadline.c  |    2 ++
 kernel/sched/ext.c       |    2 ++
 kernel/sched/fair.c      |    7 +++++--
 kernel/sched/idle.c      |    2 ++
 kernel/sched/rt.c        |    2 ++
 kernel/sched/sched.h     |   10 ++++++++++
 kernel/sched/stop_task.c |    2 ++
 8 files changed, 27 insertions(+), 2 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2089,6 +2089,7 @@ void enqueue_task(struct rq *rq, struct
 	 */
 	uclamp_rq_inc(rq, p, flags);
 
+	rq->queue_mask |= p->sched_class->queue_mask;
 	p->sched_class->enqueue_task(rq, p, flags);
 
 	psi_enqueue(p, flags);
@@ -2121,6 +2122,7 @@ inline bool dequeue_task(struct rq *rq,
 	 * and mark the task ->sched_delayed.
 	 */
 	uclamp_rq_dec(rq, p);
+	rq->queue_mask |= p->sched_class->queue_mask;
 	return p->sched_class->dequeue_task(rq, p, flags);
 }
 
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3094,6 +3094,8 @@ static int task_is_throttled_dl(struct t
 
 DEFINE_SCHED_CLASS(dl) = {
 
+	.queue_mask		= 8,
+
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3234,6 +3234,8 @@ static void scx_cgroup_unlock(void) {}
  *   their current sched_class. Call them directly from sched core instead.
  */
 DEFINE_SCHED_CLASS(ext) = {
+	.queue_mask		= 1,
+
 	.enqueue_task		= enqueue_task_scx,
 	.dequeue_task		= dequeue_task_scx,
 	.yield_task		= yield_task_scx,
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12830,6 +12830,7 @@ static int sched_balance_newidle(struct
 	}
 	rcu_read_unlock();
 
+	this_rq->queue_mask = 0;
 	raw_spin_rq_unlock(this_rq);
 
 	t0 = sched_clock_cpu(this_cpu);
@@ -12887,8 +12888,8 @@ static int sched_balance_newidle(struct
 	if (this_rq->cfs.h_nr_queued && !pulled_task)
 		pulled_task = 1;
 
-	/* Is there a task of a high priority class? */
-	if (this_rq->nr_running != this_rq->cfs.h_nr_queued)
+	/* If a higher prio class was modified, restart the pick */
+	if (this_rq->queue_mask & ~((fair_sched_class.queue_mask << 1)-1))
 		pulled_task = -1;
 
 out:
@@ -13623,6 +13624,8 @@ static unsigned int get_rr_interval_fair
  */
 DEFINE_SCHED_CLASS(fair) = {
 
+	.queue_mask		= 2,
+
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -522,6 +522,8 @@ static void update_curr_idle(struct rq *
  */
 DEFINE_SCHED_CLASS(idle) = {
 
+	.queue_mask		= 0,
+
 	/* no enqueue/yield_task for idle tasks */
 
 	/* dequeue is not valid, we print a debug message there: */
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2571,6 +2571,8 @@ static int task_is_throttled_rt(struct t
 
 DEFINE_SCHED_CLASS(rt) = {
 
+	.queue_mask		= 4,
+
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1118,6 +1118,7 @@ struct rq {
 	/* runqueue lock: */
 	raw_spinlock_t		__lock;
 
+	unsigned int		queue_mask;
 	unsigned int		nr_running;
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int		nr_numa_running;
@@ -2414,6 +2415,15 @@ struct sched_class {
 #ifdef CONFIG_UCLAMP_TASK
 	int uclamp_enabled;
 #endif
+	/*
+	 * idle:  0
+	 * ext:   1
+	 * fair:  2
+	 * rt:    4
+	 * dl:    8
+	 * stop: 16
+	 */
+	unsigned int queue_mask;
 
 	/*
 	 * move_queued_task/activate_task/enqueue_task: rq->lock
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -99,6 +99,8 @@ static void update_curr_stop(struct rq *
  */
 DEFINE_SCHED_CLASS(stop) = {
 
+	.queue_mask		= 16,
+
 	.enqueue_task		= enqueue_task_stop,
 	.dequeue_task		= dequeue_task_stop,
 	.yield_task		= yield_task_stop,



