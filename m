Return-Path: <cgroups+bounces-7974-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585AAAA67C4
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 02:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA10D982741
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 00:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29D145948;
	Fri,  2 May 2025 00:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CtAc5AYq"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF97282EB
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746145106; cv=none; b=o6zFnqAGQvpJA5jL4le2SoXNQmxZiCaTXTJ3fFfiGl0vFpLoYRBCHk7r+2eSYBdJvk7Fg8P6MN3eW2RtiIdavsJbrNSjcfZNcxykIaotZmPczY1ne2C3G4IYlcX/tU7wgGjlMqFzmWYO9qz/Gjq/LKGqoII/CrYleXzytOdvlEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746145106; c=relaxed/simple;
	bh=z5u/IWX/OGAeggD4L0wO3Rq2Xm7cLReCVEYdMranAyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRlnzQbSaB4UUMVd05t2Nv9CjvvmocchS49ViYBYH51zzXvWNDWVTIHGPOzoBwpxHR5bwC8/85XSoynvQtsdYNrc+jsZwKEcZp0R5AXhxCiq04UKASQQLJVYj46/XKGhnDF/OoLxYS1k0mbisgzYXSGwoe2qphtDH+c3dLEv0zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CtAc5AYq; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746145102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wjhN3Y6FnUXW1h0Itb0ju6GbNSYKm3lt/+0DxAbkvdQ=;
	b=CtAc5AYqfduFBQiuVXsgHGOTb00ozN+uxz70smBElMiX2eFEL6iBMfE/pLlICt0tNzw5aj
	t49hirx+9ceyMQRTKx97Zs8l7LN63GDQ8tHsQoCSKoli303RDO3x8JkA4pRXjyMjhKUkMG
	GTgt8J8Im7j0Z7bSbaSefV/VtLas5ac=
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
Subject: [PATCH v2 3/3] memcg: no irq disable for memcg stock lock
Date: Thu,  1 May 2025 17:17:42 -0700
Message-ID: <20250502001742.3087558-4-shakeel.butt@linux.dev>
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

There is no need to disable irqs to use memcg per-cpu stock, so let's
just not do that. One consequence of this change is if the kernel while
in task context has the memcg stock lock and that cpu got interrupted.
The memcg charges on that cpu in the irq context will take the slow path
of memcg charging. However that should be super rare and should be fine
in general.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cd81c70d144b..f8b9c7aa6771 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1858,7 +1858,6 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 {
 	struct memcg_stock_pcp *stock;
 	uint8_t stock_pages;
-	unsigned long flags;
 	bool ret = false;
 	int i;
 
@@ -1866,8 +1865,8 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		return ret;
 
 	if (gfpflags_allow_spinning(gfp_mask))
-		local_lock_irqsave(&memcg_stock.lock, flags);
-	else if (!local_trylock_irqsave(&memcg_stock.lock, flags))
+		local_lock(&memcg_stock.lock);
+	else if (!local_trylock(&memcg_stock.lock))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -1884,7 +1883,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 		break;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 
 	return ret;
 }
@@ -1928,18 +1927,17 @@ static void drain_stock_fully(struct memcg_stock_pcp *stock)
 static void drain_local_memcg_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
 
 	if (WARN_ONCE(!in_task(), "drain in non-task context"))
 		return;
 
-	local_lock_irqsave(&memcg_stock.lock, flags);
+	local_lock(&memcg_stock.lock);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	drain_stock_fully(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 }
 
 static void drain_local_obj_stock(struct work_struct *dummy)
@@ -1964,7 +1962,6 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	struct mem_cgroup *cached;
 	uint8_t stock_pages;
-	unsigned long flags;
 	bool success = false;
 	int empty_slot = -1;
 	int i;
@@ -1979,7 +1976,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.lock, flags)) {
+	    !local_trylock(&memcg_stock.lock)) {
 		/*
 		 * In case of larger than batch refill or unlikely failure to
 		 * lock the percpu memcg_stock.lock, uncharge memcg directly.
@@ -2014,7 +2011,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		WRITE_ONCE(stock->nr_pages[i], nr_pages);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 }
 
 static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
-- 
2.47.1


