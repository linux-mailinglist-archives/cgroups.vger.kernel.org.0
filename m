Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847FD1B191E
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgDTWMI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbgDTWMH (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:12:07 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8644C061A0C
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:05 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so9994055qtd.10
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0ByVKo45aqE3C3DiOWQlsfGiXPD8l0eCrADnL4xHp3M=;
        b=W9M8209Lc67ASOYNxMxTQgqQ83SefdkGr4BMt3zVc2SbUfZkCY8RKITBaHT3GEOBhj
         N6lcEWc71w4InzGYzCXejgX6dB57cHmEO7jFYsstDdDGBjxMHjRaEeEgsw/FS7v0xboV
         8kJ9WEuhnEhURfAcJrMRRRUKtpl23ZrvvZG1L024jGU6N6WvFDqxir/r+ZLBe1XD77/C
         3Yaim4ynqkVQTMgEXcwAP2ozd6akgOygsfVgsn/eDTH8+9VGOpu5KStmyVSRak9cEonB
         pYfrKK3YsJB+eMlMlWfXLRjbHSdSuD96IhBn35BCOQyPlYBUk9zopL+9drvDv9A0RPCR
         e2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0ByVKo45aqE3C3DiOWQlsfGiXPD8l0eCrADnL4xHp3M=;
        b=r9Z4sPB4nGITQqzfeQXcGp2DW1wsSxpf7YFE3+KuODQW6tCXMw21OufnFuKktYQJq8
         BCimihq0NM4pCcxTBLeiQ3/C5XOw1T6J3JMX4LLZFzOzuEo+r3ZESJBqpCz3PAAGw1lp
         F+bPgIk+Qq6C61C+B2Pi9j2YA1Y7QdI1iSAm5HAnzbDMhFdj7yqiVWYLHKn2Hzo+YdC7
         90HLYDZ3E2eMybJkUMnDJSMMffclMtntntkQxYKze6yUvHiShnmfqW/VyxXzDj9Jxv0S
         Qv87tCrXBXbHTfjsKECHFI2s+psxknRXC2UO1CAtDWsOgpEPdFumG+VY/yXog12491eT
         wT/g==
X-Gm-Message-State: AGi0PuZce4BdM5qBShTDJ2VOeT/e0ELyq5Gld9l6c07ibun4OFfNFCml
        mVCcvuKmWV8i4cVm5mTCc4WilQ==
X-Google-Smtp-Source: APiQypKo2DmYJKGiyL9AbVGNCrQ9cisUiwv9yX0i7x9v3iG5reuyNDJ7IGJ5vGas8mXirtHTbM036w==
X-Received: by 2002:ac8:1703:: with SMTP id w3mr18392750qtj.267.1587420724916;
        Mon, 20 Apr 2020 15:12:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id 31sm435219qta.56.2020.04.20.15.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:04 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 13/18] mm: memcontrol: drop unused try/commit/cancel charge API
Date:   Mon, 20 Apr 2020 18:11:21 -0400
Message-Id: <20200420221126.341272-14-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are no more users. RIP in peace.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h |  36 -----------
 mm/memcontrol.c            | 126 +++++--------------------------------
 2 files changed, 15 insertions(+), 147 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ac8122ec1cd..52eb6411cfee 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -357,14 +357,6 @@ static inline unsigned long mem_cgroup_protection(struct mem_cgroup *memcg,
 enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 						struct mem_cgroup *memcg);
 
-int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp);
-int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp);
-void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
-			      bool lrucare);
-void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg);
-
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 		      bool lrucare);
 
@@ -846,34 +838,6 @@ static inline enum mem_cgroup_protection mem_cgroup_protected(
 	return MEMCG_PROT_NONE;
 }
 
