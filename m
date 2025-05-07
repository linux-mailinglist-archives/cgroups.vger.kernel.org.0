Return-Path: <cgroups+bounces-8064-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913D3AADD3C
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 13:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F7B1BC605A
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 11:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05387231CB0;
	Wed,  7 May 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLn5rIsc"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C5C217733;
	Wed,  7 May 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746617014; cv=none; b=uYoOnXDvW70FymElbg+uik5iRYoz42Hg8O3IW+wl862e6ShH/+kyAPEfNSktz3kDX6OEyDeh3B4rYW1y9kFLuQqdG2NbS2Wz8GS7efLosAifSM9giO92/48Yz2DszCph2j95+ur3P7FB/IWbgOrX2e3ExH6QGbhAj5mYSd1uhvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746617014; c=relaxed/simple;
	bh=2cV6mIixfVbGAtm077DH6yhtQsn31YEy+En+GAgBAq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtHFqHsIbBQTfUEWDSHnJ377F//0FNwBPxC4wntgpBFuJN5POXHA9I8oDgh7Jl79jnRmdz61euEygYfWbQ7nMI763oczXG2pdSOnOUkWT/oFfs54N7cZCsPK9+LuGQvsV2l4/UL2bub6mNqiUJTsTLxmWgl8irCAm+CGVD3CZu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLn5rIsc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746617013; x=1778153013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2cV6mIixfVbGAtm077DH6yhtQsn31YEy+En+GAgBAq4=;
  b=MLn5rIscLqolHPaYpk4YQfle7rDeCJ7JzahKLHfgEYC02Mj6t/rsZKnK
   dw5t/aYgnS3RJS6gB4dPTrkJfWagZRsz0HgOEJ/qgQRWUSlWALIlIwEtQ
   qOmgaXpnBhmN4Z7kJ2gg3PEA1s3GayMjpxrJCrRiHC9Nw1WgQO29vWW0k
   3PjsDwOQo51nY5mc9f2dcPo1qy6pF+FLkjRXINvU9FaTFxEkxsy8or0Ap
   X/g1YyMnkZunLPfvG0mkALy20MPug54eZd6+LBjZNHtqVs8vwa4BN9ZpB
   vqTBcVfLUgOsFq/gWdtdivpYWAxYMuVQ1R/ArwFPVVvL39Obf2EY33ITG
   g==;
X-CSE-ConnectionGUID: 3L8OngKCREqOSMteT02imA==
X-CSE-MsgGUID: b/MM+AgfTuGyNDCcrHE4iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="48454987"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="48454987"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 04:23:32 -0700
X-CSE-ConnectionGUID: 5khJd032RueXiauolh6A9w==
X-CSE-MsgGUID: S/AK5p8RRH+QK2mByIzBzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; 
   d="scan'208";a="135946740"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa007.fm.intel.com with ESMTP; 07 May 2025 04:23:26 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: mkoutny@suse.com,
	Ingo Molnar <mingo@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Chen, Tim C" <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Libo Chen <libo.chen@oracle.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	"Jain, Ayush" <ayushjai@amd.com>,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.chen.surf@foxmail.com>,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v4 2/2] sched/numa: add statistics of numa balance task migration
Date: Wed,  7 May 2025 19:17:53 +0800
Message-Id: <b285978a61e9796b503fd2f0a785306d59f01a43.1746611892.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1746611892.git.yu.c.chen@intel.com>
References: <cover.1746611892.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On systems with NUMA balancing enabled, it has been found
that tracking task activities resulting from NUMA balancing
is beneficial. NUMA balancing employs two mechanisms for task
migration: one is to migrate a task to an idle CPU within its
preferred node, and the other is to swap tasks located on
different nodes when they are on each other's preferred nodes.

The kernel already provides NUMA page migration statistics in
/sys/fs/cgroup/mytest/memory.stat and /proc/{PID}/sched. However,
it lacks statistics regarding task migration and swapping.
Therefore, relevant counts for task migration and swapping should
be added.

The following two new fields:

numa_task_migrated
numa_task_swapped

will be shown in /sys/fs/cgroup/{GROUP}/memory.stat, /proc/{PID}/sched
and /proc/vmstat

Introducing both per-task and per-memory cgroup (memcg) NUMA
balancing statistics facilitates a rapid evaluation of the
performance and resource utilization of the target workload.
For instance, users can first identify the container with high
NUMA balancing activity and then further pinpoint a specific
task within that group, and subsequently adjust the memory policy
for that task. In short, although it is possible to iterate through
/proc/$pid/sched to locate the problematic task, the introduction
of aggregated NUMA balancing activity for tasks within each memcg
can assist users in identifying the task more efficiently through
a divide-and-conquer approach.

As Libo Chen pointed out, the memcg event relies on the text
names in vmstat_text, and /proc/vmstat generates corresponding items
based on vmstat_text. Thus, the relevant task migration and swapping
events introduced in vmstat_text also need to be populated by
count_vm_numa_event(), otherwise these values are zero in
/proc/vmstat.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v3->v4:
Populate the /prov/vmstat otherwise the items are all zero.
(Libo)
v2->v3:
Remove unnecessary p->mm check because kernel threads are
not supported by Numa Balancing. (Libo Chen)
v1->v2:
Update the Documentation/admin-guide/cgroup-v2.rst. (Michal)
---
 Documentation/admin-guide/cgroup-v2.rst | 6 ++++++
 include/linux/sched.h                   | 4 ++++
 include/linux/vm_event_item.h           | 2 ++
 kernel/sched/core.c                     | 9 +++++++--
 kernel/sched/debug.c                    | 4 ++++
 mm/memcontrol.c                         | 2 ++
 mm/vmstat.c                             | 2 ++
 7 files changed, 27 insertions(+), 2 deletions(-)

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
index c81cf642dba0..62b033199e9c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3352,6 +3352,10 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 #ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
 {
+	__schedstat_inc(p->stats.numa_task_swapped);
+	count_vm_numa_event(NUMA_TASK_SWAP);
+	count_memcg_event_mm(p->mm, NUMA_TASK_SWAP);
+
 	if (task_on_rq_queued(p)) {
 		struct rq *src_rq, *dst_rq;
 		struct rq_flags srf, drf;
@@ -7953,8 +7957,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
 		return -EINVAL;
 
-	/* TODO: This is not properly updating schedstats */
-
+	__schedstat_inc(p->stats.numa_task_migrated);
+	count_vm_numa_event(NUMA_TASK_MIGRATE);
+	count_memcg_event_mm(p->mm, NUMA_TASK_MIGRATE);
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


