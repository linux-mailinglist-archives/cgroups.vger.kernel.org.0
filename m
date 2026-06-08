Return-Path: <cgroups+bounces-16710-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XEsPDfSyJmp4bQIAu9opvQ
	(envelope-from <cgroups+bounces-16710-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:17:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D3C6560EF
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:17:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QpNGNNHT;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16710-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16710-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6933E30202B2
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C67437DEAB;
	Mon,  8 Jun 2026 12:16:01 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA8379993
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920961; cv=none; b=P9brQO33rKHsdn3ayQ2xINgftL/8NshjzIKoIFOiROF8KO3AcJwydR2hKFB3UJm8bJYn35udY5hoKNoDkni23w+gyzWBI4yWAkoXBkcGw4EFu0Ckkc36xOYpkGCbFEZDY3tZ6cdZ9dt7I1AO3XIby7iQHak76jU23vaHuq8hVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920961; c=relaxed/simple;
	bh=tjnTxI2QCugOXqRqvj40i033x+3jZH5sGefRnhmhLfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbckG25ig5gTKWq8YJyISKxMoDPPu3DuR8cJ9J7AjiacGoE4iCUYTU4rUz6xKf9rq3GcJ4xI6TT73DhzkBvsNg0FfdbwjpAqOrIXvKyZLK/qhf1yyS4rwmNLthfr9qpkuBhQVJKbK+7d17pBM7upoxoJTvst/yAMHba6Wh7cPj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QpNGNNHT; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso49177365e9.3
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920955; x=1781525755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=364uttzh73Oa+/XNtb6jhsl3muZzgrKhNSL18k3lXqY=;
        b=QpNGNNHTsz4Q0pkSKos12VjaqVe/UgcC+Kg36bUjo8z7F2S2LpTgTw7vvkC4+LgfVQ
         MoXOs+VuSPpn10mYO+vFaEfTmSCbCf9xsopSgFy2WIEhuEPKl0OR6JzxFgmoHyp+UYTB
         zykHf2i5NUBLEGgeQ09iTiGJpEm7pMFy7dNRZfPv3SBlobET6tjOg9fn5wLJ89DCcwIW
         fdwfbi6z291H1IFY8xnqsS2587/IIS1PiIeenA0VnL6GmK6pdTYKfDIkUi3UwagTxFS5
         CIIHQrdCHN41O9QOMEL3czEAjL/xOOTBcS4+glOZLqeH7H4CZbxDqx6QZnzggxi176pu
         WSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920955; x=1781525755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=364uttzh73Oa+/XNtb6jhsl3muZzgrKhNSL18k3lXqY=;
        b=rIGOogoL7sNyoX6GGJTxuOAwrkknUioHqTnm50V8hmgbbZsFP/yGWLOviE/FCqkZ36
         O0Bign7ow6ulYQGbfh/EaScSBBium+AimSHBeljqfwZdqM/NcN3bLhkE8bCqpQmk6kYn
         a7y97uhyj55HJ1r7XQ8X2P5YoD4MRDiHMArnIU2//DEH19GO3RevoDOzVfplPYEcUI3E
         7FwHcGHaxTfT1/XyQrL0jWdxpPmcr1XA6vILcmW7RZsLVCW4jXYigLL5anV5xVuvnhSK
         LTOPDxuoDKWnFuGt39xmRU5KqmGDD7vKih/WZhqK0CtmfMehfv96V7afbVWaOVlcXRtK
         WtAg==
X-Gm-Message-State: AOJu0YyQNpE2r7DVGkA9XzOLc6g6ov8em4iyLXHJd9lZLdzAMABx9ga6
	ufRQG2euETwitPXZnblD552pqpzDA3acSKk6Xi0l5ryZrtzMuTnYZSY2
X-Gm-Gg: Acq92OFCIn+D6+jU3JsVcTFP6jTxBviDAEr13meSUTCTKH4DG0MWV1tVEAZjvJiNlkm
	7SzzPRyi0gQtcHWizAPIoB6Aye9F8OhGXqzhDyElKW9PaGiUx6rxn6o6SSK9Po7ir9HuBEanWMc
	9pem5+uFrv80STRRkteFj8sb7Fx7twap7Kw7a8JJ1XemmrBtAxhUqO2Nvuoo8mU59VfJkAI51ga
	6OE1fZbL6OxCIPrec2P/XcrU/hFFpIRD4FU6CnfZz0vNeYRYAqeyBqOndOC73Qa39zargA3rQ5+
	YT90H71K92fxLNM6y6hWWcg0BFiJP3lVZ9qRZGxtScTz7lCnP0XWwZVHM8Tl46HotaKqnXnolT/
	mVCls+kwVlODkoGSOzUBAl6z5Ju+882xv9aUznfj07+vTOngnF13TliWlGrlqE2MpmIlrNMuKh8
	za3FlSgbrZCBvH6M11HuVibTiajCpkuwNEHnnrdw8/Aw==
X-Received: by 2002:a05:600c:8b67:b0:490:d354:bcef with SMTP id 5b1f17b1804b1-490d354be2emr8449925e9.33.1780920954386;
        Mon, 08 Jun 2026 05:15:54 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:54 -0700 (PDT)
From: Yuri Andriaccio <yurand2000@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Luca Abeni <luca.abeni@santannapisa.it>,
	Yuri Andriaccio <yuri.andriaccio@santannapisa.it>
Subject: [RFC PATCH v6 07/25] sched/rt: Disable RT_GROUP_SCHED
Date: Mon,  8 Jun 2026 14:15:26 +0200
Message-ID: <20260608121546.69910-8-yurand2000@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608121546.69910-1-yurand2000@gmail.com>
References: <20260608121546.69910-1-yurand2000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16710-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9D3C6560EF

Disable the old RT_GROUP_SCHED scheduler. Note that this does not
completely remove all the RT_GROUP_SCHED functionality, just unhooks it
and removes most of the relevant functions. Some of the RT_GROUP_SCHED
functions are kept because they will be adapted for the HCBS scheduling.

Most notably:

- Disable the initialization of the rt_bandwidth for group scheduling.
- Unhook any functionality for RT_GROUP_SCHED in normal rt.c code, leaving
  only non-group functionality.
- Remove group related field initialization in init_rt_rq().
- Remove all the unhooked (and so unused) functions from RT_GROUP_SCHED.
- Remove all allocation/deallocation code for rt-groups, always returning
  failure on allocation.
- Update inc/dec_rt_tasks active tasks' counters, as rt scheduling
  entities now only represent a single task, and not a group of tasks
  anymore.
- Remove unused rq_of_rt_se function.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/core.c     |   6 -
 kernel/sched/deadline.c |  34 --
 kernel/sched/debug.c    |   6 -
 kernel/sched/rt.c       | 852 ++--------------------------------------
 kernel/sched/sched.h    |  32 +-
 kernel/sched/syscalls.c |  13 -
 6 files changed, 28 insertions(+), 915 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b8871449d3c6..e38ca8192d2d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8922,11 +8922,6 @@ void __init sched_init(void)
 
 	init_defrootdomain();
 
-#ifdef CONFIG_RT_GROUP_SCHED
-	init_rt_bandwidth(&root_task_group.rt_bandwidth,
-			global_rt_period(), global_rt_runtime());
-#endif /* CONFIG_RT_GROUP_SCHED */
-
 #ifdef CONFIG_CGROUP_SCHED
 	task_group_cache = KMEM_CACHE(task_group, 0);
 
@@ -8978,7 +8973,6 @@ void __init sched_init(void)
 		 * starts working after scheduler_running, which is not the case
 		 * yet.
 		 */
-		rq->rt.rt_runtime = global_rt_runtime();
 		init_tg_rt_entry(&root_task_group, &rq->rt, NULL, i, NULL);
 #endif
 		rq->next_class = &idle_sched_class;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b3059658a74a..c12882348a03 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1533,40 +1533,6 @@ static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64
 	} else {
 		trace_sched_dl_update_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 	}
