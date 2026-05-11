Return-Path: <cgroups+bounces-15752-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAhmOGzIAWoRjwEAu9opvQ
	(envelope-from <cgroups+bounces-15752-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:15:40 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2F550D752
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 676A4308346F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853963A1D02;
	Mon, 11 May 2026 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gvKBIvh1"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F737B01C;
	Mon, 11 May 2026 12:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501244; cv=none; b=iGPryHTOldkTVai2O7YKkU4OUoINuM1LDxtshpW/nxFfvpCSs59iiXPzY/6wYXbklq2GZHmpctDPWbFkp/4N72sG1GSTGYL423gy58kKysHzViZTN3J0i7Y8ndZCeNNN7BPOiyXjIjqEM+RQFcGzk2TSpc2GgUljdq4TcQskGms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501244; c=relaxed/simple;
	bh=kPWp0zdalOeesi/bRYpUPSDaIbZ3pumjIro3BOeJoKo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YwA0L6DTA32pGo/48wXFYoZNdm2INx+RZEE4/pMeibxkGuMAy37LBkQRJnuHxq67OV9EDe8o9h2/xKwyHK/Uyx9gloTJ0AdlJe9yKHO3Zlc5ebkLpbghRNXM6Os41zLGjr//ALi/as9VPAIWMtipF06LiWQAQ3SrnysGmGaiFL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gvKBIvh1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=RMka6uWXz+MEpo+IzMSoQp473kglO3d0dwEXELJJ06Q=; b=gvKBIvh1u4cXfkWQqnDL5nuep+
	6zR8Jxj3aOVhyEKhF5Brm0A/SUWq4ZiheI0GVoFN4qw/t6f+EldlUA1CK5T6tRmCjOOaOQAmIbtD6
	0nTW5mRXc6Vg389wAGFlmsiShHMg2pLrRH48ZRB1qZ33rfTGGEine5WihJ5AU5CEaXechfbPpFCxf
	UX34KCmXxNHIwKWMGPGSfW6zHIGXK2R7bPgUdQMRmIk/3+7rvF+9HL9BbZUXUw8Wjq41x6fQd6Mm0
	iynhEELMr47CnUJJWhf0Hlwj0Ppq/w+aPm+oJu1jLGFHRD/gZEnTmw/7T4zk4s4fWTX31jD/Q8iyR
	X9mB1TIw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPPa-000000088mT-1EEO;
	Mon, 11 May 2026 12:07:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 2A045303096; Mon, 11 May 2026 14:07:00 +0200 (CEST)
Message-ID: <20260511120627.829222375@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 11 May 2026 13:31:11 +0200
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
Subject: [PATCH v2 07/10] sched/fair: Add cgroup_mode: CONCUR
References: <20260511113104.563854162@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Rspamd-Queue-Id: 5B2F550D752
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15752-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterz@infradead.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Action: no action

A variation of MAX; where instead of assuming maximal concurrent, this scales
with 'min(nr_tasks, nr_cpus)'. This handles the low concurrency cases more
gracefully, with the exception of CPU affnity.

Note: the tracking of tg->tasks is somewhat expensive :-/

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    1 +
 kernel/sched/fair.c  |   39 ++++++++++++++++++++++++++++++++++++---
 kernel/sched/sched.h |    3 +++
 3 files changed, 40 insertions(+), 3 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -594,6 +594,7 @@ int cgroup_mode = 1;
 static const char *cgroup_mode_str[] = {
 	"up",
 	"smp",
+	"concur",
 	"max",
 };
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4211,6 +4211,30 @@ static long calc_max_shares(struct cfs_r
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
@@ -4240,6 +4264,9 @@ static long calc_group_shares(struct cfs
 		return calc_up_shares(cfs_rq);
 
 	if (mode == 2)
+		return calc_concur_shares(cfs_rq);
+
+	if (mode == 3)
 		return calc_max_shares(cfs_rq);
 
 	return calc_smp_shares(cfs_rq);
@@ -4385,7 +4412,7 @@ static inline bool cfs_rq_is_decayed(str
  */
 static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
-	long delta;
+	long delta, dt;
 	u64 now;
 
 	/*
@@ -4407,16 +4434,19 @@ static inline void update_tg_load_avg(st
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
@@ -4427,8 +4457,11 @@ static inline void clear_tg_load_avg(str
 
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
 



