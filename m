Return-Path: <cgroups+bounces-16021-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPClBVjhCWo6twQAu9opvQ
	(envelope-from <cgroups+bounces-16021-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:40:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D415620A1
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 17CFB300398E
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED023C1413;
	Sun, 17 May 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="figebiAZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B184A3C0601;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032389; cv=none; b=YKLryBBqYQmzQuq6pXmZdvSfMEaKtm9lS38G1H+4f0AyNtYyQcyp1yQn+cv4KodZQNhXdNpW9ITnMjbkUPrW6xi2yd6RvO08meNK3IsV2QpOc4ebBKlJoS/uGIDA3chRc5kBUR8nN6VHfdmOiZpOD4Mo77cEl9O72Q9/knDwdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032389; c=relaxed/simple;
	bh=FTZF+GCZrsIHcfofs6t9OX/YECec6/F/i6KkyQtFLsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hdlCTCnNzj2MlogxUtqjZUnV03KJqx3EuIdpuVKXuKrqeRjiXChyRSKJlp7lTMynJS6w+RCOTij/pU65H9bIpAlP+1TPh2Epvjvu+BUXbokB3xdltv1sVucWt5OguXE/4gRv2R4/UGa4uys2qbtFVZ6+OlxCL/ypk5I2hR92ciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=figebiAZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87487C2BCF5;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032389;
	bh=FTZF+GCZrsIHcfofs6t9OX/YECec6/F/i6KkyQtFLsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=figebiAZjhV+uTfYnOQX4+ZSkG1TWC1bYfpjCfVmHAfUod2meQILXG7xsq0/c+KZR
	 75qA38OWFQwAiiT2G7JNy8wV17VHvmCMUOGAizVW55PiVCjB/j3POGETIp99Ww29rt
	 qkZaGk0i2l1vz46TixisedpHv2U5bmpNGq+VKt2belKLDhpnhs9DCMIvPodjWK86MS
	 BBWL14oR95FSMKTatEkFDFRrrfSewFbPyepl/Sr+twTdAtkiPS7477dVzhrtzvtK0d
	 gS850OvVUKM4momS5mZZmIBwecLnXwH5lfK4F+NcOWdQibo6utH3SJ8ILhBqSs9/jU
	 yPqgl9Y2uACbQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBBCD4F4B;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sun, 17 May 2026 23:39:51 +0800
Subject: [PATCH v5 12/12] mm, swap: merge zeromap into swap table
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-swap-table-p4-v5-12-88ae43e064c7@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779032386; l=25679;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=gttVtNi/7R4eUHbXAfn8Ru41nAabUu7c8GCjLiuwTrA=;
 b=7H4CNCyOHcGJpeqK0fJEfCdsiOq3F6jvaclr2oRPX6acDIdFYIXyXZori//qPMy4JFkv196ij
 MbAxFYc7qvnAJMV8sXk1KXcrwsXXJZEs5GgVlBNjNoEfW+TKcmjmeos
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Queue-Id: A3D415620A1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16021-lists,cgroups=lfdr.de,kasong.tencent.com];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email,tencent.com:mid,tencent.com:replyto,lge.com:email]
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

By allocating one additional bit in the swap table entry's flags field
alongside the count, we can store the zeromap inline

For 64 bit systems, zeromap will store in the swap table, avoiding zeromap
allocation. It reduces the allocated memory. That is the happy path.

For certain 32-bit archs, there might not be enough bits in the swap
table to contain both PFN and flags. Therefore, conditionally let each
cluster have a zeromap field at build time, and use that instead.
If the swapfile cluster is not fully used, it will still save memory for
zeromap. The empty cluster does not allocate a zeromap. In the worst case,
all cluster are fully populated. We will use memory similar to the
previous zeromap implementation.

A few macros were moved to different headers for build time struct
definition.

Acked-by: Chris Li <chrisl@kernel.org>
Reviewed-by: Youngjun Park <youngjun.park@lge.com>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   1 -
 mm/memory.c          |  11 +----
 mm/page_io.c         |  61 +++++++++++++++++++++++----
 mm/swap.h            |  51 +++++++++--------------
 mm/swap_state.c      |  14 ++++---
 mm/swap_table.h      | 115 +++++++++++++++++++++++++++++++++++++--------------
 mm/swapfile.c        |  54 +++++++++++-------------
 7 files changed, 191 insertions(+), 116 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 203bbe23ba1f..6d72778e6cc3 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -253,7 +253,6 @@ struct swap_info_struct {
 	struct plist_node list;		/* entry in swap_active_head */
 	signed char	type;		/* strange name for an index */
 	unsigned int	max;		/* size of this swap device */
-	unsigned long *zeromap;		/* kvmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head full_clusters; /* full clusters list */
diff --git a/mm/memory.c b/mm/memory.c
index da891bcce59c..7c020995eafc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4611,13 +4611,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
- * Check if the PTEs within a range are contiguous swap entries
- * and have consistent swapcache, zeromap.
+ * Check if the PTEs within a range are contiguous swap entries.
  */
 static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 {
 	unsigned long addr;
-	softleaf_t entry;
 	int idx;
 	pte_t pte;
 
@@ -4627,18 +4625,13 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 
 	if (!pte_same(pte, pte_move_swp_offset(vmf->orig_pte, -idx)))
 		return false;
-	entry = softleaf_from_pte(pte);
-	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
-		return false;
-
 	/*
 	 * swap_read_folio() can't handle the case a large folio is hybridly
 	 * from different backends. And they are likely corner cases. Similar
 	 * things might be added once zswap support large folios.
 	 */
-	if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
+	if (swap_pte_batch(ptep, nr_pages, pte) != nr_pages)
 		return false;
-
 	return true;
 }
 
diff --git a/mm/page_io.c b/mm/page_io.c
index 7ed76592e20d..f2d8fe7fd057 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -26,6 +26,7 @@
 #include <linux/delayacct.h>
 #include <linux/zswap.h>
 #include "swap.h"
+#include "swap_table.h"
 
 static void __end_swap_bio_write(struct bio *bio)
 {
@@ -204,15 +205,20 @@ static bool is_folio_zero_filled(struct folio *folio)
 static void swap_zeromap_folio_set(struct folio *folio)
 {
 	struct obj_cgroup *objcg = get_obj_cgroup_from_folio(folio);
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
 	int nr_pages = folio_nr_pages(folio);
+	struct swap_cluster_info *ci;
 	swp_entry_t entry;
 	unsigned int i;
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+
+	ci = swap_cluster_get_and_lock(folio);
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		entry = page_swap_entry(folio_page(folio, i));
-		set_bit(swp_offset(entry), sis->zeromap);
+		__swap_table_set_zero(ci, swp_cluster_offset(entry));
 	}
+	swap_cluster_unlock(ci);
 
 	count_vm_events(SWPOUT_ZERO, nr_pages);
 	if (objcg) {
@@ -223,14 +229,19 @@ static void swap_zeromap_folio_set(struct folio *folio)
 
 static void swap_zeromap_folio_clear(struct folio *folio)
 {
-	struct swap_info_struct *sis = __swap_entry_to_info(folio->swap);
+	struct swap_cluster_info *ci;
 	swp_entry_t entry;
 	unsigned int i;
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+
+	ci = swap_cluster_get_and_lock(folio);
 	for (i = 0; i < folio_nr_pages(folio); i++) {
 		entry = page_swap_entry(folio_page(folio, i));
-		clear_bit(swp_offset(entry), sis->zeromap);
+		__swap_table_clear_zero(ci, swp_cluster_offset(entry));
 	}
+	swap_cluster_unlock(ci);
 }
 
 /*
@@ -255,10 +266,9 @@ int swap_writeout(struct folio *folio, struct swap_iocb **swap_plug)
 	}
 
 	/*
-	 * Use a bitmap (zeromap) to avoid doing IO for zero-filled pages.
-	 * The bits in zeromap are protected by the locked swapcache folio
-	 * and atomic updates are used to protect against read-modify-write
-	 * corruption due to other zero swap entries seeing concurrent updates.
+	 * Use the swap table zero mark to avoid doing IO for zero-filled
+	 * pages. The zero mark is protected by the cluster lock, which is
+	 * acquired internally by swap_zeromap_folio_set/clear.
 	 */
 	if (is_folio_zero_filled(folio)) {
 		swap_zeromap_folio_set(folio);
@@ -509,19 +519,52 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
 	mempool_free(sio, sio_pool);
 }
 
+/*
+ * Return the count of contiguous swap entries that share the same
+ * zeromap status as the starting entry. If is_zerop is not NULL,
+ * it will return the zeromap status of the starting entry.
+ *
+ * Context: Caller must ensure the cluster containing the entries
+ * that will be checked won't be freed.
+ */
+static int swap_zeromap_batch(swp_entry_t entry, int max_nr,
+			      bool *is_zerop)
+{
+	int i;
+	bool is_zero;
+	unsigned int ci_start = swp_cluster_offset(entry);
+	struct swap_cluster_info *ci = __swap_entry_to_cluster(entry);
+
+	VM_WARN_ON_ONCE(ci_start + max_nr > SWAPFILE_CLUSTER);
+
+	rcu_read_lock();
+	is_zero = __swap_table_test_zero(ci, ci_start);
+	for (i = 1; i < max_nr; i++)
+		if (is_zero != __swap_table_test_zero(ci, ci_start + i))
+			break;
+	rcu_read_unlock();
+	if (is_zerop)
+		*is_zerop = is_zero;
+
+	return i;
+}
+
 static bool swap_read_folio_zeromap(struct folio *folio)
 {
 	int nr_pages = folio_nr_pages(folio);
 	struct obj_cgroup *objcg;
 	bool is_zeromap;
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+
 	/*
 	 * Swapping in a large folio that is partially in the zeromap is not
 	 * currently handled. Return true without marking the folio uptodate so
 	 * that an IO error is emitted (e.g. do_swap_page() will sigbus).
+	 * Folio lock stabilizes the cluster and map, so the check is safe.
 	 */
 	if (WARN_ON_ONCE(swap_zeromap_batch(folio->swap, nr_pages,
-			&is_zeromap) != nr_pages))
+			 &is_zeromap) != nr_pages))
 		return true;
 
 	if (!is_zeromap)
diff --git a/mm/swap.h b/mm/swap.h
index 5b2f095fff6e..81c06aae7ccd 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -3,12 +3,29 @@
 #define _MM_SWAP_H
 
 #include <linux/atomic.h> /* for atomic_long_t */
+#include <linux/mm.h> /* for PAGE_SHIFT */
 struct mempolicy;
 struct swap_iocb;
 struct swap_memcg_table;
 
 extern int page_cluster;
 
+#if defined(MAX_POSSIBLE_PHYSMEM_BITS)
+#define SWAP_CACHE_PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
+#elif defined(MAX_PHYSMEM_BITS)
+#define SWAP_CACHE_PFN_BITS (MAX_PHYSMEM_BITS - PAGE_SHIFT)
+#else
+#define SWAP_CACHE_PFN_BITS (BITS_PER_LONG - PAGE_SHIFT)
+#endif
+
+/* Swap table marker, 0x1 means shadow, 0x2 means PFN (SWP_TB_PFN_MARK) */
+#define SWAP_CACHE_PFN_MARK_BITS	2
+/* At least 2 bits are needed to distinguish SWP_TB_COUNT_MAX, 1 and 0 */
+#define SWAP_COUNT_MIN_BITS		2
+/* If there are enough bits besides PFN and marker, store zero flag inline */
+#define SWAP_TABLE_HAS_ZEROFLAG		((BITS_PER_LONG - SWAP_CACHE_PFN_MARK_BITS - \
+					  SWAP_CACHE_PFN_BITS) > SWAP_COUNT_MIN_BITS)
+
 #ifdef CONFIG_THP_SWAP
 #define SWAPFILE_CLUSTER	HPAGE_PMD_NR
 #define swap_entry_order(order)	(order)