-
-	/*
-	 * The dl_server does not account for real-time workload because it
-	 * is running fair work.
-	 */
-	if (dl_se->dl_server)
-		return;
-
-#ifdef CONFIG_RT_GROUP_SCHED
-	/*
-	 * Because -- for now -- we share the rt bandwidth, we need to
-	 * account our runtime there too, otherwise actual rt tasks
-	 * would be able to exceed the shared quota.
-	 *
-	 * Account to the root rt group for now.
-	 *
-	 * The solution we're working towards is having the RT groups scheduled
-	 * using deadline servers -- however there's a few nasties to figure
-	 * out before that can happen.
-	 */
-	if (rt_bandwidth_enabled()) {
-		struct rt_rq *rt_rq = &rq->rt;
-
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		/*
-		 * We'll let actual RT tasks worry about the overflow here, we
-		 * have our own CBS to keep us inline; only account when RT
-		 * bandwidth is relevant.
-		 */
-		if (sched_rt_bandwidth_account(rt_rq))
-			rt_rq->rt_time += delta_exec;
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-	}
-#endif /* CONFIG_RT_GROUP_SCHED */
 }
 
 /*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 74c1617cf652..40cc905a65b7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1009,12 +1009,6 @@ void print_rt_rq(struct seq_file *m, int cpu, struct rt_rq *rt_rq)
 
 	PU(rt_nr_running);
 
-#ifdef CONFIG_RT_GROUP_SCHED
-	P(rt_throttled);
-	PN(rt_time);
-	PN(rt_runtime);
-#endif
-
 #undef PN
 #undef PU
 #undef P
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index fe5b58f8fc69..7b526a86083c 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -82,115 +82,19 @@ void init_rt_rq(struct rt_rq *rt_rq)
 	rt_rq->highest_prio.next = MAX_RT_PRIO-1;
 	rt_rq->overloaded = 0;
 	plist_head_init(&rt_rq->pushable_tasks);
-	/* We start is dequeued state, because no RT tasks are queued */
-	rt_rq->rt_queued = 0;
-
-#ifdef CONFIG_RT_GROUP_SCHED
-	rt_rq->rt_time = 0;
-	rt_rq->rt_throttled = 0;
-	rt_rq->rt_runtime = 0;
-	raw_spin_lock_init(&rt_rq->rt_runtime_lock);
-	rt_rq->tg = &root_task_group;
-#endif
 }
 
 #ifdef CONFIG_RT_GROUP_SCHED
 
