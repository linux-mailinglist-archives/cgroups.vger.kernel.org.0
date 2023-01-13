Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953466699BC
	for <lists+cgroups@lfdr.de>; Fri, 13 Jan 2023 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjAMOOs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Jan 2023 09:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242015AbjAMONs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Jan 2023 09:13:48 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CBDDD4
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id d2so1066198wrp.8
        for <cgroups@vger.kernel.org>; Fri, 13 Jan 2023 06:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlloFS7Bj1vz8MB/gY8ujw3edPCeBj7FeQ8wX2SHm40=;
        b=XM70w7KZMtRcIGeyzBW5f5aEzTdbfuDdmw3koOm1IKpbkMOynQ0dDy1sXObUQxUUWD
         ylsbugkfXukjgr2ZrF4CzFZZTDMJZZA1RLYrwIZA/c4qJD3Ne3i15wxjLNQoDiDI7u4O
         S6WBxFtLE52OjuIVEbFG3wzgvhrTd+GYe+5fW+thyzxDa58mJvNW3vuKNoZ7JCaSo7c9
         BM7MoMBTJQIDEUqt5PxdWglEbTdmA5eU27MKeQEmEJGzRP5loLiU+kHmIctlVzW8XtFt
         PVHXElyLfJnlio7LdY04U36p+JckjuSQhhcDlFuFeLD+PVqecnaxEnK66LD+w7XOZ0NP
         9XmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zlloFS7Bj1vz8MB/gY8ujw3edPCeBj7FeQ8wX2SHm40=;
        b=k+Jv9ozd2utHHJs3ArgtOsl4+iWW+JBFy5+G+VJ2/p+0tp3D7dU/aqwpCv86pE8znq
         67JP32O7oNpFORqOqGXm3AyxxLo/UAGoXREoRy4TsSXPOPWB02E9n7ydUL+IqqfbLgzo
         fOsYyJ72YJawIJXH1s4kSzOzXMs3wz869QFUqmNso269yvCPd3iUgI9NEQM7r9SC8Lo2
         M8fKDOdMU/hSxvIeMMJ4+O1DFko5xceSspBoT6w+uAmyhsXz0zYzlmLONj8c7BTHmajj
         h2Mca9V0wLLE39K287tV61XEv4VSH3rkHJBRYlvUtC0EjwGJvL1BsRrVVxGB8WztJ304
         2ffw==
X-Gm-Message-State: AFqh2kp2xB9npJoGglJnN/XQs6m2Ptc7/q5hDj89lLMCbS6HlnkoEOte
        na3606Md9yvcVJ3jAcnqth1reA==
X-Google-Smtp-Source: AMrXdXv7hV6tw42t8RE1ipLFBAM0QwDWsJvxmAhp5BuKSySFlLQh9Ms2X+u810EEMA6TMzRVQIrZpQ==
X-Received: by 2002:a5d:42c7:0:b0:2bc:7f49:d276 with SMTP id t7-20020a5d42c7000000b002bc7f49d276mr10712356wrr.46.1673619159779;
        Fri, 13 Jan 2023 06:12:39 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:1563:65bf:c344:661e])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm13869919wrw.91.2023.01.13.06.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:12:39 -0800 (PST)
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
Subject: [PATCH v10 1/9] sched/fair: fix unfairness at wakeup
Date:   Fri, 13 Jan 2023 15:12:26 +0100
Message-Id: <20230113141234.260128-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113141234.260128-1-vincent.guittot@linaro.org>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DIET_1,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At wake up, the vruntime of a task is updated to not be more older than
a sched_latency period behind the min_vruntime. This prevents long sleeping
task to get unlimited credit at wakeup.
Such waking task should preempt current one to use its CPU bandwidth but
wakeup_gran() can be larger than sched_latency, filter out the
wakeup preemption and as a results steals some CPU bandwidth to
the waking task.

Make sure that a task, which vruntime has been capped, will preempt current
task and use its CPU bandwidth even if wakeup_gran() is in the same range
as sched_latency.

