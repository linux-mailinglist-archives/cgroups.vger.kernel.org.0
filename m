Return-Path: <cgroups+bounces-8502-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F02AD6E61
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 12:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7242E3A1854
	for <lists+cgroups@lfdr.de>; Thu, 12 Jun 2025 10:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF423C51E;
	Thu, 12 Jun 2025 10:53:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2D23BCF5
	for <cgroups@vger.kernel.org>; Thu, 12 Jun 2025 10:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749725616; cv=none; b=meJ7+KjGijJUPajxyPat7WBMNM3rn7azsMRGIN8TdkFRElw66xtazZtO4ebTpbpmlbLuWuolQyV5jex6pYiycIO+8lmBplACLHs+DfaGibAoD6T5NaEUEA0v/M7ecmZ+NnhYYVJIbK+7skeffR8OsEVhoe3H7rU2tpx6ztBg4f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749725616; c=relaxed/simple;
	bh=ALZMxnbU3t7+QRRD3cqcdF8BHAFeVToWtA6sWETWCXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XNHndkccnTLGglH5x+7ft9BNJzRiV6TCyirmXmUVNDG9a/WZ78u7BTHQjrTJ2BHqX7jL55HYVvI4z3N71wWN1Uuxpid0cDGu2GXPdCX87I3YX+aV+jROAtrbXyJF2MfPgwQfPlISLG7w+bf5VvvQG/dWk+pELReR/rOsc9sTZ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 12 Jun 2025 19:38:32 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: youngjun.park@lge.com
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shikemeng@huaweicloud.com,
	kasong@tencent.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	taejoon.song@lge.com,
	gunho.lee@lge.com,
	"youngjun.park" <youngjun.park@lge.com>
Subject: [RFC PATCH 2/2] mm: swap: apply per cgroup swap priority mechansim on swap layer
Date: Thu, 12 Jun 2025 19:37:44 +0900
Message-Id: <20250612103743.3385842-3-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612103743.3385842-1-youngjun.park@lge.com>
References: <20250612103743.3385842-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "youngjun.park" <youngjun.park@lge.com>

This patch implements swap device selection and swap on/off propagation
when a cgroup-specific swap priority is set.

There is one workaround to this implementation as follows.
Current per-cpu swap cluster enforces swap device selection based solely
on CPU locality, overriding the swap cgroup's configured priorities.
Therefore, when a swap cgroup priority is assigned, we fall back to
using per-CPU clusters per swap device, similar to the previous behavior.

A proper fix for this workaround will be evaluated in the next patch.

Signed-off-by: Youngjun park <youngjun.park@lge.com>
---
 include/linux/swap.h      |   8 +++
 mm/swap.h                 |   8 +++
 mm/swap_cgroup_priority.c | 133 ++++++++++++++++++++++++++++++++++++++
 mm/swapfile.c             | 125 ++++++++++++++++++++++++-----------
 4 files changed, 238 insertions(+), 36 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 49b73911c1bd..d158b0d5c997 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -283,6 +283,13 @@ enum swap_cluster_flags {
 #define SWAP_NR_ORDERS		1
 #endif
 
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+struct percpu_cluster {
+	local_lock_t lock; /* Protect the percpu_cluster above */
+	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
+};
+#endif
+
 /*
  * We keep using same cluster for rotational device so IO will be sequential.
  * The purpose is to optimize SWAP throughput on these device.
@@ -341,6 +348,7 @@ struct swap_info_struct {
 	struct list_head discard_clusters; /* discard clusters list */
 #ifdef CONFIG_SWAP_CGROUP_PRIORITY
 	int unique_id;
+	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 #endif
 	struct plist_node avail_lists[]; /*
 					   * entries in swap_avail_heads, one
diff --git a/mm/swap.h b/mm/swap.h
index cd2649c632ed..cb6d653fe3f1 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -113,7 +113,15 @@ void delete_swap_cgroup_priority(struct mem_cgroup *memcg);
 void show_swap_device_unique_id(struct seq_file *m);
 #else
 static inline void delete_swap_cgroup_priority(struct mem_cgroup *memcg) {}
+static inline void activate_swap_cgroup_priority_pnode(struct swap_info_struct *swp, bool swapon) {}
+static inline void deactivate_swap_cgroup_priority_pnode(struct swap_info_struct *swp, bool swapoff){}
 static inline void get_swap_unique_id(struct swap_info_struct *si) {}
+static inline bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
+				swp_entry_t *entry, int order)
+{
+	return false;
+}
+
 #endif
 
 #else /* CONFIG_SWAP */
diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
index b3e20b676680..bb18cb251f60 100644
--- a/mm/swap_cgroup_priority.c
+++ b/mm/swap_cgroup_priority.c
@@ -54,6 +54,132 @@ static void get_swap_unique_id(struct swap_info_struct *si)
 	si->unique_id = atomic_add_return(1, &swap_unique_id_counter);
 }
 
