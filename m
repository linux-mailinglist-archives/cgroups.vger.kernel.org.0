Return-Path: <cgroups+bounces-7698-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A978A95A7F
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 03:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D6C171F8D
	for <lists+cgroups@lfdr.de>; Tue, 22 Apr 2025 01:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F6319049A;
	Tue, 22 Apr 2025 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="fYJaxH4O"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4416F858
	for <cgroups@vger.kernel.org>; Tue, 22 Apr 2025 01:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745285185; cv=none; b=kegcNiop3Nakm+0jWP3z7TrK5x1jO0kMb6Ao2s7AdelcSQwPiV4w5lLiZHTiJ5RSHc+oBsx5HsbzyqBotJuZFCYl3b/pTHS5Jr2+hJikrf/6WsaBFC0vL0FuQBtLW1E2s/ag3crvhXhvGB19Hy1ecMDsgIm0WqnPCrQ/IMW0KQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745285185; c=relaxed/simple;
	bh=WMwHDQ2As8i0+1SehyLYPLGiQfF/A9eDDNpHTGo5cBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cdG0YZAAW5NMEGMOx36vImSC/aTR6YcNcofBccUwRbxywjIjlJsHXK10FIEnEbg/8ski3JAEajTBbnF71z6mdME2xZP6+B/igrwztaPqmJSXfr3kKNZyXky5qfv9ePdiCjUxed+SswVErmUlU+sddxrD9RmJ3LB1RpOP2vu89rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=fYJaxH4O; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c5e39d1db2so235376885a.3
        for <cgroups@vger.kernel.org>; Mon, 21 Apr 2025 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745285181; x=1745889981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Kle4Lqt4WBt6giVl/+yUtlyI+tb9qWSFjEQjFngXB0=;
        b=fYJaxH4OUfRcMIgrrfxZWhupBG85LFePRuF87JxCs788tgPZTTQeJspEd/Hyuj7nBv
         +vaTaM8vOvZmEC+ILsWisOzk+fxFS17KgBBk3vlAykIF2Uo8bKAPse5F3l1AZac11OC+
         tu6LQ23gg88kHvi8D+21I8u6M/2OV8ljXkbC7yK8K+kCrrcD/0xey0REY2U2qWsBS+uy
         0bU7eDDoCq4Wvmz/q2Wl5qa+PLGrQcxIMo6tWxAUa13VNEYvez0BIlX4Pv4A93gyNioW
         zWsXQf7m8zH1EgeBsXBdECZIFLbluzACx3bBPlYc8C/jaG/2T9DnZm1Z5rzpc/NZd7aC
         r2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745285181; x=1745889981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Kle4Lqt4WBt6giVl/+yUtlyI+tb9qWSFjEQjFngXB0=;
        b=XN7uNGu+T4oDbmp0IJakJCWjzpRLVzS64UmVa6ojpwNKb9x89xh/MDUB6CZtHo7Zxb
         OprhQ5p0ISdNMiFC3yJSH7XcDTYvrRkqSiViwz1MQQdEljFz+aZiLlbqtRaxarJNpCwK
         uZ9UP+JEO97qb7LWsdqUZIrU8H6OAwuSePP4dmlMCDZIVL2uzvlzi0hPgC07pwmBMeic
         OcTR5tY5kKmVAzmxEkXIlWiz/6/cp+dbYVIFeXNPJ1Lj+kWRzv/ulxPfyNjLoaepfKJQ
         FDpujd/RWsL3sauLUoT7wrncA45Dmm8HIvEvbSWuFFZXa9mPTknP8pcjbfMaZIbl6i+m
         lQBQ==
X-Gm-Message-State: AOJu0Ywspm4VSsZ0h66jGrO33319b1Xamk6Rhv4wRjBIYz/KmgQ8yflf
	n2jBFry+wTvx9+0XkFqFpvEpv5h7XhJXTYp42vsjbYtyDSR1eXQ0CE2cVO91b0E=
