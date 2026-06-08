Return-Path: <cgroups+bounces-16716-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MNDgNXGzJmqUbQIAu9opvQ
	(envelope-from <cgroups+bounces-16716-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7916465613B
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:20:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pLT9Q2di;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16716-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-16716-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A407D30362FC
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73D73A5438;
	Mon,  8 Jun 2026 12:16:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09F3803F9
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:16:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920965; cv=none; b=bB6Ii7eIqvOZPz+4Kyt+JsO7kPveQ6gVVSiPik5LN39sGeLmsSJ3m2IMsMNtWw2USd6Ym5bcql0tkS/eJU30FIvzFTbJw+QW8eqFy8G+6VxdeGdm9wldsZ5ZXIaX6p+jArD+uDopVZnJd2kl9KERpVzDLvqunI4pER+VN1PQ/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920965; c=relaxed/simple;
	bh=jcQB6FhJIuwr/IRdvU92ziCijr23bUOi8QVp9D/t2PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhvpDGIkTCWny1Fq4WqnXuZvqLszh3/Sob16uvkcX9R1COueatnI27g4kzCRkxi3bpSW/28HQhWl7jOiYkCKrEaiUyAHXyWDdY25MHmRukM2ZFe3brAveWhLtt1btGfwQT6BX7EJPmBZq14sxlgev0U/GwK3ARRrHPvqHHtQMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pLT9Q2di; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45fd45e596cso2020151f8f.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920961; x=1781525761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=voPji+yceKdPoSsP7jAvETRoIpzyXcg+YDnlEYuWa/U=;
        b=pLT9Q2di3fH6fmDCWb5Xlx8sRTV6KyPs79TlKMc06GB6RSOPC7YICGS+pD1ikrY3Mk
         Tx9FO+ksdl0x844QLSuHIDBkMpMbvCzhkMsOb7Jp06z4PjbWRZHqBfB6xGjStCupoEEL
         AHBzdQiKz7uo2PTRsWBeFWM84xaDXaLU+PtAiBeSk5CJThufNyFEYzhxRsfkBa2Cuj3I
         W2yDWNb7ORS4EpuXn0LfLMpeeb1Kt+Y2TcgvjvwKRXQjAU31Q3vJhqF2pHSl48C6hZPC
         /FgQphLXlg747agq8mX5yjIw/TRKwyuBkFOV4d9v5CzZZXDErA6xHJx5IaGpegtL4Nky
         RE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920961; x=1781525761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=voPji+yceKdPoSsP7jAvETRoIpzyXcg+YDnlEYuWa/U=;
        b=nnFpJhJpQ7VoZBmGLbpe3WdQ0SoW7SDXyL02URNxq+ImuS3bqdTlhC/kEmTZQgM9ao
         RX7+iL+pDmoO5Makcoxp7Y5QxMdalJk3Ryc65N6d1IZxQyUyO0FEiN6M+BTrKmxbk1VJ
         n35Ne3dA3Dx2KHo0DCCv0Y4+EYxXpcQIXvwt1NLBSsMpB3TjoUCHrqgN04m+6MxVpSsK
         ndDz5rNeXUp+3gv2Btb0xD2LPtMtKkeLUegLVhCw4yc4KVsOLwHkhVgnmOjUeorsTRPa
         LyF1v/ytYSe9O05L+zLZbK7FYlPK+jyelQX2bFmGLAeShrIjPBCl2X6v3zvaO4En+O8v
         023w==
X-Gm-Message-State: AOJu0YzgxjXR4es3hLHPe/taDjBQlshLtqrJYIuNf29NbFxECQ9k3OwO
	4kioz0syD14xyvyX967gt6fc8eUxYbY0T2/DN40CdMBJkmfrqlsmvCe0
X-Gm-Gg: Acq92OHyWBoxSu3HgoofKkyQCF4N3bajFSJ8bZt4QWSoFTudHqKM2trSnJmznEMdNb4
	gZY/DCJfJtwLDFaQN9BSHRwvs6LQy1pSDCFX4HhnTkyGJafIxOA741+vM2SzI8Ut9VWq2kPLpo/
	kr+LqtfeqWm96wbk0ckfXyXWkaU7PIZTKvmqGkDZZ9/8Uw4wmM1+jwduDdmnKOirASVicaHiw0i
	rTkLAv+WoS6I1XpGA58kgzgbknT82qq0q3fLdEezodHHxAk79zV9TENdCdfgKU4v+Sy/jqlCjGl
	MQSUm6I/O9u3CXBwsAcyksl4lmxU2PKOzwtkUGNVLN/IVRJgAPBc5TuDhzKYPzTQjfSIFJDFq5/
	vV545oMvz3A19WSvoiEh1Vw6yZnx5J/uYgFmsRcJ80rzrd1a/RS3LT+57/V4hRVpUaEdrx6fSo8
	GGouRAk+S6337MsUbBtirbCCp4x9qLEPU=
X-Received: by 2002:a5d:5049:0:b0:460:1a57:dd7c with SMTP id ffacd0b85a97d-4603063d5acmr18425112f8f.23.1780920961065;
        Mon, 08 Jun 2026 05:16:01 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:16:00 -0700 (PDT)
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
Subject: [RFC PATCH v6 14/25] sched/rt: Implement dl-server operations for rt-cgroups.
Date: Mon,  8 Jun 2026 14:15:33 +0200
Message-ID: <20260608121546.69910-15-yurand2000@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16716-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sssup.it:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,santannapisa.it:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7916465613B

Implement rt_server_pick, the callback that deadline servers use to
pick a task to schedule.
  rt_server_pick(): pick the next runnable rt task and tell the
  scheduler that it is going to be scheduled next.

Let enqueue_task_rt function start the attached deadline server when the
first task is enqueued on a specific rq/server.
  The server is not symmetrically stopped in dequeue_task_rt as it is
  stopped when server_pick_task returns NULL (see deadline.c).

Change update_curr_rt to perform a deadline server update if the
updated task is served by non-root group.

Update {enqueue/dequeue}_pushable_task and rt_{set/clear}_overload to
only set the CPU-wise overload flag only if the root runqueues are
overloaded, but not for HCBS runqueues.

Update inc/dec_dl_tasks to account the number of active tasks in the
local runqueue for rt-cgroups servers, as their local runqueue is
different from the global runqueue, and thus when a rt-group server is
activated/deactivated, the number of served tasks' must be
added/removed. This uses nr_running to be compatible with future
dl-server interfaces. Account also the deadline server so that it is
picked for shutdown when its runqueue is empty (future patches will
try to pull tasks before stopping).

Update inc/dec_rt_prio_smp to change a rq's cpupri only if the rt_rq
is the global runqueue, since cgroups are scheduled via their
dl-server priority.

Update inc/dec_rt_tasks to account for waking/sleeping tasks on the
global runqueue, when the task runs on the root cgroup, or its local
dl server is active. The accounting is not done when servers are
throttled, as they will add/sub the number of tasks running when they
get enqueued/dequeued. For rt cgroups, account for the number of active
tasks in the nr_running field of the local runqueue (add/sub_nr_running),
as this number is used when a dl server is enqueued/dequeued.

Update set_task_rq to record the rt_rq of the cgroup's active_context,
tracking where to schedule the given task.

Update set_task_rq to record the dl_rq, tracking which deadline
server manages a task.

Update set_task_rq to not use the parent field anymore, as it is
unused by this patchset's code. Remove the unused parent field from
sched_rt_entity.

Co-developed-by: Alessio Balsini <a.balsini@sssup.it>
Signed-off-by: Alessio Balsini <a.balsini@sssup.it>
Co-developed-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Co-developed-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: luca abeni <luca.abeni@santannapisa.it>
Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 include/linux/sched.h   |  1 -
 kernel/sched/deadline.c |  8 +++++
 kernel/sched/rt.c       | 70 ++++++++++++++++++++++++++++++++++++-----
 kernel/sched/sched.h    | 11 +++++--
 4 files changed, 79 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 411ffe9b34b3..b20451fcda55 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -630,7 +630,6 @@ struct sched_rt_entity {

 	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
-	struct sched_rt_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
 	/* rq "owned" by this entity/group: */
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 166d23f45cab..a63253ec6441 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2096,6 +2096,10 @@ void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)

 	if (!dl_server(dl_se))
 		add_nr_running(rq_of_dl_rq(dl_rq), 1);
+	else if (rq_of_dl_se(dl_se) != dl_se->my_q) {
+		WARN_ON(dl_se->my_q->rt.rt_nr_running != dl_se->my_q->nr_running);
+		add_nr_running(rq_of_dl_rq(dl_rq), dl_se->my_q->nr_running + 1);
+	}

 	inc_dl_deadline(dl_rq, deadline);
 }