+static bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
+				swp_entry_t *entry, int order)
+{
+	struct swap_cgroup_priority *swap_priority;
+	struct swap_cgroup_priority_pnode *pnode, *next;
+	unsigned long offset;
+	int node;
+
+	if (!memcg)
+		return false;
+
+	spin_lock(&swap_avail_lock);
+priority_check:
+	swap_priority = memcg->swap_priority;
+	if (!swap_priority) {
+		spin_unlock(&swap_avail_lock);
+		return false;
+	}
+
+	node = numa_node_id();
+start_over:
+	plist_for_each_entry_safe(pnode, next, &swap_priority->plist[node],
+					avail_lists[node]) {
+		struct swap_info_struct *si = pnode->swap;
+		plist_requeue(&pnode->avail_lists[node],
+			&swap_priority->plist[node]);
+		spin_unlock(&swap_avail_lock);
+
+		if (get_swap_device_info(si)) {
+			offset = cluster_alloc_swap_entry(si,
+					order, SWAP_HAS_CACHE, true);
+			put_swap_device(si);
+			if (offset) {
+				*entry = swp_entry(si->type, offset);
+				return true;
+			}
+			if (order)
+				return false;
+		}
+
+		spin_lock(&swap_avail_lock);
+
+		/* swap_priority is remove or changed under us. */
+		if (swap_priority != memcg->swap_priority)
+			goto priority_check;
+
+		if (plist_node_empty(&next->avail_lists[node]))
+			goto start_over;
+	}
+	spin_unlock(&swap_avail_lock);
+
+	return false;
+}
+
+/* add_to_avail_list (swapon / swapusage > 0) */
+static void activate_swap_cgroup_priority_pnode(struct swap_info_struct *swp,
+			bool swapon)
+{
+	struct swap_cgroup_priority *swap_priority;
+	int i;
+
+	list_for_each_entry(swap_priority, &swap_cgroup_priority_list, link) {
+		struct swap_cgroup_priority_pnode *pnode
+			= swap_priority->pnode[swp->type];
+
+		if (swapon) {
+			pnode->swap = swp;
+			pnode->prio = swp->prio;
+		}
+
+		/* NUMA priority handling */
+		for_each_node(i) {
+			if (swapon) {
+				if (swap_node(swp) == i) {
+					plist_node_init(
+						&pnode->avail_lists[i],
+						1);
+				} else {
+					plist_node_init(
+						&pnode->avail_lists[i],
+						-pnode->prio);
+				}
+			}
+
+			plist_add(&pnode->avail_lists[i],
+				&swap_priority->plist[i]);
+		}
+	}
+}
+
+/* del_from_avail_list (swapoff / swap usage <= 0) */
+static void deactivate_swap_cgroup_priority_pnode(struct swap_info_struct *swp,
+		bool swapoff)
+{
+	struct swap_cgroup_priority *swap_priority;
+	int nid, i;
+
+	list_for_each_entry(swap_priority, &swap_cgroup_priority_list, link) {
+		struct swap_cgroup_priority_pnode *pnode;
+
+		if (swapoff && swp->prio < 0) {
+			/*
+			* NUMA priority handling
+			* mimic swapoff prio adjustment without plist
+			*/
+			for (int i = 0; i < MAX_SWAPFILES; i++) {
+				pnode = swap_priority->pnode[i];
+				if (pnode->prio > swp->prio ||
+					pnode->swap == swp)
+					continue;
+
+				pnode->prio++;
+				for_each_node(nid) {
+					if (pnode->avail_lists[nid].prio != 1)
+						pnode->avail_lists[nid].prio--;
+				}
+			}
+		}
+
+		pnode = swap_priority->pnode[swp->type];
+		for_each_node(i)
+			plist_del(&pnode->avail_lists[i],
+				&swap_priority->plist[i]);
+	}
+}
+
 int create_swap_cgroup_priority(struct mem_cgroup *memcg,
 		int unique[], int prio[], int nr)
 {
@@ -183,6 +309,12 @@ void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
 {
 	struct swap_cgroup_priority *swap_priority;
 
+	/*
+	* XXX: Possible RCU wait? No. Cannot protect priority list addition.
+	* swap_avail_lock gives protection.
+	* Think about other object protection mechanism
+	* might be solve it and better. (e.g object reference)
+	*/
 	spin_lock(&swap_avail_lock);
 	swap_priority = memcg->swap_priority;
 	if (!swap_priority) {
@@ -198,5 +330,6 @@ void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
 
 	for (int i = 0; i < MAX_SWAPFILES; i++)
 		kvfree(swap_priority->pnode[i]);
+
 	kvfree(swap_priority);
 }
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f8e48dd2381e..28afe4ec0504 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -126,8 +126,12 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 	.offset = { SWAP_ENTRY_INVALID },
 	.lock = INIT_LOCAL_LOCK(),
 };
-/* TODO: better choice? */
+/* TODO: better arrangement */
 #ifdef CONFIG_SWAP_CGROUP_PRIORITY
+static bool get_swap_device_info(struct swap_info_struct *si);
+static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
+					      unsigned char usage, bool is_cgroup_priority);
+static int swap_node(struct swap_info_struct *si);
 #include "swap_cgroup_priority.c"
 #endif
 
