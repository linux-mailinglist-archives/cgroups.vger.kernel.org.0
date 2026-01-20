Return-Path: <cgroups+bounces-13326-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOM1EA0WcGlyUwAAu9opvQ
	(envelope-from <cgroups+bounces-13326-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 00:55:57 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE844E304
	for <lists+cgroups@lfdr.de>; Wed, 21 Jan 2026 00:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8202F927683
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A178443CED2;
	Tue, 20 Jan 2026 13:57:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C7436357;
	Tue, 20 Jan 2026 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917473; cv=none; b=HKeDUX100BgoKYrqCQzO5qJD5V75G5Tm7aspLbVfi6OZk9JWZzEeMopGLRPtOk9NRcs0quvGj+roCOZ/WXbdsnJWGPg4/HNlhFVF3gfXfPz7Sl9gIVgvnZVER6UczP2EpdJlK56Nd95XGguz8TK+1y938FatBRmFUVPQiNLZNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917473; c=relaxed/simple;
	bh=J9yEojaUh7VqQNQDT0IMKJdcMZhbDqbgy/U1qmgWZaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A58gA+iuyI3I0TswG8Y/cPEWsKycnHrMbczlcuQk15BqAfOGVdpSGLR77UQMInks6h2p5xJSoBLS7l8HuainKNcmRt+KvdttWzcJvkFwFwxfDpJ2hHHKQukKDvLwOo0GfnWRNaHswuuLFWk2wvenIWJJKWd+GqIH15f3JjLLCDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dwTQQ0YWSzKHMkm;
	Tue, 20 Jan 2026 21:56:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 649B640573;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPnQiW9pwhTxEQ--.10691S7;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
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
Subject: [RFC PATCH -next 5/7] mm/mglru: combine shrink_many into shrink_node_memcgs
Date: Tue, 20 Jan 2026 13:42:54 +0000
Message-Id: <20260120134256.2271710-6-chenridong@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgCnCPnQiW9pwhTxEQ--.10691S7
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw17Cr4kAw45CF1ruw45ZFb_yoW7ZFyfpa
	9xG3y2ya95JF4Ygws3tF4Du3Wakw48JrWYyry8G3WxCr1agFyrK34jkryfZFW5u3ykurnx
	ZryYvr1UWa1jqFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
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
	TAGGED_FROM(0.00)[bounces-13326-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: BFE844E304
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chen Ridong <chenridong@huawei.com>

The memcg LRU was originally introduced to improve scalability during
global reclaim, but it only supports gen lru global reclaim and remains
complex in implementation.

Previous patches have introduced heat-level-based memcg reclaim, which is
significantly simpler. This patch switches gen lru global reclaim to the
heat-level-based reclaim mechanism.

The following results are from a 24-hour test provided by YU Zhao [1]:

Throughput (number of requests)         before     after        Change
Total                                   22879701    25331956      +10%

Tail latency (number of requests)       before     after        Change
[128s, inf)                             19197	    15628	-19%
[64s, 128s)                             4500	    3815	-29%
[32s, 64s)                              14971	    13755	-36%
[16s, 32s)                              46117	    42942	-7%

[1] https://lore.kernel.org/all/20221220214923.1229538-1-yuzhao@google.com/
Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 mm/vmscan.c | 101 ++++++++++++----------------------------------------
 1 file changed, 22 insertions(+), 79 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 27c6fdbc9394..f806838c3cea 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4965,76 +4965,6 @@ static int shrink_one(struct lruvec *lruvec, struct scan_control *sc)
 	       MEMCG_LRU_TAIL : MEMCG_LRU_YOUNG;
 }
 
-static void shrink_many(struct pglist_data *pgdat, struct scan_control *sc)
-{
-	int op;
-	int gen;
-	int bin;
-	int first_bin;
-	struct lruvec *lruvec;
-	struct lru_gen_folio *lrugen;
-	struct mem_cgroup *memcg;
-	struct hlist_nulls_node *pos;
-
-	gen = get_memcg_gen(READ_ONCE(pgdat->memcg_lru.seq));
-	bin = first_bin = get_random_u32_below(MEMCG_NR_BINS);
-restart:
-	op = 0;
-	memcg = NULL;
-
-	rcu_read_lock();
-
-	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
-		if (op) {
-			lru_gen_rotate_memcg(lruvec, op);
-			op = 0;
-		}
-
-		mem_cgroup_put(memcg);
-		memcg = NULL;
-
-		if (gen != READ_ONCE(lrugen->gen))
-			continue;
-
-		lruvec = container_of(lrugen, struct lruvec, lrugen);
-		memcg = lruvec_memcg(lruvec);
-
-		if (!mem_cgroup_tryget(memcg)) {
-			lru_gen_release_memcg(memcg);
-			memcg = NULL;
-			continue;
-		}
-
-		rcu_read_unlock();
-
-		op = shrink_one(lruvec, sc);
-
-		rcu_read_lock();
-
-		if (lru_gen_should_abort_scan(lruvec, sc))
-			break;
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
-}
-
 static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -5064,6 +4994,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 	blk_finish_plug(&plug);
 }
 
