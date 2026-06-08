Return-Path: <cgroups+bounces-16708-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id of0ZOO6zJmr3bQIAu9opvQ
	(envelope-from <cgroups+bounces-16708-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:22:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9346561AA
	for <lists+cgroups@lfdr.de>; Mon, 08 Jun 2026 14:22:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ot4qIufa;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16708-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-16708-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D554E30376BF
	for <lists+cgroups@lfdr.de>; Mon,  8 Jun 2026 12:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E449378813;
	Mon,  8 Jun 2026 12:16:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0D337BE6D
	for <cgroups@vger.kernel.org>; Mon,  8 Jun 2026 12:15:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920960; cv=none; b=BQTcjV2Y6Fk25l3P4/+lZQSQ3j+j1jrEg76h0JwjeWdPz1/IPslVHUaJzW9/reX+idEpNVKNyO+d/O69pJ6Wd3KogSzzOLN6i+FHoigzPh/1Zq8+9n/vKQxaILC974Ez0xs7UrYrZfq8cLwxq7oATDUjRp9OAPiuO/lau84Gd7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920960; c=relaxed/simple;
	bh=qyB5yI6Le6xpCF2Mh0VVp9O8korJzrXEa3MKPuArOrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA5imXSfRU7mUt55E1C9eKJAu3UHcE+fY/cSjmFSrVu/CtxUFzvSe5fsK4ce9q5QgbuZ31tlkjsT0JI2p5URShv/SJaIARqQ8meJAfqbroFCbyoUhWC4jxmpjMX2A+KpOX5s2ks/3tyWhmgZxt0rs1EYPjDhYN3U3YXXKXW3qCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ot4qIufa; arc=none smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eeba68948so2963937f8f.1
        for <cgroups@vger.kernel.org>; Mon, 08 Jun 2026 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780920955; x=1781525755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NueTbVBmAJACS7om+Cw1nmdAI7MJ2FcgIbTst3qsjQM=;
        b=ot4qIufakqIxK4v/5VDZ2nJLNxGsXc0eX72sRmuKMgAJaKYfLtEGv4GHu5b4ONGFsF
         nlurnvIQdSfo7gG6SmGkMF7Naa5E1H+YX+h57cnorjlo2NHQmdpuwsXMt+t0ZQVIBB6p
         zX4qzrlHsCcPv34TBK6iZCXVNYKmPv903X+k7/bgO1VlNJx27X/ub/fTQlsfkSIKWPBp
         JWy0QN07FM+DzuTPsuN1lMx5IHTfiF1Xk58Mi6giWgsmcexSDdkW969z4Zv0Z8iXLi8s
         KkjUvP6J0fcMVfZ+5AoZRvUSgdgsUuzSV1pIi0FdAgdoCsvDTeF4bIRQlsli2+VAz7Qn
         g8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780920955; x=1781525755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NueTbVBmAJACS7om+Cw1nmdAI7MJ2FcgIbTst3qsjQM=;
        b=LWFeT+eXhfZ2Y5NwhqOPOC4Gno9gIaUFR58bep9rpGYHs9Q2YyCQDuRKbU43ULnlk3
         0XUo08unkFi2qYiB/13liOgwMu6EnUVexK9eE2izz1hD9zcI7/9HFar52FIUj5nVYl+b
         4jtsOy1Zd76bqoMTJBR/HGEJnd+gPJ/zBFWWkHqj3e12r1iPNnBmNtQshQb7YOdU3WIc
         kToIa2/YYBPKNw4+JS2hRgWgoB8J30jXgvmNWSUAfHPYxnLy8KMW0Iny8wAs2q7RhMPB
         LNnvaji3JP71bIyDVb6wVBJ3MMXTYDDhxAPFNvq21A7KsSnAplR9AJyRtTTFqTTWfb3M
         wqtg==
X-Gm-Message-State: AOJu0YwJcHff6plrtSSl1kep5mDkNwaS3J2xKg8EBTivse8kkNiJC+kO
	IXr8w9rA7LJptzzHehrXn3B6lT5KbUxi9aRew7TbwYdNVh3ZQ0wk8RUA
X-Gm-Gg: Acq92OF5ybNNyo2sqe2c2lFEOKID20rUHGvewPLhNuiQQvHKbfdnmMvQLs/oiOaZKBC
	nYa1URIlFabr3x3jV51+Y5e+v1JDku5jDQoVAmlE1HbWwol/lJBCVEuW9WrILnFsGVcpIHtnhrF
	rpS+7ztB/A4FHa9qCl9V9l+6orIM4A+UV93HINWYSrM8/XDdhtcYLhf2UVKwyUS5ufdC/UGGzG5
	UCXvUhLTNEvvUivf3EzhTu86+3lS5anHojYbezD+m8gBRgAen2m/EwF6FYs6CxSzzq+4Lat/4nT
	Zba0kxeJ9iSmDHjnS7uJwHqQGKC4Ckmqw6RgPIR/B4EU1kU+hOXSeJHwoGYWFFjGi1MTpFucaUT
	LwPuEkfOGs7IPQtGMaCdxuweyOqig9rPR3Fw03CZRu3F1vox6okuGi4iU1f+LZEl0Yxhzp70M3K
	o6O29ZvWBCJhqKaWWJzAQwlAmdRKlXbpY=
X-Received: by 2002:a5d:598b:0:b0:45e:73b3:8118 with SMTP id ffacd0b85a97d-46030512fa1mr24677902f8f.29.1780920955231;
        Mon, 08 Jun 2026 05:15:55 -0700 (PDT)
Received: from victus-lab ([193.205.81.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2ec711sm50644906f8f.12.2026.06.08.05.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 05:15:55 -0700 (PDT)
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
Subject: [RFC PATCH v6 08/25] sched/rt: Remove unnecessary runqueue pointer in struct rt_rq
Date: Mon,  8 Jun 2026 14:15:27 +0200
Message-ID: <20260608121546.69910-9-yurand2000@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-16708-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A9346561AA

Remove the rq field in struct rt_rq.
  The rq field now is just caching the pointer to the global runqueue of the
  given rt_rq, so it is unnecessary as the global runqueue can be retrieved
  in other ways.

Introduce global_rq_of_rt_rq to retrieve the global runqueue which serves a
rt_rq's dl_server.
Rework rq_of_rt_rq to retrieve the runqueue a rt_rq is serving.

Signed-off-by: Yuri Andriaccio <yurand2000@gmail.com>
---
 kernel/sched/rt.c    | 21 +++++++++------------
 kernel/sched/sched.h | 16 ++++++++++++----
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b526a86083c..4575c234ae46 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -101,10 +101,7 @@ void init_tg_rt_entry(struct task_group *tg, struct rt_rq *rt_rq,
 		struct sched_rt_entity *rt_se, int cpu,
 		struct sched_rt_entity *parent)
 {
-	struct rq *rq = cpu_rq(cpu);
-
 	rt_rq->highest_prio.curr = MAX_RT_PRIO-1;
-	rt_rq->rq = rq;
 	rt_rq->tg = tg;

 	tg->rt_rq[cpu] = rt_rq;
@@ -184,7 +181,7 @@ static void pull_rt_task(struct rq *);

 static inline void rt_queue_push_tasks(struct rt_rq *rt_rq)
 {
-	struct rq *rq = container_of_const(rt_rq, struct rq, rt);
+	struct rq *rq = global_rq_of_rt_rq(rt_rq);

 	if (!has_pushable_tasks(rt_rq))
 		return;
@@ -194,7 +191,7 @@ static inline void rt_queue_push_tasks(struct rt_rq *rt_rq)

 static inline void rt_queue_pull_task(struct rt_rq *rt_rq)
 {
-	struct rq *rq = container_of_const(rt_rq, struct rq, rt);
+	struct rq *rq = global_rq_of_rt_rq(rt_rq);

 	queue_balance_callback(rq, &per_cpu(rt_pull_head, rq->cpu), pull_rt_task);
 }
@@ -222,7 +219,7 @@ static void enqueue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 		rt_rq->highest_prio.next = p->prio;

 	if (!rt_rq->overloaded) {
-		rt_set_overload(rq_of_rt_rq(rt_rq));
+		rt_set_overload(global_rq_of_rt_rq(rt_rq));
 		rt_rq->overloaded = 1;
 	}
 }
@@ -240,7 +237,7 @@ static void dequeue_pushable_task(struct rt_rq *rt_rq, struct task_struct *p)
 		rt_rq->highest_prio.next = MAX_RT_PRIO-1;

 		if (rt_rq->overloaded) {
-			rt_clear_overload(rq_of_rt_rq(rt_rq));
+			rt_clear_overload(global_rq_of_rt_rq(rt_rq));
 			rt_rq->overloaded = 0;
 		}
 	}
@@ -495,7 +492,7 @@ update_stats_wait_start_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 	if (!stats)
 		return;

-	__update_stats_wait_start(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_wait_start(global_rq_of_rt_rq(rt_rq), p, stats);
 }

 static inline void
@@ -512,7 +509,7 @@ update_stats_enqueue_sleeper_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_
 	if (!stats)
 		return;

-	__update_stats_enqueue_sleeper(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_enqueue_sleeper(global_rq_of_rt_rq(rt_rq), p, stats);
 }

 static inline void
@@ -540,7 +537,7 @@ update_stats_wait_end_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se)
 	if (!stats)
 		return;

-	__update_stats_wait_end(rq_of_rt_rq(rt_rq), p, stats);
+	__update_stats_wait_end(global_rq_of_rt_rq(rt_rq), p, stats);
 }

 static inline void
@@ -564,11 +561,11 @@ update_stats_dequeue_rt(struct rt_rq *rt_rq, struct sched_rt_entity *rt_se,
 		state = READ_ONCE(p->__state);
 		if (state & TASK_INTERRUPTIBLE)
 			__schedstat_set(p->stats.sleep_start,
-					rq_clock(rq_of_rt_rq(rt_rq)));
+					rq_clock(global_rq_of_rt_rq(rt_rq)));

 		if (state & TASK_UNINTERRUPTIBLE)
 			__schedstat_set(p->stats.block_start,
-					rq_clock(rq_of_rt_rq(rt_rq)));
+					rq_clock(global_rq_of_rt_rq(rt_rq)));
 	}
 }

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a217c4ab6660..3aa29fe932fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -857,8 +857,6 @@ struct rt_rq {
 	raw_spinlock_t		rt_runtime_lock;

 	unsigned int		rt_nr_boosted;
-
-	struct rq		*rq; /* this is always top-level rq, cache? */
 #endif
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group	*tg; /* this tg has "this" rt_rq on given CPU for runnable entities */
@@ -3337,9 +3335,14 @@ static inline struct task_struct *rt_task_of(struct sched_rt_entity *rt_se)

 static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 {
-	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
 	WARN_ON(!rt_group_sched_enabled() && rt_rq->tg != &root_task_group);
-	return rt_rq->rq;
+	return container_of_const(rt_rq, struct rq, rt);
+}
+
+static inline struct rq *global_rq_of_rt_rq(struct rt_rq *rt_rq)
+{
+	/* Cannot fold with non-CONFIG_RT_GROUP_SCHED version, layout */
+	return cpu_rq(rq_of_rt_rq(rt_rq)->cpu);
 }

 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
@@ -3358,6 +3361,11 @@ static inline struct rq *rq_of_rt_rq(struct rt_rq *rt_rq)
 	return container_of_const(rt_rq, struct rq, rt);
 }

+static inline struct rq *global_rq_of_rt_rq(struct rt_rq *rt_rq)
+{
+	return container_of_const(rt_rq, struct rq, rt);
+}
+
 static inline struct rt_rq *rt_rq_of_se(struct sched_rt_entity *rt_se)
 {
 	struct rq *rq = task_rq(rt_task_of(rt_se));
--
2.54.0


