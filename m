Return-Path: <cgroups+bounces-4618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E56965E18
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 12:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5549B2275C
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 10:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C6F18F2D6;
	Fri, 30 Aug 2024 10:10:29 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247417E000;
	Fri, 30 Aug 2024 10:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012629; cv=none; b=XZgVWV30nGmGMoZX6Ul5vsPMpbicKd7jEyKPcCV3RXYviJRbkD+o06lrK50bnXaxxqu9BDtPvqMx3iDjY4yJAoelv27pZIC/lwV8E9IF9wUUC5DbgOGcwwdhr5iOulSQQyEuBhD3VpSjdBrUBHhGVAaFjodCLTU/llHVhdYPVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012629; c=relaxed/simple;
	bh=umItzVMD4zL3nIxdmAhYoqt9ArRx9yeqlD634Gm3tEY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dHmiid/L9ziziPPPXDzpWwkl5ySwLIBm4HouWTXbbv7O5eZvQ/MZrrNAkoqdX10xVihhqLD0MM9tRr6d78XPPrAt158HH2i/DEhqDMxufIEmIgOQHyYwoESOJbxrKo4Q4EgwNpT63jv1xUt7EoJMONFmfAU7n2+hqcip0Hehks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WwDPP2vCcz1xwfP;
	Fri, 30 Aug 2024 18:08:25 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id E0884140360;
	Fri, 30 Aug 2024 18:10:23 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Fri, 30 Aug
 2024 18:10:23 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<chenridong@huaweicloud.com>
Subject: [PATCH v4 -next 10/12] cgroup/cpuset: rename functions shared between v1 and v2
Date: Fri, 30 Aug 2024 10:02:27 +0000
Message-ID: <20240830100229.953012-11-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830100229.953012-1-chenridong@huawei.com>
References: <20240830100229.953012-1-chenridong@huawei.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)

Some functions name declared in cpuset-internel.h are generic. To avoid
confilicting with other variables for the same name, rename these
functions with cpuset_/cpuset1_ prefix to make them unique to cpuset.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h | 20 ++++++-------
 kernel/cgroup/cpuset-v1.c       | 40 ++++++++++++-------------
 kernel/cgroup/cpuset.c          | 52 ++++++++++++++++-----------------
 3 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index a6c71c86e58d..f36419d688bd 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -267,11 +267,11 @@ static inline int is_spread_slab(const struct cpuset *cs)
 		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
 
 void rebuild_sched_domains_locked(void);
-void callback_lock_irq(void);
-void callback_unlock_irq(void);
-void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus);
-void update_tasks_nodemask(struct cpuset *cs);
-int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on);
+void cpuset_callback_lock_irq(void);
+void cpuset_callback_unlock_irq(void);
+void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus);
+void cpuset_update_tasks_nodemask(struct cpuset *cs);
+int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on);
 ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off);
 int cpuset_common_seq_show(struct seq_file *sf, void *v);
@@ -279,14 +279,14 @@ int cpuset_common_seq_show(struct seq_file *sf, void *v);
 /*
  * cpuset-v1.c
  */
-extern struct cftype legacy_files[];
+extern struct cftype cpuset1_files[];
 void fmeter_init(struct fmeter *fmp);
-void cpuset_update_task_spread_flags(struct cpuset *cs,
+void cpuset1_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk);
-void update_tasks_flags(struct cpuset *cs);
-void hotplug_update_tasks_legacy(struct cpuset *cs,
+void cpuset1_update_tasks_flags(struct cpuset *cs);
+void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated);
-int validate_change_legacy(struct cpuset *cur, struct cpuset *trial);
+int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 0ccc440c468a..25c1d7b77e2f 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -209,7 +209,7 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
  * Call with callback_lock or cpuset_mutex held. The check can be skipped
  * if on default hierarchy.
  */
-void cpuset_update_task_spread_flags(struct cpuset *cs,
+void cpuset1_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk)
 {
 	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
@@ -227,21 +227,21 @@ void cpuset_update_task_spread_flags(struct cpuset *cs,
 }
 
 /**
- * update_tasks_flags - update the spread flags of tasks in the cpuset.
+ * cpuset1_update_tasks_flags - update the spread flags of tasks in the cpuset.
  * @cs: the cpuset in which each task's spread flags needs to be changed
  *
  * Iterate through each task of @cs updating its spread flags.  As this
  * function is called with cpuset_mutex held, cpuset membership stays
  * stable.
  */
-void update_tasks_flags(struct cpuset *cs)
+void cpuset1_update_tasks_flags(struct cpuset *cs)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
 
 	css_task_iter_start(&cs->css, 0, &it);
 	while ((task = css_task_iter_next(&it)))
-		cpuset_update_task_spread_flags(cs, task);
+		cpuset1_update_task_spread_flags(cs, task);
 	css_task_iter_end(&it);
 }
 
@@ -282,27 +282,27 @@ static void cpuset_migrate_tasks_workfn(struct work_struct *work)
 	kfree(s);
 }
 
