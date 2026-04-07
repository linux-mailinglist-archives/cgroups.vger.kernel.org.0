Return-Path: <cgroups+bounces-15183-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFbnCtIb1Wli0wcAu9opvQ
	(envelope-from <cgroups+bounces-15183-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:59:30 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D16093B083B
	for <lists+cgroups@lfdr.de>; Tue, 07 Apr 2026 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 319CF307D974
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2026 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6DB33D51A;
	Tue,  7 Apr 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3PJoe5i"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C333CEA8;
	Tue,  7 Apr 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573746; cv=none; b=BuONy2da5V/qvKLYXrraZM9BVpMc2eIZb1S8nUNb8YmC1x3z4MX9IU0prYJKf5Tt1QCK4zC1nrSVKzLYpoThO2ve2nuCgg7u2qoZAv9hFSd1UXXATCAWeHm6TkmGhMS0BBfBRc4IDAHtVbhQQwJ+JqFlL32dqi7dTC+qkLBxD0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573746; c=relaxed/simple;
	bh=gZSdq43ylN8hfqryWBeuU1CuwBkem5XZlHWCIIzfBHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ze+T4eazUZ99a0zDoa+2h2kvsqPtj2j6lmi0NJY06CufJUeQh+b72Siv0DyV/3sJXPt8iq3ucjrgpWqMQaE1QoLWV0ekSlaHWGEd0JvmY5BJv1mwmhIWhykNLoaV+RmyZ/PzY2O5+JvNzVVGjrdd+Lp10OcP/J+ZRQ7xv4mcKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3PJoe5i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CC89AC2BCB1;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775573745;
	bh=gZSdq43ylN8hfqryWBeuU1CuwBkem5XZlHWCIIzfBHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p3PJoe5iyZEDTbjG6OMNcQFWzPcNBl/hkk4K7+UpjvSV1TAO4Y04DLDgp8fM2bt7d
	 oJKbV8Ic8TU9BxmsV0Q54RGD1+O6B5z0ka3ZUCkKCCyiP85fEGC696zYF3QNzwKN0J
	 HDRAcTuMMjPYUcTD0g4wZ/ZvXbfuAUsxODFw0pg1f60yxOf/B7+EnA+NTqK0lP2QgC
	 gAqiQaYUQuhM/z4Zotix5i31oG7xo9LiG7VsaZRFvGJttbrjr6fL/gtFPYegR+9RZr
	 j0T2j0NPdDRD4rP9XPxCzANHLURuqjOzZ4TVtbyvhFzLkb2ZxK9CQFeZYQPz9btP70
	 J0xDAJRLXeCrA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA2FEEF56;
	Tue,  7 Apr 2026 14:55:45 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Tue, 07 Apr 2026 22:55:43 +0800
Subject: [PATCH RFC 2/2] mm, swap: fix race of charging into the wrong
 memcg for THP
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-swap-memcg-fix-v1-2-a473ce2e5bb8@tencent.com>
References: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com>
In-Reply-To: <20260407-swap-memcg-fix-v1-0-a473ce2e5bb8@tencent.com>
To: linux-mm@kvack.org
Cc: Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Alexandre Ghiti <alex@ghiti.fr>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chuanhua Han <hanchuanhua@oppo.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775573744; l=9867;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=X/ek0pSZoNxTKZ9tG09c+ZJJhzY+pVd49UQb7w0YLRg=;
 b=TEFcKwourn71DBqm8jy/z51c4t+8wplThkHDyKqJx0EX8IOsS+2FUkCNMMf6qaYfwO3XXR8pv
 JTm46EI/SigDaZbSECo8iymi1myXiHV3UPIKJ8ozTjGjcdqTbh+ysdB
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15183-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,linux-foundation.org,huaweicloud.com,gmail.com,redhat.com,lge.com,cmpxchg.org,ghiti.fr,oracle.com,google.com,suse.com,linux.alibaba.com,oppo.com,vger.kernel.org,tencent.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,tencent.com:replyto,tencent.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D16093B083B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Kairui Song <kasong@tencent.com>

During THP swapin via the SYNCHRONOUS_IO path, the folio is allocated
and charged to a memcg before being inserted into the swap cache.
Between allocation and swap cache insertion, the page table can change
under us (we don't hold the PTE lock), so the swap entry may be freed
and reused by a different cgroup. This causes the folio to be charged to
the wrong memcg. Shmem also has a similar issue.

Usually, the double check of the page table will catch this, but the
same page table entry may reuse the swap entry, but by a different
cgroup. The chance is extremely low, requiring a set of rare time
windows to hit in a row, but it is totally possible.

Fix this by charging the folio after it is inserted and stabilized in
the swap cache. This would also improve the performance and simplify the
code.

Also remove the now-stale comment about memcg charging of swapin
Now we always charge the folio after adding it to the swap cache.
Previously it has to do this before adding to swap cache for
maintaining the per-memcg swapcache stat. We have decoupled the stat
update from adding the folio during swapin in previous commit so
this is fine now.

Fixes: 242d12c981745 ("mm: support large folios swap-in for sync io devices")
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/memcontrol.c |  3 +--
 mm/memory.c     | 53 +++++++++++++++++++++++------------------------------
 mm/shmem.c      | 15 ++++-----------
 mm/swap.h       |  5 +++--
 mm/swap_state.c | 17 +++++++++--------
 5 files changed, 40 insertions(+), 53 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3d98ab41f1f..21caed15c9f5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5067,8 +5067,7 @@ int mem_cgroup_charge_hugetlb(struct folio *folio, gfp_t gfp)
  * @gfp: reclaim mode
  * @entry: swap entry for which the folio is allocated
  *
- * This function charges a folio allocated for swapin. Please call this before
- * adding the folio to the swapcache.
+ * This function charges a folio allocated for swapin.
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
diff --git a/mm/memory.c b/mm/memory.c
index ea6568571131..6d5b0c10ac8e 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4595,22 +4595,8 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 
 static struct folio *__alloc_swap_folio(struct vm_fault *vmf)
 {
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
+	return vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
+			       vmf->vma, vmf->address);
 }
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -4736,13 +4722,8 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
 	while (orders) {
 		addr = ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
 		folio = vma_alloc_folio(gfp, order, vma, addr);
-		if (folio) {
-			if (!mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
-							    gfp, entry))
-				return folio;
-			count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK_CHARGE);
-			folio_put(folio);
-		}
+		if (folio)
+			return folio;
 		count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
 		order = next_order(&orders, order);
 	}
