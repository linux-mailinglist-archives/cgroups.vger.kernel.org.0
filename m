Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7E58361C
	for <lists+cgroups@lfdr.de>; Thu, 28 Jul 2022 02:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiG1A6l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Jul 2022 20:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiG1A6l (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Jul 2022 20:58:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DAAC15A3DC
        for <cgroups@vger.kernel.org>; Wed, 27 Jul 2022 17:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658969918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BmJWjBY43RDpj3JT97t8mjKUtc70HW3e4aiC0GvyquU=;
        b=HdetwII5UdxZF0jjNacU/RmvlXiu8giJ56ORNN6sCaNnkpesq/eOFSfYVtZ5B3pGAsOOvw
        T9sF2zltQ2L+vvLVes/O0WeYqBMGVTE5pCJ2+3BQl8MwrWORHkyhul6vzFuK1WenMfMgKs
        MSZx/OyGBhJtfNjeMD/dXBrjxCbIoBc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-9-s2gKf7mUM02v7tes66gJhA-1; Wed, 27 Jul 2022 20:58:36 -0400
X-MC-Unique: s2gKf7mUM02v7tes66gJhA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DD601C01B3B;
        Thu, 28 Jul 2022 00:58:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51A2EC28100;
        Thu, 28 Jul 2022 00:58:34 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] cgroup/cpuset: Keep current cpus list if cpus affinity was explicitly set
Date:   Wed, 27 Jul 2022 20:58:14 -0400
Message-Id: <20220728005815.1715522-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It was found that any change to the current cpuset hierarchy may reset
the cpus_allowed list of the tasks in the affected cpusets to the
default cpuset value even if those tasks have cpus affinity explicitly
set by the users before. That is especially easy to trigger under a
cgroup v2 environment where writing "+cpuset" to the root cgroup's
cgroup.subtree_control file will reset the cpus affinity of all the
processes in the system.

That is especially problematic in a nohz_full environment where the
tasks running in the nohz_full CPUs usually have their cpus affinity
explicitly set and will behave incorrectly if cpus affinity changes.

Fix this problem by adding a flag in the task structure to indicate that
a task has their cpus affinity explicitly set before and make cpuset
code not to change their cpus_allowed list unless the user chosen cpu
list is no longer a subset of the cpus_allowed list of the cpuset itself.

With that change in place, it was verified that tasks that have its
cpus affinity explicitly set will not be affected by changes made to
the v2 cgroup.subtree_control files.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/sched.h  |  1 +
 kernel/cgroup/cpuset.c | 18 ++++++++++++++++--
 kernel/sched/core.c    |  1 +
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..60ae022fa842 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -815,6 +815,7 @@ struct task_struct {
 
 	unsigned int			policy;
 	int				nr_cpus_allowed;
+	int				cpus_affinity_set;
 	const cpumask_t			*cpus_ptr;
 	cpumask_t			*user_cpus_ptr;
 	cpumask_t			cpus_mask;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 71a418858a5e..c47757c61f39 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -704,6 +704,20 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	return ret;
 }
 
+/*
+ * Don't change the cpus_allowed list if cpus affinity has been explicitly
+ * set before unless the current cpu list is not a subset of the new cpu list.
+ */
+static int cpuset_set_cpus_allowed_ptr(struct task_struct *p,
+				       const struct cpumask *new_mask)
+{
+	if (p->cpus_affinity_set && cpumask_subset(p->cpus_ptr, new_mask))
+		return 0;
+
+	p->cpus_affinity_set = 0;
+	return set_cpus_allowed_ptr(p, new_mask);
+}
+
 #ifdef CONFIG_SMP
 /*
  * Helper routine for generate_sched_domains().
@@ -1130,7 +1144,7 @@ static void update_tasks_cpumask(struct cpuset *cs)
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it)))
-		set_cpus_allowed_ptr(task, cs->effective_cpus);
+		cpuset_set_cpus_allowed_ptr(task, cs->effective_cpus);
 	css_task_iter_end(&it);
 }
 
@@ -2303,7 +2317,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		 * can_attach beforehand should guarantee that this doesn't
 		 * fail.  TODO: have a better way to handle failure here
 		 */
-		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+		WARN_ON_ONCE(cpuset_set_cpus_allowed_ptr(task, cpus_attach));
 
 		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 		cpuset_update_task_spread_flag(cs, task);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index da0bf6fe9ecd..ab8ea6fa92db 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8034,6 +8034,7 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
 	if (retval)
 		goto out_free_new_mask;
 
+	p->cpus_affinity_set = 1;
 	cpuset_cpus_allowed(p, cpus_allowed);
 	if (!cpumask_subset(new_mask, cpus_allowed)) {
 		/*
-- 
2.31.1

