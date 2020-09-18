Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C0926F2C9
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRDCA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FA1C061352
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id q2so4067896ybo.5
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=w7mV5u1sVuL/HO4R09xmKV4wSajKsT9IQhDHQgEJXm8=;
        b=jDtcgyrhMdZDz3izu8b4buHaQnBHiMajkKbH5BTR5O+yM3vyEJzubaWXG3osf+PdiA
         WDIFMK6json2onX6FGRWm1wJFG4aJtqbEZCBQVMdTSxbX52x/ZxeUD6wCdCyTDvGF/W9
         fHAhr4VdkC62NlHfxA9LHTUU9ojRZZRXc5CuhbqCHj+hov8eLDeFR9CaHt3hVHuvQ3EI
         nHk9bPEOYH99f4NTwoV1jvoEj/cFFsoLfAAVtVtU6GcMuabk7KtE4Dcj35ROnppJCQWE
         SnaNaAP0OJYZNobndXx0RCrPNI28FP1PtuIeYR2ro2oXPWKjVJ4E9T8Pam52iDeW313A
         7nVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w7mV5u1sVuL/HO4R09xmKV4wSajKsT9IQhDHQgEJXm8=;
        b=OhOZKfIFp3S3Kd/fzqC6wPZmBVQwR2s3DrOrVPqWzPYxrB9F/wG2G38fQ+kWeaPyuL
         TFZuwJEesHUMKMyQ4iFUOgrMnbxtBNC5lePxh24bZQdd2H06LiLslOI+AOnBKeSlW6dH
         yiDhq4yzUYcL0R/LUnqQs9nlBWyA9u+9pe1OdZTWqXGVAXzHY+qII51e5MoJmz6cHMA/
         BFXK2kE7HFsQB/OI/LoNVrbrwixjkKoVmKa7eSc2iDOYoS8PaEUTpC6TeoRsyryuG8W3
         ApL+hhflAnhoK3TomOcbGnPIMWuTqESq+/68kQ4JlYVwlEmNiqRcANskOVY8QSc/U2G8
         bnxA==
X-Gm-Message-State: AOAM531Cj7ADfdw/nqUvyPu/uayQdrCYTJDMwbwF8xojdvLVWh5c39mK
        Cj4k2wq/hFBLe9btS87g9UKM51l81gI=
X-Google-Smtp-Source: ABdhPJxtkD2+YD/H021PF6gHpoN5EAhvy1+iGadjOw2IU9M8snsBGioGmQ4RZZk0fpZsAbdO7JC3AOTK8pI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a25:d848:: with SMTP id p69mr421664ybg.414.1600398064327;
 Thu, 17 Sep 2020 20:01:04 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:42 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-5-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 04/13] mm: shuffle lru list addition and deletion functions
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

This change should have no side effects.

We want it only because we prefer to avoid forward declarations in
the following patches.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 42 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index be9418425e41..bfa30c752804 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -45,27 +45,6 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
 #endif
 }
 
-static __always_inline void add_page_to_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
-{
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
-	list_add(&page->lru, &lruvec->lists[lru]);
-}
-
-static __always_inline void add_page_to_lru_list_tail(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
-{
-	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
-	list_add_tail(&page->lru, &lruvec->lists[lru]);
-}
-
-static __always_inline void del_page_from_lru_list(struct page *page,
-				struct lruvec *lruvec, enum lru_list lru)
-{
-	list_del(&page->lru);
-	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
-}
-
 /**
  * page_lru_base_type - which LRU list type should a page be on?
  * @page: the page to test
@@ -126,4 +105,25 @@ static __always_inline enum lru_list page_lru(struct page *page)
 	}
 	return lru;
 }
+
+static __always_inline void add_page_to_lru_list(struct page *page,
+				struct lruvec *lruvec, enum lru_list lru)
+{
+	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
+	list_add(&page->lru, &lruvec->lists[lru]);
+}
+
+static __always_inline void add_page_to_lru_list_tail(struct page *page,
+				struct lruvec *lruvec, enum lru_list lru)
+{
+	update_lru_size(lruvec, lru, page_zonenum(page), thp_nr_pages(page));
+	list_add_tail(&page->lru, &lruvec->lists[lru]);
+}
+
+static __always_inline void del_page_from_lru_list(struct page *page,
+				struct lruvec *lruvec, enum lru_list lru)
+{
+	list_del(&page->lru);
+	update_lru_size(lruvec, lru, page_zonenum(page), -thp_nr_pages(page));
+}
 #endif
-- 
2.28.0.681.g6f77f65b4e-goog

