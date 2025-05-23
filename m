Return-Path: <cgroups+bounces-8326-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3693AC233C
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C17C1BA2C8A
	for <lists+cgroups@lfdr.de>; Fri, 23 May 2025 12:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CDC7DA95;
	Fri, 23 May 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKplNDH9"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F5410A1F;
	Fri, 23 May 2025 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748005073; cv=none; b=bAWdAhBFTgpjYitlUiEaM0yQ0ZFIZdLj3svWD0Jk9PtVUNQr7jw7q+buOq9aN2bfaCvuykXn2BheuhsxE24suQ3K+kRB2/bs7gV1MLeifd04IuyJ07pjZuBCAGVluKGlbuhOui0oRuQt8UsQS0BWVjVkdAS2nn6Hww43Zil/8Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748005073; c=relaxed/simple;
	bh=rRs9XseLreLZ799IlzhB0KoGHd9fK4lDSsY4Z7uNsZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OneVIvRHbKryhZkC1ZrPNTSSPY+twev87S9pV8JsULzOVbYT17W7dj4dUGci/cOUQZU6GBQA+QrxxQj3DqVje+bHqm1N7sNsYdU+/0fL1L+naVYA6uG3x3lwX2ZIeHaxER1nP3D6ut5H/3YSTEmPsy6qd+VnvL7eXpiJqdEBwG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKplNDH9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748005071; x=1779541071;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rRs9XseLreLZ799IlzhB0KoGHd9fK4lDSsY4Z7uNsZE=;
  b=FKplNDH9wmg/PWIG75Ib2k+SKgKZHgQobuHeYEfBADsqyyYwR9ZjD3zV
   7iucXk9juWrYVTirRhRw3YQHVNINt/uqaBcAPeONpGcjajH4cuxEaCjlQ
   OB1EZpv1NdQcTLhwSbeqykqylpS/SFXXDwllOlXwiBI5Gs6taxc8TkBQ7
   H1oZ6Tg6ICnG38wOWv1s8Ft5ErOU60ThUeHp7GVIsPMTpyDh/iNev0LzN
   miu10mKnohxxDtCln6KWx6oDAOaKGKLy7KbPb8K7MuxFll+1uGLObWDE0
   Cf49RaXahq6wn9nbU1SG+jbe2I8cbhjspxhcewr/mjB4E2lffI8ikzINn
   g==;
X-CSE-ConnectionGUID: nAWanG1PQq2NMM9U+V/nFw==
X-CSE-MsgGUID: H21LbeGHR6WYQovb8K8uzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49177632"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49177632"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 05:57:50 -0700
X-CSE-ConnectionGUID: w07W8+JUToKmjsvrozAm9w==
X-CSE-MsgGUID: PVtsidVES4GxFwfdkylrBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="145087474"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa003.fm.intel.com with ESMTP; 23 May 2025 05:57:45 -0700
From: Chen Yu <yu.c.chen@intel.com>
To: peterz@infradead.org,
	akpm@linux-foundation.org
Cc: mkoutny@suse.com,
	mingo@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mgorman@suse.de,
	mhocko@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
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
Subject: [PATCH v5 2/2] sched/numa: add statistics of numa balance task
Date: Fri, 23 May 2025 20:51:15 +0800
Message-Id: <7ef90a88602ed536be46eba7152ed0d33bad5790.1748002400.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1748002400.git.yu.c.chen@intel.com>
References: <cover.1748002400.git.yu.c.chen@intel.com>
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
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v4->v5:
no change.
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


