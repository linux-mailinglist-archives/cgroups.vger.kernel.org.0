Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F51A30CA80
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 19:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhBBSus (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 13:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbhBBSso (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 13:48:44 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A6C061354
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 10:48:03 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d85so20841540qkg.5
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wH4c6SXNdhNwh+C23BEFkUNz9OTjPe+NannGM5GtmrQ=;
        b=J29bxNRinL1CN+JqxD3H5YMXk5tmfxXkSEjOPJX/ssjGALv8pJGYjjR5KFiU19djZJ
         S6ZsrjzCu/7fjI1R9wGkp68lqh0Ham2Gkmos778PuL03eCfcX0NJrzAZdDt3IblYPUkg
         m+bR2gl8Du2Ksk+3F3P4Otlj2gPliOGcn9EL7zt/X9MOjB5pmNpc13Wp6wwl+p6vpN3R
         ETUpZrK5m+SFtwGy8cKknOGHSThCZWAXNgKzokTBTDb36plDldtYBXVfUWucOZO4abs/
         z7WaXx9SJRbFDMlQJNh08vgzpdCyFr4nbRhRFHVEc5AmJpfeG5ASg2LtbyD26zAjntrl
         NDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wH4c6SXNdhNwh+C23BEFkUNz9OTjPe+NannGM5GtmrQ=;
        b=jAZvq/AD4YeDxqEr4oygcom34efroSlUzBp4yWq/IfpxqTkA1uJyGLAP3ASNxrSSfn
         K3sRILye+HQvjbJ/mYqwnxxE9PES38nwLg3MuNYyW5ytegJeyPH11wpju5bdSrnOh34K
         9ab1ntYh4t4WIzOuhNGJgu+qgQTP3SSer6wpLZkwVcC3lc/nTKaRrFYttgaHEnbDcLph
         JtMwHVUVbaWyaJyD/5op8OdPW5b6Dgva7E+81tacBwPemXJSLYCIz+Kuak4WJkp39jCL
         5Oml45L1HsBRBsjSz47N9rCMplsgMCo1xez/BvQjQqJAcGI0Q4peIPQGYMVTmCneALo/
         a2uw==
X-Gm-Message-State: AOAM530XhluKjISGExOs9kprGckBeTJYIMX8BwmRTUZG+0cnuPShcr+U
        P/jOtrfBGwpWA2mjCgKawCeiLQ==
X-Google-Smtp-Source: ABdhPJyNb24nKjqr7ExMx3Nitbz7FaveWMnR7LErpEQpfoxBwRQEu+EI4Tol1j/vL6HvAGomXp8glA==
X-Received: by 2002:ae9:d881:: with SMTP id u123mr22659274qkf.133.1612291682726;
        Tue, 02 Feb 2021 10:48:02 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k129sm18117119qkf.108.2021.02.02.10.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:48:02 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 7/7] mm: memcontrol: consolidate lruvec stat flushing
Date:   Tue,  2 Feb 2021 13:47:46 -0500
Message-Id: <20210202184746.119084-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202184746.119084-1-hannes@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

There are two functions to flush the per-cpu data of an lruvec into
the rest of the cgroup tree: when the cgroup is being freed, and when
a CPU disappears during hotplug. The difference is whether all CPUs or
just one is being collected, but the rest of the flushing code is the
same. Merge them into one function and share the common code.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 88 +++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 46 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b205b2413186..88e8afc49a46 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2410,39 +2410,56 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	mutex_unlock(&percpu_charge_mutex);
 }
 
-static int memcg_hotplug_cpu_dead(unsigned int cpu)
+static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg, int cpu)
 {
-	struct memcg_stock_pcp *stock;
-	struct mem_cgroup *memcg;
-
-	stock = &per_cpu(memcg_stock, cpu);
-	drain_stock(stock);
+	int nid;
 
-	for_each_mem_cgroup(memcg) {
+	for_each_node(nid) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0, };
+		struct batched_lruvec_stat *lstatc;
 		int i;
 
-		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			int nid;
-
-			for_each_node(nid) {
-				struct batched_lruvec_stat *lstatc;
-				struct mem_cgroup_per_node *pn;
-				long x;
-
-				pn = memcg->nodeinfo[nid];
+		if (cpu == -1) {
+			int cpui;
+			/*
+			 * The memcg is about to be freed, collect all
+			 * CPUs, no need to zero anything out.
+			 */
+			for_each_online_cpu(cpui) {
+				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpui);
+				for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+					stat[i] += lstatc->count[i];
+			}
+		} else {
+			/*
+			 * The CPU has gone away, collect and zero out
+			 * its stats, it may come back later.
+			 */
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
 				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
-
-				x = lstatc->count[i];
+				stat[i] = lstatc->count[i];
 				lstatc->count[i] = 0;
-
-				if (x) {
-					do {
-						atomic_long_add(x, &pn->lruvec_stat[i]);
-					} while ((pn = parent_nodeinfo(pn, nid)));
-				}
 			}
 		}
+
+		do {
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
+		} while ((pn = parent_nodeinfo(pn, nid)));
 	}
+}
+
+static int memcg_hotplug_cpu_dead(unsigned int cpu)
+{
+	struct memcg_stock_pcp *stock;
+	struct mem_cgroup *memcg;
+
+	stock = &per_cpu(memcg_stock, cpu);
+	drain_stock(stock);
+
+	for_each_mem_cgroup(memcg)
+		memcg_flush_lruvec_page_state(memcg, cpu);
 
 	return 0;
 }
@@ -3636,27 +3653,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
-{
-	int node;
-
-	for_each_node(node) {
-		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
-		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = {0, };
-		struct mem_cgroup_per_node *pi;
-		int cpu, i;
-
-		for_each_online_cpu(cpu)
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-				stat[i] += per_cpu(
-					pn->lruvec_stat_cpu->count[i], cpu);
-
-		for (pi = pn; pi; pi = parent_nodeinfo(pi, node))
-			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
-				atomic_long_add(stat[i], &pi->lruvec_stat[i]);
-	}
-}
-
 #ifdef CONFIG_MEMCG_KMEM
 static int memcg_online_kmem(struct mem_cgroup *memcg)
 {
@@ -5197,7 +5193,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 	 * Flush percpu lruvec stats to guarantee the value
 	 * correctness on parent's and all ancestor levels.
 	 */
-	memcg_flush_lruvec_page_state(memcg);
+	memcg_flush_lruvec_page_state(memcg, -1);
 	__mem_cgroup_free(memcg);
 }
 
-- 
2.30.0