If the waking task failed to preempt current it could to wait up to
sysctl_sched_min_granularity before preempting it during next tick.

Strictly speaking, we should use cfs->min_vruntime instead of
curr->vruntime but it doesn't worth the additional overhead and complexity
as the vruntime of current should be close to min_vruntime if not equal.

Reported-by: Youssef Esmat <youssefesmat@chromium.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c  | 46 ++++++++++++++++++++------------------------
 kernel/sched/sched.h | 34 +++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e9d906a9bba9..8a85c6cf781e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4657,33 +4657,17 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
 	u64 vruntime = cfs_rq->min_vruntime;
 
-	/*
-	 * The 'current' period is already promised to the current tasks,
-	 * however the extra weight of the new task will slow them down a
-	 * little, place the new task so that it fits in the slot that
-	 * stays open at the end.
-	 */
-	if (initial && sched_feat(START_DEBIT))
-		vruntime += sched_vslice(cfs_rq, se);
-
-	/* sleeps up to a single latency don't count. */
-	if (!initial) {
-		unsigned long thresh;
-
-		if (se_is_idle(se))
-			thresh = sysctl_sched_min_granularity;
-		else
-			thresh = sysctl_sched_latency;
-
+	if (!initial)
+		/* sleeps up to a single latency don't count. */
+		vruntime -= get_sleep_latency(se_is_idle(se));
+	else if (sched_feat(START_DEBIT))
 		/*
-		 * Halve their sleep time's effect, to allow
-		 * for a gentler effect of sleepers:
+		 * The 'current' period is already promised to the current tasks,
+		 * however the extra weight of the new task will slow them down a
+		 * little, place the new task so that it fits in the slot that
+		 * stays open at the end.
 		 */
-		if (sched_feat(GENTLE_FAIR_SLEEPERS))
-			thresh >>= 1;
-
-		vruntime -= thresh;
-	}
+		vruntime += sched_vslice(cfs_rq, se);
 
 	/* ensure we never gain time by being placed backwards. */
 	se->vruntime = max_vruntime(se->vruntime, vruntime);
@@ -7656,6 +7640,18 @@ wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 		return -1;
 
 	gran = wakeup_gran(se);
+
+	/*
+	 * At wake up, the vruntime of a task is capped to not be older than
+	 * a sched_latency period compared to min_vruntime. This prevents long
+	 * sleeping task to get unlimited credit at wakeup. Such waking up task
+	 * has to preempt current in order to not lose its share of CPU
+	 * bandwidth but wakeup_gran() can become higher than scheduling period
+	 * for low priority task. Make sure that long sleeping task will get a
+	 * chance to preempt current.
+	 */
+	gran = min_t(s64, gran, get_latency_max());
+
 	if (vdiff > gran)
 		return 1;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1072502976df..df7db06c9943 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2459,9 +2459,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
-#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
 extern unsigned int sysctl_sched_min_granularity;
+#ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
@@ -2476,6 +2476,38 @@ extern unsigned int sysctl_numa_balancing_scan_size;
 extern unsigned int sysctl_numa_balancing_hot_threshold;
 #endif
 
+static inline unsigned long get_sleep_latency(bool idle)
+{
+	unsigned long thresh;
+
+	if (idle)
+		thresh = sysctl_sched_min_granularity;
+	else
+		thresh = sysctl_sched_latency;
+
+	/*
+	 * Halve their sleep time's effect, to allow
+	 * for a gentler effect of sleepers:
+	 */
+	if (sched_feat(GENTLE_FAIR_SLEEPERS))
+		thresh >>= 1;
+
+	return thresh;
+}
+
+static inline unsigned long get_latency_max(void)
+{
+	unsigned long thresh = get_sleep_latency(false);
+
+	 /*
+	  * If the waking task failed to preempt current it could to wait up to
+	  * sysctl_sched_min_granularity before preempting it during next tick.
+	  */
+	thresh -= sysctl_sched_min_granularity;
+
+	return thresh;
+}
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
-- 
2.34.1

