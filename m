Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDD653232B
	for <lists+cgroups@lfdr.de>; Tue, 24 May 2022 08:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbiEXG1y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 May 2022 02:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235022AbiEXG1w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 May 2022 02:27:52 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3D695DDE
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:42 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 31so15521926pgp.8
        for <cgroups@vger.kernel.org>; Mon, 23 May 2022 23:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4QIRjaHJeiHbHgGHewQVJI5rixr5jafar8TUaLFgWA=;
        b=MkCTHNsxUNBMErlaDCUFDA8ek9BRW+c1NG6n7H9gxyOA2KBsh++mlxbHmVlgRQXAON
         wvVeQGECKUuL2Py5+B7jUql9VwKcy287DQOLCPZJhDIBHWfNSk2OipPfzEyRNGouNdJX
         3TJ7C6xANQxgkGQlsnWVvRiUlyeFR2U4oiozTqrQOSfpykGln3SFiPDydFQOlnVsU77I
         0A47+5k3HyNlKjGZLkGkxq1lpjQh0d5uscl1GKB80laEELcMf5YaqYc+R0gwP3lx+Fqx
         A+5X6VDGns5zFewPT8ut4ZfqX2MWolvowSpMiv4xLng/W887aOhxY7yntiIcWLOnL+rk
         nxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C4QIRjaHJeiHbHgGHewQVJI5rixr5jafar8TUaLFgWA=;
        b=AKlCW1tkH4uKfC/eEBITZrStJju5mfSpNNY8winQA67+jeJqSsc8K547a+QF/w79B+
         4/ZC+oiqTagMTYGIA1HADWwiQLSNoG2iVIwaWa3nJ+W8pmmHB4iQF3+DdkYdqN5HdH2+
         ZOaI56SLBvvFFwGn91Oi711M1/fjSWYhEY0jet5wv6LhWyFBYIA3OIs5mt6kOdVqSZn6
         +nfZu0leWowV464BJETXKohMSRb44pyYrke5Lm0p0ymY3U49ye/VKGIbnn2RZC/AFxDm
         IgfJ8gsiuoMW0dScv9MxtoCNF/G4PyrqzUp+aoONm3c0So9O+XwAisgJHbsOhPhX/lYx
         FF3w==
X-Gm-Message-State: AOAM530uZnxmk8sU20frfTAqhutgUhrcLVbI8R6CAjLgWn0EpW2POAph
        uJpuVJyCLTpwdEh3YUH+BlPOVw==
X-Google-Smtp-Source: ABdhPJxRnJODI5LFjdRDbVjSWigQvz3LogjzZlyMVA5cK9WUh3QvAyB3wQNtKrYi6SKeFqyIERSv8A==
X-Received: by 2002:a63:5625:0:b0:3db:55dd:37ae with SMTP id k37-20020a635625000000b003db55dd37aemr22489609pgb.611.1653373662140;
        Mon, 23 May 2022 23:27:42 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:f940:af17:c2f5:8656])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902f54500b0016168e90f2dsm6254455plf.219.2022.05.23.23.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:27:41 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 04/11] mm: vmscan: rework move_pages_to_lru()
Date:   Tue, 24 May 2022 14:05:44 +0800
Message-Id: <20220524060551.80037-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220524060551.80037-1-songmuchun@bytedance.com>
References: <20220524060551.80037-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

In the later patch, we will reparent the LRU pages. The pages moved to
appropriate LRU list can be reparented during the process of the
move_pages_to_lru(). So holding a lruvec lock by the caller is wrong, we
should use the more general interface of folio_lruvec_relock_irq() to
acquire the correct lruvec lock.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/vmscan.c | 49 +++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..761d5e0dd78d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2230,23 +2230,28 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
  * move_pages_to_lru() moves pages from private @list to appropriate LRU list.
  * On return, @list is reused as a list of pages to be freed by the caller.
  *
- * Returns the number of pages moved to the given lruvec.
+ * Returns the number of pages moved to the appropriate LRU list.
+ *
+ * Note: The caller must not hold any lruvec lock.
  */