+static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc);
 static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *sc)
 {
 	struct blk_plug plug;
@@ -5093,7 +5024,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	if (mem_cgroup_disabled())
 		shrink_one(&pgdat->__lruvec, sc);
 	else
-		shrink_many(pgdat, sc);
+		shrink_node_memcgs(pgdat, sc);
 
 	if (current_is_kswapd())
 		sc->nr_reclaimed += reclaimed;
@@ -5800,6 +5731,11 @@ static bool lru_gen_should_abort_scan(struct lruvec *lruvec, struct scan_control
 {
 	return false;
 }
+
+static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
+{
+	BUILD_BUG();
+}
 #endif /* CONFIG_LRU_GEN */
 
 static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
@@ -5813,11 +5749,6 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	bool proportional_reclaim;
 	struct blk_plug plug;
 
-	if (lru_gen_enabled() && !root_reclaim(sc)) {
-		lru_gen_shrink_lruvec(lruvec, sc);
-		return;
-	}
-
 	get_scan_count(lruvec, sc, nr);
 
 	/* Record the original scan target for proportional adjustments later */
@@ -6127,7 +6058,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 	 * For kswapd, reliable forward progress is more important
 	 * than a quick return to idle. Always do full walks.
 	 */
-	if (current_is_kswapd() || sc->memcg_full_walk)
+	if ((current_is_kswapd() && lru_gen_enabled())
+	    || sc->memcg_full_walk)
 		partial = NULL;
 
 	for (level = MEMCG_LEVEL_COLD; level < max_level; level++) {
@@ -6178,7 +6110,13 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 			reclaimed = sc->nr_reclaimed;
 			scanned = sc->nr_scanned;
 
-			shrink_lruvec(lruvec, sc);
+			if (lru_gen_enabled()) {
+				if (!lruvec_is_sizable(lruvec, sc))
+					continue;
+				lru_gen_shrink_lruvec(lruvec, sc);
+			} else
+				shrink_lruvec(lruvec, sc);
+
 			if (!memcg || memcg_page_state(memcg, NR_SLAB_RECLAIMABLE_B))
 				shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 					    sc->priority);
@@ -6196,7 +6134,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 
 			flush_reclaim_state(sc);
 			/* If partial walks are allowed, bail once goal is reached */
-			if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
+			if (lru_gen_enabled() && root_reclaim(sc)) {
+				if (lru_gen_should_abort_scan(lruvec, sc)) {
+					mem_cgroup_iter_break(target_memcg, memcg);
+					break;
+				}
+			} else if (partial && sc->nr_reclaimed >= sc->nr_to_reclaim) {
 				mem_cgroup_iter_break(target_memcg, memcg);
 				break;
 			}
-- 
2.34.1


