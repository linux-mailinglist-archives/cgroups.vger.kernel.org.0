Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894BC1B1927
	for <lists+cgroups@lfdr.de>; Tue, 21 Apr 2020 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgDTWM2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 20 Apr 2020 18:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728399AbgDTWMK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 20 Apr 2020 18:12:10 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9FDC061A0E
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:10 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id o19so12573722qkk.5
        for <cgroups@vger.kernel.org>; Mon, 20 Apr 2020 15:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V4CmxDg+3coaIxVQQ6Fk3kZAAIUOYIee+X4KkV8yAVM=;
        b=MF0CGwjxMBjGHHBS16rqAWiBnZrzf0N5/QjQTnOFf+30YkHPHBfowHzmz9DIUe26mS
         l9uCKuBwM5ZK5nFU/hwm9oUngNggWIb/HuU1HoR7VfqqlTA/vzjoc45ET5j5/UI77eEP
         5jWFWOa1fw0jSwXTNTuwXiDOq4HR6zobgLBOsfGSFpUnZkdbyvj94x6P5mV+jVfAjahY
         rD5N9bew9iZ9yN7KybLgwrX4G0gfrFlYMQWw4OflRYFzf5QUPQJ0xvvI1sBnC8uXHVZj
         pTpI074+gs4At+LTUCZclNDS2VQDdKRm05pQOctSvXdj46dflNH/cz59xkfMIczD0jHu
         ae4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V4CmxDg+3coaIxVQQ6Fk3kZAAIUOYIee+X4KkV8yAVM=;
        b=RVDKl34j9D9jGUQxeDb8Lg+2PixU6YxfCdkLTZ/oBByhtA/96gDQLnGVTUoH7K5k8q
         UHFYi9Zb+0kdUI35DyjaN6vo89TdKatBXMH110Ezkosa+kjhSqWS5yslvCzXR2OqTJwE
         FvvPL8qVMZn6xCon16qg75/8eO6oUXsXgagmOjj6NKHjWLfgF3HeQFY1/hmM0lr+GDsL
         y9VRJN5cc5B5hZlEj6YaKN9yw7WCN1cN1bsZt7HertGmGOLAXr7PuZwkFrKFCBFu+l7T
         4ZDMVJmoEGwvnS/RhvSXyqBPFUPlmJPS/5rGDVBqNqJ2nr4qvdkeQzo9QiI2JlC+Wefm
         dVnQ==
X-Gm-Message-State: AGi0PuZ0gcRhFG2E+H0i6qDR+f41m6tAutneQPzlgpHwqQPhbrVvqlXw
        WMOOuLbhywwNbqC0jAoDYJqjyQ==
X-Google-Smtp-Source: APiQypI+jmPGg0pa550mFWrulXsJN80RWZPk/8YQj0Olon21tP2/Ee2lF3MClScuwml1NkZpaNxOjA==
X-Received: by 2002:a37:9cce:: with SMTP id f197mr7930009qke.35.1587420729439;
        Mon, 20 Apr 2020 15:12:09 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:e6b6])
        by smtp.gmail.com with ESMTPSA id g4sm419565qtq.93.2020.04.20.15.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 15:12:08 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 15/18] mm: memcontrol: make swap tracking an integral part of memory control
Date:   Mon, 20 Apr 2020 18:11:23 -0400
Message-Id: <20200420221126.341272-16-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420221126.341272-1-hannes@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Without swap page tracking, users that are otherwise memory controlled
can easily escape their containment and allocate significant amounts
of memory that they're not being charged for. That's because swap does
readahead, but without the cgroup records of who owned the page at
swapout, readahead pages don't get charged until somebody actually
faults them into their page table and we can identify an owner task.
This can be maliciously exploited with MADV_WILLNEED, which triggers
arbitrary readahead allocations without charging the pages.

Make swap swap page tracking an integral part of memcg and remove the
Kconfig options. In the first place, it was only made configurable to
allow users to save some memory. But the overhead of tracking cgroup
ownership per swap page is minimal - 2 byte per page, or 512k per 1G
of swap, or 0.04%. Saving that at the expense of broken containment
semantics is not something we should present as a coequal option.

The swapaccount=0 boot option will continue to exist, and it will
eliminate the page_counter overhead and hide the swap control files,
but it won't disable swap slot ownership tracking.

This patch makes sure we always have the cgroup records at swapin
time; the next patch will fix the actual bug by charging readahead
swap pages at swapin time rather than at fault time.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 init/Kconfig     | 17 +----------------
 mm/memcontrol.c  | 48 +++++++++++++++++-------------------------------
 mm/swap_cgroup.c |  6 ------
 3 files changed, 18 insertions(+), 53 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 9e22ee8fbd75..39cdb13168cf 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -835,24 +835,9 @@ config MEMCG
 	  Provides control over the memory footprint of tasks in a cgroup.
 
 config MEMCG_SWAP
-	bool "Swap controller"
+	bool
 	depends on MEMCG && SWAP
-	help
-	  Provides control over the swap space consumed by tasks in a cgroup.
-
-config MEMCG_SWAP_ENABLED
-	bool "Swap controller enabled by default"
-	depends on MEMCG_SWAP
 	default y
