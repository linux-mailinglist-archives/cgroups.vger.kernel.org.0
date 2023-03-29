Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351FB6CD9C5
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 14:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjC2M5v (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 29 Mar 2023 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjC2M5o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 29 Mar 2023 08:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439A2171E
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680094605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AarAALbhiwCdePxFbgwikLSSecQrfwKJY2q+EcgoXOI=;
        b=JckCa7jv8E+yLki8nU7F5vbk30ycdVTx5uOMVkXQYX1pCOvciDtX89XsYUKVVb4PqLgol4
        8kiXustmALhGw5y+HItKQqBSBeC8PfwfiWIar+DkumfWsvQAUuGlUQclSHB8wUfOojnB/S
        l7u5bo2rEz9l4tci+FvP/92Noh65OdU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-7pyn6iU-M2a_PFcgsr9yHw-1; Wed, 29 Mar 2023 08:56:43 -0400
X-MC-Unique: 7pyn6iU-M2a_PFcgsr9yHw-1
Received: by mail-qt1-f197.google.com with SMTP id r4-20020ac867c4000000b003bfefb6dd58so10263052qtp.2
        for <cgroups@vger.kernel.org>; Wed, 29 Mar 2023 05:56:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680094603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AarAALbhiwCdePxFbgwikLSSecQrfwKJY2q+EcgoXOI=;
        b=NAILVQgepoCw8lvtkwdZEfYPqxcOaHdkNvoDsgXf+FskcpKfJDRXiBtD9MK7bwCmhg
         tNc9GzxMlT7d0ZR5bLERBdMYT51NKVceKd9iXhl+bBV2bBqnhwwbgEkgnoQtnwROHFXj
         VNMYJTvtRodrcnn9bXqAsltyL2TmoQmQfm5B3NnP21AM+g/ILafUUDeWaASe+FRZkwdr
         fUZG3ZXpgDN/QdvVl3jks3ZJkJBeadEaAjBwj+S4d8LOcYdL10WdakQoi+WZFKz8KC84
         C5vk4aQFWn7nK/mdbkG/0WpmU7zYWv+j5mnQqcSu2gvCLXqaDnt2e1zcGRujFnRBSynY
         dsXQ==
X-Gm-Message-State: AO0yUKXmzFoEiSQLD3+96tJdL/RMgSs1W+4mA58mzHVBXs67rZ3DeUIl
        7umwb9JCSM3htH0OY3iR9QU3tAk77a98xaAtMfzOuSNoAfcMFN0i7TnMgWDmdoKVN58YR7iZ5hd
        GBkV5ashQHeQuFB4+3w==
X-Received: by 2002:ac8:5a95:0:b0:3e1:59e8:7437 with SMTP id c21-20020ac85a95000000b003e159e87437mr32925160qtc.0.1680094602655;
        Wed, 29 Mar 2023 05:56:42 -0700 (PDT)
X-Google-Smtp-Source: AK7set/lfg19wjU+h28m3jehzaAFckJz1mh+H9hsasvjC7rslxKkdZ+G0cjAjqXoFZ9vnevcwWKHCQ==
X-Received: by 2002:ac8:5a95:0:b0:3e1:59e8:7437 with SMTP id c21-20020ac85a95000000b003e159e87437mr32925117qtc.0.1680094602334;
        Wed, 29 Mar 2023 05:56:42 -0700 (PDT)
Received: from localhost.localdomain.com ([151.29.151.163])
        by smtp.gmail.com with ESMTPSA id c23-20020a379a17000000b007436d0e9408sm13527134qke.127.2023.03.29.05.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 05:56:42 -0700 (PDT)
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
Subject: [PATCH 5/6] cgroup/cpuset: Free DL BW in case can_attach() fails
Date:   Wed, 29 Mar 2023 14:55:57 +0200
Message-Id: <20230329125558.255239-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329125558.255239-1-juri.lelli@redhat.com>
References: <20230329125558.255239-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Dietmar Eggemann <dietmar.eggemann@arm.com>

cpuset_can_attach() can fail. Postpone DL BW allocation until all tasks
have been checked. DL BW is not allocated per-task but as a sum over
all DL tasks migrating.

If multiple controllers are attached to the cgroup next to the cuset
controller a non-cpuset can_attach() can fail. In this case free DL BW
in cpuset_cancel_attach().

Finally, update cpuset DL task count (nr_deadline_tasks) only in
cpuset_attach().

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/sched.h  |  2 +-
 kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++++++++++----
 kernel/sched/core.c    | 17 ++-----------
 3 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6f3d84e0ed08..50cbbfefbe11 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1847,7 +1847,7 @@ current_restore_flags(unsigned long orig_flags, unsigned long flags)
 }
 
 extern int cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
-extern int task_can_attach(struct task_struct *p, const struct cpumask *cs_effective_cpus);
+extern int task_can_attach(struct task_struct *p);
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 #ifdef CONFIG_SMP
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index eb0854ef9757..f8ebec66da51 100644
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
@@ -2464,16 +2466,23 @@ static int fmeter_getrate(struct fmeter *fmp)
 
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
@@ -2491,7 +2500,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 		goto out_unlock;
 
 	cgroup_taskset_for_each(task, css, tset) {
-		ret = task_can_attach(task, cs->effective_cpus);
+		ret = task_can_attach(task);
 		if (ret)
 			goto out_unlock;
 		ret = security_task_setscheduler(task);
@@ -2499,11 +2508,31 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 			goto out_unlock;
 
 		if (dl_task(task)) {
-			cs->nr_deadline_tasks++;
-			cpuset_attach_old_cs->nr_deadline_tasks--;
+			cs->nr_migrate_dl_tasks++;
+			cs->sum_migrate_dl_bw += task->dl.dl_bw;
+		}
+	}
+
+	if (!cs->nr_migrate_dl_tasks)
+		goto out_succes;
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
 		}
 	}
 
+out_succes:
 	/*
 	 * Mark attach is in progress.  This makes validate_change() fail
 	 * changes which zero cpus/mems_allowed.
@@ -2518,11 +2547,21 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
+	struct cpuset *cs;
 
 	cgroup_taskset_first(tset, &css);
+	cs = css_cs(css);
 
 	mutex_lock(&cpuset_mutex);
-	css_cs(css)->attach_in_progress--;
+	cs->attach_in_progress--;
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
 
@@ -2617,6 +2656,12 @@ static void cpuset_attach(struct cgroup_taskset *tset)
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
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c83dae6b8586..10454980e830 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9269,8 +9269,7 @@ int cpuset_cpumask_can_shrink(const struct cpumask *cur,
 	return ret;
 }
 
-int task_can_attach(struct task_struct *p,
-		    const struct cpumask *cs_effective_cpus)
+int task_can_attach(struct task_struct *p)
 {
 	int ret = 0;
 
@@ -9283,21 +9282,9 @@ int task_can_attach(struct task_struct *p,
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
2.39.2

