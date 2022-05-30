Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB45375FA
	for <lists+cgroups@lfdr.de>; Mon, 30 May 2022 09:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiE3Hvw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 30 May 2022 03:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiE3Hvf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 30 May 2022 03:51:35 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E3D72E07
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:51:17 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so9970685pjf.5
        for <cgroups@vger.kernel.org>; Mon, 30 May 2022 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOnakioNTpkftz5TEEpxPkx+AXEcUhIQ+xBmxegLLLk=;
        b=G7UlzCFpeRyuujxoet9lrU1xhyW7FqRaPoHxhPWDapAkZHgzLVWtZvPYnkDrlFlULX
         RUwmuVgCUVLHss0KzevDkqrBPiahzVKv9axDXDIuimp7R7/aChPMdh+0G7dY3RE/Aqsw
         NA09if8i2KGe3yjtHL1j3LAcjME/OtX2A874ONr2TLKEKqGxxYvEN4DtXCouNvzV+Cdh
         sa0np4Yvv5OWhB8gFrkepTeti4iAWZmUC2ExdUtJzYwzoqZV3Bo4cPqdRoT1ezd4N8ye
         EDN2VujblGS7sShPM+Hk6rFUlmE/iFU5Zdm4MZy0LnkZXA/2P79JRNnSy1Ve7oUXzRJB
         JFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOnakioNTpkftz5TEEpxPkx+AXEcUhIQ+xBmxegLLLk=;
        b=16ZlOeep9q92j9tPlVqg25MDFn15w/uDnVrZOPfztx77pN3RZl+GDSbsOwSdiG6y+5
         5wQXI4OcJn8a5Obh60IUkT8ZT0ew3Jntrf/DHdCg8vaeWOWBOB9TXU4qj1dLJxY/CvIh
         +w1wpNe9dxj8W9w1ZkAks7OJCVj557DG5CsbC0fIrnXgyGY89cwPGoxqhrxJisBQpHuN
         NPZYyluYsyZ/qfVDUrVtD2Ifsr9SWFWAHvx8aoU9lI4Ta1vA9ZtvFOQKWwQIAQ9IHTeB
         XVonPZDeiRqu+kJV0KzIBhgnLr8qm0P/yHPkjkrR5LN4s6Mw6TEHRedkJ/wFamhEkHd4
         xCQw==
X-Gm-Message-State: AOAM532qJ62oDxA6vPcrUY7WGgGNxyuJcczPe+wgYRcBdRflE9l0x4MF
        MHnu0Yqa+LLlZJ7ZHd7XwCjspH9bC3oK9w==
X-Google-Smtp-Source: ABdhPJzvVjd94LyMjg4MN7EbMOK/53ve9a+HlZ4JvWRhjFBngX+lwFiXPgqD1EKJsTzag8g9j2FPqA==
X-Received: by 2002:a17:90a:66c1:b0:1e2:758c:46f1 with SMTP id z1-20020a17090a66c100b001e2758c46f1mr18023933pjl.104.1653897077341;
        Mon, 30 May 2022 00:51:17 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([2408:8207:18da:2310:2071:e13a:8aa:cacf])
        by smtp.gmail.com with ESMTPSA id a23-20020a170902b59700b001616c3bd5c2sm8421381pls.162.2022.05.30.00.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:51:16 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 07/11] mm: memcontrol: make all the callers of {folio,page}_memcg() safe
Date:   Mon, 30 May 2022 15:49:15 +0800
Message-Id: <20220530074919.46352-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220530074919.46352-1-songmuchun@bytedance.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When we use objcg APIs to charge the LRU pages, the page will not hold
a reference to the memcg associated with the page. So the caller of the
{folio,page}_memcg() should hold an rcu read lock or obtain a reference
to the memcg associated with the page to protect memcg from being
released. So introduce get_mem_cgroup_from_{page,folio}() to obtain a
reference to the memory cgroup associated with the page.

In this patch, make all the callers hold an rcu read lock or obtain a
reference to the memcg to protect memcg from being released when the LRU
pages reparented.

We do not need to adjust the callers of {folio,page}_memcg() during
the whole process of mem_cgroup_move_task(). Because the cgroup migration
and memory cgroup offlining are serialized by @cgroup_mutex. In this
routine, the LRU pages cannot be reparented to its parent memory cgroup.
So {folio,page}_memcg() is stable and cannot be released.

