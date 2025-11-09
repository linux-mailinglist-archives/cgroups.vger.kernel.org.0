Return-Path: <cgroups+bounces-11687-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEA7C43E10
	for <lists+cgroups@lfdr.de>; Sun, 09 Nov 2025 13:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74FBD4E5BF4
	for <lists+cgroups@lfdr.de>; Sun,  9 Nov 2025 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58772F0C48;
	Sun,  9 Nov 2025 12:50:03 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC702EC55C
	for <cgroups@vger.kernel.org>; Sun,  9 Nov 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762692603; cv=none; b=SYaOQsupjUX2J/hdrbCgQFF0gffU/VlnDA47tuHSUwIVNNZUqg1Aq4AeVITtkRAgAxmpUn6jqdvtFbciGpo4B72unSNZd7cOwSHDfJLkNm/TnbPvmI0Rc6g0e/BN4vEz1Kj75D8QfK+wCapDKO936X9+AjjM/PAUUv3+Eobkv1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762692603; c=relaxed/simple;
	bh=cdloODG8GvrmGAYlcojvqFBuRUbWyLwtbK9rWdAp4tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sJQUwpz4uyiS/qQTiLz5/XzCmF5KYQoggKEyyJkbd4VhOedA6nBuln2RvU8aane35GJ/Dn2SdcfokCLY+salSTEbaG2NA+MW0d3OaDVWYkt+BqqQZXXN8NC4swYNnDizJXDOm/SwtW4LagseK/UGe7Wh0p7w63d7V8ovLjl46lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 9 Nov 2025 21:49:52 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	gunho.lee@lge.com,
	taejoon.song@lge.com
Subject: [PATCH 1/3] mm, swap: change back to use each swap device's percpu cluster
Date: Sun,  9 Nov 2025 21:49:45 +0900
Message-Id: <20251109124947.1101520-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251109124947.1101520-1-youngjun.park@lge.com>
References: <20251109124947.1101520-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 1b7e90020eb7 ("mm, swap: use percpu cluster as
allocation fast path").

Because in the newly introduced swap tiers, the global percpu cluster
will cause two issues:
1) it will cause caching oscillation in the same order of different si
   if two different memcg can only be allowed to access different si and
   both of them are swapping out.
2) It can cause priority inversion on swap devices. Imagine a case where
   there are two memcg, say memcg1 and memcg2. Memcg1 can access si A, B
   and A is higher priority device. While memcg2 can only access si B.
   Then memcg 2 could write the global percpu cluster with si B, then
   memcg1 take si B in fast path even though si A is not exhausted.

Hence in order to support swap tier, revert commit 1b7e90020eb7 to use
each swap device's percpu cluster.

