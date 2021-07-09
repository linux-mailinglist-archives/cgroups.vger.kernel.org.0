Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447A93C2824
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhGIRSm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 13:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIRSm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 13:18:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA8C0613E5
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 10:15:58 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 132-20020a25158a0000b029055791ebe1e6so12465925ybv.20
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 10:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Mo8vf2VijmXE0Kj63cEeHZeOMc23Yva+SB8nf+0oHHk=;
        b=edy+MsiIy/d4cyFnuv1+E/otaIO6nz7+ZqGr/G0JQdc/NYFDoq4ejsTXJgkrhOkFv4
         8uB0hSdSzgXI3O38qdYCBilrBOniO0ARAy53wZsVqF3fcvMqwp8i8yzmBmG2S2crxCGg
         N6oRBxtrNu2FREg4kIW+L03/94KJCq+PEp0lumHydN1xpmNeEn08JTIlz1vzPYO/nW1R
         WV1OdtMP0+V1jEGOC067Y7JbM+/rF/121CLJ1JZJRR8CypXzxxC9ukq01qbXgYKml9RL
         8qB6e+RLAnn9ICDGygpT9ZObPnZV5pDapDoXkXphh63xKis0s3Qy9gqom096EB9pnTRR
         1+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Mo8vf2VijmXE0Kj63cEeHZeOMc23Yva+SB8nf+0oHHk=;
        b=S4XQq5XJBO2u0l/gnft1EdUhG0cWsixkbKN+vfjfppPpb/OnTh5SkYWR+pt4a+DZo3
         znE3YzHdszd9QFo+Ktrbi8HiugBvLkrIKu85VklvS19I0ztpT2VaNg5nS8xhEvMRkztW
         kMR16L1Ge24YwygtTBWpfNXv1XA4OC9zgPQcNrjNc+El0JqSkJQCSCIEDbS0K9sCNe3h
         /ZZVHqy0VvZ5Yf50ta/GhXRAXseBav5YerYvQ8jFrmtMg+UKqGYba7dC5oaU86jK+GoQ
         PZps02AUEtrH5lfRgn7dLQ3fOOglfASrfM/K4NtYiMLFxg61xFV08/ELh0eC0bujOx9E
         NXcA==
X-Gm-Message-State: AOAM532sioswAoHvbrahSsHEm9o1XoOM4huQFeU2nP4OvpCJ9VOYCXvj
        EdSDelDOJ4V9P0BIC8svzNpheiOCfmQ=
X-Google-Smtp-Source: ABdhPJzi/H/Nck0AAoo0h214LOlRmb+5pLoinbBXSR23O2IEoejG7Qf2DRTOJSSegkcmPxGYKjLml/YP47A=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:9f62:e8e9:4de2:f00a])
 (user=surenb job=sendgmr) by 2002:a25:df11:: with SMTP id w17mr47515616ybg.314.1625850957757;
 Fri, 09 Jul 2021 10:15:57 -0700 (PDT)
Date:   Fri,  9 Jul 2021 10:15:54 -0700
Message-Id: <20210709171554.3494654-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2 1/1] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        richard.weiyang@gmail.com, vbabka@suse.cz, axboe@kernel.dk,
        iamjoonsoo.kim@lge.com, david@redhat.com, willy@infradead.org,
        apopple@nvidia.com, minchan@kernel.org, linmiaohe@huawei.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com, surenb@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Inline mem_cgroup_{charge/uncharge} and mem_cgroup_uncharge_list functions
functions to perform mem_cgroup_disabled static key check inline before
calling the main body of the function. This minimizes the memcg overhead
in the pagefault and exit_mmap paths when memcgs are disabled using
cgroup_disable=memory command-line option.
This change results in ~0.4% overhead reduction when running PFT test
comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
configurationon on an 8-core ARM64 Android device.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
changes in v2:
- Changed mem_cgroup_charge to use the same inlining pattern as the rest of the
functions per Johannes.

 include/linux/memcontrol.h | 28 +++++++++++++++++++++++++---
 mm/memcontrol.c            | 29 ++++++++++-------------------
 2 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..39fa88051a42 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -693,13 +693,35 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
