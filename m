Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6FE24940D
	for <lists+cgroups@lfdr.de>; Wed, 19 Aug 2020 06:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgHSE1f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 19 Aug 2020 00:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHSE1e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 19 Aug 2020 00:27:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EEFC061389;
        Tue, 18 Aug 2020 21:27:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id p25so20556155qkp.2;
        Tue, 18 Aug 2020 21:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=5RYocxNjH/JuNLjY5mlxGXA5aUyyMf0iKZRCbtOnwVc=;
        b=uTztFXSyFhR+OqlR3qfbXh972QyhBGIQS57dnpJlCe8O8USD/B0vecgu2PDPSYgKLQ
         FH7u9ZEn/yjCqyfcU9tMUiZcj6IkFFDIauBIO7M3DLoyzlkO4UXhA/d89sksieOAIfUp
         OvPZZ/6AcVwrB6TF20v/UNVjUQyiGVpJNIVrSh7uxtzJUfn4Axb7rsU3cnSlphprgL86
         3mHT3A7y41n9L2sPVhTkqxGdOYHHqYUZfAzECqj2uDykgGUC0HHiWRWoQyG4fdBMezQp
         vPZxkPPpBxkPwUyrxX59CVv2keRH9keUcRf/hmOc+e4Kixb1yZdEgkaQ0fjWLae+b99P
         Xslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=5RYocxNjH/JuNLjY5mlxGXA5aUyyMf0iKZRCbtOnwVc=;
        b=ISJUsIT4FhuPR0F+2DlIcOFgq6NzySHHXOhleBFzxBwlV47kw+xCPlZrM7E3xC2LCB
         ShbV/I5DMSwAWwm1vwG8hezQGSjbrkAAuyhDKqfwi8UPtaibXfr5lZwaAEJijn/OjG+G
         1YXnpcnl2ghmP3R6fh51LL4P5X8RpIinzi4AdsVl8bWn68QGtuQ4m/IPrCnvA1THTx0F
         BtvESmL66Xd/0qzhYUphoD3R2+z9G73N1UG0MreEPbt828d/UVKf5uKqIlYXxueSlhtn
         r+1ISy9h/augK0b5tAoRX9UuVD1KD8d3Ap3t6hAaj4KVUno7cNkM4EjFn1pzc+G4W0fK
         AEGw==
X-Gm-Message-State: AOAM533p6A+UFNyEpiMgXeFwJw+CECQsyTW+DXW2yT40ubdpZUV9bcxD
        t7/kHQMAlLCty6knxpgwDic7caQJFjYVhw==
X-Google-Smtp-Source: ABdhPJxUUKPy8cTPbdHxNKJ42tPwCQ6Lf76LRyVq5ZadiUVAip+EDc39Tjp9mkEub1FXGbbEuTk89g==
X-Received: by 2002:a05:620a:1429:: with SMTP id k9mr19720876qkj.273.1597811253360;
        Tue, 18 Aug 2020 21:27:33 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id c33sm26752405qtk.40.2020.08.18.21.27.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Aug 2020 21:27:32 -0700 (PDT)
Subject: [RFC PATCH v2 4/5] mm: Split release_pages work into 3 passes
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
Date:   Tue, 18 Aug 2020 21:27:30 -0700
Message-ID: <20200819042730.23414.41309.stgit@localhost.localdomain>
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

The release_pages function has a number of paths that end up with the
LRU lock having to be released and reacquired. Such an example would be the
freeing of THP pages as it requires releasing the LRU lock so that it can
be potentially reacquired by __put_compound_page.

In order to avoid that we can split the work into 3 passes, the first
without the LRU lock to go through and sort out those pages that are not in
the LRU so they can be freed immediately from those that can't. The second
pass will then go through removing those pages from the LRU in batches as
large as a pagevec can hold before freeing the LRU lock. Once the pages have
been removed from the LRU we can then proceed to free the remaining pages
without needing to worry about if they are in the LRU any further.

The general idea is to avoid bouncing the LRU lock between pages and to
hopefully aggregate the lock for up to the full page vector worth of pages.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 mm/swap.c |  109 +++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 67 insertions(+), 42 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index fe53449fa1b8..b405f81b2c60 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -795,6 +795,54 @@ void lru_add_drain_all(void)
 }
 #endif
 
