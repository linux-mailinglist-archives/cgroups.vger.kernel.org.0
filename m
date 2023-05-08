Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D418A6FA1D0
	for <lists+cgroups@lfdr.de>; Mon,  8 May 2023 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjEHIBW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 May 2023 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbjEHIA3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 May 2023 04:00:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46BF226AE
        for <cgroups@vger.kernel.org>; Mon,  8 May 2023 00:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683532760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfPukP/Du1LGfYJq+OltwvS6nBsX94mIek7bBbVyGoI=;
        b=CJPkLOuu5A2RQ66TRWkMRRPqyaHUHbeEkvk0n6mFp1P9CazB7wETAeIDEkeKsp4IEJ+333
        8I7lit298CuNbdMcgX7BzIulU8cOp5tVbpZddio4j7qT6ndE6vMO6SqFRpQAW1tnstmT1V
        xuRprbZTyFziSyfBrh9krKjhQFWHLwc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-7Nr_mFHVNbaXYSLufR6nbg-1; Mon, 08 May 2023 03:59:19 -0400
X-MC-Unique: 7Nr_mFHVNbaXYSLufR6nbg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f41dcf1e28so5959635e9.3
        for <cgroups@vger.kernel.org>; Mon, 08 May 2023 00:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683532758; x=1686124758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfPukP/Du1LGfYJq+OltwvS6nBsX94mIek7bBbVyGoI=;
        b=kuftiu/u4bI1Q8+721/inHdCgauQf7DSIDcAyEhuuSVdv8la5hksIbO3b6/zjc2dDL
         r41urz50+r0yYfHwh6fR0HK0NxRqsEHjy4FTyaM15ljw7CQGLYRv4v1EHqbCcIv4w7+s
         iGnIRQwkmSFx6Jjxb+/F5YK+8Y4VUiTX0JFZK2M0/Ogx8Mu46PZdFXZXSwujb/tITfk/
         dD+SeDrjXyjCBui/MA6fGOd+Sh8rdjuqEVk0wuUHEJthwohS4S6nFkGvBz36tMs1MHE5
         7Wmw0IpJXKZyX8fu+FfBj4RNVllmJrUIGfizZaVLx6pjGC+YYre1YIzu6uWmo8kGrnfP
         ef6Q==
X-Gm-Message-State: AC+VfDyVHpbnOYzQZ6rSLjmpA7tvdwW6jYAOk0L39qgsAJ4s9KvIo/j2
        oIzzZmzPSoMOIRlSSohVXa1XhOjxoW31mvaKbk0aU8rX6GVJNaTweCMhSI70xSJ1oMezSwmit3z
        nE25uGeBRSX7cOSpFhA==
X-Received: by 2002:a7b:c314:0:b0:3ef:6b97:f0c3 with SMTP id k20-20020a7bc314000000b003ef6b97f0c3mr6383493wmj.15.1683532758543;
        Mon, 08 May 2023 00:59:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5QMc6nmMYpZnn81W6ZDf8+8596wsBwbRO3giK5xp1GXbx6tSIlERS1jK411lcpHz4EQI2Ccg==
X-Received: by 2002:a7b:c314:0:b0:3ef:6b97:f0c3 with SMTP id k20-20020a7bc314000000b003ef6b97f0c3mr6383474wmj.15.1683532758258;
        Mon, 08 May 2023 00:59:18 -0700 (PDT)
Received: from localhost.localdomain.com ([176.206.13.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a7bcd08000000b003f42894ebe2sm250423wmj.23.2023.05.08.00.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 00:59:17 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v3 6/6] cgroup/cpuset: Free DL BW in case can_attach() fails
Date:   Mon,  8 May 2023 09:58:54 +0200
Message-Id: <20230508075854.17215-7-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508075854.17215-1-juri.lelli@redhat.com>
References: <20230508075854.17215-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

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
index c7a346cfdd8d..c994d39cb0b2 100644
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
index df659892d7d5..ed0d7381b2ec 100644
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
2.40.1

