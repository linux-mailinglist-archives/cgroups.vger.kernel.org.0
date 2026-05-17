Return-Path: <cgroups+bounces-16015-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBGVKEfiCWokuAQAu9opvQ
	(envelope-from <cgroups+bounces-16015-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:44:07 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0385856215D
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 135953049957
	for <lists+cgroups@lfdr.de>; Sun, 17 May 2026 15:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9F3C09E4;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrOM3DO2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFC13BC69E;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032389; cv=none; b=odNFL5TUl6t6w+7vs6PdLYVJqp630CZ+FNU1KgYPZ8Aa7emLTKH7aW5Wp/SFuATeEnbS6l9hfIOSUqY8tt8JQRBN2G/Jio1B56lHv3LBsyVdm4MQaaGrFgo8ThwO4qOigl1dM9EkdepF6GYlMDURI+AJFBfZXU1jTKEjXxcV+Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032389; c=relaxed/simple;
	bh=ywsc30h0pTm+0AkzKZFg/ZB6sIicQ6hYTTCBSgZ6DLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBDTuhGcIloqQvlEc0YqFv+QzhdGODT7NYxJZqlblZ1Rzs2DKYINl0SpQariKZR4tAl/+iDV3zAKBCzV5xUu9E34Em14q2VgwI7y768U+hHjz1NAdVH+PuRz5o/T+cRfl4J44+SsGjEMZ20/5H2e9+UrfbDsK8DI/Z/pFbXDMq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrOM3DO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D97AC2BCFD;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779032389;
	bh=ywsc30h0pTm+0AkzKZFg/ZB6sIicQ6hYTTCBSgZ6DLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=OrOM3DO2RP6CNRzGi0gTw5Meh8zh9zGkh0Dugc17AyavRrzo1KJBuYsVUkHaPHQrd
	 ICNW8cdqMeCsZ4nNq0OX/CxGLpNULIqbl8Do+pYSaSevlp/AvEa6SEZZcDQMoAxZrn
	 iOCAnu6uWZXm0D4p3thDf2MVn76GJtInzLK+B1o53xPzFFaWTcvpFxbOnvK7+YIMua
	 9I2+M/HG7e0sxMevLoCxaiewcc6YW3KRcATZlUjUcgcHpxTVBNJEevMotNAh9YhVhn
	 qCClJ9DAvkukF/8PZ5QVxGbbd9SGO5yrEV4yKRtZCo0nXsE7W9Zif9PB1LzehpH2nK
	 7qJ11Lg9vWh3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04059CD4F47;
	Sun, 17 May 2026 15:39:49 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Sun, 17 May 2026 23:39:45 +0800
Subject: [PATCH v5 06/12] mm/memcg, swap: tidy up cgroup v1 memsw swap
 helpers
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260517-swap-table-p4-v5-6-88ae43e064c7@tencent.com>
References: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
In-Reply-To: <20260517-swap-table-p4-v5-0-88ae43e064c7@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, Yosry Ahmed <yosry@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779032386; l=9795;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=gCgUUE/Etfz8T9X0Mywmw2qi0UZBkmFa6lWPz7BcjGo=;
 b=zSehdC7R81v31OVC9Y5cQntcQByyo/27QgkaU/0kJ+Ss/mYlUb4eBRTiM0MtTVnh5TTV5GRbp
 h9jcqFma61UDq9qXqQV5/Jm2JBtOrvWK7radt5LhwjGxhF+dsYeJkqS
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Queue-Id: 0385856215D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16015-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,lge.com,linux.dev,vger.kernel.org,tencent.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tencent.com:email,tencent.com:mid,tencent.com:replyto]
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

The cgroup v1 swap helpers always operate on swap cache folios whose
swap entry is stable: the folio is locked and in the swap cache. There
is no need to pass the swap entry or page count as separate parameters
when they can be derived from the folio itself.

Simplify the redundant parameters and add sanity checks to document
the required preconditions.

