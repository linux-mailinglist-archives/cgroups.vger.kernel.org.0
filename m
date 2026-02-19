Return-Path: <cgroups+bounces-14039-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLkmKkWgl2nc3AIAu9opvQ
	(envelope-from <cgroups+bounces-14039-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:44:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBE163A19
	for <lists+cgroups@lfdr.de>; Fri, 20 Feb 2026 00:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F51F3071A4F
	for <lists+cgroups@lfdr.de>; Thu, 19 Feb 2026 23:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7B4331A6D;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KQB2OPOB"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E633314B7;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771544528; cv=none; b=k8EdeMQA96KmdBlhvYow9Fb4V5o9ukYF11xgtRygyDeLVVl9Hq9l+buK6a4PsnHTU1P8kGyCH2R5OAgf9/FGQ4frsYvCpWDnm7oZtRzdoxAhOMsExUPht5EzBu7ghNIE+GWnF+IdsEfokSpigafOvJL2YEwyvtWqvauq30l8A3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771544528; c=relaxed/simple;
	bh=/QtGbmL1TXC2oAX2Iuptbz2C/1byQSYgNfnZVKvjNtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JKWC9ZssD59ETpV69Tq2Cq5Imq9Eg+r7tnnpH8/8wDov+AmULGjJZ3VFggBS1kzYLCfHbCm31BdzoLbSSqjTIYJjcCkE0sIRYwjOkZuotPQdyoLzuAUKBXuOD9Q5hcqoIyxzcACvySCWBkAfeQDBjnGX0j+9HyBTo6jTuZU/9AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KQB2OPOB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64D08C2BCAF;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771544528;
	bh=/QtGbmL1TXC2oAX2Iuptbz2C/1byQSYgNfnZVKvjNtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=KQB2OPOBM/pjAAk9pZ4JITH0OF9/923f2NJF43QpK5OC1bRKo/MqYSGoguMpcWjRV
	 ezfMmrnDJCa9avsk30iBcqH1zsgYReHQKpbnvkpYAXyJ7+itUnyA1jnhHQJlYnQT5o
	 F5DxQhBt7G5ilOTuwuUIscOGTm/hEYCtTOGr9y5NCnMF/S+PMJXLw/3gbT81KyabTQ
	 7xScPg3ee4g3nseIs2H48OOg61uP5UmtVKErm/Pa0UpqW6YTF8/y3VN4f9k2Ycr4jo
	 FPsn/RIU36S1xbMn9KV1KzUzyd4AYlRX827kHtD/gA2tk9PmYKzMnwZ8g3kEAkjOTA
	 VL8tKd54XT78A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C662C531EB;
	Thu, 19 Feb 2026 23:42:08 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 20 Feb 2026 07:42:16 +0800
Subject: [PATCH RFC 15/15] mm, swap: allocate cluster dynamically for ghost
 swapfile
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-swap-table-p4-v1-15-104795d19815@tencent.com>
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
In-Reply-To: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
 cgroups@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771544524; l=19753;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=u9csOIKG9VriVNBt5F3fiF35yiPdu1SM5al5oGisUCo=;
 b=j9KplqMb0u3hORs3FRAbIrR2GIN8gWkTW7vVNI1catIXs2JB76IZ4taZdDfUTyG5R8KF2tiLx
 gBiqJB5+ZdgBPoP2BUFi73FFXXiMuj1fHoA9SOBNYeHkmYIsqWeZiuI
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14039-lists,cgroups=lfdr.de,kasong.tencent.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org,tencent.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	HAS_REPLYTO(0.00)[kasong@tencent.com]
X-Rspamd-Queue-Id: 14CBE163A19
X-Rspamd-Action: no action

From: Kairui Song <kasong@tencent.com>

Now, the ghost swap file is completely dynamic. For easier testing, this
commit makes the /dev/ghostswap 8 times the size of total ram by
default.

NOTE: This commit is still a minimal proof of concept, so many parts of
the implementation can be improved.

And we have a ci_dyn->virtual_table that's is ready to be used (not used
yet). For example, storing zswap's metadata. In theory the folio lock can
be used to stablize it's virtual table data.

e.g., Swap entry writeback can also be done easily using a
folio_realloc_swap, skip the folio->swap's device and use underlying
devices, it will be easier to do if we remove the global percpu cluster
cache as suggested by [1] and should just work with tiering and priority.
Just put the folio->swap as a reverse entry in the lower layer's swap
table, and collect lower level's swap entry in the virtual_table, then
it's all good.

