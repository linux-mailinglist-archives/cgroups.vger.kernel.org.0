Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA979BBA3
	for <lists+cgroups@lfdr.de>; Tue, 12 Sep 2023 02:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240101AbjIKWZ6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 11 Sep 2023 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242990AbjIKQkd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 11 Sep 2023 12:40:33 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF92DE0;
        Mon, 11 Sep 2023 09:40:26 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bc0d39b52cso33388345ad.2;
        Mon, 11 Sep 2023 09:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694450426; x=1695055226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehfDCSbS5xI1A4smBl8d8rCmXb27of6OXAgvagL8new=;
        b=DJ/f1UUdejoASC53G2jHT7pv9KobttPLt9ka9ockHIvlBNH+01QiKgSPpqf9iw4mvP
         tPoCbH10h/9WM3D9QRJ9RXGgxAXkoBUInvzzHXV0FcvHZuAno2pfjgWUgq/2kvtNyvWA
         DJ2fHkD5f5fYfv/ryJqVy3yr6y7ZWaUOOAL3Hh7JL+v5VUj69burJ1DL2oj2C019IrsV
         L7h7BngwTUjEJjkW7k0MwIAEJhVcWIhxMHip8gLlndXNj7jlHM8BLeuBy/dpEYgyCBgu
         zI9Tz0Rw/qBM4hfvUJ0e3M2u2jwrxl4XTwJGOZO0YhvZJgxATLc5flFIyb7nLu0YPNqi
         q99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694450426; x=1695055226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehfDCSbS5xI1A4smBl8d8rCmXb27of6OXAgvagL8new=;
        b=CJkRTlGgwkg/a9W//QRS5GdxqWh/otAYLibJFCT3qesaiwB1FopXZYi39eezSg3Nd4
         ESRs1K8MjrDJUmzdIosH14bH0P9d6N/oZaCGs5G3jlgKODu269fc9h+wGTBboYbRaEMs
         luU1MNjDprg0OKLPWjyBu4Mr+wTFAB1AywptyMQlCqZUtkeQE5K8fX/5X1qw3E6kAIPx
         RnAPpjCNZRKqVwome1qdo61Rm5N1YDmheCaEXvY5O90/pxgxasDtbXnFWYO8K8WPCc+g
         U1fPyXtdMBgkp0nAKOMYdEckIDejO9/Gc//QCtQtEB0iO4tUulX84rbt/nnC2BnoOzxC
         QzPQ==
X-Gm-Message-State: AOJu0Yw5qKtvdrSSj8t8K0E15DLOUKUz66zFeLdyP+vUJHDqFwO2lExQ
        rs8cIv/CtG+xstPh6sqGufa+4BO2b9YNAw==
X-Google-Smtp-Source: AGHT+IHsgsGe1jWW265/ojJCZZnvxP6+eyGvtvPoX9v33DRpDAbBUmL4skmdMcPRnjN4DbXQXrREwg==
X-Received: by 2002:a17:90a:fe14:b0:269:621e:a673 with SMTP id ck20-20020a17090afe1400b00269621ea673mr8469386pjb.1.1694450426059;
        Mon, 11 Sep 2023 09:40:26 -0700 (PDT)
Received: from localhost (fwdproxy-prn-020.fbsv.net. [2a03:2880:ff:14::face:b00c])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a840200b00260a5ecd273sm5841954pjn.1.2023.09.11.09.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:40:25 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 1/2] zswap: make shrinking memcg-aware
Date:   Mon, 11 Sep 2023 09:40:23 -0700
Message-Id: <20230911164024.2541401-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911164024.2541401-1-nphamcs@gmail.com>
References: <20230911164024.2541401-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

Currently, we only have a single global LRU for zswap. This makes it
impossible to perform worload-specific shrinking - an memcg cannot
determine which pages in the pool it owns, and often ends up writing
pages from other memcgs. This issue has been previously observed in
practice and mitigated by simply disabling memcg-initiated shrinking:

https://lore.kernel.org/all/20230530232435.3097106-1-nphamcs@gmail.com/T/#u