Also rename memcg1_swapout to __memcg1_swapout to indicate it requires
special calling context: the folio must be isolated and dying, and the
call must be made with interrupts disabled.

No functional change.

Acked-by: Chris Li <chrisl@kernel.org>
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/memcontrol.h |  8 ++++----
 include/linux/swap.h       | 10 ++++------
 mm/huge_memory.c           |  2 +-
 mm/memcontrol-v1.c         | 33 ++++++++++++++++++++-------------
 mm/memcontrol.c            |  9 ++++-----
 mm/swap_state.c            |  4 ++--
 mm/swapfile.c              |  2 +-
 mm/vmscan.c                |  2 +-
 8 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index dc3fa687759b..7d08128de1fd 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1899,8 +1899,8 @@ static inline void mem_cgroup_exit_user_fault(void)
 	current->in_user_fault = 0;
 }
 
-void memcg1_swapout(struct folio *folio, swp_entry_t entry);
-void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages);
+void __memcg1_swapout(struct folio *folio);
+void memcg1_swapin(struct folio *folio);
 
 #else /* CONFIG_MEMCG_V1 */
 static inline
@@ -1929,11 +1929,11 @@ static inline void mem_cgroup_exit_user_fault(void)
 {
 }
 
-static inline void memcg1_swapout(struct folio *folio, swp_entry_t entry)
+static inline void __memcg1_swapout(struct folio *folio)
 {
 }
 
-static inline void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
+static inline void memcg1_swapin(struct folio *folio)
 {
 }
 
diff --git a/include/linux/swap.h b/include/linux/swap.h
index aa89e1d30a77..6b3acdf9bdd4 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -576,13 +576,12 @@ static inline void folio_throttle_swaprate(struct folio *folio, gfp_t gfp)
 #endif
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
-int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry);
-static inline int mem_cgroup_try_charge_swap(struct folio *folio,
-		swp_entry_t entry)
+int __mem_cgroup_try_charge_swap(struct folio *folio);
+static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 {
 	if (mem_cgroup_disabled())
 		return 0;
-	return __mem_cgroup_try_charge_swap(folio, entry);
+	return __mem_cgroup_try_charge_swap(folio);
 }
 
 extern void __mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_pages);
@@ -596,8 +595,7 @@ static inline void mem_cgroup_uncharge_swap(swp_entry_t entry, unsigned int nr_p
 extern long mem_cgroup_get_nr_swap_pages(struct mem_cgroup *memcg);
 extern bool mem_cgroup_swap_full(struct folio *folio);
 #else
-static inline int mem_cgroup_try_charge_swap(struct folio *folio,
-					     swp_entry_t entry)
+static inline int mem_cgroup_try_charge_swap(struct folio *folio)
 {
 	return 0;
 }
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c565b2a651e0..42b86e8ab7c0 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -4430,7 +4430,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 
 	/*
 	 * Exclude swapcache: originally to avoid a corrupt deferred split
-	 * queue. Nowadays that is fully prevented by memcg1_swapout();
+	 * queue. Nowadays that is fully prevented by __memcg1_swapout();
 	 * but if page reclaim is already handling the same folio, it is
 	 * unnecessary to handle it again in the shrinker, so excluding
 	 * swapcache here may still be a useful optimization.
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 433bba9dfe71..36c507d81dc5 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -604,18 +604,23 @@ void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 }
 
 /**
- * memcg1_swapout - transfer a memsw charge to swap
+ * __memcg1_swapout - transfer a memsw charge to swap
  * @folio: folio whose memsw charge to transfer
- * @entry: swap entry to move the charge to
  *
- * Transfer the memsw charge of @folio to @entry.
+ * Transfer the memsw charge of @folio to the swap entry stored in
+ * folio->swap.
+ *
+ * Context: folio must be isolated, unmapped, locked and is just about
+ * to be freed, and caller must disable IRQs.
  */
-void memcg1_swapout(struct folio *folio, swp_entry_t entry)
+void __memcg1_swapout(struct folio *folio)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
 	struct obj_cgroup *objcg;
 	unsigned int nr_entries;
 
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_ref_count(folio), folio);
 
