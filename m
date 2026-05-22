Return-Path: <cgroups+bounces-16189-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMksDeuvD2rmOgYAu9opvQ
	(envelope-from <cgroups+bounces-16189-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 03:22:51 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E905ADA6A
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 03:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F20F302F266
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AF288C96;
	Fri, 22 May 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aeFFxBqi"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02923E33D
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 01:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412825; cv=none; b=TdzJ47taYvpzxYi6LTJh6cRZB9LvaKNPBFBCv55aHjJn4sYH6H8NIBHEbyUQ9/hNhbUi6LTCJvFhLl0iRse2PvqcleQRRmV5JUswiTJxN3/VE6nsQlt6L/2IX25TfZp2PM06w/oluO86Jatu/1vkNC7Il3+iiRHCE4X8HFQNhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412825; c=relaxed/simple;
	bh=lHTtEkVV9dleQGADmhZiZqxF/hqpeo/T+1k4eAAGw5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZOaT7rpaOJ5X+JDiUO3lInRvim/qZxbvltDo12aeVW+ADS54mQ4lEVugwcRVfjhny3q4Y573adejWwiBYWapvyV15/aXxi5Fbxp6equ47M2NHziErcwCNqu6E+r/tj8g8xEqXeOAePjQIsU8u+FzDnEUrPiHuHwZ5D36Jfg3TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aeFFxBqi; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779412822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlNjNHDfX0di3XL59bBl+Q1N8mPFOAdebVVOjRv4HBc=;
	b=aeFFxBqiMwvPBNGunCTlbkXP6dV8fKhIvqc4g3guRjXOlvjY+erJhhFwA/mOrFRKh8UBTI
	CD7UV30JQZpdOnxg0Fn1nQNm1lcCY10X8x/iqAAaB5Cvh+HO5gWsUbmCfL0HUfTqYpYrRJ
	iEfJmO8xZUFjqZjBf8MXOFNUYu/VNVk=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Qi Zheng <qi.zheng@linux.dev>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Harry Yoo <harry@kernel.org>,
	Meta kernel team <kernel-team@meta.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 4/4] memcg: multi objcg charge support
Date: Thu, 21 May 2026 18:19:08 -0700
Message-ID: <20260522011908.1669332-5-shakeel.butt@linux.dev>
In-Reply-To: <20260522011908.1669332-1-shakeel.butt@linux.dev>
References: <20260522011908.1669332-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,ghiti.fr,gmail.com,meta.com,kvack.org,vger.kernel.org,intel.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-16189-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shakeel.butt@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 89E905ADA6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg
per-node type") split a memcg's single obj_cgroup into one per NUMA
node so that reparenting LRU folios can take per-node lru locks. As a
side effect, the per-CPU obj_stock_pcp -- which caches exactly one
cached_objcg -- thrashes on workloads where threads of the same memcg
run on different NUMA nodes. The kernel test robot reported a 67.7%
regression on stress-ng.switch.ops_per_sec from this pattern.

Mirror the multi-slot pattern already used by memcg_stock_pcp: turn
nr_bytes and cached_objcg into NR_OBJ_STOCK-element arrays, scan all
slots on consume/refill/account, prefer empty slots when inserting,
and evict a random slot only when full. With multiple slots a CPU can
hold the per-node objcg variants of one memcg plus a few siblings
without ever forcing a drain.

A single int8_t index records which slot the cached slab stats belong
to; the stats are flushed on slot or pgdat change. With NR_OBJ_STOCK
= 5 the layout (verified with pahole) is:

  offset 0  : lock(1) + index(1) + node_id(2) + slab stats(4) = 8B
  offset 8  : nr_bytes[5]                                     = 10B
  offset 18 : padding                                         = 6B
  offset 24 : cached[5]                                       = 40B
  offset 64 : (line 2) work_struct + flags (cold)

so consume_obj_stock, refill_obj_stock and the slab account path each
touch exactly one 64-byte cache line on non-debug 64-bit builds.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202605121641.b6a60cb0-lkp@intel.com
Fixes: 01b9da291c49 ("mm: memcontrol: convert objcg to be per-memcg per-node type")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Tested-by: kernel test robot <oliver.sang@intel.com>
---