@@ -2108,6 +2112,10 @@ void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)

 	if (!dl_server(dl_se))
 		sub_nr_running(rq_of_dl_rq(dl_rq), 1);
+	else if (rq_of_dl_se(dl_se) != dl_se->my_q) {
+		WARN_ON(dl_se->my_q->rt.rt_nr_running != dl_se->my_q->nr_running);
+		sub_nr_running(rq_of_dl_rq(dl_rq), dl_se->my_q->nr_running - 1);
+	}

 	dec_dl_deadline(dl_rq, dl_se->deadline);
 }
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a6adf21772a6..61e9dab894d1 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -284,9 +284,19 @@ int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
 	return 1;
 }

+static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq);
+
 static struct task_struct *rt_server_pick(struct sched_dl_entity *dl_se, struct rq_flags *rf)
 {
-	return NULL;
+	struct rt_rq *rt_rq = &dl_se->my_q->rt;
+	struct task_struct *p;
+
+	if (!sched_rt_runnable(dl_se->my_q))
+		return NULL;
+
+	p = rt_task_of(pick_next_rt_entity(rt_rq));
+
+	return p;
 }

 #else /* !CONFIG_RT_GROUP_SCHED */
@@ -314,6 +324,9 @@ static inline int rt_overloaded(struct rq *rq)

 static inline void rt_set_overload(struct rq *rq)
 {
+	if (is_dl_group(&rq->rt))
+		return;
+
 	if (!rq->online)
 		return;

@@ -333,6 +346,9 @@ static inline void rt_set_overload(struct rq *rq)

 static inline void rt_clear_overload(struct rq *rq)
 {
+	if (is_dl_group(&rq->rt))
+		return;
+
 	if (!rq->online)
 		return;

@@ -392,7 +408,7 @@ static void enqueue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 		rt_rq->highest_prio.next = p->prio;

 	if (!rt_rq->overloaded) {
-		rt_set_overload(global_rq_of_rt_rq(rt_rq));
+		rt_set_overload(rq_of_rt_rq(rt_rq));
 		rt_rq->overloaded = 1;
 	}
 }
@@ -410,7 +426,7 @@ static void dequeue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 		rt_rq->highest_prio.next = MAX_RT_PRIO-1;

 		if (rt_rq->overloaded) {
-			rt_clear_overload(global_rq_of_rt_rq(rt_rq));
+			rt_clear_overload(rq_of_rt_rq(rt_rq));
 			rt_rq->overloaded = 0;
 		}
 	}
