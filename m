Return-Path: <cgroups+bounces-13207-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D469FD1EF5B
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 14:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCE5F3016379
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 13:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF4A39341C;
	Wed, 14 Jan 2026 13:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/ygW/6q"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE3734A771;
	Wed, 14 Jan 2026 13:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768395944; cv=none; b=azHTbtoD1+/sCajS/wNcP8FXZNNafGh8qJflTlyNbrCWRSWqgVwitPVAJ6Va9Uo4hB+XmlRmsxDsnJOouTtvCFkH+zXoD++RB5nkGF/6i/+fpBK5OXFUUg3TvMgHF9XL6Kymzk2CNN5apwexZYSG/YRLlJj9Z5KqaMvUU+Q7+bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768395944; c=relaxed/simple;
	bh=OJT3kacMzD2i6MS4DmnGuRnuZ6eSPXs9y0PjMS89Z78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsrgME6Ydz10520SxwXWRjyHqgEVkzCkqkZA/snUiwvv3gMHJyxwMxSwlkg3/REtJ8jdK44mX1ReKnwRq4Fgk1/RkO3R0e3164Rt3DmGaxJYqZ6topM4ZK2BScnZ7LG+y12ST/1OCUNuvpWMqT1yHR5NJrczY6yo7juwv4rBkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m/ygW/6q; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tODLtdiGSKxK0kWbMHcLOtgbmEBKlanOhIhkHxE5FDc=; b=m/ygW/6qXK3p3ZPoZWlpWAYJNJ
	ri8f0a0iQJ0ogZxPiLOMjPj7l437QDFFiF/BEf9Kk6f8ZpgoE5G7eWW8myGH28lPV3BG6HqEAdgkC
	AL7znhxOfq9QXqjoUgJ5N+5pVzxcuvCNuUqmLRNxlI3xMszT031x23avbnbYCIH1XtriwqAZ811e8
	H00pagAdsiIVhw5LzV4QVUABG98BVBIb579C9bJ4mpgnIFFSZYrR4JYZTSobKotdBD6/S9XVseRSD
	No0w/pWyjY76AfHKJBwZKI0Nqc2sHhSad2L8AP8Aw5faTwSvinawJEHuC5LjS5HRdF5zUtFsWP+a2
	Yem+P5/A==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vg0Z0-00000004sey-2WUq;
	Wed, 14 Jan 2026 13:05:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C53803005AA; Wed, 14 Jan 2026 14:05:28 +0100 (CET)
Date: Wed, 14 Jan 2026 14:05:28 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>, tj@kernel.org,
	linux-kernel@vger.kernel.org, mingo@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com, cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev, liuwenfang@honor.com, tglx@linutronix.de,
	Christian Loehle <christian.loehle@arm.com>,
	luca.abeni@santannapisa.it
Subject: Re: [PATCH 05/12] sched: Move sched_class::prio_changed() into the
 change pattern
Message-ID: <20260114130528.GB831285@noisy.programming.kicks-ass.net>
References: <20251006104402.946760805@infradead.org>
 <20251006104527.083607521@infradead.org>
 <ab9b37c9-e826-44db-a6b8-a789fcc1582d@arm.com>
 <caa2329c-d985-4a7c-b83a-c4f96d5f154a@amd.com>
 <717a0743-6d8f-4e35-8f2f-70a158b31147@arm.com>
 <20260113114718.GA831050@noisy.programming.kicks-ass.net>
 <f9e4e4a2-dadd-4f79-a83e-48ac4663f91c@amd.com>
 <20260114102336.GZ830755@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114102336.GZ830755@noisy.programming.kicks-ass.net>

On Wed, Jan 14, 2026 at 11:23:36AM +0100, Peter Zijlstra wrote:

