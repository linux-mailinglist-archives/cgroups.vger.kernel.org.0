Return-Path: <cgroups+bounces-13329-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO7jMDRUcGlvXQAAu9opvQ
	(envelope-from <cgroups+bounces-13329-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 05:21:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DEA50F32
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 05:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3AFD67412B3
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5C743CEF5;
	Tue, 20 Jan 2026 13:57:54 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8742EEC9;
	Tue, 20 Jan 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917473; cv=none; b=k5lF+eZ05CMAujOmgdgRwXkyqAWz0Fw7tO1vuUuV4kAfjnpd0+uWQsRFD5QQf3o/FrrPWreYSvi0fgJaPFXnbSqSnvPu0zFx3OdFP327l0yVAKvlnbBaskkuOmsgVHtqY5ucZgaUHG/Xn0jLapGDQj8RziDp/4PzD698cfyA040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917473; c=relaxed/simple;
	bh=1mQ+p20BVTtij/RjqCHRdSovj3VKQLmAwG1/Ah+A9SI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgz3yKmMjovyDYEp75gYyIMecT0CKeYPPmSJeKXXNBoWYXnxQmECRbDCKSR4h38WpsFgoocg25s1c5JwJDP3nwjq4OlqeGQf5MtFwHjKRv7ruS47mrJ0/uf1E1fGNcTwDzHovhlr1eS9Y6GVhZ87SdQeDJyjnOI6lUK56Zts+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwTQP4lmszKHMkc;
	Tue, 20 Jan 2026 21:56:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0576C4056B;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPnQiW9pwhTxEQ--.10691S3;
	Tue, 20 Jan 2026 21:57:46 +0800 (CST)
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
	skhan@linuxfoundation.org,
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
	ryncsn@gmail.com
Subject: [RFC PATCH -next 1/7] vmscan: add memcg heat level for reclaim
Date: Tue, 20 Jan 2026 13:42:50 +0000
Message-Id: <20260120134256.2271710-2-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120134256.2271710-1-chenridong@huaweicloud.com>
References: <20260120134256.2271710-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCPnQiW9pwhTxEQ--.10691S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Kw1UCF1DZF1xXrWDCw45Jrb_yoWkXF1DpF
	Z3JayYyws3JF13KwnIy3WUW34fAwn7Ww13J343Gr1fAr13t345Za12kr47ZFW5CF98Xr13
	J390kw1UWw4DZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUU9N3UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,huawei.com,huaweicloud.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13329-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: B7DEA50F32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chen Ridong <chenridong@huawei.com>

The memcg LRU was originally introduced to improve scalability during
global reclaim. However, it is complex and only works with gen lru
global reclaim. Moreover, its implementation complexity has led to
performance regressions when handling a large number of memory cgroups [1].

This patch introduces a per-memcg heat level for reclaim, aiming to unify
gen lru and traditional LRU global reclaim. The core idea is to track
per-node per-memcg reclaim state, including heat, last_decay, and
last_refault. The last_refault records the total reclaimed data from the
previous memcg reclaim. The last_decay is a time-based parameter; the heat
level decays over time if the memcg is not reclaimed again. Both last_decay
and last_refault are used to calculate the current heat level when reclaim
starts.

Three reclaim heat levels are defined: cold, warm, and hot. Cold memcgs are
reclaimed first; only if cold memcgs cannot reclaim enough pages, warm
memcgs become eligible for reclaim. Hot memcgs are reclaimed last.

While this design can be applied to all memcg reclaim scenarios, this patch
is conservative and only introduces heat levels for traditional LRU global
reclaim. Subsequent patches will replace the memcg LRU with
heat-level-based reclaim.

Based on tests provided by YU Zhao, traditional LRU global reclaim shows
significant performance improvement with heat-level reclaim enabled.

The results below are from a 2-hour run of the test [2].

Throughput (number of requests)		before	   after	Change
Total					1734169    2353717	+35%

Tail latency (number of requests)	before	   after	Change
[128s, inf)				1231	   1057		-14%
[64s, 128s)				586	   444		-24%
[32s, 64s)				1658	   1061		-36%
[16s, 32s)				4611	   2863		-38%

[1] https://lore.kernel.org/r/20251126171513.GC135004@cmpxchg.org
[2] https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.com/

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 include/linux/memcontrol.h |   7 ++
 mm/memcontrol.c            |   3 +
 mm/vmscan.c                | 227 +++++++++++++++++++++++++++++--------
 3 files changed, 192 insertions(+), 45 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index af352cabedba..b293caf70034 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -76,6 +76,12 @@ struct memcg_vmstats;
 struct lruvec_stats_percpu;
 struct lruvec_stats;
 
+struct memcg_reclaim_state {
+	atomic_long_t heat;
+	unsigned long last_decay;
+	atomic_long_t last_refault;
+};
+
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup *position;
 	/* scan generation, increased every round-trip */
@@ -114,6 +120,7 @@ struct mem_cgroup_per_node {
 	CACHELINE_PADDING(_pad2_);
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
+	struct memcg_reclaim_state	reclaim;
 
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
 	/* slab stats for nmi context */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f2b87e02574e..675d49ad7e2c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3713,6 +3713,9 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 
 	lruvec_init(&pn->lruvec);
 	pn->memcg = memcg;
+	atomic_long_set(&pn->reclaim.heat, 0);
+	pn->reclaim.last_decay = jiffies;
+	atomic_long_set(&pn->reclaim.last_refault, 0);
 
 	memcg->nodeinfo[node] = pn;
 	return true;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4aa73f125772..3759cd52c336 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -5978,6 +5978,124 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	return inactive_lru_pages > pages_for_compaction;
 }
 
+enum memcg_scan_level {
+	MEMCG_LEVEL_COLD,
+	MEMCG_LEVEL_WARM,
+	MEMCG_LEVEL_HOT,
+	MEMCG_LEVEL_MAX,
+};
+
+#define MEMCG_HEAT_WARM		4
+#define MEMCG_HEAT_HOT		8
+#define MEMCG_HEAT_MAX		12
+#define MEMCG_HEAT_DECAY_STEP	1
+#define MEMCG_HEAT_DECAY_INTERVAL	(1 * HZ)
+
+static void memcg_adjust_heat(struct mem_cgroup_per_node *pn, long delta)
+{
+	long heat, new_heat;
+
+	if (mem_cgroup_is_root(pn->memcg))
+		return;
+
+	heat = atomic_long_read(&pn->reclaim.heat);
+	do {
+		new_heat = clamp_t(long, heat + delta, 0, MEMCG_HEAT_MAX);
+		if (atomic_long_cmpxchg(&pn->reclaim.heat, heat, new_heat) == heat)
+			break;
+		heat = atomic_long_read(&pn->reclaim.heat);
+	} while (1);
+}
+
+static void memcg_decay_heat(struct mem_cgroup_per_node *pn)
+{
+	unsigned long last;
+	unsigned long now = jiffies;
+
+	if (mem_cgroup_is_root(pn->memcg))
+		return;
+
+	last = READ_ONCE(pn->reclaim.last_decay);
+	if (!time_after(now, last + MEMCG_HEAT_DECAY_INTERVAL))
+		return;
+
+	if (cmpxchg(&pn->reclaim.last_decay, last, now) != last)
+		return;
+
+	memcg_adjust_heat(pn, -MEMCG_HEAT_DECAY_STEP);
+}
+
+static int memcg_heat_level(struct mem_cgroup_per_node *pn)
+{
+	long heat;
+
+	if (mem_cgroup_is_root(pn->memcg))
+		return MEMCG_LEVEL_COLD;
+
+	memcg_decay_heat(pn);
+	heat = atomic_long_read(&pn->reclaim.heat);
+
+	if (heat >= MEMCG_HEAT_HOT)
+		return MEMCG_LEVEL_HOT;
+	if (heat >= MEMCG_HEAT_WARM)
+		return MEMCG_LEVEL_WARM;
+	return MEMCG_LEVEL_COLD;
+}
+
+static void memcg_record_reclaim_result(struct mem_cgroup_per_node *pn,
+					struct lruvec *lruvec,
+					unsigned long scanned,
+					unsigned long reclaimed)
+{
+	long delta;
+
+	if (mem_cgroup_is_root(pn->memcg))
+		return;
+
+	memcg_decay_heat(pn);
+
+	/*
+	 * Memory cgroup heat adjustment algorithm:
+	 * - If scanned == 0: mark as hottest (+MAX_HEAT)
+	 * - If reclaimed >= 50% * scanned: strong cool (-2)
+	 * - If reclaimed >= 25% * scanned: mild cool (-1)
+	 * - Otherwise:  warm up (+1)
+	 */
+	if (!scanned)
+		delta = MEMCG_HEAT_MAX;
+	else if (reclaimed * 2 >= scanned)
+		delta = -2;
+	else if (reclaimed * 4 >= scanned)
+		delta = -1;
+	else
+		delta = 1;
+
+	/*
+	 * Refault-based heat adjustment:
+	 * - If refault increase > reclaimed pages: heat up (more cautious reclaim)
+	 * - If no refaults and currently warm:     cool down (allow more reclaim)
+	 * This prevents thrashing by backing off when refaults indicate over-reclaim.
+	 */
+	if (lruvec) {
+		unsigned long total_refaults;
+		unsigned long prev;
+		long refault_delta;
+
+		total_refaults = lruvec_page_state(lruvec, WORKINGSET_ACTIVATE_ANON);
+		total_refaults += lruvec_page_state(lruvec, WORKINGSET_ACTIVATE_FILE);
+
+		prev = atomic_long_xchg(&pn->reclaim.last_refault, total_refaults);
+		refault_delta = total_refaults - prev;
+
+		if (refault_delta > reclaimed)
+			delta++;
+		else if (!refault_delta && delta > 0)
+			delta--;
+	}
+
+	memcg_adjust_heat(pn, delta);
+}
+
 static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 {
 	struct mem_cgroup *target_memcg = sc->target_mem_cgroup;
@@ -5986,7 +6104,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	};
 	struct mem_cgroup_reclaim_cookie *partial = &reclaim;
 	struct mem_cgroup *memcg;
-
+	int level;
+	int max_level = root_reclaim(sc) ? MEMCG_LEVEL_MAX : MEMCG_LEVEL_WARM;
 	/*
 	 * In most cases, direct reclaimers can do partial walks
 	 * through the cgroup tree, using an iterator state that
@@ -5999,62 +6118,80 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	if (current_is_kswapd() || sc->memcg_full_walk)
 		partial = NULL;
 
-	memcg = mem_cgroup_iter(target_memcg, NULL, partial);
-	do {
-		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		unsigned long reclaimed;
-		unsigned long scanned;
-
-		/*
-		 * This loop can become CPU-bound when target memcgs
-		 * aren't eligible for reclaim - either because they
-		 * don't have any reclaimable pages, or because their
-		 * memory is explicitly protected. Avoid soft lockups.
-		 */
-		cond_resched();
+	for (level = MEMCG_LEVEL_COLD; level < max_level; level++) {
+		bool need_next_level = false;
 
-		mem_cgroup_calculate_protection(target_memcg, memcg);
+		memcg = mem_cgroup_iter(target_memcg, NULL, partial);
+		do {
+			struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
+			unsigned long reclaimed;
+			unsigned long scanned;
+			struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
 
-		if (mem_cgroup_below_min(target_memcg, memcg)) {
-			/*
-			 * Hard protection.
-			 * If there is no reclaimable memory, OOM.
-			 */
-			continue;
-		} else if (mem_cgroup_below_low(target_memcg, memcg)) {
 			/*
-			 * Soft protection.
-			 * Respect the protection only as long as
-			 * there is an unprotected supply
-			 * of reclaimable memory from other cgroups.
+			 * This loop can become CPU-bound when target memcgs
+			 * aren't eligible for reclaim - either because they
+			 * don't have any reclaimable pages, or because their
+			 * memory is explicitly protected. Avoid soft lockups.
 			 */
-			if (!sc->memcg_low_reclaim) {
-				sc->memcg_low_skipped = 1;
+			cond_resched();
+
+			mem_cgroup_calculate_protection(target_memcg, memcg);
+
+			if (mem_cgroup_below_min(target_memcg, memcg)) {
+				/*
+				 * Hard protection.
+				 * If there is no reclaimable memory, OOM.
+				 */
 				continue;
+			} else if (mem_cgroup_below_low(target_memcg, memcg)) {
+				/*
+				 * Soft protection.
+				 * Respect the protection only as long as
+				 * there is an unprotected supply
+				 * of reclaimable memory from other cgroups.
+				 */
+				if (!sc->memcg_low_reclaim) {
+					sc->memcg_low_skipped = 1;
+					continue;
+				}
+				memcg_memory_event(memcg, MEMCG_LOW);
 			}
-			memcg_memory_event(memcg, MEMCG_LOW);
-		}
 
-		reclaimed = sc->nr_reclaimed;
-		scanned = sc->nr_scanned;
+			if (root_reclaim(sc) && memcg_heat_level(pn) > level) {
+				need_next_level = true;
+				continue;
+			}
 
-		shrink_lruvec(lruvec, sc);
+			reclaimed = sc->nr_reclaimed;
+			scanned = sc->nr_scanned;
 
-		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
-			    sc->priority);
+			shrink_lruvec(lruvec, sc);
+			if (!memcg || memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B))
+				shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
+					    sc->priority);
 
-		/* Record the group's reclaim efficiency */
-		if (!sc->proactive)
-			vmpressure(sc->gfp_mask, memcg, false,
-				   sc->nr_scanned - scanned,
-				   sc->nr_reclaimed - reclaimed);
+			if (root_reclaim(sc))
+				memcg_record_reclaim_result(pn, lruvec,
+						    sc->nr_scanned - scanned,
+						    sc->nr_reclaimed - reclaimed);
 
-		/* If partial walks are allowed, bail once goal is reached */
-		if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
-			mem_cgroup_iter_break(target_memcg, memcg);
+			/* Record the group's reclaim efficiency */
+			if (!sc->proactive)
+				vmpressure(sc->gfp_mask, memcg, false,
+					   sc->nr_scanned - scanned,
+					   sc->nr_reclaimed - reclaimed);
+
+			/* If partial walks are allowed, bail once goal is reached */
+			if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
+				mem_cgroup_iter_break(target_memcg, memcg);
+				break;
+			}
+		} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
+
+		if (!need_next_level)
 			break;
-		}
-	} while ((memcg = mem_cgroup_iter(target_memcg, memcg, partial)));
+	}
 }
 
 static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
-- 
2.34.1