-static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun);
-
-static enum hrtimer_restart sched_rt_period_timer(struct hrtimer *timer)
-{
-	struct rt_bandwidth *rt_b =
-		container_of(timer, struct rt_bandwidth, rt_period_timer);
-	int idle = 0;
-	int overrun;
-
-	raw_spin_lock(&rt_b->rt_runtime_lock);
-	for (;;) {
-		overrun = hrtimer_forward_now(timer, rt_b->rt_period);
-		if (!overrun)
-			break;
-
-		raw_spin_unlock(&rt_b->rt_runtime_lock);
-		idle = do_sched_rt_period_timer(rt_b, overrun);
-		raw_spin_lock(&rt_b->rt_runtime_lock);
-	}
-	if (idle)
-		rt_b->rt_period_active = 0;
-	raw_spin_unlock(&rt_b->rt_runtime_lock);
-
-	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
-}
-
-void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime)
-{
-	rt_b->rt_period = ns_to_ktime(period);
-	rt_b->rt_runtime = runtime;
-
-	raw_spin_lock_init(&rt_b->rt_runtime_lock);
-
-	hrtimer_setup(&rt_b->rt_period_timer, sched_rt_period_timer, CLOCK_MONOTONIC,
-		      HRTIMER_MODE_REL_HARD);
-}
-
-static inline void do_start_rt_bandwidth(struct rt_bandwidth *rt_b)
-{
-	raw_spin_lock(&rt_b->rt_runtime_lock);
-	if (!rt_b->rt_period_active) {
-		rt_b->rt_period_active = 1;
-		/*
-		 * SCHED_DEADLINE updates the bandwidth, as a run away
-		 * RT task with a DL task could hog a CPU. But DL does
-		 * not reset the period. If a deadline task was running
-		 * without an RT task running, it can cause RT tasks to
-		 * throttle when they start up. Kick the timer right away
-		 * to update the period.
-		 */
-		hrtimer_forward_now(&rt_b->rt_period_timer, ns_to_ktime(0));
-		hrtimer_start_expires(&rt_b->rt_period_timer,
-				      HRTIMER_MODE_ABS_PINNED_HARD);
-	}
-	raw_spin_unlock(&rt_b->rt_runtime_lock);
-}
-
-static void start_rt_bandwidth(struct rt_bandwidth *rt_b)
-{
-	if (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF)
-		return;
-
-	do_start_rt_bandwidth(rt_b);
-}
-
-static void destroy_rt_bandwidth(struct rt_bandwidth *rt_b)
-{
-	hrtimer_cancel(&rt_b->rt_period_timer);
-}
-
 void unregister_rt_sched_group(struct task_group *tg)
 {
-	if (!rt_group_sched_enabled())
-		return;
 
-	if (tg->rt_se)
-		destroy_rt_bandwidth(&tg->rt_bandwidth);
 }
 
 void free_rt_sched_group(struct task_group *tg)
 {
-	int i;
-
 	if (!rt_group_sched_enabled())
 		return;
-
-	for_each_possible_cpu(i) {
-		if (tg->rt_rq)
-			kfree(tg->rt_rq[i]);
-		if (tg->rt_se)
-			kfree(tg->rt_se[i]);
-	}
-
-	kfree(tg->rt_rq);
-	kfree(tg->rt_se);
 }
 
 void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
@@ -200,66 +104,19 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 	struct rq *rq = cpu_rq(cpu);
 
 	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->rt_nr_boosted = 0;
 	rt_rq->rq = rq;
 	rt_rq->tg = tg;
 
 	tg->rt_rq[cpu] = rt_rq;
 	tg->rt_se[cpu] = rt_se;
-
-	if (!rt_se)
-		return;
-
-	if (!parent)
-		rt_se->rt_rq = &rq->rt;
-	else
-		rt_se->rt_rq = parent->my_q;
-
-	rt_se->my_q = rt_rq;
-	rt_se->parent = parent;
-	INIT_LIST_HEAD(&rt_se->run_list);
 }
 
 int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 {
-	struct rt_rq *rt_rq;
-	struct sched_rt_entity *rt_se;
-	int i;
-
 	if (!rt_group_sched_enabled())
 		return 1;
 
-	tg->rt_rq = kzalloc_objs(rt_rq, nr_cpu_ids);
-	if (!tg->rt_rq)
-		goto err;
-	tg->rt_se = kzalloc_objs(rt_se, nr_cpu_ids);
-	if (!tg->rt_se)
-		goto err;
-
-	init_rt_bandwidth(&tg->rt_bandwidth, ktime_to_ns(global_rt_period()), 0);
-
-	for_each_possible_cpu(i) {
-		rt_rq = kzalloc_node(sizeof(struct rt_rq),
-				     GFP_KERNEL, cpu_to_node(i));
-		if (!rt_rq)
-			goto err;
-
-		rt_se = kzalloc_node(sizeof(struct sched_rt_entity),
-				     GFP_KERNEL, cpu_to_node(i));
-		if (!rt_se)
-			goto err_free_rq;
-
-		init_rt_rq(rt_rq);
-		rt_rq->rt_runtime = tg->rt_bandwidth.rt_runtime;
-		init_tg_rt_entry(tg, rt_rq, rt_se, i, parent->rt_se[i]);
-	}
-
 	return 1;
-
-err_free_rq:
-	kfree(rt_rq);
-err:
-	return 0;
 }
 
 #else /* !CONFIG_RT_GROUP_SCHED: */
@@ -389,9 +246,6 @@ static void dequeue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 	}
 }
 
-static void enqueue_top_rt_rq(struct rt_rq *rt_rq);
-static void dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count);
-
 static inline int on_rt_rq(struct sched_rt_entity *rt_se)
 {
 	return rt_se->on_rq;
@@ -438,16 +292,6 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
 
 #ifdef CONFIG_RT_GROUP_SCHED
 
-static inline u64 sched_rt_runtime(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_runtime;
-}
-
-static inline u64 sched_rt_period(struct rt_rq *rt_rq)
-{
-	return ktime_to_ns(rt_rq->tg->rt_bandwidth.rt_period);
-}
-
 typedef struct task_group *rt_rq_iter_t;
 
 static inline struct task_group *next_task_group(struct task_group *tg)
@@ -473,457 +317,20 @@ static inline struct task_group *next_task_group(struct task_group *tg)
 		iter && (rt_rq = iter->rt_rq[cpu_of(rq)]);		\
 		iter = next_task_group(iter))
 
-#define for_each_sched_rt_entity(rt_se) \
-	for (; rt_se; rt_se = rt_se->parent)
-
-static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
-{
-	return rt_se->my_q;
-}
-
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags);
 static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags);
 
