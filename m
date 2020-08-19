Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2073924A63C
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgHSStP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgHSStH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 14:49:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A89EC061757;
        Wed, 19 Aug 2020 11:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=SFuii2T6WPhgcSR/n6o4MUthReftxuKz6bFegDk7V6Y=; b=fHiweH4xvcHxBZBo/Hs4Zh/x8q
        IOR/lnZgsQ40NMoRAkmTBSFUeWvZ+BhxiVYwvmJ6/Pq6aCH0ZcHkN4WQpVwHrbcFgnTPrMOR5ZG+2
        sb+yfADxrEVowOqFCkiUp4DXUwwrI2Aoz5w+0Ps1J3NhxsPfFcad6NmL7IL38er0SZfwH6JR7ji29
        hGF/hfcvukAn8t3r6FgFgVC4LRBRJHcWoDjO9oczio+FTlp8gZq5Lyn6eyhG8b1Bik8v4IiSoW96m
        g4sKNy+aJq94mEab3qR1Xgw19wyvZ83QaPb2dmDmI8OXMdf9Fl7fauESRq9u9FzhI8WObi5xkFtEh
        ACKe314Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T8p-0006Tz-Hr; Wed, 19 Aug 2020 18:48:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] mm: Convert find_get_entry to return the head page
Date:   Wed, 19 Aug 2020 19:48:48 +0100
Message-Id: <20200819184850.24779-7-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200819184850.24779-1-willy@infradead.org>
References: <20200819184850.24779-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are only three callers remaining of find_get_entry().
find_get_swap_page() is happy to get the head page instead of the subpage.
Add find_subpage() calls to find_lock_entry() and pagecache_get_page()
to avoid auditing all their callers.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h |  4 ++--
 mm/filemap.c            | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 7de11dcd534d..8261c64f592d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -384,8 +384,8 @@ static inline struct page *find_subpage(struct page *head, pgoff_t index)
 	return head + (index & (thp_nr_pages(head) - 1));
 }
 
-struct page *find_get_entry(struct address_space *mapping, pgoff_t offset);
-struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset);
+struct page *find_get_entry(struct address_space *mapping, pgoff_t index);
+struct page *find_lock_entry(struct address_space *mapping, pgoff_t index);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 			  unsigned int nr_entries, struct page **entries,
 			  pgoff_t *indices);
diff --git a/mm/filemap.c b/mm/filemap.c
index 36067cf7f8c5..5a87e1bdddd6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1547,19 +1547,19 @@ EXPORT_SYMBOL(page_cache_prev_miss);
 /**
  * find_get_entry - find and get a page cache entry
  * @mapping: the address_space to search
- * @offset: the page cache index
+ * @index: The page cache index.
  *
  * Looks up the page cache slot at @mapping & @offset.  If there is a
- * page cache page, it is returned with an increased refcount.
+ * page cache page, the head page is returned with an increased refcount.
  *
  * If the slot holds a shadow entry of a previously evicted page, or a
  * swap entry from shmem/tmpfs, it is returned.
  *
- * Return: the found page or shadow entry, %NULL if nothing is found.
+ * Return: The head page or shadow entry, %NULL if nothing is found.
  */
-struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
+struct page *find_get_entry(struct address_space *mapping, pgoff_t index)
 {
-	XA_STATE(xas, &mapping->i_pages, offset);
+	XA_STATE(xas, &mapping->i_pages, index);
 	struct page *page;
 
 	rcu_read_lock();
@@ -1587,7 +1587,6 @@ struct page *find_get_entry(struct address_space *mapping, pgoff_t offset)
 		put_page(page);
 		goto repeat;
 	}
-	page = find_subpage(page, offset);
 out:
 	rcu_read_unlock();
 
@@ -1624,6 +1623,7 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
 			put_page(page);
 			goto repeat;
 		}
+		page = find_subpage(page, offset);
 		VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
 	}
 	return page;
@@ -1670,6 +1670,7 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 		page = NULL;
 	if (!page)
 		goto no_page;
+	page = find_subpage(page, index);
 
 	if (fgp_flags & FGP_LOCK) {
 		if (fgp_flags & FGP_NOWAIT) {
-- 
2.28.0

