Return-Path: <cgroups+bounces-16707-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5n5oKpqzJmq8bQIAu9opvQ
	(envelope-from <cgroups+bounces-16707-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A843656159
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=G+osm++j;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16707-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16707-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01FD4306F9F1
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631953793D5;
	Mon,  8 Jun 2026 12:15:57 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D488837AA72
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920957; cv=none; b=fJPuS33fZmJgfg/+7ELum3gRzA5jrcg24NFVas8nxdvAPPtuU48YGgmkSOFDyoOocxNJkNV/5LUjCCrZaHFgQudKe+RrsnVtCOAg+aBDcI2AG9jEycwt+WEyO2B5zpT3OGzt0+2776y1P/FIzYS33hImO53WkLWyaS1V/m6SICA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920957; c=relaxed/simple;
	bh=+6NNVyOAj+MiG/3rsdS2krfz8Ku9XuCIg24dZR7/GR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKcaWfShIlqMglx7RjY7XVwiMcdiFVCRiwtW3Cz912+wpquopR074YHyiESyDeZ2Tyrn5LyXyuOAHSIvx9RX37wNmCLAHqJNAK+oqXka8d6zPsiIXCTRA4wNjXiqYWiGDOWeJb9Bw04adhzBMH9ih0Tq+5dXUJj9x42OeOi9CWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+osm++j; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45eeea039ebso2184525f8f.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920952; x=1781525752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5ogVvmPvhphEqQWbqzhUkign6lvp8DgfpN6HVT+Wd4=;
        b=G+osm++jZ3m7VCwwxA0UAwuPB5sC5mHbjFdyYwMdQXMfYa9i3o6WkbX9cYiXR2HzCb
         956PH21ODi2asSkHHWbA2hjtVoCwJUfiwpnlVinmnmZzAojZLam/mq5lIWds1/4a4BG+
         /tlWf+n9TDbDVPZsx/Umie4oZPnq/V18hWFROWduqZInwmjQ7uEOm8mIsZqs4m/dq9t5
         a4Wgwjn67eWl/MOARK01jQETX/ne0KqWXB8eX8PJNjbKnUebT9qNUGazMdsKr6afIz0a
         J4M8PCcwZDn92SsBCnaTDGHk3Zy72mzWF9IwsGy2RRk5toMRm6zXpX7osqY0Y7Fga1P9
         pbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920952; x=1781525752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m5ogVvmPvhphEqQWbqzhUkign6lvp8DgfpN6HVT+Wd4=;
        b=h+kWZEtrwNb4mm9ql//LP1edJ2TPTiWPYx527FPQoNrrw1+9y2Q+zelQ1EjElns0Vu
         d15alQaeJ6da1JzW2DqXPcw1C5cwilaci3QpCnU5MATmZk2+u7MIKqceBU8VgAwHFQki
         7vZdUbE8LAPw784wXi23Lx/+QGa6GHDNLrLBDFa/PYU5woMaG0qtOTpaRjO/Cf/Ph6N7
         7a3SjQi3BrLGkh5MqR1fvJoeCnOe7qt/PdLoAqXobAmppUau8Xn8hQXKdH/oU9jZ1WZl
         nIht9C36k9nK0mr7EFvmZItzbCavacqVN4IoCJcOiaH6/wgfFb2LEz0HqsaRJN5bnhad
         /0PA==
X-Gm-Message-State: AOJu0Yw+YZUN8HTUjykpsLNn/yJpKXArB+osPctmWDkAiVH22wrt3JH7
	Kx8L7OBQSAUXesrzfOqrMb6VIzhl53ZSqgFtvtmT751wRsbhcx3oFhyX
X-Gm-Gg: Acq92OESbKEcWRE1UkwM7Em8fO2rfXjZ9OJRDM0JTVh2uxnm9Ujcu7Z9FQwtMnkzBg1
	NIkmZ0OEh2tLXZCK3a2Ej1RbOdqAWMnP8hXstNar3waKwC8uth5+FIR5v1daVNNVWLIw1NqVB0+
	hhOhqP3E3uZu2cWQcCIM21a8jdY2xmLf+WI2J3z6i0NAxLHuDLqY6VUxKnXN1uPcL+E9b2bX5pv
	slJWgVz/I/kF/JVmhCxSoE1yBgn0n6nhE/aKZDFFsHahr2xibJYo4RKm6YnX69NcnUTkIdQEm4H
	GExw73K4xuIMjICmx0a58rx0B2af6W2+6NHqCrCPVkvaGQ7izlNOgGuC/L0r4YACCwj5VkgjF03
	/v0I3tHVbqidyijF6O0VsYiibmSxzync/YK9WGSOtsGuaLWbBdm7WKAm6COI/NFWRMob1AltNYI
	3QurgQjXDiqtIldYXseZdJMX/+b9auH0g=
X-Received: by 2002:a05:6000:22c5:b0:45e:f68d:e791 with SMTP id ffacd0b85a97d-46030182afdmr24324224f8f.0.1780920952250;
        Mon, 08 Jun 2026 05:15:52 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:51 -0700 (PDT)
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
Subject: [RFC PATCH v6 05/25] sched/rt: Pass an rt_rq instead of an rq where needed
Date: Mon,  8 Jun 2026 14:15:24 +0200
Message-ID: <20260608121546.69910-6-yurand2000@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-16707-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mingo@redhat.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:dietmar.eggemann@arm.com,m:rostedt@goodmis.org,m:bsegall@google.com,m:mgorman@suse.de,m:vschneid@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luca.abeni@santannapisa.it,m:yuri.andriaccio@santannapisa.it,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yurand2000@gmail.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,santannapisa.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A843656159

From: luca abeni <luca.abeni@santannapisa.it>

Make rt.c code access the runqueue through the rt_rq data structure rather
than passing an rq pointer directly. This allows future patches to define
rt_rq data structures which do not refer only to the global runqueue, but
also to local cgroup runqueues (as rt_rq will not be always equal to
&rq->rt).

Co-developed-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
---
 kernel/sched/rt.c | 169 +++++++++++++++++++++++++++-------------------
 1 file changed, 100 insertions(+), 69 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index e6ea728f519e..0f0d9c283bd4 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -370,9 +370,9 @@ static inline void rt_clear_overload(struct rq *rq)
 	cpumask_clear_cpu(rq->cpu, rq->rd->rto_mask);
 }

