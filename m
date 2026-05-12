Return-Path: <cgroups+bounces-15846-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKjGKTQLA2pmzwEAu9opvQ
	(envelope-from <cgroups+bounces-15846-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 13:12:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 111D751F224
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 13:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1E32303DAD7
	for <lists+cgroups@lfdr.de>; Tue, 12 May 2026 11:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF1B383998;
	Tue, 12 May 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K8Zk64+l"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8B395AC1;
	Tue, 12 May 2026 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778584207; cv=none; b=XfXHEDL3ckfYUYgcvh3Yoko0qaLyXk9XL7hMkZ9gDBFU/lwjMEZRVi/vy1AamFkFhrk4se8/SIjZQZZHvDVk7hEC7d3dUK36CQfEHWbID/2e8tZY52VDHBWMJrM/CC63UtoVgceUu4L6YTPTy4WlkfVWLRtgowr7EB6A/ww2WDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778584207; c=relaxed/simple;
	bh=3O4PQOtHj4J0uPPQ5xQqo41uzNuY+GUoVapukQZ6qKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTs4eYkO1w8YO+HrEQqHWgPlNqEw6CuvoqIM0LhgbLz+Cr36bB+iLqYSLzNni/Y1PV2aaBAJUqwXF8DZ5xKdHoJB4yrTIgNQBIiID0GtP69e3Vx/n6XFwjp8FZc8sv7/wc9P3qxkIkzUsa/HcZ3YAEGz96Aipvk8OiWZMqsXqv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K8Zk64+l; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZRZDhEWKxNs8eLw2VLzKVpXdb0a6fF1FWSQbLdsdFts=; b=K8Zk64+lu9JuNSxfdcfmmx9CXZ
	wJU33ZG37nV+8/i8NxqxtwQZRfvptWoVepSJhluPukuES2CmKpQhK7gloHdkrlOQt6nw26O4MRANe
	vQfuqzd//ggLg57jf3q6MSKyYcoiTihosO+PykEmkpKRR4a2n+E3X4oS/Z2GltGi9ss71PoUXevZL
	q9GbVlpvRmrxUu/H9LnyN6F06oyte20KgtrkMKKNMIkmIA7O8uqDGwf62f20it3iPsqaOKHJJ4+Ji
	Np+AdxGxkWdebNV7inT/sopMFYTNYOIeZl6CNDkK2SQVUX0g23PxaRxRmSGgJicFk/KsrWujACUJe
	qXz9LPKQ==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMkzW-0000000EUQs-0xOB;
	Tue, 12 May 2026 11:09:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 24FCC30075A; Tue, 12 May 2026 13:09:33 +0200 (CEST)
Date: Tue, 12 May 2026 13:09:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: mingo@kernel.org, longman@redhat.com, chenridong@huaweicloud.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org,
	hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, jstultz@google.com,
	qyousef@layalina.io
Subject: Re: [PATCH v2 10/10] sched/eevdf: Move to a single runqueue
Message-ID: <20260512110932.GB1889694@noisy.programming.kicks-ass.net>
References: <20260511113104.563854162@infradead.org>
 <20260511120628.206700041@infradead.org>
 <133c4d08-5dfb-4f4f-83cb-f9652d4212ef@amd.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133c4d08-5dfb-4f4f-83cb-f9652d4212ef@amd.com>
X-Rspamd-Queue-Id: 111D751F224
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15846-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,noisy.programming.kicks-ass.net:mid]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 09:51:57PM +0530, K Prateek Nayak wrote:
> Hello Peter,
> 
> On 5/11/2026 5:01 PM, Peter Zijlstra wrote:
> > @@ -9291,34 +9206,25 @@ static void wakeup_preempt_fair(struct r
> > +	se = pick_next_entity(rq, true);
> > +	if (!se)
> > +		goto again;
> >  
> >  	p = task_of(se);
> > -	if (unlikely(throttled))
> > +	if (unlikely(check_cfs_rq_runtime(cfs_rq_of(se))))
> >  		task_throttle_setup_work(p);
> 
> I think this bit should also be replicated in set_next_task() after
> account_cfs_rq_runtime() since any part of the hierarchy may get
> throttled as a result of failing to grab runtime.
> 
> Also check_cfs_rq_runtime() only sees if the cfs_rq is throttled
> but the task can fail to run if it is on a throttled_hierarchy() too
> so that should be the correct check here.
> 
> Something like below (only build tested on queue/sched/flat):
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index e54da4c6c945..950c072244b2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9224,7 +9224,19 @@ struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
>  		goto again;
>  
>  	p = task_of(se);
> -	if (unlikely(check_cfs_rq_runtime(cfs_rq_of(se))))
> +	/*
> +	 * For cases where prev is picked again after
> +	 * being throttled, entity_tick() would have
> +	 * already marked its hierarchy as throttled.
> +	 *
> +	 * Add throttle work here since
> +	 * put_prev_set_next_task() is skipped on
> +	 * same task's selection.
> +	 *
> +	 * For other case, set_next_task_fair() will
> +	 * handle adding the throttle work.
> +	 */
> +	if (throttled_hierarchy(cfs_rq_of(se)))
>  		task_throttle_setup_work(p);

Ah, right, because we've not accumulated runtime, it doesn't make sense
to use check_cfs_rq_runtime() at pick time, all we need to do is check
if the task should be throttled.

However, since set_next_task_fair() will walk the entire hierarchy
anyway, we can remove it here entirely and fully rely on that.

>  	return p;
>  
> @@ -13819,6 +13831,12 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>  		if (on_rq)
>  			weight = __calc_prop_weight(cfs_rq, se, weight);
>  	}
> +	/*
> +	 * Add throttle work if the bandwidth allocation above failed
> +	 * to grab any runtime and throttled the task's hierarchy.
> +	 */
> +	if (throttled_hierarchy(task_cfs_rq(p)))
> +		task_throttle_setup_work(p);

