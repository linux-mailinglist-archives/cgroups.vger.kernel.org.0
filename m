Return-Path: <cgroups+bounces-8152-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2A9AB4A04
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 05:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EF18C56D3
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 03:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC131E411C;
	Tue, 13 May 2025 03:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nMEpv0pa"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFDE1E3DD0
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 03:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106061; cv=none; b=jKuebzxELl0RPFGsK2kc4wro8roHq4eb1aD5+Kl7JQ0DfJlp/fGlAOLOc79BmEW+F3IngR4Jd5LrrNzmxi1xuUuofE4CUjAxDtqsf0ipeqsRCqxQnCmwzY0CRrpTPdch9iN+fqilfa2OBqAp78Xg126L0LLmUPIxBF/Z2N/kA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106061; c=relaxed/simple;
	bh=7sONA/V33xpobgeSmyIE5zKaplWdxKZgqzaN0mo3UjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGfz5lOV7XmHRE9t3e9YTiDsoLAaiy/pIbMF9sEpFU53VoaYfTGAMS2NzB5yg9gKDrS5vM/kz4OvMr2k/g3X6Z1eS9a5UgKBHEIajxHrlM8m/eEWdeZEnUdY/Dj+sREij1JrgtFhUJ9ZB3tc/+R167XqBlhS+bAkD4J4wOC70Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nMEpv0pa; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AODqjUq8YBPAVfDEVDBp4w1/avIi3o3A3GYYWWucdOg=;
	b=nMEpv0paVndzE8CayYRfrJko55+hok+VSNUS4tnLfpg19zLqu/PvnMnIxqCvJWjK48L3bJ
	pgdw7Iur+sFTvXj2v9Wm4AgeQIsJIFY5CJhHjQVZ5kZpIc7+TLNW/z16Mp1RmWkUmKZHQW
	31iyv5GGYhMMXu1kJxlCeCI14I5l6pk=
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
Subject: [RFC PATCH 5/7] memcg: make __mod_memcg_lruvec_state re-entrant safe against irqs
Date: Mon, 12 May 2025 20:13:14 -0700
Message-ID: <20250513031316.2147548-6-shakeel.butt@linux.dev>
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

Let's make __mod_memcg_lruvec_state re-entrant safe and name it
mod_memcg_lruvec_state(). The only thing needed is to convert the usage
of __this_cpu_add() to this_cpu_add(). There are two callers of
mod_memcg_lruvec_state() and one of them i.e. __mod_objcg_mlstate() will
be re-entrant safe as well, so, rename it mod_objcg_mlstate(). The last
caller __mod_lruvec_state() still calls __mod_node_page_state() which is
not re-entrant safe yet, so keep it as is.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9e7dc90cc460..adf2f1922118 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -731,7 +731,7 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 }
 #endif
 
-static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 				     enum node_stat_item idx,
 				     int val)
 {
@@ -743,16 +743,20 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
+	if (WARN_ONCE(in_nmi(), "%s: called in nmi context for stat item %d\n",
+		      __func__, idx))
+		return;
+
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
 	cpu = get_cpu();
 
 	/* Update memcg */
-	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
+	this_cpu_add(memcg->vmstats_percpu->state[i], val);
 
 	/* Update lruvec */
-	__this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
+	this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
 
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val, cpu);
@@ -779,7 +783,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 	/* Update memcg and lruvec */
 	if (!mem_cgroup_disabled())
-		__mod_memcg_lruvec_state(lruvec, idx, val);
+		mod_memcg_lruvec_state(lruvec, idx, val);
 }
 
 void __lruvec_stat_mod_folio(struct folio *folio, enum node_stat_item idx,
@@ -2559,7 +2563,7 @@ static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	folio->memcg_data = (unsigned long)memcg;
 }
 
-static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
+static inline void mod_objcg_mlstate(struct obj_cgroup *objcg,
 				       struct pglist_data *pgdat,
 				       enum node_stat_item idx, int nr)
 {
@@ -2570,7 +2574,7 @@ static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
 	memcg = obj_cgroup_memcg(objcg);
 	if (likely(!in_nmi())) {
 		lruvec = mem_cgroup_lruvec(memcg, pgdat);
-		__mod_memcg_lruvec_state(lruvec, idx, nr);
+		mod_memcg_lruvec_state(lruvec, idx, nr);
 	} else {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[pgdat->node_id];
 
@@ -2901,12 +2905,12 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 		struct pglist_data *oldpg = stock->cached_pgdat;
 
 		if (stock->nr_slab_reclaimable_b) {
-			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
+			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			__mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
+			mod_objcg_mlstate(objcg, oldpg, NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
 		}
@@ -2932,7 +2936,7 @@ static void __account_obj_stock(struct obj_cgroup *objcg,
 		}
 	}
 	if (nr)
-		__mod_objcg_mlstate(objcg, pgdat, idx, nr);
+		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
@@ -3004,13 +3008,13 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 	 */
 	if (stock->nr_slab_reclaimable_b || stock->nr_slab_unreclaimable_b) {
 		if (stock->nr_slab_reclaimable_b) {
-			__mod_objcg_mlstate(old, stock->cached_pgdat,
+			mod_objcg_mlstate(old, stock->cached_pgdat,
 					  NR_SLAB_RECLAIMABLE_B,
 					  stock->nr_slab_reclaimable_b);
 			stock->nr_slab_reclaimable_b = 0;
 		}
 		if (stock->nr_slab_unreclaimable_b) {
-			__mod_objcg_mlstate(old, stock->cached_pgdat,
+			mod_objcg_mlstate(old, stock->cached_pgdat,
 					  NR_SLAB_UNRECLAIMABLE_B,
 					  stock->nr_slab_unreclaimable_b);
 			stock->nr_slab_unreclaimable_b = 0;
@@ -3050,7 +3054,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 
 	if (unlikely(in_nmi())) {
 		if (pgdat)
-			__mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
+			mod_objcg_mlstate(objcg, pgdat, idx, nr_bytes);
 		nr_pages = nr_bytes >> PAGE_SHIFT;
 		nr_bytes = nr_bytes & (PAGE_SIZE - 1);
 		atomic_add(nr_bytes, &objcg->nr_charged_bytes);
-- 
2.47.1


