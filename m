Return-Path: <cgroups+bounces-12549-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2DCCD287D
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 07:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1E6A30155EC
	for <lists+cgroups@lfdr.de>; Sat, 20 Dec 2025 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29772F4A0C;
	Sat, 20 Dec 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sgg33HC5"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93AB21D3CA
	for <cgroups@vger.kernel.org>; Sat, 20 Dec 2025 06:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766211035; cv=none; b=q7XiZjfjkCA+zIdw1g9LNt9traT5R1GRRaLVJrHOkwjyHWFxz1lTdzdYf2MqDc6ea+vaeHE+q5qD0q+kJWdgL/lCkrTUCcb5OHEr3aIxml6C0Uo6M8jZY59EhS/Ex6aSlJBwtO6us8QJyTKXR6vQDipaHs+JlXVSZrCvRQFP6lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766211035; c=relaxed/simple;
	bh=IfWhzw7KLgZuBcoFqV2MJtclut6bEbE3XIRw6NrubnI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Y3QdbQSsncpAk5AmKBHU4CGitXLoSFOGHL4nQsX3Wk/CGJ07Oh9DCbx1Ry6zidv/tFeZrCmQbjm0Lh0Id6bRtiHjIGDKKEy8QultnpxkTt61rwlvDsy67TPUO9ED6+QY8wcW85kOPiXottGAwa0UOp3RjrRlVxwZUDx812Qju9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sgg33HC5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b993eb2701bso2491057a12.0
        for <cgroups@vger.kernel.org>; Fri, 19 Dec 2025 22:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766211033; x=1766815833; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vKo946kZ9pVLWnQ/K49l7Ogi2e3nAydeRACLsVD0qOc=;
        b=sgg33HC5/RARiv+6sjocwiIO0vAtVJ8aRUyyT6whJVC/YGdnnu4KRnYhLqgJlahenQ
         K1xVlSjhaobj4xofoFf/79urCcxiFBfbzaZD5PspNNAPcaGUDydTEa35QvOF0hoJb/St
         U18QJdy+v15TLfVtHJ+AOrqBzi6JNapPcERpzgOCoV4VmTwNEVwIe/YQKhQ7slInZMto
         nxFRKlYcz7PW2TjIzPIrLrZmKoKz5kb7A8AOIywjylW3MYr2P4YRZqjy5bJ7RJc5S2qA
         aW53f2oOw1t9uHW3pWw4FeS/fWqtUB7xGM6DtfDgWZtzRvuDrfAqMM2WUHnHn/Qd7Evg
         vAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766211033; x=1766815833;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vKo946kZ9pVLWnQ/K49l7Ogi2e3nAydeRACLsVD0qOc=;
        b=C2rEPF3QGFd7D/KVwk5BsOtAnLL5SOHJnYkAxIcbJCA5QogpLdgtzu9iUmjYXjOaNG
         rqNcBrKx1d14jp2FXKVmrqBT7E9ITStp65Y2y8BUBU8J7pHAV/VgolgITikYASxeT2Az
         hwtsKhs7o7zQRzw8teS9JHo95pNz0TtnXZKISiBsWCD1C2Gx3T/EZuy2beby8OaKDZxM
         5E0mpJr73R8g1mrwTdMJQhqQwloiDLTWfGFd9be9d1pmBVWi2U5q+QLjZOwDCzWo+K9q
         8HfB+dLhTyPn2NcGyHZIS4xaZVP2IW9SwJf7/1lEp0UoID0qPUg2oPWRN2+bfBvcb1oB
         eFVg==
X-Forwarded-Encrypted: i=1; AJvYcCWmWf5+LxmJG8GVHzb+wIxze5LjbPD9Ioo6T8fG9+Bkb0i0pLwjpz407VVjtJDdSC2DTdN7FeRo@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcZ/YNG1qod0m09S7gakFR20lh8AH4AC62DXvQdmflzvZmDPt
	oNk93+8KjUIHm+5Ks+7XYdMQgWGUsdZ3SLj4cHZHLBiiK4+yU3grd+lbjVT6s+/P7IMxLL+ClvV
	49hEaOoPJGLUKXg==
