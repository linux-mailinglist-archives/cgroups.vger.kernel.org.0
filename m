Return-Path: <cgroups+bounces-14029-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wALgNB+gl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14029-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0431639D8
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E6F5305E99E
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F795330307;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TS1V7COW"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D29324B1F;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544527; cv=none; b=Z5iYAISCH5rWWoiOEMGSNnBPHYZefIsiMPh6kxUZIsbheuzZ6LIgw/eo284v9QBpFLsmiAXS+Va6gyTJg5bRBfXGjeSWR32MkukDK7syzOd/yLHireEh8zN+anchzLyeze4bhfzYMRwKTFkhWYDHL5oAjIciHQIlyFA0DvkpOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544527; c=relaxed/simple;
	bh=pjJUa1fFgyrsyPyrCrROjkC/rrvPsGfIR4mvGiZIF7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VMmP99GKwcZ/5Na2JqsLN6KHWwVsgZmPEYn5WJV9vcBgz95nBBQmV6dRBfxV97pZRxWqzsRrOavDSAPjmh4sryLTnS2K9fgbDr4xcAgCWTpkW/NaNDNY7RZHAYloAwR5GEq3rGb7anAJNp7i+vjelL8wNnK49ab9oJHT/HxeNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TS1V7COW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D5EDC2BC86;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544527;
	bh=pjJUa1fFgyrsyPyrCrROjkC/rrvPsGfIR4mvGiZIF7g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TS1V7COWhmNelMcnOj04+7XD92TCDA7yhx9HvwDuofIcEQ80TMyO6/xJAHYc87tMB
	 AROmFVzJHpPrusJmAy+qS4PJYmU9BxcxyOxDCsm4ytscHPWKcW+aPUyZ7JRz3Pbswd
	 LZSsS5q02J0+m8ZfDGUI7MelY8cah/qt2h9nLyqj8ZXYWGWwL/Fo57p+K4x2m2dRe7
	 RupvSECyeo4u8Kyybzsw774xgasmiUdfhubbCbh+q6TsabPZyDK6492mK+p0PdCh6E
	 ZZmvhs6pb5B8GlT+MkDiADIbICYSBjz1g18XdjLubPF4D1w3Vd/+uCmA/zFM5/eF5E
	 GQsSnnMG8pXrw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71208C531EA;
	Thu, 19 Feb 2026 23:42:07 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 20 Feb 2026 07:42:06 +0800
Subject: [PATCH RFC 05/15] mm, swap: unify large folio allocation
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-swap-table-p4-v1-5-104795d19815@tencent.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=19505;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=zaL8E2c3BSd0dUGVRVd03OjIP9BByn+whCdDpg5s+H4=;
 b=uf0UfWfusmCfdSvsmKFiWhO5/Si66GCuWlnzS5Feoymfb9ZlBpLHWNuzNs+2rzeoeNbJFkp0+
 KY+1cqqyWbsBVWoCMt1omqzZJjKfy7VzEN6mMusRquUPs/Jq7ZDBLB4
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14029-lists,cgroups=lfdr.de,kasong.tencent.com];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com]
X-Rspamd-Queue-Id: 7D0431639D8
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Now the large order allocation is supported in swap cache, making both
anon and shmem use this instead of implementing their own different
method for doing so.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memory.c     |  77 +++++---------------------
 mm/shmem.c      |  94 ++++++++------------------------
 mm/swap.h       |  30 ++---------
 mm/swap_state.c | 163 ++++++++++++--------------------------------------------
 mm/swapfile.c   |   3 +-
 5 files changed, 76 insertions(+), 291 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 21bf2517fbce..e58f976508b3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4520,26 +4520,6 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	return VM_FAULT_SIGBUS;
 }
 
-static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
-{
-	struct vm_area_struct *vma = vmf->vma;
-	struct folio *folio;
-	softleaf_t entry;
-
-	folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vmf->address);
-	if (!folio)
-		return NULL;
-
-	entry = softleaf_from_pte(vmf->orig_pte);
-	if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
-					   GFP_KERNEL, entry)) {
-		folio_put(folio);
-		return NULL;
-	}
-
-	return folio;
-}
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * Check if the PTEs within a range are contiguous swap entries
@@ -4569,8 +4549,6 @@ static bool can_swapin_thp(struct vm_fault *vmf, pte_t *ptep, int nr_pages)
 	 */
 	if (unlikely(swap_zeromap_batch(entry, nr_pages, NULL) != nr_pages))
 		return false;
