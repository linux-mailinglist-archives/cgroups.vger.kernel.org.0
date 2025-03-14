Return-Path: <cgroups+bounces-7061-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4336BA6091C
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 796F517FD96
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD95019DFA5;
	Fri, 14 Mar 2025 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mYEbdysE"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1E11632E4
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932959; cv=none; b=QI20+y3eNTBzyee1UHb9eJbZ/V1lBndo97JOwJdY+0OB/GX+rJGQSAOcsjW3YWxw22/XR3cHoZhLpgx6Ootm+5uUZ4ky0B7X9VnD5tMSOLVcODw8aHCSGawd+P6T0wu7yc3UYszrhpiYa+zCDtMlWKZHZTv8IrENrsku5iX4hnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932959; c=relaxed/simple;
	bh=4tRYEgx4s2dGQWYal44m1GqRv+xFVFSmf6A26cqiTaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iaSpUymHiYREUAI2RYgsR07Pl1RXrw4/l05DLlNzDXKBlMcE29QkLcmJJXsxxDLTjR4gOXcrDC5LKduWoUZ0A9PcsO+TZITQBZDTejyJy2AjJWqJsusM/EO2vrlSRl3wTAGXVq4qgVQQN4eXsp6/ZSb7zGLv5b9MRSzAeq7KFE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mYEbdysE; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xw8AvDJaEiUMuHgyRNtkqcMvSjXYO4544yPP6QKBNZE=;
	b=mYEbdysEUSC+zM5Wxo6KARPQbRM+HtLiduFhPb20JvLfYT1Htqt3W955s6pM5F7W/XSXLA
	nSL+qfEuasBoi5U2vDZB22BZQ4/YlY81kfFMHRajmjZlWxx8jAIR113xghAv/rPdhjWTr3
	Z8nwH3ZhCOSHPMA4YlqvUW9uRNC4Hjw=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH 10/10] memcg: no more irq disabling for stock locks
Date: Thu, 13 Mar 2025 23:15:11 -0700
Message-ID: <20250314061511.1308152-11-shakeel.butt@linux.dev>
In-Reply-To: <20250314061511.1308152-1-shakeel.butt@linux.dev>
References: <20250314061511.1308152-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's switch all memcg_stock locks acquire and release places to not
disable and enable irqs. There are two still functions (i.e.
mod_objcg_state() and drain_obj_stock) which needs to disable irqs to
update the stats on non-RT kernels. For now add a simple wrapper for
that functionality.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 83 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ba5d004049d3..fa28efa298f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1796,22 +1796,17 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
  *
  * returns true if successful, false otherwise.
  */
-static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
-			  gfp_t gfp_mask)
+static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned int stock_pages;
-	unsigned long flags;
 	bool ret = false;
 
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
-		if (!gfpflags_allow_spinning(gfp_mask))
+	if (!localtry_trylock(&memcg_stock.stock_lock))
 			return ret;
-		localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
-	}
 
 	stock = this_cpu_ptr(&memcg_stock);
 	stock_pages = READ_ONCE(stock->nr_pages);
@@ -1820,7 +1815,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		ret = true;
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock(&memcg_stock.stock_lock);
 
 	return ret;
 }
@@ -1855,7 +1850,6 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 static void drain_local_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 
 	lockdep_assert_once(in_task());
 
@@ -1864,14 +1858,14 @@ static void drain_local_stock(struct work_struct *dummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
+	localtry_lock(&memcg_stock.stock_lock);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock(&memcg_stock.stock_lock);
 }
 
 /* Should never be called with root_mem_cgroup. */
@@ -1879,9 +1873,8 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	unsigned int stock_pages;
-	unsigned long flags;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	if (!localtry_trylock(&memcg_stock.stock_lock)) {
 		/*
 		 * In case of unlikely failure to lock percpu stock_lock
 		 * uncharge memcg directly.
@@ -1902,7 +1895,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (stock_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock(&memcg_stock.stock_lock);
 }
 
 /*
@@ -1953,17 +1946,12 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 
 	lockdep_assert_once(in_task());
 
 	stock = &per_cpu(memcg_stock, cpu);
 
-	/* drain_obj_stock requires stock_lock */
-	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 	drain_obj_stock(stock);
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-
 	drain_stock(stock);
 
 	return 0;
@@ -2254,7 +2242,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	unsigned long pflags;
 
 retry:
-	if (consume_stock(memcg, nr_pages, gfp_mask))
+	if (consume_stock(memcg, nr_pages))
 		return 0;
 
 	if (!gfpflags_allow_spinning(gfp_mask))
@@ -2757,6 +2745,28 @@ static void replace_stock_objcg(struct memcg_stock_pcp *stock,
 	WRITE_ONCE(stock->cached_objcg, objcg);
 }
 
+static unsigned long rt_lock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+	migrate_disable();
+	return 0;
+#else
+	unsigned long flags = 0;
+
+	local_irq_save(flags);
+	return flags;
+#endif
+}
+
+static void rt_unlock(unsigned long flags)
+{
+#ifdef CONFIG_PREEMPT_RT
+	migrate_enable();
+#else
+	local_irq_restore(flags);
+#endif
+}
+
 static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
@@ -2764,7 +2774,8 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	unsigned long flags;
 	int *bytes;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	if (!localtry_trylock(&memcg_stock.stock_lock)) {
+		/* Do we need mix_rt_[un]lock here too. */
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
 		return;
 	}
@@ -2783,6 +2794,8 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		/* Flush the existing cached vmstat data */
 		struct pglist_data *oldpg = stock->cached_pgdat;
 
+		flags = rt_lock();
+
 		if (stock->nr_slab_reclaimable_b) {
 			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
@@ -2793,6 +2806,8 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
+
+		rt_unlock(flags);
 		stock->cached_pgdat = pgdat;
 	}
 
@@ -2814,19 +2829,21 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 			nr = 0;
 		}
 	}
-	if (nr)
+	if (nr) {
+		flags = rt_lock();
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
+		rt_unlock(flags);
+	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock(&memcg_stock.stock_lock);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 	bool ret = false;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags))
+	if (!localtry_trylock(&memcg_stock.stock_lock))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -2835,7 +2852,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 		ret = true;
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock(&memcg_stock.stock_lock);
 
 	return ret;
 }
@@ -2843,10 +2860,16 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 static void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
+	unsigned long flags;
+	bool locked = stock->nr_bytes || stock->nr_slab_reclaimable_b ||
+		stock->nr_slab_unreclaimable_b;
 
 	if (!old)
 		return;
 
+	if (locked)
+		flags = rt_lock();
+
 	if (stock->nr_bytes) {
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
@@ -2897,6 +2920,9 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
 		stock->cached_pgdat = NULL;
 	}
 
+	if (locked)
+		rt_unlock(flags);
+
 	WRITE_ONCE(stock->cached_objcg, NULL);
 	obj_cgroup_put(old);
 }
@@ -2920,10 +2946,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
+	if (!localtry_trylock(&memcg_stock.stock_lock)) {
 		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
 		return;
 	}
@@ -2940,7 +2965,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	localtry_unlock(&memcg_stock.stock_lock);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.47.1


