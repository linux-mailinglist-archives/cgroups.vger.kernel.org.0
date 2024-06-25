Return-Path: <cgroups+bounces-3323-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D41915B51
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC4D2824A9
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C0D2FF;
	Tue, 25 Jun 2024 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GmhrTbP+"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D10413ADA
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277175; cv=none; b=Wu186LykX3Z8qcI5kz6qKLKdCfN0e1yBl9bWNKrvDsHhvEBM34MAF9SdxJMkF7lLEaWUe/Y5iNEMoC/gH+/wzyHIpfIBh6OC3vjjwGEnfpS9LUmI6qcJem9BgvQT1pxFqG4gajrH7VuSKiBJte08CPpR5DyU9Os4xyhaRzRicYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277175; c=relaxed/simple;
	bh=vPKmJJJOZYVc4kEAqMQOqjWeooMK18QKthpBQ1BFnaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0TNZZ4NgkKwuI8W5m2jEEVT1ikGuKKMqImOtxCawH6K5PLp1JnaSvJnglLme+gQ7WnLyFu2hjq1WTZRaq5p9Rd/a/gjf/VMuznuOYznQ8MEGRErrhe0GY4AFWednIsuC/PAOVZWDph/2jhqFJim00jWWx1UX2GDZHWmD+VZ4XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GmhrTbP+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rjhMCfmQ5JlzFrU4RV8zWub/Fm9YmIR6Xcl5saEXBXg=;
	b=GmhrTbP+cQCGqW0v1/PBAdYCK9w59SjAQqjOeUubJgdxGDNfRE7O+OSVZO2hMOj0thmYpL
	0HIc5CZIo4WY5zNd2rGVoPrZLXvIDmkwoMrtij56Tjl4iPPSRcrbBeSLihGhfEibFgsv8c
	pFkIK2YNYrNSp9nfGFUPwklXrLeEJ7I=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 02/14] mm: memcg: move soft limit reclaim code to memcontrol-v1.c
Date: Mon, 24 Jun 2024 17:58:54 -0700
Message-ID: <20240625005906.106920-3-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Soft limits are cgroup v1-specific and are not supported by cgroup v2,
so let's move the corresponding code into memcontrol-v1.c.

Aside from simple moving the code, this commits introduces a trivial
memcg1_soft_limit_reset() function to reset soft limits and also
moves the global soft limit tree initialization code into a new
memcg1_init() function.

It also moves corresponding declarations shared between memcontrol.c
and memcontrol-v1.c into mm/memcontrol-v1.h.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 mm/memcontrol-v1.c | 342 +++++++++++++++++++++++++++++++++++++++++++++
 mm/memcontrol-v1.h |   7 +
 mm/memcontrol.c    | 337 +-------------------------------------------
 3 files changed, 353 insertions(+), 333 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index a941446ba575..2ccb8406fa84 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1,3 +1,345 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
+#include <linux/memcontrol.h>
+#include <linux/swap.h>
+#include <linux/mm_inline.h>
+
 #include "memcontrol-v1.h"
