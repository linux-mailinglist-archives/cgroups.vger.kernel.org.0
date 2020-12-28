Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4392E68EA
	for <lists+cgroups@lfdr.de>; Mon, 28 Dec 2020 17:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634497AbgL1QnJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Dec 2020 11:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634481AbgL1QnG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Dec 2020 11:43:06 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83BAC0617A1
        for <cgroups@vger.kernel.org>; Mon, 28 Dec 2020 08:42:00 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id j1so5883703pld.3
        for <cgroups@vger.kernel.org>; Mon, 28 Dec 2020 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hr2f4RExR2PrTJqAzW0crUOFygEtErY+YiZgtTonA30=;
        b=WShLKtO7qhLzaSlZiMFOZfj6gmx40TVIMKc4Velmjvbi3dCPaqdj0nqotQA7ZfaL+G
         aJA4g4P/QBhJiDnwNY3fAoAMwfgwKtoUia/hOoWxfUCVJlxxEJ7X0yA9gAJKvKPPKNJl
         qIxczo2EDqHiaowtjaWgkzA5kHLTT2gqTEP+NS8eGKIl/CCi8gNibuXXhsvmGEj2RGo6
         ly5zLtgvrPFnii0hNuPU6w7Bq4XhNWjKB7J8TWNCG3UOUU7JXgLbFfuYj96RaLjoohXo
         G9tEDeTBRlbmOYaR/jpQViXWrm8byzCdQOH3ZPkb7mKHIRqYQ1LJ0CE1d9yUOv2z3YHo
         UBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hr2f4RExR2PrTJqAzW0crUOFygEtErY+YiZgtTonA30=;
        b=CJfyORcrFFz8T1kX3xPlVj6E2xsA/RI2Ug5htJS9yC53xngibL7/RnzHR7QzHAXCTJ
         MKAyXd1Z57eZ8esAr0ES8ridImJL7PIX0J5HexaoVfrg0sSGsVdLr32NKpN0CBeVPIku
         ANAZ4VRr2uIpx907CCqibZk3kLjm9VdlwIbI6aYVqtg7DRdgJKsWBDMzSIwjDnH6MX72
         VIDbWuerDegVN5hWTibOsKM9cCJWxTRr72lFAY6VPJUkX+NiTov2NXeds+5dGClgGQd+
         OcBOWVcJtETlkrqrdvbh42JHo9G7LQTfwTWxDcp+uiKZjPJ7VRAKYwJa1nQjz+KOUggY
         oSqA==
X-Gm-Message-State: AOAM533uTpXA1SQYCv15Myx96OIdi31qiOlajMHxiHkcfawE9aZLxPqE
        Ope5y/73RZYv+bKSbOz7eKLdWA==
X-Google-Smtp-Source: ABdhPJwiyVTnudoroU6Ge5cG1q5hs8Rxs4J7eAGjim8APv3Kcs5AA1MuuQlHqc4+GnE+AncsnS4Yfg==
X-Received: by 2002:a17:902:bc47:b029:da:cbd5:dbdf with SMTP id t7-20020a170902bc47b02900dacbd5dbdfmr23260322plz.77.1609173720169;
        Mon, 28 Dec 2020 08:42:00 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id r68sm36686306pfr.113.2020.12.28.08.41.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Dec 2020 08:41:59 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org, adobriyan@gmail.com,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, hughd@google.com, shakeelb@google.com,
        guro@fb.com, samitolvanen@google.com, feng.tang@intel.com,
        neilb@suse.de, iamjoonsoo.kim@lge.com, rdunlap@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 2/7] mm: memcontrol: convert NR_ANON_THPS account to pages
Date:   Tue, 29 Dec 2020 00:41:05 +0800
Message-Id: <20201228164110.2838-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201228164110.2838-1-songmuchun@bytedance.com>
References: <20201228164110.2838-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently we use struct per_cpu_nodestat to cache the vmstat
counters, which leads to inaccurate statistics especially THP
vmstat counters. In the systems with hundreds of processors
it can be GBs of memory. For example, for a 96 CPUs system,
the threshold is the maximum number of 125. And the per cpu
counters can cache 23.4375 GB in total.

The THP page is already a form of batched addition (it will
add 512 worth of memory in one go) so skipping the batching
seems like sensible. Although every THP stats update overflows
the per-cpu counter, resorting to atomic global updates. But
it can make the statistics more accuracy for the THP vmstat
counters.

