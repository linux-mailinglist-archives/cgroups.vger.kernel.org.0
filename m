Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957FA1B97FC
	for <lists+cgroups@lfdr.de>; Mon, 27 Apr 2020 09:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgD0HDn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 27 Apr 2020 03:03:43 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:37668 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726504AbgD0HDk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 27 Apr 2020 03:03:40 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0TwlGiqA_1587971012;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TwlGiqA_1587971012)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Apr 2020 15:03:33 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH v10 01/15] mm/swap: use vmf clean up swapin funcs parameters
Date:   Mon, 27 Apr 2020 15:02:50 +0800
Message-Id: <1587970985-21629-2-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587970985-21629-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Folding parameter struct vm_area_struct *vma, unsigned long addr into
struct vm_fault vmf, this makes func path more readble.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/swap.h |  6 ++----
 mm/madvise.c         | 11 +++++++----
 mm/swap_state.c      | 23 ++++++++++-------------
 mm/swapfile.c        |  8 +++++---
 mm/zswap.c           |  3 ++-
 5 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index c453d08e07fb..6ca3adf62fe0 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -417,11 +417,9 @@ extern struct page *lookup_swap_cache(swp_entry_t entry,
 				      struct vm_area_struct *vma,
 				      unsigned long addr);
 extern struct page *read_swap_cache_async(swp_entry_t, gfp_t,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool do_poll);
+				struct vm_fault *vmf, bool do_poll);
 extern struct page *__read_swap_cache_async(swp_entry_t, gfp_t,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated);
+				struct vm_fault *vmf, bool *new_page_allocated);
 extern struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
 				struct vm_fault *vmf);
 extern struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
diff --git a/mm/madvise.c b/mm/madvise.c
index 4bb30ed6c8d2..e9bd80087dbb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -184,8 +184,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 	unsigned long end, struct mm_walk *walk)
 {
 	pte_t *orig_pte;
-	struct vm_area_struct *vma = walk->private;
 	unsigned long index;
+	struct vm_fault vmf = { .vma = walk->private};
 
 	if (pmd_none_or_trans_huge_or_clear_bad(pmd))
 		return 0;
@@ -196,7 +196,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		struct page *page;
 		spinlock_t *ptl;
 
-		orig_pte = pte_offset_map_lock(vma->vm_mm, pmd, start, &ptl);
+		orig_pte = pte_offset_map_lock(vmf.vma->vm_mm,
+						pmd, start, &ptl);
 		pte = *(orig_pte + ((index - start) / PAGE_SIZE));
 		pte_unmap_unlock(orig_pte, ptl);
 
@@ -206,8 +207,9 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		if (unlikely(non_swap_entry(entry)))
 			continue;
 
+		vmf.address = index;
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
-							vma, index, false);
+							&vmf, false);
 		if (page)
 			put_page(page);
 	}
@@ -226,6 +228,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 	pgoff_t index;
 	struct page *page;
 	swp_entry_t swap;
+	struct vm_fault vmf = { .vma = NULL, .address = 0};
 
 	for (; start < end; start += PAGE_SIZE) {
 		index = ((start - vma->vm_start) >> PAGE_SHIFT) + vma->vm_pgoff;
@@ -238,7 +241,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 		}
 		swap = radix_to_swp_entry(page);
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
-							NULL, 0, false);
+							&vmf, false);
 		if (page)
 			put_page(page);
 	}
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 26fded65c30d..b056c7ec941f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -357,11 +357,12 @@ struct page *lookup_swap_cache(swp_entry_t entry, struct vm_area_struct *vma,
 }
 
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-			struct vm_area_struct *vma, unsigned long addr,
-			bool *new_page_allocated)
+			struct vm_fault *vmf, bool *new_page_allocated)
 {
 	struct swap_info_struct *si;
 	struct page *page;
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address;
 
 	*new_page_allocated = false;
 
@@ -453,11 +454,11 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  * the swap entry is no longer in use.
  */
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
-		struct vm_area_struct *vma, unsigned long addr, bool do_poll)
+					struct vm_fault *vmf, bool do_poll)
 {
 	bool page_was_allocated;
 	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
-			vma, addr, &page_was_allocated);
+						vmf, &page_was_allocated);
 
 	if (page_was_allocated)
 		swap_readpage(retpage, do_poll);
@@ -554,8 +555,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
 	bool do_poll = true, page_allocated;
-	struct vm_area_struct *vma = vmf->vma;
-	unsigned long addr = vmf->address;
 
 	mask = swapin_nr_pages(offset) - 1;
 	if (!mask)
@@ -582,7 +581,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		/* Ok, do the async read-ahead now */
 		page = __read_swap_cache_async(
 			swp_entry(swp_type(entry), offset),
-			gfp_mask, vma, addr, &page_allocated);
+			gfp_mask, vmf, &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -598,7 +597,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll);
+	return read_swap_cache_async(entry, gfp_mask, vmf, do_poll);
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -730,7 +729,6 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 				       struct vm_fault *vmf)
 {
 	struct blk_plug plug;
-	struct vm_area_struct *vma = vmf->vma;
 	struct page *page;
 	pte_t *pte, pentry;
 	swp_entry_t entry;
@@ -753,8 +751,8 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 		entry = pte_to_swp_entry(pentry);
 		if (unlikely(non_swap_entry(entry)))
 			continue;
-		page = __read_swap_cache_async(entry, gfp_mask, vma,
-					       vmf->address, &page_allocated);
+		page = __read_swap_cache_async(entry, gfp_mask, vmf,
+					       &page_allocated);
 		if (!page)
 			continue;
 		if (page_allocated) {
@@ -769,8 +767,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 	blk_finish_plug(&plug);
 	lru_add_drain();
 skip:
-	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1);
+	return read_swap_cache_async(fentry, gfp_mask, vmf, ra_info.win == 1);
 }
 
 /**
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e41074848f25..0c4d604fbf8d 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1850,12 +1850,14 @@ static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
  * just let do_wp_page work it out if a write is requested later - to
  * force COW, vm_page_prot omits write permission from any private vma.
  */
-static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
-		unsigned long addr, swp_entry_t entry, struct page *page)
+static int unuse_pte(struct vm_fault *vmf, swp_entry_t entry, struct page *page)
 {
 	struct page *swapcache;
 	spinlock_t *ptl;
 	pte_t *pte;
+	struct vm_area_struct *vma = vmf->vma;
+	unsigned long addr = vmf->address;
+	pmd_t *pmd = vmf->pmd;
 	int ret = 1;
 
 	swapcache = page;
@@ -1938,7 +1940,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 
 		lock_page(page);
 		wait_on_page_writeback(page);
-		ret = unuse_pte(vma, pmd, addr, entry, page);
+		ret = unuse_pte(&vmf, entry, page);
 		if (ret < 0) {
 			unlock_page(page);
 			put_page(page);
diff --git a/mm/zswap.c b/mm/zswap.c
index fbb782924ccc..ef5a3fe442d6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -846,9 +846,10 @@ static int zswap_get_swap_cache_page(swp_entry_t entry,
 				struct page **retpage)
 {
 	bool page_was_allocated;
+	struct vm_fault vmf = { .vma = NULL, .address = 0};
 
 	*retpage = __read_swap_cache_async(entry, GFP_KERNEL,
-			NULL, 0, &page_was_allocated);
+			&vmf, &page_was_allocated);
 	if (page_was_allocated)
 		return ZSWAP_SWAPCACHE_NEW;
 	if (!*retpage)
-- 
1.8.3.1

