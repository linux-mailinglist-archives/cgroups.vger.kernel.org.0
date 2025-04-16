Return-Path: <cgroups+bounces-7599-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACF1A90ABE
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 20:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B56AB3AA521
	for <lists+cgroups@lfdr.de>; Wed, 16 Apr 2025 18:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BCB204598;
	Wed, 16 Apr 2025 18:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bZLxmOyZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1C218AB9
	for <cgroups@vger.kernel.org>; Wed, 16 Apr 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744826583; cv=none; b=pE5zu0nlBAd+LgSpJMCcml2q6+4b7F2ID1jzMccPuYiR4QHGi1W+vXbewNQKjMIot/nRhwBKVJ+/+19zD3u53Mmb5IKjP435W14KtRCKYT//1TIGS0QIKaqft3nu7QClnBcOk79tOcrBfNOVxSmGhACNUY1bsFBMho6XRnh0DVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744826583; c=relaxed/simple;
	bh=VbyjV1xV3keb5zHv6u5VS//P+QDhOb2P56UX/HT/MQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i67+MRuhSxDOxuidAL55Ftpp6kKHxFYSoIeVCmMZL6xUDbPXNzMIilSqCNtyPQqsT2avY/kII0iZuy2l2Xwom+O6YGBfZHq8TGqFhc4eSTaatf5OrYlwqKzmZGacYzpeVzOZ/cJChXhX42bVV5idNg/5vXEhwFkr9kmJuWA+w+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bZLxmOyZ; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744826568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=N0wICEPxoKXEmipCZYFaxtgePit0HW271+fFL4AOW2o=;
	b=bZLxmOyZSqJIgeH3b8E/IhKnLdC5mDVuFbevye1u2CDLkg4g8giv0pPSr3rix5NVguurWY
	++44wvKJt2GnLxbqKR0RFVhr3B/F8xJoFTWYCIRdighAPedcQfvfIuy/wlBu8S2bmXe+sY
	NCjFH85QUZAtGGci4kR+Mi1fw+cGBng=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Soheil Hassas Yeganeh <soheil@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: multi-memcg percpu charge cache
Date: Wed, 16 Apr 2025 11:02:29 -0700
Message-ID: <20250416180229.2902751-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memory cgroup accounting is expensive and to reduce the cost, the kernel
maintains per-cpu charge cache for a single memcg. So, if a charge
request comes for a different memcg, the kernel will flush the old
memcg's charge cache and then charge the newer memcg a fixed amount (64
pages), subtracts the charge request amount and stores the remaining in
the per-cpu charge cache for the newer memcg.

This mechanism is based on the assumption that the kernel, for locality,
keep a process on a CPU for long period of time and most of the charge
requests from that process will be served by that CPU's local charge
cache.

However this assumption breaks down for incoming network traffic in a
multi-tenant machine. We are in the process of running multiple
workloads on a single machine and if such workloads are network heavy,
we are seeing very high network memory accounting cost. We have observed
multiple CPUs spending almost 100% of their time in net_rx_action and
almost all of that time is spent in memcg accounting of the network
traffic.

More precisely, net_rx_action is serving packets from multiple workloads
and is observing/serving mix of packets of these workloads. The memcg
switch of per-cpu cache is very expensive and we are observing a lot of
memcg switches on the machine. Almost all the time is being spent on
charging new memcg and flushing older memcg cache. So, definitely we
need per-cpu cache that support multiple memcgs for this scenario.

This patch implements a simple (and dumb) multiple memcg percpu charge
cache. Actually we started with more sophisticated LRU based approach but
the dumb one was always better than the sophisticated one by 1% to 3%,
so going with the simple approach.

Some of the design choices are:

1. Fit all caches memcgs in a single cacheline.
2. The cache array can be mix of empty slots or memcg charged slots, so
   the kernel has to traverse the full array.
3. The cache drain from the reclaim will drain all cached memcgs to keep
   things simple.

To evaluate the impact of this optimization, on a 72 CPUs machine, we
ran the following workload where each netperf client runs in a different
cgroup. The next-20250415 kernel is used as base.

 $ netserver -6
 $ netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

number of clients | Without patch | With patch
  6               | 42584.1 Mbps  | 48603.4 Mbps (14.13% improvement)
  12              | 30617.1 Mbps  | 47919.7 Mbps (56.51% improvement)
  18              | 25305.2 Mbps  | 45497.3 Mbps (79.79% improvement)
  24              | 20104.1 Mbps  | 37907.7 Mbps (88.55% improvement)
  30              | 14702.4 Mbps  | 30746.5 Mbps (109.12% improvement)
  36              | 10801.5 Mbps  | 26476.3 Mbps (145.11% improvement)

The results show drastic improvement for network intensive workloads.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 128 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 91 insertions(+), 37 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1ad326e871c1..0a02ba07561e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1769,10 +1769,11 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 	pr_cont(" are going to be killed due to memory.oom.group set\n");
 }
 
+#define NR_MEMCG_STOCK 7
 struct memcg_stock_pcp {
 	local_trylock_t stock_lock;
-	struct mem_cgroup *cached; /* this never be root cgroup */
-	unsigned int nr_pages;
+	uint8_t nr_pages[NR_MEMCG_STOCK];
+	struct mem_cgroup *cached[NR_MEMCG_STOCK];
 
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
@@ -1809,9 +1810,10 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 			  gfp_t gfp_mask)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned int stock_pages;
+	uint8_t stock_pages;
 	unsigned long flags;
 	bool ret = false;
