Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728B781EBD
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbjHTP0U (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjHTP0B (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:26:01 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111044683
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:23:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3feddbb670cso13234655e9.3
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544986; x=1693149786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjJzyXCDZRnO5S3i8PaQSpY49m3CqdcltrMAbk+AgrI=;
        b=H9sJpLmtQexSNnmzR9lDVSDxw7LVQBCygZsvaSp+cGqHTMKeI/TpC00lNhqXVmbpMa
         5ed8pfohi1I2zsWjUwxFcS9rvYK0lhAt1MUWJ2sy/PJrA2Slkfl1Pfe4/LpF5evX8win
         CpwDSQd6RfC8kFl5vkhyb9AEsej7hxtYETrd8qUGQOh0fOSayAf/vYAIW5s8mdi/2i6P
         SISc1WVE2hm7zbkl5uqSRlLeqYaRkOCoaEFmbgK4r+n/SqXx2lp0oRZLsIkDXIhLVNT1
         +GCgWDVifQ0+5XpX2Mogre4B8VEQPq2t6WGs1tIMPJzNjk15hmPE0BiTmon+3DzveZez
         ip4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544986; x=1693149786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjJzyXCDZRnO5S3i8PaQSpY49m3CqdcltrMAbk+AgrI=;
        b=F/rCh6ecaXncxvNXno6wIcquVEv+rNKSBzq9hVHBLe0F0t0ww9LIcMOF6CkkgRa+Qk
         92p+krq/BiNxCSV0yQbkPe/R2zZhqSq8LRb6+HFuQ2zVHOHi05aE0WGrBjW3tys5hGm+
         oc33T5EQP+sXbPeTw8ijMeJHQ5Kw+sswIa2Ii1mwsvwkZ1OUo/nMKgSlo2Uw1HXzKUfL
         RqWW9Nff0PZIsUGl/abDO+l7EVuqTrI0V5De5K9haWRo7jMWQ0e0zJ5MZkr6OCHVQQ4+
         JBLr4hwE8gm38w6y6Thw1hbtkrlbn8CQGkRb4+7Y7KvnVwpbs/rmEbdlsbMDeryMrX13
         eJJw==
X-Gm-Message-State: AOJu0YzGCp3c7nz7WRfjcQ/EoSBQIeCQeGy/CfxRxqia7hvuhLtEVotJ
        OnFg+vmlmgQjVJ7ioWOMOyiixQ==
X-Google-Smtp-Source: AGHT+IGgfmwaMPu6+ziabfVirvrWGn78n4Vx3osiOq1I/zZd75YriD9oasKLB3zsIJfNjonG6rcz2A==
X-Received: by 2002:adf:f10c:0:b0:31c:4c68:e73a with SMTP id r12-20020adff10c000000b0031c4c68e73amr356189wro.66.1692544986616;
        Sun, 20 Aug 2023 08:23:06 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id c3-20020adfe703000000b0031773a8e5c4sm9527466wrm.37.2023.08.20.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:23:06 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 3/6] sched/cpuset: Keep track of SCHED_DEADLINE task in cpusets
Date:   Sun, 20 Aug 2023 16:22:55 +0100
Message-Id: <20230820152258.518128-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152258.518128-1-qyousef@layalina.io>
References: <20230820152258.518128-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit 6c24849f5515e4966d94fa5279bdff4acf2e9489 upstream.

Qais reported that iterating over all tasks when rebuilding root domains
for finding out which ones are DEADLINE and need their bandwidth
correctly restored on such root domains can be a costly operation (10+
ms delays on suspend-resume).

To fix the problem keep track of the number of DEADLINE tasks belonging
to each cpuset and then use this information (followup patch) to only
perform the above iteration if DEADLINE tasks are actually present in
the cpuset for which a corresponding root domain is being rebuilt.

Reported-by: Qais Yousef (Google) <qyousef@layalina.io>
Link: https://lore.kernel.org/lkml/20230206221428.2125324-1-qyousef@layalina.io/
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 6c24849f5515e4966d94fa5279bdff4acf2e9489)
[Conflict in kernel/cgroup/cpuset.c and kernel/sched/deadline.c due to
pulling new code. Reject new code/fields.]
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/cpuset.h  |  4 ++++
 kernel/cgroup/cgroup.c  |  4 ++++
 kernel/cgroup/cpuset.c  | 25 +++++++++++++++++++++++++
 kernel/sched/deadline.c | 13 +++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 5a94f5143924..82fb7e24d1cb 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -56,6 +56,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
