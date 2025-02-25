Return-Path: <cgroups+bounces-6712-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F09A441E1
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 15:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1953AFDE8
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2A26A090;
	Tue, 25 Feb 2025 14:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D5szGzZD"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C0533CFC;
	Tue, 25 Feb 2025 14:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492303; cv=none; b=uSTur4GZnTFuvUJ7rmgBwwyqMTwjxkyrIcdwfQPXTBDqmixt+GVm9J2cWyLG85jgWoQD79tCEpKSagzeA/3ZHQXZDJMlMZWRSJTGYFhkV/sCUjMW0k95NU8NAaRL4BAWnP0yNhGUkOhxvQ1cgnQqtFDovzOadmVxyTz7JibQbfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492303; c=relaxed/simple;
	bh=hdQzrrNE52j/1pPIwjImRAwPDZ4EG0HB8b/6MuOnZsA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCVceGWcF4RNXqANeiKr+UKHp58JPufiHhay+XBhU5CjrM0yzvuu0385Ch8L0oCqafVbe7K2CwfCPsVAFeZDgkErtaUfTrwtgPzwpMm8nuRhLSm19y/Din6cwm54VxIjLH8aNzYliUjICphIeQCXa/7IZJfcOW/UBVlbaq7r8cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D5szGzZD; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740492302; x=1772028302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hdQzrrNE52j/1pPIwjImRAwPDZ4EG0HB8b/6MuOnZsA=;
  b=D5szGzZDfn1JT+NYprq2nNa+60QZ05C0TdIUT6vIQCF9AjozjcfyrLuy
   cIaQJfuqdlT0zKZ+EM56fCCBN+ZBF13I2JKvLMrb0a1MloQBmtssyTaWl
   a/9fjQuHS0A5NOFvrX7V7TsYk07ts5CxAenjOtBTXY1patibmQxvGQ1S7
   O+WgyqKQ6/PAhgh2dYS3kczyJu2ev991PTh+E95g31h3Qeh6rFqJ8oqao
   2jADKZpNh2ib28OeNJb7SxzjqvKF5jl90v9FBjHihY5d1JQIcw2UFoHA0
   gzmBx+QNvuxyQADNz17wrI49A2flWbIWI8GMREqDOd41SHA2qURDR4u+U
   g==;
X-CSE-ConnectionGUID: VTCZTJuQTSmsFuMHa2rKPw==
X-CSE-MsgGUID: YqaiZC5LQ1KUsLiwl84qSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41424598"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="41424598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:05:01 -0800
X-CSE-ConnectionGUID: jOvlhMYcRna49H6HM95Otg==
X-CSE-MsgGUID: aHIhg91ZQQexTDVfL18beg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="116590762"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by fmviesa008.fm.intel.com with ESMTP; 25 Feb 2025 06:04:56 -0800
From: Chen Yu <yu.c.chen@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Tim Chen <tim.c.chen@intel.com>,
	Aubrey Li <aubrey.li@intel.com>,
	Michael Wang <yun.wang@linux.alibaba.com>,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	David Rientjes <rientjes@google.com>,
	Raghavendra K T <raghavendra.kt@amd.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Chen Yu <yu.c.chen@intel.com>
Subject: [RFC PATCH 1/3] sched/numa: Introduce numa balance task migration and swap in schedstats
Date: Tue, 25 Feb 2025 22:00:01 +0800
Message-Id: <1847c5ef828ad4835a35e3a54b88d2e13bce0eea.1740483690.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1740483690.git.yu.c.chen@intel.com>
References: <cover.1740483690.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a requirement to track task activities during NUMA
balancing. NUMA balancing has two mechanisms for task migration:
one is to migrate the task to an idle CPU in its preferred node,
and the other is to swap tasks on different nodes if they are
on each other's preferred node. The kernel already has NUMA page
migration statistics. Add the task migration and swap count
described above in the per-task/cgroup scope. The data will be
displayed at

/sys/fs/cgroup/mytest/memory.stat and
/proc/{PID}/sched.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched.h         |  4 ++++
 include/linux/vm_event_item.h |  2 ++
 kernel/sched/core.c           | 10 ++++++++--
 kernel/sched/debug.c          |  4 ++++
 mm/memcontrol.c               |  2 ++
 mm/vmstat.c                   |  2 ++
 6 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..01faa608ed7c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -527,6 +527,10 @@ struct sched_statistics {
 	u64				nr_failed_migrations_running;
 	u64				nr_failed_migrations_hot;
 	u64				nr_forced_migrations;
+#ifdef CONFIG_NUMA_BALANCING
+	u64				nr_numa_migrations;
+	u64				nr_numa_swap;
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
index 165c90ba64ea..44efc725054a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3348,6 +3348,11 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 #ifdef CONFIG_NUMA_BALANCING
 static void __migrate_swap_task(struct task_struct *p, int cpu)
 {
+	__schedstat_inc(p->stats.nr_numa_swap);
+
+	if (p->mm)
+		count_memcg_events_mm(p->mm, NUMA_TASK_SWAP, 1);
+
 	if (task_on_rq_queued(p)) {
 		struct rq *src_rq, *dst_rq;
 		struct rq_flags srf, drf;
@@ -7901,8 +7906,9 @@ int migrate_task_to(struct task_struct *p, int target_cpu)
 	if (!cpumask_test_cpu(target_cpu, p->cpus_ptr))
 		return -EINVAL;
 
-	/* TODO: This is not properly updating schedstats */
-
+	__schedstat_inc(p->stats.nr_numa_migrations);
+	if (p->mm)
+		count_memcg_events_mm(p->mm, NUMA_TASK_MIGRATE, 1);
 	trace_sched_move_numa(p, curr_cpu, target_cpu);
 	return stop_one_cpu(curr_cpu, migration_cpu_stop, &arg);
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index ef047add7f9e..ed801cc00bf1 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1204,6 +1204,10 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 		P_SCHEDSTAT(nr_failed_migrations_running);
 		P_SCHEDSTAT(nr_failed_migrations_hot);
 		P_SCHEDSTAT(nr_forced_migrations);
+#ifdef CONFIG_NUMA_BALANCING
+		P_SCHEDSTAT(nr_numa_migrations);
+		P_SCHEDSTAT(nr_numa_swap);
+#endif
 		P_SCHEDSTAT(nr_wakeups);
 		P_SCHEDSTAT(nr_wakeups_sync);
 		P_SCHEDSTAT(nr_wakeups_migrate);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 46f8b372d212..496b5edc3db6 100644
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
index 16bfe1c694dd..d6651778e4bf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1339,6 +1339,8 @@ const char * const vmstat_text[] = {
 	"numa_hint_faults",
 	"numa_hint_faults_local",
 	"numa_pages_migrated",
+	"numa_task_migrated",
+	"numa_task_swaped",
 #endif
 #ifdef CONFIG_MIGRATION
 	"pgmigrate_success",
-- 
2.25.1