We already call into account_cfs_rq_runtime(); which basically does all
we need.

I think the distinction between account_cfs_rq_runtime() and
check_cfs_rq_runtime() no longer makes sense. We can throttle a cfs_rq
at any point now, since we no longer remove the cfs_rq, but rather we
make the tasks suspend themselves until the cfs_rq naturally dequeues
for being empty.

Something like so perhaps?

---
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -488,7 +488,7 @@ static int se_is_idle(struct sched_entit
 #endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 static __always_inline
-void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
+bool account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec);
 
 /**************************************************************
  * Scheduling class tree data structure manipulation methods:
@@ -1420,12 +1420,22 @@ static void update_curr(struct cfs_rq *c
 	}
 }
 
+static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
+static inline void task_throttle_setup_work(struct task_struct *p);
+
 static void update_curr_fair(struct rq *rq)
 {
 	struct sched_entity *se = &rq->donor->se;
+	bool throttled = false;
 
-	for_each_sched_entity(se)
-		update_curr(cfs_rq_of(se));
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+		update_curr(cfs_rq);
+		throttled |= cfs_rq_throttled(cfs_rq);
+	}
+
+	if (throttled)
+		task_throttle_setup_work(rq->donor);
 }
 
 static inline void
@@ -5627,7 +5637,6 @@ place_entity(struct cfs_rq *cfs_rq, stru
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
-static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
@@ -5830,8 +5839,6 @@ pick_next_entity(struct rq *rq, bool pro
 	return se;
 }
 
-static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
-
 static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 {
 	/*
@@ -5841,9 +5848,6 @@ static void put_prev_entity(struct cfs_r
 	if (prev->on_rq)
 		update_curr(cfs_rq);
 
-	/* throttle cfs_rqs exceeding runtime */
-	check_cfs_rq_runtime(cfs_rq);
-
 	if (prev->on_rq) {
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
@@ -5976,44 +5980,29 @@ static int __assign_cfs_rq_runtime(struc
 	return cfs_rq->runtime_remaining > 0;
 }
 
-/* returns 0 on failure to allocate runtime */
-static int assign_cfs_rq_runtime(struct cfs_rq *cfs_rq)
-{
-	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
-	int ret;
-
-	raw_spin_lock(&cfs_b->lock);
-	ret = __assign_cfs_rq_runtime(cfs_b, cfs_rq, sched_cfs_bandwidth_slice());
-	raw_spin_unlock(&cfs_b->lock);
-
-	return ret;
-}
+static bool throttle_cfs_rq(struct cfs_rq *cfs_rq);
 
-static void __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
+static bool __account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	/* dock delta_exec before expiring quota (as it could span periods) */
 	cfs_rq->runtime_remaining -= delta_exec;
 
 	if (likely(cfs_rq->runtime_remaining > 0))
-		return;
+		return false;
 
 	if (cfs_rq->throttled)
-		return;
-	/*
-	 * if we're unable to extend our runtime we resched so that the active
-	 * hierarchy can be throttled
-	 */
-	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->h_curr))
-		resched_curr(rq_of(cfs_rq));
+		return true;
+
+	return throttle_cfs_rq(cfs_rq);
 }
 
 static __always_inline