@@ -776,7 +780,8 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 					    struct swap_cluster_info *ci,
 					    unsigned long offset,
 					    unsigned int order,
-					    unsigned char usage)
+					    unsigned char usage,
+					    bool is_cgroup_priority)
 {
 	unsigned int next = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
 	unsigned long start = ALIGN_DOWN(offset, SWAPFILE_CLUSTER);
@@ -820,12 +825,19 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 out:
 	relocate_cluster(si, ci);
 	unlock_cluster(ci);
+
 	if (si->flags & SWP_SOLIDSTATE) {
-		this_cpu_write(percpu_swap_cluster.offset[order], next);
-		this_cpu_write(percpu_swap_cluster.si[order], si);
-	} else {
+		if (!is_cgroup_priority) {
+			this_cpu_write(percpu_swap_cluster.offset[order], next);
+			this_cpu_write(percpu_swap_cluster.si[order], si);
+		} else {
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+			__this_cpu_write(si->percpu_cluster->next[order], next);
+#endif
+		}
+	} else
 		si->global_cluster->next[order] = next;
-	}
+
 	return found;
 }
 
@@ -883,7 +895,7 @@ static void swap_reclaim_work(struct work_struct *work)
  * cluster for current CPU too.
  */
 static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
-					      unsigned char usage)
+					      unsigned char usage, bool is_cgroup_priority)
 {
 	struct swap_cluster_info *ci;
 	unsigned int offset = SWAP_ENTRY_INVALID, found = SWAP_ENTRY_INVALID;
@@ -895,32 +907,38 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	if (order && !(si->flags & SWP_BLKDEV))
 		return 0;
 
-	if (!(si->flags & SWP_SOLIDSTATE)) {
+	if (si->flags & SWP_SOLIDSTATE) {
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+                local_lock(&si->percpu_cluster->lock);
+                offset = __this_cpu_read(si->percpu_cluster->next[order]);
+#endif
+	} else {
 		/* Serialize HDD SWAP allocation for each device. */
 		spin_lock(&si->global_cluster_lock);
 		offset = si->global_cluster->next[order];
-		if (offset == SWAP_ENTRY_INVALID)
-			goto new_cluster;
+	}
 
-		ci = lock_cluster(si, offset);
-		/* Cluster could have been used by another order */
-		if (cluster_is_usable(ci, order)) {
-			if (cluster_is_empty(ci))
-				offset = cluster_offset(si, ci);
-			found = alloc_swap_scan_cluster(si, ci, offset,
-							order, usage);
-		} else {
-			unlock_cluster(ci);
-		}
-		if (found)
-			goto done;
+	if (offset == SWAP_ENTRY_INVALID)
+		goto new_cluster;
+
+	ci = lock_cluster(si, offset);
+	/* Cluster could have been used by another order */
+	if (cluster_is_usable(ci, order)) {
+		if (cluster_is_empty(ci))
+			offset = cluster_offset(si, ci);
+		found = alloc_swap_scan_cluster(si, ci, offset,
+						order, usage, is_cgroup_priority);
+	} else {
+		unlock_cluster(ci);
 	}
+	if (found)
+		goto done;
 
 new_cluster:
 	ci = isolate_lock_cluster(si, &si->free_clusters);
 	if (ci) {
 		found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-						order, usage);
+						order, usage, is_cgroup_priority);
 		if (found)
 			goto done;
 	}
@@ -934,7 +952,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 
 		while ((ci = isolate_lock_cluster(si, &si->nonfull_clusters[order]))) {
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							order, usage);
+							order, usage, is_cgroup_priority);
 			if (found)
 				goto done;
 			/* Clusters failed to allocate are moved to frag_clusters */
@@ -952,7 +970,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 			 * reclaimable (eg. lazy-freed swap cache) slots.
 			 */
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							order, usage);
+							order, usage, is_cgroup_priority);
 			if (found)
 				goto done;
 			frags++;