> Juri, Luca, I'm tempted to suggest to simply remove the replenish on
> RESTORE entirely -- that would allow the task to continue as it had
> been, irrespective of it being 'late'.
> 
> Something like so -- what would this break?
> 
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2214,10 +2214,6 @@ enqueue_dl_entity(struct sched_dl_entity
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> -	} else if ((flags & ENQUEUE_RESTORE) &&
> -		   !is_dl_boosted(dl_se) &&
> -		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
> -		setup_new_dl_entity(dl_se);
>  	}
>  
>  	/*

Ah, this is de-boost, right? Boosting allows one to break the CBS rules
and then we have to rein in the excesses.

But we have {DE,EN}QUEUE_MOVE for this, that explicitly allows priority
to change and is set for rt_mutex_setprio() (among others).

So doing s/RESTORE/MOVE/ above.

The corollary to all this is that everybody that sets MOVE must be able
to deal with balance callbacks, so audit that too.

This then gives something like so.. which builds and boots for me, but
clearly I haven't been able to trigger these funny cases.

---
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4969,9 +4969,13 @@ struct balance_callback *splice_balance_
 	return __splice_balance_callbacks(rq, true);
 }
 
-static void __balance_callbacks(struct rq *rq)
+void __balance_callbacks(struct rq *rq, struct rq_flags *rf)
 {
+	if (rf)
+		rq_unpin_lock(rq, rf);
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
+	if (rf)
+		rq_repin_lock(rq, rf);
 }
 
 void balance_callbacks(struct rq *rq, struct balance_callback *head)
@@ -5018,7 +5022,7 @@ static inline void finish_lock_switch(st
 	 * prev into current:
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
-	__balance_callbacks(rq);
+	__balance_callbacks(rq, NULL);
 	raw_spin_rq_unlock_irq(rq);
 }
 
@@ -6901,7 +6905,7 @@ static void __sched notrace __schedule(i
 			proxy_tag_curr(rq, next);
 
 		rq_unpin_lock(rq, &rf);
-		__balance_callbacks(rq);
+		__balance_callbacks(rq, NULL);
 		raw_spin_rq_unlock_irq(rq);
 	}
 	trace_sched_exit_tp(is_switch);
@@ -7350,7 +7354,7 @@ void rt_mutex_setprio(struct task_struct
 	trace_sched_pi_setprio(p, pi_task);
 	oldprio = p->prio;
 
-	if (oldprio == prio)
+	if (oldprio == prio && !dl_prio(prio))
 		queue_flag &= ~DEQUEUE_MOVE;
 
 	prev_class = p->sched_class;
@@ -7396,9 +7400,7 @@ void rt_mutex_setprio(struct task_struct
 out_unlock:
 	/* Caller holds task_struct::pi_lock, IRQs are still disabled */
 
-	rq_unpin_lock(rq, &rf);
-	__balance_callbacks(rq);
-	rq_repin_lock(rq, &rf);
+	__balance_callbacks(rq, &rf);
 	__task_rq_unlock(rq, p, &rf);
 }
 #endif /* CONFIG_RT_MUTEXES */
@@ -9167,6 +9169,8 @@ void sched_move_task(struct task_struct
 
 	if (resched)
 		resched_curr(rq);
+
+	__balance_callbacks(rq, &rq_guard.rf);
 }
 
 static struct cgroup_subsys_state *
@@ -10891,6 +10895,9 @@ void sched_change_end(struct sched_chang
 				resched_curr(rq);
 		}
 	} else {
+		/*
+		 * XXX validate prio only really changed when ENQUEUE_MOVE is set.
+		 */
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2214,9 +2214,14 @@ enqueue_dl_entity(struct sched_dl_entity
 		update_dl_entity(dl_se);
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
-	} else if ((flags & ENQUEUE_RESTORE) &&
+	} else if ((flags & ENQUEUE_MOVE) &&
 		   !is_dl_boosted(dl_se) &&
 		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
+		/*
+		 * Deals with the de-boost case, and ENQUEUE_MOVE explicitly
+		 * allows us to change priority. Callers are expected to deal
+		 * with balance_callbacks.
+		 */
 		setup_new_dl_entity(dl_se);
 	}
 
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -545,6 +545,7 @@ static void scx_task_iter_start(struct s
 static void __scx_task_iter_rq_unlock(struct scx_task_iter *iter)
 {
 	if (iter->locked_task) {
+		__balance_callbacks(iter->rq, &iter->rf);
 		task_rq_unlock(iter->rq, iter->locked_task, &iter->rf);
 		iter->locked_task = NULL;
 	}
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2430,7 +2430,8 @@ extern const u32		sched_prio_to_wmult[40
  *                should preserve as much state as possible.
  *
  * MOVE - paired with SAVE/RESTORE, explicitly does not preserve the location
- *        in the runqueue.
+ *        in the runqueue. IOW the priority is allowed to change. Callers
+ *        must expect to deal with balance callbacks.
  *
  * NOCLOCK - skip the update_rq_clock() (avoids double updates)
  *
@@ -4019,6 +4020,8 @@ extern void enqueue_task(struct rq *rq,
 extern bool dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
 extern struct balance_callback *splice_balance_callbacks(struct rq *rq);
+
+extern void __balance_callbacks(struct rq *rq, struct rq_flags *rf);
 extern void balance_callbacks(struct rq *rq, struct balance_callback *head);
 
 /*
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -639,7 +639,7 @@ int __sched_setscheduler(struct task_str
 		 * itself.
 		 */
 		newprio = rt_effective_prio(p, newprio);
-		if (newprio == oldprio)
+		if (newprio == oldprio && !dl_prio(newprio))
 			queue_flags &= ~DEQUEUE_MOVE;
 	}
 

