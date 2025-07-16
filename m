Return-Path: <cgroups+bounces-8743-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CACF0B07EC7
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 22:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFC71C26918
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 20:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A82C3259;
	Wed, 16 Jul 2025 20:21:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A2A2C08A8
	for <cgroups@vger.kernel.org>; Wed, 16 Jul 2025 20:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697289; cv=none; b=piu9kU1TIthXZZWqsBgMCoQmwA+tws1a6NAEfIA/5pNICkTMEEERz8Q1JlHMvkOKp6Ns2EGww6im93gH2lUy3F9IZb1hKvTXuLEe3zwcHslfYAU0SE2S3RzqJn2pG1sWBKihNBBZjcmHsXZNvq4xqTTBZCLr7WOZcoFUZIA54g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697289; c=relaxed/simple;
	bh=R49JyfSFG/TbXcGcMdXj10k1XNRDNfs6c0SGbi4hsDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YF6q6Y9VGSgdca3NXsOi7aTNAS04E9Rtmiy+uMLGOfPUaaEzpfvtjS4vIvZp+H2YA2IB1NSjbb9CCCm+OuFss744oJ2mOreYBape1PXUZdg4AMg0LzHX7O1scBIKs2QqEcNbth39BnOoUwwQgFw8/ZGXEGG8wx5kpMxFmv0IrCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 17 Jul 2025 05:21:19 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org,
	hannes@cmpxchg.org
Cc: mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	iamjoonsoo.kim@lge.com,
	taejoon.song@lge.com,
	Youngjun Park <youngjun.park@lge.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH 3/4] mm: memcg: Add swap cgroup priority inheritance mechanism
Date: Thu, 17 Jul 2025 05:20:05 +0900
Message-Id: <20250716202006.3640584-4-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716202006.3640584-1-youngjun.park@lge.com>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch introduces inheritance semantics for swap cgroup priorities.

Each cgroup can configure its own swap priority via the
memory.swap.priority interface. However, the effective priority is
determined by walking up the cgroup hierarchy and applying the highest
ancestor's configured value.

If no ancestor has a configured value, the cgroup's own setting is used.
If neither is present, it falls back to the global swap configuration.

To make inheritance visible to userspace, this patch introduces the
memory.swap.priority.effective interface.

Suggested-by: Michal Koutný <mkoutny@suse.com>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  14 ++
 mm/memcontrol.c                         |  14 ++
 mm/swap_cgroup_priority.c               | 203 ++++++++++++++++++++----
 mm/swap_cgroup_priority.h               |   3 +
 4 files changed, 207 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 35fb9677f0d6..ae6a0c809db4 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1901,6 +1901,20 @@ The following nested keys are defined.
       other negative priorities to restore the same ordering as the global
       swap configuration.
 
+  memory.swap.priority.effective
+        A read-only file showing the effective swap priority ordering
+        actually applied to this cgroup, after resolving inheritance
+        from ancestors. The effective swap priority for a cgroup is
+        also influenced by its position within the cgroup hierarchy. If any
+        ancestor cgroup has set a swap priority configuration, it is
+        propagated and inherited by all descendants. In that case, the
+        child’s own configuration is ignored and the topmost configured
+        ancestor determines the effective priority ordering.
+
+        If there is no configuration in the current cgroup and its
+        ancestors, this file shows the global swap device priority from
+        `swapon`, in the form of id and priority pairs.
+
   memory.zswap.current
 	A read-only single value file which exists on non-root
 	cgroups.
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ea207d498ad6..4a0762060f99 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3806,6 +3806,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
 	if (parent) {
 		WRITE_ONCE(memcg->swappiness, mem_cgroup_swappiness(parent));
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+		memcg->swap_priority = inherit_swap_cgroup_priority(parent);
+#endif
 		page_counter_init(&memcg->memory, &parent->memory, memcg_on_dfl);
 		page_counter_init(&memcg->swap, &parent->swap, false);
 #ifdef CONFIG_MEMCG_V1
@@ -5480,6 +5483,12 @@ static int swap_cgroup_priority_show(struct seq_file *m, void *v)
 	show_swap_cgroup_priority(m);
 	return 0;
 }
