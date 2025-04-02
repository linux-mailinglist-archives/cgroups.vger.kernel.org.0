Return-Path: <cgroups+bounces-7289-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92507A7860A
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 03:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52AA3ACCE5
	for <lists+cgroups@lfdr.de>; Wed,  2 Apr 2025 01:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCBEDDDC;
	Wed,  2 Apr 2025 01:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTovjPzm"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AF80B;
	Wed,  2 Apr 2025 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743556384; cv=none; b=fMOudGL8NqBzzwdkDiFvi75N3Tu2TraPjJ/O8/XckDeo165opGWnbNXz/ElTs94dxdctkTR2zFutCSZ/CAkrfAs5w6pcsmDx4fQQ/mOOtGIY5j97uq4srR1Whja0HjnH+qsKmqTpD7IK0e+VbmOXC/gKjUtbRktTn3PwxRbOvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743556384; c=relaxed/simple;
	bh=dkDDZ46+D6s06CwT6yuA2JUG7qQMBQcORO4mUIRvv0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iyuUUJjIMHESLoa3vh5GcgEVEYdCN7tX/RHwaYXC8D1oPvIi5cg8YCv8BjjATrXXxs9egJ2UUXVcq9rzvpPUZnxwXuwvCna70N5ppHsbelZS/DRO+554Zf08yPBPZzxx+pLcFXjRJ5ZSqr7A8y+HFXa3MLxDSOw+5QwArS7bbIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTovjPzm; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743556383; x=1775092383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dkDDZ46+D6s06CwT6yuA2JUG7qQMBQcORO4mUIRvv0U=;
  b=PTovjPzm9pzfeLQ5eiKgtZfbUBdIJ5prn+TpJUHQ5NIt52AbWsenjCPA
   Q1FIfM3db6XyueP5laDNZO+vhQVM7v2Ih1BBWjqzrl0UU2830FffBu/mM
   r0sH3m2LAP7DKxhu1DDju8hqw/+sSd9EHaEtd3Zl5IM4JJBQfV+L/Fze1
   3YYrA9/OURUWCN7gJZGxw7CWGLOKPi3Gvp0LMb6xSOVhMAeIZXEr+AXfi
   mPQdTfMessvrJCbvoaDHCmZjp9kPW7aYQBN/9ZXeny0C9hTLbbrKokX1f
   zA6fE+P7AXpoZUi+9WWCrBT9nWqkwnSXRALDGI7dJA5+RDkjGEbXoYs4W
   w==;
X-CSE-ConnectionGUID: GtJN5vepRruvxmTYlsQu7w==
X-CSE-MsgGUID: YNTCTUhdRRWsQYrGJb8ubw==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="45075100"
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="45075100"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 18:13:02 -0700
X-CSE-ConnectionGUID: LZY7pB2pQB+rTQoopQpl9g==
X-CSE-MsgGUID: +9HhSE1MSECtq6/USqK3Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,294,1736841600"; 
   d="scan'208";a="157529943"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa001.fm.intel.com with ESMTP; 01 Apr 2025 18:12:57 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Tim Chen <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Rik van Riel <riel@surriel.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Xunlei Pang <xlpang@linux.alibaba.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Chen Yu <yu.chen.surf@foxmail.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH] sched/numa: Add statistics of numa balance task migration and swap
Date: Wed,  2 Apr 2025 09:06:11 +0800
Message-Id: <20250402010611.3204674-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On system with NUMA balancing enabled, it is found that tracking
the task activities due to NUMA balancing is helpful. NUMA balancing
has two mechanisms for task migration: one is to migrate the task to
an idle CPU in its preferred node, the other is to swap tasks on
different nodes if they are on each other's preferred node.

The kernel already has NUMA page migration statistics in
/sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched.
but does not have statistics for task migration/swap.
Add the task migration and swap count accordingly.

The following two new fields:

numa_task_migrated
numa_task_swapped

will be displayed in both
/sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched

Previous RFC version can be found here:
https://lore.kernel.org/lkml/1847c5ef828ad4835a35e3a54b88d2e13bce0eea.1740483690.git.yu.c.chen@intel.com/

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
RFC->v1: Rename the nr_numa_task_migrated to
         numa_task_migrated, and nr_numa_task_swapped
         numa_task_swapped in /proc/{PID}/sched,
         so both cgroup's memory.stat and task's
         sched have the same field name.
---
 include/linux/sched.h         |  4 ++++
 include/linux/vm_event_item.h |  2 ++
 kernel/sched/core.c           | 10 ++++++++--
 kernel/sched/debug.c          |  4 ++++
 mm/memcontrol.c               |  2 ++
 mm/vmstat.c                   |  2 ++
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0785268c76f8..9623e5300453 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -532,6 +532,10 @@ struct sched_statistics {
 	u64				nr_failed_migrations_running;
 	u64				nr_failed_migrations_hot;
 	u64				nr_forced_migrations;
+#ifdef CONFIG_NUMA_BALANCING
+	u64				numa_task_migrated;
+	u64				numa_task_swapped;
+#endif
 
 	u64				nr_wakeups;
 	u64				nr_wakeups_sync;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f70d0958095c..aef817474781 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -64,6 +64,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
+		NUMA_TASK_MIGRATE,
+		NUMA_TASK_SWAP,
 #endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c86c05264719..314d5cbce2b6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3348,6 +3348,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 #ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
 {
+	__schedstat_inc(p->stats.numa_task_swapped);
+
+	if (p->mm)
+		count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
+
 	if (task_on_rq_queued(p)) {
 		struct rq *src_rq, *dst_rq;
 		struct rq_flags srf, drf;
@@ -7948,8 +7953,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
 		return -EINVAL;
 
-	/* TODO: This is not properly updating schedstats */
-
+	__schedstat_inc(p->stats.numa_task_migrated);
+	if (p->mm)
+		count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
 	trace_sched_move_numa(p, curr_cpu, target_cpu);
 	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 56ae54e0ce6a..f971c2af7912 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1206,6 +1206,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_failed_migrations_running);
 		P_SCHEDSTAT(nr_failed_migrations_hot);
 		P_SCHEDSTAT(nr_forced_migrations);
+#ifdef CONFIG_NUMA_BALANCING
+		P_SCHEDSTAT(numa_task_migrated);
+		P_SCHEDSTAT(numa_task_swapped);
+#endif
 		P_SCHEDSTAT(nr_wakeups);
 		P_SCHEDSTAT(nr_wakeups_sync);
 		P_SCHEDSTAT(nr_wakeups_migrate);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4de6acb9b8ec..1656c90b2381 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -460,6 +460,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 	NUMA_PAGE_MIGRATE,
 	NUMA_PTE_UPDATES,
 	NUMA_HINT_FAULTS,
+	NUMA_TASK_MIGRATE,
+	NUMA_TASK_SWAP,
 #endif
 };
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 16bfe1c694dd..7de1583a63c9 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1339,6 +1339,8 @@ const char * const vmstat_text[] = {
 	"numa_hint_faults",
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
+	"numa_task_migrated",
+	"numa_task_swapped",
 #endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
-- 
2.25.1