Co-developed-by: Baoquan He <bhe@redhat.com>
Suggested-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/swap.h |  13 +++-
 mm/swapfile.c        | 151 +++++++++++++------------------------------
 2 files changed, 56 insertions(+), 108 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 38ca3df68716..90fa27bb7796 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -250,10 +250,17 @@ enum {
 #endif
 
 /*
- * We keep using same cluster for rotational device so IO will be sequential.
- * The purpose is to optimize SWAP throughput on these device.
+ * We assign a cluster to each CPU, so each CPU can allocate swap entry from
+ * its own cluster and swapout sequentially. The purpose is to optimize swapout
+ * throughput.
  */
+struct percpu_cluster {
+	local_lock_t lock; /* Protect the percpu_cluster above */
+	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
+};
+
 struct swap_sequential_cluster {
+	spinlock_t lock; /* Serialize usage of global cluster */
 	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
 };
 
@@ -278,8 +285,8 @@ struct swap_info_struct {
 					/* list of cluster that are fragmented or contented */
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
+	struct percpu_cluster __percpu *percpu_cluster; /* per cpu's swap location */
 	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
-	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
 	struct block_device *bdev;	/* swap device or bdev of swap file */
 	struct file *swap_file;		/* seldom referenced */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 44eb6a6e5800..3bb77c9a4879 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -118,18 +118,6 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
 
 atomic_t nr_rotate_swap = ATOMIC_INIT(0);
 
-struct percpu_swap_cluster {
-	struct swap_info_struct *si[SWAP_NR_ORDERS];
-	unsigned long offset[SWAP_NR_ORDERS];
-	local_lock_t lock;
-};
-
-static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
-	.si = { NULL },
-	.offset = { SWAP_ENTRY_INVALID },
-	.lock = INIT_LOCAL_LOCK(),
-};
-
 /* May return NULL on invalid type, caller must check for NULL return */
 static struct swap_info_struct *swap_type_to_info(int type)
 {
@@ -497,7 +485,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	 * Swap allocator uses percpu clusters and holds the local lock.
 	 */
 	lockdep_assert_held(&ci->lock);
-	lockdep_assert_held(&this_cpu_ptr(&percpu_swap_cluster)->lock);
+	lockdep_assert_held(&this_cpu_ptr(si->percpu_cluster)->lock);
 
 	/* The cluster must be free and was just isolated from the free list. */
 	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
@@ -515,8 +503,8 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	 */
 	spin_unlock(&ci->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
-		spin_unlock(&si->global_cluster_lock);
-	local_unlock(&percpu_swap_cluster.lock);
+		spin_unlock(&si->global_cluster->lock);
+	local_unlock(&si->percpu_cluster->lock);
 
 	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | GFP_KERNEL);
 
@@ -528,9 +516,9 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	 * could happen with ignoring the percpu cluster is fragmentation,
 	 * which is acceptable since this fallback and race is rare.
 	 */
-	local_lock(&percpu_swap_cluster.lock);
+	local_lock(&si->percpu_cluster->lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
-		spin_lock(&si->global_cluster_lock);
+		spin_lock(&si->global_cluster->lock);
 	spin_lock(&ci->lock);
 
 	/* Nothing except this helper should touch a dangling empty cluster. */
@@ -642,7 +630,7 @@ static bool swap_do_scheduled_discard(struct swap_info_struct *si)
 		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
 		/*
 		 * Delete the cluster from list to prepare for discard, but keep
-		 * the CLUSTER_FLAG_DISCARD flag, percpu_swap_cluster could be
+		 * the CLUSTER_FLAG_DISCARD flag, there could be percpu_cluster
 		 * pointing to it, or ran into by relocate_cluster.
 		 */
 		list_del(&ci->list);
@@ -939,12 +927,11 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 out:
 	relocate_cluster(si, ci);
 	swap_cluster_unlock(ci);
-	if (si->flags & SWP_SOLIDSTATE) {
-		this_cpu_write(percpu_swap_cluster.offset[order], next);
-		this_cpu_write(percpu_swap_cluster.si[order], si);
-	} else {
+	if (si->flags & SWP_SOLIDSTATE)
+		this_cpu_write(si->percpu_cluster->next[order], next);
+	else
 		si->global_cluster->next[order] = next;
-	}
+
 	return found;
 }
 
@@ -1037,13 +1024,17 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	if (order && !(si->flags & SWP_BLKDEV))
 		return 0;
 
-	if (!(si->flags & SWP_SOLIDSTATE)) {
+	if (si->flags & SWP_SOLIDSTATE) {
+		/* Fast path using per CPU cluster */
+		local_lock(&si->percpu_cluster->lock);
+		offset = __this_cpu_read(si->percpu_cluster->next[order]);
+	} else {
 		/* Serialize HDD SWAP allocation for each device. */
-		spin_lock(&si->global_cluster_lock);
+		spin_lock(&si->global_cluster->lock);
 		offset = si->global_cluster->next[order];
-		if (offset == SWAP_ENTRY_INVALID)
-			goto new_cluster;
+	}
 
+	if (offset != SWAP_ENTRY_INVALID) {
 		ci = swap_cluster_lock(si, offset);
 		/* Cluster could have been used by another order */
 		if (cluster_is_usable(ci, order)) {
@@ -1058,7 +1049,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 			goto done;
 	}
 
-new_cluster:
 	/*
 	 * If the device need discard, prefer new cluster over nonfull
 	 * to spread out the writes.
@@ -1121,8 +1111,10 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 			goto done;
 	}
 done:
-	if (!(si->flags & SWP_SOLIDSTATE))
-		spin_unlock(&si->global_cluster_lock);
+	if (si->flags & SWP_SOLIDSTATE)
+		local_unlock(&si->percpu_cluster->lock);
+	else
+		spin_unlock(&si->global_cluster->lock);
 
 	return found;
 }
@@ -1303,43 +1295,8 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	return true;
 }
 
-/*
- * Fast path try to get swap entries with specified order from current
- * CPU's swap entry pool (a cluster).
- */
-static bool swap_alloc_fast(swp_entry_t *entry,
-			    int order)
-{
-	struct swap_cluster_info *ci;
-	struct swap_info_struct *si;
-	unsigned int offset, found = SWAP_ENTRY_INVALID;
-
-	/*
-	 * Once allocated, swap_info_struct will never be completely freed,
-	 * so checking it's liveness by get_swap_device_info is enough.
-	 */
-	si = this_cpu_read(percpu_swap_cluster.si[order]);
-	offset = this_cpu_read(percpu_swap_cluster.offset[order]);
-	if (!si || !offset || !get_swap_device_info(si))
-		return false;
-
-	ci = swap_cluster_lock(si, offset);
-	if (cluster_is_usable(ci, order)) {
-		if (cluster_is_empty(ci))
-			offset = cluster_offset(si, ci);
-		found = alloc_swap_scan_cluster(si, ci, offset, order, SWAP_HAS_CACHE);
-		if (found)
-			*entry = swp_entry(si->type, found);
-	} else {
-		swap_cluster_unlock(ci);
-	}
-
-	put_swap_device(si);
-	return !!found;
-}
-
 /* Rotate the device and switch to a new cluster */
-static bool swap_alloc_slow(swp_entry_t *entry,
+static void swap_alloc_entry(swp_entry_t *entry,
 			    int order)
 {
 	unsigned long offset;
@@ -1356,10 +1313,10 @@ static bool swap_alloc_slow(swp_entry_t *entry,
 			put_swap_device(si);
 			if (offset) {
 				*entry = swp_entry(si->type, offset);
-				return true;
+				return;
 			}
 			if (order)
-				return false;
+				return;
 		}
 
 		spin_lock(&swap_avail_lock);
@@ -1378,7 +1335,6 @@ static bool swap_alloc_slow(swp_entry_t *entry,
 			goto start_over;
 	}
 	spin_unlock(&swap_avail_lock);
-	return false;
 }
 
 /*
@@ -1445,10 +1401,7 @@ int folio_alloc_swap(struct folio *folio)
 	}
 
 again:
-	local_lock(&percpu_swap_cluster.lock);
-	if (!swap_alloc_fast(&entry, order))
-		swap_alloc_slow(&entry, order);
-	local_unlock(&percpu_swap_cluster.lock);
+	swap_alloc_entry(&entry, order);
 
 	if (unlikely(!order && !entry.val)) {
 		if (swap_sync_discard())
@@ -2016,13 +1969,7 @@ swp_entry_t get_swap_page_of_type(int type)
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
-			/*
-			 * Grab the local lock to be complaint
-			 * with swap table allocation.
-			 */
-			local_lock(&percpu_swap_cluster.lock);
 			offset = cluster_alloc_swap_entry(si, 0, 1);
-			local_unlock(&percpu_swap_cluster.lock);
 			if (offset)
 				entry = swp_entry(si->type, offset);
 		}
@@ -2799,28 +2746,6 @@ static void free_cluster_info(struct swap_cluster_info *cluster_info,
 	kvfree(cluster_info);
 }
 
-/*
- * Called after swap device's reference count is dead, so
- * neither scan nor allocation will use it.
- */
-static void flush_percpu_swap_cluster(struct swap_info_struct *si)
-{
-	int cpu, i;
-	struct swap_info_struct **pcp_si;
-
-	for_each_possible_cpu(cpu) {
-		pcp_si = per_cpu_ptr(percpu_swap_cluster.si, cpu);
-		/*
-		 * Invalidate the percpu swap cluster cache, si->users
-		 * is dead, so no new user will point to it, just flush
-		 * any existing user.
-		 */
-		for (i = 0; i < SWAP_NR_ORDERS; i++)
-			cmpxchg(&pcp_si[i], si, NULL);
-	}
-}
-
-
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -2904,7 +2829,6 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	flush_work(&p->discard_work);
 	flush_work(&p->reclaim_work);
-	flush_percpu_swap_cluster(p);
 
 	destroy_swap_extents(p);
 	if (p->flags & SWP_CONTINUED)
@@ -2933,6 +2857,8 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	arch_swap_invalidate_area(p->type);
 	zswap_swapoff(p->type);
 	mutex_unlock(&swapon_mutex);
+	free_percpu(p->percpu_cluster);
+	p->percpu_cluster = NULL;
 	kfree(p->global_cluster);
 	p->global_cluster = NULL;
 	vfree(swap_map);
@@ -3308,7 +3234,7 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 {
 	unsigned long nr_clusters = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
 	struct swap_cluster_info *cluster_info;
-	int err = -ENOMEM;
+	int cpu, err = -ENOMEM;
 	unsigned long i;
 
 	cluster_info = kvcalloc(nr_clusters, sizeof(*cluster_info), GFP_KERNEL);
@@ -3318,14 +3244,27 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++)
 		spin_lock_init(&cluster_info[i].lock);
 
-	if (!(si->flags & SWP_SOLIDSTATE)) {
+	if (si->flags & SWP_SOLIDSTATE) {
+		si->percpu_cluster = alloc_percpu(struct percpu_cluster);
+		if (!si->percpu_cluster)
+			goto err;
+
+		for_each_possible_cpu(cpu) {
+			struct percpu_cluster *cluster;
+
+			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
+			for (i = 0; i < SWAP_NR_ORDERS; i++)
+				cluster->next[i] = SWAP_ENTRY_INVALID;
+			local_lock_init(&cluster->lock);
+		}
+	} else {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
 				     GFP_KERNEL);
 		if (!si->global_cluster)
 			goto err_free;
 		for (i = 0; i < SWAP_NR_ORDERS; i++)
 			si->global_cluster->next[i] = SWAP_ENTRY_INVALID;
-		spin_lock_init(&si->global_cluster_lock);
+		spin_lock_init(&si->global_cluster->lock);
 	}
 
 	/*
@@ -3607,6 +3546,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 bad_swap_unlock_inode:
 	inode_unlock(inode);
 bad_swap:
+	free_percpu(si->percpu_cluster);
+	si->percpu_cluster = NULL;
 	kfree(si->global_cluster);
 	si->global_cluster = NULL;
 	inode = NULL;
-- 
2.34.1