@@ -4858,18 +4839,30 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	folio = swap_cache_get_folio(entry);
 	if (folio)
 		swap_update_readahead(folio, vma, vmf->address);
+
 	if (!folio) {
 		if (data_race(si->flags & SWP_SYNCHRONOUS_IO)) {
+			gfp_t gfp = GFP_HIGHUSER_MOVABLE;
+
 			folio = alloc_swap_folio(vmf);
 			if (folio) {
-				/*
-				 * folio is charged, so swapin can only fail due
-				 * to raced swapin and return NULL.
-				 */
-				swapcache = swapin_folio(entry, folio);
-				if (swapcache != folio)
+				if (folio_test_large(folio))
+					gfp = vma_thp_gfp_mask(vma);
+				swapcache = swapin_folio(entry, folio, gfp);
+				if (swapcache) {
+					/* We might hit with another cached swapin */
+					if (swapcache != folio)
+						folio_put(folio);
+					folio = swapcache;
+				} else if (folio_test_large(folio)) {
+					/* THP swapin failed, try order 0 */
+					folio_put(folio);
+					folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
+				} else {
+					/* order 0 swapin failure, abort */
 					folio_put(folio);
-				folio = swapcache;
+					folio = NULL;
+				}
 			}
 		} else {
 			folio = swapin_readahead(entry, GFP_HIGHUSER_MOVABLE, vmf);
diff --git a/mm/shmem.c b/mm/shmem.c
index 5aa43657886c..bc67b04b9de4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2071,22 +2071,15 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		goto fallback;
 	}
 
-	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
-					   alloc_gfp, entry)) {
-		folio_put(new);
-		new = ERR_PTR(-ENOMEM);
-		goto fallback;
-	}
-
-	swapcache = swapin_folio(entry, new);
+	swapcache = swapin_folio(entry, new, alloc_gfp);
 	if (swapcache != new) {
 		folio_put(new);
 		if (!swapcache) {
 			/*
-			 * The new folio is charged already, swapin can
-			 * only fail due to another raced swapin.
+			 * Fail with -ENOMEM by default, caller will
+			 * correct it to -EEXIST if mapping changed.
 			 */
-			new = ERR_PTR(-EEXIST);
+			new = ERR_PTR(-ENOMEM);
 			goto fallback;
 		}
 	}