@@ -41,6 +58,9 @@ struct swap_cluster_info {
 	unsigned int *extend_table;	/* For large swap count, protected by ci->lock */
 #ifdef CONFIG_MEMCG
 	struct swap_memcg_table *memcg_table;	/* Swap table entries' cgroup record */
+#endif
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	unsigned long *zero_bitmap;
 #endif
 	struct list_head list;
 };
@@ -314,31 +334,6 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 	return __swap_entry_to_info(folio->swap)->flags;
 }
 
-/*
- * Return the count of contiguous swap entries that share the same
- * zeromap status as the starting entry. If is_zeromap is not NULL,
- * it will return the zeromap status of the starting entry.
- */
-static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
-		bool *is_zeromap)
-{
-	struct swap_info_struct *sis = __swap_entry_to_info(entry);
-	unsigned long start = swp_offset(entry);
-	unsigned long end = start + max_nr;
-	bool first_bit;
-
-	first_bit = test_bit(start, sis->zeromap);
-	if (is_zeromap)
-		*is_zeromap = first_bit;
-
-	if (max_nr <= 1)
-		return max_nr;
-	if (first_bit)
-		return find_next_zero_bit(sis->zeromap, end, start) - start;
-	else
-		return find_next_bit(sis->zeromap, end, start) - start;
-}
-
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline struct swap_cluster_info *swap_cluster_lock(
@@ -476,11 +471,5 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 {
 	return 0;
 }
-
-static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
-		bool *has_zeromap)
-{
-	return 0;
-}
 #endif /* CONFIG_SWAP */
 #endif /* _MM_SWAP_H */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 873cb3f26337..04f5ce992401 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -160,6 +160,7 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 {
 	unsigned int ci_off, ci_end;
 	unsigned long old_tb;
+	bool is_zero;
 
 	lockdep_assert_held(&ci->lock);
 
@@ -184,12 +185,14 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 	if (nr == 1)
 		return 0;
 
+	is_zero = __swap_table_test_zero(ci, ci_off);
 	ci_off = round_down(ci_off, nr);
 	ci_end = ci_off + nr;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		if (unlikely(swp_tb_is_folio(old_tb) ||
 			     !__swp_tb_get_count(old_tb) ||
+			     is_zero != __swap_table_test_zero(ci, ci_off) ||
 			     (memcg_id && *memcg_id != __swap_cgroup_get(ci, ci_off))))
 			return -EBUSY;
 	} while (++ci_off < ci_end);
@@ -213,7 +216,7 @@ static void __swap_cache_do_add_folio(struct swap_cluster_info *ci,
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		VM_WARN_ON_ONCE(swp_tb_is_folio(old_tb));
-		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_count(old_tb)));
+		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_flags(old_tb)));
 	} while (++ci_off < ci_end);
 
 	folio_ref_add(folio, nr_pages);
@@ -249,7 +252,6 @@ static void __swap_cache_do_del_folio(struct swap_cluster_info *ci,
 				      struct folio *folio,
 				      swp_entry_t entry, void *shadow)
 {
-	int count;
 	unsigned long old_tb;
 	struct swap_info_struct *si;
 	unsigned int ci_start, ci_off, ci_end;
@@ -269,13 +271,13 @@ static void __swap_cache_do_del_folio(struct swap_cluster_info *ci,
 		old_tb = __swap_table_get(ci, ci_off);
 		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) ||
 			     swp_tb_to_folio(old_tb) != folio);
-		count = __swp_tb_get_count(old_tb);
-		if (count)
+		if (__swp_tb_get_count(old_tb))
 			folio_swapped = true;
 		else
 			need_free = true;
 		/* If shadow is NULL, we set an empty shadow. */
-		__swap_table_set(ci, ci_off, shadow_to_swp_tb(shadow, count));
+		__swap_table_set(ci, ci_off, shadow_to_swp_tb(shadow,
+				 __swp_tb_get_flags(old_tb)));
 	} while (++ci_off < ci_end);
 
 	folio->swap.val = 0;
