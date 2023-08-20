Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1072781E8C
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjHTPZF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjHTPZB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:25:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C349C1
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:24:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3198d2745feso2232813f8f.1
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692545072; x=1693149872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDz/YcZW7+uYCKsBbezAQo5gXEMmfxi4O3UJgcQICwE=;
        b=LBxR+5WUJJC8BFpWBKuZn3ghPrCSgN5IqdKfN0jHHKXYxCR8TeZhmNh8//JJMYOoWS
         vDcp0V1TNpdG6kQAxDz8xAhZsiTpdiBEJUnvPGnyY+LOtemg/tEJtm+x+au8GaCMm9zO
         4AohXa2u4pkbAhd1+Gg5523S429t+Bx8Ymx04x7d43JTvQw3sZRbc/+czO5y1nTOa74j
         8PApzIpgPqsJQK+QnefFaAgNmVhYkOMcbDaPShRGNQxk4mAOMy+ODpN3222LvBQQkyWh
         ZVaYAuuTtrJgnqRePk9qToNMLiUGFh4KVgNWBQMkWiqw/dQHF2TIEzT6GweoF1CiHCaG
         AdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692545072; x=1693149872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDz/YcZW7+uYCKsBbezAQo5gXEMmfxi4O3UJgcQICwE=;
        b=Efgdme22gW2WsPRYmilnMY1WAKW8q8EsZr05TmGX+eej+VZo430fJxmLbXtGNjNbz8
         8vpr85z++u7lopOOV3vR8Mt0KYusOD35B8TV7/jCMyPWPFk3DnxWFXDlauNFd96NRfc3
         cPxYoDbdVeeyuqIe5v8tUZNqRrifhYa/7s03dYt5c3wy+6AhHcNY4UzCpu+YsZfFbbvV
         0sMiZx1cMup8R9rsvWYnr5XCmrHZ+YsobC7SsmhvKG7rVkO1IZ+e3oLA7+u+7PPKLtGW
         6cDu3Re/Te+4+Q3Zk8du0E+6w9qtJv29QWALVf61DphU6s8Aa+kKigfj60HL2IzWXkqT
         SX0Q==
X-Gm-Message-State: AOJu0YxsMWssxCnPF1F2fs1K9KJgnU41B9pQtCj4DkTe8J8x5sFqtOig
        WIHoQYPEEzTF7Kf7xacHoWFQvQ==
X-Google-Smtp-Source: AGHT+IFRV5o+dRUe5UGyJ2X0Jgyucw0WfqhTy/NidJ+qaEvXmLIhCDSSXv+/qsEk11Fm+2/rVWdUYA==
X-Received: by 2002:adf:f011:0:b0:317:6965:ef4d with SMTP id j17-20020adff011000000b003176965ef4dmr3075246wro.56.1692545072059;
        Sun, 20 Aug 2023 08:24:32 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d4fcb000000b003141e629cb6sm9419257wrw.101.2023.08.20.08.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:24:31 -0700 (PDT)
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
Subject: [PATCH 6/6] cgroup/cpuset: Free DL BW in case can_attach() fails
Date:   Sun, 20 Aug 2023 16:24:17 +0100
Message-Id: <20230820152417.518806-7-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152417.518806-1-qyousef@layalina.io>
References: <20230820152417.518806-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

commit 2ef269ef1ac006acf974793d975539244d77b28f upstream.

cpuset_can_attach() can fail. Postpone DL BW allocation until all tasks
have been checked. DL BW is not allocated per-task but as a sum over
all DL tasks migrating.

If multiple controllers are attached to the cgroup next to the cpuset
controller a non-cpuset can_attach() can fail. In this case free DL BW
in cpuset_cancel_attach().

