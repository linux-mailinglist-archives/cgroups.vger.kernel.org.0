Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646B010419F
	for <lists+cgroups@lfdr.de>; Wed, 20 Nov 2019 17:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbfKTQ6u (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 20 Nov 2019 11:58:50 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39684 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728460AbfKTQ6u (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 20 Nov 2019 11:58:50 -0500
Received: by mail-qv1-f66.google.com with SMTP id v16so185864qvq.6
        for <cgroups@vger.kernel.org>; Wed, 20 Nov 2019 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpIA+rvc+Ub15DwARGwCPsLQo64idg/OwWT6O3mpE6w=;
        b=JWQOya2UTVmtO3YTI3J++veMgOo/VuDvIh5JkQNpTTc5CoZly1XR0w+K3s2/9nah4Z
         Lf4udbLEoNM5yRNDtigxpPqCVFNUr3ddOdXT3J4WRH326Cl1KZVwMCvo/0or/mAXbbJc
         7ndDVIb5LaaBTvFcVp9tiGBhnT8zG4zAG+GDR4hka42LtEM9yjtvplacvk12jKQlfcTr
         riLsiA8iJtP9ZK6LbWmV8IYv+4jyuxHurD+NKQDg9aC7WjCIe4eFpDGjxUL/Kiqzgtwy
         p9zgdkh9CrE3imotLw33zZnAacTznJz8BMsbPk67PT4MqDz8fy+XGUqTzA4f3LkSg68T
         nVAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hpIA+rvc+Ub15DwARGwCPsLQo64idg/OwWT6O3mpE6w=;
        b=KEdhXBQG13wnL0RleNJi9Q3/V5E2phQdX7EpKwn5+rXMC9EucoI+fOH6u6yxlYxqov
         e2DDD1mgQzsxKj9WVdngFtsaWbpoTZxAv4HkQlMHZZx5oi2p7bAazmPSuTTe0yulk42r
         1/uTYJvE4BJM9R0TGMKiYaS43+XrX8ZWVhAiYcwKIEJWvaDxwtKH2tQJR9pA4/fsTJ3Z
         kQgrorXjljidJN1g97mHywvOtrs0FigPeZcetbw46OQ/lv3BEAidaj84ctO+Q8m9GcD5
         c6wng/zDWaFQ97sHXRLhRIpzuWEq4cPoACPPHpy/BWl7aslu7eBgPD9aMaYvpC4AgTxv
         3DOQ==
X-Gm-Message-State: APjAAAVR640v++JDhn2U89SK6vzEIgWuEeUFl77ctRfuXsFPPMyGdgco
        IeXUXzdtB8gdp1q6mbchjHmJXQ==
X-Google-Smtp-Source: APXvYqxiTcyvcwZS6OaUR2diyQ9VgWPR8HMJDoANnPSA/6WdaWdJUN91QROYr7TbLLupkBa34MsurQ==
X-Received: by 2002:a0c:d4ba:: with SMTP id u55mr3539945qvh.40.1574269128605;
        Wed, 20 Nov 2019 08:58:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::6900])
        by smtp.gmail.com with ESMTPSA id 11sm12082528qkv.131.2019.11.20.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 08:58:47 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] mm: fix unsafe page -> lruvec lookups with cgroup charge migration
Date:   Wed, 20 Nov 2019 11:58:47 -0500
Message-Id: <20191120165847.423540-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

While reviewing the "per lruvec lru_lock for memcg" series, Hugh and I
noticed two places in the existing code where the page -> memcg ->
lruvec lookup can result in a use-after-free bug. This affects cgroup1
setups that have charge migration enabled.

