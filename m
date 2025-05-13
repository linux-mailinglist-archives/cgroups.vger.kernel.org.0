Return-Path: <cgroups+bounces-8153-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33643AB4A05
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 05:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4703A6616
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 03:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285E345038;
	Tue, 13 May 2025 03:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pDrJPdFU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C701DE3AB;
	Tue, 13 May 2025 03:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106089; cv=none; b=tyDfU4v4jeTkImFvgtvRsqeDiYE+A44TCJulZVAF8V0iVk6l8WrMJr9OEGos9Whkh5yBDabzyPdER2Sp/uC/I6MIdrqhtfKFoCN1che5FDCpj+Z91NJs829rex7DI0IEXBVEr3+2p4VEtQz6kNyvserG7Xccsara2N2tQMl3A+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106089; c=relaxed/simple;
	bh=tzT6JA/r5TkV8JllNM+FoqeHtdq7KrC3AoGh5YFp/kE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChQfOC7YXkOF1XzGLIqO+VnRkQG6gQ/P7JHeELgLGaEpQoij8ib5cvLnA4Mqt1kIe+wDGxAAOV7RG2ASG7QY7BQbrsiyrcdRZi7vRlT7qvtQBXjB+/F+XdZ7PmZ6xMmtOu5uWvRTH8hSnqYNZTNrVDgKQkLaIVwTJ1uxWigax4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pDrJPdFU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fO3n7VreyxXtpgsjbDq9VlopfXabKVT3tylZkZXuQ8Q=;
	b=pDrJPdFUkledZkOpZSrVThmJnwlzIPPtE5A/fYKeqLewpsDPY157dmQoLr7OnQk7QY33XP
	0HqvK4rK8E795Gp0RDxNXi9XpYhIZBQPB7f3h3rPmGJJelyscFEQACOESqw0iAv6FE3nV8
	ZfRjYtHnABfCNVuo8b6DOnvJoM8P6ug=
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
Subject: [RFC PATCH 6/7] memcg: objcg stock trylock without irq disabling
Date: Mon, 12 May 2025 20:13:15 -0700
Message-ID: <20250513031316.2147548-7-shakeel.butt@linux.dev>
In-Reply-To: <20250513031316.2147548-1-shakeel.butt@linux.dev>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
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
need to use trylock instead to keep per-cpu stock safe. One consequence
of this change is that the charge request from irq context may take
slowpath more often but it should be rare.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index adf2f1922118..af7df675d733 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1918,18 +1918,17 @@ static void drain_local_memcg_stock(struct work_struct *dummy)
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
@@ -2062,14 +2061,13 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct obj_stock_pcp *obj_st;
-	unsigned long flags;
 
 	obj_st = &per_cpu(obj_stock, cpu);
 
 	/* drain_obj_stock requires objstock.lock */
-	local_lock_irqsave(&obj_stock.lock, flags);
+	local_lock(&obj_stock.lock);
 	drain_obj_stock(obj_st);
-	local_unlock_irqrestore(&obj_stock.lock, flags);
+	local_unlock(&obj_stock.lock);
 
 	/* no need for the local lock */
 	drain_stock_fully(&per_cpu(memcg_stock, cpu));
@@ -2943,14 +2941,12 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			      struct pglist_data *pgdat, enum node_stat_item idx)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 	bool ret = false;
 
-	if (unlikely(in_nmi()))
+	if (unlikely(in_nmi()) ||
+	    !local_trylock(&obj_stock.lock))
 		return ret;
 
-	local_lock_irqsave(&obj_stock.lock, flags);
-
 	stock = this_cpu_ptr(&obj_stock);
 	if (objcg == READ_ONCE(stock->cached_objcg) && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
@@ -2960,7 +2956,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			__account_obj_stock(objcg, stock, nr_bytes, pgdat, idx);
 	}
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
+	local_unlock(&obj_stock.lock);
 
 	return ret;
 }
@@ -3049,10 +3045,10 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		enum node_stat_item idx)
 {
 	struct obj_stock_pcp *stock;
-	unsigned long flags;
 	unsigned int nr_pages = 0;
 
-	if (unlikely(in_nmi())) {
+	if (unlikely(in_nmi()) ||
+	    !local_trylock(&obj_stock.lock)) {
 		if (pgdat)
 			mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
@@ -3061,8 +3057,6 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		goto out;
 	}
 
-	local_lock_irqsave(&obj_stock.lock, flags);
-
 	stock = this_cpu_ptr(&obj_stock);
 	if (READ_ONCE(stock->cached_objcg) != objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
@@ -3083,7 +3077,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	local_unlock_irqrestore(&obj_stock.lock, flags);
+	local_unlock(&obj_stock.lock);
 out:
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
-- 
2.47.1


