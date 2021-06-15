Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E75A3A87F8
	for <lists+cgroups@lfdr.de>; Tue, 15 Jun 2021 19:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbhFORqv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Jun 2021 13:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhFORqv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Jun 2021 13:46:51 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDD7C06175F
        for <cgroups@vger.kernel.org>; Tue, 15 Jun 2021 10:44:45 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w1-20020ac87a610000b02902433332a0easo9904022qtt.0
        for <cgroups@vger.kernel.org>; Tue, 15 Jun 2021 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=20nqL6qcCVh1AvFA3adHVcn9UAqdKdvXk0+eH6fWh7o=;
        b=m+Dyg5uwVyznaSJVLrsdBn75XEh0xyv7liBZGwWfTPbsybpDB18UQGHlxrGfJcAbAu
         PvQd0xgxx5xVpV4T430nt56XZeWq/mlgdOxaJVTcwl2F2BJiX75apbPEH89ycqsNK8Ey
         P3RqZTILjTqeJKydGAmZK4F5I1+GJBuiHgvxiCF6Ec3O78MK8hu9jaePxEJg8e93uIYv
         8a8fh88cW+K3tWGH6qd8tiP/HJfiQUm8+HXThHY+ec99TaD8lp+zfY2Ld1jZMlY/nrmV
         zYMnFPA0waN5TKV6PcO5B/Cvw/wopjfrfphFlEZqBb2eSdsVLDOqq4II863RtZ/ifn80
         1q+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=20nqL6qcCVh1AvFA3adHVcn9UAqdKdvXk0+eH6fWh7o=;
        b=dYjiQzIJgOKSqKWa+WUD4D1pS0LJ5Xm1Fcs1/Q5A76SPdd7nfooUzYxdiCqmRcNG+p
         1g6ZEkQSvNl6nZH47zPp+GlvOVjtZwE1b7VUnpytuJJ3/1SCghw4iO5It7RpCwWJpIYn
         yRo4Q1MTKT4wZqe17pIjMl4ARj8OXV2SSyTzUIWeHSCYV7W6K7OWoqdQ7dK3WO5ndsxt
         x3q51w6pNFLvPFPjT5cqV96s9Uf42Bhg7uwqn48IREDrGPMYjgAwUJDJwpJiRZdgvWxo
         d8ixWqPqSsoy1LbKryzJfXzV79wU2nJeaKs/WrH6qlIPZ5c/VDxs+Advw7P/VqSlgVP5
         hC5Q==
X-Gm-Message-State: AOAM530muTyc3PBoTB6/gj5QOvhtqyCg2pksqFloECuQqQGyrypNRPPj
        NSad1fg9Nnn+nO79ODnggZLzAXIP58mArg==
X-Google-Smtp-Source: ABdhPJydvun+o6IPzXg8Ul67P4VrrhW7vltIRPiCs1YmM0dbnynwRa4fSol1BQuApDKPWYqGIdY7S4ePTHTpZQ==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:5fdb:fdf0:b7e3:fb19])
 (user=shakeelb job=sendgmr) by 2002:a05:620a:e09:: with SMTP id
 y9mr778121qkm.359.1623779084624; Tue, 15 Jun 2021 10:44:44 -0700 (PDT)
Date:   Tue, 15 Jun 2021 10:44:34 -0700
Message-Id: <20210615174435.4174364-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 1/2] memcg: switch lruvec stats to rstat
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The commit 2d146aa3aa84 ("mm: memcontrol: switch to rstat") but skipped
the conversion of the lruvec stats as such stats are read in the
performance critical code paths and flushing stats may have impacted the
performances of the applications. This patch converts the lruvec stats
to rstat and later patch adds the periodic flushing of the stats and
thus remove the need to synchronously flushing the stats in the
performance critical code paths.

