Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9766526F2BF
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgIRDBd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D05C06121D
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:09 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id a14so3799476qtp.15
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m9SV8To9giQpZ6vlTURw1wnUtOeRuWbkRD6idl4rWic=;
        b=I56cheOdKpadMiISI8D3cG12+YcWjTwNmGhUtTv6Hp9t9gRU4RRdYiIHsk/0jFXmyH
         cWLQJMpbcUAEISgmwVnWJRx8Pu5moOnRNObl8NrzMuG10t1uEVB/oDN6VbizahrHeDXp
         s5DdATUvkw8bZSQsKZpXhor/grLA+VmtK7Fwrpwgeoaj5Fi/6zRjPs29QE5WD+Qp3mjC
         0c0DuuFKEYWQ4Bq4OBTGv1YstJIngd3P3uXY4KZulaz6XmM9C7zeHzTpFORS90uJ1AE2
         MaMtBpBIKEb6OZ8KhFdnhm/F2mMDsPCbQpvQAsSnjz1u8pqDrunMQS6E4nbchxMKsV23
         YXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m9SV8To9giQpZ6vlTURw1wnUtOeRuWbkRD6idl4rWic=;
        b=Z14oQ0Uwk2q8B97MencLh8bVSEdXd98w3tq4lfVfjk56pqZKpiPdiNa60VRP9ZTFSA
         uhPc4KsPh0zfTw70A+mPOJAAJh/UvUIKL2qetpN5V4gymJJIPBLLaIt5wF2rh6pMhEf4
         fWlW2PyFUhzre0kcJ/RnR+yQwUqxBXyEH6tOSkQ1eYb5zbjCcpugTISBXqEFaSqOOZam
         j+YV5gT1K69B/ShCdGvIt17dtvcFLZE1n/dSJ2a2gMmPxO5JnhiTwrADMdjiGCg89sPv
         mXC6aC8Dy5bgixRwRyHL/Y3r7+GDz2uYGShqqG1mpeRQt0IoxBfbV1TwbpdqaCHKflaU
         SxUg==
X-Gm-Message-State: AOAM532saiS6KKTM7MkWbVL+5Ku37NvC+0mCJk4W85Oj/ecoQbkphMFb
        PNSbXbiO58HthrtNXIcZZbcRl0fp/eg=
X-Google-Smtp-Source: ABdhPJxSJ6H+qBap6jb3jm+pH6Y0Qsceyc8/VfY7SdRpbY0psSRlj8jZwDgLG/bk2SjMsAhDHvZHEM0GqJw=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a0c:c407:: with SMTP id r7mr15393093qvi.36.1600398068453;
 Thu, 17 Sep 2020 20:01:08 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:45 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-8-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 07/13] mm: don't pass enum lru_list to del_page_from_lru_list()
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

The parameter is redundant in the sense that it can be extracted
from the struct page parameter by page_lru().

To do this, we need to make sure PageActive() or PageUnevictable()
is correctly set or cleared before calling the function. In
check_move_unevictable_pages(), we have:
	ClearPageUnevictable()
	del_page_from_lru_list(lru_list = LRU_UNEVICTABLE)

And we need to reorder them to make page_lru() return
LRU_UNEVICTABLE:
	del_page_from_lru_list()
		page_lru()
	ClearPageUnevictable()

We also need to deal with the deletions on releasing paths that
clear PageLRU() and PageActive()/PageUnevictable():
	del_page_from_lru_list(lru_list = page_off_lru())

It's done by another recording like this:
	del_page_from_lru_list()
		page_lru()
	page_off_lru()

In both cases, the recording should have no side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h |  5 +++--
 mm/compaction.c           |  2 +-
 mm/mlock.c                |  2 +-
 mm/swap.c                 | 26 ++++++++++----------------
 mm/vmscan.c               |  8 ++++----
 5 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 199ff51bf2a0..03796021f0fe 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -125,9 +125,10 @@ static __always_inline void add_page_to_lru_list_tail(struct page *page,
 }
 
 static __always_inline void del_page_from_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
+				struct lruvec *lruvec)
 {
 	list_del(&page->lru);
-	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
+	update_lru_size(lruvec, page_lru(page), page_zonenum(page),
+			-thp_nr_pages(page));
 }
 #endif
diff --git a/mm/compaction.c b/mm/compaction.c
index 176dcded298e..ec4af21d2867 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1006,7 +1006,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 			low_pfn += compound_nr(page) - 1;
 
 		/* Successfully isolated */
