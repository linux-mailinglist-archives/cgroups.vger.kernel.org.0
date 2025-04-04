Return-Path: <cgroups+bounces-7357-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B71A7B587
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 03:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F1B179185
	for <lists+cgroups@lfdr.de>; Fri,  4 Apr 2025 01:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21EF717A2FC;
	Fri,  4 Apr 2025 01:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YVIdQTwo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8E137750
	for <cgroups@vger.kernel.org>; Fri,  4 Apr 2025 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743730820; cv=none; b=QE8AB9ro2zxHGVpGfN2B3DMNDF0y/5/5+5byAwUJRb+4mfLPPLPwyBAMGjc1H7kEdwB9F5pktEnbe1Wigh8e4DaVw76DgwQuiHgUFtawUtF8SL7JswA+QGC9DI9+6m18vYLttSD0AJK4gOqtKDrxvMXx5gy8ZqErm7+qLjG2GMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743730820; c=relaxed/simple;
	bh=06gXiVx5lKSFFQekv0CghOGVFlT7QaHEhE3pSVzC+e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUXy0ItC2CZMYJba5ReraMvXgPfy3QuSHOXOpgJXVQ7y/m/zmGFAcuqKGAT8q2c07/wm6+4eogEoyEHyvYATZNeLm9wRPAXBDWsJeXJnnUQ22fh+v2gcdCzz51d1i5hE3ga/EbgNO7XFI9nqaSa8lABRQg+cUOU3JBCQsn5RzjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YVIdQTwo; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743730814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaL+YTe2+GRQTxvSOsA8F0slQZP0gsLtQVxtzdV+oik=;
	b=YVIdQTwo2vNEeKkxMFLZpTiRY9Tw49WcPNXtYb9sRqKpBiDZDA6NoG3Z2N2wJFJSP6T989
	6fGtuqPuZcGBUzJ/81KT5TR2UWOQVfZDwQjl3oesbA1Zu4hGcO/aXcHyoqQ+2nfVWlgWya
	tDhVUf4+urqwi6rscCd66ZwobItacxM=
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
Subject: [PATCH v2 9/9] memcg: manually inline replace_stock_objcg
Date: Thu,  3 Apr 2025 18:39:13 -0700
Message-ID: <20250404013913.1663035-10-shakeel.butt@linux.dev>
In-Reply-To: <20250404013913.1663035-1-shakeel.butt@linux.dev>
References: <20250404013913.1663035-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The replace_stock_objcg() is being called by only refill_obj_stock, so
manually inline it.

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3bb02f672e39..aebb1f2c8657 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2763,17 +2763,6 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 	obj_cgroup_put(objcg);
 }
 
-/* Replace the stock objcg with objcg, return the old objcg */
-static void replace_stock_objcg(struct memcg_stock_pcp *stock,
-				struct obj_cgroup *objcg)
-{
-	drain_obj_stock(stock);
-	obj_cgroup_get(objcg);
-	stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
-			? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
-	WRITE_ONCE(stock->cached_objcg, objcg);
-}
-
 static void __account_obj_stock(struct obj_cgroup *objcg,
 				struct memcg_stock_pcp *stock, int nr,
 				struct pglist_data *pgdat, enum node_stat_item idx)
@@ -2934,7 +2923,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
-		replace_stock_objcg(stock, objcg);
+		drain_obj_stock(stock);
+		obj_cgroup_get(objcg);
+		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
+				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
+		WRITE_ONCE(stock->cached_objcg, objcg);
+
 		allow_uncharge = true;	/* Allow uncharge when objcg changes */
 	}
 	stock->nr_bytes += nr_bytes;
-- 
2.47.1


