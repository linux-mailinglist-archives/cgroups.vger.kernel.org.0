Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65ABC26F2C3
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgIRDBo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730507AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1544AC061220
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g1so3758249qtc.22
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=b85d06LSJeBa6rsJlkkKw7JSUKETD4Y77r+y+YRUjRk=;
        b=cWN5izs+aaUKIykYldczEGDmX7RVsvXEViMXNM8ddq7IeJUErvEZ7YdO38E4AFWwxP
         YEGT0mKVWONgbxqp+r4pTV4D1WwdDlqTrABmb6KVFHS5OFMTLKY2UEzRGM+vL7hhdhKx
         IaQIzDSeHjmyce1otEEqrqDyv6uST3U5GfHz2sDAE1s8kXR5cjQj4EETNK69mu8yGn9j
         GvzZfTkNo0CzoDjDLYHYJ8I5KsS2eGdRS+qV0OiiRKfOB1pppqA28sk9tyOGnxQxSwcr
         G+u1NzRVk46Muag854KLQHKD6YgqmcxLbkzWgPIt4r7DV7v+ZaC3USwXXEuUreUOuKSI
         IIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b85d06LSJeBa6rsJlkkKw7JSUKETD4Y77r+y+YRUjRk=;
        b=GPh5LnRUttC5vfqNfBYwfFD2U/MEf4Zv7EYTCWwXfiFlwNTZwzqsJ2nYcSui/N6MMA
         fVgFvcPy3PjRL9MehWIoZY825BwCmiR+t2018ACbnkb8h/VJY5PRcwzxPpn+X2G0O3YK
         hPhbLEnfeu1rSmxSUsnuJ4l25kYzKZviWk5xz8bmLkO1v0LU4euSgsAxRtg4wjFFSfOY
         9PljCpTTXFC1/0HBitaS4i0msX+l4bJ4suO0ZiaS0l5kBqJEeqBAXQnYRi5gbgP2yvYe
         dKCA876+cy8FNyd5sYz7nGBGKE/jd+UqwM12J2CvvcnRCTx5QPYJFvWgicL5/OaHvIJX
         XpLg==
X-Gm-Message-State: AOAM532yDLRz6zQ4T82GFqQdqKGz6u3vBOa1t92h4lQ0AvKPGXGJy5Tn
        DQOzrB4IrFdFZv0Te/5aYdkZm31eGFY=
X-Google-Smtp-Source: ABdhPJx+hjixMwDHpA9umqu4pgWDN6Xi+UKbNRpq8JuDRKAm+QSAwliVY3yAQF3K3VTtyDo+SOcVYv9cqh0=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a0c:e6ea:: with SMTP id m10mr15321673qvn.53.1600398071234;
 Thu, 17 Sep 2020 20:01:11 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:47 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-10-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 09/13] mm: inline page_lru_base_type()
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

We've removed all other references to this function.

This change should have no side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index ef3fd79222e5..07d9a0286635 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -45,21 +45,6 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
 #endif
 }
 
-/**
- * page_lru_base_type - which LRU list type should a page be on?
- * @page: the page to test
- *
- * Used for LRU list index arithmetic.
- *
- * Returns the base LRU type - file or anon - @page should be on.
- */
-static inline enum lru_list page_lru_base_type(struct page *page)
-{
-	if (page_is_file_lru(page))
-		return LRU_INACTIVE_FILE;
-	return LRU_INACTIVE_ANON;
-}
-
 /**
  * __clear_page_lru_flags - clear page lru flags before releasing a page
  * @page: the page that was on lru and now has a zero reference
@@ -88,12 +73,12 @@ static __always_inline enum lru_list page_lru(struct page *page)
 	enum lru_list lru;
 
 	if (PageUnevictable(page))
-		lru = LRU_UNEVICTABLE;
-	else {
-		lru = page_lru_base_type(page);
-		if (PageActive(page))
-			lru += LRU_ACTIVE;
-	}
+		return LRU_UNEVICTABLE;
+
+	lru = page_is_file_lru(page) ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON;
+	if (PageActive(page))
+		lru += LRU_ACTIVE;
+
 	return lru;
 }
 
-- 
2.28.0.681.g6f77f65b4e-goog

