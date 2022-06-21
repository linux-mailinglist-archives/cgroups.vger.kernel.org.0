Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F485532B2
	for <lists+cgroups@lfdr.de>; Tue, 21 Jun 2022 14:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiFUM67 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Jun 2022 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351155AbiFUM6h (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Jun 2022 08:58:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEEBB0C
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:36 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 23so6885847pgc.8
        for <cgroups@vger.kernel.org>; Tue, 21 Jun 2022 05:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FXYyMqCuMn8N8AtiePCadIk2ihaRxjS8+sCa4dkDZyY=;
        b=ID4gt1H5XAXZc2WTCkcM4F1wzX1sAe3JOWtacCk0iQKQ+aLMZXAoV2LeDm9V/qhVXx
         6tpAVEejJhQBmJjVUK+nIaNyniVWz7hJGtPgx1OZl1uOfj2pujAFTcbGChoVU9DBG1kQ
         iSr/YRd45uGdFIuCRF+nZy0GIGBavXDFzjNLsbIp/9bZz+yRlZan+nvKfKhVHEPvjiD5
         P/VKwyJbbrvB0eRUS26CEwFTb/hg3CWoix8AAXQYFzZU3v7OZBDBODtMEhL6UOydPlDK
         QPnx0hfY8bRXub0eY6AxeQXF/rpFM66dPqaBxFcGtr4OkljZGqrs6ATOyrSkIf9U3exr
         0w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FXYyMqCuMn8N8AtiePCadIk2ihaRxjS8+sCa4dkDZyY=;
        b=MzvaryEXHSKw6Zgsn4iGFulv2Gpqeglv17578rXs5KbYAIYHACMzqLTY2Orecq7LE/
         jpiLvRCWXZReEtD538dxj1cCds6++Ub8S/T372aMLb7WXxzOt+usE66eL3Vfv2kYo1di
         q/eu7HU29yIs1B5aQAw4xMy6d5r9kTKtzFg+VxZp4Kjba/4NwS+7KB4ojd9i3WJIZSKO
         qOMyLaIdFK8uABzgGHHclfsSbhLN56wCUb8nqrqzAZ/yLcAD1Y5n7OVU1N24XAEPBR85
         9DrSbq5SrcEEjhHLrVBo5gr/MgqRK+KjyKasGJhWHqbX0k4czyv81ybOGlSQqSMzSWdA
         m1tQ==
X-Gm-Message-State: AJIora9yFluBJ1CDCotUCxcgSJHVscBAaBKdpN+g6AC6PBkTDRXBYXqz
        wD+fjc6oGK4rXrhMqXgXikErDQ==
X-Google-Smtp-Source: AGRyM1s3jBpILIrDx7KtbyRkegEjXT/bYyiPJT5PmXEB7MsPCFZC/X2wELk53MsJbksfq61xEhFUrw==
X-Received: by 2002:a63:7c4e:0:b0:380:8ae9:c975 with SMTP id l14-20020a637c4e000000b003808ae9c975mr26959498pgn.25.1655816315865;
        Tue, 21 Jun 2022 05:58:35 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id e3-20020a170903240300b0015ea3a491a1sm10643134plo.191.2022.06.21.05.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:58:35 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com
Cc:     cgroups@vger.kernel.org, duanxiongchun@bytedance.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 11/11] mm: lru: use lruvec lock to serialize memcg changes
Date:   Tue, 21 Jun 2022 20:56:58 +0800
Message-Id: <20220621125658.64935-12-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220621125658.64935-1-songmuchun@bytedance.com>
References: <20220621125658.64935-1-songmuchun@bytedance.com>
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