This patch fully resolves the issue by replacing the global zswap LRU
with memcg- and NUMA-specific LRUs, and modify the reclaim logic:

a) When a store attempt hits an memcg limit, it now triggers a
   synchronous reclaim attempt that, if successful, allows the new
   hotter page to be accepted by zswap.
b) If the store attempt instead hits the global zswap limit, it will
   trigger an asynchronous reclaim attempt, in which an memcg is
   selected for reclaim in a round-robin-like fashion.

Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Co-developed-by: Nhat Pham <nphamcs@gmail.com>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/list_lru.h |  39 +++++++
 include/linux/zswap.h    |   9 ++
 mm/list_lru.c            |  46 ++++++--
 mm/swap_state.c          |  19 ++++
 mm/zswap.c               | 221 +++++++++++++++++++++++++++++++--------
 5 files changed, 282 insertions(+), 52 deletions(-)

diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
index b35968ee9fb5..b517b4e2c7c4 100644
--- a/include/linux/list_lru.h
+++ b/include/linux/list_lru.h
@@ -89,6 +89,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg, struct mem_cgroup *paren
  */
 bool list_lru_add(struct list_lru *lru, struct list_head *item);
 
+/**
+ * __list_lru_add: add an element to a specific sublist.
+ * @list_lru: the lru pointer
+ * @item: the item to be added.
+ * @memcg: the cgroup of the sublist to add the item to.
+ * @nid: the node id of the sublist to add the item to.
+ *
+ * This function is similar to list_lru_add(), but it allows the caller to
+ * specify the sublist to which the item should be added. This can be useful
+ * when the list_head node is not necessarily in the same cgroup and NUMA node
+ * as the data it represents, such as zswap, where the list_head node could be
+ * from kswapd and the data from a different cgroup altogether.
+ *
+ * Return value: true if the list was updated, false otherwise
+ */
+bool __list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
+		struct mem_cgroup *memcg);
+
 /**
  * list_lru_del: delete an element to the lru list
  * @list_lru: the lru pointer
@@ -102,6 +120,18 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item);
  */
 bool list_lru_del(struct list_lru *lru, struct list_head *item);
 
+/**
+ * __list_lru_delete: delete an element from a specific sublist.
+ * @list_lru: the lru pointer
+ * @item: the item to be deleted.
+ * @memcg: the cgroup of the sublist to delete the item from.
+ * @nid: the node id of the sublist to delete the item from.
+ *
+ * Return value: true if the list was updated, false otherwise.
+ */
+bool __list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
+		struct mem_cgroup *memcg);
+
 /**
  * list_lru_count_one: return the number of objects currently held by @lru
  * @lru: the lru pointer.
@@ -137,6 +167,15 @@ void list_lru_isolate(struct list_lru_one *list, struct list_head *item);
 void list_lru_isolate_move(struct list_lru_one *list, struct list_head *item,
 			   struct list_head *head);
 
+/*
+ * list_lru_putback: undo list_lru_isolate.
+ *
+ * Since we might have dropped the LRU lock in between, recompute list_lru_one
+ * from the node's id and memcg.
+ */
+void list_lru_putback(struct list_lru *lru, struct list_head *item, int nid,
+		struct mem_cgroup *memcg);
+
 typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
 		struct list_lru_one *list, spinlock_t *lock, void *cb_arg);
 
diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 2a60ce39cfde..04f80b64a09b 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -15,6 +15,8 @@ bool zswap_load(struct folio *folio);
 void zswap_invalidate(int type, pgoff_t offset);
 void zswap_swapon(int type);
 void zswap_swapoff(int type);
+bool zswap_remove_swpentry_from_lru(swp_entry_t swpentry);
+void zswap_insert_swpentry_into_lru(swp_entry_t swpentry);
 
 #else
 
@@ -32,6 +34,13 @@ static inline void zswap_invalidate(int type, pgoff_t offset) {}
 static inline void zswap_swapon(int type) {}
 static inline void zswap_swapoff(int type) {}
 
+static inline bool zswap_remove_swpentry_from_lru(swp_entry_t swpentry)
+{
+	return false;
+}
+
+static inline void zswap_insert_swpentry_into_lru(swp_entry_t swpentry) {}
+
 #endif
 
 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/list_lru.c b/mm/list_lru.c
