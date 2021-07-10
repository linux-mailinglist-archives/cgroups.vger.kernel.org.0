Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B4D3C2C1C
	for <lists+cgroups@lfdr.de>; Sat, 10 Jul 2021 02:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbhGJAjW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 9 Jul 2021 20:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbhGJAjT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 9 Jul 2021 20:39:19 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DE1C0613DD
        for <cgroups@vger.kernel.org>; Fri,  9 Jul 2021 17:36:35 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u40-20020a0cb9280000b0290290c3a9f6f1so7545124qvf.0
        for <cgroups@vger.kernel.org>; Fri, 09 Jul 2021 17:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=opU13ZvqFbTIG3+3YPtm0KlTLmzXrEdtRDIHVvzw01I=;
        b=B3gFAAegNZq5hS0hJtoWZL9U6vmEBhkZxndT53wJ6PDDklVJOLme2gmDWRYbOFu2+9
         o3yn9IacVVmn+JEjdy2K8fwIOZOOKvXXjoo+JjcOtquzqA0BDiFocJlp5c57Lte2LuM4
         PvtegrcSPsKjuWE6h148+opRC/Yis1IzzjmO6UYJIDq7Pev3SO6Xme3ts0jNB4d4c4mM
         KxiK7AXRuJY4SBplJbEV3EFZ9/+a2Gf+XDxKFiazinpHbjyWlf6CcBuPozRj641pPKcS
         VNMJ05R1ndOBDLVv02UCRVNENDl8RNCFbEwCpmEVXGypqJNslqiE0HADW6C0mAcRRjkH
         z2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=opU13ZvqFbTIG3+3YPtm0KlTLmzXrEdtRDIHVvzw01I=;
        b=r98YTWvaVdScvXFGPfoJXgJv9dESj59SDdcvsCXDiA5yn92GI5bY7iz/G6McypIHED
         R1C7ynO9FnD7o+SnFdnmm8+i24/XTHsLdphKuUx4g73cGroG10it/HcaSaEJZBJZFzSD
         uF1k2afnRo4xNhx6LG+Ddu8f93fmV3l5DOWWHtDY3DLggfSEy3iEmXGhkcDlohto17Qh
         56kYsEIzHIzI6Gvqd4jG0LmOCqFO2Pu319DPtSZLm6gGy420uaf0cc2JPzKGT4UVveYb
         TzQk/AZQFpBTeOmmXhgBwzXsZOGd59S+1M/zwXeA1WPBrX4DfU+NKxlhlUrRiXnEB1ex
         7x+Q==
X-Gm-Message-State: AOAM532IpYnSvGBbpKl/jWVUR0QFmQwHYwk20aqxhs3cHS4AF5mm4fTO
        K1Ho4pgxeObsAswV5Qr/OEQG9xBZZIU=
X-Google-Smtp-Source: ABdhPJyVBm5z1WMOwGpSlEi9aG7dUs47ZDqEc0D2JeL1EI46btts7VM/LuH6Y+Ds97z+s+YNP27LfmafiHw=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:9f62:e8e9:4de2:f00a])
 (user=surenb job=sendgmr) by 2002:a05:6214:1631:: with SMTP id
 e17mr15837096qvw.16.1625877394878; Fri, 09 Jul 2021 17:36:34 -0700 (PDT)
Date:   Fri,  9 Jul 2021 17:36:26 -0700
In-Reply-To: <20210710003626.3549282-1-surenb@google.com>
Message-Id: <20210710003626.3549282-3-surenb@google.com>
Mime-Version: 1.0
References: <20210710003626.3549282-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v3 3/3] mm, memcg: inline swap-related functions to improve
 disabled memcg config
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

Inline mem_cgroup_try_charge_swap, mem_cgroup_uncharge_swap and
cgroup_throttle_swaprate functions to perform mem_cgroup_disabled static
key check inline before calling the main body of the function. This
minimizes the memcg overhead in the pagefault and exit_mmap paths when
memcgs are disabled using cgroup_disable=memory command-line option.
This change results in ~1% overhead reduction when running PFT test
comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
configuration on an 8-core ARM64 Android device.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/swap.h | 26 +++++++++++++++++++++++---
 mm/memcontrol.c      | 14 ++++----------
 mm/swapfile.c        |  5 +----
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6f5a43251593..f30d26b0f71d 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -721,7 +721,13 @@ static inline int mem_cgroup_swappiness(struct mem_cgroup *mem)
 #endif
 
 #if defined(CONFIG_SWAP) && defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-extern void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
+extern void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask);
+static inline  void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__cgroup_throttle_swaprate(page, gfp_mask);
+}
 #else
 static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 {
@@ -730,8 +736,22 @@ static inline void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 
 #ifdef CONFIG_MEMCG_SWAP
 extern void mem_cgroup_swapout(struct page *page, swp_entry_t entry);
-extern int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
-extern void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
+extern int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry);
+static inline int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
+{
+	if (mem_cgroup_disabled())
+		return 0;
+	return __mem_cgroup_try_charge_swap(page, entry);
+}
+
+extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
+static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
+{
+	if (mem_cgroup_disabled())
+		return;
+	__mem_cgroup_uncharge_swap(entry, nr_pages);
+}
+
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct page *page);
 #else
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cdaf7003b43d..0b05322836ec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7234,7 +7234,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 }
 
 /**
- * mem_cgroup_try_charge_swap - try charging swap space for a page
+ * __mem_cgroup_try_charge_swap - try charging swap space for a page
  * @page: page being added to swap
  * @entry: swap entry to charge
  *
@@ -7242,16 +7242,13 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
  *
  * Returns 0 on success, -ENOMEM on failure.
  */
-int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
+int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 {
 	unsigned int nr_pages = thp_nr_pages(page);
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
-	if (mem_cgroup_disabled())
-		return 0;
-
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
@@ -7287,18 +7284,15 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 }
 
 /**
- * mem_cgroup_uncharge_swap - uncharge swap space
+ * __mem_cgroup_uncharge_swap - uncharge swap space
  * @entry: swap entry to uncharge
  * @nr_pages: the amount of swap space to uncharge
  */
-void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
+void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 {
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	if (mem_cgroup_disabled())
-		return;
-
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 707fa0481bb4..04a0c83f1313 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3773,14 +3773,11 @@ static void free_swap_count_continuations(struct swap_info_struct *si)
 }
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
-void cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
+void __cgroup_throttle_swaprate(struct page *page, gfp_t gfp_mask)
 {
 	struct swap_info_struct *si, *next;
 	int nid = page_to_nid(page);
 
-	if (mem_cgroup_disabled())
-		return;
-
 	if (!(gfp_mask & __GFP_IO))
 		return;
 
-- 
2.32.0.93.g670b81a890-goog

