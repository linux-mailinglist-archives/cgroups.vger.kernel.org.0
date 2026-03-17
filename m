Return-Path: <cgroups+bounces-14842-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJnjJWQxuWn4uAEAu9opvQ
	(envelope-from <cgroups+bounces-14842-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7672A836F
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 11:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D5A93025139
	for <lists+cgroups@lfdr.de>; Tue, 17 Mar 2026 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7DC37BE97;
	Tue, 17 Mar 2026 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/WkfZSk"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943063659FA;
	Tue, 17 Mar 2026 10:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773744469; cv=none; b=UMG072a1Pa1MeAT8Ly3pUMSDDIJObzhuHO0IF29PYdgtrwudADRMXEJ65UN7QQpGPwvhTlKR1014n8lJR+qrLplouCepLetzTtrfcjUOhSEh/gIPlK/dgqP/TkpCd28lKRcbtnMRkIog8C9OX9yjtkmoNtaiWAgSvz26/v6as/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773744469; c=relaxed/simple;
	bh=+pFF1AelRju298M6nOKw8/46MZRO/cTJx2ER7TBzv7M=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KMGfdqswsF9Ovl+mIehPTNHgSlMHMGq+AjKMvF4fBi4VWOipenMjBZDAnlSCRm4iyZMxdq9DdxphSkYZWcfiJwVkTKEltz9JxAn8DRBhvI45g84j5+iiV3tpxor86u8kKxxZUqpAlv2WwcQPOYqZKffTkfcVePKtPoMeYbfmbEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j/WkfZSk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=senJf2wakpmdGrsim4pMJJFM9+m5WIr95mcaSzWPbVY=; b=j/WkfZSkvwvSjSiz0uvv/G/gGI
	2Pdj75YO4x6l2Rpc9iCkiaMV05cH862ToCeuTi5RwaJT6+zwGZQrt4sKRcIrskrYNamGOO2f1hvTL
	yGHZQc2BhptyaV8j49Iyq0ZTb3595Qnap9GbQMlmzKcRi0Pl+k/dSarO1SRLXcCvWlbMM5KFdWaJ6
	pVfo0dBeHZeuSim8M1Dt57Y7R6uLsgdQyK6ZtgZZniSptHltQZZPhwIQkd+jD9/FXvjO+nxJOg2LC
	dCdRxRX3IMvF9IzGAbHLXZl6txt5OTTWAlEygu0rQ2ELvoZJG+xhB0I+zjMgPhdozOJmYw7qWQHjG
	vJWYeyvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2RxY-00000008kbs-1VAE;
	Tue, 17 Mar 2026 10:47:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2B93B3032EB; Tue, 17 Mar 2026 11:47:35 +0100 (CET)
Message-ID: <20260317104342.931729160@infradead.org>
User-Agent: quilt/0.68
Date: Tue, 17 Mar 2026 10:51:18 +0100
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
Subject: [RFC][PATCH 5/8] sched/fair: Add cgroup_mode: CONCUR
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
	TAGGED_FROM(0.00)[bounces-14842-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 3A7672A836F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A variation of MAX; where instead of assuming maximal concurrent, this scales
with 'min(nr_tasks, nr_cpus)'. This handles the low concurrency cases more
gracefully, with the exception of CPU affnity.

Note: the tracking of tg->tasks is somewhat expensive :-/

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    1 +
 kernel/sched/fair.c  |   38 +++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |    3 +++
 3 files changed, 39 insertions(+), 3 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -593,6 +593,7 @@ int cgroup_mode = 1;
 static const char *cgroup_mode_str[] = {
 	"up",
 	"smp",
+	"concur",
 	"max",
 };
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4210,6 +4210,30 @@ static long calc_max_shares(struct cfs_r
 	return __calc_smp_shares(cfs_rq, tg_shares * nr, max_shares);
 }
 
+static inline int tg_tasks(struct task_group *tg)
+{
+	return max(1, atomic_long_read(&tg->tasks));
+}
+
+/*
+ * Func: min(fraction(num * tg->shares), nice -20); where
+ *       num = min(nr_tasks, nr_cpus)
+ *
+ * Similar to max, except scale with min(nr_tasks, nr_cpus), which gives
+ * a far more natural distrubution. Can still create edge case using CPU
+ * affinity.
+ */
+static long calc_concur_shares(struct cfs_rq *cfs_rq)
+{
+	struct task_group *tg = cfs_rq->tg;
+	int nr_cpus = tg_cpus(tg);
+	int nr_tasks = tg_tasks(tg);
+	int nr = min(nr_tasks, nr_cpus);
+	long tg_shares = READ_ONCE(tg->shares);
+	long max_shares = scale_load(sched_prio_to_weight[0]);
+	return __calc_smp_shares(cfs_rq, nr * tg_shares, max_shares);
+}
+
 /*
  * Func: fraction(tg->shares)
  *
@@ -4236,6 +4260,8 @@ static long calc_group_shares(struct cfs
 	if (cgroup_mode == 0)
 		return calc_up_shares(cfs_rq);
 	if (cgroup_mode == 2)
+		return calc_concur_shares(cfs_rq);
+	if (cgroup_mode == 3)
 		return calc_max_shares(cfs_rq);
 
 	return calc_smp_shares(cfs_rq);
@@ -4381,7 +4407,7 @@ static inline bool cfs_rq_is_decayed(str
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
-	long delta;
+	long delta, dt;
 	u64 now;
 
 	/*
@@ -4403,16 +4429,19 @@ static inline void update_tg_load_avg(st
 		return;
 
 	delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
-	if (abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
+	dt = cfs_rq->h_nr_queued - cfs_rq->tg_tasks_contrib;
+	if (dt || abs(delta) > cfs_rq->tg_load_avg_contrib / 64) {
 		atomic_long_add(delta, &cfs_rq->tg->load_avg);
+		atomic_long_add(dt, &cfs_rq->tg->tasks);
 		cfs_rq->tg_load_avg_contrib = cfs_rq->avg.load_avg;
+		cfs_rq->tg_tasks_contrib = cfs_rq->h_nr_queued;
 		cfs_rq->last_update_tg_load_avg = now;
 	}
 }
 
 static inline void clear_tg_load_avg(struct cfs_rq *cfs_rq)
 {
-	long delta;
+	long delta, dt;
 	u64 now;
 
 	/*
@@ -4423,8 +4452,11 @@ static inline void clear_tg_load_avg(str
 
 	now = sched_clock_cpu(cpu_of(rq_of(cfs_rq)));
 	delta = 0 - cfs_rq->tg_load_avg_contrib;
+	dt = 0 - cfs_rq->tg_tasks_contrib;
 	atomic_long_add(delta, &cfs_rq->tg->load_avg);
+	atomic_long_add(dt, &cfs_rq->tg->tasks);
 	cfs_rq->tg_load_avg_contrib = 0;
+	cfs_rq->tg_tasks_contrib = 0;
 	cfs_rq->last_update_tg_load_avg = now;
 }
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -491,6 +491,8 @@ struct task_group {
 	 * will also be accessed at each tick.
 	 */
 	atomic_long_t		load_avg ____cacheline_aligned;
+	atomic_long_t		tasks;
+
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -720,6 +722,7 @@ struct cfs_rq {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	u64			last_update_tg_load_avg;
 	unsigned long		tg_load_avg_contrib;
+	unsigned long		tg_tasks_contrib;
 	long			propagate;
 	long			prop_runnable_sum;
 