-	if (unlikely(non_swapcache_batch(entry, nr_pages) != nr_pages))
-		return false;
 
 	return true;
 }
@@ -4598,16 +4576,14 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
 	return orders;
 }
 
-static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+static unsigned long thp_swapin_suiltable_orders(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long orders;
-	struct folio *folio;
 	unsigned long addr;
 	softleaf_t entry;
 	spinlock_t *ptl;
 	pte_t *pte;
-	gfp_t gfp;
 	int order;
 
 	/*
@@ -4615,7 +4591,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * maintain the uffd semantics.
 	 */
 	if (unlikely(userfaultfd_armed(vma)))
-		goto fallback;
+		return 0;
 
 	/*
 	 * A large swapped out folio could be partially or fully in zswap. We
@@ -4623,7 +4599,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	 * folio.
 	 */
 	if (!zswap_never_enabled())
-		goto fallback;
+		return 0;
 
 	entry = softleaf_from_pte(vmf->orig_pte);
 	/*
@@ -4637,12 +4613,12 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 					  vmf->address, orders);
 
 	if (!orders)
-		goto fallback;
+		return 0;
 
 	pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
 				  vmf->address & PMD_MASK, &ptl);
 	if (unlikely(!pte))
-		goto fallback;
+		return 0;
 
 	/*
 	 * For do_swap_page, find the highest order where the aligned range is
@@ -4658,29 +4634,12 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 
 	pte_unmap_unlock(pte, ptl);
 
-	/* Try allocating the highest of the remaining orders. */
-	gfp = vma_thp_gfp_mask(vma);
-	while (orders) {
-		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
-		folio = vma_alloc_folio(gfp, order, vma, addr);
-		if (folio) {
-			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
-							    gfp, entry))
-				return folio;
-			count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
-			folio_put(folio);
-		}
-		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
-		order = next_order(&orders, order);
-	}
-
-fallback:
-	return __alloc_swap_folio(vmf);
+	return orders;
 }
 #else /* !CONFIG_TRANSPARENT_HUGEPAGE */
-static struct folio *alloc_swap_folio(struct vm_fault *vmf)
+static unsigned long thp_swapin_suiltable_orders(struct vm_fault *vmf)
 {
-	return __alloc_swap_folio(vmf);
+	return 0;
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -4785,21 +4744,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (folio)
 		swap_update_readahead(folio, vma, vmf->address);
 	if (!folio) {
-		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
-			folio = alloc_swap_folio(vmf);
-			if (folio) {
-				/*
-				 * folio is charged, so swapin can only fail due
-				 * to raced swapin and return NULL.
-				 */
-				swapcache = swapin_folio(entry, folio);
-				if (swapcache != folio)
-					folio_put(folio);
-				folio = swapcache;
-			}
-		} else {
+		/* Swapin bypass readahead for SWP_SYNCHRONOUS_IO devices */
+		if (data_race(si->flags & SWP_SYNCHRONOUS_IO))
+			folio = swapin_entry(entry, GFP_HIGHUSER_MOVABLE,
+					     thp_swapin_suiltable_orders(vmf),
+					     vmf, NULL, 0);
+		else
 			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
-		}
 
 		if (!folio) {
 			/*
diff --git a/mm/shmem.c b/mm/shmem.c
index 9f054b5aae8e..0a19ac82ec77 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -159,7 +159,7 @@ static unsigned long shmem_default_max_inodes(void)
 
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
-			struct vm_area_struct *vma, vm_fault_t *fault_type);
+			struct vm_fault *vmf, vm_fault_t *fault_type);
 
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
@@ -2014,68 +2014,24 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 }
 
 static struct folio *shmem_swap_alloc_folio(struct inode *inode,
-		struct vm_area_struct *vma, pgoff_t index,
+		struct vm_fault *vmf, pgoff_t index,
 		swp_entry_t entry, int order, gfp_t gfp)
 {
+	pgoff_t ilx;
+	struct folio *folio;
+	struct mempolicy *mpol;
+	unsigned long orders = BIT(order);
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct folio *new, *swapcache;
-	int nr_pages = 1 << order;
-	gfp_t alloc_gfp = gfp;
-
-	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-		if (WARN_ON_ONCE(order))
-			return ERR_PTR(-EINVAL);
-	} else if (order) {
-		/*
-		 * If uffd is active for the vma, we need per-page fault
-		 * fidelity to maintain the uffd semantics, then fallback
-		 * to swapin order-0 folio, as well as for zswap case.
-		 * Any existing sub folio in the swap cache also blocks
-		 * mTHP swapin.
-		 */
-		if ((vma && unlikely(userfaultfd_armed(vma))) ||
-		     !zswap_never_enabled() ||
-		     non_swapcache_batch(entry, nr_pages) != nr_pages)
-			goto fallback;
 
-		alloc_gfp = thp_limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
-	}
-retry:
-	new = shmem_alloc_folio(alloc_gfp, order, info, index);
-	if (!new) {
-		new = ERR_PTR(-ENOMEM);
-		goto fallback;
-	}
+	if ((vmf && unlikely(userfaultfd_armed(vmf->vma))) ||
+	     !zswap_never_enabled())
+		orders = 0;
 
-	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
-					   alloc_gfp, entry)) {
-		folio_put(new);
-		new = ERR_PTR(-ENOMEM);
-		goto fallback;
-	}
+	mpol = shmem_get_pgoff_policy(info, index, order, &ilx);
+	folio = swapin_entry(entry, gfp, orders, vmf, mpol, ilx);
+	mpol_cond_put(mpol);
 