+
+static int swap_cgroup_priority_effective_show(struct seq_file *m, void *v)
+{
+	show_swap_cgroup_priority_effective(m);
+	return 0;
+}
 #endif
 
 static struct cftype swap_files[] = {
@@ -5521,6 +5530,11 @@ static struct cftype swap_files[] = {
 		.seq_show = swap_cgroup_priority_show,
 		.write = swap_cgroup_priority_write,
 	},
+	{
+		.name = "swap.priority.effective",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = swap_cgroup_priority_effective_show,
+	},
 #endif
 	{ }	/* terminate */
 };
diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
index 979bc18d2eed..84e876b77f01 100644
--- a/mm/swap_cgroup_priority.c
+++ b/mm/swap_cgroup_priority.c
@@ -21,6 +21,7 @@
 #include "swap_cgroup_priority.h"
 #include "memcontrol-v1.h"
 
+static DEFINE_MUTEX(swap_cgroup_priority_inherit_lck);
 static LIST_HEAD(swap_cgroup_priority_list);
 
 /*
@@ -31,6 +32,16 @@ static LIST_HEAD(swap_cgroup_priority_list);
  * tracks priority differences from global swap. If zero, and its default_prio
  * follows global swap priority(SWAP_PRIORITY_GLOBAL), the object is destroyed.
  *
+ * Child cgroups hold direct pointers to this object for fast access.
+ * No reference counting is needed, as the owner's teardown or zero
+ * distance directly implies this object's destruction.
+ *
+ * A child cgroup that has its own effective swap_cgroup_priority uses
+ * the 'effective' field to point to the top-most cgroup's relevant
+ * swap_cgroup_priority object that it should inherit. Changes in the
+ * parent cgroup's swap priority are appropriately propagated downwards.
+ *
+ * effective - Actual effective swap cgroup priority.
  * pnode - Array of pointers to swap device priority nodes.
  * owner - The owning memory cgroup.
  * rcu - RCU free callback.
@@ -41,6 +52,7 @@ static LIST_HEAD(swap_cgroup_priority_list);
  * plist - Priority list head.
  */
 struct swap_cgroup_priority {
+	struct swap_cgroup_priority *effective;
 	struct swap_cgroup_priority_pnode *pnode[MAX_SWAPFILES];
 	struct mem_cgroup *owner;
 
@@ -106,13 +118,38 @@ void get_swapdev_id(struct swap_info_struct *si)
 	si->id = atomic64_inc_return(&swapdev_id_counter);
 }
 
-static struct swap_cgroup_priority *get_swap_cgroup_priority(
+static struct swap_cgroup_priority *get_effective_swap_cgroup_priority(
 	struct mem_cgroup *memcg)
 {
+	struct swap_cgroup_priority *swap_priority;
 	if (!memcg)
 		return NULL;
 
-	return rcu_dereference(memcg->swap_priority);
+	swap_priority = memcg->swap_priority;
+	if (!swap_priority)
+		return NULL;
+
+	return swap_priority->effective;
+}
+
+static bool validate_effective_swap_cgroup_priority(
+	struct mem_cgroup *memcg,
+	struct swap_cgroup_priority **swap_priority)
+{
+	struct swap_cgroup_priority *target = memcg->swap_priority;
+
+	if (!target) {
+		*swap_priority = NULL;
+		return false;
+	}
+
+	target = target->effective;
+	if (target != *swap_priority) {
+		*swap_priority = target;
+		return false;
+	}
+
+	return true;
 }
 
 static struct swap_cgroup_priority_pnode *alloc_swap_cgroup_priority_pnode(
@@ -182,10 +219,13 @@ void show_swap_cgroup_priority(struct seq_file *m)
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 	struct swap_cgroup_priority *swap_priority;
 
+	mutex_lock(&swap_cgroup_priority_inherit_lck);
 	spin_lock(&swap_lock);
+
 	swap_priority = memcg->swap_priority;
 	if (!swap_priority || swap_priority->owner != memcg) {
 		spin_unlock(&swap_lock);
+		mutex_unlock(&swap_cgroup_priority_inherit_lck);
 		return;
 	}
 
@@ -217,6 +257,47 @@ void show_swap_cgroup_priority(struct seq_file *m)
 	}
 
 	spin_unlock(&swap_lock);
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
+}
+
+void show_swap_cgroup_priority_effective(struct seq_file *m)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
+	struct swap_cgroup_priority *swap_priority;
+
+	mutex_lock(&swap_cgroup_priority_inherit_lck);
+	spin_lock(&swap_lock);
+
+	swap_priority = get_effective_swap_cgroup_priority(memcg);
+	if (swap_priority && swap_priority->default_prio != SWAP_PRIORITY_GLOBAL)
+		seq_printf(m,  "default disabled\n");
+
+	for (int i = 0; i < nr_swapfiles; i++) {
+		struct swap_info_struct *si = swap_info[i];
+		struct swap_cgroup_priority_pnode *pnode;
+		signed short prio;
+
+		if (!(si->flags & SWP_USED) || !(si->flags & SWP_WRITEOK))
+			continue;
+
+		seq_printf(m,  "%lld", si->id);
+		if (!swap_priority) {
+			seq_printf(m, " %d\n", si->prio);
+			continue;
+		}
+
+		pnode = swap_priority->pnode[i];
+		if (WARN_ON(!pnode))
+			continue;
+
+		prio = pnode->prio;
+		if (prio != SWAP_PRIORITY_DISABLE)
+			seq_printf(m,  " %d\n", prio);
+		else
+			seq_printf(m,  " disabled\n");
+	}
+	spin_unlock(&swap_lock);
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 }
 
 static void __delete_swap_cgroup_priority(struct mem_cgroup *memcg);
@@ -224,6 +305,7 @@ void purge_swap_cgroup_priority(void)
 {
 	struct swap_cgroup_priority *swap_priority, *tmp;
 
+	mutex_lock(&swap_cgroup_priority_inherit_lck);
 	spin_lock(&swap_avail_lock);
 	list_for_each_entry_safe(swap_priority, tmp, &swap_cgroup_priority_list,
 				 link) {
@@ -232,6 +314,7 @@ void purge_swap_cgroup_priority(void)
 			__delete_swap_cgroup_priority(swap_priority->owner);
 	}
 	spin_unlock(&swap_avail_lock);
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 }
 
 bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
@@ -250,7 +333,7 @@ bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
 	spin_lock(&swap_avail_lock);
 	node = numa_node_id();
 
