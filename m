Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B1D781E9A
	for <lists+cgroups@lfdr.de>; Sun, 20 Aug 2023 17:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjHTPZd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 20 Aug 2023 11:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbjHTPZZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 20 Aug 2023 11:25:25 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18B13C27
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:21:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fee8af9cb9so7045835e9.1
        for <cgroups@vger.kernel.org>; Sun, 20 Aug 2023 08:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692544915; x=1693149715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4eaIWX40z8aFQo5GiCOptHOVpDMLSBVPcf1X2aT4ak=;
        b=QsXYhxXf782rhJMh/sqsFzrX21R2XzYEvaym0Bu52SKp465+zDHhM5fpV8ZJ00vZf7
         BBa8tgl9VO6d/WAkohGEYZ4k3RIopI/mFAXUmvrJFY4Ux3LTRqCTGaK/b0aeO8h+rhpc
         w2eKjxhF7OKvGZ0qNyYSYLAx76zxzbOZ8uTF30ZdxGES7dBTz8+nR4n/08dYmSkEdh6d
         K3tEARiYiwsMAuk03NtiSVa23xQ9cgTCGeqNXwNl+pN3QX2e2/QbPfgeU/t/ocIiz6ho
         L3vztvCYkbRlEYPjaQnQaRsUuKt67bYRV272S5XitjNvkPtcqMpgLLz/oxtyhKSd5Fzs
         xsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692544915; x=1693149715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R4eaIWX40z8aFQo5GiCOptHOVpDMLSBVPcf1X2aT4ak=;
        b=QmT2GnUhst3nElMt1x6MbELQZ5PAUBZEteOmXJyye2dVwmGpeQtIrhDVbnE5YmXOdK
         RgnO254QuVVEZnUxa+8ZQg2Nle8O3ZfDoaJ1IWKY9moIUEKqNStBjS1r6Qt8CW5Mfeaz
         kCJEqZCdZdFtnrcIchQ8eReDQfdoMQh2PG7qiyS1fjaHQKzc2zyGZ3ZRHr8D8ogv9zEJ
         ewt9K0be+/rxNRIT1Mhcj5LDhs+bKigrvZpFutKJkbWALsbeOoBxG9FIfXoI1RaaRg+0
         RcOhcbneViXthBxN0ch8HAvdYAAOKahI+DTpTG7jov9vNG/fOgra5jyr2YGFBlC9Z+Ej
         GhHw==
X-Gm-Message-State: AOJu0YzI9cjT6lG0ChsWdrB9SaCLanHWotHN7AAZHerUk9R/nfuwKh6y
        PZ3YdXhAz6VAP+dwUDqP198kQg==
X-Google-Smtp-Source: AGHT+IHn0fwc2jENegxBe9PyXo1n9ODl+3gIuSa/3VM76XMCfcqbjb/N68Ux1JEBpVKgN4b2np9eeA==
X-Received: by 2002:a7b:c34d:0:b0:3fe:2e0d:b715 with SMTP id l13-20020a7bc34d000000b003fe2e0db715mr3401627wmj.18.1692544915420;
        Sun, 20 Aug 2023 08:21:55 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003fe3674bb39sm9762497wms.2.2023.08.20.08.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 08:21:55 -0700 (PDT)
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
Date:   Sun, 20 Aug 2023 16:21:44 +0100
Message-Id: <20230820152144.517461-7-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230820152144.517461-1-qyousef@layalina.io>
References: <20230820152144.517461-1-qyousef@layalina.io>
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
[Fix conflicts in kernel/cgroup/cpuset.c due to new code being applied
that is not applicable on this branch. Reject new code.]
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/sched.h  |  2 +-
 kernel/cgroup/cpuset.c | 51 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/core.c    | 17 ++------------
 3 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index f4b3640dadb8..aa015416c569 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1657,7 +1657,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6c69e715b05a..195f9cccab20 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -167,6 +167,8 @@ struct cpuset {
 	 * know when to rebuild associated root domain bandwidth information.
 	 */
 	int nr_deadline_tasks;
+	int nr_migrate_dl_tasks;
+	u64 sum_migrate_dl_bw;
 };
 
 /*
@@ -2168,16 +2170,23 @@ static int fmeter_getrate(struct fmeter *fmp)
 
 static struct cpuset *cpuset_attach_old_cs;
 
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
@@ -2189,7 +2198,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->effective_cpus);
+		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
@@ -2197,11 +2206,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
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
@@ -2225,6 +2254,14 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
 
@@ -2299,6 +2336,12 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cfcd2059a66..40f40f359c5d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6600,8 +6600,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_effective_cpus)
+int task_can_attach(struct task_struct *p)
 {
 	int ret = 0;
 
@@ -6614,21 +6613,9 @@ int task_can_attach(struct task_struct *p,
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