@@ -511,6 +527,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
 static void update_curr_rt(struct rq *rq)
 {
 	struct task_struct *donor = rq->donor;
+	struct rt_rq *rt_rq;
 	s64 delta_exec;

 	if (donor->sched_class != &rt_sched_class)
@@ -520,21 +537,32 @@ static void update_curr_rt(struct rq *rq)
 	if (unlikely(delta_exec <= 0))
 		return;

-	if (!rt_bandwidth_enabled())
+	if (!rt_group_sched_enabled())
+		return;
+
+	if (!dl_bandwidth_enabled())
 		return;
+
+	rt_rq = rt_rq_of_se(&donor->rt);
+	if (is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		dl_server_update(dl_se, delta_exec);
+	}
 }

 static void
 inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 {
-	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct rq *rq;

 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
+	if (is_dl_group(rt_rq))
 		return;

+	rq = rq_of_rt_rq(rt_rq);
 	if (rq->online && prio < prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, prio);
 }
@@ -542,14 +570,15 @@ inc_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 static void
 dec_rt_prio_smp(struct rt_rq *rt_rq, int prio, int prev_prio)
 {
-	struct rq *rq = rq_of_rt_rq(rt_rq);
+	struct rq *rq;

 	/*
 	 * Change rq's cpupri only if rt_rq is the top queue.
 	 */
-	if (IS_ENABLED(CONFIG_RT_GROUP_SCHED) && &rq->rt != rt_rq)
+	if (is_dl_group(rt_rq))
 		return;

+	rq = rq_of_rt_rq(rt_rq);
 	if (rq->online && rt_rq->highest_prio.curr != prev_prio)
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rt_rq->highest_prio.curr);
 }
