Return-Path: <cgroups+bounces-12302-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D91CAEA49
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 02:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 562C3300EB70
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 01:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7102FFF88;
	Tue,  9 Dec 2025 01:41:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082B12FF153;
	Tue,  9 Dec 2025 01:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244476; cv=none; b=OvtB9gN7IWv3ArbJAQGY1lDRotSFGGawUAnFh924CUXm5c87p3J+HoaShK+UT7L+M41OTvovJQDJf5BcoEFuvFJL8m2XpTFnwSnyjtGihAPJGYpFmzC0wApe+cR0u1ybl8tlWm+syY3luORuHf0rjLxd1Xdl752NJQSF5m6YnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244476; c=relaxed/simple;
	bh=IozRJQ+B6OgfbHCeUBmAr2KIQZ4FCMfcLnzh6x/3YPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oScRBA3A3VGpb+6JLBfpyLCb04k5bYTCDSLpJ34WqEAQk97j/PuaU+3Dw74Rf1ojPjqyPhUhU0HlPZlwoGqsf71iI/BaNETt+r1kxuZlEgjRfQtDDt4p1USFElcaFZ4IUeFGYwzoysiWu++LnKrw2zMUhacVJpj/Zxuby+7ZvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dQM4p4vQ2zYQtkD;
	Tue,  9 Dec 2025 09:40:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5760C1A084B;
	Tue,  9 Dec 2025 09:41:11 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgBnRlAafjdpkF9fBA--.23909S6;
	Tue, 09 Dec 2025 09:41:10 +0800 (CST)
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
	zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com,
	zhongjinji@honor.com
Subject: [PATCH -next 4/5] mm/mglru: combine shrink_many into shrink_node_memcgs
Date: Tue,  9 Dec 2025 01:25:56 +0000
Message-Id: <20251209012557.1949239-5-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251209012557.1949239-1-chenridong@huaweicloud.com>
References: <20251209012557.1949239-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnRlAafjdpkF9fBA--.23909S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF15Jw45Gr4rCF17Cr47CFg_yoWrXr4DpF
	ZxJ347AayrAF4Yga4fta97ua4fCw48GrW3Ary8J3WfAr1Sga45Ga47CryIyFW5Ca4kur17
	ZF90vw18Wa1jvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

The previous patch extended shrink_one to support both lrugen and
non-lrugen reclaim. Now shrink_many and shrink_node_memcgs are almost
identical, except that shrink_many also calls should_abort_scan for lrugen
root reclaim.

This patch adds the should_abort_scan check to shrink_node_memcgs (which is
only meaningful for gen-LRU root reclaim). After this change,
shrink_node_memcgs can be used directly instead of shrink_many, allowing
shrink_many to be safely removed.

Suggested-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 67 ++++++++++++-----------------------------------------
 1 file changed, 15 insertions(+), 52 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 795f5ebd9341..dbf2cfbe3243 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4758,57 +4758,6 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	return nr_to_scan < 0;
 }
 
-static void shrink_one(struct lruvec *lruvec, struct scan_control *sc);
-
-static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
-{
-	struct mem_cgroup *target = sc->target_mem_cgroup;
-	struct mem_cgroup_reclaim_cookie reclaim = {
-		.pgdat = pgdat,
-	};
-	struct mem_cgroup_reclaim_cookie *cookie = &reclaim;
-	struct mem_cgroup *memcg;
-
-	if (current_is_kswapd() || sc->memcg_full_walk)
-		cookie = NULL;
-
-	memcg = mem_cgroup_iter(target, NULL, cookie);
-	while (memcg) {
-		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
-
-		cond_resched();
-
-		mem_cgroup_calculate_protection(target, memcg);
-
-		if (mem_cgroup_below_min(target, memcg))
-			goto next;
-
-		if (mem_cgroup_below_low(target, memcg)) {
-			if (!sc->memcg_low_reclaim) {
-				sc->memcg_low_skipped = 1;
-				goto next;
-			}
-			memcg_memory_event(memcg, MEMCG_LOW);
-		}
-
-		shrink_one(lruvec, sc);
-
-		if (should_abort_scan(lruvec, sc)) {
-			if (cookie)
-				mem_cgroup_iter_break(target, memcg);
-			break;
-		}
-
-next:
-		if (cookie && sc->nr_reclaimed >= sc->nr_to_reclaim) {
-			mem_cgroup_iter_break(target, memcg);
-			break;
-		}
-
-		memcg = mem_cgroup_iter(target, memcg, cookie);
-	}
-}
-
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -4829,6 +4778,9 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	blk_finish_plug(&plug);
 }
 
+static void shrink_one(struct lruvec *lruvec, struct scan_control *sc);
+static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc);
+
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -4858,7 +4810,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	if (mem_cgroup_disabled())
 		shrink_one(&pgdat->__lruvec, sc);
 	else
-		shrink_many(pgdat, sc);
+		shrink_node_memcgs(pgdat, sc);
 
 	if (current_is_kswapd())
 		sc->nr_reclaimed += reclaimed;
@@ -5554,6 +5506,11 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	BUILD_BUG();
 }
 
+static bool should_abort_scan(struct lruvec *lruvec, struct scan_control *sc)
+{
+	return false;
+}
+
 #endif /* CONFIG_LRU_GEN */
 
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
@@ -5822,6 +5779,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 		shrink_one(lruvec, sc);
 
+		if (should_abort_scan(lruvec, sc)) {
+			if (partial)
+				mem_cgroup_iter_break(target_memcg, memcg);
+			break;
+		}
+
 		/* If partial walks are allowed, bail once goal is reached */
 		if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
 			mem_cgroup_iter_break(target_memcg, memcg);
-- 
2.34.1


