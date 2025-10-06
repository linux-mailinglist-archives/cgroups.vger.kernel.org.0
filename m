Return-Path: <cgroups+bounces-10554-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2294BBDC01
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C13C3BB315
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0554126C399;
	Mon,  6 Oct 2025 10:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D6EvLUAm"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF752627FC;
	Mon,  6 Oct 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747562; cv=none; b=WoGM0x3Q38NqXE9fT5sMdL/FIfnvhQtQGJMKCzKuduip3HOHdD2iLI65zsKA295dCDHU6UEv94/CwnbcpNuCp8uRSPaFDbuLDjJT6AECENYqpux0xGktiIeymfg5JhCjv5FWa2UmIeaGed+VWodvMys15Zcx2H5PJIktha9wr3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747562; c=relaxed/simple;
	bh=c9xoIob1d4Dr2GfYVz5Rit2g6x6od88j4KsW99vCxOI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=f6mY3yqT5uOJtJq7B+Jd40zjo/69JZeewK8z4LGZzlPnEGXSexvoP4y5bolLA7w+JtdPm7w96mlBKtx8r1Id81/8DXV0YbNqVdcPis25I12wvSQaWAsz/W92cT1S+4u0+x2IsG1d+BSPncO7ic/94+taxgzJYrVLvv8T+wKNrGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D6EvLUAm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=BgD2e8jwOUPdYSAJVBJ3I9+RfPG0RYrESbEwPiGDcBM=; b=D6EvLUAmY4DbKVsAczPiazAJ9v
	psS8akrf1uI3rZrGQwRls/RtJebAjfO8UJJaJWSdrXxX2Kv6+HRbwcICxHyx5IBaMyNuCEjMH8W6h
	UlFqvQSKQFHRNXVlWsT6fKP2agBhBqtGPP6R3V/9dqYlwAl79QPUOq3znO2fl8G+1vRDCEcLu+snV
	WCDuDz0mXWIDqMbozNhtyYjea1irX/nFtJhIscs5DppyqgQj59jUh+n/ipiQJxjyl8CTf5FHahWDU
	LkcoTZJ0ovj/Jdc6zhl004j8c4FQI4gYOfcSLdvl+SxbWyrKqge4iJGrprrV8Rln/YOsJcT7dmMea
	YrqGPGgQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iix-00000009yaz-0RHa;
	Mon, 06 Oct 2025 10:45:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id CC577300754; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104526.964100769@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:06 +0200
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
Subject: [PATCH 04/12] sched: Cleanup sched_delayed handling for class switches
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Use the new sched_class::switching_from() method to dequeue delayed
tasks before switching to another class.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c     |   12 ++++++++----
 kernel/sched/ext.c      |    6 ------
 kernel/sched/fair.c     |    7 +++++++
 kernel/sched/syscalls.c |    3 ---
 4 files changed, 15 insertions(+), 13 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7368,9 +7368,6 @@ void rt_mutex_setprio(struct task_struct
 		queue_flag &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 	}
 
-	if (prev_class != next_class && p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 	scoped_guard (sched_change, p, queue_flag) {
 		/*
 		 * Boosting condition are:
@@ -10845,8 +10842,15 @@ struct sched_change_ctx *sched_change_be
 		if (WARN_ON_ONCE(flags & (DEQUEUE_SAVE | DEQUEUE_MOVE)))
 			flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 
-		if (p->sched_class->switching_from)
+		if (p->sched_class->switching_from) {
+			/*
+			 * switching_from_fair() assumes CLASS implies NOCLOCK;
+			 * fixing this assumption would mean switching_from()
+			 * would need to be able to change flags.
+			 */
+			WARN_ON(!(flags & DEQUEUE_NOCLOCK));
 			p->sched_class->switching_from(rq, p);
+		}
 	}
 
 	*ctx = (struct sched_change_ctx){
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3924,9 +3924,6 @@ static void scx_disable_workfn(struct kt
 			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 		}
 
-		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class = new_class;
 		}
@@ -4677,9 +4674,6 @@ static int scx_enable(struct sched_ext_o
 			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 		}
 
-		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 		scoped_guard (sched_change, p, queue_flags) {
 			p->scx.slice = SCX_SLICE_DFL;
 			p->sched_class = new_class;
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13237,6 +13237,12 @@ static void attach_task_cfs_rq(struct ta
 	attach_entity_cfs_rq(se);
 }
 
+static void switching_from_fair(struct rq *rq, struct task_struct *p)
+{
+	if (p->se.sched_delayed)
+		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
+}
+
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
@@ -13638,6 +13644,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
 	.reweight_task		= reweight_task_fair,
 	.prio_changed		= prio_changed_fair,
+	.switching_from		= switching_from_fair,
 	.switched_from		= switched_from_fair,
 	.switched_to		= switched_to_fair,
 
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -689,9 +689,6 @@ int __sched_setscheduler(struct task_str
 		queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 	}
 
-	if (prev_class != next_class && p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 	scoped_guard (sched_change, p, queue_flags) {
 
 		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {



