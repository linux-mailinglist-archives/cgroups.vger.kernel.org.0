Return-Path: <cgroups+bounces-16020-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNsyLmfiCWo6twQAu9opvQ
	(envelope-from <cgroups+bounces-16020-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:44:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED9256219D
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80A403050A54
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 15:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2653C140D;
	Sun, 17 May 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+zLAs87"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14A3BF69C;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032389; cv=none; b=AnkZdEIOgZDATpb1vgIDFz3tn+zkvRfmSTB2N52zwL6kQ0m1BLyAOuMuC8IWhzCvh1XdkmT8mTemSbD6y4CHeNDUfD6MMYl13GPYHbfPunoGCtllkNQrkmAh1qC9+C055PKJ5ccCHFRZc6NXaFW1QEBjQIcPmpqV+ZzLCyKOc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032389; c=relaxed/simple;
	bh=lhIWzlgO0iPvpJ0krVLf6BdjLRUh5La5OGxJd6WrUXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnzB8rJgxYbKB1IIqNXlnNYkkyQGlhFm4Qmg5mp3pkPagtYSPFfJ5zUKDgUqAO06IntHYvJ3oaqJh+2lmSiEARDTw9HhtRmaxJFST7YvYZaMKVZXwz9hiS2Up351MlxUXP1crgcF607oKdKPxtR/yqJHkDGiRv9x6aRDcJObSus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+zLAs87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C4B8C2BCFA;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032389;
	bh=lhIWzlgO0iPvpJ0krVLf6BdjLRUh5La5OGxJd6WrUXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s+zLAs87NcMDmuQ/5gP0z7QrmStxRQT30D3gBVE/2vt/GEW7Ych1q65eJbLPfD7vh
	 16YmiAnNzweAIjQcU2x4cw6tqfqdSRTTLFPoagaD4jKxF0a+vBM0YbSpS5i0CTPBEl
	 0ByTKsHgKCFncBm1QGSvHr8IxAGZi+J323BF5JmTDyWO8VMjrcH8df6aJ8jqbsdf/g
	 vJD0e0JSRhEl9aZ5u6QUn6CtjerQ/vOAQgL10WJxVtksd6aGPCCf+4p2ZANc35h/fA
	 MASwyErBMHlLwz8QzDz8Knqvh54c53prfAiCXv7PDFpyEUzKPNCGnafZBjcuImHc1T
	 +JM4Yd9hDW76Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E87CD4F47;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sun, 17 May 2026 23:39:49 +0800
Subject: [PATCH v5 10/12] mm/memcg, swap: store cgroup id in cluster table
 directly
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-swap-table-p4-v5-10-88ae43e064c7@tencent.com>
References: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
In-Reply-To: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779032386; l=15426;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=xJcSmosb42r4Bg21YfxGHIrP+RMnEGQrTQryxhKS1qI=;
 b=al/zHgvGHr8jn+tJsgDWfWpr+1zcaDtZs3FVJmmqHvFXBvkTVNipAFp0keDAV00JGczwEi7tW
 E6Y/Voa4o3wABwHgvNm8R61cSCgMrc014uCaVw+LPif+9gLiIbepvYh
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Queue-Id: 1ED9256219D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16020-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org,tencent.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:mid,tencent.com:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Drop the usage of the swap_cgroup_ctrl, and use the dynamic cluster
table instead.

The per-cluster memcg table is 1024 / 512 bytes on most archs, and does
not need RCU protection: the cgroup data is only read and written under
the cluster lock. That keeps things simple, lets the allocation use
plain kmalloc with immediate kfree (no deferred free), and keeps
fragmentation acceptable.

Acked-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h |  6 +++--
 include/linux/swap.h       |  8 +++---
 mm/memcontrol-v1.c         | 42 +++++++++++++++++++-----------
 mm/memcontrol.c            | 13 ++++++----
 mm/swap.h                  |  4 +++
 mm/swap_state.c            |  6 ++---
 mm/swap_table.h            | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/swapfile.c              | 37 ++++++++++++++++++---------
 mm/vmscan.c                |  2 +-
 9 files changed, 139 insertions(+), 43 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a013f37f24aa..bf1a6e131eca 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -29,6 +29,7 @@ struct obj_cgroup;
 struct page;
 struct mm_struct;
 struct kmem_cache;
+struct swap_cluster_info;
 
 /* Cgroup-specific page state, on top of universal node page state */
 enum memcg_stat_item {
@@ -1899,7 +1900,7 @@ static inline void mem_cgroup_exit_user_fault(void)
 	current->in_user_fault = 0;
 }
 
-void __memcg1_swapout(struct folio *folio);
+void __memcg1_swapout(struct folio *folio, struct swap_cluster_info *ci);
 void memcg1_swapin(struct folio *folio);
 
 #else /* CONFIG_MEMCG_V1 */
@@ -1929,7 +1930,8 @@ static inline void mem_cgroup_exit_user_fault(void)
 {
 }
 
-static inline void __memcg1_swapout(struct folio *folio)
+static inline void __memcg1_swapout(struct folio *folio,
+		struct swap_cluster_info *ci)
 {
 }
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6b3acdf9bdd4..203bbe23ba1f 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -584,12 +584,12 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 	return __mem_cgroup_try_charge_swap(folio);
 }
 
-extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
-static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
+extern void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages);
+static inline void mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages)
 {
 	if (mem_cgroup_disabled())
 		return;
-	__mem_cgroup_uncharge_swap(entry, nr_pages);
+	__mem_cgroup_uncharge_swap(id, nr_pages);
 }
 
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
@@ -600,7 +600,7 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 	return 0;
 }
 
-static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
+static inline void mem_cgroup_uncharge_swap(unsigned short id,
 					    unsigned int nr_pages)
 {
 }
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 36c507d81dc5..494e7b9adc60 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -14,6 +14,7 @@
 
 #include "internal.h"
 #include "swap.h"
+#include "swap_table.h"
 #include "memcontrol-v1.h"
 
 /*
@@ -606,14 +607,15 @@ void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 /**
  * __memcg1_swapout - transfer a memsw charge to swap
  * @folio: folio whose memsw charge to transfer
+ * @ci: the locked swap cluster holding the swap entries
  *
  * Transfer the memsw charge of @folio to the swap entry stored in
  * folio->swap.
  *
- * Context: folio must be isolated, unmapped, locked and is just about
- * to be freed, and caller must disable IRQs.
+ * Context: folio must be isolated, unmapped, locked and is just about to
+ * be freed, and caller must disable IRQs and hold the swap cluster lock.
  */
-void __memcg1_swapout(struct folio *folio)
+void __memcg1_swapout(struct folio *folio, struct swap_cluster_info *ci)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
 	struct obj_cgroup *objcg;
@@ -646,7 +648,8 @@ void __memcg1_swapout(struct folio *folio)
 	swap_memcg = mem_cgroup_private_id_get_online(memcg, nr_entries);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
-	swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), folio->swap);
+	__swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_entries,
+			  mem_cgroup_private_id(swap_memcg));
 
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
@@ -661,8 +664,7 @@ void __memcg1_swapout(struct folio *folio)
 	}
 
 	/*
-	 * Interrupts should be disabled here because the caller holds the
-	 * i_pages lock which is taken with interrupts-off. It is
+	 * The caller must hold the swap cluster lock with IRQ off. It is
 	 * important here to have the interrupts disabled because it is the
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
@@ -677,7 +679,7 @@ void __memcg1_swapout(struct folio *folio)
 }
 
 /**
- * memcg1_swapin - uncharge swap slot
+ * memcg1_swapin - uncharge swap slot on swapin
  * @folio: folio being swapped in
  *
  * Call this function after successfully adding the charged
@@ -687,6 +689,10 @@ void __memcg1_swapout(struct folio *folio)
  */
 void memcg1_swapin(struct folio *folio)
 {
+	struct swap_cluster_info *ci;
+	unsigned long nr_pages;
+	unsigned short id;
+
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 
@@ -702,14 +708,20 @@ void memcg1_swapin(struct folio *folio)
 	 * correspond 1:1 to page and swap slot lifetimes: we charge the
 	 * page to memory here, and uncharge swap when the slot is freed.
 	 */
-	if (do_memsw_account()) {
-		/*
-		 * The swap entry might not get freed for a long time,
-		 * let's not wait for it.  The page already received a
-		 * memory+swap charge, drop the swap entry duplicate.
-		 */
-		mem_cgroup_uncharge_swap(folio->swap, folio_nr_pages(folio));
-	}
+	if (!do_memsw_account())
+		return;
+
+	/*
+	 * The swap entry might not get freed for a long time,
+	 * let's not wait for it.  The page already received a
+	 * memory+swap charge, drop the swap entry duplicate.
+	 */
+	nr_pages = folio_nr_pages(folio);
+	ci = swap_cluster_get_and_lock(folio);
+	id = __swap_cgroup_clear(ci, swp_cluster_offset(folio->swap),
+				 nr_pages);
+	swap_cluster_unlock(ci);
+	mem_cgroup_uncharge_swap(id, nr_pages);
 }
 
 void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4f940cf22ffe..b5c267a061a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -64,6 +64,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/kmemleak.h>
 #include "internal.h"
