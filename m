Return-Path: <cgroups+bounces-14024-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDOKGwCgl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14024-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:42:56 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DB91639B0
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7697F3041A40
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCB5329E40;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRrdbCjn"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B37F30B539;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544527; cv=none; b=e+knKnCxlqIAOPTTM5gtkscrMEWM/GV5MXK8fprJVt6VWi+50pEcqNKme0Vhoi1BQYEYu1ctFyuhfog/xkSTkd03O8pG66sYp2d4NzCQTUBEqG94Gjc/PR4jA34VXFkGC1j2HPvUURF+R6LIt9lMCF/Ex2HBW6K6jyqyUm7qxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544527; c=relaxed/simple;
	bh=5uwq0THsq2yE7wG5RBgSijQvYGxW9tqtgr8TxpPxV/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k0bWGQCvZZ31hvAQv1QHdUmzvqfQ0dsRBAevDxbEuR3b1grW3DKW9Ki468mSNjKB4BCLl+R+WqfdzFZl8OhYqqPV4s7xOt3f4QdJvwKJUA1P72RhOtCLfyo0df7FTrwvR2JdeoF9zw6CEV3deqJVwgenP1nvVG1xJcdKImd+o4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRrdbCjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A67FC116C6;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544527;
	bh=5uwq0THsq2yE7wG5RBgSijQvYGxW9tqtgr8TxpPxV/0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nRrdbCjnoXXR6G/oCB6bcdFMKGk6HxINrFXkE18iajX1TwVzHl5qq2wq3BnWKfOEW
	 5XtTxo33wH97kj1hXsdVAmd47YFeTgNBZVqsh5kC68qIoVKHdAdTIWYV2dvp6Z3ovZ
	 6G1WC/i4LW9VriWImqilMeMLUtaKaHuJHdn1O7THKxwHagwf04vJU7sFpNMOGgZold
	 iK4u71B3+5IlDi+TeKASl358VbzH2OTTsVkB4TGjpmr0ieNddqmqmFrmIzrw7yAXwu
	 Ai6Zs3mcp5jaJGQvP+8bIh6+j0X9m4oDV7mtwE9tYVnhgjVhP2wSxoMNvZerIDFnXF
	 AqJZqUzUe80OA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C68EC531E3;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 20 Feb 2026 07:42:03 +0800
Subject: [PATCH RFC 02/15] mm, swap: simplify swap_cache_alloc_folio
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-swap-table-p4-v1-2-104795d19815@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=13576;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=n1cHUHJ7MXKr4ug4xnaunQlLGRDtG75OYXxYppL+FWk=;
 b=rG4YFu9U3/Ih89l7XZZzYUxJLVJtLVHuwWYfjQRpWNLAsLy8kWBYQsXB41nE3xM5e97+pg9FG
 AKJktt5DLY+BSvzlENe0fgk9nrA8g9gZSTEQhmyPPTLIE1BCU+cARSg
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
	TAGGED_FROM(0.00)[bounces-14024-lists,cgroups=lfdr.de,kasong.tencent.com];
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
X-Rspamd-Queue-Id: C0DB91639B0
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Instead of trying to return the existing folio if the entry is already
cached, just return an error code if the allocation failed. And
introduce proper wrappers that handle the allocation failure in
different ways.

For async swapin and readahead, the caller only wants to ensure that a
swap in read if the allocation succeeded, and for zswap swap out, the
caller will just abort if the allocation failed because the entry is
gone or cached already.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |   3 +-
 mm/swap_state.c | 177 +++++++++++++++++++++++++++++---------------------------
 mm/zswap.c      |  15 ++---
 3 files changed, 98 insertions(+), 97 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index a77016f2423b..ad8b17a93758 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -281,8 +281,7 @@ struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
 void swap_cache_del_folio(struct folio *folio);
 struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