X-Gm-Gg: ASbGncs/kgMPGYoUTFu7IL2UPu4rby4pr7Nt8LbdkmetrcH4hcYKmuRgBQnBRB1LBf6
	63HNIMrAl7C5tS+roq8HU1ji/7seNPcFSJFxNRjxiJAc1xVPNgFcF5iJmdBxaEjgicdMcJflONs
	BrY2N5NmxltJ6QUomo1sFkeIgTi5o8K0Q/dOarD2wZ8j3hvPBoRFdkuf4QkY8GZCP1nLEZK8d0i
	9sp0ETQE8UpKtbbHxYdiu33c7hh0gyoFTmAfkNBFpJ+CfZjETitrur6HaLz/7waKduPnpDPT4Q2
	ZMVoZRbsjWcsSK6rluyhl/hgEVEpU7oKhmerd4HZLhRBllKCQ4J/TyeIzvKUqFWcOGsYDtZUsoj
	5eZOYKrxShEtsRFch7FwmcM9UM3lKvua8lHNFQhk=
X-Google-Smtp-Source: AGHT+IG6HxcdwaS4DYHDMOqX5ZLpYXYsTbmi3+FGkCgYV4wxqXoEUZtvFG5cMXhmSwORfqHFe+7drA==
X-Received: by 2002:a05:6214:2484:b0:6f2:b551:a65 with SMTP id 6a1803df08f44-6f2c4674ffcmr281778536d6.38.1745285181142;
        Mon, 21 Apr 2025 18:26:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2c00d78sm50985746d6.79.2025.04.21.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 18:26:20 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	longman@redhat.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	tj@kernel.org,
	mkoutny@suse.com,
	akpm@linux-foundation.org
Subject: [PATCH v4 2/2] vmscan,cgroup: apply mems_effective to reclaim
Date: Mon, 21 Apr 2025 21:26:15 -0400
Message-ID: <20250422012616.1883287-3-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422012616.1883287-1-gourry@gourry.net>
References: <20250422012616.1883287-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible for a reclaimer to cause demotions of an lruvec belonging
to a cgroup with cpuset.mems set to exclude some nodes. Attempt to apply
this limitation based on the lruvec's memcg and prevent demotion.

Notably, this may still allow demotion of shared libraries or any memory
first instantiated in another cgroup. This means cpusets still cannot
cannot guarantee complete isolation when demotion is enabled, and the
docs have been updated to reflect this.

This is useful for isolating workloads on a multi-tenant system from
certain classes of memory more consistently - with the noted exceptions.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 16 +++++---
 include/linux/cpuset.h                        |  5 +++
 include/linux/memcontrol.h                    |  6 +++
 kernel/cgroup/cpuset.c                        | 26 ++++++++++++
 mm/memcontrol.c                               |  6 +++
 mm/vmscan.c                                   | 41 +++++++++++--------
 6 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
index 77e559d4ed80..90e375ff54cb 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-numa
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-numa
@@ -16,9 +16,13 @@ Description:	Enable/disable demoting pages during reclaim
 		Allowing page migration during reclaim enables these
 		systems to migrate pages from fast tiers to slow tiers
 		when the fast tier is under pressure.  This migration
-		is performed before swap.  It may move data to a NUMA
-		node that does not fall into the cpuset of the
-		allocating process which might be construed to violate
-		the guarantees of cpusets.  This should not be enabled
-		on systems which need strict cpuset location
-		guarantees.
+		is performed before swap if an eligible numa node is
+		present in cpuset.mems for the cgroup (or if cpuset v1
+		is being used). If cpusets.mems changes at runtime, it
+		may move data to a NUMA node that does not fall into the
+		cpuset of the new cpusets.mems, which might be construed
+		to violate the guarantees of cpusets.  Shared memory,
+		such as libraries, owned by another cgroup may still be
+		demoted and result in memory use on a node not present
+		in cpusets.mem. This should not be enabled on systems
+		which need strict cpuset location guarantees.
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 893a4c340d48..5255e3fdbf62 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -171,6 +171,7 @@ static inline void set_mems_allowed(nodemask_t nodemask)
 	task_unlock(current);
 }
 