Finally, update cpuset DL task count (nr_deadline_tasks) only in
cpuset_attach().

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 2ef269ef1ac006acf974793d975539244d77b28f)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/sched.h  |  2 +-
 kernel/cgroup/cpuset.c | 53 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/core.c    | 17 ++------------
 3 files changed, 51 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b2e30fbbeef0..0cac69902ec5 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1846,7 +1846,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index eca07ff71656..db3e05b6b4dd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -198,6 +198,8 @@ struct cpuset {
 	 * know when to rebuild associated root domain bandwidth information.
 	 */
 	int nr_deadline_tasks;
+	int nr_migrate_dl_tasks;
+	u64 sum_migrate_dl_bw;
 
 	/* Invalid partition error code, not lock protected */
 	enum prs_errcode prs_err;
@@ -2491,16 +2493,23 @@ static int cpuset_can_attach_check(struct cpuset *cs)
 	return 0;
 }
 
+static void reset_migrate_dl_data(struct cpuset *cs)
+{
+	cs->nr_migrate_dl_tasks = 0;
+	cs->sum_migrate_dl_bw = 0;
+}
+
 /* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
-	struct cpuset *cs;
+	struct cpuset *cs, *oldcs;
 	struct task_struct *task;
 	int ret;
 
 	/* used later by cpuset_attach() */
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
+	oldcs = cpuset_attach_old_cs;
 	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
@@ -2511,7 +2520,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->effective_cpus);
+		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
@@ -2519,11 +2528,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			goto out_unlock;
 
 		if (dl_task(task)) {
-			cs->nr_deadline_tasks++;
-			cpuset_attach_old_cs->nr_deadline_tasks--;
+			cs->nr_migrate_dl_tasks++;
+			cs->sum_migrate_dl_bw += task->dl.dl_bw;
 		}
 	}
 
+	if (!cs->nr_migrate_dl_tasks)
+		goto out_success;
+
+	if (!cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)) {
+		int cpu = cpumask_any_and(cpu_active_mask, cs->effective_cpus);
+
+		if (unlikely(cpu >= nr_cpu_ids)) {
+			reset_migrate_dl_data(cs);
+			ret = -EINVAL;
+			goto out_unlock;
+		}
+
+		ret = dl_bw_alloc(cpu, cs->sum_migrate_dl_bw);
+		if (ret) {
+			reset_migrate_dl_data(cs);
+			goto out_unlock;
+		}
+	}
+
+out_success:
 	/*
 	 * Mark attach is in progress.  This makes validate_change() fail
 	 * changes which zero cpus/mems_allowed.
@@ -2546,6 +2575,14 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
+
+	if (cs->nr_migrate_dl_tasks) {
+		int cpu = cpumask_any(cs->effective_cpus);
+
+		dl_bw_free(cpu, cs->sum_migrate_dl_bw);
+		reset_migrate_dl_data(cs);
+	}
+
 	mutex_unlock(&cpuset_mutex);
 }
 
@@ -2623,6 +2660,12 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
+	if (cs->nr_migrate_dl_tasks) {
+		cs->nr_deadline_tasks += cs->nr_migrate_dl_tasks;
+		oldcs->nr_deadline_tasks -= cs->nr_migrate_dl_tasks;
+		reset_migrate_dl_data(cs);
+	}
+
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
@@ -3298,7 +3341,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	if (ret)
 		goto out_unlock;
 
-	ret = task_can_attach(task, cs->effective_cpus);
+	ret = task_can_attach(task);
 	if (ret)
 		goto out_unlock;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6963fc4ef897..0f6a92737c91 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9083,8 +9083,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_effective_cpus)
+int task_can_attach(struct task_struct *p)
 {
 	int ret = 0;
 
@@ -9097,21 +9096,9 @@ int task_can_attach(struct task_struct *p,
 	 * success of set_cpus_allowed_ptr() on all attached tasks
 	 * before cpus_mask may be changed.
 	 */
-	if (p->flags & PF_NO_SETAFFINITY) {
+	if (p->flags & PF_NO_SETAFFINITY)
 		ret = -EINVAL;
-		goto out;
-	}
-
-	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
-					      cs_effective_cpus)) {
-		int cpu = cpumask_any_and(cpu_active_mask, cs_effective_cpus);
 
-		if (unlikely(cpu >= nr_cpu_ids))
-			return -EINVAL;
-		ret = dl_bw_alloc(cpu, p->dl.dl_bw);
-	}
-
-out:
 	return ret;
 }
 
-- 
2.34.1