-	swap_priority = get_swap_cgroup_priority(memcg);
+	swap_priority = get_effective_swap_cgroup_priority(memcg);
 swap_priority_check:
 	if (!swap_priority) {
 		spin_unlock(&swap_avail_lock);
@@ -282,7 +365,8 @@ bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
 		 * If 'swap_cgroup_priority' changes while we're holding a lock,
 		 * we must verify its state to ensure memory validness.
 		 */
-		if (memcg->swap_priority != swap_priority)
+		if (!validate_effective_swap_cgroup_priority(memcg,
+							     &swap_priority))
 			goto swap_priority_check;
 
 		if (plist_node_empty(&next->avail_lists[node]))
@@ -350,7 +434,7 @@ void deactivate_swap_cgroup_priority(struct swap_info_struct *swp,
 	struct swap_cgroup_priority *swap_priority, *tmp;
 	int nid, i;
 
-	list_for_each_entry_safe(swap_priority, tmp, &swap_cgroup_priority_list,
+	list_for_each_entry_safe(swap_priority, tmp, &swap_cgroup_priority_list, 
 				 link) {
 		struct swap_cgroup_priority_pnode *pnode =
 			swap_priority->pnode[swp->type];
@@ -603,17 +687,57 @@ static int __apply_swap_cgroup_priority(
 	return 0;
 }
 
+/*
+ * If this is the top-level swap_cgroup_priority, propagation is needed.
+ * We traverse the 'mem_cgroup_tree' using 'for_each_mem_cgroup_tree'.
+ * Due to its pre-order traversal, after propagating changes in the parent,
+ * subsequent child nodes can correctly retrieve the parent's effective
+ * swap_cgroup_priority, ensuring proper propagation.
+ */
+static void propagate_swap_cgroup_priority(
+	struct mem_cgroup *memcg,
+	struct swap_cgroup_priority *swap_priority)
+{
+	struct mem_cgroup *iter;
+
+	iter = parent_mem_cgroup(memcg);
+	while (iter) {
+		if (iter->swap_priority)
+			return;
+		iter = parent_mem_cgroup(iter);
+	}
+
+	for_each_mem_cgroup_tree(iter, memcg) {
+		if (iter == memcg)
+			continue;
+
+		if (iter->swap_priority &&
+			iter->swap_priority->owner == iter) {
+			rcu_assign_pointer(iter->swap_priority->effective,
+					   swap_priority ?
+					   swap_priority : iter->swap_priority);
+		} else {
+			struct swap_cgroup_priority *effective =
+				get_effective_swap_cgroup_priority(
+					parent_mem_cgroup(iter));
+			iter->swap_priority = effective;
+		}
+	}
+
+	return;
+}
+
 int prepare_swap_cgroup_priority(int type)
 {
 	struct swap_cgroup_priority *swap_priority;
 	int err = 0;
 
-	spin_lock(&swap_avail_lock);
+	mutex_lock(&swap_cgroup_priority_inherit_lck);
 	list_for_each_entry_rcu(swap_priority,
 				&swap_cgroup_priority_list, link) {
 		if (!swap_priority->pnode[type]) {
 			swap_priority->pnode[type] =
-				alloc_swap_cgroup_priority_pnode(GFP_ATOMIC);
+				alloc_swap_cgroup_priority_pnode(GFP_KERNEL);
 
 			if (!swap_priority->pnode[type]) {
 				err = -ENOMEM;
@@ -622,11 +746,23 @@ int prepare_swap_cgroup_priority(int type)
 		}
 
 	}
-	spin_unlock(&swap_avail_lock);
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 
 	return err;
 }
 
+struct swap_cgroup_priority *inherit_swap_cgroup_priority(
+	struct mem_cgroup *parent)
+{
+	struct swap_cgroup_priority *swap_priority;
+
+	mutex_lock(&swap_cgroup_priority_inherit_lck);
+	swap_priority = get_effective_swap_cgroup_priority(parent);
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
+
+	return swap_priority;
+}
+
 int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
 {
 	struct swap_cgroup_priority *swap_priority;
@@ -634,22 +770,24 @@ int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
 	bool new = false;
 	int err = 0;
 
-	rcu_read_lock();
-	swap_priority = rcu_dereference(memcg->swap_priority);
-	if (swap_priority && swap_priority->owner == memcg) {
-		rcu_read_unlock();
+	mutex_lock(&swap_cgroup_priority_inherit_lck);
+	swap_priority = memcg->swap_priority;
+	if (swap_priority && swap_priority->owner == memcg)
 		goto prio_set;
-	}
-	rcu_read_unlock();
+
 	new = true;
 
 	/* No need to define "global swap priority" for a new cgroup. */
-	if (new && prio == SWAP_PRIORITY_GLOBAL)
+	if (new && prio == SWAP_PRIORITY_GLOBAL) {
+		mutex_unlock(&swap_cgroup_priority_inherit_lck);
 		return 0;
+	}
 
 	swap_priority = alloc_swap_cgroup_priority();
-	if (!swap_priority)
+	if (!swap_priority) {
+		mutex_unlock(&swap_cgroup_priority_inherit_lck);
 		return -ENOMEM;
+	}
 
 	/* Just initialize. may changed on __apply_swap_cgroup_priority */
 	swap_priority->default_prio = SWAP_PRIORITY_GLOBAL;
@@ -661,23 +799,17 @@ int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
 	spin_lock(&swap_lock);
 	spin_lock(&swap_avail_lock);
 
-	/* Simultaneous calls to the same interface.*/
-	if (new && memcg->swap_priority &&
-	    memcg->swap_priority->owner == memcg) {
-		new = false;
-		free_swap_cgroup_priority(swap_priority);
-		swap_priority = memcg->swap_priority;
-	}
-
 	err = __apply_swap_cgroup_priority(swap_priority, id, prio, new);
 	if (err) {
 		/*
 		 * The difference with the global swap priority is now zero.
-		 * Remove the swap priority.
+		 * Remove the swap priority, and propagate if needed.
 		 */
 		if (err == 1) {
 			err = 0;
 			__delete_swap_cgroup_priority(memcg);
+			if (swap_priority != swap_priority->effective)
+				memcg->swap_priority = swap_priority->effective;
 		}
 
 		goto error_locked;
@@ -686,7 +818,19 @@ int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
 	if (new) {
 		swap_priority->owner = memcg;
 		list_add_rcu(&swap_priority->link, &swap_cgroup_priority_list);
-		memcg->swap_priority = swap_priority;
+	        /* If there was an inherited swap priority, update effective. */
+		if (memcg->swap_priority) {
+			swap_priority->effective = memcg->swap_priority;
+			memcg->swap_priority = swap_priority;
+		} else {
+			swap_priority->effective = swap_priority;
+			memcg->swap_priority = swap_priority;
+	                /*
+			 * Might be a top-level parent memcg,
+			 * so propagate effective priority.
+			 */
+			propagate_swap_cgroup_priority(memcg, swap_priority);
+		}
 
 		for (int i = 0; i < nr_swapfiles; i++) {
 			if (!swap_priority->pnode[i]->swap) {
@@ -699,12 +843,13 @@ int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
 
 	spin_unlock(&swap_avail_lock);
 	spin_unlock(&swap_lock);
-
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 	return 0;
 
 error_locked:
 	spin_unlock(&swap_avail_lock);
 	spin_unlock(&swap_lock);
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 
 	if (!new)
 		return err;
@@ -717,6 +862,7 @@ static void __delete_swap_cgroup_priority(struct mem_cgroup *memcg)
 {
 	struct swap_cgroup_priority *swap_priority = memcg->swap_priority;
 
+	lockdep_assert_held(&swap_cgroup_priority_inherit_lck);
 	lockdep_assert_held(&swap_avail_lock);
 
 	if (!swap_priority)
@@ -727,13 +873,16 @@ static void __delete_swap_cgroup_priority(struct mem_cgroup *memcg)
 		return;
 
 	rcu_assign_pointer(memcg->swap_priority, NULL);
+	propagate_swap_cgroup_priority(memcg, NULL);
 	list_del_rcu(&swap_priority->link);
 	call_rcu(&swap_priority->rcu, rcu_free_swap_cgroup_priority);
 }
 
 void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
 {
+	mutex_lock(&swap_cgroup_priority_inherit_lck);
 	spin_lock(&swap_avail_lock);
 	__delete_swap_cgroup_priority(memcg);
 	spin_unlock(&swap_avail_lock);
+	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 }
diff --git a/mm/swap_cgroup_priority.h b/mm/swap_cgroup_priority.h
index 253e95623270..5d16b63d12e0 100644
--- a/mm/swap_cgroup_priority.h
+++ b/mm/swap_cgroup_priority.h
@@ -39,8 +39,11 @@ void deactivate_swap_cgroup_priority(struct swap_info_struct *swp,
 				     bool swapoff);
 int prepare_swap_cgroup_priority(int type);
 void show_swap_cgroup_priority(struct seq_file *m);
+void show_swap_cgroup_priority_effective(struct seq_file *m);
 void get_swapdev_id(struct swap_info_struct *si);
 void purge_swap_cgroup_priority(void);
+struct swap_cgroup_priority *inherit_swap_cgroup_priority(
+	struct mem_cgroup *parent);
 bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg, swp_entry_t *entry,
 				int order);
 void delete_swap_cgroup_priority(struct mem_cgroup *memcg);
-- 
2.34.1


