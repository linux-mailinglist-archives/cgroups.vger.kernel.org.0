Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF0032016F
	for <lists+cgroups@lfdr.de>; Fri, 19 Feb 2021 23:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBSWpB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 19 Feb 2021 17:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBSWpB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 19 Feb 2021 17:45:01 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0C2C061574
        for <cgroups@vger.kernel.org>; Fri, 19 Feb 2021 14:44:21 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id o20so4518769pgu.16
        for <cgroups@vger.kernel.org>; Fri, 19 Feb 2021 14:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=f+jPsQm7BQbbCo3vZbL1OIRiq8am17ZcJ9XzWa+2WI0=;
        b=H8dGYbZjmSEcgf2ZFtrhHydNxDKneTbq2NyanqnRshN8oqRuHArlapIsKvsM3nLFMB
         jZizm/vpQtvejkMNhVBGH2QqGJeGG1J+35iXvPnRphx5n4SaiEwDB9YXYnGpFXJ88ph6
         Gg/RDU4s8nOnELJpojDs3Zg+OZGB2ZL5RhcQfW9J2SIqPeJxxFkFQzW4aiXh5g7pOmAw
         HVD6A+Me99UYg5aa4M9Jut7mX4HclsMDE7GRRvlahTtrS7sNrIMvCbpLlauhqGYg77PZ
         o7h7FceX5Q4ZvLtjyH2CQdeqYaoo78taVIG17/20TP2Pk7vkDOcK4RHNnrcRzxdYdQLJ
         6AFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=f+jPsQm7BQbbCo3vZbL1OIRiq8am17ZcJ9XzWa+2WI0=;
        b=N7U4InG50ODiOS6+I15/MvtsSKOKDWggtlz/5go5DbpSfNEBvj56j9/baK/9Uy7tYr
         vIMVB1hgBRemLRY2PnKK+8IYHfk7iW2CzqWUXyIi1FcW7RtOnu1mQ4NG2SdbI3KDBMXv
         jMiaoT6AtP3YSmaG3KGcqJ+qQ0Pv66t9Isb+ee58aR0/rAABWDFIxEn6Sx68NvklD/3F
         1OSLP2G+8TVcUG0zZTMZhfRJDWSPnlJWhtOvxyEHIhHpHd0g3jr6ePr4bY5gfY8j3BFf
         DzMObdQrVNQW8TZj6J57didvL4W2DwyagtxPTs6ZlLvCyDc6cvOy1AMoYB5NXOWF9lvp
         /G+w==
X-Gm-Message-State: AOAM530/tIuaitDpWV1mxb02prO9fCwy1PUpEcEhxX2aSaZtZ1OFQYGB
        kBQ8udlghMfPvO5f/rmq0BLp24s51+DkOw==
X-Google-Smtp-Source: ABdhPJzOY/LGfPTJMuc746ADMYrZhI5cWa2Y/nkf8ISLm6qcoSmc90IgH23Vd00INhPgX1DeBB19QPREiOwM2w==
Sender: "shakeelb via sendgmr" <shakeelb@shakeelb.svl.corp.google.com>
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:952a:270c:66f7:6213])
 (user=shakeelb job=sendgmr) by 2002:a63:1f10:: with SMTP id
 f16mr10154398pgf.111.1613774660515; Fri, 19 Feb 2021 14:44:20 -0800 (PST)
Date:   Fri, 19 Feb 2021 14:44:05 -0800
Message-Id: <20210219224405.1544597-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] memcg: charge before adding to swapcache on swapin
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
swap counters.

To correctly maintain the per-memcg swapcache stat, one option which
this patch has adopted is to charge the page before adding it to
swapcache. One challenge in this option is the failure case of
add_to_swap_cache() on which we need to undo the mem_cgroup_charge().
Specifically undoing mem_cgroup_uncharge_swap() is not simple.

This patch circumvent this specific issue by removing the failure path
of  add_to_swap_cache() by providing __GFP_NOFAIL. Please note that in
this specific situation ENOMEM was the only possible failure of
add_to_swap_cache() which is removed by using __GFP_NOFAIL.

Another option was to use __mod_memcg_lruvec_state(NR_SWAPCACHE) in
mem_cgroup_charge() but then we need to take of the do_swap_page() case
where synchronous swap devices bypass the swapcache. The do_swap_page()
already does hackery to set and reset PageSwapCache bit to make
mem_cgroup_charge() execute the swap accounting code and then we would
need to add additional parameter to tell to not touch NR_SWAPCACHE stat
as that code patch bypass swapcache.

This patch added memcg charging API explicitly foe swapin pages and
cleaned up do_swap_page() to not set and reset PageSwapCache bit.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---

Andrew, please couple this patch with "mm: memcg: add swapcache stat for
memcg v2" patch and there is no urgency for these two to be in 5.12.

 include/linux/memcontrol.h |   8 +++
 mm/memcontrol.c            | 100 ++++++++++++++++++++++---------------
 mm/memory.c                |   8 +--
 mm/swap_state.c            |  16 +++---
 scripts/cc-version.sh      |   0
 5 files changed, 77 insertions(+), 55 deletions(-)
 mode change 100644 => 100755 scripts/cc-version.sh

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e6dc793d587d..f3af65caddc6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -596,6 +596,8 @@ static inline bool mem_cgroup_below_min(struct mem_cgroup *memcg)
 }
 
 int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask);