So we convert the NR_ANON_THPS account to pages. This patch
is consistent with 8f182270dfec ("mm/swap.c: flush lru pvecs
on compound page arrival"). Doing this also can make the unit
of vmstat counters more unified. Finally, the unit of the vmstat
counters are pages, kB and bytes. The B/KB suffix can tell us
that the unit is bytes or kB. The rest which is without suffix
are pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 drivers/base/node.c    | 15 +++++++++------
 fs/proc/meminfo.c      |  2 +-
 include/linux/mmzone.h | 13 +++++++++++++
 mm/huge_memory.c       |  3 ++-
 mm/memcontrol.c        | 20 ++++++--------------
 mm/page_alloc.c        |  2 +-
 mm/rmap.c              |  6 +++---
 mm/vmstat.c            | 11 +++++++++--
 8 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 04f71c7bc3f8..6da0c3508bc9 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -461,8 +461,7 @@ static ssize_t node_read_meminfo(struct device *dev,
 			     nid, K(sunreclaimable)
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			     ,
-			     nid, K(node_page_state(pgdat, NR_ANON_THPS) *
-				    HPAGE_PMD_NR),
+			     nid, K(node_page_state(pgdat, NR_ANON_THPS)),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_THPS) *
 				    HPAGE_PMD_NR),
 			     nid, K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED) *
@@ -519,10 +518,14 @@ static ssize_t node_read_vmstat(struct device *dev,
 				     sum_zone_numa_state(nid, i));
 
 #endif
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-		len += sysfs_emit_at(buf, len, "%s %lu\n",
-				     node_stat_name(i),
-				     node_page_state_pages(pgdat, i));
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+		unsigned long pages = node_page_state_pages(pgdat, i);
+
+		if (vmstat_item_print_in_thp(i))
+			pages /= HPAGE_PMD_NR;
+		len += sysfs_emit_at(buf, len, "%s %lu\n", node_stat_name(i),
+				     pages);
+	}
 
 	return len;
 }
diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
index d6fc74619625..a635c8a84ddf 100644
--- a/fs/proc/meminfo.c
+++ b/fs/proc/meminfo.c
@@ -129,7 +129,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	show_val_kb(m, "AnonHugePages:  ",
-		    global_node_page_state(NR_ANON_THPS) * HPAGE_PMD_NR);
+		    global_node_page_state(NR_ANON_THPS));
 	show_val_kb(m, "ShmemHugePages: ",
 		    global_node_page_state(NR_SHMEM_THPS) * HPAGE_PMD_NR);
 	show_val_kb(m, "ShmemPmdMapped: ",
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..67d50ef5dd20 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -210,6 +210,19 @@ enum node_stat_item {
 };
 
 /*
+ * Returns true if the item should be printed in THPs (/proc/vmstat
+ * currently prints number of anon, file and shmem THPs. But the item
+ * is charged in pages).
+ */
+static __always_inline bool vmstat_item_print_in_thp(enum node_stat_item item)
+{
+	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
+		return false;
+
+	return item == NR_ANON_THPS;
+}
+
+/*
  * Returns true if the value is measured in bytes (most vmstat values are
  * measured in pages). This defines the API part, the internal representation
  * might be different.
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 10dd3cae5f53..66ec454120de 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2178,7 +2178,8 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 		lock_page_memcg(page);
 		if (atomic_add_negative(-1, compound_mapcount_ptr(page))) {
 			/* Last compound_mapcount is gone. */
-			__dec_lruvec_page_state(page, NR_ANON_THPS);
+			__mod_lruvec_page_state(page, NR_ANON_THPS,
+						-HPAGE_PMD_NR);
 			if (TestClearPageDoubleMap(page)) {
 				/* No need in mapcount reference anymore */
 				for (i = 0; i < HPAGE_PMD_NR; i++)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8818bf64d6fe..b18e25a5cdf3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1532,7 +1532,7 @@ static struct memory_stat memory_stats[] = {
 	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
 	 * constant(e.g. powerpc).
 	 */
-	{ "anon_thp", 0, NR_ANON_THPS },
+	{ "anon_thp", PAGE_SIZE, NR_ANON_THPS },
 	{ "file_thp", 0, NR_FILE_THPS },
 	{ "shmem_thp", 0, NR_SHMEM_THPS },
 #endif
@@ -1565,8 +1565,7 @@ static int __init memory_stats_init(void)
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memory_stats[i].idx == NR_ANON_THPS ||
-		    memory_stats[i].idx == NR_FILE_THPS ||
+		if (memory_stats[i].idx == NR_FILE_THPS ||
 		    memory_stats[i].idx == NR_SHMEM_THPS)
 			memory_stats[i].ratio = HPAGE_PMD_SIZE;
 #endif
@@ -4088,10 +4087,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state_local(memcg, memcg1_stats[i]);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memcg1_stats[i] == NR_ANON_THPS)
-			nr *= HPAGE_PMD_NR;
-#endif
 		seq_printf(m, "%s %lu\n", memcg1_stat_names[i], nr * PAGE_SIZE);
 	}
 
@@ -4122,10 +4117,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
 			continue;
 		nr = memcg_page_state(memcg, memcg1_stats[i]);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		if (memcg1_stats[i] == NR_ANON_THPS)
-			nr *= HPAGE_PMD_NR;
-#endif
 		seq_printf(m, "total_%s %llu\n", memcg1_stat_names[i],
 						(u64)nr * PAGE_SIZE);
 	}
