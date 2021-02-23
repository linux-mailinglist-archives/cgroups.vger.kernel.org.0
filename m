Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1BF32259D
	for <lists+cgroups@lfdr.de>; Tue, 23 Feb 2021 06:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhBWF4P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 23 Feb 2021 00:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbhBWFz4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 23 Feb 2021 00:55:56 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682B1C061574
        for <cgroups@vger.kernel.org>; Mon, 22 Feb 2021 21:55:16 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o4so981762pjp.3
        for <cgroups@vger.kernel.org>; Mon, 22 Feb 2021 21:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GraTumaBJkKJQ9u22jVkHqKEy5q/8MUh2zxLlp3bkMw=;
        b=mlLr7TLkrLx+Rk92G4tH5XwC6B/SUpZurSFzMG3FqiYVoSARCZHnfom+k6wwf6zLFr
         8tuMk5mKE24yblwMee2PmDHM623gkoTkrleETBBD6ereP74g7sZeODt53TFW6YYP5CzO
         ZJk8WUYp3eGT1Pi6V2oGyIkiO5dkoiJGQ5b6C06WDIgsObaYjLjOknG6JWiT5fLK1ta9
         maFpu9MWZGMaXd8ll09/5VLTVcNzPyKhVxstH1KYWw54rRhYhuRdVXzVLuYsUFWvtWhX
         3X9RfPSW3gtHl24rSTyC+hr5p2+rxzBCx1wH4TjvBerdzT03emfQfBavpeNVaK9U1V9C
         xSIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GraTumaBJkKJQ9u22jVkHqKEy5q/8MUh2zxLlp3bkMw=;
        b=qe+YJVLJ3jG0QfQj9OTmb58sRP7y99YceBiKO43DesULzQR2uuDyEhBizASjqQWWAO
         xck5ni1lN3bvCzpwaSdFkvbsMbYkZbvqdVkZnG97XIYwrfQGVsemxdKJrQ5TsVpZABX5
         e5lIruaHbQpjqXB3/Pgor9MsUfBG3vzwKzHxKdi/hdolwQaprhcg26zasxNaUWorPgfB
         ry7/AAqlLYkcdujDx7CYAjpJIOXQ/qzNZYc9PklvdpB8CZqYcTGjyTDS5swGPMmvkRla
         lVpFGXdFZunhGeHdhE/WjnxgrnjAtlCB7L3sL6VOgl8/v8jH1CkQ+nodllNU0X5+R95b
         1nGA==
X-Gm-Message-State: AOAM5325nSsq4ztW9QoO/cgH66VjkY5EWLuXgE5BIcsJSEvLvDKv3LK1
        Vj49d5Mo3nXH1T+oaGOJQrujzyTzH5xxbQ==
X-Google-Smtp-Source: ABdhPJxr415/due1RPqAUN1I+8CTWEPv4jZ2W+CLDvUzNW3IWprWUAjzmUWRZ6J1u6y/2woM/K42PzA6GPt6Ag==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:dcc:e59c:6d4b:fd65])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:4a84:: with SMTP id
 f4mr27825277pjh.231.1614059715750; Mon, 22 Feb 2021 21:55:15 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:55:05 -0800
Message-Id: <20210223055505.2594953-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2] memcg: charge before adding to swapcache on swapin
From:   Shakeel Butt <shakeelb@google.com>
To:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently the kernel adds the page, allocated for swapin, to the
swapcache before charging the page. This is fine but now we want a
per-memcg swapcache stat which is essential for folks who wants to
transparently migrate from cgroup v1's memsw to cgroup v2's memory and
swap counters. In addition charging a page before exposing it to other
parts of the kernel is a step in the right direction.

To correctly maintain the per-memcg swapcache stat, this patch has
adopted to charge the page before adding it to swapcache. One
challenge in this option is the failure case of add_to_swap_cache() on
which we need to undo the mem_cgroup_charge(). Specifically undoing
mem_cgroup_uncharge_swap() is not simple.

To resolve the issue, this patch introduces transaction like interface
to charge a page for swapin. The function mem_cgroup_charge_swapin_page()
initiates the charging of the page and mem_cgroup_finish_swapin_page()
completes the charging process. So, the kernel starts the charging
process of the page for swapin with mem_cgroup_charge_swapin_page(),
adds the page to the swapcache and on success completes the charging
process with mem_cgroup_finish_swapin_page().

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- Removes __GFP_NOFAIL and introduced transaction interface for charging
  (suggested by Johannes)
