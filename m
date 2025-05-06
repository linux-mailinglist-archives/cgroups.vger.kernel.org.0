Return-Path: <cgroups+bounces-8048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 115CFAAD142
	for <lists+cgroups@lfdr.de>; Wed,  7 May 2025 00:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A7077AA48F
	for <lists+cgroups@lfdr.de>; Tue,  6 May 2025 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F78220F22;
	Tue,  6 May 2025 22:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgIDG1Zl"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3C19CC0A;
	Tue,  6 May 2025 22:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746572195; cv=none; b=PPDHOlqjQGNq33IPiNy6MDVIjroEGE9wWJhrJgYS0I85+ZFVgGAxtwWqwQTgFqeYVtfnFMNGL7ljhM4Lk+Do2IniOMAYFNs3wPxriWJluve8NhqiAXgXkYZec2KxptHnBy4C085PA//extWYDZOrryhkDxRPws1z8qcwXxBxdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746572195; c=relaxed/simple;
	bh=ymPetmztVj4ZKjM6qJYBSDvFukJw9xzz9yDALJZYHR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qycVqFWKgQbjk1jxR/dPxJFifd4AR2pzoebZ1U+n/CHJsxMXj0Uc4m6oO9rRS7EEjsOP9gssibNx/RtXhOjuo5//Q5Au3UHsakfh75sahLjus0tZqjQowenkmM3Y9vnPEb6bAeZRr2OS+JhW2/ov+g9IXgnMEIOOmiVR5y8eDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgIDG1Zl; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746572191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b6zqPxMuKls1ect+i80Pr9eZUaXtWgeMitGJN3FhUCk=;
	b=vgIDG1ZlTQv/1d/jlb+cn/ieWHsMOlwaJYb2IvRtXROBKliLUIk/PmHWQGOE0aQyWOpx22
	G8jKSDouRdjGNE3VSVNFoLCBvqINHyKEIQ6+6g3UtCuv8JKI1qZDJ/PS97t1+UxdUGIILx
	dVimCd9GGwGHBzv7pvmCpcr75ds2Y+k=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 4/4] memcg: no irq disable for memcg stock lock
Date: Tue,  6 May 2025 15:55:33 -0700
Message-ID: <20250506225533.2580386-5-shakeel.butt@linux.dev>
In-Reply-To: <20250506225533.2580386-1-shakeel.butt@linux.dev>
References: <20250506225533.2580386-1-shakeel.butt@linux.dev>
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
 mm/memcontrol.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 14d73e5352fe..5ac3c8cc1ac5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1831,12 +1831,11 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	struct memcg_stock_pcp *stock;
 	uint8_t stock_pages;
-	unsigned long flags;
 	bool ret = false;
 	int i;
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.lock, flags))
+	    !local_trylock(&memcg_stock.lock))
 		return ret;
 
 	stock = this_cpu_ptr(&memcg_stock);
@@ -1853,7 +1852,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		break;
 	}
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 
 	return ret;
 }
@@ -1897,18 +1896,17 @@ static void drain_stock_fully(struct memcg_stock_pcp *stock)
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
@@ -1933,7 +1931,6 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	struct memcg_stock_pcp *stock;
 	struct mem_cgroup *cached;
 	uint8_t stock_pages;
-	unsigned long flags;
 	bool success = false;
 	int empty_slot = -1;
 	int i;
@@ -1948,7 +1945,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	VM_WARN_ON_ONCE(mem_cgroup_is_root(memcg));
 
 	if (nr_pages > MEMCG_CHARGE_BATCH ||
-	    !local_trylock_irqsave(&memcg_stock.lock, flags)) {
+	    !local_trylock(&memcg_stock.lock)) {
 		/*
 		 * In case of larger than batch refill or unlikely failure to
 		 * lock the percpu memcg_stock.lock, uncharge memcg directly.
@@ -1983,7 +1980,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		WRITE_ONCE(stock->nr_pages[i], nr_pages);
 	}
 
-	local_unlock_irqrestore(&memcg_stock.lock, flags);
+	local_unlock(&memcg_stock.lock);
 }
 
 static bool is_memcg_drain_needed(struct memcg_stock_pcp *stock,
-- 
2.47.1