@@ -369,7 +371,7 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) || swp_tb_to_folio(old_tb) != old);
-		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_count(old_tb)));
+		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_flags(old_tb)));
 	} while (++ci_off < ci_end);
 
 	/*
diff --git a/mm/swap_table.h b/mm/swap_table.h
index b4e1100f8296..e6613e62f8d0 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -26,12 +26,14 @@ struct swap_memcg_table {
  * Swap table entry type and bits layouts:
  *
  * NULL:     |---------------- 0 ---------------| - Free slot
- * Shadow:   | SWAP_COUNT |---- SHADOW_VAL ---|1| - Swapped out slot
- * PFN:      | SWAP_COUNT |------ PFN -------|10| - Cached slot
+ * Shadow:   |SWAP_COUNT|Z|---- SHADOW_VAL ---|1| - Swapped out slot
+ * PFN:      |SWAP_COUNT|Z|------ PFN -------|10| - Cached slot
  * Pointer:  |----------- Pointer ----------|100| - (Unused)
  * Bad:      |------------- 1 -------------|1000| - Bad slot
  *
- * SWAP_COUNT is `SWP_TB_COUNT_BITS` long, each entry is an atomic long.
+ * COUNT is `SWP_TB_COUNT_BITS` long, Z is the `SWP_TB_ZERO_FLAG` bit,
+ * and together they form the `SWP_TB_FLAGS_BITS` wide flags field.
+ * Each entry is an atomic long.
  *
  * Usages:
  *
@@ -54,14 +56,6 @@ struct swap_memcg_table {
  * - Bad: Swap slot is reserved, protects swap header or holes on swap devices.
  */
 
-#if defined(MAX_POSSIBLE_PHYSMEM_BITS)
-#define SWAP_CACHE_PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
-#elif defined(MAX_PHYSMEM_BITS)
-#define SWAP_CACHE_PFN_BITS (MAX_PHYSMEM_BITS - PAGE_SHIFT)
-#else
-#define SWAP_CACHE_PFN_BITS (BITS_PER_LONG - PAGE_SHIFT)
-#endif
-
 /* NULL Entry, all 0 */
 #define SWP_TB_NULL		0UL
 
@@ -69,22 +63,26 @@ struct swap_memcg_table {
 #define SWP_TB_SHADOW_MARK	0b1UL
 
 /* Cached: PFN */
-#define SWP_TB_PFN_BITS		(SWAP_CACHE_PFN_BITS + SWP_TB_PFN_MARK_BITS)
+#define SWP_TB_PFN_BITS		(SWAP_CACHE_PFN_BITS + SWAP_CACHE_PFN_MARK_BITS)
 #define SWP_TB_PFN_MARK		0b10UL
-#define SWP_TB_PFN_MARK_BITS	2
-#define SWP_TB_PFN_MARK_MASK	(BIT(SWP_TB_PFN_MARK_BITS) - 1)
+#define SWP_TB_PFN_MARK_MASK	(BIT(SWAP_CACHE_PFN_MARK_BITS) - 1)
 
-/* SWAP_COUNT part for PFN or shadow, the width can be shrunk or extended */
-#define SWP_TB_COUNT_BITS      min(4, BITS_PER_LONG - SWP_TB_PFN_BITS)
+/* Flags: For PFN or shadow, contains SWAP_COUNT, width changes */
+#define SWP_TB_FLAGS_BITS	min(5, BITS_PER_LONG - SWP_TB_PFN_BITS)
+#define SWP_TB_COUNT_BITS	(SWP_TB_FLAGS_BITS - SWAP_TABLE_HAS_ZEROFLAG)
+#define SWP_TB_FLAGS_MASK	(~((~0UL) >> SWP_TB_FLAGS_BITS))
 #define SWP_TB_COUNT_MASK      (~((~0UL) >> SWP_TB_COUNT_BITS))
+#define SWP_TB_FLAGS_SHIFT     (BITS_PER_LONG - SWP_TB_FLAGS_BITS)
 #define SWP_TB_COUNT_SHIFT     (BITS_PER_LONG - SWP_TB_COUNT_BITS)
 #define SWP_TB_COUNT_MAX       ((1 << SWP_TB_COUNT_BITS) - 1)
+/* The first flag is zero bit (SWAP_TABLE_HAS_ZEROFLAG) */
+#define SWP_TB_ZERO_FLAG	BIT(BITS_PER_LONG - SWP_TB_FLAGS_BITS)
 
 /* Bad slot: ends with 0b1000 and rests of bits are all 1 */
 #define SWP_TB_BAD		((~0UL) << 3)
 
 /* Macro for shadow offset calculation */
-#define SWAP_COUNT_SHIFT	SWP_TB_COUNT_BITS
+#define SWAP_COUNT_SHIFT	SWP_TB_FLAGS_BITS
 
 /*
  * Helpers for casting one type of info into a swap table entry.
@@ -102,40 +100,47 @@ static inline unsigned long __count_to_swp_tb(unsigned char count)
 	 * used (count > 0 && count < SWP_TB_COUNT_MAX), and
 	 * overflow (count == SWP_TB_COUNT_MAX).
 	 */
-	BUILD_BUG_ON(SWP_TB_COUNT_MAX < 2 || SWP_TB_COUNT_BITS < 2);
+	BUILD_BUG_ON(SWP_TB_COUNT_BITS < SWAP_COUNT_MIN_BITS);
 	VM_WARN_ON(count > SWP_TB_COUNT_MAX);
 	return ((unsigned long)count) << SWP_TB_COUNT_SHIFT;
 }
 
