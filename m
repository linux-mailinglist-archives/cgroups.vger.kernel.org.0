Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AB531102A
	for <lists+cgroups@lfdr.de>; Fri,  5 Feb 2021 19:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbhBERAD (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 5 Feb 2021 12:00:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbhBEQrZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 5 Feb 2021 11:47:25 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07BEC06121E
        for <cgroups@vger.kernel.org>; Fri,  5 Feb 2021 10:28:27 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id x3so3774695qti.5
        for <cgroups@vger.kernel.org>; Fri, 05 Feb 2021 10:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=anbL9Wexkq0QH+x4JfZ6vBo+adkAAWXAkexWmp3sHZ4=;
        b=U4EQA/daTMWDj2KpnKM6JeOv9uy/kBDEm/uO2MZ/dYoFEl9BtZMe0u8Up1GJlOAVat
         FyUdHSnYcoLRyCDpy8I5JguO9gryQYk06pvXlFuWvP1nanx9BoVt708OpOVjX7hGp0NM
         u3CpSRjrbpoptPnLF+vCKAD0uEl8CgLgfTmhRpQRx/D7hadhMAKsjwWqjtUsOTrJBngg
         UoyMrvGzLTbhsQjBLb0Zn4ex3iUdg2hNEv85wEs/BAJ3rcBGu3oLsoIUeTYsYAC4yl/2
         Yon8QeGPR9FRKoCpxU7jZA/EY4KF58sECERo6V/grHRiHwQukuZWKSjdWkEetayENa9D
         8EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=anbL9Wexkq0QH+x4JfZ6vBo+adkAAWXAkexWmp3sHZ4=;
        b=m1x8Ug8zAAlADUPmqoekwiOF8AtCWq7/A/ZkWaIw07pE6rWj2ecbiMG/RHO/pCDuQv
         tC2XQmn3w+KFV43xALTihrjKBR3EzGQhM/QvE/BtWYUiWcso/kj/Mjoltis6myveBTBc
         yDQlWHdjRTvAiIdDDfQspI/W8UQIXrCRGt+ahryHUVktnwjExhMmYujAfwLnponorj5N
         dfoXPNd0J0Q07ayuLUjscvr+V2GZaU3sscExc2md4kCtXh/zRSsyjQhLMgYtPENgn53F
         hV3JBREKONQA/yG1y6gpECwK3gQPDZo3lfqN0jvWCWv/lphtkHbQSsmtSKAFn2gptpL2
         MV9w==
X-Gm-Message-State: AOAM531s01eq3G2pcbh9yVGRhldUSswhsjN/kRbruu3H8dWEFGmL2neu
        oztu1PaQUvXh/scSzc4ep305Vg==
X-Google-Smtp-Source: ABdhPJxc7WXk4zJUXM1XvvDnCZEwxVU/BXPLAaamoPKXlLUScXsoh7UaMFIajiqR+agL6tmf/QJPQg==
X-Received: by 2002:ac8:598e:: with SMTP id e14mr5644319qte.346.1612549707014;
        Fri, 05 Feb 2021 10:28:27 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q50sm9452451qtb.32.2021.02.05.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 10:28:26 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/8] mm: memcontrol: fix cpuhotplug statistics flushing
Date:   Fri,  5 Feb 2021 13:27:59 -0500
Message-Id: <20210205182806.17220-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205182806.17220-1-hannes@cmpxchg.org>
References: <20210205182806.17220-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The memcg hotunplug callback erroneously flushes counts on the local
CPU, not the counts of the CPU going away; those counts will be lost.

Flush the CPU that is actually going away.

Also simplify the code a bit by using mod_memcg_state() and
count_memcg_events() instead of open-coding the upward flush - this is
comparable to how vmstat.c handles hotunplug flushing.

Fixes: a983b5ebee572 ("mm: memcontrol: fix excessive complexity in memory.stat reporting")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index ed5cc78a8dbf..8120d565dd79 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2411,45 +2411,52 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
 	struct memcg_stock_pcp *stock;
-	struct mem_cgroup *memcg, *mi;
+	struct mem_cgroup *memcg;
 
 	stock = &per_cpu(memcg_stock, cpu);
 	drain_stock(stock);
 
 	for_each_mem_cgroup(memcg) {
+		struct memcg_vmstats_percpu *statc;
 		int i;
 
+		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
+
 		for (i = 0; i < MEMCG_NR_STAT; i++) {
 			int nid;
-			long x;
 
-			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
-			if (x)
-				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmstats[i]);
+			if (statc->stat[i]) {
+				mod_memcg_state(memcg, i, statc->stat[i]);
+				statc->stat[i] = 0;
+			}
 
 			if (i >= NR_VM_NODE_STAT_ITEMS)
 				continue;
 
 			for_each_node(nid) {
+				struct batched_lruvec_stat *lstatc;
 				struct mem_cgroup_per_node *pn;
+				long x;
 
 				pn = mem_cgroup_nodeinfo(memcg, nid);
-				x = this_cpu_xchg(pn->lruvec_stat_cpu->count[i], 0);
-				if (x)
+				lstatc = per_cpu_ptr(pn->lruvec_stat_cpu, cpu);
+
+				x = lstatc->count[i];
+				lstatc->count[i] = 0;
+
+				if (x) {
 					do {
 						atomic_long_add(x, &pn->lruvec_stat[i]);
 					} while ((pn = parent_nodeinfo(pn, nid)));
+				}
 			}
 		}
 
 		for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-			long x;
-
-			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
-			if (x)
-				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
-					atomic_long_add(x, &memcg->vmevents[i]);
+			if (statc->events[i]) {
+				count_memcg_events(memcg, i, statc->events[i]);
+				statc->events[i] = 0;
+			}
 		}
 	}
 
-- 
2.30.0