-void hotplug_update_tasks_legacy(struct cpuset *cs,
+void cpuset1_hotplug_update_tasks(struct cpuset *cs,
 			    struct cpumask *new_cpus, nodemask_t *new_mems,
 			    bool cpus_updated, bool mems_updated)
 {
 	bool is_empty;
 
-	callback_lock_irq();
+	cpuset_callback_lock_irq();
 	cpumask_copy(cs->cpus_allowed, new_cpus);
 	cpumask_copy(cs->effective_cpus, new_cpus);
 	cs->mems_allowed = *new_mems;
 	cs->effective_mems = *new_mems;
-	callback_unlock_irq();
+	cpuset_callback_unlock_irq();
 
 	/*
-	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
+	 * Don't call cpuset_update_tasks_cpumask() if the cpuset becomes empty,
 	 * as the tasks will be migrated to an ancestor.
 	 */
 	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
-		update_tasks_cpumask(cs, new_cpus);
+		cpuset_update_tasks_cpumask(cs, new_cpus);
 	if (mems_updated && !nodes_empty(cs->mems_allowed))
-		update_tasks_nodemask(cs);
+		cpuset_update_tasks_nodemask(cs);
 
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
@@ -345,10 +345,10 @@ static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
 }
 
 /*
- * validate_change_legacy() - Validate conditions specific to legacy (v1)
+ * cpuset1_validate_change() - Validate conditions specific to legacy (v1)
  *                            behavior.
  */
-int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
+int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *c, *par;
@@ -421,28 +421,28 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 
 	switch (type) {
 	case FILE_CPU_EXCLUSIVE:
-		retval = update_flag(CS_CPU_EXCLUSIVE, cs, val);
+		retval = cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_EXCLUSIVE:
-		retval = update_flag(CS_MEM_EXCLUSIVE, cs, val);
+		retval = cpuset_update_flag(CS_MEM_EXCLUSIVE, cs, val);
 		break;
 	case FILE_MEM_HARDWALL:
-		retval = update_flag(CS_MEM_HARDWALL, cs, val);
+		retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
 		break;
 	case FILE_SCHED_LOAD_BALANCE:
-		retval = update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
+		retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
 		break;
 	case FILE_MEMORY_MIGRATE:
-		retval = update_flag(CS_MEMORY_MIGRATE, cs, val);
+		retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
 		break;
 	case FILE_MEMORY_PRESSURE_ENABLED:
 		cpuset_memory_pressure_enabled = !!val;
 		break;
 	case FILE_SPREAD_PAGE:
-		retval = update_flag(CS_SPREAD_PAGE, cs, val);
+		retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
 		break;
 	case FILE_SPREAD_SLAB:
-		retval = update_flag(CS_SPREAD_SLAB, cs, val);
+		retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
 		break;
 	default:
 		retval = -EINVAL;
@@ -458,7 +458,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
  * for the common functions, 'private' gives the type of file
  */
 
-struct cftype legacy_files[] = {
+struct cftype cpuset1_files[] = {
 	{
 		.name = "cpus",
 		.seq_show = cpuset_common_seq_show,
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2f52fe488f3a..b63c577cacd7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -233,12 +233,12 @@ void cpuset_unlock(void)
 
 static DEFINE_SPINLOCK(callback_lock);
 
-void callback_lock_irq(void)
+void cpuset_callback_lock_irq(void)
 {
 	spin_lock_irq(&callback_lock);
 }
 
-void callback_unlock_irq(void)
+void cpuset_callback_unlock_irq(void)
 {
 	spin_unlock_irq(&callback_lock);
 }
@@ -534,7 +534,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	rcu_read_lock();
 
 	if (!is_in_v2_mode())
-		ret = validate_change_legacy(cur, trial);
+		ret = cpuset1_validate_change(cur, trial);
 	if (ret)
 		goto out;
 
@@ -1047,7 +1047,7 @@ void rebuild_sched_domains(void)
 }
 
 /**
- * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
+ * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
  * @new_cpus: the temp variable for the new effective_cpus mask
  *
@@ -1057,7 +1057,7 @@ void rebuild_sched_domains(void)
  * is used instead of effective_cpus to make sure all offline CPUs are also
  * included as hotplug code won't update cpumasks for tasks in top_cpuset.
  */
-void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
+void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -1120,11 +1120,11 @@ static int update_partition_exclusive(struct cpuset *cs, int new_prs)
 	bool exclusive = (new_prs > PRS_MEMBER);
 
 	if (exclusive && !is_cpu_exclusive(cs)) {
-		if (update_flag(CS_CPU_EXCLUSIVE, cs, 1))
+		if (cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, 1))
 			return PERR_NOTEXCL;
 	} else if (!exclusive && is_cpu_exclusive(cs)) {
 		/* Turning off CS_CPU_EXCLUSIVE will not return error */
-		update_flag(CS_CPU_EXCLUSIVE, cs, 0);
+		cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 	}
 	return 0;
 }
@@ -1374,7 +1374,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
-	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
 	return 0;
 }
@@ -1410,7 +1410,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
-	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
 }
 
@@ -1462,7 +1462,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	/*
 	 * Proprogate changes in top_cpuset's effective_cpus down the hierarchy.
 	 */
