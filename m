Return-Path: <cgroups+bounces-8742-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9BAB07EC6
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15A673A84D5
	for <lists+cgroups@lfdr.de>; Wed, 16 Jul 2025 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20952C0323;
	Wed, 16 Jul 2025 20:21:19 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247C92D77F8
	for <cgroups@vger.kernel.org>; Wed, 16 Jul 2025 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752697279; cv=none; b=ipmsMiWVZlZubDFutuQCsNKCFzgRAZBP8qzjyytlaHevFJ57u5E43sX9OkeT8MRwwlwNvPveVEerXg03YPhnpQNQQWMWkD9Co5LMV6oVXuYdD3oo2ipgo44TOlbf8qUmQ590xkkKKvv+y+KsJAFljd4tryWAG2I9kozApYBtWwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752697279; c=relaxed/simple;
	bh=L+6dhr9Tqz0Aoxu4yvfGFJiKwxKTNoFWGxvhDOthrT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdQfyonXwqXHFMaoEkK94mVPq1MM+Xg4j/mh4rB82r0B0B262JWJU9oyPW+SIxWC6koVqIX3ZxfP/KyJdS9sR+sw5Q9NybTOIoSnesNY8uZ/OKToRB/ZRkVlZhZ5CrEBidpkp46quG2Dd3aobKYloIEIQRTPCw0RPitrPOPCYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 17 Jul 2025 05:21:07 +0900
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
Subject: [PATCH 2/4] mm: swap: Apply per-cgroup swap priority mechanism to swap layer
Date: Thu, 17 Jul 2025 05:20:04 +0900
Message-Id: <20250716202006.3640584-3-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250716202006.3640584-1-youngjun.park@lge.com>
References: <20250716202006.3640584-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch applies the per-cgroup swap priority mechanism to the swap layer.

It implements:
- Swap device ID assignment based on the cgroup's effective priority
- Swap device selection respecting cgroup-specific priorities
- Swap on/off propagation logic that updates per-cgroup settings accordingly

Currently, the per-CPU swap cluster cache is bypassed, since different
cgroups may select different devices based on their configured priorities.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swap_cgroup_priority.c |  6 ++---
 mm/swapfile.c             | 46 +++++++++++++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/mm/swap_cgroup_priority.c b/mm/swap_cgroup_priority.c
index abbefa6de63a..979bc18d2eed 100644
--- a/mm/swap_cgroup_priority.c
+++ b/mm/swap_cgroup_priority.c
@@ -243,9 +243,9 @@ bool swap_alloc_cgroup_priority(struct mem_cgroup *memcg,
 	unsigned long offset;
 	int node;
 
-	/* TODO
-	 * Per-cpu swapdev cache can't be used directly as cgroup-specific
-	 * priorities may select different devices.
+	/*
+	 * TODO: Per-cpu swap cluster cache can't be used directly
+	 * as cgroup-specific priorities may select different devices.
 	 */
 	spin_lock(&swap_avail_lock);
 	node = numa_node_id();
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4b56f117b2b0..bfd0532ad250 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1029,6 +1029,7 @@ static void del_from_avail_list(struct swap_info_struct *si, bool swapoff)
 	for_each_node(nid)
 		plist_del(&si->avail_lists[nid], &swap_avail_heads[nid]);
 
+	deactivate_swap_cgroup_priority(si, swapoff);
 skip:
 	spin_unlock(&swap_avail_lock);
 }
@@ -1072,6 +1073,7 @@ static void add_to_avail_list(struct swap_info_struct *si, bool swapon)
 	for_each_node(nid)
 		plist_add(&si->avail_lists[nid], &swap_avail_heads[nid]);
 
+	activate_swap_cgroup_priority(si, swapon);
 skip:
 	spin_unlock(&swap_avail_lock);
 }
@@ -1292,8 +1294,10 @@ int folio_alloc_swap(struct folio *folio, gfp_t gfp)
 	}
 
 	local_lock(&percpu_swap_cluster.lock);
-	if (!swap_alloc_fast(&entry, order))
-		swap_alloc_slow(&entry, order);
+	if (!swap_alloc_cgroup_priority(folio_memcg(folio), &entry, order)) {
+		if (!swap_alloc_fast(&entry, order))
+			swap_alloc_slow(&entry, order);
+	}
 	local_unlock(&percpu_swap_cluster.lock);
 
 	/* Need to call this even if allocation failed, for MEMCG_SWAP_FAIL. */
@@ -2778,6 +2782,7 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	if (!p->bdev || !bdev_nonrot(p->bdev))
 		atomic_dec(&nr_rotate_swap);
 
+	purge_swap_cgroup_priority();
 	mutex_lock(&swapon_mutex);
 	spin_lock(&swap_lock);
 	spin_lock(&p->lock);
@@ -2895,6 +2900,8 @@ static void swap_stop(struct seq_file *swap, void *v)
 	mutex_unlock(&swapon_mutex);
 }
 
+
+#ifndef CONFIG_SWAP_CGROUP_PRIORITY
 static int swap_show(struct seq_file *swap, void *v)
 {
 	struct swap_info_struct *si = v;
@@ -2921,6 +2928,34 @@ static int swap_show(struct seq_file *swap, void *v)
 			si->prio);
 	return 0;
 }
+#else
+static int swap_show(struct seq_file *swap, void *v)
+{
+	struct swap_info_struct *si = v;
+	struct file *file;
+	int len;
+	unsigned long bytes, inuse;
+
+	if (si == SEQ_START_TOKEN) {
+		seq_puts(swap, "Filename\t\t\t\tType\t\tSize\t\tUsed\t\tPriority\t\tId\n");
+		return 0;
+	}
+
+	bytes = K(si->pages);
+	inuse = K(swap_usage_in_pages(si));
+
+	file = si->swap_file;
+	len = seq_file_path(swap, file, " \t\n\\");
+	seq_printf(swap, "%*s%s\t%lu\t%s%lu\t%s%d\t\t\t%llu\n",
+			len < 40 ? 40 - len : 1, " ",
+			S_ISBLK(file_inode(file)->i_mode) ?
+				"partition" : "file\t",
+			bytes, bytes < 10000000 ? "\t" : "",
+			inuse, inuse < 10000000 ? "\t" : "",
+			si->prio, si->id);
+	return 0;
+}
+#endif
 
 static const struct seq_operations swaps_op = {
 	.start =	swap_start,
@@ -3463,6 +3498,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		goto free_swap_zswap;
 	}
 
+	error = prepare_swap_cgroup_priority(si->type);
+	if (error) {
+		inode->i_flags &= ~S_SWAPFILE;
+		goto free_swap_zswap;
+	}
+	get_swapdev_id(si);
+
 	mutex_lock(&swapon_mutex);
 	prio = -1;
 	if (swap_flags & SWAP_FLAG_PREFER)
-- 
2.34.1


