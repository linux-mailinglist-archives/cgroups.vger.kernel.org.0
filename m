Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAD1CE256
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2020 20:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgEKSMi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 May 2020 14:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKSMi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 May 2020 14:12:38 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA28C061A0C
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 11:12:36 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c64so10750306qkf.12
        for <cgroups@vger.kernel.org>; Mon, 11 May 2020 11:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zkDVL6MvW8WSIQ5Mjj12wIdfJyoGic/GAL7tCV6iez0=;
        b=k4y4Q0vn1Q7ckeOWMSDRnHl/6eyp6Eius6E6WMfA2zuc5F3ReUA4iW8IOb1tVTYZro
         Isa3WDsioQ+3gp+ddvoX7AjECZaw4vYe1+Fs7TDVg8YB/VSnsUmKYVKq8BvTtQd5limj
         0lE1e0TqAMtEqFk9MOyVBN9Qymem0hGJxSna+plw7Gzu9PbiiZ3JOF2snDfApAT5M2+q
         4egHCh+tppFdmpNvDfV7E0JrsyXGUYm44oLGjZpEBl9R1502VVUsf+vTJYf8EWm896Ab
         Pbx2JEQUiA/3rK/NXWMkYbSjAzTuN/aawGKaxNCSGYHV7eQAwesSoUttPhFhuttIXf8A
         XaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zkDVL6MvW8WSIQ5Mjj12wIdfJyoGic/GAL7tCV6iez0=;
        b=P1FdZtexetZipKAp6BHJl231L6EaJgxJEVEC2oE87hNjZgrBBjdvrRvYgtiaNqR2dE
         j8tLrEs6EUG/oQkmelz/BaL5cPuaPSymmLx4UpUc7TfEGZvNxsZp+rTbUECmPVPYLsCm
         QU2z/EhU+CXo+oGe5/XVhoKuj6eCSs5O3hdCqbuG8omSvuAudzgUJAHTcavgouPZ3NHS
         tn7v+69l2TFuobwPXo+cAytedI1vuVIMs+2u3OR8ovE1bE/8I6jiS+sEEsw5hS/ddoHW
         CZfH5DGtCx8r/8SBHCG4OCKXU/a9o1xPP+5FCOYN7C1pdD+MopCgPH6/UHhy19R7Ya3f
         pKIg==
X-Gm-Message-State: AOAM533fPBV4871vR+5JsQjDkytZXA79oNhb7UNfkn/0Z0npN6VeZ0/H
        zxTCSTEMgx3NqnYmLHFZEZXQWQ==
X-Google-Smtp-Source: ABdhPJwSSJPrc2KOvmIgbDaS7jX5tcexLK4idgmpbTaaJ0cgPi1hOX2HTQyuxBzJm/yL1KA1m+SjcA==
X-Received: by 2002:a37:6547:: with SMTP id z68mr3638441qkb.197.1589220755935;
        Mon, 11 May 2020 11:12:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id b198sm8036881qkg.37.2020.05.11.11.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:12:34 -0700 (PDT)
Date:   Mon, 11 May 2020 14:12:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 05/18] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API
Message-ID: <20200511181217.GB339505@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-6-hannes@cmpxchg.org>
 <20200422064041.GE6780@js1304-desktop>
 <20200422120946.GA358439@cmpxchg.org>
 <20200423052450.GA12538@js1304-desktop>
 <20200508160122.GB181181@cmpxchg.org>
 <alpine.LSU.2.11.2005102350360.2769@eggly.anvils>
 <20200511150648.GA306292@cmpxchg.org>
 <alpine.LSU.2.11.2005110912180.3431@eggly.anvils>
 <20200511181056.GA339505@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511181056.GA339505@cmpxchg.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 11, 2020 at 02:10:58PM -0400, Johannes Weiner wrote:
> From fc9dcaf68c8b54baf365cd670fb5780c7f0d243f Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Mon, 11 May 2020 12:59:08 -0400
> Subject: [PATCH] mm: shmem: remove rare optimization when swapin races with
>  hole punching

And a new, conflict-resolved version of the patch this thread is
attached to:

---
From 7f630d9bc5d6f692298fd906edd5f48070b257c7 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Thu, 16 Apr 2020 15:08:07 -0400
Subject: [PATCH] mm: memcontrol: convert page cache to a new
 mem_cgroup_charge() API

The try/commit/cancel protocol that memcg uses dates back to when
pages used to be uncharged upon removal from the page cache, and thus
couldn't be committed before the insertion had succeeded. Nowadays,
pages are uncharged when they are physically freed; it doesn't matter
whether the insertion was successful or not. For the page cache, the
transaction dance has become unnecessary.

Introduce a mem_cgroup_charge() function that simply charges a newly
allocated page to a cgroup and sets up page->mem_cgroup in one single
step. If the insertion fails, the caller doesn't have to do anything
but free/put the page.

Then switch the page cache over to this new API.

Subsequent patches will also convert anon pages, but it needs a bit
more prep work. Right now, memcg depends on page->mapping being
already set up at the time of charging, so that it can maintain its
own MEMCG_CACHE and MEMCG_RSS counters. For anon, page->mapping is set
under the same pte lock under which the page is publishd, so a single
charge point that can block doesn't work there just yet.