To pin page->mem_cgroup, callers need to either have the page locked,
an exclusive refcount (0), or hold the lru_lock and "own" PageLRU
(either ensure it's set, or be the one to hold the page in isolation)
to make cgroup migration fail the isolation step. Failure to follow
this can result in the page moving out of the memcg and freeing it,
along with its lruvecs, while the observer is dereferencing them.

1. isolate_lru_page() calls mem_cgroup_page_lruvec() with the lru_lock
held but before testing PageLRU. It doesn't dereference the returned
lruvec before testing PageLRU, giving the impression that it might
just be safe ordering after all - but mem_cgroup_page_lruvec() itself
touches the lruvec to lazily initialize the pgdat back pointer. This
one is easy to fix, just move the lookup into the PageLRU branch.

2. pagevec_lru_move_fn() conveniently looks up the lruvec for all the
callbacks it might get invoked on. Unfortunately, it's the callbacks
that first check PageLRU under the lru_lock, which makes this order
equally unsafe as isolate_lru_page(). Remove the lruvec argument from
the move callbacks and let them do it inside their PageLRU branches.

Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/swap.c   | 48 +++++++++++++++++++++++++++++-------------------
 mm/vmscan.c |  8 ++++----
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 5341ae93861f..6b015e9532fb 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -188,12 +188,11 @@ int get_kernel_page(unsigned long start, int write, struct page **pages)
 EXPORT_SYMBOL_GPL(get_kernel_page);
 
 static void pagevec_lru_move_fn(struct pagevec *pvec,
-	void (*move_fn)(struct page *page, struct lruvec *lruvec, void *arg),
+	void (*move_fn)(struct page *page, void *arg),
 	void *arg)
 {
 	int i;
 	struct pglist_data *pgdat = NULL;
-	struct lruvec *lruvec;
 	unsigned long flags = 0;
 
 	for (i = 0; i < pagevec_count(pvec); i++) {
@@ -207,8 +206,7 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 			spin_lock_irqsave(&pgdat->lru_lock, flags);
 		}
 
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
-		(*move_fn)(page, lruvec, arg);
+		(*move_fn)(page, arg);
 	}
 	if (pgdat)
 		spin_unlock_irqrestore(&pgdat->lru_lock, flags);
@@ -216,12 +214,14 @@ static void pagevec_lru_move_fn(struct pagevec *pvec,
 	pagevec_reinit(pvec);
 }
 
-static void pagevec_move_tail_fn(struct page *page, struct lruvec *lruvec,
-				 void *arg)
+static void pagevec_move_tail_fn(struct page *page, void *arg)
 {
 	int *pgmoved = arg;
 
 	if (PageLRU(page) && !PageUnevictable(page)) {
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 		del_page_from_lru_list(page, lruvec, page_lru(page));
 		ClearPageActive(page);
 		add_page_to_lru_list_tail(page, lruvec, page_lru(page));
@@ -272,12 +272,14 @@ static void update_page_reclaim_stat(struct lruvec *lruvec,
 		reclaim_stat->recent_rotated[file]++;
 }
 
-static void __activate_page(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void __activate_page(struct page *page, void *arg)
 {
 	if (PageLRU(page) && !PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_cache(page);
 		int lru = page_lru_base_type(page);
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 
 		del_page_from_lru_list(page, lruvec, lru);
 		SetPageActive(page);
@@ -328,7 +330,7 @@ void activate_page(struct page *page)
 
 	page = compound_head(page);
 	spin_lock_irq(&pgdat->lru_lock);
-	__activate_page(page, mem_cgroup_page_lruvec(page, pgdat), NULL);
+	__activate_page(page, NULL);
 	spin_unlock_irq(&pgdat->lru_lock);
 }
 #endif
@@ -498,9 +500,9 @@ void lru_cache_add_active_or_unevictable(struct page *page,
  * be write it out by flusher threads as this is much more effective
  * than the single-page writeout from reclaim.
  */
-static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
-			      void *arg)
+static void lru_deactivate_file_fn(struct page *page, void *arg)
 {
+	struct lruvec *lruvec;
 	int lru, file;
 	bool active;
 
@@ -518,6 +520,8 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	file = page_is_file_cache(page);
 	lru = page_lru_base_type(page);
 
+	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
 	del_page_from_lru_list(page, lruvec, lru + active);
 	ClearPageActive(page);
 	ClearPageReferenced(page);
@@ -544,12 +548,14 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
 	update_page_reclaim_stat(lruvec, file, 0);
 }
 
-static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void lru_deactivate_fn(struct page *page, void *arg)
 {
 	if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
 		int file = page_is_file_cache(page);
 		int lru = page_lru_base_type(page);
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 
 		del_page_from_lru_list(page, lruvec, lru + LRU_ACTIVE);
 		ClearPageActive(page);
@@ -561,12 +567,14 @@ static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec,
 	}
 }
 
-static void lru_lazyfree_fn(struct page *page, struct lruvec *lruvec,
-			    void *arg)
+static void lru_lazyfree_fn(struct page *page, void *arg)
 {
 	if (PageLRU(page) && PageAnon(page) && PageSwapBacked(page) &&
 	    !PageSwapCache(page) && !PageUnevictable(page)) {
 		bool active = PageActive(page);
+		struct lruvec *lruvec;
+
+		lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
 
 		del_page_from_lru_list(page, lruvec,
 				       LRU_INACTIVE_ANON + active);
@@ -921,15 +929,17 @@ void lru_add_page_tail(struct page *page, struct page *page_tail,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static void __pagevec_lru_add_fn(struct page *page, struct lruvec *lruvec,
-				 void *arg)
+static void __pagevec_lru_add_fn(struct page *page, void *arg)
 {
-	enum lru_list lru;
 	int was_unevictable = TestClearPageUnevictable(page);
+	struct lruvec *lruvec;
+	enum lru_list lru;
 
 	VM_BUG_ON_PAGE(PageLRU(page), page);
-
 	SetPageLRU(page);
+
+	lruvec = mem_cgroup_page_lruvec(page, page_pgdat(page));
+
 	/*
 	 * Page becomes evictable in two ways:
 	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
diff --git a/mm/vmscan.c b/mm/vmscan.c
index df859b1d583c..3c8b81990146 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1767,15 +1767,15 @@ int isolate_lru_page(struct page *page)
 
 	if (PageLRU(page)) {
 		pg_data_t *pgdat = page_pgdat(page);
-		struct lruvec *lruvec;
 
 		spin_lock_irq(&pgdat->lru_lock);
-		lruvec = mem_cgroup_page_lruvec(page, pgdat);
 		if (PageLRU(page)) {
-			int lru = page_lru(page);
+			struct lruvec *lruvec;
+
+			lruvec = mem_cgroup_page_lruvec(page, pgdat);
 			get_page(page);
 			ClearPageLRU(page);
-			del_page_from_lru_list(page, lruvec, lru);
+			del_page_from_lru_list(page, lruvec, page_lru(page));
 			ret = 0;
 		}
 		spin_unlock_irq(&pgdat->lru_lock);
-- 
2.24.0