-	swapcache = swapin_folio(entry, new);
-	if (swapcache != new) {
-		folio_put(new);
-		if (!swapcache) {
-			/*
-			 * The new folio is charged already, swapin can
-			 * only fail due to another raced swapin.
-			 */
-			new = ERR_PTR(-EEXIST);
-			goto fallback;
-		}
-	}
-	return swapcache;
-fallback:
-	/* Order 0 swapin failed, nothing to fallback to, abort */
-	if (!order)
-		return new;
-	entry.val += index - round_down(index, nr_pages);
-	alloc_gfp = gfp;
-	nr_pages = 1;
-	order = 0;
-	goto retry;
+	return folio;
 }
 
 /*
@@ -2262,11 +2218,12 @@ static int shmem_split_large_entry(struct inode *inode, pgoff_t index,
  */
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			     struct folio **foliop, enum sgp_type sgp,
-			     gfp_t gfp, struct vm_area_struct *vma,
+			     gfp_t gfp, struct vm_fault *vmf,
 			     vm_fault_t *fault_type)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct mm_struct *fault_mm = vma ? vma->vm_mm : NULL;
+	struct vm_area_struct *vma = vmf ? vmf->vma : NULL;
+	struct mm_struct *fault_mm = vmf ? vmf->vma->vm_mm : NULL;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	swp_entry_t swap;
 	softleaf_t index_entry;
@@ -2307,20 +2264,15 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
 			/* Direct swapin skipping swap cache & readahead */
-			folio = shmem_swap_alloc_folio(inode, vma, index,
-						       index_entry, order, gfp);
-			if (IS_ERR(folio)) {
-				error = PTR_ERR(folio);
-				folio = NULL;
-				goto failed;
-			}
+			folio = shmem_swap_alloc_folio(inode, vmf, index,
+						       swap, order, gfp);
 		} else {
 			/* Cached swapin only supports order 0 folio */
 			folio = shmem_swapin_cluster(swap, gfp, info, index);
-			if (!folio) {
-				error = -ENOMEM;
-				goto failed;
-			}
+		}
+		if (!folio) {
+			error = -ENOMEM;
+			goto failed;
 		}
 		if (fault_type) {
 			*fault_type |= VM_FAULT_MAJOR;
@@ -2468,7 +2420,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 	if (xa_is_value(folio)) {
 		error = shmem_swapin_folio(inode, index, &folio,
-					   sgp, gfp, vma, fault_type);
+					   sgp, gfp, vmf, fault_type);
 		if (error == -EEXIST)
 			goto repeat;
 
diff --git a/mm/swap.h b/mm/swap.h
index 6774af10a943..80c2f1bf7a57 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -300,7 +300,8 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
 		struct vm_fault *vmf);
-struct folio *swapin_folio(swp_entry_t entry, struct folio *folio);
+struct folio *swapin_entry(swp_entry_t entry, gfp_t flag, unsigned long orders,
+			   struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx);
 void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 			   unsigned long addr);
 
@@ -334,24 +335,6 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 		return find_next_bit(sis->zeromap, end, start) - start;
 }
 