diff --git a/mm/swap.h b/mm/swap.h
index a77016f2423b..90f1edabb73a 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -300,7 +300,7 @@ struct folio *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 		struct mempolicy *mpol, pgoff_t ilx);
 struct folio *swapin_readahead(swp_entry_t entry, gfp_t flag,
 		struct vm_fault *vmf);
-struct folio *swapin_folio(swp_entry_t entry, struct folio *folio);
+struct folio *swapin_folio(swp_entry_t entry, struct folio *folio, gfp_t flag);
 void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
 			   unsigned long addr);
 
@@ -433,7 +433,8 @@ static inline struct folio *swapin_readahead(swp_entry_t swp, gfp_t gfp_mask,
 	return NULL;
 }
 
-static inline struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
+static inline struct folio *swapin_folio(swp_entry_t entry,
+		struct folio *folio, gfp_t flag)
 {
 	return NULL;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index c53d16b87a98..d24a7a3482ec 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -468,8 +468,7 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
  * __swap_cache_prepare_and_add - Prepare the folio and add it to swap cache.
  * @entry: swap entry to be bound to the folio.
  * @folio: folio to be added.
- * @gfp: memory allocation flags for charge, can be 0 if @charged is true.
- * @charged: if the folio is already charged.
+ * @gfp: memory allocation flags for charge.
  *
  * Update the swap_map and add folio as swap cache, typically before swapin.
  * All swap slots covered by the folio must have a non-zero swap count.
@@ -480,7 +479,7 @@ void swap_update_readahead(struct folio *folio, struct vm_area_struct *vma,
  */
 static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 						  struct folio *folio,
-						  gfp_t gfp, bool charged)
+						  gfp_t gfp)
 {
 	unsigned long nr_pages = folio_nr_pages(folio);
 	struct folio *swapcache = NULL;
@@ -511,12 +510,14 @@ static struct folio *__swap_cache_prepare_and_add(swp_entry_t entry,
 			goto failed;
 	}
 
-	if (!charged && mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
+	if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp, entry)) {
 		/* We might lose the shadow here, but that's fine */
 		ci = swap_cluster_get_and_lock(folio);
 		__swap_cache_do_del_folio(ci, folio, entry, NULL);
 		swap_cluster_unlock(ci);
 
+		count_mthp_stat(folio_order(folio), MTHP_STAT_SWPIN_FALLBACK_CHARGE);
+
 		/* __swap_cache_do_del_folio doesn't put the refs */
 		folio_ref_sub(folio, nr_pages);
 		goto failed;
@@ -578,7 +579,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 	if (!folio)
 		return NULL;
 	/* Try add the new folio, returns existing folio or NULL on failure. */
-	result = __swap_cache_prepare_and_add(entry, folio, gfp_mask, false);
+	result = __swap_cache_prepare_and_add(entry, folio, gfp_mask);
 	if (result == folio)
 		*new_page_allocated = true;
 	else
@@ -589,7 +590,7 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
 /**
  * swapin_folio - swap-in one or multiple entries skipping readahead.
  * @entry: starting swap entry to swap in
- * @folio: a new allocated and charged folio
+ * @folio: a new allocated folio
  *
  * Reads @entry into @folio, @folio will be added to the swap cache.
  * If @folio is a large folio, the @entry will be rounded down to align
@@ -600,14 +601,14 @@ struct folio *swap_cache_alloc_folio(swp_entry_t entry, gfp_t gfp_mask,
  * to order 0. Else, if another folio was already added to the swap cache,
  * return that swap cache folio instead.
  */
-struct folio *swapin_folio(swp_entry_t entry, struct folio *folio)
+struct folio *swapin_folio(swp_entry_t entry, struct folio *folio, gfp_t gfp)
 {
 	struct folio *swapcache;
 	pgoff_t offset = swp_offset(entry);
 	unsigned long nr_pages = folio_nr_pages(folio);
 
 	entry = swp_entry(swp_type(entry), round_down(offset, nr_pages));
-	swapcache = __swap_cache_prepare_and_add(entry, folio, 0, true);
+	swapcache = __swap_cache_prepare_and_add(entry, folio, gfp);
 	if (swapcache == folio)
 		swap_read_folio(folio, NULL);
 	return swapcache;

-- 
2.53.0