-static inline int has_pushable_tasks(struct rq *rq)
+static inline int has_pushable_tasks(struct rt_rq *rt_rq)
 {
-	return !plist_head_empty(&rq->rt.pushable_tasks);
+	return !plist_head_empty(&rt_rq->pushable_tasks);
 }

 static DEFINE_PER_CPU(struct balance_callback, rt_push_head);
@@ -381,50 +381,66 @@ static DEFINE_PER_CPU(struct balance_callback, rt_pull_head);
 static void push_rt_tasks(struct rq *);
 static void pull_rt_task(struct rq *);

-static inline void rt_queue_push_tasks(struct rq *rq)
+static inline void rt_queue_push_tasks(struct rt_rq *rt_rq)
 {
-	if (!has_pushable_tasks(rq))
+	struct rq *rq = container_of_const(rt_rq, struct rq, rt);
+
+	if (!has_pushable_tasks(rt_rq))
 		return;

 	queue_balance_callback(rq, &per_cpu(rt_push_head, rq->cpu), push_rt_tasks);
 }

-static inline void rt_queue_pull_task(struct rq *rq)
+static inline void rt_queue_pull_task(struct rt_rq *rt_rq)
 {
+	struct rq *rq = container_of_const(rt_rq, struct rq, rt);
+
 	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
 }

