Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5F310FF6
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 19:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhBEQui (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 11:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbhBEQsa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 11:48:30 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9669AC0611BD
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 10:28:36 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k193so7854236qke.6
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 10:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NkGochaaRcmTlyZxkCgRxNgKhbX45qwASpGU1xNehx0=;
        b=0F6KH20bviGrQNM9hbNvSXi7Vk/KA9cDm/VECQSQnHEPGSsqEZRI0RBWRVQ6p7HnxD
         kC8C0UB7VSTJzFNjkBOtg4VH27hzXIAf2zYhcPeZ+v+UP273dW65hwzx7s1q0zHV9zuE
         6vfEBaxgqx27Nni6gCcAWoGeoPzLDvXiXlOZTA9n3Z6qpCthBOX9QIdwNhwPDX36/zpY
         bL4fcNoSLRdYjOitEDTdeTKEkerao0KI7iYwRLfbfjEzu0FaMeyPFq93DsS1foVkMa5C
         iVzRPcKT76qsfJIiN0d/uMOZ0uR77juU+76rJpaWEPDpmJM4ewdbqq1FxIf6bknXkOCX
         bD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NkGochaaRcmTlyZxkCgRxNgKhbX45qwASpGU1xNehx0=;
        b=FyGDvMt9njP6fTO4CiZt10+ncBZ7c11WP3mS5Cco65oYNyY36gJ11mqv2ZTcH2GdF1
         7Oid7GvioOD2J1qT2WiJTYdrfo9O4BJNzN2+5/UluA1OVvaZ+Fxnvpyg8fXsObwQEuc9
         ngTRFPPLCfwtyuHC4NuIWsHSVYNgJgwCdCGvlFRIt9KYyuWd1okNLj+/70yD4RTaVTr/
         iaB6MIBbZtsK5qY14mQnKfUh6urT7QDczt//jrbCaSw7h8Xf8/lMSqQstrTpsxajvVTk
         gbFcphGi5UeyTzn7veqIhHiBDKV68GC1xb3ab+rQ99nV1FtBQja57R1deo+eXXWdhAiq
         l/Gg==
X-Gm-Message-State: AOAM533eq0zJ4xEtVBYRKddsuiDUxidQpMorJyZTkPzUvw6yOharmCj/
        e8EN5P7D2nMsTUI+T6aYxVscpQ==
X-Google-Smtp-Source: ABdhPJwOCyzi6wMCfUG8t5Uh5azCf+Qr016KkMDhRws7YkXV+J/NqxYYWdgO7dds/64Fu1/bKXhz0g==
X-Received: by 2002:a37:9c94:: with SMTP id f142mr5628212qke.388.1612549715911;
        Fri, 05 Feb 2021 10:28:35 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q92sm8919874qtd.92.2021.02.05.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:35 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 7/8] mm: memcontrol: consolidate lruvec stat flushing
Date:   Fri,  5 Feb 2021 13:28:05 -0500
Message-Id: <20210205182806.17220-8-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
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
 mm/memcontrol.c | 74 +++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5dc0bd53b64a..490357945f2c 100644
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
@@ -3636,27 +3636,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
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
@@ -5192,12 +5171,15 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
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

