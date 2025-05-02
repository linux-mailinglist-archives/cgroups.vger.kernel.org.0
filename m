Return-Path: <cgroups+bounces-7973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EFFAA67C0
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 02:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061A0980BA4
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 00:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255591804A;
	Fri,  2 May 2025 00:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mC6Ra1VA"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B7DDCD
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 00:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145102; cv=none; b=ECI+ThLmNfkleoywoGw6fBTUDqYM8OcT+NqR6TbArmKzPwQEJIvHPECDCORyvoE5NY1CMZIdy8PrGxt/cZJV38foGGsJjEid53XMFDG1m8/t8iKx+MVfzDrzyg9Yzk9l0nTTCKe4U38UO5i5YLNRRu2biQiHUZEVzrnRsL0TZAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145102; c=relaxed/simple;
	bh=axBFpFhOiXoIYChDXClXxaaxXb6A9fs3XaVAI+OcZW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzt01HcepiWwEhxBfNUQcXgq7Nr19AaXlSdtwWOt7Gz3c07m2yugHNB5Q3pExssmHaXLNuRD19fAyu6dSKAS/gnRYwaG7bo9KIqsyzsY42fdkrXZjAcot2KkLHbDfLe9pLnZ/Ud9RMekNEZFPoLLlrFF9/XG4g5pEDmY4TBR3Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mC6Ra1VA; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746145096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qMCF0/XPZ0mCMOvXetG4kCK+cUAsNSQxkyeVg3OMcQ=;
	b=mC6Ra1VAKBnLB+tzb4m/2cVp6+QmusNG1hna35ympuJaNLptLqO3jEpNf35/l+Ij0o/R39
	cy4qX1XPxHiXJIoXJN/5tAfPcTJsXdXBFRTRJSQqfUxBx4p85Oh4tSoB4PJ+qlwGAHGPfJ
	7UhYjtS3uDouwuRfYv3WuLWoZZhQq7k=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 2/3] memcg: completely decouple memcg and obj stocks
Date: Thu,  1 May 2025 17:17:41 -0700
Message-ID: <20250502001742.3087558-3-shakeel.butt@linux.dev>
In-Reply-To: <20250502001742.3087558-1-shakeel.butt@linux.dev>
References: <20250502001742.3087558-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's completely decouple the memcg and obj per-cpu stocks. This will
enable us to make memcg per-cpu stocks to used without disabling irqs.
Also it will enable us to make obj stocks nmi safe independently which
is required to make kmalloc/slab safe for allocations from nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 151 +++++++++++++++++++++++++++++-------------------
 1 file changed, 93 insertions(+), 58 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 14714e1d36e9..cd81c70d144b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1804,13 +1804,23 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
  * The value of NR_MEMCG_STOCK is selected to keep the cached memcgs and their
  * nr_pages in a single cacheline. This may change in future.
  */
