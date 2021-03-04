Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800F932CA23
	for <lists+cgroups@lfdr.de>; Thu,  4 Mar 2021 02:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhCDBnq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 Mar 2021 20:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbhCDBne (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 Mar 2021 20:43:34 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89276C061756
        for <cgroups@vger.kernel.org>; Wed,  3 Mar 2021 17:42:53 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id b78so18246435qkg.13
        for <cgroups@vger.kernel.org>; Wed, 03 Mar 2021 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/y8akNG1DgiTdfrJxBTeisB7ZHUVtQmD2LTrAqUe9Rc=;
        b=pRuHjSLtrINXjcaRHUknD2x66XzH2lKt75rlaw+GMEzKk6LpreODAay8rCA8X5pQPk
         gcT7zeVVLlFide7EBT7jKo5DShiOrQBaKkWftDhyI+uz+q/+1AODQc4NJr8AkADlw35H
         o+xXKOVbbUYi5XUmuwXkwyVYy67X/wyagrybe3eZfQFa9EF73G58le9g6qzjteuH4tbW
         gXD89LH82cefAizQt3fwyEMLdZ/FxKBW+YfyC2kctAbSfoSOHRIDXigkn8LuCwSv9Ii+
         jw7qATtGDOCqEd9NG8HxWoEYwB5xwJ0AbtTecwPIVkDFWZu9qRdQSee6qUytxU2GsZQN
         4UlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/y8akNG1DgiTdfrJxBTeisB7ZHUVtQmD2LTrAqUe9Rc=;
        b=cg3SRpFtEqdhtMnPVMjoXtbP35OABiBzJnxaQGso2Blf+Olxel8sz8reafUp3lqtgn
         BGoQeUY6gJQav7iLOz7CY0ZvsNaW52tzXj+NX78dXfCJ2lkZNVdzDayD2J5uDvmh1l8L
         W6sX0TIgLgqacR1BsWvIBWlKx7TYmhI2sY9T/5p/UYZI/2wTe1nD3xQ1NnQM6ID3Zc+Y
         mJf7FjKdZtotOucNV+adIiBRJ21sPpNklP0HeV2AMVGUE6SsnkQf3VLJ0zxKaPSG7une
         ttKADNb/jmrDxbOY1nGlVQu+7pA48GTsaQHk7zVDRDwtig2KdDlLX6Xarqa+MfkdB5b4
         HGHg==
X-Gm-Message-State: AOAM5339C1EPtVt8FAFK/1ZOO0mURRVhQMNen/Gxp726OlcuW6UnY00i
        ITdH4y1vp2X8QS7MhhEkn02pe/2uHqWOXA==
X-Google-Smtp-Source: ABdhPJzEfJTbRoRRZjuPDqwSE1xvEUNN3nZNxtvUkE4GY78x6gDDJbP9FFiLvNQ0xe8dXOMozMT5qT8YZq+Tqw==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:5df8:a0bb:52b8:486c])
 (user=shakeelb job=sendgmr) by 2002:a05:6214:1103:: with SMTP id
 e3mr2189923qvs.12.1614822172690; Wed, 03 Mar 2021 17:42:52 -0800 (PST)
Date:   Wed,  3 Mar 2021 17:42:29 -0800
Message-Id: <20210304014229.521351-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v3] memcg: charge before adding to swapcache on swapin
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
Changes since v2:
- fixed build for !CONFIG_MEMCG
- simplified failure path from add_to_swap_cache()

Changes since v1:
- Removes __GFP_NOFAIL and introduced transaction interface for charging
  (suggested by Johannes)
- Updated the commit message

 include/linux/memcontrol.h |  14 +++++
 mm/memcontrol.c            | 116 +++++++++++++++++++++++--------------
 mm/memory.c                |  14 ++---
 mm/swap_state.c            |  13 ++---
 4 files changed, 97 insertions(+), 60 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..d31e6dca397f 100644
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
+			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry)
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
index 3cdee7b11da9..e69a8df7da33 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -497,16 +497,14 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__SetPageLocked(page);
 	__SetPageSwapBacked(page);
 
-	/* May fail (-ENOMEM) if XArray node allocation failed. */
-	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow)) {
-		put_swap_page(page, entry);
+	if (mem_cgroup_charge_swapin_page(page, NULL, gfp_mask, entry))
 		goto fail_unlock;
-	}
 
-	if (mem_cgroup_charge(page, NULL, gfp_mask)) {
-		delete_from_swap_cache(page);
+	/* May fail (-ENOMEM) if XArray node allocation failed. */
+	if (add_to_swap_cache(page, entry, gfp_mask & GFP_RECLAIM_MASK, &shadow))
 		goto fail_unlock;
-	}
+
+	mem_cgroup_finish_swapin_page(page, entry);
 
 	if (shadow)
 		workingset_refault(page, shadow);
@@ -517,6 +515,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	return page;
 
 fail_unlock:
+	put_swap_page(page, entry);
 	unlock_page(page);
 	put_page(page);
 	return NULL;
-- 
2.30.1.766.gb4fecdf3b7-goog

