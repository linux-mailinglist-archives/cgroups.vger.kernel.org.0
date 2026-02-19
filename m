Return-Path: <cgroups+bounces-14032-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLxdEiGgl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14032-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:29 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E46931639DF
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 529E2305F7D3
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4589B330328;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gutj444u"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E950332D43C;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544528; cv=none; b=TxIqEtz7EOtE59GnDr0FNlNbKQMdniM+0+rM1f3VtTQkkACGkRXvwuseA6dkJtK7Jt8yqfXQMlsX8q3jYTYRU532w5gIouqj0DiMnbryW5zyYzmTwd6anIi1jkRtpJipB91hfQ+aMoh/+KMBBf0fKb7H6DVDYpV2crHJDQunZjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544528; c=relaxed/simple;
	bh=7fVNl2OWSZn5yIAaZMdbJy8esxpVNqxwiw/ChyI7RI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irYGUlDIUgLXivF2vs/ZuVftuCfqSSGE0n89wPKqBHhZcjVRHKZOXabPVywVN39SWX3gFh3hQ1NYZ4bhiNAQc6dyjmLx/L1Ns9YN0nk8z8fIxEP+aGm/zNfUs/Nz9ThkpsPXPlzA0WnZKTiEuNBTQpzmqAMMNiv+GZ7s8y8CC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gutj444u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC63EC116C6;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544527;
	bh=7fVNl2OWSZn5yIAaZMdbJy8esxpVNqxwiw/ChyI7RI8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gutj444uK2RjiSDXuWpNITUZSFe22ZDCg5BOQxexBE5QKnd/jwXsdUge+dqFwKryQ
	 5vCzE9A/AmchcdBBvU9G5g1UxNIDXHadQOZeellY7WZ0GHK4CNU+clLYjjoEs5ccp6
	 Yf4ltSnll7hIlZ/BjxAUVnlRvhWE3PpWpkxvB1He4qUyMyXmAq3PrBv9O45AOWoEJY
	 5i+j4s6B2K244MbMZQZSQX51cTw7ZH3sRwicL1Y2kkMsbBshdGMdlaZXVKMw+aoyiM
	 2MERmy08ck+5sVPOG9po56/zI95lxP733oXgxuGBRSck0VnykXAu8fn4soqhDdu6BV
	 qMjo3zu08GvOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47E2C531E3;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 20 Feb 2026 07:42:09 +0800
Subject: [PATCH RFC 08/15] mm, swap: store and check memcg info in the swap
 table
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-swap-table-p4-v1-8-104795d19815@tencent.com>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
In-Reply-To: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=11918;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=T46p8i3lmd7nNPEr9N3RzFlb/rLjAdfkkrw3HoHcgOA=;
 b=ACLCqf4sQhtOMVUw7uIzQypZq7bA8GsNSCfaFYF7EJAQ3irEZYoDIiP6FtvzUwRYrJH13tShm
 Hs2UKl47dqHD/sSc/bYJeKsgR98o16GR9f3V+K0HcrnsXdNGKtXBqBL
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14032-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com]
X-Rspamd-Queue-Id: E46931639DF
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

To prepare for merging the swap_cgroup_ctrl into the swap table, store
the memcg info in the swap table on swapout.

This is done by using the existing shadow format.

Note this also changes the refault counting at the nearest online memcg
level:

Unlike file folios, anon folios are mostly exclusive to one mem cgroup,
and each cgroup is likely to have different characteristics.

When commit b910718a948a ("mm: vmscan: detect file thrashing at the
reclaim root") moved the refault accounting to the reclaim root level,
anon shadows don't even exist, and it's explicitly for file pages. Later
commit aae466b0052e ("mm/swap: implement workingset detection for
anonymous LRU") added anon shadows following a similar design. And in
shrink_lruvec, an active LRU's shrinking is done regardlessly when it's
low.

For MGLRU, it's a bit different, but with the PID refault control, it's
more accurate to let the nearest online memcg take the refault feedback
too.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/internal.h   | 20 ++++++++++++++++++++
 mm/swap.h       |  7 ++++---
 mm/swap_state.c | 50 +++++++++++++++++++++++++++++++++-----------------
 mm/swapfile.c   |  4 +++-
 mm/vmscan.c     |  6 +-----
 mm/workingset.c | 16 +++++++++++-----
 6 files changed, 72 insertions(+), 31 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index cb0af847d7d9..5bbe081c9048 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1714,6 +1714,7 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 #endif /* CONFIG_SHRINKER_DEBUG */
 
 /* Only track the nodes of mappings with shadow entries */
+#define WORKINGSET_SHIFT 1
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
 #define mapping_set_update(xas, mapping) do {			\
@@ -1722,6 +1723,25 @@ extern struct list_lru shadow_nodes;
 		xas_set_lru(xas, &shadow_nodes);		\
 	}							\
 } while (0)
