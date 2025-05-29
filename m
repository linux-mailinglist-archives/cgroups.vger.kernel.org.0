Return-Path: <cgroups+bounces-8384-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D68AC7763
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 07:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3261F9E5522
	for <lists+cgroups@lfdr.de>; Thu, 29 May 2025 05:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C08525291B;
	Thu, 29 May 2025 05:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCK7GyuD"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F0E25228C;
	Thu, 29 May 2025 05:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494953; cv=none; b=rOhUbBp3fYAf0r1dpmdq61GzkXyemAPon7FLI58IeG6qdT8gjCs+zJ0+XMg89aOuSeZF6BFbHmjbkDbQMPmKkdTgO/bGfUlVOaKN8pkJdYPa0dqjzmmFVsuIGoNJRApRKVLoAQbHZOzWrDGZ2IPxqi5FBafQvngc7OqeZ+F2pKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494953; c=relaxed/simple;
	bh=ecTVOg2+Ta+tPmrIDYXpDrGuLsS5tXEp9EXSdd7/jCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zgf75IIrEZ9CRr6ZVBvQb07CekXJToNspvy0DN8s7yyANJpGb+bptNonclmQ8v+Q/kYgaYk74ZnHSR3SB1qJfPP8JkDnUq8JbhTY+9Yd5WnXIWRgeHvwjXShepT6mfKcjelZybBCX3YRBCDQLEb48DSXYIzooObie9lVvK79MYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCK7GyuD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748494951; x=1780030951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ecTVOg2+Ta+tPmrIDYXpDrGuLsS5tXEp9EXSdd7/jCE=;
  b=NCK7GyuD12WqNTaWEneXpXYG1QDHHtWEXLRDkO2m/mfgeon/HTibW594
   QookTVdgSWim6RsQtFTZpLA8bGJGpk0H8JV946wfwtiuz3sn3pww8gre+
   MPoQCi7CX3H0k/XEjPmZx0aBilG2RmKRCShy53pldy6Nlq36UzS2sWF9G
   9kFNrYR+E2obtwpynumGh0cT7KOHNS/w0KMoJBFU+apmvCRY3bs2qt2um
   3fPSWlY1ahxeOWO/eeuoGMADo6JEXL4HAFUpMU8Qt7uRX40HYSpKg5Swu
   7A0HTDYQHlxqgoYYjB4rwC2U8Q4q4KKanj7osOipbw8IEe7rLOJH7mpEP
   w==;
X-CSE-ConnectionGUID: LY4yNmr+RQW2TXjTWsCy6Q==
X-CSE-MsgGUID: y3+rsbdLSPC3fXSK/J+tnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50598655"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="50598655"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 22:02:30 -0700
X-CSE-ConnectionGUID: ZQKzcb8/RaiBkTgNEXNAqw==
X-CSE-MsgGUID: 0KGgKI0zQxa/LOlVBlT1lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; 
   d="scan'208";a="148315094"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa005.fm.intel.com with ESMTP; 28 May 2025 22:02:25 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: peterz@infradead.org,
	akpm@linux-foundation.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev
Cc: mingo@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mgorman@suse.de,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	tim.c.chen@intel.com,
	aubrey.li@intel.com,
	libo.chen@oracle.com,
	kprateek.nayak@amd.com,
	vineethr@linux.ibm.com,
	venkat88@linux.ibm.com,
	ayushjai@amd.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	yu.chen.surf@foxmail.com,
	Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH v6 2/2] sched/numa: add statistics of numa balance task
Date: Thu, 29 May 2025 12:55:50 +0800
Message-Id: <d00edb12ba0f0de3c5222f61487e65f2ac58f5b1.1748493462.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1748493462.git.yu.c.chen@intel.com>
References: <cover.1748493462.git.yu.c.chen@intel.com>
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

In theory, task migration and swap events are part of the
scheduler's activities. The reason for exposing them through the
memory.stat/vmstat interface is that we already have NUMA balancing
statistics in memory.stat/vmstat, and these events are closely
related to each other. Following Shakeel's suggestion, we describe
the end-to-end flow/story of all these events occurring on a
timeline for future reference:

The goal of NUMA balancing is to co-locate a task and its
memory pages on the same NUMA node. There are two strategies:
migrate the pages to the task's node, or migrate the task to
the node where its pages reside.

Suppose a task p1 is running on Node 0, but its pages are
located on Node 1. NUMA page fault statistics for p1 reveal
its "page footprint" across nodes. If NUMA balancing detects
that most of p1's pages are on Node 1:

1.Page Migration Attempt:
The Numa balance first tries to migrate p1's pages to Node 0.
The numa_page_migrate counter increments.

2.Task Migration Strategies:
After the page migration finishes, Numa balance checks every
1 second to see if p1 can be migrated to Node 1.

Case 2.1: Idle CPU Available
If Node 1 has an idle CPU, p1 is directly scheduled there. This
event is logged as numa_task_migrated.
Case 2.2: No Idle CPU (Task Swap)
If all CPUs on Node1 are busy, direct migration could cause CPU
contention or load imbalance. Instead:
The Numa balance selects a candidate task p2 on Node 1 that prefers
Node 0 (e.g., due to its own page footprint).
p1 and p2 are swapped. This cross-node swap is recorded as
numa_task_swapped.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v5->v6:
Enhance the commit message by adding Numa balance events description.
(Shakeel)
v4->v5:
no change.
v3->v4:
Populate the /prov/vmstat otherwise the items are all zero.
(Libo)
v2->v3:
Remove unnecessary p->mm check because kernel threads are
not supported by Numa Balancing. (Libo)
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
index 1edc26622594..2e5d08a273ad 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1705,6 +1705,12 @@ The following nested keys are defined.
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
index 45e5953b8f32..bbc1820a1552 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -548,6 +548,10 @@ struct sched_statistics {
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
index 62b3416f5e43..dce50fa57471 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3362,6 +3362,10 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
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
@@ -7930,8 +7934,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
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
index 557246880a7e..9d71baf08075 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1210,6 +1210,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
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
index ec39e62b172e..ab89a3a0f1bf 100644
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


