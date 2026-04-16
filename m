Return-Path: <cgroups+bounces-15333-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHjhA0Qs4WmQqAAAu9opvQ
	(envelope-from <cgroups+bounces-15333-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:52 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6182413CB1
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 20:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D60CC30B50BF
	for <lists+cgroups@lfdr.de>; Thu, 16 Apr 2026 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4198433E35B;
	Thu, 16 Apr 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9jwFxZE"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94C933AD9D;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776364484; cv=none; b=EYdKFlmDCCh8JUMhL7s3df7cd1VhQTqBCawzCKklz5xjKs7BQzXG1zKvEJDPAPda4uo6JKroWMgo2IHRftXP2R2Xo2TeUasrTEehOOauyodLotMTOpZFaA7iB44180xX4dGOXnQq4hBGyYuruRfeLNYCbSvoTIlTQw8JyfUNm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776364484; c=relaxed/simple;
	bh=aZB698+gAbXXAdXUMquyJP/Mf7DXzpLLU5R5yDH/rDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahuVSi7T1exgyn6KKLp+LItgA6ghsQOZ0GLmcwpGRT6Af5S6dUxXf5Hy3RxGrzCQ8HB5PfxNQ8gpnGkl1n2XVMQ/dkl+QpuGuRola05HnxdA6lbjvxDurj7rJh+QbXdp0H7KeY08VgqHVZSl8X5SuOO5Xw5sWFgyoVZmBSM1jhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9jwFxZE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8EB8C2BCB7;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776364483;
	bh=aZB698+gAbXXAdXUMquyJP/Mf7DXzpLLU5R5yDH/rDI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=h9jwFxZE9nC5ZgqgTZ0iofm+21vNV+rtwwsqoisivn9ZgNduBYgBZrX8Yzi7X3JMO
	 qHLmVY4BMhyAEc/sKJCj2tg1fPItGuNa8gqK+lyieTts2QhXBjhy8C8khIfyCfrGB0
	 9zVGlVe5dOadTE8mapOG10H4zvjFDnoav4K9/fw+oYb4HlH94aRmYLQ1h7yjV3hNKT
	 Xs2isfhrIfnzZMYHMhO8bJO/188VNC0p0wE4/hWpjL3/9osLt6dAyRKo1cPIJjD6Wz
	 gasynWJ104ojGlW8r1Q/mklqUSydPvBJaDSaWrjfzhxiV+h1R15cYnGaMEQsZSo8Lx
	 E+zrHUIu84zwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18E1F8D755;
	Thu, 16 Apr 2026 18:34:43 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 17 Apr 2026 02:34:41 +0800
Subject: [PATCH v2 11/11] mm, swap: merge zeromap into swap table
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-swap-table-p4-v2-11-17f5d1015428@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776364480; l=20091;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=aLbY9FwW47CRL8bDpagKg25iezsg11VqpCHhhAjbwxQ=;
 b=uwXHF5kNjNOYoxpYahpBUA6/krOOlclFJjN3PCoOhVFxd76dUFjZ8p5MLYpqpkuUljuxgE8MD
 pGIm8eJG+2ADKWg6xPT9abYQF7rz1ZvmcXuEhjdelMZiMETpZDzUVsc
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15333-lists,cgroups=lfdr.de,kasong.tencent.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,tencent.com:replyto,tencent.com:mid]
X-Rspamd-Queue-Id: A6182413CB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

By reserving one bit for the counting part, we can easily merge the
zeromap into the swap table.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  1 -
 mm/memory.c          | 11 ++------
 mm/page_io.c         | 58 +++++++++++++++++++++++++++++++------
 mm/swap.h            | 31 --------------------
 mm/swap_state.c      | 14 +++++----
 mm/swap_table.h      | 80 +++++++++++++++++++++++++++++++++++++++++-----------
 mm/swapfile.c        | 27 ++----------------
 7 files changed, 125 insertions(+), 97 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 57af4647d432..8f0f68e245ba 100644
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
index 404734a5bcff..a45905f8728f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4595,13 +4595,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 
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
 
