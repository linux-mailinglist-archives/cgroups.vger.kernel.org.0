Return-Path: <cgroups+bounces-8744-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9AB07ECB
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 22:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705E41C270DD
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 20:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB3C2D94B9;
	Wed, 16 Jul 2025 20:21:36 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AC2D94A8
	for <cgroups@vger.kernel.org>; Wed, 16 Jul 2025 20:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697296; cv=none; b=qBVah4d9Kc90+fLYam297GbjivI1Aa1hid7kgvnzHEbwFEdibBoK37guYwMwKMbwlalTAhRcEpcbjT7+rUTWTDPFZ8ZT0ncIvOYMbkj16Qxp+Vis5R2KeLe2kBXmF3LoI+oA4tQ74++HIjtnqXjszKX8SA3nbzXNgArg1bUR1Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697296; c=relaxed/simple;
	bh=6k6oMKVv3MY8X4J/+oRu1DGCe8pTbKfA1bjBy+xbDMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGOepKP4eDfEtZMIj75krAciy27TgvInaNk7F8omhK2OVhdAvTLlgtz1yQSsAx+T34WwmLcXjPuwb7OuPv0/NcUc0W1MVVQ8wHSsKe+bOcaSlfsMRwPJUdYxjoW87jwfZtugHvKvvTmUChWBw75UP93dXhxlfJSOJH/IGGj+OSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 17 Jul 2025 05:21:27 +0900
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
	Youngjun Park <youngjun.park@lge.com>
Subject: [PATCH 4/4] mm: swap: Per-cgroup per-CPU swap device cache with shared clusters
Date: Thu, 17 Jul 2025 05:20:06 +0900
Message-Id: <20250716202006.3640584-5-youngjun.park@lge.com>
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

This patch introduces a new swap allocation mechanism that supports
per-cgroup per-CPU swap device caches, combined with per-device per-CPU
cluster management.

The existing global swap allocator uses a per-CPU device cache and
cluster, shared by all cgroups. Under this model, per-cgroup swap
priorities cannot be effectively honored on the fast path, as allocations
do not distinguish between cgroups.

To address this, we introduce per-cgroup per-CPU swap device caches.
This allows fast-path swap allocations to respect each cgroup’s
individual priority settings.

To avoid an explosion of cluster structures proportional to the number
of cgroups, clusters remain per-device and are shared across cgroups.
This strikes a balance between performance and memory overhead.

