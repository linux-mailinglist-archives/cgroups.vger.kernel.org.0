Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD2739B019
	for <lists+cgroups@lfdr.de>; Fri,  4 Jun 2021 03:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhFDB7C (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 21:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhFDB7C (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 21:59:02 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4193C061760
        for <cgroups@vger.kernel.org>; Thu,  3 Jun 2021 18:57:01 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id 2-20020a1709020202b02900eecb50c2deso3448827plc.0
        for <cgroups@vger.kernel.org>; Thu, 03 Jun 2021 18:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bv2HXAmGAwf1OCVRda73ecPrrSIpyQRMd6cgUbsrMv0=;
        b=eFloSTVUQU9IkUU1DSNboTys4VUnQayFEX47/s3Gd1NDNoewr73Ghhjd88xCDQjiC+
         gPpsMGcRGrou7m/vgdY1MfO4evGSmw3olKrXEHTk3VNKnRWl7TSHV5Rabkd+dCP8YMTv
         tyVd8NSX7jyVd4u+djCYOI3b3RVWe5YY6mnxCrpwmw3X+liuwb5CqtZTl2u3fvYpY+iV
         lXw2umisbk4ZxK4QNPOm8aekEaXQdY597VziUYvsKW2W1/QazgYxLWMM+YuMRsa3fjSl
         M5oVkOo0R9pperVTplkLvY+K/h9OMaHttfvG+oW1XiW+J2IIVbZ0Xrclq2HymEgOl7y8
         7J0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bv2HXAmGAwf1OCVRda73ecPrrSIpyQRMd6cgUbsrMv0=;
        b=N+72A474mzziRbqNWU9DF9uGqf5oW4x7zH/56RkojH6P1wfQ6vXRnk+xR6wuiw4k1b
         h/5ujIZlhWGBMashVAnT8YevKSFROxHr6LUsY+uZa5962I5/T+jo1S60GK90zSg+uwO0
         8pPZURS19qlumZ6BHWmkRAqsGErVikETx5hviBRDOuqtFLD5XrKcykpY7EnFYL/BVCkx
         AExrRA4+xVOJyGhTgJHAhxlJF3dbjLBmXVaF9q5+WVBLslCzU9n4/JS0NH2WZWC5C9su
         AJ1wtvTkFc4OEIxLX1brYsPfJ60WzVN3y0nSvSTaLGfD3sCj/PxPomLbHQCvSLDFRBoP
         xCDg==
X-Gm-Message-State: AOAM532hN9nRfGIBiUMlbfm3NqEM2658qF62P5og6YPhBYoQuDb1eCbt
        zYE5QIJY7XjhWyRZX21yoNdgEm308q1hlA==
X-Google-Smtp-Source: ABdhPJw87L3hPfWHiAVUQbhQVpGz0rUbJiIjQSnWEoq4bNXhysfDZhBKtC/yTn3SWVaN10/7zQzMcdMQzx33cA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:1d16:daf:7a47:a348])
 (user=shakeelb job=sendgmr) by 2002:a17:90a:5b0c:: with SMTP id
 o12mr14449879pji.108.1622771818195; Thu, 03 Jun 2021 18:56:58 -0700 (PDT)
Date:   Thu,  3 Jun 2021 18:56:39 -0700
Message-Id: <20210604015640.2586269-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 1/2] memcg: switch lruvec stats to rstat
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
 include/linux/memcontrol.h |  42 +++++++------
 mm/memcontrol.c            | 118 +++++++++++++------------------------
 2 files changed, 60 insertions(+), 100 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3cc18c2176e7..81d65d32ec2a 100644
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
index b9a6db6a7d4f..d48f727bec05 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -665,46 +665,20 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
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
@@ -2271,40 +2245,13 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
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
 
@@ -5108,17 +5055,9 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
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
@@ -5139,8 +5078,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
-	free_percpu(pn->lruvec_stat_cpu);
-	free_percpu(pn->lruvec_stat_local);
+	free_percpu(pn->lruvec_stats_percpu);
 	kfree(pn);
 }
 
@@ -5156,15 +5094,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
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
 
@@ -5397,7 +5327,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct memcg_vmstats_percpu *statc;
 	long delta, v;
-	int i;
+	int i, nid;
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
@@ -5445,6 +5375,36 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
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
@@ -6378,6 +6338,8 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
+	cgroup_rstat_flush(memcg->css.cgroup);
+
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