This is a preparation for reparenting the LRU pages.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/buffer.c                      |  4 +--
 fs/fs-writeback.c                | 23 +++++++-------
 include/linux/memcontrol.h       | 61 +++++++++++++++++++++++++++++++----
 include/trace/events/writeback.h |  5 +++
 mm/memcontrol.c                  | 68 +++++++++++++++++++++++++++++-----------
 mm/migrate.c                     |  4 +++
 mm/page_io.c                     |  5 +--
 7 files changed, 131 insertions(+), 39 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2b5561ae5d0b..80975a457670 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -819,8 +819,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 	if (retry)
 		gfp |= __GFP_NOFAIL;
 
-	/* The page lock pins the memcg */
-	memcg = page_memcg(page);
+	memcg = get_mem_cgroup_from_page(page);
 	old_memcg = set_active_memcg(memcg);
 
 	head = NULL;
@@ -840,6 +839,7 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
 		set_bh_page(bh, page, offset);
 	}
 out:
+	mem_cgroup_put(memcg);
 	set_active_memcg(old_memcg);
 	return head;
 /*
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1fae0196292a..56612ace8778 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -243,15 +243,13 @@ void __inode_attach_wb(struct inode *inode, struct page *page)
 	if (inode_cgwb_enabled(inode)) {
 		struct cgroup_subsys_state *memcg_css;
 
-		if (page) {
-			memcg_css = mem_cgroup_css_from_page(page);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-		} else {
-			/* must pin memcg_css, see wb_get_create() */
+		/* must pin memcg_css, see wb_get_create() */
+		if (page)
+			memcg_css = get_mem_cgroup_css_from_page(page);
+		else
 			memcg_css = task_get_css(current, memory_cgrp_id);
-			wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
-			css_put(memcg_css);
-		}
+		wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+		css_put(memcg_css);
 	}
 
 	if (!wb)
@@ -868,16 +866,16 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 	if (!wbc->wb || wbc->no_cgroup_owner)
 		return;
 
-	css = mem_cgroup_css_from_page(page);
+	css = get_mem_cgroup_css_from_page(page);
 	/* dead cgroups shouldn't contribute to inode ownership arbitration */
 	if (!(css->flags & CSS_ONLINE))
-		return;
+		goto out;
 
 	id = css->id;
 
 	if (id == wbc->wb_id) {
 		wbc->wb_bytes += bytes;
-		return;
+		goto out;
 	}
 
 	if (id == wbc->wb_lcand_id)
@@ -890,6 +888,9 @@ void wbc_account_cgroup_owner(struct writeback_control *wbc, struct page *page,
 		wbc->wb_tcand_bytes += bytes;
 	else
 		wbc->wb_tcand_bytes -= min(bytes, wbc->wb_tcand_bytes);
+
+out:
+	css_put(css);
 }
 EXPORT_SYMBOL_GPL(wbc_account_cgroup_owner);
 
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 56227603dcb8..16464116f94a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -373,7 +373,7 @@ static inline bool folio_memcg_kmem(struct folio *folio);
  * a valid memcg, but can be atomically swapped to the parent memcg.
  *
  * The caller must ensure that the returned memcg won't be released:
- * e.g. acquire the rcu_read_lock or css_set_lock.
+ * e.g. acquire the rcu_read_lock or objcg_lock or cgroup_mutex.
  */
 static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 {
@@ -439,8 +439,8 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  * - lock_page_memcg()
  * - exclusive reference
  *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * Note: The caller should hold an rcu read lock to protect memcg associated
+ * with a folio from being released.
  */
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
@@ -449,12 +449,48 @@ static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 	return __folio_memcg(folio);
 }
 
+/*
+ * page_memcg - Get the memory cgroup associated with a page.
+ * @page: Pointer to the page.
+ *
+ * See the cooments in folio_memcg().
+ */
 static inline struct mem_cgroup *page_memcg(struct page *page)
 {
 	return folio_memcg(page_folio(page));
 }
 