@@ -641,7 +646,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	swap_memcg = mem_cgroup_private_id_get_online(memcg, nr_entries);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
-	swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), entry);
+	swap_cgroup_record(folio, mem_cgroup_private_id(swap_memcg), folio->swap);
 
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
@@ -671,18 +676,20 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	obj_cgroup_put(objcg);
 }
 
-/*
+/**
  * memcg1_swapin - uncharge swap slot
- * @entry: the first swap entry for which the pages are charged
- * @nr_pages: number of pages which will be uncharged
+ * @folio: folio being swapped in
  *
- * Call this function after successfully adding the charged page to swapcache.
+ * Call this function after successfully adding the charged
+ * folio to swapcache.
  *
- * Note: This function assumes the page for which swap slot is being uncharged
- * is order 0 page.
+ * Context: The folio has to be in swap cache and locked.
  */
-void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
+void memcg1_swapin(struct folio *folio)
 {
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
+
 	/*
 	 * Cgroup1's unified memory+swap counter has been charged with the
 	 * new swapcache page, finish the transfer by uncharging the swap
@@ -701,7 +708,7 @@ void memcg1_swapin(swp_entry_t entry, unsigned int nr_pages)
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, nr_pages);
+		mem_cgroup_uncharge_swap(folio->swap, folio_nr_pages(folio));
 	}
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d978e18b9b2d..a28a68eed7ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5464,13 +5464,12 @@ int __init mem_cgroup_init(void)
 /**
  * __mem_cgroup_try_charge_swap - try charging swap space for a folio
  * @folio: folio being added to swap
- * @entry: swap entry to charge
  *
- * Try to charge @folio's memcg for the swap space at @entry.
+ * Try to charge @folio's memcg for the swap space at folio->swap.
  *
  * Returns 0 on success, -ENOMEM on failure.
  */
-int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
+int __mem_cgroup_try_charge_swap(struct folio *folio)
 {
 	unsigned int nr_pages = folio_nr_pages(folio);
 	struct page_counter *counter;
@@ -5487,7 +5486,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	if (!entry.val) {
+	if (!folio_test_swapcache(folio)) {
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
 		rcu_read_unlock();
 		return 0;
@@ -5506,7 +5505,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	}
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
 
-	swap_cgroup_record(folio, mem_cgroup_private_id(memcg), entry);
+	swap_cgroup_record(folio, mem_cgroup_private_id(memcg), folio->swap);
 
 	return 0;
 }
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 98c8691826fb..7a80494fa37f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -455,8 +455,8 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* For memsw accounting, swap is uncharged when folio is added to swap cache */
-	memcg1_swapin(entry, 1 << order);
+	/* memsw uncharges swap when folio is added to swap cache */
+	memcg1_swapin(folio);
 	if (shadow)
 		workingset_refault(folio, shadow);
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4e5a54769e81..5c8bb15719bf 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1731,7 +1731,7 @@ int folio_alloc_swap(struct folio *folio)
 	}
 
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
-	if (unlikely(mem_cgroup_try_charge_swap(folio, folio->swap)))
+	if (unlikely(mem_cgroup_try_charge_swap(folio)))
 		swap_cache_del_folio(folio);
 
 	if (unlikely(!folio_test_swapcache(folio)))
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b3e555561417..924c84326551 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -737,7 +737,7 @@ static int __remove_mapping(struct address_space *mapping, struct folio *folio,
 
 		if (reclaimed && !mapping_exiting(mapping))
 			shadow = workingset_eviction(folio, target_memcg);
-		memcg1_swapout(folio, swap);
+		__memcg1_swapout(folio);
 		__swap_cache_del_folio(ci, folio, swap, shadow);
 		swap_cluster_unlock_irq(ci);
 	} else {

-- 
2.54.0



