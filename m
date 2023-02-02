Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0089D68802D
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjBBOdL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 09:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjBBOdF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 09:33:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F2A712FC
        for <cgroups@vger.kernel.org>; Thu,  2 Feb 2023 06:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675348339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K4+oxLjiheAOZOYbU74GypHSVXBNjbH6+0gElb58eD0=;
        b=IsbLE3BPfbFR54UlN1UJDel7bNeWhSny5JMk9aHNfAHXBOg9a68c7jtdNZyia5IbU+ZfmN
        qAvuTfQZ4F0eHtOYUqgCa8ope6ZYapnU1srbb9VAxkC8kqcwS2ArhPk6Cgd4T8H+r/l+bB
        YN18BREkq4fERjzeiq/w0L7s1soAYQs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-134-T59fjzIaMl-1DX2bA2x_8A-1; Thu, 02 Feb 2023 09:32:15 -0500
X-MC-Unique: T59fjzIaMl-1DX2bA2x_8A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1BAD98030CB;
        Thu,  2 Feb 2023 14:32:11 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B359451E5;
        Thu,  2 Feb 2023 14:32:10 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com, Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] cgroup/cpuset: Don't update tasks' cpumasks for cpu offline events
Date:   Thu,  2 Feb 2023 09:32:00 -0500
Message-Id: <20230202143200.128753-3-longman@redhat.com>
In-Reply-To: <20230202143200.128753-1-longman@redhat.com>
References: <20230202143200.128753-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is a known issue that when a task is in a non-root v1 cpuset, a cpu
offline event will cause that cpu to be lost from the task's cpumask
permanently as the cpuset's cpus_allowed mask won't get back that cpu
when it becomes online again. A possible workaround for this type of
cpu offline/online sequence is to leave the offline cpu in the task's
cpumask and do the update only if new cpus are added. It also has the
benefit of reducing the overhead of a cpu offline event.

Note that the scheduler is able to ignore the offline cpus and so
leaving offline cpus in the cpumask won't do any harm.

Now with v2, only the cpu online events will cause a call to
hotplug_update_tasks() to update the tasks' cpumasks. For tasks
in a non-root v1 cpuset, the situation is a bit different. The cpu
offline event will not cause change to a task's cpumask. Neither does a
subsequent cpu online event because "cpuset.cpus" had that offline cpu
removed and its subsequent onlining won't be registered as a change
to the cpuset. An exception is when all the cpus in the original
"cpuset.cpus" have gone offline once. In that case, "cpuset.cpus" will
become empty which will force task migration to its parent. A task's
cpumask will also be changed if set_cpus_allowed_ptr() is somehow called
for whatever reason.

Of course, this patch can cause a discrepancy between v1's "cpuset.cpus"
and and its tasks' cpumasks. Howver, it can also largely work around
the offline cpu losing problem with v1 cpuset.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cbf749fc05d9..207bafdb05e8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3332,7 +3332,7 @@ static void remove_tasks_in_empty_cpuset(struct cpuset *cs)
 static void
 hotplug_update_tasks_legacy(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
-			    bool cpus_updated, bool mems_updated)
+			    bool update_task_cpus, bool mems_updated)
 {
 	bool is_empty;
 
@@ -3347,7 +3347,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
 	 * as the tasks will be migrated to an ancestor.
 	 */
-	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
+	if (update_task_cpus && !cpumask_empty(cs->cpus_allowed))
 		update_tasks_cpumask(cs);
 	if (mems_updated && !nodes_empty(cs->mems_allowed))
 		update_tasks_nodemask(cs);
@@ -3371,11 +3371,14 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 static void
 hotplug_update_tasks(struct cpuset *cs,
 		     struct cpumask *new_cpus, nodemask_t *new_mems,
-		     bool cpus_updated, bool mems_updated)
+		     bool update_task_cpus, bool mems_updated)
 {
 	/* A partition root is allowed to have empty effective cpus */
-	if (cpumask_empty(new_cpus) && !is_partition_valid(cs))
+	if (cpumask_empty(new_cpus) && !is_partition_valid(cs)) {
 		cpumask_copy(new_cpus, parent_cs(cs)->effective_cpus);
+		update_task_cpus = true;
+	}
+
 	if (nodes_empty(*new_mems))
 		*new_mems = parent_cs(cs)->effective_mems;
 
@@ -3384,7 +3387,7 @@ hotplug_update_tasks(struct cpuset *cs,
 	cs->effective_mems = *new_mems;
 	spin_unlock_irq(&callback_lock);
 
-	if (cpus_updated)
+	if (update_task_cpus)
 		update_tasks_cpumask(cs);
 	if (mems_updated)
 		update_tasks_nodemask(cs);
@@ -3410,7 +3413,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 {
 	static cpumask_t new_cpus;
 	static nodemask_t new_mems;
-	bool cpus_updated;
+	bool cpus_updated, update_task_cpus;
 	bool mems_updated;
 	struct cpuset *parent;
 retry:
@@ -3512,12 +3515,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (mems_updated)
 		check_insane_mems_config(&new_mems);
 
+	/*
+	 * Update tasks' cpumasks only if new cpus are added. Some offline
+	 * cpus may be left, but the scheduler has no problem ignoring those.
+	 * The case of empty new_cpus will be handled inside
+	 * hotplug_update_tasks().
+	 */
+	update_task_cpus = cpus_updated &&
+			   !cpumask_subset(&new_cpus, cs->effective_cpus);
+
 	if (is_in_v2_mode())
 		hotplug_update_tasks(cs, &new_cpus, &new_mems,
-				     cpus_updated, mems_updated);
+				     update_task_cpus, mems_updated);
 	else
 		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
-					    cpus_updated, mems_updated);
+					    update_task_cpus, mems_updated);
 
 unlock:
 	percpu_up_write(&cpuset_rwsem);
-- 
2.31.1