+static void __release_page(struct page *page, struct list_head *pages_to_free)
+{
+	if (PageCompound(page)) {
+		__put_compound_page(page);
+	} else {
+		/* Clear Active bit in case of parallel mark_page_accessed */
+		__ClearPageActive(page);
+		__ClearPageWaiters(page);
+
+		list_add(&page->lru, pages_to_free);
+	}
+}
+
+static void __release_lru_pages(struct pagevec *pvec,
+				struct list_head *pages_to_free)
+{
+	struct lruvec *lruvec = NULL;
+	unsigned long flags = 0;
+	int i;
+
+	/*
+	 * The pagevec at this point should contain a set of pages with
+	 * their reference count at 0 and the LRU flag set. We will now
+	 * need to pull the pages from their LRU lists.
+	 *
+	 * We walk the list backwards here since that way we are starting at
+	 * the pages that should be warmest in the cache.
+	 */
+	for (i = pagevec_count(pvec); i--;) {
+		struct page *page = pvec->pages[i];
+
+		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
+		VM_BUG_ON_PAGE(!PageLRU(page), page);
+		__ClearPageLRU(page);
+		del_page_from_lru_list(page, lruvec, page_off_lru(page));
+	}
+
+	unlock_page_lruvec_irqrestore(lruvec, flags);
+
+	/*
+	 * A batch of pages are no longer on the LRU list. Go through and
+	 * start the final process of returning the deferred pages to their
+	 * appropriate freelists.
+	 */
+	for (i = pagevec_count(pvec); i--;)
+		__release_page(pvec->pages[i], pages_to_free);
+}
+
 /**
  * release_pages - batched put_page()
  * @pages: array of pages to release
@@ -806,32 +854,24 @@ void lru_add_drain_all(void)
 void release_pages(struct page **pages, int nr)
 {
 	int i;
+	struct pagevec pvec;
 	LIST_HEAD(pages_to_free);
-	struct lruvec *lruvec = NULL;
-	unsigned long flags;
-	unsigned int lock_batch;
 
+	pagevec_init(&pvec);
+
+	/*
+	 * We need to first walk through the list cleaning up the low hanging
+	 * fruit and clearing those pages that either cannot be freed or that
+	 * are non-LRU. We will store the LRU pages in a pagevec so that we
+	 * can get to them in the next pass.
+	 */
 	for (i = 0; i < nr; i++) {
 		struct page *page = pages[i];
 
-		/*
-		 * Make sure the IRQ-safe lock-holding time does not get
-		 * excessive with a continuous string of pages from the
-		 * same lruvec. The lock is held only if lruvec != NULL.
-		 */
-		if (lruvec && ++lock_batch == SWAP_CLUSTER_MAX) {
-			unlock_page_lruvec_irqrestore(lruvec, flags);
-			lruvec = NULL;
-		}
-
 		if (is_huge_zero_page(page))
 			continue;
 
 		if (is_zone_device_page(page)) {
-			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-				lruvec = NULL;
-			}
 			/*
 			 * ZONE_DEVICE pages that return 'false' from
 			 * put_devmap_managed_page() do not require special
@@ -848,36 +888,21 @@ void release_pages(struct page **pages, int nr)
 		if (!put_page_testzero(page))
 			continue;
 
-		if (PageCompound(page)) {
-			if (lruvec) {
-				unlock_page_lruvec_irqrestore(lruvec, flags);
-				lruvec = NULL;
-			}
-			__put_compound_page(page);
+		if (!PageLRU(page)) {
+			__release_page(page, &pages_to_free);
 			continue;
 		}
 
-		if (PageLRU(page)) {
-			struct lruvec *prev_lruvec = lruvec;
-
-			lruvec = relock_page_lruvec_irqsave(page, lruvec,
-									&flags);
-			if (prev_lruvec != lruvec)
-				lock_batch = 0;
-
-			VM_BUG_ON_PAGE(!PageLRU(page), page);
-			__ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, page_off_lru(page));
+		/* record page so we can get it in the next pass */
+		if (!pagevec_add(&pvec, page)) {
+			__release_lru_pages(&pvec, &pages_to_free);
+			pagevec_reinit(&pvec);
 		}
-
-		/* Clear Active bit in case of parallel mark_page_accessed */
-		__ClearPageActive(page);
-		__ClearPageWaiters(page);
-
-		list_add(&page->lru, &pages_to_free);
 	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+
+	/* flush any remaining LRU pages that need to be processed */
+	if (pagevec_count(&pvec))
+		__release_lru_pages(&pvec, &pages_to_free);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);