+#define FLUSHING_CACHED_CHARGE	0
 #define NR_MEMCG_STOCK 7
 struct memcg_stock_pcp {
-	local_trylock_t memcg_lock;
+	local_trylock_t lock;
 	uint8_t nr_pages[NR_MEMCG_STOCK];
 	struct mem_cgroup *cached[NR_MEMCG_STOCK];
 
-	local_trylock_t obj_lock;
+	struct work_struct work;
+	unsigned long flags;
+};
+
+static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
+	.lock = INIT_LOCAL_TRYLOCK(lock),
+};
+
+struct obj_stock_pcp {
+	local_trylock_t lock;
 	unsigned int nr_bytes;
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
@@ -1819,16 +1829,16 @@ struct memcg_stock_pcp {
 
 	struct work_struct work;
 	unsigned long flags;
-#define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU_ALIGNED(struct memcg_stock_pcp, memcg_stock) = {
-	.memcg_lock = INIT_LOCAL_TRYLOCK(memcg_lock),
-	.obj_lock = INIT_LOCAL_TRYLOCK(obj_lock),
+
+static DEFINE_PER_CPU_ALIGNED(struct obj_stock_pcp, obj_stock) = {
+	.lock = INIT_LOCAL_TRYLOCK(lock),
 };
+
 static DEFINE_MUTEX(percpu_charge_mutex);
 
-static void drain_obj_stock(struct memcg_stock_pcp *stock);
-static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+static void drain_obj_stock(struct obj_stock_pcp *stock);
+static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 /**
@@ -1856,8 +1866,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		return ret;
 
 	if (gfpflags_allow_spinning(gfp_mask))
-		local_lock_irqsave(&memcg_stock.memcg_lock, flags);
-	else if (!local_trylock_irqsave(&memcg_stock.memcg_lock, flags))
+		local_lock_irqsave(&memcg_stock.lock, flags);
+	else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -1874,7 +1884,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		break;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.lock, flags);
 
 	return ret;
 }
@@ -1915,7 +1925,7 @@ static void drain_stock_fully(struct memcg_stock_pcp *stock)
 		drain_stock(stock, i);
 }
 
-static void drain_local_stock(struct work_struct *dummy)
+static void drain_local_memcg_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned long flags;
@@ -1923,16 +1933,30 @@ static void drain_local_stock(struct work_struct *dummy)
 	if (WARN_ONCE(!in_task(), "drain in non-task context"))
 		return;
 
-	local_lock_irqsave(&memcg_stock.obj_lock, flags);
-	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(stock);
-	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
+	local_lock_irqsave(&memcg_stock.lock, flags);
 
-	local_lock_irqsave(&memcg_stock.memcg_lock, flags);
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock_fully(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
-	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
+
+	local_unlock_irqrestore(&memcg_stock.lock, flags);
+}
+
+static void drain_local_obj_stock(struct work_struct *dummy)
+{
+	struct obj_stock_pcp *stock;
+	unsigned long flags;
+
+	if (WARN_ONCE(!in_task(), "drain in non-task context"))
+		return;
+
+	local_lock_irqsave(&obj_stock.lock, flags);
+
+	stock = this_cpu_ptr(&obj_stock);
+	drain_obj_stock(stock);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+
+	local_unlock_irqrestore(&obj_stock.lock, flags);
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
@@ -1955,10 +1979,10 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.memcg_lock, flags)) {
+	    !local_trylock_irqsave(&memcg_stock.lock, flags)) {
 		/*
 		 * In case of larger than batch refill or unlikely failure to
-		 * lock the percpu memcg_lock, uncharge memcg directly.
+		 * lock the percpu memcg_stock.lock, uncharge memcg directly.
 		 */
 		memcg_uncharge(memcg, nr_pages);
 		return;
@@ -1990,23 +2014,17 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		WRITE_ONCE(stock->nr_pages[i], nr_pages);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.lock, flags);
 }
 
-static bool is_drain_needed(struct memcg_stock_pcp *stock,
-			    struct mem_cgroup *root_memcg)
+static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
+				  struct mem_cgroup *root_memcg)
 {
 	struct mem_cgroup *memcg;
 	bool flush = false;
 	int i;
 
 	rcu_read_lock();
-
-	if (obj_stock_flush_required(stock, root_memcg)) {
-		flush = true;
-		goto out;
-	}
-
 	for (i = 0; i < NR_MEMCG_STOCK; ++i) {
 		memcg = READ_ONCE(stock->cached[i]);
 		if (!memcg)
@@ -2018,7 +2036,6 @@ static bool is_drain_needed(struct memcg_stock_pcp *stock,
 			break;
 		}
 	}
-out:
 	rcu_read_unlock();
 	return flush;
 }