+
+/*
+ * Cgroups above their limits are maintained in a RB-Tree, independent of
+ * their hierarchy representation
+ */
+
+struct mem_cgroup_tree_per_node {
+	struct rb_root rb_root;
+	struct rb_node *rb_rightmost;
+	spinlock_t lock;
+};
+
+struct mem_cgroup_tree {
+	struct mem_cgroup_tree_per_node *rb_tree_per_node[MAX_NUMNODES];
+};
+
+static struct mem_cgroup_tree soft_limit_tree __read_mostly;
+
+/*
+ * Maximum loops in mem_cgroup_soft_reclaim(), used for soft
+ * limit reclaim to prevent infinite loops, if they ever occur.
+ */
+#define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
+#define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
+
+static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
+					 struct mem_cgroup_tree_per_node *mctz,
+					 unsigned long new_usage_in_excess)
+{
+	struct rb_node **p = &mctz->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	struct mem_cgroup_per_node *mz_node;
+	bool rightmost = true;
+
+	if (mz->on_tree)
+		return;
+
+	mz->usage_in_excess = new_usage_in_excess;
+	if (!mz->usage_in_excess)
+		return;
+	while (*p) {
+		parent = *p;
+		mz_node = rb_entry(parent, struct mem_cgroup_per_node,
+					tree_node);
+		if (mz->usage_in_excess < mz_node->usage_in_excess) {
+			p = &(*p)->rb_left;
+			rightmost = false;
+		} else {
+			p = &(*p)->rb_right;
+		}
+	}
+
+	if (rightmost)
+		mctz->rb_rightmost = &mz->tree_node;
+
+	rb_link_node(&mz->tree_node, parent, p);
+	rb_insert_color(&mz->tree_node, &mctz->rb_root);
+	mz->on_tree = true;
+}
+
+static void __mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
+					 struct mem_cgroup_tree_per_node *mctz)
+{
+	if (!mz->on_tree)
+		return;
+
+	if (&mz->tree_node == mctz->rb_rightmost)
+		mctz->rb_rightmost = rb_prev(&mz->tree_node);
+
+	rb_erase(&mz->tree_node, &mctz->rb_root);
+	mz->on_tree = false;
+}
+
+static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
+				       struct mem_cgroup_tree_per_node *mctz)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mctz->lock, flags);
+	__mem_cgroup_remove_exceeded(mz, mctz);
+	spin_unlock_irqrestore(&mctz->lock, flags);
+}
+
+static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
+{
+	unsigned long nr_pages = page_counter_read(&memcg->memory);
+	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
+	unsigned long excess = 0;
+
+	if (nr_pages > soft_limit)
+		excess = nr_pages - soft_limit;
+
+	return excess;
+}
+
+void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
+{
+	unsigned long excess;
+	struct mem_cgroup_per_node *mz;
+	struct mem_cgroup_tree_per_node *mctz;
+
+	if (lru_gen_enabled()) {
+		if (soft_limit_excess(memcg))
+			lru_gen_soft_reclaim(memcg, nid);
+		return;
+	}
+
+	mctz = soft_limit_tree.rb_tree_per_node[nid];
+	if (!mctz)
+		return;
+	/*
+	 * Necessary to update all ancestors when hierarchy is used.
+	 * because their event counter is not touched.
+	 */
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		mz = memcg->nodeinfo[nid];
+		excess = soft_limit_excess(memcg);
+		/*
+		 * We have to update the tree if mz is on RB-tree or
+		 * mem is over its softlimit.
+		 */
+		if (excess || mz->on_tree) {
+			unsigned long flags;
+
+			spin_lock_irqsave(&mctz->lock, flags);
+			/* if on-tree, remove it */
+			if (mz->on_tree)
+				__mem_cgroup_remove_exceeded(mz, mctz);
+			/*
+			 * Insert again. mz->usage_in_excess will be updated.
+			 * If excess is 0, no tree ops.
+			 */
+			__mem_cgroup_insert_exceeded(mz, mctz, excess);
+			spin_unlock_irqrestore(&mctz->lock, flags);
+		}
+	}
+}
+
+void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
+{
+	struct mem_cgroup_tree_per_node *mctz;
+	struct mem_cgroup_per_node *mz;
+	int nid;
+
+	for_each_node(nid) {
+		mz = memcg->nodeinfo[nid];
+		mctz = soft_limit_tree.rb_tree_per_node[nid];
+		if (mctz)
+			mem_cgroup_remove_exceeded(mz, mctz);
+	}
+}
+
+static struct mem_cgroup_per_node *
+__mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
+{
+	struct mem_cgroup_per_node *mz;
+
+retry:
+	mz = NULL;
+	if (!mctz->rb_rightmost)
+		goto done;		/* Nothing to reclaim from */
+
+	mz = rb_entry(mctz->rb_rightmost,
+		      struct mem_cgroup_per_node, tree_node);
+	/*
+	 * Remove the node now but someone else can add it back,
+	 * we will to add it back at the end of reclaim to its correct
+	 * position in the tree.
+	 */
+	__mem_cgroup_remove_exceeded(mz, mctz);
+	if (!soft_limit_excess(mz->memcg) ||
+	    !css_tryget(&mz->memcg->css))
+		goto retry;
+done:
+	return mz;
+}
+
+static struct mem_cgroup_per_node *
+mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
+{
+	struct mem_cgroup_per_node *mz;
+
+	spin_lock_irq(&mctz->lock);
+	mz = __mem_cgroup_largest_soft_limit_node(mctz);
+	spin_unlock_irq(&mctz->lock);
+	return mz;
+}
+
+static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
+				   pg_data_t *pgdat,
+				   gfp_t gfp_mask,
+				   unsigned long *total_scanned)
+{
+	struct mem_cgroup *victim = NULL;
+	int total = 0;
+	int loop = 0;
+	unsigned long excess;
+	unsigned long nr_scanned;
+	struct mem_cgroup_reclaim_cookie reclaim = {
+		.pgdat = pgdat,
+	};
+
+	excess = soft_limit_excess(root_memcg);
+
+	while (1) {
+		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
+		if (!victim) {
+			loop++;
+			if (loop >= 2) {
+				/*
+				 * If we have not been able to reclaim
+				 * anything, it might because there are
+				 * no reclaimable pages under this hierarchy
+				 */
+				if (!total)
+					break;
+				/*
+				 * We want to do more targeted reclaim.
+				 * excess >> 2 is not to excessive so as to
+				 * reclaim too much, nor too less that we keep
+				 * coming back to reclaim from this cgroup
+				 */
+				if (total >= (excess >> 2) ||
+					(loop > MEM_CGROUP_MAX_RECLAIM_LOOPS))
+					break;
+			}
+			continue;
+		}
+		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
+					pgdat, &nr_scanned);
+		*total_scanned += nr_scanned;
+		if (!soft_limit_excess(root_memcg))
+			break;
+	}
+	mem_cgroup_iter_break(root_memcg, victim);
+	return total;
+}
+
+unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					    gfp_t gfp_mask,
+					    unsigned long *total_scanned)
+{
+	unsigned long nr_reclaimed = 0;
+	struct mem_cgroup_per_node *mz, *next_mz = NULL;
+	unsigned long reclaimed;
+	int loop = 0;
+	struct mem_cgroup_tree_per_node *mctz;
+	unsigned long excess;
+
+	if (lru_gen_enabled())
+		return 0;
+
+	if (order > 0)
+		return 0;
+
+	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
+
+	/*
+	 * Do not even bother to check the largest node if the root
+	 * is empty. Do it lockless to prevent lock bouncing. Races
+	 * are acceptable as soft limit is best effort anyway.
+	 */
+	if (!mctz || RB_EMPTY_ROOT(&mctz->rb_root))
+		return 0;
+
+	/*
+	 * This loop can run a while, specially if mem_cgroup's continuously
+	 * keep exceeding their soft limit and putting the system under
+	 * pressure
+	 */
+	do {
+		if (next_mz)
+			mz = next_mz;
+		else
+			mz = mem_cgroup_largest_soft_limit_node(mctz);
+		if (!mz)
+			break;
+
+		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
+						    gfp_mask, total_scanned);
+		nr_reclaimed += reclaimed;
+		spin_lock_irq(&mctz->lock);
+
+		/*
+		 * If we failed to reclaim anything from this memory cgroup
+		 * it is time to move on to the next cgroup
+		 */
+		next_mz = NULL;
+		if (!reclaimed)
+			next_mz = __mem_cgroup_largest_soft_limit_node(mctz);
+
+		excess = soft_limit_excess(mz->memcg);
+		/*
+		 * One school of thought says that we should not add
+		 * back the node to the tree if reclaim returns 0.
+		 * But our reclaim could return 0, simply because due
+		 * to priority we are exposing a smaller subset of
+		 * memory to reclaim from. Consider this as a longer
+		 * term TODO.
+		 */
+		/* If excess == 0, no tree ops */
+		__mem_cgroup_insert_exceeded(mz, mctz, excess);
+		spin_unlock_irq(&mctz->lock);
+		css_put(&mz->memcg->css);
+		loop++;
+		/*
+		 * Could not reclaim anything and there are no more
+		 * mem cgroups to try or we seem to be looping without
+		 * reclaiming anything.
+		 */
+		if (!nr_reclaimed &&
+			(next_mz == NULL ||
+			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
+			break;
+	} while (!nr_reclaimed);
+	if (next_mz)
+		css_put(&next_mz->memcg->css);
+	return nr_reclaimed;
+}
+
+static int __init memcg1_init(void)
+{
+	int node;
+
+	for_each_node(node) {
+		struct mem_cgroup_tree_per_node *rtpn;
+
+		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
+
+		rtpn->rb_root = RB_ROOT;
+		rtpn->rb_rightmost = NULL;
+		spin_lock_init(&rtpn->lock);
+		soft_limit_tree.rb_tree_per_node[node] = rtpn;
+	}
+
+	return 0;
+}
+subsys_initcall(memcg1_init);
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 7c5f094755ff..4da6fa561c6d 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -3,5 +3,12 @@
 #ifndef __MM_MEMCONTROL_V1_H
 #define __MM_MEMCONTROL_V1_H
 
+void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid);
+void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg);
+
+static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
+{
+	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+}
 
 #endif	/* __MM_MEMCONTROL_V1_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 974bd160838c..003e944f34ea 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -72,6 +72,7 @@
 #include <net/ip.h>
 #include "slab.h"
 #include "swap.h"