Changes since v1:
- Use round robin for drain

 mm/memcontrol.c | 188 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 136 insertions(+), 52 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 78c02451312b..ba17633b0bd0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -150,14 +150,14 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	 * However, it can be PAGE_SIZE or (x * PAGE_SIZE).
 	 *
 	 * The following sequence can lead to it:
-	 * 1) CPU0: objcg == stock->cached_objcg
+	 * 1) CPU0: objcg cached in one of stock->cached[i]
 	 * 2) CPU1: we do a small allocation (e.g. 92 bytes),
 	 *          PAGE_SIZE bytes are charged
 	 * 3) CPU1: a process from another memcg is allocating something,
 	 *          the stock if flushed,
 	 *          objcg->nr_charged_bytes = PAGE_SIZE - 92
 	 * 5) CPU0: we do release this object,
-	 *          92 bytes are added to stock->nr_bytes
+	 *          92 bytes are added to stock->nr_bytes[i]
 	 * 6) CPU0: stock is flushed,
 	 *          92 bytes are added to objcg->nr_charged_bytes
 	 *
@@ -2017,25 +2017,40 @@ static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
 	.lock = INIT_LOCAL_TRYLOCK(lock),
 };
 
+/*
+ * NR_OBJ_STOCK is sized so the entire hot path of obj_stock_pcp
+ * (lock, accounting metadata, nr_bytes[] and cached[]) fits within a
+ * single 64-byte cache line on non-debug 64-bit builds. With 5 slots:
+ *   lock(1) + index(1) + node_id(2) + slab stats(4) + nr_bytes(10)
+ *   + pad(6) + cached(40) == 64 bytes.
+ * A CPU can thus consume/refill/account against five different objcgs
+ * (typically per-node variants of the same memcg) while incurring at
+ * most one cache miss on the stock.
+ */
+#define NR_OBJ_STOCK 5
 struct obj_stock_pcp {
 	local_trylock_t lock;
-	struct obj_cgroup *cached_objcg;
-	uint16_t nr_bytes;
+	int8_t index;
 	int16_t node_id;
 	int16_t nr_slab_reclaimable_b;
 	int16_t nr_slab_unreclaimable_b;
+	uint16_t nr_bytes[NR_OBJ_STOCK];
+	struct obj_cgroup *cached[NR_OBJ_STOCK];
 
 	struct work_struct work;
 	unsigned long flags;
+	uint8_t drain_idx;
 };
 
 static DEFINE_PER_CPU_ALIGNED(struct obj_stock_pcp, obj_stock) = {
 	.lock = INIT_LOCAL_TRYLOCK(lock),
+	.index = -1,
 	.node_id = NUMA_NO_NODE,
 };
 
 static DEFINE_MUTEX(percpu_charge_mutex);
 
+static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i);
 static void drain_obj_stock(struct obj_stock_pcp *stock);
 static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
@@ -3153,12 +3168,13 @@ static void unlock_stock(struct obj_stock_pcp *stock)
 		local_unlock(&obj_stock.lock);
 }
 
-/* Call after __refill_obj_stock() to ensure stock->cached_objg == objcg */
+/* Call after __refill_obj_stock() so a slot for objcg exists in the stock */
 static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	int16_t *bytes;
+	int i;
 
 	/*
 	 * Though at the moment MAX_NUMNODES <= 1024 in all archs but let's make
@@ -3167,29 +3183,39 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 	 */
 	BUILD_BUG_ON(MAX_NUMNODES >= S16_MAX);
 
-	if (!stock || READ_ONCE(stock->cached_objcg) != objcg)
+	if (!stock)
+		goto direct;
+
+	for (i = 0; i < NR_OBJ_STOCK; ++i) {
+		if (READ_ONCE(stock->cached[i]) == objcg)
+			break;
+	}
+	if (i == NR_OBJ_STOCK)
 		goto direct;
 
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
-	 * accumulating over a page of vmstat data or when pgdat changes.
+	 * accumulating over a page of vmstat data or when the objcg slot or
+	 * pgdat the stats belong to changes.
 	 */
-	if (stock->node_id == NUMA_NO_NODE) {
+	if (stock->index < 0) {
+		stock->index = i;
 		stock->node_id = pgdat->node_id;
-	} else if (stock->node_id != pgdat->node_id) {
-		/* Flush the existing cached vmstat data */
+	} else if (stock->index != i || stock->node_id != pgdat->node_id) {
+		struct obj_cgroup *old = READ_ONCE(stock->cached[stock->index]);
 		struct pglist_data *oldpg = NODE_DATA(stock->node_id);
 
 		if (stock->nr_slab_reclaimable_b) {
-			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
+			mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
+			mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
+		stock->index = i;
 		stock->node_id = pgdat->node_id;
 	}
 
@@ -3230,10 +3256,16 @@ static bool __consume_obj_stock(struct obj_cgroup *objcg,
 				struct obj_stock_pcp *stock,
 				unsigned int nr_bytes)
 {
-	if (objcg == READ_ONCE(stock->cached_objcg) &&
-	    stock->nr_bytes >= nr_bytes) {
-		stock->nr_bytes -= nr_bytes;
-		return true;
+	int i;
+
+	for (i = 0; i < NR_OBJ_STOCK; ++i) {
+		if (READ_ONCE(stock->cached[i]) != objcg)
+			continue;
+		if (stock->nr_bytes[i] >= nr_bytes) {
+			stock->nr_bytes[i] -= nr_bytes;
+			return true;
+		}
+		return false;
 	}
 
 	return false;
@@ -3254,16 +3286,42 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	return ret;
 }
 
-static void drain_obj_stock(struct obj_stock_pcp *stock)
+/* Flush the cached slab stats (if any) back to their owning objcg/pgdat. */
+static void drain_obj_stock_stats(struct obj_stock_pcp *stock)
 {
-	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
+	struct obj_cgroup *old;
+	struct pglist_data *oldpg;
+
+	if (stock->index < 0)
+		return;
+
+	old = READ_ONCE(stock->cached[stock->index]);
+	oldpg = NODE_DATA(stock->node_id);
+
+	if (stock->nr_slab_reclaimable_b) {
+		mod_objcg_mlstate(old, oldpg, NR_SLAB_RECLAIMABLE_B,
+				  stock->nr_slab_reclaimable_b);
+		stock->nr_slab_reclaimable_b = 0;
+	}
+	if (stock->nr_slab_unreclaimable_b) {
+		mod_objcg_mlstate(old, oldpg, NR_SLAB_UNRECLAIMABLE_B,
+				  stock->nr_slab_unreclaimable_b);
+		stock->nr_slab_unreclaimable_b = 0;
+	}
+	stock->index = -1;
+	stock->node_id = NUMA_NO_NODE;
+}
+
+static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
+{
+	struct obj_cgroup *old = READ_ONCE(stock->cached[i]);
 
 	if (!old)
 		return;
 
-	if (stock->nr_bytes) {
-		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
-		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
+	if (stock->nr_bytes[i]) {
+		unsigned int nr_pages = stock->nr_bytes[i] >> PAGE_SHIFT;
+		unsigned int nr_bytes = stock->nr_bytes[i] & (PAGE_SIZE - 1);
 
 		if (nr_pages) {
 			struct mem_cgroup *memcg;
@@ -3289,46 +3347,43 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 		 * so it might be changed in the future.
 		 */
 		atomic_add(nr_bytes, &old->nr_charged_bytes);
-		stock->nr_bytes = 0;
+		stock->nr_bytes[i] = 0;
 	}
 
-	/*
-	 * Flush the vmstat data in current stock
-	 */
-	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
-		struct pglist_data *oldpg = NODE_DATA(stock->node_id);
-
-		if (stock->nr_slab_reclaimable_b) {
-			mod_objcg_mlstate(old, oldpg,
-					  NR_SLAB_RECLAIMABLE_B,
-					  stock->nr_slab_reclaimable_b);
-			stock->nr_slab_reclaimable_b = 0;
-		}
-		if (stock->nr_slab_unreclaimable_b) {
-			mod_objcg_mlstate(old, oldpg,
-					  NR_SLAB_UNRECLAIMABLE_B,
-					  stock->nr_slab_unreclaimable_b);
-			stock->nr_slab_unreclaimable_b = 0;
-		}
-		stock->node_id = NUMA_NO_NODE;
-	}
+	/* Flush vmstat data when its owning slot is being drained. */
+	if (stock->index == i)
+		drain_obj_stock_stats(stock);
 
-	WRITE_ONCE(stock->cached_objcg, NULL);
+	WRITE_ONCE(stock->cached[i], NULL);
 	obj_cgroup_put(old);
 }
 
+static void drain_obj_stock(struct obj_stock_pcp *stock)
+{
+	int i;
+
+	for (i = 0; i < NR_OBJ_STOCK; ++i)
+		drain_obj_stock_slot(stock, i);
+}
+
 static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
 {
-	struct obj_cgroup *objcg = READ_ONCE(stock->cached_objcg);
+	struct obj_cgroup *objcg;
 	struct mem_cgroup *memcg;
 	bool flush = false;
+	int i;
 
 	rcu_read_lock();
-	if (objcg) {
+	for (i = 0; i < NR_OBJ_STOCK; ++i) {
+		objcg = READ_ONCE(stock->cached[i]);
+		if (!objcg)
+			continue;
 		memcg = obj_cgroup_memcg(objcg);
-		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
+		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg)) {
 			flush = true;
+			break;
+		}
 	}
 	rcu_read_unlock();
 
@@ -3342,6 +3397,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 {
 	unsigned int nr_pages = 0;
 	unsigned int stock_nr_bytes;
+	int i, slot = -1, empty_slot = -1;
 
 	if (!stock) {
 		nr_pages = nr_bytes >> PAGE_SHIFT;
@@ -3350,19 +3406,47 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 		goto out;
 	}
 
-	stock_nr_bytes = stock->nr_bytes;
-	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+	for (i = 0; i < NR_OBJ_STOCK; ++i) {
+		struct obj_cgroup *cached = READ_ONCE(stock->cached[i]);
+
+		if (!cached) {
+			if (empty_slot == -1)
+				empty_slot = i;
+			continue;
+		}
+		if (cached == objcg) {
+			slot = i;
+			break;
+		}
+	}
+
+	if (slot == -1) {
+		slot = empty_slot;
+		if (slot == -1) {
+			slot = stock->drain_idx++;
+			if (stock->drain_idx == NR_OBJ_STOCK)
+				stock->drain_idx = 0;
+			drain_obj_stock_slot(stock, slot);
+		}
 		obj_cgroup_get(objcg);
+		/*
+		 * Keep the xchg result in the unsigned int local; storing
+		 * it directly into stock->nr_bytes[slot] (uint16_t) would
+		 * silently truncate values >= U16_MAX and bypass the flush
+		 * guard below, leaking page-counter charges.
+		 */
 		stock_nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
-		WRITE_ONCE(stock->cached_objcg, objcg);
+		WRITE_ONCE(stock->cached[slot], objcg);
 
 		allow_uncharge = true;	/* Allow uncharge when objcg changes */
+	} else {
+		stock_nr_bytes = stock->nr_bytes[slot];
 	}
+
 	stock_nr_bytes += nr_bytes;
 
-	/* Since stock->nr_bytes is uint16_t, don't refill >= U16_MAX */
+	/* nr_bytes[] is uint16_t; flush if we would refill >= U16_MAX. */
 	if ((allow_uncharge && (stock_nr_bytes > PAGE_SIZE)) ||
 	    stock_nr_bytes > U16_MAX) {
 		nr_pages = stock_nr_bytes >> PAGE_SHIFT;
@@ -3384,7 +3468,7 @@ static void __refill_obj_stock(struct obj_cgroup *objcg,
 			stock_nr_bytes = kept;
 		}
 	}
-	stock->nr_bytes = stock_nr_bytes;
+	stock->nr_bytes[slot] = stock_nr_bytes;
 
 out:
 	if (nr_pages)
-- 
2.53.0-Meta