The following prep patches will replace the private memcg counters
with the generic vmstat counters, thus removing the page->mapping
dependency, then complete the transition to the new single-point
charge API and delete the old transactional scheme.

v2: leave shmem swapcache when charging fails to avoid double IO (Joonsoo)
v3: rebase on preceeding shmem simplification patch

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 include/linux/memcontrol.h | 10 ++++++
 mm/filemap.c               | 24 ++++++-------
 mm/memcontrol.c            | 29 +++++++++++++--
 mm/shmem.c                 | 73 ++++++++++++++++----------------------
 4 files changed, 77 insertions(+), 59 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 30292d57c8af..57339514d960 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -379,6 +379,10 @@ int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
 void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 			      bool lrucare);
 void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg);
+
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
+		      bool lrucare);
+
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
 
@@ -893,6 +897,12 @@ static inline void mem_cgroup_cancel_charge(struct page *page,
 {
 }
 
+static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
+				    gfp_t gfp_mask, bool lrucare)
+{
+	return 0;
+}
+
 static inline void mem_cgroup_uncharge(struct page *page)
 {
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index ce200386736c..ee9882509566 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -832,7 +832,6 @@ static int __add_to_page_cache_locked(struct page *page,
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
 	int huge = PageHuge(page);
-	struct mem_cgroup *memcg;
 	int error;
 	void *old;
 
@@ -840,17 +839,16 @@ static int __add_to_page_cache_locked(struct page *page,
 	VM_BUG_ON_PAGE(PageSwapBacked(page), page);
 	mapping_set_update(&xas, mapping);
 
-	if (!huge) {
-		error = mem_cgroup_try_charge(page, current->mm,
-					      gfp_mask, &memcg);
-		if (error)
-			return error;
-	}
-
 	get_page(page);
 	page->mapping = mapping;
 	page->index = offset;
 
+	if (!huge) {
+		error = mem_cgroup_charge(page, current->mm, gfp_mask, false);
+		if (error)
+			goto error;
+	}
+
 	do {
 		xas_lock_irq(&xas);
 		old = xas_load(&xas);
@@ -874,20 +872,18 @@ static int __add_to_page_cache_locked(struct page *page,
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
 
-	if (xas_error(&xas))
+	if (xas_error(&xas)) {
+		error = xas_error(&xas);
 		goto error;
+	}
 
-	if (!huge)
-		mem_cgroup_commit_charge(page, memcg, false);
 	trace_mm_filemap_add_to_page_cache(page);
 	return 0;
 error:
 	page->mapping = NULL;
 	/* Leave page->index set: truncation relies upon it */
-	if (!huge)
-		mem_cgroup_cancel_charge(page, memcg);
 	put_page(page);
-	return xas_error(&xas);
+	return error;
 }
 ALLOW_ERROR_INJECTION(__add_to_page_cache_locked, ERRNO);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 8188d462d7ce..1d45a09b334f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6578,6 +6578,33 @@ void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg)
 	cancel_charge(memcg, nr_pages);
 }
 
+/**
+ * mem_cgroup_charge - charge a newly allocated page to a cgroup
+ * @page: page to charge
+ * @mm: mm context of the victim
+ * @gfp_mask: reclaim mode
+ * @lrucare: page might be on the LRU already
+ *
+ * Try to charge @page to the memcg that @mm belongs to, reclaiming
+ * pages according to @gfp_mask if necessary.
+ *
+ * Returns 0 on success. Otherwise, an error code is returned.
+ */
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
+		      bool lrucare)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	VM_BUG_ON_PAGE(!page->mapping, page);
+
+	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
+	if (ret)
+		return ret;
+	mem_cgroup_commit_charge(page, memcg, lrucare);
+	return 0;
+}
+
 struct uncharge_gather {
 	struct mem_cgroup *memcg;
 	unsigned long pgpgout;
@@ -6625,8 +6652,6 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 {
 	VM_BUG_ON_PAGE(PageLRU(page), page);
-	VM_BUG_ON_PAGE(page_count(page) && !is_zone_device_page(page) &&
-			!PageHWPoison(page) , page);
 
 	if (!page->mem_cgroup)
 		return;
diff --git a/mm/shmem.c b/mm/shmem.c
index 729bbb3513cd..0d9615723152 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -605,11 +605,13 @@ static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
  */
 static int shmem_add_to_page_cache(struct page *page,
 				   struct address_space *mapping,
-				   pgoff_t index, void *expected, gfp_t gfp)
+				   pgoff_t index, void *expected, gfp_t gfp,
+				   struct mm_struct *charge_mm)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, compound_order(page));
 	unsigned long i = 0;
 	unsigned long nr = compound_nr(page);
+	int error;
 
 	VM_BUG_ON_PAGE(PageTail(page), page);
 	VM_BUG_ON_PAGE(index != round_down(index, nr), page);
