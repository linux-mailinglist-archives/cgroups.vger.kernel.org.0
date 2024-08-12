Return-Path: <cgroups+bounces-4211-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0179A94F992
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 00:29:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC4DB21620
	for <lists+cgroups@lfdr.de>; Mon, 12 Aug 2024 22:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E9195B27;
	Mon, 12 Aug 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="HjGDkD2W"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0731953B9
	for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 22:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723501754; cv=none; b=Z88Hsv5hKzjltsWsoczkruA5mrc5Xq0Qx4T3QcmeTH/jW70GWb3kfPIv0ZkWp5E9l82hjYgW/CtQhD2lw6eoSaciF84bdMmVRxj7ZFyvF7e6an9dMdsgIaH6gcU9W/op5RUB7yafiDVLgr3D0GP94liyMubxmpJfd1xgmMaXBfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723501754; c=relaxed/simple;
	bh=qZThMG7p0TUt+axf0coCZ/s8mTbCUoUQ94X78BAQHt8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cz+qbgkSi9vTV+2OOKUkjOFk0gMtb8elFQ9AjsrUe9qtH7s73eSPGb8LH4aiY61pgsaa7uuiM6g0//YBc/hmXQu0GJa/qbLwr7UozyRbeNa+hxZzNUt8qj2B2fDMyQf1itR3YK0IhYWlVZj6wrBKLyUVMcGuivSV41N5WAkZEBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=HjGDkD2W; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5d80752933bso3377871eaf.1
        for <cgroups@vger.kernel.org>; Mon, 12 Aug 2024 15:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1723501750; x=1724106550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sU+cXVlCu80kO1aIaHd0R2m3JFR5yw4EpOY383VOajM=;
        b=HjGDkD2WW28dxop7zrrgFXDZ3PAbURN3Byo1ano1r2VuMrdywMaRjfdBqvqCkMKTCi
         cqSxlEuF7R5l8+1OhyGPLen+1rq8JStdivDO7j+zeQ0n+R8oMf1bWXRzc+e2cQoKTDDR
         bxRk5s+RslvhriEzmHONBO0M+B6oVlsZOTyQBbzwV5PJ7CBQWqqdPv4VZxBT6ALEjUzq
         efu/NH6vUwDCjNWJ5Vcxb6cbKCNDjCpuYPrz9UpnUKONrMjzG7Atd3aTEIkAKPoWwDoA
         dciUXQ1CAXs4ZuuBanjHVV8XL7AYM/5D0w8gUQEfKQ+3U4MFMUZ50w+hMmmOv1SzpXJJ
         UWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723501750; x=1724106550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sU+cXVlCu80kO1aIaHd0R2m3JFR5yw4EpOY383VOajM=;
        b=JLb6fw5TdmYVkbtc52/x0lhsKQ+KuicU0SG9X2KXJhLEp/cmw6H+UiJslBuGm6CD7G
         C4jZMeRmYa/l5JsiMcn67cEweBRctk7HjbLgB8mQ1EhWnfFDYdjYmAlwJ82X79It/8g2
         rRTBZ1+F0U7Gr6sg6EKlov20dVm7zr57gARuRRQhhudq0PxAMTg4YLPGF1wWDsaGE62D
         nrS7FLAzfAZW0t0VkybhARyehUb0MGvoCzYMqy+V6Z9dfcwj3iJ3FzRr8fLorWu/hQpZ
         1+7yN21j9YWtQZjF3SG4++Xai29jtKS2kUpTyiyg7qDAjH6pH64eMxo2vaQp1gkpRLDn
         OTkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfrYpY42abbRwZsjZcZsghH/YFGq30Y3YvNoL8rm1GFXheG1N2eWG8CC49TacHuiFEBP0ihUAYnUBdFuVZ1G/6uz4oR6f1rw==
X-Gm-Message-State: AOJu0YxvcJrive5yhLHuly3aB6HKmPawF58F6XcSUSVhtr7sDttDZ0rX
	eewRZOm5fYB5QHhFx76b9ano/SgBbASkGKnwFf5o22PUQonoxvfDY7ani0sS5g==
X-Google-Smtp-Source: AGHT+IFcJidv67v90uN/Bsg3X9CY1oIITmA2J31QpXvDj9YHd81VojRBIvDUKlOmr4rO8WDEdqrs7w==
X-Received: by 2002:a05:6358:5f03:b0:1aa:a27c:ae9e with SMTP id e5c5f4694b2df-1b19d2e71bamr230501355d.19.1723501749668;
        Mon, 12 Aug 2024 15:29:09 -0700 (PDT)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7a4c7d6dbf4sm283931785a.34.2024.08.12.15.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 15:29:09 -0700 (PDT)
From: kaiyang2@cs.cmu.edu
To: linux-mm@kvack.org,
	cgroups@vger.kernel.org
