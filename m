Return-Path: <cgroups+bounces-12647-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2C5CDB9F5
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 08:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C610307A5A6
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DC832ED5B;
	Wed, 24 Dec 2025 07:45:40 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1013923D7EA;
	Wed, 24 Dec 2025 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766562340; cv=none; b=UceuXDzwU+Izwb/v3Po/18ClhCvEMUtThARcsJe11GJZXxUlBvPF/uYI3GaMLocjUpDfItTbvsFzb0qq+pYkIpDNfjm8kuBXx6xqYhMhlJzWAOH6muJoRgLGM+/76C8aSXiaUXy1IQzhDr4kpm+4R3d1rGkCyhG70YSUQUv8jds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766562340; c=relaxed/simple;
	bh=0XiW60W9or9uxfeW5SVF1I30GRUtp9fF8zXrqSbMlUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kb0IVoqmOEFKPVdQEITP9pJGlViwUp1hMsrXLz62CiyvFFsiGa5CHVoqFox8d/EIVYJWN7P8nF8KdOY/4QQ1o8e7Meznp9R27dyS6g3rsh6OI21Q1X+lYWXcdJiLQ8UroxydGN071mkY3hvstzARvNPwvDNgZO6gIsb0RRNLMsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dbkRr2xC4zYQtn3;
	Wed, 24 Dec 2025 15:44:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B0A9E40574;
	Wed, 24 Dec 2025 15:45:34 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_cMmktp9pcvBQ--.63051S3;
	Wed, 24 Dec 2025 15:45:34 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com,
	mkoutny@suse.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com
Subject: [PATCH -next v2 1/7] mm/mglru: use mem_cgroup_iter for global reclaim
Date: Wed, 24 Dec 2025 07:30:26 +0000
Message-Id: <20251224073032.161911-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251224073032.161911-1-chenridong@huaweicloud.com>
References: <20251224073032.161911-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3l_cMmktp9pcvBQ--.63051S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1rJFyrtryUKF15Xr1DJrb_yoWxGrW7pF
	ZxGrWay395JF13Kr4fKa1Uu3WrC3yxJr45Jryxtw1xAr1ft34Fgw12kr18JFW5ZFZ5Zr17
	GF90yw1UWw4jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0pRlJPiUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The memcg LRU was originally introduced for global reclaim to enhance
scalability. However, its implementation complexity has led to performance
regressions when dealing with a large number of memory cgroups [1].

As suggested by Johannes [1], this patch adopts mem_cgroup_iter with
cookie-based iteration for global reclaim, aligning with the approach
already used in shrink_node_memcgs. This simplification removes the
dedicated memcg LRU tracking while maintaining the core functionality.

It performed a stress test based on Yu Zhao's methodology [2] on a
1 TB, 4-node NUMA system. The results are summarized below:

	pgsteal:
						memcg LRU    memcg iter
	stddev(pgsteal) / mean(pgsteal)		106.03%		93.20%
	sum(pgsteal) / sum(requested)		98.10%		99.28%

	workingset_refault_anon:
						memcg LRU    memcg iter
	stddev(refault) / mean(refault)		193.97%		134.67%
	sum(refault)				1963229		2027567

The new implementation shows a clear fairness improvement, reducing the
standard deviation relative to the mean by 12.8 percentage points. The
pgsteal ratio is also closer to 100%. Refault counts increased by 3.2%
(from 1,963,229 to 2,027,567).

The primary benefits of this change are:
1. Simplified codebase by removing custom memcg LRU infrastructure
2. Improved fairness in memory reclaim across multiple cgroups
3. Better performance when creating many memory cgroups

[1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
[2] https://lore.kernel.org/r/20221222041905.2431096-7-yuzhao@google.com
Suggested-by: Johannes Weiner <hannes@cmxpchg.org>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 111 +++++++++++++---------------------------------------
 1 file changed, 28 insertions(+), 83 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 76e9864447cc..95fa4e054db6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4896,27 +4896,14 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	return nr_to_scan < 0;
 }
 
