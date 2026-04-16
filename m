Return-Path: <cgroups+bounces-15331-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCxHDNkr4WmQqAAAu9opvQ
	(envelope-from <cgroups+bounces-15331-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:35:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EB6413C4B
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D58A53019FC7
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3709B33D6E1;
	Thu, 16 Apr 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zds+0fLR"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C4133A9F5;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364483; cv=none; b=WC23PfWhONSWbpx9bmIQ8ennxpWvqMalqiIAaAobZ0ZGabYaYyTIGHnVLNWhfE3D7jDOcPfOSkvh5H2E78bOdJcBbM1XChoVwjbp8Uma5WdvZyTh62RaXVopxQ8o8OW8weXtfysFufPETkV/cuE0IiuCb+TT9qYHdSR4Uihtrpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364483; c=relaxed/simple;
	bh=uEzmBJn8Gh0LCG4Fpy6z5l9upX93GQJ59tjiQgkZEK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=crqx5N7kErNOmdESEyRSwVmNedJkUuZtxldMKL39phzb2vHI0RYwCWNycdVKuXmN08ZF9iefrIxOeVkxI6EoE2sl9z+jBc0z8vV5raO/mz/6D22PaISqaNoAWS4D/aLxhOzzXhMm9m5xkbtHm6XUKgv9F1tAmrjJgz5YG4dlj78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zds+0fLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2B5AC2BCC4;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364483;
	bh=uEzmBJn8Gh0LCG4Fpy6z5l9upX93GQJ59tjiQgkZEK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Zds+0fLRKw62K17427zH2HgkOutHnZby+sVzCoCj6+k7NELZtut7EajyZKqvuA5OO
	 CJQgw66isHlVRpgCE6XLbZGqs5NVD0N5FI4GoA0jKbIjB1GfgHomAYf8UV0afhy4Hw
	 JI3Q98T/c5QbiOxTz93m+GbWrTPGvbLZZngnjDcNyxMfTpnJ0e4MItS377u/B8ASEj
	 gAe7V5w1cxArDUL+h7Wk+/cbKDcMBt3HDolASXjlSrbLldlg0OIuGD8kZMPB8Lmp09
	 zsK+uF3mdEzCnFrBFy66QH7aaMV0f4GK+Xt45+XrHYSzgqFOGJ/vBdQkLbSL6INXoe
	 ZJ6/jGW8CvEHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C76F8D762;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 17 Apr 2026 02:34:39 +0800
Subject: [PATCH v2 09/11] mm/memcg, swap: store cgroup id in cluster table
 directly
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-swap-table-p4-v2-9-17f5d1015428@tencent.com>
References: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
In-Reply-To: <20260417-swap-table-p4-v2-0-17f5d1015428@tencent.com>
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
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Yosry Ahmed <yosry@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
 Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776364480; l=17987;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=zT0f++DWYrkvysbZWVgiMERGvsh+qv7DfByMhzV7Adg=;
 b=SZFrA8TlWh9azRiphoc02t0VEPkMgtdIM6ghVq3bvHKIaD6xGEbFLBa1Sn8+MA4N8pqepcu7C
 rJygoaqq1CvBi9gi6r/L+meMtNt6YnurhzyQ06F2Y1dzshdG0IFq0BH
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15331-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,bytedance.com,vger.kernel.org,tencent.com,arm.com,suse.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:replyto,tencent.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 52EB6413C4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

Drop the usage of the swap_cgroup_ctrl, and use the dynamic cluster
table instead.

The memcg table of each cluster is 1024 bytes and doesn't need RCU
protection. We only check and modify the cgroup data under cluster lock,
which makes things a bit easier and fits well for kmalloc.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h |  6 ++--
 include/linux/swap.h       |  8 +++---
 mm/memcontrol-v1.c         | 42 ++++++++++++++++++----------
 mm/memcontrol.c            | 14 ++++++----
 mm/swap.h                  |  5 ++++
 mm/swap_state.c            |  6 ++--
 mm/swap_table.h            | 54 ++++++++++++++++++++++++++++++++++++
 mm/swapfile.c              | 68 +++++++++++++++++++++++++++++++++++-----------
 mm/vmscan.c                |  2 +-
 9 files changed, 158 insertions(+), 47 deletions(-)

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
index f2949f5844a6..57af4647d432 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -582,12 +582,12 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
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
@@ -598,7 +598,7 @@ static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 	return 0;
 }
 
