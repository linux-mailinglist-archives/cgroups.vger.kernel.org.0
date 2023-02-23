Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464BA6A1045
	for <lists+cgroups@lfdr.de>; Thu, 23 Feb 2023 20:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjBWTLb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Feb 2023 14:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjBWTLT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Feb 2023 14:11:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C82B301A7
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c12so11559404wrw.1
        for <cgroups@vger.kernel.org>; Thu, 23 Feb 2023 11:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrHADWHoMY9y8ELVmvMbzTureJuyfP6JlwHmhpl9ZDg=;
        b=Qyw1CqW71eyXYbSz0GTnhvWK1TYOrEuH868f5034qbj8ll371dbPYSqy5emdEUDKGB
         42bYlsrkmT1rK0Z/31TH70o0tisVmmC4i6Chi5MZJLpbzi3QxfPaSDgh8n+ZuvR/ifPI
         d655ZEinrxDVcIJyowzv4a7GQndq1CoIVqg1iKbq7qkFM9Sl7W2zednQlkJ8z25swJqB
         ANtbIND9z53bgeEp0PMHu58W7WDiGjA02kYKiM8K4u0tyCEq+tJ7k97+Ayatc6Jjww5n
         7bkXG/2cvljjOEubkyxfPTmqpUlfuzxhI5IqRje3UzJ1iMVKAfz/9AavplCgCxdq1x8R
         esQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrHADWHoMY9y8ELVmvMbzTureJuyfP6JlwHmhpl9ZDg=;
        b=RnUoG7KVuyTGo9nFW111oV2hXmAVFAzvsYd2kgIWOKd/BjarczNt1AkXu3V+M+HLy5
         aehUNQSI4BsDejNrm9uPylH6WMY2d9IJayiWo6DzGqqGOFGycSUPRXJCpNjIhMTiKBRr
         0pjRaoe54QzYadXhfhHB586IHikn1E1kZyO/CugciopqOahU7EYwmK/DCAvjOXD1SU6X
         nG1Y6SVQyJM3R9hpJMNuPDxLsSGSFYLey8aNs060SyXWHIfUyCGDNjdh+NPBjHMq1oZz
         vh47BRwFjuNT0PuWOeYiQIIxsOThVAK5xunU4xxc/IQ8jB1UaFgVM2KCd0RlszSBXMNp
         D8eQ==
X-Gm-Message-State: AO0yUKXl+mh2z1/ffRsPxOodhBQHF1Cz1fkXNkjBkb8G/HlkTIiHw/vs
        dGRP1T3CMfYf4C6Qlmg/ewk3dw==
X-Google-Smtp-Source: AK7set907oOLmf5B2utz5wIhikq7alUFQyP2J1ImCu7ZiubjkvQNk70Sm9GawcW4HF6tZz+tgwZGKQ==
X-Received: by 2002:adf:cd0c:0:b0:2c7:454:cee8 with SMTP id w12-20020adfcd0c000000b002c70454cee8mr9504064wrm.1.1677179457122;
        Thu, 23 Feb 2023 11:10:57 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:a6f0:4ee9:c103:44cb])
        by smtp.gmail.com with ESMTPSA id k2-20020adff282000000b002c6e8cb612fsm9844481wro.92.2023.02.23.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 11:10:56 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org
Cc:     tj@kernel.org, qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v11 8/8] sched/fair: Add latency list
Date:   Thu, 23 Feb 2023 20:10:41 +0100
Message-Id: <20230223191041.577305-9-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230223191041.577305-1-vincent.guittot@linaro.org>
References: <20230223191041.577305-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Add a rb tree for latency sensitive entities so we can schedule the most
sensitive one first even when it failed to preempt current at wakeup or
when it got quickly preempted by another entity of higher priority.

In order to keep fairness, the latency is used once at wakeup to get a
minimum slice and not during the following scheduling slice to prevent
long running entity to got more running time than allocated to his nice
priority.

The rb tree enables to cover the last corner case where latency
sensitive entity can't got schedule quickly after the wakeup.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/linux/sched.h |   1 +
 kernel/sched/core.c   |   1 +
 kernel/sched/fair.c   | 108 ++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |   1 +
 4 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 38decae3e156..41bb92be5ecc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -548,6 +548,7 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	struct rb_node			latency_node;
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 093cc1af73dc..752fd364216c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4434,6 +4434,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
+	RB_CLEAR_NODE(&p->se.latency_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 125a6ff53378..9fb0461197bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -680,7 +680,85 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 
 	return __node_2_se(last);
 }
