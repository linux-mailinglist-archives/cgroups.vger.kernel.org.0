Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED10978358B
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 00:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjHUWUj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 18:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjHUWUi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 18:20:38 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B87127
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 15:20:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso36876945e9.0
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 15:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692656426; x=1693261226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddy6FCEY5hzeS0746oHXREKMbN9QVr6NPEwblklvNZo=;
        b=4LGFXD8A8ENlsep9RQwGl10vPxO88NsvzMgXD+9eNRZ/7DkjwMT1Zi45Y77ZHu5j35
         fAR/SWi67fTJGy6DPHA5dGI0BYGOP9hZRMzlgCTW8qYqB9Ph1w4Hecrw80DG03EL+91s
         KANRNANdrqCmfVVCsebcxcdAsgsG82MH/roQ1LK+1P2+qhUN+FO31C/FheHaizkfb1Lj
         EB7ETBvwnb85T1LCOCXiKyHbjloZva22BLI3QZ5anM/mQ6CY4lpl+j0BzBzOZWPDxbMm
         p0AnclTj2DwBoi/mLAlySk0v3njaL+AL0rpvxPoGFmFSd/hq2dKwRHgy0p4VXMoPEwIz
         d4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656426; x=1693261226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddy6FCEY5hzeS0746oHXREKMbN9QVr6NPEwblklvNZo=;
        b=VmzRlJyjDh/OB3vHOpbBPxlvfTCiqk9opRELfS9TTBOhLnDPaNxS35VnrGZJEtAHE2
         iVJsQAraJua7RUJR3mT9qk0UX/fFPUO87IOLY+jz8AzR561RuMhNqF/iTf1Yjup3jDP/
         h5/1WI9a67fnSiBFBTJhG9NdG8gP9bVqnLXIn9m6PhlHYjysEIquUOGCFmjenOS63lxP
         6AKpGjBQPEhzU1eWOLULry7tP1h+oAzzQ1hyzUEj4dZYMWY/0W8pVGrZpy09vbKSUKEO
         5pOOk5bl/zONRpgws0w/YO/x13OcGRymFM8VXU8THXgPUgAbBWOKn7AO1DOsVzVcR0Vu
         CQ7Q==
X-Gm-Message-State: AOJu0YyeAdNgFWdD3sDT7LZ57N08xRYlQLJKP1DmwoT+yaGoiNSIDDOS
        4qCWrQfPwVuJ6AyPpJN00sK3vw==
X-Google-Smtp-Source: AGHT+IGuL4lJ6a+Hcvj9IHHW0ZedYrdkuqW75STmYvkP3MfMFqU7cHV/ivmQuIUtxDCkFoP1IOnzQg==
X-Received: by 2002:a05:600c:214a:b0:3fc:25:ced6 with SMTP id v10-20020a05600c214a00b003fc0025ced6mr6358964wml.13.1692656426229;
        Mon, 21 Aug 2023 15:20:26 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fe61c33df5sm17751154wmb.3.2023.08.21.15.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:20:25 -0700 (PDT)
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
Date:   Mon, 21 Aug 2023 23:19:56 +0100
Message-Id: <20230821221956.698117-7-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821221956.698117-1-qyousef@layalina.io>
References: <20230821221956.698117-1-qyousef@layalina.io>
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
index 0bee06542450..2553918f0b61 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1852,7 +1852,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b7168970fff2..2c76fcd9f0bc 100644
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
@@ -2496,16 +2498,23 @@ static int cpuset_can_attach_check(struct cpuset *cs)
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
@@ -2516,7 +2525,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->effective_cpus);
+		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
@@ -2524,11 +2533,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -2551,6 +2580,14 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
 
@@ -2651,6 +2688,12 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 out:
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
@@ -3330,7 +3373,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	if (ret)
 		goto out_unlock;
 
-	ret = task_can_attach(task, cs->effective_cpus);
+	ret = task_can_attach(task);
 	if (ret)
 		goto out_unlock;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 50fab8114260..90005760003f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9294,8 +9294,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_effective_cpus)
+int task_can_attach(struct task_struct *p)
 {
 	int ret = 0;
 
@@ -9308,21 +9307,9 @@ int task_can_attach(struct task_struct *p,
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

