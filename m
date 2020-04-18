Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE41AECCA
	for <lists+cgroups@lfdr.de>; Sat, 18 Apr 2020 15:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgDRNpz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Apr 2020 09:45:55 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:51532 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbgDRNpz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Apr 2020 09:45:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TvvMGTV_1587217545;
Received: from localhost(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TvvMGTV_1587217545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Apr 2020 21:45:46 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 2/2] mm/memcg: remove swapaccount kernel parameter
Date:   Sat, 18 Apr 2020 21:33:09 +0800
Message-Id: <1587216789-42342-3-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587216789-42342-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1587216789-42342-1-git-send-email-alex.shi@linux.alibaba.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

After merge the CONFIG_MEMCG_SWAP into kernel as default feature. This
patch removes the kernel parameter interface swapaccount= to keep this
feature from user disable in boot.

Now, all swapped memcg page record it's id permanently.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: cgroups@vger.kernel.org
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/kernel-parameters.txt |  5 ---
 include/linux/memcontrol.h                      |  2 -
 mm/memcontrol.c                                 | 50 ++++++++-----------------
 mm/swap_cgroup.c                                |  7 ----
 4 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8679e8..f8532dfc4f17 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4877,11 +4877,6 @@
 			This parameter controls use of the Protected
 			Execution Facility on pSeries.
 
-	swapaccount=[0|1]
-			[KNL] Enable accounting of swap in memory resource
-			controller if no parameter or 1 is given or disable
-			it if 0 is given (See Documentation/admin-guide/cgroup-v1/memory.rst)
-
 	swiotlb=	[ARM,IA-64,PPC,MIPS,X86]
 			Format: { <int> | force | noforce }
 			<int> -- Number of I/O TLB slabs
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 45842ed8ba53..9d6330ef5a13 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -569,8 +569,6 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
-extern int do_swap_account;
-
 struct mem_cgroup *lock_page_memcg(struct page *page);
 void __unlock_page_memcg(struct mem_cgroup *memcg);
 void unlock_page_memcg(struct page *page);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 446141b6597a..ba3ac7c7644b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -81,9 +81,6 @@
 /* Kernel memory accounting disabled? */
 static bool cgroup_memory_nokmem;
 
-/* Whether the swap controller is active */
-int do_swap_account __read_mostly;
-
 #ifdef CONFIG_CGROUP_WRITEBACK
 static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
 #endif
@@ -91,7 +88,7 @@
 /* Whether legacy memory+swap accounting is active */
 static bool do_memsw_account(void)
 {
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && do_swap_account;
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
 }
 
 #define THRESHOLDS_EVENTS_TARGET 128
@@ -6444,6 +6441,9 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		goto out;
 
 	if (PageSwapCache(page)) {
+		swp_entry_t ent;
+		unsigned short id;
+
 		/*
 		 * Every swap fault against a single page tries to charge the
 		 * page, bail as early as possible.  shmem_unuse() encounters
@@ -6455,16 +6455,13 @@ int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
 		if (compound_head(page)->mem_cgroup)
 			goto out;
 
-		if (do_swap_account) {
-			swp_entry_t ent = { .val = page_private(page), };
-			unsigned short id = lookup_swap_cgroup_id(ent);
-
-			rcu_read_lock();
-			memcg = mem_cgroup_from_id(id);
-			if (memcg && !css_tryget_online(&memcg->css))
-				memcg = NULL;
-			rcu_read_unlock();
-		}
+		ent.val = page_private(page);
+		id = lookup_swap_cgroup_id(ent);
+		rcu_read_lock();
+		memcg = mem_cgroup_from_id(id);
+		if (memcg && !css_tryget_online(&memcg->css))
+			memcg = NULL;
+		rcu_read_unlock();
 	}
 
 	if (!memcg)
@@ -7024,7 +7021,7 @@ int mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
 
-	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) || !do_swap_account)
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
 	memcg = page->mem_cgroup;
@@ -7068,9 +7065,6 @@ void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages)
 	struct mem_cgroup *memcg;
 	unsigned short id;
 
-	if (!do_swap_account)
-		return;
-
 	id = swap_cgroup_record(entry, 0, nr_pages);
 	rcu_read_lock();
 	memcg = mem_cgroup_from_id(id);
@@ -7091,7 +7085,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 {
 	long nr_swap_pages = get_nr_swap_pages();
 
-	if (!do_swap_account || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return nr_swap_pages;
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg))
 		nr_swap_pages = min_t(long, nr_swap_pages,
@@ -7108,7 +7102,7 @@ bool mem_cgroup_swap_full(struct page *page)
 
 	if (vm_swap_full())
 		return true;
-	if (!do_swap_account || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
 
 	memcg = page->mem_cgroup;
@@ -7123,19 +7117,6 @@ bool mem_cgroup_swap_full(struct page *page)
 	return false;
 }
 
-/* for remember boot option*/
-static int really_do_swap_account __initdata = 1;
-
-static int __init enable_swap_account(char *s)
-{
-	if (!strcmp(s, "1"))
-		really_do_swap_account = 1;
-	else if (!strcmp(s, "0"))
-		really_do_swap_account = 0;
-	return 1;
-}
-__setup("swapaccount=", enable_swap_account);
-
 static u64 swap_current_read(struct cgroup_subsys_state *css,
 			     struct cftype *cft)
 {
@@ -7229,8 +7210,7 @@ static int swap_events_show(struct seq_file *m, void *v)
 
 static int __init mem_cgroup_swap_init(void)
 {
-	if (!mem_cgroup_disabled() && really_do_swap_account) {
-		do_swap_account = 1;
+	if (!mem_cgroup_disabled()) {
 		WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys,
 					       swap_files));
 		WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys,
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index 45affaef3bc6..3cb015179d29 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -171,9 +171,6 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	unsigned long length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (!do_swap_account)
-		return 0;
-
 	length = DIV_ROUND_UP(max_pages, SC_PER_PAGE);
 	array_size = length * sizeof(void *);
 
@@ -199,7 +196,6 @@ int swap_cgroup_swapon(int type, unsigned long max_pages)
 	return 0;
 nomem:
 	pr_info("couldn't allocate enough memory for swap_cgroup\n");
-	pr_info("swap_cgroup can be disabled by swapaccount=0 boot option\n");
 	return -ENOMEM;
 }
 
@@ -209,9 +205,6 @@ void swap_cgroup_swapoff(int type)
 	unsigned long i, length;
 	struct swap_cgroup_ctrl *ctrl;
 
-	if (!do_swap_account)
-		return;
-
 	mutex_lock(&swap_cgroup_mutex);
 	ctrl = &swap_cgroup_ctrl[type];
 	map = ctrl->map;
-- 
1.8.3.1