-	help
-	  Memory Resource Controller Swap Extension comes with its price in
-	  a bigger memory consumption. General purpose distribution kernels
-	  which want to enable the feature but keep it disabled by default
-	  and let the user enable it by swapaccount=1 boot command line
-	  parameter should have this option unselected.
-	  For those who want to have the feature enabled by default should
-	  select this option (if, for some reason, they need to disable it
-	  then swapaccount=0 does the trick).
 
 config MEMCG_KMEM
 	bool
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5558777023e7..1d7408a8744a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -83,14 +83,10 @@ static bool cgroup_memory_nokmem;
 
 /* Whether the swap controller is active */
 #ifdef CONFIG_MEMCG_SWAP
-#ifdef CONFIG_MEMCG_SWAP_ENABLED
 bool cgroup_memory_noswap __read_mostly;
 #else
-bool cgroup_memory_noswap __read_mostly = 1;
-#endif /* CONFIG_MEMCG_SWAP_ENABLED */
-#else
 #define cgroup_memory_noswap		1
-#endif /* CONFIG_MEMCG_SWAP */
+#endif
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
@@ -5290,8 +5286,7 @@ static struct page *mc_handle_swap_pte(struct vm_area_struct *vma,
 	 * we call find_get_page() with swapper_space directly.
 	 */
 	page = find_get_page(swap_address_space(ent), swp_offset(ent));
-	if (do_memsw_account())
-		entry->val = ent.val;
+	entry->val = ent.val;
 
 	return page;
 }
@@ -5325,8 +5320,7 @@ static struct page *mc_handle_file_pte(struct vm_area_struct *vma,
 		page = find_get_entry(mapping, pgoff);
 		if (xa_is_value(page)) {
 			swp_entry_t swp = radix_to_swp_entry(page);
-			if (do_memsw_account())
-				*entry = swp;
+			*entry = swp;
 			page = find_get_page(swap_address_space(swp),
 					     swp_offset(swp));
 		}
@@ -6459,6 +6453,9 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 		goto out;
 
 	if (PageSwapCache(page)) {
+		swp_entry_t ent = { .val = page_private(page), };
+		unsigned short id;
+
 		/*
 		 * Every swap fault against a single page tries to charge the
 		 * page, bail as early as possible.  shmem_unuse() encounters
@@ -6470,17 +6467,12 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 		if (compound_head(page)->mem_cgroup)
 			goto out;
 
-		if (!cgroup_memory_noswap) {
-			swp_entry_t ent = { .val = page_private(page), };
-			unsigned short id;
-
-			id = lookup_swap_cgroup_id(ent);
-			rcu_read_lock();
-			memcg = mem_cgroup_from_id(id);
-			if (memcg && !css_tryget_online(&memcg->css))
-				memcg = NULL;
-			rcu_read_unlock();
-		}
+		id = lookup_swap_cgroup_id(ent);
+		rcu_read_lock();
+		memcg = mem_cgroup_from_id(id);
+		if (memcg && !css_tryget_online(&memcg->css))
+			memcg = NULL;
+		rcu_read_unlock();
 	}
 
 	if (!memcg)
@@ -6497,7 +6489,7 @@ int mem_cgroup_charge(struct page *page, struct mm_struct *mm, gfp_t gfp_mask,
 	memcg_check_events(memcg, page);
 	local_irq_enable();
 
-	if (do_memsw_account() && PageSwapCache(page)) {
+	if (PageSwapCache(page)) {
 		swp_entry_t entry = { .val = page_private(page) };
 		/*
 		 * The swap entry might not get freed for a long time,
@@ -6884,9 +6876,6 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	VM_BUG_ON_PAGE(PageLRU(page), page);
 	VM_BUG_ON_PAGE(page_count(page), page);
 
-	if (!do_memsw_account())
-		return;
-
 	memcg = page->mem_cgroup;
 
 	/* Readahead page, never charged */
@@ -6913,7 +6902,7 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	if (!mem_cgroup_is_root(memcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
-	if (memcg != swap_memcg) {
+	if (do_memsw_account() && memcg != swap_memcg) {
 		if (!mem_cgroup_is_root(swap_memcg))
 			page_counter_charge(&swap_memcg->memsw, nr_entries);
 		page_counter_uncharge(&memcg->memsw, nr_entries);
@@ -6949,7 +6938,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) || cgroup_memory_noswap)
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
 	memcg = page->mem_cgroup;
@@ -6965,7 +6954,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 
 	memcg = mem_cgroup_id_get_online(memcg);
 
-	if (!mem_cgroup_is_root(memcg) &&
+	if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
@@ -6993,14 +6982,11 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	if (cgroup_memory_noswap)
-		return;
-
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
 	if (memcg) {
-		if (!mem_cgroup_is_root(memcg)) {
+		if (!cgroup_memory_noswap && !mem_cgroup_is_root(memcg)) {
 			if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 				page_counter_uncharge(&memcg->swap, nr_pages);
 			else
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 7aa764f09079..7f34343c075a 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -171,9 +171,6 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	unsigned long length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (cgroup_memory_noswap)
-		return 0;
-
 	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
 	array_size = length * sizeof(void *);
 
@@ -209,9 +206,6 @@ void swap_cgroup_swapoff(int type)
 	unsigned long i, length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (cgroup_memory_noswap)
-		return;
-
 	mutex_lock(&swap_cgroup_mutex);
 	ctrl = &swap_cgroup_ctrl[type];
 	map = ctrl->map;
-- 
2.26.0

