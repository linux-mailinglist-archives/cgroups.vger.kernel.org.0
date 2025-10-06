Return-Path: <cgroups+bounces-10555-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E6BBDC10
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3BAF034AF0E
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C72426F2A7;
	Mon,  6 Oct 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gIxJnzUR"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A87026A0EB;
	Mon,  6 Oct 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747564; cv=none; b=oLF22OoLU3tUhDdQR8FFjRCbC+1e0VDJKjVeXBEpY6Q3hLy4+i6udZ/dKRRwHkhZh3zAnXIVrXcVcUm1uzs4sa5QFc2f91+QzFNquc1KaiBKuitcWEnYeGI5b/5DisAVb3n0q3OCmp+oVt/UaNTNSKcTLayq5vqP5nUO34NlBhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747564; c=relaxed/simple;
	bh=gTI742AaE0sWs/CFpbysRhf9OccN75qridDrxhx998o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JXOlpiJuob6Yx2b22t6V47vaPJLuI4uiL7FXGR/7WGTEllKSHfmPCSU7NxUikJ9GQ5aRk7tdqScrGAS8lT1Sc42/vgJkZ2jVDaGAVNsfpgc+hAaM8FfHVKX2d4Mu+1e9AO2qs+QISKo8jy+VPzr0iwMgdhU7Dz4rSyMwj+GjoQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gIxJnzUR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=s73925o8F4ztmgHRHrIqf3eXQDX1t2LjryoHd9LMTzQ=; b=gIxJnzURgvag+QCVNMyydUloom
	AIZ16CmLkc2+tTNLSDN8DUEiM9FrbHg7vOXi0KpEoMORL/3/0a99n5EYj5jbwPwoyJ05m+mbzyf+s
	qiIzu+VbjkYBy2HVV8Z7CEqZeGYuiVbBiRDlKZAoHY5+bo18TQ6s36SNGxB4nb5hSrdnLbC74qtZk
	1uA3JeuwnJ1SWnpKxXLikFKoXUGnjNWYCd/1lIuhp1jhTYTuVbUqXiMslpYYoKHMGT7Y5oSMp0A8u
	oaf6EM80PnNb9DhlzvVsk6L/PnHkUqxI/GPjPNjP88miVl91GS4DsYnGzLdcPcHktjpU2vIvZmEN7
	yWb+8QNA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iiz-0000000Grdr-0EgO;
	Mon, 06 Oct 2025 10:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D5158301A54; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.202601024@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:08 +0200
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
Subject: [PATCH 06/12] sched: Fix migrate_disable_switch() locking
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

For some reason migrate_disable_switch() was more complicated than it
needs to be, resulting in mind bending locking of dubious quality.

Recognise that migrate_disable_switch() must be called before a
context switch, but any place before that switch is equally good.
Since the current place results in troubled locking, simply move the
thing before taking rq->lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c |   27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2346,10 +2346,10 @@ static void migrate_disable_switch(struc
 	if (p->cpus_ptr != &p->cpus_mask)
 		return;
 
-	/*
-	 * Violates locking rules! See comment in __do_set_cpus_allowed().
-	 */
-	__do_set_cpus_allowed(p, &ac);
+	scoped_guard (task_rq_lock, p) {
+		update_rq_clock(scope.rq);
+		__do_set_cpus_allowed(p, &ac);
+	}
 }
 
 void ___migrate_enable(void)
@@ -2667,22 +2667,7 @@ __do_set_cpus_allowed(struct task_struct
 	struct rq *rq = task_rq(p);
 	bool queued, running;
 
-	/*
-	 * This here violates the locking rules for affinity, since we're only
-	 * supposed to change these variables while holding both rq->lock and
-	 * p->pi_lock.
-	 *
-	 * HOWEVER, it magically works, because ttwu() is the only code that
-	 * accesses these variables under p->pi_lock and only does so after
-	 * smp_cond_load_acquire(&p->on_cpu, !VAL), and we're in __schedule()
-	 * before finish_task().
-	 *
-	 * XXX do further audits, this smells like something putrid.
-	 */
-	if (ctx->flags & SCA_MIGRATE_DISABLE)
-		WARN_ON_ONCE(!p->on_cpu);
-	else
-		lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_held(&p->pi_lock);
 
 	queued = task_on_rq_queued(p);
 	running = task_current_donor(rq, p);
@@ -6781,6 +6766,7 @@ static void __sched notrace __schedule(i
 
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
+	migrate_disable_switch(rq, prev);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -6887,7 +6873,6 @@ static void __sched notrace __schedule(i
 		 */
 		++*switch_count;
 
-		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
 					     prev->se.sched_delayed);



