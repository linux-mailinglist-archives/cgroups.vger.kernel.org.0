Return-Path: <cgroups+bounces-14845-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEoiMnoxuWnsuQEAu9opvQ
	(envelope-from <cgroups+bounces-14845-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 918162A83C1
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A1E0302D19D
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6995D3A7F4A;
	Tue, 17 Mar 2026 10:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m2+t5n/t"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10618369239;
	Tue, 17 Mar 2026 10:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744471; cv=none; b=pG5GepvEAgfTpb5H7AUwmw5YYtXj9cNnuKKos4ekyjv8OYTPFAzDHH+E9/5UkWql2CCzQccF8nWVVgqgWgaiJMl5TjdD58i0D6T2A8z4u4Ztp1QsKoltQeG0b5Q2P4RBb2tQhFVMdhSCAYhRGYwkiWggxo775ce0di0Uf86+osc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744471; c=relaxed/simple;
	bh=7P25UE6S8RoXqmag/PCnKjbsN5mal1/08o0Z1efP1F4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Tenv7hts9HD92xPkXcfbpbl6ldoUVXURarThuR0COsXiQ9cwanFFQjmERtY4VVw1XkuZZRD0aZmzkBNy42ko5E7tgM4uAG10Z0bmwC9u0qgkT5/2pL6rC3ws7m8K13jG8U5blK4KsIFiF9CaFEp8HHnz0MAvyZAVqV4S+nms0z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m2+t5n/t; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=PPU88KCYcFvenIxKTUc2FVGZlR/VTRyGBt2Hgt29noI=; b=m2+t5n/tJZsXK/SLfTFVgADkgN
	wlKmKhau0LEfjv5hK+sGeY8KO0lunsFAYMAEA/6ihx9AF/dSUrXJv4jhVDuGskN9FFd/DGMz7+qyh
	R2s6iiux7TqfnLlknHDn5ND+F1WJTMUH1qigCYc9WRzWYGO2AFWOBXy7sf3emqz8YGahWcDPyn8r1
	Clo9mwp4pS+1/qe+8sIStDwWn0aDAQP/ZSu9xhfNsx2YobMVR4GZ+qCEX5SOxDSCnSF3DCsWYEpsu
	iwsHrs1rKZlHXgzvnEA/pJOxhICM83NSbLo3PjqzMxDDXuY6yUiZeG6RlFUD+UFZXIOF1sXPO9xkt
	CaEZJcig==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxZ-00000008kbx-06Ob;
	Tue, 17 Mar 2026 10:47:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 38C363032FE; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104343.338573840@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:21 +0100
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
Subject: [RFC][PATCH 8/8] sched/eevdf: Move to a single runqueue
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=desiato.20200630];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14845-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:dkim,infradead.org:email,infradead.org:mid]
X-Rspamd-Queue-Id: 918162A83C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Change fair/cgroup to a single runqueue.

Infamously fair/cgroup isn't working for a number of people; typically
the complaint is latencies and/or overhead. The latency issue is due
to the intermediate entries that represent a combination of tasks and
thereby obfuscate the runnability of tasks.

The approach here is to leave the cgroup hierarchy as is; including
the intermediate enqueue/dequeue but move the actual EEVDF runqueue
outside. This means things like the shares_weight approximation are
fully preserved.

That is, given a hierarchy like:

        R
        |
        se--G1
            / \
      G2--se   se--G3
     / \           |
T1--se se--T2      se--T3

This is fully maintained for load tracking, however the EEVDF parts of
cfs_rq/se go unused for the intermediates and are instead connected
like:

     _R_
    / | \
   T1 T2 T3

Since the effective weight of the entities is determined by the
hierarchy, this gets recomputed on enqueue,set_next_task and tick.

Notably, the effective weight (se->h_load) is computed from the
hierarchical fraction: se->load / cfs_rq->load.

Since EEVDF is now exclusive operating on rq->cfs, it needs to
consider cfs_rq->h_nr_queued rather than cfs_rq->nr_queued. Similarly,
only tasks can get delayed, simplifying some of the cgroup cleanup.

One place where additional information was required was
set_next_task() / put_prev_task(), where we need to track 'current'
both in the hierarchical sense (cfs_rq->h_curr) and in the flat sense
(cfs_rq->curr).

As a result of only having a single level to pick from, much of the
complications in pick_next_task() and preemption go away.

Since many of the hierarchical operations are still there, this won't
immediately fix the performance issues, but hopefully it will fix some
of the latency issues.

