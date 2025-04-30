Return-Path: <cgroups+bounces-7949-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3670BAA491B
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 12:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA3291893CCF
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 10:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB3B2586CC;
	Wed, 30 Apr 2025 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U2letWcU"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFB253327;
	Wed, 30 Apr 2025 10:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009748; cv=none; b=KD7sxyJJzl5cQW1a7LkFanHMJW/U5gGJpj/ViEXkwM+l84f5jpBiopwPMyTNU6g1GEbeEtuQIQGkgpwDMJOx/wWSgtuO+TG8n5zdPuug0XVzbqUXYz2fLMMDVTSs3gLZPTSieMrzNtvXBJ0LOqvNsCQ//aghSJU7sD5W5XoRmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009748; c=relaxed/simple;
	bh=VOI7vS/Hx63Qc2jd9lMpXR2iXNmohRhb+XxgADkUU14=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B+vQIfZ1Vz3dB61nLtWF6bWFI+mwTKnJA+hBFTU6xOxAU1mHvv7m+uul2IHQXQqQNmFeScS5gVBQsjdu/E0X2AIW3PujePmnYHuChsnwiq0JTw5BrPeJVst6osiOI8sGexgshRxUUm3FTRPlc0U7J9egyxXBUKgYldeu9Pp67ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U2letWcU; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746009746; x=1777545746;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VOI7vS/Hx63Qc2jd9lMpXR2iXNmohRhb+XxgADkUU14=;
  b=U2letWcUZE+S4cpQiNsf4wlcjJSNrpybqc6ssWoSxIL+kMZDxRmvrE5k
   MPmYo5RtQ2CJpRsOfUjhypOch0lPUTMjvoDLQvldml4ULETMk73p4VmOn
   xGnqPyJPm/K2Yv3WcE2FRpRJYuGLvK5mJDPD0qjkToX1KaI79IqCpofw8
   HRiVCLuCBsnHooYporHyuRhmRSuJXHCkpWwZ4QPwJdqjT6+0YdFrvX08j
   /FOR4V38yGvP9WHxSjJcH4+lCjXvNnY9T/OV18mcHVtwZvA6MmQifW/Hi
   TvOOENFBJn2bompdFPFcO07hgKaAdmD3WerlYwZn4CDeyA2HivWHmj221
   g==;
X-CSE-ConnectionGUID: 1JNMoUdgQSi0rEAs64C4ZQ==
X-CSE-MsgGUID: QkYLB4moRUaCirdNsxGx5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="51326304"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="51326304"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 03:42:25 -0700
X-CSE-ConnectionGUID: yYbopDp1TwOcHFALwXyC4g==
X-CSE-MsgGUID: vjyOm4ajRs6T5uxyOPgSmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="138899488"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa003.jf.intel.com with ESMTP; 30 Apr 2025 03:42:20 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mel Gorman <mgormanmgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Michal Koutny <mkoutny@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Chen, Tim C" <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v3] sched/numa: add statistics of numa balance task migration
Date: Wed, 30 Apr 2025 18:36:23 +0800
Message-Id: <20250430103623.3349842-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with NUMA balancing enabled, it is found that tracking
the task activities due to NUMA balancing is helpful. NUMA balancing
has two mechanisms for task migration: one is to migrate the task to
an idle CPU in its preferred node, the other is to swap tasks on
different nodes if they are on each other's preferred node.

The kernel already has NUMA page migration statistics in
/sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched,
but does not have statistics for task migration/swap.
Add the task migration and swap count accordingly.

The following two new fields:

numa_task_migrated
numa_task_swapped

will be displayed in both
/sys/fs/cgroup/{GROUP}/memory.stat and /proc/{PID}/sched

Introducing both pertask and permemcg NUMA balancing statistics helps
to quickly evaluate the performance and resource usage of the target
workload. For example, the user can first identify the container which
has high NUMA balance activity and then narrow down to a specific task
within that group, and tune the memory policy of that task.
In summary, it is plausible to iterate the /proc/$pid/sched to find the
offending task, but the introduction of per memcg tasks' Numa balancing
aggregated  activity can further help users identify the task in a
divide-and-conquer way.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2->v3:
Remove unnecessary p->mm check because kernel threads are
not supported by Numa Balancing. (Libo Chen)
v1->v2:
Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
---
 Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
 include/linux/sched.h                   | 4 ++++
 include/linux/vm_event_item.h           | 2 ++
 kernel/sched/core.c                     | 7 +++++--
 kernel/sched/debug.c                    | 4 ++++
 mm/memcontrol.c                         | 2 ++
 mm/vmstat.c                             | 2 ++
 7 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 1a16ce68a4d7..d346f3235945 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1670,6 +1670,12 @@ The following nested keys are defined.
 	  numa_hint_faults (npn)
 		Number of NUMA hinting faults.
 
+	  numa_task_migrated (npn)
+		Number of task migration by NUMA balancing.
+
+	  numa_task_swapped (npn)
+		Number of task swap by NUMA balancing.
+
 	  pgdemote_kswapd
 		Number of pages demoted by kswapd.
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac1982893..1c50e30b5c01 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -549,6 +549,10 @@ struct sched_statistics {
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
index 9e15a088ba38..91a3ce9a2687 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -66,6 +66,8 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NUMA_HINT_FAULTS,
 		NUMA_HINT_FAULTS_LOCAL,
 		NUMA_PAGE_MIGRATE,
+		NUMA_TASK_MIGRATE,
+		NUMA_TASK_SWAP,
 #endif
 #ifdef CONFIG_MIGRATION
 		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c81cf642dba0..25a92f2abda4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3352,6 +3352,9 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 #ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
 {
+	__schedstat_inc(p->stats.numa_task_swapped);
+	count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
+
 	if (task_on_rq_queued(p)) {
 		struct rq *src_rq, *dst_rq;
 		struct rq_flags srf, drf;
@@ -7953,8 +7956,8 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
 		return -EINVAL;
 
-	/* TODO: This is not properly updating schedstats */
-
+	__schedstat_inc(p->stats.numa_task_migrated);
+	count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
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
index c96c1f2b9cf5..cdaab8a957f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -463,6 +463,8 @@ static const unsigned int memcg_vm_event_stat[] = {
 	NUMA_PAGE_MIGRATE,
 	NUMA_PTE_UPDATES,
 	NUMA_HINT_FAULTS,
+	NUMA_TASK_MIGRATE,
+	NUMA_TASK_SWAP,
 #endif
 };
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 4c268ce39ff2..ed08bb384ae4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1347,6 +1347,8 @@ const char * const vmstat_text[] = {
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