+#include "swap_table.h"
 #include <net/sock.h>
 #include <net/ip.h>
 #include "slab.h"
@@ -5470,6 +5471,7 @@ int __init mem_cgroup_init(void)
 int __mem_cgroup_try_charge_swap(struct folio *folio)
 {
 	unsigned int nr_pages = folio_nr_pages(folio);
+	struct swap_cluster_info *ci;
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
@@ -5503,22 +5505,23 @@ int __mem_cgroup_try_charge_swap(struct folio *folio)
 	}
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
 
-	swap_cgroup_record(folio, mem_cgroup_private_id(memcg), folio->swap);
+	ci = swap_cluster_get_and_lock(folio);
+	__swap_cgroup_set(ci, swp_cluster_offset(folio->swap), nr_pages,
+			  mem_cgroup_private_id(memcg));
+	swap_cluster_unlock(ci);
 
 	return 0;
 }
 
 /**
  * __mem_cgroup_uncharge_swap - uncharge swap space
- * @entry: swap entry to uncharge
+ * @id: cgroup id to uncharge
  * @nr_pages: the amount of swap space to uncharge
  */
-void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
+void __mem_cgroup_uncharge_swap(unsigned short id, unsigned int nr_pages)
 {
 	struct mem_cgroup *memcg;
-	unsigned short id;
 
-	id = swap_cgroup_clear(entry, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_private_id(id);
 	if (memcg) {
diff --git a/mm/swap.h b/mm/swap.h
index 8e57e9431624..5b2f095fff6e 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -5,6 +5,7 @@
 #include <linux/atomic.h> /* for atomic_long_t */
 struct mempolicy;
 struct swap_iocb;
+struct swap_memcg_table;
 
 extern int page_cluster;
 
@@ -38,6 +39,9 @@ struct swap_cluster_info {
 	u8 order;
 	atomic_long_t __rcu *table;	/* Swap table entries, see mm/swap_table.h */
 	unsigned int *extend_table;	/* For large swap count, protected by ci->lock */
+#ifdef CONFIG_MEMCG
+	struct swap_memcg_table *memcg_table;	/* Swap table entries' cgroup record */
+#endif
 	struct list_head list;
 };
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index bdd949ae0044..873cb3f26337 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -179,21 +179,19 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 	if (shadowp && swp_tb_is_shadow(old_tb))
 		*shadowp = swp_tb_to_shadow(old_tb);
 	if (memcg_id)
-		*memcg_id = lookup_swap_cgroup_id(targ_entry);
+		*memcg_id = __swap_cgroup_get(ci, ci_off);
 
 	if (nr == 1)
 		return 0;
 
-	targ_entry.val = round_down(targ_entry.val, nr);
 	ci_off = round_down(ci_off, nr);
 	ci_end = ci_off + nr;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		if (unlikely(swp_tb_is_folio(old_tb) ||
 			     !__swp_tb_get_count(old_tb) ||
-			     (memcg_id && *memcg_id != lookup_swap_cgroup_id(targ_entry))))
+			     (memcg_id && *memcg_id != __swap_cgroup_get(ci, ci_off))))
 			return -EBUSY;
-		targ_entry.val++;
 	} while (++ci_off < ci_end);
 
 	return 0;
diff --git a/mm/swap_table.h b/mm/swap_table.h
index 8415ffbe2b9c..b4e1100f8296 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -11,6 +11,11 @@ struct swap_table {
 	atomic_long_t entries[SWAPFILE_CLUSTER];
 };
 