@@ -5653,10 +5644,11 @@ static int mem_cgroup_move_account(struct page *page,
 			__mod_lruvec_state(from_vec, NR_ANON_MAPPED, -nr_pages);
 			__mod_lruvec_state(to_vec, NR_ANON_MAPPED, nr_pages);
 			if (PageTransHuge(page)) {
-				__dec_lruvec_state(from_vec, NR_ANON_THPS);
-				__inc_lruvec_state(to_vec, NR_ANON_THPS);
+				__mod_lruvec_state(from_vec, NR_ANON_THPS,
+						   -nr_pages);
+				__mod_lruvec_state(to_vec, NR_ANON_THPS,
+						   nr_pages);
 			}
-
 		}
 	} else {
 		__mod_lruvec_state(from_vec, NR_FILE_PAGES, -nr_pages);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 469e28f95ce7..1700f52b7869 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5580,7 +5580,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 			K(node_page_state(pgdat, NR_SHMEM_THPS) * HPAGE_PMD_NR),
 			K(node_page_state(pgdat, NR_SHMEM_PMDMAPPED)
 					* HPAGE_PMD_NR),
-			K(node_page_state(pgdat, NR_ANON_THPS) * HPAGE_PMD_NR),
+			K(node_page_state(pgdat, NR_ANON_THPS)),
 #endif
 			K(node_page_state(pgdat, NR_WRITEBACK_TEMP)),
 			node_page_state(pgdat, NR_KERNEL_STACK_KB),
diff --git a/mm/rmap.c b/mm/rmap.c
index 08c56aaf72eb..c4d5c63cfd29 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1144,7 +1144,7 @@ void do_page_add_anon_rmap(struct page *page,
 		 * disabled.
 		 */
 		if (compound)
-			__inc_lruvec_page_state(page, NR_ANON_THPS);
+			__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 		__mod_lruvec_page_state(page, NR_ANON_MAPPED, nr);
 	}
 
@@ -1186,7 +1186,7 @@ void page_add_new_anon_rmap(struct page *page,
 		if (hpage_pincount_available(page))
 			atomic_set(compound_pincount_ptr(page), 0);
 
-		__inc_lruvec_page_state(page, NR_ANON_THPS);
+		__mod_lruvec_page_state(page, NR_ANON_THPS, nr);
 	} else {
 		/* Anon THP always mapped first with PMD */
 		VM_BUG_ON_PAGE(PageTransCompound(page), page);
@@ -1292,7 +1292,7 @@ static void page_remove_anon_compound_rmap(struct page *page)
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
 		return;
 
-	__dec_lruvec_page_state(page, NR_ANON_THPS);
+	__mod_lruvec_page_state(page, NR_ANON_THPS, -thp_nr_pages(page));
 
 	if (TestClearPageDoubleMap(page)) {
 		/*
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 663f49ed1fd6..37c9e7b21e1e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1624,8 +1624,12 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 	if (is_zone_first_populated(pgdat, zone)) {
 		seq_printf(m, "\n  per-node stats");
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			unsigned long pages = node_page_state_pages(pgdat, i);
+
+			if (vmstat_item_print_in_thp(i))
+				pages /= HPAGE_PMD_NR;
 			seq_printf(m, "\n      %-12s %lu", node_stat_name(i),
-				   node_page_state_pages(pgdat, i));
+				   pages);
 		}
 	}
 	seq_printf(m,
@@ -1745,8 +1749,11 @@ static void *vmstat_start(struct seq_file *m, loff_t *pos)
 	v += NR_VM_NUMA_STAT_ITEMS;
 #endif
 
-	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+	for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 		v[i] = global_node_page_state_pages(i);
+		if (vmstat_item_print_in_thp(i))
+			v[i] /= HPAGE_PMD_NR;
+	}
 	v += NR_VM_NODE_STAT_ITEMS;
 
 	global_dirty_limits(v + NR_DIRTY_BG_THRESHOLD,
-- 
2.11.0

