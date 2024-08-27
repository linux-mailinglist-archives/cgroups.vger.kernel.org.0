Return-Path: <cgroups+bounces-4492-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB99601AA
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 08:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57F31F22DD0
	for <lists+cgroups@lfdr.de>; Tue, 27 Aug 2024 06:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B10153835;
	Tue, 27 Aug 2024 06:29:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2FB148302;
	Tue, 27 Aug 2024 06:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724740143; cv=none; b=Kq2XWqh+djULmTh86k/J1v9MRCjzh9ygMKSbvWp+7nkPq+NZ5JbsTQT2ze7woMQ/VBIBEc0D3vqZRFENOLYJ+LYln9UikHUeO9IGVqMGEtf2X0nDLtwiv6Xp2ZP0/Ds27XhbfVlcSapkf2WfBS/RagP9OIHt+QN313zoVhFgZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724740143; c=relaxed/simple;
	bh=ZLv1r7Ko4oryC4beQPJA/3rM14P+MXREEu4MrhZ6M+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SA17tgg6OWRWXH064Xb7aHrUluHCzeMZ5MwiaD+Q5QIqPjuyhss3JLnsfrMd1puv/KjuHlyeDdWxpStIvxB1NNcG8COpH5mY5Yu/LvXIpAZuDPFEcSZlJqxZU/+tVfvXQV3KN4YAlVCidZh0/pKwFSnLZaobbAcnxkmRfCNIWP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WtHgN5XQsz1j7H4;
	Tue, 27 Aug 2024 14:28:48 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 59DD7140154;
	Tue, 27 Aug 2024 14:28:58 +0800 (CST)
Received: from huawei.com (10.67.174.121) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 27 Aug
 2024 14:28:57 +0800
From: Chen Ridong <chenridong@huawei.com>
To: <tj@kernel.org>, <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
	<longman@redhat.com>, <adityakali@google.com>, <sergeh@kernel.org>,
	<mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 -next 02/12] cgroup/cpuset: move common code to cpuset-internal.h
Date: Tue, 27 Aug 2024 06:21:01 +0000
Message-ID: <20240827062111.580296-3-chenridong@huawei.com>
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

Move some declarations that will be used for cpuset v1 and v2,
including 'cpuset struct', 'cpuset_flagbits_t', cpuset_filetype_t,etc.
No logical change.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h | 235 +++++++++++++++++++++++++++++++
 kernel/cgroup/cpuset.c          | 236 +-------------------------------
 2 files changed, 236 insertions(+), 235 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index 034de3cbf3ad..ffea3eefebdf 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -3,4 +3,239 @@
 #ifndef __CPUSET_INTERNAL_H
 #define __CPUSET_INTERNAL_H
 