Cc: roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	nehagholkar@meta.com,
	abhishekd@meta.com,
	hannes@cmpxchg.org,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
	kernel test robot <lkp@intel.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] mm,memcg: provide per-cgroup counters for NUMA balancing operations
Date: Mon, 12 Aug 2024 22:29:07 +0000
Message-ID: <20240812222907.2676698-1-kaiyang2@cs.cmu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Kaiyang Zhao <kaiyang2@cs.cmu.edu>

v2:
- fixed compilation error when CONFIG_NUMA_BALANCING is off
- fixed doc warning due to missing parameter description in
get_mem_cgroup_from_folio

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408110848.pqaWv5zD-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202408110708.gCHsUKRI-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202408110706.DZD0TOV3-lkp@intel.com/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
The ability to observe the demotion and promotion decisions made by the
kernel on a per-cgroup basis is important for monitoring and tuning
containerized workloads on either NUMA machines or machines
equipped with tiered memory.

Different containers in the system may experience drastically different
memory tiering actions that cannot be distinguished from the global
counters alone.

For example, a container running a workload that has a much hotter
memory accesses will likely see more promotions and fewer demotions,
potentially depriving a colocated container of top tier memory to such
an extent that its performance degrades unacceptably.

For another example, some containers may exhibit longer periods between
data reuse, causing much more numa_hint_faults than numa_pages_migrated.
In this case, tuning hot_threshold_ms may be appropriate, but the signal
can easily be lost if only global counters are available.

This patch set adds five counters to
memory.stat in a cgroup: numa_pages_migrated, numa_pte_updates,
numa_hint_faults, pgdemote_kswapd and pgdemote_direct.

count_memcg_events_mm() is added to count multiple event occurrences at
once, and get_mem_cgroup_from_folio() is added because we need to get a
reference to the memcg of a folio before it's migrated to track
numa_pages_migrated. The accounting of PGDEMOTE_* is moved to
shrink_inactive_list() before being changed to per-cgroup.

Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
---
 include/linux/memcontrol.h | 24 +++++++++++++++++++++---
 include/linux/vmstat.h     |  1 +
 mm/memcontrol.c            | 33 +++++++++++++++++++++++++++++++++
 mm/memory.c                |  3 +++
 mm/mempolicy.c             |  4 +++-
 mm/migrate.c               |  3 +++
 mm/vmscan.c                |  8 ++++----
 7 files changed, 68 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 44f7fb7dc0c8..90ecd2dbca06 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -768,6 +768,8 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
 
 struct mem_cgroup *get_mem_cgroup_from_current(void);
 
+struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio);
+
 struct lruvec *folio_lruvec_lock(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irq(struct folio *folio);
 struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
@@ -1012,8 +1014,8 @@ static inline void count_memcg_folio_events(struct folio *folio,
 		count_memcg_events(memcg, idx, nr);
 }
 
-static inline void count_memcg_event_mm(struct mm_struct *mm,
-					enum vm_event_item idx)
+static inline void count_memcg_events_mm(struct mm_struct *mm,
+					enum vm_event_item idx, unsigned long count)
 {
 	struct mem_cgroup *memcg;
 
@@ -1023,10 +1025,16 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 	rcu_read_lock();
 	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
 	if (likely(memcg))
-		count_memcg_events(memcg, idx, 1);
+		count_memcg_events(memcg, idx, count);
 	rcu_read_unlock();
 }
 
+static inline void count_memcg_event_mm(struct mm_struct *mm,
+					enum vm_event_item idx)
+{
+	count_memcg_events_mm(mm, idx, 1);
+}
+
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
 {
@@ -1246,6 +1254,11 @@ static inline struct mem_cgroup *get_mem_cgroup_from_current(void)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	return NULL;
+}
+
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css)
 {
@@ -1468,6 +1481,11 @@ static inline void count_memcg_folio_events(struct folio *folio,
 {
 }
 
+static inline void count_memcg_events_mm(struct mm_struct *mm,
+					enum vm_event_item idx, unsigned long count)
+{
+}
+
 static inline
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index 596c050ed492..ff0b49f76ca4 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -32,6 +32,7 @@ struct reclaim_stat {
 	unsigned nr_ref_keep;
 	unsigned nr_unmap_fail;
 	unsigned nr_lazyfree_fail;
+	unsigned nr_demoted;
 };
 
 /* Stat data for system wide items */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e1ffd2950393..fe7d057bbb67 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -307,6 +307,9 @@ static const unsigned int memcg_node_stat_items[] = {
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
 #endif
+	PGDEMOTE_KSWAPD,
+	PGDEMOTE_DIRECT,
+	PGDEMOTE_KHUGEPAGED,
 };
 
 static const unsigned int memcg_stat_items[] = {
@@ -437,6 +440,11 @@ static const unsigned int memcg_vm_event_stat[] = {
 	THP_SWPOUT,
 	THP_SWPOUT_FALLBACK,
 #endif
+#ifdef CONFIG_NUMA_BALANCING
+	NUMA_PAGE_MIGRATE,
+	NUMA_PTE_UPDATES,
+	NUMA_HINT_FAULTS,
+#endif
 };
 
 #define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
@@ -978,6 +986,24 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
 	return memcg;
 }
 
+/**
+ * get_mem_cgroup_from_folio - Obtain a reference on a given folio's memcg.
+ * @folio: folio from which memcg should be extracted.
+ */
+struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	struct mem_cgroup *memcg = folio_memcg(folio);
+
+	if (mem_cgroup_disabled())
+		return NULL;
+
+	rcu_read_lock();
+	if (!memcg || WARN_ON_ONCE(!css_tryget(&memcg->css)))
+		memcg = root_mem_cgroup;
+	rcu_read_unlock();
+	return memcg;
+}
+
 /**
  * mem_cgroup_iter - iterate over memory cgroup hierarchy
  * @root: hierarchy root
@@ -1383,6 +1409,10 @@ static const struct memory_stat memory_stats[] = {
 	{ "workingset_restore_anon",	WORKINGSET_RESTORE_ANON		},
 	{ "workingset_restore_file",	WORKINGSET_RESTORE_FILE		},
 	{ "workingset_nodereclaim",	WORKINGSET_NODERECLAIM		},
+
+	{ "pgdemote_kswapd",		PGDEMOTE_KSWAPD		},
+	{ "pgdemote_direct",		PGDEMOTE_DIRECT		},
+	{ "pgdemote_khugepaged",	PGDEMOTE_KHUGEPAGED	},
 };
 
 /* The actual unit of the state item, not the same as the output unit */
@@ -1416,6 +1446,9 @@ static int memcg_page_state_output_unit(int item)
 	case WORKINGSET_RESTORE_ANON:
 	case WORKINGSET_RESTORE_FILE:
 	case WORKINGSET_NODERECLAIM:
+	case PGDEMOTE_KSWAPD:
+	case PGDEMOTE_DIRECT:
+	case PGDEMOTE_KHUGEPAGED:
 		return 1;
 	default:
 		return memcg_page_state_unit(item);
diff --git a/mm/memory.c b/mm/memory.c
index d6af095d255b..7b6a3619fcce 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5373,6 +5373,9 @@ int numa_migrate_prep(struct folio *folio, struct vm_fault *vmf,
 	vma_set_access_pid_bit(vma);
 
 	count_vm_numa_event(NUMA_HINT_FAULTS);
+#ifdef CONFIG_NUMA_BALANCING
+	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
+#endif
 	if (page_nid == numa_node_id()) {
 		count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
 		*flags |= TNF_FAULT_LOCAL;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b3b5f376471f..b646fab3e45e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -676,8 +676,10 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 	tlb_gather_mmu(&tlb, vma->vm_mm);
 
 	nr_updated = change_protection(&tlb, vma, addr, end, MM_CP_PROT_NUMA);
-	if (nr_updated > 0)
+	if (nr_updated > 0) {
 		count_vm_numa_events(NUMA_PTE_UPDATES, nr_updated);
+		count_memcg_events_mm(vma->vm_mm, NUMA_PTE_UPDATES, nr_updated);
+	}
 
 	tlb_finish_mmu(&tlb);
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 66a5f73ebfdf..7e1267042a56 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2614,6 +2614,7 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 	int nr_remaining;
 	unsigned int nr_succeeded;
 	LIST_HEAD(migratepages);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
 
 	list_add(&folio->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
@@ -2623,12 +2624,14 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 		putback_movable_pages(&migratepages);
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
+		count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
 		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
 		    && !node_is_toptier(folio_nid(folio))
 		    && node_is_toptier(node))
 			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
 					    nr_succeeded);
 	}
+	mem_cgroup_put(memcg);
 	BUG_ON(!list_empty(&migratepages));
 	return nr_remaining ? -EAGAIN : 0;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 25e43bb3b574..fd66789a413b 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1008,9 +1008,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-	mod_node_page_state(pgdat, PGDEMOTE_KSWAPD + reclaimer_offset(),
-			    nr_succeeded);
-
 	return nr_succeeded;
 }
 
@@ -1518,7 +1515,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */
 
 	/* Migrate folios selected for demotion */
-	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
+	stat->nr_demoted = demote_folio_list(&demote_folios, pgdat);
+	nr_reclaimed += stat->nr_demoted;
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
 		/* Folios which weren't demoted go back on @folio_list */
@@ -1984,6 +1982,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
 
+	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
+					stat.nr_demoted);
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = PGSTEAL_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc))
-- 
2.43.0


