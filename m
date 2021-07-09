Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64233C1C62
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhGIAIF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jul 2021 20:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhGIAIB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jul 2021 20:08:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7036C06175F
        for <cgroups@vger.kernel.org>; Thu,  8 Jul 2021 17:05:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q10-20020a056902150ab02905592911c932so9183385ybu.15
        for <cgroups@vger.kernel.org>; Thu, 08 Jul 2021 17:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bUjUMz6cUI7H8dlLz2s05nSjYMcuDgwip5aFJgPl7pk=;
        b=QNM4PuLJZd/MvfHK1N/nuIGXiMdR0WUAn3o67cSIYU6e0Yn0dY5a91CfXK+8cT7Xo1
         zY90AZROwL+PX+cCbiB75nD85CNafuwwShOD3nfp5eReaf0zvET3tZs/mViUxKteJuj+
         aMH+FnH3IcG9ekUxbm5qSsVTNQ2VPqPp5FPFA62WJNUkRrgLP75omKOyaP64Wf6QhYji
         je3qLPwDa2Z4XjKck3xbCe+sbEvEhc5Kx5Y1Aw7XFFCrG2Xp/hBZw3O56fqZHfh+fw9U
         Fk7QB5Kd5Qfs9NWPXYBXJb/gBlIbcMSU8dGCCfsUgYbCHOQXLvLGNtnzP9lWMu/JrdrM
         e85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bUjUMz6cUI7H8dlLz2s05nSjYMcuDgwip5aFJgPl7pk=;
        b=IC3UaH+L305dCM1Qvn74BBw/Icu9c+dIsEpdD3crLW2jMyfI0DNSrZ8xAPYvA2uHNu
         CKM7sXf+Xy3kjxpbL+3F3VF2VUieX2G9NEyJ6u8oRjtga2azW5STn/NgFJikDy6xXrOi
         +fOiS4xBWffs7UL7XLJCKDSLfDR1kRQopMrGKXZRsRg+YFUw2D4HUH3C4TqbI0Kg7UWk
         wGo8GFFGkmFO3QrsvQKsRX+q4pwKPxeEgsy7Pj+qaJg710A00IwrMg1IPc5S0LohdNnj
         HpuoHjyZ2ULQx/PMwpx5v5T9za7fRRvbC/UXt/7EgKCGIxOsA0suf9hA7gVDBVh2LYC7
         kx7A==
X-Gm-Message-State: AOAM531K6Vb6/Zm9q21MDZk+rHXfCia/j095vaVK4++j+RAQdyl/Oua2
        BfluA8DHgID6o0Yh7z3pHxYoWw3V/pk=
X-Google-Smtp-Source: ABdhPJwTGta8xdNQcTmp1igsFRUbPJSFJMRAgz9qZFkzjghU9O2djnnLnVCUpMpzRbRjqAW1dT8Yl4gEHaw=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:7a7f:fa1f:71a4:365b])
 (user=surenb job=sendgmr) by 2002:a25:df11:: with SMTP id w17mr42318689ybg.314.1625789117804;
 Thu, 08 Jul 2021 17:05:17 -0700 (PDT)
Date:   Thu,  8 Jul 2021 17:05:08 -0700
In-Reply-To: <20210709000509.2618345-1-surenb@google.com>
Message-Id: <20210709000509.2618345-3-surenb@google.com>
Mime-Version: 1.0
References: <20210709000509.2618345-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to improve
 disabled memcg config
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, shakeelb@google.com, guro@fb.com,
        songmuchun@bytedance.com, shy828301@gmail.com, alexs@kernel.org,
        alexander.h.duyck@linux.intel.com, richard.weiyang@gmail.com,
        vbabka@suse.cz, axboe@kernel.dk, iamjoonsoo.kim@lge.com,
        david@redhat.com, willy@infradead.org, apopple@nvidia.com,
        minchan@kernel.org, linmiaohe@huawei.com,
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
 include/linux/memcontrol.h | 54 ++++++++++++++++++++++++++++++++++----
 mm/memcontrol.c            | 43 +++---------------------------
 2 files changed, 53 insertions(+), 44 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..480815feb116 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -693,13 +693,59 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 		page_counter_read(&memcg->memory);
 }
 
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
+struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
+
+int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
+			gfp_t gfp);
+/**
+ * mem_cgroup_charge - charge a newly allocated page to a cgroup
+ * @page: page to charge
+ * @mm: mm context of the victim
+ * @gfp_mask: reclaim mode
+ *
+ * Try to charge @page to the memcg that @mm belongs to, reclaiming
+ * pages according to @gfp_mask if necessary. if @mm is NULL, try to
+ * charge to the active memcg.
+ *
+ * Do not use this for pages allocated for swapin.
+ *
+ * Returns 0 on success. Otherwise, an error code is returned.
+ */
+static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
+				    gfp_t gfp_mask)
+{
+	struct mem_cgroup *memcg;
+	int ret;
+
+	if (mem_cgroup_disabled())
+		return 0;
+
+	memcg = get_mem_cgroup_from_mm(mm);
+	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
+	css_put(&memcg->css);
+
+	return ret;
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
 
@@ -756,8 +802,6 @@ static inline struct lruvec *mem_cgroup_page_lruvec(struct page *page)
 
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p);
 
-struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm);
-
 struct lruvec *lock_page_lruvec(struct page *page);
 struct lruvec *lock_page_lruvec_irq(struct page *page);
 struct lruvec *lock_page_lruvec_irqsave(struct page *page,
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a228cd51c4bd..da677b55b2fe 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6701,8 +6701,8 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
-static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
-			       gfp_t gfp)
+int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
+			gfp_t gfp)
 {
 	unsigned int nr_pages = thp_nr_pages(page);
 	int ret;
@@ -6722,35 +6722,6 @@ static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
 	return ret;
 }
 
-/**
- * mem_cgroup_charge - charge a newly allocated page to a cgroup
- * @page: page to charge
- * @mm: mm context of the victim
- * @gfp_mask: reclaim mode
- *
- * Try to charge @page to the memcg that @mm belongs to, reclaiming
- * pages according to @gfp_mask if necessary. if @mm is NULL, try to
- * charge to the active memcg.
- *
- * Do not use this for pages allocated for swapin.
- *
- * Returns 0 on success. Otherwise, an error code is returned.
- */
-int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
-{
-	struct mem_cgroup *memcg;
-	int ret;
-
-	if (mem_cgroup_disabled())
-		return 0;
-
-	memcg = get_mem_cgroup_from_mm(mm);
-	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
-	css_put(&memcg->css);
-
-	return ret;
-}
-
 /**
  * mem_cgroup_swapin_charge_page - charge a newly allocated page for swapin
  * @page: page to charge
@@ -6921,13 +6892,10 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
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
@@ -6944,14 +6912,11 @@ void mem_cgroup_uncharge(struct page *page)
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