+#include <linux/union_find.h>
+#include <linux/cpumask.h>
+#include <linux/spinlock.h>
+#include <linux/cpuset.h>
+#include <linux/cgroup.h>
+
+/* See "Frequency meter" comments, below. */
+
+struct fmeter {
+	int cnt;		/* unprocessed events count */
+	int val;		/* most recent output value */
+	time64_t time;		/* clock (secs) when val computed */
+	spinlock_t lock;	/* guards read or write of above */
+};
+
+/*
+ * Invalid partition error code
+ */
+enum prs_errcode {
+	PERR_NONE = 0,
+	PERR_INVCPUS,
+	PERR_INVPARENT,
+	PERR_NOTPART,
+	PERR_NOTEXCL,
+	PERR_NOCPUS,
+	PERR_HOTPLUG,
+	PERR_CPUSEMPTY,
+	PERR_HKEEPING,
+	PERR_ACCESS,
+};
+
+/* bits in struct cpuset flags field */
+typedef enum {
+	CS_ONLINE,
+	CS_CPU_EXCLUSIVE,
+	CS_MEM_EXCLUSIVE,
+	CS_MEM_HARDWALL,
+	CS_MEMORY_MIGRATE,
+	CS_SCHED_LOAD_BALANCE,
+	CS_SPREAD_PAGE,
+	CS_SPREAD_SLAB,
+} cpuset_flagbits_t;
+
+/* The various types of files and directories in a cpuset file system */
+
+typedef enum {
+	FILE_MEMORY_MIGRATE,
+	FILE_CPULIST,
+	FILE_MEMLIST,
+	FILE_EFFECTIVE_CPULIST,
+	FILE_EFFECTIVE_MEMLIST,
+	FILE_SUBPARTS_CPULIST,
+	FILE_EXCLUSIVE_CPULIST,
+	FILE_EFFECTIVE_XCPULIST,
+	FILE_ISOLATED_CPULIST,
+	FILE_CPU_EXCLUSIVE,
+	FILE_MEM_EXCLUSIVE,
+	FILE_MEM_HARDWALL,
+	FILE_SCHED_LOAD_BALANCE,
+	FILE_PARTITION_ROOT,
+	FILE_SCHED_RELAX_DOMAIN_LEVEL,
+	FILE_MEMORY_PRESSURE_ENABLED,
+	FILE_MEMORY_PRESSURE,
+	FILE_SPREAD_PAGE,
+	FILE_SPREAD_SLAB,
+} cpuset_filetype_t;
+
+struct cpuset {
+	struct cgroup_subsys_state css;
+
+	unsigned long flags;		/* "unsigned long" so bitops work */
+
+	/*
+	 * On default hierarchy:
+	 *
+	 * The user-configured masks can only be changed by writing to
+	 * cpuset.cpus and cpuset.mems, and won't be limited by the
+	 * parent masks.
+	 *
+	 * The effective masks is the real masks that apply to the tasks
+	 * in the cpuset. They may be changed if the configured masks are
+	 * changed or hotplug happens.
+	 *
+	 * effective_mask == configured_mask & parent's effective_mask,
+	 * and if it ends up empty, it will inherit the parent's mask.
+	 *
+	 *
+	 * On legacy hierarchy:
+	 *
+	 * The user-configured masks are always the same with effective masks.
+	 */
+
+	/* user-configured CPUs and Memory Nodes allow to tasks */
+	cpumask_var_t cpus_allowed;
+	nodemask_t mems_allowed;
+
+	/* effective CPUs and Memory Nodes allow to tasks */
+	cpumask_var_t effective_cpus;
+	nodemask_t effective_mems;
+
+	/*
+	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
+	 *
+	 * The effective_cpus of a valid partition root comes solely from its
+	 * effective_xcpus and some of the effective_xcpus may be distributed
+	 * to sub-partitions below & hence excluded from its effective_cpus.
+	 * For a valid partition root, its effective_cpus have no relationship
+	 * with cpus_allowed unless its exclusive_cpus isn't set.
+	 *
+	 * This value will only be set if either exclusive_cpus is set or
+	 * when this cpuset becomes a local partition root.
+	 */
+	cpumask_var_t effective_xcpus;
+
+	/*
+	 * Exclusive CPUs as requested by the user (default hierarchy only)
+	 *
+	 * Its value is independent of cpus_allowed and designates the set of
+	 * CPUs that can be granted to the current cpuset or its children when
+	 * it becomes a valid partition root. The effective set of exclusive
+	 * CPUs granted (effective_xcpus) depends on whether those exclusive
+	 * CPUs are passed down by its ancestors and not yet taken up by
+	 * another sibling partition root along the way.
+	 *
+	 * If its value isn't set, it defaults to cpus_allowed.
+	 */
+	cpumask_var_t exclusive_cpus;
+
+	/*
+	 * This is old Memory Nodes tasks took on.
+	 *
+	 * - top_cpuset.old_mems_allowed is initialized to mems_allowed.
+	 * - A new cpuset's old_mems_allowed is initialized when some
+	 *   task is moved into it.
+	 * - old_mems_allowed is used in cpuset_migrate_mm() when we change
+	 *   cpuset.mems_allowed and have tasks' nodemask updated, and
+	 *   then old_mems_allowed is updated to mems_allowed.
+	 */
+	nodemask_t old_mems_allowed;
+
+	struct fmeter fmeter;		/* memory_pressure filter */
+
+	/*
+	 * Tasks are being attached to this cpuset.  Used to prevent
+	 * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
+	 */
+	int attach_in_progress;
+
+	/* for custom sched domain */
+	int relax_domain_level;
+
+	/* number of valid local child partitions */
+	int nr_subparts;
+
+	/* partition root state */
+	int partition_root_state;
+
+	/*
+	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
+	 * know when to rebuild associated root domain bandwidth information.
+	 */
+	int nr_deadline_tasks;
+	int nr_migrate_dl_tasks;
+	u64 sum_migrate_dl_bw;
+
+	/* Invalid partition error code, not lock protected */
+	enum prs_errcode prs_err;
+
+	/* Handle for cpuset.cpus.partition */
+	struct cgroup_file partition_file;
+
+	/* Remote partition silbling list anchored at remote_children */
+	struct list_head remote_sibling;
+
+	/* Used to merge intersecting subsets for generate_sched_domains */
+	struct uf_node node;
+};
+
+static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
+{
+	return css ? container_of(css, struct cpuset, css) : NULL;
+}
+
+/* Retrieve the cpuset for a task */
+static inline struct cpuset *task_cs(struct task_struct *task)
+{
+	return css_cs(task_css(task, cpuset_cgrp_id));
+}
+
+static inline struct cpuset *parent_cs(struct cpuset *cs)
+{
+	return css_cs(cs->css.parent);
+}
+
+/* convenient tests for these bits */
+static inline bool is_cpuset_online(struct cpuset *cs)
+{
+	return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
+}
+
+static inline int is_cpu_exclusive(const struct cpuset *cs)
+{
+	return test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
+}
+
+static inline int is_mem_exclusive(const struct cpuset *cs)
+{
+	return test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
+}
+
+static inline int is_mem_hardwall(const struct cpuset *cs)
+{
+	return test_bit(CS_MEM_HARDWALL, &cs->flags);
+}
+
+static inline int is_sched_load_balance(const struct cpuset *cs)
+{
+	return test_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
+}
+
+static inline int is_memory_migrate(const struct cpuset *cs)
+{
+	return test_bit(CS_MEMORY_MIGRATE, &cs->flags);
+}
+
+static inline int is_spread_page(const struct cpuset *cs)
+{
+	return test_bit(CS_SPREAD_PAGE, &cs->flags);
+}
+
+static inline int is_spread_slab(const struct cpuset *cs)
+{
+	return test_bit(CS_SPREAD_SLAB, &cs->flags);
+}
+
 #endif /* __CPUSET_INTERNAL_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 7db55eed63cf..61763dd70de5 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -22,11 +22,9 @@
  *  distribution for more details.
  */
 #include "cgroup-internal.h"