+#include "memcontrol-v1.h"
 
 #include <linux/uaccess.h>
 
@@ -108,23 +109,6 @@ static bool do_memsw_account(void)
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 
-/*
- * Cgroups above their limits are maintained in a RB-Tree, independent of
- * their hierarchy representation
- */
-
-struct mem_cgroup_tree_per_node {
-	struct rb_root rb_root;
-	struct rb_node *rb_rightmost;
-	spinlock_t lock;
-};
-
-struct mem_cgroup_tree {
-	struct mem_cgroup_tree_per_node *rb_tree_per_node[MAX_NUMNODES];
-};
-
-static struct mem_cgroup_tree soft_limit_tree __read_mostly;
-
 /* for OOM */
 struct mem_cgroup_eventfd_list {
 	struct list_head list;
@@ -199,13 +183,6 @@ static struct move_charge_struct {
 	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(mc.waitq),
 };
 
-/*
- * Maximum loops in mem_cgroup_soft_reclaim(), used for soft
- * limit reclaim to prevent infinite loops, if they ever occur.
- */
-#define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
-#define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
-
 /* for encoding cft->private value on file */
 enum res_type {
 	_MEM,
@@ -413,169 +390,6 @@ ino_t page_cgroup_ino(struct page *page)
 	return ino;
 }
 
-static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
-					 struct mem_cgroup_tree_per_node *mctz,
-					 unsigned long new_usage_in_excess)
-{
-	struct rb_node **p = &mctz->rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct mem_cgroup_per_node *mz_node;
-	bool rightmost = true;
-
-	if (mz->on_tree)
-		return;
-
-	mz->usage_in_excess = new_usage_in_excess;
-	if (!mz->usage_in_excess)
-		return;
-	while (*p) {
-		parent = *p;
-		mz_node = rb_entry(parent, struct mem_cgroup_per_node,
-					tree_node);
-		if (mz->usage_in_excess < mz_node->usage_in_excess) {
-			p = &(*p)->rb_left;
-			rightmost = false;
-		} else {
-			p = &(*p)->rb_right;
-		}
-	}
-
-	if (rightmost)
-		mctz->rb_rightmost = &mz->tree_node;
-
-	rb_link_node(&mz->tree_node, parent, p);
-	rb_insert_color(&mz->tree_node, &mctz->rb_root);
-	mz->on_tree = true;
-}
-
-static void __mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
-					 struct mem_cgroup_tree_per_node *mctz)
-{
-	if (!mz->on_tree)
-		return;
-
-	if (&mz->tree_node == mctz->rb_rightmost)
-		mctz->rb_rightmost = rb_prev(&mz->tree_node);
-
-	rb_erase(&mz->tree_node, &mctz->rb_root);
-	mz->on_tree = false;
-}
-
-static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
-				       struct mem_cgroup_tree_per_node *mctz)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mctz->lock, flags);
-	__mem_cgroup_remove_exceeded(mz, mctz);
-	spin_unlock_irqrestore(&mctz->lock, flags);
-}
-
-static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
-{
-	unsigned long nr_pages = page_counter_read(&memcg->memory);
-	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
-	unsigned long excess = 0;
-
-	if (nr_pages > soft_limit)
-		excess = nr_pages - soft_limit;
-
-	return excess;
-}
-
-static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
-{
-	unsigned long excess;
-	struct mem_cgroup_per_node *mz;
-	struct mem_cgroup_tree_per_node *mctz;
-
-	if (lru_gen_enabled()) {
-		if (soft_limit_excess(memcg))
-			lru_gen_soft_reclaim(memcg, nid);
-		return;
-	}
-
-	mctz = soft_limit_tree.rb_tree_per_node[nid];
-	if (!mctz)
-		return;
-	/*
-	 * Necessary to update all ancestors when hierarchy is used.
-	 * because their event counter is not touched.
-	 */
-	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		mz = memcg->nodeinfo[nid];
-		excess = soft_limit_excess(memcg);
-		/*
-		 * We have to update the tree if mz is on RB-tree or
-		 * mem is over its softlimit.
-		 */
-		if (excess || mz->on_tree) {
-			unsigned long flags;
-
-			spin_lock_irqsave(&mctz->lock, flags);
-			/* if on-tree, remove it */
-			if (mz->on_tree)
-				__mem_cgroup_remove_exceeded(mz, mctz);
-			/*
-			 * Insert again. mz->usage_in_excess will be updated.
-			 * If excess is 0, no tree ops.
-			 */
-			__mem_cgroup_insert_exceeded(mz, mctz, excess);
-			spin_unlock_irqrestore(&mctz->lock, flags);
-		}
-	}
-}
-
-static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
-{
-	struct mem_cgroup_tree_per_node *mctz;
-	struct mem_cgroup_per_node *mz;
-	int nid;
-
-	for_each_node(nid) {
-		mz = memcg->nodeinfo[nid];
-		mctz = soft_limit_tree.rb_tree_per_node[nid];
-		if (mctz)
-			mem_cgroup_remove_exceeded(mz, mctz);
-	}
-}
-
-static struct mem_cgroup_per_node *
-__mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
-{
-	struct mem_cgroup_per_node *mz;
-
-retry:
-	mz = NULL;
-	if (!mctz->rb_rightmost)
-		goto done;		/* Nothing to reclaim from */
-
-	mz = rb_entry(mctz->rb_rightmost,
-		      struct mem_cgroup_per_node, tree_node);
-	/*
-	 * Remove the node now but someone else can add it back,
-	 * we will to add it back at the end of reclaim to its correct
-	 * position in the tree.
-	 */
-	__mem_cgroup_remove_exceeded(mz, mctz);
-	if (!soft_limit_excess(mz->memcg) ||
-	    !css_tryget(&mz->memcg->css))
-		goto retry;
-done:
-	return mz;
-}
-
-static struct mem_cgroup_per_node *
-mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
-{
-	struct mem_cgroup_per_node *mz;
-
-	spin_lock_irq(&mctz->lock);
-	mz = __mem_cgroup_largest_soft_limit_node(mctz);
-	spin_unlock_irq(&mctz->lock);
-	return mz;
-}
-
 /* Subset of node_stat_item for memcg stats */
 static const unsigned int memcg_node_stat_items[] = {
 	NR_INACTIVE_ANON,
@@ -1980,56 +1794,6 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return ret;
 }
 
