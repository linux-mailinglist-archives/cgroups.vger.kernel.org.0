Return-Path: <cgroups+bounces-507-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533D97F4326
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 11:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7172B20FB4
	for <lists+cgroups@lfdr.de>; Wed, 22 Nov 2023 10:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9860B54BD0;
	Wed, 22 Nov 2023 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="U2cR+jny"
X-Original-To: cgroups@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8ED6A;
	Wed, 22 Nov 2023 02:02:07 -0800 (PST)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 2BF7912007A;
	Wed, 22 Nov 2023 13:02:06 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 2BF7912007A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1700647326;
	bh=gpgaCxHlI+b2COEC+6FpbgcB+0fsnGeeLl3cqShaJqM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=U2cR+jnyFbVSzokJr22L16YfRk74aZVdMuKPLIDW3i2hdsMEGqhTka7lSAcD1g7oN
	 z2fv1tAsNgBKodod7yLz0WGHRNZ8gq8n1M5u4/xt0vAf/N8fubkhsGuVdxTJJ60mEh
	 khZTlInYrQnkPAqvmUR8tsBUNwLEF9LklqKdr9RH8xu5M3kZAIyIJ+45UK4zy0vUHM
	 RFmVf4Ms267OyFVzFgAJXCHnIvGz5UB96iFfP3MHVwODner3M1vXSvnbdsyG+zCAyF
	 bM12FaKE4cwOJPq3reOyAsKTYOA1t3jxeLOtSpSDEb0yBRXobevAbGBHsbZONIlxba
	 qXQIQhmVNh7yQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 22 Nov 2023 13:02:06 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 22 Nov 2023 13:02:05 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 2/2] mm: memcg: introduce new event to trace shrink_memcg
Date: Wed, 22 Nov 2023 13:01:56 +0300
Message-ID: <20231122100156.6568-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231122100156.6568-1-ddrokosov@salutedevices.com>
References: <20231122100156.6568-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181525 [Nov 22 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 3 0.3.3 e5c6a18a9a9bff0226d530c5b790210c0bd117c8, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/22 05:48:00 #22499758
X-KSMG-AntiVirus-Status: Clean, skipped

The shrink_memcg flow plays a crucial role in memcg reclamation.
Currently, it is not possible to trace this point from non-direct
reclaim paths. However, direct reclaim has its own tracepoint, so there
is no issue there. In certain cases, when debugging memcg pressure,
developers may need to identify all potential requests for memcg
reclamation including kswapd(). The patchset introduces the tracepoints
mm_vmscan_memcg_shrink_{begin|end}() to address this problem.

Example of output in the kswapd context (non-direct reclaim):
    kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=test
    kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: nr_reclaimed=0 memcg=test
    kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=test
    kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: nr_reclaimed=1 memcg=test
    kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=test
    kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: nr_reclaimed=4 memcg=test
    kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=test
    kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: nr_reclaimed=11 memcg=test
    kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=test
    kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: nr_reclaimed=25 memcg=test
    kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: order=0 gfp_flags=GFP_KERNEL memcg=test
    kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: nr_reclaimed=53 memcg=test

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 include/trace/events/vmscan.h | 14 ++++++++++++++
 mm/vmscan.c                   | 11 +++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 9b49cd120ae9..cb39b4f0dca9 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -182,6 +182,13 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_r
 	TP_ARGS(order, gfp_flags, memcg)
 );
 
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_shrink_begin,
+
+	TP_PROTO(int order, gfp_t gfp_flags, const struct mem_cgroup *memcg),
+
+	TP_ARGS(order, gfp_flags, memcg)
+);
+
 #endif /* CONFIG_MEMCG */
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
@@ -247,6 +254,13 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_rec
 	TP_ARGS(nr_reclaimed, memcg)
 );
 
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_shrink_end,
+
+	TP_PROTO(unsigned long nr_reclaimed, const struct mem_cgroup *memcg),
+
+	TP_ARGS(nr_reclaimed, memcg)
+);
+
 #endif /* CONFIG_MEMCG */
 
 TRACE_EVENT(mm_shrink_slab_start,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 45780952f4b5..6d89b39d9a91 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6461,6 +6461,12 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		cond_resched();
 
+#ifdef CONFIG_MEMCG
+		trace_mm_vmscan_memcg_shrink_begin(sc->order,
+						   sc->gfp_mask,
+						   memcg);
+#endif
+
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
@@ -6491,6 +6497,11 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
 
+#ifdef CONFIG_MEMCG
+		trace_mm_vmscan_memcg_shrink_end(sc->nr_reclaimed - reclaimed,
+						 memcg);
+#endif
+
 		/* Record the group's reclaim efficiency */
 		if (!sc->proactive)
 			vmpressure(sc->gfp_mask, memcg, false,
-- 
2.36.0


