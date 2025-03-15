Return-Path: <cgroups+bounces-7087-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC462A63106
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AB516A7EE
	for <lists+cgroups@lfdr.de>; Sat, 15 Mar 2025 17:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0D8205ADA;
	Sat, 15 Mar 2025 17:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EsH21tpo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA2320551A
	for <cgroups@vger.kernel.org>; Sat, 15 Mar 2025 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742060994; cv=none; b=e9Dbbw0fhs8Quach3F12BfvoNkvmNaIhaf3MQDsZ4VncpTXxL+6ZCR4nK0jvl/Lmo8YHHrBW8nbsfxVtlb5N6Q+Nedm/cVQ0T0iCSjYI4SR8ez/BVHCmgvaY+XT7r7LSPJhzvRTcwLitNyvd3QABR8jbrJvY1BhpI4b5e2A+h9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742060994; c=relaxed/simple;
	bh=0ftGgLW4/MlnZh9Fmz7q/GevfyJlJJyM4N09cbLOa4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pHwhpUm581dcXogWSbJOnOyoVAxznye6JEta26gn9O1fEdCkKzuAa8DMQUkhHAnxkfJfqKZnn9QwinD86MDvET/yEO/nS3Z3vcHvxqouiyb/+6lRbtKCH8ZRWEbhIvN4D44GpU0CbAtodxfEmlsSxHpYCRojbSYiHVE/73LBgrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EsH21tpo; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742060990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D9SGS5ZGVTJYUs7bi8rBcO4GG6XSRL+h8cbbja/hnd4=;
	b=EsH21tpoGivxemQBYrsxMd+ru7bHcE8LYPnGChI+hOtYbRl8sO0Czs0Q7Br3PmMb9k9bpa
	gce6M48m5W+CSQy02N7oSlHbmeiv0YDYjFi2vfK6zdqUHBTGYUDd4M1RiDkREBX83mGRH4
	YD4a7IZYjimlw7tBXcpiVnolqcmcIyI=
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
Subject: [PATCH 3/9] memcg: introduce memcg_uncharge
Date: Sat, 15 Mar 2025 10:49:24 -0700
Message-ID: <20250315174930.1769599-4-shakeel.butt@linux.dev>
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

At multiple places in memcontrol.c, the memory and memsw page counters
are being uncharged. This is error-prone. Let's move the functionality
to a newly introduced memcg_uncharge and call it from all those places.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 28cb75b5bc66..b54e3a1d23bd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1816,6 +1816,13 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	return ret;
 }
 
+static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	page_counter_uncharge(&memcg->memory, nr_pages);
+	if (do_memsw_account())
+		page_counter_uncharge(&memcg->memsw, nr_pages);
+}
+
 /*
  * Returns stocks cached in percpu and reset cached information.
  */
@@ -1828,10 +1835,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 		return;
 
 	if (stock_pages) {
-		page_counter_uncharge(&old->memory, stock_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&old->memsw, stock_pages);
-
+		memcg_uncharge(old, stock_pages);
 		WRITE_ONCE(stock->nr_pages, 0);
 	}
 
@@ -1893,9 +1897,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		 * In case of unlikely failure to lock percpu stock_lock
 		 * uncharge memcg directly.
 		 */
-		page_counter_uncharge(&memcg->memory, nr_pages);
-		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 		return;
 	}
 	__refill_stock(memcg, nr_pages);
@@ -2855,12 +2857,8 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
 
 			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
-			if (!mem_cgroup_is_root(memcg)) {
-				page_counter_uncharge(&memcg->memory, nr_pages);
-				if (do_memsw_account())
-					page_counter_uncharge(&memcg->memsw,
-							      nr_pages);
-			}
+			if (!mem_cgroup_is_root(memcg))
+				memcg_uncharge(memcg, nr_pages);
 
 			css_put(&memcg->css);
 		}
@@ -4689,9 +4687,7 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	if (ug->nr_memory) {
-		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
-		if (do_memsw_account())
-			page_counter_uncharge(&ug->memcg->memsw, ug->nr_memory);
+		memcg_uncharge(ug->memcg, ug->nr_memory);
 		if (ug->nr_kmem) {
 			mod_memcg_state(ug->memcg, MEMCG_KMEM, -ug->nr_kmem);
 			memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
-- 
2.47.1