+extern void inc_dl_tasks_cs(struct task_struct *task);
+extern void dec_dl_tasks_cs(struct task_struct *task);
 extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
@@ -179,6 +181,8 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
+static inline void inc_dl_tasks_cs(struct task_struct *task) { }
+static inline void dec_dl_tasks_cs(struct task_struct *task) { }
 static inline void cpuset_lock(void) { }
 static inline void cpuset_unlock(void) { }
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6ccdbce17399..be467aea457e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -56,6 +56,7 @@
 #include <linux/file.h>
 #include <linux/fs_parser.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/deadline.h>
 #include <linux/psi.h>
 #include <net/sock.h>
 
@@ -6467,6 +6468,9 @@ void cgroup_exit(struct task_struct *tsk)
 	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
 	cset->nr_tasks--;
 
+	if (dl_task(tsk))
+		dec_dl_tasks_cs(tsk);
+
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
 	if (unlikely(!(tsk->flags & PF_KTHREAD) &&
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0eff9fb4e6d3..00821ed3d300 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -162,6 +162,12 @@ struct cpuset {
 	int use_parent_ecpus;
 	int child_ecpus_count;
 
+	/*
+	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
+	 * know when to rebuild associated root domain bandwidth information.
+	 */
+	int nr_deadline_tasks;
+
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
 };
@@ -209,6 +215,20 @@ static inline struct cpuset *parent_cs(struct cpuset *cs)
 	return css_cs(cs->css.parent);
 }
 
+void inc_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks++;
+}
+
+void dec_dl_tasks_cs(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	cs->nr_deadline_tasks--;
+}
+
 /* bits in struct cpuset flags field */
 typedef enum {
 	CS_ONLINE,
@@ -2210,6 +2230,11 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		ret = security_task_setscheduler(task);
 		if (ret)
 			goto out_unlock;
+
+		if (dl_task(task)) {
+			cs->nr_deadline_tasks++;
+			cpuset_attach_old_cs->nr_deadline_tasks--;
+		}
 	}
 
 	/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b3e206498395..fced55d6e8da 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -17,6 +17,7 @@
  */
 #include "sched.h"
 #include "pelt.h"
+#include <linux/cpuset.h>
 
 struct dl_bandwidth def_dl_bandwidth;
 
@@ -2446,6 +2447,12 @@ static void switched_from_dl(struct rq *rq, struct task_struct *p)
 	if (task_on_rq_queued(p) && p->dl.dl_runtime)
 		task_non_contending(p);
 
+	/*
+	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
+	 * keep track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	dec_dl_tasks_cs(p);
+
 	if (!task_on_rq_queued(p)) {
 		/*
 		 * Inactive timer is armed. However, p is leaving DEADLINE and
@@ -2486,6 +2493,12 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	if (hrtimer_try_to_cancel(&p->dl.inactive_timer) == 1)
 		put_task_struct(p);
 
+	/*
+	 * In case a task is setscheduled to SCHED_DEADLINE we need to keep
+	 * track of that on its cpuset (for correct bandwidth tracking).
+	 */
+	inc_dl_tasks_cs(p);
+
 	/* If p is not queued we will update its parameters at next wakeup. */
 	if (!task_on_rq_queued(p)) {
 		add_rq_bw(&p->dl, &rq->dl);
-- 
2.34.1