@@ -4611,18 +4609,13 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 
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
index 70cea9e24d2f..fffe51bf8543 100644
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
@@ -509,12 +519,44 @@ static void sio_read_complete(struct kiocb *iocb, long ret)
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
+	bool is_zero;
+	unsigned long swp_tb;
+	struct swap_cluster_info *ci = __swap_entry_to_cluster(entry);
+	unsigned int ci_start = swp_cluster_offset(entry), ci_off, ci_end;
+
+	ci_off = ci_start;
+	ci_end = ci_off + max_nr;
+	swp_tb = swap_table_get(ci, ci_off);
+	is_zero = __swp_tb_is_zero(swp_tb);
+	if (is_zerop)
+		*is_zerop = is_zero;
+	while (++ci_off < ci_end) {
+		swp_tb = swap_table_get(ci, ci_off);
+		if (is_zero != __swp_tb_is_zero(swp_tb))
+			break;
+	}
+	return ci_off - ci_start;
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
diff --git a/mm/swap.h b/mm/swap.h
index 319dbe4eb299..68e739923df3 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -315,31 +315,6 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
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
@@ -477,11 +452,5 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
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
index c3d19c9fc594..b842fb65ae7e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -159,6 +159,7 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 {
 	unsigned int ci_off, ci_end;
 	unsigned long old_tb;
+	bool is_zero;
 
 	/*
 	 * If the target slot is not swapped out, return
@@ -181,12 +182,14 @@ static int __swap_cache_add_check(struct swap_cluster_info *ci,
 	if (nr == 1)
 		return 0;
 
+	is_zero = __swp_tb_is_zero(old_tb);
 	ci_off = round_down(ci_off, nr);
 	ci_end = ci_off + nr;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		if (unlikely(swp_tb_is_folio(old_tb) ||
 			     !__swp_tb_get_count(old_tb) ||
+			     is_zero != __swp_tb_is_zero(old_tb) ||
 			     (memcg_id && *memcg_id != __swap_cgroup_get(ci, ci_off))))
 			return -EBUSY;
 	} while (++ci_off < ci_end);
@@ -210,7 +213,7 @@ static void __swap_cache_do_add_folio(struct swap_cluster_info *ci,
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		VM_WARN_ON_ONCE(swp_tb_is_folio(old_tb));
-		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_count(old_tb)));
+		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_flags(old_tb)));
 	} while (++ci_off < ci_end);
 
 	folio_ref_add(folio, nr_pages);
@@ -246,7 +249,6 @@ static void __swap_cache_do_del_folio(struct swap_cluster_info *ci,
 				      struct folio *folio,
 				      swp_entry_t entry, void *shadow)
 {
-	int count;
 	unsigned long old_tb;
 	struct swap_info_struct *si;
 	unsigned int ci_start, ci_off, ci_end;
@@ -266,13 +268,13 @@ static void __swap_cache_do_del_folio(struct swap_cluster_info *ci,
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
@@ -366,7 +368,7 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
 		WARN_ON_ONCE(!swp_tb_is_folio(old_tb) || swp_tb_to_folio(old_tb) != old);
-		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_count(old_tb)));
+		__swap_table_set(ci, ci_off, pfn_to_swp_tb(pfn, __swp_tb_get_flags(old_tb)));
 	} while (++ci_off < ci_end);
 
 	/*
diff --git a/mm/swap_table.h b/mm/swap_table.h
index b2b02ee161b1..a87100dd5fda 100644
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
+ * COUNT is `SWP_TB_COUNT_BITS` long, Z is the `SWP_TB_ZERO_MARK` bit,
+ * and together they form the `SWP_TB_FLAGS_BITS` wide flags field.
+ * Each entry is an atomic long.
  *
  * Usages:
  *
@@ -74,17 +76,22 @@ struct swap_memcg_table {
 #define SWP_TB_PFN_MARK_BITS	2
 #define SWP_TB_PFN_MARK_MASK	(BIT(SWP_TB_PFN_MARK_BITS) - 1)
 
-/* SWAP_COUNT part for PFN or shadow, the width can be shrunk or extended */
-#define SWP_TB_COUNT_BITS      min(4, BITS_PER_LONG - SWP_TB_PFN_BITS)
+/* SWAP_COUNT and flags for PFN or shadow, width can be shrunk or extended */
+#define SWP_TB_FLAGS_BITS	min(5, BITS_PER_LONG - SWP_TB_PFN_BITS)
+#define SWP_TB_COUNT_BITS	(SWP_TB_FLAGS_BITS - 1)
+#define SWP_TB_FLAGS_MASK	(~((~0UL) >> SWP_TB_FLAGS_BITS))
 #define SWP_TB_COUNT_MASK      (~((~0UL) >> SWP_TB_COUNT_BITS))
+#define SWP_TB_FLAGS_SHIFT     (BITS_PER_LONG - SWP_TB_FLAGS_BITS)
 #define SWP_TB_COUNT_SHIFT     (BITS_PER_LONG - SWP_TB_COUNT_BITS)
 #define SWP_TB_COUNT_MAX       ((1 << SWP_TB_COUNT_BITS) - 1)
 
+#define SWP_TB_ZERO_MARK	BIT(BITS_PER_LONG - SWP_TB_COUNT_BITS - 1)
+
 /* Bad slot: ends with 0b1000 and rests of bits are all 1 */
 #define SWP_TB_BAD		((~0UL) << 3)
 
 /* Macro for shadow offset calculation */
-#define SWAP_COUNT_SHIFT	SWP_TB_COUNT_BITS
+#define SWAP_COUNT_SHIFT	SWP_TB_FLAGS_BITS
 
 /*
  * Helpers for casting one type of info into a swap table entry.
@@ -107,35 +114,42 @@ static inline unsigned long __count_to_swp_tb(unsigned char count)
 	return ((unsigned long)count) << SWP_TB_COUNT_SHIFT;
 }
 
-static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned int count)
+static inline unsigned long __flags_to_swp_tb(unsigned char flags)
+{
+	BUILD_BUG_ON(SWP_TB_FLAGS_BITS > BITS_PER_BYTE);
+	VM_WARN_ON((flags >> 1) > SWP_TB_COUNT_MAX);
+	return ((unsigned long)flags) << SWP_TB_FLAGS_SHIFT;
+}
+
+static inline unsigned long pfn_to_swp_tb(unsigned long pfn, unsigned char flags)
 {
 	unsigned long swp_tb;
 
 	BUILD_BUG_ON(sizeof(unsigned long) != sizeof(void *));
 	BUILD_BUG_ON(SWAP_CACHE_PFN_BITS >
-		     (BITS_PER_LONG - SWP_TB_PFN_MARK_BITS - SWP_TB_COUNT_BITS));
+		     (BITS_PER_LONG - SWP_TB_PFN_MARK_BITS - SWP_TB_FLAGS_BITS));
 
 	swp_tb = (pfn << SWP_TB_PFN_MARK_BITS) | SWP_TB_PFN_MARK;
-	VM_WARN_ON_ONCE(swp_tb & SWP_TB_COUNT_MASK);
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
@@ -167,20 +181,26 @@ static inline bool swp_tb_is_countable(unsigned long swp_tb)
 		swp_tb_is_null(swp_tb));
 }
 
+static inline bool __swp_tb_is_zero(unsigned long swp_tb)
+{
+	VM_WARN_ON_ONCE(!swp_tb_is_countable(swp_tb));
+	return swp_tb & SWP_TB_ZERO_MARK;
+}
+
 /*
  * Helpers for retrieving info from swap table.
  */
 static inline struct folio *swp_tb_to_folio(unsigned long swp_tb)
 {
 	VM_WARN_ON(!swp_tb_is_folio(swp_tb));
-	return pfn_folio((swp_tb & ~SWP_TB_COUNT_MASK) >> SWP_TB_PFN_MARK_BITS);
+	return pfn_folio((swp_tb & ~SWP_TB_FLAGS_MASK) >> SWP_TB_PFN_MARK_BITS);
 }
 
 static inline void *swp_tb_to_shadow(unsigned long swp_tb)
 {
 	VM_WARN_ON(!swp_tb_is_shadow(swp_tb));
 	/* No shift needed, xa_value is stored as it is in the lower bits. */
-	return (void *)(swp_tb & ~SWP_TB_COUNT_MASK);
+	return (void *)(swp_tb & ~SWP_TB_FLAGS_MASK);
 }
 
 static inline unsigned char __swp_tb_get_count(unsigned long swp_tb)
@@ -189,6 +209,12 @@ static inline unsigned char __swp_tb_get_count(unsigned long swp_tb)
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
@@ -253,6 +279,26 @@ static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
 	return swp_tb;
 }
 
