Return-Path: <cgroups+bounces-12643-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCCCDB9E2
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 08:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2EFD8303E00F
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 07:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED032E12D;
	Wed, 24 Dec 2025 07:45:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F12528FD;
	Wed, 24 Dec 2025 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766562339; cv=none; b=IdLKnRfmazjzLXpPVUMpbcji+o7OLzHhLcyWTN0LXEm85c1XenisrMGdBHyMPQyuDV2JP4W8dYrQ4voxFOxN8ApAIaoiYuexTniFkmQ2k/3amJHqKTQLaflXhYpyVGiQ7YL4UthTlFYlLmvRSDqGLIwtJ09jzC1cxOd59eR5TmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766562339; c=relaxed/simple;
	bh=0CPrT+ghLEuRM3cIbeYzqgGyQEPmDLZtw2yFACYPIqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kc3BWuXRWqn6zR89d+PTAY7+oTh2jN9COaH8wEpPC/SXHtw9Z/B6UX8nQKyG3GYNTjMKBxamERi/zjrQH1iEAMKZfGBfpasLYOAcuyQgJqCnE/vI3aMgpliNh4t6lzIjP2B2RK+OkB/mWCbDAP6By4NHxBPO3yxe8njoakY2n6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dbkSC6FK1zKHMNw;
	Wed, 24 Dec 2025 15:45:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5ABD340572;
	Wed, 24 Dec 2025 15:45:35 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgA3l_cMmktp9pcvBQ--.63051S8;
	Wed, 24 Dec 2025 15:45:35 +0800 (CST)
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
Subject: [PATCH -next v2 6/7] mm/mglru: combine shrink_many into shrink_node_memcgs
Date: Wed, 24 Dec 2025 07:30:31 +0000
Message-Id: <20251224073032.161911-7-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgA3l_cMmktp9pcvBQ--.63051S8
X-Coremail-Antispam: 1UD129KBjvJXoWxGFyDGw1fGFW5ArW8CF4fGrg_yoWrXFWUpF
	ZxJry7ZayrAFsIgw13ta17ua4Skw48GrW3Ary8J3WxCr1Sqa4rGa42kryxCFy5CF95urnx
	Zr909w1UWw4jvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

This patch adds the lru_gen_should_abort_scan check to shrink_node_memcgs
(which is only meaningful for gen-LRU root reclaim). After this change,
shrink_node_memcgs can be used directly instead of shrink_many, allowing
shrink_many to be safely removed.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 60 +++++++++++------------------------------------------
 1 file changed, 12 insertions(+), 48 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3a266f6456af..1d13ce7338b4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4777,45 +4777,6 @@ static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	flush_reclaim_state(sc);
 }
 
-static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
-{
-	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
-	struct mem_cgroup_reclaim_cookie reclaim = {
-		.pgdat = pgdat,
-	};
-	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
-	struct mem_cgroup *memcg;
-
-	if (current_is_kswapd() || sc->memcg_full_walk)
-		partial = NULL;
-
-	memcg = mem_cgroup_iter(target_memcg, NULL, partial);
-	do {
-		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
-
-		cond_resched();
-
-		mem_cgroup_calculate_protection(target_memcg, memcg);
-
-		if (mem_cgroup_below_min(target_memcg, memcg)) {
-			continue;
-		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
-			if (!sc->memcg_low_reclaim) {
-				sc->memcg_low_skipped = 1;
-				continue;
-			}
-			memcg_memory_event(memcg, MEMCG_LOW);
-		}
-
-		shrink_one(lruvec, sc);
-
-		if (lru_gen_should_abort_scan(lruvec, sc)) {
-			mem_cgroup_iter_break(target_memcg, memcg);
-			break;
-		}
-	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
-}
-
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -4844,6 +4805,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	blk_finish_plug(&plug);
 }
 
+static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc);
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -4873,7 +4835,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	if (mem_cgroup_disabled())
 		shrink_one(&pgdat->__lruvec, sc);
 	else
-		shrink_many(pgdat, sc);
+		shrink_node_memcgs(pgdat, sc);
 
 	if (current_is_kswapd())
 		sc->nr_reclaimed += reclaimed;
@@ -5586,11 +5548,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	bool proportional_reclaim;
 	struct blk_plug plug;
 
-	if (lru_gen_enabled() && !root_reclaim(sc)) {
-		lru_gen_shrink_lruvec(lruvec, sc);
-		return;
-	}
-
 	get_scan_count(lruvec, sc, nr);
 
 	/* Record the original scan target for proportional adjustments later */
@@ -5822,8 +5779,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		reclaimed = sc->nr_reclaimed;
 		scanned = sc->nr_scanned;
-
-		shrink_lruvec(lruvec, sc);
+		if (lru_gen_enabled())
+			lru_gen_shrink_lruvec(lruvec, sc);
+		else
+			shrink_lruvec(lruvec, sc);
 
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
@@ -5837,7 +5796,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		flush_reclaim_state(sc);
 
 		/* If partial walks are allowed, bail once goal is reached */
-		if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
+		if (lru_gen_enabled() && root_reclaim(sc)) {
+			if (lru_gen_should_abort_scan(lruvec, sc)) {
+				mem_cgroup_iter_break(target_memcg, memcg);
+				break;
+			}
+		} else if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
 			mem_cgroup_iter_break(target_memcg, memcg);
 			break;
 		}
-- 
2.34.1


