Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC90026C151
	for <lists+cgroups@lfdr.de>; Wed, 16 Sep 2020 12:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgIPKBq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 16 Sep 2020 06:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgIPKAu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 16 Sep 2020 06:00:50 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9BEC06178B
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 03:00:49 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bg9so2916926plb.2
        for <cgroups@vger.kernel.org>; Wed, 16 Sep 2020 03:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoQEbACqPpIQFJXy8AjmoFdfb7CHFu7qQo7ReK9lH5I=;
        b=gdxBfrw/6tT1KxkKel3eKzqD4TKLrbFonOp8M84nJS5ZzIyUFnVMpjUBSGHOFuyKLf
         vIt0VPz5bxW9DhRDUa34CYp4xWePpb529qHSa1zCi+6dajcKV3GPD6DmZfRsv+9eY8g3
         5N6hAyyyaKrm1x76soY3roDjGkMBd2FWZvbI3quRNXs8+soPx0tAV+gXBds1DT9eoZiI
         dB47/ZBPmXZh38avhng6R75O/YUDDxWyFzADaGkUr66zEyHeMul3Cp04m1EwSw6UXA25
         1dN7+Lu8c9SVeLM/oeVN6NUGMTDvErZMaEVGPy7z+6Q7yPS9TTZfXAkDPdDcwwHjLUjt
         +V6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoQEbACqPpIQFJXy8AjmoFdfb7CHFu7qQo7ReK9lH5I=;
        b=thbe+EGRv7lkuFRV0+fJRIlk6SKO+AWx81xtjm6ksLU/Z0Rut+R8feaT0xjQj/gSni
         I+vAn7Hjs03mwhqSZfzflKe96p4rRHbYAqJsAHdnsZo6EeOkCas6tlrjKUQkuTPM1s1g
         ts0wwRE4xRSsXYGWnn1I6A+MlMvEeYIDXm1YifpPfvYb/u7lCuXJzfj2f+R1s+yiMtF1
         05tauXg9mmrPW/gFwpvN1lJa9mrbfMDEZ10WGQHQBLSnXPsT++LODlGa22aD+9KPQmwL
         D2QX6Rcih9JCsP051pc2gZoMdrQmnDIK9x7bO7RuEODCR72Fp152RYzZNORtkQbMjyAY
         kPHw==
X-Gm-Message-State: AOAM5316XzXphxN3XQU2PeXuxnA5u7y6hBc6fUOHtLJCQojqgCYG/Bem
        LqcOdFdVJa2r9mcOEY1sohHodg==
X-Google-Smtp-Source: ABdhPJwvBMPG+fof5KCgRbuyKgJHh5rtj8uiOEMrn1N7Yzabp/Oq+YMtm++BhmnmNLuDaYWI3kzJcQ==
X-Received: by 2002:a17:90a:b387:: with SMTP id e7mr3351815pjr.228.1600250449072;
        Wed, 16 Sep 2020 03:00:49 -0700 (PDT)
Received: from bogon.bytedance.net ([103.136.220.68])
        by smtp.gmail.com with ESMTPSA id y3sm17205748pfb.18.2020.09.16.03.00.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 03:00:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        rdunlap@infradead.org
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 2/2] mm: memcontrol: Add the missing numa_stat interface for cgroup v2
Date:   Wed, 16 Sep 2020 18:00:30 +0800
Message-Id: <20200916100030.71698-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200916100030.71698-1-songmuchun@bytedance.com>
References: <20200916100030.71698-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the cgroup v1, we have a numa_stat interface. This is useful for
providing visibility into the numa locality information within an
memcg since the pages are allowed to be allocated from any physical
node. One of the use cases is evaluating application performance by
combining this information with the application's CPU allocation.
But the cgroup v2 does not. So this patch adds the missing information.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Suggested-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
 changelog in v6:
 1. Rework memory_stat_format() to reuse the same shared table of memory_stats.
 2. Update documentation.

 changelog in v5:
 1. Fix small nits pointed out by Shakeel Butt

 changelog in v4:
 1. Fix some document problems pointed out by Randy Dunlap.
 2. Remove memory_numa_stat_format() suggested by Shakeel Butt.

 changelog in v3:
 1. Fix compiler error on powerpc architecture reported by kernel test robot.
 2. Fix a typo from "anno" to "anon".

 changelog in v2:
 1. Add memory.numa_stat interface in cgroup v2.

 Documentation/admin-guide/cgroup-v2.rst |  69 +++++++---
 mm/memcontrol.c                         | 170 +++++++++++++++---------
 2 files changed, 159 insertions(+), 80 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index baa07b30845e..608d7c279396 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1259,6 +1259,10 @@ PAGE_SIZE multiple when read back.
 	can show up in the middle. Don't rely on items remaining in a
 	fixed position; use the keys to look up specific values!
 
