Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6096699C8
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 15:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbjAMOO5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 09:14:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbjAMONy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 09:13:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE5B1ADBC
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:51 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p3-20020a05600c1d8300b003d9ee5f125bso12372454wms.4
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWiIpOe2nNdT5aWZRMfGm3NcSfCw2CxcRRTzhzpvxrA=;
        b=BywjmuYYDQL0B21BIKa7iT2z+zdJTdpWyljP9Agfj2597r0VBHFUwD+R67fS51aQp7
         VbuIrgy3kWGXYiQ+AbS40a9O3nOPS9zQ7D3TFtpaiZfn/uqD3EHq44UHZjX3is0nupNv
         N3xfnI864WldAvYuq/c2/aof7J0TL/NuZUi6kM22NjmqFjasPhF2FPEtAdcms4XvNet8
         itm+i4Y4ADmVmnsCKI+/u+MNMrocBIza8Wircmv8MtKQ4+e0VcHPCl4ioHcGfoq3dnWP
         fI0NUB55RCG2tu31OHi5U1koTyaUjudyfB8StE8p0F8t3cp3XWaNYF7wC76RWyz9yC5D
         lgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWiIpOe2nNdT5aWZRMfGm3NcSfCw2CxcRRTzhzpvxrA=;
        b=HP256gO1kdWYD+cGY0tjUyMgIbY2txizPF7bN0tyeQ+paDr2xoJLdlXpKkb3BN2VG1
         55jlhQg7bfX7sXy7TGVUhusNQQEavcXpyOGZOH2mA+3ZB7/rifrdJJIUtYBU4PpZ9TTr
         Km8PBH0p7qrWXmgC8bGbRi1+3Pclfoq/Ozce16oOnRtiUzoxemxKhTUmdTb0TP9PYwaG
         4ZhGAPYyS+ZMqXkd2otajg0SpkJcnLODMoYjF6ngjEzE2qfmRrkp0XJkLh4LRdEOLyZy
         405evk9AaiSp+DTNJdze1D/Vn1lUDk7CnCMA+sR0g1sqBT4V11Ms+1PErv3MkCOjgiVi
         DplA==
X-Gm-Message-State: AFqh2kpaDieTqSFOqApeKgKycY7SKlbqKNtPhQKaNJdCedTubbao+bL1
        cw2y0w5W2rYr0X9gcj6+a3y17g==
X-Google-Smtp-Source: AMrXdXsvaTp5++t6rF0ECA51nl7GXntsSWE9wqhBBQs7Gzceg/pd6dyHVV8i0yvfz4/cZdizV5Orog==
X-Received: by 2002:a05:600c:510b:b0:3da:2090:d404 with SMTP id o11-20020a05600c510b00b003da2090d404mr2041306wms.18.1673619170540;
        Fri, 13 Jan 2023 06:12:50 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:49 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org
Cc:     qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com, timj@gnu.org,
        kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, joel@joelfernandes.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v10 8/9] sched/fair: Add latency list
Date:   Fri, 13 Jan 2023 15:12:33 +0100
Message-Id: <20230113141234.260128-9-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
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
 include/linux/sched.h |  1 +
 kernel/sched/core.c   |  1 +
 kernel/sched/fair.c   | 95 +++++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h  |  1 +
 4 files changed, 95 insertions(+), 3 deletions(-)

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
index 6798c9a297d6..5c99f67c7e7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4390,6 +4390,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	INIT_LIST_HEAD(&p->se.group_node);
+	RB_CLEAR_NODE(&p->se.latency_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a4bfa03d096c..a8f0e32431e2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -680,7 +680,76 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 
 	return __node_2_se(last);
 }
+#endif
+
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
+	 * An execution time less than sysctl_sched_min_granularity means that
+	 * the entity has been preempted by a higher sched class or an entity
+	 * with higher latency constraint.
+	 * Put it back in the list so it gets a chance to run 1st during the
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
+static void __dequeue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (!RB_EMPTY_NODE(&se->latency_node)) {
+		rb_erase_cached(&se->latency_node, &cfs_rq->latency_timeline);
+		RB_CLEAR_NODE(&se->latency_node);
+	}
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
 
+#ifdef CONFIG_SCHED_DEBUG
 /**************************************************************
  * Scheduling class statistics methods:
  */
@@ -4751,8 +4820,10 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
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
@@ -4838,8 +4909,10 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	clear_buddies(cfs_rq, se);
 
-	if (se != cfs_rq->curr)
+	if (se != cfs_rq->curr) {
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
+	}
 	se->on_rq = 0;
 	account_entity_dequeue(cfs_rq, se);
 
@@ -4928,6 +5001,7 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		 */
 		update_stats_wait_end_fair(cfs_rq, se);
 		__dequeue_entity(cfs_rq, se);
+		__dequeue_latency(cfs_rq, se);
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 	}
 
@@ -4966,7 +5040,7 @@ static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
 	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *latency, *se;
 
 	/*
 	 * If curr is set we have to see if its left of the leftmost entity
@@ -5008,6 +5082,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
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
 
@@ -5031,6 +5111,7 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
 		__enqueue_entity(cfs_rq, prev);
+		__enqueue_latency(cfs_rq, prev, 0);
 		/* in !on_rq case, update occurred at dequeue */
 		update_load_avg(cfs_rq, prev, 0);
 	}
@@ -12244,6 +12325,7 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
 void init_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->tasks_timeline = RB_ROOT_CACHED;
+	cfs_rq->latency_timeline = RB_ROOT_CACHED;
 	u64_u32_store(cfs_rq->min_vruntime, (u64)(-(1LL << 20)));
 #ifdef CONFIG_SMP
 	raw_spin_lock_init(&cfs_rq->removed.lock);
@@ -12552,8 +12634,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
 
 	for_each_possible_cpu(i) {
 		struct sched_entity *se = tg->se[i];
+		struct rq *rq = cpu_rq(i);
+		struct rq_flags rf;
+
+		rq_lock_irqsave(rq, &rf);
 
+		__dequeue_latency(se->cfs_rq, se);
 		WRITE_ONCE(se->latency_offset, latency);
+
+		rq_unlock_irqrestore(rq, &rf);
 	}
 
 	mutex_unlock(&shares_mutex);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5a4ce8e61f47..186873bb41e2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -575,6 +575,7 @@ struct cfs_rq {
 #endif
 
 	struct rb_root_cached	tasks_timeline;
+	struct rb_root_cached	latency_timeline;
 
 	/*
 	 * 'curr' points to currently running entity on this cfs_rq.
-- 
2.34.1