-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		del_page_from_lru_list(page, lruvec);
 		mod_node_page_state(page_pgdat(page),
 				NR_ISOLATED_ANON + page_is_file_lru(page),
 				thp_nr_pages(page));
diff --git a/mm/mlock.c b/mm/mlock.c
index 93ca2bf30b4f..647487912d0a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -114,7 +114,7 @@ static bool __munlock_isolate_lru_page(struct page *page, bool getpage)
 		if (getpage)
 			get_page(page);
 		ClearPageLRU(page);
-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		del_page_from_lru_list(page, lruvec);
 		return true;
 	}
 
diff --git a/mm/swap.c b/mm/swap.c
index 3c89a7276359..8bbeabc582c1 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -86,7 +86,8 @@ static void __page_cache_release(struct page *page)
 		spin_lock_irqsave(&pgdat->lru_lock, flags);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
-		del_page_from_lru_list(page, lruvec, page_off_lru(page));
+		del_page_from_lru_list(page, lruvec);
+		page_off_lru(page);
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
 }
@@ -236,7 +237,7 @@ static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
 	int *pgmoved = arg;
 
 	if (PageLRU(page) && !PageUnevictable(page)) {
-		del_page_from_lru_list(page, lruvec, page_lru(page));
+		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec);
 		(*pgmoved) += thp_nr_pages(page);
@@ -317,10 +318,9 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
-		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec, lru);
+		del_page_from_lru_list(page, lruvec);
 		SetPageActive(page);
 		add_page_to_lru_list(page, lruvec);
 		trace_mm_lru_activate(page);
@@ -527,8 +527,7 @@ void lru_cache_add_inactive_or_unevictable(struct page *page,
 static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 			      void *arg)
 {
-	int lru;
-	bool active;
+	bool active = PageActive(page);
 	int nr_pages = thp_nr_pages(page);
 
 	if (!PageLRU(page))
@@ -541,10 +540,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	if (page_mapped(page))
 		return;
 
-	active = PageActive(page);
-	lru = page_lru_base_type(page);
-
-	del_page_from_lru_list(page, lruvec, lru + active);
+	del_page_from_lru_list(page, lruvec);
 	ClearPageActive(page);
 	ClearPageReferenced(page);
 
@@ -576,10 +572,9 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 			    void *arg)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
-		int lru = page_lru_base_type(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
+		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		add_page_to_lru_list(page, lruvec);
@@ -595,11 +590,9 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
-		bool active = PageActive(page);
 		int nr_pages = thp_nr_pages(page);
 
-		del_page_from_lru_list(page, lruvec,
-				       LRU_INACTIVE_ANON + active);
+		del_page_from_lru_list(page, lruvec);
 		ClearPageActive(page);
 		ClearPageReferenced(page);
 		/*
@@ -893,7 +886,8 @@ void release_pages(struct page **pages, int nr)
 
 			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
-			del_page_from_lru_list(page, lruvec, page_off_lru(page));
+			del_page_from_lru_list(page, lruvec);
+			page_off_lru(page);
 		}
 
 		list_add(&page->lru, &pages_to_free);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 895be9fb96ec..47a4e8ba150f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1770,10 +1770,9 @@ int isolate_lru_page(struct page *page)
 		spin_lock_irq(&pgdat->lru_lock);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		if (PageLRU(page)) {
-			int lru = page_lru(page);
 			get_page(page);
 			ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, lru);
+			del_page_from_lru_list(page, lruvec);
 			ret = 0;
 		}
 		spin_unlock_irq(&pgdat->lru_lock);
@@ -1862,7 +1861,8 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec);
 
 		if (put_page_testzero(page)) {
-			del_page_from_lru_list(page, lruvec, page_off_lru(page));
+			del_page_from_lru_list(page, lruvec);
+			page_off_lru(page);
 
 			if (unlikely(PageCompound(page))) {
 				spin_unlock_irq(&pgdat->lru_lock);
@@ -4277,8 +4277,8 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 
 		if (page_evictable(page)) {
 			VM_BUG_ON_PAGE(PageActive(page), page);
+			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
-			del_page_from_lru_list(page, lruvec, LRU_UNEVICTABLE);
 			add_page_to_lru_list(page, lruvec);
 			pgrescued++;
 		}
-- 
2.28.0.681.g6f77f65b4e-goog