-static void enqueue_pushable_task(struct rq *rq, struct task_struct *p)
+static void push_rt_rq_tasks(struct rt_rq *rt_rq);
+
+static void push_rt_tasks(struct rq *global_rq) {
+	push_rt_rq_tasks(&global_rq->rt);
+}
+
+static void pull_rt_rq_task(struct rt_rq *this_rt_rq);
+
+static void pull_rt_task(struct rq *global_rq) {
+	pull_rt_rq_task(&global_rq->rt);
+}
+
+static void enqueue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 {
-	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
+	plist_del(&p->pushable_tasks, &rt_rq->pushable_tasks);
 	plist_node_init(&p->pushable_tasks, p->prio);
-	plist_add(&p->pushable_tasks, &rq->rt.pushable_tasks);
+	plist_add(&p->pushable_tasks, &rt_rq->pushable_tasks);

 	/* Update the highest prio pushable task */
-	if (p->prio < rq->rt.highest_prio.next)
-		rq->rt.highest_prio.next = p->prio;
+	if (p->prio < rt_rq->highest_prio.next)
+		rt_rq->highest_prio.next = p->prio;

-	if (!rq->rt.overloaded) {
-		rt_set_overload(rq);
-		rq->rt.overloaded = 1;
+	if (!rt_rq->overloaded) {
+		rt_set_overload(rq_of_rt_rq(rt_rq));
+		rt_rq->overloaded = 1;
 	}
 }

-static void dequeue_pushable_task(struct rq *rq, struct task_struct *p)
+static void dequeue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 {
-	plist_del(&p->pushable_tasks, &rq->rt.pushable_tasks);
+	plist_del(&p->pushable_tasks, &rt_rq->pushable_tasks);

 	/* Update the new highest prio pushable task */
-	if (has_pushable_tasks(rq)) {
-		p = plist_first_entry(&rq->rt.pushable_tasks,
+	if (has_pushable_tasks(rt_rq)) {
+		p = plist_first_entry(&rt_rq->pushable_tasks,
 				      struct task_struct, pushable_tasks);
-		rq->rt.highest_prio.next = p->prio;
+		rt_rq->highest_prio.next = p->prio;
 	} else {
-		rq->rt.highest_prio.next = MAX_RT_PRIO-1;
+		rt_rq->highest_prio.next = MAX_RT_PRIO-1;

-		if (rq->rt.overloaded) {
-			rt_clear_overload(rq);
-			rq->rt.overloaded = 0;
+		if (rt_rq->overloaded) {
+			rt_clear_overload(rq_of_rt_rq(rt_rq));
+			rt_rq->overloaded = 0;
 		}
 	}
 }
@@ -1436,6 +1452,7 @@ static void
 enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);

 	if (flags & ENQUEUE_WAKEUP)
 		rt_se->timeout = 0;
@@ -1449,17 +1466,18 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 		return;

 	if (!task_current(rq, p) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
+		enqueue_pushable_task(rt_rq, p);
 }

 static bool dequeue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(rt_se);

 	update_curr_rt(rq);
 	dequeue_rt_entity(rt_se, flags);

-	dequeue_pushable_task(rq, p);
+	dequeue_pushable_task(rt_rq, p);

 	return true;
 }
@@ -1498,7 +1516,7 @@ static void yield_task_rt(struct rq *rq)
 	requeue_task_rt(rq, rq->donor, 0);
 }

-static int find_lowest_rq(struct task_struct *task);
+static int find_lowest_rt_rq(struct task_struct *task);

 static int
 select_task_rq_rt(struct task_struct *p, int cpu, int flags)
@@ -1548,7 +1566,7 @@ select_task_rq_rt(struct task_struct *p, int cpu, int flags)
 	       (curr->nr_cpus_allowed < 2 || donor->prio <= p->prio);

 	if (test || !rt_task_fits_capacity(p, cpu)) {
-		int target = find_lowest_rq(p);
+		int target = find_lowest_rt_rq(p);

 		/*
 		 * Bail out if we were forcing a migration to find a better
@@ -1606,7 +1624,7 @@ static int balance_rt(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 		 * not yet started the picking loop.
 		 */
 		rq_unpin_lock(rq, rf);
-		pull_rt_task(rq);
+		pull_rt_rq_task(&rq->rt);
 		rq_repin_lock(rq, rf);
 	}

@@ -1650,14 +1668,14 @@ static void wakeup_preempt_rt(struct rq *rq, struct task_struct *p, int flags)
 static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool first)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq = &rq->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);

 	p->se.exec_start = rq_clock_task(rq);
 	if (on_rt_rq(&p->rt))
 		update_stats_wait_end_rt(rt_rq, rt_se);

 	/* The running task is never eligible for pushing */
