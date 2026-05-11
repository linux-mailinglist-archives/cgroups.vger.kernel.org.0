Return-Path: <cgroups+bounces-15750-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBtULgLIAWoRjwEAu9opvQ
	(envelope-from <cgroups+bounces-15750-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:13:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B1A50D6D2
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3507307EA2E
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B5A39E19C;
	Mon, 11 May 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dHPYRult"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD35837AA7E;
	Mon, 11 May 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501243; cv=none; b=miTLnF2oPAanF/0pLug4uW08/4t91j1o+JIbj+PuDL9pgx3AWYyePSjWh+AEab4EpJTEaCl/TdDXHyWsd9ngOCPtUa0cxxnBHAgSSKPqTEGnr2eNBO4xI6jJyLm7iIhWVUTpP7MPqWj4LyrvwQTMRReqGdtVjJoK01IfXLLSVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501243; c=relaxed/simple;
	bh=hxLQPb3dZmxgpnnb5eMMN5QzCDrXRzIkJMRiqBnHDRU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Vy/5dULV0EU+BmC73JcRYK/eTFbLkbGk+iZ7xqG2sN3PIWS3zW2nZGfzMFiH/K7qW1h7EEH53kTOjP2+rU3meRo3hgamV/YUQ+LsZDOZsKzNl0W1k35As8HkZkkCzaV8KU/6C4ec+L4IxQaYiogzOlQOQRS8fDmCyrtiPUG8Pe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dHPYRult; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=S0mi3ejVRKZtD/+6BvinHRssu4pdxxO2hzy61vpyyO8=; b=dHPYRultxTY3aIYkyfLKk1lH23
	rfSK6/lCjY4HHaLv0apiYL3YvMtnUubcD7lpbLbwh1j5pI/KmfkLfhiawbNNA5EYH/BfHbRT1Ha/R
	qoNVzko2sn0xh287gdeS1sM+ozRI5J6YHpfjvNtXv3QeqP+kqLO2XgEqg7Ic/3lIAprw2Q1FgziSr
	nH2LzCqpB3fPC4m8pTPLuymfp/tydtXaqh5Mx8k13vfI9k6QF4y4VjxafEBTeysfturHb9N/jFnZB
	dB11EXagVAbivdgILQrUismejpF3XL0qIVd4r31vjDoRScT4/QAbOcBKXQhL4C5v9k1nN1Qfk3QRZ
	X5vHzrfA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPa-0000000BZMq-04y4;
	Mon, 11 May 2026 12:07:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 325DC3030E7; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120628.057634261@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:13 +0200
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
 kprateek.nayak@amd.com,
 qyousef@layalina.io
Subject: [PATCH v2 09/10] sched: Remove sched_class::pick_next_task()
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 18B1A50D6D2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15750-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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
 kernel/sched/fair.c  |  139 +++++++++++++++++----------------------------------
 kernel/sched/sched.h |   14 -----
 3 files changed, 57 insertions(+), 123 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5980,16 +5980,15 @@ __pick_next_task(struct rq *rq, struct t
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
 
@@ -5997,20 +5996,12 @@ __pick_next_task(struct rq *rq, struct t
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
@@ -9214,7 +9214,7 @@ static void wakeup_preempt_fair(struct r
 	resched_curr_lazy(rq);
 }
 
-static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
+struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 	__must_hold(__rq_lockp(rq))
 {
 	struct sched_entity *se;
@@ -9257,72 +9257,6 @@ static struct task_struct *pick_task_fai
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
-
-	p = pick_task_fair(rq, rf);
-	if (unlikely(p == RETRY_TASK))
-		return p;
-	if (!p)
-		return p;
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
-}
-
 static struct task_struct *
 fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 	__must_hold(__rq_lockp(dl_se->rq))
@@ -9346,10 +9280,33 @@ static void put_prev_task_fair(struct rq
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
+
+			int d = nse->depth - se->depth;
+			if (d >= 0) {
+				/* nse has equal or greater depth, ascend */
+				nse = parent_entity(nse);
+				/* if nse is the deeper, do not ascend se */
+				if (d > 0)
+					continue;
+			}
+		}
+#endif
+		se = parent_entity(se);
 	}
 }
 
@@ -13896,10 +13853,30 @@ static void switched_to_fair(struct rq *
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
+		set_next_entity(cfs_rq, se, first);
+		/* ensure bandwidth has been allocated on our new cfs_rq */
+		account_cfs_rq_runtime(cfs_rq, 0);
+	}
+
+	se = &p->se;
+
 	if (task_on_rq_queued(p)) {
 		/*
 		 * Move the next running task to the front of the list, so our
@@ -13919,27 +13896,6 @@ static void __set_next_task_fair(struct
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
@@ -14251,7 +14207,6 @@ DEFINE_SCHED_CLASS(fair) = {
 	.wakeup_preempt		= wakeup_preempt_fair,
 
 	.pick_task		= pick_task_fair,
-	.pick_next_task		= pick_next_task_fair,
 	.put_prev_task		= put_prev_task_fair,
 	.set_next_task          = set_next_task_fair,
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2555,17 +2555,6 @@ struct sched_class {
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
@@ -2789,8 +2778,7 @@ static inline bool sched_fair_runnable(s
 	return rq->cfs.nr_queued > 0;
 }
 
-extern struct task_struct *pick_next_task_fair(struct rq *rq, struct task_struct *prev,
-					       struct rq_flags *rf);
+extern struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf);
 extern struct task_struct *pick_task_idle(struct rq *rq, struct rq_flags *rf);
 
 #define SCA_CHECK		0x01