-static inline void mem_cgroup_uncharge_swap(swp_entry_t entry,
+static inline void mem_cgroup_uncharge_swap(unsigned short id,
 					    unsigned int nr_pages)
 {
 }
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index c8579395ed80..ff49337a61a3 100644
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
- * to be freed, and caller must disable IRQ.
+ * Context: folio must be isolated, unmapped, locked and is just about to
+ * be freed, and caller must disable IRQ and hold the swap cluster lock.
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
index 641706fa47bf..43a7b25da37e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -67,6 +67,8 @@
 #include <net/sock.h>
 #include <net/ip.h>
 #include "slab.h"
+#include "swap.h"
+#include "swap_table.h"
 #include "memcontrol-v1.h"
 
 #include <linux/uaccess.h>
@@ -5462,6 +5464,7 @@ int __init mem_cgroup_init(void)
 int __mem_cgroup_try_charge_swap(struct folio *folio)
 {
 	unsigned int nr_pages = folio_nr_pages(folio);
+	struct swap_cluster_info *ci;
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
@@ -5495,22 +5498,23 @@ int __mem_cgroup_try_charge_swap(struct folio *folio)
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
index 80c2f1bf7a57..319dbe4eb299 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -3,8 +3,10 @@
 #define _MM_SWAP_H
 
 #include <linux/atomic.h> /* for atomic_long_t */
+
 struct mempolicy;
 struct swap_iocb;
+struct swap_memcg_table;
 
 extern int page_cluster;
 
@@ -38,6 +40,9 @@ struct swap_cluster_info {
 	u8 order;
 	atomic_long_t __rcu *table;	/* Swap table entries, see mm/swap_table.h */
 	unsigned int *extend_table;	/* For large swap count, protected by ci->lock */
+#ifdef CONFIG_MEMCG
+	struct swap_memcg_table *memcg_table;	/* Swap table entries' cgroup record */
+#endif
 	struct list_head list;
 };
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 4c1cb0b1c0c5..c3d19c9fc594 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -176,21 +176,19 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
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
index 8415ffbe2b9c..b2b02ee161b1 100644
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
@@ -247,4 +252,53 @@ static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
 
 	return swp_tb;
 }
+
+#ifdef CONFIG_MEMCG
+static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
+		unsigned int ci_off, unsigned long nr, unsigned short id)
+{
+	lockdep_assert_held(&ci->lock);
+	VM_WARN_ON_ONCE(ci_off >= SWAPFILE_CLUSTER);
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
+	return ci->memcg_table->id[ci_off];
+}
+
+static inline unsigned short __swap_cgroup_clear(struct swap_cluster_info *ci,
+						 unsigned int ci_off,
+						 unsigned long nr)
+{
+	unsigned short old = ci->memcg_table->id[ci_off];
+
+	__swap_cgroup_set(ci, ci_off, nr, 0);
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
index b0efae57b973..5511cdbd2ccf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -411,6 +411,21 @@ static inline unsigned int cluster_offset(struct swap_info_struct *si,
 	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
 }
 
+static struct swap_memcg_table *swap_memcg_table_alloc(gfp_t gfp)
+{
+	if (!IS_ENABLED(CONFIG_MEMCG))
+		return NULL;
+	return kzalloc(sizeof(struct swap_memcg_table), gfp);
+}
+
+static void swap_memcg_table_assign(struct swap_cluster_info *ci,
+				    struct swap_memcg_table *memcg_table)
+{
+#ifdef CONFIG_MEMCG
+	ci->memcg_table = memcg_table;
+#endif
+}
+
 static struct swap_table *swap_table_alloc(gfp_t gfp)
 {
 	struct folio *folio;
@@ -434,6 +449,9 @@ static void swap_table_free_folio_rcu_cb(struct rcu_head *head)
 
 static void swap_table_free(struct swap_table *table)
 {
+	if (!table)
+		return;
+
 	if (!SWP_TABLE_USE_PAGE) {
 		kmem_cache_free(swap_table_cachep, table);
 		return;
@@ -465,6 +483,7 @@ static void swap_cluster_assert_empty(struct swap_cluster_info *ci,
 			bad_slots++;
 		else
 			WARN_ON_ONCE(!swp_tb_is_null(swp_tb));
+		WARN_ON_ONCE(__swap_cgroup_get(ci, ci_off));
 	} while (++ci_off < ci_end);
 
 	WARN_ON_ONCE(bad_slots != (swapoff ? ci->count : 0));
@@ -481,6 +500,11 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	rcu_assign_pointer(ci->table, NULL);
 
 	swap_table_free(table);
+
+#ifdef CONFIG_MEMCG
+	kfree(ci->memcg_table);
+	ci->memcg_table = NULL;
+#endif
 }
 
 /*
@@ -492,6 +516,8 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 			 struct swap_cluster_info *ci)
 {
 	struct swap_table *table;
+	struct swap_memcg_table *memcg_table;
+	gfp_t gfp = __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN;
 
 	/*
 	 * Only cluster isolation from the allocator does table allocation.
@@ -505,8 +531,10 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	/* The cluster must be free and was just isolated from the free list. */
 	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
 
-	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
-	if (table) {
+	table = swap_table_alloc(gfp);
+	memcg_table = swap_memcg_table_alloc(gfp);
+	if (table && (!IS_ENABLED(CONFIG_MEMCG) || memcg_table)) {
+		swap_memcg_table_assign(ci, memcg_table);
 		rcu_assign_pointer(ci->table, table);
 		return ci;
 	}
@@ -516,12 +544,16 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	 * a sleep allocation, but there is a limited number of them, so
 	 * the potential recursive allocation is limited.
 	 */
+	gfp |= GFP_KERNEL;
 	spin_unlock(&ci->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
 	local_unlock(&percpu_swap_cluster.lock);
 
-	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | GFP_KERNEL);
+	if (!table)
+		table = swap_table_alloc(gfp);
+	if (!memcg_table)
+		memcg_table = swap_memcg_table_alloc(gfp);
 
 	/*
 	 * Back to atomic context. We might have migrated to a new CPU with a
@@ -538,17 +570,20 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 
 	/* Nothing except this helper should touch a dangling empty cluster. */
 	if (WARN_ON_ONCE(cluster_table_is_alloced(ci))) {
-		if (table)
-			swap_table_free(table);
+		swap_table_free(table);
+		kfree(memcg_table);
 		return ci;
 	}
 
-	if (!table) {
+	if (!table || (IS_ENABLED(CONFIG_MEMCG) && !memcg_table)) {
 		move_cluster(si, ci, &si->free_clusters, CLUSTER_FLAG_FREE);
 		spin_unlock(&ci->lock);
+		swap_table_free(table);
+		kfree(memcg_table);
 		return NULL;
 	}
 
+	swap_memcg_table_assign(ci, memcg_table);
 	rcu_assign_pointer(ci->table, table);
 	return ci;
 }
@@ -768,6 +803,7 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 {
 	unsigned int ci_off = offset % SWAPFILE_CLUSTER;
 	unsigned long idx = offset / SWAPFILE_CLUSTER;
+	struct swap_memcg_table *memcg_table;
 	struct swap_cluster_info *ci;
 	struct swap_table *table;
 	int ret = 0;
@@ -794,6 +830,12 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
 		table = swap_table_alloc(GFP_KERNEL);
 		if (!table)
 			return -ENOMEM;
+		memcg_table = swap_memcg_table_alloc(GFP_KERNEL);
+		if (IS_ENABLED(CONFIG_MEMCG) && !memcg_table) {
+			swap_table_free(table);
+			return -ENOMEM;
+		}
+		swap_memcg_table_assign(ci, memcg_table);
 		rcu_assign_pointer(ci->table, table);
 	}
 	spin_lock(&ci->lock);
@@ -1872,12 +1914,10 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 				 unsigned int ci_start, unsigned int nr_pages)
 {
 	unsigned long old_tb;
-	unsigned int type = si->type;
 	unsigned short id = 0, id_cur;
 	unsigned int ci_off = ci_start, ci_end = ci_start + nr_pages;
 	unsigned long offset = cluster_offset(si, ci);
 	unsigned int ci_batch = ci_off;
-	swp_entry_t entry;
 
 	VM_WARN_ON(ci->count < nr_pages);
 
@@ -1895,21 +1935,17 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 		 * Uncharge swap slots by memcg in batches. Consecutive
 		 * slots with the same cgroup id are uncharged together.
 		 */
-		entry = swp_entry(type, offset + ci_off);
-		id_cur = lookup_swap_cgroup_id(entry);
+		id_cur = __swap_cgroup_clear(ci, ci_off, 1);
 		if (id != id_cur) {
 			if (id)
-				mem_cgroup_uncharge_swap(swp_entry(type, offset + ci_batch),
-							 ci_off - ci_batch);
+				mem_cgroup_uncharge_swap(id, ci_off - ci_batch);
 			id = id_cur;
 			ci_batch = ci_off;
 		}
 	} while (++ci_off < ci_end);
 
-	if (id) {
-		mem_cgroup_uncharge_swap(swp_entry(type, offset + ci_batch),
-					 ci_off - ci_batch);
-	}
+	if (id)
+		mem_cgroup_uncharge_swap(id, ci_off - ci_batch);
 
 	swap_range_free(si, offset + ci_start, nr_pages);
 	swap_cluster_assert_empty(ci, ci_start, nr_pages, false);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 63d06930d8e3..50d87ff58f86 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -739,7 +739,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		__memcg1_swapout(folio);
+		__memcg1_swapout(folio, ci);
 		__swap_cache_del_folio(ci, folio, swap, shadow);
 		swap_cluster_unlock_irq(ci);
 	} else {

-- 
2.53.0