+extern bool cpuset_node_allowed(struct cgroup *cgroup, int nid);
 #else /* !CONFIG_CPUSETS */
 
 static inline bool cpusets_enabled(void) { return false; }
@@ -282,6 +283,10 @@ static inline bool read_mems_allowed_retry(unsigned int seq)
 	return false;
 }
 
+static inline bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+{
+	return true;
+}
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53364526d877..a6c4e3faf721 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1736,6 +1736,8 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid);
+
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1793,6 +1795,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 {
 }
 
+static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+{
+	return true;
+}
 #endif /* CONFIG_MEMCG */
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f8e6a9b642cb..c52348bfd5db 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4163,6 +4163,32 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	return allowed;
 }
 
+bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+{
+	struct cgroup_subsys_state *css;
+	struct cpuset *cs;
+	bool allowed;
+
+	/*
+	 * In v1, mem_cgroup and cpuset are unlikely in the same hierarchy
+	 * and mems_allowed is likely to be empty even if we could get to it,
+	 * so return true to avoid taking a global lock on the empty check.
+	 */
+	if (!cpuset_v2())
+		return true;
+
+	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
+	if (!css)
+		return true;
+
+	cs = container_of(css, struct cpuset, css);
+	rcu_read_lock();
+	allowed = node_isset(nid, cs->effective_mems);
+	rcu_read_unlock();
+	css_put(css);
+	return allowed;
+}
+
 /**
  * cpuset_spread_node() - On which node to begin search for a page
  * @rotor: round robin rotor
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 40c07b8699ae..2f61d0060fd1 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -29,6 +29,7 @@
 #include <linux/page_counter.h>
 #include <linux/memcontrol.h>
 #include <linux/cgroup.h>
+#include <linux/cpuset.h>
 #include <linux/sched/mm.h>
 #include <linux/shmem_fs.h>
 #include <linux/hugetlb.h>
@@ -5437,3 +5438,8 @@ static int __init mem_cgroup_swap_init(void)
 subsys_initcall(mem_cgroup_swap_init);
 
 #endif /* CONFIG_SWAP */
+
+bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+{
+	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
+}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2b2ab386cab5..32a7ce421e42 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -342,16 +342,22 @@ static void flush_reclaim_state(struct scan_control *sc)
 	}
 }
 
-static bool can_demote(int nid, struct scan_control *sc)
+static bool can_demote(int nid, struct scan_control *sc,
+		       struct mem_cgroup *memcg)
 {
+	int demotion_nid;
+
 	if (!numa_demotion_enabled)
 		return false;
 	if (sc && sc->no_demotion)
 		return false;
-	if (next_demotion_node(nid) == NUMA_NO_NODE)
+
+	demotion_nid = next_demotion_node(nid);
+	if (demotion_nid == NUMA_NO_NODE)
 		return false;
 
-	return true;
+	/* If demotion node isn't in the cgroup's mems_allowed, fall back */
+	return mem_cgroup_node_allowed(memcg, demotion_nid);
 }
 
 static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
