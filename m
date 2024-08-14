Return-Path: <cgroups+bounces-4256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45B95216F
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 19:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515A52833C7
	for <lists+cgroups@lfdr.de>; Wed, 14 Aug 2024 17:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957561BC065;
	Wed, 14 Aug 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b="HmTLxAyQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06341B14F8
	for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657387; cv=none; b=Y7YJIqTvu/b7fK69aYJ8fqGS0D/7nW9FXu3PyhXbBWYSqQUdTxVoDiPbiejOMuk+HwbxJpM1B8CSlrOER5uKsXPetqbs08gm+gqbs6UaFrqE+2qhW3c+li/3UpQQsT0DqyiaWnuCLAbqJal4ouDmcN6oJlwthCsxX81rZaDlFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657387; c=relaxed/simple;
	bh=89OUc9Ef569Ql3eOlrY8DdwjwJWfUoNDLTlYh4Zb8BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uG+4cPhPqI3lQ5HNWkmkzBeUBiRFzdDdF7DLxI4lgnEqtToKJ+gNQhEcE6TIEJFI37Ja6OTFHw9+46N/ueg9Ts1ahEbf2JFVFfYblSEOnjdlifFe8btDVDOxjVTuMlnfvSLnNEX3cWtSGwlg0WerQrpMrRXBIHQQF62UrsPpZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu; spf=pass smtp.mailfrom=andrew.cmu.edu; dkim=pass (2048-bit key) header.d=cs.cmu.edu header.i=@cs.cmu.edu header.b=HmTLxAyQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.cmu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andrew.cmu.edu
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso194328276.1
        for <cgroups@vger.kernel.org>; Wed, 14 Aug 2024 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.cmu.edu; s=google-2021; t=1723657381; x=1724262181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbydyfcnYMbQui7MtCStpXyMmVCUv/3iDljB6GAcDNY=;
        b=HmTLxAyQhYY7qHk5ly/IVY523GOmT1gP0r1cULUmSn2o6DChxzgqrnVSx+Ex2d6VYW
         kGPoElxR5MxXpuiVn0vZUahqJ6I+cqqQo0U/lqviCABarNohhbOoROyih2JiMBNmstWX
         NkMoB4sqEYAEp4luDugA+CKnUyfc1RQ2gakSzgzuwnHYer90CgiJUQ7++LEzWzKO39k1
         33DwLDmHFgQWlMPK4PvZwZQh6olms7m97MRqflApXZpp7qkGsL6yNisz3xfoHrDGIyGG
         2BwurC6LQouJ+Tva5rXumfNhDErt/wAuaoCHOm9PTJUUbaa3tX4gJC2iKtKK8RMVCSqo
         Ypyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657381; x=1724262181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FbydyfcnYMbQui7MtCStpXyMmVCUv/3iDljB6GAcDNY=;
        b=SynPMCdQzWW1k5vfKG/B8cLt9UXVWjWYWFUvaOBlWLe3UV56za1vnGUM7TN1aqL0oB
         H32YqDH1s7u2YCSsMWh1wk9dgubKw9GzPsgQcQM39NR2BFSmYyLTbQ/S1WsPqASc7mkl
         4oEyhlr1x13dbd5FTmgvAvkPs2gG8XyKqBP1ThY7q3N8qpF9Ka17YHBe1B4CeWv3q56A
         ZRIva9eZT3SWCMU5lCW0NB4BYeP1qk+HI8IXMjj3hY2/oQLCCAA3apkCdH1m4mYKbQoE
         0Ysn3IMlbJxY6/sXpTmcrTg2s58cHzTNyh/rIpjefbuDdKZc9llZgW4luejZNIvuENXy
         0Izg==
X-Forwarded-Encrypted: i=1; AJvYcCWKexDnDxgsT+85idRXNjbkpMFx1g/vGLeCkZgTMWPwL5H3k11EaD/FTCpnC48G/J+qxXiV5UbWM7iwac1BP8VLrVDKTCzxjg==
X-Gm-Message-State: AOJu0Yx5S50NjJsH+YgXNFU1licLrWRYW+waQnrIW27OlwAksko/YHIY
	GMA9bU14MhTFXeV0DVDcFfXrDREIuTQT+nUMuUex7e5eFnf54tA4aGvDEhbRlw==