X-Google-Smtp-Source: AGHT+IFmLXO2Pg/zpC2Amug9pMikW3Q50qrP5JzCe6kGGASDSQr5U1AbfMqmNd+xCK0M7dFx9SfgRLK7MSzAmw==
X-Received: from dlbps14.prod.google.com ([2002:a05:7023:88e:b0:11e:64d:cd3b])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ea50:b0:11b:65e:f2d with SMTP id a92af1059eb24-121722ab60amr4061084c88.10.1766211032987;
 Fri, 19 Dec 2025 22:10:32 -0800 (PST)
Date: Sat, 20 Dec 2025 06:10:21 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20251220061022.2726028-1-bingjiao@google.com>
Subject: [PATCH] mm/vmscan: respect mems_effective in demote_folio_list()
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: gourry@gourry.net, Bing Jiao <bingjiao@google.com>, 
	Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Tejun Heo <tj@kernel.org>, "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
introduces the cpuset.mems_effective check and applies it to
can_demote(). However, it does not apply this check in
demote_folio_list(), which leads to situations where pages are demoted
to nodes that are explicitly excluded from the task's cpuset.mems.

To address the issue that demotion targets do not respect
cpuset.mem_effective in demote_folio_list(), implement a new function
get_demotion_targets(), which returns a preferred demotion target
and all allowed (fallback) nodes against mems_effective,
and update demote_folio_list() and can_demote() accordingly to
use get_demotion_targets().

Furthermore, update some supporting functions:
  - Add a parameter for next_demotion_node() to return a copy of
    node_demotion[]->preferred, allowing get_demotion_targets()
    to select the next-best node for demotion.
  - Change the parameters for cpuset_node_allowed() and
    mem_cgroup_node_allowed() from nid to nodemask * to allow
    for direct logic-and operations with mems_effective.

Signed-off-by: Bing Jiao <bingjiao@google.com>
---
 include/linux/cpuset.h       |  5 +--
 include/linux/memcontrol.h   |  6 +--
 include/linux/memory-tiers.h |  6 +--
 kernel/cgroup/cpuset.c       | 14 +++----
 mm/memcontrol.c              |  5 ++-
 mm/memory-tiers.c            |  8 +++-
 mm/vmscan.c                  | 77 +++++++++++++++++++++++++++++-------
 7 files changed, 87 insertions(+), 34 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index a98d3330385c..27a0b6e9fb9d 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -174,7 +174,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }

-extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
+extern void cpuset_node_allowed(struct cgroup *cgroup, nodemask_t *nodes);
 #else /* !CONFIG_CPUSETS */

 static inline bool cpusets_enabled(void) { return false; }
@@ -301,9 +301,8 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }

-static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+static inline void cpuset_node_allowed(struct cgroup *cgroup, nodemask_t *nodes)
 {
-	return true;
 }
 #endif /* !CONFIG_CPUSETS */

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fd400082313a..a87f008b6600 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1740,7 +1740,7 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
+void mem_cgroup_node_allowed(struct mem_cgroup *memcg, nodemask_t *nodes);

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);

@@ -1811,9 +1811,9 @@ static inline ino_t page_cgroup_ino(struct page *page)
 	return 0;
 }

-static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+static inline void mem_cgroup_node_allowed(struct mem_cgroup *memcg,
+					   nodemask_t *nodes)
 {
-	return true;
 }

 static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 7a805796fcfd..2706ebfa94b5 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -53,11 +53,11 @@ struct memory_dev_type *mt_find_alloc_memory_type(int adist,
 						  struct list_head *memory_types);
 void mt_put_memory_types(struct list_head *memory_types);
 #ifdef CONFIG_MIGRATION
