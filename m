Return-Path: <cgroups+bounces-15965-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBTmOgHzBmohpQIAu9opvQ
	(envelope-from <cgroups+bounces-15965-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 12:18:41 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AD154D305
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 12:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA31C30F1DA3
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2026 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9A44102D;
	Fri, 15 May 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDWOyOrZ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0443DA24;
	Fri, 15 May 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838862; cv=none; b=PZ0pXxVECvoYY4Eqo4l/pXjnWiTm9AFE51zDGnZgSbKvCUQCV1WQo2Xes2CqQ530Y2KkmV14QI8TQcRFE6QAbgw6dUKiqFd8DPRyo7PpGwxpw9AeBL+TrrxX8R6Bkl3ZXnF8aJ/ZHa+xFzpqjilvF79iUiSne819WfjOCYBYnU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838862; c=relaxed/simple;
	bh=c3s5FfZ7wCYyoqvN44mg9Dp1ba2S7N9t/07lN+mNBPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dm6fV4VHCwNm0Ho8eLCNnX7Au0XVwu2Ubj3GAACyB9yayvafL5s6/p2lMYEiBTCaw/QHO1K7Gte84FFlC9f+sNEGbkSYvGKvecDQzICrsxBdm6a4owa/ERN2nufwYZe/FBWqG9SFWXnHh8aBu8oK4S0YatcwwlfyOybTkKwuzk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDWOyOrZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11DF2C2BCFD;
	Fri, 15 May 2026 09:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778838862;
	bh=c3s5FfZ7wCYyoqvN44mg9Dp1ba2S7N9t/07lN+mNBPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hDWOyOrZ0k3aUPD8/cM69TmK+NEvip8Kul0BVKOmijfhql8keM+YMY1K0TPOGZvi0
	 v6tD82TcEq8IeHj194PwTEPCK//3BIwgns486Mk1vQtlKZI51PDAtieF8nfROJ6E/J
	 wXsytbBhymnZ+RsradkXG/OJSp/73PhkKOl7EW6NaEqtbwkngZ0MREPmLY/n7gJA5y
	 gj/mmqFG7sEEFT0FGakIFe1I1WS6kiKmaxZKFcrBKsrI9OsW4FjwVYEiz9boZ8aq9e
	 ZO1D3+cMV7TsXT5irv6XXg2q+QktEYgj/nsJPffGs5Rro0TBiYiFM4EFnI0vE8EqOZ
	 ny0yTNAUacUjQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A840CD343F;
	Fri, 15 May 2026 09:54:22 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 15 May 2026 17:54:17 +0800
Subject: [PATCH v4 04/12] mm, swap: add support for stable large allocation
 in swap cache directly
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-swap-table-p4-v4-4-f1b49e845a8d@tencent.com>
References: <20260515-swap-table-p4-v4-0-f1b49e845a8d@tencent.com>
In-Reply-To: <20260515-swap-table-p4-v4-0-f1b49e845a8d@tencent.com>
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
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>, Qi Zheng <qi.zheng@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778838859; l=13193;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=kTuYyMGJB41z/ywRxyzfs8vEnGjel7vkukkFrC2V7bo=;
 b=0Cz6x+ITvD4cA42OzJAvopEnOoa8goMeCaQuod1mDN5jmfNdVUcsCepPfirh7udZAzf9E+Y8d
 bPgs14PmpTOB2kHVjaOy4S+eDHpsZmel3y/VDw1pHoGAblsLuIhYivN
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Queue-Id: 49AD154D305
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15965-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org,tencent.com];
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
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

To make it possible to allocate large folios directly in swap cache,
provide a new infrastructure helper to handle the swap cache status
check, allocation, and order fallback in the swap cache layer

The new helper replaces the existing swap_cache_alloc_folio. Based on
this, all the separate swap folio allocation that is being done by anon
/ shmem before is converted to use this helper directly, unifying folio
allocation for anon, shmem, and readahead.

