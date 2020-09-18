Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36726F2BC
	for <lists+cgroups@lfdr.de>; Fri, 18 Sep 2020 05:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgIRDBb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Sep 2020 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730506AbgIRDBR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Sep 2020 23:01:17 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD26C061223
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:13 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g1so3758315qtc.22
        for <cgroups@vger.kernel.org>; Thu, 17 Sep 2020 20:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JWU8yC6IA7OOmAjcclmLYHeJJ6Drguj19pPsyjDCDs0=;
        b=qy3asCDaCFhH2UckwoVpj1hLkwKFWdJ8Q5ketDmhYI3hL6mTuFwQvIqRDiOthDLcop
         PaTh5jl3tn3RExOoer2eQ1sA4CtBHf8RusyChtv3D0k48TiFbyxIhJyEXtCqHq/0n1xE
         3Yn8oq0MtIy5PWoW+p1Bq2LKE228TMBHdm2Q2e3ocu7wJuESMOzDPfmS1X2MYwdMtH0N
         /lhTVZtJPDrrqCIwW+Ymnxtxhor8zWXlnCdwoOxR8+e1hPcZXo/+sihZSJUl+SblRMo0
         nvdn+vCO4zY56L7FbvQlWb3v1qy4rUB83yS9VcoBBSfFkDeCenHZoAYK3FFf8xrMjl6h
         SWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JWU8yC6IA7OOmAjcclmLYHeJJ6Drguj19pPsyjDCDs0=;
        b=eEs2MsuIt/WycUH6o5x0zL+iQDRZi1kBK9121ZjfwBWYum6ZKYJPmQDqKTqXm7jaN4
         WgiUQRF+pS7Tw1otAEKZqMkyLVx8NAvWmOrz2w98YzWunP49IdP9B97yHkAsgo0sZ2sB
         nKrA+/YBIVyFYoDKgUkR+qF/lo2as48CVGWZUbH7X+LZZTT4PNNUr5aWbWQvwL5Fe7Oq
         Zcg30dr+tVdAFf+uTRl+NAlmL9baJ32YAxkW0EWKl0Qrk1ZRYQLPTLz3tTaKppyBf0lg
         DzOSEGKol0lijFwBp1J4GB9IfxULPDX9gbMAkdnypXvriPUm7X3+H2XbQsPX5MC9kbEE
         VWYA==
X-Gm-Message-State: AOAM530eZVfdySc2Ct95iG3xXMVchZLj/RUOjc2/jxjfVRVGJXIEuA2P
        Q263SXLv8sA69TW4mcmlvbuKk3ZKE1Y=
X-Google-Smtp-Source: ABdhPJxIHy/OXzjFuCpoj0u7VNt7iPcltg3BNZV0oXGBDUKbZUUYLhQqY4UiUR7CtG/Lm+IdXuWI6R/A+ec=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
 (user=yuzhao job=sendgmr) by 2002:ad4:5745:: with SMTP id q5mr31480391qvx.29.1600398072647;
 Thu, 17 Sep 2020 20:01:12 -0700 (PDT)
Date:   Thu, 17 Sep 2020 21:00:48 -0600
In-Reply-To: <20200918030051.650890-1-yuzhao@google.com>
Message-Id: <20200918030051.650890-11-yuzhao@google.com>
Mime-Version: 1.0
References: <20200918030051.650890-1-yuzhao@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [PATCH 10/13] mm: VM_BUG_ON lru page flags
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

Move scattered VM_BUG_ONs to two essential places that cover all
lru list additions and deletions.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/mm_inline.h | 4 ++++
 mm/swap.c                 | 2 --
 mm/vmscan.c               | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 07d9a0286635..7183c7a03f09 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -51,6 +51,8 @@ static __always_inline void update_lru_size(struct lruvec *lruvec,
  */
 static __always_inline void __clear_page_lru_flags(struct page *page)
 {
+	VM_BUG_ON_PAGE(!PageLRU(page), page);
+
 	__ClearPageLRU(page);
 
 	/* this shouldn't happen, so leave the flags to bad_page() */
@@ -72,6 +74,8 @@ static __always_inline enum lru_list page_lru(struct page *page)
 {
 	enum lru_list lru;
 
+	VM_BUG_ON_PAGE(PageActive(page) && PageUnevictable(page), page);
+
 	if (PageUnevictable(page))
 		return LRU_UNEVICTABLE;
 
diff --git a/mm/swap.c b/mm/swap.c
index b252f3593c57..4daa46907dd5 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -85,7 +85,6 @@ static void __page_cache_release(struct page *page)
 
 		spin_lock_irqsave(&pgdat->lru_lock, flags);
 		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		VM_BUG_ON_PAGE(!PageLRU(page), page);
 		del_page_from_lru_list(page, lruvec);
 		__clear_page_lru_flags(page);
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -885,7 +884,6 @@ void release_pages(struct page **pages, int nr)
 			}
 
 			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
-			VM_BUG_ON_PAGE(!PageLRU(page), page);
 			del_page_from_lru_list(page, lruvec);
 			__clear_page_lru_flags(page);
 		}
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d93033407200..4688e495c242 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4276,7 +4276,6 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 			continue;
 
 		if (page_evictable(page)) {
-			VM_BUG_ON_PAGE(PageActive(page), page);
 			del_page_from_lru_list(page, lruvec);
 			ClearPageUnevictable(page);
 			add_page_to_lru_list(page, lruvec);
-- 
2.28.0.681.g6f77f65b4e-goog

