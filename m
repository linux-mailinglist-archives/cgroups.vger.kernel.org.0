Return-Path: <cgroups+bounces-6713-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E7DA441CD
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 15:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF307189259A
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 14:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1AC26A0FF;
	Tue, 25 Feb 2025 14:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AK5bKZFb"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757801FC7D5;
	Tue, 25 Feb 2025 14:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492328; cv=none; b=qwuZ0+NDqFcx0996WyraIntISdsSYYJm4Ts2aPY2MaQtMx5TgPayC7IXHLiC945PW3MztI16LjF93Jpz6PBx7D8Se3lJoOxepMyfWTV7/1ucytVf1Vg37229WdJKjb6nrdnVQ88Kf7StZJpHY2gw6gqSrBlGfctIOri+nTq8b5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492328; c=relaxed/simple;
	bh=MRXLTjehIE10KAbbp3iCpL5NeG3pAuNZ+yln9NJGlpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuW6Vw47H2MOVG6wtCrX9+2IOHEigNvsUp1yZFTMLOCjreUcOpGap/di1opHqo/y6aUrVHxwtCWJuBJUXhCtmpdV32QnnWRHpyq49ra81L+/0j8cQSEeD9MRbSDDCgmC9kGhROcjBuOp4mFzlmDmI6emzUI7KAoJHkeag7pmfbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AK5bKZFb; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740492327; x=1772028327;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MRXLTjehIE10KAbbp3iCpL5NeG3pAuNZ+yln9NJGlpU=;
  b=AK5bKZFbpaQ0XL4obPawQngCEd5PMAR+i0AktPIT7QsrevlvJqqi9V2a
   0tRki9cSovBD0GPX6BfeBnE7ApZkGGJ63l8ItHoWkrvIamqQkdNY9GGkQ
   4gZcPUHUxXIvKvwiesnrnc8xkkRNjvYKBpf6zpn/HHuAYohDGlV3L9ml2
   XuZiI1F8wYQJPcxjR+eA8lAgsOUYcVxXvma8yj9UJOQsDliWXMx3P7yfy
   6SDbk087GQ7jvZ++gpy07DADEWww7rQBGqyPVmRQ2yYvPG5bUs2lRSJBb
   xL5fFgjfNu2prRTzu3oMzNuLHvJh34+iBVrt7B06e/OOmgwWQ+OXsW62D
   Q==;
X-CSE-ConnectionGUID: xYMNd1nyRN2/MzkP0wd6rA==
X-CSE-MsgGUID: CN6aLz18Qdi9GoSLwkR0Wg==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58720185"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="58720185"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:05:26 -0800
X-CSE-ConnectionGUID: jQaiv7nJRRiPCgEZItUVGQ==
X-CSE-MsgGUID: BxXGW796SFaKvlUgJxOdPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="147217658"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa002.jf.intel.com with ESMTP; 25 Feb 2025 06:05:20 -0800
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
Subject: [RFC PATCH 2/3] sched/numa: Introduce per cgroup numa balance control
Date: Tue, 25 Feb 2025 22:00:15 +0800
Message-Id: <b3f1f6c478127a38b9091a8341374ba160d25c5a.1740483690.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1740483690.git.yu.c.chen@intel.com>
References: <cover.1740483690.git.yu.c.chen@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Problem Statement]
Currently, NUMA balancing is configured system-wide. However,
in some production environments, different containers may have
varying requirements for NUMA balancing. Some containers are
CPU-intensive, while others are memory-intensive. Some do not
benefit from NUMA balancing due to the overhead associated with
VMA scanning, while the other prefers NUMA balancing as it helps
improve memory locality. In this case, system-wide NUMA balancing
is usually disabled to produce stable results.

[Proposal]
Introduce a per-cgroup interface to enable NUMA balancing for specific
cgroups. The system administrator must set the NUMA balancing mode
to NUMA_BALANCING_CGROUP=4 to enable this feature. When in global
NUMA_BALANCING_CGROUP mode, all cgroups' NUMA balancing is disabled by
default. After the administrator enables this feature for a specific
cgroup, NUMA balancing for that cgroup is enabled.

A simple example to show how to use per-cgroup Numa balancing:

Step1
//switch to global per cgroup Numa balancing,
//All cgroup's Numa balance is disabled by default.
echo 4 > /proc/sys/kernel/numa_balancing

Step2
//created a cgroup named mytest, enable its Numa balancing
echo 1 > /sys/fs/cgroup/mytest/cpu.numa_load_balance

[Benchmark]
Tested on two systems. Both systems have 4 nodes. Created a
cgroup mytest which is bind to node0 and node1(cpu affinity
as well as memory allocation policy). Launched autonumabench
NUMA01_THREADLOCAL via mmtests.

