Return-Path: <cgroups+bounces-8046-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF1AAD136
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 00:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 556D64C1567
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 22:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA3421CC4B;
	Tue,  6 May 2025 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pOCPrCgJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A949221CA0A
	for <cgroups@vger.kernel.org>; Tue,  6 May 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572173; cv=none; b=tAG8Wuf/6VNbkISdhFt/1EPSG5SbP6gv66tVIRDzGED3dBBt+SNuyw18wxfESS2Ds9ZGqSjZWhOXhccVGuNg2qHAWD3W5u1EMIWUGwfZjhtW3+8cjiFXKuId9gCAmleifFNKd3NiL9ksXIYvI8/GTUU4f5UgM1FyUAoy71XfdbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572173; c=relaxed/simple;
	bh=83pWq0jTfAa8vmnye1At1OPGGerblj3f2ShBta2CDV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFkPhJTRQM6Ee86Zx7u6l2Ac8SA4v/j1d2CGGggaQe6xKcSVwdDVcg4wy15oueVkXgRFBz3kNSNcFNb/TSlXnXOkBpDlTpyG0YK7MkC4NUBPmvs8ZGuzyUqAk5y7L6r8QXi9scptiu3QsfxSUBWu81huq1BoubG+lH+dYgLkASs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pOCPrCgJ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746572169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJwnznAHDN0760wPcBrSeu9sZjvnIt1jrOT0C+SaQHI=;
	b=pOCPrCgJaQKh/k+UutdxY+ukBOW5kmezdf94Gw0k/V2FqmSBWv8gn+IijNorQLLw53QE4Z
	VEWYFVVxbnAg7pr89eM+l9xNV1zu/RJBRuA02S5FfRCuDHu7eK4LYl9WIIbdI4XFYPbPUs
	pMk1X2lG2Lu2LiS4w50u7iW45MgoKYM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/4] memcg: separate local_trylock for memcg and obj
Date: Tue,  6 May 2025 15:55:31 -0700
Message-ID: <20250506225533.2580386-3-shakeel.butt@linux.dev>
In-Reply-To: <20250506225533.2580386-1-shakeel.butt@linux.dev>
References: <20250506225533.2580386-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The per-cpu stock_lock protects cached memcg and cached objcg and their
respective fields. However there is no dependency between these fields
and it is better to have fine grained separate locks for cached memcg
and cached objcg. This decoupling of locks allows us to make the memcg
charge cache and objcg charge cache to be nmi safe independently.

At the moment, memcg charge cache is already nmi safe and this
decoupling will allow to make memcg charge cache work without disabling
irqs.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 49 ++++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7561e12ca0e0..09a78c606d8d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1781,13 +1781,14 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
  */
 #define NR_MEMCG_STOCK 7
 struct memcg_stock_pcp {
-	local_trylock_t stock_lock;
+	local_trylock_t memcg_lock;
 	uint8_t nr_pages[NR_MEMCG_STOCK];
 	struct mem_cgroup *cached[NR_MEMCG_STOCK];
 
+	local_trylock_t obj_lock;
+	unsigned int nr_bytes;
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
-	unsigned int nr_bytes;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
 
@@ -1796,7 +1797,8 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_TRYLOCK(stock_lock),
+	.memcg_lock = INIT_LOCAL_TRYLOCK(memcg_lock),
+	.obj_lock = INIT_LOCAL_TRYLOCK(obj_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -1824,7 +1826,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	int i;
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))
+	    !local_trylock_irqsave(&memcg_stock.memcg_lock, flags))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -1841,7 +1843,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		break;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 
 	return ret;
 }
@@ -1887,19 +1889,19 @@ static void drain_local_stock(struct work_struct *dummy)
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
 
-	/*
-	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
-	 * drain_stock races is that we always operate on local CPU stock
-	 * here with IRQ disabled
-	 */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	if (WARN_ONCE(!in_task(), "drain in non-task context"))
+		return;
 
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_obj_stock(stock);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
+
+	local_lock_irqsave(&memcg_stock.memcg_lock, flags);
+	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock_fully(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
-
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
@@ -1922,10 +1924,10 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	    !local_trylock_irqsave(&memcg_stock.memcg_lock, flags)) {
 		/*
 		 * In case of larger than batch refill or unlikely failure to
-		 * lock the percpu stock_lock, uncharge memcg directly.
+		 * lock the percpu memcg_lock, uncharge memcg directly.
 		 */
 		memcg_uncharge(memcg, nr_pages);
 		return;
@@ -1957,7 +1959,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		WRITE_ONCE(stock->nr_pages[i], nr_pages);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 }
 
 static bool is_drain_needed(struct memcg_stock_pcp *stock,
@@ -2032,11 +2034,12 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 
 	stock = &per_cpu(memcg_stock, cpu);
 
-	/* drain_obj_stock requires stock_lock */
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	/* drain_obj_stock requires obj_lock */
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 	drain_obj_stock(stock);
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
+	/* no need for the local lock */
 	drain_stock_fully(stock);
 
 	return 0;
@@ -2889,7 +2892,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2900,7 +2903,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
 	return ret;
 }
@@ -2989,7 +2992,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -3011,7 +3014,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.47.1


