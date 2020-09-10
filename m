Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33426536A
	for <lists+cgroups@lfdr.de>; Thu, 10 Sep 2020 23:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIJVel (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 10 Sep 2020 17:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbgIJNt4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 10 Sep 2020 09:49:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962A0C061796;
        Thu, 10 Sep 2020 06:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8HnaJsrywNAsTbyAgR0uDLUkI/076f0nl1xcx0f5Xko=; b=AVDgGo0/6/PB8I5DLtMJL2binO
        pmOQFwK5wVGNZiNAEaWwYcL8vS/eMnTaPIZAY7mbv6nStP3R2yb3GXKw3Qof4jcmSlWeoHU+/82Bd
        0TBjzvJIvJc9SWg49AWb+7o7JjGt5K7abOf0Il9pg05LbGq1YrgXcbg2ZOL7iK1OafUcqQA5Oej0N
        Rzb00lRrkyeX+N9QqRfbzHBkWInN0t2a18twu+JQOaR6naObkQH/wPwnpfeKDHczznhDDNSnbqA1I
        Hp3PxF293vyIQQgKuyBlP0/cCZMpvlMZkU473U0yNovX0yMS07kGlvLPybyBzlNDYEBoRKOPENnzX
        TSCNEaRg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGMx1-0003DF-8H; Thu, 10 Sep 2020 13:49:23 +0000
Date:   Thu, 10 Sep 2020 14:49:23 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
        shy828301@gmail.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v18 06/32] mm/thp: narrow lru locking
Message-ID: <20200910134923.GR6583@casper.infradead.org>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
 <1598273705-69124-7-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598273705-69124-7-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 24, 2020 at 08:54:39PM +0800, Alex Shi wrote:
> lru_lock and page cache xa_lock have no reason with current sequence,
> put them together isn't necessary. let's narrow the lru locking, but
> left the local_irq_disable to block interrupt re-entry and statistic update.

What stats are you talking about here?

> +++ b/mm/huge_memory.c
> @@ -2397,7 +2397,7 @@ static void __split_huge_page_tail(struct page *head, int tail,
>  }
>  
>  static void __split_huge_page(struct page *page, struct list_head *list,
> -		pgoff_t end, unsigned long flags)
> +			      pgoff_t end)

Please don't change this whitespace.  It's really annoying having to
adjust the whitespace when renaming a function.  Just two tabs indentation
to give a clear separation of arguments from code is fine.


How about this patch instead?  It occurred to me we already have
perfectly good infrastructure to track whether or not interrupts are
already disabled, and so we should use that instead of ensuring that
interrupts are disabled, or tracking that ourselves.

But I may have missed something else that's relying on having
interrupts disabled.  Please check carefully.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2ccff8472cd4..74cae6c032f9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2376,17 +2376,16 @@ static void __split_huge_page_tail(struct page *head, int tail,
 }
 
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end, unsigned long flags)
+		pgoff_t end)
 {
 	struct page *head = compound_head(page);
 	pg_data_t *pgdat = page_pgdat(head);
 	struct lruvec *lruvec;
 	struct address_space *swap_cache = NULL;
 	unsigned long offset = 0;
+	unsigned long flags;
 	int i;
 
-	lruvec = mem_cgroup_page_lruvec(head, pgdat);
-
 	/* complete memcg works before add pages to LRU */
 	mem_cgroup_split_huge_fixup(head);
 
@@ -2395,9 +2394,13 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 		offset = swp_offset(entry);
 		swap_cache = swap_address_space(entry);
-		xa_lock(&swap_cache->i_pages);
+		xa_lock_irq(&swap_cache->i_pages);
 	}
 
+	/* prevent PageLRU to go away from under us, and freeze lru stats */
+	spin_lock_irqsave(&pgdat->lru_lock, flags);
+	lruvec = mem_cgroup_page_lruvec(head, pgdat);
+
 	for (i = HPAGE_PMD_NR - 1; i >= 1; i--) {
 		__split_huge_page_tail(head, i, lruvec, list);
 		/* Some pages can be beyond i_size: drop them from page cache */
@@ -2417,6 +2420,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 	}
 
 	ClearPageCompound(head);
+	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 
 	split_page_owner(head, HPAGE_PMD_ORDER);
 
@@ -2425,18 +2429,16 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 		/* Additional pin to swap cache */
 		if (PageSwapCache(head)) {
 			page_ref_add(head, 2);
-			xa_unlock(&swap_cache->i_pages);
+			xa_unlock_irq(&swap_cache->i_pages);
 		} else {
 			page_ref_inc(head);
 		}
 	} else {
 		/* Additional pin to page cache */
 		page_ref_add(head, 2);
-		xa_unlock(&head->mapping->i_pages);
+		xa_unlock_irq(&head->mapping->i_pages);
 	}
 
-	spin_unlock_irqrestore(&pgdat->lru_lock, flags);
-
 	remap_page(head);
 
 	for (i = 0; i < HPAGE_PMD_NR; i++) {
@@ -2574,7 +2576,6 @@ bool can_split_huge_page(struct page *page, int *pextra_pins)
 int split_huge_page_to_list(struct page *page, struct list_head *list)
 {
 	struct page *head = compound_head(page);
-	struct pglist_data *pgdata = NODE_DATA(page_to_nid(head));
 	struct deferred_split *ds_queue = get_deferred_split_queue(head);
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
@@ -2640,9 +2641,6 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 	unmap_page(head);
 	VM_BUG_ON_PAGE(compound_mapcount(head), head);
 
-	/* prevent PageLRU to go away from under us, and freeze lru stats */
-	spin_lock_irqsave(&pgdata->lru_lock, flags);
-
 	if (mapping) {
 		XA_STATE(xas, &mapping->i_pages, page_index(head));
 
@@ -2650,13 +2648,13 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 		 * Check if the head page is present in page cache.
 		 * We assume all tail are present too, if head is there.
 		 */
-		xa_lock(&mapping->i_pages);
+		xa_lock_irq(&mapping->i_pages);
 		if (xas_load(&xas) != head)
 			goto fail;
 	}
 
 	/* Prevent deferred_split_scan() touching ->_refcount */
-	spin_lock(&ds_queue->split_queue_lock);
+	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	count = page_count(head);
 	mapcount = total_mapcount(head);
 	if (!mapcount && page_ref_freeze(head, 1 + extra_pins)) {
@@ -2664,7 +2662,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			ds_queue->split_queue_len--;
 			list_del(page_deferred_list(head));
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 		if (mapping) {
 			if (PageSwapBacked(head))
 				__dec_node_page_state(head, NR_SHMEM_THPS);
@@ -2672,7 +2670,7 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 				__dec_node_page_state(head, NR_FILE_THPS);
 		}
 
-		__split_huge_page(page, list, end, flags);
+		__split_huge_page(page, list, end);
 		if (PageSwapCache(head)) {
 			swp_entry_t entry = { .val = page_private(head) };
 
@@ -2688,10 +2686,9 @@ int split_huge_page_to_list(struct page *page, struct list_head *list)
 			dump_page(page, "total_mapcount(head) > 0");
 			BUG();
 		}
-		spin_unlock(&ds_queue->split_queue_lock);
+		spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 fail:		if (mapping)
-			xa_unlock(&mapping->i_pages);
-		spin_unlock_irqrestore(&pgdata->lru_lock, flags);
+			xa_unlock_irq(&mapping->i_pages);
 		remap_page(head);
 		ret = -EBUSY;
 	}