echo 0 > /sys/fs/cgroup/mytest/cpu.numa_load_balance
cgexec -g cpuset:mytest  ./run-mmtests.sh --no-monitor \
	--config config-numa baseline
echo 1 > /sys/fs/cgroup/mytest/cpu.numa_load_balance \
cgexec -g cpuset:mytest  ./run-mmtests.sh --no-monitor
	--config config-numa nb_cgroup

system1: 4 nodes, 24 Cores(48 CPUs)/node.
baseline took a total of 191.32 seconds to finish, while cgroup
numa balancing took a total of 104.46 seconds. There is around
45% improvement.

                                                 baselin               nb_cgrou
                                                baseline              nb_cgroup
Min       syst-NUMA01_THREADLOCAL       69.65 (   0.00%)      106.73 ( -53.24%)
Min       elsp-NUMA01_THREADLOCAL      191.32 (   0.00%)      104.46 (  45.40%)
Amean     syst-NUMA01_THREADLOCAL       69.65 (   0.00%)      106.73 * -53.24%*
Amean     elsp-NUMA01_THREADLOCAL      191.32 (   0.00%)      104.46 *  45.40%*  <---
Stddev    syst-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
Stddev    elsp-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  syst-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  elsp-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
Max       syst-NUMA01_THREADLOCAL       69.65 (   0.00%)      106.73 ( -53.24%)
Max       elsp-NUMA01_THREADLOCAL      191.32 (   0.00%)      104.46 (  45.40%)
BAmean-50 syst-NUMA01_THREADLOCAL       69.65 (   0.00%)      106.73 ( -53.24%)
BAmean-50 elsp-NUMA01_THREADLOCAL      191.32 (   0.00%)      104.46 (  45.40%)
BAmean-95 syst-NUMA01_THREADLOCAL       69.65 (   0.00%)      106.73 ( -53.24%)
BAmean-95 elsp-NUMA01_THREADLOCAL      191.32 (   0.00%)      104.46 (  45.40%)
BAmean-99 syst-NUMA01_THREADLOCAL       69.65 (   0.00%)      106.73 ( -53.24%)
BAmean-99 elsp-NUMA01_THREADLOCAL      191.32 (   0.00%)      104.46 (  45.40%)

The run-to-run deviation downgrading occurs because sometimes the
per-cgroup NUMA balancing does not improve the score, although no
performance downgrading is observed.

delta of /sys/fs/cgroup/mytest/memory.stat during the test:
numa_pages_migrated: 979933
numa_pte_updates:    21007548  <-- introduced in previous patch
numa_hint_faults:    19663982  <-- introduced in previous patch

system1: 4 nodes, 40 Cores(80 CPUs)/node.
baseline took a total of 212.94 seconds to finish, while cgroup numa
balance took a total of 127.05 second, which is of 40.34% improvment.

                                                 baselin               nb_cgrou
                                                baseline              nb_cgroup
Min       syst-NUMA01_THREADLOCAL     8356.05 (   0.00%)     8921.84 (  -6.77%)
Min       elsp-NUMA01_THREADLOCAL      212.94 (   0.00%)      127.05 (  40.34%)
Amean     syst-NUMA01_THREADLOCAL     8356.05 (   0.00%)     8921.84 (  -6.77%)
Amean     elsp-NUMA01_THREADLOCAL      212.94 (   0.00%)      127.05 (  40.34%)  <---
Stddev    syst-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
Stddev    elsp-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  syst-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  elsp-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
Max       syst-NUMA01_THREADLOCAL     8356.05 (   0.00%)     8921.84 (  -6.77%)
Max       elsp-NUMA01_THREADLOCAL      212.94 (   0.00%)      127.05 (  40.34%)
BAmean-50 syst-NUMA01_THREADLOCAL     8356.05 (   0.00%)     8921.84 (  -6.77%)
BAmean-50 elsp-NUMA01_THREADLOCAL      212.94 (   0.00%)      127.05 (  40.34%)
BAmean-95 syst-NUMA01_THREADLOCAL     8356.05 (   0.00%)     8921.84 (  -6.77%)
BAmean-95 elsp-NUMA01_THREADLOCAL      212.94 (   0.00%)      127.05 (  40.34%)
BAmean-99 syst-NUMA01_THREADLOCAL     8356.05 (   0.00%)     8921.84 (  -6.77%)
BAmean-99 elsp-NUMA01_THREADLOCAL      212.94 (   0.00%)      127.05 (  40.34%)

The Numa statistics delta during the test:
numa_pages_migrated:  785848
numa_pte_updates:     2359714
numa_hint_faults:     2349857