-static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
-{
-	int i;
-
-	/*
-	 * While allocating a large folio and doing mTHP swapin, we need to
-	 * ensure all entries are not cached, otherwise, the mTHP folio will
-	 * be in conflict with the folio in swap cache.
-	 */
-	for (i = 0; i < max_nr; i++) {
-		if (swap_cache_has_folio(entry))
-			return i;
-		entry.val++;
-	}
-
-	return i;
-}
-
 #else /* CONFIG_SWAP */
 struct swap_iocb;
 static inline struct swap_cluster_info *swap_cluster_lock(
@@ -433,7 +416,9 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
-static inline struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
+static inline struct folio *swapin_entry(
+	swp_entry_t entry, gfp_t flag, unsigned long orders,
+	struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx)
 {
 	return NULL;
 }
@@ -493,10 +478,5 @@ static inline int swap_zeromap_batch(swp_entry_t entry, int max_nr,
 {
 	return 0;
 }
-
-static inline int non_swapcache_batch(swp_entry_t entry, int max_nr)
-{
-	return 0;
-}
 #endif /* CONFIG_SWAP */
 #endif /* _MM_SWAP_H */
diff --git a/mm/swap_state.c b/mm/swap_state.c
index e32b06a1f229..0a2a4e084cf2 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -199,43 +199,6 @@ void __swap_cache_add_folio(struct swap_cluster_info *ci,
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 }
 
-/**
- * swap_cache_add_folio - Add a folio into the swap cache.
- * @folio: The folio to be added.
- * @entry: The swap entry corresponding to the folio.
- * @gfp: gfp_mask for XArray node allocation.
- * @shadowp: If a shadow is found, return the shadow.
- *
- * Context: Caller must ensure @entry is valid and protect the swap device
- * with reference count or locks.
- */
-static int swap_cache_add_folio(struct folio *folio, swp_entry_t entry,
-				void **shadowp)
-{
-	int err;
-	void *shadow = NULL;
-	unsigned int ci_off;
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	unsigned long nr_pages = folio_nr_pages(folio);
-
-	si = __swap_entry_to_info(entry);
-	ci = swap_cluster_lock(si, swp_offset(entry));
-	ci_off = swp_cluster_offset(entry);
-	err = __swap_cache_check_batch(ci, ci_off, ci_off, nr_pages, &shadow);
-	if (err) {
-		swap_cluster_unlock(ci);
-		return err;
-	}
-
-	__swap_cache_add_folio(ci, folio, entry);
-	swap_cluster_unlock(ci);
-	if (shadowp)
-		*shadowp = shadow;
-
-	return 0;
-}
-
 static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 					swp_entry_t targ_entry, gfp_t gfp,
 					unsigned int order, struct vm_fault *vmf,
@@ -328,30 +291,28 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp_mask,
 				     unsigned long orders, struct vm_fault *vmf,
 				     struct mempolicy *mpol, pgoff_t ilx)
 {
-	int order;
+	int order, err;
 	struct folio *folio;
 	struct swap_cluster_info *ci;
 
+	/* Always allow order 0 so swap won't fail under pressure. */
+	order = orders ? highest_order(orders |= BIT(0)) : 0;
 	ci = __swap_entry_to_cluster(targ_entry);
-	order = orders ? highest_order(orders) : 0;
 	for (;;) {
 		folio = __swap_cache_alloc(ci, targ_entry, gfp_mask, order,
 					   vmf, mpol, ilx);
 		if (!IS_ERR(folio))
 			return folio;
-		if (PTR_ERR(folio) == -EAGAIN)
+		err = PTR_ERR(folio);
+		if (err == -EAGAIN)
 			continue;
-		/* Only -EBUSY means we should fallback and retry. */
-		if (PTR_ERR(folio) != -EBUSY)
-			return folio;
+		if (!order || (err != -EBUSY && err != -ENOMEM))
+			break;
 		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
 		order = next_order(&orders, order);
-		if (!orders)
-			break;
 	}
-	/* Should never reach here, order 0 should not fail with -EBUSY. */
-	WARN_ON_ONCE(1);
-	return ERR_PTR(-EINVAL);
+
+	return ERR_PTR(err);
 }
 
 /**
@@ -584,51 +545,6 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 	}
 }
 
-/**
- * __swap_cache_prepare_and_add - Prepare the folio and add it to swap cache.
- * @entry: swap entry to be bound to the folio.
- * @folio: folio to be added.
- * @gfp: memory allocation flags for charge, can be 0 if @charged if true.
- * @charged: if the folio is already charged.
- *
- * Update the swap_map and add folio as swap cache, typically before swapin.
- * All swap slots covered by the folio must have a non-zero swap count.
- *
- * Context: Caller must protect the swap device with reference count or locks.
- * Return: 0 if success, error code if failed.
- */
-static int __swap_cache_prepare_and_add(swp_entry_t entry,
-					struct folio *folio,
-					gfp_t gfp, bool charged)
-{
-	void *shadow;
-	int ret;
-
-	__folio_set_locked(folio);
-	__folio_set_swapbacked(folio);
-	ret = swap_cache_add_folio(folio, entry, &shadow);
-	if (ret)
-		goto failed;
-
-	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
-		swap_cache_del_folio(folio);
-		ret = -ENOMEM;
-		goto failed;
-	}
-
-	memcg1_swapin(entry, folio_nr_pages(folio));
-	if (shadow)
-		workingset_refault(folio, shadow);
-
-	/* Caller will initiate read into locked folio */
-	folio_add_lru(folio);
-	return 0;
-
-failed:
-	folio_unlock(folio);
-	return ret;
-}
-
 static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 					   struct mempolicy *mpol, pgoff_t ilx,
 					   struct swap_iocb **plug, bool readahead)