-				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *alloced);
+				     struct mempolicy *mpol, pgoff_t ilx);
 /* Below helpers require the caller to lock and pass in the swap cluster. */
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
 			    struct folio *folio, swp_entry_t entry);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 32d9d877bda8..53fa95059012 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -459,41 +459,24 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
  * All swap slots covered by the folio must have a non-zero swap count.
  *
  * Context: Caller must protect the swap device with reference count or locks.
- * Return: Returns the folio being added on success. Returns the existing folio
- * if @entry is already cached. Returns NULL if raced with swapin or swapoff.
+ * Return: 0 if success, error code if failed.
  */
-static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
-						  struct folio *folio,
-						  gfp_t gfp, bool charged)
+static int __swap_cache_prepare_and_add(swp_entry_t entry,
+					struct folio *folio,
+					gfp_t gfp, bool charged)
 {
-	struct folio *swapcache = NULL;
 	void *shadow;
 	int ret;
 
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
-	for (;;) {
-		ret = swap_cache_add_folio(folio, entry, &shadow);
-		if (!ret)
-			break;
-
-		/*
-		 * Large order allocation needs special handling on
-		 * race: if a smaller folio exists in cache, swapin needs
-		 * to fallback to order 0, and doing a swap cache lookup
-		 * might return a folio that is irrelevant to the faulting
-		 * entry because @entry is aligned down. Just return NULL.
-		 */
-		if (ret != -EEXIST || folio_test_large(folio))
-			goto failed;
-
-		swapcache = swap_cache_get_folio(entry);
-		if (swapcache)
-			goto failed;
-	}
+	ret = swap_cache_add_folio(folio, entry, &shadow);
+	if (ret)
+		goto failed;
 
 	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
 		swap_cache_del_folio(folio);
+		ret = -ENOMEM;
 		goto failed;
 	}
 
@@ -503,11 +486,11 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 
 	/* Caller will initiate read into locked folio */
 	folio_add_lru(folio);
-	return folio;
+	return 0;
 
 failed:
 	folio_unlock(folio);
-	return swapcache;
+	return ret;
 }
 
 /**
@@ -516,7 +499,6 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
  * @gfp_mask: memory allocation flags
  * @mpol: NUMA memory allocation policy to be applied
  * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
- * @new_page_allocated: sets true if allocation happened, false otherwise
  *
  * Allocate a folio in the swap cache for one swap slot, typically before
  * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
@@ -524,18 +506,40 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
  * Currently only supports order 0.
  *
  * Context: Caller must protect the swap device with reference count or locks.
- * Return: Returns the existing folio if @entry is cached already. Returns
- * NULL if failed due to -ENOMEM or @entry have a swap count < 1.
+ * Return: Returns the folio if allocation succeeded and folio is added to
+ * swap cache. Returns error code if allocation failed due to race.
  */
 struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
