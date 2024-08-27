Return-Path: <cgroups+bounces-4495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542F59601AF
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 08:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4181C22272
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 06:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE9A155725;
	Tue, 27 Aug 2024 06:29:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89614900F;
	Tue, 27 Aug 2024 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740144; cv=none; b=Qo2F8HvbNkuSHH4l3kEEBEycuDZlZ5sD4OlPn8qRG11o7A2a2vqwl9vqLfLvh8mtzGGMJQr3fMm7FBxgoxbifJSVIBCBvqOYqsbLmc8coe8+O+bvBpFwv1kQ1xebnuHrLvCUbyqwGwxfNdhF8U7remmt8zO+i9gynGJ0dYlRtCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740144; c=relaxed/simple;
	bh=fk+vMctnhYVz7j9Nmg1XLMZbdaplvM8dG+FYEpY3O0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nK0KbjqyDXX0xip7ksEE+jDc9IGhwgZijYl2Cj/qOpwo0Z23VDNYEw87zQJhG+3AHQGyxjAcgr9ObHSvPkZf7wRR7L3uD1BUsP61GfrnGXgcqXcAK3Ohl2dpKBz2Phjbntok5ooOmNuDkdXAcb3NUXX3QkAdVNQdDfhcTXdtaro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtHg32wzszyR2M;
	Tue, 27 Aug 2024 14:28:31 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BF04140137;
	Tue, 27 Aug 2024 14:29:00 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 14:28:59 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next 07/12] cgroup/cpuset: move legacy hotplug update to cpuset-v1.c
Date: Tue, 27 Aug 2024 06:21:06 +0000
Message-ID: <20240827062111.580296-8-chenridong@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827062111.580296-1-chenridong@huawei.com>
References: <20240827062111.580296-1-chenridong@huawei.com>
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

There are some differents about hotplug update between cpuset v1 and
cpuset v2. Move the legacy code to cpuset-v1.c.

'update_tasks_cpumask' and 'update_tasks_nodemask' are both used in cpuset
v1 and cpuset v2, declare them in cpuset-internal.h.

The change from original code is that use callback_lock helpers to get
callback_lock lock/unlock.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h |  5 ++
 kernel/cgroup/cpuset-v1.c       | 91 +++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 96 +--------------------------------
 3 files changed, 98 insertions(+), 94 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 9a60dd6681e4..7cd30ad809d5 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -241,6 +241,8 @@ static inline int is_spread_slab(const struct cpuset *cs)
 void rebuild_sched_domains_locked(void);
 void callback_lock_irq(void);
 void callback_unlock_irq(void);
+void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus);
+void update_tasks_nodemask(struct cpuset *cs);
 
 /*
  * cpuset-v1.c
@@ -253,5 +255,8 @@ s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft);
 void cpuset_update_task_spread_flags(struct cpuset *cs,
 					struct task_struct *tsk);
 void update_tasks_flags(struct cpuset *cs);
+void hotplug_update_tasks_legacy(struct cpuset *cs,
+			    struct cpumask *new_cpus, nodemask_t *new_mems,
+			    bool cpus_updated, bool mems_updated);
 
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index ca973b4de38a..ebc71c5d2568 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -2,6 +2,14 @@
 
 #include "cpuset-internal.h"
 
+/*
+ * Legacy hierarchy call to cgroup_transfer_tasks() is handled asynchrously
+ */
+struct cpuset_remove_tasks_struct {
+	struct work_struct work;
+	struct cpuset *cs;
+};
+
 /*
  * Frequency meter - How fast is some event occurring?
  *
@@ -236,3 +244,86 @@ void update_tasks_flags(struct cpuset *cs)
 		cpuset_update_task_spread_flags(cs, task);
 	css_task_iter_end(&it);
 }
+
+/*
+ * If CPU and/or memory hotplug handlers, below, unplug any CPUs
+ * or memory nodes, we need to walk over the cpuset hierarchy,
+ * removing that CPU or node from all cpusets.  If this removes the
+ * last CPU or node from a cpuset, then move the tasks in the empty
+ * cpuset to its next-highest non-empty parent.
+ */
+static void remove_tasks_in_empty_cpuset(struct cpuset *cs)
+{
+	struct cpuset *parent;
+
+	/*
+	 * Find its next-highest non-empty parent, (top cpuset
+	 * has online cpus, so can't be empty).
+	 */
+	parent = parent_cs(cs);
+	while (cpumask_empty(parent->cpus_allowed) ||
+			nodes_empty(parent->mems_allowed))
+		parent = parent_cs(parent);
+
+	if (cgroup_transfer_tasks(parent->css.cgroup, cs->css.cgroup)) {
+		pr_err("cpuset: failed to transfer tasks out of empty cpuset ");
+		pr_cont_cgroup_name(cs->css.cgroup);
+		pr_cont("\n");
+	}
+}
+
+static void cpuset_migrate_tasks_workfn(struct work_struct *work)
+{
+	struct cpuset_remove_tasks_struct *s;
+
+	s = container_of(work, struct cpuset_remove_tasks_struct, work);
+	remove_tasks_in_empty_cpuset(s->cs);
+	css_put(&s->cs->css);
+	kfree(s);
+}
+
+void hotplug_update_tasks_legacy(struct cpuset *cs,
+			    struct cpumask *new_cpus, nodemask_t *new_mems,
+			    bool cpus_updated, bool mems_updated)
+{
+	bool is_empty;
+
+	callback_lock_irq();
+	cpumask_copy(cs->cpus_allowed, new_cpus);
+	cpumask_copy(cs->effective_cpus, new_cpus);
+	cs->mems_allowed = *new_mems;
+	cs->effective_mems = *new_mems;
+	callback_unlock_irq();
+
+	/*
+	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
+	 * as the tasks will be migrated to an ancestor.
+	 */
+	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
+		update_tasks_cpumask(cs, new_cpus);
+	if (mems_updated && !nodes_empty(cs->mems_allowed))
+		update_tasks_nodemask(cs);
+
+	is_empty = cpumask_empty(cs->cpus_allowed) ||
+		   nodes_empty(cs->mems_allowed);
+
+	/*
+	 * Move tasks to the nearest ancestor with execution resources,
+	 * This is full cgroup operation which will also call back into
+	 * cpuset. Execute it asynchronously using workqueue.
+	 */
+	if (is_empty && cs->css.cgroup->nr_populated_csets &&
+	    css_tryget_online(&cs->css)) {
+		struct cpuset_remove_tasks_struct *s;
+
+		s = kzalloc(sizeof(*s), GFP_KERNEL);
+		if (WARN_ON_ONCE(!s)) {
+			css_put(&cs->css);
+			return;
+		}
+
+		s->cs = cs;
+		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
+		schedule_work(&s->work);
+	}
+}
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2b2dc963299b..b93ef0b48eae 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -65,14 +65,6 @@ static const char * const perr_strings[] = {
 	[PERR_ACCESS]    = "Enable partition not permitted",
 };
 