-static unsigned int move_pages_to_lru(struct lruvec *lruvec,
-				      struct list_head *list)
+static unsigned int move_pages_to_lru(struct list_head *list)
 {
-	int nr_pages, nr_moved = 0;
+	int nr_moved = 0;
+	struct lruvec *lruvec = NULL;
 	LIST_HEAD(pages_to_free);
-	struct page *page;
 
 	while (!list_empty(list)) {
-		page = lru_to_page(list);
+		int nr_pages;
+		struct folio *folio = lru_to_folio(list);
+		struct page *page = &folio->page;
+
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
 		VM_BUG_ON_PAGE(PageLRU(page), page);
 		list_del(&page->lru);
 		if (unlikely(!page_evictable(page))) {
-			spin_unlock_irq(&lruvec->lru_lock);
+			unlock_page_lruvec_irq(lruvec);
 			putback_lru_page(page);
-			spin_lock_irq(&lruvec->lru_lock);
+			lruvec = NULL;
 			continue;
 		}
 
@@ -2267,20 +2272,16 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			__clear_page_lru_flags(page);
 
 			if (unlikely(PageCompound(page))) {
-				spin_unlock_irq(&lruvec->lru_lock);
+				unlock_page_lruvec_irq(lruvec);
 				destroy_compound_page(page);
-				spin_lock_irq(&lruvec->lru_lock);
+				lruvec = NULL;
 			} else
 				list_add(&page->lru, &pages_to_free);
 
 			continue;
 		}
 
-		/*
-		 * All pages were isolated from the same lruvec (and isolation
-		 * inhibits memcg migration).
-		 */
-		VM_BUG_ON_PAGE(!folio_matches_lruvec(page_folio(page), lruvec), page);
+		VM_BUG_ON_PAGE(!folio_matches_lruvec(folio, lruvec), page);
 		add_page_to_lru_list(page, lruvec);
 		nr_pages = thp_nr_pages(page);
 		nr_moved += nr_pages;
@@ -2288,6 +2289,8 @@ static unsigned int move_pages_to_lru(struct lruvec *lruvec,
 			workingset_age_nonresident(lruvec, nr_pages);
 	}
 
+	if (lruvec)
+		unlock_page_lruvec_irq(lruvec);
 	/*
 	 * To save our caller's stack, now use input list for pages to free.
 	 */
@@ -2359,16 +2362,16 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 
 	nr_reclaimed = shrink_page_list(&page_list, pgdat, sc, &stat, false);
 
-	spin_lock_irq(&lruvec->lru_lock);
-	move_pages_to_lru(lruvec, &page_list);
+	move_pages_to_lru(&page_list);
 
+	local_irq_disable();
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
 	item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
 	if (!cgroup_reclaim(sc))
 		__count_vm_events(item, nr_reclaimed);
 	__count_memcg_events(lruvec_memcg(lruvec), item, nr_reclaimed);
 	__count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
-	spin_unlock_irq(&lruvec->lru_lock);
+	local_irq_enable();
 
 	lru_note_cost(lruvec, file, stat.nr_pageout);
 	mem_cgroup_uncharge_list(&page_list);
@@ -2498,18 +2501,16 @@ static void shrink_active_list(unsigned long nr_to_scan,
 	/*
 	 * Move pages back to the lru list.
 	 */
-	spin_lock_irq(&lruvec->lru_lock);
-
-	nr_activate = move_pages_to_lru(lruvec, &l_active);
-	nr_deactivate = move_pages_to_lru(lruvec, &l_inactive);
+	nr_activate = move_pages_to_lru(&l_active);
+	nr_deactivate = move_pages_to_lru(&l_inactive);
 	/* Keep all free pages in l_active list */
 	list_splice(&l_inactive, &l_active);
 
+	local_irq_disable();
 	__count_vm_events(PGDEACTIVATE, nr_deactivate);
 	__count_memcg_events(lruvec_memcg(lruvec), PGDEACTIVATE, nr_deactivate);
-
 	__mod_node_page_state(pgdat, NR_ISOLATED_ANON + file, -nr_taken);
-	spin_unlock_irq(&lruvec->lru_lock);
+	local_irq_enable();
 
 	mem_cgroup_uncharge_list(&l_active);
 	free_unref_page_list(&l_active);
-- 
2.11.0

