Return-Path: <cgroups+bounces-540-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941787F67AA
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 20:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C333A1C20DC6
	for <lists+cgroups@lfdr.de>; Thu, 23 Nov 2023 19:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF814CE0E;
	Thu, 23 Nov 2023 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="UDEGgq7W"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF9FD5A;
	Thu, 23 Nov 2023 11:39:47 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 30808120011;
	Thu, 23 Nov 2023 22:39:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 30808120011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700768386;
	bh=fGDBCiKmSTE+7SXnjipAsp+7eqI2bC5r1hZ9/0vsdks=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=UDEGgq7WizGwhy3OIZgsMiqkZLcTpueDXg7U2Imd1cfixaVQx4o6vVtmX9T1OzYn1
	 T3A4mqAHGm9OWkx7niV8FtJqfMR2DJjvS6R9vZDw2KAfyfRXl5zmKpuNnJsdzRS5jF
	 pFvpyVd4N7VZYKBl3OXBfLrJeuWt/DFIb1jSYICCO52ubgfO5r8HLBQ+JBvTtOVASw
	 g4kI659Jm40D3Rymt6ELCvngjiSmu/QowWf0vNBZsdLvQpXVby0ndm3np0MKZOaNiU
	 UlxVGJQk71a2iyk08KherA4MzmRSDRLJczMDB1C3zFxkE8dHfqpZCspqFBPmQAt2ut
	 s7WQ4D7dm3bGg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 23 Nov 2023 22:39:46 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 Nov 2023 22:39:45 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <mhocko@suse.com>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v3 2/2] mm: memcg: introduce new event to trace shrink_memcg
Date: Thu, 23 Nov 2023 22:39:37 +0300
Message-ID: <20231123193937.11628-3-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 4 0.3.4 720d3c21819df9b72e78f051e300e232316d302a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/23 17:02:00 #22509098
X-KSMG-AntiVirus-Status: Clean, skipped

The shrink_memcg flow plays a crucial role in memcg reclamation.
Currently, it is not possible to trace this point from non-direct
reclaim paths. However, direct reclaim has its own tracepoint, so there
is no issue there. In certain cases, when debugging memcg pressure,
developers may need to identify all potential requests for memcg
reclamation including kswapd(). The patchset introduces the tracepoints
mm_vmscan_memcg_shrink_{begin|end}() to address this problem.

Example of output in the kswapd context (non-direct reclaim):
    kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
    kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=16
    kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
    kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=16
    kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
    kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=16
    kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
    kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=16
    kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
    kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=16
    kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=16
    kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=16

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 include/trace/events/vmscan.h | 22 ++++++++++++++++++++++
 mm/vmscan.c                   |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index e9093fa1c924..a4686afe571d 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -180,6 +180,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_r
 	TP_ARGS(order, gfp_flags, memcg)
 );
 
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_shrink_begin,
+
+	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
+
+	TP_ARGS(order, gfp_flags, memcg)
+);
+
+#else
+
+#define trace_mm_vmscan_memcg_shrink_begin(...)
+
 #endif /* CONFIG_MEMCG */
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
@@ -243,6 +254,17 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_rec
 	TP_ARGS(nr_reclaimed, memcg)
 );
 
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_shrink_end,
+
+	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
+
+	TP_ARGS(nr_reclaimed, memcg)
+);
+
+#else
+
+#define trace_mm_vmscan_memcg_shrink_end(...)
+
 #endif /* CONFIG_MEMCG */
 
 TRACE_EVENT(mm_shrink_slab_start,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 45780952f4b5..f7e3ddc5a7ad 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6461,6 +6461,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		cond_resched();
 
+		trace_mm_vmscan_memcg_shrink_begin(sc->order,
+						   sc->gfp_mask,
+						   memcg);
+
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
@@ -6491,6 +6495,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
 
+		trace_mm_vmscan_memcg_shrink_end(sc->nr_reclaimed - reclaimed,
+						 memcg);
+
 		/* Record the group's reclaim efficiency */
 		if (!sc->proactive)
 			vmpressure(sc->gfp_mask, memcg, false,
-- 
2.36.0


