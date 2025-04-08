Return-Path: <cgroups+bounces-7421-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F880A7FBC8
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 12:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 388917A6401
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4430F267728;
	Tue,  8 Apr 2025 10:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Od1W2qo3"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907672673A5;
	Tue,  8 Apr 2025 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107698; cv=none; b=awfsQF7evP7Z4SpEFD0NAEzV+/SC0FntZYIQij6blYfHjT5oRkqjtqdlyeDK19TFlPd3r1n1acFUvpmcw2ut3leirD31FzXcBDh0OU7fH02Gsn8qtn9hUOZaouc4V8ibkAGrxgS9gx2RutZh2TBoiwCjxbi5rdg13PEBGz4itTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107698; c=relaxed/simple;
	bh=2TWbx80DBfebYdtB+8UqZOQggmllLAdKvcVPGbHUZJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qY7R4fnpb2u29CQtoEWWT/+bU4r0nM3HMt4fOooH6Pr3/kVKN9/lME70cfBAGBlfnWpy9gru/Y/fAijKJrzWa7LeRA/xL0a6bNILYtxpz7CuHyGdFS5VFI5HoQhCKmKx4QR33QxpTSrILvL+YC3L0pcTjFsx9DqdEKEGIzJ5llE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Od1W2qo3; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744107696; x=1775643696;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2TWbx80DBfebYdtB+8UqZOQggmllLAdKvcVPGbHUZJk=;
  b=Od1W2qo34OL0DoK/GNBY/hN7EtGlGZtIxpMZ0HGKu29UZXl/0RmjsinD
   W7AKNIfWAt/4kExRv+oSkb4zxkABrOK220qxstL/JCjtGE3AnFyC1zPYl
   TE9d+eckvu3w5t8qku+ltZUGrxREMBhuo+lnCEc1V1GKipF8k7Vm+iAPr
   Dk2NBLxNWQfWP0BOJTw+UGr8y1TEbFWTBlqikS0wBTw+F+SRsTY6wXi1z
   NPLuECfio3veFjiME/+c9s9q5hQ6/mbHSgZVcQgCtAjlMUVa/hXNknger
   BwSgfsFtUJ5Dao3mCtDmakRbhp8/XVBUc+Sz5pdnB7pa7LEtNEKPDdU8g
   g==;
X-CSE-ConnectionGUID: NIEZ6w9yQ5Cel7uETZsk0w==
X-CSE-MsgGUID: 3yLdRBXIQvq6LmXHS6K3Tw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56196520"
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="56196520"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 03:21:19 -0700
X-CSE-ConnectionGUID: AkbhsusUSYGQ+uYCTBeKCA==
X-CSE-MsgGUID: ECRVkKJ1RkOqWDOy3NxCKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,197,1739865600"; 
   d="scan'208";a="132360362"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa003.fm.intel.com with ESMTP; 08 Apr 2025 03:21:10 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	"Michal Koutny" <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tim Chen <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Chen Yu <yu.chen.surf@foxmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Subject: [PATCH v2] sched/numa: Add statistics of numa balance task migration and swap
Date: Tue,  8 Apr 2025 18:14:44 +0800
Message-Id: <20250408101444.192519-1-yu.c.chen@intel.com>
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
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v1->v2:
Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
---
 Documentation/admin-guide/cgroup-v2.rst |  6 ++++++
 include/linux/sched.h                   |  4 ++++
 include/linux/vm_event_item.h           |  2 ++
 kernel/sched/core.c                     | 10 ++++++++--
 kernel/sched/debug.c                    |  4 ++++
 mm/memcontrol.c                         |  2 ++
 mm/vmstat.c                             |  2 ++
 7 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index f293a13b42ed..b698be14942c 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1652,6 +1652,12 @@ The following nested keys are defined.
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
index 56ddeb37b5cd..2e91326c16ec 100644
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
index 5a37cb2b6f93..df8a1b30930f 100644
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
index b434c2f7e3c1..54e7d63f7785 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3352,6 +3352,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
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
@@ -7955,8 +7960,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
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
index 83c2df73e4b6..1ba1fa9ed8cb 100644
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
index 651318765ebf..4abd2ca05d2a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1342,6 +1342,8 @@ const char * const vmstat_text[] = {
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