+#endif
 
+/**************************************************************
+ * Scheduling class tree data structure manipulation methods:
+ * for latency
+ */
+
+static inline bool latency_before(struct sched_entity *a,
+				struct sched_entity *b)
+{
+	return (s64)(a->vruntime + a->latency_offset - b->vruntime - b->latency_offset) < 0;
+}
+
+#define __latency_node_2_se(node) \
+	rb_entry((node), struct sched_entity, latency_node)
+
+static inline bool __latency_less(struct rb_node *a, const struct rb_node *b)
+{
+	return latency_before(__latency_node_2_se(a), __latency_node_2_se(b));
+}
+
+/*
+ * Enqueue an entity into the latency rb-tree:
+ */
+static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+{
+
+	/* Only latency sensitive entity can be added to the list */
+	if (se->latency_offset >= 0)
+		return;
+
+	if (!RB_EMPTY_NODE(&se->latency_node))
+		return;
+
+	/*
+	 * The entity is always added the latency list at wakeup.
+	 * Then, a not waking up entity that is put back in the list after an
+	 * execution time less than sysctl_sched_min_granularity, means that
+	 * the entity has been preempted by a higher sched class or an entity
+	 * with higher latency constraint. In thi case, the entity is also put
+	 * back in the latency list so it gets a chance to run 1st during the
+	 * next slice.
+	 */
+	if (!(flags & ENQUEUE_WAKEUP)) {
+		u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+
+		if (delta_exec >= sysctl_sched_min_granularity)
+			return;
+	}
+
+	rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
+}
+
+/*
+ * Dequeue an entity from the latency rb-tree and return true if it was really
+ * part of the rb-tree:
+ */
+static bool __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (!RB_EMPTY_NODE(&se->latency_node)) {
+		rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
+		RB_CLEAR_NODE(&se->latency_node);
+		return true;
+	}
+
+	return false;
+}
+
+static struct sched_entity *__pick_first_latency(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *left = rb_first_cached(&cfs_rq->latency_timeline);
+
+	if (!left)
+		return NULL;
+
+	return __latency_node_2_se(left);
+}
+
+#ifdef CONFIG_SCHED_DEBUG
 /**************************************************************
  * Scheduling class statistics methods:
  */
@@ -4758,8 +4836,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
 	check_spread(cfs_rq, se);
-	if (!curr)
+	if (!curr) {
 		__enqueue_entity(cfs_rq, se);
+		__enqueue_latency(cfs_rq, se, flags);
+	}
 	se->on_rq = 1;
 
 	if (cfs_rq->nr_running == 1) {
@@ -4845,8 +4925,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->curr) {
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
+	}
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -4941,6 +5023,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
@@ -4979,7 +5062,7 @@ static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *latency, *se;
 
 	/*
 	 * If curr is set we have to see if its left of the leftmost entity
@@ -5021,6 +5104,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 		se = cfs_rq->last;
 	}
 
+	/* Check for latency sensitive entity waiting for running */
+	latency = __pick_first_latency(cfs_rq);
+	if (latency && (latency != se) &&
+	    wakeup_preempt_entity(latency, se) < 1)
+		se = latency;
+
 	return se;
 }
 
@@ -5044,6 +5133,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
+		__enqueue_latency(cfs_rq, prev, 0);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
@@ -12222,6 +12312,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+	cfs_rq->latency_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
@@ -12529,8 +12620,19 @@ int sched_group_set_latency(struct task_group *tg, int prio)
 
 	for_each_possible_cpu(i) {
 		struct sched_entity *se = tg->se[i];
+		struct rq *rq = cpu_rq(i);
+		struct rq_flags rf;
+		bool queued;
+
+		rq_lock_irqsave(rq, &rf);
 
+		queued = __dequeue_latency(se->cfs_rq, se);
 		WRITE_ONCE(se->latency_offset, latency_offset);
+		if (queued)
+			__enqueue_latency(se->cfs_rq, se, ENQUEUE_WAKEUP);
+
+
+		rq_unlock_irqrestore(rq, &rf);
 	}
 
 	mutex_unlock(&shares_mutex);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9a2e71231083..21dd309e98a9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -570,6 +570,7 @@ struct cfs_rq {
 #endif
 
 	struct rb_root_cached	tasks_timeline;
+	struct rb_root_cached	latency_timeline;
 
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
-- 
2.34.1

