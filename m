Return-Path: <cgroups+bounces-7909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7CBAA3BE3
	for <lists+cgroups@lfdr.de>; Wed, 30 Apr 2025 01:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 656791BC1A35
	for <lists+cgroups@lfdr.de>; Tue, 29 Apr 2025 23:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0B22DAF93;
	Tue, 29 Apr 2025 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1yfKabS"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FA2DCB55
	for <cgroups@vger.kernel.org>; Tue, 29 Apr 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745967910; cv=none; b=JqPsj3I2WCGdKCs1xK6k/gXxUHoVjSHsrduE1HGOwbUWKs9p0NXfW/WZb8NwN3AduQbJ8WhjLqej0fgERNzUzHINDhieOGUcCBQXc+RORex7UE6vPwsPWY+zudbmrhvvO/3F/hOYNAq5VeohUA1dd9v4D7gyNUR64IUHUOi8tDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745967910; c=relaxed/simple;
	bh=JWDhGANP8sIe9IFnB6VrxLUfLPvdgV7YcsEbsBbUKig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfbrwC9Jzz9D0Qg2oS7etPwKql1DBfz3j7TujEhJJASMZW3FPJx4WtF0NPLvEQt5AXFbhE4CUnIDa1MxVC28X3X1AL6yI9LI6RJbNWbQ8Z8fvCYeJ0zMbI3DGH64MUYxZNjd7J8Ze1xgqcYno2XBODQpMGGuTG//miW+Q+siM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1yfKabS; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745967903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FedcIVEcoO0k/CPNqGJbnqtLtjq2M33qwVx6Hh8t7k8=;
	b=M1yfKabSFr2l+TzSsPuUKT6AH4jH6rGYGn6f7a0IS6IHgt+4cp2vBTYMlGOYujkMWVUhe1
	d0QNQqffz0e2EEJV3ob/0RNbEnAgB8lDP8rqlGiVnj8T1eMwr5YRlOltwrovUksYVjeOPC
	IbkiPA24ZWMGQNm9pXw9qtTWPGL2T8s=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 2/4] memcg: separate local_trylock for memcg and obj
Date: Tue, 29 Apr 2025 16:04:26 -0700
Message-ID: <20250429230428.1935619-3-shakeel.butt@linux.dev>
In-Reply-To: <20250429230428.1935619-1-shakeel.butt@linux.dev>
References: <20250429230428.1935619-1-shakeel.butt@linux.dev>
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
 mm/memcontrol.c | 52 +++++++++++++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 40d0838d88bc..460634e8435f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1777,13 +1777,14 @@ void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 
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
 
@@ -1792,7 +1793,8 @@ struct memcg_stock_pcp {
 #define FLUSHING_CACHED_CHARGE	0
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
-	.stock_lock = INIT_LOCAL_TRYLOCK(stock_lock),
+	.memcg_lock = INIT_LOCAL_TRYLOCK(memcg_lock),
+	.obj_lock = INIT_LOCAL_TRYLOCK(obj_lock),
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
@@ -1820,7 +1822,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	int i;
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.stock_lock, flags))
+	    !local_trylock_irqsave(&memcg_stock.memcg_lock, flags))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -1837,7 +1839,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		break;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 
 	return ret;
 }
@@ -1883,19 +1885,22 @@ static void drain_local_stock(struct work_struct *dummy)
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
 
+	preempt_disable();
 	stock = this_cpu_ptr(&memcg_stock);
+
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 	drain_obj_stock(stock);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
+
+	local_lock_irqsave(&memcg_stock.memcg_lock, flags);
 	drain_stock_fully(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	preempt_enable();
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
@@ -1918,10 +1923,10 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
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
@@ -1953,7 +1958,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		WRITE_ONCE(stock->nr_pages[i], nr_pages);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.memcg_lock, flags);
 }
 
 static bool is_drain_needed(struct memcg_stock_pcp *stock,
@@ -2028,11 +2033,12 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 
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
@@ -2885,7 +2891,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2896,7 +2902,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
 	return ret;
 }
@@ -2985,7 +2991,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	local_lock_irqsave(&memcg_stock.obj_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -3007,7 +3013,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	local_unlock_irqrestore(&memcg_stock.obj_lock, flags);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.47.1