-static void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
-{
-	struct task_struct *donor = rq_of_rt_rq(rt_rq)->donor;
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-	struct sched_rt_entity *rt_se;
-
-	int cpu = cpu_of(rq);
-
-	rt_se = rt_rq->tg->rt_se[cpu];
-
-	if (rt_rq->rt_nr_running) {
-		if (!rt_se)
-			enqueue_top_rt_rq(rt_rq);
-		else if (!on_rt_rq(rt_se))
-			enqueue_rt_entity(rt_se, 0);
-
-		if (rt_rq->highest_prio.curr < donor->prio)
-			resched_curr(rq);
-	}
-}
-
-static void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
-{
-	struct sched_rt_entity *rt_se;
-	int cpu = cpu_of(rq_of_rt_rq(rt_rq));
-
-	rt_se = rt_rq->tg->rt_se[cpu];
-
-	if (!rt_se) {
-		dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
-		/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-		cpufreq_update_util(rq_of_rt_rq(rt_rq), 0);
-	}
-	else if (on_rt_rq(rt_se))
-		dequeue_rt_entity(rt_se, 0);
-}
-
-static inline int rt_rq_throttled(struct rt_rq *rt_rq)
-{
-	return rt_rq->rt_throttled && !rt_rq->rt_nr_boosted;
-}
-
-static int rt_se_boosted(struct sched_rt_entity *rt_se)
-{
-	struct rt_rq *rt_rq = group_rt_rq(rt_se);
-	struct task_struct *p;
-
-	if (rt_rq)
-		return !!rt_rq->rt_nr_boosted;
-
-	p = rt_task_of(rt_se);
-	return p->prio != p->normal_prio;
-}
-
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return this_rq()->rd->span;
-}
-
-static inline
-struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
-{
-	return container_of(rt_b, struct task_group, rt_bandwidth)->rt_rq[cpu];
-}
-
-static inline struct rt_bandwidth *sched_rt_bandwidth(struct rt_rq *rt_rq)
-{
-	return &rt_rq->tg->rt_bandwidth;
-}
-
-bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
-{
-	struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
-
-	return (hrtimer_active(&rt_b->rt_period_timer) ||
-		rt_rq->rt_time < rt_b->rt_runtime);
-}
-
-/*
- * We ran out of runtime, see if we can borrow some from our neighbours.
- */
-static void do_balance_runtime(struct rt_rq *rt_rq)
-{
-	struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
-	struct root_domain *rd = rq_of_rt_rq(rt_rq)->rd;
-	int i, weight;
-	u64 rt_period;
-
-	weight = cpumask_weight(rd->span);
-
-	raw_spin_lock(&rt_b->rt_runtime_lock);
-	rt_period = ktime_to_ns(rt_b->rt_period);
-	for_each_cpu(i, rd->span) {
-		struct rt_rq *iter = sched_rt_period_rt_rq(rt_b, i);
-		s64 diff;
-
-		if (iter == rt_rq)
-			continue;
-
-		raw_spin_lock(&iter->rt_runtime_lock);
-		/*
-		 * Either all rqs have inf runtime and there's nothing to steal
-		 * or __disable_runtime() below sets a specific rq to inf to
-		 * indicate its been disabled and disallow stealing.
-		 */
-		if (iter->rt_runtime == RUNTIME_INF)
-			goto next;
-
-		/*
-		 * From runqueues with spare time, take 1/n part of their
-		 * spare time, but no more than our period.
-		 */
-		diff = iter->rt_runtime - iter->rt_time;
-		if (diff > 0) {
-			diff = div_u64((u64)diff, weight);
-			if (rt_rq->rt_runtime + diff > rt_period)
-				diff = rt_period - rt_rq->rt_runtime;
-			iter->rt_runtime -= diff;
-			rt_rq->rt_runtime += diff;
-			if (rt_rq->rt_runtime == rt_period) {
-				raw_spin_unlock(&iter->rt_runtime_lock);
-				break;
-			}
-		}
-next:
-		raw_spin_unlock(&iter->rt_runtime_lock);
-	}
-	raw_spin_unlock(&rt_b->rt_runtime_lock);
-}
-
-/*
- * Ensure this RQ takes back all the runtime it lend to its neighbours.
- */
-static void __disable_runtime(struct rq *rq)
-{
-	struct root_domain *rd = rq->rd;
-	rt_rq_iter_t iter;
-	struct rt_rq *rt_rq;
-
-	if (unlikely(!scheduler_running))
-		return;
-
-	for_each_rt_rq(rt_rq, iter, rq) {
-		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
-		s64 want;
-		int i;
-
-		raw_spin_lock(&rt_b->rt_runtime_lock);
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		/*
-		 * Either we're all inf and nobody needs to borrow, or we're
-		 * already disabled and thus have nothing to do, or we have
-		 * exactly the right amount of runtime to take out.
-		 */
-		if (rt_rq->rt_runtime == RUNTIME_INF ||
-				rt_rq->rt_runtime == rt_b->rt_runtime)
-			goto balanced;
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-
-		/*
-		 * Calculate the difference between what we started out with
-		 * and what we current have, that's the amount of runtime
-		 * we lend and now have to reclaim.
-		 */
-		want = rt_b->rt_runtime - rt_rq->rt_runtime;
-
-		/*
-		 * Greedy reclaim, take back as much as we can.
-		 */
-		for_each_cpu(i, rd->span) {
-			struct rt_rq *iter = sched_rt_period_rt_rq(rt_b, i);
-			s64 diff;
-
-			/*
-			 * Can't reclaim from ourselves or disabled runqueues.
-			 */
-			if (iter == rt_rq || iter->rt_runtime == RUNTIME_INF)
-				continue;
-
-			raw_spin_lock(&iter->rt_runtime_lock);
-			if (want > 0) {
-				diff = min_t(s64, iter->rt_runtime, want);
-				iter->rt_runtime -= diff;
-				want -= diff;
-			} else {
-				iter->rt_runtime -= want;
-				want -= want;
-			}
-			raw_spin_unlock(&iter->rt_runtime_lock);
-
-			if (!want)
-				break;
-		}
-
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		/*
-		 * We cannot be left wanting - that would mean some runtime
-		 * leaked out of the system.
-		 */
-		WARN_ON_ONCE(want);
-balanced:
-		/*
-		 * Disable all the borrow logic by pretending we have inf
-		 * runtime - in which case borrowing doesn't make sense.
-		 */
-		rt_rq->rt_runtime = RUNTIME_INF;
-		rt_rq->rt_throttled = 0;
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-		raw_spin_unlock(&rt_b->rt_runtime_lock);
-
-		/* Make rt_rq available for pick_next_task() */
-		sched_rt_rq_enqueue(rt_rq);
-	}
-}
-
-static void __enable_runtime(struct rq *rq)
-{
-	rt_rq_iter_t iter;
-	struct rt_rq *rt_rq;
-
-	if (unlikely(!scheduler_running))
-		return;
-
-	/*
-	 * Reset each runqueue's bandwidth settings
-	 */
-	for_each_rt_rq(rt_rq, iter, rq) {
-		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
-
-		raw_spin_lock(&rt_b->rt_runtime_lock);
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		rt_rq->rt_runtime = rt_b->rt_runtime;
-		rt_rq->rt_time = 0;
-		rt_rq->rt_throttled = 0;
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-		raw_spin_unlock(&rt_b->rt_runtime_lock);
-	}
-}
-
-static void balance_runtime(struct rt_rq *rt_rq)
-{
-	if (!sched_feat(RT_RUNTIME_SHARE))
-		return;
-
-	if (rt_rq->rt_time > rt_rq->rt_runtime) {
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-		do_balance_runtime(rt_rq);
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-	}
-}
-
-static int do_sched_rt_period_timer(struct rt_bandwidth *rt_b, int overrun)
-{
-	int i, idle = 1, throttled = 0;
-	const struct cpumask *span;
-
-	span = sched_rt_period_mask();
-
-	/*
-	 * FIXME: isolated CPUs should really leave the root task group,
-	 * whether they are isolcpus or were isolated via cpusets, lest
-	 * the timer run on a CPU which does not service all runqueues,
-	 * potentially leaving other CPUs indefinitely throttled.  If
-	 * isolation is really required, the user will turn the throttle
-	 * off to kill the perturbations it causes anyway.  Meanwhile,
-	 * this maintains functionality for boot and/or troubleshooting.
-	 */
-	if (rt_b == &root_task_group.rt_bandwidth)
-		span = cpu_online_mask;
-
-	for_each_cpu(i, span) {
-		int enqueue = 0;
-		struct rt_rq *rt_rq = sched_rt_period_rt_rq(rt_b, i);
-		struct rq *rq = rq_of_rt_rq(rt_rq);
-		struct rq_flags rf;
-		int skip;
-
-		/*
-		 * When span == cpu_online_mask, taking each rq->lock
-		 * can be time-consuming. Try to avoid it when possible.
-		 */
-		raw_spin_lock(&rt_rq->rt_runtime_lock);
-		if (!sched_feat(RT_RUNTIME_SHARE) && rt_rq->rt_runtime != RUNTIME_INF)
-			rt_rq->rt_runtime = rt_b->rt_runtime;
-		skip = !rt_rq->rt_time && !rt_rq->rt_nr_running;
-		raw_spin_unlock(&rt_rq->rt_runtime_lock);
-		if (skip)
-			continue;
-
-		rq_lock(rq, &rf);
-		update_rq_clock(rq);
-
-		if (rt_rq->rt_time) {
-			u64 runtime;
-
-			raw_spin_lock(&rt_rq->rt_runtime_lock);
-			if (rt_rq->rt_throttled)
-				balance_runtime(rt_rq);
-			runtime = rt_rq->rt_runtime;
-			rt_rq->rt_time -= min(rt_rq->rt_time, overrun*runtime);
-			if (rt_rq->rt_throttled && rt_rq->rt_time < runtime) {
-				rt_rq->rt_throttled = 0;
-				enqueue = 1;
-
-				/*
-				 * When we're idle and a woken (rt) task is
-				 * throttled wakeup_preempt() will set
-				 * skip_update and the time between the wakeup
-				 * and this unthrottle will get accounted as
-				 * 'runtime'.
-				 */
-				if (rt_rq->rt_nr_running && rq->curr == rq->idle)
-					rq_clock_cancel_skipupdate(rq);
-			}
-			if (rt_rq->rt_time || rt_rq->rt_nr_running)
-				idle = 0;
-			raw_spin_unlock(&rt_rq->rt_runtime_lock);
-		} else if (rt_rq->rt_nr_running) {
-			idle = 0;
-			if (!rt_rq_throttled(rt_rq))
-				enqueue = 1;
-		}
-		if (rt_rq->rt_throttled)
-			throttled = 1;
-
-		if (enqueue)
-			sched_rt_rq_enqueue(rt_rq);
-		rq_unlock(rq, &rf);
-	}
-
-	if (!throttled && (!rt_bandwidth_enabled() || rt_b->rt_runtime == RUNTIME_INF))
-		return 1;
-
-	return idle;
-}
-
-static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
-{
-	u64 runtime = sched_rt_runtime(rt_rq);
-
-	if (rt_rq->rt_throttled)
-		return rt_rq_throttled(rt_rq);
-
-	if (runtime >= sched_rt_period(rt_rq))
-		return 0;
-
-	balance_runtime(rt_rq);
-	runtime = sched_rt_runtime(rt_rq);
-	if (runtime == RUNTIME_INF)
-		return 0;
-
-	if (rt_rq->rt_time > runtime) {
-		struct rt_bandwidth *rt_b = sched_rt_bandwidth(rt_rq);
-
-		/*
-		 * Don't actually throttle groups that have no runtime assigned
-		 * but accrue some time due to boosting.
-		 */
-		if (likely(rt_b->rt_runtime)) {
-			rt_rq->rt_throttled = 1;
-			printk_deferred_once("sched: RT throttling activated\n");
-		} else {
-			/*
-			 * In case we did anyway, make it go away,
-			 * replenishment is a joke, since it will replenish us
-			 * with exactly 0 ns.
-			 */
-			rt_rq->rt_time = 0;
-		}
-
-		if (rt_rq_throttled(rt_rq)) {
-			sched_rt_rq_dequeue(rt_rq);
-			return 1;
-		}
-	}
-
-	return 0;
-}
-
-#else /* !CONFIG_RT_GROUP_SCHED: */
+#else /* !CONFIG_RT_GROUP_SCHED */
 
 typedef struct rt_rq *rt_rq_iter_t;
 
 #define for_each_rt_rq(rt_rq, iter, rq) \
 	for ((void) iter, rt_rq = &rq->rt; rt_rq; rt_rq = NULL)
 
