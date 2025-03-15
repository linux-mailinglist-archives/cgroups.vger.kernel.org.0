Return-Path: <cgroups+bounces-7091-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E419DA63111
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 18:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55FE1899134
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 17:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCA8205AA4;
	Sat, 15 Mar 2025 17:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kZK6wnzZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDE204C18
	for <cgroups@vger.kernel.org>; Sat, 15 Mar 2025 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742061009; cv=none; b=g2cbThEE0vcZ0Ayh+VPFgKu7siJiAW+CF7itaZ4UAm19b0O3tKJOe5Yn3oD81u9Ch5H+DrcmCkLeKn4My2tUoWrvd1VSeiWUlbMvJPWALIo8/PhLf6gNTqK0Yf3NfzcLyd7PFAdrmwwKWoMi1DktAKyWtawFl7QT22ZGRU6G4ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742061009; c=relaxed/simple;
	bh=LloJnKkIR/QdFvsz1WTvP10su9GsOgJ3e0RXRBD9G0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXHV+dJJ9V2R0W3bZo/1aUGCZff9fa2Rdow3fVIAT/lZw4nGIP2yqR7K7YRCRrcEHXNI8jI/aayV5a3/y8e7Hg+nkQouwPzSWmh4c3yXbiBPGZKlyGULLfz3DloX+4L1PlO+gnfYA4F5HIDF9yu3Vg7d23c+bYnH+OWBoMfzmFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kZK6wnzZ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742061003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tHvct7NUO2otKVtcPkikbwH9IxeqmMsC6tyfV+hMsCI=;
	b=kZK6wnzZBdB6KoWZYB2gbmXAmEglH6MpMFhomC5Kcno08qRkhhrz6/f/yhMsfRdCd8x3BY
	ZJHkxF4tenCzo+3OAxNHXlFxu7B6frqfODK2qZdld+O7uCsw0kDPPXntdcw72Ksl54uqxd
	5fjRV2fVuE5qN1Q9kOdIaE6i/nHy4Gc=
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
Subject: [PATCH 6/9] memcg: do obj_cgroup_put inside drain_obj_stock
Date: Sat, 15 Mar 2025 10:49:27 -0700
Message-ID: <20250315174930.1769599-7-shakeel.butt@linux.dev>
In-Reply-To: <20250315174930.1769599-1-shakeel.butt@linux.dev>
References: <20250315174930.1769599-1-shakeel.butt@linux.dev>
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


