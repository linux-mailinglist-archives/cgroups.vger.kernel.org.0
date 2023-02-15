Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416A2697A0B
	for <lists+cgroups@lfdr.de>; Wed, 15 Feb 2023 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjBOKj4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 15 Feb 2023 05:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbjBOKjv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 15 Feb 2023 05:39:51 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F76360B4;
        Wed, 15 Feb 2023 02:39:49 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Vbk1bhe_1676457585;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vbk1bhe_1676457585)
          by smtp.aliyun-inc.com;
          Wed, 15 Feb 2023 18:39:46 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, sj@kernel.org, hannes@cmpxchg.org,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, naoya.horiguchi@nec.com,
        linmiaohe@huawei.com, david@redhat.com, osalvador@suse.de,
        mike.kravetz@oracle.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, damon@lists.linux.dev,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mm: change to return bool for folio_isolate_lru()
Date:   Wed, 15 Feb 2023 18:39:34 +0800
Message-Id: <8a4e3679ed4196168efadf7ea36c038f2f7d5aa9.1676424378.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
References: <cover.1676424378.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now the folio_isolate_lru() did not return a boolean value to indicate
isolation success or not, however below code checking the return value
can make people think that it was a boolean success/failure thing, which
makes people easy to make mistakes (see the fix patch[1]).

if (folio_isolate_lru(folio))
	continue;

Thus it's better to check the negative error value expilictly returned by
folio_isolate_lru(), which makes code more clear per Linus's suggestion[2].
Moreover Matthew suggested we can convert the isolation functions to return
a boolean[3], since most users did not care about the negative error value,
and can also remove the confusing of checking return value.

So this patch converts the folio_isolate_lru() to return a boolean value,
which means return 'true' to indicate the folio isolation is successful,
and 'false' means a failure to isolation. Meanwhile changing all users'
logic of checking the isolation state.

No functional changes intended.

[1] https://lore.kernel.org/all/20230131063206.28820-1-Kuan-Ying.Lee@mediatek.com/T/#u
[2] https://lore.kernel.org/all/CAHk-=wiBrY+O-4=2mrbVyxR+hOqfdJ=Do6xoucfJ9_5az01L4Q@mail.gmail.com/
[3] https://lore.kernel.org/all/Y+sTFqwMNAjDvxw3@casper.infradead.org/

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/damon/paddr.c  |  2 +-
 mm/folio-compat.c |  8 +++++++-
 mm/gup.c          |  2 +-
 mm/internal.h     |  2 +-
 mm/khugepaged.c   |  2 +-
 mm/madvise.c      |  4 ++--
 mm/mempolicy.c    |  2 +-
 mm/vmscan.c       | 10 +++++-----
 8 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b4df9b9bcc0a..607bb69e526c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -246,7 +246,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s)
 
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
-		if (folio_isolate_lru(folio)) {
+		if (!folio_isolate_lru(folio)) {
 			folio_put(folio);
 			continue;
 		}
diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 18c48b557926..540373cf904e 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -115,9 +115,15 @@ EXPORT_SYMBOL(grab_cache_page_write_begin);
 
 int isolate_lru_page(struct page *page)
 {
+	bool ret;
+
 	if (WARN_RATELIMIT(PageTail(page), "trying to isolate tail page"))
 		return -EBUSY;
-	return folio_isolate_lru((struct folio *)page);
+	ret = folio_isolate_lru((struct folio *)page);
+	if (ret)
+		return 0;
+
+	return -EBUSY;
 }
 
 void putback_lru_page(struct page *page)
diff --git a/mm/gup.c b/mm/gup.c
index b0885f70579c..eab18ba045db 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1939,7 +1939,7 @@ static unsigned long collect_longterm_unpinnable_pages(
 			drain_allow = false;
 		}
 
-		if (folio_isolate_lru(folio))
+		if (!folio_isolate_lru(folio))
 			continue;
 
 		list_add_tail(&folio->lru, movable_page_list);
diff --git a/mm/internal.h b/mm/internal.h
index dfb37e94e140..8645e8496537 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -188,7 +188,7 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
  * in mm/vmscan.c:
  */
 int isolate_lru_page(struct page *page);
-int folio_isolate_lru(struct folio *folio);
+bool folio_isolate_lru(struct folio *folio);
 void putback_lru_page(struct page *page);
 void folio_putback_lru(struct folio *folio);
 extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a5d32231bfad..cee659cfa3c1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2047,7 +2047,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 			goto out_unlock;
 		}
 
-		if (folio_isolate_lru(folio)) {
+		if (!folio_isolate_lru(folio)) {
 			result = SCAN_DEL_PAGE_LRU;
 			goto out_unlock;
 		}
diff --git a/mm/madvise.c b/mm/madvise.c
index 5a5a687d03c2..c2202f51e9dd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -406,7 +406,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
 		if (pageout) {
-			if (!folio_isolate_lru(folio)) {
+			if (folio_isolate_lru(folio)) {
 				if (folio_test_unevictable(folio))
 					folio_putback_lru(folio);
 				else
@@ -500,7 +500,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		folio_clear_referenced(folio);
 		folio_test_clear_young(folio);
 		if (pageout) {
-			if (!folio_isolate_lru(folio)) {
+			if (folio_isolate_lru(folio)) {
 				if (folio_test_unevictable(folio))
 					folio_putback_lru(folio);
 				else
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 0919c7a719d4..2751bc3310fd 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1033,7 +1033,7 @@ static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
 	 * expensive, so check the estimated mapcount of the folio instead.
 	 */
 	if ((flags & MPOL_MF_MOVE_ALL) || folio_estimated_sharers(folio) == 1) {
-		if (!folio_isolate_lru(folio)) {
+		if (folio_isolate_lru(folio)) {
 			list_add_tail(&folio->lru, foliolist);
 			node_stat_mod_folio(folio,
 				NR_ISOLATED_ANON + folio_is_file_lru(folio),
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 34535bbd4fe9..7658b40df947 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2337,12 +2337,12 @@ static unsigned long isolate_lru_folios(unsigned long nr_to_scan,
  * (2) The lru_lock must not be held.
  * (3) Interrupts must be enabled.
  *
- * Return: 0 if the folio was removed from an LRU list.
- * -EBUSY if the folio was not on an LRU list.
+ * Return: true if the folio was removed from an LRU list.
+ * false if the folio was not on an LRU list.
  */
-int folio_isolate_lru(struct folio *folio)
+bool folio_isolate_lru(struct folio *folio)
 {
-	int ret = -EBUSY;
+	bool ret = false;
 
 	VM_BUG_ON_FOLIO(!folio_ref_count(folio), folio);
 
@@ -2353,7 +2353,7 @@ int folio_isolate_lru(struct folio *folio)
 		lruvec = folio_lruvec_lock_irq(folio);
 		lruvec_del_folio(lruvec, folio);
 		unlock_page_lruvec_irq(lruvec);
-		ret = 0;
+		ret = true;
 	}
 
 	return ret;
-- 
2.27.0