-/**
+/*
+ * get_mem_cgroup_from_folio - Obtain a reference on the memory cgroup
+ *			       associated with a folio.
+ * @folio: Pointer to the folio.
+ *
+ * Returns a pointer to the memory cgroup (and obtain a reference on it)
+ * associated with the folio, or NULL. This function assumes that the
+ * folio is known to have a proper memory cgroup pointer. It's not safe
+ * to call this function against some type of pages, e.g. slab pages or
+ * ex-slab pages.
+ */
+static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+retry:
+	memcg = folio_memcg(folio);
+	if (unlikely(memcg && !css_tryget(&memcg->css)))
+		goto retry;
+	rcu_read_unlock();
+
+	return memcg;
+}
+
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return get_mem_cgroup_from_folio(page_folio(page));
+}
+
+/*
  * folio_memcg_rcu - Locklessly get the memory cgroup associated with a folio.
  * @folio: Pointer to the folio.
  *
@@ -873,7 +909,7 @@ static inline bool mm_match_cgroup(struct mm_struct *mm,
 	return match;
 }
 
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page);
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page);
 ino_t page_cgroup_ino(struct page *page);
 
 static inline bool mem_cgroup_online(struct mem_cgroup *memcg)
@@ -1047,10 +1083,13 @@ static inline void count_memcg_events(struct mem_cgroup *memcg,
 static inline void count_memcg_page_event(struct page *page,
 					  enum vm_event_item idx)
 {
-	struct mem_cgroup *memcg = page_memcg(page);
+	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
+	memcg = page_memcg(page);
 	if (memcg)
 		count_memcg_events(memcg, idx, 1);
+	rcu_read_unlock();
 }
 
 static inline void count_memcg_event_mm(struct mm_struct *mm,
@@ -1129,6 +1168,16 @@ static inline struct mem_cgroup *page_memcg(struct page *page)
 	return NULL;
 }
 
+static inline struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
+{
+	return NULL;
+}
+
+static inline struct mem_cgroup *get_mem_cgroup_from_page(struct page *page)
+{
+	return NULL;
+}
+
 static inline struct mem_cgroup *folio_memcg_rcu(struct folio *folio)
 {
 	WARN_ON_ONCE(!rcu_read_lock_held());
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 86b2a82da546..cdb822339f13 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -258,6 +258,11 @@ TRACE_EVENT(track_foreign_dirty,
 		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		/*
+		 * TP_fast_assign() is under preemption disabled which can
+		 * serve as an RCU read-side critical section so that the
+		 * memcg returned by folio_memcg() cannot be freed.
+		 */
 		__entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);
 	),
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9d98a791353c..4cc392741753 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -371,7 +371,7 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
 #endif
 
 /**
- * mem_cgroup_css_from_page - css of the memcg associated with a page
+ * get_mem_cgroup_css_from_page - get css of the memcg associated with a page
  * @page: page of interest
  *
  * If memcg is bound to the default hierarchy, css of the memcg associated
@@ -381,13 +381,15 @@ EXPORT_SYMBOL(memcg_kmem_enabled_key);
  * If memcg is bound to a traditional hierarchy, the css of root_mem_cgroup
  * is returned.
  */
-struct cgroup_subsys_state *mem_cgroup_css_from_page(struct page *page)
+struct cgroup_subsys_state *get_mem_cgroup_css_from_page(struct page *page)
 {
 	struct mem_cgroup *memcg;
 
-	memcg = page_memcg(page);
+	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return &root_mem_cgroup->css;
 
-	if (!memcg || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+	memcg = get_mem_cgroup_from_page(page);
+	if (!memcg)
 		memcg = root_mem_cgroup;
 
 	return &memcg->css;
@@ -770,13 +772,13 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
 			     int val)
 {
-	struct page *head = compound_head(page); /* rmap on tail pages */
+	struct folio *folio = page_folio(page); /* rmap on tail pages */
 	struct mem_cgroup *memcg;
 	pg_data_t *pgdat = page_pgdat(page);
 	struct lruvec *lruvec;
 
 	rcu_read_lock();
-	memcg = page_memcg(head);
+	memcg = folio_memcg(folio);
 	/* Untracked pages have no memcg, no lruvec. Update only the node */
 	if (!memcg) {
 		rcu_read_unlock();
@@ -2049,7 +2051,9 @@ void folio_memcg_lock(struct folio *folio)
 	 * The RCU lock is held throughout the transaction.  The fast
 	 * path can get away without acquiring the memcg->move_lock
 	 * because page moving starts with an RCU grace period.
-         */
+	 *
+	 * The RCU lock also protects the memcg from being freed.
+	 */
 	rcu_read_lock();
 
 	if (mem_cgroup_disabled())
@@ -3287,7 +3291,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
 void split_page_memcg(struct page *head, unsigned int nr)
 {
 	struct folio *folio = page_folio(head);
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
 	int i;
 
 	if (mem_cgroup_disabled() || !memcg)
@@ -3300,6 +3304,8 @@ void split_page_memcg(struct page *head, unsigned int nr)
 		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
 	else
 		css_get_many(&memcg->css, nr - 1);
+
+	css_put(&memcg->css);
 }
 
 #ifdef CONFIG_MEMCG_SWAP
@@ -4496,7 +4502,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 					     struct bdi_writeback *wb)
 {
-	struct mem_cgroup *memcg = folio_memcg(folio);
+	struct mem_cgroup *memcg = get_mem_cgroup_from_folio(folio);
 	struct memcg_cgwb_frn *frn;
 	u64 now = get_jiffies_64();
 	u64 oldest_at = now;
@@ -4543,6 +4549,7 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
 		frn->memcg_id = wb->memcg_css->id;
 		frn->at = now;
 	}
+	css_put(&memcg->css);
 }
 
 /* issue foreign writeback flushes for recorded foreign dirtying events */
@@ -6077,6 +6084,14 @@ static void mem_cgroup_move_charge(void)
 	atomic_dec(&mc.from->moving_account);
 }
 
