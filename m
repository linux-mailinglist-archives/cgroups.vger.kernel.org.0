Return-Path: <cgroups+bounces-8183-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98BAB620C
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 07:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385FC19E79B4
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 05:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E671F5437;
	Wed, 14 May 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BB6zKS6f"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E4A1F4CBD
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199350; cv=none; b=pOQUgd/L4I1PNlteKID0GQllzb1aXOYzhe6/kIjkkPCn3PARaNaFYQqJeuOKJs5tE0XJDQ0DBoTustl3KiygdLKz7z9F+vd6OYlPKkfNV2Xr39h1gxTpdoEMqcV+LJ0h/QTJPdiw20n3wTXvp66Hl+eqRAZq+6m+s1C6j9nn1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199350; c=relaxed/simple;
	bh=cMXg1Zoafpf6T/Bl4D/YqFLGcqsmHolvDIggz69J7Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtTtDQOnt/fwUEm3l3qTp0M5VjaYpXgcwAtcB5ROWNnln/vVSAhgzQ3MIIbHcF9VMJJnL7L8V5ONNkkKfTl/IkKwFVwAS4G2A89G3wuqpSa2bFVUhEE0zWNF3RvAKUlKySavJlCqp0N8aQkddc66WMpQAgw2ZAleFPEvRxlX2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BB6zKS6f; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747199346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NuiqYU5xQUJzlD4OF0DY6DzP++awncv0NldqTEFbrbk=;
	b=BB6zKS6fZt3IpK/PR2CCdNoGUYOkfDyeW0jJMjAtx0JRxkzb3wR1CwWeIyeUXF6F8CVPyQ
	RIxNVBrlQPoCKw9bPu6nsPBuDBXncIYIHIJ/NBJu2AQ/6VwHqfxddK4NDXmwlv6OuYPqAu
	3X6ncWadCJ7SIUgeaoUy8vmHHxLLaVg=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 7/7] memcg: objcg stock trylock without irq disabling
Date: Tue, 13 May 2025 22:08:13 -0700
Message-ID: <20250514050813.2526843-8-shakeel.butt@linux.dev>
In-Reply-To: <20250514050813.2526843-1-shakeel.butt@linux.dev>
References: <20250514050813.2526843-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There is no need to disable irqs to use objcg per-cpu stock, so let's
just not do that but consume_obj_stock() and refill_obj_stock() will
need to use trylock instead to avoid deadlock against irq. One
consequence of this change is that the charge request from irq context
may take slowpath more often but it should be rare.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 78a41378b8f3..73b19137901a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1907,18 +1907,17 @@ static void drain_local_memcg_stock(struct work_struct *dummy)
 static void drain_local_obj_stock(struct work_struct *dummy)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 
 	if (WARN_ONCE(!in_task(), "drain in non-task context"))
 		return;
 
-	local_lock_irqsave(&obj_stock.lock, flags);
+	local_lock(&obj_stock.lock);
 
 	stock = this_cpu_ptr(&obj_stock);
 	drain_obj_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
+	local_unlock(&obj_stock.lock);
 }
 
 static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
@@ -2901,10 +2900,10 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			      struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 	bool ret = false;
 
-	local_lock_irqsave(&obj_stock.lock, flags);
+	if (!local_trylock(&obj_stock.lock))
+		return ret;
 
 	stock = this_cpu_ptr(&obj_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
@@ -2915,7 +2914,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
+	local_unlock(&obj_stock.lock);
 
 	return ret;
 }
@@ -3004,10 +3003,16 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		enum node_stat_item idx)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	local_lock_irqsave(&obj_stock.lock, flags);
+	if (!local_trylock(&obj_stock.lock)) {
+		if (pgdat)
+			mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
+		nr_pages = nr_bytes >> PAGE_SHIFT;
+		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
+		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
+		goto out;
+	}
 
 	stock = this_cpu_ptr(&obj_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
@@ -3029,8 +3034,8 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
-
+	local_unlock(&obj_stock.lock);
+out:
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
 }
-- 
2.47.1