+static inline unsigned short shadow_to_memcgid(void *shadow)
+{
+	unsigned long entry = xa_to_value(shadow);
+	unsigned short memcgid;
+
+	entry >>= (WORKINGSET_SHIFT + NODES_SHIFT);
+	memcgid = entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
+
+	return memcgid;
+}
+static inline void *memcgid_to_shadow(unsigned short memcgid)
+{
+	unsigned long val;
+
+	val = memcgid;
+	val <<= (NODES_SHIFT + WORKINGSET_SHIFT);
+
+	return xa_mk_value(val);
+}
 
 /* mremap.c */
 unsigned long move_page_tables(struct pagetable_move_control *pmc);
diff --git a/mm/swap.h b/mm/swap.h
index da41e9cea46d..c95f5fafea42 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -265,6 +265,8 @@ static inline bool folio_matches_swap_entry(const struct folio *folio,
 	return folio_entry.val == round_down(entry.val, nr_pages);
 }
 
+bool folio_maybe_swapped(struct folio *folio);
+
 /*
  * All swap cache helpers below require the caller to ensure the swap entries
  * used are valid and stabilize the device by any of the following ways:
@@ -286,9 +288,8 @@ struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
 /* Below helpers require the caller to lock and pass in the swap cluster. */
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
 			    struct folio *folio, swp_entry_t entry);