@@ -979,21 +997,27 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 		while ((ci = isolate_lock_cluster(si, &si->frag_clusters[o]))) {
 			atomic_long_dec(&si->frag_cluster_nr[o]);
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							0, usage);
+							0, usage, is_cgroup_priority);
 			if (found)
 				goto done;
 		}
 
 		while ((ci = isolate_lock_cluster(si, &si->nonfull_clusters[o]))) {
 			found = alloc_swap_scan_cluster(si, ci, cluster_offset(si, ci),
-							0, usage);
+							0, usage, is_cgroup_priority);
 			if (found)
 				goto done;
 		}
 	}
 done:
-	if (!(si->flags & SWP_SOLIDSTATE))
+	if (si->flags & SWP_SOLIDSTATE) {
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+		local_unlock(&si->percpu_cluster->lock);
+#endif
+	} else {
 		spin_unlock(&si->global_cluster_lock);
+	}
+
 	return found;
 }
 
@@ -1032,6 +1056,7 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 	for_each_node(nid)
 		plist_del(&si->avail_lists[nid], &swap_avail_heads[nid]);
 
+	deactivate_swap_cgroup_priority_pnode(si, swapoff);
 skip:
 	spin_unlock(&swap_avail_lock);
 }
@@ -1075,6 +1100,7 @@ static void add_to_avail_list(struct swap_info_struct *si, bool swapon)
 	for_each_node(nid)
 		plist_add(&si->avail_lists[nid], &swap_avail_heads[nid]);
 
+	activate_swap_cgroup_priority_pnode(si, swapon);
 skip:
 	spin_unlock(&swap_avail_lock);
 }
@@ -1200,7 +1226,8 @@ static bool swap_alloc_fast(swp_entry_t *entry,
 	if (cluster_is_usable(ci, order)) {
 		if (cluster_is_empty(ci))
 			offset = cluster_offset(si, ci);
-		found = alloc_swap_scan_cluster(si, ci, offset, order, SWAP_HAS_CACHE);
+		found = alloc_swap_scan_cluster(si, ci, offset, order,
+				SWAP_HAS_CACHE, false);
 		if (found)
 			*entry = swp_entry(si->type, found);
 	} else {
@@ -1227,7 +1254,7 @@ static bool swap_alloc_slow(swp_entry_t *entry,
 		plist_requeue(&si->avail_lists[node], &swap_avail_heads[node]);
 		spin_unlock(&swap_avail_lock);
 		if (get_swap_device_info(si)) {
-			offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE);
+			offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE, false);
 			put_swap_device(si);
 			if (offset) {
 				*entry = swp_entry(si->type, offset);
@@ -1294,10 +1321,12 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp)
 		}
 	}
 
-	local_lock(&percpu_swap_cluster.lock);
-	if (!swap_alloc_fast(&entry, order))
-		swap_alloc_slow(&entry, order);
-	local_unlock(&percpu_swap_cluster.lock);
+	if (!swap_alloc_cgroup_priority(folio_memcg(folio), &entry, order)) {
+		local_lock(&percpu_swap_cluster.lock);
+		if (!swap_alloc_fast(&entry, order))
+			swap_alloc_slow(&entry, order);
+		local_unlock(&percpu_swap_cluster.lock);
+	}
 
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
 	if (mem_cgroup_try_charge_swap(folio, entry))
@@ -1870,7 +1899,7 @@ swp_entry_t get_swap_page_of_type(int type)
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
-			offset = cluster_alloc_swap_entry(si, 0, 1);
+			offset = cluster_alloc_swap_entry(si, 0, 1, false);
 			if (offset) {
 				entry = swp_entry(si->type, offset);
 				atomic_long_dec(&nr_swap_pages);
@@ -2800,6 +2829,10 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	free_percpu(p->percpu_cluster);
+	p->percpu_cluster = NULL;
+#endif
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
@@ -3207,7 +3240,23 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);
 
-	if (!(si->flags & SWP_SOLIDSTATE)) {
+	if (si->flags & SWP_SOLIDSTATE) {
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+		si->percpu_cluster = alloc_percpu(struct percpu_cluster);
+		if (!si->percpu_cluster)
+			goto err_free;
+
+		int cpu;
+		for_each_possible_cpu(cpu) {
+			struct percpu_cluster *cluster;
+
+			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
+			for (i = 0; i < SWAP_NR_ORDERS; i++)
+				cluster->next[i] = SWAP_ENTRY_INVALID;
+			local_lock_init(&cluster->lock);
+		}
+#endif
+	} else {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
 				     GFP_KERNEL);
 		if (!si->global_cluster)
@@ -3495,6 +3544,10 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+	free_percpu(si->percpu_cluster);
+	si->percpu_cluster = NULL;
+#endif
 	kfree(si->global_cluster);
 	si->global_cluster = NULL;
 	inode = NULL;
-- 
2.34.1