-int next_demotion_node(int node);
+int next_demotion_node(int node, nodemask_t *mask);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 bool node_is_toptier(int node);
 #else
-static inline int next_demotion_node(int node)
+static inline int next_demotion_node(int node, nodemask_t *mask)
 {
 	return NUMA_NO_NODE;
 }
@@ -101,7 +101,7 @@ static inline void clear_node_memory_type(int node, struct memory_dev_type *memt

 }

-static inline int next_demotion_node(int node)
+static inline int next_demotion_node(int node, nodemask_t *mask)
 {
 	return NUMA_NO_NODE;
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6e6eb09b8db6..2d78cfde5911 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4416,11 +4416,10 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	return allowed;
 }

-bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+void cpuset_node_allowed(struct cgroup *cgroup, nodemask_t *nodes)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *cs;
-	bool allowed;

 	/*
 	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
@@ -4428,16 +4427,16 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * so return true to avoid taking a global lock on the empty check.
 	 */
 	if (!cpuset_v2())
-		return true;
+		return;

 	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
 	if (!css)
-		return true;
+		return;

 	/*
 	 * Normally, accessing effective_mems would require the cpuset_mutex
-	 * or callback_lock - but node_isset is atomic and the reference
-	 * taken via cgroup_get_e_css is sufficient to protect css.
+	 * or callback_lock - but the reference taken via cgroup_get_e_css
+	 * is sufficient to protect css.
 	 *
 	 * Since this interface is intended for use by migration paths, we
 	 * relax locking here to avoid taking global locks - while accepting
@@ -4447,9 +4446,8 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * cannot make strong isolation guarantees, so this is acceptable.
 	 */
 	cs = container_of(css, struct cpuset, css);
-	allowed = node_isset(nid, cs->effective_mems);
+	nodes_and(*nodes, *nodes, cs->effective_mems);
 	css_put(css);
-	return allowed;
 }

 /**
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75fc22a33b28..a62c75b136ef 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5597,9 +5597,10 @@ subsys_initcall(mem_cgroup_swap_init);

 #endif /* CONFIG_SWAP */

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+void mem_cgroup_node_allowed(struct mem_cgroup *memcg, nodemask_t *nodes)
 {
-	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
+	if (memcg)
+		cpuset_node_allowed(memcg->css.cgroup, nodes);
 }

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 20aab9c19c5e..ed0ee9c3ae70 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -320,13 +320,14 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
+ * @mask: The preferred nodemask copy to be returned
  *
  * Return: node id for next memory node in the demotion path hierarchy
  * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
  * @node online or guarantee that it *continues* to be the next demotion
  * target.
  */
-int next_demotion_node(int node)
+int next_demotion_node(int node, nodemask_t *mask)
 {
 	struct demotion_nodes *nd;
 	int target;
@@ -355,7 +356,12 @@ int next_demotion_node(int node)
 	 * last target node. Or introducing per-cpu data to avoid
 	 * caching issue, which seems more complicated. So selecting
 	 * target node randomly seems better until now.
+	 *
+	 * Copy preferred nodes as the fallback if the returned one
+	 * does not satisify some constraints like cpuset.
 	 */
+	if (mask)
+		nodes_copy(*mask, nd->preferred);
 	target = node_random(&nd->preferred);
 	rcu_read_unlock();

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8bdb1629b6eb..2ddbf5584af8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -341,22 +341,71 @@ static void flush_reclaim_state(struct scan_control *sc)
 	}
 }

