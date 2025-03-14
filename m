Return-Path: <cgroups+bounces-7057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8ACA60910
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 07:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F2C3BEC1B
	for <lists+cgroups@lfdr.de>; Fri, 14 Mar 2025 06:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7080186E56;
	Fri, 14 Mar 2025 06:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V274faEo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D918C924
	for <cgroups@vger.kernel.org>; Fri, 14 Mar 2025 06:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932948; cv=none; b=E05r3/c7Dc9ZuGw+OUYHT3R/DFKltpztsJzc7qV+D9haN2jSO/hi4RgIv5FuuuvYiB8NRkd/LDvbsAmExcF2F1SqkV5UArcKv0XwH3fXj7pmV/Hxrwg2mGjonSVbjqPiT8xhzCSzkam7liMtlFMerU6S5dLfro4i8udOnH/Dsxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932948; c=relaxed/simple;
	bh=LloJnKkIR/QdFvsz1WTvP10su9GsOgJ3e0RXRBD9G0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tE1LwWZbkfEAqmyJzLo7RdRwrs2yusVGXtRQEiL5PaYXzrk2E2T4oR2ezlOV/QGH1IibTYjVB5Qj36k01M0qMXz1TT78rAjSpf7Nj7PWismyW4/A/cVtiqFHpRlVuYBhaQW6sS5J7Cqr6lkv0Ib0t2ikbpHDH8sGb6vdi4aBDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V274faEo; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741932944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHvct7NUO2otKVtcPkikbwH9IxeqmMsC6tyfV+hMsCI=;
	b=V274faEovU31wH6hmPF8Pl1ql5SCdkECGFNsM9aIg8fqkshlyZQjJkHlOiibZ5eK8EBIaF
	mzT2xavCrHmwrG2e71ysA2lRB0K2dCx5x92LDIJjzGPXTyyBhrFDUktB4v80nkwy47GVhp
	OIu/u1LFsSewxNzC4GuEWlmMp1zITI8=
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
Subject: [RFC PATCH 06/10] memcg: do obj_cgroup_put inside drain_obj_stock
Date: Thu, 13 Mar 2025 23:15:07 -0700
Message-ID: <20250314061511.1308152-7-shakeel.butt@linux.dev>
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

Previously we could not call obj_cgroup_put() inside the local lock
because on the put on the last reference, the release function
obj_cgroup_release() may try to re-acquire the local lock. However that
chain has been broken. Now simply do obj_cgroup_put() inside
drain_obj_stock() instead of returning the old objcg.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 83db180455a1..3c4de384b5a0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1778,7 +1778,7 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
 };
 static DEFINE_MUTEX(percpu_charge_mutex);
 
-static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
+static void drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
@@ -1853,7 +1853,6 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 static void drain_local_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
-	struct obj_cgroup *old = NULL;
 	unsigned long flags;
 
 	/*
@@ -1864,12 +1863,11 @@ static void drain_local_stock(struct work_struct *dummy)
 	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
-	old = drain_obj_stock(stock);
+	drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
 	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-	obj_cgroup_put(old);
 }
 
 /* Should never be called with root_mem_cgroup. */
@@ -1951,18 +1949,16 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
-	struct obj_cgroup *old;
 	unsigned long flags;
 
 	stock = &per_cpu(memcg_stock, cpu);
 
 	/* drain_obj_stock requires stock_lock */
 	localtry_lock_irqsave(&memcg_stock.stock_lock, flags);
-	old = drain_obj_stock(stock);
+	drain_obj_stock(stock);
 	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	drain_stock(stock);
-	obj_cgroup_put(old);
 
 	return 0;
 }
@@ -2745,24 +2741,20 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 }
 
 /* Replace the stock objcg with objcg, return the old objcg */
-static struct obj_cgroup *replace_stock_objcg(struct memcg_stock_pcp *stock,
-					     struct obj_cgroup *objcg)
+static void replace_stock_objcg(struct memcg_stock_pcp *stock,
+				struct obj_cgroup *objcg)
 {
-	struct obj_cgroup *old = NULL;
-
-	old = drain_obj_stock(stock);
+	drain_obj_stock(stock);
 	obj_cgroup_get(objcg);
 	stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 			? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
 	WRITE_ONCE(stock->cached_objcg, objcg);
-	return old;
 }
 
 static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
 	struct memcg_stock_pcp *stock;
-	struct obj_cgroup *old = NULL;
 	unsigned long flags;
 	int *bytes;
 
@@ -2775,7 +2767,7 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	 * changes.
 	 */
 	if (READ_ONCE(stock->cached_objcg) != objcg) {
-		old = replace_stock_objcg(stock, objcg);
+		replace_stock_objcg(stock, objcg);
 		stock->cached_pgdat = pgdat;
 	} else if (stock->cached_pgdat != pgdat) {
 		/* Flush the existing cached vmstat data */
@@ -2816,7 +2808,6 @@ static void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
 	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-	obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
@@ -2838,12 +2829,12 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 	return ret;
 }
 
-static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
+static void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old = READ_ONCE(stock->cached_objcg);
 
 	if (!old)
-		return NULL;
+		return;
 
 	if (stock->nr_bytes) {
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
@@ -2896,11 +2887,7 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 	}
 
 	WRITE_ONCE(stock->cached_objcg, NULL);
-	/*
-	 * The `old' objects needs to be released by the caller via
-	 * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
-	 */
-	return old;
+	obj_cgroup_put(old);
 }
 
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -2922,7 +2909,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
 	struct memcg_stock_pcp *stock;
-	struct obj_cgroup *old = NULL;
 	unsigned long flags;
 	unsigned int nr_pages = 0;
 
@@ -2930,7 +2916,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
-		old = replace_stock_objcg(stock, objcg);
+		replace_stock_objcg(stock, objcg);
 		allow_uncharge = true;	/* Allow uncharge when objcg changes */
 	}
 	stock->nr_bytes += nr_bytes;
@@ -2941,7 +2927,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 	}
 
 	localtry_unlock_irqrestore(&memcg_stock.stock_lock, flags);
-	obj_cgroup_put(old);
 
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.47.1