@@ -621,6 +623,16 @@ static int shmem_add_to_page_cache(struct page *page,
 	page->mapping = mapping;
 	page->index = index;
 
+	error = mem_cgroup_charge(page, charge_mm, gfp, PageSwapCache(page));
+	if (error) {
+		if (!PageSwapCache(page) && PageTransHuge(page)) {
+			count_vm_event(THP_FILE_FALLBACK);
+			count_vm_event(THP_FILE_FALLBACK_CHARGE);
+		}
+		goto error;
+	}
+	cgroup_throttle_swaprate(page, gfp);
+
 	do {
 		void *entry;
 		xas_lock_irq(&xas);
@@ -648,12 +660,15 @@ static int shmem_add_to_page_cache(struct page *page,
 	} while (xas_nomem(&xas, gfp));
 
 	if (xas_error(&xas)) {
-		page->mapping = NULL;
-		page_ref_sub(page, nr);
-		return xas_error(&xas);
+		error = xas_error(&xas);
+		goto error;
 	}
 
 	return 0;
+error:
+	page->mapping = NULL;
+	page_ref_sub(page, nr);
+	return error;
 }
 
 /*
@@ -1619,7 +1634,6 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct mm_struct *charge_mm = vma ? vma->vm_mm : current->mm;
-	struct mem_cgroup *memcg;
 	struct page *page;
 	swp_entry_t swap;
 	int error;
@@ -1664,18 +1678,11 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 			goto failed;
 	}
 
-	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
-	if (error)
-		goto failed;
-
 	error = shmem_add_to_page_cache(page, mapping, index,
-					swp_to_radix_entry(swap), gfp);
-	if (error) {
-		mem_cgroup_cancel_charge(page, memcg);
+					swp_to_radix_entry(swap), gfp,
+					charge_mm);
+	if (error)
 		goto failed;
-	}
-
-	mem_cgroup_commit_charge(page, memcg, true);
 
 	spin_lock_irq(&info->lock);
 	info->swapped--;
@@ -1722,7 +1729,6 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo;
 	struct mm_struct *charge_mm;
-	struct mem_cgroup *memcg;
 	struct page *page;
 	enum sgp_type sgp_huge = sgp;
 	pgoff_t hindex = index;
@@ -1847,21 +1853,11 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		__SetPageReferenced(page);
 
-	error = mem_cgroup_try_charge_delay(page, charge_mm, gfp, &memcg);
-	if (error) {
-		if (PageTransHuge(page)) {
-			count_vm_event(THP_FILE_FALLBACK);
-			count_vm_event(THP_FILE_FALLBACK_CHARGE);
-		}
-		goto unacct;
-	}
 	error = shmem_add_to_page_cache(page, mapping, hindex,
-					NULL, gfp & GFP_RECLAIM_MASK);
-	if (error) {
-		mem_cgroup_cancel_charge(page, memcg);
+					NULL, gfp & GFP_RECLAIM_MASK,
+					charge_mm);
+	if (error)
 		goto unacct;
-	}
-	mem_cgroup_commit_charge(page, memcg, false);
 	lru_cache_add_anon(page);
 
 	spin_lock_irq(&info->lock);
@@ -2299,7 +2295,6 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	struct address_space *mapping = inode->i_mapping;
 	gfp_t gfp = mapping_gfp_mask(mapping);
 	pgoff_t pgoff = linear_page_index(dst_vma, dst_addr);
-	struct mem_cgroup *memcg;
 	spinlock_t *ptl;
 	void *page_kaddr;
 	struct page *page;
@@ -2349,16 +2344,10 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	if (unlikely(offset >= max_off))
 		goto out_release;
 
-	ret = mem_cgroup_try_charge_delay(page, dst_mm, gfp, &memcg);
-	if (ret)
-		goto out_release;
-
 	ret = shmem_add_to_page_cache(page, mapping, pgoff, NULL,
-						gfp & GFP_RECLAIM_MASK);
+				      gfp & GFP_RECLAIM_MASK, dst_mm);
 	if (ret)
-		goto out_release_uncharge;
-
-	mem_cgroup_commit_charge(page, memcg, false);
+		goto out_release;
 
 	_dst_pte = mk_pte(page, dst_vma->vm_page_prot);
 	if (dst_vma->vm_flags & VM_WRITE)
@@ -2379,11 +2368,11 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	ret = -EFAULT;
 	max_off = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
 	if (unlikely(offset >= max_off))
-		goto out_release_uncharge_unlock;
+		goto out_release_unlock;
 
 	ret = -EEXIST;
 	if (!pte_none(*dst_pte))
-		goto out_release_uncharge_unlock;
+		goto out_release_unlock;
 
 	lru_cache_add_anon(page);
 
@@ -2404,12 +2393,10 @@ static int shmem_mfill_atomic_pte(struct mm_struct *dst_mm,
 	ret = 0;
 out:
 	return ret;
-out_release_uncharge_unlock:
+out_release_unlock:
 	pte_unmap_unlock(dst_pte, ptl);
 	ClearPageDirty(page);
 	delete_from_page_cache(page);
-out_release_uncharge:
-	mem_cgroup_cancel_charge(page, memcg);
 out_release:
 	unlock_page(page);
 	put_page(page);
-- 
2.26.2

