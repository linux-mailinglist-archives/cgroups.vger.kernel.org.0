Return-Path: <cgroups+bounces-7637-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA14FA930B2
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 05:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AF98E00CA
	for <lists+cgroups@lfdr.de>; Fri, 18 Apr 2025 03:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DC5268689;
	Fri, 18 Apr 2025 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="U7fUyTIh"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1B267F61
	for <cgroups@vger.kernel.org>; Fri, 18 Apr 2025 03:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744946044; cv=none; b=jWWpfqbGgnP2y9Ed0iUDxhpMbpIbqZh4l1jZtXY4J6Iv6TTYiXcgP0dBB8fHoe1OKOsLdyk8n0IjPDxvPnpYsDtoSN46asel2kpXhlEAiQNYk+g7YyBGCyRKlCzyoTKNXWc90NRMlo6NZljmIGfS5iwYVRcA/kXvuRlo/ihXPrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744946044; c=relaxed/simple;
	bh=Nn+auOPB1Pe3mdZJAcIUTIHjTFUV6LeI8x8O1PF0j3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Quc7an3aB0V9FJ3Ci6Pn85/89HoF2oALbBjpiuGlOaXIyVfQjBPZ83syxoD3hEzlE/7sSdkmr3zTizXnyWdqnL40jn5PCyHwi0KPl9sjYu64a2BXpeu/cG4EXDe0/fRjnfM9umXi9KUFvfo+9JW/go7yE9lN6L6PaLSpDJb0wsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=U7fUyTIh; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6ecf99dd567so18374256d6.0
        for <cgroups@vger.kernel.org>; Thu, 17 Apr 2025 20:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1744946041; x=1745550841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5c4EiNLEzaH1kEu4rlybhAXBFQwwhe/VADHqdjirWGU=;
        b=U7fUyTIhnu4FJcPlVteDoJUtq4viO7+6OlYb5DObeiESe4ArDZVJpL4+jSurliciW3
         WWCZir47/C2hOV2UggxUt+gSiOhSDgD+CH9RC/wwyeEEqXUqq//PbNlueLc4EzL4gtrb
         iefQrG5KzQhjC7hjPM/ec0LEBOFWAj6K0TRoNJfIcAs3y8KM7lnl9qVBzaY9hIPQSvGQ
         kmxUeZDQu1k2OjDQbrYzkBoN+C5+29C5msCKa3M7zEaVZBaJDErxMzEOnQQWwWg4Jy9a
         I1W9kOP+V6ese/UxWOwZhJX9lhkTSXoYCDio2wWzgn5GTqhgHwldFaBYAYCIovTks9gD
         rt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744946041; x=1745550841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5c4EiNLEzaH1kEu4rlybhAXBFQwwhe/VADHqdjirWGU=;
        b=lGvxgHDnIkrRc9eaEl8Gq9D0eklhIgrQkYQjkgb50mae2MUWxRJSXdF6iwFAj8T8fe
         aC2YeUWXTLCQceS2A3DFjVHC4WUbF0Y+Zgm/5gFOaMxIBsNGDc85nC9b9EbR0cBw+QgX
         sxorcA72J4qy0zvtxqPQtZ+p9+dwFKIwOrlv4dgHHCo6HHPg9ne7M45SjdqYNLlrR625
         N25pAU0HdQZTr915tsia5MEqlmig2VOb2zRYrSTYqCq2LPey9eNXh40U417AqFCT9O8P
         OY8GcO+3UMb0DbPxLmX2ZDZioMyDjwq+y1eYYC1T/sEbvjHIMJ8HQtX4MkfqZ2vHH8lK
         hvfA==
X-Gm-Message-State: AOJu0Yx0c1N4TwwDlthg7T/sD5Lfrycd6FJJUWd42+i01o2taC1VXv46
	293NmcHVuRIPRYAc/GrMj90yu3JQpJ2L7gdrXuMvaKT4+wTU6/TIWb86GLQNpAoLWA5998Pk0x9
	u
