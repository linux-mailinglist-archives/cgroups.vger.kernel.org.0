Return-Path: <cgroups+bounces-6714-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F109A441C4
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 15:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A303316C4F1
	for <lists+cgroups@lfdr.de>; Tue, 25 Feb 2025 14:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB8B26A1BC;
	Tue, 25 Feb 2025 14:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WNyKJh5J"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BF52690D4;
	Tue, 25 Feb 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492357; cv=none; b=kUa4EahgMazl2FH3DwmLxlpw8vq85nFATgxNi18K9qi//26HL/A9wgrSNG2Ga8DavO0KMC312XMyO3k688E/LU6txXhn9M2BJGcF3oZWvFBHYJg9uJIoigDa15WvmLxHuQFdA/gn0a0SqsZkSFx5eEMDaPmddEjPUIdTgFcg5o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492357; c=relaxed/simple;
	bh=pdPlp0rDL1jfLw0dpmJfYk+F666XwJmSc0932Ij+l7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyFOMYDTvOvEAOhoJtiD3R5RjDV8wETY7MIwCjXmkck8Ytz4zkjkwjVtzDJWIBuk590kvcbfcdnS6WH4EHo7rcUy4z4Sd7sk4p3GWU+wrp/wmnJhvpNRdDsqxWhwe9d7iFtpAbCIupnOidXr6Fa0+c9L4KvwZum5STEhenGhxdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WNyKJh5J; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740492356; x=1772028356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pdPlp0rDL1jfLw0dpmJfYk+F666XwJmSc0932Ij+l7s=;
  b=WNyKJh5JZpkL6lRQVLK3w6MmtE4ir9zR0df5jLDetjqKzPoNoAykBS1l
   LGT1qz5PJlMpQQDnuEdPh8Mo9vc9jcbZvdX1lmRHNh3YqyY3bviYgXToQ
   I1uqZ4fELtLstiWu7MTb+ali49T3LoEMiMkEUD0vbDqUpG9LnUqcqDAol
   Lfbs9y/Q2xx9HVBqjamQJwF8XQ0XkTDP0hAvUn/d15vH2rSOaGtMJhSol
   sycFk/SkkX2QvWkPKE+v3+IY6JcXgd7xkoSZqRzNr+gDVnO5sIc62IE1l
   eTztfOmZ/IlxBTJ7bDvyLpvIubBt2GDIRi9Dxncqfb7v4OZO1x+1rLbxx
   A==;
X-CSE-ConnectionGUID: UsN3LzVqRPyrfyyhujcDnQ==
X-CSE-MsgGUID: 6vdRe1y6SzGC0JBdPhO+Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51513798"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="51513798"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 06:05:42 -0800
X-CSE-ConnectionGUID: VzWe+/YeR0W/uh6YQZcfXg==
X-CSE-MsgGUID: kkeWeCHnS1e4ahFVdyY1dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117326296"
Received: from chenyu-dev.sh.intel.com ([10.239.62.107])
  by orviesa008.jf.intel.com with ESMTP; 25 Feb 2025 06:05:35 -0800
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
Subject: [RFC PATCH 3/3] sched/numa: Allow intervale memory allocation for numa balance
Date: Tue, 25 Feb 2025 22:00:40 +0800
Message-Id: <b2193c946639598e1c506a555afcfc0224f1cecf.1740483690.git.yu.c.chen@intel.com>
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

MPOL_INTERLEAVE is used to allocate pages interleaved across different
NUMA nodes to make the best use of memory bandwidth. Under MPOL_INTERLEAVE
mode, NUMA load balance page migration does not occur because the page is
already in its designated place. Similarly, NUMA load task migration does
not occur either—mpol_misplaced() returns NUMA_NO_NODE, which instructs
do_numa_page() to skip page/task migration. However, there is a scenario
in the production environment where NUMA balance could benefit
MPOL_INTERLEAVE. This typical scenario involves tasks within cgroup g_A
being bound to two SNC (Sub-NUMA Cluster) nodes via cpuset, with their
pages allocated only on these two SNC nodes in an interleaved manner
using MPOL_INTERLEAVE. This setup allows g_A to achieve good resource
isolation while effectively utilizing the memory bandwidth of the two
SNC nodes. However, it is possible that tasks t1 and t2 in g_A could
experience remote access patterns:

	Node 0		Node 1
	t1		t1.page
	t2.page		t2

Ideally, a NUMA balance task swap would be beneficial:

	Node 0		Node 1
	t2		t1.page
	t2.page		t1

In other words, NUMA balancing can help swap t1 and t2 to improve NUMA
locality without migrating pages, thereby still honoring the
MPOL_INTERLEAVE policy. To enable NUMA balancing to manage MPOL_INTERLEAVE,
add MPOL_F_MOF to the MPOL_INTERLEAVE policy if the user has requested
it via MPOL_F_NUMA_BALANCING (similar to MPOL_BIND). In summary, pages
will not be migrated for MPOL_INTERLEAVE, but tasks will be migrated to
their preferred nodes.