-#define for_each_sched_rt_entity(rt_se) \
-	for (; rt_se; rt_se = NULL)
-
-static inline struct rt_rq *group_rt_rq(struct sched_rt_entity *rt_se)
-{
-	return NULL;
-}
-
-static inline void sched_rt_rq_enqueue(struct rt_rq *rt_rq)
-{
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-
-	if (!rt_rq->rt_nr_running)
-		return;
-
-	enqueue_top_rt_rq(rt_rq);
-	resched_curr(rq);
-}
-
-static inline void sched_rt_rq_dequeue(struct rt_rq *rt_rq)
-{
-	dequeue_top_rt_rq(rt_rq, rt_rq->rt_nr_running);
-}
-
-static inline int rt_rq_throttled(struct rt_rq *rt_rq)
-{
-	return false;
-}
-
-static inline const struct cpumask *sched_rt_period_mask(void)
-{
-	return cpu_online_mask;
-}
-
-static inline
-struct rt_rq *sched_rt_period_rt_rq(struct rt_bandwidth *rt_b, int cpu)
-{
-	return &cpu_rq(cpu)->rt;
-}
-
-static void __enable_runtime(struct rq *rq) { }
-static void __disable_runtime(struct rq *rq) { }
-
-#endif /* !CONFIG_RT_GROUP_SCHED */
+#endif /* CONFIG_RT_GROUP_SCHED */
 
 static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