X-Gm-Gg: ASbGncvjurORPbcUbi1f2VagZfs9j9MVttkk1GCz4UyNCqT/jQdgG5so3SmGvvCGj3u
	+aEDpKichIdLrrFb5+MVAMLoW8Z+qfOqF05Dal4E7zuSSyyPIb2n0aPMTyjXd66X9xrXq6GvidK
	DBCu2AwXh0JmdyDZuVGytzL2MuHEN+ygMdeMAM+e7+T8SzxzrGGJY2NH1VveVXeh4dhDnXh2Zbc
	lWlr7ybfybQ7rSq2nBKNvBjlU04/6wEvGiXPZAvst2sLUJzvQ8QIlH/+IEFg4+JjE5lvifRJNlt
	7et/Tb9YkM1Zte1GRrVZm98ctYBhp3K5NGcLa9TGVAWOGt2Nk8/5Z6hq2lt9c0JlfmVIIzhcvEB
	RNrJRa2qsPw4cbMgAwtxEowiO1yoP
X-Google-Smtp-Source: AGHT+IEsxXzvK+RuOTa9fUyb98lbKMDB18an/pe4G3IndVeUIywzKG7ffnqYQetM9ARvJ/Mn4afdqg==
X-Received: by 2002:a05:6214:4012:b0:6ed:1da2:afb9 with SMTP id 6a1803df08f44-6f2c45750a8mr28479756d6.19.1744946040958;
        Thu, 17 Apr 2025 20:14:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2af1717sm6231796d6.15.2025.04.17.20.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 20:14:00 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	longman@redhat.com,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Subject: [PATCH v2 2/2] vmscan,cgroup: apply mems_effective to reclaim
Date: Thu, 17 Apr 2025 23:13:52 -0400
Message-ID: <20250418031352.1277966-2-gourry@gourry.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250418031352.1277966-1-gourry@gourry.net>
References: <20250418031352.1277966-1-gourry@gourry.net>
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
 include/linux/cgroup.h                        |  7 ++++
 include/linux/cpuset.h                        |  5 +++
 include/linux/memcontrol.h                    |  9 ++++
 kernel/cgroup/cgroup.c                        |  5 +++
 kernel/cgroup/cpuset.c                        | 22 ++++++++++
 mm/vmscan.c                                   | 41 +++++++++++--------
 7 files changed, 82 insertions(+), 21 deletions(-)

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
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index f8ef47f8a634..2915250a3e5e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -632,6 +632,8 @@ static inline void cgroup_kthread_ready(void)
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
 struct cgroup *cgroup_get_from_id(u64 id);
+
+extern bool cgroup_node_allowed(struct cgroup *cgroup, int nid);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -681,6 +683,11 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 
 static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {}
+
+static inline bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
+{
+	return true;
+}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
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
index 53364526d877..2906e4bb12e9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1736,6 +1736,11 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 	rcu_read_unlock();
 }
 
+static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+{
+	return memcg ? cgroup_node_allowed(memcg->css.cgroup, nid) : true;
+}
+
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1793,6 +1798,10 @@ static inline void count_objcg_events(struct obj_cgroup *objcg,
 {
 }
 
+static inline bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
+{
+	return true;
+}
 #endif /* CONFIG_MEMCG */
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index afc665b7b1fe..ba0b90cd774c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -7038,6 +7038,11 @@ int cgroup_parse_float(const char *input, unsigned dec_shift, s64 *v)
 	return 0;
 }
 
+bool cgroup_node_allowed(struct cgroup *cgroup, int nid)
+{
+	return cpuset_node_allowed(cgroup, nid);
+}
+
 /*
  * sock->sk_cgrp_data handling.  For more info, see sock_cgroup_data
  * definition in cgroup-defs.h.
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d6ed3f053e62..31e4c4cbcdfc 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4163,6 +4163,28 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
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
+	/* At least one parent must have a valid node list */
+	while (nodes_empty(cs->effective_mems))
+		cs = parent_cs(cs);
+	allowed = node_isset(nid, cs->effective_mems);
+	spin_unlock_irqrestore(&callback_lock, flags);
+	css_put(css);
+	return allowed;
+}
+
 /**
  * cpuset_spread_node() - On which node to begin search for a page
  * @rotor: round robin rotor
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