@@ -376,7 +382,7 @@ static inline bool can_reclaim_anon_pages(struct mem_cgroup *memcg,
 	 *
 	 * Can it be reclaimed from this node via demotion?
 	 */
-	return can_demote(nid, sc);
+	return can_demote(nid, sc, memcg);
 }
 
 /*
@@ -1096,7 +1102,8 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
  */
 static unsigned int shrink_folio_list(struct list_head *folio_list,
 		struct pglist_data *pgdat, struct scan_control *sc,
-		struct reclaim_stat *stat, bool ignore_references)
+		struct reclaim_stat *stat, bool ignore_references,
+		struct mem_cgroup *memcg)
 {
 	struct folio_batch free_folios;
 	LIST_HEAD(ret_folios);
@@ -1109,7 +1116,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	folio_batch_init(&free_folios);
 	memset(stat, 0, sizeof(*stat));
 	cond_resched();
-	do_demote_pass = can_demote(pgdat->node_id, sc);
+	do_demote_pass = can_demote(pgdat->node_id, sc, memcg);
 
 retry:
 	while (!list_empty(folio_list)) {
@@ -1658,7 +1665,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	 */
 	noreclaim_flag = memalloc_noreclaim_save();
 	nr_reclaimed = shrink_folio_list(&clean_folios, zone->zone_pgdat, &sc,
-					&stat, true);
+					&stat, true, NULL);
 	memalloc_noreclaim_restore(noreclaim_flag);
 
 	list_splice(&clean_folios, folio_list);
@@ -2031,7 +2038,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	if (nr_taken == 0)
 		return 0;
 
-	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false);
+	nr_reclaimed = shrink_folio_list(&folio_list, pgdat, sc, &stat, false,
+					 lruvec_memcg(lruvec));
 
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
@@ -2214,7 +2222,7 @@ static unsigned int reclaim_folio_list(struct list_head *folio_list,
 		.no_demotion = 1,
 	};
 
-	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &stat, true);
+	nr_reclaimed = shrink_folio_list(folio_list, pgdat, &sc, &stat, true, NULL);
 	while (!list_empty(folio_list)) {
 		folio = lru_to_folio(folio_list);
 		list_del(&folio->lru);
@@ -2646,7 +2654,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
  * Anonymous LRU management is a waste if there is
  * ultimately no way to reclaim the memory.
  */
-static bool can_age_anon_pages(struct pglist_data *pgdat,
+static bool can_age_anon_pages(struct lruvec *lruvec,
 			       struct scan_control *sc)
 {
 	/* Aging the anon LRU is valuable if swap is present: */
@@ -2654,7 +2662,8 @@ static bool can_age_anon_pages(struct pglist_data *pgdat,
 		return true;
 
 	/* Also valuable if anon pages can be demoted: */
-	return can_demote(pgdat->node_id, sc);
+	return can_demote(lruvec_pgdat(lruvec)->node_id, sc,
+			  lruvec_memcg(lruvec));
 }
 
 #ifdef CONFIG_LRU_GEN
@@ -2732,7 +2741,7 @@ static int get_swappiness(struct lruvec *lruvec, struct scan_control *sc)
 	if (!sc->may_swap)
 		return 0;
 
-	if (!can_demote(pgdat->node_id, sc) &&
+	if (!can_demote(pgdat->node_id, sc, memcg) &&
 	    mem_cgroup_get_nr_swap_pages(memcg) < MIN_LRU_BATCH)
 		return 0;
 
@@ -4695,7 +4704,7 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	if (list_empty(&list))
 		return scanned;
 retry:
-	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false);
+	reclaimed = shrink_folio_list(&list, pgdat, sc, &stat, false, memcg);
 	sc->nr.unqueued_dirty += stat.nr_unqueued_dirty;
 	sc->nr_reclaimed += reclaimed;
 	trace_mm_vmscan_lru_shrink_inactive(pgdat->node_id,
@@ -5850,7 +5859,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	 * Even if we did not try to evict anon pages at all, we want to
 	 * rebalance the anon lru active/inactive ratio.
 	 */
-	if (can_age_anon_pages(lruvec_pgdat(lruvec), sc) &&
+	if (can_age_anon_pages(lruvec, sc) &&
 	    inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		shrink_active_list(SWAP_CLUSTER_MAX, lruvec,
 				   sc, LRU_ACTIVE_ANON);
@@ -6681,10 +6690,10 @@ static void kswapd_age_node(struct pglist_data *pgdat, struct scan_control *sc)
 		return;
 	}
 
-	if (!can_age_anon_pages(pgdat, sc))
+	lruvec = mem_cgroup_lruvec(NULL, pgdat);
+	if (!can_age_anon_pages(lruvec, sc))
 		return;
 
-	lruvec = mem_cgroup_lruvec(NULL, pgdat);
 	if (!inactive_is_low(lruvec, LRU_INACTIVE_ANON))
 		return;
 
-- 
2.49.0


