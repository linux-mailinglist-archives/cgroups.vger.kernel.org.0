Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699EF26F2CE
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgIRDCK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgIRDBQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:16 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2062C061797
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:03 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id j35so3796872qtk.14
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xgnYESlnPAgRXuNmUoKIpEseoXbDWRNbcLBaliwt4oc=;
        b=JUmupfA4wraNNkt/3nQDRoRaUfUY18y3RzYhZnq0DDiJXlYJesex9t/1/0moJHN7v0
         50pxg0398VUNoS2zmL94S71EK7TP61x8/Q7FBsofCF2wC7NulxTKKH3hMdhR7nFOJ/PC
         uki9yZgG4KT9CzoqHNwgC7l7OkUR4FkQCLaBZwHr0QORR/rpMHGg/TdJWwEZCAtCS+8e
         4b1oC3cA+Trzzm0/dv8Wx+97jp+3a3DAAkgXb8OwFXgLmTQBqSbxgIv/X9QFjfhX+pRs
         K0DivOWlJ0PQTVXSvOGXUPE5sMtcoED2ZmrCJl1b9tqjC20mjmwqKnURY63+3efkm+wG
         BY+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xgnYESlnPAgRXuNmUoKIpEseoXbDWRNbcLBaliwt4oc=;
        b=BNcXX6WGDaAzec/hzj5ygHLWxTBaCNYV4ayQQjBvKJ8APewT7Qv/qcjwkK9ubA0VNx
         eg8s9N2JKM/xb7PLscyZD9sAK8enT3KH4TmbYkYNIICzdXVIUwxO/n8PV8I/2qTSrKwn
         btcVyqKlu7NqMGHXU3FNrUfAKjHt+PCMDdeQ3arBzmmzhSojK29eXFJvGlGklMiKA9ca
         BDyfSKkURdWmJBoxQRQWXsZDPE1Wtglim/n8tdv+opdodjXD7uOaVIt1SS0fjhzEIEph
         dSFxWFMZJ14x1EFez8EL9bu0A+fwGkA4vzlnV+FdiLbRtXDMs0Iicen3DJ7ldj3f9/q5
         y9pw==
X-Gm-Message-State: AOAM533cv4HNkOkhwtFoyMOQAXVBhaRBLQWwGs/TwNd9v6cHKedK4SZR
        05vdTKOAqbnfwWCtLmlDHpzIm7DNNfw=
X-Google-Smtp-Source: ABdhPJxi2d5rBcjBpXGVEN33YSeJpIGsvVd5FHEOFm+6Zvu+65+brOoWC+mQWMQVotpkrxRGOx14mPFQ4PA=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:a05:6214:a6c:: with SMTP id
 ef12mr32117792qvb.14.1600398062849; Thu, 17 Sep 2020 20:01:02 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:41 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-4-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 03/13] mm: move __ClearPageLRU() into page_off_lru()
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

Now we have a total of three places that free lru pages when their
references become zero (after we drop the reference from isolation).

Before this patch, they all do:
	__ClearPageLRU()
	page_off_lru()
	del_page_from_lru_list()

After this patch, they become:
	page_off_lru()
		__ClearPageLRU()
	del_page_from_lru_list()

This change should have no side effects.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 1 +
 mm/swap.c                 | 2 --
 mm/vmscan.c               | 1 -
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 8fc71e9d7bb0..be9418425e41 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -92,6 +92,7 @@ static __always_inline enum lru_list page_off_lru(struct page *page)
 {
 	enum lru_list lru;
 
+	__ClearPageLRU(page);
 	if (PageUnevictable(page)) {
 		__ClearPageUnevictable(page);
 		lru = LRU_UNEVICTABLE;
diff --git a/mm/swap.c b/mm/swap.c
index 40bf20a75278..8362083f00c9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -86,7 +86,6 @@ static void __page_cache_release(struct page *page)
 		spin_lock_irqsave(&pgdat->lru_lock, flags);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		VM_BUG_ON_PAGE(!PageLRU(page), page);
-		__ClearPageLRU(page);
 		del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
 	}
@@ -895,7 +894,6 @@ void release_pages(struct page **pages, int nr)
 
 			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
 			VM_BUG_ON_PAGE(!PageLRU(page), page);
-			__ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 		}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f257d2f61574..f9a186a96410 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1862,7 +1862,6 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
 		add_page_to_lru_list(page, lruvec, lru);
 
 		if (put_page_testzero(page)) {
-			__ClearPageLRU(page);
 			del_page_from_lru_list(page, lruvec, page_off_lru(page));
 
 			if (unlikely(PageCompound(page))) {
-- 
2.28.0.681.g6f77f65b4e-goog

