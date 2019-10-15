Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E564D71C1
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2019 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfJOJCK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Oct 2019 05:02:10 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:50278 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727838AbfJOJCJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Oct 2019 05:02:09 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 0B5762E14E2;
        Tue, 15 Oct 2019 12:02:06 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id oIq2cXkIR9-25qKoYea;
        Tue, 15 Oct 2019 12:02:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1571130125; bh=1aq0pVoTzlDnzXJ1d6ME0b2po+bbeLYJMa32BOa4Uzs=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=dFoY6Mbv7lkY3dqBTxfNtO6WxztXVf8vh0W3zhA6EqWINXorGsGi/oIrgpzuXF1KB
         KBElDLYGa9wj3ehn5Ks6WIvuYt8CfV4XcC2qHJfEP5QNneWCuaf6x0OH3VXkyV/6QV
         56uKhB0CElNd6zWODPKq5/+KfYwyV8gTnVuf4UKw=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:3d4d:a9cb:ef29:4bb1])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id or88dzfQpo-25HmHwwC;
        Tue, 15 Oct 2019 12:02:05 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: [PATCH 2/2] mm/memcontrol: use vmstat names for printing statistics
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Date:   Tue, 15 Oct 2019 12:02:05 +0300
Message-ID: <157113012508.453.80391533767219371.stgit@buzz>
In-Reply-To: <157113012325.453.562783073839432766.stgit@buzz>
References: <157113012325.453.562783073839432766.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Use common names from vmstat array when possible.
This gives not much difference in code size for now,
but should help in keeping interfaces consistent.

add/remove: 0/2 grow/shrink: 2/0 up/down: 70/-72 (-2)
Function                                     old     new   delta
memory_stat_format                           984    1050     +66
memcg_stat_show                              957     961      +4
memcg1_event_names                            32       -     -32
mem_cgroup_lru_names                          40       -     -40
Total: Before=14485337, After=14485335, chg -0.00%

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/vmstat.h |    4 ++--
 mm/memcontrol.c        |   52 ++++++++++++++++++++----------------------------
 mm/vmstat.c            |    9 +++++---
 3 files changed, 29 insertions(+), 36 deletions(-)

diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index b995d8b680c2..292485f3d24d 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -420,7 +420,7 @@ static inline const char *writeback_stat_name(enum writeback_stat_item item)
 			   item];
 }
 
-#ifdef CONFIG_VM_EVENT_COUNTERS
+#if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 static inline const char *vm_event_name(enum vm_event_item item)
 {
 	return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
@@ -429,6 +429,6 @@ static inline const char *vm_event_name(enum vm_event_item item)
 			   NR_VM_WRITEBACK_STAT_ITEMS +
 			   item];
 }
-#endif /* CONFIG_VM_EVENT_COUNTERS */
+#endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 
 #endif /* _LINUX_VMSTAT_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bdac56009a38..e0aff8a81067 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -98,14 +98,6 @@ static bool do_memsw_account(void)
 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && do_swap_account;
 }
 
-static const char *const mem_cgroup_lru_names[] = {
-	"inactive_anon",
-	"active_anon",
-	"inactive_file",
-	"active_file",
-	"unevictable",
-};
-
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 #define NUMAINFO_EVENTS_TARGET	1024
@@ -1438,7 +1430,7 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 		       PAGE_SIZE);
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_buf_printf(&s, "%s %llu\n", mem_cgroup_lru_names[i],
+		seq_buf_printf(&s, "%s %llu\n", lru_list_name(i),
 			       (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
 			       PAGE_SIZE);
 
@@ -1451,8 +1443,10 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 
 	/* Accumulated memory events */
 
-	seq_buf_printf(&s, "pgfault %lu\n", memcg_events(memcg, PGFAULT));
-	seq_buf_printf(&s, "pgmajfault %lu\n", memcg_events(memcg, PGMAJFAULT));
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGFAULT),
+		       memcg_events(memcg, PGFAULT));
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGMAJFAULT),
+		       memcg_events(memcg, PGMAJFAULT));
 
 	seq_buf_printf(&s, "workingset_refault %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_REFAULT));
@@ -1461,22 +1455,27 @@ static char *memory_stat_format(struct mem_cgroup *memcg)
 	seq_buf_printf(&s, "workingset_nodereclaim %lu\n",
 		       memcg_page_state(memcg, WORKINGSET_NODERECLAIM));
 
-	seq_buf_printf(&s, "pgrefill %lu\n", memcg_events(memcg, PGREFILL));
+	seq_buf_printf(&s, "%s %lu\n",  vm_event_name(PGREFILL),
+		       memcg_events(memcg, PGREFILL));
 	seq_buf_printf(&s, "pgscan %lu\n",
 		       memcg_events(memcg, PGSCAN_KSWAPD) +
 		       memcg_events(memcg, PGSCAN_DIRECT));
 	seq_buf_printf(&s, "pgsteal %lu\n",
 		       memcg_events(memcg, PGSTEAL_KSWAPD) +
 		       memcg_events(memcg, PGSTEAL_DIRECT));
-	seq_buf_printf(&s, "pgactivate %lu\n", memcg_events(memcg, PGACTIVATE));
-	seq_buf_printf(&s, "pgdeactivate %lu\n", memcg_events(memcg, PGDEACTIVATE));
-	seq_buf_printf(&s, "pglazyfree %lu\n", memcg_events(memcg, PGLAZYFREE));
-	seq_buf_printf(&s, "pglazyfreed %lu\n", memcg_events(memcg, PGLAZYFREED));
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGACTIVATE),
+		       memcg_events(memcg, PGACTIVATE));
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGDEACTIVATE),
+		       memcg_events(memcg, PGDEACTIVATE));
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREE),
+		       memcg_events(memcg, PGLAZYFREE));
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(PGLAZYFREED),
+		       memcg_events(memcg, PGLAZYFREED));
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	seq_buf_printf(&s, "thp_fault_alloc %lu\n",
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_FAULT_ALLOC),
 		       memcg_events(memcg, THP_FAULT_ALLOC));