+/*
+ * Returns a preferred demotion node and all allowed demotion @targets.
+ * Returns NUMA_NO_NODE and @targets is meaningless if no allowed nodes.
+ */
+static int get_demotion_targets(nodemask_t *targets, struct pglist_data *pgdat,
+				struct mem_cgroup *memcg)
+{
+	nodemask_t allowed_mask;
+	nodemask_t preferred_mask;
+	int preferred_node;
+
+	if (!pgdat)
+		return NUMA_NO_NODE;
+
+	preferred_node = next_demotion_node(pgdat->node_id, &preferred_mask);
+	if (preferred_node == NUMA_NO_NODE)
+		return NUMA_NO_NODE;
+
+	node_get_allowed_targets(pgdat, &allowed_mask);
+	mem_cgroup_node_allowed(memcg, &allowed_mask);
+	if (nodes_empty(allowed_mask))
+		return NUMA_NO_NODE;
+
+	if (targets)
+		nodes_copy(*targets, allowed_mask);
+
+	do {
+		if (node_isset(preferred_node, allowed_mask))
+			return preferred_node;
+
+		nodes_and(preferred_mask, preferred_mask, allowed_mask);
+		if (!nodes_empty(preferred_mask))
+			return node_random(&preferred_mask);
+
+		/*
+		 * Hop to the next tier of preferred nodes. Even if
+		 * preferred_node is not set in allowed_mask, still can use it
+		 * to query the nest-best demotion nodes.
+		 */
+		preferred_node = next_demotion_node(preferred_node,
+						    &preferred_mask);
+	} while (preferred_node != NUMA_NO_NODE);
+
+	/*
+	 * Should not reach here, as a non-empty allowed_mask ensures
+	 * there must have a target node for demotion.
+	 * Otherwise, it suggests something wrong in node_demotion[]->preferred,
+	 * where the same-tier nodes have different preferred targets.
+	 * E.g., if node 0 identifies both nodes 2 and 3 as preferred targets,
+	 * but nodes 2 and 3 themselves have different preferred nodes.
+	 */
+	WARN_ON_ONCE(1);
+	return node_random(&allowed_mask);
+}
+
 static bool can_demote(int nid, struct scan_control *sc,
 		       struct mem_cgroup *memcg)
 {
-	int demotion_nid;
-
 	if (!numa_demotion_enabled)
 		return false;
 	if (sc && sc->no_demotion)
 		return false;

-	demotion_nid = next_demotion_node(nid);
-	if (demotion_nid == NUMA_NO_NODE)
-		return false;
-
-	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	return mem_cgroup_node_allowed(memcg, demotion_nid);
+	return get_demotion_targets(NULL, NODE_DATA(nid), memcg) !=
+	       NUMA_NO_NODE;
 }

 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
@@ -1019,9 +1068,10 @@ static struct folio *alloc_demote_folio(struct folio *src,
  * Folios which are not demoted are left on @demote_folios.
  */
 static unsigned int demote_folio_list(struct list_head *demote_folios,
-				     struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      struct mem_cgroup *memcg)
 {
-	int target_nid = next_demotion_node(pgdat->node_id);
+	int target_nid;
 	unsigned int nr_succeeded;
 	nodemask_t allowed_mask;

@@ -1033,7 +1083,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		 */
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
 			__GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = target_nid,
 		.nmask = &allowed_mask,
 		.reason = MR_DEMOTION,
 	};
@@ -1041,10 +1090,10 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (list_empty(demote_folios))
 		return 0;

+	target_nid = get_demotion_targets(&allowed_mask, pgdat, memcg);
 	if (target_nid == NUMA_NO_NODE)
 		return 0;
-
-	node_get_allowed_targets(pgdat, &allowed_mask);
+	mtc.nid = target_nid;

 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
@@ -1566,7 +1615,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */

 	/* Migrate folios selected for demotion */
-	nr_demoted = demote_folio_list(&demote_folios, pgdat);
+	nr_demoted = demote_folio_list(&demote_folios, pgdat, memcg);
 	nr_reclaimed += nr_demoted;
 	stat->nr_demoted += nr_demoted;
 	/* Folios that could not be demoted are still in @demote_folios */
--
2.52.0.351.gbe84eed79e-goog