+int mem_cgroup_charge_swapin_page(struct page *page, struct mm_struct *mm,
+				  gfp_t gfp, swp_entry_t entry);
 
 void mem_cgroup_uncharge(struct page *page);
 void mem_cgroup_uncharge_list(struct list_head *page_list);
@@ -1141,6 +1143,12 @@ static inline int mem_cgroup_charge(struct page *page, struct mm_struct *mm,
 	return 0;
 }
 
+static inline int mem_cgroup_charge_swapin_page(struct page *page,
+			struct mm_struct *mm, gfp_t gfp, swp_entry_t entry);
+{
+	return 0;
+}
+
 static inline void mem_cgroup_uncharge(struct page *page)
 {
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2db2aeac8a9e..a0ad7682f28e 100644
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
@@ -6699,54 +6720,54 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
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
-
-	if (PageSwapCache(page)) {
-		swp_entry_t ent = { .val = page_private(page), };
-		unsigned short id;
+		return 0;
 
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
+	memcg = get_mem_cgroup_from_mm(mm);
+	ret = __mem_cgroup_charge(page, memcg, gfp_mask);
+	css_put(&memcg->css);
 
-		id = lookup_swap_cgroup_id(ent);
-		rcu_read_lock();
-		memcg = mem_cgroup_from_id(id);
-		if (memcg && !css_tryget_online(&memcg->css))
-			memcg = NULL;
-		rcu_read_unlock();
-	}
+	return ret;
+}
 
-	if (!memcg)
-		memcg = get_mem_cgroup_from_mm(mm);
+/**
+ * mem_cgroup_charge_swapin_page - charge a newly allocated page for swapin
+ * @page: page to charge
+ * @mm: mm context of the victim
+ * @gfp: reclaim mode
+ * @entry: swap entry for which the page is allocated
+ *
+ * This is similar to mem_cgroup_charge() but only pages allocated for swapin.
+ *
+ * Returns 0 on success. Otherwise, an error code is returned.
+ */
+int mem_cgroup_charge_swapin_page(struct page *page, struct mm_struct *mm,
+				  gfp_t gfp, swp_entry_t entry)
+{
+	struct mem_cgroup *memcg;
+	unsigned short id;
+	int ret;
 
-	ret = try_charge(memcg, gfp_mask, nr_pages);
-	if (ret)
-		goto out_put;
+	if (mem_cgroup_disabled())
+		return 0;
 
-	css_get(&memcg->css);
-	commit_charge(page, memcg);
+	id = lookup_swap_cgroup_id(entry);
+	rcu_read_lock();
+	memcg = mem_cgroup_from_id(id);
+	if (!memcg || !css_tryget_online(&memcg->css))
+		memcg = get_mem_cgroup_from_mm(mm);
+	rcu_read_unlock();
 
-	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, page, nr_pages);
-	memcg_check_events(memcg, page);
-	local_irq_enable();
+	ret = __mem_cgroup_charge(page, memcg, gfp);
 
 	/*
 	 * Cgroup1's unified memory+swap counter has been charged with the
@@ -6760,19 +6781,16 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask)
 	 * correspond 1:1 to page and swap slot lifetimes: we charge the
 	 * page to memory here, and uncharge swap when the slot is freed.
 	 */
-	if (do_memsw_account() && PageSwapCache(page)) {
-		swp_entry_t entry = { .val = page_private(page) };
+	if (!ret && do_memsw_account()) {
 		/*
 		 * The swap entry might not get freed for a long time,
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, nr_pages);
+		mem_cgroup_uncharge_swap(entry, thp_nr_pages(page));
 	}
 
-out_put:
 	css_put(&memcg->css);
-out:
 	return ret;
 }
 
diff --git a/mm/memory.c b/mm/memory.c
index c8e357627318..fb39af50f62d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3311,13 +3311,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 
 				__SetPageLocked(page);
 				__SetPageSwapBacked(page);
-				set_page_private(page, entry.val);
 
-				/* Tell memcg to use swap ownership records */
-				SetPageSwapCache(page);
-				err = mem_cgroup_charge(page, vma->vm_mm,
-							GFP_KERNEL);
-				ClearPageSwapCache(page);
+				err = mem_cgroup_charge_swapin_page(page,
+						vma->vm_mm, GFP_KERNEL, entry);
 				if (err) {
 					ret = VM_FAULT_OOM;
 					goto out_page;
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 3cdee7b11da9..816218545a48 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -497,16 +497,15 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
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
-		goto fail_unlock;
-	}
+	/*
+	 * Use __GFP_NOFAIL to not worry about undoing the changes done by
+	 * mem_cgroup_charge_swapin_page() on failure of add_to_swap_cache().
+	 */
+	add_to_swap_cache(page, entry,
+			  (gfp_mask|__GFP_NOFAIL) & GFP_RECLAIM_MASK, &shadow);
 
 	if (shadow)
 		workingset_refault(page, shadow);
@@ -517,6 +516,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	return page;
 
 fail_unlock:
+	put_swap_page(page, entry);
 	unlock_page(page);
 	put_page(page);
 	return NULL;
diff --git a/scripts/cc-version.sh b/scripts/cc-version.sh
old mode 100644
new mode 100755
-- 
2.30.0.617.g56c4b15f3c-goog