Suggested-by: Nhat Pham <nphamcs@gmail.com>
Suggested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/swap.h      |   7 ++
 mm/swap_cgroup_priority.c | 156 +++++++++++++++++++++++++++++++++++++-
 mm/swap_cgroup_priority.h |  39 ++++++++++
 mm/swapfile.c             |  47 +++++++-----
 4 files changed, 228 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index bfddbec2ee28..ab15f4c103a1 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -283,6 +283,12 @@ enum swap_cluster_flags {
 #define SWAP_NR_ORDERS		1
 #endif
 
+#ifdef CONFIG_SWAP_CGROUP_PRIORITY
+struct percpu_cluster {
+	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
+};
+#endif
+
 /*
  * We keep using same cluster for rotational device so IO will be sequential.
  * The purpose is to optimize SWAP throughput on these device.
@@ -341,6 +347,7 @@ struct swap_info_struct {
 	struct list_head discard_clusters; /* discard clusters list */
 #ifdef CONFIG_SWAP_CGROUP_PRIORITY
 	u64 id;
+	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 #endif
 	struct plist_node avail_lists[]; /*
 					   * entries in swap_avail_heads, one
diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
index 84e876b77f01..f960c3dcab48 100644
--- a/mm/swap_cgroup_priority.c
+++ b/mm/swap_cgroup_priority.c
@@ -21,6 +21,17 @@
 #include "swap_cgroup_priority.h"
 #include "memcontrol-v1.h"
 
+/*
+ * We do maintain a cache on a per-cgroup-per-swap-device basis.
+ * However, the underlying cluster cache itself is managed
+ * per-swap-device. This design prevents each individual
+ * swap_cgroup_priority entry from caching its own cluster data,
+ * even as the number of such entries increases.
+ */
+struct percpu_swap_device {
+	struct swap_info_struct *si[SWAP_NR_ORDERS];
+};
+
 static DEFINE_MUTEX(swap_cgroup_priority_inherit_lck);
 static LIST_HEAD(swap_cgroup_priority_list);
 
@@ -49,6 +60,7 @@ static LIST_HEAD(swap_cgroup_priority_list);
  * least_priority - Current lowest priority.
  * distance - Priority differences from global swap priority.
  * default_prio - Default priority for this cgroup.
+ * pcpu_swapdev - Per-CPU swap device.
  * plist - Priority list head.
  */
 struct swap_cgroup_priority {
@@ -64,6 +76,7 @@ struct swap_cgroup_priority {
 	int least_priority;
 	s8 distance;
 	int default_prio;
+	struct percpu_swap_device __percpu *pcpu_swapdev;
 	struct plist_head plist[];
 };
 
@@ -132,6 +145,21 @@ static struct swap_cgroup_priority *get_effective_swap_cgroup_priority(
 	return swap_priority->effective;
 }
 
+static struct swap_cgroup_priority *get_effective_swap_cgroup_priority_rcu(
+	struct mem_cgroup *memcg)
+{
+	struct swap_cgroup_priority *swap_priority;
+
+	if (!memcg)
+		return NULL;
+
+	swap_priority = rcu_dereference(memcg->swap_priority);
+	if (!swap_priority)
+		return NULL;
+
+	return rcu_dereference(swap_priority->effective);
+}
+
 static bool validate_effective_swap_cgroup_priority(
 	struct mem_cgroup *memcg,
 	struct swap_cgroup_priority **swap_priority)
@@ -172,6 +200,9 @@ static void free_swap_cgroup_priority_pnode(
 static void free_swap_cgroup_priority(
 	struct swap_cgroup_priority *swap_priority)
 {
+	if (swap_priority->pcpu_swapdev)
+		free_percpu(swap_priority->pcpu_swapdev);
+
 	for (int i = 0; i < MAX_SWAPFILES; i++)
 		free_swap_cgroup_priority_pnode(swap_priority->pnode[i]);
 
@@ -187,6 +218,12 @@ static struct swap_cgroup_priority *alloc_swap_cgroup_priority(void)
 	if (!swap_priority)
 		return NULL;
 
+	swap_priority->pcpu_swapdev = alloc_percpu(struct percpu_swap_device);
+	if (!swap_priority->pcpu_swapdev) {
+		kvfree(swap_priority);
+		return NULL;
+	}
+
 	/*
 	 * Pre-allocates pnode array up to nr_swapfiles at init.
 	 * Individual pnodes are assigned on swapon, but not freed
@@ -326,10 +363,34 @@ bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
 	unsigned long offset;
 	int node;
 
-	/*
-	 * TODO: Per-cpu swap cluster cache can't be used directly
-	 * as cgroup-specific priorities may select different devices.
-	 */
+	rcu_read_lock();
+	if (!(swap_priority = get_effective_swap_cgroup_priority_rcu(memcg))) {
+		rcu_read_unlock();
+		return false;
+	}
+
+	/* Fast path */
+	si = this_cpu_read(swap_priority->pcpu_swapdev->si[order]);
+	if (si && get_swap_device_info(si)) {
+		offset = cluster_alloc_swap_entry(si, order, SWAP_HAS_CACHE);
+		if (offset) {
+			*entry = swp_entry(si->type, offset);
+			/*
+			 * Protected by 'percpu_swap_cluster' local_lock;
+			 * CPU migration is disabled during this operation.
+			 */
+			this_cpu_write(swap_priority->pcpu_swapdev->si[order],
+				       si);
+			put_swap_device(si);
+			rcu_read_unlock();
+
+			return true;
+		}
+		put_swap_device(si);
+	}
+	rcu_read_unlock();
+
+	/* Slow path */
 	spin_lock(&swap_avail_lock);
 	node = numa_node_id();
 
@@ -350,6 +411,14 @@ bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
 		if (get_swap_device_info(si)) {
 			offset = cluster_alloc_swap_entry(si, order,
 							  SWAP_HAS_CACHE);
+			/*
+			 * Protected by 'percpu_swap_cluster' local_lock;
+			 * CPU migration is disabled during this operation.
+			 */
+			if (memcg->swap_priority == swap_priority)
+				this_cpu_write(
+					swap_priority->pcpu_swapdev->si[order],
+					si);
 			put_swap_device(si);
 			if (offset) {
 				*entry = swp_entry(si->type, offset);
@@ -687,6 +756,21 @@ static int __apply_swap_cgroup_priority(
 	return 0;
 }
 
+static int init_swap_cgroup_priority_pcpu_swapdev_cache(
+	struct swap_cgroup_priority *swap_priority)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct percpu_swap_device *pcp_swap_dev =
+			per_cpu_ptr(swap_priority->pcpu_swapdev, cpu);
+		for (int i = 0; i < SWAP_NR_ORDERS; i++)
+			pcp_swap_dev->si[i] = NULL;
+	}
+
+	return 0;
+}
+
 /*
  * If this is the top-level swap_cgroup_priority, propagation is needed.
  * We traverse the 'mem_cgroup_tree' using 'for_each_mem_cgroup_tree'.
@@ -795,6 +879,8 @@ int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
 	for_each_node(nid)
 		plist_head_init(&swap_priority->plist[nid]);
 
+	init_swap_cgroup_priority_pcpu_swapdev_cache(swap_priority);
+
 prio_set:
 	spin_lock(&swap_lock);
 	spin_lock(&swap_avail_lock);
@@ -843,6 +929,23 @@ int apply_swap_cgroup_priority(struct mem_cgroup *memcg, u64 id, int prio)
 
 	spin_unlock(&swap_avail_lock);
 	spin_unlock(&swap_lock);
+	/*
+	 * XXX: We cannot fully synchronize with swap_alloc_cgroup_priority
+	 * when updating the next si.
+	 * Still, we ensure that flush operations inside swap_priority
+	 * are performed as reliably as possible.
+	 */
+	if (id != DEFAULT_ID &&
+	    swap_priority == swap_priority->effective && !new) {
+		int cpu;
+		struct swap_info_struct **pcp_si;
+		for_each_possible_cpu(cpu) {
+			pcp_si = per_cpu_ptr(
+				swap_priority->pcpu_swapdev->si, cpu);
+			for (int i = 0; i < SWAP_NR_ORDERS; i++)
+				pcp_si[i] = NULL;
+		}
+	}
 	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 	return 0;
 
@@ -886,3 +989,48 @@ void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
 	spin_unlock(&swap_avail_lock);
 	mutex_unlock(&swap_cgroup_priority_inherit_lck);
 }
+
+void flush_swap_cgroup_priority_percpu_swapdev(struct swap_info_struct *si)
+{
+	int cpu, i;
+	struct swap_info_struct **pcp_si;
+	struct swap_cgroup_priority *swap_priority;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(swap_priority,
+				&swap_cgroup_priority_list, link) {
+		for_each_possible_cpu(cpu) {
+			pcp_si = per_cpu_ptr(
+					swap_priority->pcpu_swapdev->si, cpu);
+
+			for (i = 0; i < SWAP_NR_ORDERS; i++)
+				cmpxchg(&pcp_si[i], si, NULL);
+		}
+	}
+	rcu_read_unlock();
+}
+
+bool alloc_percpu_swap_cluster(struct swap_info_struct *si)
+{
+	si->percpu_cluster = alloc_percpu(struct percpu_cluster);
+	if (!si->percpu_cluster)
+		return false;
+
+	int cpu;
+	int i;
+	for_each_possible_cpu(cpu) {
+		struct percpu_cluster *cluster;
+
+		cluster = per_cpu_ptr(si->percpu_cluster, cpu);
+		for (i = 0; i < SWAP_NR_ORDERS; i++)
+			cluster->next[i] = SWAP_ENTRY_INVALID;
+	}
+
+	return true;
+}
+
+void free_percpu_swap_cluster(struct swap_info_struct *si)
+{
+	free_percpu(si->percpu_cluster);
+	si->percpu_cluster = NULL;
+}
diff --git a/mm/swap_cgroup_priority.h b/mm/swap_cgroup_priority.h
index 5d16b63d12e0..815822ebd0d1 100644
--- a/mm/swap_cgroup_priority.h
+++ b/mm/swap_cgroup_priority.h
@@ -47,6 +47,22 @@ struct swap_cgroup_priority *inherit_swap_cgroup_priority(
 bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg, swp_entry_t *entry,
 				int order);
 void delete_swap_cgroup_priority(struct mem_cgroup *memcg);
+void flush_swap_cgroup_priority_percpu_swapdev(struct swap_info_struct *si);
+
+bool alloc_percpu_swap_cluster(struct swap_info_struct *si);
+void free_percpu_swap_cluster(struct swap_info_struct *si);
+static inline void write_percpu_swap_cluster_next(struct swap_info_struct *si,
+						  int order,
+						  unsigned int next)
+{
+	this_cpu_write(si->percpu_cluster->next[order], next);
+}
+
+static inline unsigned int read_percpu_swap_cluster_next(
+	struct swap_info_struct *si, int order)
+{
+        return __this_cpu_read(si->percpu_cluster->next[order]);
+}
 #else
 int swap_node(struct swap_info_struct *si);
 unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
@@ -85,5 +101,28 @@ static inline bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
 static inline void delete_swap_cgroup_priority(struct mem_cgroup *memcg)
 {
 }
+static inline void flush_swap_cgroup_priority_percpu_swapdev(
+	struct swap_info_struct *si)
+{
+}
+static inline bool alloc_percpu_swap_cluster(struct swap_info_struct *si)
+{
+	return true;
+}
+static inline void free_percpu_swap_cluster(struct swap_info_struct *si)
+{
+}
+static inline void write_percpu_swap_cluster_next(struct swap_info_struct *si,
+						  int order,
+						  unsigned int next)
+{
+	return;
+}
+
+static inline unsigned int read_percpu_swap_cluster_next(
+	struct swap_info_struct *si, int order)
+{
+	return SWAP_ENTRY_INVALID;
+}
 #endif
 #endif
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bfd0532ad250..6a5ac9962e9f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -817,12 +817,15 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 out:
 	relocate_cluster(si, ci);
 	unlock_cluster(ci);
+
 	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(percpu_swap_cluster.offset[order], next);
 		this_cpu_write(percpu_swap_cluster.si[order], si);
+		write_percpu_swap_cluster_next(si, order, next);
 	} else {
 		si->global_cluster->next[order] = next;
 	}
+
 	return found;
 }
 
@@ -892,26 +895,29 @@ unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
 	if (order && !(si->flags & SWP_BLKDEV))
 		return 0;
 
-	if (!(si->flags & SWP_SOLIDSTATE)) {
+	if (si->flags & SWP_SOLIDSTATE) {
+		offset = read_percpu_swap_cluster_next(si, order);
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
+						order, usage);
+	} else {
+		unlock_cluster(ci);
 	}
+	if (found)
+		goto done;
 
 new_cluster:
 	ci = isolate_lock_cluster(si, &si->free_clusters);
@@ -991,6 +997,7 @@ unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order,
 done:
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster_lock);
+
 	return found;
 }
 