index a05e5bef3b40..37c5c2ef6c0e 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -119,18 +119,26 @@ list_lru_from_kmem(struct list_lru *lru, int nid, void *ptr,
 bool list_lru_add(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
+	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
+		mem_cgroup_from_slab_obj(item) : NULL;
+
+	return __list_lru_add(lru, item, nid, memcg);
+}
+EXPORT_SYMBOL_GPL(list_lru_add);
+
+bool __list_lru_add(struct list_lru *lru, struct list_head *item, int nid,
+		struct mem_cgroup *memcg)
+{
 	struct list_lru_node *nlru = &lru->node[nid];
-	struct mem_cgroup *memcg;
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (list_empty(item)) {
-		l = list_lru_from_kmem(lru, nid, item, &memcg);
+		l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 		list_add_tail(item, &l->list);
 		/* Set shrinker bit if the first element was added */
 		if (!l->nr_items++)
-			set_shrinker_bit(memcg, nid,
-					 lru_shrinker_id(lru));
+			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
 		nlru->nr_items++;
 		spin_unlock(&nlru->lock);
 		return true;
@@ -138,17 +146,27 @@ bool list_lru_add(struct list_lru *lru, struct list_head *item)
 	spin_unlock(&nlru->lock);
 	return false;
 }
-EXPORT_SYMBOL_GPL(list_lru_add);
+EXPORT_SYMBOL_GPL(__list_lru_add);
 
 bool list_lru_del(struct list_lru *lru, struct list_head *item)
 {
 	int nid = page_to_nid(virt_to_page(item));
+	struct mem_cgroup *memcg = list_lru_memcg_aware(lru) ?
+		mem_cgroup_from_slab_obj(item) : NULL;
+
+	return __list_lru_del(lru, item, nid, memcg);
+}
+EXPORT_SYMBOL_GPL(list_lru_del);
+
+bool __list_lru_del(struct list_lru *lru, struct list_head *item, int nid,
+		struct mem_cgroup *memcg)
+{
 	struct list_lru_node *nlru = &lru->node[nid];
 	struct list_lru_one *l;
 
 	spin_lock(&nlru->lock);
 	if (!list_empty(item)) {
-		l = list_lru_from_kmem(lru, nid, item, NULL);
+		l = list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
 		list_del_init(item);
 		l->nr_items--;
 		nlru->nr_items--;
@@ -158,7 +176,7 @@ bool list_lru_del(struct list_lru *lru, struct list_head *item)
 	spin_unlock(&nlru->lock);
 	return false;
 }
-EXPORT_SYMBOL_GPL(list_lru_del);
+EXPORT_SYMBOL_GPL(__list_lru_del);
 
 void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
 {
@@ -175,6 +193,20 @@ void list_lru_isolate_move(struct list_lru_one *list, struct list_head *item,
 }
 EXPORT_SYMBOL_GPL(list_lru_isolate_move);
 
+void list_lru_putback(struct list_lru *lru, struct list_head *item, int nid,
+		struct mem_cgroup *memcg)
+{
+	struct list_lru_one *list =
+		list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
+
+	if (list_empty(item)) {
+		list_add_tail(item, &list->list);
+		if (!list->nr_items++)
+			set_shrinker_bit(memcg, nid, lru_shrinker_id(lru));
+	}
+}
+EXPORT_SYMBOL_GPL(list_lru_putback);
+
 unsigned long list_lru_count_one(struct list_lru *lru,
 				 int nid, struct mem_cgroup *memcg)
 {
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b3b14bd0dd64..1c826737aacb 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -21,6 +21,7 @@
 #include <linux/swap_slots.h>
 #include <linux/huge_mm.h>
 #include <linux/shmem_fs.h>
+#include <linux/zswap.h>
 #include "internal.h"
 #include "swap.h"
 
@@ -417,6 +418,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	struct folio *folio;
 	struct page *page;
 	void *shadow = NULL;
+	bool zswap_lru_removed = false;
 
 	*new_page_allocated = false;
 	si = get_swap_device(entry);
@@ -485,6 +487,17 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 
+	/*
+	 * Page fault might itself trigger reclaim, on a zswap object that
+	 * corresponds to the same swap entry. However, as the swap entry has
+	 * previously been pinned, the task will run into an infinite loop trying
+	 * to pin the swap entry again.
+	 *
+	 * To prevent this from happening, we remove it from the zswap
+	 * LRU to prevent its reclamation.
+	 */
+	zswap_lru_removed = zswap_remove_swpentry_from_lru(entry);
+
 	if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
 		goto fail_unlock;
 
@@ -497,6 +510,9 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	if (shadow)
 		workingset_refault(folio, shadow);
 
+	if (zswap_lru_removed)
+		zswap_insert_swpentry_into_lru(entry);
+
 	/* Caller will initiate read into locked folio */
 	folio_add_lru(folio);
 	*new_page_allocated = true;
@@ -506,6 +522,9 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 	return page;
 
 fail_unlock:
+	if (zswap_lru_removed)
+		zswap_insert_swpentry_into_lru(entry);
+
 	put_swap_folio(folio, entry);
 	folio_unlock(folio);
 	folio_put(folio);
diff --git a/mm/zswap.c b/mm/zswap.c
index 412b1409a0d7..83386200222a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -34,6 +34,7 @@
 #include <linux/writeback.h>
 #include <linux/pagemap.h>
 #include <linux/workqueue.h>
+#include <linux/list_lru.h>
 
 #include "swap.h"
 #include "internal.h"
@@ -171,8 +172,8 @@ struct zswap_pool {
 	struct work_struct shrink_work;
 	struct hlist_node node;
 	char tfm_name[CRYPTO_MAX_ALG_NAME];
-	struct list_head lru;
-	spinlock_t lru_lock;
+	struct list_lru list_lru;
+	struct mem_cgroup *next_shrink;
 };
 
 /*
@@ -209,6 +210,7 @@ struct zswap_entry {
 		unsigned long value;
 	};
 	struct obj_cgroup *objcg;
+	int nid;
 	struct list_head lru;
 };
 
@@ -309,6 +311,29 @@ static void zswap_entry_cache_free(struct zswap_entry *entry)
 	kmem_cache_free(zswap_entry_cache, entry);
 }
 
+/*********************************
+* lru functions
+**********************************/
+static bool zswap_lru_add(struct list_lru *list_lru, struct zswap_entry *entry)
+{
+	struct mem_cgroup *memcg = entry->objcg ?
+		get_mem_cgroup_from_objcg(entry->objcg) : NULL;
+	bool added = __list_lru_add(list_lru, &entry->lru, entry->nid, memcg);
+
+	mem_cgroup_put(memcg);
+	return added;
+}
+
+static bool zswap_lru_del(struct list_lru *list_lru, struct zswap_entry *entry)
+{
+	struct mem_cgroup *memcg = entry->objcg ?
+		get_mem_cgroup_from_objcg(entry->objcg) : NULL;
+	bool removed = __list_lru_del(list_lru, &entry->lru, entry->nid, memcg);
+
+	mem_cgroup_put(memcg);
+	return removed;
+}
+
 /*********************************
 * rbtree functions
 **********************************/
@@ -393,9 +418,7 @@ static void zswap_free_entry(struct zswap_entry *entry)
 	if (!entry->length)
 		atomic_dec(&zswap_same_filled_pages);
 	else {
-		spin_lock(&entry->pool->lru_lock);
-		list_del(&entry->lru);
-		spin_unlock(&entry->pool->lru_lock);
+		zswap_lru_del(&entry->pool->list_lru, entry);
 		zpool_free(zswap_find_zpool(entry), entry->handle);
 		zswap_pool_put(entry->pool);
 	}
@@ -629,21 +652,16 @@ static void zswap_invalidate_entry(struct zswap_tree *tree,
 		zswap_entry_put(tree, entry);
 }
 
-static int zswap_reclaim_entry(struct zswap_pool *pool)
+static enum lru_status shrink_memcg_cb(struct list_head *item, struct list_lru_one *l,
+				       spinlock_t *lock, void *arg)
 {
-	struct zswap_entry *entry;
+	struct zswap_entry *entry = container_of(item, struct zswap_entry, lru);
+	struct mem_cgroup *memcg;
 	struct zswap_tree *tree;
 	pgoff_t swpoffset;
-	int ret;
+	enum lru_status ret = LRU_REMOVED_RETRY;
+	int writeback_result;
 
-	/* Get an entry off the LRU */
-	spin_lock(&pool->lru_lock);
-	if (list_empty(&pool->lru)) {
-		spin_unlock(&pool->lru_lock);
-		return -EINVAL;
-	}
-	entry = list_last_entry(&pool->lru, struct zswap_entry, lru);
-	list_del_init(&entry->lru);
 	/*
 	 * Once the lru lock is dropped, the entry might get freed. The
 	 * swpoffset is copied to the stack, and entry isn't deref'd again
@@ -651,26 +669,35 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	 */
 	swpoffset = swp_offset(entry->swpentry);
 	tree = zswap_trees[swp_type(entry->swpentry)];
-	spin_unlock(&pool->lru_lock);
+	list_lru_isolate(l, item);
+	spin_unlock(lock);
 
 	/* Check for invalidate() race */
 	spin_lock(&tree->lock);
 	if (entry != zswap_rb_search(&tree->rbroot, swpoffset)) {
-		ret = -EAGAIN;
 		goto unlock;
 	}
 	/* Hold a reference to prevent a free during writeback */
 	zswap_entry_get(entry);
 	spin_unlock(&tree->lock);
 
-	ret = zswap_writeback_entry(entry, tree);
+	writeback_result = zswap_writeback_entry(entry, tree);
 
 	spin_lock(&tree->lock);
-	if (ret) {
-		/* Writeback failed, put entry back on LRU */
-		spin_lock(&pool->lru_lock);
-		list_move(&entry->lru, &pool->lru);
-		spin_unlock(&pool->lru_lock);
+	if (writeback_result) {
+		zswap_reject_reclaim_fail++;
+
+		/* Check for invalidate() race */
+		if (entry != zswap_rb_search(&tree->rbroot, swpoffset))
+			goto put_unlock;
+
+		memcg = entry->objcg ? get_mem_cgroup_from_objcg(entry->objcg) : NULL;
+		spin_lock(lock);
+		/* we cannot use zswap_lru_add here, because it increments node's lru count */
+		list_lru_putback(&entry->pool->list_lru, item, entry->nid, memcg);
+		spin_unlock(lock);
+		mem_cgroup_put(memcg);
+		ret = LRU_RETRY;
 		goto put_unlock;
 	}
 
@@ -686,19 +713,63 @@ static int zswap_reclaim_entry(struct zswap_pool *pool)
 	zswap_entry_put(tree, entry);
 unlock:
 	spin_unlock(&tree->lock);
-	return ret ? -EAGAIN : 0;
+	spin_lock(lock);
+	return ret;
+}
+
+static int shrink_memcg(struct mem_cgroup *memcg)
+{
+	struct zswap_pool *pool;
+	int nid, shrunk = 0;
+	bool is_empty = true;
+
+	pool = zswap_pool_current_get();
+	if (!pool)
+		return -EINVAL;
+
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		unsigned long nr_to_walk = 1;
+
+		if (list_lru_walk_one(&pool->list_lru, nid, memcg, &shrink_memcg_cb,
+				      NULL, &nr_to_walk))
+			shrunk++;
+		if (!nr_to_walk)
+			is_empty = false;
+	}
+	zswap_pool_put(pool);
+
+	if (is_empty)
+		return -EINVAL;
+	if (shrunk)
+		return 0;
+	return -EAGAIN;
 }
 
 static void shrink_worker(struct work_struct *w)
 {
 	struct zswap_pool *pool = container_of(w, typeof(*pool),
 						shrink_work);
-	int ret, failures = 0;
+	int ret, failures = 0, memcg_selection_failures = 0;
 
+	/* global reclaim will select cgroup in a round-robin fashion. */
 	do {
-		ret = zswap_reclaim_entry(pool);
+		/* previous next_shrink has become a zombie - restart from the top */
+		if (pool->next_shrink && !mem_cgroup_online(pool->next_shrink)) {
+			css_put(&pool->next_shrink->css);
+			pool->next_shrink = NULL;
+		}
+		pool->next_shrink = mem_cgroup_iter(NULL, pool->next_shrink, NULL);
+
+		/* fails to find a suitable cgroup - give the worker another chance. */
+		if (!pool->next_shrink) {
+			if (++memcg_selection_failures == 2)
+				break;
+			continue;
+		}
+
+		ret = shrink_memcg(pool->next_shrink);
+
 		if (ret) {
-			zswap_reject_reclaim_fail++;
 			if (ret != -EAGAIN)
 				break;
 			if (++failures == MAX_RECLAIM_RETRIES)
@@ -764,9 +835,8 @@ static struct zswap_pool *zswap_pool_create(char *type, char *compressor)
 	 */
 	kref_init(&pool->kref);
 	INIT_LIST_HEAD(&pool->list);
-	INIT_LIST_HEAD(&pool->lru);
-	spin_lock_init(&pool->lru_lock);
 	INIT_WORK(&pool->shrink_work, shrink_worker);
+	list_lru_init_memcg(&pool->list_lru, NULL);
 
 	zswap_pool_debug("created", pool);
 
@@ -831,6 +901,9 @@ static void zswap_pool_destroy(struct zswap_pool *pool)
 
 	cpuhp_state_remove_instance(CPUHP_MM_ZSWP_POOL_PREPARE, &pool->node);
 	free_percpu(pool->acomp_ctx);
+	list_lru_destroy(&pool->list_lru);
+	if (pool->next_shrink)
+		css_put(&pool->next_shrink->css);
 	for (i = 0; i < ZSWAP_NR_ZPOOLS; i++)
 		zpool_destroy_pool(pool->zpools[i]);
 	kfree(pool);
@@ -1199,8 +1272,10 @@ bool zswap_store(struct folio *folio)
 	struct scatterlist input, output;
 	struct crypto_acomp_ctx *acomp_ctx;
 	struct obj_cgroup *objcg = NULL;
+	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
 	struct zpool *zpool;
+	int lru_alloc_ret;
 	unsigned int dlen = PAGE_SIZE;
 	unsigned long handle, value;
 	char *buf;
@@ -1218,14 +1293,15 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_enabled || !tree)
 		return false;
 
-	/*
-	 * XXX: zswap reclaim does not work with cgroups yet. Without a
-	 * cgroup-aware entry LRU, we will push out entries system-wide based on
-	 * local cgroup limits.
-	 */
 	objcg = get_obj_cgroup_from_folio(folio);
-	if (objcg && !obj_cgroup_may_zswap(objcg))
-		goto reject;
+	if (objcg && !obj_cgroup_may_zswap(objcg)) {
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		if (shrink_memcg(memcg)) {
+			css_put(&memcg->css);
+			goto reject;
+		}
+		css_put(&memcg->css);
+	}
 
 	/* reclaim space if needed */
 	if (zswap_is_full()) {
@@ -1240,7 +1316,11 @@ bool zswap_store(struct folio *folio)
 		else
 			zswap_pool_reached_full = false;
 	}
-
+	pool = zswap_pool_current_get();
+	if (!pool) {
+		ret = -EINVAL;
+		goto reject;
+	}
 	/* allocate entry */
 	entry = zswap_entry_cache_alloc(GFP_KERNEL);
 	if (!entry) {
@@ -1256,6 +1336,7 @@ bool zswap_store(struct folio *folio)
 			entry->length = 0;
 			entry->value = value;
 			atomic_inc(&zswap_same_filled_pages);
+			zswap_pool_put(pool);
 			goto insert_entry;
 		}
 		kunmap_atomic(src);
@@ -1264,6 +1345,15 @@ bool zswap_store(struct folio *folio)
 	if (!zswap_non_same_filled_pages_enabled)
 		goto freepage;
 
+	if (objcg) {
+		memcg = get_mem_cgroup_from_objcg(objcg);
+		lru_alloc_ret = memcg_list_lru_alloc(memcg, &pool->list_lru, GFP_KERNEL);
+		css_put(&memcg->css);
+
+		if (lru_alloc_ret)
+			goto freepage;
+	}
+
 	/* if entry is successfully added, it keeps the reference */
 	entry->pool = zswap_pool_current_get();
 	if (!entry->pool)
@@ -1325,6 +1415,7 @@ bool zswap_store(struct folio *folio)
 
 insert_entry:
 	entry->objcg = objcg;
+	entry->nid = page_to_nid(page);
 	if (objcg) {
 		obj_cgroup_charge_zswap(objcg, entry->length);
 		/* Account before objcg ref is moved to tree */
@@ -1338,9 +1429,8 @@ bool zswap_store(struct folio *folio)
 		zswap_invalidate_entry(tree, dupentry);
 	}
 	if (entry->length) {
-		spin_lock(&entry->pool->lru_lock);
-		list_add(&entry->lru, &entry->pool->lru);
-		spin_unlock(&entry->pool->lru_lock);
+		INIT_LIST_HEAD(&entry->lru);
+		zswap_lru_add(&pool->list_lru, entry);
 	}
 	spin_unlock(&tree->lock);
 
@@ -1447,9 +1537,8 @@ bool zswap_load(struct folio *folio)
 		zswap_invalidate_entry(tree, entry);
 		folio_mark_dirty(folio);
 	} else if (entry->length) {
-		spin_lock(&entry->pool->lru_lock);
-		list_move(&entry->lru, &entry->pool->lru);
-		spin_unlock(&entry->pool->lru_lock);
+		zswap_lru_del(&entry->pool->list_lru, entry);
+		zswap_lru_add(&entry->pool->list_lru, entry);
 	}
 	zswap_entry_put(tree, entry);
 	spin_unlock(&tree->lock);
@@ -1507,6 +1596,48 @@ void zswap_swapoff(int type)
 	zswap_trees[type] = NULL;
 }
 
+bool zswap_remove_swpentry_from_lru(swp_entry_t swpentry)
+{
+	struct zswap_tree *tree = zswap_trees[swp_type(swpentry)];
+	struct zswap_entry *entry;
+	struct zswap_pool *pool;
+	bool removed = false;
+
+	/* get the zswap entry and prevent it from being freed */
+	spin_lock(&tree->lock);
+	entry = zswap_rb_search(&tree->rbroot, swp_offset(swpentry));
+	/* skip if the entry is already written back or is a same filled page */
+	if (!entry || !entry->length)
+		goto tree_unlock;
+
+	pool = entry->pool;
+	removed = zswap_lru_del(&pool->list_lru, entry);
+
+tree_unlock:
+	spin_unlock(&tree->lock);
+	return removed;
+}
+
+void zswap_insert_swpentry_into_lru(swp_entry_t swpentry)
+{
+	struct zswap_tree *tree = zswap_trees[swp_type(swpentry)];
+	struct zswap_entry *entry;
+	struct zswap_pool *pool;
+
+	/* get the zswap entry and prevent it from being freed */
+	spin_lock(&tree->lock);
+	entry = zswap_rb_search(&tree->rbroot, swp_offset(swpentry));
+	/* skip if the entry is already written back or is a same filled page */
+	if (!entry || !entry->length)
+		goto tree_unlock;
+
+	pool = entry->pool;
+	zswap_lru_add(&pool->list_lru, entry);
+
+tree_unlock:
+	spin_unlock(&tree->lock);
+}
+
 /*********************************
 * debugfs functions
 **********************************/
@@ -1560,7 +1691,7 @@ static int zswap_setup(void)
 	struct zswap_pool *pool;
 	int ret;
 
-	zswap_entry_cache = KMEM_CACHE(zswap_entry, 0);
+	zswap_entry_cache = KMEM_CACHE(zswap_entry, SLAB_ACCOUNT);
 	if (!zswap_entry_cache) {
 		pr_err("entry cache creation failed\n");
 		goto cache_fail;
-- 
2.34.1

