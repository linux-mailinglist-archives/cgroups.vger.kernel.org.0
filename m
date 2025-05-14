Return-Path: <cgroups+bounces-8195-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C326AB74A3
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 20:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBF5C7A2368
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 18:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9184928C2B5;
	Wed, 14 May 2025 18:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AeGHYahc"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD381288504;
	Wed, 14 May 2025 18:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248170; cv=none; b=WR+ZqGXo9b9w3zAdeDhGWm64C2znaFPp2arht8BrBz0zr8m84LenqUhmbrG364ZJAj0SeYL7b0J2m8ssTaog4GIl4T06vt+ZRPRjz7vKzSD7McUcYV1YJnsIMk0M78Tujym/eHNTLucD3Ykh58PpTis9WD35cBc36Hh4EYgbLZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248170; c=relaxed/simple;
	bh=mTNNAhXxTmuKIpiWZywIQ/5hY9vcPCNEi5pwe+i0vF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8+we3yalAd4uTMrJYCRqlzviDuq8zshfK2sSophmw9SVEA6xuu4KMc/0J5ll680fMNWsIaZcwN/Lrf7j1Yt8tGfQElVDIfuLEtUomth0S8fLqoaUmufJIvluGvp9wc3H7JyCXQ9q6eLZWIEg5VMjz+QC2U+LaDRJeia8wDqfiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AeGHYahc; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747248156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0hq3oSPGOoYcep4MVQZiDjVHKcY+KXmN8QcGYtIe92g=;
	b=AeGHYahcQD4nY/SaOCUvLSzBipLtoKpoNJa3KmuL+Uo+M+Zi3uVoBSjGWm8N3I8w3dhhLm
	pVJt8eREwCiR9EwSHIxX2Se2gB4i3bxdgu7u+wT0Uk9+iso2cJpcHXF8fWaulJAe1jO0Ft
	CFTHhmUOmtjMi82XHcOkaTc1OZslUCs=
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
Subject: [PATCH v2 3/7] memcg: make mod_memcg_state re-entrant safe against irqs
Date: Wed, 14 May 2025 11:41:54 -0700
Message-ID: <20250514184158.3471331-4-shakeel.butt@linux.dev>
In-Reply-To: <20250514184158.3471331-1-shakeel.butt@linux.dev>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's make mod_memcg_state re-entrant safe against irqs. The only thing
needed is to convert the usage of __this_cpu_add() to this_cpu_add().
In addition, with re-entrant safety, there is no need to disable irqs.

mod_memcg_state() is not safe against nmi, so let's add warning if
someone tries to call it in nmi context.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 20 ++------------------
 mm/memcontrol.c            |  8 ++++----
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9ed75f82b858..92861ff3c43f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -903,19 +903,9 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
-void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
-		       int val);
-
 /* idx can be of type enum memcg_stat_item or node_stat_item */
-static inline void mod_memcg_state(struct mem_cgroup *memcg,
-				   enum memcg_stat_item idx, int val)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	__mod_memcg_state(memcg, idx, val);
-	local_irq_restore(flags);
-}
+void mod_memcg_state(struct mem_cgroup *memcg,
+		     enum memcg_stat_item idx, int val);
 
 static inline void mod_memcg_page_state(struct page *page,
 					enum memcg_stat_item idx, int val)
@@ -1375,12 +1365,6 @@ static inline void mem_cgroup_print_oom_group(struct mem_cgroup *memcg)
 {
 }
 
-static inline void __mod_memcg_state(struct mem_cgroup *memcg,
-				     enum memcg_stat_item idx,
-				     int nr)
-{
-}
-
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
 				   enum memcg_stat_item idx,
 				   int nr)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1750d86012f3..c5a835071610 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -681,12 +681,12 @@ static int memcg_state_val_in_pages(int idx, int val)
 }
 
 /**
- * __mod_memcg_state - update cgroup memory statistics
+ * mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
  * @idx: the stat item - can be enum memcg_stat_item or enum node_stat_item
  * @val: delta to add to the counter, can be negative
  */
-void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
+void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		       int val)
 {
 	int i = memcg_stats_index(idx);
@@ -700,7 +700,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 
 	cpu = get_cpu();
 
-	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
+	this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val, cpu);
 	trace_mod_memcg_state(memcg, idx, val);
@@ -2920,7 +2920,7 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 
 			memcg = get_mem_cgroup_from_objcg(old);
 
-			__mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
 			if (!mem_cgroup_is_root(memcg))
 				memcg_uncharge(memcg, nr_pages);
-- 
2.47.1