-static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned int count)
+static inline unsigned long __flags_to_swp_tb(unsigned char flags)
+{
+	BUILD_BUG_ON(SWP_TB_FLAGS_BITS > BITS_PER_BYTE);
+	VM_WARN_ON(flags >> SWP_TB_FLAGS_BITS);
+	return ((unsigned long)flags) << SWP_TB_FLAGS_SHIFT;
+}
+
+static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned char flags)
 {
 	unsigned long swp_tb;
 
 	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(void *));
 	BUILD_BUG_ON(SWAP_CACHE_PFN_BITS >
-		     (BITS_PER_LONG - SWP_TB_PFN_MARK_BITS - SWP_TB_COUNT_BITS));
+		     (BITS_PER_LONG - SWAP_CACHE_PFN_MARK_BITS - SWP_TB_FLAGS_BITS));
 
-	swp_tb = (pfn << SWP_TB_PFN_MARK_BITS) | SWP_TB_PFN_MARK;
-	VM_WARN_ON_ONCE(swp_tb & SWP_TB_COUNT_MASK);
+	swp_tb = (pfn << SWAP_CACHE_PFN_MARK_BITS) | SWP_TB_PFN_MARK;
+	VM_WARN_ON_ONCE(swp_tb & SWP_TB_FLAGS_MASK);
 
-	return swp_tb | __count_to_swp_tb(count);
+	return swp_tb | __flags_to_swp_tb(flags);
 }
 
-static inline unsigned long folio_to_swp_tb(struct folio *folio, unsigned int count)
+static inline unsigned long folio_to_swp_tb(struct folio *folio, unsigned char flags)
 {
-	return pfn_to_swp_tb(folio_pfn(folio), count);
+	return pfn_to_swp_tb(folio_pfn(folio), flags);
 }
 
-static inline unsigned long shadow_to_swp_tb(void *shadow, unsigned int count)
+static inline unsigned long shadow_to_swp_tb(void *shadow, unsigned char flags)
 {
 	BUILD_BUG_ON((BITS_PER_XA_VALUE + 1) !=
 		     BITS_PER_BYTE * sizeof(unsigned long));
 	BUILD_BUG_ON((unsigned long)xa_mk_value(0) != SWP_TB_SHADOW_MARK);
 
 	VM_WARN_ON_ONCE(shadow && !xa_is_value(shadow));
-	VM_WARN_ON_ONCE(shadow && ((unsigned long)shadow & SWP_TB_COUNT_MASK));
+	VM_WARN_ON_ONCE(shadow && ((unsigned long)shadow & SWP_TB_FLAGS_MASK));
 
-	return (unsigned long)shadow | __count_to_swp_tb(count) | SWP_TB_SHADOW_MARK;
+	return (unsigned long)shadow | SWP_TB_SHADOW_MARK | __flags_to_swp_tb(flags);
 }
 
 /*
@@ -173,14 +178,14 @@ static inline bool swp_tb_is_countable(unsigned long swp_tb)
 static inline struct folio *swp_tb_to_folio(unsigned long swp_tb)
 {
 	VM_WARN_ON(!swp_tb_is_folio(swp_tb));
-	return pfn_folio((swp_tb & ~SWP_TB_COUNT_MASK) >> SWP_TB_PFN_MARK_BITS);
+	return pfn_folio((swp_tb & ~SWP_TB_FLAGS_MASK) >> SWAP_CACHE_PFN_MARK_BITS);
 }
 
 static inline void *swp_tb_to_shadow(unsigned long swp_tb)
 {
 	VM_WARN_ON(!swp_tb_is_shadow(swp_tb));
 	/* No shift needed, xa_value is stored as it is in the lower bits. */