TODO: split struct cfs_rq / struct sched_entity
TODO: try and get rid of h_curr

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h |    1 
 kernel/sched/debug.c  |    7 
 kernel/sched/fair.c   |  795 +++++++++++++++++++++-----------------------------
 kernel/sched/sched.h  |    2 
 4 files changed, 346 insertions(+), 459 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -575,6 +575,7 @@ struct sched_statistics {
 struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
+	struct load_weight		h_load;
 	struct rb_node			run_node;
 	u64				deadline;
 	u64				min_vruntime;
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -908,8 +908,9 @@ print_task(struct seq_file *m, struct rq
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, " %15s %5d %9Ld.%06ld   %c   %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld   %5d ",
+	SEQ_printf(m, " %15s %5d %10ld %9Ld.%06ld   %c   %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld   %5d ",
 		p->comm, task_pid_nr(p),
+		p->se.h_load.weight,
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
@@ -940,7 +941,7 @@ static void print_rq(struct seq_file *m,
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID       vruntime   eligible    "
+	SEQ_printf(m, " S            task   PID     weight       vruntime   eligible    "
 		   "deadline             slice          sum-exec      switches  "
 		   "prio         wait-time        sum-sleep       sum-block"
 #ifdef CONFIG_NUMA_BALANCING
@@ -1046,6 +1047,8 @@ void print_cfs_rq(struct seq_file *m, in
 			cfs_rq->tg_load_avg_contrib);
 	SEQ_printf(m, "  .%-30s: %ld\n", "tg_load_avg",
 			atomic_long_read(&cfs_rq->tg->load_avg));
+	SEQ_printf(m, "  .%-30s: %lu\n", "h_load",
+			cfs_rq->h_load);
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 #ifdef CONFIG_CFS_BANDWIDTH
 	SEQ_printf(m, "  .%-30s: %d\n", "throttled",
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -296,8 +296,8 @@ static u64 __calc_delta(u64 delta_exec,
  */
 static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 {
-	if (unlikely(se->load.weight != NICE_0_LOAD))
-		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+	if (se->h_load.weight != NICE_0_LOAD)
+		delta = __calc_delta(delta, NICE_0_LOAD, &se->h_load);
 
 	return delta;
 }
@@ -427,38 +427,6 @@ static inline struct sched_entity *paren
 	return se->parent;
 }
 
-static void
-find_matching_se(struct sched_entity **se, struct sched_entity **pse)
-{
-	int se_depth, pse_depth;
-
-	/*
-	 * preemption test can be made between sibling entities who are in the
-	 * same cfs_rq i.e who have a common parent. Walk up the hierarchy of
-	 * both tasks until we find their ancestors who are siblings of common
-	 * parent.
-	 */
-
-	/* First walk up until both entities are at same depth */
-	se_depth = (*se)->depth;
-	pse_depth = (*pse)->depth;
-
-	while (se_depth > pse_depth) {
-		se_depth--;
-		*se = parent_entity(*se);
-	}
-
-	while (pse_depth > se_depth) {
-		pse_depth--;
-		*pse = parent_entity(*pse);
-	}
-
-	while (!is_same_group(*se, *pse)) {
-		*se = parent_entity(*se);
-		*pse = parent_entity(*pse);
-	}
-}
-
 static int tg_is_idle(struct task_group *tg)
 {
 	return tg->idle > 0;
@@ -502,11 +470,6 @@ static inline struct sched_entity *paren
 	return NULL;
 }
 
-static inline void
-find_matching_se(struct sched_entity **se, struct sched_entity **pse)
-{
-}
-
 static inline int tg_is_idle(struct task_group *tg)
 {
 	return 0;
@@ -685,7 +648,7 @@ static inline unsigned long avg_vruntime
 static inline void
 __sum_w_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+	unsigned long weight = avg_vruntime_weight(cfs_rq, se->h_load.weight);
 	s64 w_vruntime, key = entity_key(cfs_rq, se);
 
 	w_vruntime = key * weight;
@@ -702,7 +665,7 @@ sum_w_vruntime_add_paranoid(struct cfs_r
 	s64 key, tmp;
 
 again:
-	weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+	weight = avg_vruntime_weight(cfs_rq, se->h_load.weight);
 	key = entity_key(cfs_rq, se);
 
 	if (check_mul_overflow(key, weight, &key))
@@ -748,7 +711,7 @@ sum_w_vruntime_add(struct cfs_rq *cfs_rq
 static void
 sum_w_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+	unsigned long weight = avg_vruntime_weight(cfs_rq, se->h_load.weight);
 	s64 key = entity_key(cfs_rq, se);
 
 	cfs_rq->sum_w_vruntime -= key * weight;
@@ -790,7 +753,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		s64 runtime = cfs_rq->sum_w_vruntime;
 
 		if (curr) {
-			unsigned long w = avg_vruntime_weight(cfs_rq, curr->load.weight);
+			unsigned long w = avg_vruntime_weight(cfs_rq, curr->h_load.weight);
 
 			runtime += entity_key(cfs_rq, curr) * w;
 			weight += w;
@@ -842,8 +805,6 @@ static s64 entity_lag(struct cfs_rq *cfs
 
 static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	WARN_ON_ONCE(!se->on_rq);
-
 	se->vlag = entity_lag(cfs_rq, se, avg_vruntime(cfs_rq));
 }
 
@@ -871,7 +832,7 @@ static int vruntime_eligible(struct cfs_
 	long load = cfs_rq->sum_weight;
 
 	if (curr && curr->on_rq) {
-		unsigned long weight = avg_vruntime_weight(cfs_rq, curr->load.weight);
+		unsigned long weight = avg_vruntime_weight(cfs_rq, curr->h_load.weight);
 
 		avg += entity_key(cfs_rq, curr) * weight;
 		load += weight;
@@ -983,6 +944,9 @@ RB_DECLARE_CALLBACKS(static, min_vruntim
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(&rq_of(cfs_rq)->cfs != cfs_rq);
+	WARN_ON_ONCE(!entity_is_task(se));
+
 	sum_w_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
@@ -992,6 +956,9 @@ static void __enqueue_entity(struct cfs_
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(&rq_of(cfs_rq)->cfs != cfs_rq);
+	WARN_ON_ONCE(!entity_is_task(se));
+
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	sum_w_vruntime_sub(cfs_rq, se);
@@ -1077,7 +1044,7 @@ static inline void cancel_protect_slice(
  *
  * Which allows tree pruning through eligibility.
  */
-static struct sched_entity *__pick_eevdf(struct cfs_rq *cfs_rq, bool protect)
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq, bool protect)
 {
 	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
 	struct sched_entity *se = __pick_first_entity(cfs_rq);
@@ -1088,7 +1055,7 @@ static struct sched_entity *__pick_eevdf
 	 * We can safely skip eligibility check if there is only one entity
 	 * in this cfs_rq, saving some cycles.
 	 */
-	if (cfs_rq->nr_queued == 1)
+	if (cfs_rq->h_nr_queued == 1)
 		return curr && curr->on_rq ? curr : se;
 
 	/*
@@ -1148,11 +1115,6 @@ static struct sched_entity *__pick_eevdf
 	return best;
 }
 
-static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
-{
-	return __pick_eevdf(cfs_rq, true);
-}
-
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
 	struct rb_node *last = rb_last(&cfs_rq->tasks_timeline.rb_root);
@@ -1339,8 +1301,6 @@ static s64 update_se(struct rq *rq, stru
 	return delta_exec;
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 /*
  * Used by other classes to account runtime.
  */
@@ -1360,7 +1320,7 @@ static void update_curr(struct cfs_rq *c
 	 * not necessarily be the actual task running
 	 * (rq->curr.se). This is easy to confuse!
 	 */
-	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_entity *curr = cfs_rq->h_curr;
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 	bool resched;
@@ -1372,26 +1332,29 @@ static void update_curr(struct cfs_rq *c
 	if (unlikely(delta_exec <= 0))
 		return;
 
+	account_cfs_rq_runtime(cfs_rq, delta_exec);
+
+	if (!entity_is_task(curr))
+		return;
+
+	cfs_rq = &rq->cfs;
+
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
 	resched = update_deadline(cfs_rq, curr);
 
-	if (entity_is_task(curr)) {
-		/*
-		 * If the fair_server is active, we need to account for the
-		 * fair_server time whether or not the task is running on
-		 * behalf of fair_server or not:
-		 *  - If the task is running on behalf of fair_server, we need
-		 *    to limit its time based on the assigned runtime.
-		 *  - Fair task that runs outside of fair_server should account
-		 *    against fair_server such that it can account for this time
-		 *    and possibly avoid running this period.
-		 */
-		dl_server_update(&rq->fair_server, delta_exec);
-	}
-
-	account_cfs_rq_runtime(cfs_rq, delta_exec);
+	/*
+	 * If the fair_server is active, we need to account for the
+	 * fair_server time whether or not the task is running on
+	 * behalf of fair_server or not:
+	 *  - If the task is running on behalf of fair_server, we need
+	 *    to limit its time based on the assigned runtime.
+	 *  - Fair task that runs outside of fair_server should account
+	 *    against fair_server such that it can account for this time
+	 *    and possibly avoid running this period.
+	 */
+	dl_server_update(&rq->fair_server, delta_exec);
 
-	if (cfs_rq->nr_queued == 1)
+	if (cfs_rq->h_nr_queued == 1)
 		return;
 
 	if (resched || !protect_slice(curr)) {
@@ -1402,7 +1365,10 @@ static void update_curr(struct cfs_rq *c
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->donor->se));
+	struct sched_entity *se = &rq->donor->se;
+
+	for_each_sched_entity(se)
+		update_curr(cfs_rq_of(se));
 }
 
 static inline void
@@ -1478,7 +1444,7 @@ update_stats_enqueue_fair(struct cfs_rq
 	 * Are we enqueueing a waiting task? (for current tasks
 	 * a dequeue/enqueue event is a NOP)
 	 */
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->h_curr)
 		update_stats_wait_start_fair(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
@@ -1496,7 +1462,7 @@ update_stats_dequeue_fair(struct cfs_rq
 	 * Mark the end of the wait period if dequeueing a
 	 * waiting task:
 	 */
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->h_curr)
 		update_stats_wait_end_fair(cfs_rq, se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
@@ -3823,6 +3789,7 @@ static inline void update_scan_period(st
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(cfs_rq != cfs_rq_of(se));
 	update_load_add(&cfs_rq->load, se->load.weight);
 	if (entity_is_task(se)) {
 		struct rq *rq = rq_of(cfs_rq);
@@ -3836,6 +3803,7 @@ account_entity_enqueue(struct cfs_rq *cf
 static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(cfs_rq != cfs_rq_of(se));
 	update_load_sub(&cfs_rq->load, se->load.weight);
 	if (entity_is_task(se)) {
 		account_numa_dequeue(rq_of(cfs_rq), task_of(se));
@@ -3913,7 +3881,7 @@ dequeue_load_avg(struct cfs_rq *cfs_rq,
 static void
 rescale_entity(struct sched_entity *se, unsigned long weight, bool rel_vprot)
 {
-	unsigned long old_weight = se->load.weight;
+	long old_weight = se->h_load.weight;
 
 	/*
 	 * VRUNTIME
@@ -4013,16 +3981,17 @@ rescale_entity(struct sched_entity *se,
 		se->vprot = div64_long(se->vprot * old_weight, weight);
 }
 
-static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
-			    unsigned long weight)
+static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
+			   unsigned long weight, bool on_rq)
 {
 	bool curr = cfs_rq->curr == se;
 	bool rel_vprot = false;
 	u64 avruntime = 0;
 
-	if (se->on_rq) {
-		/* commit outstanding execution time */
-		update_curr(cfs_rq);
+	if (se->h_load.weight == weight)
+		return;
+
+	if (on_rq) {
 		avruntime = avg_vruntime(cfs_rq);
 		se->vlag = entity_lag(cfs_rq, se, avruntime);
 		se->deadline -= avruntime;
@@ -4032,46 +4001,79 @@ static void reweight_entity(struct cfs_r
 			rel_vprot = true;
 		}
 
-		cfs_rq->nr_queued--;
+		cfs_rq->h_nr_queued--;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
-		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
-	dequeue_load_avg(cfs_rq, se);
 
 	rescale_entity(se, weight, rel_vprot);
 
-	update_load_set(&se->load, weight);
+	update_load_set(&se->h_load, weight);
 
-	do {
-		u32 divider = get_pelt_divider(&se->avg);
-		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
-	} while (0);
-
-	enqueue_load_avg(cfs_rq, se);
-	if (se->on_rq) {
+	if (on_rq) {
 		if (rel_vprot)
 			se->vprot += avruntime;
 		se->deadline += avruntime;
 		se->rel_deadline = 0;
 		se->vruntime = avruntime - se->vlag;
 
-		update_load_add(&cfs_rq->load, se->load.weight);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
-		cfs_rq->nr_queued++;
+		cfs_rq->h_nr_queued++;
 	}
 }
 
+static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
+			    unsigned long weight)
+{
+	if (se->load.weight == weight)
+		return;
+
+	if (se->on_rq) {
+		WARN_ON_ONCE(cfs_rq != cfs_rq_of(se));
+		update_load_sub(&cfs_rq->load, se->load.weight);
+	}
+	dequeue_load_avg(cfs_rq, se);
+
+	update_load_set(&se->load, weight);
+
+	do {
+		u32 divider = get_pelt_divider(&se->avg);
+		se->avg.load_avg = div_u64(se_weight(se) * se->avg.load_sum, divider);
+	} while (0);
+
+	enqueue_load_avg(cfs_rq, se);
+
+	if (se->on_rq)
+		update_load_add(&cfs_rq->load, se->load.weight);
+}
+
 static void reweight_task_fair(struct rq *rq, struct task_struct *p,
 			       const struct load_weight *lw)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-	struct load_weight *load = &se->load;
+	unsigned long weight = NICE_0_LOAD;
 
-	reweight_entity(cfs_rq, se, lw->weight);
-	load->inv_weight = lw->inv_weight;
+	if (se->on_rq)
+		update_curr_fair(rq);
+
+	reweight_entity(cfs_rq_of(se), se, lw->weight);
+	se->load.inv_weight = lw->inv_weight;
+
+	if (!se->on_rq)
+		return;
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		weight *= se->load.weight;
+		if (parent_entity(se))
+			weight /= cfs_rq->load.weight;
+	}
+
+	weight /= NICE_0_LOAD;
+
+	reweight_eevdf(&rq->cfs, &p->se, weight, p->se.on_rq);
 }
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
@@ -4272,7 +4274,6 @@ static long calc_group_shares(struct cfs
 static void update_cfs_group(struct sched_entity *se)
 {
 	struct cfs_rq *gcfs_rq = group_cfs_rq(se);
-	long shares;
 
 	/*
 	 * When a group becomes empty, preserve its weight. This matters for
@@ -4281,9 +4282,7 @@ static void update_cfs_group(struct sche
 	if (!gcfs_rq || !gcfs_rq->load.weight)
 		return;
 
-	shares = calc_group_shares(gcfs_rq);
-	if (unlikely(se->load.weight != shares))
-		reweight_entity(cfs_rq_of(se), se, shares);
+	reweight_entity(cfs_rq_of(se), se, calc_group_shares(gcfs_rq));
 }
 
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
@@ -4401,7 +4400,7 @@ static inline bool cfs_rq_is_decayed(str
  * differential update where we store the last value we propagated. This in
  * turn allows skipping updates if the differential is 'small'.
  *
- * Updating tg's load_avg is necessary before update_cfs_share().
+ * Updating tg's load_avg is necessary before update_cfs_group().
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
@@ -4867,7 +4866,7 @@ static void migrate_se_pelt_lag(struct s
  * The cfs_rq avg is the direct sum of all its entities (blocked and runnable)
  * avg. The immediate corollary is that all (fair) tasks must be attached.
  *
- * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
+ * cfs_rq->avg is used for task_h_load() and update_cfs_group() for example.
  *
  * Return: true if the load decayed or we removed load.
  *
@@ -5416,12 +5415,16 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
+	unsigned int nr_queued = cfs_rq->h_nr_queued;
 	s64 lag = 0;
 
 	if (!se->custom_slice)
 		se->slice = sysctl_sched_base_slice;
 	vslice = calc_delta_fair(se->slice, se);
 
+	if (flags & ENQUEUE_QUEUED)
+		nr_queued -= 1;
+
 	/*
 	 * Due to how V is constructed as the weighted average of entities,
 	 * adding tasks with positive lag, or removing tasks with negative lag
@@ -5430,7 +5433,7 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {
+	if (sched_feat(PLACE_LAG) && nr_queued && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		long load;
 
@@ -5490,9 +5493,9 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		 */
 		load = cfs_rq->sum_weight;
 		if (curr && curr->on_rq)
-			load += avg_vruntime_weight(cfs_rq, curr->load.weight);
+			load += avg_vruntime_weight(cfs_rq, curr->h_load.weight);
 
-		lag *= load + avg_vruntime_weight(cfs_rq, se->load.weight);
+		lag *= load + avg_vruntime_weight(cfs_rq, se->h_load.weight);
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div64_long(lag, load);
@@ -5524,22 +5527,8 @@ static void check_enqueue_throttle(struc
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 
 static void
-requeue_delayed_entity(struct sched_entity *se);
-
-static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	bool curr = cfs_rq->curr == se;
-
-	/*
-	 * If we're the current task, we must renormalise before calling
-	 * update_curr().
-	 */
-	if (curr)
-		place_entity(cfs_rq, se, flags);
-
-	update_curr(cfs_rq);
-
 	/*
 	 * When enqueuing a sched_entity, we must:
 	 *   - Update loads to have both entity and cfs_rq synced with now.
@@ -5558,13 +5547,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	 */
 	update_cfs_group(se);
 
-	/*
-	 * XXX now that the entity has been re-weighted, and it's lag adjusted,
-	 * we can place the entity.
-	 */
-	if (!curr)
-		place_entity(cfs_rq, se, flags);
-
 	account_entity_enqueue(cfs_rq, se);
 
 	/* Entity has migrated, no longer consider this task hot */
@@ -5573,8 +5555,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
-	if (!curr)
-		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_queued == 1) {
@@ -5592,21 +5572,19 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	}
 }
 
-static void __clear_buddies_next(struct sched_entity *se)
+static void set_next_buddy(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		if (cfs_rq->next != se)
-			break;
-
-		cfs_rq->next = NULL;
-	}
+	if (WARN_ON_ONCE(!se->on_rq || se->sched_delayed))
+		return;
+	if (se_is_idle(se))
+		return;
+	cfs_rq->next = se;
 }
 
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if (cfs_rq->next == se)
-		__clear_buddies_next(se);
+		cfs_rq->next = NULL;
 }
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -5617,7 +5595,7 @@ static void set_delayed(struct sched_ent
 
 	/*
 	 * Delayed se of cfs_rq have no tasks queued on them.
-	 * Do not adjust h_nr_runnable since dequeue_entities()
+	 * Do not adjust h_nr_runnable since __dequeue_task()
 	 * will account it for blocked tasks.
 	 */
 	if (!entity_is_task(se))
@@ -5657,36 +5635,11 @@ static inline void finish_delayed_dequeu
 		se->vlag = 0;
 }
 
-static bool
+static void
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	bool sleep = flags & DEQUEUE_SLEEP;
 	int action = UPDATE_TG;
 
-	update_curr(cfs_rq);
-	clear_buddies(cfs_rq, se);
-
-	if (flags & DEQUEUE_DELAYED) {
-		WARN_ON_ONCE(!se->sched_delayed);
-	} else {
-		bool delay = sleep;
-		/*
-		 * DELAY_DEQUEUE relies on spurious wakeups, special task
-		 * states must not suffer spurious wakeups, excempt them.
-		 */
-		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
-			delay = false;
-
-		WARN_ON_ONCE(delay && se->sched_delayed);
-
-		if (sched_feat(DELAY_DEQUEUE) && delay &&
-		    !entity_eligible(cfs_rq, se)) {
-			update_load_avg(cfs_rq, se, 0);
-			set_delayed(se);
-			return false;
-		}
-	}
-
 	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
 		action |= DO_DETACH;
 
@@ -5704,14 +5657,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	update_stats_dequeue_fair(cfs_rq, se, flags);
 
-	update_entity_lag(cfs_rq, se);
-	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
-		se->deadline -= se->vruntime;
-		se->rel_deadline = 1;
-	}
-
-	if (se != cfs_rq->curr)
-		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -5720,9 +5665,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	update_cfs_group(se);
 
-	if (flags & DEQUEUE_DELAYED)
-		finish_delayed_dequeue_entity(se);
-
 	if (cfs_rq->nr_queued == 0) {
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -5735,15 +5677,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 		}
 #endif
 	}
-
-	return true;
 }
 
 static void
-set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, bool first)
+set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	clear_buddies(cfs_rq, se);
-
 	/* 'current' is not kept within the tree. */
 	if (se->on_rq) {
 		/*
@@ -5752,16 +5690,12 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 		 * runqueue.
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
-		__dequeue_entity(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
-
-		if (first)
-			set_protect_slice(cfs_rq, se);
 	}
 
 	update_stats_curr_start(cfs_rq, se);
-	WARN_ON_ONCE(cfs_rq->curr);
-	cfs_rq->curr = se;
+	WARN_ON_ONCE(cfs_rq->h_curr);
+	cfs_rq->h_curr = se;
 
 	/*
 	 * Track our maximum slice length, if the CPU's load is at
@@ -5781,31 +5715,6 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
-static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
-
-/*
- * Pick the next process, keeping these things in mind, in this order:
- * 1) keep things fair between processes/task groups
- * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
- */
-static struct sched_entity *
-pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
-{
-	struct sched_entity *se;
-
-	se = pick_eevdf(cfs_rq);
-	if (se->sched_delayed) {
-		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-		/*
-		 * Must not reference @se again, see __block_task().
-		 */
-		return NULL;
-	}
-	return se;
-}
-
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 
 static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
@@ -5822,13 +5731,11 @@ static void put_prev_entity(struct cfs_r
 
 	if (prev->on_rq) {
 		update_stats_wait_start_fair(cfs_rq, prev);
-		/* Put 'current' back into the tree. */
-		__enqueue_entity(cfs_rq, prev);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
-	WARN_ON_ONCE(cfs_rq->curr != prev);
-	cfs_rq->curr = NULL;
+	WARN_ON_ONCE(cfs_rq->h_curr != prev);
+	cfs_rq->h_curr = NULL;
 }
 
 static void
@@ -5986,7 +5893,7 @@ static void __account_cfs_rq_runtime(str
 	 * if we're unable to extend our runtime we resched so that the active
 	 * hierarchy can be throttled
 	 */
-	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->curr))
+	if (!assign_cfs_rq_runtime(cfs_rq) && likely(cfs_rq->h_curr))
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -6344,7 +6251,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_queued)
+	if (rq->curr == rq->idle && rq->cfs.h_nr_queued)
 		resched_curr(rq);
 }
 
@@ -6685,7 +6592,7 @@ static void check_enqueue_throttle(struc
 		return;
 
 	/* an active group must be handled by the update_curr()->put() path */
-	if (!cfs_rq->runtime_enabled || cfs_rq->curr)
+	if (!cfs_rq->runtime_enabled || cfs_rq->h_curr)
 		return;
 
 	/* ensure the group is not already throttled */
@@ -7080,7 +6987,7 @@ static void hrtick_start_fair(struct rq
 			resched_curr(rq);
 		return;
 	}
-	delta = (se->load.weight * vdelta) / NICE_0_LOAD;
+	delta = (se->h_load.weight * vdelta) / NICE_0_LOAD;
 
 	/*
 	 * Correct for instantaneous load of other classes.
@@ -7180,10 +7087,8 @@ static int choose_idle_cpu(int cpu, stru
 }
 
 static void
-requeue_delayed_entity(struct sched_entity *se)
+requeue_delayed_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
-
 	/*
 	 * se->sched_delayed should imply: se->on_rq == 1.
 	 * Because a delayed entity is one that is still on
@@ -7195,14 +7100,14 @@ requeue_delayed_entity(struct sched_enti
 	if (sched_feat(DELAY_ZERO)) {
 		update_entity_lag(cfs_rq, se);
 		if (se->vlag > 0) {
-			cfs_rq->nr_queued--;
+			cfs_rq->h_nr_queued--;
 			if (se != cfs_rq->curr)
 				__dequeue_entity(cfs_rq, se);
 			se->vlag = 0;
 			place_entity(cfs_rq, se, 0);
 			if (se != cfs_rq->curr)
 				__enqueue_entity(cfs_rq, se);
-			cfs_rq->nr_queued++;
+			cfs_rq->h_nr_queued++;
 		}
 	}
 
@@ -7210,6 +7115,47 @@ requeue_delayed_entity(struct sched_enti
 	clear_delayed(se);
 }
 
+static unsigned long enqueue_hierarchy(struct task_struct *p, int flags)
+{
+	unsigned long weight = NICE_0_LOAD;
+	int task_new = !(flags & ENQUEUE_WAKEUP);
+	struct sched_entity *se = &p->se;
+	int h_nr_idle = task_has_idle_policy(p);
+	int h_nr_runnable = 1;
+
+	if (task_new && se->sched_delayed)
+		h_nr_runnable = 0;
+
+	for_each_sched_entity(se) {
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+		update_curr(cfs_rq);
+
+		if (!se->on_rq) {
+			enqueue_entity(cfs_rq, se, flags);
+		} else {
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			se_update_runnable(se);
+			update_cfs_group(se);
+		}
+
+		cfs_rq->h_nr_runnable += h_nr_runnable;
+		cfs_rq->h_nr_queued++;
+		cfs_rq->h_nr_idle += h_nr_idle;
+
+		if (cfs_rq_is_idle(cfs_rq))
+			h_nr_idle = 1;
+
+		weight *= se->load.weight;
+		if (parent_entity(se))
+			weight /= cfs_rq->load.weight;
+
+		flags = ENQUEUE_WAKEUP;
+	}
+
+	return weight / NICE_0_LOAD;
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -7218,13 +7164,12 @@ requeue_delayed_entity(struct sched_enti
 static void
 enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	struct cfs_rq *cfs_rq;
-	struct sched_entity *se = &p->se;
-	int h_nr_idle = task_has_idle_policy(p);
-	int h_nr_runnable = 1;
-	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_queued = rq->cfs.h_nr_queued;
-	u64 slice = 0;
+	int task_new = !(flags & ENQUEUE_WAKEUP);
+	struct sched_entity *se = &p->se;
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	unsigned long weight;
+	bool curr;
 
 	if (task_is_throttled(p) && enqueue_throttled_task(p))
 		return;
@@ -7236,10 +7181,10 @@ enqueue_task_fair(struct rq *rq, struct
 	 * estimated utilization, before we update schedutil.
 	 */
 	if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
-		util_est_enqueue(&rq->cfs, p);
+		util_est_enqueue(cfs_rq, p);
 
 	if (flags & ENQUEUE_DELAYED) {
-		requeue_delayed_entity(se);
+		requeue_delayed_entity(cfs_rq, se);
 		return;
 	}
 
@@ -7251,57 +7196,22 @@ enqueue_task_fair(struct rq *rq, struct
 	if (p->in_iowait)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
-	if (task_new && se->sched_delayed)
-		h_nr_runnable = 0;
-
-	for_each_sched_entity(se) {
-		if (se->on_rq) {
-			if (se->sched_delayed)
-				requeue_delayed_entity(se);
-			break;
-		}
-		cfs_rq = cfs_rq_of(se);
-
-		/*
-		 * Basically set the slice of group entries to the min_slice of
-		 * their respective cfs_rq. This ensures the group can service
-		 * its entities in the desired time-frame.
-		 */
-		if (slice) {
-			se->slice = slice;
-			se->custom_slice = 1;
-		}
-		enqueue_entity(cfs_rq, se, flags);
-		slice = cfs_rq_min_slice(cfs_rq);
-
-		cfs_rq->h_nr_runnable += h_nr_runnable;
-		cfs_rq->h_nr_queued++;
-		cfs_rq->h_nr_idle += h_nr_idle;
-
-		if (cfs_rq_is_idle(cfs_rq))
-			h_nr_idle = 1;
-
-		flags = ENQUEUE_WAKEUP;
-	}
-
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-		update_cfs_group(se);
+	/*
+	 * XXX comment on the curr thing
+	 */
+	curr = (cfs_rq->curr == se);
+	if (curr)
+		place_entity(cfs_rq, se, flags);
 
-		se->slice = slice;
-		if (se != cfs_rq->curr)
-			min_vruntime_cb_propagate(&se->run_node, NULL);
-		slice = cfs_rq_min_slice(cfs_rq);
+	if (se->on_rq && se->sched_delayed)
+		requeue_delayed_entity(cfs_rq, se);
 
-		cfs_rq->h_nr_runnable += h_nr_runnable;
-		cfs_rq->h_nr_queued++;
-		cfs_rq->h_nr_idle += h_nr_idle;
+	weight = enqueue_hierarchy(p, flags);
 
-		if (cfs_rq_is_idle(cfs_rq))
-			h_nr_idle = 1;
+	if (!curr) {
+		reweight_eevdf(cfs_rq, se, weight, false);
+		place_entity(cfs_rq, se, flags | ENQUEUE_QUEUED);
+		__enqueue_entity(cfs_rq, se);
 	}
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
@@ -7332,105 +7242,107 @@ enqueue_task_fair(struct rq *rq, struct
 	hrtick_update(rq);
 }
 
-/*
- * Basically dequeue_task_fair(), except it can deal with dequeue_entity()
- * failing half-way through and resume the dequeue later.
- *
- * Returns:
- * -1 - dequeue delayed
- *  0 - dequeue throttled
- *  1 - dequeue complete
- */
-static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
+static void dequeue_hierarchy(struct task_struct *p, int flags)
 {
-	bool was_sched_idle = sched_idle_rq(rq);
+	struct sched_entity *se = &p->se;
 	bool task_sleep = flags & DEQUEUE_SLEEP;
 	bool task_delayed = flags & DEQUEUE_DELAYED;
 	bool task_throttled = flags & DEQUEUE_THROTTLE;
-	struct task_struct *p = NULL;
-	int h_nr_idle = 0;
-	int h_nr_queued = 0;
 	int h_nr_runnable = 0;
-	struct cfs_rq *cfs_rq;
-	u64 slice = 0;
+	int h_nr_idle = task_has_idle_policy(p);
+	bool dequeue = true;
 
-	if (entity_is_task(se)) {
-		p = task_of(se);
-		h_nr_queued = 1;
-		h_nr_idle = task_has_idle_policy(p);
-		if (task_sleep || task_delayed || !se->sched_delayed)
-			h_nr_runnable = 1;
-	}
+	if (task_sleep || task_delayed || !se->sched_delayed)
+		h_nr_runnable = 1;
 
 	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-		if (!dequeue_entity(cfs_rq, se, flags)) {
-			if (p && &p->se == se)
-				return -1;
+		update_curr(cfs_rq);
 
-			slice = cfs_rq_min_slice(cfs_rq);
-			break;
+		if (dequeue) {
+			dequeue_entity(cfs_rq, se, flags);
+			/* Don't dequeue parent if it has other entities besides us */
+			if (cfs_rq->load.weight)
+				dequeue = false;
+		} else {
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			se_update_runnable(se);
+			update_cfs_group(se);
 		}
 
 		cfs_rq->h_nr_runnable -= h_nr_runnable;
-		cfs_rq->h_nr_queued -= h_nr_queued;
+		cfs_rq->h_nr_queued--;
 		cfs_rq->h_nr_idle -= h_nr_idle;
 
 		if (cfs_rq_is_idle(cfs_rq))
-			h_nr_idle = h_nr_queued;
+			h_nr_idle = 1;
 
 		if (throttled_hierarchy(cfs_rq) && task_throttled)
 			record_throttle_clock(cfs_rq);
 
-		/* Don't dequeue parent if it has other entities besides us */
-		if (cfs_rq->load.weight) {
-			slice = cfs_rq_min_slice(cfs_rq);
-
-			/* Avoid re-evaluating load for this entity: */
-			se = parent_entity(se);
-			/*
-			 * Bias pick_next to pick a task from this cfs_rq, as
-			 * p is sleeping when it is within its sched_slice.
-			 */
-			if (task_sleep && se)
-				set_next_buddy(se);
-			break;
-		}
 		flags |= DEQUEUE_SLEEP;
 		flags &= ~(DEQUEUE_DELAYED | DEQUEUE_SPECIAL);
 	}
+}
 
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
+/*
+ * The part of dequeue_task_fair() that is needed to dequeue delayed tasks.
+ *
+ * Returns:
+ *   true  - dequeued
+ *   false - delayed
+ */
+static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags)
+{
+	struct sched_entity *se = &p->se;
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	bool was_sched_idle = sched_idle_rq(rq);
+	bool task_sleep = flags & DEQUEUE_SLEEP;
+	bool task_delayed = flags & DEQUEUE_DELAYED;
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-		update_cfs_group(se);
+	clear_buddies(cfs_rq, se);
 
-		se->slice = slice;
-		if (se != cfs_rq->curr)
-			min_vruntime_cb_propagate(&se->run_node, NULL);
-		slice = cfs_rq_min_slice(cfs_rq);
+	if (flags & DEQUEUE_DELAYED) {
+		WARN_ON_ONCE(!se->sched_delayed);
+	} else {
+		bool delay = task_sleep;
+		/*
+		 * DELAY_DEQUEUE relies on spurious wakeups, special task
+		 * states must not suffer spurious wakeups, excempt them.
+		 */
+		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
+			delay = false;
 
-		cfs_rq->h_nr_runnable -= h_nr_runnable;
-		cfs_rq->h_nr_queued -= h_nr_queued;
-		cfs_rq->h_nr_idle -= h_nr_idle;
+		WARN_ON_ONCE(delay && se->sched_delayed);
 
-		if (cfs_rq_is_idle(cfs_rq))
-			h_nr_idle = h_nr_queued;
+		if (sched_feat(DELAY_DEQUEUE) && delay &&
+		    !entity_eligible(cfs_rq, se)) {
+			update_load_avg(cfs_rq_of(se), se, 0);
+			set_delayed(se);
+			return false;
+		}
+	}
 
-		if (throttled_hierarchy(cfs_rq) && task_throttled)
-			record_throttle_clock(cfs_rq);
+	dequeue_hierarchy(p, flags);
+
+	update_entity_lag(cfs_rq, se);
+	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
+		se->deadline -= se->vruntime;
+		se->rel_deadline = 1;
 	}
+	if (se != cfs_rq->curr)
+		__dequeue_entity(cfs_rq, se);
 
-	sub_nr_running(rq, h_nr_queued);
+	sub_nr_running(rq, 1);
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-	if (p && task_delayed) {
+	if (task_delayed) {
+		finish_delayed_dequeue_entity(se);
+
 		WARN_ON_ONCE(!task_sleep);
 		WARN_ON_ONCE(p->on_rq != 1);
 
@@ -7442,7 +7354,7 @@ static int dequeue_entities(struct rq *r
 		__block_task(rq, p);
 	}
 
-	return 1;
+	return true;
 }
 
 /*
@@ -7461,11 +7373,11 @@ static bool dequeue_task_fair(struct rq
 		util_est_dequeue(&rq->cfs, p);
 
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
-	if (dequeue_entities(rq, &p->se, flags) < 0)
+	if (!__dequeue_task(rq, p, flags))
 		return false;
 
 	/*
-	 * Must not reference @p after dequeue_entities(DEQUEUE_DELAYED).
+	 * Must not reference @p after __dequeue_task(DEQUEUE_DELAYED).
 	 */
 	return true;
 }
@@ -8953,19 +8865,6 @@ static void migrate_task_rq_fair(struct
 static void task_dead_fair(struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-
-	if (se->sched_delayed) {
-		struct rq_flags rf;
-		struct rq *rq;
-
-		rq = task_rq_lock(p, &rf);
-		if (se->sched_delayed) {
-			update_rq_clock(rq);
-			dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-		}
-		task_rq_unlock(rq, p, &rf);
-	}
-
 	remove_entity_load_avg(se);
 }
 
@@ -8999,21 +8898,10 @@ static void set_cpus_allowed_fair(struct
 	set_task_max_allowed_capacity(p);
 }
 
-static void set_next_buddy(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		if (WARN_ON_ONCE(!se->on_rq))
-			return;
-		if (se_is_idle(se))
-			return;
-		cfs_rq_of(se)->next = se;
-	}
-}
-
 enum preempt_wakeup_action {
 	PREEMPT_WAKEUP_NONE,	/* No preemption. */
 	PREEMPT_WAKEUP_SHORT,	/* Ignore slice protection. */
-	PREEMPT_WAKEUP_PICK,	/* Let __pick_eevdf() decide. */
+	PREEMPT_WAKEUP_PICK,	/* Let pick_eevdf() decide. */
 	PREEMPT_WAKEUP_RESCHED,	/* Force reschedule. */
 };
 
@@ -9030,7 +8918,7 @@ set_preempt_buddy(struct cfs_rq *cfs_rq,
 	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
 		return false;
 
-	set_next_buddy(pse);
+	set_next_buddy(cfs_rq, pse);
 	return true;
 }
 
@@ -9083,8 +8971,8 @@ static void wakeup_preempt_fair(struct r
 	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
 	struct task_struct *donor = rq->donor;
 	struct sched_entity *se = &donor->se, *pse = &p->se;
-	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
 	int cse_is_idle, pse_is_idle;
+	struct cfs_rq *cfs_rq = &rq->cfs;
 
 	/*
 	 * XXX Getting preempted by higher class, try and find idle CPU?
@@ -9120,7 +9008,6 @@ static void wakeup_preempt_fair(struct r
 	if (!sched_feat(WAKEUP_PREEMPTION))
 		return;
 
-	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
 
 	cse_is_idle = se_is_idle(se);
@@ -9148,8 +9035,7 @@ static void wakeup_preempt_fair(struct r
 	if (unlikely(!normal_policy(p->policy)))
 		return;
 
-	cfs_rq = cfs_rq_of(se);
-	update_curr(cfs_rq);
+	update_curr_fair(rq);
 	/*
 	 * If @p has a shorter slice than current and @p is eligible, override
 	 * current's slice protection in order to allow preemption.
@@ -9196,7 +9082,7 @@ static void wakeup_preempt_fair(struct r
 	/*
 	 * If @p has become the most eligible task, force preemption.
 	 */
-	if (__pick_eevdf(cfs_rq, preempt_action != PREEMPT_WAKEUP_SHORT) == pse)
+	if (pick_eevdf(cfs_rq, preempt_action != PREEMPT_WAKEUP_SHORT) == pse)
 		goto preempt;
 
 	if (sched_feat(RUN_TO_PARITY))
@@ -9214,35 +9100,34 @@ static void wakeup_preempt_fair(struct r
 struct task_struct *pick_task_fair(struct rq *rq, struct rq_flags *rf)
 	__must_hold(__rq_lockp(rq))
 {
+	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
-	struct cfs_rq *cfs_rq;
 	struct task_struct *p;
-	bool throttled;
 	int new_tasks;
 
 again:
-	cfs_rq = &rq->cfs;
-	if (!cfs_rq->nr_queued)
+	if (!cfs_rq->h_nr_queued)
 		goto idle;
 
-	throttled = false;
-
-	do {
-		/* Might not have done put_prev_entity() */
-		if (cfs_rq->curr && cfs_rq->curr->on_rq)
-			update_curr(cfs_rq);
-
-		throttled |= check_cfs_rq_runtime(cfs_rq);
+	/* Might not have done put_prev_entity() */
+	if (cfs_rq->curr && cfs_rq->curr->on_rq)
+		update_curr(cfs_rq);
 
-		se = pick_next_entity(rq, cfs_rq);
-		if (!se)
-			goto again;
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
+	se = pick_eevdf(cfs_rq, true);
+	if (WARN_ON_ONCE(!se))
+		return NULL;
 
 	p = task_of(se);
-	if (unlikely(throttled))
+	if (unlikely(check_cfs_rq_runtime(cfs_rq_of(se))))
 		task_throttle_setup_work(p);
+
+	if (se->sched_delayed) {
+		__dequeue_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		/*
+		 * Must not reference @se again, see __block_task().
+		 */
+		goto again;
+	}
 	return p;
 
 idle:
@@ -9276,7 +9161,7 @@ void fair_server_init(struct rq *rq)
 static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	struct sched_entity *se = &prev->se;
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *nse = NULL;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -9286,7 +9171,7 @@ static void put_prev_task_fair(struct rq
 
 	while (se) {
 		cfs_rq = cfs_rq_of(se);
-		if (!nse || cfs_rq->curr)
+		if (!nse || cfs_rq->h_curr)
 			put_prev_entity(cfs_rq, se);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		if (nse) {
@@ -9300,6 +9185,14 @@ static void put_prev_task_fair(struct rq
 #endif
 		se = parent_entity(se);
 	}
+
+	/* Put 'current' back into the tree. */
+	cfs_rq = &rq->cfs;
+	se = &prev->se;
+	WARN_ON_ONCE(cfs_rq->curr != se);
+	cfs_rq->curr = NULL;
+	if (se->on_rq)
+		__enqueue_entity(cfs_rq, se);
 }
 
 /*
@@ -9308,8 +9201,8 @@ static void put_prev_task_fair(struct rq
 static void yield_task_fair(struct rq *rq)
 {
 	struct task_struct *curr = rq->donor;
-	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
+	struct cfs_rq *cfs_rq = &rq->cfs;
 
 	/*
 	 * Are we the only task in the tree?
@@ -9350,11 +9243,11 @@ static bool yield_to_task_fair(struct rq
 	struct sched_entity *se = &p->se;
 
 	/* !se->on_rq also covers throttled task */
-	if (!se->on_rq)
+	if (!se->on_rq || se->sched_delayed)
 		return false;
 
 	/* Tell the scheduler that we'd really like se to run next. */
-	set_next_buddy(se);
+	set_next_buddy(&task_rq(p)->cfs, se);
 
 	yield_task_fair(rq);
 
@@ -9680,15 +9573,10 @@ static inline long migrate_degrades_loca
  */
 static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_cpu)
 {
-	struct cfs_rq *dst_cfs_rq;
+	struct cfs_rq *dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	dst_cfs_rq = task_group(p)->cfs_rq[dest_cpu];
-#else
-	dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
-#endif
-	if (sched_feat(PLACE_LAG) && dst_cfs_rq->nr_queued &&
-	    !entity_eligible(task_cfs_rq(p), &p->se))
+	if (sched_feat(PLACE_LAG) && dst_cfs_rq->h_nr_queued &&
+	    !entity_eligible(&task_rq(p)->cfs, &p->se))
 		return 1;
 
 	return 0;
@@ -10184,7 +10072,7 @@ static void update_cfs_rq_h_load(struct
 	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
-			cfs_rq_load_avg(cfs_rq) + 1);
+				cfs_rq_load_avg(cfs_rq) + 1);
 		cfs_rq = group_cfs_rq(se);
 		cfs_rq->h_load = load;
 		cfs_rq->last_h_load_update = now;
@@ -13405,7 +13293,7 @@ static inline void task_tick_core(struct
 	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
 	 * if we need to give up the CPU.
 	 */
-	if (rq->core->core_forceidle_count && rq->cfs.nr_queued == 1 &&
+	if (rq->core->core_forceidle_count && rq->cfs.h_nr_queued == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
@@ -13614,30 +13502,8 @@ bool cfs_prio_less(const struct task_str
 
 	WARN_ON_ONCE(task_rq(b)->core != rq->core);
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	/*
-	 * Find an se in the hierarchy for tasks a and b, such that the se's
-	 * are immediate siblings.
-	 */
-	while (sea->cfs_rq->tg != seb->cfs_rq->tg) {
-		int sea_depth = sea->depth;
-		int seb_depth = seb->depth;
-
-		if (sea_depth >= seb_depth)
-			sea = parent_entity(sea);
-		if (sea_depth <= seb_depth)
-			seb = parent_entity(seb);
-	}
-
-	se_fi_update(sea, rq->core->core_forceidle_seq, in_fi);
-	se_fi_update(seb, rq->core->core_forceidle_seq, in_fi);
-
-	cfs_rqa = sea->cfs_rq;
-	cfs_rqb = seb->cfs_rq;
-#else /* !CONFIG_FAIR_GROUP_SCHED: */
 	cfs_rqa = &task_rq(a)->cfs;
 	cfs_rqb = &task_rq(b)->cfs;
-#endif /* !CONFIG_FAIR_GROUP_SCHED */
 
 	/*
 	 * Find delta after normalizing se's vruntime with its cfs_rq's
@@ -13675,14 +13541,24 @@ static inline void task_tick_core(struct
  */
 static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
-	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &curr->se;
+	unsigned long weight = NICE_0_LOAD;
+	struct cfs_rq *cfs_rq;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 		entity_tick(cfs_rq, se, queued);
+
+		weight *= se->load.weight;
+		if (parent_entity(se))
+			weight /= cfs_rq->load.weight;
 	}
 
+	weight /= NICE_0_LOAD;
+
+	se = &curr->se;
+	reweight_eevdf(cfs_rq, se, weight, se->on_rq);
+
 	if (queued)
 		return;
 
@@ -13718,7 +13594,7 @@ prio_changed_fair(struct rq *rq, struct
 	if (p->prio == oldprio)
 		return;
 
-	if (rq->cfs.nr_queued == 1)
+	if (rq->cfs.h_nr_queued == 1)
 		return;
 
 	/*
@@ -13847,29 +13723,43 @@ static void switched_to_fair(struct rq *
 	}
 }
 
-/*
- * Account for a task changing its policy or group.
- *
- * This routine is mostly called to set cfs_rq->curr field when a task
- * migrates between groups/classes.
- */
 static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_entity *se = &p->se;
+	struct cfs_rq *cfs_rq = &rq->cfs;
+	unsigned long weight = NICE_0_LOAD;
+	bool on_rq = se->on_rq;
+
+	clear_buddies(cfs_rq, se);
+
+	if (on_rq)
+		__dequeue_entity(cfs_rq, se);
 
 	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
+		cfs_rq = cfs_rq_of(se);
 
-		if (IS_ENABLED(CONFIG_FAIR_GROUP_SCHED) &&
-		    first && cfs_rq->curr)
-			break;
+		if (!IS_ENABLED(CONFIG_FAIR_GROUP_SCHED) ||
+		    !first || !cfs_rq->h_curr)
+			set_next_entity(cfs_rq, se);
 
-		set_next_entity(cfs_rq, se, true);
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		account_cfs_rq_runtime(cfs_rq, 0);
+
+		if (on_rq) {
+			weight *= se->load.weight;
+			if (parent_entity(se))
+				weight /= cfs_rq->load.weight;
+		}
 	}
 
 	se = &p->se;
+	cfs_rq->curr = se;
+
+	if (on_rq) {
+		reweight_eevdf(cfs_rq, se, weight/NICE_0_LOAD, se->on_rq);
+		if (first)
+			set_protect_slice(cfs_rq, se);
+	}
 
 	if (task_on_rq_queued(p)) {
 		/*
@@ -14000,17 +13890,8 @@ void unregister_fair_sched_group(struct
 		struct sched_entity *se = tg->se[cpu];
 		struct rq *rq = cpu_rq(cpu);
 
-		if (se) {
-			if (se->sched_delayed) {
-				guard(rq_lock_irqsave)(rq);
-				if (se->sched_delayed) {
-					update_rq_clock(rq);
-					dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-				}
-				list_del_leaf_cfs_rq(cfs_rq);
-			}
+		if (se)
 			remove_entity_load_avg(se);
-		}
 
 		/*
 		 * Only empty task groups can be destroyed; so we can speculatively
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -707,6 +707,7 @@ struct cfs_rq {
 	/*
 	 * CFS load tracking
 	 */
+	struct sched_entity	*h_curr;
 	struct sched_avg	avg;
 #ifndef CONFIG_64BIT
 	u64			last_update_time_copy;
@@ -2493,6 +2494,7 @@ extern const u32		sched_prio_to_wmult[40
 #define ENQUEUE_MIGRATED	0x00040000
 #define ENQUEUE_INITIAL		0x00080000
 #define ENQUEUE_RQ_SELECTED	0x00100000
+#define ENQUEUE_QUEUED		0x00200000
 
 #define RETRY_TASK		((void *)-1UL)
 