-				     struct mempolicy *mpol, pgoff_t ilx,
-				     bool *new_page_allocated)
+				     struct mempolicy *mpol, pgoff_t ilx)
+{
+	int ret;
+	struct folio *folio;
+
+	/* Allocate a new folio to be added into the swap cache. */
+	folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
+	if (!folio)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Try add the new folio, it returns NULL if already exist,
+	 * since folio is order 0.
+	 */
+	ret = __swap_cache_prepare_and_add(entry, folio, gfp_mask, false);
+	if (ret) {
+		folio_put(folio);
+		return ERR_PTR(ret);
+	}
+
+	return folio;
+}
+
+static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
+					   struct mempolicy *mpol, pgoff_t ilx,
+					   struct swap_iocb **plug, bool readahead)
 {
 	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct folio *folio;
-	struct folio *result = NULL;
 
-	*new_page_allocated = false;
 	/* Check the swap cache again for readahead path. */
 	folio = swap_cache_get_folio(entry);
 	if (folio)
@@ -545,17 +549,24 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 	if (!swap_entry_swapped(si, entry))
 		return NULL;
 
-	/* Allocate a new folio to be added into the swap cache. */
-	folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
-	if (!folio)
+	do {
+		folio = swap_cache_get_folio(entry);
+		if (folio)
+			return folio;
+
+		folio = swap_cache_alloc_folio(entry, gfp, mpol, ilx);
+	} while (PTR_ERR(folio) == -EEXIST);
+
+	if (IS_ERR_OR_NULL(folio))
 		return NULL;
-	/* Try add the new folio, returns existing folio or NULL on failure. */
-	result = __swap_cache_prepare_and_add(entry, folio, gfp_mask, false);
-	if (result == folio)
-		*new_page_allocated = true;
-	else
-		folio_put(folio);
-	return result;
+
+	swap_read_folio(folio, plug);
+	if (readahead) {
+		folio_set_readahead(folio);
+		count_vm_event(SWAP_RA);
+	}
+
+	return folio;
 }
 
 /**
@@ -574,15 +585,35 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
  */
 struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
 {
+	int ret;
 	struct folio *swapcache;
 	pgoff_t offset = swp_offset(entry);
 	unsigned long nr_pages = folio_nr_pages(folio);
 
 	entry = swp_entry(swp_type(entry), round_down(offset, nr_pages));
-	swapcache = __swap_cache_prepare_and_add(entry, folio, 0, true);
-	if (swapcache == folio)
-		swap_read_folio(folio, NULL);
-	return swapcache;
+	for (;;) {
+		ret = __swap_cache_prepare_and_add(entry, folio, 0, true);
+		if (!ret) {
+			swap_read_folio(folio, NULL);
+			break;
+		}
+
+		/*
+		 * Large order allocation needs special handling on
+		 * race: if a smaller folio exists in cache, swapin needs
+		 * to fallback to order 0, and doing a swap cache lookup
+		 * might return a folio that is irrelevant to the faulting
+		 * entry because @entry is aligned down. Just return NULL.
+		 */
+		if (ret != -EEXIST || nr_pages > 1)
+			return NULL;
+
+		swapcache = swap_cache_get_folio(entry);
+		if (swapcache)
+			return swapcache;
+	}
+
+	return folio;
 }
 
 /*
@@ -596,7 +627,6 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		struct swap_iocb **plug)
 {
 	struct swap_info_struct *si;
-	bool page_allocated;
 	struct mempolicy *mpol;
 	pgoff_t ilx;
 	struct folio *folio;
@@ -606,13 +636,9 @@ struct folio *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 		return NULL;
 
 	mpol = get_vma_policy(vma, addr, 0, &ilx);
-	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
-				       &page_allocated);
+	folio = swap_cache_read_folio(entry, gfp_mask, mpol, ilx, plug, false);
 	mpol_cond_put(mpol);
 
-	if (page_allocated)
-		swap_read_folio(folio, plug);
-
 	put_swap_device(si);
 	return folio;
 }
@@ -697,7 +723,7 @@ static unsigned long swapin_nr_pages(unsigned long offset)
  * are fairly likely to have been swapped out from the same node.
  */
 struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
