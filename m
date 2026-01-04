Return-Path: <cgroups+bounces-12888-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CB4CF0C5A
	for <lists+cgroups@lfdr.de>; Sun, 04 Jan 2026 09:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7AC9300F310
	for <lists+cgroups@lfdr.de>; Sun,  4 Jan 2026 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C92B279792;
	Sun,  4 Jan 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eas3CMK9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF07F275AFD
	for <cgroups@vger.kernel.org>; Sun,  4 Jan 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767516883; cv=none; b=OgnphbkAthKQSaJ4SbGXgRxnluVlTl/RrVpRW4D/CpYOpue538wDglW2H8mQIrX+oS80Rzmczj6ycwB+0ozXOo9fUTKMDznFPPrQGeuSQKtZkYVibFE2BUg1or9PIDBEL/xNoIqhpVa07s8FyuVjLl9NUKZllPqso+RjabzLjZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767516883; c=relaxed/simple;
	bh=f2sLCcb9RyE1po0dKUyLcsrgCF3v01QGNQgcKfzcvLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WyyF9oKa6q+xTbxFOmIHepJhs80Me6e5qC6aMGqYKgeaXgNcj90GzHu/lzjqJfMSeciIbrhfdmbzAI8xtVJn0BLndeRmeGPYS2GUTMpow2Qe6OR6WkAahKQfzC5Qsh3BFRxZiP5H0UHenoM9Tp1YFl//hbHGHVi9eS2LoigcL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eas3CMK9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a0bb1192cbso270746845ad.1
        for <cgroups@vger.kernel.org>; Sun, 04 Jan 2026 00:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767516881; x=1768121681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y8elJMWPjMs0XkG/FEkWBkLMbCQyfYnBpuHl89Qv1Qc=;
        b=Eas3CMK971FUESAPnmV3bDCkHbtPZ01WhPtt6mTckS7op+6NP1LvX+4SP1Ymt9mWJu
         HUYifuNKQ6Q4adOR0Kifxgs+WT0U10qjloauPEdzWVatmcudE7O53gCeQzfwJ/7kfvsx
         AitTI6EKIEJBeDuWbe7mkkkix5nIj1eXsBhThxRtLDDFUSFtbpUaaZgA547oDVFt2zSX
         V9+JUqfq2EjR3VvX+R3yMVNBEyH5wgkvA4PD8BSWMl5i30nQyIWRs7TAkeUbo2UQMw2l
         Rn/qJEORkPDHTiaHPP2FL8SjD0YBC7/aK1XoG8rffZ77dUJaCHBBsm7sR80UHAFxj2aH
         vguw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767516881; x=1768121681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8elJMWPjMs0XkG/FEkWBkLMbCQyfYnBpuHl89Qv1Qc=;
        b=L2YCLij92RRJAXMUshP6+XJi0JYZEl326J7Hwu+UCVcmxK5d0Qoey1X85A4RiUiG1m
         ano7f5ArPne31gsEcSEgsSxG9hyI9uQgoDF3zoQCThTOvB4/DyejIkivWpMpzFGNPgzz
         12fDO20fTifRgD8sgHEBGWT4FEj4al1vEHdH9QuEzPj4ANpfXK3PVYB5+rv/ML/n0SVH
         1cjblqSiIDQCMB2t1R5DlxYg/xj97DmixZh9e2GEJ+F9y+tEPurpEsgvjQ++GPjcqAVt
         HHvC/qH3f39YjZ0qntIeOxvmzH2z7pEf+DU2C2Tblat+si59ML3uM3zwtpT1OnLLURuF
         KRKg==
X-Forwarded-Encrypted: i=1; AJvYcCUlSvCnNsReoEJocKWxzi0YhTX141sKDrpXniETTVmyYR488RfMlaSziAqnV+wtIALtpWCZscSd@vger.kernel.org
X-Gm-Message-State: AOJu0YyrM2seOq0CWMr1j40rDONw/MiTp9j1XSQHqYkv4juz9+owFZK8
	QfwZ2xhwC/0HodoJ2T4Plh2FVQx9rorfSm7PHUE0sRMrNUu6KiEip4WgynThYw0F0b7wdiY890R
	NrIog+5rCyT3ZzQ==
X-Google-Smtp-Source: AGHT+IFkkIq48VPz0jCSFUEY3kHRMnJcthmvmoml7S8VPslj3aDivZGf4nrCSTp69Tv0P+luUh/xpxWXxsZCKw==
X-Received: from dlaj14.prod.google.com ([2002:a05:701b:280e:b0:11f:464f:4c69])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:258d:b0:11d:f464:5c97 with SMTP id a92af1059eb24-1217230621bmr41689090c88.39.1767516880809;
 Sun, 04 Jan 2026 00:54:40 -0800 (PST)