The rstat conversion comes with the price i.e. memory cost. Effectively
this patch reverts the savings done by the commit f3344adf38bd ("mm:
memcontrol: optimize per-lruvec stats counter memory usage"). However
this cost is justified due to negative impact of the inaccurate lruvec
stats on many heuristics. One such case is reported in [1].

The memory reclaim code is filled with plethora of heuristics and many
of those heuristics reads the lruvec stats. So, inaccurate stats can
make such heuristics ineffective. [1] reports the impact of inaccurate
lruvec stats on the "cache trim mode" heuristic. Inaccurate lruvec stats
can impact the deactivation and aging anon heuristics as well.

[1] https://lore.kernel.org/linux-mm/20210311004449.1170308-1-ying.huang@intel.com/

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v1:
- no changes

 include/linux/memcontrol.h |  42 +++++++------
 mm/memcontrol.c            | 118 +++++++++++++------------------------
 2 files changed, 60 insertions(+), 100 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..0bfa0409af22 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -105,14 +105,6 @@ struct mem_cgroup_reclaim_iter {
 	unsigned int generation;
 };
 
-struct lruvec_stat {
-	long count[NR_VM_NODE_STAT_ITEMS];
-};
-
-struct batched_lruvec_stat {
-	s32 count[NR_VM_NODE_STAT_ITEMS];
-};
-
 /*
  * Bitmap and deferred work of shrinker::id corresponding to memcg-aware
  * shrinkers, which have elements charged to this memcg.
@@ -123,24 +115,30 @@ struct shrinker_info {
 	unsigned long *map;
 };
 
+struct lruvec_stats_percpu {
+	/* Local (CPU and cgroup) state */
+	long state[NR_VM_NODE_STAT_ITEMS];
+
+	/* Delta calculation for lockless upward propagation */
+	long state_prev[NR_VM_NODE_STAT_ITEMS];
+};
+
+struct lruvec_stats {
+	/* Aggregated (CPU and subtree) state */
+	long state[NR_VM_NODE_STAT_ITEMS];
+
+	/* Pending child counts during tree propagation */
+	long state_pending[NR_VM_NODE_STAT_ITEMS];
+};
+
 /*
  * per-node information in memory controller.
  */
 struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
-	/*
-	 * Legacy local VM stats. This should be struct lruvec_stat and
-	 * cannot be optimized to struct batched_lruvec_stat. Because
-	 * the threshold of the lruvec_stat_cpu can be as big as
-	 * MEMCG_CHARGE_BATCH * PAGE_SIZE. It can fit into s32. But this
-	 * filed has no upper limit.
-	 */
-	struct lruvec_stat __percpu *lruvec_stat_local;
-
-	/* Subtree VM stats (batched updates) */
-	struct batched_lruvec_stat __percpu *lruvec_stat_cpu;
-	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
+	struct lruvec_stats_percpu __percpu	*lruvec_stats_percpu;
+	struct lruvec_stats			lruvec_stats;
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 
@@ -965,7 +963,7 @@ static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = atomic_long_read(&pn->lruvec_stat[idx]);
+	x = READ_ONCE(pn->lruvec_stats.state[idx]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -985,7 +983,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	for_each_possible_cpu(cpu)
-		x += per_cpu(pn->lruvec_stat_local->count[idx], cpu);
+		x += per_cpu(pn->lruvec_stats_percpu->state[idx], cpu);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dce5154fbb8f..6e24fd8c5301 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -671,46 +671,20 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	return x;
 }
 
