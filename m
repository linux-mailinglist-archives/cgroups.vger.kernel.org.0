Return-Path: <cgroups+bounces-15747-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NXoIFvIAWoRjwEAu9opvQ
	(envelope-from <cgroups+bounces-15747-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:15:23 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE16050D733
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43619307A885
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B41C382388;
	Mon, 11 May 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCv39yfZ"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A783806C1;
	Mon, 11 May 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501242; cv=none; b=VefU8gzKyFojQqFc2SzJGtAmLsFxo695SESYDKoOViL3RQVYLOZApxwLscpA9BoDRkqzZb0V997DvmGV2+k/j3qXrrXSeDg/mJuGjb9UELLzJZYYNNeODfmaU0fyHkG5CqbwvnpBpr0tSuU/vYZ8/dSnyREDOylxByPA8HcZkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501242; c=relaxed/simple;
	bh=ydNjD1b6VjzRmA/AvRTkngfGzc+2CDYKjvACvyQ/DUI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=jRp+u1klWE1NPcQuPBSCLdjl8RY70nNeN9m1Rfj6hktc8FV9jVahXEEVHCe5GY44YHzX7NHIonQkNsNlZMPmMc+ecmUZFsilQrWWPPrNirC3s1M8NfB+3AiM5Ex3s651pfGGWiIM2vGEX2Fao67NqWfLb8SxtOwzVUJ9QgZaxvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rCv39yfZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=QGTqD1eGQix9gKqNGYA+CLlyDJime6VdW+xYhMpi23A=; b=rCv39yfZaFJxOyTZwF0VZ0R/t6
	NVgSM4dLBhh57mxNtDhl9juee9JAoML/K7okg3tmfPG+XQXmqrcRj6WjrigANFiBDRJvOnWfHcOyp
	7XsQrfGRNOZHH3s31B4Az5JOUVNW31p8GEmUrykdpW6XmmlpQAxPv6Qr+L+D1MUAPyPUn7bHwQ745
	8NTVGVfjYGG4PpKJ5byH1vbY0lwsE9w6ni3iBbXKbPZWTcTT3vY6gqV2/i6D72KKOFspIACAbWn0f
	yV/6KRpocntyl8XHo0ENYxbqqu7n8mYe73v1P23xkdTMNew+68XfbAZuHVULBNxe76gE4fGqzVwoy
	tF5oa/vw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPa-000000088mU-16QE;
	Mon, 11 May 2026 12:07:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2E2063030CA; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120627.944705718@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:12 +0200
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
Subject: [PATCH v2 08/10] sched/fair: Add newidle balance to pick_task_fair()
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: DE16050D733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15747-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

With commit 50653216e4ff ("sched: Add support to pick functions to
take rf") removing the balance callback, the pick_task() callback is
in charge of newidle balancing.

This means pick_task_fair() should do so too. This hasn't been a
problem in practise because pick_next_task_fair() is used. However,
since we'll be removing that one shortly, make sure pick_next_task()
is up to scratch.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9215,16 +9215,18 @@ static void wakeup_preempt_fair(struct r
 }
 
 static struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
+	__must_hold(__rq_lockp(rq))
 {
 	struct sched_entity *se;
 	struct cfs_rq *cfs_rq;
 	struct task_struct *p;
 	bool throttled;
+	int new_tasks;
 
 again:
 	cfs_rq = &rq->cfs;
 	if (!cfs_rq->nr_queued)
-		return NULL;
+		goto idle;
 
 	throttled = false;
 
@@ -9245,6 +9247,14 @@ static struct task_struct *pick_task_fai
 	if (unlikely(throttled))
 		task_throttle_setup_work(p);
 	return p;
+
+idle:
+	new_tasks = sched_balance_newidle(rq, rf);
+	if (new_tasks < 0)
+		return RETRY_TASK;
+	if (new_tasks > 0)
+		goto again;
+	return NULL;
 }
 
 static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
@@ -9256,12 +9266,12 @@ pick_next_task_fair(struct rq *rq, struc
 {
 	struct sched_entity *se;
 	struct task_struct *p;
-	int new_tasks;
 
-again:
 	p = pick_task_fair(rq, rf);
+	if (unlikely(p == RETRY_TASK))
+		return p;
 	if (!p)
-		goto idle;
+		return p;
 	se = &p->se;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -9311,29 +9321,11 @@ pick_next_task_fair(struct rq *rq, struc
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 	put_prev_set_next_task(rq, prev, p);
 	return p;
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
 }
 
 static struct task_struct *
 fair_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+	__must_hold(__rq_lockp(dl_se->rq))
 {
 	return pick_task_fair(dl_se->rq, rf);
 }