And right now all allocations are using atomic, which can also be
improved as the swap table already has sleep allocation support,
just need to adapt it.

The RCU lock protection convention can also be simplified.

But without all that, this works pretty well. We can have a "virtual
swap" of any size with zero overhead, common stress tests are showing
a very nice performance, while ordinary swaps have zero overhead,
and everything is runtime configurable.

But don't be too surprised if some corner cases are not well covered
yet, as most works are still focusing on the infrastructure.

Link: https://lore.kernel.org/linux-mm/20260126065242.1221862-5-youngjun.park@lge.com/ [1]
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   1 +
 mm/swap.h            |  44 +++++++++++++---
 mm/swap_state.c      |  35 ++++++++-----
 mm/swap_table.h      |   2 +
 mm/swapfile.c        | 145 +++++++++++++++++++++++++++++++++++++++++++++++----
 5 files changed, 199 insertions(+), 28 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index b57a4a40f4fe..41d7eae56d65 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -284,6 +284,7 @@ struct swap_info_struct {
 	struct work_struct reclaim_work; /* reclaim worker */
 	struct list_head discard_clusters; /* discard clusters list */
 	struct plist_node avail_list;   /* entry in swap_avail_head */
+	struct xarray cluster_info_pool; /* Xarray for ghost swap cluster info */
 };
 
 static inline swp_entry_t page_swap_entry(struct page *page)
diff --git a/mm/swap.h b/mm/swap.h
index 55aa6d904afd..7a4d1d939842 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -41,6 +41,13 @@ struct swap_cluster_info {
 	struct list_head list;
 };
 
+struct swap_cluster_info_dynamic {
+	struct swap_cluster_info ci;	/* Underlying cluster info */
+	unsigned int index;		/* for cluster_index() */
+	struct rcu_head rcu;		/* For kfree_rcu deferred free */
+	/* unsigned long *virtual_table; And we can easily have a virtual table */
+};
+
 /* All on-list cluster must have a non-zero flag. */
 enum swap_cluster_flags {
 	CLUSTER_FLAG_NONE = 0, /* For temporary off-list cluster */
@@ -51,6 +58,7 @@ enum swap_cluster_flags {
 	CLUSTER_FLAG_USABLE = CLUSTER_FLAG_FRAG,
 	CLUSTER_FLAG_FULL,
 	CLUSTER_FLAG_DISCARD,
+	CLUSTER_FLAG_DEAD,	/* Ghost cluster pending kfree_rcu */
 	CLUSTER_FLAG_MAX,
 };
 
@@ -84,9 +92,19 @@ static inline struct swap_info_struct *__swap_entry_to_info(swp_entry_t entry)
 static inline struct swap_cluster_info *__swap_offset_to_cluster(
 		struct swap_info_struct *si, pgoff_t offset)
 {
+	unsigned int cluster_idx = offset / SWAPFILE_CLUSTER;
+
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
 	VM_WARN_ON_ONCE(offset >= roundup(si->max, SWAPFILE_CLUSTER));
-	return &si->cluster_info[offset / SWAPFILE_CLUSTER];
+
+	if (si->flags & SWP_GHOST) {
+		struct swap_cluster_info_dynamic *ci_dyn;
+
+		ci_dyn = xa_load(&si->cluster_info_pool, cluster_idx);
+		return ci_dyn ? &ci_dyn->ci : NULL;
+	}
+
+	return &si->cluster_info[cluster_idx];
 }
 
 static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entry)
