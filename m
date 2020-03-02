Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03EEB1758E7
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2020 12:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgCBLBc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Mar 2020 06:01:32 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:51939 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727659AbgCBLBL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Mar 2020 06:01:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0TrR9JWI_1583146862;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrR9JWI_1583146862)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Mar 2020 19:01:02 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
To:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 19/20] mm/lru: add debug checking for page memcg moving
Date:   Mon,  2 Mar 2020 19:00:29 +0800
Message-Id: <1583146830-169516-20-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This debug patch could give some clues if there are sth out of
consideration.

Hugh Dickins reported a bug of this patch, Thanks!

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/memcontrol.h |  6 ++++++
 mm/compaction.c            |  2 ++
 mm/memcontrol.c            | 15 +++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f60009580d2a..27c7bbe82125 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -431,6 +431,8 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page,
 void unlock_page_lruvec_irq(struct lruvec *lruvec);
 void unlock_page_lruvec_irqrestore(struct lruvec *lruvec, unsigned long flags);
 
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page);
+
 static inline
 struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 	return css ? container_of(css, struct mem_cgroup, css) : NULL;
@@ -1191,6 +1193,10 @@ static inline void count_memcg_page_event(struct page *page,
 void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 {
 }
+
+static inline void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 /* idx can be of type enum memcg_stat_item or node_stat_item */
diff --git a/mm/compaction.c b/mm/compaction.c
index 4a773f0ffedf..40c270bd5092 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -984,6 +984,8 @@ static bool too_many_isolated(pg_data_t *pgdat)
 			compact_lock_irqsave(&lruvec->lru_lock, &flags, cc);
 			locked_lruvec = lruvec;
 
+			lruvec_memcg_debug(lruvec, page);
+
 			/* Try get exclusive access under lock */
 			if (!skip_updated) {
 				skip_updated = true;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 099926efbb48..2d71e53ead88 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1240,6 +1240,19 @@ struct lruvec *mem_cgroup_page_lruvec(struct page *page, struct pglist_data *pgd
 	return lruvec;
 }
 
+void lruvec_memcg_debug(struct lruvec *lruvec, struct page *page)
+{
+#ifdef CONFIG_DEBUG_VM
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!page->mem_cgroup)
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != root_mem_cgroup, page);
+	else
+		VM_BUG_ON_PAGE(lruvec_memcg(lruvec) != page->mem_cgroup, page);
+#endif
+}
+
 /* page must be isolated */
 struct lruvec *lock_page_lruvec_irq(struct page *page)
 {
@@ -1248,6 +1261,7 @@ struct lruvec *lock_page_lruvec_irq(struct page *page)
 	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 	spin_lock_irq(&lruvec->lru_lock);
 
+	lruvec_memcg_debug(lruvec, page);
 	return lruvec;
 }
 
@@ -1258,6 +1272,7 @@ struct lruvec *lock_page_lruvec_irqsave(struct page *page, unsigned long *flags)
 	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	lruvec_memcg_debug(lruvec, page);
 	return lruvec;
 }
 
-- 
1.8.3.1

