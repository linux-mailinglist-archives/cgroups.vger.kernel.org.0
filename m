Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C224124FE4F
	for <lists+cgroups@lfdr.de>; Mon, 24 Aug 2020 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHXMzY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 24 Aug 2020 08:55:24 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:36100 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbgHXMzW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 24 Aug 2020 08:55:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U6k9-bl_1598273712;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U6k9-bl_1598273712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 24 Aug 2020 20:55:18 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com, mhocko@suse.com,
        vdavydov.dev@gmail.com, shy828301@gmail.com
Subject: [PATCH v18 14/32] mm/lru: move lru_lock holding in func lru_note_cost_page
Date:   Mon, 24 Aug 2020 20:54:47 +0800
Message-Id: <1598273705-69124-15-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1598273705-69124-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

It's a clean up patch w/o function changes.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c       | 2 ++
 mm/workingset.c | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 4eea95a4286f..906255db6006 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -298,8 +298,10 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
 
 void lru_note_cost_page(struct page *page)
 {
+	spin_lock_irq(&page_pgdat(page)->lru_lock);
 	lru_note_cost(mem_cgroup_page_lruvec(page, page_pgdat(page)),
 		      page_is_file_lru(page), thp_nr_pages(page));
+	spin_unlock_irq(&page_pgdat(page)->lru_lock);
 }
 
 static void __activate_page(struct page *page, struct lruvec *lruvec)
diff --git a/mm/workingset.c b/mm/workingset.c
index 92e66113a577..32e24cda1b4f 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -381,9 +381,7 @@ void workingset_refault(struct page *page, void *shadow)
 	if (workingset) {
 		SetPageWorkingset(page);
 		/* XXX: Move to lru_cache_add() when it supports new vs putback */
-		spin_lock_irq(&page_pgdat(page)->lru_lock);
 		lru_note_cost_page(page);
-		spin_unlock_irq(&page_pgdat(page)->lru_lock);
 		inc_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file);
 	}
 out:
-- 
1.8.3.1

