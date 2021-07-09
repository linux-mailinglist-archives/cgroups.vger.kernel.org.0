Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345903C1C60
	for <lists+cgroups@lfdr.de>; Fri,  9 Jul 2021 02:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGIAIF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Jul 2021 20:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhGIAID (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 8 Jul 2021 20:08:03 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A3EC061574
        for <cgroups@vger.kernel.org>; Thu,  8 Jul 2021 17:05:21 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t144-20020a3746960000b02903ad9c5e94baso4970325qka.16
        for <cgroups@vger.kernel.org>; Thu, 08 Jul 2021 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jhuZ3xbmwvygLf83CLhmdeU2lS+ILnD+96Bl12UNwwQ=;
        b=v6/1TR9Jp9q8MB8LmdT7od76ysRCArOyT9FO2mXwU1jNjU7hqKQM0aKLiOhZn9sRsb
         pyVKA5YohGGjVAtswwGrlI7xo/9PENSs/7IfiwKmwEUJxYioxTKvavlDDqjdfJ9QIJBZ
         rJYJm+jb8ylIi0IGjFWnzXYuF/3tyLL16UxipfYvOtFR3FVWfZ5eZ3quPLTXhYWPEh73
         Ye8DNpWqNb7yfL4uEGqljolcxoU7cTEb6cmiqrgLx0xLqqD/ay4gcAkPvvF8c5ELWrI2
         y/DfYPUrgKqhMNY/sWN+VhCbsLMnzZMsF7HyxX66apExhzA23EXaCisNBfuqEtRK214X
         DJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jhuZ3xbmwvygLf83CLhmdeU2lS+ILnD+96Bl12UNwwQ=;
        b=Yu7WHkbhI45cY8EP6LadqrlmlCL8pfb/3S2S7NRNSVKOzFGpoQwBGRwHkdydsXSVzn
         SKTX+Y4FJIuIEIE9HhG2eL4qGUknGRZh/lI3XN9az9sYRQMViClFFe7qflDAtP48oSCh
         WueKs7cCXOfUVrLEDdUEEX2JfrTTRZJCrIRqgzaavQJgn/qjBW0t1Pt6pUGiKAP4q3fO
         jzJPTXlzXJvB5e9rzC7esob58rVM47wDKShvVW1SAeKnkWw6Tb0M2VmxySEq5ejl8lrk
         tDgDuTsMRdQy8zY76HJdrNPj6whNFMe3/4lWVtHwTb2/qe77mpkQRKpitPBDctJ4N0Ej
         9/nQ==
X-Gm-Message-State: AOAM530EYHrQrAlnCtDDH3gn/CVZ3umPghgSv6GzA47wBXQ55to7r7U7
        JMax3mE/0bhU586zHMZM06yXDbnXySA=
X-Google-Smtp-Source: ABdhPJy1s7QKwgir5ZIETa39TTPGxDdQUJBb1YRH/9if3Ew7PVLazjhBLabI4NL9su//Dnh1qSZzEAZn12Q=
X-Received: from surenb1.mtv.corp.google.com ([2620:15c:211:200:7a7f:fa1f:71a4:365b])
 (user=surenb job=sendgmr) by 2002:ad4:5426:: with SMTP id g6mr32824500qvt.47.1625789120378;
 Thu, 08 Jul 2021 17:05:20 -0700 (PDT)
Date:   Thu,  8 Jul 2021 17:05:09 -0700
In-Reply-To: <20210709000509.2618345-1-surenb@google.com>
Message-Id: <20210709000509.2618345-4-surenb@google.com>
Mime-Version: 1.0
References: <20210709000509.2618345-1-surenb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH 3/3] mm, memcg: inline swap-related functions to improve
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

Inline mem_cgroup_try_charge_swap, mem_cgroup_uncharge_swap and
cgroup_throttle_swaprate functions to perform mem_cgroup_disabled static
key check inline before calling the main body of the function. This
minimizes the memcg overhead in the pagefault and exit_mmap paths when
memcgs are disabled using cgroup_disable=memory command-line option.
This change results in ~1% overhead reduction when running PFT test
comparing {CONFIG_MEMCG=n} against {CONFIG_MEMCG=y, cgroup_disable=memory}
configuration on an 8-core ARM64 Android device.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 include/linux/swap.h | 26 +++++++++++++++++++++++---
 mm/memcontrol.c      | 12 +++---------
 mm/swapfile.c        |  5 +----
 3 files changed, 27 insertions(+), 16 deletions(-)

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
index da677b55b2fe..43f3f50a4751 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -7208,7 +7208,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 }
 
 /**
- * mem_cgroup_try_charge_swap - try charging swap space for a page
+ * __mem_cgroup_try_charge_swap - try charging swap space for a page
  * @page: page being added to swap
  * @entry: swap entry to charge
  *
@@ -7216,16 +7216,13 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
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
 
@@ -7265,14 +7262,11 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
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

