Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9B061614A
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 11:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKBKzm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiKBKzl (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 06:55:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CA623BE3
        for <cgroups@vger.kernel.org>; Wed,  2 Nov 2022 03:55:40 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667386538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxN3Bnq0k5Pod8u7djmWflIgrS64nBxyhsK0MaMhRwM=;
        b=qQrB6LIoJ3XgCdHOkAVVGYfJzoVEaIO9WwH/FtIZr7JQABhwYfDMhXd797hbn8/ZqeaR6F
        Jl5CmfYri7ywJNeM4kaycooIn9SqMQFRDoczLi9ZPNvpgurnESHK4j9gbeqi9j7HItdgbV
        gry0JdFuN4v6FSxfExiW7XJA+rBv7jDjX3Y/fHtErBot99N9ucTqBWVI74/X6CbyydyGN9
        lqhcd2sNocIYpWKoqKtlNOhh0H32zClaI9sSUnxPjN0X0fgRWYzG3TE4QmP3uk9IsvXLIl
        Y5Ln2LN9ninOIuMqmCP2GSspOi/HKdarbP+NNHpMP5H6IynOfHRa9txdcv+ssA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667386538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxN3Bnq0k5Pod8u7djmWflIgrS64nBxyhsK0MaMhRwM=;
        b=sUB2CdA80dwytTTsGWw9PM+irgR++Qri/lxMIuu5VO8rOxUpCEbviAhWcm7dKH2jP2MuYV
        JrvFVHS1jTYhohBA==
To:     cgroups@vger.kernel.org
Cc:     Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 2/2] cpuset: Don't change the cpumask if the task changed it.
Date:   Wed,  2 Nov 2022 11:55:30 +0100
Message-Id: <20221102105530.1795429-3-bigeasy@linutronix.de>
In-Reply-To: <20221102105530.1795429-1-bigeasy@linutronix.de>
References: <20221102105530.1795429-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Upon changing the allowed CPUs of cgroup, all task within this cgroup
will get their CPU-mask updated to the new mask. Tasks that changed
their CPU-mask will get their mask changed without knowing. If task
restricted itself to subset of CPUs, there is no reason to change its
mask after a new CPU has been added or a CPU has been removed which was
not used by the task.

Skip CPU-mask updates if task's CPU-mask differs from the previous
CPU-mask of the cgroup (it was changed) and if this CPU-mask is a subset
of the requested new CPU mask.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/cgroup/cpuset.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8d5126684f9e6..6d0d07148cfaa 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1206,7 +1206,7 @@ void rebuild_sched_domains(void)
  * effective cpuset's.  As this function is called with cpuset_rwsem held,
  * cpuset membership stays stable.
  */
-static void update_tasks_cpumask(struct cpuset *cs)
+static void update_tasks_cpumask(struct cpuset *cs, cpumask_var_t prev_mas=
k)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -1220,7 +1220,13 @@ static void update_tasks_cpumask(struct cpuset *cs)
 		if (top_cs && (task->flags & PF_KTHREAD) &&
 		    kthread_is_per_cpu(task))
 			continue;
-		set_cpus_allowed_ptr(task, cs->effective_cpus);
+		/*
+		 * Update if task's CPU-mask equals previous CPUset or if task's
+		 * CPU-mask has CPUs which are not part of the new CPUset
+		 */
+		if (!prev_mask || (cpumask_equal(&task->cpus_mask, prev_mask) ||
+				   !cpumask_subset(&task->cpus_mask, cs->effective_cpus)))
+			set_cpus_allowed_ptr(task, cs->effective_cpus);
 	}
 	css_task_iter_end(&it);
 }
@@ -1505,7 +1511,7 @@ static int update_parent_subparts_cpumask(struct cpus=
et *cs, int cmd,
 	spin_unlock_irq(&callback_lock);
=20
 	if (adding || deleting)
-		update_tasks_cpumask(parent);
+		update_tasks_cpumask(parent, NULL);
=20
 	/*
 	 * Set or clear CS_SCHED_LOAD_BALANCE when partcmd_update, if necessary.
@@ -1639,6 +1645,7 @@ static void update_cpumasks_hier(struct cpuset *cs, s=
truct tmpmasks *tmp,
 			cpumask_clear(cp->subparts_cpus);
 		}
=20
+		cpumask_copy(tmp->addmask, cp->effective_cpus);
 		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
 		if (cp->nr_subparts_cpus) {
 			/*
@@ -1657,7 +1664,7 @@ static void update_cpumasks_hier(struct cpuset *cs, s=
truct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
=20
-		update_tasks_cpumask(cp);
+		update_tasks_cpumask(cp, tmp->addmask);
=20
 		/*
 		 * On legacy hierarchy, if the effective cpumask of any non-
@@ -2305,7 +2312,7 @@ static int update_prstate(struct cpuset *cs, int new_=
prs)
 		}
 	}
=20
-	update_tasks_cpumask(parent);
+	update_tasks_cpumask(parent, NULL);
=20
 	if (parent->child_ecpus_count)
 		update_sibling_cpumasks(parent, cs, &tmpmask);
@@ -3318,7 +3325,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	 * as the tasks will be migrated to an ancestor.
 	 */
 	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
-		update_tasks_cpumask(cs);
+		update_tasks_cpumask(cs, NULL);
 	if (mems_updated && !nodes_empty(cs->mems_allowed))
 		update_tasks_nodemask(cs);
=20
@@ -3355,7 +3362,7 @@ hotplug_update_tasks(struct cpuset *cs,
 	spin_unlock_irq(&callback_lock);
=20
 	if (cpus_updated)
-		update_tasks_cpumask(cs);
+		update_tasks_cpumask(cs, NULL);
 	if (mems_updated)
 		update_tasks_nodemask(cs);
 }
--=20
2.37.2