-				    struct mempolicy *mpol, pgoff_t ilx)
+				     struct mempolicy *mpol, pgoff_t ilx)
 {
 	struct folio *folio;
 	unsigned long entry_offset = swp_offset(entry);
@@ -707,7 +733,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
-	bool page_allocated;
+	swp_entry_t ra_entry;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
@@ -724,18 +750,11 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	blk_start_plug(&plug);
 	for (offset = start_offset; offset <= end_offset ; offset++) {
 		/* Ok, do the async read-ahead now */
-		folio = swap_cache_alloc_folio(
-			swp_entry(swp_type(entry), offset), gfp_mask, mpol, ilx,
-			&page_allocated);
+		ra_entry = swp_entry(swp_type(entry), offset);
+		folio = swap_cache_read_folio(ra_entry, gfp_mask, mpol, ilx,
+					      &splug, offset != entry_offset);
 		if (!folio)
 			continue;
-		if (page_allocated) {
-			swap_read_folio(folio, &splug);
-			if (offset != entry_offset) {
-				folio_set_readahead(folio);
-				count_vm_event(SWAP_RA);
-			}
-		}
 		folio_put(folio);
 	}
 	blk_finish_plug(&plug);
@@ -743,11 +762,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
-				       &page_allocated);
-	if (unlikely(page_allocated))
-		swap_read_folio(folio, NULL);
-	return folio;
+	return swap_cache_read_folio(entry, gfp_mask, mpol, ilx, NULL, false);
 }
 
 static int swap_vma_ra_win(struct vm_fault *vmf, unsigned long *start,
@@ -813,8 +828,7 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	pte_t *pte = NULL, pentry;
 	int win;
 	unsigned long start, end, addr;
-	pgoff_t ilx;
-	bool page_allocated;
+	pgoff_t ilx = targ_ilx;
 
 	win = swap_vma_ra_win(vmf, &start, &end);
 	if (win == 1)
@@ -848,19 +862,12 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 			if (!si)
 				continue;
 		}
-		folio = swap_cache_alloc_folio(entry, gfp_mask, mpol, ilx,
-					       &page_allocated);
+		folio = swap_cache_read_folio(entry, gfp_mask, mpol, ilx,
+					      &splug, addr != vmf->address);
 		if (si)
 			put_swap_device(si);
 		if (!folio)
 			continue;
-		if (page_allocated) {
-			swap_read_folio(folio, &splug);
-			if (addr != vmf->address) {
-				folio_set_readahead(folio);
-				count_vm_event(SWAP_RA);
-			}
-		}
 		folio_put(folio);
 	}
 	if (pte)
@@ -870,10 +877,8 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	lru_add_drain();
 skip:
 	/* The folio was likely read above, so no need for plugging here */
-	folio = swap_cache_alloc_folio(targ_entry, gfp_mask, mpol, targ_ilx,
-				       &page_allocated);
-	if (unlikely(page_allocated))
-		swap_read_folio(folio, NULL);
+	folio = swap_cache_read_folio(targ_entry, gfp_mask, mpol, targ_ilx,
+				      NULL, false);
 	return folio;
 }
 
diff --git a/mm/zswap.c b/mm/zswap.c
index af3f0fbb0558..f3aa83a99636 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -992,7 +992,6 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	pgoff_t offset = swp_offset(swpentry);
 	struct folio *folio;
 	struct mempolicy *mpol;
-	bool folio_was_allocated;
 	struct swap_info_struct *si;
 	int ret = 0;
 
@@ -1003,22 +1002,20 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 
 	mpol = get_task_policy(current);
 	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, mpol,
-				       NO_INTERLEAVE_INDEX, &folio_was_allocated);
+				       NO_INTERLEAVE_INDEX);
 	put_swap_device(si);
-	if (!folio)
-		return -ENOMEM;
 
 	/*
+	 * Swap cache allocaiton might fail due to OOM, raced with free
+	 * or existing folio when we due to concurrent swapin or free.
 	 * Found an existing folio, we raced with swapin or concurrent
 	 * shrinker. We generally writeback cold folios from zswap, and
 	 * swapin means the folio just became hot, so skip this folio.
 	 * For unlikely concurrent shrinker case, it will be unlinked
 	 * and freed when invalidated by the concurrent shrinker anyway.
 	 */
-	if (!folio_was_allocated) {
-		ret = -EEXIST;
-		goto out;
-	}
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
 
 	/*
 	 * folio is locked, and the swapcache is now secured against
@@ -1058,7 +1055,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 	__swap_writepage(folio, NULL);
 
 out:
-	if (ret && ret != -EEXIST) {
+	if (ret) {
 		swap_cache_del_folio(folio);
 		folio_unlock(folio);
 	}

-- 
2.53.0



