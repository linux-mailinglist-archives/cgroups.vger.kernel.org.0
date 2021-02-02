Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 234C430CA77
	for <lists+cgroups@lfdr.de>; Tue,  2 Feb 2021 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239015AbhBBSuB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 2 Feb 2021 13:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbhBBSse (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 2 Feb 2021 13:48:34 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BA7C06178C
        for <cgroups@vger.kernel.org>; Tue,  2 Feb 2021 10:47:54 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id r77so20817371qka.12
        for <cgroups@vger.kernel.org>; Tue, 02 Feb 2021 10:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBCKydbpWga5DpiOrlHudvnTFh13spVvcDscPggPa+8=;
        b=iixvdo9II3CKbmX3rdwEdikCy6FYq2Xh7l6cr1JZDyZLV3tA7TuJMIZuIukFI2YdMG
         BTy4s/CiTvdw7jKAbWtlNoWIJe4vyWfjyD9CrO57tcOSLynLgtpULv2m6u3oUrxMqe6n
         cdDCwBSYaO1AFHPmCA2adqCaOiR2FF28vjLiw9S4VV2dR2P+1YK3kcyjPDRjRzQJfmHU
         iUdM0DlrSVzOwnsqjfhCFN1CXQKjBxXFaOvaFjkd0I314jpXy9KqXtn6Gpji3x8apJ7O
         WNsgg5PiF2eDrCHcn+OWgi/CW/dWhUMfSQcTW2vMCUHR5pB5jPDCL8FW9+KOOoyrSOBR
         s06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBCKydbpWga5DpiOrlHudvnTFh13spVvcDscPggPa+8=;
        b=llA+a86bU9R9nLIeXCseuxWpJLnU5/pRbN5LFubrqBVJLgZXaI0JoNeHgTgZxpmZr8
         aUInta18MsV566/pa0Jmnj+5Tz3EPly2aw76scoDGvxqJ3QXNR2PkOM+sOKp2y/0/DGl
         mpBGeuUsjWvmlGp/WnlnkdBu3iBzTvMJCJKwXhBlniZ44H6i3cuZlM+v7UpkMQ3M0mLn
         NjlfADnvZa+LNdgzsVmE38n4O8YrYgTPutA5PsrGPpB86mzft27RvdnvZ4iyGQROOyxg
         68CeshxQCSBxINWyHbNhG/N+dqA4P3rz0ycsn479B9werRmwxbku3cP1Ux1+LAZZ3kzW
         Pbmg==
X-Gm-Message-State: AOAM5308N1jvT+fqxFDH8i4V9FJIuzhzF1Qv4cHJO8tEr7o7XJEVJX+1
        pIjLryoYpFl8tI8g+wnA4RoLGg==
X-Google-Smtp-Source: ABdhPJy5MjmvwvaZM06ZkRt9SFWmclrfAONi0RAh0i6LjYYVtxj9vXig0yYsTm/dF1v/5Mq0AeSP8Q==
X-Received: by 2002:a37:a40b:: with SMTP id n11mr23845773qke.430.1612291673304;
        Tue, 02 Feb 2021 10:47:53 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id y135sm18881253qkb.14.2021.02.02.10.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 10:47:52 -0800 (PST)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/7] mm: memcontrol: fix cpuhotplug statistics flushing
Date:   Tue,  2 Feb 2021 13:47:40 -0500
Message-Id: <20210202184746.119084-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202184746.119084-1-hannes@cmpxchg.org>
References: <20210202184746.119084-1-hannes@cmpxchg.org>
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

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
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