+/*
+ * The cgroup migration and memory cgroup offlining are serialized by
+ * @cgroup_mutex. If we reach here, it means that the LRU pages cannot
+ * be reparented to its parent memory cgroup. So during the whole process
+ * of mem_cgroup_move_task(), page_memcg(page) is stable. So we do not
+ * need to worry about the memcg (returned from page_memcg()) being
+ * released even if we do not hold an rcu read lock.
+ */
 static void mem_cgroup_move_task(void)
 {
 	if (mc.to) {
@@ -6876,7 +6891,7 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (folio_memcg(new))
 		return;
 
-	memcg = folio_memcg(old);
+	memcg = get_mem_cgroup_from_folio(old);
 	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
 	if (!memcg)
 		return;
@@ -6895,6 +6910,8 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
+
+	css_put(&memcg->css);
 }
 
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7079,6 +7096,10 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	/*
+	 * Interrupts should be disabled by the caller (see the comments below),
+	 * which can serve as RCU read-side critical sections.
+	 */
 	memcg = folio_memcg(folio);
 
 	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
@@ -7140,19 +7161,21 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
 	unsigned short oldid;
+	int ret = 0;
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return 0;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 
 	VM_WARN_ON_ONCE_PAGE(!memcg, page);
 	if (!memcg)
-		return 0;
+		goto out;
 
 	if (!entry.val) {
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
-		return 0;
+		goto out;
 	}
 
 	memcg = mem_cgroup_id_get_online(memcg);
@@ -7162,7 +7185,8 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 		memcg_memory_event(memcg, MEMCG_SWAP_MAX);
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		mem_cgroup_id_put(memcg);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	/* Get references for the tail pages, too */
@@ -7171,8 +7195,10 @@ int __mem_cgroup_try_charge_swap(struct page *page, swp_entry_t entry)
 	oldid = swap_cgroup_record(entry, mem_cgroup_id(memcg), nr_pages);
 	VM_BUG_ON_PAGE(oldid, page);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
+out:
+	rcu_read_unlock();
 
-	return 0;
+	return ret;
 }
 
 /**
@@ -7217,6 +7243,7 @@ long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg)
 bool mem_cgroup_swap_full(struct page *page)
 {
 	struct mem_cgroup *memcg;
+	bool ret = false;
 
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
@@ -7225,19 +7252,24 @@ bool mem_cgroup_swap_full(struct page *page)
 	if (cgroup_memory_noswap || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return false;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 	if (!memcg)
-		return false;
+		goto out;
 
 	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
 		unsigned long usage = page_counter_read(&memcg->swap);
 
 		if (usage * 2 >= READ_ONCE(memcg->swap.high) ||
-		    usage * 2 >= READ_ONCE(memcg->swap.max))
-			return true;
+		    usage * 2 >= READ_ONCE(memcg->swap.max)) {
+			ret = true;
+			goto out;
+		}
 	}
+out:
+	rcu_read_unlock();
 
-	return false;
+	return ret;
 }
 
 static int __init setup_swap_account(char *s)
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..59e97a8a64a0 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -430,6 +430,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 		struct lruvec *old_lruvec, *new_lruvec;
 		struct mem_cgroup *memcg;
 
+		/*
+		 * Irq is disabled, which can serve as RCU read-side critical
+		 * sections.
+		 */
 		memcg = folio_memcg(folio);
 		old_lruvec = mem_cgroup_lruvec(memcg, oldzone->zone_pgdat);
 		new_lruvec = mem_cgroup_lruvec(memcg, newzone->zone_pgdat);
diff --git a/mm/page_io.c b/mm/page_io.c
index 89fbf3cae30f..a0d9cd68e87a 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -221,13 +221,14 @@ static void bio_associate_blkg_from_page(struct bio *bio, struct page *page)
 	struct cgroup_subsys_state *css;
 	struct mem_cgroup *memcg;
 
+	rcu_read_lock();
 	memcg = page_memcg(page);
 	if (!memcg)
-		return;
+		goto out;
 
-	rcu_read_lock();
 	css = cgroup_e_css(memcg->css.cgroup, &io_cgrp_subsys);
 	bio_associate_blkg_from_css(bio, css);
+out:
 	rcu_read_unlock();
 }
 #else
-- 
2.11.0