+	If the entry has no per-node counter(or not show in the
+	mempry.numa_stat). We use 'npn'(non-per-node) as the tag
+	to indicate that it will not show in the mempry.numa_stat.
+
 	  anon
 		Amount of memory used in anonymous mappings such as
 		brk(), sbrk(), and mmap(MAP_ANONYMOUS)
@@ -1270,15 +1274,11 @@ PAGE_SIZE multiple when read back.
 	  kernel_stack
 		Amount of memory allocated to kernel stacks.
 
-	  slab
-		Amount of memory used for storing in-kernel data
-		structures.
-
-	  percpu
+	  percpu(npn)
 		Amount of memory used for storing per-cpu kernel
 		data structures.
 
-	  sock
+	  sock(npn)
 		Amount of memory used in network transmission buffers
 
 	  shmem
@@ -1318,11 +1318,9 @@ PAGE_SIZE multiple when read back.
 		Part of "slab" that cannot be reclaimed on memory
 		pressure.
 
-	  pgfault
-		Total number of page faults incurred
-
-	  pgmajfault
-		Number of major page faults incurred
+	  slab(npn)
+		Amount of memory used for storing in-kernel data
+		structures.
 
 	  workingset_refault_anon
 		Number of refaults of previously evicted anonymous pages.
@@ -1348,37 +1346,68 @@ PAGE_SIZE multiple when read back.
 	  workingset_nodereclaim
 		Number of times a shadow node has been reclaimed
 
-	  pgrefill
+	  pgfault(npn)
+		Total number of page faults incurred
+
+	  pgmajfault(npn)
+		Number of major page faults incurred
+
+	  pgrefill(npn)
 		Amount of scanned pages (in an active LRU list)
 
-	  pgscan
+	  pgscan(npn)
 		Amount of scanned pages (in an inactive LRU list)
 
-	  pgsteal
+	  pgsteal(npn)
 		Amount of reclaimed pages
 
-	  pgactivate
+	  pgactivate(npn)
 		Amount of pages moved to the active LRU list
 
-	  pgdeactivate
+	  pgdeactivate(npn)
 		Amount of pages moved to the inactive LRU list
 
-	  pglazyfree
+	  pglazyfree(npn)
 		Amount of pages postponed to be freed under memory pressure
 
-	  pglazyfreed
+	  pglazyfreed(npn)
 		Amount of reclaimed lazyfree pages
 
-	  thp_fault_alloc
+	  thp_fault_alloc(npn)
 		Number of transparent hugepages which were allocated to satisfy
 		a page fault. This counter is not present when CONFIG_TRANSPARENT_HUGEPAGE
                 is not set.
 
-	  thp_collapse_alloc
+	  thp_collapse_alloc(npn)
 		Number of transparent hugepages which were allocated to allow
 		collapsing an existing range of pages. This counter is not
 		present when CONFIG_TRANSPARENT_HUGEPAGE is not set.
 
+  memory.numa_stat
+	A read-only nested-keyed file which exists on non-root cgroups.
+
+	This breaks down the cgroup's memory footprint into different
+	types of memory, type-specific details, and other information
+	per node on the state of the memory management system.
+
+	This is useful for providing visibility into the NUMA locality
+	information within an memcg since the pages are allowed to be
+	allocated from any physical node. One of the use case is evaluating
+	application performance by combining this information with the
+	application's CPU allocation.
+
+	All memory amounts are in bytes.
+
+	The output format of memory.numa_stat is::
+
+	  type N0=<bytes in node 0> N1=<bytes in node 1> ...
+
+	The entries are ordered to be human readable, and new entries
+	can show up in the middle. Don't rely on items remaining in a
+	fixed position; use the keys to look up specific values!
+
+	The entries can refer to the memory.stat.
+
   memory.swap.current
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0e85a054017f..711bdb217bdb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1492,6 +1492,70 @@ static bool mem_cgroup_wait_acct_move(struct mem_cgroup *memcg)
 	return false;
 }
 
