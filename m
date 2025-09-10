Return-Path: <cgroups+bounces-9942-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CC4B51CD2
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22524A01DC6
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1791327A33;
	Wed, 10 Sep 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gSwRbE9B"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C69E334733;
	Wed, 10 Sep 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520045; cv=none; b=lUXAjEjVu8kKjRb+yaBdOL+OruwYUcsR/B178PsfTWUTvePfSf8hpEOB66s+gCA8xy9j1dqmVhdnrQxvB1w+mCvZPiIMPRLhL24mI4d8M2mAW+MqCAPiQjsTpESW80BxhK/Zf3pSOKhzsgG6fxv9l2f1uNu6YeD5jnP2Fct7vQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520045; c=relaxed/simple;
	bh=IUCkWQ6wGqZwAbUmhFozAUW9M10IVL1wf8pIxmTstes=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=qDu3yHbiJ1EodNoXVbMrNicmCUzclZYAo2Ft/2WQZhik7lQCJHPl78E36I6Dd4OzXP9ngiA0/HAZTeOnkgK39p8lT5WL6kfhaS1dJpMroZu59Q9nwTX8sYzOpvWB6AsisWEpM83EhVv5Zwpv9bUfPkKuG46W1pWTk6bIKA9GZJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gSwRbE9B; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=KROeO6ylt+iaOjtKwEutyUCejaZHIqUyNIxZI7cvLNw=; b=gSwRbE9BunXYI8CC6h6+QMoY7u
	umuBf1guLbuHCBol2ESKhgjJ2bwMdBSEHi28ojadQHCZOn/r4/9imVOD0jh/Q6bUPwaN2gqjn45ut
	mm5CiyfkwYJiJcCS+V1jBEtZzqeupc4vZ1w5WT+FxfiuDuH9CBqVIBBO71ydbbyTPJp0+U0yh2jde
	aJmFD6uXOJIrxTh7zPbPubFFCQ8ANYztNd99zm0u2vmcqgDWdI54QLFpuhZxT0X4avUTivNHb2A85
	hUALMCP310FoddZWfN8F2SC2SbJ2z3S6gPUL4A+o+q9/jm6TPxHEwCzOnaD3gmjzK6Hm5Cd2tH0UV
	xZdnpT+A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFG-00000005ufD-0UXk;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 86FD6302E5F; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155808.764084708@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:13 +0200
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
Subject: [PATCH 04/14] sched: Cleanup sched_delayed handling for class switches
References: <20250910154409.446470175@infradead.org>
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
---
 kernel/sched/core.c     |   12 ++++++++----
 kernel/sched/ext.c      |    6 ------
 kernel/sched/fair.c     |    7 +++++++
 kernel/sched/syscalls.c |    3 ---
 4 files changed, 15 insertions(+), 13 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7403,9 +7403,6 @@ void rt_mutex_setprio(struct task_struct
 		queue_flag &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 	}
 
-	if (prev_class != next_class && p->se.sched_delayed)
-		dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 	scoped_guard (sched_change, p, queue_flag) {
 		/*
 		 * Boosting condition are:
@@ -10879,8 +10876,15 @@ struct sched_change_ctx *sched_change_be
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
@@ -5011,9 +5011,6 @@ static void scx_disable_workfn(struct kt
 			queue_flags &= ~(DEQUEUE_SAVE | DEQUEUE_MOVE);
 		}
 
-		if (old_class != new_class && p->se.sched_delayed)
-			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED | DEQUEUE_NOCLOCK);
-
 		scoped_guard (sched_change, p, queue_flags) {
 			p->sched_class = new_class;
 		}
@@ -5764,9 +5761,6 @@ static int scx_enable(struct sched_ext_o
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
@@ -13221,6 +13221,12 @@ static void attach_task_cfs_rq(struct ta
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
@@ -13622,6 +13628,7 @@ DEFINE_SCHED_CLASS(fair) = {
 
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