-	dequeue_pushable_task(rq, p);
+	dequeue_pushable_task(rt_rq, p);

 	if (!first)
 		return;
@@ -1670,7 +1688,7 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
 	if (rq->donor->sched_class != &rt_sched_class)
 		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);

-	rt_queue_push_tasks(rq);
+	rt_queue_push_tasks(rt_rq);
 }

 static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
@@ -1721,7 +1739,7 @@ static struct task_struct *pick_task_rt(struct rq *rq, struct rq_flags *rf)
 static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_struct *next)
 {
 	struct sched_rt_entity *rt_se = &p->rt;
-	struct rt_rq *rt_rq = &rq->rt;
+	struct rt_rq *rt_rq = rt_rq_of_se(&p->rt);

 	if (on_rt_rq(&p->rt))
 		update_stats_wait_start_rt(rt_rq, rt_se);
@@ -1737,7 +1755,7 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
 	 * if it is still active
 	 */
 	if (on_rt_rq(&p->rt) && p->nr_cpus_allowed > 1)
-		enqueue_pushable_task(rq, p);
+		enqueue_pushable_task(rt_rq, p);
 }

 /* Only try algorithms three times */
@@ -1747,16 +1765,16 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p, struct task_s
  * Return the highest pushable rq's task, which is suitable to be executed
  * on the CPU, NULL otherwise
  */
-static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
+static struct task_struct *pick_highest_pushable_task(struct rt_rq *rt_rq, int cpu)
 {
-	struct plist_head *head = &rq->rt.pushable_tasks;
+	struct plist_head *head = &rt_rq->pushable_tasks;
 	struct task_struct *p;

-	if (!has_pushable_tasks(rq))
+	if (!has_pushable_tasks(rt_rq))
 		return NULL;

 	plist_for_each_entry(p, head, pushable_tasks) {
-		if (task_is_pushable(rq, p, cpu))
+		if (task_is_pushable(rq_of_rt_rq(rt_rq), p, cpu))
 			return p;
 	}

@@ -1765,7 +1783,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)

 static DEFINE_PER_CPU(cpumask_var_t, local_cpu_mask);

-static int find_lowest_rq(struct task_struct *task)
+static int find_lowest_rt_rq(struct task_struct *task)
 {
 	struct sched_domain *sd;
 	struct cpumask *lowest_mask = this_cpu_cpumask_var_ptr(local_cpu_mask);
@@ -1856,12 +1874,13 @@ static int find_lowest_rq(struct task_struct *task)
 	return -1;
 }

-static struct task_struct *pick_next_pushable_task(struct rq *rq)
+static struct task_struct *pick_next_pushable_task(struct rt_rq *rt_rq)
 {
-	struct plist_head *head = &rq->rt.pushable_tasks;
+	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct plist_head *head = &rt_rq->pushable_tasks;
 	struct task_struct *i, *p = NULL;

-	if (!has_pushable_tasks(rq))
+	if (!has_pushable_tasks(rt_rq))
 		return NULL;

 	plist_for_each_entry(i, head, pushable_tasks) {
@@ -1887,14 +1906,15 @@ static struct task_struct *pick_next_pushable_task(struct rq *rq)
 }

 /* Will lock the rq it finds */
-static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
+static struct rt_rq *find_lock_lowest_rt_rq(struct task_struct *task, struct rt_rq *rt_rq)
 {
+	struct rq *rq = rq_of_rt_rq(rt_rq);
 	struct rq *lowest_rq = NULL;
 	int tries;
 	int cpu;

 	for (tries = 0; tries < RT_MAX_TRIES; tries++) {
-		cpu = find_lowest_rq(task);
+		cpu = find_lowest_rt_rq(task);

 		if ((cpu == -1) || (cpu == rq->cpu))
 			break;
@@ -1925,7 +1945,7 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 			 */
 			if (unlikely(is_migration_disabled(task) ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task != pick_next_pushable_task(rq))) {
+				     task != pick_next_pushable_task(rt_rq))) {

 				double_unlock_balance(rq, lowest_rq);
 				lowest_rq = NULL;
@@ -1942,7 +1962,13 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
 		lowest_rq = NULL;
 	}

-	return lowest_rq;
+	return &lowest_rq->rt;
+}
+
+static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq) {
+	struct rt_rq *rt_rq = find_lock_lowest_rt_rq(task, &rq->rt);
+
+	return rq_of_rt_rq(rt_rq);
 }

 /*
@@ -1950,16 +1976,17 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
  * running task can migrate over to a CPU that is running a task
  * of lesser priority.
  */
