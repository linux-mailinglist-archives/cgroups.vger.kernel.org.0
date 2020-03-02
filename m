Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5166D1758EC
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 12:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgCBLBI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 06:01:08 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60412 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727510AbgCBLBH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 06:01:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrRUeZ0_1583146860;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrRUeZ0_1583146860)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:01:00 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v9 15/20] mm/mlock: optimize munlock_pagevec by relocking
Date:   Mon,  2 Mar 2020 19:00:25 +0800
Message-Id: <1583146830-169516-16-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

During the pagevec locking, a new page's lruvec is may same as
previous one. Thus we could save a re-locking, and only
change lock iff lruvec is newer.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 mm/mlock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index d285348b147e..236a29b791f4 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -281,6 +281,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	int nr = pagevec_count(pvec);
 	int delta_munlocked = -nr;
 	struct pagevec pvec_putback;
+	struct lruvec *lruvec = NULL;
 	int pgrescued = 0;
 
 	pagevec_init(&pvec_putback);
@@ -288,7 +289,6 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 	/* Phase 1: page isolation */
 	for (i = 0; i < nr; i++) {
 		struct page *page = pvec->pages[i];
-		struct lruvec *lruvec;
 
 		if (!TestClearPageMlocked(page)) {
 			delta_munlocked++;
@@ -305,9 +305,8 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		 * We already have pin from follow_page_mask()
 		 * so we can spare the get_page() here.
 		 */
-		lruvec = lock_page_lruvec_irq(page);
+		lruvec = relock_page_lruvec_irq(page, lruvec);
 		del_page_from_lru_list(page, lruvec, page_lru(page));
-		unlock_page_lruvec_irq(lruvec);
 		continue;
 
 		/*
@@ -320,6 +319,8 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 		pagevec_add(&pvec_putback, pvec->pages[i]);
 		pvec->pages[i] = NULL;
 	}
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 	__mod_zone_page_state(zone, NR_MLOCK, delta_munlocked);
 
 	/* Now we can release pins of pages that we are not munlocking */
-- 
1.8.3.1

