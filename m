Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6927F26F2B4
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgIRDBS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730500AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF146C061356
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g189so3991498ybg.9
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4MOFrrHR2/UhZD8wnGs0ogWSv0e594oXOmpHs7V/Hlc=;
        b=Dw/BE/Q/G5v7r7p+x51pZfrNQwT6ly7+dXeOKeyFItGyUFUkIUvZVYbl/2GhRz9B5T
         4EDzpTx9xwcDSkMvD4RmnNW6/nCZcAjD1C8bv7jZeW3LHYuhVAjSofCxPTb/sJvrFqkb
         XaC9tNEde7FVCTlIR39u+GG4+ga57fTsfOXaPb6/W9TU9ebCZnKpGjfeQ0+KAajoU1V4
         JexNO6nH/0XLaMxu1Wzu0g7z/+KB3XTivJ8zth62HMCUc7HtsbWrnRg9q0BJU0Ku3RwP
         tTGf9lCuOhl4wZDotKm7LIyzwDkomMVN2j58x7knCFbS1f+ICgjaHXX+oFBr5j4R5VI0
         bqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4MOFrrHR2/UhZD8wnGs0ogWSv0e594oXOmpHs7V/Hlc=;
        b=AVOjjeqVLQ++o+89VcEGa0gL5TKHWsQ/p2ZvHpH5xzS318Nu2lURSfK/8J6cC7OvE+
         brp60HgaG73OmLsmuTO69ymf4hUL3l2y4vAlwOjAXl4pQpSPZjYe1woNazLIOkQ43rqW
         7KVFq4tce6jBGL9DIpn5qtGW9gnmBlDE4Ydind4JeS22Uf3mOVdx/EAqsRKiyNRr4+7j
         v6gdmvWqbrhT/nyrcpuSoMnrhjTaqmaRoLTQP3+y0r82djEZWW1x5Uhr1f/5w4Eh0178
         9o7A9TAzoMpCp6QjWYrnRcv7EuyZ2XXi0bI0RDyR9sueR/mBZpwpdCFml1ug3VACDc8M
         4c0w==
X-Gm-Message-State: AOAM5329nzblTN2QDLi89DilW28lfFYpl6ewDKzgWqvRADrgr2BkHf2i
        HFLyIwTA9qbBK9FmK1GCy2loP2j6HB0=
X-Google-Smtp-Source: ABdhPJyAJfQ43oGswfhp/4VcfkX+7z1s2wZn7/IZ4YurRAP4MdZ31Dvya5HTaLX6dy1NRUu80RMWCsW5Yos=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a5b:d09:: with SMTP id y9mr15575625ybp.258.1600398067055;
 Thu, 17 Sep 2020 20:01:07 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:44 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-7-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 06/13] mm: don't pass enum lru_list to trace_mm_lru_insertion()
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
from the struct page parameter by page_lru() correctly.

This change should have no side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/trace/events/pagemap.h | 11 ++++-------
 mm/swap.c                      |  5 +----
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/trace/events/pagemap.h b/include/trace/events/pagemap.h
index 8fd1babae761..e1735fe7c76a 100644
--- a/include/trace/events/pagemap.h
+++ b/include/trace/events/pagemap.h
@@ -27,24 +27,21 @@
 
 TRACE_EVENT(mm_lru_insertion,
 
-	TP_PROTO(
-		struct page *page,
-		int lru
-	),
+	TP_PROTO(struct page *page),
 
-	TP_ARGS(page, lru),
+	TP_ARGS(page),
 
 	TP_STRUCT__entry(
 		__field(struct page *,	page	)
 		__field(unsigned long,	pfn	)
-		__field(int,		lru	)
+		__field(enum lru_list,	lru	)
 		__field(unsigned long,	flags	)
 	),
 
 	TP_fast_assign(
 		__entry->page	= page;
 		__entry->pfn	= page_to_pfn(page);
-		__entry->lru	= lru;
+		__entry->lru	= page_lru(page);
 		__entry->flags	= trace_pagemap_flags(page);
 	),
 
diff --git a/mm/swap.c b/mm/swap.c
index 8d0e31d43852..3c89a7276359 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -962,7 +962,6 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 				 void *arg)
 {
-	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
 	int nr_pages = thp_nr_pages(page);
 
@@ -998,11 +997,9 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 	smp_mb__after_atomic();
 
 	if (page_evictable(page)) {
-		lru = page_lru(page);
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
-		lru = LRU_UNEVICTABLE;
 		ClearPageActive(page);
 		SetPageUnevictable(page);
 		if (!was_unevictable)
@@ -1010,7 +1007,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 	}
 
 	add_page_to_lru_list(page, lruvec);
-	trace_mm_lru_insertion(page, lru);
+	trace_mm_lru_insertion(page);
 }
 
 /*
-- 
2.28.0.681.g6f77f65b4e-goog