+#include "cpuset-internal.h"
 
 #include <linux/cpu.h>
-#include <linux/cpumask.h>
-#include <linux/cpuset.h>
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -40,13 +38,10 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
 #include <linux/security.h>
-#include <linux/spinlock.h>
 #include <linux/oom.h>
 #include <linux/sched/isolation.h>
-#include <linux/cgroup.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
-#include <linux/union_find.h>
 
 DEFINE_STATIC_KEY_FALSE(cpusets_pre_enable_key);
 DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
@@ -58,31 +53,6 @@ DEFINE_STATIC_KEY_FALSE(cpusets_enabled_key);
  */
 DEFINE_STATIC_KEY_FALSE(cpusets_insane_config_key);
 
-/* See "Frequency meter" comments, below. */
-
-struct fmeter {
-	int cnt;		/* unprocessed events count */
-	int val;		/* most recent output value */
-	time64_t time;		/* clock (secs) when val computed */
-	spinlock_t lock;	/* guards read or write of above */
-};
-
-/*
- * Invalid partition error code
- */
-enum prs_errcode {
-	PERR_NONE = 0,
-	PERR_INVCPUS,
-	PERR_INVPARENT,
-	PERR_NOTPART,
-	PERR_NOTEXCL,
-	PERR_NOCPUS,
-	PERR_HOTPLUG,
-	PERR_CPUSEMPTY,
-	PERR_HKEEPING,
-	PERR_ACCESS,
-};
-
 static const char * const perr_strings[] = {
 	[PERR_INVCPUS]   = "Invalid cpu list in cpuset.cpus.exclusive",
 	[PERR_INVPARENT] = "Parent is an invalid partition root",
@@ -95,117 +65,6 @@ static const char * const perr_strings[] = {
 	[PERR_ACCESS]    = "Enable partition not permitted",
 };
 
-struct cpuset {
-	struct cgroup_subsys_state css;
-
-	unsigned long flags;		/* "unsigned long" so bitops work */
-
-	/*
-	 * On default hierarchy:
-	 *
-	 * The user-configured masks can only be changed by writing to
-	 * cpuset.cpus and cpuset.mems, and won't be limited by the
-	 * parent masks.
-	 *
-	 * The effective masks is the real masks that apply to the tasks
-	 * in the cpuset. They may be changed if the configured masks are
-	 * changed or hotplug happens.
-	 *
-	 * effective_mask == configured_mask & parent's effective_mask,
-	 * and if it ends up empty, it will inherit the parent's mask.
-	 *
-	 *
-	 * On legacy hierarchy:
-	 *
-	 * The user-configured masks are always the same with effective masks.
-	 */
-
-	/* user-configured CPUs and Memory Nodes allow to tasks */
-	cpumask_var_t cpus_allowed;
-	nodemask_t mems_allowed;
-
-	/* effective CPUs and Memory Nodes allow to tasks */
-	cpumask_var_t effective_cpus;
-	nodemask_t effective_mems;
-
-	/*
-	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
-	 *
-	 * The effective_cpus of a valid partition root comes solely from its
-	 * effective_xcpus and some of the effective_xcpus may be distributed
-	 * to sub-partitions below & hence excluded from its effective_cpus.
-	 * For a valid partition root, its effective_cpus have no relationship
-	 * with cpus_allowed unless its exclusive_cpus isn't set.
-	 *
-	 * This value will only be set if either exclusive_cpus is set or
-	 * when this cpuset becomes a local partition root.
-	 */
-	cpumask_var_t effective_xcpus;
-
-	/*
-	 * Exclusive CPUs as requested by the user (default hierarchy only)
-	 *
-	 * Its value is independent of cpus_allowed and designates the set of
-	 * CPUs that can be granted to the current cpuset or its children when
-	 * it becomes a valid partition root. The effective set of exclusive
-	 * CPUs granted (effective_xcpus) depends on whether those exclusive
-	 * CPUs are passed down by its ancestors and not yet taken up by
-	 * another sibling partition root along the way.
-	 *
-	 * If its value isn't set, it defaults to cpus_allowed.
-	 */
-	cpumask_var_t exclusive_cpus;
-
-	/*
-	 * This is old Memory Nodes tasks took on.
-	 *
-	 * - top_cpuset.old_mems_allowed is initialized to mems_allowed.
-	 * - A new cpuset's old_mems_allowed is initialized when some
-	 *   task is moved into it.
-	 * - old_mems_allowed is used in cpuset_migrate_mm() when we change
-	 *   cpuset.mems_allowed and have tasks' nodemask updated, and
-	 *   then old_mems_allowed is updated to mems_allowed.
-	 */
-	nodemask_t old_mems_allowed;
-
-	struct fmeter fmeter;		/* memory_pressure filter */
-
-	/*
-	 * Tasks are being attached to this cpuset.  Used to prevent
-	 * zeroing cpus/mems_allowed between ->can_attach() and ->attach().
-	 */
-	int attach_in_progress;
-
-	/* for custom sched domain */
-	int relax_domain_level;
-
-	/* number of valid local child partitions */
-	int nr_subparts;
-
-	/* partition root state */
-	int partition_root_state;
-
-	/*
-	 * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
-	 * know when to rebuild associated root domain bandwidth information.
-	 */
-	int nr_deadline_tasks;
-	int nr_migrate_dl_tasks;
-	u64 sum_migrate_dl_bw;
-
-	/* Invalid partition error code, not lock protected */
-	enum prs_errcode prs_err;
-
-	/* Handle for cpuset.cpus.partition */
-	struct cgroup_file partition_file;
-
-	/* Remote partition silbling list anchored at remote_children */
-	struct list_head remote_sibling;
-
-	/* Used to merge intersecting subsets for generate_sched_domains */
-	struct uf_node node;
-};
-
 /*
  * Legacy hierarchy call to cgroup_transfer_tasks() is handled asynchrously
  */
@@ -274,22 +133,6 @@ struct tmpmasks {
 	cpumask_var_t new_cpus;		/* For update_cpumasks_hier() */
 };
 
-static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
-{
-	return css ? container_of(css, struct cpuset, css) : NULL;
-}
-
-/* Retrieve the cpuset for a task */
-static inline struct cpuset *task_cs(struct task_struct *task)
-{
-	return css_cs(task_css(task, cpuset_cgrp_id));
-}
-
-static inline struct cpuset *parent_cs(struct cpuset *cs)
-{
-	return css_cs(cs->css.parent);
-}
-
 void inc_dl_tasks_cs(struct task_struct *p)
 {
 	struct cpuset *cs = task_cs(p);
@@ -304,59 +147,6 @@ void dec_dl_tasks_cs(struct task_struct *p)
 	cs->nr_deadline_tasks--;
 }
 
-/* bits in struct cpuset flags field */
-typedef enum {
-	CS_ONLINE,
-	CS_CPU_EXCLUSIVE,
-	CS_MEM_EXCLUSIVE,
-	CS_MEM_HARDWALL,
-	CS_MEMORY_MIGRATE,
-	CS_SCHED_LOAD_BALANCE,
-	CS_SPREAD_PAGE,
-	CS_SPREAD_SLAB,
-} cpuset_flagbits_t;
-
-/* convenient tests for these bits */
-static inline bool is_cpuset_online(struct cpuset *cs)
-{
-	return test_bit(CS_ONLINE, &cs->flags) && !css_is_dying(&cs->css);
-}
-
-static inline int is_cpu_exclusive(const struct cpuset *cs)
-{
-	return test_bit(CS_CPU_EXCLUSIVE, &cs->flags);
-}
-
-static inline int is_mem_exclusive(const struct cpuset *cs)
-{
-	return test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
-}
-
-static inline int is_mem_hardwall(const struct cpuset *cs)
-{
-	return test_bit(CS_MEM_HARDWALL, &cs->flags);
-}
-
-static inline int is_sched_load_balance(const struct cpuset *cs)
-{
-	return test_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
-}
-
-static inline int is_memory_migrate(const struct cpuset *cs)
-{
-	return test_bit(CS_MEMORY_MIGRATE, &cs->flags);
-}
-
-static inline int is_spread_page(const struct cpuset *cs)
-{
-	return test_bit(CS_SPREAD_PAGE, &cs->flags);
-}
-
-static inline int is_spread_slab(const struct cpuset *cs)
-{
-	return test_bit(CS_SPREAD_SLAB, &cs->flags);
-}
-
 static inline int is_partition_valid(const struct cpuset *cs)
 {
 	return cs->partition_root_state > 0;
@@ -3529,30 +3319,6 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	mutex_unlock(&cpuset_mutex);
 }
 
-/* The various types of files and directories in a cpuset file system */
-
-typedef enum {
-	FILE_MEMORY_MIGRATE,
-	FILE_CPULIST,
-	FILE_MEMLIST,
-	FILE_EFFECTIVE_CPULIST,
-	FILE_EFFECTIVE_MEMLIST,
-	FILE_SUBPARTS_CPULIST,
-	FILE_EXCLUSIVE_CPULIST,
-	FILE_EFFECTIVE_XCPULIST,
-	FILE_ISOLATED_CPULIST,
-	FILE_CPU_EXCLUSIVE,
-	FILE_MEM_EXCLUSIVE,
-	FILE_MEM_HARDWALL,
-	FILE_SCHED_LOAD_BALANCE,
-	FILE_PARTITION_ROOT,
-	FILE_SCHED_RELAX_DOMAIN_LEVEL,
-	FILE_MEMORY_PRESSURE_ENABLED,
-	FILE_MEMORY_PRESSURE,
-	FILE_SPREAD_PAGE,
-	FILE_SPREAD_SLAB,
-} cpuset_filetype_t;
-
 static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 			    u64 val)
 {
-- 
2.34.1


