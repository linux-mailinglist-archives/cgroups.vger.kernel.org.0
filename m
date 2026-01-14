Return-Path: <cgroups+bounces-13201-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E62E6D1E7A8
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7BA531318FF
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EBF393DC0;
	Wed, 14 Jan 2026 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M6fCdsWR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F944395DA1
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390561; cv=none; b=IZoxCq26qDeFksgVxRRawjErC7pgmFFrdTXvZUD325te2UKlt2BSm+slUDJQNMTIEeeIEYrS3vOOke7cYHJL5DBBPPJxc1Cn67K1oWxWYFHF15BwaS/5BqK04JPp9yyGNeSSHrbi00Gfs8gBkGONaVWqbsj4ko4dqc4jInXzQV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390561; c=relaxed/simple;
	bh=RMlvOfwkCXrSKdq414J/8rj3i8HQVfygLYwBJobOdV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iQPnLsF5TKFAf9aT/pGutZGJNIz7VcMji32seAEMzkH8XGihRpYTiEgCAlZ5AXih8EhVHexEt+kt+lOa53ZWOJOAZcpuJMe5TiACXdroSmKks3ObPcVhtHqt5oMEm9+5BGd4YVkDV+zybvlPYQvAAtW3DrhMeG5Gz8eNWvYrE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M6fCdsWR; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nrIiGmzrPddCzyrKZdqDkSj0MgSt0dRpJv5I1+lcafw=;
	b=M6fCdsWRiOPynPpGQoKa+M9QMkaiLufFtqZyCqB7CkCQpzXxZ/BaAInFTO+f3iCBtlui1E
	5QrID4zcWlG2j+JEofg84xWeLhlxNLt/TAw94oXPVS2ieVCRgFvI0wTkiJKx1zof1gwJwl
	1OrjEB74AwD5y9miusJ0SyiNPwMEqck=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 25/30] mm: vmscan: prepare for reparenting traditional LRU folios
Date: Wed, 14 Jan 2026 19:32:52 +0800
Message-ID: <3adb367000706f9ef681b34d0a2b0eb34c494c84.1768389889.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

To resolve the dying memcg issue, we need to reparent LRU folios of child
memcg to its parent memcg. For traditional LRU list, each lruvec of every
memcg comprises four LRU lists. Due to the symmetry of the LRU lists, it
is feasible to transfer the LRU lists from a memcg to its parent memcg
during the reparenting process.

This commit implements the specific function, which will be used during
the reparenting process.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/mmzone.h |  4 ++++
 include/linux/swap.h   | 19 +++++++++++++++++++
 mm/swap.c              | 37 +++++++++++++++++++++++++++++++++++++
 mm/vmscan.c            | 19 -------------------
 4 files changed, 60 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 6a7db0fee54a3..1014b5a93c09c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -366,6 +366,10 @@ enum lruvec_flags {
 	LRUVEC_NODE_CONGESTED,
 };
 
+#ifdef CONFIG_MEMCG
+void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+#endif /* CONFIG_MEMCG */
+
 #endif /* !__GENERATING_BOUNDS_H */
 
 /*
diff --git a/include/linux/swap.h b/include/linux/swap.h
index e60f45b48e74d..4449d1f371a56 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -636,5 +636,24 @@ static inline bool mem_cgroup_swap_full(struct folio *folio)
 }
 #endif
 
+/* for_each_managed_zone_pgdat - helper macro to iterate over all managed zones in a pgdat up to
+ * and including the specified highidx
+ * @zone: The current zone in the iterator
+ * @pgdat: The pgdat which node_zones are being iterated
+ * @idx: The index variable
+ * @highidx: The index of the highest zone to return
+ *
+ * This macro iterates through all managed zones up to and including the specified highidx.
+ * The zone iterator enters an invalid state after macro call and must be reinitialized
+ * before it can be used again.
+ */
+#define for_each_managed_zone_pgdat(zone, pgdat, idx, highidx)	\
+	for ((idx) = 0, (zone) = (pgdat)->node_zones;		\
+	    (idx) <= (highidx);					\
+	    (idx)++, (zone)++)					\
+		if (!managed_zone(zone))			\
+			continue;				\
+		else
+
 #endif /* __KERNEL__*/
 #endif /* _LINUX_SWAP_H */
diff --git a/mm/swap.c b/mm/swap.c
index 7e53479ca1732..cb40e80da53cd 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1090,6 +1090,43 @@ void folio_batch_remove_exceptionals(struct folio_batch *fbatch)
 	fbatch->nr = j;
 }
 
+#ifdef CONFIG_MEMCG
+static void lruvec_reparent_lru(struct lruvec *child_lruvec,
+				struct lruvec *parent_lruvec,
+				enum lru_list lru, int nid)
+{
+	int zid;
+	struct zone *zone;
+
+	if (lru != LRU_UNEVICTABLE)
+		list_splice_tail_init(&child_lruvec->lists[lru], &parent_lruvec->lists[lru]);
+
+	for_each_managed_zone_pgdat(zone, NODE_DATA(nid), zid, MAX_NR_ZONES - 1) {
+		unsigned long size = mem_cgroup_get_zone_lru_size(child_lruvec, lru, zid);
+
+		mem_cgroup_update_lru_size(parent_lruvec, lru, zid, size);
+	}
+}
+
+void lru_reparent_memcg(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+	int nid;
+
+	for_each_node(nid) {
+		enum lru_list lru;
+		struct lruvec *child_lruvec, *parent_lruvec;
+
+		child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+		parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
+		parent_lruvec->anon_cost += child_lruvec->anon_cost;
+		parent_lruvec->file_cost += child_lruvec->file_cost;
+
+		for_each_lru(lru)
+			lruvec_reparent_lru(child_lruvec, parent_lruvec, lru, nid);
+	}
+}
+#endif
+
 static const struct ctl_table swap_sysctl_table[] = {
 	{
 		.procname	= "page-cluster",
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c48ff6e05e004..e738082874878 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -270,25 +270,6 @@ static int sc_swappiness(struct scan_control *sc, struct mem_cgroup *memcg)
 }
 #endif
 
-/* for_each_managed_zone_pgdat - helper macro to iterate over all managed zones in a pgdat up to
- * and including the specified highidx
- * @zone: The current zone in the iterator
- * @pgdat: The pgdat which node_zones are being iterated
- * @idx: The index variable
- * @highidx: The index of the highest zone to return
- *
- * This macro iterates through all managed zones up to and including the specified highidx.
- * The zone iterator enters an invalid state after macro call and must be reinitialized
- * before it can be used again.
- */
-#define for_each_managed_zone_pgdat(zone, pgdat, idx, highidx)	\
-	for ((idx) = 0, (zone) = (pgdat)->node_zones;		\
-	    (idx) <= (highidx);					\
-	    (idx)++, (zone)++)					\
-		if (!managed_zone(zone))			\
-			continue;				\
-		else
-
 static void set_task_reclaim_state(struct task_struct *task,
 				   struct reclaim_state *rs)
 {
-- 
2.20.1