+	int i;
 
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
@@ -1822,10 +1824,17 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
-	stock_pages = READ_ONCE(stock->nr_pages);
-	if (memcg == READ_ONCE(stock->cached) && stock_pages >= nr_pages) {
-		WRITE_ONCE(stock->nr_pages, stock_pages - nr_pages);
-		ret = true;
+
+	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
+		if (memcg != READ_ONCE(stock->cached[i]))
+			continue;
+
+		stock_pages = READ_ONCE(stock->nr_pages[i]);
+		if (stock_pages >= nr_pages) {
+			WRITE_ONCE(stock->nr_pages[i], stock_pages - nr_pages);
+			ret = true;
+		}
+		break;
 	}
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
@@ -1843,21 +1852,30 @@ static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
 /*
  * Returns stocks cached in percpu and reset cached information.
  */
-static void drain_stock(struct memcg_stock_pcp *stock)
+static void drain_stock(struct memcg_stock_pcp *stock, int i)
 {
-	unsigned int stock_pages = READ_ONCE(stock->nr_pages);
-	struct mem_cgroup *old = READ_ONCE(stock->cached);
+	struct mem_cgroup *old = READ_ONCE(stock->cached[i]);
+	uint8_t stock_pages;
 
 	if (!old)
 		return;
 
+	stock_pages = READ_ONCE(stock->nr_pages[i]);
 	if (stock_pages) {
 		memcg_uncharge(old, stock_pages);
-		WRITE_ONCE(stock->nr_pages, 0);
+		WRITE_ONCE(stock->nr_pages[i], 0);
 	}
 
 	css_put(&old->css);
-	WRITE_ONCE(stock->cached, NULL);
+	WRITE_ONCE(stock->cached[i], NULL);
+}
+
+static void drain_stock_fully(struct memcg_stock_pcp *stock)
+{
+	int i;
+
+	for (i = 0; i < NR_MEMCG_STOCK; ++i)
+		drain_stock(stock, i);
 }
 
 static void drain_local_stock(struct work_struct *dummy)
@@ -1874,7 +1892,7 @@ static void drain_local_stock(struct work_struct *dummy)
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_obj_stock(stock);
-	drain_stock(stock);
+	drain_stock_fully(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
@@ -1883,35 +1901,81 @@ static void drain_local_stock(struct work_struct *dummy)
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned int stock_pages;
+	struct mem_cgroup *cached;
+	uint8_t stock_pages;
 	unsigned long flags;
+	bool evict = true;
+	int i;
 
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
-	if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	if (nr_pages > MEMCG_CHARGE_BATCH ||
+	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
 		/*
-		 * In case of unlikely failure to lock percpu stock_lock
-		 * uncharge memcg directly.
+		 * In case of larger than batch refill or unlikely failure to
+		 * lock the percpu stock_lock, uncharge memcg directly.
 		 */
 		memcg_uncharge(memcg, nr_pages);
 		return;
 	}
 
 	stock = this_cpu_ptr(&memcg_stock);
-	if (READ_ONCE(stock->cached) != memcg) { /* reset if necessary */
-		drain_stock(stock);
-		css_get(&memcg->css);
-		WRITE_ONCE(stock->cached, memcg);
+	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
+again:
+		cached = READ_ONCE(stock->cached[i]);
+		if (!cached) {
+			css_get(&memcg->css);
+			WRITE_ONCE(stock->cached[i], memcg);
+		}
+		if (!cached || memcg == READ_ONCE(stock->cached[i])) {
+			stock_pages = READ_ONCE(stock->nr_pages[i]) + nr_pages;
+			WRITE_ONCE(stock->nr_pages[i], stock_pages);
+			if (stock_pages > MEMCG_CHARGE_BATCH)
+				drain_stock(stock, i);
+			evict = false;
+			break;
+		}
 	}
-	stock_pages = READ_ONCE(stock->nr_pages) + nr_pages;
-	WRITE_ONCE(stock->nr_pages, stock_pages);
 
-	if (stock_pages > MEMCG_CHARGE_BATCH)
-		drain_stock(stock);
+	if (evict) {
+		i = get_random_u32_below(NR_MEMCG_STOCK);
+		drain_stock(stock, i);
+		goto again;
+	}
 
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
 
+static bool is_drain_needed(struct memcg_stock_pcp *stock,
+			    struct mem_cgroup *root_memcg)
+{
+	struct mem_cgroup *memcg;
+	bool flush = false;
+	int i;
+
+	rcu_read_lock();
+
+	if (obj_stock_flush_required(stock, root_memcg)) {
+		flush = true;
+		goto out;
+	}
+
+	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
+		memcg = READ_ONCE(stock->cached[i]);
+		if (!memcg)
+			continue;
+
+		if (READ_ONCE(stock->nr_pages[i]) &&
+		    mem_cgroup_is_descendant(memcg, root_memcg)) {
+			flush = true;
+			break;
+		}
+	}
+out:
+	rcu_read_unlock();
+	return flush;
+}
+
 /*
  * Drains all per-CPU charge caches for given root_memcg resp. subtree
  * of the hierarchy under it.
@@ -1933,17 +1997,7 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 	curcpu = smp_processor_id();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
-		struct mem_cgroup *memcg;
-		bool flush = false;
-
-		rcu_read_lock();
-		memcg = READ_ONCE(stock->cached);
-		if (memcg && READ_ONCE(stock->nr_pages) &&
-		    mem_cgroup_is_descendant(memcg, root_memcg))
-			flush = true;
-		else if (obj_stock_flush_required(stock, root_memcg))
-			flush = true;
-		rcu_read_unlock();
+		bool flush = is_drain_needed(stock, root_memcg);
 
 		if (flush &&
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
@@ -1969,7 +2023,7 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 	drain_obj_stock(stock);
 	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
-	drain_stock(stock);
+	drain_stock_fully(stock);
 
 	return 0;
 }
-- 
2.47.1


