Return-Path: <cgroups+bounces-13573-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFOiBFf8fWkmUwIAu9opvQ
	(envelope-from <cgroups+bounces-13573-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:57:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B904BC1DC4
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76E1C303323A
	for <lists+cgroups@lfdr.de>; Sat, 31 Jan 2026 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD18272E63;
	Sat, 31 Jan 2026 12:56:31 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B157257448
	for <cgroups@vger.kernel.org>; Sat, 31 Jan 2026 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769864191; cv=none; b=Q/K3/LvmmxBbIQI6kjMEtT6mCWxz3ieFt5CWClSUrwQ5guQWOvnhGgkVTtGqY7EfUkXGqZWdNMa4LCZFBVtsncZ8/S5VFnm8rvE8BaSEwDTD/buRwGMId9qYR+mwd8aQlH8iAWHXepLvGC4KOrr//tF4BQfHd4bNWvVmwvIY1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769864191; c=relaxed/simple;
	bh=4EriPx2e1KD0LB3eU2OevGD+QtdGkBWQCXNzcpUyFac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iO3w478xzLVyC3YP//Cvfd4EuL2I/sVKffD8lm3toFtKpd/DxOJzTXrYnDHrQis7/FKTLMfHYlMw5QznhyJX0p99Pj0dt/NwdITfkNNp0aIOAscmeDsKah7inv1XCkPjb0DeYM9koObSIGbraQOJaftv8UgqSG8SpacQn5vH1OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 31 Jan 2026 21:56:27 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: akpm@linux-foundation.org
Cc: chrisl@kernel.org,
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
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	gunho.lee@lge.com,
	youngjun.park@lge.com,
	taejoon.song@lge.com
Subject: [RFC PATCH v3 5/5] mm, swap: introduce percpu swap device cache to avoid fragmentation
Date: Sat, 31 Jan 2026 21:54:54 +0900
Message-Id: <20260131125454.3187546-6-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260131125454.3187546-1-youngjun.park@lge.com>
References: <20260131125454.3187546-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lge.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13573-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,gmail.com,redhat.com,vger.kernel.org,kvack.org,lge.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[youngjun.park@lge.com,cgroups@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lge.com:mid,lge.com:email]
X-Rspamd-Queue-Id: B904BC1DC4
X-Rspamd-Action: no action

In the previous commit that introduced per-device percpu clusters,
the allocation logic caused swap device rotation on every allocation
when multiple swap devices share the same priority. This led to
cluster fragmentation on every allocation attemp.

To address this issue, this patch introduces a per-cpu swap device
cache, restoring the allocation behavior to closely match the
traditional fastpath and slowpath flow.

With swap tiers, cluster fragmentation can still occur when a CPU's
cached swap device doesn't belong to the required tier for the current
allocation - this is the intended behavior for tier-based allocation.

With swap tiers and same-priority swap devices, the slow path
triggers device rotation and causes initial cluster fragmentation.
However, once a cluster is allocated, subsequent allocations will
continue using that cluster until it's exhausted, preventing repeated
fragmentation. While this may not be severe, there is room for future
optimization.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/swap.h |  1 -
 mm/swapfile.c        | 87 +++++++++++++++++++++++++++++++++++---------
 2 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6921e22b14d3..ac634a21683a 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -253,7 +253,6 @@ enum {
   * throughput.
   */
 struct percpu_cluster {
-	local_lock_t lock; /* Protect the percpu_cluster above */
 	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
 };
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4708014c96c4..fc1f64eaa8fe 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -106,6 +106,16 @@ PLIST_HEAD(swap_active_head);
 static PLIST_HEAD(swap_avail_head);
 static DEFINE_SPINLOCK(swap_avail_lock);
 
+struct percpu_swap_device {
+	struct swap_info_struct *si[SWAP_NR_ORDERS];
+	local_lock_t lock;
+};
+
+static DEFINE_PER_CPU(struct percpu_swap_device, percpu_swap_device) = {
+	.si = { NULL },
+	.lock = INIT_LOCAL_LOCK(),
+};
+
 struct swap_info_struct *swap_info[MAX_SWAPFILES];
 
 static struct kmem_cache *swap_table_cachep;
@@ -465,10 +475,8 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	 * Swap allocator uses percpu clusters and holds the local lock.
 	 */
 	lockdep_assert_held(&ci->lock);
-	if (si->flags & SWP_SOLIDSTATE)
-		lockdep_assert_held(this_cpu_ptr(&si->percpu_cluster->lock));
-	else
-		lockdep_assert_held(&si->global_cluster->lock);
+	lockdep_assert_held(this_cpu_ptr(&percpu_swap_device.lock));
+
 	/* The cluster must be free and was just isolated from the free list. */
 	VM_WARN_ON_ONCE(ci->flags || !cluster_is_empty(ci));
 
@@ -484,10 +492,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	 * the potential recursive allocation is limited.
 	 */
 	spin_unlock(&ci->lock);
-	if (si->flags & SWP_SOLIDSTATE)
-		local_unlock(&si->percpu_cluster->lock);
-	else
-		spin_unlock(&si->global_cluster->lock);
+	local_unlock(&percpu_swap_device.lock);
 
 	table = swap_table_alloc(__GFP_HIGH | __GFP_NOMEMALLOC | GFP_KERNEL);
 
@@ -499,7 +504,7 @@ swap_cluster_alloc_table(struct swap_info_struct *si,
 	 * could happen with ignoring the percpu cluster is fragmentation,
 	 * which is acceptable since this fallback and race is rare.
 	 */
-	local_lock(&si->percpu_cluster->lock);
+	local_lock(&percpu_swap_device.lock);
 	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_lock(&si->global_cluster->lock);
 	spin_lock(&ci->lock);
@@ -944,9 +949,10 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si,
 out:
 	relocate_cluster(si, ci);
 	swap_cluster_unlock(ci);
-	if (si->flags & SWP_SOLIDSTATE)
+	if (si->flags & SWP_SOLIDSTATE) {
 		this_cpu_write(si->percpu_cluster->next[order], next);
-	else
+		this_cpu_write(percpu_swap_device.si[order], si);
+	} else
 		si->global_cluster->next[order] = next;
 
 	return found;
@@ -1044,7 +1050,6 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 
 	if (si->flags & SWP_SOLIDSTATE) {
 		/* Fast path using per CPU cluster */
-		local_lock(&si->percpu_cluster->lock);
 		offset = __this_cpu_read(si->percpu_cluster->next[order]);
 	} else {
 		/* Serialize HDD SWAP allocation for each device. */
@@ -1122,9 +1127,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si,
 			goto done;
 	}
 done:
-	if (si->flags & SWP_SOLIDSTATE)
-		local_unlock(&si->percpu_cluster->lock);
-	else
+	if (!(si->flags & SWP_SOLIDSTATE))
 		spin_unlock(&si->global_cluster->lock);
 
 	return found;
@@ -1306,8 +1309,29 @@ static bool get_swap_device_info(struct swap_info_struct *si)
 	return true;
 }
 
+static bool swap_alloc_fast(struct folio *folio)
+{
+	unsigned int order = folio_order(folio);
+	struct swap_info_struct *si;
+	int mask = folio_tier_effective_mask(folio);
+
+	/*
+	 * Once allocated, swap_info_struct will never be completely freed,
+	 * so checking it's liveness by get_swap_device_info is enough.
+	 */
+	si = this_cpu_read(percpu_swap_device.si[order]);
+	if (!si || !swap_tiers_mask_test(si->tier_mask, mask) ||
+		!get_swap_device_info(si))
+		return false;
+
+	cluster_alloc_swap_entry(si, folio);
+	put_swap_device(si);
+
+	return folio_test_swapcache(folio);
+}
+
 /* Rotate the device and switch to a new cluster */
-static void swap_alloc_entry(struct folio *folio)
+static void swap_alloc_slow(struct folio *folio)
 {
 	struct swap_info_struct *si, *next;
 	int mask = folio_tier_effective_mask(folio);
@@ -1484,7 +1508,11 @@ int folio_alloc_swap(struct folio *folio)
 	}
 
 again:
-	swap_alloc_entry(folio);
+	local_lock(&percpu_swap_device.lock);
+	if (!swap_alloc_fast(folio))
+		swap_alloc_slow(folio);
+	local_unlock(&percpu_swap_device.lock);
+
 	if (!order && unlikely(!folio_test_swapcache(folio))) {
 		if (swap_sync_discard())
 			goto again;
@@ -1903,7 +1931,9 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 			 * Grab the local lock to be compliant
 			 * with swap table allocation.
 			 */
+			local_lock(&percpu_swap_device.lock);
 			offset = cluster_alloc_swap_entry(si, NULL);
+			local_unlock(&percpu_swap_device.lock);
 			if (offset)
 				entry = swp_entry(si->type, offset);
 		}
@@ -2707,6 +2737,27 @@ static void free_cluster_info(struct swap_cluster_info *cluster_info,
 	kvfree(cluster_info);
 }
 
+/*
+ * Called after swap device's reference count is dead, so
+ * neither scan nor allocation will use it.
+ */
+static void flush_percpu_swap_device(struct swap_info_struct *si)
+{
+	int cpu, i;
+	struct swap_info_struct **pcp_si;
+
+	for_each_possible_cpu(cpu) {
+		pcp_si = per_cpu_ptr(percpu_swap_device.si, cpu);
+		/*
+		 * Invalidate the percpu swap device cache, si->users
+		 * is dead, so no new user will point to it, just flush
+		 * any existing user.
+		 */
+		for (i = 0; i < SWAP_NR_ORDERS; i++)
+			cmpxchg(&pcp_si[i], si, NULL);
+	}
+}
+
 SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 {
 	struct swap_info_struct *p = NULL;
@@ -2790,6 +2841,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 
 	flush_work(&p->discard_work);
 	flush_work(&p->reclaim_work);
+	flush_percpu_swap_device(p);
 
 	destroy_swap_extents(p);
 	if (p->flags & SWP_CONTINUED)
@@ -3224,7 +3276,6 @@ static struct swap_cluster_info *setup_clusters(struct swap_info_struct *si,
 			cluster = per_cpu_ptr(si->percpu_cluster, cpu);
 			for (i = 0; i < SWAP_NR_ORDERS; i++)
 				cluster->next[i] = SWAP_ENTRY_INVALID;
-			local_lock_init(&cluster->lock);
 		}
 	} else {
 		si->global_cluster = kmalloc(sizeof(*si->global_cluster),
-- 
2.34.1


