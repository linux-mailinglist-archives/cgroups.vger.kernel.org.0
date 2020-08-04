Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BDD23B6DE
	for <lists+cgroups@lfdr.de>; Tue,  4 Aug 2020 10:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgHDIhP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 Aug 2020 04:37:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:48339 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726058AbgHDIhP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 Aug 2020 04:37:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U4jIqSF_1596530228;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U4jIqSF_1596530228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Aug 2020 16:37:08 +0800
Subject: Re: [PATCH v17 00/21] per memcg lru lock
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, shakeelb@google.com,
        iamjoonsoo.kim@lge.com, richard.weiyang@gmail.com,
        kirill@shutemov.name, alexander.duyck@gmail.com,
        rong.a.chen@intel.com, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Message-ID: <7622d74e-5884-4ee5-382d-78d6476db18a@linux.alibaba.com>
Date:   Tue, 4 Aug 2020 16:36:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From e2918c8fa741442255a2f12659f95dae94fdfe5d Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Sat, 1 Aug 2020 22:49:31 +0800
Subject: [PATCH 3/3] mm/swap.c: optimizing __pagevec_lru_add lru_lock

The current relock will unlock/lock lru_lock with every time lruvec
changes, so it would cause frequency relock if 2 memcgs are reading file
simultaneously.

This patch will record the involved lru_lock and only hold them once in
above scenario. That could reduce the lock contention.

Using per cpu data intead of local stack data to avoid repeatly
INIT_LIST_HEAD action.

[lkp@intel.com: found a build issue in the original patch, thanks]
Suggested-by: Konstantin Khlebnikov <koct9i@gmail.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/swap.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index d88a6c650a7c..e227fec6983c 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -72,6 +72,27 @@ static DEFINE_PER_CPU(struct lru_pvecs, lru_pvecs) = {
 	.lock = INIT_LOCAL_LOCK(lock),
 };
 
+struct pvlvs {
+	struct list_head lists[PAGEVEC_SIZE];
+	struct lruvec *vecs[PAGEVEC_SIZE];
+};
+static DEFINE_PER_CPU(struct pvlvs, pvlvs);
+
+static int __init pvlvs_init(void) {
+	int i, cpu;
+	struct pvlvs *pvecs;
+
+	for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		if (!cpu_possible(cpu))
+			continue;
+		pvecs = per_cpu_ptr(&pvlvs, cpu);
+		for (i = 0; i < PAGEVEC_SIZE; i++)
+			INIT_LIST_HEAD(&pvecs->lists[i]);
+	}
+	return 0;
+}
+subsys_initcall(pvlvs_init);
+
 /*
  * This path almost never happens for VM activity - pages are normally
  * freed via pagevecs.  But it gets used by networking.
@@ -963,18 +984,42 @@ static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec)
  */
 void __pagevec_lru_add(struct pagevec *pvec)
 {
-	int i;
+	int i, j, total = 0;
 	struct lruvec *lruvec = NULL;
 	unsigned long flags = 0;
+	struct page *page;
+	struct pvlvs *lvs = this_cpu_ptr(&pvlvs);
 
+	/* Sort the same lruvec pages on a list. */
 	for (i = 0; i < pagevec_count(pvec); i++) {
-		struct page *page = pvec->pages[i];
+		page = pvec->pages[i];
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
+		/* Try to find a same lruvec */
+		for (j = 0; j <= total; j++)
+			if (lruvec == lvs->vecs[j])
+				break;
+		/* A new lruvec */
+		if (j > total) {
+			lvs->vecs[total] = lruvec;
+			j = total;
+			total++;
+		}
 
-		lruvec = relock_page_lruvec_irqsave(page, lruvec, &flags);
-		__pagevec_lru_add_fn(page, lruvec);
+		list_add(&page->lru, &lvs->lists[j]);
 	}
-	if (lruvec)
-		unlock_page_lruvec_irqrestore(lruvec, flags);
+
+	for (i = 0; i < total; i++) {
+		spin_lock_irqsave(&lvs->vecs[i]->lru_lock, flags);
+		while (!list_empty(&lvs->lists[i])) {
+			page = lru_to_page(&lvs->lists[i]);
+			list_del(&page->lru);
+			__pagevec_lru_add_fn(page, lvs->vecs[i]);
+		}
+		spin_unlock_irqrestore(&lvs->vecs[i]->lru_lock, flags);
+		lvs->vecs[i] = NULL;
+	}
+
 	release_pages(pvec->pages, pvec->nr);
 	pagevec_reinit(pvec);
 }
-- 
1.8.3.1


