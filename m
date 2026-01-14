Return-Path: <cgroups+bounces-13223-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 152A5D213B3
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 21:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5914F3044BA8
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 20:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC75357A22;
	Wed, 14 Jan 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WgHwFUEX"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F309F357733
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 20:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423990; cv=none; b=h6wD8x6hdUovs6JkniebDjI/97Xb0rj7ttxmvGhunycrX0Y2U/x5Ly3IO8jgkwUDXRTGEcOf0TvPt1YyctKXP488DV5KiNw7EZL8y4ZkNGp0EWxT4/+M/kiubeTuLr2cdBJYrsg7GICndt0o1aLGdKWTQFcaI6S4An4EzVVTs0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423990; c=relaxed/simple;
	bh=/rBZx0YB0gt6V8TOLopN22zzR/+Lt5sTM5XFhgihwvY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I4F0/GtAwEk7EhdY+YAey/U+zlwu4pAL/pJhNCQlYQMbiEKbf4kWf8eWOQzWd4Sra1yNdzaMkX5HPN0kJMv2j8Oq2fcvM6Zz7nZzALXuDPojG9e6gW//vhZh0ofB7djDKMd0pQu5AYByzspcVjwQhTfN8Qe/RYukBv8aak6AzUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WgHwFUEX; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-11b94abc09dso342452c88.1
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 12:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768423988; x=1769028788; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rx4GaMs2Q/4qfts+N5AuEA3y8Pe+7VCYzOqGGqst5P0=;
        b=WgHwFUEXpQX7FR30gL+uIhWZe6EF0Uj92v5+OaPp+1un5QQHufWwXwhd0Xr13cQXlN
         /HPqIqBpm9WwAggv4de/MP4vpu8tuPWqfpblsEGtosKOwlkM1SQ9lafSRoSYpLm++043
         EPaPRVaAYVgLFO+AjNHua5aif5a29q1qlJ0sNiasJmyPPEmRjIPf/7ptjddX1GC/TBvu
         A/ja9WvNS7itWAjQ/EdmJ7Q8F7EIlkx+hsuJipZ3wQmRdxOlBp23kc7AxVXMibpeVJed
         EG9P4WvPOXHKCUT9w+ZpFCbRn1FGFc4rB/WCz8JeOViEdAgwTCivIcJ6nYmZbycvEJ5k
         tayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768423988; x=1769028788;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rx4GaMs2Q/4qfts+N5AuEA3y8Pe+7VCYzOqGGqst5P0=;
        b=CK7RLxdxmxLlMBI8puJd9UP5Be8GfcvygvQ9347XDhko8i70yc23nK8sLENXTYRdwZ
         6Gb8XkXS1vIlCrdc7crKzzg3d7vSJ5aYiP1Cy0ckkvTqdHff7tEW1+MvpOheU47Ai3Wn
         UgVOf7PaIHKFcxeTpzZrrTQGenCBIKeN6cO7aCDGXG3Y2i3ijsOzaW0p+emoZ6PP4d57
         vvdX2Ufid1oh5BigoN9D67iczmPiCUC3QLiT/5yBQONFh3ckjj+ai8CNnElFS6ZoIsGh
         GXI6qA4jqRDfpORgyD7qMmE+mKjKuQPVhKOH2Bo06p1vbY/cSGRG5nWpp318FdoZ1BYM
         frtw==
X-Forwarded-Encrypted: i=1; AJvYcCVQOPdE2QgGfBoTHV5ieyOxkNTva19vvksx4wzCJMJNl6QDfft8mkaFO3L6+S/4l1N26WgYe8JZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzyogyiAAJoHjB5XDAJAZzAqhGjT1INynn96jh/tKvo2rtpyV
	74hkctrKJfl02ieLSjT9lGs2Opn+0tk8eCysj5LAYNOwMW0rRzkFFGUHio2438uXPSgspDvttn/
	m13priF9ecJxWcA==
X-Received: from dlbtu14.prod.google.com ([2002:a05:7022:3c0e:b0:11f:30f6:ea10])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:418b:b0:11f:2c69:31 with SMTP id a92af1059eb24-123377660bfmr4150749c88.46.1768423988024;
 Wed, 14 Jan 2026 12:53:08 -0800 (PST)