-static int push_rt_task(struct rq *rq, bool pull)
+static int push_rt_rq_task(struct rt_rq *rt_rq, bool pull)
 {
 	struct task_struct *next_task;
-	struct rq *lowest_rq;
+	struct rq *lowest_rq, *rq = rq_of_rt_rq(rt_rq);
+	struct rt_rq *lowest_rt_rq;
 	int ret = 0;

-	if (!rq->rt.overloaded)
+	if (!rt_rq->overloaded)
 		return 0;

-	next_task = pick_next_pushable_task(rq);
+	next_task = pick_next_pushable_task(rt_rq);
 	if (!next_task)
 		return 0;

@@ -1982,7 +2009,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 			return 0;

 		/*
-		 * Invoking find_lowest_rq() on anything but an RT task doesn't
+		 * Invoking find_lowest_rt_rq() on anything but an RT task doesn't
 		 * make sense. Per the above priority check, curr has to
 		 * be of higher priority than next_task, so no need to
 		 * reschedule when bailing out.
@@ -1993,7 +2020,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		if (rq->donor->sched_class != &rt_sched_class)
 			return 0;

-		cpu = find_lowest_rq(rq->curr);
+		cpu = find_lowest_rt_rq(rq->curr);
 		if (cpu == -1 || cpu == rq->cpu)
 			return 0;

@@ -2022,19 +2049,19 @@ static int push_rt_task(struct rq *rq, bool pull)
 	/* We might release rq lock */
 	get_task_struct(next_task);

-	/* find_lock_lowest_rq locks the rq if found */
-	lowest_rq = find_lock_lowest_rq(next_task, rq);
-	if (!lowest_rq) {
+	/* find_lock_lowest_rt_rq locks the rq if found */
+	lowest_rt_rq = find_lock_lowest_rt_rq(next_task, rt_rq);
+	if (!lowest_rt_rq) {
 		struct task_struct *task;
 		/*
-		 * find_lock_lowest_rq releases rq->lock
+		 * find_lock_lowest_rt_rq releases rq->lock
 		 * so it is possible that next_task has migrated.
 		 *
 		 * We need to make sure that the task is still on the same
 		 * run-queue and is also still the next task eligible for
 		 * pushing.
 		 */
-		task = pick_next_pushable_task(rq);
+		task = pick_next_pushable_task(rt_rq);
 		if (task == next_task) {
 			/*
 			 * The task hasn't migrated, and is still the next
@@ -2057,6 +2084,7 @@ static int push_rt_task(struct rq *rq, bool pull)
 		goto retry;
 	}

+	lowest_rq = rq_of_rt_rq(lowest_rt_rq);
 	move_queued_task_locked(rq, lowest_rq, next_task);
 	resched_curr(lowest_rq);
 	ret = 1;
@@ -2068,10 +2096,10 @@ static int push_rt_task(struct rq *rq, bool pull)
 	return ret;
 }

-static void push_rt_tasks(struct rq *rq)
+static void push_rt_rq_tasks(struct rt_rq *rt_rq)
 {
-	/* push_rt_task will return true if it moved an RT */
-	while (push_rt_task(rq, false))
+	/* push_rt_rq_task will return true if it moved an RT */
+	while (push_rt_rq_task(rt_rq, false))
 		;
 }

@@ -2227,9 +2255,9 @@ void rto_push_irq_work_func(struct irq_work *work)
 	 * We do not need to grab the lock to check for has_pushable_tasks.
 	 * When it gets updated, a check is made if a push is possible.
 	 */
-	if (has_pushable_tasks(rq)) {
+	if (has_pushable_tasks(&rq->rt)) {
 		raw_spin_rq_lock(rq);
-		while (push_rt_task(rq, true))
+		while (push_rt_rq_task(&rq->rt, true))
 			;
 		raw_spin_rq_unlock(rq);
 	}
@@ -2251,11 +2279,13 @@ void rto_push_irq_work_func(struct irq_work *work)
 }
 #endif /* HAVE_RT_PUSH_IPI */

-static void pull_rt_task(struct rq *this_rq)
+static void pull_rt_rq_task(struct rt_rq *this_rt_rq)
 {
+	struct rq *this_rq = rq_of_rt_rq(this_rt_rq);
 	int this_cpu = this_rq->cpu, cpu;
 	bool resched = false;
 	struct task_struct *p, *push_task;
+	struct rt_rq *src_rt_rq;
 	struct rq *src_rq;
 	int rt_overload_count = rt_overloaded(this_rq);

@@ -2285,6 +2315,7 @@ static void pull_rt_task(struct rq *this_rq)
 			continue;

 		src_rq = cpu_rq(cpu);
+		src_rt_rq = &src_rq->rt;

 		/*
 		 * Don't bother taking the src_rq->lock if the next highest
@@ -2293,8 +2324,8 @@ static void pull_rt_task(struct rq *this_rq)
 		 * logically higher, the src_rq will push this task away.
 		 * And if its going logically lower, we do not care
 		 */
-		if (src_rq->rt.highest_prio.next >=
-		    this_rq->rt.highest_prio.curr)
+		if (src_rt_rq->highest_prio.next >=
+		    this_rt_rq->highest_prio.curr)
 			continue;

 		/*
@@ -2309,13 +2340,13 @@ static void pull_rt_task(struct rq *this_rq)
 		 * We can pull only a task, which is pushable
 		 * on its rq, and no others.
 		 */
-		p = pick_highest_pushable_task(src_rq, this_cpu);
+		p = pick_highest_pushable_task(src_rt_rq, this_cpu);

 		/*
 		 * Do we have an RT task that preempts
 		 * the to-be-scheduled task?
 		 */
-		if (p && (p->prio < this_rq->rt.highest_prio.curr)) {
+		if (p && (p->prio < this_rt_rq->highest_prio.curr)) {
 			WARN_ON(p == src_rq->curr);
 			WARN_ON(!task_on_rq_queued(p));

@@ -2374,7 +2405,7 @@ static void task_woken_rt(struct rq *rq, struct task_struct *p)
 			     rq->donor->prio <= p->prio);

 	if (need_to_push)
-		push_rt_tasks(rq);
+		push_rt_rq_tasks(rt_rq_of_se(&p->rt));
 }

 /* Assumes rq->lock is held */
@@ -2415,7 +2446,7 @@ static void switched_from_rt(struct rq *rq, struct task_struct *p)
 	if (!task_on_rq_queued(p) || rq->rt.rt_nr_running)
 		return;

-	rt_queue_pull_task(rq);
+	rt_queue_pull_task(rt_rq_of_se(&p->rt));
 }

 void __init init_sched_rt_class(void)
@@ -2451,7 +2482,7 @@ static void switched_to_rt(struct rq *rq, struct task_struct *p)
 	 */
 	if (task_on_rq_queued(p)) {
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
-			rt_queue_push_tasks(rq);
+			rt_queue_push_tasks(rt_rq_of_se(&p->rt));
 		if (p->prio < rq->donor->prio && cpu_online(cpu_of(rq)))
 			resched_curr(rq);
 	}
@@ -2476,7 +2507,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, u64 oldprio)
 		 * may need to pull tasks to this runqueue.
 		 */
 		if (oldprio < p->prio)
-			rt_queue_pull_task(rq);
+			rt_queue_pull_task(rt_rq_of_se(&p->rt));

 		/*
 		 * If there's a higher priority task waiting to run
--
2.54.0