This slightly consolidates how allocation is synchronized, making it
more stable and less prone to errors. The slot-count and cache-conflict
check is now always performed with the cluster lock held before
allocation, and repeated under the same lock right before cache
insertion. This double check produces a stable result compared to the
previous anon and shmem mTHP allocation implementation,  avoids the
false-negative conflict checks that the lockless path can return — large
allocations no longer have to be unwound because the range turned out to
be occupied — and aborts early for already-freed slots, which helps
ordinary swapin and especially readahead, with only a marginal increase
in cluster-lock contention (the lock is very lightly contended and stays
local in the first place). Hence, callers of swap_cache_alloc_folio() no
longer need to check the swap slot count or swap cache status
themselves.

And now whoever first successfully allocates a folio in the swap cache
will be the one who charges it and performs the swap-in. The race window
of swapping is also reduced since the loop is much more compact.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap.h       |   3 +-
 mm/swap_state.c | 234 +++++++++++++++++++++++++++++++++++++++-----------------
 mm/zswap.c      |   2 +-
 3 files changed, 168 insertions(+), 71 deletions(-)

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
index 89fa19ec13f6..cd4543ff5e47 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -139,10 +139,10 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 
 /**
  * __swap_cache_add_check - Check if a range is suitable for adding a folio.
- * @ci: The locked swap cluster.
- * @ci_off: Range start offset.
- * @nr: Number of slots to check.
- * @shadow: Returns the shadow value if one exists in the range.
+ * @ci: The locked swap cluster
+ * @targ_entry: The target swap entry to check, will be rounded down by @nr
+ * @nr: Number of slots to check, must be a power of 2
+ * @shadowp: Returns the shadow value if one exists in the range.
  *
  * Check if all slots covered by given range have a swap count >= 1.
  * Retrieves the shadow if there is one.
@@ -151,26 +151,40 @@ void *swap_cache_get_shadow(swp_entry_t entry)
  * Return: 0 if success, error code if failed.
  */
 static int __swap_cache_add_check(struct swap_cluster_info *ci,
-				  unsigned int ci_off, unsigned int nr,
-				  void **shadow)
+				  swp_entry_t targ_entry,
+				  unsigned long nr, void **shadowp)
 {
-	unsigned int ci_end = ci_off + nr;
+	unsigned int ci_off, ci_end;
 	unsigned long old_tb;
 
 	lockdep_assert_held(&ci->lock);
-	if (WARN_ON_ONCE(ci_off >= SWAPFILE_CLUSTER))
-		return -EINVAL;
 
+	/*
+	 * If the target slot is not swapped out or already cached, return
+	 * -ENOENT or -EEXIST. If the batch is not suitable, could be a
+	 * race with concurrent free or cache add, return -EBUSY.
+	 */
 	if (unlikely(!ci->table))
 		return -ENOENT;
+	ci_off = swp_cluster_offset(targ_entry);
+	old_tb = __swap_table_get(ci, ci_off);
+	if (swp_tb_is_folio(old_tb))
+		return -EEXIST;
+	if (!__swp_tb_get_count(old_tb))
+		return -ENOENT;
+	if (swp_tb_is_shadow(old_tb) && shadowp)
+		*shadowp = swp_tb_to_shadow(old_tb);
+
+	if (nr == 1)
+		return 0;
+
+	ci_off = round_down(ci_off, nr);
+	ci_end = ci_off + nr;
 	do {
 		old_tb = __swap_table_get(ci, ci_off);
-		if (unlikely(swp_tb_is_folio(old_tb)))
-			return -EEXIST;
-		if (unlikely(!__swp_tb_get_count(old_tb)))
-			return -ENOENT;
-		if (swp_tb_is_shadow(old_tb))
-			*shadow = swp_tb_to_shadow(old_tb);
+		if (unlikely(swp_tb_is_folio(old_tb) ||
+			     !__swp_tb_get_count(old_tb)))
+			return -EBUSY;
 	} while (++ci_off < ci_end);
 
 	return 0;
@@ -241,15 +255,13 @@ static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
 {
 	int err;
 	void *shadow = NULL;
-	unsigned int ci_off;
 	struct swap_info_struct *si;
 	struct swap_cluster_info *ci;
 	unsigned long nr_pages = folio_nr_pages(folio);
 
 	si = __swap_entry_to_info(entry);
 	ci = swap_cluster_lock(si, swp_offset(entry));
-	ci_off = swp_cluster_offset(entry);
-	err = __swap_cache_add_check(ci, ci_off, nr_pages, &shadow);
+	err = __swap_cache_add_check(ci, entry, nr_pages, &shadow);
 	if (err) {
 		swap_cluster_unlock(ci);
 		return err;
@@ -404,6 +416,140 @@ void __swap_cache_replace_folio(struct swap_cluster_info *ci,
 	}
 }
 
+/*
+ * Try to allocate a folio of given order in the swap cache.
+ *
+ * This helper resolves the potential races of swap allocation
+ * and prepares a folio to be used for swap IO. May return following
+ * value:
+ *
+ * -ENOMEM / -EBUSY: Order is too large or in conflict with sub slot,
+ *                   caller should shrink the order and retry
+ * -ENOENT / -EEXIST: Target swap entry is unavailable or cached, the caller
+ *                    should abort or try to use the cached folio instead
+ */
+static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
+					swp_entry_t targ_entry, gfp_t gfp,
+					unsigned int order, struct vm_fault *vmf,
+					struct mempolicy *mpol, pgoff_t ilx)
+{
+	int err;
+	swp_entry_t entry;
+	struct folio *folio;
+	void *shadow = NULL;
+	unsigned long address, nr_pages = 1UL << order;
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
+
+	VM_WARN_ON_ONCE(nr_pages > SWAPFILE_CLUSTER);
+	entry.val = round_down(targ_entry.val, nr_pages);
+
+	/* Check if the slot and range are available, skip allocation if not */
+	spin_lock(&ci->lock);
+	err = __swap_cache_add_check(ci, targ_entry, nr_pages, NULL);
+	spin_unlock(&ci->lock);
+	if (unlikely(err))
+		return ERR_PTR(err);
+
+	/*
+	 * Limit THP gfp. The limitation is a no-op for typical
+	 * GFP_HIGHUSER_MOVABLE but matters for shmem.
+	 */
+	if (order)
+		gfp = thp_shmem_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
+
+	if (mpol || !vmf) {
+		folio = folio_alloc_mpol(gfp, order, mpol, ilx, numa_node_id());
+	} else {
+		address = round_down(vmf->address, PAGE_SIZE << order);
+		folio = vma_alloc_folio(gfp, order, vmf->vma, address);
+	}
+	if (unlikely(!folio))
+		return ERR_PTR(-ENOMEM);
+
+	/* Double check the range is still not in conflict */
+	spin_lock(&ci->lock);
+	err = __swap_cache_add_check(ci, targ_entry, nr_pages, &shadow);
+	if (unlikely(err)) {
+		spin_unlock(&ci->lock);
+		folio_put(folio);
+		return ERR_PTR(err);
+	}
+
+	__folio_set_locked(folio);
+	__folio_set_swapbacked(folio);
+	__swap_cache_do_add_folio(ci, folio, entry);
+	spin_unlock(&ci->lock);
+
+	if (mem_cgroup_swapin_charge_folio(folio, vmf ? vmf->vma->vm_mm : NULL,
+					   gfp, entry)) {
+		spin_lock(&ci->lock);
+		__swap_cache_do_del_folio(ci, folio, entry, shadow);
+		spin_unlock(&ci->lock);
+		folio_unlock(folio);
+		/* nr_pages refs from swap cache, 1 from allocation */
+		folio_put_refs(folio, nr_pages + 1);
+		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	/* For memsw accounting, swap is uncharged when folio is added to swap cache */
+	memcg1_swapin(entry, 1 << order);
+	if (shadow)
+		workingset_refault(folio, shadow);
+
+	node_stat_mod_folio(folio, NR_FILE_PAGES, nr_pages);
+	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
+
+	/* Caller will initiate read into locked new_folio */
+	folio_add_lru(folio);
+	return folio;
+}
+
+/**
+ * swap_cache_alloc_folio - Allocate folio for swapped out slot in swap cache.
+ * @targ_entry: swap entry indicating the target slot
+ * @gfp: memory allocation flags
+ * @orders: allocation orders, must be non zero
+ * @vmf: fault information
+ * @mpol: NUMA memory allocation policy to be applied
+ * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
+ *
+ * Allocate a folio in the swap cache for one swap slot, typically before
+ * doing IO (e.g. swap in or zswap writeback). The swap slot indicated by
+ * @targ_entry must have a non-zero swap count (swapped out).
+ *
+ * Context: Caller must protect the swap device with reference count or locks.
+ * Return: Returns the folio if allocation succeeded and folio is in the swap
+ * cache. Returns error code if failed due to race, OOM or invalid arguments.
+ */
+struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp,
+				     unsigned long orders, struct vm_fault *vmf,
+				     struct mempolicy *mpol, pgoff_t ilx)
+{
+	int order, err;
+	struct folio *ret;
+	struct swap_cluster_info *ci;
+
+	if (WARN_ON_ONCE(!orders))
+		return ERR_PTR(-EINVAL);
+
+	ci = __swap_entry_to_cluster(targ_entry);
+	order = highest_order(orders);
+	while (orders) {
+		ret = __swap_cache_alloc(ci, targ_entry, gfp, order,
+					 vmf, mpol, ilx);
+		if (!IS_ERR(ret))
+			break;
+		err = PTR_ERR(ret);
+		if (err && err != -EBUSY && err != -ENOMEM)
+			break;
+		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
+		order = next_order(&orders, order);
+	}
+
+	return ret;
+}
+
 /*
  * If we are the only user, then try to free up the swap cache.
  *
@@ -547,68 +693,18 @@ static int __swap_cache_prepare_and_add(swp_entry_t entry,
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
- * swap cache. Returns error code if allocation failed due to race or OOM.
- */
-struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
-				     struct mempolicy *mpol, pgoff_t ilx)
-{
-	int err;
-	struct folio *folio;
-
-	/* Allocate a new folio to be added into the swap cache. */
-	folio = folio_alloc_mpol(gfp_mask, 0, mpol, ilx, numa_node_id());
-	if (!folio)
-		return ERR_PTR(-ENOMEM);
-
-	/*
-	 * Try to add the new folio to the swap cache. It returns
-	 * -EEXIST if the entry is already cached.
-	 */
-	err = __swap_cache_prepare_and_add(entry, folio, gfp_mask, false);
-	if (err) {
-		folio_put(folio);
-		return ERR_PTR(err);
-	}
-
-	return folio;
-}
-
 static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 					   struct mempolicy *mpol, pgoff_t ilx,
 					   struct swap_iocb **plug, bool readahead)
 {
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct folio *folio;
 
-	/* Check the swap cache again for readahead path. */
-	folio = swap_cache_get_folio(entry);
-	if (folio)
-		return folio;
-
-	/* Skip allocation for unused and bad swap slot for readahead. */
-	if (!swap_entry_swapped(si, entry))
-		return NULL;
-
 	do {
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			return folio;
 
-		folio = swap_cache_alloc_folio(entry, gfp, mpol, ilx);
+		folio = swap_cache_alloc_folio(entry, gfp, BIT(0), NULL, mpol, ilx);
 	} while (PTR_ERR(folio) == -EEXIST);
 
 	if (IS_ERR_OR_NULL(folio))
diff --git a/mm/zswap.c b/mm/zswap.c
index e27f6e96f003..761cd699e0a3 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1000,7 +1000,7 @@ static int zswap_writeback_entry(struct zswap_entry *entry,
 		return -EEXIST;
 
 	mpol = get_task_policy(current);
-	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, mpol,
+	folio = swap_cache_alloc_folio(swpentry, GFP_KERNEL, BIT(0), NULL, mpol,
 				       NO_INTERLEAVE_INDEX);
 	put_swap_device(si);
 

-- 
2.54.0