-void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
+bool account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec)
 {
 	if (!cfs_bandwidth_used() || !cfs_rq->runtime_enabled)
-		return;
+		return false;
 
-	__account_cfs_rq_runtime(cfs_rq, delta_exec);
+	return __account_cfs_rq_runtime(cfs_rq, delta_exec);
 }
 
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
@@ -6284,9 +6273,9 @@ static bool throttle_cfs_rq(struct cfs_r
 		 * We have raced with bandwidth becoming available, and if we
 		 * actually throttled the timer might not unthrottle us for an
 		 * entire period. We additionally needed to make sure that any
-		 * subsequent check_cfs_rq_runtime calls agree not to throttle
-		 * us, as we may commit to do cfs put_prev+pick_next, so we ask
-		 * for 1ns of runtime rather than just check cfs_b.
+		 * subsequent account_cfs_rq_runtime() calls agree not to
+		 * throttle us, as we may commit to do cfs put_prev+pick_next,
+		 * so we ask for 1ns of runtime rather than just check cfs_b.
 		 */
 		dequeue = 0;
 	} else {
@@ -6711,8 +6700,6 @@ static void check_enqueue_throttle(struc
 
 	/* update runtime allocation */
 	account_cfs_rq_runtime(cfs_rq, 0);
-	if (cfs_rq->runtime_remaining <= 0)
-		throttle_cfs_rq(cfs_rq);
 }
 
 static void sync_throttle(struct task_group *tg, int cpu)
@@ -6742,25 +6729,6 @@ static void sync_throttle(struct task_gr
 		cfs_rq->pelt_clock_throttled = 1;
 }
 
-/* conditionally throttle active cfs_rq's from put_prev_entity() */
-static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq)
-{
-	if (!cfs_bandwidth_used())
-		return false;
-
-	if (likely(!cfs_rq->runtime_enabled || cfs_rq->runtime_remaining > 0))
-		return false;
-
-	/*
-	 * it's possible for a throttled entity to be forced into a running
-	 * state (e.g. set_curr_task), in this case we're finished.
-	 */
-	if (cfs_rq_throttled(cfs_rq))
-		return true;
-
-	return throttle_cfs_rq(cfs_rq);
-}
-
 static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 {
 	struct cfs_bandwidth *cfs_b =
@@ -7015,8 +6983,7 @@ static void sched_fair_update_stop_tick(
 
 #else /* !CONFIG_CFS_BANDWIDTH: */
 
-static void account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) {}
-static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq) { return false; }
+static bool account_cfs_rq_runtime(struct cfs_rq *cfs_rq, u64 delta_exec) { return false; }
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq) {}
 static inline void sync_throttle(struct task_group *tg, int cpu) {}
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
@@ -9208,7 +9175,6 @@ struct task_struct *pick_task_fair(struc
 {
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
-	struct task_struct *p;
 	int new_tasks;
 
 again:
@@ -9223,10 +9189,7 @@ struct task_struct *pick_task_fair(struc
 	if (!se)
 		goto again;
 
-	p = task_of(se);
-	if (unlikely(check_cfs_rq_runtime(cfs_rq_of(se))))
-		task_throttle_setup_work(p);
-	return p;
+	return task_of(se);
 
 idle:
 	new_tasks = sched_balance_newidle(rq, rf);
@@ -13618,6 +13581,7 @@ static void task_tick_fair(struct rq *rq
 {
 	struct sched_entity *se = &curr->se;
 	unsigned long weight = NICE_0_LOAD;
+	bool throttled = false;
 	struct cfs_rq *cfs_rq;
 
 	for_each_sched_entity(se) {
@@ -13625,8 +13589,13 @@ static void task_tick_fair(struct rq *rq
 		entity_tick(cfs_rq, se, queued);
 
 		weight = __calc_prop_weight(cfs_rq, se, weight);
+
+		throttled |= cfs_rq_throttled(cfs_rq);
 	}
 
+	if (throttled)
+		task_throttle_setup_work(curr);
+
 	se = &curr->se;
 	reweight_eevdf(cfs_rq, se, weight, se->on_rq);
 
@@ -13800,6 +13769,7 @@ static void set_next_task_fair(struct rq
 	struct cfs_rq *cfs_rq = &rq->cfs;
 	unsigned long weight = NICE_0_LOAD;
 	bool on_rq = se->on_rq;
+	bool throttled = false;
 
 	clear_buddies(cfs_rq, se);
 
@@ -13814,12 +13784,15 @@ static void set_next_task_fair(struct rq
 			set_next_entity(cfs_rq, se);
 
 		/* ensure bandwidth has been allocated on our new cfs_rq */
-		account_cfs_rq_runtime(cfs_rq, 0);
+		throttled |= account_cfs_rq_runtime(cfs_rq, 0);
 
 		if (on_rq)
 			weight = __calc_prop_weight(cfs_rq, se, weight);
 	}
 
+	if (throttled)
+		task_throttle_setup_work(p);
+
 	se = &p->se;
 	cfs_rq->curr = se;
 