Date: Sun,  4 Jan 2026 08:54:05 +0000
In-Reply-To: <20251223212032.665731-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251223212032.665731-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
Message-ID: <20260104085439.4076810-1-bingjiao@google.com>
Subject: [PATCH v4] mm/vmscan: fix demotion targets checks in reclaim/demotion
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, gourry@gourry.net, 
	longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com, 
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com, 
	cgroups@vger.kernel.org, bingjiao@google.com
Content-Type: text/plain; charset="UTF-8"

Fix two bugs in demote_folio_list() and can_demote() due to incorrect
demotion target checks in reclaim/demotion.

Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
introduces the cpuset.mems_effective check and applies it to
can_demote(). However:

  1. It does not apply this check in demote_folio_list(), which leads
     to situations where pages are demoted to nodes that are
     explicitly excluded from the task's cpuset.mems.

  2. It checks only the nodes in the immediate next demotion hierarchy
     and does not check all allowed demotion targets in can_demote().
     This can cause pages to never be demoted if the nodes in the next
     demotion hierarchy are not set in mems_effective.

These bugs break resource isolation provided by cpuset.mems.
This is visible from userspace because pages can either fail to be
demoted entirely or are demoted to nodes that are not allowed
in multi-tier memory systems.

To address these bugs, update cpuset_node_allowed() and
mem_cgroup_node_allowed() to return effective_mems, allowing directly
logic-and operation against demotion targets. Also update can_demote()
and demote_folio_list() accordingly.

Bug 1 reproduction:
  Assume a system with 4 nodes, where nodes 0-1 are top-tier and
  nodes 2-3 are far-tier memory. All nodes have equal capacity.

  Test script:
    echo 1 > /sys/kernel/mm/numa/demotion_enabled
    mkdir /sys/fs/cgroup/test
    echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
    echo "0-2" > /sys/fs/cgroup/test/cpuset.mems
    echo $$ > /sys/fs/cgroup/test/cgroup.procs
    swapoff -a
    # Expectation: Should respect node 0-2 limit.
    # Observation: Node 3 shows significant allocation (MemFree drops)
    stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1

Bug 2 reproduction:
  Assume a system with 6 nodes, where nodes 0-2 are top-tier,
  node 3 is a far-tier node, and nodes 4-5 are the farthest-tier nodes.
  All nodes have equal capacity.

  Test script:
    echo 1 > /sys/kernel/mm/numa/demotion_enabled
    mkdir /sys/fs/cgroup/test
    echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
    echo "0-2,4-5" > /sys/fs/cgroup/test/cpuset.mems
    echo $$ > /sys/fs/cgroup/test/cgroup.procs
    swapoff -a
    # Expectation: Pages are demoted to Nodes 4-5
    # Observation: No pages are demoted before oom.
    stress-ng --oomable --vm 1 --vm-bytes 150% --mbind 0,1,2

Fixes: 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bing Jiao <bingjiao@google.com>

---
v3 -> v4:
Update functions to filter out nodes that are not in cgroup's
mems_allowed rather than returning mems_allowed directly.
It minimizes stack usage and remains versatile enough to return
mems_allowed when all possible nodes are set in the passed
nodemask_t pointer.
---

 include/linux/cpuset.h     |  7 ++++---
 include/linux/memcontrol.h |  6 +++---
 kernel/cgroup/cpuset.c     | 24 +++++++++++++++---------
 mm/memcontrol.c            |  5 +++--
 mm/vmscan.c                | 32 +++++++++++++++++++++-----------
 5 files changed, 46 insertions(+), 28 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index a98d3330385c..c937537f318a 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -174,7 +174,8 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }

-extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
+extern void cpuset_nodes_filter_allowed(struct cgroup *cgroup,
+					nodemask_t *mask);
 #else /* !CONFIG_CPUSETS */

 static inline bool cpusets_enabled(void) { return false; }
@@ -301,9 +302,9 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }

-static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+static inline void cpuset_nodes_filter_allowed(struct cgroup *cgroup,
+					       nodemask_t *mask)
 {
-	return true;
 }
 #endif /* !CONFIG_CPUSETS */

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fd400082313a..911e0c71453e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1740,7 +1740,7 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
+void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask);

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);

@@ -1811,9 +1811,9 @@ static inline ino_t page_cgroup_ino(struct page *page)
 	return 0;
 }