- Updated the commit message

 include/linux/memcontrol.h |  14 +++++
 mm/memcontrol.c            | 116 +++++++++++++++++++++++--------------
 mm/memory.c                |  14 ++---
 mm/swap_state.c            |  11 ++--
 4 files changed, 97 insertions(+), 58 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..585d96bda4f5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -596,6 +596,9 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 }
 
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
+int mem_cgroup_charge_swapin_page(struct page *page, struct mm_struct *mm,
+				  gfp_t gfp, swp_entry_t entry);
+void mem_cgroup_finish_swapin_page(struct page *page, swp_entry_t entry);
 
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
@@ -1141,6 +1144,17 @@ static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mem_cgroup_charge_swapin_page(struct page *page,
+			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry);
+{
+	return 0;
+}
+
+static inline void mem_cgroup_finish_swapin_page(struct page *page,
+						 swp_entry_t entry)
+{
+}
+
 static inline void mem_cgroup_uncharge(struct page *page)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2db2aeac8a9e..226b7bccb44c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6690,6 +6690,27 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 			atomic_long_read(&parent->memory.children_low_usage)));
 }
 
+static int __mem_cgroup_charge(struct page *page, struct mem_cgroup *memcg,
+			       gfp_t gfp)
+{
+	unsigned int nr_pages = thp_nr_pages(page);
+	int ret;
+
+	ret = try_charge(memcg, gfp, nr_pages);
+	if (ret)
+		goto out;
+
+	css_get(&memcg->css);
+	commit_charge(page, memcg);
+
+	local_irq_disable();
+	mem_cgroup_charge_statistics(memcg, page, nr_pages);
+	memcg_check_events(memcg, page);
+	local_irq_enable();
+out:
+	return ret;
+}
+
 /**
  * mem_cgroup_charge - charge a newly allocated page to a cgroup
  * @page: page to charge
@@ -6699,55 +6720,70 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
  * Try to charge @page to the memcg that @mm belongs to, reclaiming
  * pages according to @gfp_mask if necessary.
  *
+ * Do not use this for pages allocated for swapin.
+ *
  * Returns 0 on success. Otherwise, an error code is returned.
  */
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 {
-	unsigned int nr_pages = thp_nr_pages(page);
-	struct mem_cgroup *memcg = NULL;
-	int ret = 0;
+	struct mem_cgroup *memcg;
+	int ret;
 
 	if (mem_cgroup_disabled())
-		goto out;
+		return 0;
 
-	if (PageSwapCache(page)) {
-		swp_entry_t ent = { .val = page_private(page), };
-		unsigned short id;
+	memcg = get_mem_cgroup_from_mm(mm);
+	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
+	css_put(&memcg->css);
 
-		/*
-		 * Every swap fault against a single page tries to charge the
-		 * page, bail as early as possible.  shmem_unuse() encounters
-		 * already charged pages, too.  page and memcg binding is
-		 * protected by the page lock, which serializes swap cache
-		 * removal, which in turn serializes uncharging.
-		 */
-		VM_BUG_ON_PAGE(!PageLocked(page), page);
-		if (page_memcg(compound_head(page)))
-			goto out;
+	return ret;
+}
 
-		id = lookup_swap_cgroup_id(ent);
-		rcu_read_lock();
-		memcg = mem_cgroup_from_id(id);
-		if (memcg && !css_tryget_online(&memcg->css))
-			memcg = NULL;
-		rcu_read_unlock();
-	}
+/**
+ * mem_cgroup_charge_swapin_page - charge a newly allocated page for swapin
+ * @page: page to charge
+ * @mm: mm context of the victim
+ * @gfp: reclaim mode
+ * @entry: swap entry for which the page is allocated
+ *
+ * This function marks the start of the transaction of charging the page for
+ * swapin. Complete the transaction with mem_cgroup_finish_swapin_page().
+ *
+ * Returns 0 on success. Otherwise, an error code is returned.
+ */
+int mem_cgroup_charge_swapin_page(struct page *page, struct mm_struct *mm,
+				  gfp_t gfp, swp_entry_t entry)
+{
+	struct mem_cgroup *memcg;
+	unsigned short id;
+	int ret;
 
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(mm);
+	if (mem_cgroup_disabled())
+		return 0;
 
-	ret = try_charge(memcg, gfp_mask, nr_pages);
-	if (ret)
-		goto out_put;
+	id = lookup_swap_cgroup_id(entry);
+	rcu_read_lock();
+	memcg = mem_cgroup_from_id(id);
+	if (!memcg || !css_tryget_online(&memcg->css))
+		memcg = get_mem_cgroup_from_mm(mm);
+	rcu_read_unlock();
 
-	css_get(&memcg->css);
-	commit_charge(page, memcg);
+	ret = __mem_cgroup_charge(page, memcg, gfp);
 
-	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, page, nr_pages);
-	memcg_check_events(memcg, page);
-	local_irq_enable();
+	css_put(&memcg->css);
+	return ret;
+}
 
