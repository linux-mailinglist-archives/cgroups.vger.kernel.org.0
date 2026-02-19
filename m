Return-Path: <cgroups+bounces-14028-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFSgFQagl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14028-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:02 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E601639B8
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D574930465FA
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCCC32ABCA;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozQVrw3f"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDA3191D8;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544527; cv=none; b=NsazowwOXNcjEzZhzFSWaf4353ctvXtHjKoz9N5DUiSgTa4I+rg8bn5T8P3hWnRXXBPHxqaAo3znjnvdb0c3wp5j+vy5SeAZ/kLLj/cu5goBTay+gApo+7uoIeVGTNzcBOoWTot+jYMvj4NOvHmPnr1uZA4zVlGpI3Cr+QDWOqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544527; c=relaxed/simple;
	bh=xxmdaXbJhm2fa/xOaTiqJLbiS6Wf5af2Y0X+Fu5RtUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XsmKOf6nVbjwKPmMBh/XtN4tqXIlRjabnwVlQQs7VLjgxnngeEQFM8WoyB+G9u24l5iIzkSjv6L+WevFZ38bSAQjEGrWSrZIj3wAAX2Tb0sNeJMBJL7pKnCz1iPuR0HlQSi7+WwyG9GJ1MnlaZ+K1jM5rgPXqfgglXSqGZicqtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozQVrw3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6754CC2BC87;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544527;
	bh=xxmdaXbJhm2fa/xOaTiqJLbiS6Wf5af2Y0X+Fu5RtUo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ozQVrw3fR2WH1Iv9/eXne8azFHDLeuJC+Zmj3eo9zHJOTf7MFMkqLTNoJeNzZfxb7
	 vEaRwJtqDMv1v9alomEUEVe/Uv5UyeiUkw3ymYUqhQMxOAs1KMzgenkc5TlqC1LiDJ
	 s1xLaiUR2ElFdmCQV4Oth0ukHW/uZ5YKfvbYK+8SiuFqFx4FwasYlyRtKu1h7U/20V
	 PiNFBzl43elGgUTMbxHYIm0tHAHAgiwUr0q9jUsYQC5YuIJ4F7LTB7y3cXSWOamHWv
	 gBZT/twWXLTH88IZlGn+3IITFPt/EHO9R2ORANTYa/8CUuhTSjZXaF61S3W0cx5L0S
	 9CbXqjfvLUAZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D584E9A04F;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 20 Feb 2026 07:42:05 +0800
Subject: [PATCH RFC 04/15] mm, swap: add support for large order folios in
 swap cache directly
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-swap-table-p4-v1-4-104795d19815@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=10217;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=iRaA16zPocun7MNZRSreX0nvZb3ZKPTMy/X1q06icVE=;
 b=zwpwc54oeGo2FV9brWSj7Ua9BWGbgsk7pitnp3rs3n/80DvSbA5U89WYopprBd/WDxiPl9kUJ
 8kbvnF3WNGkBhVzE4ooNnEcc9N7F5qKH7pOt9uS3DzM4hdGngRJzAty
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
	TAGGED_FROM(0.00)[bounces-14028-lists,cgroups=lfdr.de,kasong.tencent.com];
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
X-Rspamd-Queue-Id: B0E601639B8
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

To make it possible to allocate large folios directly in swap cache, let
swap_cache_alloc_folio handle larger orders too.

This slightly changes how allocation is synchronized. Now, whoever first
successfully allocates a folio in the swap cache will be the one who
charges it and performs the swap-in. Raced swapin now should avoid a
redundant charge and just wait for the swapin to finish.

Large order fallback is also moved to the swap cache layer. This should
make the fallback process less racy, too.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |   3 +-
 mm/swap_state.c | 193 +++++++++++++++++++++++++++++++++++++++++---------------
 mm/zswap.c      |   2 +-
 3 files changed, 145 insertions(+), 53 deletions(-)

diff --git a/mm/swap.h b/mm/swap.h
index ad8b17a93758..6774af10a943 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -280,7 +280,8 @@ bool swap_cache_has_folio(swp_entry_t entry);
 struct folio *swap_cache_get_folio(swp_entry_t entry);
 void *swap_cache_get_shadow(swp_entry_t entry);
 void swap_cache_del_folio(struct folio *folio);
-struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_flags,
+struct folio *swap_cache_alloc_folio(swp_entry_t target_entry, gfp_t gfp_mask,
+				     unsigned long orders, struct vm_fault *vmf,
 				     struct mempolicy *mpol, pgoff_t ilx);
 /* Below helpers require the caller to lock and pass in the swap cluster. */
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 1e340faea9ac..e32b06a1f229 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -137,26 +137,39 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 	return NULL;
 }
 