-	seq_buf_printf(&s, "thp_collapse_alloc %lu\n",
+	seq_buf_printf(&s, "%s %lu\n", vm_event_name(THP_COLLAPSE_ALLOC),
 		       memcg_events(memcg, THP_COLLAPSE_ALLOC));
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -3849,13 +3848,6 @@ static const unsigned int memcg1_events[] = {
 	PGMAJFAULT,
 };
 
-static const char *const memcg1_event_names[] = {
-	"pgpgin",
-	"pgpgout",
-	"pgfault",
-	"pgmajfault",
-};
-
 static int memcg_stat_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
@@ -3864,7 +3856,6 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 	unsigned int i;
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
-	BUILD_BUG_ON(ARRAY_SIZE(mem_cgroup_lru_names) != NR_LRU_LISTS);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		if (memcg1_stats[i] == MEMCG_SWAP && !do_memsw_account())
@@ -3875,11 +3866,11 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_printf(m, "%s %lu\n", memcg1_event_names[i],
+		seq_printf(m, "%s %lu\n", vm_event_name(memcg1_events[i]),
 			   memcg_events_local(memcg, memcg1_events[i]));
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_printf(m, "%s %lu\n", mem_cgroup_lru_names[i],
+		seq_printf(m, "%s %lu\n", lru_list_name(i),
 			   memcg_page_state_local(memcg, NR_LRU_BASE + i) *
 			   PAGE_SIZE);
 
@@ -3904,11 +3895,12 @@ static int memcg_stat_show(struct seq_file *m, void *v)
 	}
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_events); i++)
-		seq_printf(m, "total_%s %llu\n", memcg1_event_names[i],
+		seq_printf(m, "total_%s %llu\n",
+			   vm_event_name(memcg1_events[i]),
 			   (u64)memcg_events(memcg, memcg1_events[i]));
 
 	for (i = 0; i < NR_LRU_LISTS; i++)
-		seq_printf(m, "total_%s %llu\n", mem_cgroup_lru_names[i],
+		seq_printf(m, "total_%s %llu\n", lru_list_name(i),
 			   (u64)memcg_page_state(memcg, NR_LRU_BASE + i) *
 			   PAGE_SIZE);
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 590aeca27cab..b2fd344d2fcf 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1084,7 +1084,8 @@ int fragmentation_index(struct zone *zone, unsigned int order)
 }
 #endif
 
-#if defined(CONFIG_PROC_FS) || defined(CONFIG_SYSFS) || defined(CONFIG_NUMA)
+#if defined(CONFIG_PROC_FS) || defined(CONFIG_SYSFS) || \
+    defined(CONFIG_NUMA) || defined(CONFIG_MEMCG)
 #ifdef CONFIG_ZONE_DMA
 #define TEXT_FOR_DMA(xx) xx "_dma",
 #else
@@ -1172,7 +1173,7 @@ const char * const vmstat_text[] = {
 	"nr_dirty_threshold",
 	"nr_dirty_background_threshold",
 
-#ifdef CONFIG_VM_EVENT_COUNTERS
+#if defined(CONFIG_VM_EVENT_COUNTERS) || defined(CONFIG_MEMCG)
 	/* enum vm_event_item counters */
 	"pgpgin",
 	"pgpgout",
@@ -1291,9 +1292,9 @@ const char * const vmstat_text[] = {
 	"swap_ra",
 	"swap_ra_hit",
 #endif
-#endif /* CONFIG_VM_EVENTS_COUNTERS */
+#endif /* CONFIG_VM_EVENT_COUNTERS || CONFIG_MEMCG */
 };
-#endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA */
+#endif /* CONFIG_PROC_FS || CONFIG_SYSFS || CONFIG_NUMA || CONFIG_MEMCG */
 
 #if (defined(CONFIG_DEBUG_FS) && defined(CONFIG_COMPACTION)) || \
      defined(CONFIG_PROC_FS)