+/*
+ * mem_cgroup_finish_swapin_page - complete the swapin page charge transaction
+ * @page: page charged for swapin
+ * @entry: swap entry for which the page is charged
+ *
+ * This function completes the transaction of charging the page allocated for
+ * swapin.
+ */
+void mem_cgroup_finish_swapin_page(struct page *page, swp_entry_t entry)
+{
 	/*
 	 * Cgroup1's unified memory+swap counter has been charged with the
 	 * new swapcache page, finish the transfer by uncharging the swap
@@ -6760,20 +6796,14 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 	 * correspond 1:1 to page and swap slot lifetimes: we charge the
 	 * page to memory here, and uncharge swap when the slot is freed.
 	 */
-	if (do_memsw_account() && PageSwapCache(page)) {
-		swp_entry_t entry = { .val = page_private(page) };
+	if (!mem_cgroup_disabled() && do_memsw_account()) {
 		/*
 		 * The swap entry might not get freed for a long time,
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, nr_pages);
+		mem_cgroup_uncharge_swap(entry, thp_nr_pages(page));
 	}
-
-out_put:
-	css_put(&memcg->css);
-out:
-	return ret;
 }
 
 struct uncharge_gather {
diff --git a/mm/memory.c b/mm/memory.c
index c8e357627318..4cd3cd95bb70 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3307,21 +3307,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			page = alloc_page_vma(GFP_HIGHUSER_MOVABLE, vma,
 							vmf->address);
 			if (page) {
-				int err;
-
 				__SetPageLocked(page);
 				__SetPageSwapBacked(page);
-				set_page_private(page, entry.val);
-
-				/* Tell memcg to use swap ownership records */
-				SetPageSwapCache(page);
-				err = mem_cgroup_charge(page, vma->vm_mm,
-							GFP_KERNEL);
-				ClearPageSwapCache(page);
-				if (err) {
+
+				if (mem_cgroup_charge_swapin_page(page,
+					vma->vm_mm, GFP_KERNEL, entry)) {
 					ret = VM_FAULT_OOM;
 					goto out_page;
 				}
+				mem_cgroup_finish_swapin_page(page, entry);
 
 				shadow = get_shadow_from_swap_cache(entry);
 				if (shadow)
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3cdee7b11da9..27a7acbcf880 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -497,16 +497,16 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__SetPageLocked(page);
 	__SetPageSwapBacked(page);
 
+	if (mem_cgroup_charge_swapin_page(page, NULL, gfp_mask, entry))
+		goto fail_unlock;
+
 	/* May fail (-ENOMEM) if XArray node allocation failed. */
 	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow)) {
-		put_swap_page(page, entry);
+		mem_cgroup_uncharge(page);
 		goto fail_unlock;
 	}
 
-	if (mem_cgroup_charge(page, NULL, gfp_mask)) {
-		delete_from_swap_cache(page);
-		goto fail_unlock;
-	}
+	mem_cgroup_finish_swapin_page(page, entry);
 
 	if (shadow)
 		workingset_refault(page, shadow);
@@ -517,6 +517,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	return page;
 
 fail_unlock:
+	put_swap_page(page, entry);
 	unlock_page(page);
 	put_page(page);
 	return NULL;
-- 
2.30.0.617.g56c4b15f3c-goog

