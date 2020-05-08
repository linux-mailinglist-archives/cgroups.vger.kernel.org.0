Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D311CB9B4
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 23:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgEHVWk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgEHVWi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 17:22:38 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD72C05BD43
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 14:22:37 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 69so2268959pgd.14
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 14:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WB4fh0ll1orLfT6cXNAXpIF6IJgnNIJAflmvuUUH6tI=;
        b=ljlb+5JoPOLhwCwo/9ooaMm5dNWWqB4RKavWnR1bMTb4L6DZlaJkSQfWkg3sAAEQ0X
         UMnUuP9OvKrvFO2Zf1tnvuK0HExsQ2dYx49Deh2BpHI0OnP5ZatGHYAs8ZTI/yxrils3
         xzpe4ILlD48aErissngz/JZQjPXUgLkKPbNMlhHbgVIt6JvI2Qqhq9LILj81H24qLUpd
         2GqNHMP6geeEqMap9slI4hgNGU5PWE9SdVjpN1ZygLe6+JYzxYDnJcgw76g8ZJaiwYbx
         XGaBJ2xHrlPcPEipfB3nycm7Y2ZiWhkuNvSYmpS4fjdgG5Kmdhl2nIvXnPOUcLCgKgr5
         47gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WB4fh0ll1orLfT6cXNAXpIF6IJgnNIJAflmvuUUH6tI=;
        b=Fp6Y5UyZTdU6pJGHYtrHOWelhLQKG1IarhZZTJkUm+aLwWe/riX95YfPFfSiki3GkE
         gRWYDRwAw1vDwajmEvy1Chf6Ho58Fu3TioK67nbsCb2SGv/ASfZjviVYeWME5nevfigp
         uSO64a/jiR2FaHYB/bs9ksH7Q6iD/YlVq0wivgZNQCD8iulr+oEA1jTMQr1v/cPNlHzV
         XcTQAS2fOz6OxAoigt8j8GnFQ5G2W04MFfHe0g1UIKKQ0swmzq+l+KyXDLAk8yrlawSv
         H91vd2sgnp3KoTd+MkXsjPaHitOa7ewiBW3GgXTOrunf/SxRFyFmbfNOBUA0Ker8CE7S
         Kw4Q==
X-Gm-Message-State: AGi0Pub2IOr1KSQkWQSIZCywzj257tAdUjde+3MzL2ls/VvHmn4KuVjm
        noWaHJGZjFg9yiwrEunYYwV9IaEOR1fR1Q==
X-Google-Smtp-Source: APiQypLOtqKOw6qGIFJrdKSoiXSUY0c+iu42+pRBK9bHu2cCiYtB9/Zi/7+9qgttPV+xyxHeaRmrB0aXGe1j9A==
X-Received: by 2002:a17:90a:6f22:: with SMTP id d31mr7728053pjk.14.1588972956538;
 Fri, 08 May 2020 14:22:36 -0700 (PDT)
Date:   Fri,  8 May 2020 14:22:14 -0700
In-Reply-To: <20200508212215.181307-1-shakeelb@google.com>
Message-Id: <20200508212215.181307-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20200508212215.181307-1-shakeelb@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 2/3] mm: swap: memcg: fix memcg stats for huge pages
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit 2262185c5b28 ("mm: per-cgroup memory reclaim stats") added
PGLAZYFREE, PGACTIVATE & PGDEACTIVATE stats for cgroups but missed
couple of places and PGLAZYFREE missed huge page handling. Fix that.
Also for PGLAZYFREE use the irq-unsafe function to update as the irq is
already disabled.

Fixes: 2262185c5b28 ("mm: per-cgroup memory reclaim stats")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/swap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 3dbef6517cac..4eb179ee0b72 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -278,6 +278,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_lru(page);
 		int lru = page_lru_base_type(page);
+		int nr_pages = hpage_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec, lru);
 		SetPageActive(page);
@@ -285,7 +286,8 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec, lru);
 		trace_mm_lru_activate(page);
 
-		__count_vm_events(PGACTIVATE, hpage_nr_pages(page));
+		__count_vm_events(PGACTIVATE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
 		update_page_reclaim_stat(lruvec, file, 1);
 	}
 }
@@ -540,8 +542,10 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		__count_vm_events(PGROTATED, nr_pages);
 	}
 
-	if (active)
+	if (active) {
 		__count_vm_events(PGDEACTIVATE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
+	}
 	update_page_reclaim_stat(lruvec, file, 0);
 }
 
@@ -551,13 +555,15 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_lru(page);
 		int lru = page_lru_base_type(page);
+		int nr_pages = hpage_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		add_page_to_lru_list(page, lruvec, lru);
 
-		__count_vm_events(PGDEACTIVATE, hpage_nr_pages(page));
+		__count_vm_events(PGDEACTIVATE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
 		update_page_reclaim_stat(lruvec, file, 0);
 	}
 }
@@ -568,6 +574,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		bool active = PageActive(page);
+		int nr_pages = hpage_nr_pages(page);
 
 		del_page_from_lru_list(page, lruvec,
 				       LRU_INACTIVE_ANON + active);
@@ -581,8 +588,8 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 		ClearPageSwapBacked(page);
 		add_page_to_lru_list(page, lruvec, LRU_INACTIVE_FILE);
 
-		__count_vm_events(PGLAZYFREE, hpage_nr_pages(page));
-		count_memcg_page_event(page, PGLAZYFREE);
+		__count_vm_events(PGLAZYFREE, nr_pages);
+		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
 		update_page_reclaim_stat(lruvec, 1, 0);
 	}
 }
-- 
2.26.2.645.ge9eca65c58-goog