Tested on a system with 4 nodes, 40 Cores(80 CPUs)/node, using
autonumabench NUMA01_THREADLOCAL, with some minor changes to support
MPOL_INTERLEAVE:

  p = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, \
		MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  set_mempolicy(MPOL_INTERLEAVE | MPOL_F_NUMA_BALANCING, \
		&nodemask_global, max_nodes);
  ...
  //each thread accesses 4K of data every 8K,
  //1 thread should access the pages on 1 node.

No obvious score difference was observed, but noticed some Numa balance
task migration:

                                 baseline_nocg_interleav      nb_nocg_interlave
                                 baseline_nocg_interleave     nb_nocg_interlave/
Min       syst-NUMA01_THREADLOCAL     7156.34 (   0.00%)     7267.28 (  -1.55%)
Min       elsp-NUMA01_THREADLOCAL       90.73 (   0.00%)       90.88 (  -0.17%)
Amean     syst-NUMA01_THREADLOCAL     7156.34 (   0.00%)     7267.28 (  -1.55%)
Amean     elsp-NUMA01_THREADLOCAL       90.73 (   0.00%)       90.88 (  -0.17%)
Stddev    syst-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
Stddev    elsp-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  syst-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
CoeffVar  elsp-NUMA01_THREADLOCAL        0.00 (   0.00%)        0.00 (   0.00%)
Max       syst-NUMA01_THREADLOCAL     7156.34 (   0.00%)     7267.28 (  -1.55%)
Max       elsp-NUMA01_THREADLOCAL       90.73 (   0.00%)       90.88 (  -0.17%)
BAmean-50 syst-NUMA01_THREADLOCAL     7156.34 (   0.00%)     7267.28 (  -1.55%)
BAmean-50 elsp-NUMA01_THREADLOCAL       90.73 (   0.00%)       90.88 (  -0.17%)
BAmean-95 syst-NUMA01_THREADLOCAL     7156.34 (   0.00%)     7267.28 (  -1.55%)
BAmean-95 elsp-NUMA01_THREADLOCAL       90.73 (   0.00%)       90.88 (  -0.17%)
BAmean-99 syst-NUMA01_THREADLOCAL     7156.34 (   0.00%)     7267.28 (  -1.55%)
BAmean-99 elsp-NUMA01_THREADLOCAL       90.73 (   0.00%)       90.88 (  -0.17%)

delta of /sys/fs/cgroup/mytest/memory.stat during the test:
numa_pages_migrated: 0
numa_pte_updates:    9156154
numa_hint_faults:    8659673
numa_task_migrated:  282  <--- introduced in previous patch
numa_task_swaped:    114  <---- introduced in previous patch

More tests to come.

Suggested-by: Aubrey Li <aubrey.li@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 include/linux/numa.h           | 1 +
 include/uapi/linux/mempolicy.h | 1 +
 mm/memory.c                    | 2 +-
 mm/mempolicy.c                 | 7 +++++++
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/numa.h b/include/linux/numa.h
index 3567e40329eb..6c3f2d839c76 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -14,6 +14,7 @@
 
 #define	NUMA_NO_NODE	(-1)
 #define	NUMA_NO_MEMBLK	(-1)
+#define	NUMA_TASK_MIG	(1)
 
 static inline bool numa_valid_node(int nid)
 {
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 1f9bb10d1a47..2081365612ac 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -64,6 +64,7 @@ enum {
 #define MPOL_F_SHARED  (1 << 0)	/* identify shared policies */
 #define MPOL_F_MOF	(1 << 3) /* this policy wants migrate on fault */
 #define MPOL_F_MORON	(1 << 4) /* Migrate On protnone Reference On Node */
+#define MPOL_F_MOFT	(1 << 5) /* allow task but no page migrate on fault */
 
 /*
  * These bit locations are exposed in the vm.zone_reclaim_mode sysctl
diff --git a/mm/memory.c b/mm/memory.c
index 539c0f7c6d54..4013bbcbf40f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5683,7 +5683,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	target_nid = numa_migrate_check(folio, vmf, vmf->address, &flags,
 					writable, &last_cpupid);
-	if (target_nid == NUMA_NO_NODE)
+	if (target_nid == NUMA_NO_NODE || target_nid == NUMA_TASK_MIG)
 		goto out_map;
 	if (migrate_misplaced_folio_prepare(folio, vma, target_nid)) {
 		flags |= TNF_MIGRATE_FAIL;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index bbaadbeeb291..0b88601ec22d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1510,6 +1510,8 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	if (*flags & MPOL_F_NUMA_BALANCING) {
 		if (*mode == MPOL_BIND || *mode == MPOL_PREFERRED_MANY)
 			*flags |= (MPOL_F_MOF | MPOL_F_MORON);
+		else if (*mode == MPOL_INTERLEAVE)
+			*flags |= (MPOL_F_MOF | MPOL_F_MOFT);
 		else
 			return -EINVAL;
 	}
@@ -2779,6 +2781,11 @@ int mpol_misplaced(struct folio *folio, struct vm_fault *vmf,
 	if (!(pol->flags & MPOL_F_MOF))
 		goto out;
 
+	if (pol->flags & MPOL_F_MOFT) {
+		ret = NUMA_TASK_MIG;
+		goto out;
+	}
+
 	switch (pol->mode) {
 	case MPOL_INTERLEAVE:
 		polnid = interleave_nid(pol, ilx);
-- 
2.25.1