Date: Wed, 14 Jan 2026 20:53:02 +0000
In-Reply-To: <20260114205305.2869796-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260114070053.2446770-1-bingjiao@google.com> <20260114205305.2869796-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260114205305.2869796-2-bingjiao@google.com>
Subject: [PATCH v9 1/2] mm/vmscan: fix demotion targets checks in reclaim/demotion
From: Bing Jiao <bingjiao@google.com>
To: bingjiao@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Gregory Price <gourry@gourry.net>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	tj@kernel.org, longman@redhat.com, chenridong@huaweicloud.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fix two bugs in demote_folio_list() and can_demote() due to incorrect
demotion target checks against cpuset.mems_effective in reclaim/demotion.

Commit 7d709f49babc ("vmscan,cgroup: apply mems_effective to reclaim")
introduces the cpuset.mems_effective check and applies it to can_demote().
However:

  1. It does not apply this check in demote_folio_list(), which leads
     to situations where pages are demoted to nodes that are
     explicitly excluded from the task's cpuset.mems.

  2. It checks only the nodes in the immediate next demotion hierarchy
     and does not check all allowed demotion targets in can_demote().
     This can cause pages to never be demoted if the nodes in the next
     demotion hierarchy are not set in mems_effective.

These bugs break resource isolation provided by cpuset.mems.  This is
visible from userspace because pages can either fail to be demoted
entirely or are demoted to nodes that are not allowed in multi-tier memory
systems.

To address these bugs, update cpuset_node_allowed() and
mem_cgroup_node_allowed() to return effective_mems, allowing directly
logic-and operation against demotion targets.  Also update can_demote()
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
Signed-off-by: Bing Jiao <bingjiao@google.com>
Cc: <stable@vger.kernel.org>
---
v7 -> v9:
Minor updates in demote_folio_list() for better code logic.

 include/linux/cpuset.h     |  6 ++---
 include/linux/memcontrol.h |  6 ++---
 kernel/cgroup/cpuset.c     | 54 +++++++++++++++++++++++++-------------
 mm/memcontrol.c            | 16 +++++++++--
 mm/vmscan.c                | 34 +++++++++++++++---------
 5 files changed, 78 insertions(+), 38 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index a98d3330385c..631577384677 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -174,7 +174,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }

-extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
+extern void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask);
 #else /* !CONFIG_CPUSETS */

 static inline bool cpusets_enabled(void) { return false; }
@@ -301,9 +301,9 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }

-static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+static inline void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
 {
-	return true;
+	nodes_copy(*mask, node_states[N_MEMORY]);
 }
 #endif /* !CONFIG_CPUSETS */

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0651865a4564..412db7663357 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1744,7 +1744,7 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
+void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask);

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);

@@ -1815,9 +1815,9 @@ static inline ino_t page_cgroup_ino(struct page *page)
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
index 6e6eb09b8db6..289fb1a72550 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4416,40 +4416,58 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	return allowed;
 }

-bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+/**
+ * cpuset_nodes_allowed - return effective_mems mask from a cgroup cpuset.
+ * @cgroup: pointer to struct cgroup.
+ * @mask: pointer to struct nodemask_t to be returned.
+ *
+ * Returns effective_mems mask from a cgroup cpuset if it is cgroup v2 and
+ * has cpuset subsys. Otherwise, returns node_states[N_MEMORY].
+ *
+ * This function intentionally avoids taking the cpuset_mutex or callback_lock
+ * when accessing effective_mems. This is because the obtained effective_mems
+ * is stale immediately after the query anyway (e.g., effective_mems is updated
+ * immediately after releasing the lock but before returning).
+ *
+ * As a result, returned @mask may be empty because cs->effective_mems can be
+ * rebound during this call. Besides, nodes in @mask are not guaranteed to be
+ * online due to hot plugins. Callers should check the mask for validity on
+ * return based on its subsequent use.
+ **/
+void cpuset_nodes_allowed(struct cgroup *cgroup, nodemask_t *mask)
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
+	if (!cgroup || !cpuset_v2()) {
+		nodes_copy(*mask, node_states[N_MEMORY]);
+		return;
+	}

 	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