+struct memory_stat {
+	const char *name;
+	unsigned int ratio;
+	unsigned int idx;
+};
+
+static struct memory_stat memory_stats[] = {
+	{ "anon", PAGE_SIZE, NR_ANON_MAPPED },
+	{ "file", PAGE_SIZE, NR_FILE_PAGES },
+	{ "kernel_stack", 1024, NR_KERNEL_STACK_KB },
+	{ "percpu", 1, MEMCG_PERCPU_B },
+	{ "sock", PAGE_SIZE, MEMCG_SOCK },
+	{ "shmem", PAGE_SIZE, NR_SHMEM },
+	{ "file_mapped", PAGE_SIZE, NR_FILE_MAPPED },
+	{ "file_dirty", PAGE_SIZE, NR_FILE_DIRTY },
+	{ "file_writeback", PAGE_SIZE, NR_WRITEBACK },
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	/*
+	 * The ratio will be initialized in memory_stats_init(). Because
+	 * on some architectures, the macro of HPAGE_PMD_SIZE is not
+	 * constant(e.g. powerpc).
+	 */
+	{ "anon_thp", 0, NR_ANON_THPS },
+#endif
+	{ "inactive_anon", PAGE_SIZE, NR_INACTIVE_ANON },
+	{ "active_anon", PAGE_SIZE, NR_ACTIVE_ANON },
+	{ "inactive_file", PAGE_SIZE, NR_INACTIVE_FILE },
+	{ "active_file", PAGE_SIZE, NR_ACTIVE_FILE },
+	{ "unevictable", PAGE_SIZE, NR_UNEVICTABLE },
+
+	/*
+	 * Note: The slab_reclaimable and slab_unreclaimable must be
+	 * together and slab_reclaimable must be in front.
+	 */
+	{ "slab_reclaimable", 1, NR_SLAB_RECLAIMABLE_B },
+	{ "slab_unreclaimable", 1, NR_SLAB_UNRECLAIMABLE_B },
+
+	/* The memory events */
+	{ "workingset_refault_anon", 1, WORKINGSET_REFAULT_ANON },
+	{ "workingset_refault_file", 1, WORKINGSET_REFAULT_FILE },
+	{ "workingset_activate_anon", 1, WORKINGSET_ACTIVATE_ANON },
+	{ "workingset_activate_file", 1, WORKINGSET_ACTIVATE_FILE },
+	{ "workingset_restore_anon", 1, WORKINGSET_RESTORE_ANON },
+	{ "workingset_restore_file", 1, WORKINGSET_RESTORE_FILE },
+	{ "workingset_nodereclaim", 1, WORKINGSET_NODERECLAIM },
+};
+
+static int __init memory_stats_init(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+		if (memory_stats[i].idx == NR_ANON_THPS)
+			memory_stats[i].ratio = HPAGE_PMD_SIZE;
+#endif
+		VM_BUG_ON(!memory_stats[i].ratio);
+		VM_BUG_ON(memory_stats[i].idx >= MEMCG_NR_STAT);
+	}
+
+	return 0;
+}
+pure_initcall(memory_stats_init);
+
 static char *memory_stat_format(struct mem_cgroup *memcg)
 {
 	struct seq_buf s;
@@ -1512,52 +1576,19 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	 * Current memory state:
 	 */
 
-	seq_buf_printf(&s, "anon %llu\n",
-		       (u64)memcg_page_state(memcg, NR_ANON_MAPPED) *
-		       PAGE_SIZE);
-	seq_buf_printf(&s, "file %llu\n",
-		       (u64)memcg_page_state(memcg, NR_FILE_PAGES) *
-		       PAGE_SIZE);
-	seq_buf_printf(&s, "kernel_stack %llu\n",
-		       (u64)memcg_page_state(memcg, NR_KERNEL_STACK_KB) *
-		       1024);
-	seq_buf_printf(&s, "slab %llu\n",
-		       (u64)(memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
-			     memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B)));
-	seq_buf_printf(&s, "percpu %llu\n",
-		       (u64)memcg_page_state(memcg, MEMCG_PERCPU_B));
-	seq_buf_printf(&s, "sock %llu\n",
-		       (u64)memcg_page_state(memcg, MEMCG_SOCK) *
-		       PAGE_SIZE);
-
-	seq_buf_printf(&s, "shmem %llu\n",
-		       (u64)memcg_page_state(memcg, NR_SHMEM) *
-		       PAGE_SIZE);
-	seq_buf_printf(&s, "file_mapped %llu\n",
-		       (u64)memcg_page_state(memcg, NR_FILE_MAPPED) *
-		       PAGE_SIZE);
-	seq_buf_printf(&s, "file_dirty %llu\n",
-		       (u64)memcg_page_state(memcg, NR_FILE_DIRTY) *
-		       PAGE_SIZE);
-	seq_buf_printf(&s, "file_writeback %llu\n",
-		       (u64)memcg_page_state(memcg, NR_WRITEBACK) *
-		       PAGE_SIZE);
-
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	seq_buf_printf(&s, "anon_thp %llu\n",
-		       (u64)memcg_page_state(memcg, NR_ANON_THPS) *
-		       HPAGE_PMD_SIZE);
-#endif
+	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
+		u64 size;
 