-	struct rt_rq *rt_rq = group_rt_rq(rt_se);
-
-	if (rt_rq)
-		return rt_rq->highest_prio.curr;
-#endif
-
 	return rt_task_of(rt_se)->prio;
 }
 
@@ -943,67 +350,8 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return;
 
-#ifdef CONFIG_RT_GROUP_SCHED
-	struct sched_rt_entity *rt_se = &donor->rt;
-
 	if (!rt_bandwidth_enabled())
 		return;
-
-	for_each_sched_rt_entity(rt_se) {
-		struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
-		int exceeded;
-
-		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
-			raw_spin_lock(&rt_rq->rt_runtime_lock);
-			rt_rq->rt_time += delta_exec;
-			exceeded = sched_rt_runtime_exceeded(rt_rq);
-			if (exceeded)
-				resched_curr(rq);
-			raw_spin_unlock(&rt_rq->rt_runtime_lock);
-			if (exceeded)
-				do_start_rt_bandwidth(sched_rt_bandwidth(rt_rq));
-		}
-	}
-#endif /* CONFIG_RT_GROUP_SCHED */
-}
-
-static void
-dequeue_top_rt_rq(struct rt_rq *rt_rq, unsigned int count)
-{
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-
-	BUG_ON(&rq->rt != rt_rq);
-
-	if (!rt_rq->rt_queued)
-		return;
-
-	BUG_ON(!rq->nr_running);
-
-	sub_nr_running(rq, count);
-	rt_rq->rt_queued = 0;
-
-}
-
-static void
-enqueue_top_rt_rq(struct rt_rq *rt_rq)
-{
-	struct rq *rq = rq_of_rt_rq(rt_rq);
-
-	BUG_ON(&rq->rt != rt_rq);
-
-	if (rt_rq->rt_queued)
-		return;
-
-	if (rt_rq_throttled(rt_rq))
-		return;
-
-	if (rt_rq->rt_nr_running) {
-		add_nr_running(rq, rt_rq->rt_nr_running);
-		rt_rq->rt_queued = 1;
-	}
-
-	/* Kick cpufreq (see the comment in kernel/sched/sched.h). */
-	cpufreq_update_util(rq, 0);
 }
 
 static void
@@ -1074,58 +422,11 @@ dec_rt_prio(struct rt_rq *rt_rq, int prio)
 	dec_rt_prio_smp(rt_rq, prio, prev_prio);
 }
 
-#ifdef CONFIG_RT_GROUP_SCHED
-
-static void
-inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
-{
-	if (rt_se_boosted(rt_se))
-		rt_rq->rt_nr_boosted++;
-
-	start_rt_bandwidth(&rt_rq->tg->rt_bandwidth);
-}
-
-static void
-dec_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
-{
-	if (rt_se_boosted(rt_se))
-		rt_rq->rt_nr_boosted--;
-
-	WARN_ON(!rt_rq->rt_nr_running && rt_rq->rt_nr_boosted);
-}
-
-#else /* !CONFIG_RT_GROUP_SCHED: */
-
-static void
-inc_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
-{
-}
-
-static inline
-void dec_rt_group(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq) {}
-
-#endif /* !CONFIG_RT_GROUP_SCHED */
-
 static inline
-unsigned int rt_se_nr_running(struct sched_rt_entity *rt_se)
+unsigned int is_rr_task(struct sched_rt_entity *rt_se)
 {
-	struct rt_rq *group_rq = group_rt_rq(rt_se);
-
-	if (group_rq)
-		return group_rq->rt_nr_running;
-	else
-		return 1;
-}
-
-static inline
-unsigned int rt_se_rr_nr_running(struct sched_rt_entity *rt_se)
-{
-	struct rt_rq *group_rq = group_rt_rq(rt_se);
 	struct task_struct *tsk;
 
-	if (group_rq)
-		return group_rq->rr_nr_running;
-
 	tsk = rt_task_of(rt_se);
 
 	return (tsk->policy == SCHED_RR) ? 1 : 0;
@@ -1134,26 +435,21 @@ unsigned int rt_se_rr_nr_running(struct sched_rt_entity *rt_se)
 static inline
 void inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
-	int prio = rt_se_prio(rt_se);
-
-	WARN_ON(!rt_prio(prio));
-	rt_rq->rt_nr_running += rt_se_nr_running(rt_se);
-	rt_rq->rr_nr_running += rt_se_rr_nr_running(rt_se);
+	WARN_ON(!rt_prio(rt_se_prio(rt_se)));
+	rt_rq->rt_nr_running += 1;
+	rt_rq->rr_nr_running += is_rr_task(rt_se);
 
-	inc_rt_prio(rt_rq, prio);
-	inc_rt_group(rt_se, rt_rq);
+	inc_rt_prio(rt_rq, rt_se_prio(rt_se));
 }
 
 static inline
 void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 {
 	WARN_ON(!rt_prio(rt_se_prio(rt_se)));
-	WARN_ON(!rt_rq->rt_nr_running);
-	rt_rq->rt_nr_running -= rt_se_nr_running(rt_se);
-	rt_rq->rr_nr_running -= rt_se_rr_nr_running(rt_se);
+	rt_rq->rt_nr_running -= 1;
+	rt_rq->rr_nr_running -= is_rr_task(rt_se);
 
 	dec_rt_prio(rt_rq, rt_se_prio(rt_se));
-	dec_rt_group(rt_se, rt_rq);
 }
 
 /*
@@ -1182,10 +478,6 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 static inline struct sched_statistics *
 __schedstats_from_rt_se(struct sched_rt_entity *rt_se)
 {
-	/* schedstats is not supported for rt group. */
-	if (!rt_entity_is_task(rt_se))
-		return NULL;
-
 	return &rt_task_of(rt_se)->stats;
 }
 
