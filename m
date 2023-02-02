Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8F36873BA
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 04:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjBBDTN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 22:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjBBDTM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 22:19:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B211298F1
        for <cgroups@vger.kernel.org>; Wed,  1 Feb 2023 19:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675307905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0byIjFVLJjYccYZ4C0wxeuACvdHbraDwQ8DEwlpl42E=;
        b=fB7Qw5ah8J3ksyux7RxrO2UbwawOymbf0NN6UZNfCTdVln0W4tldZsdiciUVCZ8mMiRBJw
        vzQNmr6EbvohXP/XMdtS7g8yVYnxgXnPOEcTgxn/rCx4lMDcl26ABBVP4soDX3K0FwcPLx
        I2MriBRVFzDhoxNiFMXTfAI2PreD3N8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-T6uSgZiyM-KDNkGcQDrT6w-1; Wed, 01 Feb 2023 22:18:22 -0500
X-MC-Unique: T6uSgZiyM-KDNkGcQDrT6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D94F29AA2D0;
        Thu,  2 Feb 2023 03:18:21 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A9FDD2026D4B;
        Thu,  2 Feb 2023 03:18:20 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@android.com, Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup/cpuset: Don't update tasks' cpumasks for cpu offline events
Date:   Wed,  1 Feb 2023 22:17:49 -0500
Message-Id: <20230202031749.118146-3-longman@redhat.com>
In-Reply-To: <20230202031749.118146-1-longman@redhat.com>
References: <20230202031749.118146-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It is a known issue that when a task is in a non-root v1 cpuset, a cpu
offline event will cause that cpu to be lost from the task's cpumask
permanently as the cpus_allowed mask won't get back that cpu when it
becomes online again. A partial workaround for this type of single
cpu offline/online sequence is to leave the offline cpu in the task's
cpumask and do the update only if new cpus are added. It also has the
benefit of reducing the overhead of a cpu offline event.

Note that the scheduler is able to ignore the offline cpus and so
leaving offline cpus in the cpumask won't do any harm.

Some cpus will still be lost if more than one cpu become offline
initially and then become online again. Or when set_cpus_allowed_ptr()
is somehow called. There can also be a discrepancy between cpus_allowed
and the task's cpumask.

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