-static int __swap_cache_add_check(struct swap_cluster_info *ci,
-				  unsigned int ci_off, unsigned int nr,
-				  void **shadow)
+static int __swap_cache_check_batch(struct swap_cluster_info *ci,
+				    unsigned int ci_off, unsigned int ci_targ,
+				    unsigned int nr, void **shadowp)
 {
 	unsigned int ci_end = ci_off + nr;
 	unsigned long old_tb;
 
 	if (unlikely(!ci->table))
 		return -ENOENT;
+
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
-		if (unlikely(swp_tb_is_folio(old_tb)))
-			return -EEXIST;
-		if (unlikely(!__swp_tb_get_count(old_tb)))
-			return -ENOENT;
+		if (unlikely(swp_tb_is_folio(old_tb)) ||
+		    unlikely(!__swp_tb_get_count(old_tb)))
+			break;
 		if (swp_tb_is_shadow(old_tb))
-			*shadow = swp_tb_to_shadow(old_tb);
+			*shadowp = swp_tb_to_shadow(old_tb);
 	} while (++ci_off < ci_end);
 
-	return 0;
+	if (likely(ci_off == ci_end))
+		return 0;
+
+	/*
+	 * If the target slot is not suitable for adding swap cache, return
+	 * -EEXIST or -ENOENT. If the batch is not suitable, could be a
+	 * race with concurrent free or cache add, return -EBUSY.
+	 */
+	old_tb = __swap_table_get(ci, ci_targ);
+	if (swp_tb_is_folio(old_tb))
+		return -EEXIST;
+	if (!__swp_tb_get_count(old_tb))
+		return -ENOENT;
+	return -EBUSY;
 }
 
 void __swap_cache_add_folio(struct swap_cluster_info *ci,
@@ -209,7 +222,7 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 	si = __swap_entry_to_info(entry);
 	ci = swap_cluster_lock(si, swp_offset(entry));
 	ci_off = swp_cluster_offset(entry);
-	err = __swap_cache_add_check(ci, ci_off, nr_pages, &shadow);
+	err = __swap_cache_check_batch(ci, ci_off, ci_off, nr_pages, &shadow);
 	if (err) {
 		swap_cluster_unlock(ci);
 		return err;
@@ -223,6 +236,124 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 	return 0;
 }
 
+static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
+					swp_entry_t targ_entry, gfp_t gfp,
+					unsigned int order, struct vm_fault *vmf,
+					struct mempolicy *mpol, pgoff_t ilx)
+{
+	int err;
+	swp_entry_t entry;
+	struct folio *folio;
+	void *shadow = NULL, *shadow_check = NULL;
+	unsigned long address, nr_pages = 1 << order;
+	unsigned int ci_off, ci_targ = swp_cluster_offset(targ_entry);
+
+	entry.val = round_down(targ_entry.val, nr_pages);
+	ci_off = round_down(ci_targ, nr_pages);
+
+	/* First check if the range is available */
+	spin_lock(&ci->lock);
+	err = __swap_cache_check_batch(ci, ci_off, ci_targ, nr_pages, &shadow);
+	spin_unlock(&ci->lock);
+	if (unlikely(err))
+		return ERR_PTR(err);
+
+	if (vmf) {
+		if (order)
+			gfp = thp_limit_gfp_mask(vma_thp_gfp_mask(vmf->vma), gfp);
+		address = round_down(vmf->address, PAGE_SIZE << order);
+		folio = vma_alloc_folio(gfp, order, vmf->vma, address);
+	} else {
+		folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id());
+	}
+	if (unlikely(!folio))
+		return ERR_PTR(-ENOMEM);
+
+	/* Double check the range is still not in conflict */
+	spin_lock(&ci->lock);
+	err = __swap_cache_check_batch(ci, ci_off, ci_targ, nr_pages, &shadow_check);
+	if (unlikely(err) || shadow_check != shadow) {
+		spin_unlock(&ci->lock);
+		folio_put(folio);
+
+		/* If shadow changed, just try again */
+		return ERR_PTR(err ? err : -EAGAIN);
+	}
+
+	__folio_set_locked(folio);
+	__folio_set_swapbacked(folio);
+	__swap_cache_add_folio(ci, folio, entry);
+	spin_unlock(&ci->lock);
+
+	if (mem_cgroup_swapin_charge_folio(folio, vmf ? vmf->vma->vm_mm : NULL,
+					   gfp, entry)) {
+		spin_lock(&ci->lock);
+		__swap_cache_del_folio(ci, folio, shadow);
+		spin_unlock(&ci->lock);
+		folio_unlock(folio);
+		folio_put(folio);
+		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* For memsw accouting, swap is uncharged when folio is added to swap cache */
+	memcg1_swapin(entry, 1 << order);
+	if (shadow)
+		workingset_refault(folio, shadow);
+
+	/* Caller will initiate read into locked new_folio */
+	folio_add_lru(folio);
+
+	return folio;
+}
+
+/**
+ * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
+ * @targ_entry: swap entry indicating the target slot
+ * @orders: allocation orders
+ * @vmf: fault information
+ * @gfp_mask: memory allocation flags
+ * @mpol: NUMA memory allocation policy to be applied
+ * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
+ *
+ * Allocate a folio in the swap cache for one swap slot, typically before
+ * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
+ * @targ_entry must have a non-zero swap count (swapped out).
+ *
+ * Context: Caller must protect the swap device with reference count or locks.
+ * Return: Returns the folio if allocation successed and folio is added to
+ * swap cache. Returns error code if allocation failed due to race.
+ */
+struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp_mask,
+				     unsigned long orders, struct vm_fault *vmf,
+				     struct mempolicy *mpol, pgoff_t ilx)
+{
+	int order;
+	struct folio *folio;
+	struct swap_cluster_info *ci;
+
+	ci = __swap_entry_to_cluster(targ_entry);
+	order = orders ? highest_order(orders) : 0;
+	for (;;) {
+		folio = __swap_cache_alloc(ci, targ_entry, gfp_mask, order,
+					   vmf, mpol, ilx);
+		if (!IS_ERR(folio))
+			return folio;
+		if (PTR_ERR(folio) == -EAGAIN)
+			continue;
+		/* Only -EBUSY means we should fallback and retry. */
+		if (PTR_ERR(folio) != -EBUSY)
+			return folio;
+		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
+		order = next_order(&orders, order);
+		if (!orders)
+			break;
+	}
+	/* Should never reach here, order 0 should not fail with -EBUSY. */
+	WARN_ON_ONCE(1);
+	return ERR_PTR(-EINVAL);
+}
+
 /**
  * __swap_cache_del_folio - Removes a folio from the swap cache.
  * @ci: The locked swap cluster.
@@ -498,46 +629,6 @@ static int __swap_cache_prepare_and_add(swp_entry_t entry,
 	return ret;
 }
 
-/**
- * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
- * @entry: the swapped out swap entry to be binded to the folio.
- * @gfp_mask: memory allocation flags
- * @mpol: NUMA memory allocation policy to be applied
- * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
- *
- * Allocate a folio in the swap cache for one swap slot, typically before
- * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
- * @entry must have a non-zero swap count (swapped out).
- * Currently only supports order 0.
- *
- * Context: Caller must protect the swap device with reference count or locks.
- * Return: Returns the folio if allocation succeeded and folio is added to
- * swap cache. Returns error code if allocation failed due to race.
- */
-struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
-				     struct mempolicy *mpol, pgoff_t ilx)
-{
-	int ret;
-	struct folio *folio;
-
-	/* Allocate a new folio to be added into the swap cache. */
-	folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
-	if (!folio)
-		return ERR_PTR(-ENOMEM);
-
-	/*
-	 * Try add the new folio, it returns NULL if already exist,
-	 * since folio is order 0.
-	 */
-	ret = __swap_cache_prepare_and_add(entry, folio, gfp_mask, false);
-	if (ret) {
-		folio_put(folio);
-		return ERR_PTR(ret);
-	}
-
-	return folio;
-}
-
 static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 					   struct mempolicy *mpol, pgoff_t ilx,
 					   struct swap_iocb **plug, bool readahead)
@@ -559,7 +650,7 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 		if (folio)
 			return folio;
 
-		folio = swap_cache_alloc_folio(entry, gfp, mpol, ilx);
+		folio = swap_cache_alloc_folio(entry, gfp, 0, NULL, mpol, ilx);
 	} while (PTR_ERR(folio) == -EEXIST);
 
 	if (IS_ERR_OR_NULL(folio))
diff --git a/mm/zswap.c b/mm/zswap.c
index f3aa83a99636..5d83539a8bba 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1001,7 +1001,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -EEXIST;
 
 	mpol = get_task_policy(current);
-	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, mpol,
+	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, 0, NULL, mpol,
 				       NO_INTERLEAVE_INDEX);
 	put_swap_device(si);
 

-- 
2.53.0



