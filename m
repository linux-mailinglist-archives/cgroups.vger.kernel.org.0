Return-Path: <cgroups+bounces-12301-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61916CAEA43
	for <lists+cgroups@lfdr.de>; Tue, 09 Dec 2025 02:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6907F30117AB
	for <lists+cgroups@lfdr.de>; Tue,  9 Dec 2025 01:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC192FFDEB;
	Tue,  9 Dec 2025 01:41:16 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C222FF14D;
	Tue,  9 Dec 2025 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765244476; cv=none; b=DFlhOc7WHiO+TIN7jA5kLrtFV953cLljVhyPRW8Me1MbZiiTDfDEhePbv/gbBTRa/reRQUFqgQfHEddPAaXZX1dWz1RHyuWrZCn21lQvUyF8FWFWBvu3FBruDzV0AFBGo4B7DAPc2zv/q+QMq1zu3xDVsXuasuSuLnUkT7jImxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765244476; c=relaxed/simple;
	bh=T+kqe7s3p6OD9UwmnfewzL0JtVgGbWopOKOE++i19n8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kJgJmWZ95rP1CweeqTsDbaXZUdyA4QydCn15yKNMe+ERtu+g6qIcNoDyu4h6EtAohhYIBwTYJCe0U0gCSYqzg+BXZrHMrOHsz2PRIq3WJsOWQeh4Zq5fs5pwguEZTKDcuL8xBRSYDAK2REQ7jLcr4ZBlXSx2mtKypy76YDs5ZAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dQM3x2vW3zKHMHr;
	Tue,  9 Dec 2025 09:40:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 356EC1A1CB3;
	Tue,  9 Dec 2025 09:41:11 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP2 (Coremail) with SMTP id Syh0CgBnRlAafjdpkF9fBA--.23909S5;
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
Subject: [PATCH -next 3/5] mm/mglru: extend shrink_one for both lrugen and non-lrugen
Date: Tue,  9 Dec 2025 01:25:55 +0000
Message-Id: <20251209012557.1949239-4-chenridong@huaweicloud.com>
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
X-CM-TRANSID:Syh0CgBnRlAafjdpkF9fBA--.23909S5
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kArWUtr43KF1rGF45ZFb_yoWrZry7pF
	ZxJry2ya1rArnIg39avF4kWw1Yyw48Gr13Ary5C3WfAFyfJFyFya47CrW8CryUC3s5ur9x
	Ar4avw1UW3y0vF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7sRiuWl3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/

From: Chen Ridong <chenridong@huawei.com>

Currently, flush_reclaim_state is placed differently between
shrink_node_memcgs and shrink_many. shrink_many (only used for gen-LRU)
calls it after each lruvec is shrunk, while shrink_node_memcgs calls it
only after all lruvecs have been shrunk.

This patch moves flush_reclaim_state into shrink_node_memcgs and calls it
after each lruvec. This unifies the behavior and is reasonable because:

1. flush_reclaim_state adds current->reclaim_state->reclaimed to
   sc->nr_reclaimed.
2. For non-MGLRU root reclaim, this can help stop the iteration earlier
   when nr_to_reclaim is reached.
3. For non-root reclaim, the effect is negligible since flush_reclaim_state
   does nothing in that case.

After moving flush_reclaim_state into shrink_node_memcgs, shrink_one can be
extended to support both lrugen and non-lrugen paths. It will call
try_to_shrink_lruvec for lrugen root reclaim and shrink_lruvec otherwise.

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 57 +++++++++++++++++++++--------------------------------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 584f41eb4c14..795f5ebd9341 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4758,23 +4758,7 @@ static bool try_to_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	return nr_to_scan < 0;
 }
 
-static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
-{
-	unsigned long scanned = sc->nr_scanned;
-	unsigned long reclaimed = sc->nr_reclaimed;
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
-
-	try_to_shrink_lruvec(lruvec, sc);
-
-	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
-
-	if (!sc->proactive)
-		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
-			   sc->nr_reclaimed - reclaimed);
-
-	flush_reclaim_state(sc);
-}
+static void shrink_one(struct lruvec *lruvec, struct scan_control *sc);
 
 static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
 {
@@ -5760,6 +5744,27 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return inactive_lru_pages > pages_for_compaction;
 }
 
+static void shrink_one(struct lruvec *lruvec, struct scan_control *sc)
+{
+	unsigned long scanned = sc->nr_scanned;
+	unsigned long reclaimed = sc->nr_reclaimed;
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+
+	if (lru_gen_enabled() && root_reclaim(sc))
+		try_to_shrink_lruvec(lruvec, sc);
+	else
+		shrink_lruvec(lruvec, sc);
+
+	shrink_slab(sc->gfp_mask, pgdat->node_id, memcg, sc->priority);
+
+	if (!sc->proactive)
+		vmpressure(sc->gfp_mask, memcg, false, sc->nr_scanned - scanned,
+			   sc->nr_reclaimed - reclaimed);
+
+	flush_reclaim_state(sc);
+}
+
 static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
@@ -5784,8 +5789,6 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	memcg = mem_cgroup_iter(target_memcg, NULL, partial);
 	do {
 		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		unsigned long reclaimed;
-		unsigned long scanned;
 
 		/*
 		 * This loop can become CPU-bound when target memcgs
@@ -5817,19 +5820,7 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			memcg_memory_event(memcg, MEMCG_LOW);
 		}
 
-		reclaimed = sc->nr_reclaimed;
-		scanned = sc->nr_scanned;
-
-		shrink_lruvec(lruvec, sc);
-
-		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
-			    sc->priority);
-
-		/* Record the group's reclaim efficiency */
-		if (!sc->proactive)
-			vmpressure(sc->gfp_mask, memcg, false,
-				   sc->nr_scanned - scanned,
-				   sc->nr_reclaimed - reclaimed);
+		shrink_one(lruvec, sc);
 
 		/* If partial walks are allowed, bail once goal is reached */
 		if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
@@ -5863,8 +5854,6 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 
 	shrink_node_memcgs(pgdat, sc);
 
-	flush_reclaim_state(sc);
-
 	nr_node_reclaimed = sc->nr_reclaimed - nr_reclaimed;
 
 	/* Record the subtree's reclaim efficiency */
-- 
2.34.1


