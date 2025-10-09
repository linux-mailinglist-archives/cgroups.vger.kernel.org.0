Return-Path: <cgroups+bounces-10618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072D8BC9712
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD28420076
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8492EA170;
	Thu,  9 Oct 2025 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nAXgoFtI"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9E2459F3;
	Thu,  9 Oct 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760018989; cv=none; b=U0uRqSshhajsHXDSlKB3n6PMTYMb1TXUD7F4l/OZ08ASpotuNeze7ux23GnYtoHxcrC0dqRXijBcYIJKytIHm+ZT4V7cl4eKFHXkbZ0BF98Yv5g0EP1NfnfdtQcnBzeYf5IEei+tN0Nqg5osZZTBwd1zcLsHRV042JK4Nrc0UHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760018989; c=relaxed/simple;
	bh=tDJS4NRxkFnQkEwxcMTkDM1sNOfGQ40YA+cT0EfHN1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChZNtNWaLWot4OpX66Q0h0JpQJquQI1MeHPIhnf6Tx6bX10xFOqH/cAs3f1WWyURwvszUU2EgK8NNZ8grcro8UDMeKXhKiv1M4fL9HtPYv9RAXEibFPTiWoBHco42f4q7yNO5Cys+ewxC/bcQo4cF0IE8YEmFGl0JRgvIWF7yqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nAXgoFtI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ieBvCbBheNPFtBxoISVqmiEkRKqIWXh/v+HP5ZowhjI=; b=nAXgoFtIs28drwEauJTWwJGMeN
	R0382zPEDZu8KViUA23YGsIcqITo7rULbxEHggZb8TyUIJlbdiEuFkfBrBCdqb9kr9cC0tnmoisYt
	tlJpmN+kuzbwUrs3AhlYo0yAUF1RAuEC1/Mo4tbe06lTGX3puqiIglGdZOAQU/EVATkJzyyqfGs6W
	J1Nun6SJdCTW9mEqQpiIb7wEpdiDMCJ0Uus1ASFS3lg5jEAswzuAVbc/5mNbqQIeWKUPKFhiN94GG
	UhaxTi6qdVfzD0Yf9YL8tJoC0ZzLrNF5mhYcQel1+gwpwTy0sKAOCoYMaPri4zW1cbdP5jlxeu2Yq
	jk741fVA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6rKg-00000001Ubm-3AbJ;
	Thu, 09 Oct 2025 14:09:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1BDB300399; Thu, 09 Oct 2025 16:09:25 +0200 (CEST)
Date: Thu, 9 Oct 2025 16:09:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, longman@redhat.com, hannes@cmpxchg.org,
	mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de
Subject: Re: [PATCH 03/12] sched: Fold
 sched_class::switch{ing,ed}_{to,from}() into the change pattern
Message-ID: <20251009140925.GD4068168@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104526.861755244@infradead.org>
 <02452879-8998-47e0-9679-d2ff00503901@arm.com>
 <20251009135408.GD4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009135408.GD4067720@noisy.programming.kicks-ass.net>

On Thu, Oct 09, 2025 at 03:54:08PM +0200, Peter Zijlstra wrote:
> On Thu, Oct 09, 2025 at 03:30:02PM +0200, Dietmar Eggemann wrote:
> > On 06.10.25 12:44, Peter Zijlstra wrote:
> > > Add {DE,EN}QUEUE_CLASS and fold the sched_class::switch* methods into
> > > the change pattern. This completes and makes the pattern more
> > > symmetric.
> > > 
> > > This changes the order of callbacks slightly:
> > > 
> > > 				|
> > > 				|  switching_from()
> > >   dequeue_task();		|  dequeue_task()
> > >   put_prev_task();		|  put_prev_task()
> > > 				|  switched_from()
> > > 				|
> > >   ... change task ...		|  ... change task ...
> > > 				|
> > >   switching_to();		|  switching_to()
> > >   enqueue_task();		|  enqueue_task()
> > >   set_next_task();		|  set_next_task()
> > >   prev_class->switched_from()	|
> > >   switched_to()			|  switched_to()
> > > 				|
> > > 
> > > Notably, it moves the switched_from() callback right after the
> > > dequeue/put. Existing implementations don't appear to be affected by
> > > this change in location -- specifically the task isn't enqueued on the
> > > class in question in either location.
> > > 
> > > Make (CLASS)^(SAVE|MOVE), because there is nothing to save-restore
> > > when changing scheduling classes.
> > 
> > This one causes a DL bw related warning when I run a simple 1 DL task
> > rt-app workload:
> 
> > Not sure yet how this is related to switched_from_dl() being now called earlier?
> 
> Ooh, I might see a problem. task_non_contending() uses dl_task(), which
> uses p->prio. The move above means it is now called using the 'old'
> prio, whereas it used to run with the 'new' prio.
> 
> Let me see if I can figure out something for this.

Does this help? /me goes find rt-app.

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 615411a0a881..fe2272c812b2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -405,7 +405,7 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
  * up, and checks if the task is still in the "ACTIVE non contending"
  * state or not (in the second case, it updates running_bw).
  */
-static void task_non_contending(struct sched_dl_entity *dl_se)
+static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_task)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
 	struct rq *rq = rq_of_dl_se(dl_se);
@@ -444,10 +444,10 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
 		} else {
 			struct task_struct *p = dl_task_of(dl_se);
 
-			if (dl_task(p))
+			if (dl_task)
 				sub_running_bw(dl_se, dl_rq);
 
-			if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
+			if (!dl_task || READ_ONCE(p->__state) == TASK_DEAD) {
 				struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
 				if (READ_ONCE(p->__state) == TASK_DEAD)
@@ -2045,7 +2045,7 @@ static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	 * or "inactive")
 	 */
 	if (flags & DEQUEUE_SLEEP)
-		task_non_contending(dl_se);
+		task_non_contending(dl_se, true);
 }
 
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
@@ -2970,7 +2970,7 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	 * will reset the task parameters.
 	 */
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
-		task_non_contending(&p->dl);
+		task_non_contending(&p->dl, false);
 
 	/*
 	 * In case a task is setscheduled out from SCHED_DEADLINE we need to