-	if (!css)
-		return true;
+	if (!css) {
+		nodes_copy(*mask, node_states[N_MEMORY]);
+		return;
+	}

 	/*
-	 * Normally, accessing effective_mems would require the cpuset_mutex
-	 * or callback_lock - but node_isset is atomic and the reference
-	 * taken via cgroup_get_e_css is sufficient to protect css.
-	 *
-	 * Since this interface is intended for use by migration paths, we
-	 * relax locking here to avoid taking global locks - while accepting
-	 * there may be rare scenarios where the result may be innaccurate.
+	 * The reference taken via cgroup_get_e_css is sufficient to
+	 * protect css, but it does not imply safe accesses to effective_mems.
 	 *
-	 * Reclaim and migration are subject to these same race conditions, and
-	 * cannot make strong isolation guarantees, so this is acceptable.
+	 * Normally, accessing effective_mems would require the cpuset_mutex
+	 * or callback_lock - but the correctness of this information is stale
+	 * immediately after the query anyway. We do not acquire the lock
+	 * during this process to save lock contention in exchange for racing
+	 * against mems_allowed rebinds.
 	 */
 	cs = container_of(css, struct cpuset, css);
-	allowed = node_isset(nid, cs->effective_mems);
+	nodes_copy(*mask, cs->effective_mems);
 	css_put(css);
-	return allowed;
 }

 /**
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 86f43b7e5f71..702c3db624a0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5624,9 +5624,21 @@ subsys_initcall(mem_cgroup_swap_init);

 #endif /* CONFIG_SWAP */

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+void mem_cgroup_node_filter_allowed(struct mem_cgroup *memcg, nodemask_t *mask)
 {
-	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
+	nodemask_t allowed;
+
+	if (!memcg)
+		return;
+
+	/*
+	 * Since this interface is intended for use by migration paths, and
+	 * reclaim and migration are subject to race conditions such as changes
+	 * in effective_mems and hot-unpluging of nodes, inaccurate allowed
+	 * mask is acceptable.
+	 */
+	cpuset_nodes_allowed(memcg->css.cgroup, &allowed);
+	nodes_and(*mask, *mask, allowed);
 }

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 670fe9fae5ba..5ea1dd2b8cce 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -344,19 +344,21 @@ static void flush_reclaim_state(struct scan_control *sc)
 static bool can_demote(int nid, struct scan_control *sc,
 		       struct mem_cgroup *memcg)
 {
-	int demotion_nid;
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
 		return false;

-	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	return mem_cgroup_node_allowed(memcg, demotion_nid);
+	/* Filter out nodes that are not in cgroup's mems_allowed. */
+	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
+	return !nodes_empty(allowed_mask);
 }

 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
@@ -1019,9 +1021,10 @@ static struct folio *alloc_demote_folio(struct folio *src,
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

@@ -1033,7 +1036,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		 */
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
 			__GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = target_nid,
 		.nmask = &allowed_mask,
 		.reason = MR_DEMOTION,
 	};
@@ -1041,10 +1043,18 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (list_empty(demote_folios))
 		return 0;

-	if (target_nid == NUMA_NO_NODE)
+	node_get_allowed_targets(pgdat, &allowed_mask);
+	mem_cgroup_node_filter_allowed(memcg, &allowed_mask);
+	if (nodes_empty(allowed_mask))
 		return 0;

-	node_get_allowed_targets(pgdat, &allowed_mask);
+	target_nid = next_demotion_node(pgdat->node_id);
+	if (target_nid == NUMA_NO_NODE)
+		/* No lower-tier nodes or nodes were hot-unplugged. */
+		return 0;
+	if (!node_isset(target_nid, allowed_mask))
+		target_nid = node_random(&allowed_mask);
+	mtc.nid = target_nid;

 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
@@ -1566,7 +1576,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */

 	/* Migrate folios selected for demotion */
-	nr_demoted = demote_folio_list(&demote_folios, pgdat);
+	nr_demoted = demote_folio_list(&demote_folios, pgdat, memcg);
 	nr_reclaimed += nr_demoted;
 	stat->nr_demoted += nr_demoted;
 	/* Folios that could not be demoted are still in @demote_folios */
--
2.52.0.457.g6b5491de43-goog


