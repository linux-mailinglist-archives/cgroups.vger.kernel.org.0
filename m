Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D733C2C19
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 02:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGJAjT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 20:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhGJAjR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 20:39:17 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678F5C0613E5
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 17:36:33 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id t21-20020a05622a1495b02901e65f85117bso3644146qtx.18
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 17:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lGECd4YNDKupd8BNu5/j/OFnfVdaVr7qkXOLQ2yf+4c=;
        b=EDuXO1JpxSPl3zLyGTCPY37N16B4Ezsy0GNzFdTeAj4DKspnA4XXMzSqr755a3CRdz
         asUYkF4Lr+4qltlSsyytVNrVckmomw1qEmHunDL7Yw6A7RsPbkuEXfKhY+zYhM6ELpRX
         CNnBnLRJF+3xfZJLfeYAhYmHvEWgCX5wyD4t4RsO2M7BxnuXX09ywz0nvZqIbVTvIQXh
         nLz04JYlXa+slmyn/gEmoPPNV5E7eLxQYSJyU4pVlRn0oPmRExiBuObP9ZprVA6oIO+P
         6c6eqbv4SMgC+Aas6j4m6VGDeu6zuosUx5ktURVB+liI8lih/GpRIfdW5yzSfvWFWWV4
         0pYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lGECd4YNDKupd8BNu5/j/OFnfVdaVr7qkXOLQ2yf+4c=;
        b=EQEEZ121iFv//gvYcNRag3nLUV6fUQ0PXH55CP2Fq4Np4DIVd8F6IVc3YjF0bo0VhP
         kjF4hLf3zvIhvmAOzLxbsD3lnhH/HhiBnTok/KE7BbYPYBxRYwRYkjEjONvkNbpMOhtb
         Qcj0u2yBQ16jFeuPOvgoVjfRT4jInkQlIjej0XoTU2psny3lMtrtQT865r2B6uZPiabA
         0+aS606hyL6L/1ml4AsCZR4XZNkK3YZfEKFHU0DgX/gbi9J0SrhPHUlB95GTMbO/Ugmc
         C7jLJSFIZpWlcoqkOAZrC6HCMDLN7XKsVDssHiboAjbivH8BBZB3Fzwp4lTNnXwUoqPl
         UpRg==
X-Gm-Message-State: AOAM533hbiNQt6mjzSWJjD1UbcOGRntcDSIld+36i0oIa4quK2x03wuc
        b+0837MQIfaZl5Pz60ar2F78RXdCm/Y=
X-Google-Smtp-Source: ABdhPJyOe5Z3XOBl15HHySEI4TUGeIbGHg+d+K6gfBVD6RdhYgaFx89ODyx1xdvYeoixLQ5TaU9KdCQhYHY=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:9f62:e8e9:4de2:f00a])
 (user=surenb job=sendgmr) by 2002:ad4:5444:: with SMTP id h4mr38984070qvt.14.1625877392468;
 Fri, 09 Jul 2021 17:36:32 -0700 (PDT)
Date:   Fri,  9 Jul 2021 17:36:25 -0700
In-Reply-To: <20210710003626.3549282-1-surenb@google.com>
Message-Id: <20210710003626.3549282-2-surenb@google.com>
Mime-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 2/3] mm, memcg: inline mem_cgroup_{charge/uncharge} to
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
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

