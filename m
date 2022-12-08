Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15C06476DB
	for <lists+cgroups@lfdr.de>; Thu,  8 Dec 2022 20:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiLHT56 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Dec 2022 14:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLHT54 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Dec 2022 14:57:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1685F6C3
        for <cgroups@vger.kernel.org>; Thu,  8 Dec 2022 11:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670529421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o3RT2XE+xKZNyXg1+7HlKgY8RIpsHwoxTjw78hAkIis=;
        b=TObXH1gDs2BbRWgiSLwVD1SpEOZUYs9hKrmLNIz7kGiMBZSezZJqmseNr4y9aIhF7pnWq3
        SGohLqUbYQIFhdvUeD8xw6SX+WAN6a1thzlU5R5DHa/wkQJnlDiF5E+vdoR4xOtW6LhYsS
        vrMmNtyH4JQp4P4k/pqelU5EOf9Fxq0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-YlI51mnrM8uB4EAmYlyLOQ-1; Thu, 08 Dec 2022 14:57:00 -0500
X-MC-Unique: YlI51mnrM8uB4EAmYlyLOQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1A6D868A22;
        Thu,  8 Dec 2022 19:56:59 +0000 (UTC)
Received: from llong.com (dhcp-17-153.bos.redhat.com [10.18.17.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71437492B04;
        Thu,  8 Dec 2022 19:56:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] cgroup/cpuset: Use cpuset_rwsem read lock in cpuset_can_attach()
Date:   Thu,  8 Dec 2022 14:56:33 -0500
Message-Id: <20221208195634.2604362-2-longman@redhat.com>
In-Reply-To: <20221208195634.2604362-1-longman@redhat.com>
References: <20221208195634.2604362-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 1243dc518c9d ("cgroup/cpuset: Convert cpuset_mutex to
percpu_rwsem"), cpuset_mutex is changed to cpuset_rwsem. This has the
undesirable side effect of increasing the latency to take cpuset_rwsem
write lock, potentially up to a RCU grace period later which can be
especially problematic on systems with a large number of CPU cores.

One particular pain point is moving a task from one cpuset to another
one. The locking sequence for such a task migration is as follow:

  cgroup_mutex => cgroup_threadgroup_rwsem => cpuset_rwsem

The cpuset_rwsem write lock has to be taken twice - at both
cpuset_can_attach() and cpuset_attach(). This can create significant
delay in blocking the fork/exit path while the task migration is in
progress.

Reduce that latency by using cpuset_rwsem read lock in
cpuset_can_attach() and cpuset_cancel_attach() as they don't need to
change anything in the cpuset except attach_in_progress which is now
changed to an atomic_t type to allow proper concurrent update while
holding cpuset_rwsem read lock. The attach_in_progress field is only read
while holding cpuset_rwsem write lock avoiding possible race condition.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index b474289c15b8..800c65de5daa 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -171,7 +171,7 @@ struct cpuset {
 	 * Tasks are being attached to this cpuset.  Used to prevent
 	 * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
 	 */
-	int attach_in_progress;
+	atomic_t attach_in_progress;
 
 	/* partition number for rebuild_sched_domains() */
 	int pn;
@@ -369,11 +369,14 @@ static struct cpuset top_cpuset = {
  * There are two global locks guarding cpuset structures - cpuset_rwsem and
  * callback_lock. We also require taking task_lock() when dereferencing a
  * task's cpuset pointer. See "The task_lock() exception", at the end of this
- * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
- * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
- * prevent change to cpuset structures.
- *
- * A task must hold both locks to modify cpusets.  If a task holds
+ * comment.  The cpuset code uses mostly cpuset_rwsem write lock with the
+ * exception of cpuset_can_attach() and cpuset_cancel_attach().  Other kernel
+ * subsystems can use cpuset_read_lock()/cpuset_read_unlock() to prevent
+ * change to cpuset structures.
+ *
+ * A task must hold both locks to modify cpusets except attach_in_progress
+ * which can be modified by either holding cpuset_rwsem read or write
+ * lock and to be read under cpuset_rwsem write lock.  If a task holds
  * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
  * is the only task able to also acquire callback_lock and be able to
  * modify cpusets.  It can perform various checks on the cpuset structure
@@ -746,7 +749,8 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 * be changed to have empty cpus_allowed or mems_allowed.
 	 */
 	ret = -ENOSPC;
-	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
+	if ((cgroup_is_populated(cur->css.cgroup) ||
+	     atomic_read(&cur->attach_in_progress))) {
 		if (!cpumask_empty(cur->cpus_allowed) &&
 		    cpumask_empty(trial->cpus_allowed))
 			goto out;
@@ -2448,7 +2452,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	percpu_down_read(&cpuset_rwsem);
 
 	/* allow moving tasks into an empty cpuset if on default hierarchy */
 	ret = -ENOSPC;
@@ -2475,10 +2479,10 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 * Mark attach is in progress.  This makes validate_change() fail
 	 * changes which zero cpus/mems_allowed.
 	 */
-	cs->attach_in_progress++;
+	atomic_inc(&cs->attach_in_progress);
 	ret = 0;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	percpu_up_read(&cpuset_rwsem);
 	return ret;
 }
 
@@ -2488,9 +2492,9 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 
 	cgroup_taskset_first(tset, &css);
 
-	percpu_down_write(&cpuset_rwsem);
-	css_cs(css)->attach_in_progress--;
-	percpu_up_write(&cpuset_rwsem);
+	percpu_down_read(&cpuset_rwsem);
+	atomic_dec(&css_cs(css)->attach_in_progress);
+	percpu_up_read(&cpuset_rwsem);
 }
 
 /*
@@ -2562,8 +2566,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 
 	cs->old_mems_allowed = cpuset_attach_nodemask_to;
 
-	cs->attach_in_progress--;
-	if (!cs->attach_in_progress)
+	atomic_inc(&cs->attach_in_progress);
+	if (!atomic_read(&cs->attach_in_progress))
 		wake_up(&cpuset_attach_wq);
 
 	percpu_up_write(&cpuset_rwsem);
@@ -3072,6 +3076,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	nodes_clear(cs->mems_allowed);
 	nodes_clear(cs->effective_mems);
 	fmeter_init(&cs->fmeter);
+	atomic_set(&cs->attach_in_progress, 0);
 	cs->relax_domain_level = -1;
 
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
@@ -3383,7 +3388,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	bool mems_updated;
 	struct cpuset *parent;
 retry:
-	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
+	wait_event(cpuset_attach_wq, atomic_read(&cs->attach_in_progress) == 0);
 
 	percpu_down_write(&cpuset_rwsem);
 
@@ -3391,7 +3396,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	 * We have raced with task attaching. We wait until attaching
 	 * is finished, so we won't attach a task to an empty cpuset.
 	 */
-	if (cs->attach_in_progress) {
+	if (atomic_read(&cs->attach_in_progress)) {
 		percpu_up_write(&cpuset_rwsem);
 		goto retry;
 	}
-- 
2.31.1