@@ -1198,9 +490,7 @@ update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
+	p = rt_task_of(rt_se);
 	stats = __schedstats_from_rt_se(rt_se);
 	if (!stats)
 		return;
@@ -1217,9 +507,7 @@ update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
+	p = rt_task_of(rt_se);
 	stats = __schedstats_from_rt_se(rt_se);
 	if (!stats)
 		return;
@@ -1247,9 +535,7 @@ update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se))
-		p = rt_task_of(rt_se);
-
+	p = rt_task_of(rt_se);
 	stats = __schedstats_from_rt_se(rt_se);
 	if (!stats)
 		return;
@@ -1267,12 +553,10 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 	if (!schedstat_enabled())
 		return;
 
-	if (rt_entity_is_task(rt_se)) {
-		p = rt_task_of(rt_se);
+	p = rt_task_of(rt_se);
 
-		if (p != rq->curr)
-			update_stats_wait_end_rt(rt_rq, rt_se);
-	}
+	if (p != rq->curr)
+		update_stats_wait_end_rt(rt_rq, rt_se);
 
 	if ((flags & DEQUEUE_SLEEP) && p) {
 		unsigned int state;
@@ -1292,21 +576,8 @@ static void __enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 {
 	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);
 	struct rt_prio_array *array = &rt_rq->active;
-	struct rt_rq *group_rq = group_rt_rq(rt_se);
 	struct list_head *queue = array->queue + rt_se_prio(rt_se);
 
-	/*
-	 * Don't enqueue the group if its throttled, or when empty.
-	 * The latter is a consequence of the former when a child group
-	 * get throttled and the current group doesn't have any other
-	 * active members.
-	 */
-	if (group_rq && (rt_rq_throttled(group_rq) || !group_rq->rt_nr_running)) {
-		if (rt_se->on_list)
-			__delist_rt_entity(rt_se, array);
-		return;
-	}
-
 	if (move_entity(flags)) {
 		WARN_ON_ONCE(rt_se->on_list);
 		if (flags & ENQUEUE_HEAD)
@@ -1336,57 +607,18 @@ static void __dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flag
 	dec_rt_tasks(rt_se, rt_rq);
 }
 
-/*
- * Because the prio of an upper entry depends on the lower
- * entries, we must remove entries top - down.
- */
-static void dequeue_rt_stack(struct sched_rt_entity *rt_se, unsigned int flags)
-{
-	struct sched_rt_entity *back = NULL;
-	unsigned int rt_nr_running;
-
-	for_each_sched_rt_entity(rt_se) {
-		rt_se->back = back;
-		back = rt_se;
-	}
-
-	rt_nr_running = rt_rq_of_se(back)->rt_nr_running;
-
-	for (rt_se = back; rt_se; rt_se = rt_se->back) {
-		if (on_rt_rq(rt_se))
-			__dequeue_rt_entity(rt_se, flags);
-	}
-
-	dequeue_top_rt_rq(rt_rq_of_se(back), rt_nr_running);
-}
-
 static void enqueue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
-	struct rq *rq = rq_of_rt_se(rt_se);
-
 	update_stats_enqueue_rt(rt_rq_of_se(rt_se), rt_se, flags);
 
-	dequeue_rt_stack(rt_se, flags);
-	for_each_sched_rt_entity(rt_se)
-		__enqueue_rt_entity(rt_se, flags);
-	enqueue_top_rt_rq(&rq->rt);
+	__enqueue_rt_entity(rt_se, flags);
 }
 
 static void dequeue_rt_entity(struct sched_rt_entity *rt_se, unsigned int flags)
 {
-	struct rq *rq = rq_of_rt_se(rt_se);
-
 	update_stats_dequeue_rt(rt_rq_of_se(rt_se), rt_se, flags);
 
-	dequeue_rt_stack(rt_se, flags);
-
-	for_each_sched_rt_entity(rt_se) {
-		struct rt_rq *rt_rq = group_rt_rq(rt_se);
-
-		if (rt_rq && rt_rq->rt_nr_running)
-			__enqueue_rt_entity(rt_se, flags);
-	}
-	enqueue_top_rt_rq(&rq->rt);
+	__dequeue_rt_entity(rt_se, flags);
 }
 
 /*
@@ -1446,13 +678,7 @@ requeue_rt_entity(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se, int head)
 
 static void requeue_task_rt(struct rq *rq, struct task_struct *p, int head)
 {
-	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq;
-
-	for_each_sched_rt_entity(rt_se) {
-		rt_rq = rt_rq_of_se(rt_se);
-		requeue_rt_entity(rt_rq, rt_se, head);
-	}
+	requeue_rt_entity(rt_rq_of_se(&p->rt), &p->rt, head);
 }
 
 static void yield_task_rt(struct rq *rq)
@@ -1653,21 +879,6 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
 	return next;
 }
 
-static struct task_struct *_pick_next_task_rt(struct rq *rq)
-{
-	struct sched_rt_entity *rt_se;
-	struct rt_rq *rt_rq  = &rq->rt;
-
-	do {
-		rt_se = pick_next_rt_entity(rt_rq);
-		if (unlikely(!rt_se))
-			return NULL;
-		rt_rq = group_rt_rq(rt_se);
-	} while (rt_rq);
-
-	return rt_task_of(rt_se);
-}
-
 static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *p;
@@ -1675,7 +886,7 @@ static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 	if (!sched_rt_runnable(rq))
 		return NULL;
 
-	p = _pick_next_task_rt(rq);
+	p = rt_task_of(pick_next_rt_entity(&rq->rt));
 
 	return p;
 }
@@ -2358,8 +1569,6 @@ static void rq_online_rt(struct rq *rq)
 	if (rq->rt.overloaded)
 		rt_set_overload(rq);
 
-	__enable_runtime(rq);
-
 	cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 }
 
@@ -2369,8 +1578,6 @@ static void rq_offline_rt(struct rq *rq)
 	if (rq->rt.overloaded)
 		rt_clear_overload(rq);
 
-	__disable_runtime(rq);
-
 	cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);
 }
 
@@ -2531,12 +1738,10 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
 	 * Requeue to the end of queue if we (and all of our ancestors) are not
 	 * the only element on the queue
 	 */