X-Google-Smtp-Source: AGHT+IF8uB1i/SxF6hVwiRjNBpd8rb7PbC/HUG5DUIPBJTeyUibX0DJXrmE7OXIMJialuKMzG/RIVw==
X-Received: by 2002:a05:6902:2407:b0:e0b:ee88:7cda with SMTP id 3f1490d57ef6-e1155b9aa46mr3919060276.36.1723657381515;
        Wed, 14 Aug 2024 10:43:01 -0700 (PDT)
Received: from localhost (pool-74-98-231-160.pitbpa.fios.verizon.net. [74.98.231.160])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6bd82c8305fsm46037126d6.41.2024.08.14.10.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 10:43:01 -0700 (PDT)
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
	weixugc@google.com,
	rientjes@google.com,
	Kaiyang Zhao <kaiyang2@cs.cmu.edu>
Subject: [PATCH v3] mm,memcg: provide per-cgroup counters for NUMA balancing operations
Date: Wed, 14 Aug 2024 17:42:27 +0000
Message-ID: <20240814174227.30639-1-kaiyang2@cs.cmu.edu>
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

This patch set adds seven counters to memory.stat in a cgroup:
numa_pages_migrated, numa_pte_updates, numa_hint_faults, pgdemote_kswapd,
pgdemote_khugepaged, pgdemote_direct and pgpromote_success. pgdemote_*
and pgpromote_success are also available in memory.numa_stat.

count_memcg_events_mm() is added to count multiple event occurrences at
once, and get_mem_cgroup_from_folio() is added because we need to get a
reference to the memcg of a folio before it's migrated to track
numa_pages_migrated. The accounting of PGDEMOTE_* is moved to
shrink_inactive_list() before being changed to per-cgroup.

Signed-off-by: Kaiyang Zhao <kaiyang2@cs.cmu.edu>
---
v3:
- added pgpromote_success as suggested by Wei Xu

