Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FD13C67DE
	for <lists+cgroups@lfdr.de>; Tue, 13 Jul 2021 03:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhGMBMc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 21:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhGMBMa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 21:12:30 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C77BC0613DD
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:09:41 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id i190-20020a3786c70000b02903b54f40b442so15640693qkd.0
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VHC+YzAQlppaneCSXMJd1zGWtOqB6UoQTAIsnf0LqyQ=;
        b=B96QMnD0FPaSmeEsppXsVd3HAhgPo4nyv4JECcEg7l+oShKYLwOpMGC/sUCjQbXWRl
         oks73mO0TPAgR6iq9peBltmQkRiVWIWrTRmZYSzElLXllQyDKnqgOTbk6y67vuRC0rI8
         c9UsXgvDYat3KZvFpDZWBv0Vasmht7AvEHzy93lcn3z+HRpPEzKHh2f4NlLZ3vUsa47O
         lfqTyCrtAbui11u0enmycqLCQjhOmYFHe6rOdHA43YSu92ycgFJEpDOVtBNblhWvuugU
         NjYhM61KfqFe0oBF1KW0OtoiQw3QlTw6VW9jGQmM8vuClVFM8B84JK+d3jsuhXIYmbrn
         WLpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VHC+YzAQlppaneCSXMJd1zGWtOqB6UoQTAIsnf0LqyQ=;
        b=JGpK/mM8NL9fxB3jAKsXwESWIEea++BAljkMUqqb/2jOCczQobWVo8aJHQtOBnyeMU
         0Y+03d3lnXVr3znB6iomfxaBJMKOpX2i2MbAKlg5KHEw9jOuvasPUdnod58fppLKxaxY
         FLLMAWYFqPaGtjJtEHONGlOQugl6F383njhVa2yILsXS3sYOYp9cGsuSWo1M3zM2MMJl
         ALiM54CO6WtySWS8HbNCYuZkLKnMC7sN6xLpV83eQ403XO9zVD0XXWqoouHyYqf13bum
         GP0rJ5yPbX1pFU3cUETWiSkkZ9tqXdIidioqYUvfd3y7X04fUZ6cPs6NVjeSBkoonasz
         skZQ==
X-Gm-Message-State: AOAM531TnJy+3QxjMrDSb66ihwj4gWlGYvy49ZF2ppnEr96sbELKgpQ2
        fhD2GgRR79hTpDtwa1KnSoUEEukyVSU=
X-Google-Smtp-Source: ABdhPJxRLJG0ufJocNQajQsmACrz3wFP0mbch21XtZNh4dx+ecRPXx5GPV1sA8xr9QgLbVfLtsUu4N4++NY=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:2a5a:e173:9576:794e])
 (user=surenb job=sendgmr) by 2002:a05:6214:27e7:: with SMTP id
 jt7mr2315244qvb.28.1626138580442; Mon, 12 Jul 2021 18:09:40 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:09:33 -0700
In-Reply-To: <20210713010934.299876-1-surenb@google.com>
Message-Id: <20210713010934.299876-2-surenb@google.com>
Mime-Version: 1.0
References: <20210713010934.299876-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v4 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
 improve disabled memcg config
From:   Suren Baghdasaryan <surenb@google.com>
To:     tj@kernel.org
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, mhocko@suse.com,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        shakeelb@google.com, guro@fb.com, songmuchun@bytedance.com,
        shy828301@gmail.com, alexs@kernel.org, richard.weiyang@gmail.com,
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
This change results in ~0.4% overhead reduction when running PFT test [1]
comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
configuration on an 8-core ARM64 Android device.

[1] https://lkml.org/lkml/2006/8/29/294 also used in mmtests suite

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 28 +++++++++++++++++++++++++---
 mm/memcontrol.c            | 33 ++++++++++++---------------------
 2 files changed, 37 insertions(+), 24 deletions(-)

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
index a228cd51c4bd..6adf50acdbe2 100644
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
- * Uncharge a page previously charged with mem_cgroup_charge().
+ * Uncharge a page previously charged with __mem_cgroup_charge().
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
- * mem_cgroup_charge().
+ * __mem_cgroup_charge().
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