+int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
+			gfp_t gfp_mask);
+static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
+				    gfp_t gfp_mask)
+{
+	if (mem_cgroup_disabled())
+		return 0;
+	return __mem_cgroup_charge(page, mm, gfp_mask);
+}
+
 int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
 void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
 
-void mem_cgroup_uncharge(struct page *page);
-void mem_cgroup_uncharge_list(struct list_head *page_list);
+void __mem_cgroup_uncharge(struct page *page);
+static inline void mem_cgroup_uncharge(struct page *page)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge(page);
+}
+
+void __mem_cgroup_uncharge_list(struct list_head *page_list);
+static inline void mem_cgroup_uncharge_list(struct list_head *page_list)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_list(page_list);
+}
 
 void mem_cgroup_migrate(struct page *oldpage, struct page *newpage);
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a228cd51c4bd..cdaf7003b43d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6701,8 +6701,7 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
-static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
-			       gfp_t gfp)
+static int charge_memcg(struct page *page, struct mem_cgroup *memcg, gfp_t gfp)
 {
 	unsigned int nr_pages = thp_nr_pages(page);
 	int ret;
@@ -6723,7 +6722,7 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 }
 
 /**
- * mem_cgroup_charge - charge a newly allocated page to a cgroup
+ * __mem_cgroup_charge - charge a newly allocated page to a cgroup
  * @page: page to charge
  * @mm: mm context of the victim
  * @gfp_mask: reclaim mode
@@ -6736,16 +6735,14 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
  *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
+int __mem_cgroup_charge(struct page *page, struct mm_struct *mm,
+			gfp_t gfp_mask)
 {
 	struct mem_cgroup *memcg;
 	int ret;
 
-	if (mem_cgroup_disabled())
-		return 0;
-
 	memcg = get_mem_cgroup_from_mm(mm);
-	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
+	ret = charge_memcg(page, memcg, gfp_mask);
 	css_put(&memcg->css);
 
 	return ret;
@@ -6780,7 +6777,7 @@ int mem_cgroup_swapin_charge_page(struct page *page, struct mm_struct *mm,
 		memcg = get_mem_cgroup_from_mm(mm);
 	rcu_read_unlock();
 
-	ret = __mem_cgroup_charge(page, memcg, gfp);
+	ret = charge_memcg(page, memcg, gfp);
 
 	css_put(&memcg->css);
 	return ret;
@@ -6916,18 +6913,15 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 }
 
 /**
- * mem_cgroup_uncharge - uncharge a page
+ * __mem_cgroup_uncharge - uncharge a page
  * @page: page to uncharge
  *
  * Uncharge a page previously charged with mem_cgroup_charge().
  */
-void mem_cgroup_uncharge(struct page *page)
+void __mem_cgroup_uncharge(struct page *page)
 {
 	struct uncharge_gather ug;
 
-	if (mem_cgroup_disabled())
-		return;
-
 	/* Don't touch page->lru of any random page, pre-check: */
 	if (!page_memcg(page))
 		return;
@@ -6938,20 +6932,17 @@ void mem_cgroup_uncharge(struct page *page)
 }
 
 /**
- * mem_cgroup_uncharge_list - uncharge a list of page
+ * __mem_cgroup_uncharge_list - uncharge a list of page
  * @page_list: list of pages to uncharge
  *
  * Uncharge a list of pages previously charged with
  * mem_cgroup_charge().
  */
-void mem_cgroup_uncharge_list(struct list_head *page_list)
+void __mem_cgroup_uncharge_list(struct list_head *page_list)
 {
 	struct uncharge_gather ug;
 	struct page *page;
 
-	if (mem_cgroup_disabled())
-		return;
-
 	uncharge_gather_clear(&ug);
 	list_for_each_entry(page, page_list, lru)
 		uncharge_page(page, &ug);
-- 
2.32.0.93.g670b81a890-goog