-	return (void *)(swp_tb & ~SWP_TB_COUNT_MASK);
+	return (void *)(swp_tb & ~SWP_TB_FLAGS_MASK);
 }
 
 static inline unsigned char __swp_tb_get_count(unsigned long swp_tb)
@@ -189,6 +194,12 @@ static inline unsigned char __swp_tb_get_count(unsigned long swp_tb)
 	return ((swp_tb & SWP_TB_COUNT_MASK) >> SWP_TB_COUNT_SHIFT);
 }
 
+static inline unsigned char __swp_tb_get_flags(unsigned long swp_tb)
+{
+	VM_WARN_ON(!swp_tb_is_countable(swp_tb));
+	return ((swp_tb & SWP_TB_FLAGS_MASK) >> SWP_TB_FLAGS_SHIFT);
+}
+
 static inline int swp_tb_get_count(unsigned long swp_tb)
 {
 	if (swp_tb_is_countable(swp_tb))
@@ -253,6 +264,50 @@ static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
 	return swp_tb;
 }
 
+static inline void __swap_table_set_zero(struct swap_cluster_info *ci,
+					 unsigned int ci_off)
+{
+#if SWAP_TABLE_HAS_ZEROFLAG
+	unsigned long swp_tb = __swap_table_get(ci, ci_off);
+
+	BUILD_BUG_ON(SWP_TB_ZERO_FLAG & ~SWP_TB_FLAGS_MASK);
+	VM_WARN_ON(!swp_tb_is_countable(swp_tb));
+	swp_tb |= SWP_TB_ZERO_FLAG;
+	__swap_table_set(ci, ci_off, swp_tb);
+#else
+	lockdep_assert_held(&ci->lock);
+	__set_bit(ci_off, ci->zero_bitmap);
+#endif
+}
+
+static inline bool __swap_table_test_zero(struct swap_cluster_info *ci,
+					  unsigned int ci_off)
+{
+#if SWAP_TABLE_HAS_ZEROFLAG
+	unsigned long swp_tb = __swap_table_get(ci, ci_off);
+
+	VM_WARN_ON(!swp_tb_is_countable(swp_tb));
+	return !!(swp_tb & SWP_TB_ZERO_FLAG);
+#else
+	return test_bit(ci_off, ci->zero_bitmap);
+#endif
+}
+
+static inline void __swap_table_clear_zero(struct swap_cluster_info *ci,
+					   unsigned int ci_off)
+{
+#if SWAP_TABLE_HAS_ZEROFLAG
+	unsigned long swp_tb = __swap_table_get(ci, ci_off);
+
+	VM_WARN_ON(!swp_tb_is_countable(swp_tb));
+	swp_tb &= ~SWP_TB_ZERO_FLAG;
+	__swap_table_set(ci, ci_off, swp_tb);
+#else
+	lockdep_assert_held(&ci->lock);
+	__clear_bit(ci_off, ci->zero_bitmap);
+#endif
+}
+
 #ifdef CONFIG_MEMCG
 static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
 		unsigned int ci_off, unsigned long nr, unsigned short id)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 095e9c953e49..a9a1e477fec9 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -427,6 +427,11 @@ static void swap_cluster_free_table(struct swap_cluster_info *ci)
 	ci->memcg_table = NULL;
 #endif
 
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	kfree(ci->zero_bitmap);
+	ci->zero_bitmap = NULL;
+#endif
+
 	table = (struct swap_table *)rcu_access_pointer(ci->table);
 	if (!table)
 		return;
@@ -469,13 +474,21 @@ static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t gfp)
 		VM_WARN_ON_ONCE(ci->memcg_table);
 		ci->memcg_table = kzalloc_obj(*ci->memcg_table, gfp);
 		if (!ci->memcg_table)