-/*
- * Legacy hierarchy call to cgroup_transfer_tasks() is handled asynchrously
- */
-struct cpuset_remove_tasks_struct {
-	struct work_struct work;
-	struct cpuset *cs;
-};
-
 /*
  * Exclusive CPUs distributed out to sub-partitions of top_cpuset
  */
@@ -1138,7 +1130,7 @@ void rebuild_sched_domains(void)
  * is used instead of effective_cpus to make sure all offline CPUs are also
  * included as hotplug code won't update cpumasks for tasks in top_cpuset.
  */
-static void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
+void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 {
 	struct css_task_iter it;
 	struct task_struct *task;
@@ -2591,7 +2583,7 @@ static void *cpuset_being_rebound;
  * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
-static void update_tasks_nodemask(struct cpuset *cs)
+void update_tasks_nodemask(struct cpuset *cs)
 {
 	static nodemask_t newmems;	/* protected by cpuset_mutex */
 	struct css_task_iter it;
@@ -3923,90 +3915,6 @@ int __init cpuset_init(void)
 	return 0;
 }
 
-/*
- * If CPU and/or memory hotplug handlers, below, unplug any CPUs
- * or memory nodes, we need to walk over the cpuset hierarchy,
- * removing that CPU or node from all cpusets.  If this removes the
- * last CPU or node from a cpuset, then move the tasks in the empty
- * cpuset to its next-highest non-empty parent.
- */
-static void remove_tasks_in_empty_cpuset(struct cpuset *cs)
-{
-	struct cpuset *parent;
-
-	/*
-	 * Find its next-highest non-empty parent, (top cpuset
-	 * has online cpus, so can't be empty).
-	 */
-	parent = parent_cs(cs);
-	while (cpumask_empty(parent->cpus_allowed) ||
-			nodes_empty(parent->mems_allowed))
-		parent = parent_cs(parent);
-
-	if (cgroup_transfer_tasks(parent->css.cgroup, cs->css.cgroup)) {
-		pr_err("cpuset: failed to transfer tasks out of empty cpuset ");
-		pr_cont_cgroup_name(cs->css.cgroup);
-		pr_cont("\n");
-	}
-}
-
-static void cpuset_migrate_tasks_workfn(struct work_struct *work)
-{
-	struct cpuset_remove_tasks_struct *s;
-
-	s = container_of(work, struct cpuset_remove_tasks_struct, work);
-	remove_tasks_in_empty_cpuset(s->cs);
-	css_put(&s->cs->css);
-	kfree(s);
-}
-
-static void
-hotplug_update_tasks_legacy(struct cpuset *cs,
-			    struct cpumask *new_cpus, nodemask_t *new_mems,
-			    bool cpus_updated, bool mems_updated)
-{
-	bool is_empty;
-
-	spin_lock_irq(&callback_lock);
-	cpumask_copy(cs->cpus_allowed, new_cpus);
-	cpumask_copy(cs->effective_cpus, new_cpus);
-	cs->mems_allowed = *new_mems;
-	cs->effective_mems = *new_mems;
-	spin_unlock_irq(&callback_lock);
-
-	/*
-	 * Don't call update_tasks_cpumask() if the cpuset becomes empty,
-	 * as the tasks will be migrated to an ancestor.
-	 */
-	if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
-		update_tasks_cpumask(cs, new_cpus);
-	if (mems_updated && !nodes_empty(cs->mems_allowed))
-		update_tasks_nodemask(cs);
-
-	is_empty = cpumask_empty(cs->cpus_allowed) ||
-		   nodes_empty(cs->mems_allowed);
-
-	/*
-	 * Move tasks to the nearest ancestor with execution resources,
-	 * This is full cgroup operation which will also call back into
-	 * cpuset. Execute it asynchronously using workqueue.
-	 */
-	if (is_empty && cs->css.cgroup->nr_populated_csets &&
-	    css_tryget_online(&cs->css)) {
-		struct cpuset_remove_tasks_struct *s;
-
-		s = kzalloc(sizeof(*s), GFP_KERNEL);
-		if (WARN_ON_ONCE(!s)) {
-			css_put(&cs->css);
-			return;
-		}
-
-		s->cs = cs;
-		INIT_WORK(&s->work, cpuset_migrate_tasks_workfn);
-		schedule_work(&s->work);
-	}
-}
-
 static void
 hotplug_update_tasks(struct cpuset *cs,
 		     struct cpumask *new_cpus, nodemask_t *new_mems,
-- 
2.34.1


