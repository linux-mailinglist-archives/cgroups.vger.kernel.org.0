Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47D683925
	for <lists+cgroups@lfdr.de>; Tue, 31 Jan 2023 23:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbjAaWRd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 31 Jan 2023 17:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjAaWRc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 31 Jan 2023 17:17:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAF9460BA;
        Tue, 31 Jan 2023 14:17:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BACAB81F54;
        Tue, 31 Jan 2023 22:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5170FC433A0;
        Tue, 31 Jan 2023 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675203449;
        bh=QeeSjHFFviAdqSXwR8qgEE04ILGmTX9d2u0+rUBGGfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EMvjDpuwGsse6CjAWdx95eLhVhyqOmy3NGY6VaRrPM/v/x8FUdelAx0Ym+Iu4CCk9
         XVT8SSVTaujB2jVjdnzEtmg9/DezLBbtvfFEamzabWcKu4n0VR2c0oYv0nrQZ/9Y/D
         N1qJqPyE1ClBStFMeJpK2VVHJUbRzwnHlh6DP4+2o2lhtvl8gY6R57neNjSSpGA+kS
         N9XUFglBzHgv1H8l+gilMzKauMsCUjx8s/t+lokRFeHi9w1+iK8nbaJRHGI2T4v0IK
         oPBwO75mt/aZZpiOQ06Rhmph6dirsFzbf+RH60mNCDzBEfVcEdQ4laPaQqI6yqry0+
         HVEJFPnhrr2zw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: [PATCH 2/2] cpuset: Call set_cpus_allowed_ptr() with appropriate mask for task
Date:   Tue, 31 Jan 2023 22:17:19 +0000
Message-Id: <20230131221719.3176-3-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230131221719.3176-1-will@kernel.org>
References: <20230131221719.3176-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

set_cpus_allowed_ptr() will fail with -EINVAL if the requested
affinity mask is not a subset of the task_cpu_possible_mask() for the
task being updated. Consequently, on a heterogeneous system with cpusets
spanning the different CPU types, updates to the cgroup hierarchy can
silently fail to update task affinities when the effective affinity
mask for the cpuset is expanded.

For example, consider an arm64 system with 4 CPUs, where CPUs 2-3 are
the only cores capable of executing 32-bit tasks. Attaching a 32-bit
task to a cpuset containing CPUs 0-2 will correctly affine the task to
CPU 2. Extending the cpuset to CPUs 0-3, however, will fail to extend
the affinity mask of the 32-bit task because update_tasks_cpumask() will
pass the full 0-3 mask to set_cpus_allowed_ptr().

Extend update_tasks_cpumask() to take a temporary 'cpumask' paramater
and use it to mask the 'effective_cpus' mask with the possible mask for
each task being updated.

Fixes: 431c69fac05b ("cpuset: Honour task_cpu_possible_mask() in guarantee_online_cpus()")
Signed-off-by: Will Deacon <will@kernel.org>
---

Note: We wondered whether it was worth calling guarantee_online_cpus()
if the cpumask_and() returns 0 in update_tasks_cpumask(), but given that
this path is only called when the effective mask changes, it didn't
seem appropriate. Ultimately, if you have 32-bit tasks attached to a
cpuset containing only 64-bit cpus, then the affinity is going to be
forced.

 kernel/cgroup/cpuset.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8552cc2c586a..f15fb0426707 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1205,12 +1205,13 @@ void rebuild_sched_domains(void)
 /**
  * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
+ * @new_cpus: the temp variable for the new effective_cpus mask
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
  * effective cpuset's.  As this function is called with cpuset_rwsem held,
  * cpuset membership stays stable.
  */
-static void update_tasks_cpumask(struct cpuset *cs)
+static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -1224,7 +1225,10 @@ static void update_tasks_cpumask(struct cpuset *cs)
 		if (top_cs && (task->flags & PF_KTHREAD) &&
 		    kthread_is_per_cpu(task))
 			continue;
-		set_cpus_allowed_ptr(task, cs->effective_cpus);
+
+		cpumask_and(new_cpus, cs->effective_cpus,
+			    task_cpu_possible_mask(task));
+		set_cpus_allowed_ptr(task, new_cpus);
 	}
 	css_task_iter_end(&it);
 }
@@ -1509,7 +1513,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	spin_unlock_irq(&callback_lock);
 
 	if (adding || deleting)
-		update_tasks_cpumask(parent);
+		update_tasks_cpumask(parent, tmp->new_cpus);
 
 	/*
 	 * Set or clear CS_SCHED_LOAD_BALANCE when partcmd_update, if necessary.
@@ -1661,7 +1665,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		update_tasks_cpumask(cp);
+		update_tasks_cpumask(cp, tmp->new_cpus);
 
 		/*
 		 * On legacy hierarchy, if the effective cpumask of any non-
@@ -2309,7 +2313,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		}
 	}
 
-	update_tasks_cpumask(parent);
+	update_tasks_cpumask(parent, tmpmask.new_cpus);
 
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
@@ -3347,7 +3351,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	 * as the tasks will be migrated to an ancestor.
 	 */
 	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
-		update_tasks_cpumask(cs);
+		update_tasks_cpumask(cs, new_cpus);
 	if (mems_updated && !nodes_empty(cs->mems_allowed))
 		update_tasks_nodemask(cs);
 
@@ -3384,7 +3388,7 @@ hotplug_update_tasks(struct cpuset *cs,
 	spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
-		update_tasks_cpumask(cs);
+		update_tasks_cpumask(cs, new_cpus);
 	if (mems_updated)
 		update_tasks_nodemask(cs);
 }
-- 
2.39.1.456.gfc5497dd1b-goog