-static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+static inline void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg,
+						  nodemask_t *mask)
 {
-	return true;
 }

 static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6e6eb09b8db6..cc0e1d42611c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4416,27 +4416,34 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	return allowed;
 }

-bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+/**
+ * cpuset_nodes_filter_allowed - filter out nodes not in cgroup's mems_allowed.
+ * @cgroup: pointer to struct cgroup.
+ * @mask: pointer to struct nodemask_t to be filtered.
+ *
+ * Description: Filters out nodes that are not in mems_allowed for @cgroup.
+ * Nodes returned in @mask are not guaranteed to be online.
+ **/
+void cpuset_nodes_filter_allowed(struct cgroup *cgroup, nodemask_t *mask)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	bool allowed;

 	/*
 	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
 	 * and mems_allowed is likely to be empty even if we could get to it,
-	 * so return true to avoid taking a global lock on the empty check.
+	 * so return directly to avoid taking a global lock on the empty check.
 	 */
-	if (!cpuset_v2())
-		return true;
+	if (!cgroup || !cpuset_v2())
+		return;

 	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
 	if (!css)
-		return true;
+		return;

 	/*
 	 * Normally, accessing effective_mems would require the cpuset_mutex
-	 * or callback_lock - but node_isset is atomic and the reference
+	 * or callback_lock - but not doing so is acceptable and the reference
 	 * taken via cgroup_get_e_css is sufficient to protect css.
 	 *
 	 * Since this interface is intended for use by migration paths, we
@@ -4447,9 +4454,8 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * cannot make strong isolation guarantees, so this is acceptable.
 	 */
 	cs = container_of(css, struct cpuset, css);
-	allowed = node_isset(nid, cs->effective_mems);
+	nodes_and(*mask, *mask, cs->effective_mems);
 	css_put(css);
-	return allowed;
 }

 /**
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75fc22a33b28..4c850805b7a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5597,9 +5597,10 @@ subsys_initcall(mem_cgroup_swap_init);

 #endif /* CONFIG_SWAP */

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
 {
-	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
+	if (memcg)
+		cpuset_nodes_filter_allowed(memcg->css.cgroup, mask);
 }

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index ac16b6b984ab..919e116ddaf3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -345,18 +345,24 @@ static bool can_demote(int nid, struct scan_control *sc,
 		       struct mem_cgroup *memcg)
 {
 	int demotion_nid;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	nodemask_t allowed_mask;

-	if (!numa_demotion_enabled)
+	if (!pgdat || !numa_demotion_enabled)
 		return false;
 	if (sc && sc->no_demotion)
 		return false;

-	demotion_nid = next_demotion_node(nid);
-	if (demotion_nid == NUMA_NO_NODE)
+	node_get_allowed_targets(pgdat, &allowed_mask);
+	if (nodes_empty(allowed_mask))
+		return false;
+
+	/* Filter out nodes that are not in cgroup's mems_allowed. */
+	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
+	if (nodes_empty(allowed_mask))
 		return false;

-	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	if (mem_cgroup_node_allowed(memcg, demotion_nid)) {
+	for_each_node_mask(demotion_nid, allowed_mask) {
 		int z;
 		struct zone *zone;
 		struct pglist_data *pgdat = NODE_DATA(demotion_nid);
@@ -1029,7 +1035,8 @@ static struct folio *alloc_demote_folio(struct folio *src,
  * Folios which are not demoted are left on @demote_folios.
  */
 static unsigned int demote_folio_list(struct list_head *demote_folios,
-				     struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      struct mem_cgroup *memcg)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
@@ -1043,7 +1050,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		 */
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
 			__GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = target_nid,
 		.nmask = &allowed_mask,
 		.reason = MR_DEMOTION,
 	};
@@ -1051,10 +1057,14 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (list_empty(demote_folios))
 		return 0;

-	if (target_nid == NUMA_NO_NODE)
-		return 0;
-
 	node_get_allowed_targets(pgdat, &allowed_mask);
+	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
+	if (nodes_empty(allowed_mask))
+		return false;
+
+	if (!node_isset(target_nid, allowed_mask))
+		target_nid = node_random(&allowed_mask);
+	mtc.nid = target_nid;

 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
@@ -1576,7 +1586,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */

 	/* Migrate folios selected for demotion */
-	nr_demoted = demote_folio_list(&demote_folios, pgdat);
+	nr_demoted = demote_folio_list(&demote_folios, pgdat, memcg);
 	nr_reclaimed += nr_demoted;
 	stat->nr_demoted += nr_demoted;
 	/* Folios that could not be demoted are still in @demote_folios */
--
2.52.0.358.g0dd7633a29-goog