@@ -2043,15 +2060,27 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 	migrate_disable();
 	curcpu = smp_processor_id();
 	for_each_online_cpu(cpu) {
-		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
-		bool flush = is_drain_needed(stock, root_memcg);
+		struct memcg_stock_pcp *memcg_st = &per_cpu(memcg_stock, cpu);
+		struct obj_stock_pcp *obj_st = &per_cpu(obj_stock, cpu);
 
-		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
+		if (!test_bit(FLUSHING_CACHED_CHARGE, &memcg_st->flags) &&
+		    is_memcg_drain_needed(memcg_st, root_memcg) &&
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE,
+				      &memcg_st->flags)) {
 			if (cpu == curcpu)
-				drain_local_stock(&stock->work);
+				drain_local_memcg_stock(&memcg_st->work);
 			else if (!cpu_is_isolated(cpu))
-				schedule_work_on(cpu, &stock->work);
+				schedule_work_on(cpu, &memcg_st->work);
+		}
+
+		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
+		    obj_stock_flush_required(obj_st, root_memcg) &&
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE,
+				      &obj_st->flags)) {
+			if (cpu == curcpu)
+				drain_local_obj_stock(&obj_st->work);
+			else if (!cpu_is_isolated(cpu))
+				schedule_work_on(cpu, &obj_st->work);
 		}
 	}
 	migrate_enable();
@@ -2060,18 +2089,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
-	struct memcg_stock_pcp *stock;
+	struct obj_stock_pcp *obj_st;
 	unsigned long flags;
 
-	stock = &per_cpu(memcg_stock, cpu);
+	obj_st = &per_cpu(obj_stock, cpu);
 
-	/* drain_obj_stock requires obj_lock */
-	local_lock_irqsave(&memcg_stock.obj_lock, flags);
-	drain_obj_stock(stock);
-	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
+	/* drain_obj_stock requires objstock.lock */
+	local_lock_irqsave(&obj_stock.lock, flags);
+	drain_obj_stock(obj_st);
+	local_unlock_irqrestore(&obj_stock.lock, flags);
 
 	/* no need for the local lock */
-	drain_stock_fully(stock);
+	drain_stock_fully(&per_cpu(memcg_stock, cpu));
 
 	return 0;
 }
@@ -2868,7 +2897,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 }
 
 static void __account_obj_stock(struct obj_cgroup *objcg,
-				struct memcg_stock_pcp *stock, int nr,
+				struct obj_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	int *bytes;
@@ -2919,13 +2948,13 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			      struct pglist_data *pgdat, enum node_stat_item idx)
 {
-	struct memcg_stock_pcp *stock;
+	struct obj_stock_pcp *stock;
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.obj_lock, flags);
+	local_lock_irqsave(&obj_stock.lock, flags);
 
-	stock = this_cpu_ptr(&memcg_stock);
+	stock = this_cpu_ptr(&obj_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
@@ -2934,12 +2963,12 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
+	local_unlock_irqrestore(&obj_stock.lock, flags);
 
 	return ret;
 }
 
-static void drain_obj_stock(struct memcg_stock_pcp *stock)
+static void drain_obj_stock(struct obj_stock_pcp *stock)
 {
 	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
 
@@ -3000,32 +3029,35 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 	obj_cgroup_put(old);
 }
 
-static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
+static bool obj_stock_flush_required(struct obj_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
 {
 	struct obj_cgroup *objcg = READ_ONCE(stock->cached_objcg);
 	struct mem_cgroup *memcg;
+	bool flush = false;
 
+	rcu_read_lock();
 	if (objcg) {
 		memcg = obj_cgroup_memcg(objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
-			return true;
+			flush = true;
 	}
+	rcu_read_unlock();
 
-	return false;
+	return flush;
 }
 
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		bool allow_uncharge, int nr_acct, struct pglist_data *pgdat,
 		enum node_stat_item idx)
 {
-	struct memcg_stock_pcp *stock;
+	struct obj_stock_pcp *stock;
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.obj_lock, flags);
+	local_lock_irqsave(&obj_stock.lock, flags);
 
-	stock = this_cpu_ptr(&memcg_stock);
+	stock = this_cpu_ptr(&obj_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
@@ -3045,7 +3077,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
+	local_unlock_irqrestore(&obj_stock.lock, flags);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
@@ -5164,9 +5196,12 @@ int __init mem_cgroup_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-			  drain_local_stock);
+			  drain_local_memcg_stock);
+		INIT_WORK(&per_cpu_ptr(&obj_stock, cpu)->work,
+			  drain_local_obj_stock);
+	}
 
 	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
 	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
-- 
2.47.1


