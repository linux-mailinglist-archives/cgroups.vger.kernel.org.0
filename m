Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEADC3C67E0
	for <lists+cgroups@lfdr.de>; Tue, 13 Jul 2021 03:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbhGMBMe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jul 2021 21:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbhGMBMd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jul 2021 21:12:33 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7BBC0613DD
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:09:44 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id o189-20020a378cc60000b02903b2ccd94ea1so15573260qkd.19
        for <cgroups@vger.kernel.org>; Mon, 12 Jul 2021 18:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=GVgy78Y4XH5cKdFUoC55+OC486NwPMBxiv8zZWv7bfY=;
        b=rTbNMSzuL2c2s+SMmiQn/vo/SmZsGY+OXkBGAmvHywWnVW/URmqQ0RI383JRllnj0g
         /Rgg9ahp4PmJVJfmhYHoDdwgpVoqHOW7CDS7rKPdn0+cGvbn/snoF9GCBhg1uiqWT9qe
         43PBwfiIlYRPZEiXNO6L/bQhFZLTXhl3q1rBuTazBFbrIcS6ashHR8TI3ejZXN/+67qF
         /+fnl5fqxgXZO19rd7/Iv4KOhZTISnV77Hla7Q49CH2r/Hracy8Sa9p7sUx7g69DDiLf
         40gs9q2RTcEOIDoqcVOBMQoSikn/FykSFTUWz1XCCTFAn5AiVv+nfMNeup81sN3KERDA
         fEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GVgy78Y4XH5cKdFUoC55+OC486NwPMBxiv8zZWv7bfY=;
        b=WJsVax1QGqHg7lzycuLTdc4mnFWcdL40GqJ+wx/gNlFWDMurNq5LozdEobn+Df0AcM
         cHAV8IrrkrRQzGOR7+n5Enz8cO4xQHbwDHBxXMkocPiufs1dBQdNu+VXb6cRnmhvm+IA
         GG0X3x7qbUSLKaGPlKpQxbCF9eiKZjc9Qjx0mswFeHZT04t4gf9Txfkza3rGlpb2LhD3
         Kdbfuyhq33pebyhhMHahXkbh3NOC1YJ7HIxKr687gvY72xLIClg6Q8u0hJ8w4E6nDBve
         v33KwxNlZolybJbQHVd1QshuUAjexEBkWxbnAYUZayM8fJjdatMM9+w4iJpdyUqKUFmK
         lG6Q==
X-Gm-Message-State: AOAM531jGAHupaEORNBZYWIjX2GHj6n0artOjOUtEQHkzqvOI66O4NLU
        YMXMG6YTlvx75Ebg/psVn+ROJJI9v0w=
X-Google-Smtp-Source: ABdhPJyjUESs588030M5v+lLeh6WjvewH3DZcGV9RsmwjkEGb+fdJhU9dJwttvo6+TJFHFNMxA2VaZGZz94=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:2a5a:e173:9576:794e])
 (user=surenb job=sendgmr) by 2002:ad4:5bec:: with SMTP id k12mr2263862qvc.5.1626138582967;
 Mon, 12 Jul 2021 18:09:42 -0700 (PDT)
Date:   Mon, 12 Jul 2021 18:09:34 -0700
In-Reply-To: <20210713010934.299876-1-surenb@google.com>
Message-Id: <20210713010934.299876-3-surenb@google.com>
Mime-Version: 1.0
References: <20210713010934.299876-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v4 3/3] mm, memcg: inline swap-related functions to improve
 disabled memcg config
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

Inline mem_cgroup_try_charge_swap, mem_cgroup_uncharge_swap and
cgroup_throttle_swaprate functions to perform mem_cgroup_disabled static
key check inline before calling the main body of the function. This
minimizes the memcg overhead in the pagefault and exit_mmap paths when
memcgs are disabled using cgroup_disable=memory command-line option.
This change results in ~1% overhead reduction when running PFT test [1]
comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
configuration on an 8-core ARM64 Android device.

[1] https://lkml.org/lkml/2006/8/29/294 also used in mmtests suite

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Michal Hocko <mhocko@suse.com>
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
index 6adf50acdbe2..b8aab1900995 100644
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