-			ret = -ENOMEM;
+			goto err_free;
 	}
 #endif
-	if (ret)
-		swap_cluster_free_table(ci);
 
-	return ret;
+#if !SWAP_TABLE_HAS_ZEROFLAG
+	VM_WARN_ON_ONCE(ci->zero_bitmap);
+	ci->zero_bitmap = bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
+	if (!ci->zero_bitmap)
+		goto err_free;
+#endif
+	return 0;
+
+err_free:
+	swap_cluster_free_table(ci);
+	return -ENOMEM;
 }
 
 /*
@@ -928,8 +941,8 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 		order = 0;
 		nr_pages = 1;
 		swap_cluster_assert_empty(ci, ci_off, 1, false);
-		/* Sets a fake shadow as placeholder */
-		__swap_table_set(ci, ci_off, shadow_to_swp_tb(NULL, 1));
+		/* Fake shadow placeholder with no flag, hibernation does not use the zeromap */
+		__swap_table_set(ci, ci_off, __swp_tb_mk_count(shadow_to_swp_tb(NULL, 0), 1));
 	} else {
 		/* Allocation without folio is only possible with hibernation */
 		WARN_ON_ONCE(1);
@@ -1302,14 +1315,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
 	void (*swap_slot_free_notify)(struct block_device *, unsigned long);
 	unsigned int i;
 
-	/*
-	 * Use atomic clear_bit operations only on zeromap instead of non-atomic
-	 * bitmap_clear to prevent adjacent bits corruption due to simultaneous writes.
-	 */
-	for (i = 0; i < nr_entries; i++) {
-		clear_bit(offset + i, si->zeromap);
+	for (i = 0; i < nr_entries; i++)
 		zswap_invalidate(swp_entry(si->type, offset + i));
-	}
 
 	if (si->flags & SWP_BLKDEV)
 		swap_slot_free_notify =
@@ -1894,7 +1901,11 @@ void __swap_cluster_free_entries(struct swap_info_struct *si,
 		 * ref, or after swap cache is dropped
 		 */
 		VM_WARN_ON(!swp_tb_is_shadow(old_tb) || __swp_tb_get_count(old_tb) > 1);
+
+		/* Resetting the slot to NULL also clears the inline flags. */
 		__swap_table_set(ci, ci_off, null_to_swp_tb());
+		if (!SWAP_TABLE_HAS_ZEROFLAG)
+			__swap_table_clear_zero(ci, ci_off);
 
 		/*
 		 * Uncharge swap slots by memcg in batches. Consecutive
@@ -3088,7 +3099,6 @@ static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
-	unsigned long *zeromap;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -3184,8 +3194,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
-	zeromap = p->zeromap;
-	p->zeromap = NULL;
 	maxpages = p->max;
 	cluster_info = p->cluster_info;
 	p->max = 0;
@@ -3197,7 +3205,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	mutex_unlock(&swapon_mutex);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
-	kvfree(zeromap);
 	free_swap_cluster_info(cluster_info, maxpages);
 
 	inode = mapping->host;
@@ -3729,17 +3736,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	if (error)
 		goto bad_swap_unlock_inode;
 
-	/*
-	 * Use kvmalloc_array instead of bitmap_zalloc as the allocation order might
-	 * be above MAX_PAGE_ORDER incase of a large swap file.
-	 */
-	si->zeromap = kvmalloc_array(BITS_TO_LONGS(maxpages), sizeof(long),
-				     GFP_KERNEL | __GFP_ZERO);
-	if (!si->zeromap) {
-		error = -ENOMEM;
-		goto bad_swap_unlock_inode;
-	}
-
 	if (si->bdev && bdev_stable_writes(si->bdev))
 		si->flags |= SWP_STABLE_WRITES;
 
@@ -3841,8 +3837,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	destroy_swap_extents(si, swap_file);
 	free_swap_cluster_info(si->cluster_info, si->max);
 	si->cluster_info = NULL;
-	kvfree(si->zeromap);
-	si->zeromap = NULL;
 	/*
 	 * Clear the SWP_USED flag after all resources are freed so
 	 * alloc_swap_info can reuse this si safely.

-- 
2.54.0



