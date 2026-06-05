Return-Path: <cgroups+bounces-16664-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1MpxNAnGImoddgEAu9opvQ
	(envelope-from <cgroups+bounces-16664-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:50:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F05648527
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 14:50:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=casper.20170209 header.b=FvAgik7y;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16664-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16664-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81EB830CCE40
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACBCD3E8C79;
	Fri,  5 Jun 2026 12:43:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A2B21770B;
	Fri,  5 Jun 2026 12:43:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780663420; cv=none; b=l0G17kV4zrNURi2FL5TxMXHbsjmDqRmLX3fUvKPEi6kzQSxjXfeqMtM2Ya3Jadn64u0fzebb9lhtH5nrzeGDZAf5+Gf7MtqW9/9Kp+1UwE06W7bvbi9l2pjVseKo5+95H+1mzuVVC+Stxre3TOShKisvo0CandxwWoX/JxmgfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780663420; c=relaxed/simple;
	bh=FpwRrBkwKSXkxnjoSnBO3oIeUunERLqzAklG8a93z6U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=FWxPTTPkWlj0Ew8ruQP22F5j/VmtZggaKRL7jHWs+ZNjz4MHU0Y+Hzokx0n4Iutd3xAfjwk0IhVXTKkcZpBJxj1d7e5qaf558RVX8IsFclPWWqcVWfzq5ls/1McgxsPqGLcg1rvlewoCW5LJzsR+6icuHDdfPXIZE/uZCqhuHOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FvAgik7y; arc=none smtp.client-ip=90.155.50.34
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=QENbhsT42wygOuhjLKNvfeYB+Nqy2NYCzFToxy05sAU=; b=FvAgik7ytJT9aNnBLbmOYdB7wX
	ss5xFsKXEC2euaEF9o3naxsZisaJ5w+iLSCAZ7wmd2BatyM2z/J9UMfjW+MOQCmzU8bLwaXtVkhTw
	8RIpgmx8etIAVwqvec4EOL9s6UEqSmp2cpsg2EmSsBEOjqW1GvI6T4cOAwRNAVJVI4wyL6nLIvns9
	exdxN51gjPGSvulcxwz6s1mlGWjkcaCA3ikKuj7BsqsOCH2i5JV6asyEOeSUveJ3hZ1StWV87umJf
	lCewxlB3YmnJe7Jefb2Dlg289gm74mAPvqr0Kj6B3XLubZEcI2fC+tY8v5bbmMKLQPvY0tbKv26XB
	IAysyAIg==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVTtI-00000007vas-2Ads;
	Fri, 05 Jun 2026 12:43:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 40CDD30325C; Fri, 05 Jun 2026 14:43:11 +0200 (CEST)
Message-ID: <20260605124052.227463677@infradead.org>
User-Agent: quilt/0.68
Date: Fri, 05 Jun 2026 14:40:20 +0200
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
Subject: [PATCH v3 7/7] sched/eevdf: Move to a single runqueue
References: <20260605105513.354837583@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16664-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mingo@kernel.org,m:longman@redhat.com,m:chenridong@huaweicloud.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jstultz@google.com,m:kprateek.nayak@amd.com,m:qyousef@layalina.io,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,infradead.org:from_mime,infradead.org:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49F05648527

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

Since EEVDF is now exclusively operating on rq->cfs, it needs to
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
 kernel/sched/core.c   |    5 
 kernel/sched/debug.c  |    9 
 kernel/sched/fair.c   |  803 +++++++++++++++++++++-----------------------------
 kernel/sched/pelt.c   |    6 
 kernel/sched/sched.h  |   26 -
 6 files changed, 375 insertions(+), 475 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -574,6 +574,7 @@ struct sched_statistics {
 struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
+	struct load_weight		h_load;
 	struct rb_node			run_node;
 	u64				deadline;
 	u64				min_vruntime;
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5652,11 +5652,8 @@ EXPORT_PER_CPU_SYMBOL(kernel_cpustat);
  */
 static inline void prefetch_curr_exec_start(struct task_struct *p)
 {
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	struct sched_entity *curr = p->se.cfs_rq->curr;
-#else
 	struct sched_entity *curr = task_rq(p)->cfs.curr;
-#endif
+
 	prefetch(curr);
 	prefetch(&curr->exec_start);
 }
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -975,10 +975,11 @@ print_task(struct seq_file *m, struct rq
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, " %15s %5d %9Ld.%06ld   %c   %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld   %5d ",
+	SEQ_printf(m, " %15s %5d %10ld %9Ld.%06ld   %c   %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld   %5d ",
 		p->comm, task_pid_nr(p),
+		p->se.h_load.weight,
 		SPLIT_NS(p->se.vruntime),
-		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
+		entity_eligible(&rq->cfs, &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
 		p->se.custom_slice ? 'S' : ' ',
 		SPLIT_NS(p->se.slice),
@@ -1007,7 +1008,7 @@ static void print_rq(struct seq_file *m,
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID       vruntime   eligible    "
+	SEQ_printf(m, " S            task   PID     weight       vruntime   eligible    "
 		   "deadline             slice          sum-exec      switches  "
 		   "prio         wait-time        sum-sleep       sum-block"
 #ifdef CONFIG_NUMA_BALANCING
@@ -1115,6 +1116,8 @@ void print_cfs_rq(struct seq_file *m, in
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
@@ -297,8 +297,8 @@ static u64 __calc_delta(u64 delta_exec,
  */
 static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
 {
-	if (unlikely(se->load.weight != NICE_0_LOAD))
-		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+	if (se->h_load.weight != NICE_0_LOAD)
+		delta = __calc_delta(delta, NICE_0_LOAD, &se->h_load);
 
 	return delta;
 }
@@ -428,38 +428,6 @@ static inline struct sched_entity *paren
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
@@ -503,11 +471,6 @@ static inline struct sched_entity *paren
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
@@ -686,7 +649,7 @@ static inline unsigned long avg_vruntime
 static inline void
 __sum_w_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+	unsigned long weight = avg_vruntime_weight(cfs_rq, se->h_load.weight);
 	s64 w_vruntime, key = entity_key(cfs_rq, se);
 
 	w_vruntime = key * weight;
@@ -703,7 +666,7 @@ sum_w_vruntime_add_paranoid(struct cfs_r
 	s64 key, tmp;
 
 again:
-	weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+	weight = avg_vruntime_weight(cfs_rq, se->h_load.weight);
 	key = entity_key(cfs_rq, se);
 
 	if (check_mul_overflow(key, weight, &key))
@@ -749,7 +712,7 @@ sum_w_vruntime_add(struct cfs_rq *cfs_rq
 static void
 sum_w_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+	unsigned long weight = avg_vruntime_weight(cfs_rq, se->h_load.weight);
 	s64 key = entity_key(cfs_rq, se);
 
 	cfs_rq->sum_w_vruntime -= key * weight;
@@ -791,7 +754,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		s64 runtime = cfs_rq->sum_w_vruntime;
 
 		if (curr) {
-			unsigned long w = avg_vruntime_weight(cfs_rq, curr->load.weight);
+			unsigned long w = avg_vruntime_weight(cfs_rq, curr->h_load.weight);
 
 			runtime += entity_key(cfs_rq, curr) * w;
 			weight += w;
@@ -862,8 +825,6 @@ bool update_entity_lag(struct cfs_rq *cf
 	u64 avruntime = avg_vruntime(cfs_rq);
 	s64 vlag = entity_lag(cfs_rq, se, avruntime);
 
-	WARN_ON_ONCE(!se->on_rq);
-
 	if (se->sched_delayed) {
 		/* previous vlag < 0 otherwise se would not be delayed */
 		vlag = max(vlag, se->vlag);
@@ -899,7 +860,7 @@ static int vruntime_eligible(struct cfs_
 	long load = cfs_rq->sum_weight;
 
 	if (curr && curr->on_rq) {
-		unsigned long weight = avg_vruntime_weight(cfs_rq, curr->load.weight);
+		unsigned long weight = avg_vruntime_weight(cfs_rq, curr->h_load.weight);
 
 		avg += entity_key(cfs_rq, curr) * weight;
 		load += weight;
@@ -1040,6 +1001,9 @@ RB_DECLARE_CALLBACKS(static, min_vruntim
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(&rq_of(cfs_rq)->cfs != cfs_rq);
+	WARN_ON_ONCE(!entity_is_task(se));
+
 	sum_w_vruntime_add(cfs_rq, se);
 	se->min_vruntime = se->vruntime;
 	se->min_slice = se->slice;
@@ -1049,6 +1013,9 @@ static void __enqueue_entity(struct cfs_
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(&rq_of(cfs_rq)->cfs != cfs_rq);
+	WARN_ON_ONCE(!entity_is_task(se));
+
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	sum_w_vruntime_sub(cfs_rq, se);
@@ -1145,7 +1112,7 @@ static struct sched_entity *pick_eevdf(s
 	 * We can safely skip eligibility check if there is only one entity
 	 * in this cfs_rq, saving some cycles.
 	 */
-	if (cfs_rq->nr_queued == 1)
+	if (cfs_rq->h_nr_queued == 1)
 		return curr && curr->on_rq ? curr : se;
 
 	/*
@@ -1395,8 +1362,6 @@ static s64 update_se(struct rq *rq, stru
 	return delta_exec;
 }
 
-static void set_next_buddy(struct sched_entity *se);
-
 #ifdef CONFIG_SCHED_CACHE
 
 /*
@@ -1991,7 +1956,7 @@ static void update_curr(struct cfs_rq *c
 	 * not necessarily be the actual task running
 	 * (rq->curr.se). This is easy to confuse!
 	 */
-	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_entity *curr = cfs_rq->h_curr;
 	struct rq *rq = rq_of(cfs_rq);
 	s64 delta_exec;
 	bool resched;
@@ -2003,26 +1968,29 @@ static void update_curr(struct cfs_rq *c
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
@@ -2033,7 +2001,10 @@ static void update_curr(struct cfs_rq *c
 
 static void update_curr_fair(struct rq *rq)
 {
-	update_curr(cfs_rq_of(&rq->donor->se));
+	struct sched_entity *se = &rq->donor->se;
+
+	for_each_sched_entity(se)
+		update_curr(cfs_rq_of(se));
 }
 
 static inline void
@@ -2109,7 +2080,7 @@ update_stats_enqueue_fair(struct cfs_rq
 	 * Are we enqueueing a waiting task? (for current tasks
 	 * a dequeue/enqueue event is a NOP)
 	 */
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->h_curr)
 		update_stats_wait_start_fair(cfs_rq, se);
 
 	if (flags & ENQUEUE_WAKEUP)
@@ -2127,7 +2098,7 @@ update_stats_dequeue_fair(struct cfs_rq
 	 * Mark the end of the wait period if dequeueing a
 	 * waiting task:
 	 */
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->h_curr)
 		update_stats_wait_end_fair(cfs_rq, se);
 
 	if ((flags & DEQUEUE_SLEEP) && entity_is_task(se)) {
@@ -4468,6 +4439,7 @@ static inline void update_scan_period(st
 static void
 account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(cfs_rq != cfs_rq_of(se));
 	update_load_add(&cfs_rq->load, se->load.weight);
 	if (entity_is_task(se)) {
 		struct task_struct *p = task_of(se);
@@ -4483,6 +4455,7 @@ account_entity_enqueue(struct cfs_rq *cf
 static void
 account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	WARN_ON_ONCE(cfs_rq != cfs_rq_of(se));
 	update_load_sub(&cfs_rq->load, se->load.weight);
 	if (entity_is_task(se)) {
 		struct task_struct *p = task_of(se);
@@ -4564,7 +4537,7 @@ dequeue_load_avg(struct cfs_rq *cfs_rq,
 static void
 rescale_entity(struct sched_entity *se, unsigned long weight, bool rel_vprot)
 {
-	unsigned long old_weight = se->load.weight;
+	long old_weight = se->h_load.weight;
 
 	/*
 	 * VRUNTIME
@@ -4664,16 +4637,17 @@ rescale_entity(struct sched_entity *se,
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
@@ -4683,46 +4657,90 @@ static void reweight_entity(struct cfs_r
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
+/*
+ * weight = NICE_0_LOAD;
+ * for_each_entity_se(se)
+ *   weight = __calc_prop_weight(cfs_rq_of(se), se, weight);
+ */
+static __always_inline
+unsigned long __calc_prop_weight(struct cfs_rq *cfs_rq, struct sched_entity *se,
+				 unsigned long weight)
+{
+	weight *= se->load.weight;
+	if (parent_entity(se))
+		weight /= cfs_rq->load.weight;
+	else
+		weight /= NICE_0_LOAD;
+
+	return max(weight, MIN_SHARES);
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
+	for_each_sched_entity(se)
+		weight = __calc_prop_weight(cfs_rq_of(se), se, weight);
+
+	reweight_eevdf(&rq->cfs, &p->se, weight, p->se.on_rq);
 }
 
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq);
@@ -4958,8 +4976,7 @@ static void update_cfs_group(struct sche
 		return;
 
 	shares = static_call(calc_group_shares)(gcfs_rq);
-	if (unlikely(se->load.weight != shares))
-		reweight_entity(cfs_rq_of(se), se, shares);
+	reweight_entity(cfs_rq_of(se), se, shares);
 }
 
 #else /* !CONFIG_FAIR_GROUP_SCHED: */
@@ -5077,7 +5094,7 @@ static inline bool cfs_rq_is_decayed(str
  * differential update where we store the last value we propagated. This in
  * turn allows skipping updates if the differential is 'small'.
  *
- * Updating tg's load_avg is necessary before update_cfs_share().
+ * Updating tg's load_avg is necessary before update_cfs_group().
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
@@ -5544,7 +5561,7 @@ static void migrate_se_pelt_lag(struct s
  * The cfs_rq avg is the direct sum of all its entities (blocked and runnable)
  * avg. The immediate corollary is that all (fair) tasks must be attached.
  *
- * cfs_rq->avg is used for task_h_load() and update_cfs_share() for example.
+ * cfs_rq->avg is used for task_h_load() and update_cfs_group() for example.
  *
  * Return: true if the load decayed or we removed load.
  *
@@ -6082,6 +6099,7 @@ static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
+	unsigned int nr_queued = cfs_rq->h_nr_queued;
 	bool update_zero = false;
 	s64 lag = 0;
 
@@ -6089,6 +6107,9 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		se->slice = sysctl_sched_base_slice;
 	vslice = calc_delta_fair(se->slice, se);
 
+	if (flags & ENQUEUE_QUEUED)
+		nr_queued -= 1;
+
 	/*
 	 * Due to how V is constructed as the weighted average of entities,
 	 * adding tasks with positive lag, or removing tasks with negative lag
@@ -6097,7 +6118,7 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {
+	if (sched_feat(PLACE_LAG) && nr_queued && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		long load, weight;
 
@@ -6157,9 +6178,9 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		 */
 		load = cfs_rq->sum_weight;
 		if (curr && curr->on_rq)
-			load += avg_vruntime_weight(cfs_rq, curr->load.weight);
+			load += avg_vruntime_weight(cfs_rq, curr->h_load.weight);
 
-		weight = avg_vruntime_weight(cfs_rq, se->load.weight);
+		weight = avg_vruntime_weight(cfs_rq, se->h_load.weight);
 		lag *= load + weight;
 		if (WARN_ON_ONCE(!load))
 			load = 1;
@@ -6218,22 +6239,8 @@ static void check_enqueue_throttle(struc
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
@@ -6252,13 +6259,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
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
@@ -6267,8 +6267,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
-	if (!curr)
-		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_queued == 1) {
@@ -6286,21 +6284,19 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
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
@@ -6311,7 +6307,7 @@ static void set_delayed(struct sched_ent
 
 	/*
 	 * Delayed se of cfs_rq have no tasks queued on them.
-	 * Do not adjust h_nr_runnable since dequeue_entities()
+	 * Do not adjust h_nr_runnable since __dequeue_task()
 	 * will account it for blocked tasks.
 	 */
 	if (!entity_is_task(se))
@@ -6344,45 +6340,16 @@ static void clear_delayed(struct sched_e
 	}
 }
 
-static bool
+static void
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
-	bool sleep = flags & DEQUEUE_SLEEP;
-	int action = 0;
-
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
+	int action = UPDATE_TG;
 
-		if (sched_feat(DELAY_DEQUEUE) && delay &&
-		    !entity_eligible(cfs_rq, se)) {
-			if (entity_is_task(se))
-				action |= UPDATE_UTIL_EST;
-			update_load_avg(cfs_rq, se, action);
-			update_entity_lag(cfs_rq, se);
-			set_delayed(se);
-			return false;
-		}
-	}
-
-	action = UPDATE_TG;
 	if (entity_is_task(se)) {
 		if (task_on_rq_migrating(task_of(se)))
 			action |= DO_DETACH;
 
-		if (sleep && !(flags & DEQUEUE_DELAYED))
+		if ((flags & DEQUEUE_SLEEP) && !(flags & DEQUEUE_DELAYED))
 			action |= UPDATE_UTIL_EST;
 	}
 
@@ -6400,14 +6367,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
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
 
@@ -6416,9 +6375,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 
 	update_cfs_group(se);
 
-	if (flags & DEQUEUE_DELAYED)
-		clear_delayed(se);
-
 	if (cfs_rq->nr_queued == 0) {
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
@@ -6431,15 +6387,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
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
@@ -6448,16 +6400,12 @@ set_next_entity(struct cfs_rq *cfs_rq, s
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
@@ -6477,23 +6425,17 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
-static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
+static bool __dequeue_task(struct rq *rq, struct task_struct *p, int flags);
 
-/*
- * Pick the next process, keeping these things in mind, in this order:
- * 1) keep things fair between processes/task groups
- * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
- */
 static struct sched_entity *
-pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq, bool protect)
+pick_next_entity(struct rq *rq, bool protect)
 {
+	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *se;
 
 	se = pick_eevdf(cfs_rq, protect);
 	if (se->sched_delayed) {
-		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		__dequeue_task(rq, task_of(se), DEQUEUE_SLEEP | DEQUEUE_DELAYED);
 		/*
 		 * Must not reference @se again, see __block_task().
 		 */
@@ -6513,13 +6455,11 @@ static void put_prev_entity(struct cfs_r
 
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
@@ -7074,7 +7014,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cf
 	assert_list_leaf_cfs_rq(rq);
 
 	/* Determine whether we need to wake up potentially idle CPU: */
-	if (rq->curr == rq->idle && rq->cfs.nr_queued)
+	if (rq->curr == rq->idle && rq->cfs.h_nr_queued)
 		resched_curr(rq);
 }
 
@@ -7409,7 +7349,7 @@ static void check_enqueue_throttle(struc
 		return;
 
 	/* an active group must be handled by the update_curr() path */
-	if (!cfs_rq->runtime_enabled || cfs_rq->curr)
+	if (!cfs_rq->runtime_enabled || cfs_rq->h_curr)
 		return;
 
 	/* ensure the group is not already throttled */
@@ -7781,7 +7721,7 @@ static void hrtick_start_fair(struct rq
 			resched_curr(rq);
 		return;
 	}
-	delta = (se->load.weight * vdelta) / NICE_0_LOAD;
+	delta = (se->h_load.weight * vdelta) / NICE_0_LOAD;
 
 	/*
 	 * Correct for instantaneous load of other classes.
@@ -7881,10 +7821,8 @@ static int choose_idle_cpu(int cpu, stru
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
@@ -7894,19 +7832,58 @@ requeue_delayed_entity(struct sched_enti
 	WARN_ON_ONCE(!se->on_rq);
 
 	if (update_entity_lag(cfs_rq, se)) {
-		cfs_rq->nr_queued--;
+		cfs_rq->h_nr_queued--;
 		if (se != cfs_rq->curr)
 			__dequeue_entity(cfs_rq, se);
 		place_entity(cfs_rq, se, 0);
 		if (se != cfs_rq->curr)
 			__enqueue_entity(cfs_rq, se);
-		cfs_rq->nr_queued++;
+		cfs_rq->h_nr_queued++;
 	}
 
 	update_load_avg(cfs_rq, se, 0);
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
+		weight = __calc_prop_weight(cfs_rq, se, weight);
+
+		flags = ENQUEUE_WAKEUP;
+	}
+
+	return weight;
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -7915,13 +7892,12 @@ requeue_delayed_entity(struct sched_enti
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
@@ -7933,10 +7909,10 @@ enqueue_task_fair(struct rq *rq, struct
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
 
@@ -7948,57 +7924,22 @@ enqueue_task_fair(struct rq *rq, struct
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
+	/*
+	 * XXX comment on the curr thing
+	 */
+	curr = (cfs_rq->curr == se);
+	if (curr)
+		place_entity(cfs_rq, se, flags);
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
-		se_update_runnable(se);
-		update_cfs_group(se);
+	if (se->on_rq && se->sched_delayed)
+		requeue_delayed_entity(cfs_rq, se);
 
-		se->slice = slice;
-		if (se != cfs_rq->curr)
-			min_vruntime_cb_propagate(&se->run_node, NULL);
-		slice = cfs_rq_min_slice(cfs_rq);
+	weight = enqueue_hierarchy(p, flags);
 
-		cfs_rq->h_nr_runnable += h_nr_runnable;
-		cfs_rq->h_nr_queued++;
-		cfs_rq->h_nr_idle += h_nr_idle;
-
-		if (cfs_rq_is_idle(cfs_rq))
-			h_nr_idle = 1;
+	if (!curr) {
+		reweight_eevdf(cfs_rq, se, weight, false);
+		place_entity(cfs_rq, se, flags | ENQUEUE_QUEUED);
+		__enqueue_entity(cfs_rq, se);
 	}
 
 	if (!rq_h_nr_queued && rq->cfs.h_nr_queued)
@@ -8029,105 +7970,109 @@ enqueue_task_fair(struct rq *rq, struct
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
+	update_curr(cfs_rq_of(se));
+	update_entity_lag(cfs_rq, se);
 
-		cfs_rq->h_nr_runnable -= h_nr_runnable;
-		cfs_rq->h_nr_queued -= h_nr_queued;
-		cfs_rq->h_nr_idle -= h_nr_idle;
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
 
-		if (cfs_rq_is_idle(cfs_rq))
-			h_nr_idle = h_nr_queued;
+		WARN_ON_ONCE(delay && se->sched_delayed);
 
-		if (throttled_hierarchy(cfs_rq) && task_throttled)
-			record_throttle_clock(cfs_rq);
+		if (sched_feat(DELAY_DEQUEUE) && delay &&
+		    !entity_eligible(cfs_rq, se)) {
+			update_load_avg(cfs_rq_of(se), se, UPDATE_UTIL_EST);
+			set_delayed(se);
+			return false;
+		}
 	}
 
-	sub_nr_running(rq, h_nr_queued);
+	dequeue_hierarchy(p, flags);
+
+	if (sched_feat(PLACE_REL_DEADLINE) && !task_sleep) {
+		se->deadline -= se->vruntime;
+		se->rel_deadline = 1;
+	}
+	if (se != cfs_rq->curr)
+		__dequeue_entity(cfs_rq, se);
+
+	sub_nr_running(rq, 1);
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
-	if (p && task_delayed) {
+	if (task_delayed) {
+		clear_delayed(se);
+
 		WARN_ON_ONCE(!task_sleep);
 		WARN_ON_ONCE(p->on_rq != 1);
 
@@ -8139,7 +8084,7 @@ static int dequeue_entities(struct rq *r
 		__block_task(rq, p);
 	}
 
-	return 1;
+	return true;
 }
 
 /*
@@ -8157,11 +8102,11 @@ static bool dequeue_task_fair(struct rq
 	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
-	if (dequeue_entities(rq, &p->se, flags) < 0)
+	if (!__dequeue_task(rq, p, flags))
 		return false;
 
 	/*
-	 * Must not reference @p after dequeue_entities(DEQUEUE_DELAYED).
+	 * Must not reference @p after __dequeue_task(DEQUEUE_DELAYED).
 	 */
 	return true;
 }
@@ -9749,19 +9694,6 @@ static void migrate_task_rq_fair(struct
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
 
@@ -9795,21 +9727,10 @@ static void set_cpus_allowed_fair(struct
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
 
@@ -9826,7 +9747,7 @@ set_preempt_buddy(struct cfs_rq *cfs_rq,
 	if (cfs_rq->next && entity_before(cfs_rq->next, pse))
 		return false;
 
-	set_next_buddy(pse);
+	set_next_buddy(cfs_rq, pse);
 	return true;
 }
 
@@ -9879,7 +9800,7 @@ static void wakeup_preempt_fair(struct r
 	enum preempt_wakeup_action preempt_action = PREEMPT_WAKEUP_PICK;
 	struct task_struct *donor = rq->donor;
 	struct sched_entity *nse, *se = &donor->se, *pse = &p->se;
-	struct cfs_rq *cfs_rq = task_cfs_rq(donor);
+	struct cfs_rq *cfs_rq = &rq->cfs;
 	int cse_is_idle, pse_is_idle;
 
 	/*
@@ -9916,7 +9837,6 @@ static void wakeup_preempt_fair(struct r
 	if (!sched_feat(WAKEUP_PREEMPTION))
 		return;
 
-	find_matching_se(&se, &pse);
 	WARN_ON_ONCE(!pse);
 
 	cse_is_idle = se_is_idle(se);
@@ -9944,8 +9864,7 @@ static void wakeup_preempt_fair(struct r
 	if (unlikely(!normal_policy(p->policy)))
 		return;
 
-	cfs_rq = cfs_rq_of(se);
-	update_curr(cfs_rq);
+	update_curr_fair(rq);
 	/*
 	 * If @p has a shorter slice than current and @p is eligible, override
 	 * current's slice protection in order to allow preemption.
@@ -9989,18 +9908,15 @@ static void wakeup_preempt_fair(struct r
 	}
 
 pick:
-	nse = pick_next_entity(rq, cfs_rq, preempt_action != PREEMPT_WAKEUP_SHORT);
-	/* If @p has become the most eligible task, force preemption */
-	if (nse == pse)
-		goto preempt;
-
-	/*
-	 * Because p is enqueued, nse being null can only mean that we
-	 * dequeued a delayed task. If there are still entities queued in
-	 * cfs, check if the next one will be p.
-	 */
-	if (!nse && cfs_rq->nr_queued)
-		goto pick;
+	if (cfs_rq->h_nr_queued) {
+		nse = pick_next_entity(rq, preempt_action != PREEMPT_WAKEUP_SHORT);
+		if (unlikely(!nse))
+			goto pick;
+
+		/* If @p has become the most eligible task, force preemption */
+		if (nse == pse)
+			goto preempt;
+	}
 
 	if (sched_feat(RUN_TO_PARITY))
 		update_protect_slice(cfs_rq, se);
@@ -10019,33 +9935,24 @@ static void wakeup_preempt_fair(struct r
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
+	/* Might not have done put_prev_entity() */
+	if (cfs_rq->curr && cfs_rq->curr->on_rq)
+		update_curr(cfs_rq);
 
-		se = pick_next_entity(rq, cfs_rq, true);
-		if (!se)
-			goto again;
-		cfs_rq = group_cfs_rq(se);
-	} while (cfs_rq);
+	se = pick_next_entity(rq, true);
+	if (!se)
+		goto again;
 
 	p = task_of(se);
-	if (unlikely(throttled))
-		task_throttle_setup_work(p);
 	return p;
 
 idle:
@@ -10079,7 +9986,7 @@ void fair_server_init(struct rq *rq)
 static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	struct sched_entity *se = &prev->se;
-	struct cfs_rq *cfs_rq;
+	struct cfs_rq *cfs_rq = &rq->cfs;
 	struct sched_entity *nse = NULL;
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -10089,7 +9996,7 @@ static void put_prev_task_fair(struct rq
 
 	while (se) {
 		cfs_rq = cfs_rq_of(se);
-		if (!nse || cfs_rq->curr)
+		if (!nse || cfs_rq->h_curr)
 			put_prev_entity(cfs_rq, se);
 #ifdef CONFIG_FAIR_GROUP_SCHED
 		if (nse) {
@@ -10108,6 +10015,14 @@ static void put_prev_task_fair(struct rq
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
@@ -10116,8 +10031,8 @@ static void put_prev_task_fair(struct rq
 static void yield_task_fair(struct rq *rq)
 {
 	struct task_struct *curr = rq->donor;
-	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
 	struct sched_entity *se = &curr->se;
+	struct cfs_rq *cfs_rq = &rq->cfs;
 
 	/*
 	 * Are we the only task in the tree?
@@ -10158,11 +10073,11 @@ static bool yield_to_task_fair(struct rq
 	struct sched_entity *se = &p->se;
 
 	/* !se->on_rq also covers throttled task */
-	if (!se->on_rq)
+	if (!se->on_rq || se->sched_delayed)
 		return false;
 
 	/* Tell the scheduler that we'd really like se to run next. */
-	set_next_buddy(se);
+	set_next_buddy(&task_rq(p)->cfs, se);
 
 	yield_task_fair(rq);
 
@@ -10501,15 +10416,10 @@ static inline long migrate_degrades_loca
  */
 static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_cpu)
 {
-	struct cfs_rq *dst_cfs_rq;
+	struct cfs_rq *dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
 
-#ifdef CONFIG_FAIR_GROUP_SCHED
-	dst_cfs_rq = tg_cfs_rq(task_group(p), dest_cpu);
-#else
-	dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
-#endif
-	if (sched_feat(PLACE_LAG) && dst_cfs_rq->nr_queued &&
-	    !entity_eligible(task_cfs_rq(p), &p->se))
+	if (sched_feat(PLACE_LAG) && dst_cfs_rq->h_nr_queued &&
+	    !entity_eligible(&task_rq(p)->cfs, &p->se))
 		return 1;
 
 	return 0;
@@ -11292,7 +11202,7 @@ static void update_cfs_rq_h_load(struct
 	while ((se = READ_ONCE(cfs_rq->h_load_next)) != NULL) {
 		load = cfs_rq->h_load;
 		load = div64_ul(load * se->avg.load_avg,
-			cfs_rq_load_avg(cfs_rq) + 1);
+				cfs_rq_load_avg(cfs_rq) + 1);
 		cfs_rq = group_cfs_rq(se);
 		cfs_rq->h_load = load;
 		cfs_rq->last_h_load_update = now;
@@ -14684,7 +14594,7 @@ static inline void task_tick_core(struct
 	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
 	 * if we need to give up the CPU.
 	 */
-	if (rq->core->core_forceidle_count && rq->cfs.nr_queued == 1 &&
+	if (rq->core->core_forceidle_count && rq->cfs.h_nr_queued == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
 		resched_curr(rq);
 }
@@ -14893,30 +14803,8 @@ bool cfs_prio_less(const struct task_str
 
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
@@ -14955,11 +14843,20 @@ static inline void task_tick_core(struct
 static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
 {
 	struct sched_entity *se = &curr->se;
-	struct cfs_rq *cfs_rq;
 
-	for_each_sched_entity(se) {
-		cfs_rq = cfs_rq_of(se);
-		entity_tick(cfs_rq, se, queued);
+	if (se->on_rq) {
+		unsigned long weight = NICE_0_LOAD;
+		struct cfs_rq *cfs_rq;
+
+		for_each_sched_entity(se) {
+			cfs_rq = cfs_rq_of(se);
+			entity_tick(cfs_rq, se, queued);
+
+			weight = __calc_prop_weight(cfs_rq, se, weight);
+		}
+
+		se = &curr->se;
+		reweight_eevdf(cfs_rq, se, weight, se->on_rq);
 	}
 
 	if (queued)
@@ -14999,7 +14896,7 @@ prio_changed_fair(struct rq *rq, struct
 	if (p->prio == oldprio)
 		return;
 
-	if (rq->cfs.nr_queued == 1)
+	if (rq->cfs.h_nr_queued == 1)
 		return;
 
 	/*
@@ -15128,33 +15025,44 @@ static void switched_to_fair(struct rq *
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
 	bool throttled = false;
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
 
-		set_next_entity(cfs_rq, se, first);
 		/* ensure bandwidth has been allocated on our new cfs_rq */
 		throttled |= account_cfs_rq_runtime(cfs_rq, 0);
+
+		if (on_rq)
+			weight = __calc_prop_weight(cfs_rq, se, weight);
 	}
 
 	if (throttled)
 		task_throttle_setup_work(p);
 
 	se = &p->se;
+	cfs_rq->curr = se;
+
+	if (on_rq) {
+		reweight_eevdf(cfs_rq, se, weight, se->on_rq);
+		if (first)
+			set_protect_slice(cfs_rq, se);
+	}
 
 	if (task_on_rq_queued(p)) {
 		/*
@@ -15267,17 +15175,8 @@ void unregister_fair_sched_group(struct
 		struct sched_entity *se = tg_se(tg, cpu);
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
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -206,7 +206,7 @@ ___update_load_sum(u64 now, struct sched
 	/*
 	 * running is a subset of runnable (weight) so running can't be set if
 	 * runnable is clear. But there are some corner cases where the current
-	 * se has been already dequeued but cfs_rq->curr still points to it.
+	 * se has been already dequeued but cfs_rq->h_curr still points to it.
 	 * This means that weight will be 0 but not running for a sched_entity
 	 * but also for a cfs_rq if the latter becomes idle. As an example,
 	 * this happens during sched_balance_newidle() which calls
@@ -307,7 +307,7 @@ int __update_load_avg_blocked_se(u64 now
 int __update_load_avg_se(u64 now, struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
-				cfs_rq->curr == se)) {
+				cfs_rq->h_curr == se)) {
 
 		___update_load_avg(&se->avg, se_weight(se));
 		cfs_se_util_change(&se->avg);
@@ -323,7 +323,7 @@ int __update_load_avg_cfs_rq(u64 now, st
 	if (___update_load_sum(now, &cfs_rq->avg,
 				scale_load_down(cfs_rq->load.weight),
 				cfs_rq->h_nr_runnable,
-				cfs_rq->curr != NULL)) {
+				cfs_rq->h_curr != NULL)) {
 
 		___update_load_avg(&cfs_rq->avg, 1);
 		trace_pelt_cfs_tp(cfs_rq);
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -530,21 +530,8 @@ struct task_group {
 
 };
 
-#ifdef CONFIG_GROUP_SCHED_WEIGHT
 #define ROOT_TASK_GROUP_LOAD	NICE_0_LOAD
 
-/*
- * A weight of 0 or 1 can cause arithmetics problems.
- * A weight of a cfs_rq is the sum of weights of which entities
- * are queued on this cfs_rq, so a weight of a entity should not be
- * too large, so as the shares value of a task group.
- * (The default weight is 1024 - so there's no practical
- *  limitation from this.)
- */
-#define MIN_SHARES		(1UL <<  1)
-#define MAX_SHARES		(1UL << 18)
-#endif
-
 typedef int (*tg_visitor)(struct task_group *, void *);
 
 extern int walk_tg_tree_from(struct task_group *from,
@@ -631,6 +618,17 @@ static inline bool cfs_task_bw_constrain
 
 #endif /* !CONFIG_CGROUP_SCHED */
 
+/*
+ * A weight of 0 or 1 can cause arithmetics problems.
+ * A weight of a cfs_rq is the sum of weights of which entities
+ * are queued on this cfs_rq, so a weight of a entity should not be
+ * too large, so as the shares value of a task group.
+ * (The default weight is 1024 - so there's no practical
+ *  limitation from this.)
+ */
+#define MIN_SHARES		(1UL <<  1)
+#define MAX_SHARES		(1UL << 18)
+
 extern void unregister_rt_sched_group(struct task_group *tg);
 extern void free_rt_sched_group(struct task_group *tg);
 extern int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent);
@@ -709,6 +707,7 @@ struct cfs_rq {
 	/*
 	 * CFS load tracking
 	 */
+	struct sched_entity	*h_curr;
 	struct sched_avg	avg;
 #ifndef CONFIG_64BIT
 	u64			last_update_time_copy;
@@ -2575,6 +2574,7 @@ extern const u32		sched_prio_to_wmult[40
 #define ENQUEUE_MIGRATED	0x00040000
 #define ENQUEUE_INITIAL		0x00080000
 #define ENQUEUE_RQ_SELECTED	0x00100000
+#define ENQUEUE_QUEUED		0x00200000
 
 #define RETRY_TASK		((void *)-1UL)
 