-static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
-				   pg_data_t *pgdat,
-				   gfp_t gfp_mask,
-				   unsigned long *total_scanned)
-{
-	struct mem_cgroup *victim = NULL;
-	int total = 0;
-	int loop = 0;
-	unsigned long excess;
-	unsigned long nr_scanned;
-	struct mem_cgroup_reclaim_cookie reclaim = {
-		.pgdat = pgdat,
-	};
-
-	excess = soft_limit_excess(root_memcg);
-
-	while (1) {
-		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
-		if (!victim) {
-			loop++;
-			if (loop >= 2) {
-				/*
-				 * If we have not been able to reclaim
-				 * anything, it might because there are
-				 * no reclaimable pages under this hierarchy
-				 */
-				if (!total)
-					break;
-				/*
-				 * We want to do more targeted reclaim.
-				 * excess >> 2 is not to excessive so as to
-				 * reclaim too much, nor too less that we keep
-				 * coming back to reclaim from this cgroup
-				 */
-				if (total >= (excess >> 2) ||
-					(loop > MEM_CGROUP_MAX_RECLAIM_LOOPS))
-					break;
-			}
-			continue;
-		}
-		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
-					pgdat, &nr_scanned);
-		*total_scanned += nr_scanned;
-		if (!soft_limit_excess(root_memcg))
-			break;
-	}
-	mem_cgroup_iter_break(root_memcg, victim);
-	return total;
-}
-
 #ifdef CONFIG_LOCKDEP
 static struct lockdep_map memcg_oom_lock_dep_map = {
 	.name = "memcg_oom_lock",
@@ -3925,88 +3689,6 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
 	return ret;
 }
 
-unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					    gfp_t gfp_mask,
-					    unsigned long *total_scanned)
-{
-	unsigned long nr_reclaimed = 0;
-	struct mem_cgroup_per_node *mz, *next_mz = NULL;
-	unsigned long reclaimed;
-	int loop = 0;
-	struct mem_cgroup_tree_per_node *mctz;
-	unsigned long excess;
-
-	if (lru_gen_enabled())
-		return 0;
-
-	if (order > 0)
-		return 0;
-
-	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
-
-	/*
-	 * Do not even bother to check the largest node if the root
-	 * is empty. Do it lockless to prevent lock bouncing. Races
-	 * are acceptable as soft limit is best effort anyway.
-	 */
-	if (!mctz || RB_EMPTY_ROOT(&mctz->rb_root))
-		return 0;
-
-	/*
-	 * This loop can run a while, specially if mem_cgroup's continuously
-	 * keep exceeding their soft limit and putting the system under
-	 * pressure
-	 */
-	do {
-		if (next_mz)
-			mz = next_mz;
-		else
-			mz = mem_cgroup_largest_soft_limit_node(mctz);
-		if (!mz)
-			break;
-
-		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
-						    gfp_mask, total_scanned);
-		nr_reclaimed += reclaimed;
-		spin_lock_irq(&mctz->lock);
-
-		/*
-		 * If we failed to reclaim anything from this memory cgroup
-		 * it is time to move on to the next cgroup
-		 */
-		next_mz = NULL;
-		if (!reclaimed)
-			next_mz = __mem_cgroup_largest_soft_limit_node(mctz);
-
-		excess = soft_limit_excess(mz->memcg);
-		/*
-		 * One school of thought says that we should not add
-		 * back the node to the tree if reclaim returns 0.
-		 * But our reclaim could return 0, simply because due
-		 * to priority we are exposing a smaller subset of
-		 * memory to reclaim from. Consider this as a longer
-		 * term TODO.
-		 */
-		/* If excess == 0, no tree ops */
-		__mem_cgroup_insert_exceeded(mz, mctz, excess);
-		spin_unlock_irq(&mctz->lock);
-		css_put(&mz->memcg->css);
-		loop++;
-		/*
-		 * Could not reclaim anything and there are no more
-		 * mem cgroups to try or we seem to be looping without
-		 * reclaiming anything.
-		 */
-		if (!nr_reclaimed &&
-			(next_mz == NULL ||
-			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
-			break;
-	} while (!nr_reclaimed);
-	if (next_mz)
-		css_put(&next_mz->memcg->css);
-	return nr_reclaimed;
-}
-
 /*
  * Reclaims as many pages from the given memcg as possible.
  *
@@ -5784,7 +5466,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		return ERR_CAST(memcg);
 
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
-	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+	memcg1_soft_limit_reset(memcg);
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	memcg->zswap_max = PAGE_COUNTER_MAX;
 	WRITE_ONCE(memcg->zswap_writeback,
@@ -5957,7 +5639,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	page_counter_set_min(&memcg->memory, 0);
 	page_counter_set_low(&memcg->memory, 0);
 	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
-	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+	memcg1_soft_limit_reset(memcg);
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	memcg_wb_domain_size_changed(memcg);
 }
@@ -7984,7 +7666,7 @@ __setup("cgroup.memory=", cgroup_memory);
  */
 static int __init mem_cgroup_init(void)
 {
-	int cpu, node;
+	int cpu;
 
 	/*
 	 * Currently s32 type (can refer to struct batched_lruvec_stat) is
@@ -8001,17 +7683,6 @@ static int __init mem_cgroup_init(void)
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_stock);
 
-	for_each_node(node) {
-		struct mem_cgroup_tree_per_node *rtpn;
-
-		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
-
-		rtpn->rb_root = RB_ROOT;
-		rtpn->rb_rightmost = NULL;
-		spin_lock_init(&rtpn->lock);
-		soft_limit_tree.rb_tree_per_node[node] = rtpn;
-	}
-
 	return 0;
 }
 subsys_initcall(mem_cgroup_init);
-- 
2.45.2