[Shortage]
It has been observed that even with per-cgroup NUMA balancing enabled,
there is still remote node access, and the benchmark score does not
increase compared to the baseline. According to the NUMA statistics,
not much NUMA page migration is detected. Further testing shows that
global NUMA balancing has the same issue—sometimes NUMA balancing
does not help. This could be a generic issue in the current kernel
code, possibly due to either the NUMA page migration or task migration
strategy, and it needs to be further investigated.

Suggested-by: Tim Chen <tim.c.chen@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/sched/sysctl.h |  1 +
 kernel/sched/core.c          | 32 ++++++++++++++++++++++++++++++++
 kernel/sched/fair.c          | 18 ++++++++++++++++++
 kernel/sched/sched.h         |  3 +++
 mm/mprotect.c                |  5 +++--
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5a64582b086b..1e4d5a9ddb26 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -22,6 +22,7 @@ enum sched_tunable_scaling {
 #define NUMA_BALANCING_DISABLED		0x0
 #define NUMA_BALANCING_NORMAL		0x1
 #define NUMA_BALANCING_MEMORY_TIERING	0x2
+#define NUMA_BALANCING_CGROUP		0x4
 
 #ifdef CONFIG_NUMA_BALANCING
 extern int sysctl_numa_balancing_mode;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 44efc725054a..f4f048b3da68 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10023,6 +10023,31 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 }
 #endif
 
+#ifdef CONFIG_NUMA_BALANCING
+static DEFINE_MUTEX(numa_balance_mutex);
+static int numa_balance_write_u64(struct cgroup_subsys_state *css,
+				  struct cftype *cftype, u64 enable)
+{
+	struct task_group *tg;
+	int ret;
+
+	guard(mutex)(&numa_balance_mutex);
+	tg = css_tg(css);
+	if (tg->nlb_enabled == enable)
+		return 0;
+
+	tg->nlb_enabled = enable;
+
+	return ret;
+}
+
+static u64 numa_balance_read_u64(struct cgroup_subsys_state *css,
+				 struct cftype *cft)
+{
+	return css_tg(css)->nlb_enabled;
+}
+#endif /* CONFIG_NUMA_BALANCING */
+
 static struct cftype cpu_files[] = {
 #ifdef CONFIG_GROUP_SCHED_WEIGHT
 	{
@@ -10071,6 +10096,13 @@ static struct cftype cpu_files[] = {
 		.seq_show = cpu_uclamp_max_show,
 		.write = cpu_uclamp_max_write,
 	},
+#endif
+#ifdef CONFIG_NUMA_BALANCING
+	{
+		.name = "numa_load_balance",
+		.read_u64 = numa_balance_read_u64,
+		.write_u64 = numa_balance_write_u64,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1c0ef435a7aa..526cb33b007c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3146,6 +3146,18 @@ void task_numa_free(struct task_struct *p, bool final)
 	}
 }
 
+/* return true if the task group has enabled the numa balance */
+static bool tg_numa_balance_enabled(struct task_struct *p)
+{
+	struct task_group *tg = task_group(p);
+
+	if (tg && (sysctl_numa_balancing_mode & NUMA_BALANCING_CGROUP) &&
+	    !tg->nlb_enabled)
+		return false;
+
+	return true;
+}
+
 /*
  * Got a PROT_NONE fault for a page on @node.
  */
@@ -3174,6 +3186,9 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	     !cpupid_valid(last_cpupid)))
 		return;
 
+	if (!tg_numa_balance_enabled(p))
+		return;
+
 	/* Allocate buffer to track faults on a per-node basis */
 	if (unlikely(!p->numa_faults)) {
 		int size = sizeof(*p->numa_faults) *
@@ -3596,6 +3611,9 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
+	if (!tg_numa_balance_enabled(curr))
+		return;
+
 	/*
 	 * Using runtime rather than walltime has the dual advantage that
 	 * we (mostly) drive the selection from busy threads and that the
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 38e0e323dda2..9f478fb2c03a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -491,6 +491,9 @@ struct task_group {
 	/* Effective clamp values used for a task group */
 	struct uclamp_se	uclamp[UCLAMP_CNT];
 #endif
+#ifdef CONFIG_NUMA_BALANCING
+	u64			nlb_enabled;
+#endif
 
 };
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 516b1d847e2c..ddaaf20ef94c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -155,10 +155,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 				toptier = node_is_toptier(nid);
 
 				/*
-				 * Skip scanning top tier node if normal numa
+				 * Skip scanning top tier node if normal/cgroup numa
 				 * balancing is disabled
 				 */
-				if (!(sysctl_numa_balancing_mode & NUMA_BALANCING_NORMAL) &&
+				if (!(sysctl_numa_balancing_mode &
+				    (NUMA_BALANCING_CGROUP | NUMA_BALANCING_NORMAL)) &&
 				    toptier)
 					continue;
 				if (folio_use_access_time(folio))
-- 
2.25.1