+/* For storing memcg private id */
+struct swap_memcg_table {
+	unsigned short id[SWAPFILE_CLUSTER];
+};
+
 #define SWP_TABLE_USE_PAGE (sizeof(struct swap_table) == PAGE_SIZE)
 
 /*
@@ -247,4 +252,63 @@ static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
 
 	return swp_tb;
 }
+
+#ifdef CONFIG_MEMCG
+static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
+		unsigned int ci_off, unsigned long nr, unsigned short id)
+{
+	lockdep_assert_held(&ci->lock);
+	VM_WARN_ON_ONCE(ci_off >= SWAPFILE_CLUSTER);
+	if (WARN_ON_ONCE(!ci->memcg_table))
+		return;
+	do {
+		ci->memcg_table->id[ci_off++] = id;
+	} while (--nr);
+}
+
+static inline unsigned short __swap_cgroup_get(struct swap_cluster_info *ci,
+					       unsigned int ci_off)
+{
+	lockdep_assert_held(&ci->lock);
+	VM_WARN_ON_ONCE(ci_off >= SWAPFILE_CLUSTER);
+	if (unlikely(!ci->memcg_table))
+		return 0;
+	return ci->memcg_table->id[ci_off];
+}
+
+static inline unsigned short __swap_cgroup_clear(struct swap_cluster_info *ci,
+						 unsigned int ci_off,
+						 unsigned long nr)
+{
+	unsigned short old = __swap_cgroup_get(ci, ci_off);
+
+	if (!old)
+		return 0;
+	do {
+		VM_WARN_ON_ONCE(ci->memcg_table->id[ci_off] != old);
+		ci->memcg_table->id[ci_off++] = 0;
+	} while (--nr);
+
+	return old;
+}
+#else
+static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
+		unsigned int ci_off, unsigned long nr, unsigned short id)
+{
+}
+
+static inline unsigned short __swap_cgroup_get(struct swap_cluster_info *ci,
+					       unsigned int ci_off)
+{
+	return 0;
+}
+
+static inline unsigned short __swap_cgroup_clear(struct swap_cluster_info *ci,
+						 unsigned int ci_off,
+						 unsigned long nr)
+{
+	return 0;
+}
+#endif
+
 #endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7740ba99f87e..ae14d4049e4b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -423,7 +423,12 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 {
 	struct swap_table *table;
 
-	table = (struct swap_table *)rcu_dereference_protected(ci->table, true);
+#ifdef CONFIG_MEMCG
+	kfree(ci->memcg_table);
+	ci->memcg_table = NULL;
+#endif
+
+	table = (struct swap_table *)rcu_access_pointer(ci->table);
 	if (!table)
 		return;
 
@@ -441,6 +446,7 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 {
 	struct swap_table *table = NULL;
 	struct folio *folio;
+	int ret = 0;
 
 	/* The cluster must be empty and not on any list during allocation. */
 	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
@@ -458,7 +464,19 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 		return -ENOMEM;
 
 	rcu_assign_pointer(ci->table, table);
-	return 0;
+
+#ifdef CONFIG_MEMCG
+	if (!mem_cgroup_disabled()) {
+		VM_WARN_ON_ONCE(ci->memcg_table);
+		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
+		if (!ci->memcg_table)
+			ret = -ENOMEM;
+	}
+#endif
+	if (ret)
+		swap_cluster_free_table(ci);
+
+	return ret;
 }
 
 /*
@@ -483,6 +501,7 @@ static void swap_cluster_assert_empty(struct swap_cluster_info *ci,
 			bad_slots++;
 		else
 			WARN_ON_ONCE(!swp_tb_is_null(swp_tb));
+		WARN_ON_ONCE(__swap_cgroup_get(ci, ci_off));
 	} while (++ci_off < ci_end);
 
 	WARN_ON_ONCE(bad_slots != (swapoff ? ci->count : 0));
@@ -1861,12 +1880,10 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 				 unsigned int ci_start, unsigned int nr_pages)
 {
 	unsigned long old_tb;
-	unsigned int type = si->type;
 	unsigned short batch_id = 0, id_cur;
 	unsigned int ci_off = ci_start, ci_end = ci_start + nr_pages;
 	unsigned long ci_head = cluster_offset(si, ci);
 	unsigned int batch_off = ci_off;
-	swp_entry_t entry;
 
 	VM_WARN_ON(ci->count < nr_pages);
 
@@ -1884,21 +1901,17 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 		 * Uncharge swap slots by memcg in batches. Consecutive
 		 * slots with the same cgroup id are uncharged together.
 		 */
-		entry = swp_entry(type, ci_head + ci_off);
-		id_cur = lookup_swap_cgroup_id(entry);
+		id_cur = __swap_cgroup_clear(ci, ci_off, 1);
 		if (batch_id != id_cur) {
 			if (batch_id)
-				mem_cgroup_uncharge_swap(swp_entry(type, ci_head + batch_off),
-							 ci_off - batch_off);
+				mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
 			batch_id = id_cur;
 			batch_off = ci_off;
 		}
 	} while (++ci_off < ci_end);
 
-	if (batch_id) {
-		mem_cgroup_uncharge_swap(swp_entry(type, ci_head + batch_off),
-					 ci_off - batch_off);
-	}
+	if (batch_id)
+		mem_cgroup_uncharge_swap(batch_id, ci_off - batch_off);
 
 	swap_range_free(si, ci_head + ci_start, nr_pages);
 	swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 924c84326551..ca4533eba701 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -737,7 +737,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		__memcg1_swapout(folio);
+		__memcg1_swapout(folio, ci);
 		__swap_cache_del_folio(ci, folio, swap, shadow);
 		swap_cluster_unlock_irq(ci);
 	} else {

-- 
2.54.0



