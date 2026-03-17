Return-Path: <cgroups+bounces-14837-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIqBAlMyuWnsuQEAu9opvQ
	(envelope-from <cgroups+bounces-14837-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:52:03 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4982A8483
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ED77302D946
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F70372B5F;
	Tue, 17 Mar 2026 10:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cu1np/3E"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94962365A1C;
	Tue, 17 Mar 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744469; cv=none; b=Z4mF3BpqCgEjTagdjVU60GNsjnGHouEH2iY21cDQC1LetNVr8hYSGObOvByM0EtT90P4t5ANGKKy94kuv5t2BlVXA8oOuRc/8MpALRbLyt58w5zJYWHinsAqQv5gvizTrPdZpObZfCJCNPCkxHtQV1xy5U86usfNGeKzO22cjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744469; c=relaxed/simple;
	bh=dqCcAXFRNfuoGgrf+WlIR8eJDUCDHGl7msCw3V+8qhY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HLTNO2dEDuKGEU+Y1VR+uadqDAxLm5FP87S10kdJnzmVCfK6Yg3a3LlDgYB81pSNfXT5PsjLS5CCga2OvCXH+MyOIgZXiLMGO4IhYnc2Y2tvysQ/8CwdbhDfYWIqSbOlshsl9ujkcP+MUcQZ3XLGuR824s5VkPIJb8Fj4V4W5bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cu1np/3E; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=MUmdy1hmWZji1oYBTrFsPfb5N9nygfW8f4vys4PyEfk=; b=cu1np/3EZEVETHsWafF27pp1ER
	dil3HSl72/YGi6ycGQBiEUNoTpvkQrrwj2doz7m9JGnvcqMbHWhaUBbLyIBqQwyRyylb+d9SyVtr9
	u6/Dk5r31YHTGuNKbVruXiz08GvSnwSLZLWt9doLHHvtmg9cIwMZ81MM47mJ94Z9fnP6quDuIB8lU
	B7+xylUdEZQ3vD13tQLyxmcwBOHX0GALWPu1ZFZgChxUt6Dldw6iivsQHyDw527ztIM5XOk5V64qs
	r7ETeAuWm/WM54i51AI5pC7O7EeW7hScz2+g50OtVLYNEexalgQQncuJyG9kZOoMT99qllOAamKvV
	hfeJiVog==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxZ-00000008kbw-0ZFl;
	Tue, 17 Mar 2026 10:47:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3423D3032FC; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104343.225156112@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org
Cc: longman@redhat.com,
 chenridong@huaweicloud.com,
 peterz@infradead.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 tj@kernel.org,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 jstultz@google.com,
 kprateek.nayak@amd.com
Subject: [RFC][PATCH 7/8] sched: Remove sched_class::pick_next_task()
References: <20260317095113.387450089@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14837-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:email,infradead.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E4982A8483
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The reason for pick_next_task_fair() is the put/set optimization that
avoids touching the common ancestors. However, it is possible to
implement this in the put_prev_task() and set_next_task() calls as
used in put_prev_set_next_task().

Notably, put_prev_set_next_task() is the only site that:

 - calls put_prev_task() with a .next argument;
 - calls set_next_task() with .first = true.

This means that put_prev_task() can determine the common hierarchy and
stop there, and then set_next_task() can terminate where put_prev_task
stopped.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  |   27 +++------
 kernel/sched/fair.c  |  153 ++++++++++++++-------------------------------------
 kernel/sched/sched.h |   14 ----
 3 files changed, 52 insertions(+), 142 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5924,16 +5924,15 @@ __pick_next_task(struct rq *rq, struct t
 	if (likely(!sched_class_above(prev->sched_class, &fair_sched_class) &&
 		   rq->nr_running == rq->cfs.h_nr_queued)) {
 
-		p = pick_next_task_fair(rq, prev, rf);
+		p = pick_task_fair(rq, rf);
 		if (unlikely(p == RETRY_TASK))
 			goto restart;
 
 		/* Assume the next prioritized class is idle_sched_class */
-		if (!p) {
+		if (!p)
 			p = pick_task_idle(rq, rf);
-			put_prev_set_next_task(rq, prev, p);
-		}
 
+		put_prev_set_next_task(rq, prev, p);
 		return p;
 	}
 
@@ -5941,20 +5940,12 @@ __pick_next_task(struct rq *rq, struct t
 	prev_balance(rq, prev, rf);
 
 	for_each_active_class(class) {
-		if (class->pick_next_task) {
-			p = class->pick_next_task(rq, prev, rf);
-			if (unlikely(p == RETRY_TASK))
-				goto restart;
-			if (p)
-				return p;
-		} else {
-			p = class->pick_task(rq, rf);
-			if (unlikely(p == RETRY_TASK))
-				goto restart;
-			if (p) {
-				put_prev_set_next_task(rq, prev, p);
-				return p;
-			}
+		p = class->pick_task(rq, rf);
+		if (unlikely(p == RETRY_TASK))
+			goto restart;
+		if (p) {
+			put_prev_set_next_task(rq, prev, p);
+			return p;
 		}
 	}
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8891,7 +8891,7 @@ static void wakeup_preempt_fair(struct r
 	resched_curr_lazy(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
+struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 	__must_hold(__rq_lockp(rq))
 {
 	struct sched_entity *se;
@@ -8934,91 +8934,6 @@ static struct task_struct *pick_task_fai
 	return NULL;
 }
 
-static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
-static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
-
-struct task_struct *
-pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
-	__must_hold(__rq_lockp(rq))
-{
-	struct sched_entity *se;
-	struct task_struct *p;
-	int new_tasks;
-
-again:
-	p = pick_task_fair(rq, rf);
-	if (!p)
-		goto idle;
-	se = &p->se;
-
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	if (prev->sched_class != &fair_sched_class)
-		goto simple;
-
-	__put_prev_set_next_dl_server(rq, prev, p);
-
-	/*
-	 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
-	 * likely that a next task is from the same cgroup as the current.
-	 *
-	 * Therefore attempt to avoid putting and setting the entire cgroup
-	 * hierarchy, only change the part that actually changes.
-	 *
-	 * Since we haven't yet done put_prev_entity and if the selected task
-	 * is a different task than we started out with, try and touch the
-	 * least amount of cfs_rqs.
-	 */
-	if (prev != p) {
-		struct sched_entity *pse = &prev->se;
-		struct cfs_rq *cfs_rq;
-
-		while (!(cfs_rq = is_same_group(se, pse))) {
-			int se_depth = se->depth;
-			int pse_depth = pse->depth;
-
-			if (se_depth <= pse_depth) {
-				put_prev_entity(cfs_rq_of(pse), pse);
-				pse = parent_entity(pse);
-			}
-			if (se_depth >= pse_depth) {
-				set_next_entity(cfs_rq_of(se), se, true);
-				se = parent_entity(se);
-			}
-		}
-
-		put_prev_entity(cfs_rq, pse);
-		set_next_entity(cfs_rq, se, true);
-
-		__set_next_task_fair(rq, p, true);
-	}
-
-	return p;
-
-simple:
-#endif /* CONFIG_FAIR_GROUP_SCHED */
-	put_prev_set_next_task(rq, prev, p);
-	return p;
-
-idle:
-	if (rf) {
-		new_tasks = sched_balance_newidle(rq, rf);
-
-		/*
-		 * Because sched_balance_newidle() releases (and re-acquires)
-		 * rq->lock, it is possible for any higher priority task to
-		 * appear. In that case we must re-start the pick_next_entity()
-		 * loop.
-		 */
-		if (new_tasks < 0)
-			return RETRY_TASK;
-
-		if (new_tasks > 0)
-			goto again;
-	}
-
-	return NULL;
-}
-
 static struct task_struct *
 fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 	__must_hold(__rq_lockp(dl_se->rq))
@@ -9042,10 +8957,28 @@ static void put_prev_task_fair(struct rq
 {
 	struct sched_entity *se = &prev->se;
 	struct cfs_rq *cfs_rq;
+	struct sched_entity *nse = NULL;
 
-	for_each_sched_entity(se) {
+#ifdef CONFIG_FAIR_GROUP_SCHED
+	if (next && next->sched_class == &fair_sched_class)
+		nse = &next->se;
+#endif
+
+	while (se) {
 		cfs_rq = cfs_rq_of(se);
-		put_prev_entity(cfs_rq, se);
+		if (!nse || cfs_rq->curr)
+			put_prev_entity(cfs_rq, se);
+#ifdef CONFIG_FAIR_GROUP_SCHED
+		if (nse) {
+			if (is_same_group(se, nse))
+				break;
+			if (nse->depth >= se->depth)
+				nse = parent_entity(nse);
+			if (nse->depth > se->depth)
+				continue;
+		}
+#endif
+		se = parent_entity(se);
 	}
 }
 
@@ -13566,10 +13499,30 @@ static void switched_to_fair(struct rq *
 	}
 }
 
-static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
+/*
+ * Account for a task changing its policy or group.
+ *
+ * This routine is mostly called to set cfs_rq->curr field when a task
+ * migrates between groups/classes.
+ */
+static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
 
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		if (IS_ENABLED(CONFIG_FAIR_GROUP_SCHED) &&
+		    first && cfs_rq->curr)
+			break;
+
+		set_next_entity(cfs_rq, se, true);
+		/* ensure bandwidth has been allocated on our new cfs_rq */
+		account_cfs_rq_runtime(cfs_rq, 0);
+	}
+
+	se = &p->se;
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * Move the next running task to the front of the list, so our
@@ -13589,27 +13542,6 @@ static void __set_next_task_fair(struct
 	sched_fair_update_stop_tick(rq, p);
 }
 
-/*
- * Account for a task changing its policy or group.
- *
- * This routine is mostly called to set cfs_rq->curr field when a task
- * migrates between groups/classes.
- */
-static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
-{
-	struct sched_entity *se = &p->se;
-
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
-		set_next_entity(cfs_rq, se, first);
-		/* ensure bandwidth has been allocated on our new cfs_rq */
-		account_cfs_rq_runtime(cfs_rq, 0);
-	}
-
-	__set_next_task_fair(rq, p, first);
-}
-
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
@@ -13921,7 +13853,6 @@ DEFINE_SCHED_CLASS(fair) = {
 	.wakeup_preempt		= wakeup_preempt_fair,
 
 	.pick_task		= pick_task_fair,
-	.pick_next_task		= pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2538,17 +2538,6 @@ struct sched_class {
 	 * schedule/pick_next_task: rq->lock
 	 */
 	struct task_struct *(*pick_task)(struct rq *rq, struct rq_flags *rf);
-	/*
-	 * Optional! When implemented pick_next_task() should be equivalent to:
-	 *
-	 *   next = pick_task();
-	 *   if (next) {
-	 *       put_prev_task(prev);
-	 *       set_next_task_first(next);
-	 *   }
-	 */
-	struct task_struct *(*pick_next_task)(struct rq *rq, struct task_struct *prev,
-					      struct rq_flags *rf);
 
 	/*
 	 * sched_change:
@@ -2761,8 +2750,7 @@ static inline bool sched_fair_runnable(s
 	return rq->cfs.nr_queued > 0;
 }
 
-extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev,
-					       struct rq_flags *rf);
+extern struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf);
 extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 
 #define SCA_CHECK		0x01