-	update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
+	cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
 	update_sibling_cpumasks(&top_cpuset, NULL, tmp);
 	return;
 
@@ -1834,7 +1834,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		update_partition_exclusive(cs, new_prs);
 
 	if (adding || deleting) {
-		update_tasks_cpumask(parent, tmp->addmask);
+		cpuset_update_tasks_cpumask(parent, tmp->addmask);
 		update_sibling_cpumasks(parent, cs, tmp);
 	}
 
@@ -2017,7 +2017,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		/*
 		 * update_parent_effective_cpumask() should have been called
 		 * for cs already in update_cpumask(). We should also call
-		 * update_tasks_cpumask() again for tasks in the parent
+		 * cpuset_update_tasks_cpumask() again for tasks in the parent
 		 * cpuset if the parent's effective_cpus changes.
 		 */
 		if ((cp != cs) && old_prs) {
@@ -2074,7 +2074,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 		WARN_ON(!is_in_v2_mode() &&
 			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
 
-		update_tasks_cpumask(cp, cp->effective_cpus);
+		cpuset_update_tasks_cpumask(cp, cp->effective_cpus);
 
 		/*
 		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
@@ -2501,14 +2501,14 @@ static void cpuset_change_task_nodemask(struct task_struct *tsk,
 static void *cpuset_being_rebound;
 
 /**
- * update_tasks_nodemask - Update the nodemasks of tasks in the cpuset.
+ * cpuset_update_tasks_nodemask - Update the nodemasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
  *
  * Iterate through each task of @cs updating its mems_allowed to the
  * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
-void update_tasks_nodemask(struct cpuset *cs)
+void cpuset_update_tasks_nodemask(struct cpuset *cs)
 {
 	static nodemask_t newmems;	/* protected by cpuset_mutex */
 	struct css_task_iter it;
@@ -2606,7 +2606,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 		WARN_ON(!is_in_v2_mode() &&
 			!nodes_equal(cp->mems_allowed, cp->effective_mems));
 
-		update_tasks_nodemask(cp);
+		cpuset_update_tasks_nodemask(cp);
 
 		rcu_read_lock();
 		css_put(&cp->css);
@@ -2693,7 +2693,7 @@ bool current_cpuset_is_being_rebound(void)
 }
 
 /*
- * update_flag - read a 0 or a 1 in a file and update associated flag
+ * cpuset_update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:		the bit to update (see cpuset_flagbits_t)
  * cs:		the cpuset to update
  * turning_on: 	whether the flag is being set or cleared
@@ -2701,7 +2701,7 @@ bool current_cpuset_is_being_rebound(void)
  * Call with cpuset_mutex held.
  */
 
-int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
+int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 		       int turning_on)
 {
 	struct cpuset *trialcs;
@@ -2737,7 +2737,7 @@ int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 		rebuild_sched_domains_locked();
 
 	if (spread_flag_changed)
-		update_tasks_flags(cs);
+		cpuset1_update_tasks_flags(cs);
 out:
 	free_cpuset(trialcs);
 	return err;
@@ -3002,7 +3002,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 	WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
 
 	cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
-	cpuset_update_task_spread_flags(cs, task);
+	cpuset1_update_task_spread_flags(cs, task);
 }
 
 static void cpuset_attach(struct cgroup_taskset *tset)
@@ -3478,7 +3478,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 
 	if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
 	    is_sched_load_balance(cs))
-		update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
+		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
 
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
@@ -3617,7 +3617,7 @@ struct cgroup_subsys cpuset_cgrp_subsys = {
 	.can_fork	= cpuset_can_fork,
 	.cancel_fork	= cpuset_cancel_fork,
 	.fork		= cpuset_fork,
-	.legacy_cftypes	= legacy_files,
+	.legacy_cftypes	= cpuset1_files,
 	.dfl_cftypes	= dfl_files,
 	.early_init	= true,
 	.threaded	= true,
@@ -3670,9 +3670,9 @@ hotplug_update_tasks(struct cpuset *cs,
 	spin_unlock_irq(&callback_lock);
 
 	if (cpus_updated)
-		update_tasks_cpumask(cs, new_cpus);
+		cpuset_update_tasks_cpumask(cs, new_cpus);
 	if (mems_updated)
-		update_tasks_nodemask(cs);
+		cpuset_update_tasks_nodemask(cs);
 }
 
 void cpuset_force_rebuild(void)
@@ -3773,7 +3773,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		hotplug_update_tasks(cs, &new_cpus, &new_mems,
 				     cpus_updated, mems_updated);
 	else
-		hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
+		cpuset1_hotplug_update_tasks(cs, &new_cpus, &new_mems,
 					    cpus_updated, mems_updated);
 
 unlock:
@@ -3858,7 +3858,7 @@ static void cpuset_handle_hotplug(void)
 			top_cpuset.mems_allowed = new_mems;
 		top_cpuset.effective_mems = new_mems;
 		spin_unlock_irq(&callback_lock);
-		update_tasks_nodemask(&top_cpuset);
+		cpuset_update_tasks_nodemask(&top_cpuset);
 	}
 
 	mutex_unlock(&cpuset_mutex);
-- 
2.34.1