@@ -649,7 +565,6 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 		folio = swap_cache_get_folio(entry);
 		if (folio)
 			return folio;
-
 		folio = swap_cache_alloc_folio(entry, gfp, 0, NULL, mpol, ilx);
 	} while (PTR_ERR(folio) == -EEXIST);
 
@@ -666,49 +581,37 @@ static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gfp,
 }
 
 /**
- * swapin_folio - swap-in one or multiple entries skipping readahead.
- * @entry: starting swap entry to swap in
- * @folio: a new allocated and charged folio
+ * swapin_entry - swap-in one or multiple entries skipping readahead.
+ * @entry: swap entry indicating the target slot
+ * @gfp_mask: memory allocation flags
+ * @orders: allocation orders
+ * @vmf: fault information
+ * @mpol: NUMA memory allocation policy to be applied
+ * @ilx: NUMA interleave index, for use only when MPOL_INTERLEAVE
  *
- * Reads @entry into @folio, @folio will be added to the swap cache.
- * If @folio is a large folio, the @entry will be rounded down to align
- * with the folio size.
+ * This would allocate a folio suit given @orders, or return the existing
+ * folio in the swap cache for @entry. This initiates the IO, too, if needed.
+ * @entry could be rounded down if @orders allows large allocation.
  *
- * Return: returns pointer to @folio on success. If folio is a large folio
- * and this raced with another swapin, NULL will be returned to allow fallback
- * to order 0. Else, if another folio was already added to the swap cache,
- * return that swap cache folio instead.
+ * Context: Caller must ensure @entry is valid and pin the swap device with refcount.
+ * Return: Returns the folio on success, returns error code if failed.
  */
-struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
+struct folio *swapin_entry(swp_entry_t entry, gfp_t gfp, unsigned long orders,
+			   struct vm_fault *vmf, struct mempolicy *mpol, pgoff_t ilx)
 {
-	int ret;
-	struct folio *swapcache;
-	pgoff_t offset = swp_offset(entry);
-	unsigned long nr_pages = folio_nr_pages(folio);
-
-	entry = swp_entry(swp_type(entry), round_down(offset, nr_pages));
-	for (;;) {
-		ret = __swap_cache_prepare_and_add(entry, folio, 0, true);
-		if (!ret) {
-			swap_read_folio(folio, NULL);
-			break;
-		}
+	struct folio *folio;
 
-		/*
-		 * Large order allocation needs special handling on
-		 * race: if a smaller folio exists in cache, swapin needs
-		 * to fallback to order 0, and doing a swap cache lookup
-		 * might return a folio that is irrelevant to the faulting
-		 * entry because @entry is aligned down. Just return NULL.
-		 */
-		if (ret != -EEXIST || nr_pages > 1)
-			return NULL;
+	do {
+		folio = swap_cache_get_folio(entry);
+		if (folio)
+			return folio;
+		folio = swap_cache_alloc_folio(entry, gfp, orders, vmf, mpol, ilx);
+	} while (PTR_ERR(folio) == -EEXIST);
 
-		swapcache = swap_cache_get_folio(entry);
-		if (swapcache)
-			return swapcache;
-	}
+	if (IS_ERR(folio))
+		return NULL;
 
+	swap_read_folio(folio, NULL);
 	return folio;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 06b37efad2bd..7e7614a5181a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1833,8 +1833,7 @@ void folio_put_swap(struct folio *folio, struct page *subpage)
  *   do_swap_page()
  *     ...				swapoff+swapon
  *     swap_cache_alloc_folio()
- *       swap_cache_add_folio()
- *         // check swap_map
+ *       // check swap_map
  *     // verify PTE not changed
  *
  * In __swap_duplicate(), the swap_map need to be checked before

-- 
2.53.0



