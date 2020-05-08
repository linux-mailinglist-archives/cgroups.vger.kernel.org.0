Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EAD1CB9B5
	for <lists+cgroups@lfdr.de>; Fri,  8 May 2020 23:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgEHVWo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 8 May 2020 17:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgEHVWo (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 8 May 2020 17:22:44 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E02C061A0C
        for <cgroups@vger.kernel.org>; Fri,  8 May 2020 14:22:44 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id k10so10735147pjj.4
        for <cgroups@vger.kernel.org>; Fri, 08 May 2020 14:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+lPomwo6gVp+8sIw/I2u7q5nAUGKdenRSc6ButB2wWA=;
        b=Y/d3gs9c8fLWvNo8cv/JRlC7Gdv90wnQcNRlqk6pT0nZP3sUowsrJKLy1ajL1gCIKP
         BNUeVyKZcJBZjS+0eDdZFhjTK3KefN3ABh56eoNStvjd714RuGjuUnA3L4xeJIFNUkAY
         bO0mV9zYI5WmPppNa8u/mIKGLHCWC/TjhPqGsKKMVtsXjIEUy6r5sxDfnrG5LunrIWzK
         c4P45AcNlm8NzX8yWiwIltielavQyQsD9QYT1cC7LRok37X0rUT9i2vJ4vjVhIsWoAUZ
         ZCn8t+LqSaHTPehqaJHQ7MaZ0Cg0xB93YKJMmUk8rRApPNqqK1qZub7KUWVS80QT7IRV
         OJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+lPomwo6gVp+8sIw/I2u7q5nAUGKdenRSc6ButB2wWA=;
        b=RGFs+OSZhcpAMzql7AT6jMPy2ndYRfVZneemJW2+SCPRaWOLd6c0Lq6Km+6OEE1jiV
         RI1BGELfgnBMHF8IVMhm3NRW8GnpxRtnnAwW1V0vPl6ZVQVHCuGgk6i6ZaQnMC4W2+sh
         I4ulIBe0vIBrkF9fnojWF6TSF8O4JQeXUPOMA1ig2vS1xKb3g9dneZpkpbymi+GMmSOu
         TVH+IE9emL/LJ9AmkS46gkvWa+R+Xe7/70tabPMqLklWQ0aFfFShZiz2UP+x0hTSgiuu
         xcIKjT8o2qpP1OkQeANUArWukFuGY4tDKU+SDdMbW5qbc4EVm7VINRdB/unPB4BTMrLV
         nU7w==
X-Gm-Message-State: AGi0PuZN7z1yLWMLioG5KwjAlXU4635BoWhNb6N36i9NwNCOBupyRsht
        Zg4xA1CBNeGPNDyJdV/7Mu38k9Y11g2GvQ==
X-Google-Smtp-Source: APiQypJmqSHJBTT//7e2TqA5OSPQcmtaFbDDtkXqZeIJ65UCsh6cE8u40zY5RJjMUR0eep6ydcbTdiWgYEkrMw==
X-Received: by 2002:a63:f14b:: with SMTP id o11mr3831209pgk.429.1588972963716;
 Fri, 08 May 2020 14:22:43 -0700 (PDT)
Date:   Fri,  8 May 2020 14:22:15 -0700
In-Reply-To: <20200508212215.181307-1-shakeelb@google.com>
Message-Id: <20200508212215.181307-3-shakeelb@google.com>
Mime-Version: 1.0
References: <20200508212215.181307-1-shakeelb@google.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 3/3] mm: swap: fix update_page_reclaim_stat for huge pages
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

Currently update_page_reclaim_stat() updates the lruvec.reclaim_stats
just once for a page irrespective if a page is huge or not. Fix that by
passing the hpage_nr_pages(page) to it.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/swap.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 4eb179ee0b72..dc7297cb76a0 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -262,14 +262,14 @@ void rotate_reclaimable_page(struct page *page)
 	}
 }
 
-static void update_page_reclaim_stat(struct lruvec *lruvec,
-				     int file, int rotated)
+static void update_page_reclaim_stat(struct lruvec *lruvec, int file,
+				     int rotated, int nr_pages)
 {
 	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
 
-	reclaim_stat->recent_scanned[file]++;
+	reclaim_stat->recent_scanned[file] += nr_pages;
 	if (rotated)
-		reclaim_stat->recent_rotated[file]++;
+		reclaim_stat->recent_rotated[file] += nr_pages;
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec,
@@ -288,7 +288,7 @@ static void __activate_page(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGACTIVATE, nr_pages);
-		update_page_reclaim_stat(lruvec, file, 1);
+		update_page_reclaim_stat(lruvec, file, 1, nr_pages);
 	}
 }
 
@@ -546,7 +546,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 		__count_vm_events(PGDEACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
 	}
-	update_page_reclaim_stat(lruvec, file, 0);
+	update_page_reclaim_stat(lruvec, file, 0, nr_pages);
 }
 
 static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
@@ -564,7 +564,7 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGDEACTIVATE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_pages);
-		update_page_reclaim_stat(lruvec, file, 0);
+		update_page_reclaim_stat(lruvec, file, 0, nr_pages);
 	}
 }
 
@@ -590,7 +590,7 @@ static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
 
 		__count_vm_events(PGLAZYFREE, nr_pages);
 		__count_memcg_events(lruvec_memcg(lruvec), PGLAZYFREE, nr_pages);
-		update_page_reclaim_stat(lruvec, 1, 0);
+		update_page_reclaim_stat(lruvec, 1, 0, nr_pages);
 	}
 }
 
@@ -928,7 +928,7 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 	}
 
 	if (!PageUnevictable(page))
-		update_page_reclaim_stat(lruvec, file, PageActive(page_tail));
+		update_page_reclaim_stat(lruvec, file, PageActive(page_tail), 1);
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
@@ -973,7 +973,7 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
 	if (page_evictable(page)) {
 		lru = page_lru(page);
 		update_page_reclaim_stat(lruvec, page_is_file_lru(page),
-					 PageActive(page));
+					 PageActive(page), nr_pages);
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
 	} else {
-- 
2.26.2.645.ge9eca65c58-goog