@@ -98,7 +116,7 @@ static inline struct swap_cluster_info *__swap_entry_to_cluster(swp_entry_t entr
 static __always_inline struct swap_cluster_info *__swap_cluster_lock(
 		struct swap_info_struct *si, unsigned long offset, bool irq)
 {
-	struct swap_cluster_info *ci = __swap_offset_to_cluster(si, offset);
+	struct swap_cluster_info *ci;
 
 	/*
 	 * Nothing modifies swap cache in an IRQ context. All access to
@@ -111,10 +129,24 @@ static __always_inline struct swap_cluster_info *__swap_cluster_lock(
 	 */
 	VM_WARN_ON_ONCE(!in_task());
 	VM_WARN_ON_ONCE(percpu_ref_is_zero(&si->users)); /* race with swapoff */
-	if (irq)
-		spin_lock_irq(&ci->lock);
-	else
-		spin_lock(&ci->lock);
+
+	rcu_read_lock();
+	ci = __swap_offset_to_cluster(si, offset);
+	if (ci) {
+		if (irq)
+			spin_lock_irq(&ci->lock);
+		else
+			spin_lock(&ci->lock);
+
+		if (ci->flags == CLUSTER_FLAG_DEAD) {
+			if (irq)
+				spin_unlock_irq(&ci->lock);
+			else
+				spin_unlock(&ci->lock);
+			ci = NULL;
+		}
+	}
+	rcu_read_unlock();
 	return ci;
 }
 
diff --git a/mm/swap_state.c b/mm/swap_state.c
index 419419e18a47..1c3600a93ecd 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -90,8 +90,10 @@ struct folio *swap_cache_get_folio(swp_entry_t entry)
 	struct folio *folio;
 
 	for (;;) {
+		rcu_read_lock();
 		swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 					swp_cluster_offset(entry));
+		rcu_read_unlock();
 		if (!swp_tb_is_folio(swp_tb))
 			return NULL;
 		folio = swp_tb_to_folio(swp_tb);
@@ -113,8 +115,10 @@ bool swap_cache_has_folio(swp_entry_t entry)
 {
 	unsigned long swp_tb;
 
+	rcu_read_lock();
 	swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 				swp_cluster_offset(entry));
+	rcu_read_unlock();
 	return swp_tb_is_folio(swp_tb);
 }
 
@@ -130,8 +134,10 @@ void *swap_cache_get_shadow(swp_entry_t entry)
 {
 	unsigned long swp_tb;
 
+	rcu_read_lock();
 	swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 				swp_cluster_offset(entry));
+	rcu_read_unlock();
 	if (swp_tb_is_shadow(swp_tb))
 		return swp_tb_to_shadow(swp_tb);
 	return NULL;
@@ -209,14 +215,14 @@ void __swap_cache_add_folio(struct swap_cluster_info *ci,
 	lruvec_stat_mod_folio(folio, NR_SWAPCACHE, nr_pages);
 }
 