@@ -610,6 +639,15 @@ void inc_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	rt_rq->rr_nr_running += is_rr_task(rt_se);

 	inc_rt_prio(rt_rq, rt_se_prio(rt_se));
+
+	if (is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		if (!dl_se->dl_throttled)
+			add_nr_running(global_rq_of_rt_rq(rt_rq), 1);
+	}
+
+	add_nr_running(rq_of_rt_rq(rt_rq), 1);
 }

 static inline
@@ -620,6 +658,15 @@ void dec_rt_tasks(struct sched_rt_entity *rt_se, struct rt_rq *rt_rq)
 	rt_rq->rr_nr_running -= is_rr_task(rt_se);

 	dec_rt_prio(rt_rq, rt_se_prio(rt_se));
+
+	if (is_dl_group(rt_rq)) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		if (!dl_se->dl_throttled)
+			sub_nr_running(global_rq_of_rt_rq(rt_rq), 1);
+	}
+
+	sub_nr_running(rq_of_rt_rq(rt_rq), 1);
 }

 /*
@@ -806,6 +853,13 @@ enqueue_task_rt(struct rq *rq, struct task_struct *p, int flags)
 	check_schedstat_required();
 	update_stats_wait_start_rt(rt_rq_of_se(rt_se), rt_se);

+	/* Task arriving in an idle group of tasks. */
+	if (is_dl_group(rt_rq) && rt_rq->rt_nr_running == 0) {
+		struct sched_dl_entity *dl_se = dl_group_of(rt_rq);
+
+		dl_server_start(dl_se);
+	}
+
 	enqueue_rt_entity(rt_se, flags);

 	if (task_is_blocked(p))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58f67093145e..66d5bd1aa4f1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2310,10 +2310,11 @@ static inline void set_task_rq(struct task_struct *p, unsigned int cpu)
 	 * root_task_group's rt_rq than switching in rt_rq_of_se()
 	 * Clobbers tg(!)
 	 */
+	guard(raw_spinlock_irqsave)(&tg->dl_bandwidth.dl_runtime_lock);
 	if (!rt_group_sched_enabled())
 		tg = &root_task_group;
-	p->rt.rt_rq  = tg->rt_rq[cpu];
-	p->rt.parent = tg->rt_se[cpu];
+	p->rt.rt_rq  = tg->dl_bandwidth.active_context->rt_rq[cpu];
+	p->dl.dl_rq  = &cpu_rq(cpu)->dl;
 #endif /* CONFIG_RT_GROUP_SCHED */
 }

@@ -2976,6 +2977,9 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 	unsigned prev_nr = rq->nr_running;

 	rq->nr_running = prev_nr + count;
+	if (rq != cpu_rq(rq->cpu))
+		return;
+
 	if (trace_sched_update_nr_running_tp_enabled()) {
 		call_trace_sched_update_nr_running(rq, count);
 	}
@@ -2989,6 +2993,9 @@ static inline void add_nr_running(struct rq *rq, unsigned count)
 static inline void sub_nr_running(struct rq *rq, unsigned count)
 {
 	rq->nr_running -= count;
+	if (rq != cpu_rq(rq->cpu))
+		return;
+
 	if (trace_sched_update_nr_running_tp_enabled()) {
 		call_trace_sched_update_nr_running(rq, -count);
 	}
--
2.54.0