v2:
- fixed compilation error when CONFIG_NUMA_BALANCING is off
- fixed doc warning due to missing parameter description in
get_mem_cgroup_from_folio

 include/linux/memcontrol.h | 24 +++++++++++++++++---
 include/linux/vmstat.h     |  1 +
 mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++++++++++
 mm/memory.c                |  3 +++
 mm/mempolicy.c             |  4 +++-
 mm/migrate.c               |  7 ++++--
 mm/vmscan.c                |  8 +++----
 7 files changed, 82 insertions(+), 10 deletions(-)

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
index 9eb77c9007e6..d2761bf8ff32 100644
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
index 4884629f0ce5..9a338978eeae 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -307,6 +307,12 @@ static const unsigned int memcg_node_stat_items[] = {
 #ifdef CONFIG_SWAP
 	NR_SWAPCACHE,
 #endif
+#ifdef CONFIG_NUMA_BALANCING
+	PGPROMOTE_SUCCESS,
+#endif
+	PGDEMOTE_KSWAPD,
+	PGDEMOTE_DIRECT,
+	PGDEMOTE_KHUGEPAGED,
 };
 
 static const unsigned int memcg_stat_items[] = {
@@ -437,6 +443,11 @@ static const unsigned int memcg_vm_event_stat[] = {
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
@@ -978,6 +989,24 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
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
@@ -1383,6 +1412,13 @@ static const struct memory_stat memory_stats[] = {
 	{ "workingset_restore_anon",	WORKINGSET_RESTORE_ANON		},
 	{ "workingset_restore_file",	WORKINGSET_RESTORE_FILE		},
 	{ "workingset_nodereclaim",	WORKINGSET_NODERECLAIM		},
+
+	{ "pgdemote_kswapd",		PGDEMOTE_KSWAPD		},
+	{ "pgdemote_direct",		PGDEMOTE_DIRECT		},
+	{ "pgdemote_khugepaged",	PGDEMOTE_KHUGEPAGED	},
+#ifdef CONFIG_NUMA_BALANCING
+	{ "pgpromote_success",		PGPROMOTE_SUCCESS	},
+#endif
 };
 
 /* The actual unit of the state item, not the same as the output unit */
@@ -1407,6 +1443,9 @@ static int memcg_page_state_output_unit(int item)
 	/*
 	 * Workingset state is actually in pages, but we export it to userspace
 	 * as a scalar count of events, so special case it here.
+	 *
+	 * Demotion and promotion activities are exported in pages, consistent
+	 * with their global counterparts.
 	 */
 	switch (item) {
 	case WORKINGSET_REFAULT_ANON:
@@ -1416,6 +1455,12 @@ static int memcg_page_state_output_unit(int item)
 	case WORKINGSET_RESTORE_ANON:
 	case WORKINGSET_RESTORE_FILE:
 	case WORKINGSET_NODERECLAIM:
+	case PGDEMOTE_KSWAPD:
+	case PGDEMOTE_DIRECT:
+	case PGDEMOTE_KHUGEPAGED:
+#ifdef CONFIG_NUMA_BALANCING
+	case PGPROMOTE_SUCCESS:
+#endif
 		return 1;
 	default:
 		return memcg_page_state_unit(item);
diff --git a/mm/memory.c b/mm/memory.c
index 0ed3603aaf31..13b679ad182c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5400,6 +5400,9 @@ int numa_migrate_check(struct folio *folio, struct vm_fault *vmf,
 	vma_set_access_pid_bit(vma);
 
 	count_vm_numa_event(NUMA_HINT_FAULTS);
+#ifdef CONFIG_NUMA_BALANCING
+	count_memcg_folio_events(folio, NUMA_HINT_FAULTS, 1);
+#endif
 	if (folio_nid(folio) == numa_node_id()) {
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
index 6e32098ac2dc..dbfa910ec24b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2668,6 +2668,8 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 	int nr_remaining;
 	unsigned int nr_succeeded;
 	LIST_HEAD(migratepages);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
 	list_add(&folio->lru, &migratepages);
 	nr_remaining = migrate_pages(&migratepages, alloc_misplaced_dst_folio,
@@ -2677,12 +2679,13 @@ int migrate_misplaced_folio(struct folio *folio, struct vm_area_struct *vma,
 		putback_movable_pages(&migratepages);
 	if (nr_succeeded) {
 		count_vm_numa_events(NUMA_PAGE_MIGRATE, nr_succeeded);
+		count_memcg_events(memcg, NUMA_PAGE_MIGRATE, nr_succeeded);
 		if ((sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
 		    && !node_is_toptier(folio_nid(folio))
 		    && node_is_toptier(node))
-			mod_node_page_state(pgdat, PGPROMOTE_SUCCESS,
-					    nr_succeeded);
+			mod_lruvec_state(lruvec, PGPROMOTE_SUCCESS, nr_succeeded);
 	}
+	mem_cgroup_put(memcg);
 	BUG_ON(!list_empty(&migratepages));
 	return nr_remaining ? -EAGAIN : 0;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index da6ba3206827..a118a55bbed5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1018,9 +1018,6 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);
 
-	mod_node_page_state(pgdat, PGDEMOTE_KSWAPD + reclaimer_offset(),
-			    nr_succeeded);
-
 	return nr_succeeded;
 }
 
@@ -1519,7 +1516,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */
 
 	/* Migrate folios selected for demotion */
-	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
+	stat->nr_demoted = demote_folio_list(&demote_folios, pgdat);
+	nr_reclaimed += stat->nr_demoted;
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
 		/* Folios which weren't demoted go back on @folio_list */
@@ -1985,6 +1983,8 @@ static unsigned long shrink_inactive_list(unsigned long nr_to_scan,
 	spin_lock_irq(&lruvec->lru_lock);
 	move_folios_to_lru(lruvec, &folio_list);
 
+	__mod_lruvec_state(lruvec, PGDEMOTE_KSWAPD + reclaimer_offset(),
+					stat.nr_demoted);
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = PGSTEAL_KSWAPD + reclaimer_offset();
 	if (!cgroup_reclaim(sc))
-- 
2.43.0


