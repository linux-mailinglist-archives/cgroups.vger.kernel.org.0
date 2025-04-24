Return-Path: <cgroups+bounces-7811-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C24A9B92D
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 670FC1BC0AA8
	for <lists+cgroups@lfdr.de>; Thu, 24 Apr 2025 20:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1328136E;
	Thu, 24 Apr 2025 20:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="AI7rOCnF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0064238166
	for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745526496; cv=none; b=bKLAKbpesRSFItRRT0mZIvdBdEdqghx1HtNFNutCwszaV9M4cI0ahpGEk0W+zVo7zbPJFj8/hX7x8hiOr2JxUrfU2VXzd0gnVZrQ9U0R2dQQGb3on2ViZjU//tq7HDOvscrkrHkhnHL3+niRwkpmGFlzcra/YQcD/fBxQ7++gv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745526496; c=relaxed/simple;
	bh=zfoCZAi+qgWXFIaHeDNfmek6cFG6y/TXE1VwWMa2yYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4MdTI7xgspQBam5HsZgoAx8a3kVk6JhJ8oYTbUNYrkILZ0gVJFyrHvzCZNXDD/6PaybGRGFxoP5GXqaLETugady6LlUQjNgsTDWQ2+MUPNaDRNo8fvKToEXCelbJj+WJ0EZQNHi+0UR5Pobl4Ud09v+GuU50quwcLi8EAsA7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=AI7rOCnF; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476977848c4so18722981cf.1
        for <cgroups@vger.kernel.org>; Thu, 24 Apr 2025 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745526493; x=1746131293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxWEnn5MTFE6+1tVKFs4oJ/SdesKMia6cc2bPiHfnm4=;
        b=AI7rOCnFe+64PBkGlQ4be3bDf6h5+hsJ2h27O6VWlAcz43ClTYv/o4OK3+f29ZcF2r
         oO+PjGNPp8tGRl7f/rwYy8ayfgt4+qURjib91VXPP9CUu2yp6PPkBsUobQEzT+JJM3hf
         nuFrRrf2DiyWy4+v0wF+5yal0OJzMt72ppyvuM3YhbuVs75dfCrsJhjGm6UZBsWnO5mb
         YLQ/vivH1FEUpmSohv5NgWo5MF7y7teC/D5/+NsezXbKtEMtlOUsfKJQchJEvbwR0aLW
         7iyQL7IjARwP8XyrsTQUyhZcDnJ0xtdf/lt9oMk0Brctg5XxKpjyEGZNAJ1dAgduiu2b
         5ckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745526493; x=1746131293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxWEnn5MTFE6+1tVKFs4oJ/SdesKMia6cc2bPiHfnm4=;
        b=OFGAYgO5hazTumNO+y1PqoMdsTKKII4JfdX8gKpjCh+EyVp3l9lLOaVIjpcnsDqTza
         yCOvVgE77Y40pJzeCr70g7R3U7QEwiCJzGxAU0VAfz7m0yQp2Dzn4A6BcsiR1V0vtYPy
         UwtR7SWFpN5WKI68N0cGnj/hF5h4QUL6rNh5KH2XyWomyoqZJ28NeYPB+Riy0RlhJNHF
         xy8Kxul1JNI4GcJ1ugf6Y3fW9mKHCTxpKbTAdRcj0SQMYINsJjQRm5bGK75KXFunpC04
         1TnAQEaKwl3Dk8hPZ7XoJ0h4zaHIcBkTwMK8FZNscOCct88VijAFp7UY16qnjSNHwqyT
         vTsg==
X-Gm-Message-State: AOJu0YyHuQ8A6nA3Rb/5YkmmFamMCsSp1ahxiIaxeC/Yjc6Z6l+QakT6
	IpJPXhFOXypUuCeRk7Yh8FCPuklFLITvR6H0hJg8tg06vWm+JaxQif3zaCWz9tI=
X-Gm-Gg: ASbGncuNydmSxxLlUbTS8YLHuJ8qz1fb+BGQhlyCTnLTV0bKBJVFgZjayN5bwUVhpfi
	uQuHwMLuJ/vnrCZfqVVoXQxFR0iWBEKKwfAF5gLXptjvnAxcwWluICfvCmkzj3ggu0T4kF+Tn3F
	I2eKsWc5QFY+c6/2lXLIcudOVzAGRDYIw7uzam8PF0nyk4Y6Sj0PsMte72fTchNTz9MWheuAzFt
	0rpazrnlAISuGoLdGjgfuGnZunExB+YCedfwqU+n+X17Co5MbZ4mECSTSke66G3jU7tTfPPhufQ
	CyKEnmP+T9APP9BlDGAZE/OB5NSS6aAe9tGkAeCKQLdQpmXz84ARBusXkpwa8TGAQm3ir7ojqvS
	5XgcjsN/dHuuX78iC7cX9wnXfNwQtKCXeoNtCN6o=
X-Google-Smtp-Source: AGHT+IHogOSfTg5LJdUBkMbpkPdMOCaNUDFPxTL0UeOXpsUsIFBmyFi+0UOFbb/jmohzrTYiFE7SSQ==
X-Received: by 2002:ac8:7d44:0:b0:47f:9f87:ce0a with SMTP id d75a77b69052e-47fb68d7bf9mr14855211cf.0.1745526493434;
        Thu, 24 Apr 2025 13:28:13 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9ebeb870sm16091691cf.5.2025.04.24.13.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 13:28:13 -0700 (PDT)
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
Subject: [PATCH v5 2/2] vmscan,cgroup: apply mems_effective to reclaim
Date: Thu, 24 Apr 2025 16:28:06 -0400
Message-ID: <20250424202806.52632-3-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424202806.52632-1-gourry@gourry.net>
References: <20250424202806.52632-1-gourry@gourry.net>
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

Note on locking:

The cgroup_get_e_css reference protects the css->effective_mems, and
calls of this interface would be subject to the same race conditions
associated with a non-atomic access to cs->effective_mems.

So while this interface cannot make strong guarantees of correctness,
it can therefore avoid taking a global or rcu_read_lock for performance.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Suggested-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 16 +++++---
 include/linux/cpuset.h                        |  5 +++
 include/linux/memcontrol.h                    |  6 +++
 kernel/cgroup/cpuset.c                        | 36 ++++++++++++++++
 mm/memcontrol.c                               |  6 +++
 mm/vmscan.c                                   | 41 +++++++++++--------
 6 files changed, 88 insertions(+), 22 deletions(-)

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
index f8e6a9b642cb..7eb71d411dc7 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4163,6 +4163,42 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
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
+	/*
+	 * Normally, accessing effective_mems would require the cpuset_mutex
+	 * or callback_lock - but node_isset is atomic and the reference
+	 * taken via cgroup_get_e_css is sufficient to protect css.
+	 *
+	 * Since this interface is intended for use by migration paths, we
+	 * relax locking here to avoid taking global locks - while accepting
+	 * there may be rare scenarios where the result may be innaccurate.
+	 *
+	 * Reclaim and migration are subject to these same race conditions, and
+	 * cannot make strong isolation guarantees, so this is acceptable.
+	 */
+	cs = container_of(css, struct cpuset, css);
+	allowed = node_isset(nid, cs->effective_mems);
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