-void __swap_cache_del_folio(struct swap_cluster_info *ci,
-			    struct folio *folio, void *shadow,
-			    bool charged, bool reclaim);
+void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
+			    void *shadow, bool charged, bool reclaim);
 void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 				struct folio *old, struct folio *new);
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 40f037576c5f..cc4bf40320ef 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -143,22 +143,11 @@ static int __swap_cache_check_batch(struct swap_cluster_info *ci,
 {
 	unsigned int ci_end = ci_off + nr;
 	unsigned long old_tb;
+	unsigned int memcgid;
 
 	if (unlikely(!ci->table))
 		return -ENOENT;
 
-	do {
-		old_tb = __swap_table_get(ci, ci_off);
-		if (unlikely(swp_tb_is_folio(old_tb)) ||
-		    unlikely(!__swp_tb_get_count(old_tb)))
-			break;
-		if (swp_tb_is_shadow(old_tb))
-			*shadowp = swp_tb_to_shadow(old_tb);
-	} while (++ci_off < ci_end);
-
-	if (likely(ci_off == ci_end))
-		return 0;
-
 	/*
 	 * If the target slot is not suitable for adding swap cache, return
 	 * -EEXIST or -ENOENT. If the batch is not suitable, could be a
@@ -169,7 +158,21 @@ static int __swap_cache_check_batch(struct swap_cluster_info *ci,
 		return -EEXIST;
 	if (!__swp_tb_get_count(old_tb))
 		return -ENOENT;
-	return -EBUSY;
+	if (WARN_ON_ONCE(!swp_tb_is_shadow(old_tb)))
+		return -ENOENT;
+	*shadowp = swp_tb_to_shadow(old_tb);
+	memcgid = shadow_to_memcgid(*shadowp);
+
+	WARN_ON_ONCE(!mem_cgroup_disabled() && !memcgid);
+	do {
+		old_tb = __swap_table_get(ci, ci_off);
+		if (unlikely(swp_tb_is_folio(old_tb)) ||
+		    unlikely(!__swp_tb_get_count(old_tb)) ||
+		    memcgid != shadow_to_memcgid(swp_tb_to_shadow(old_tb)))
+			return -EBUSY;
+	} while (++ci_off < ci_end);
+
+	return 0;
 }
 
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
@@ -261,8 +264,7 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 
 	/* For memsw accouting, swap is uncharged when folio is added to swap cache */
 	memcg1_swapin(folio);
-	if (shadow)
-		workingset_refault(folio, shadow);
+	workingset_refault(folio, shadow);
 
 	/* Caller will initiate read into locked new_folio */
 	folio_add_lru(folio);
@@ -319,7 +321,8 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp_mask,
  * __swap_cache_del_folio - Removes a folio from the swap cache.
  * @ci: The locked swap cluster.
  * @folio: The folio.
- * @shadow: shadow value to be filled in the swap cache.
+ * @shadow: Shadow to restore when the folio is not charged. Ignored when
+ *          @charged is true, as the shadow is computed internally.
  * @charged: If folio->swap is charged to folio->memcg.
  * @reclaim: If the folio is being reclaimed. When true on cgroup v1,
  *           the memory charge is transferred from memory to swap.
@@ -336,6 +339,7 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 	int count;
 	unsigned long old_tb;
 	struct swap_info_struct *si;
+	struct mem_cgroup *memcg = NULL;
 	swp_entry_t entry = folio->swap;
 	unsigned int ci_start, ci_off, ci_end;
 	bool folio_swapped = false, need_free = false;
@@ -353,7 +357,13 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
 	 * charging (e.g. swapin charge failure, or swap alloc charge failure).
 	 */
 	if (charged)
-		mem_cgroup_swap_free_folio(folio, reclaim);
+		memcg = mem_cgroup_swap_free_folio(folio, reclaim);
+	if (reclaim) {
+		WARN_ON(!charged);
+		shadow = workingset_eviction(folio, memcg);
+	} else if (memcg) {
+		shadow = memcgid_to_shadow(mem_cgroup_private_id(memcg));
+	}
 
 	si = __swap_entry_to_info(entry);
 	ci_start = swp_cluster_offset(entry);
@@ -392,6 +402,11 @@ void __swap_cache_del_folio(struct swap_cluster_info *ci, struct folio *folio,
  * swap_cache_del_folio - Removes a folio from the swap cache.
  * @folio: The folio.
  *
+ * Force delete a folio from the swap cache. This is only safe to use for
+ * folios that are not swapped out (swap count == 0) to release the swap
+ * space from being pinned by swap cache, or remove a clean and charged
+ * folio that no one modified or is still using.
+ *
  * Same as __swap_cache_del_folio, but handles lock and refcount. The
  * caller must ensure the folio is either clean or has a swap count
  * equal to zero, or it may cause data loss.
@@ -404,6 +419,7 @@ void swap_cache_del_folio(struct folio *folio)
 	swp_entry_t entry = folio->swap;
 
 	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
+	VM_WARN_ON_ONCE(folio_test_dirty(folio) && folio_maybe_swapped(folio));
 	__swap_cache_del_folio(ci, folio, NULL, true, false);
 	swap_cluster_unlock(ci);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c0169bce46c9..2cd3e260f1bf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1972,9 +1972,11 @@ int swp_swapcount(swp_entry_t entry)
  * decrease of swap count is possible through swap_put_entries_direct, so this
  * may return a false positive.
  *
+ * Caller can hold the ci lock to get a stable result.
+ *
  * Context: Caller must ensure the folio is locked and in the swap cache.
  */
-static bool folio_maybe_swapped(struct folio *folio)
+bool folio_maybe_swapped(struct folio *folio)
 {
 	swp_entry_t entry = folio->swap;
 	struct swap_cluster_info *ci;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5112f81cf875..4565c9c3ac60 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -755,11 +755,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 	}
 
 	if (folio_test_swapcache(folio)) {
-		swp_entry_t swap = folio->swap;
-
-		if (reclaimed && !mapping_exiting(mapping))
-			shadow = workingset_eviction(folio, target_memcg);
-		__swap_cache_del_folio(ci, folio, shadow, true, true);
+		__swap_cache_del_folio(ci, folio, NULL, true, true);
 		swap_cluster_unlock_irq(ci);
 	} else {
 		void (*free_folio)(struct folio *);
diff --git a/mm/workingset.c b/mm/workingset.c
index 37a94979900f..765a954baefa 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -202,12 +202,18 @@ static unsigned int bucket_order[ANON_AND_FILE] __read_mostly;
 static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction,
 			 bool workingset, bool file)
 {
+	void *shadow;
+
 	eviction &= file ? EVICTION_MASK : EVICTION_MASK_ANON;
 	eviction = (eviction << MEM_CGROUP_ID_SHIFT) | memcgid;
 	eviction = (eviction << NODES_SHIFT) | pgdat->node_id;
 	eviction = (eviction << WORKINGSET_SHIFT) | workingset;
 
-	return xa_mk_value(eviction);
+	shadow = xa_mk_value(eviction);
+	/* Sanity check for retrieving memcgid from anon shadow. */
+	VM_WARN_ON_ONCE(shadow_to_memcgid(shadow) != memcgid);
+
+	return shadow;
 }
 
 static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
@@ -232,7 +238,7 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
 
 #ifdef CONFIG_LRU_GEN
 
-static void *lru_gen_eviction(struct folio *folio)
+static void *lru_gen_eviction(struct folio *folio, struct mem_cgroup *memcg)
 {
 	int hist;
 	unsigned long token;
@@ -244,7 +250,6 @@ static void *lru_gen_eviction(struct folio *folio)
 	int refs = folio_lru_refs(folio);
 	bool workingset = folio_test_workingset(folio);
 	int tier = lru_tier_from_refs(refs, workingset);
-	struct mem_cgroup *memcg = folio_memcg(folio);
 	struct pglist_data *pgdat = folio_pgdat(folio);
 
 	BUILD_BUG_ON(LRU_GEN_WIDTH + LRU_REFS_WIDTH >
@@ -252,6 +257,7 @@ static void *lru_gen_eviction(struct folio *folio)
 
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	lrugen = &lruvec->lrugen;
+	memcg = lruvec_memcg(lruvec);
 	min_seq = READ_ONCE(lrugen->min_seq[type]);
 	token = (min_seq << LRU_REFS_WIDTH) | max(refs - 1, 0);
 
@@ -329,7 +335,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 
 #else /* !CONFIG_LRU_GEN */
 
-static void *lru_gen_eviction(struct folio *folio)
+static void *lru_gen_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
 {
 	return NULL;
 }
@@ -396,7 +402,7 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 
 	if (lru_gen_enabled())
-		return lru_gen_eviction(folio);
+		return lru_gen_eviction(folio, target_memcg);
 
 	lruvec = mem_cgroup_lruvec(target_memcg, pgdat);
 	/* XXX: target_memcg can be NULL, go through lruvec */

-- 
2.53.0