-	for_each_sched_rt_entity(rt_se) {
-		if (rt_se->run_list.prev != rt_se->run_list.next) {
-			requeue_task_rt(rq, p, 0);
-			resched_curr(rq);
-			return;
-		}
+	if (rt_se->run_list.prev != rt_se->run_list.next) {
+		requeue_task_rt(rq, p, 0);
+		resched_curr(rq);
+		return;
 	}
 }
 
@@ -2554,16 +1759,7 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 #ifdef CONFIG_SCHED_CORE
 static int task_is_throttled_rt(struct task_struct *p, int cpu)
 {
-	struct rt_rq *rt_rq;
-
-#ifdef CONFIG_RT_GROUP_SCHED // XXX maybe add task_rt_rq(), see also sched_rt_period_rt_rq
-	rt_rq = task_group(p)->rt_rq[cpu];
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
-#else
-	rt_rq = &cpu_rq(cpu)->rt;
-#endif
-
-	return rt_rq_throttled(rt_rq);
+	return 0;
 }
 #endif /* CONFIG_SCHED_CORE */
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a03866f68a3b..a217c4ab6660 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -827,7 +827,7 @@ struct scx_rq {
 
 static inline int rt_bandwidth_enabled(void)
 {
-	return sysctl_sched_rt_runtime >= 0;
+	return 0;
 }
 
 /* RT IPI pull logic requires IRQ_WORK */
@@ -867,7 +867,7 @@ struct rt_rq {
 
 static inline bool rt_rq_is_runnable(struct rt_rq *rt_rq)
 {
-	return rt_rq->rt_queued && rt_rq->rt_nr_running;
+	return rt_rq->rt_nr_running;
 }
 
 /* Deadline class' related fields in a runqueue */
@@ -2794,7 +2794,7 @@ static inline bool sched_dl_runnable(struct rq *rq)
 
 static inline bool sched_rt_runnable(struct rq *rq)
 {
-	return rq->rt.rt_queued > 0;
+	return rq->rt.rt_nr_running > 0;
 }
 
 static inline bool sched_fair_runnable(struct rq *rq)
@@ -2906,9 +2906,6 @@ extern void resched_curr(struct rq *rq);
 extern void resched_curr_lazy(struct rq *rq);
 extern void resched_cpu(int cpu);
 
-extern void init_rt_bandwidth(struct rt_bandwidth *rt_b, u64 period, u64 runtime);
-extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
-
 extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
 extern void init_cfs_throttle_work(struct task_struct *p);
@@ -3333,12 +3330,8 @@ extern void set_rq_offline(struct rq *rq);
 extern bool sched_smp_initialized;
 
 #ifdef CONFIG_RT_GROUP_SCHED
-#define rt_entity_is_task(rt_se) (!(rt_se)->my_q)
-
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
-	WARN_ON_ONCE(!rt_entity_is_task(rt_se));
-
 	return container_of_const(rt_se, struct task_struct, rt);
 }
 
@@ -3354,17 +3347,7 @@ static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 	WARN_ON(!rt_group_sched_enabled() && rt_se->rt_rq->tg != &root_task_group);
 	return rt_se->rt_rq;
 }
-
-static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
-{
-	struct rt_rq *rt_rq = rt_se->rt_rq;
-
-	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
-	return rt_rq->rq;
-}
 #else
-#define rt_entity_is_task(rt_se) (1)
-
 static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)
 {
 	return container_of_const(rt_se, struct task_struct, rt);
@@ -3375,16 +3358,9 @@ static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 	return container_of_const(rt_rq, struct rq, rt);
 }
 
-static inline struct rq *rq_of_rt_se(struct sched_rt_entity *rt_se)
-{
-	struct task_struct *p = rt_task_of(rt_se);
-
-	return task_rq(p);
-}
-
 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 {
-	struct rq *rq = rq_of_rt_se(rt_se);
+	struct rq *rq = task_rq(rt_task_of(rt_se));
 
 	return &rq->rt;
 }
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index b215b0ead9a6..9c1ba10ea5a7 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -606,19 +606,6 @@ int __sched_setscheduler(struct task_struct *p,
 change:
 
 	if (user) {
-#ifdef CONFIG_RT_GROUP_SCHED
-		/*
-		 * Do not allow real-time tasks into groups that have no runtime
-		 * assigned.
-		 */
-		if (rt_group_sched_enabled() &&
-				rt_bandwidth_enabled() && rt_policy(policy) &&
-				task_group(p)->rt_bandwidth.rt_runtime == 0 &&
-				!task_group_is_autogroup(task_group(p))) {
-			retval = -EPERM;
-			goto unlock;
-		}
-#endif /* CONFIG_RT_GROUP_SCHED */
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
 			cpumask_t *span = rq->rd->span;
-- 
2.54.0