-static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
-					swp_entry_t targ_entry, gfp_t gfp,
+static struct folio *__swap_cache_alloc(swp_entry_t targ_entry, gfp_t gfp,
 					unsigned int order, struct vm_fault *vmf,
 					struct mempolicy *mpol, pgoff_t ilx)
 {
 	int err;
 	swp_entry_t entry;
 	struct folio *folio;
+	struct swap_cluster_info *ci;
 	void *shadow = NULL, *shadow_check = NULL;
 	unsigned long address, nr_pages = 1 << order;
 	unsigned int ci_off, ci_targ = swp_cluster_offset(targ_entry);
@@ -225,9 +231,12 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	ci_off = round_down(ci_targ, nr_pages);
 
 	/* First check if the range is available */
-	spin_lock(&ci->lock);
-	err = __swap_cache_check_batch(ci, entry, ci_off, ci_targ, nr_pages, &shadow);
-	spin_unlock(&ci->lock);
+	err = -ENOENT;
+	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
+	if (ci) {
+		err = __swap_cache_check_batch(ci, entry, ci_off, ci_targ, nr_pages, &shadow);
+		swap_cluster_unlock(ci);
+	}
 	if (unlikely(err))
 		return ERR_PTR(err);
 
@@ -243,10 +252,13 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 		return ERR_PTR(-ENOMEM);
 
 	/* Double check the range is still not in conflict */
-	spin_lock(&ci->lock);
-	err = __swap_cache_check_batch(ci, entry, ci_off, ci_targ, nr_pages, &shadow_check);
+	err = -ENOENT;
+	ci = swap_cluster_lock(__swap_entry_to_info(entry), swp_offset(entry));
+	if (ci)
+		err = __swap_cache_check_batch(ci, entry, ci_off, ci_targ, nr_pages, &shadow_check);
 	if (unlikely(err) || shadow_check != shadow) {
-		spin_unlock(&ci->lock);
+		if (ci)
+			swap_cluster_unlock(ci);
 		folio_put(folio);
 
 		/* If shadow changed, just try again */
@@ -256,13 +268,14 @@ static struct folio *__swap_cache_alloc(struct swap_cluster_info *ci,
 	__folio_set_locked(folio);
 	__folio_set_swapbacked(folio);
 	__swap_cache_add_folio(ci, folio, entry);
-	spin_unlock(&ci->lock);
+	swap_cluster_unlock(ci);
 
 	/* With swap table, we must have a shadow, for memcg tracking */
 	WARN_ON(!shadow);
 
 	if (mem_cgroup_swapin_charge_folio(folio, vmf ? vmf->vma->vm_mm : NULL,
 					   gfp, shadow_to_memcgid(shadow))) {
+		/* The folio pins the cluster */
 		spin_lock(&ci->lock);
 		__swap_cache_del_folio(ci, folio, shadow, false, false);
 		spin_unlock(&ci->lock);
@@ -305,13 +318,11 @@ struct folio *swap_cache_alloc_folio(swp_entry_t targ_entry, gfp_t gfp_mask,
 {
 	int order, err;
 	struct folio *folio;
-	struct swap_cluster_info *ci;
 
 	/* Always allow order 0 so swap won't fail under pressure. */
 	order = orders ? highest_order(orders |= BIT(0)) : 0;
-	ci = __swap_entry_to_cluster(targ_entry);
 	for (;;) {
-		folio = __swap_cache_alloc(ci, targ_entry, gfp_mask, order,
+		folio = __swap_cache_alloc(targ_entry, gfp_mask, order,
 					   vmf, mpol, ilx);
 		if (!IS_ERR(folio))
 			return folio;
diff --git a/mm/swap_table.h b/mm/swap_table.h
index 6d3d773e1908..867bcfff0e3c 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -260,6 +260,8 @@ static inline unsigned long swap_table_get(struct swap_cluster_info *ci,
 	unsigned long swp_tb;
 
 	VM_WARN_ON_ONCE(off >= SWAPFILE_CLUSTER);
+	if (!ci)
+		return SWP_TB_NULL;
 
 	rcu_read_lock();
 	table = rcu_dereference(ci->table);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index d054f40ec75f..f0682c8c8f53 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -404,6 +404,8 @@ static inline bool cluster_is_usable(struct swap_cluster_info *ci, int order)
 static inline unsigned int cluster_index(struct swap_info_struct *si,
 					 struct swap_cluster_info *ci)
 {
+	if (si->flags & SWP_GHOST)
+		return container_of(ci, struct swap_cluster_info_dynamic, ci)->index;
 	return ci - si->cluster_info;
 }
 
@@ -708,6 +710,22 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 		return;
 	}
 
+	if (si->flags & SWP_GHOST) {
+		struct swap_cluster_info_dynamic *ci_dyn;
+
+		ci_dyn = container_of(ci, struct swap_cluster_info_dynamic, ci);
+		if (ci->flags != CLUSTER_FLAG_NONE) {
+			spin_lock(&si->lock);
+			list_del(&ci->list);
+			spin_unlock(&si->lock);
+		}
+		swap_cluster_free_table(ci);
+		xa_erase(&si->cluster_info_pool, ci_dyn->index);
+		ci->flags = CLUSTER_FLAG_DEAD;
+		kfree_rcu(ci_dyn, rcu);
+		return;
+	}
+
 	__free_cluster(si, ci);
 }
 
@@ -814,15 +832,17 @@ static int swap_cluster_setup_bad_slot(struct swap_info_struct *si,
  * stolen by a lower order). @usable will be set to false if that happens.
  */
 static bool cluster_reclaim_range(struct swap_info_struct *si,
-				  struct swap_cluster_info *ci,
+				  struct swap_cluster_info **pcip,
 				  unsigned long start, unsigned int order,
 				  bool *usable)
 {
+	struct swap_cluster_info *ci = *pcip;
 	unsigned int nr_pages = 1 << order;
 	unsigned long offset = start, end = start + nr_pages;
 	unsigned long swp_tb;
 
 	spin_unlock(&ci->lock);
+	rcu_read_lock();
 	do {
 		swp_tb = swap_table_get(ci, offset % SWAPFILE_CLUSTER);
 		if (swp_tb_get_count(swp_tb))
@@ -831,7 +851,15 @@ static bool cluster_reclaim_range(struct swap_info_struct *si,
 			if (__try_to_reclaim_swap(si, offset, TTRS_ANYWAY) < 0)
 				break;
 	} while (++offset < end);
-	spin_lock(&ci->lock);
+	rcu_read_unlock();
+
+	/* Re-lookup: ghost cluster may have been freed while lock was dropped */
+	ci = swap_cluster_lock(si, start);
+	*pcip = ci;
+	if (!ci) {
+		*usable = false;
+		return false;
+	}
 
 	/*
 	 * We just dropped ci->lock so cluster could be used by another
@@ -979,7 +1007,8 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 		if (!cluster_scan_range(si, ci, offset, nr_pages, &need_reclaim))
 			continue;
 		if (need_reclaim) {
-			ret = cluster_reclaim_range(si, ci, offset, order, &usable);
+			ret = cluster_reclaim_range(si, &ci, offset, order,
+						    &usable);
 			if (!usable)
 				goto out;
 			if (cluster_is_empty(ci))
@@ -1005,8 +1034,10 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 	 * should use a new cluster, and move the failed cluster to where it
 	 * should be.
 	 */
-	relocate_cluster(si, ci);
-	swap_cluster_unlock(ci);
+	if (ci) {
+		relocate_cluster(si, ci);
+		swap_cluster_unlock(ci);
+	}
 	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(percpu_swap_cluster.offset[order], next);
 		this_cpu_write(percpu_swap_cluster.si[order], si);
@@ -1038,6 +1069,44 @@ static unsigned int alloc_swap_scan_list(struct swap_info_struct *si,
 	return found;
 }
 
+static unsigned int alloc_swap_scan_dynamic(struct swap_info_struct *si,
+					    struct folio *folio)
+{
+	struct swap_cluster_info_dynamic *ci_dyn;
+	struct swap_cluster_info *ci;
+	struct swap_table *table;
+	unsigned long offset;
+
+	WARN_ON(!(si->flags & SWP_GHOST));
+
+	ci_dyn = kzalloc(sizeof(*ci_dyn), GFP_ATOMIC);
+	if (!ci_dyn)
+		return SWAP_ENTRY_INVALID;
+
+	table = swap_table_alloc(GFP_ATOMIC);
+	if (!table) {
+		kfree(ci_dyn);
+		return SWAP_ENTRY_INVALID;
+	}
+
+	spin_lock_init(&ci_dyn->ci.lock);
+	INIT_LIST_HEAD(&ci_dyn->ci.list);
+	rcu_assign_pointer(ci_dyn->ci.table, table);
+
+	if (xa_alloc(&si->cluster_info_pool, &ci_dyn->index, ci_dyn,
+		     XA_LIMIT(1, DIV_ROUND_UP(si->max, SWAPFILE_CLUSTER) - 1),
+		     GFP_ATOMIC)) {
+		swap_table_free(table);
+		kfree(ci_dyn);
+		return SWAP_ENTRY_INVALID;
+	}
+
+	ci = &ci_dyn->ci;
+	spin_lock(&ci->lock);
+	offset = cluster_offset(si, ci);
+	return alloc_swap_scan_cluster(si, ci, folio, offset);
+}
+
 static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 {
 	long to_scan = 1;
@@ -1060,7 +1129,9 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 				spin_unlock(&ci->lock);
 				nr_reclaim = __try_to_reclaim_swap(si, offset,
 								   TTRS_ANYWAY);
-				spin_lock(&ci->lock);
+				ci = swap_cluster_lock(si, offset);
+				if (!ci)
+					goto next;
 				if (nr_reclaim) {
 					offset += abs(nr_reclaim);
 					continue;
@@ -1074,6 +1145,7 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 			relocate_cluster(si, ci);
 
 		swap_cluster_unlock(ci);
+next:
 		if (to_scan <= 0)
 			break;
 	}
@@ -1136,6 +1208,12 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 			goto done;
 	}
 
+	if (si->flags & SWP_GHOST) {
+		found = alloc_swap_scan_dynamic(si, folio);
+		if (found)
+			goto done;
+	}
+
 	if (!(si->flags & SWP_PAGE_DISCARD)) {
 		found = alloc_swap_scan_list(si, &si->free_clusters, folio, false);
 		if (found)
@@ -1375,7 +1453,8 @@ static bool swap_alloc_fast(struct folio *folio)
 		return false;
 
 	ci = swap_cluster_lock(si, offset);
-	alloc_swap_scan_cluster(si, ci, folio, offset);
+	if (ci)
+		alloc_swap_scan_cluster(si, ci, folio, offset);
 	put_swap_device(si);
 	return folio_test_swapcache(folio);
 }
@@ -1476,6 +1555,7 @@ int swap_retry_table_alloc(swp_entry_t entry, gfp_t gfp)
 	if (!si)
 		return 0;
 
+	/* Entry is in use (being faulted in), so its cluster is alive. */
 	ci = __swap_offset_to_cluster(si, offset);
 	ret = swap_extend_table_alloc(si, ci, gfp);
 
@@ -1996,6 +2076,7 @@ bool folio_maybe_swapped(struct folio *folio)
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_swapcache(folio), folio);
 
+	/* Folio is locked and in swap cache, so ci->count > 0: cluster is alive. */
 	ci = __swap_entry_to_cluster(entry);
 	ci_off = swp_cluster_offset(entry);
 	ci_end = ci_off + folio_nr_pages(folio);
@@ -2124,7 +2205,8 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
 	if (pcp_si == si && pcp_offset) {
 		ci = swap_cluster_lock(si, pcp_offset);
-		offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+		if (ci)
+			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
 	}
 	if (offset == SWAP_ENTRY_INVALID)
 		offset = cluster_alloc_swap_entry(si, NULL);
@@ -2413,8 +2495,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 						&vmf);
 		}
 		if (!folio) {
+			rcu_read_lock();
 			swp_tb = swap_table_get(__swap_entry_to_cluster(entry),
 						swp_cluster_offset(entry));
+			rcu_read_unlock();
 			if (swp_tb_get_count(swp_tb) <= 0)
 				continue;
 			return -ENOMEM;
@@ -2560,8 +2644,10 @@ static unsigned int find_next_to_unuse(struct swap_info_struct *si,
 	 * allocations from this area (while holding swap_lock).
 	 */
 	for (i = prev + 1; i < si->max; i++) {
+		rcu_read_lock();
 		swp_tb = swap_table_get(__swap_offset_to_cluster(si, i),
 					i % SWAPFILE_CLUSTER);
+		rcu_read_unlock();
 		if (!swp_tb_is_null(swp_tb) && !swp_tb_is_bad(swp_tb))
 			break;
 		if ((i % LATENCY_LIMIT) == 0)
@@ -2874,6 +2960,8 @@ static void wait_for_allocation(struct swap_info_struct *si)
 	struct swap_cluster_info *ci;
 
 	BUG_ON(si->flags & SWP_WRITEOK);
+	if (si->flags & SWP_GHOST)
+		return;
 
 	for (offset = 0; offset < end; offset += SWAPFILE_CLUSTER) {
 		ci = swap_cluster_lock(si, offset);
@@ -3394,10 +3482,47 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 				    unsigned long maxpages)
 {
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
-	struct swap_cluster_info *cluster_info;
+	struct swap_cluster_info *cluster_info = NULL;
+	struct swap_cluster_info_dynamic *ci_dyn;
 	int err = -ENOMEM;
 	unsigned long i;
 
+	/* For SWP_GHOST files, initialize Xarray pool instead of static array */
+	if (si->flags & SWP_GHOST) {
+		/*
+		 * Pre-allocate cluster 0 and mark slot 0 (header page)
+		 * as bad so the allocator never hands out page offset 0.
+		 */
+		ci_dyn = kzalloc(sizeof(*ci_dyn), GFP_KERNEL);
+		if (!ci_dyn)
+			goto err;
+		spin_lock_init(&ci_dyn->ci.lock);
+		INIT_LIST_HEAD(&ci_dyn->ci.list);
+
+		nr_clusters = 0;
+		xa_init_flags(&si->cluster_info_pool, XA_FLAGS_ALLOC);
+		err = xa_insert(&si->cluster_info_pool, 0, ci_dyn, GFP_KERNEL);
+		if (err) {
+			kfree(ci_dyn);
+			goto err;
+		}
+
+		err = swap_cluster_setup_bad_slot(si, &ci_dyn->ci, 0, false);
+		if (err) {
+			struct swap_table *table;
+
+			xa_erase(&si->cluster_info_pool, 0);
+			table = (void *)rcu_dereference_protected(ci_dyn->ci.table, true);
+			if (table)
+				swap_table_free(table);
+			kfree(ci_dyn);
+			xa_destroy(&si->cluster_info_pool);
+			goto err;
+		}
+
+		goto setup_cluster_info;
+	}
+
 	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
 	if (!cluster_info)
 		goto err;
@@ -3538,7 +3663,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 	/* /dev/ghostswap: synthesize a ghost swap device. */
 	if (S_ISCHR(inode->i_mode) &&
 	    imajor(inode) == MEM_MAJOR && iminor(inode) == DEVGHOST_MINOR) {
-		maxpages = round_up(totalram_pages(), SWAPFILE_CLUSTER);
+		maxpages = round_up(totalram_pages(), SWAPFILE_CLUSTER) * 8;
 		si->flags |= SWP_GHOST | SWP_SOLIDSTATE;
 		si->bdev = NULL;
 		goto setup;

-- 
2.53.0