@@ -2674,6 +2681,8 @@ static void flush_percpu_swap_cluster(struct swap_info_struct *si)
 		for (i = 0; i < SWAP_NR_ORDERS; i++)
 			cmpxchg(&pcp_si[i], si, NULL);
 	}
+
+	flush_swap_cgroup_priority_percpu_swapdev(si);
 }
 
 
@@ -2802,6 +2811,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
+	free_percpu_swap_cluster(p);
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
@@ -2900,7 +2910,6 @@ static void swap_stop(struct seq_file *swap, void *v)
 	mutex_unlock(&swapon_mutex);
 }
 
-
 #ifndef CONFIG_SWAP_CGROUP_PRIORITY
 static int swap_show(struct seq_file *swap, void *v)
 {
@@ -3239,7 +3248,10 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);
 
-	if (!(si->flags & SWP_SOLIDSTATE)) {
+	if (si->flags & SWP_SOLIDSTATE) {
+		if (!alloc_percpu_swap_cluster(si))
+			goto err_free;
+	} else {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
 				     GFP_KERNEL);
 		if (!si->global_cluster)
@@ -3532,6 +3544,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
+	free_percpu_swap_cluster(si);
 	kfree(si->global_cluster);
 	si->global_cluster = NULL;
 	inode = NULL;
-- 
2.34.1


