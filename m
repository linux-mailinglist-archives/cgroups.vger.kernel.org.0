Return-Path: <cgroups+bounces-541-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D04B7F67B0
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 20:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5965B2130D
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89C94CE0D;
	Thu, 23 Nov 2023 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="PI9aQbRE"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8FD6F;
	Thu, 23 Nov 2023 11:39:47 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 66922100002;
	Thu, 23 Nov 2023 22:39:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 66922100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700768385;
	bh=ywDtj6tZPYqsf6JfVartrIaJdgw+5bnQVzBGvn2tRUk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=PI9aQbREnvKhexKQ0GGXr5+Y3ivzCgX45+xVc56UuJ3IeASPnFkZ/w0vmM1qFYMml
	 NP3jgLWtKiWN3iFQ16GSuZUVOiwf3uMVwOGpIKGNtNGX8xYoD0l6HvBNjGj7ZHDW/A
	 PTCdMowrQWgumnWpN+vW88EBlOX1BOMAZwk6Uv2vnH6JILwPPW53jxFEzrjh0PIDPw
	 6PMQEtVbbfqQphA5EWgdyCzN7n1d5eFIi56doyOVHV29wHHElCGG8C9UG5F2xnMzDm
	 Ncc/kffYHs3Ztb9ikweTidb3FBxW5Lqamk5JlCy6ehDa3zIDzMMxDLz8wxVgUkINDW
	 saB6OQsiXNLeA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 22:39:45 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 22:39:44 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <mhocko@suse.com>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 1/2] mm: memcg: print out cgroup ino in the memcg tracepoints
Date: Thu, 23 Nov 2023 22:39:36 +0300
Message-ID: <20231123193937.11628-2-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231123193937.11628-1-ddrokosov@salutedevices.com>
References: <20231123193937.11628-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181569 [Nov 23 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;100.64.160.123:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 17:02:00 #22509098
X-KSMG-AntiVirus-Status: Clean, skipped

Sometimes, it becomes necessary to determine the memcg tracepoint event
that has occurred. This is particularly relevant in scenarios involving
a large cgroup hierarchy, where users may wish to trace the process of
reclamation within a specific cgroup(s) by applying a filter.

The function cgroup_ino() is a useful tool for this purpose.
To integrate cgroup_ino() into the existing memcg tracepoints, this
patch introduces a new tracepoint template for the begin() and end()
events.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 include/trace/events/vmscan.h | 73 +++++++++++++++++++++++++++++------
 mm/vmscan.c                   | 10 ++---
 2 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d2123dd960d5..e9093fa1c924 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -141,19 +141,45 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_b
 );
 
 #ifdef CONFIG_MEMCG
-DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_begin_template,
 
-	TP_ARGS(order, gfp_flags)
+	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
+
+	TP_ARGS(order, gfp_flags, memcg),
+
+	TP_STRUCT__entry(
+		__field(int, order)
+		__field(unsigned long, gfp_flags)
+		__field(ino_t, ino)
+	),
+
+	TP_fast_assign(
+		__entry->order = order;
+		__entry->gfp_flags = (__force unsigned long)gfp_flags;
+		__entry->ino = cgroup_ino(memcg->css.cgroup);
+	),
+
+	TP_printk("order=%d gfp_flags=%s memcg=%ld",
+		__entry->order,
+		show_gfp_flags(__entry->gfp_flags),
+		__entry->ino)
 );
 
-DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
 
-	TP_ARGS(order, gfp_flags)
+	TP_ARGS(order, gfp_flags, memcg)
+);
+
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
+
+	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
+
+	TP_ARGS(order, gfp_flags, memcg)
 );
+
 #endif /* CONFIG_MEMCG */
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
@@ -181,19 +207,42 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_direct_reclaim_end
 );
 
 #ifdef CONFIG_MEMCG
-DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_end_template,
 
-	TP_ARGS(nr_reclaimed)
+	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
+
+	TP_ARGS(nr_reclaimed, memcg),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, nr_reclaimed)
+		__field(ino_t, ino)
+	),
+
+	TP_fast_assign(
+		__entry->nr_reclaimed = nr_reclaimed;
+		__entry->ino = cgroup_ino(memcg->css.cgroup);
+	),
+
+	TP_printk("nr_reclaimed=%lu memcg=%ld",
+		__entry->nr_reclaimed,
+		__entry->ino)
 );
 
-DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_reclaim_end,
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
 
-	TP_ARGS(nr_reclaimed)
+	TP_ARGS(nr_reclaimed, memcg)
 );
+
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_reclaim_end,
+
+	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
+
+	TP_ARGS(nr_reclaimed, memcg)
+);
+
 #endif /* CONFIG_MEMCG */
 
 TRACE_EVENT(mm_shrink_slab_start,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568b..45780952f4b5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7088,8 +7088,8 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	sc.gfp_mask = (gfp_mask & GFP_RECLAIM_MASK) |
 			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
 
-	trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
-						      sc.gfp_mask);
+	trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order, sc.gfp_mask,
+						      memcg);
 
 	/*
 	 * NOTE: Although we can get the priority field, using it
@@ -7100,7 +7100,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 */
 	shrink_lruvec(lruvec, &sc);
 
-	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
+	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed, memcg);
 
 	*nr_scanned = sc.nr_scanned;
 
@@ -7134,13 +7134,13 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
+	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask, memcg);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
+	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed, memcg);
 	set_task_reclaim_state(current, NULL);
 
 	return nr_reclaimed;
-- 
2.36.0


