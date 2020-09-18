Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1393226F2CB
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbgIRDCB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730499AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A494DC061355
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:06 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id a26so3774414qtb.16
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d0N2YNozj8FzBRJ6VQ0c28ZpuzKJvjKqya/hyG9SAss=;
        b=GcBDKNFKsQeNSxhucTO0XJtY/nmuVgnmcwBGZjjhLtbAo/zHl78n+uIqOAXYw9Atc2
         pdBj2q0PrqGhK1Ax5dmJkf52ecZq9oeG+d7hhc7Km/9ULwndyEN71/Sp6nzSoF9OJ2uT
         6RCcKmhioRolb9jXu/oG1FZ5rEfVtyYOqNEq+2KJucS4VlNaZPGnnPDCr2yqdyDB7fbE
         Yq6jZ6dXmC2gQJD7V0OJijyJIwBud4vVWs+1RP6zyvs+1u0C51lB52kJylZvoFmG8jrr
         eCsSvRygARZuZZSx0mbpyPtpKOIdYDZj0pxHwox19Ko02Pa2BfamshM6dlvj+QQIxJ7o
         pAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d0N2YNozj8FzBRJ6VQ0c28ZpuzKJvjKqya/hyG9SAss=;
        b=Bql/wRYKXYiZXk9leBUr4S7GAGQx34ao3iviJjl07d7Hvk9iVG1/p9a/tL/69i0FmM
         spaFoVHfu+5NZ8CK6wnL9h2QlrQ/jWswReOi+SG4Vxd/HnwyvYQIulkT4EmuHjCU7HVc
         4nfQh2wwKrZ/LXUlStAn0JdSbcq075oDPzifWVBkHoCu1GW4KN0P/uYppNurz7BuRazd
         FFONuaOuXcACqfdRjoh5/wzJBUHQFgFavu4BxXSlpfRde7dxJdIuebVg4UiMaNdCvj3h
         a9YqTfI/YYOtbauP3oGv7zEUCfDcQGn9uS0laq7Q/DXL83EHi/jKD8UpmPh4QOrdZOKc
         rHzQ==
X-Gm-Message-State: AOAM532tk2uOqmmF+nuxblFdAQBPAnS1sX/72CV7CD6l1uKdMDpp6HcY
        Kgd+W9NMeyQR7oonybKL4UZoxKR214I=
X-Google-Smtp-Source: ABdhPJzCIN4MKgnxw+rBMXtIM13RkiIS+ijRbe2ZJA5M0lfk1sXC0F2KMwBDWUmal8mHOzCBeFjmgh3GjjE=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:ad4:5745:: with SMTP id q5mr31479962qvx.29.1600398065725;
 Thu, 17 Sep 2020 20:01:05 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:43 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 05/13] mm: don't pass enum lru_list to lru list addition functions
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Huang Ying <ying.huang@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The enum lru_list parameter to add_page_to_lru_list() and
add_page_to_lru_list_tail() is redundant in the sense that it can
be extracted from the struct page parameter by page_lru().

A caveat is that we need to make sure PageActive() or
PageUnevictable() is correctly set or cleared before calling
these two functions. And they are indeed.

This change should have no side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h |  8 ++++++--
 mm/swap.c                 | 18 ++++++++----------
 mm/vmscan.c               |  6 ++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index bfa30c752804..199ff51bf2a0 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -107,15 +107,19 @@ static __always_inline enum lru_list page_lru(struct page *page)
 }
 
 static __always_inline void add_page_to_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
+				struct lruvec *lruvec)
 {
+	enum lru_list lru = page_lru(page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add(&page->lru, &lruvec->lists[lru]);
 }
 
 static __always_inline void add_page_to_lru_list_tail(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
+				struct lruvec *lruvec)
 {
+	enum lru_list lru = page_lru(page);
+
 	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
 	list_add_tail(&page->lru, &lruvec->lists[lru]);
 }
diff --git a/mm/swap.c b/mm/swap.c
index 8362083f00c9..8d0e31d43852 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -238,7 +238,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && !PageUnevictable(page)) {
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
-		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
+		add_page_to_lru_list_tail(page, lruvec);
 		(*pgmoved) += thp_nr_pages(page);
 	}
 }
@@ -322,8 +322,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 
 		del_page_from_lru_list(page, lruvec, lru);
 		SetPageActive(page);
-		lru += LRU_ACTIVE;
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 		trace_mm_lru_activate(page);
 
 		__count_vm_events(PGACTIVATE, nr_pages);
@@ -555,14 +554,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		 * It can make readahead confusing.  But race window
 		 * is _really_ small and  it's non-critical problem.
 		 */
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 		SetPageReclaim(page);
 	} else {
 		/*
 		 * The page's writeback ends up during pagevec
 		 * We moves tha page into tail of inactive.
 		 */
-		add_page_to_lru_list_tail(page, lruvec, lru);
+		add_page_to_lru_list_tail(page, lruvec);
 		__count_vm_events(PGROTATED, nr_pages);
 	}
 
@@ -583,7 +582,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 
 		__count_vm_events(PGDEACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE,
@@ -609,7 +608,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 		 * anonymous pages
 		 */
 		ClearPageSwapBacked(page);
-		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
+		add_page_to_lru_list(page, lruvec);
 
 		__count_vm_events(PGLAZYFREE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE,
@@ -955,8 +954,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 		 * Put page_tail on the list at the correct position
 		 * so they all end up in order.
 		 */
-		add_page_to_lru_list_tail(page_tail, lruvec,
-					  page_lru(page_tail));
+		add_page_to_lru_list_tail(page_tail, lruvec);
 	}
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -1011,7 +1009,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 			__count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
 	}
 
-	add_page_to_lru_list(page, lruvec, lru);
+	add_page_to_lru_list(page, lruvec);
 	trace_mm_lru_insertion(page, lru);
 }
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f9a186a96410..895be9fb96ec 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1859,7 +1859,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 
 		SetPageLRU(page);
-		add_page_to_lru_list(page, lruvec, lru);
+		add_page_to_lru_list(page, lruvec);
 
 		if (put_page_testzero(page)) {
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
@@ -4276,12 +4276,10 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 			continue;
 
 		if (page_evictable(page)) {
-			enum lru_list lru = page_lru_base_type(page);
-
 			VM_BUG_ON_PAGE(PageActive(page), page);
 			ClearPageUnevictable(page);
 			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
-			add_page_to_lru_list(page, lruvec, lru);
+			add_page_to_lru_list(page, lruvec);
 			pgrescued++;
 		}
 	}
-- 
2.28.0.681.g6f77f65b4e-goog