+static inline void __swap_table_set_zero(struct swap_cluster_info *ci,
+					 unsigned int ci_off)
+{
+	unsigned long swp_tb = __swap_table_get(ci, ci_off);
+
+	VM_WARN_ON(!swp_tb_is_countable(swp_tb));
+	swp_tb |= SWP_TB_ZERO_MARK;
+	__swap_table_set(ci, ci_off, swp_tb);
+}
+
+static inline void __swap_table_clear_zero(struct swap_cluster_info *ci,
+					   unsigned int ci_off)
+{
+	unsigned long swp_tb = __swap_table_get(ci, ci_off);
+
+	VM_WARN_ON(!swp_tb_is_countable(swp_tb));
+	swp_tb &= ~SWP_TB_ZERO_MARK;
+	__swap_table_set(ci, ci_off, swp_tb);
+}
+
 #ifdef CONFIG_MEMCG
 static inline void __swap_cgroup_set(struct swap_cluster_info *ci,
 		unsigned int ci_off, unsigned long nr, unsigned short id)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0753a62ebc25..e100908d4129 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -964,7 +964,7 @@ static bool __swap_cluster_alloc_entries(struct swap_info_struct *si,
 		nr_pages = 1;
 		swap_cluster_assert_empty(ci, ci_off, 1, false);
 		/* Sets a fake shadow as placeholder */
-		__swap_table_set(ci, ci_off, shadow_to_swp_tb(NULL, 1));
+		__swap_table_set(ci, ci_off, __swp_tb_mk_count(shadow_to_swp_tb(NULL, 0), 1));
 	} else {
 		/* Allocation without folio is only possible with hibernation */
 		WARN_ON_ONCE(1);
@@ -1336,14 +1336,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
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
@@ -3061,7 +3055,6 @@ static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
-	unsigned long *zeromap;
 	struct swap_cluster_info *cluster_info;
 	struct file *swap_file, *victim;
 	struct address_space *mapping;
@@ -3157,8 +3150,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	swap_file = p->swap_file;
 	p->swap_file = NULL;
-	zeromap = p->zeromap;
-	p->zeromap = NULL;
 	maxpages = p->max;
 	cluster_info = p->cluster_info;
 	p->max = 0;
@@ -3170,7 +3161,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	mutex_unlock(&swapon_mutex);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
-	kvfree(zeromap);
 	free_swap_cluster_info(cluster_info, maxpages);
 
 	inode = mapping->host;
@@ -3702,17 +3692,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
 
@@ -3814,8 +3793,6 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	destroy_swap_extents(si, swap_file);
 	free_swap_cluster_info(si->cluster_info, si->max);
 	si->cluster_info = NULL;
-	kvfree(si->zeromap);
-	si->zeromap = NULL;
 	/*
 	 * Clear the SWP_USED flag after all resources are freed so
 	 * alloc_swap_info can reuse this si safely.

-- 
2.53.0