-	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),
-			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
-			       PAGE_SIZE);
+		size = memcg_page_state(memcg, memory_stats[i].idx);
+		size *= memory_stats[i].ratio;
+		seq_buf_printf(&s, "%s %llu\n", memory_stats[i].name, size);
 
-	seq_buf_printf(&s, "slab_reclaimable %llu\n",
-		       (u64)memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B));
-	seq_buf_printf(&s, "slab_unreclaimable %llu\n",
-		       (u64)memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B));
+		if (unlikely(memory_stats[i].idx == NR_SLAB_UNRECLAIMABLE_B)) {
+			size = memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B) +
+			       memcg_page_state(memcg, NR_SLAB_UNRECLAIMABLE_B);
+			seq_buf_printf(&s, "slab %llu\n", size);
+		}
+	}
 
 	/* Accumulated memory events */
 
@@ -1565,22 +1596,6 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       memcg_events(memcg, PGFAULT));
 	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
 		       memcg_events(memcg, PGMAJFAULT));
-
-	seq_buf_printf(&s, "workingset_refault_anon %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_REFAULT_ANON));
-	seq_buf_printf(&s, "workingset_refault_file %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_REFAULT_FILE));
-	seq_buf_printf(&s, "workingset_activate_anon %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_ANON));
-	seq_buf_printf(&s, "workingset_activate_file %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_ACTIVATE_FILE));
-	seq_buf_printf(&s, "workingset_restore_anon %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_RESTORE_ANON));
-	seq_buf_printf(&s, "workingset_restore_file %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_RESTORE_FILE));
-	seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
-		       memcg_page_state(memcg, WORKINGSET_NODERECLAIM));
-
 	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
 		       memcg_events(memcg, PGREFILL));
 	seq_buf_printf(&s, "pgscan %lu\n",
@@ -6425,6 +6440,35 @@ static int memory_stat_show(struct seq_file *m, void *v)
 	return 0;
 }
 
+#ifdef CONFIG_NUMA
+static int memory_numa_stat_show(struct seq_file *m, void *v)
+{
+	int i;
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+
+	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
+		int nid;
+
+		if (memory_stats[i].idx >= NR_VM_NODE_STAT_ITEMS)
+			continue;
+
+		seq_printf(m, "%s", memory_stats[i].name);
+		for_each_node_state(nid, N_MEMORY) {
+			u64 size;
+			struct lruvec *lruvec;
+
+			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+			size = lruvec_page_state(lruvec, memory_stats[i].idx);
+			size *= memory_stats[i].ratio;
+			seq_printf(m, " N%d=%llu", nid, size);
+		}
+		seq_putc(m, '\n');
+	}
+
+	return 0;
+}
+#endif
+
 static int memory_oom_group_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -6502,6 +6546,12 @@ static struct cftype memory_files[] = {
 		.name = "stat",
 		.seq_show = memory_stat_show,
 	},
+#ifdef CONFIG_NUMA
+	{
+		.name = "numa_stat",
+		.seq_show = memory_numa_stat_show,
+	},
+#endif
 	{
 		.name = "oom.group",
 		.flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
-- 
2.20.1

