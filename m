Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1032A63B9
	for <lists+cgroups@lfdr.de>; Wed,  4 Nov 2020 12:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKDL5d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Nov 2020 06:57:33 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:40491 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728841AbgKDLzq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Nov 2020 06:55:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UED0xNV_1604490939;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UED0xNV_1604490939)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Nov 2020 19:55:39 +0800
Subject: Re: [PATCH v20 00/20] per memcg lru lock
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
References: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <811216d4-4972-4721-d6b9-1028c02f4290@linux.alibaba.com>
Date:   Wed, 4 Nov 2020 19:55:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1603968305-8026-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Johannes & all,

Thanks for all comments and suggestions, here is a patch base on v20, as a summary for all you suggested:
Is this ok?

Many thanks!
Alex

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0c97292834fa..0fe4172c8c14 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -20,6 +20,9 @@
  * Lockless page tracking & accounting
  * Unified hierarchy configuration model
  * Copyright (C) 2015 Red Hat, Inc., Johannes Weiner
+ *
+ * Per memcg lru locking
+ * Copyright (C) 2020 Alibaba, Inc, Alex Shi
  */

 #include <linux/page_counter.h>
@@ -1380,6 +1383,14 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
        return lruvec;
 }

+/**
+ * lock_page_lruvec - return lruvec for the locked page.
+ * @page: the page
+ *
+ * This series functions should be used in either conditions:
+ * PageLRU is cleared or unset
+ * or, page->_refcount is zero
+ */
 struct lruvec *lock_page_lruvec(struct page *page)
 {
        struct lruvec *lruvec;
diff --git a/mm/swap.c b/mm/swap.c
index 9fe5ff9a8111..bcc814de35c4 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -264,6 +264,13 @@ void lru_note_cost(struct lruvec *lruvec, bool file, unsigned int nr_pages)
        do {
                unsigned long lrusize;

+               /*
+                * Hold lruvec->lru_lock is safe here, since
+                * 1) The pinned lruvec in reclaim, or
+                * 2) From a pre-LRU page during refault (which also holds the
+                *    rcu lock, so would be safe even if the page was on the LRU
+                *    and could move simultaneously to a new lruvec).
+                */
                spin_lock_irq(&lruvec->lru_lock);
                /* Record cost event */
                if (file)
@@ -355,10 +362,12 @@ static void activate_page(struct page *page)
        struct lruvec *lruvec;

        page = compound_head(page);
-       lruvec = lock_page_lruvec_irq(page);
-       if (PageLRU(page))
+       if (TestClearPageLRU(page)) {
+               lruvec = lock_page_lruvec_irq(page);
                __activate_page(page, lruvec);
-       unlock_page_lruvec_irq(lruvec);
+               unlock_page_lruvec_irq(lruvec);
+               SetPageLRU(page);
+       }
 }
 #endif

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 7ed10ade548d..af03a7f2e1b8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1868,6 +1868,10 @@ static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
                        continue;
                }

+               /*
+                * All pages were isolated from the same lruvec (and isolation
+                * inhibits memcg migration).
+                */
                VM_BUG_ON_PAGE(!lruvec_holds_page_lru_lock(page, lruvec), page);
                lru = page_lru(page);
                nr_pages = thp_nr_pages(page);

