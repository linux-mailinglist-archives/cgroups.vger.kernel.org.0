Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970E524940F
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 06:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgHSE1p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 00:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHSE1m (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 00:27:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F96AC061389;
        Tue, 18 Aug 2020 21:27:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h21so16878775qtp.11;
        Tue, 18 Aug 2020 21:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=taoylAfZ50RvbeR+qDxRIBM5RKgvtzNS5VKzJspUyB8=;
        b=Z+DDR3MmkmAOpsWWDpyXeYNgIGzTgK9Ddb7UhBT/vJrDAZuGC7IlYskyQk03tzEygi
         hg0yvwJORukjN33wkxhvlIHH+zvaP6U6lypz2wcfStTBHY8CmTz2F7TgzrpOR/fJm1M7
         EFODaa5/wquuu3op5FFYJRBLf5S9RBmRBvBOB54DJqk3ofigrbivIJ1NXhgI5tnxk9EX
         VX77DTOK8ANaygFl9DWT0sOHN+dtc1RaB7H+Xn9h5/7jP/Epn+84BTlG6LRCCUFBnKKo
         Ikfqq6/wFEvz43BPxSR6OKSjvmmyvtPFx/O6FVNMW3b4ApIC1B4o5rqHt+Vy/0CELP6F
         R4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=taoylAfZ50RvbeR+qDxRIBM5RKgvtzNS5VKzJspUyB8=;
        b=FkVIOa3lJy5IAZXMidlFCtRVM6ZLQ++akq1rZhTeYsD//y1rvmrFuBkopfkZvFqFL7
         216f+92ElU/enL45RKgMKKIxMvL7hcAuGGin3IEvsrmcusYhSBc7MvhEUZ9TkgxTZBaK
         yZR91NCGtAjBptZiiiNesnHkKlYu2+mU0ML57l3mjRtbTZuroNpRCCbE8CSMSU8FB2Vb
         SZ0JRXXS5NhsNo8DVnKQ8HtaLNe0d4MCs/QmsxysaRybVe1yODtqnYtl98O/7zldByIZ
         0rTU3HgIRszek2071C6OkpMIDVnuCjU13INK5IFH6517K5wKcJO7UgAb7RSOKyU3/yFX
         K4Ag==
X-Gm-Message-State: AOAM5337EFZtOXCFAcFYrOxcg9cu634NtiPCzJohvHvFGWTM+pCY3HL5
        D6JBaAFEYZH4u3m0X7+aSlg=
X-Google-Smtp-Source: ABdhPJyDanWGHvp3JCIJhebJK8Z+qpciCv8gSBa8JKVjUZllBLCq+m9VK5Y9O/7JNh540/o4GxDybA==
X-Received: by 2002:ac8:5146:: with SMTP id h6mr21244001qtn.290.1597811261609;
        Tue, 18 Aug 2020 21:27:41 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id g129sm24061413qkb.39.2020.08.18.21.27.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 21:27:41 -0700 (PDT)
Subject: [RFC PATCH v2 5/5] mm: Split move_pages_to_lru into 3 separate
 passes
From:   Alexander Duyck <alexander.duyck@gmail.com>
To:     alex.shi@linux.alibaba.com
Cc:     yang.shi@linux.alibaba.com, lkp@intel.com, rong.a.chen@intel.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name, hughd@google.com,
        linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        daniel.m.jordan@oracle.com, linux-mm@kvack.org,
        shakeelb@google.com, willy@infradead.org, hannes@cmpxchg.org,
        tj@kernel.org, cgroups@vger.kernel.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com
Date:   Tue, 18 Aug 2020 21:27:38 -0700
Message-ID: <20200819042738.23414.60815.stgit@localhost.localdomain>
In-Reply-To: <20200819041852.23414.95939.stgit@localhost.localdomain>
References: <20200819041852.23414.95939.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

The current code for move_pages_to_lru is meant to release the LRU lock
every time it encounters an unevictable page or a compound page that must
be freed. This results in a fair amount of code bulk because the lruvec has
to be reacquired every time the lock is released and reacquired.

Instead of doing this I believe we can break the code up into 3 passes. The
first pass will identify the pages we can move to LRU and move those. In
addition it will sort the list out leaving the unevictable pages in the
list and moving those pages that have dropped to a reference count of 0 to
pages_to_free. The second pass will return the unevictable pages to the
LRU. The final pass will free any compound pages we have in the
pages_to_free list before we merge it back with the original list and
return from the function.

The advantage of doing it this way is that we only have to release the lock
between pass 1 and 2, and then we reacquire the lock after pass 3 after we
merge the pages_to_free back into the original list. As such we only have
to release the lock at most once in an entire call instead of having to
test to see if we need to relock with each page.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/vmscan.c |   68 ++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3ebe3f9b653b..6a2bdbc1a9eb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1850,22 +1850,21 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 {
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
-	struct page *page;
-	struct lruvec *orig_lruvec = lruvec;
+	struct page *page, *next;
 	enum lru_list lru;
 
-	while (!list_empty(list)) {
-		page = lru_to_page(list);
+	list_for_each_entry_safe(page, next, list, lru) {
 		VM_BUG_ON_PAGE(PageLRU(page), page);
-		list_del(&page->lru);
-		if (unlikely(!page_evictable(page))) {
-			if (lruvec) {
-				spin_unlock_irq(&lruvec->lru_lock);
-				lruvec = NULL;
-			}
-			putback_lru_page(page);
+
+		/*
+		 * if page is unevictable leave it on the list to be returned
+		 * to the LRU after we have finished processing the other
+		 * entries in the list.
+		 */
+		if (unlikely(!page_evictable(page)))
 			continue;
-		}
+
+		list_del(&page->lru);
 
 		/*
 		 * The SetPageLRU needs to be kept here for list intergrity.
@@ -1878,20 +1877,14 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		 *     list_add(&page->lru,)
 		 *                                        list_add(&page->lru,)
 		 */
-		lruvec = relock_page_lruvec_irq(page, lruvec);
 		SetPageLRU(page);
 
 		if (unlikely(put_page_testzero(page))) {
 			__ClearPageLRU(page);
 			__ClearPageActive(page);
 
-			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&lruvec->lru_lock);
-				lruvec = NULL;
-				destroy_compound_page(page);
-			} else
-				list_add(&page->lru, &pages_to_free);
-
+			/* defer freeing until we can release lru_lock */
+			list_add(&page->lru, &pages_to_free);
 			continue;
 		}
 
@@ -1904,16 +1897,33 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		if (PageActive(page))
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
-	if (orig_lruvec != lruvec) {
-		if (lruvec)
-			spin_unlock_irq(&lruvec->lru_lock);
-		spin_lock_irq(&orig_lruvec->lru_lock);
-	}
 
-	/*
-	 * To save our caller's stack, now use input list for pages to free.
-	 */
-	list_splice(&pages_to_free, list);
+	if (unlikely(!list_empty(list) || !list_empty(&pages_to_free))) {
+		spin_unlock_irq(&lruvec->lru_lock);
+
+		/* return any unevictable pages to the LRU list */
+		while (!list_empty(list)) {
+			page = lru_to_page(list);
+			list_del(&page->lru);
+			putback_lru_page(page);
+		}
+
+		/*
+		 * To save our caller's stack use input
+		 * list for pages to free.
+		 */
+		list_splice(&pages_to_free, list);
+
+		/* free any compound pages we have in the list */
+		list_for_each_entry_safe(page, next, list, lru) {
+			if (likely(!PageCompound(page)))
+				continue;
+			list_del(&page->lru);
+			destroy_compound_page(page);
+		}
+
+		spin_lock_irq(&lruvec->lru_lock);
+	}
 
 	return nr_moved;
 }

