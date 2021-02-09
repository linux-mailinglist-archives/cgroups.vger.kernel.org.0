Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48DCA315402
	for <lists+cgroups@lfdr.de>; Tue,  9 Feb 2021 17:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbhBIQgJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 9 Feb 2021 11:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhBIQfP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 9 Feb 2021 11:35:15 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2740DC0617AB
        for <cgroups@vger.kernel.org>; Tue,  9 Feb 2021 08:33:37 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id x3so11461449qti.5
        for <cgroups@vger.kernel.org>; Tue, 09 Feb 2021 08:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pM+e2ns8V7jwVqNtLJGWoXKVZQIo4iLejzhQNz1sprE=;
        b=J3MueaBKAh3WgnLMGe7OwtcFhvXuTlKr9pZvBYRnjonYxR/d+hPgUsnZWtFoS+DXxR
         4947cn/DGehG0pH3dQaK5U6DaHTJpXD2JQApOWmbSjEND+Ir1y4Grjap8BRSXMtXPBTh
         7kfLhkEB6rHobmxZ1KcPew0T/LvPT4VHfx5wUDtbA7E/aD0s3ZkRMg+FjAgA9sVICG8D
         lJSWb0EL9OdGDTTTNB0i2QcQgkNUehpROlYc+Yb8BZPrPAuh5dFNUeHhwHeny5/Tqlpu
         bvmFn7HFw322Eg5vJYUyQ5tB+pGdMJ8uR+wXVNr4d+gVy2MIvyIy/1H0wDQ8I/2oap4V
         gjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pM+e2ns8V7jwVqNtLJGWoXKVZQIo4iLejzhQNz1sprE=;
        b=tKDIDi8tDePAwd1fa65Ms4US0H/oRlDfXVzGR9HPmXQ6bpix/J8A8NbS+JpsutPWrW
         DXxaI1Fa83NOsSt+sw/xZ5PXSr177sn5BNDsyswN1vvsTUwNQ0QfD6xzKENuThZoRKPm
         JwO103R6duFrSV7Gv8qTzE7HPgknkzaXPZcn6hUiu2CQbK6Ayd81Ivb4lDCb5KUliW7T
         QousuFQU7h7cynZLagHTTCXw/7cJ+VXg6vDpi0LDNkcyCae31sVdUU4AElyYCq41GHtg
         iBeL2NNKGJel0zH1Fst0qsRPeGF3o7t/qQgywlIjDlPZqJFW0t1VHy0/N8MnO+6qG7D3
         px7Q==
X-Gm-Message-State: AOAM530x4YOz5oxRkfpVGJNnfaFBpA8j85faa+phjJ4GoT4CvudEcbP/
        cqMMPYAp3Y/6f0NM3EwjEm0x9Q==
X-Google-Smtp-Source: ABdhPJwYdE5CZIL4QYdDeUriQ8kH+B2GTLuOZ4e1VF2c/78G7/4F3PlGGPBjoc3kFIE8V6uokbKG3w==
X-Received: by 2002:ac8:6b45:: with SMTP id x5mr20912145qts.226.1612888416356;
        Tue, 09 Feb 2021 08:33:36 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id v18sm19441028qkv.62.2021.02.09.08.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 08:33:35 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 7/8] mm: memcontrol: consolidate lruvec stat flushing
Date:   Tue,  9 Feb 2021 11:33:03 -0500
Message-Id: <20210209163304.77088-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210209163304.77088-1-hannes@cmpxchg.org>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
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
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 74 +++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index bc0979257551..51778fa9b462 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2410,39 +2410,39 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
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
+		unsigned long stat[NR_VM_NODE_STAT_ITEMS];
+		struct batched_lruvec_stat *lstatc;
 		int i;
 
+		lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
 		for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++) {
-			int nid;
+			stat[i] = lstatc->count[i];
+			lstatc->count[i] = 0;
+		}
 
-			for_each_node(nid) {
-				struct batched_lruvec_stat *lstatc;
-				struct mem_cgroup_per_node *pn;
-				long x;
+		do {
+			for (i = 0; i < NR_VM_NODE_STAT_ITEMS; i++)
+				atomic_long_add(stat[i], &pn->lruvec_stat[i]);
+		} while ((pn = parent_nodeinfo(pn, nid)));
+	}
+}
 
-				pn = memcg->nodeinfo[nid];
-				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
+static int memcg_hotplug_cpu_dead(unsigned int cpu)
+{
+	struct memcg_stock_pcp *stock;
+	struct mem_cgroup *memcg;
 
-				x = lstatc->count[i];
-				lstatc->count[i] = 0;
+	stock = &per_cpu(memcg_stock, cpu);
+	drain_stock(stock);
 
-				if (x) {
-					do {
-						atomic_long_add(x, &pn->lruvec_stat[i]);
-					} while ((pn = parent_nodeinfo(pn, nid)));
-				}
-			}
-		}
-	}
+	for_each_mem_cgroup(memcg)
+		memcg_flush_lruvec_page_state(memcg, cpu);
 
 	return 0;
 }
@@ -3635,27 +3635,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
 	}
 }
 
-static void memcg_flush_lruvec_page_state(struct mem_cgroup *memcg)
-{
-	int node;
-
-	for_each_node(node) {
-		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
-		unsigned long stat[NR_VM_NODE_STAT_ITEMS] = { 0 };
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
@@ -5191,12 +5170,15 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	int cpu;
+
 	memcg_wb_domain_exit(memcg);
 	/*
 	 * Flush percpu lruvec stats to guarantee the value
 	 * correctness on parent's and all ancestor levels.
 	 */
-	memcg_flush_lruvec_page_state(memcg);
+	for_each_online_cpu(cpu)
+		memcg_flush_lruvec_page_state(memcg, cpu);
 	__mem_cgroup_free(memcg);
 }
 
-- 
2.30.0

