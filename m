Return-Path: <cgroups+bounces-12617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 851DFCDAAB4
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 22:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9AA300D42B
	for <lists+cgroups@lfdr.de>; Tue, 23 Dec 2025 21:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21CC3115B1;
	Tue, 23 Dec 2025 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ajLM4n7Q"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97A29D26D
	for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766524836; cv=none; b=N7NWizp85A4B2E+4PLc0Cm0efNNoFQPlqBJU78tH9cjSblH60/XNgXZp+iz2nBtEz+Y7LlUzC1hNLbwCck1I6KpTnOFUhRTawIJmdG9ULcL0j37wF2ICjHkjKH2nb40Rkapkfk/Q76WTJb5ZKqEEYiOqeyeFX7nhMMN0eymnAyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766524836; c=relaxed/simple;
	bh=DoZhKRfKFmI1qo5NVDRpPpGkB69QPB99mmMeA/ldaCY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zp8aYK9Kgpll4PpAYtPoaXewpo1gWQSehsOieAQQLc28uA8IqV8eqAyaga33qtp0IJtBV93mEDZbGRxPC9hRMlq8yyZ9BG4/iWWZzycC7KoqHILZLnFlsJgSYJ7Kn0H6xJvy/Q16+hOX5PmIhkZOapTQ4rTWnjWxTFOm5Cqld2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ajLM4n7Q; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bingjiao.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c0c7e0a8ac1so8027599a12.0
        for <cgroups@vger.kernel.org>; Tue, 23 Dec 2025 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766524834; x=1767129634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lYfxavFypXvQWKTZ6bRnNlNx9q/hbXcZzoHeTM07X9Y=;
        b=ajLM4n7QPdmbTAWy9psXjGwWv843+BHYM3clXEWINxLcZcQsnpyJyW4c1KKhxOcfMs
         YqpyOFcC4Ti254Uxjhtc4p+UKLOs5C/ksScc7l+Mh/0NdYj8NT1+z5VUH7xSv41qLR8k
         y1GdpAHtzSSsXRWiypF7Ls0Ccr3AlGC5foDy1CDMGOjBh9dF4Q7bsw2nkl6xelVK2NMw
         UuWFrQUb6Sa2Lj3EmhgEAyiIVQwq05dqCOq5biQbdCZ7udkTaOWpj8DMeJ1KsDmnhaD4
         kPoVPxsVRrtuOrwfxlMy8HluyS+CjJynBQIZwokmsxELruy1JGxuCXfkkN6hTM8DL6T1
         VDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766524834; x=1767129634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYfxavFypXvQWKTZ6bRnNlNx9q/hbXcZzoHeTM07X9Y=;
        b=rKAtoYkt+tqLXDJadY31Q/VVBmFNjhRVJbND3IzuHRHaGUGf0Hps7pzz+nQn0QgSMZ
         mpe9ZmxM1Iax4hILPJNLBGDQ0GBWFUNcDBprYVuGNepN63cgk871BrsAPk91n7o/kgQ2
         w61KGmFXN2DqJnmMkJdgegpVsEII6eiVUgymyZqes0u9OqXmRt9kVgH9WUVlmTCA0N7f
         bgn2ysxrSJrrM7EER+5vv74tRSOKK0hySZkst7NWSpVxsJ6D+zD4EQTc4HpEjo4dNk9O
         QCQBcofMVxwrTeUfr52hqLlRxx9pXTJLSP1y1aEZ0eKKmkMjsnA5w5bsS6jknb/XXQRw
         CCaw==
X-Forwarded-Encrypted: i=1; AJvYcCWlCyxWk4iAvsQd5U/7E8fOA38Q5cXgFgH3kSUgN361HZ6Y44nqIbw8abLFaVwYoxsLbcuT+3hn@vger.kernel.org
X-Gm-Message-State: AOJu0YxSvsUKVQbHkr09i6cUIArgMffBh8uUYka1KUjsTAyVcvmIO0oV
	Php5ziYWilTKybNqCxn2uiPDJoE2NFD/VsTKUuua8uv4pljbCLny9saGgLbAbOptKBm9gIo7fyE
	EmCGQZ+sFpHnBiQ==
X-Google-Smtp-Source: AGHT+IGXR/gpiuAps+7fq4OauW9eemy4cSM5YIpNWsP7dLBZO0ns7cPZXMjmRfT48tgS6uiqxUjYwDaT0P2F6A==
X-Received: from dlqq20.prod.google.com ([2002:a05:7022:6394:b0:11d:cf7a:5407])
 (user=bingjiao job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:2520:b0:11d:c04a:dc5b with SMTP id a92af1059eb24-121722e03camr15593882c88.30.1766524833960;
 Tue, 23 Dec 2025 13:20:33 -0800 (PST)
Date: Tue, 23 Dec 2025 21:19:59 +0000
In-Reply-To: <20251221233635.3761887-1-bingjiao@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251221233635.3761887-1-bingjiao@google.com>
X-Mailer: git-send-email 2.52.0.358.g0dd7633a29-goog
Message-ID: <20251223212032.665731-1-bingjiao@google.com>
Subject: [PATCH v3] mm/vmscan: fix demotion targets checks in reclaim/demotion
From: Bing Jiao <bingjiao@google.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, gourry@gourry.net, 
	longman@redhat.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	tj@kernel.org, mkoutny@suse.com, david@kernel.org, zhengqi.arch@bytedance.com, 
	lorenzo.stoakes@oracle.com, axelrasmussen@google.com, 
	chenridong@huaweicloud.com, yuanchu@google.com, weixugc@google.com, 
	cgroups@vger.kernel.org
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

Reproduct Bug 1:
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

Reproduct Bug 2:
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
 include/linux/cpuset.h     |  6 +++---
 include/linux/memcontrol.h |  6 +++---
 kernel/cgroup/cpuset.c     | 16 ++++++++--------
 mm/memcontrol.c            |  6 ++++--
 mm/vmscan.c                | 35 +++++++++++++++++++++++------------
 5 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index a98d3330385c..eb358c3aa9c0 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -174,7 +174,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }

-extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
+extern nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup);
 #else /* !CONFIG_CPUSETS */

 static inline bool cpusets_enabled(void) { return false; }
@@ -301,9 +301,9 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }

-static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+static inline nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup)
 {
-	return true;
+	return node_possible_map;
 }
 #endif /* !CONFIG_CPUSETS */

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fd400082313a..f9463d853bba 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1740,7 +1740,7 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
+nodemask_t mem_cgroup_node_get_allowed(struct mem_cgroup *memcg);

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);

@@ -1811,9 +1811,9 @@ static inline ino_t page_cgroup_ino(struct page *page)
 	return 0;
 }

-static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+static inline nodemask_t mem_cgroup_node_get_allowed(struct mem_cgroup *memcg)
 {
-	return true;
+	return node_possible_map;
 }

 static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6e6eb09b8db6..abb9afb64205 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4416,23 +4416,23 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	return allowed;
 }

-bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+nodemask_t cpuset_node_get_allowed(struct cgroup *cgroup)
 {
+	nodemask_t nodes = node_possible_map;
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
+		return nodes;

 	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
 	if (!css)
-		return true;
+		return nodes;

 	/*
 	 * Normally, accessing effective_mems would require the cpuset_mutex
@@ -4447,9 +4447,9 @@ bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
 	 * cannot make strong isolation guarantees, so this is acceptable.
 	 */
 	cs = container_of(css, struct cpuset, css);
-	allowed = node_isset(nid, cs->effective_mems);
+	nodes_copy(nodes, cs->effective_mems);
 	css_put(css);
-	return allowed;
+	return nodes;
 }

 /**
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75fc22a33b28..c2f4ac50d5c2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5597,9 +5597,11 @@ subsys_initcall(mem_cgroup_swap_init);

 #endif /* CONFIG_SWAP */

-bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+nodemask_t mem_cgroup_node_get_allowed(struct mem_cgroup *memcg)
 {
-	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
+	if (memcg)
+		return cpuset_node_get_allowed(memcg->css.cgroup);
+	return node_possible_map;
 }

 void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a4b308a2f9ad..711a04baf258 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -345,18 +345,24 @@ static bool can_demote(int nid, struct scan_control *sc,
 		       struct mem_cgroup *memcg)
 {
 	int demotion_nid;
+	struct pglist_data *pgdat = NODE_DATA(nid);
+	nodemask_t allowed_mask, allowed_mems;

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
+	allowed_mems = mem_cgroup_node_get_allowed(memcg);
+	nodes_and(allowed_mask, allowed_mask, allowed_mems);
+	if (nodes_empty(allowed_mask))
 		return false;

-	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
-	if (mem_cgroup_node_allowed(memcg, demotion_nid)) {
+	for_each_node_mask(demotion_nid, allowed_mask) {
 		int z;
 		struct zone *zone;
 		struct pglist_data *pgdat = NODE_DATA(demotion_nid);
@@ -1029,11 +1035,12 @@ static struct folio *alloc_demote_folio(struct folio *src,
  * Folios which are not demoted are left on @demote_folios.
  */
 static unsigned int demote_folio_list(struct list_head *demote_folios,
-				     struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      struct mem_cgroup *memcg)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
-	nodemask_t allowed_mask;
+	nodemask_t allowed_mask, allowed_mems;

 	struct migration_target_control mtc = {
 		/*
@@ -1043,7 +1050,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		 */
 		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
 			__GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = target_nid,
 		.nmask = &allowed_mask,
 		.reason = MR_DEMOTION,
 	};
@@ -1051,10 +1057,15 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (list_empty(demote_folios))
 		return 0;

-	if (target_nid == NUMA_NO_NODE)
-		return 0;
-
 	node_get_allowed_targets(pgdat, &allowed_mask);
+	allowed_mems = mem_cgroup_node_get_allowed(memcg);
+	nodes_and(allowed_mask, allowed_mask, allowed_mems);
+	if (nodes_empty(allowed_mask))
+		return false;
+
+	if (target_nid == NUMA_NO_NODE || !node_isset(target_nid, allowed_mask))
+		target_nid = node_random(&allowed_mask);
+	mtc.nid = target_nid;

 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_folio, NULL,
@@ -1576,7 +1587,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */

 	/* Migrate folios selected for demotion */
-	nr_demoted = demote_folio_list(&demote_folios, pgdat);
+	nr_demoted = demote_folio_list(&demote_folios, pgdat, memcg);
 	nr_reclaimed += nr_demoted;
 	stat->nr_demoted += nr_demoted;
 	/* Folios that could not be demoted are still in @demote_folios */
--
2.52.0.358.g0dd7633a29-goog


