Return-Path: <cgroups+bounces-9940-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29EB51CD8
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F276F7B8FC8
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A601338F30;
	Wed, 10 Sep 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YwZX65ms"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C06334391;
	Wed, 10 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520045; cv=none; b=FuIl/LWWip2U3NhwoECOsRbupV7YO9ENXjKr+wMWjPVzljpQQheVKU7SunQRI+G5V9roqKQGlikpoHgzlOGzIjAz34vsPi02G+lgR5VpiLZJOClfbQTE1r25GFnnvV5UsWGkY2e6t7qLLXRJWum9uH4nKRVqWkVsofu67m2450U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520045; c=relaxed/simple;
	bh=osnhLCq+rTGvUo4rO5z2cPoV6pOR2BCW5uwsZ2PrbYA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DXGpRhUILtNau3vyZ3rHpl1f14krcYgvWnJ2VYRL5oTSoMu6eqUdOABGXWYLBxEl6CleD1xV2KJfIWr0aZqseSnoU+d/LxckuF4vFOM/odxo0Mllg9UsTA+nDTqsP4ZlMRZLyLEyLcsAdyo3H1sUSxJ/sNs/7n8ObcdKIVJuOpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YwZX65ms; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=8oEWYSUZB/IIQUVHNUsQ2fhwwdqwSyCfZUQ3TS6Le5k=; b=YwZX65msD5IAoXkZTZqvRa0pGe
	7gP3nWoFZwrxdUjsyg/YU9YsyTGCpoUQntPR1n+3jJE6D4os92PLnGuqmldHYTJ9j7pE4fikDhhEA
	MYIAgLEzne8ay+9JOKtDxx09knIqiyRQyezJvIHHGT780Ir4RWbh4xdoL5xR5Li7UlC8+b1lIvrGA
	vXjFvoCD8OQ00lN4hX4pRUNQ5RyQIy/PzFD8CMn5uIgIeIdZWL6xnwRFTbfZGPoZU5iDCZZcEyH73
	E5pcz280dFI5QvwJ8NYB74NEVvIPYhKmSQ2Rs7KwG2uxYm5wx7WhWy70engR5IhfwEeNPoXMQifCC
	0jB36nEg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFG-00000005ufG-37qb;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 8FDCB302F12; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155808.987080375@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:15 +0200
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
Subject: [PATCH 06/14] sched: Fix migrate_disable_switch() locking
References: <20250910154409.446470175@infradead.org>
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
@@ -2344,10 +2344,10 @@ static void migrate_disable_switch(struc
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
 
 void migrate_disable(void)
@@ -2702,22 +2702,7 @@ __do_set_cpus_allowed(struct task_struct
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
@@ -6816,6 +6801,7 @@ static void __sched notrace __schedule(i
 
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
+	migrate_disable_switch(rq, prev);
 
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -6922,7 +6908,6 @@ static void __sched notrace __schedule(i
 		 */
 		++*switch_count;
 
-		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
 					     prev->se.sched_delayed);



