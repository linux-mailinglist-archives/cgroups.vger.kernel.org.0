Return-Path: <cgroups+bounces-7658-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC39A941C8
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 07:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5333E189D85E
	for <lists+cgroups@lfdr.de>; Sat, 19 Apr 2025 05:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B356A18E76B;
	Sat, 19 Apr 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="J+nOK59V"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FEA18A6A5
	for <cgroups@vger.kernel.org>; Sat, 19 Apr 2025 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745041115; cv=none; b=S+JSITcCRcEEK0MrPOxmFEkFgobt6DIeoMq4gYwUgdytXR7eDSTkLg7qdXilXZCRlKKdUryrgIPsyaMxhpfMlNYjD/lRNz0V3vreE5HrLz1AeMVIT/ehB+07FMJK4lJahQE73gUnsYo7mkQafzhYrWM9H+JzIu23iKglkttxJKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745041115; c=relaxed/simple;
	bh=j5nyS1jQOepDC8tMs075jfTRcxAytHTavkThiK4YD+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDc+7BeQGqM2KP+IQRhBMzeE0hzEuOsnS7MZj51FUq+7Aani4gx40ZiS2BDM5wce4yuKUzYKcLf8L78IAO524QRjP9+1AwijJ0VYNgbpyaHdFONUBCQTPBv4zu+qD2sSYeYlsmH+LTuucIqdx3WzWltcvV6K+onHlIN07cxLb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=J+nOK59V; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6e8fce04655so22250076d6.3
        for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 22:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1745041112; x=1745645912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kphArVCSz0KLbAMkbfXsG72n7nuxXX/C7s3H9vWRSxo=;
        b=J+nOK59VfNl9jJXcQ1RNA+1P39+yyKqdF2bKRZyimivzskqHa1MHUMDW/ABd4n/faW
         75DVDlxvhcav/qGmg/IqfQf0uTkTfcuO+u3PYBCvgVT06zkguvoMBlP83C8W8/OGmh38
         Xx79b921hgigSoiBAoG+Q3Vb36C5XgSPNlvOFjjzcv4bvBo4U9Xh9cv8gY+MLDDadGDl
         IMiVznpFOd14xAnnBg2lqJ6ILQ2nJJwU0S/dGH0aXNYtXO5M7PXk8s1uf5lp0OkEw0cI
         4TmHppl69EmmXZ/IF60So89f8VvwJ7ajZWSY4fJbyHVkq4ej+W0WvSqNKoMpdiF75aoy
         28RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745041112; x=1745645912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kphArVCSz0KLbAMkbfXsG72n7nuxXX/C7s3H9vWRSxo=;
        b=iBDn8DXT4nSxhCpYxtym9+iZEfhymg6YIXSr8oJu6WVz+57INODwbO3Qfir/rkP0HM
         XB3BtnXp43ZR5EbyOaE9YTkNf/Dm2FKqyvRSBAPGIP/gSHXprhKULghykaYOympQ7Sna
         rTYwHA0/GFLj957vSGoVeAXAL85Zu/kXp2xJNYwE3HoBNmgIsNGqolYkDaAGfFdMQzY+
         OSMCZ4YMGw1FNxBvJvO8OJZLSIV5dwBqMY6z3cJyHRNYepWChMsjeAL8THIf0gpq2yXE
         a9UPUmmTJaR9jjUQf6RQ7j87GQUMssoV/mVNRP8KnRtMMjfUp1wjBfa0ReFpQjpMe6C7
         XxhA==
X-Gm-Message-State: AOJu0YxEiyURysWtCpV9WFlfYSkLpeBAUSbbLaChe9J0v/wo3fl451ke
	JtsUv/OZm/KlG8owEdi0A4DrvJkI4Vn0SZtrkCudhj6STAGcd/2z/OoLH+k8arA=
X-Gm-Gg: ASbGncstiNtFIiQjnFUrVYV9VdgFpDNbJ29II40bLNbbVYdPOB9KVmoBQOe+4lXsmxB
	N1yo/4fnmEFUGidePQpD2NELFWZoFYYdDVoEXaLbmW1XnaaJJvGDrY6UyI6IDOCjLeqdk/y8aGw
	3VcGVyXD+hSDNnjXtTuGBFuFtXxk9QYzAN9MYNXtQ6uAtMdisGVvhVwqF39wCaEJkaPjoBei9Tm
	RG9FROrBJ8Z6jTOKyB5FNkKlrmWzd4eBVu5Bm2w/WV57fV2XTI58aM5dtvUStLOHyCaoCP4U6F+
	Cg8+oeNGs0EfNcEWM9vKsVqeHIBZ7wbxzGyeC0to2NOzbOMWH6p33HrfwbAj8DMpTMMccD4yGue
	FgGhrNrzFkgiRxOkHAgupA8aTAvDh
X-Google-Smtp-Source: AGHT+IGokloKomTVMayniE6Mf++d9cjUZKWpbDcg5f1ADpmX7RSw+BGIJ9I5WqbA/PGhMdrqH+rBOQ==
X-Received: by 2002:ad4:5d43:0:b0:6e8:f940:50af with SMTP id 6a1803df08f44-6f2c4688419mr88612006d6.44.1745041112115;
        Fri, 18 Apr 2025 22:38:32 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2b30c65sm18341956d6.51.2025.04.18.22.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 22:38:31 -0700 (PDT)
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
Subject: [PATCH v3 2/2] vmscan,cgroup: apply mems_effective to reclaim
Date: Sat, 19 Apr 2025 01:38:24 -0400
Message-ID: <20250419053824.1601470-3-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250419053824.1601470-1-gourry@gourry.net>
References: <20250419053824.1601470-1-gourry@gourry.net>
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

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 .../ABI/testing/sysfs-kernel-mm-numa          | 14 ++++---
 include/linux/cpuset.h                        |  5 +++
 include/linux/memcontrol.h                    |  6 +++
 kernel/cgroup/cpuset.c                        | 21 ++++++++++
 mm/memcontrol.c                               |  6 +++
 mm/vmscan.c                                   | 41 +++++++++++--------
 6 files changed, 72 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-numa b/Documentation/ABI/testing/sysfs-kernel-mm-numa
index 77e559d4ed80..27cdcab901f7 100644
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
+		is performed before swap if an eligible numa node is
+		present in cpuset.mems for the cgroup. If cpusets.mems
+		changes at runtime, it may move data to a NUMA node that
+		does not fall into the cpuset of the new cpusets.mems,
+		which might be construed to violate the guarantees of
+		cpusets.  Shared memory, such as libraries, owned by
+		another cgroup may still be demoted and result in memory
+		use on a node not present in cpusets.mem. This should not
+		be enabled on systems which need strict cpuset location
 		guarantees.
diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 893a4c340d48..c64b4a174456 100644
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
+	return false;
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
index f8e6a9b642cb..8814ca8ec710 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4163,6 +4163,27 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	return allowed;
 }
 
+bool cpuset_node_allowed(struct cgroup *cgroup, int nid)
+{
+	struct cgroup_subsys_state *css;
+	unsigned long flags;
+	struct cpuset *cs;
+	bool allowed;
+
+	css = cgroup_get_e_css(cgroup, &cpuset_cgrp_subsys);
+	if (!css)
+		return true;
+
+	cs = container_of(css, struct cpuset, css);
+	spin_lock_irqsave(&callback_lock, flags);
+	/* On v1 effective_mems may be empty, simply allow */
+	allowed = node_isset(nid, cs->effective_mems) ||
+		  nodes_empty(cs->effective_mems);
+	spin_unlock_irqrestore(&callback_lock, flags);
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