-static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
+static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 {
-	bool success;
 	unsigned long scanned = sc->nr_scanned;
 	unsigned long reclaimed = sc->nr_reclaimed;
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
 
-	/* lru_gen_age_node() called mem_cgroup_calculate_protection() */
-	if (mem_cgroup_below_min(NULL, memcg))
-		return MEMCG_LRU_YOUNG;
-
-	if (mem_cgroup_below_low(NULL, memcg)) {
-		/* see the comment on MEMCG_NR_GENS */
-		if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL)
-			return MEMCG_LRU_TAIL;
-
-		memcg_memory_event(memcg, MEMCG_LOW);
-	}
-
-	success = try_to_shrink_lruvec(lruvec, sc);
+	try_to_shrink_lruvec(lruvec, sc);
 
 	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
 
@@ -4925,86 +4912,45 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 			   sc->nr_reclaimed - reclaimed);
 
 	flush_reclaim_state(sc);
-
-	if (success && mem_cgroup_online(memcg))
-		return MEMCG_LRU_YOUNG;
-
-	if (!success && lruvec_is_sizable(lruvec, sc))
-		return 0;
-
-	/* one retry if offlined or too small */
-	return READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_TAIL ?
-	       MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
 }
 
 static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 {
-	int op;
-	int gen;
-	int bin;
-	int first_bin;
-	struct lruvec *lruvec;
-	struct lru_gen_folio *lrugen;
+	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
+	struct mem_cgroup_reclaim_cookie reclaim = {
+		.pgdat = pgdat,
+	};
+	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
 	struct mem_cgroup *memcg;
-	struct hlist_nulls_node *pos;
-
-	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
-	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
-restart:
-	op = 0;
-	memcg = NULL;
-
-	rcu_read_lock();
 
-	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
-		if (op) {
-			lru_gen_rotate_memcg(lruvec, op);
-			op = 0;
-		}
+	if (current_is_kswapd() || sc->memcg_full_walk)
+		partial = NULL;
 
-		mem_cgroup_put(memcg);
-		memcg = NULL;
+	memcg = mem_cgroup_iter(target_memcg, NULL, partial);
+	do {
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-		if (gen != READ_ONCE(lrugen->gen))
-			continue;
+		cond_resched();
 
-		lruvec = container_of(lrugen, struct lruvec, lrugen);
-		memcg = lruvec_memcg(lruvec);
+		mem_cgroup_calculate_protection(target_memcg, memcg);
 
-		if (!mem_cgroup_tryget(memcg)) {
-			lru_gen_release_memcg(memcg);
-			memcg = NULL;
+		if (mem_cgroup_below_min(target_memcg, memcg)) {
 			continue;
+		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
+			if (!sc->memcg_low_reclaim) {
+				sc->memcg_low_skipped = 1;
+				continue;
+			}
+			memcg_memory_event(memcg, MEMCG_LOW);
 		}
 
-		rcu_read_unlock();
-
-		op = shrink_one(lruvec, sc);
+		shrink_one(lruvec, sc);
 
-		rcu_read_lock();
-
-		if (should_abort_scan(lruvec, sc))
+		if (should_abort_scan(lruvec, sc)) {
+			mem_cgroup_iter_break(target_memcg, memcg);
 			break;
-	}
-
-	rcu_read_unlock();
-
-	if (op)
-		lru_gen_rotate_memcg(lruvec, op);
-
-	mem_cgroup_put(memcg);
-
-	if (!is_a_nulls(pos))
-		return;
-
-	/* restart if raced with lru_gen_rotate_memcg() */
-	if (gen != get_nulls_value(pos))
-		goto restart;
-
-	/* try the rest of the bins of the current generation */
-	bin = get_memcg_bin(bin + 1);
-	if (bin != first_bin)
-		goto restart;
+		}
+	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
 }
 
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
@@ -5020,8 +4966,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 
 	set_mm_walk(NULL, sc->proactive);
 
-	if (try_to_shrink_lruvec(lruvec, sc))
-		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
+	try_to_shrink_lruvec(lruvec, sc);
 
 	clear_mm_walk();
 
-- 
2.34.1