-static struct mem_cgroup_per_node *
-parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
-{
-	struct mem_cgroup *parent;
-
-	parent = parent_mem_cgroup(pn->memcg);
-	if (!parent)
-		return NULL;
-	return parent->nodeinfo[nid];
-}
-
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val)
 {
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
-	long x, threshold = MEMCG_CHARGE_BATCH;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
-	/* Update memcg */
-	__mod_memcg_state(memcg, idx, val);
-
 	/* Update lruvec */
-	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
+	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
-	if (vmstat_item_in_bytes(idx))
-		threshold <<= PAGE_SHIFT;
-
-	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
-	if (unlikely(abs(x) > threshold)) {
-		pg_data_t *pgdat = lruvec_pgdat(lruvec);
-		struct mem_cgroup_per_node *pi;
-
-		for (pi = pn; pi; pi = parent_nodeinfo(pi, pgdat->node_id))
-			atomic_long_add(x, &pi->lruvec_stat[idx]);
-		x = 0;
-	}
-	__this_cpu_write(pn->lruvec_stat_cpu->count[idx], x);
+	/* Update memcg */
+	__mod_memcg_state(memcg, idx, val);
 }
 
 /**
@@ -2289,40 +2263,13 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	mutex_unlock(&percpu_charge_mutex);
 }
 
-static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
-{
-	int nid;
-
-	for_each_node(nid) {
-		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
-		unsigned long stat[NR_VM_NODE_STAT_ITEMS];
-		struct batched_lruvec_stat *lstatc;
-		int i;
-
-		lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			stat[i] = lstatc->count[i];
-			lstatc->count[i] = 0;
-		}
-
-		do {
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
-		} while ((pn = parent_nodeinfo(pn, nid)));
-	}
-}
-
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
-	struct mem_cgroup *memcg;
 
 	stock = &per_cpu(memcg_stock, cpu);
 	drain_stock(stock);
 
-	for_each_mem_cgroup(memcg)
-		memcg_flush_lruvec_page_state(memcg, cpu);
-
 	return 0;
 }
 
@@ -5126,17 +5073,9 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return 1;
 
-	pn->lruvec_stat_local = alloc_percpu_gfp(struct lruvec_stat,
-						 GFP_KERNEL_ACCOUNT);
-	if (!pn->lruvec_stat_local) {
-		kfree(pn);
-		return 1;
-	}
-
-	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct batched_lruvec_stat,
-					       GFP_KERNEL_ACCOUNT);
-	if (!pn->lruvec_stat_cpu) {
-		free_percpu(pn->lruvec_stat_local);
+	pn->lruvec_stats_percpu = alloc_percpu_gfp(struct lruvec_stats_percpu,
+						   GFP_KERNEL_ACCOUNT);
+	if (!pn->lruvec_stats_percpu) {
 		kfree(pn);
 		return 1;
 	}
@@ -5157,8 +5096,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
-	free_percpu(pn->lruvec_stat_cpu);
-	free_percpu(pn->lruvec_stat_local);
+	free_percpu(pn->lruvec_stats_percpu);
 	kfree(pn);
 }
 
@@ -5174,15 +5112,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
-	int cpu;
-
 	memcg_wb_domain_exit(memcg);
-	/*
-	 * Flush percpu lruvec stats to guarantee the value
-	 * correctness on parent's and all ancestor levels.
-	 */
-	for_each_online_cpu(cpu)
-		memcg_flush_lruvec_page_state(memcg, cpu);
 	__mem_cgroup_free(memcg);
 }
 
@@ -5415,7 +5345,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct memcg_vmstats_percpu *statc;
 	long delta, v;
-	int i;
+	int i, nid;
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
@@ -5463,6 +5393,36 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (parent)
 			parent->vmstats.events_pending[i] += delta;
 	}
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		struct mem_cgroup_per_node *ppn = NULL;
+		struct lruvec_stats_percpu *lstatc;
+
+		if (parent)
+			ppn = parent->nodeinfo[nid];
+
+		lstatc = per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
+
+		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
+			delta = pn->lruvec_stats.state_pending[i];
+			if (delta)
+				pn->lruvec_stats.state_pending[i] = 0;
+
+			v = READ_ONCE(lstatc->state[i]);
+			if (v != lstatc->state_prev[i]) {
+				delta += v - lstatc->state_prev[i];
+				lstatc->state_prev[i] = v;
+			}
+
+			if (!delta)
+				continue;
+
+			pn->lruvec_stats.state[i] += delta;
+			if (ppn)
+				ppn->lruvec_stats.state_pending[i] += delta;
+		}
+	}
 }
 
 #ifdef CONFIG_MMU
@@ -6396,6 +6356,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
+	cgroup_rstat_flush(memcg->css.cgroup);
+
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
 
-- 
2.32.0.272.g935e593368-goog

