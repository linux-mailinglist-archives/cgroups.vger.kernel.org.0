Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71D326F2BD
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgIRDBc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730504AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADBEC06121F
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p187so4065844ybg.14
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mgUvRZoNyo/y0AQ5WR2jz5tZr6t85cJbSfg1V582xDg=;
        b=WbBF/biWXWgsyfQrPFvQ3vxOo+han7gBPOKVDaDU4vJiFk4GkLPWtgi2/g3SIc6Sm4
         t3Uu+l1/J0OCujYFgUdgOOdQnLSuYKqjCbiVFAVL62xtqsR8AWYvU9xxCQbe5SNYfR7P
         6qKIYnW/Nq+bYrVKiO/ZRYqZ9sujtxhKeqHLelTrl4oSZWzPFumT+IwW1EXoRdnknys4
         9tdE11jEHtr50ERnioBOHFSTj/eepTvgUi5+qbGrY2XaOveyiAXErPRrap0CkToH0ECx
         xdvml7aQA0VQtDWIbFHHojN2KjO7YQ6KHO6zMR5goFxSrxt+PJ5zaHkJ1IMNTqEdb9d2
         DZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mgUvRZoNyo/y0AQ5WR2jz5tZr6t85cJbSfg1V582xDg=;
        b=jZgoyOQFW1pqYa/H0J8bDW8eMBAvagLyFIRh8d+oO5PGaG1c53XyZ2APf/cRe3a5Wb
         SPTlGMQjZErwBdbDwjEIP6dnm0IEmkHRk3xSkD5cKWf495oVOFrelSdmfZSuX6N+AkZf
         Ng/n+k7BAXe55JdlslUF2dOEapoAVrCf7iW1P7++P0PqwQeAHphdeau4Gk3t03qjRn0+
         n0zEowaywPBID8x5rmuHzDTK38wP/jtlYY8Cpjx5JSe9MABzOLa3AU0LLC4VgRbfYNCP
         +ZDl/ij/5l9ZuYERfwAZtBmtIHjyFkQNVoabATZ2ZHXod4gG/XNFNVdUclwj8yZsGYMA
         KytA==
X-Gm-Message-State: AOAM532BPfy5sP6+wyTd/F1+BBZKhIg3BU+ds5rXMHKeNHVBu3EYg/gK
        KXxAbNGIZ0F474xmpqPpzi8ppvslJcY=
X-Google-Smtp-Source: ABdhPJw/NMQTsr5clEF7UbuRxrpPr6jti09YZRwK5a69aAftHh4i/FzywDR2H/UoJQ1/f0Yitz79mnIXNPs=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:ad43:: with SMTP id l3mr28473720ybe.157.1600398069895;
 Thu, 17 Sep 2020 20:01:09 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:46 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-9-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 08/13] mm: rename page_off_lru() to __clear_page_lru_flags()
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

Rename the function according to what it really does. And make it
return void since the return value is not needed anymore.

If PageActive() and PageUnevictable() are both true, refuse to clear
either and leave them to bad_page().

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 29 ++++++++++-------------------
 mm/swap.c                 |  4 ++--
 mm/vmscan.c               |  2 +-
 3 files changed, 13 insertions(+), 22 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 03796021f0fe..ef3fd79222e5 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -61,28 +61,19 @@ static inline enum lru_list page_lru_base_type(struct page *page)
 }
 
 /**
- * page_off_lru - which LRU list was page on? clearing its lru flags.
- * @page: the page to test
- *
- * Returns the LRU list a page was on, as an index into the array of LRU
- * lists; and clears its Unevictable or Active flags, ready for freeing.
+ * __clear_page_lru_flags - clear page lru flags before releasing a page
+ * @page: the page that was on lru and now has a zero reference
  */
-static __always_inline enum lru_list page_off_lru(struct page *page)
+static __always_inline void __clear_page_lru_flags(struct page *page)
 {
-	enum lru_list lru;
-
 	__ClearPageLRU(page);
-	if (PageUnevictable(page)) {
-		__ClearPageUnevictable(page);
-		lru = LRU_UNEVICTABLE;
-	} else {
-		lru = page_lru_base_type(page);
-		if (PageActive(page)) {
-			__ClearPageActive(page);
-			lru += LRU_ACTIVE;
-		}
-	}
-	return lru;
+
+	/* this shouldn't happen, so leave the flags to bad_page() */
+	if (PageActive(page) && PageUnevictable(page))
+		return;
+
+	__ClearPageActive(page);
+	__ClearPageUnevictable(page);
 }
 
 /**
diff --git a/mm/swap.c b/mm/swap.c
index 8bbeabc582c1..b252f3593c57 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -87,7 +87,7 @@ static void __page_cache_release(struct page *page)
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
 		del_page_from_lru_list(page, lruvec);
-		page_off_lru(page);
+		__clear_page_lru_flags(page);
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
 }
@@ -887,7 +887,7 @@ void release_pages(struct page **pages, int nr)
 			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			del_page_from_lru_list(page, lruvec);
-			page_off_lru(page);
+			__clear_page_lru_flags(page);
 		}
 
 		list_add(&page->lru, &pages_to_free);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 47a4e8ba150f..d93033407200 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1862,7 +1862,7 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 
 		if (put_page_testzero(page)) {
 			del_page_from_lru_list(page, lruvec);
-			page_off_lru(page);
+			__clear_page_lru_flags(page);
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
-- 
2.28.0.681.g6f77f65b4e-goog