-static inline int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-					gfp_t gfp_mask,
-					struct mem_cgroup **memcgp)
-{
-	*memcgp = NULL;
-	return 0;
-}
-
-static inline int mem_cgroup_try_charge_delay(struct page *page,
-					      struct mm_struct *mm,
-					      gfp_t gfp_mask,
-					      struct mem_cgroup **memcgp)
-{
-	*memcgp = NULL;
-	return 0;
-}
-
-static inline void mem_cgroup_commit_charge(struct page *page,
-					    struct mem_cgroup *memcg,
-					    bool lrucare)
-{
-}
-
-static inline void mem_cgroup_cancel_charge(struct page *page,
-					    struct mem_cgroup *memcg)
-{
-}
-
 static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
 				    gfp_t gfp_mask, bool lrucare)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7845a87b94d5..d5aee5577ff3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6431,29 +6431,26 @@ enum mem_cgroup_protection mem_cgroup_protected(struct mem_cgroup *root,
 }
 
 /**
- * mem_cgroup_try_charge - try charging a page
+ * mem_cgroup_charge - charge a newly allocated page to a cgroup
  * @page: page to charge
  * @mm: mm context of the victim
  * @gfp_mask: reclaim mode
- * @memcgp: charged memcg return
+ * @lrucare: page might be on the LRU already
  *
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
  * pages according to @gfp_mask if necessary.
  *
- * Returns 0 on success, with *@memcgp pointing to the charged memcg.
- * Otherwise, an error code is returned.
- *
- * After page->mapping has been set up, the caller must finalize the
- * charge with mem_cgroup_commit_charge().  Or abort the transaction
- * with mem_cgroup_cancel_charge() in case page instantiation fails.
+ * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp)
+int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
+		      bool lrucare)
 {
 	unsigned int nr_pages = hpage_nr_pages(page);
 	struct mem_cgroup *memcg = NULL;
 	int ret = 0;
 
+	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
+
 	if (mem_cgroup_disabled())
 		goto out;
 
@@ -6485,56 +6482,8 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 
 	ret = try_charge(memcg, gfp_mask, nr_pages);
-
-	css_put(&memcg->css);
-out:
-	*memcgp = memcg;
-	return ret;
-}
-
-int mem_cgroup_try_charge_delay(struct page *page, struct mm_struct *mm,
-			  gfp_t gfp_mask, struct mem_cgroup **memcgp)
-{
-	int ret;
-
-	ret = mem_cgroup_try_charge(page, mm, gfp_mask, memcgp);
-	if (*memcgp)
-		cgroup_throttle_swaprate(page, gfp_mask);
-	return ret;
-}
-
-/**
- * mem_cgroup_commit_charge - commit a page charge
- * @page: page to charge
- * @memcg: memcg to charge the page to
- * @lrucare: page might be on LRU already
- *
- * Finalize a charge transaction started by mem_cgroup_try_charge(),
- * after page->mapping has been set up.  This must happen atomically
- * as part of the page instantiation, i.e. under the page table lock
- * for anonymous pages, under the page lock for page and swap cache.
- *
- * In addition, the page must not be on the LRU during the commit, to
- * prevent racing with task migration.  If it might be, use @lrucare.
- *
- * Use mem_cgroup_cancel_charge() to cancel the transaction instead.
- */
-void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
-			      bool lrucare)
-{
-	unsigned int nr_pages = hpage_nr_pages(page);
-
-	VM_BUG_ON_PAGE(PageLRU(page) && !lrucare, page);
-
-	if (mem_cgroup_disabled())
-		return;
-	/*
-	 * Swap faults will attempt to charge the same page multiple
-	 * times.  But reuse_swap_page() might have removed the page
-	 * from swapcache already, so we can't check PageSwapCache().
-	 */
-	if (!memcg)
-		return;
+	if (ret)
+		goto out_put;
 
 	commit_charge(page, memcg, lrucare);
 
@@ -6552,55 +6501,11 @@ void mem_cgroup_commit_charge(struct page *page, struct mem_cgroup *memcg,
 		 */
 		mem_cgroup_uncharge_swap(entry, nr_pages);
 	}
-}
 
-/**
- * mem_cgroup_cancel_charge - cancel a page charge
- * @page: page to charge
- * @memcg: memcg to charge the page to
- *
- * Cancel a charge transaction started by mem_cgroup_try_charge().
- */
-void mem_cgroup_cancel_charge(struct page *page, struct mem_cgroup *memcg)
-{
-	unsigned int nr_pages = hpage_nr_pages(page);
-
-	if (mem_cgroup_disabled())
-		return;
-	/*
-	 * Swap faults will attempt to charge the same page multiple
-	 * times.  But reuse_swap_page() might have removed the page
-	 * from swapcache already, so we can't check PageSwapCache().
-	 */
-	if (!memcg)
-		return;
-
-	cancel_charge(memcg, nr_pages);
-}
-
-/**
- * mem_cgroup_charge - charge a newly allocated page to a cgroup
- * @page: page to charge
- * @mm: mm context of the victim
- * @gfp_mask: reclaim mode
- * @lrucare: page might be on the LRU already
- *
- * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary.
- *
- * Returns 0 on success. Otherwise, an error code is returned.
- */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
-		      bool lrucare)
-{
-	struct mem_cgroup *memcg;
-	int ret;
-
-	ret = mem_cgroup_try_charge(page, mm, gfp_mask, &memcg);
-	if (ret)
-		return ret;
-	mem_cgroup_commit_charge(page, memcg, lrucare);
-	return 0;
+out_put:
+	css_put(&memcg->css);
+out:
+	return ret;
 }
 
 struct uncharge_gather {
@@ -6707,8 +6612,7 @@ static void uncharge_list(struct list_head *page_list)
  * mem_cgroup_uncharge - uncharge a page
  * @page: page to uncharge
  *
- * Uncharge a page previously charged with mem_cgroup_try_charge() and
- * mem_cgroup_commit_charge().
+ * Uncharge a page previously charged with mem_cgroup_charge().
  */
 void mem_cgroup_uncharge(struct page *page)
 {
@@ -6731,7 +6635,7 @@ void mem_cgroup_uncharge(struct page *page)
  * @page_list: list of pages to uncharge
  *
  * Uncharge a list of pages previously charged with
- * mem_cgroup_try_charge() and mem_cgroup_commit_charge().
+ * mem_cgroup_charge().
  */
 void mem_cgroup_uncharge_list(struct list_head *page_list)
 {
-- 
2.26.0