As described by commit fc574c23558c ("mm/swap.c: serialize memcg
changes in pagevec_lru_move_fn"), TestClearPageLRU() aims to
serialize mem_cgroup_move_account() during pagevec_lru_move_fn().
Now folio_lruvec_lock*() has the ability to detect whether page
memcg has been changed. So we can use lruvec lock to serialize
mem_cgroup_move_account() during pagevec_lru_move_fn(). This
change is a partial revert of the commit fc574c23558c ("mm/swap.c:
serialize memcg changes in pagevec_lru_move_fn").

And pagevec_lru_move_fn() is more hot compare with
mem_cgroup_move_account(), removing an atomic operation would be
an optimization. Also this change would not dirty cacheline for a
page which isn't on the LRU.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 34 ++++++++++++++++++++++++++++++++++
 mm/swap.c       | 32 +++++++++++++++-----------------
 mm/vmscan.c     | 16 +++++++---------
 3 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 803dbdf5f233..85adc43c5a25 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1330,10 +1330,39 @@ struct lruvec *folio_lruvec_lock(struct folio *folio)
 	lruvec = folio_lruvec(folio);
 	spin_lock(&lruvec->lru_lock);
 
+	/*
+	 * The memcg of the page can be changed by any the following routines:
+	 *
+	 * 1) mem_cgroup_move_account() or
+	 * 2) memcg_reparent_objcgs()
+	 *
+	 * The possible bad scenario would like:
+	 *
+	 * CPU0:                CPU1:                CPU2:
+	 * lruvec = folio_lruvec()
+	 *
+	 *                      if (!isolate_lru_page())
+	 *                              mem_cgroup_move_account()
+	 *
+	 *                                           memcg_reparent_objcgs()
+	 *
+	 * spin_lock(&lruvec->lru_lock)
+	 *                ^^^^^^
+	 *              wrong lock
+	 *
+	 * Either CPU1 or CPU2 can change page memcg, so we need to check
+	 * whether page memcg is changed, if so, we should reacquire the
+	 * new lruvec lock.
+	 */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock(&lruvec->lru_lock);
 		goto retry;
 	}
+
+	/*
+	 * When we reach here, it means that the folio_memcg(folio) is
+	 * stable.
+	 */
 	rcu_read_unlock();
 
 	return lruvec;
@@ -1361,6 +1390,7 @@ struct lruvec *folio_lruvec_lock_irq(struct folio *folio)
 	lruvec = folio_lruvec(folio);
 	spin_lock_irq(&lruvec->lru_lock);
 
+	/* See the comments in folio_lruvec_lock(). */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock_irq(&lruvec->lru_lock);
 		goto retry;
@@ -1394,6 +1424,7 @@ struct lruvec *folio_lruvec_lock_irqsave(struct folio *folio,
 	lruvec = folio_lruvec(folio);
 	spin_lock_irqsave(&lruvec->lru_lock, *flags);
 
+	/* See the comments in folio_lruvec_lock(). */
 	if (unlikely(lruvec_memcg(lruvec) != folio_memcg(folio))) {
 		spin_unlock_irqrestore(&lruvec->lru_lock, *flags);
 		goto retry;
@@ -5809,7 +5840,10 @@ static int mem_cgroup_move_account(struct page *page,
 	obj_cgroup_put(rcu_dereference(from->objcg));
 	rcu_read_unlock();
 
+	/* See the comments in folio_lruvec_lock(). */
+	spin_lock(&from_vec->lru_lock);
 	folio->memcg_data = (unsigned long)rcu_access_pointer(to->objcg);
+	spin_unlock(&from_vec->lru_lock);
 
 	__folio_memcg_unlock(from);
 
diff --git a/mm/swap.c b/mm/swap.c
index 987dcbd93ffa..0fc59409e27d 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -196,6 +196,7 @@ static void lru_add_fn(struct lruvec *lruvec, struct folio *folio)
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
+	folio_set_lru(folio);
 	/*
 	 * Is an smp_mb__after_atomic() still required here, before
 	 * folio_evictable() tests the mlocked flag, to rule out the possibility
@@ -238,14 +239,8 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 	for (i = 0; i < folio_batch_count(fbatch); i++) {
 		struct folio *folio = fbatch->folios[i];
 
-		/* block memcg migration while the folio moves between lru */
-		if (move_fn != lru_add_fn && !folio_test_clear_lru(folio))
-			continue;
-
 		lruvec = folio_lruvec_relock_irqsave(folio, lruvec, &flags);
 		move_fn(lruvec, folio);
-
-		folio_set_lru(folio);
 	}
 
 	if (lruvec)
@@ -265,7 +260,7 @@ static void folio_batch_add_and_move(struct folio_batch *fbatch,
 
 static void lru_move_tail_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (!folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && !folio_test_unevictable(folio)) {
 		lruvec_del_folio(lruvec, folio);
 		folio_clear_active(folio);
 		lruvec_add_folio_tail(lruvec, folio);
@@ -348,7 +343,8 @@ void lru_note_cost_folio(struct folio *folio)
 
 static void folio_activate_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (!folio_test_active(folio) && !folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && !folio_test_active(folio) &&
+	    !folio_test_unevictable(folio)) {
 		long nr_pages = folio_nr_pages(folio);
 
 		lruvec_del_folio(lruvec, folio);
@@ -394,12 +390,9 @@ static void folio_activate(struct folio *folio)
 {
 	struct lruvec *lruvec;
 
-	if (folio_test_clear_lru(folio)) {
-		lruvec = folio_lruvec_lock_irq(folio);
-		folio_activate_fn(lruvec, folio);
-		lruvec_unlock_irq(lruvec);
-		folio_set_lru(folio);
-	}
+	lruvec = folio_lruvec_lock_irq(folio);
+	folio_activate_fn(lruvec, folio);
+	lruvec_unlock_irq(lruvec);
 }
 #endif
 
@@ -542,6 +535,9 @@ static void lru_deactivate_file_fn(struct lruvec *lruvec, struct folio *folio)
 	bool active = folio_test_active(folio);
 	long nr_pages = folio_nr_pages(folio);
 
+	if (!folio_test_lru(folio))
+		return;
+
 	if (folio_test_unevictable(folio))
 		return;
 
@@ -580,7 +576,8 @@ static void lru_deactivate_file_fn(struct lruvec *lruvec, struct folio *folio)
 
 static void lru_deactivate_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (folio_test_active(folio) && !folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && folio_test_active(folio) &&
+	    !folio_test_unevictable(folio)) {
 		long nr_pages = folio_nr_pages(folio);
 
 		lruvec_del_folio(lruvec, folio);
@@ -596,8 +593,9 @@ static void lru_deactivate_fn(struct lruvec *lruvec, struct folio *folio)
 
 static void lru_lazyfree_fn(struct lruvec *lruvec, struct folio *folio)
 {
-	if (folio_test_anon(folio) && folio_test_swapbacked(folio) &&
-	    !folio_test_swapcache(folio) && !folio_test_unevictable(folio)) {
+	if (folio_test_lru(folio) && folio_test_anon(folio) &&
+	    folio_test_swapbacked(folio) && !folio_test_swapcache(folio) &&
+	    !folio_test_unevictable(folio)) {
 		long nr_pages = folio_nr_pages(folio);
 
 		lruvec_del_folio(lruvec, folio);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 51b1607c81e4..11e1f6fc5898 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4864,21 +4864,19 @@ void check_move_unevictable_pages(struct pagevec *pvec)
 		if (PageTransTail(page))
 			continue;
 
-		nr_pages = thp_nr_pages(page);
+		nr_pages = folio_nr_pages(folio);
 		pgscanned += nr_pages;
 
-		/* block memcg migration during page moving between lru */
-		if (!TestClearPageLRU(page))
+		lruvec = folio_lruvec_relock_irq(folio, lruvec);
+		if (!folio_test_lru(folio) || !folio_test_unevictable(folio))
 			continue;
 
-		lruvec = folio_lruvec_relock_irq(folio, lruvec);
-		if (page_evictable(page) && PageUnevictable(page)) {
-			del_page_from_lru_list(page, lruvec);
-			ClearPageUnevictable(page);
-			add_page_to_lru_list(page, lruvec);
+		if (folio_evictable(folio)) {
+			lruvec_del_folio(lruvec, folio);
+			folio_clear_unevictable(folio);
+			lruvec_add_folio(lruvec, folio);
 			pgrescued += nr_pages;
 		}
-		SetPageLRU(page);
 	}
 
 	if (lruvec) {
-- 
2.11.0

