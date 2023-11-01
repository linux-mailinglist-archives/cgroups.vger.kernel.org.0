Return-Path: <cgroups+bounces-138-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D96F7DDF60
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 11:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB82C281959
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 10:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A410954;
	Wed,  1 Nov 2023 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="hQdEufFt"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7619F79E3;
	Wed,  1 Nov 2023 10:29:01 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AA4DE;
	Wed,  1 Nov 2023 03:28:52 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 39397120033;
	Wed,  1 Nov 2023 13:28:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 39397120033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698834531;
	bh=pSKI4+L8HJRYn63UrrAYG4N/D56LntFTm89/ZK6IV24=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=hQdEufFtltMp4tP59pfpQfMZAy5u5HUeSe7wslXZZYG0+RgoZAruI5nqoFqESnayv
	 8PDojzaOXskd/K7rXMwIx6qNKqm6R5vcNxDJK681HH83Rps5sg7ya2aMBELUJAJ6+k
	 WMIv7jOTRVH3GHf7iukh+HewyvxYIkLSOb9Z4tjRH2k4Kp5IBR1TKZZ0fimlsP4pwF
	 u4noMpFQRni0uYtGrP5RH1EpCivQAkmimxBRQzhD27R6S11XCbOzTNSmO9ePcwujmk
	 QtHTqb1InR6V7SZErR2B8uCuSGeHYqP2v8FxvSROexv5DeZrnYOs7Ohb6iEczA7DlU
	 slqJr1B6XRbag==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 13:28:50 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 13:28:50 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 2/2] mm: memcg: introduce new event to trace shrink_memcg
Date: Wed, 1 Nov 2023 13:28:37 +0300
Message-ID: <20231101102837.25205-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20231101102837.25205-1-ddrokosov@salutedevices.com>
References: <20231101102837.25205-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 181040 [Nov 01 2023]
X-KSMG-AntiSpam-Version: 6.0.0.2
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 06:18:00 #22376334
X-KSMG-AntiVirus-Status: Clean, skipped

The shrink_memcg flow plays a crucial role in memcg reclamation.
Currently, it is not possible to trace this point from non-direct
reclaim paths. However, direct reclaim has its own tracepoint, so there
is no issue there. In certain cases, when debugging memcg pressure,
developers may need to identify all potential requests for memcg
reclamation including kswapd(). The patchset introduces the tracepoints
mm_vmscan_memcg_shrink_{begin|end}() to address this problem.

Example of output in the kswapd context (non-direct reclaim):
    kswapd0-39      [001] .....   240.356378: mm_vmscan_memcg_shrink_begin: memcg=test order=0 gfp_flags=GFP_KERNEL
    kswapd0-39      [001] .....   240.356396: mm_vmscan_memcg_shrink_end: memcg=test nr_reclaimed=0
    kswapd0-39      [001] .....   240.356420: mm_vmscan_memcg_shrink_begin: memcg=test oorder=0 gfp_flags=GFP_KERNEL
    kswapd0-39      [001] .....   240.356454: mm_vmscan_memcg_shrink_end: memcg=test nr_reclaimed=1
    kswapd0-39      [001] .....   240.356479: mm_vmscan_memcg_shrink_begin: memcg=test oorder=0 gfp_flags=GFP_KERNEL
    kswapd0-39      [001] .....   240.356506: mm_vmscan_memcg_shrink_end: memcg=test nr_reclaimed=4
    kswapd0-39      [001] .....   240.356525: mm_vmscan_memcg_shrink_begin: memcg=test oorder=0 gfp_flags=GFP_KERNEL
    kswapd0-39      [001] .....   240.356593: mm_vmscan_memcg_shrink_end: memcg=test nr_reclaimed=11
    kswapd0-39      [001] .....   240.356614: mm_vmscan_memcg_shrink_begin: memcg=test oorder=0 gfp_flags=GFP_KERNEL
    kswapd0-39      [001] .....   240.356738: mm_vmscan_memcg_shrink_end: memcg=test nr_reclaimed=25
    kswapd0-39      [001] .....   240.356790: mm_vmscan_memcg_shrink_begin: memcg=test oorder=0 gfp_flags=GFP_KERNEL
    kswapd0-39      [001] .....   240.357125: mm_vmscan_memcg_shrink_end: memcg=test nr_reclaimed=53

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 include/trace/events/vmscan.h | 14 ++++++++++++++
 mm/vmscan.c                   |  7 +++++++
 2 files changed, 21 insertions(+)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index 124bc22866c8..518e7232c9eb 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -182,6 +182,13 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_r
 	TP_ARGS(memcg, order, gfp_flags)
 );
 
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_shrink_begin,
+
+	TP_PROTO(const struct mem_cgroup *memcg, int order, gfp_t gfp_flags),
+
+	TP_ARGS(memcg, order, gfp_flags)
+);
+
 #endif /* CONFIG_MEMCG */
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
@@ -247,6 +254,13 @@ DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_rec
 	TP_ARGS(memcg, nr_reclaimed)
 );
 
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_shrink_end,
+
+	TP_PROTO(const struct mem_cgroup *memcg, unsigned long nr_reclaimed),
+
+	TP_ARGS(memcg, nr_reclaimed)
+);
+
 #endif /* CONFIG_MEMCG */
 
 TRACE_EVENT(mm_shrink_slab_start,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4309eaf188b4..6b9619922dfb 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6461,6 +6461,10 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		 */
 		cond_resched();
 
+		trace_mm_vmscan_memcg_shrink_begin(memcg,
+						   sc->order,
+						   sc->gfp_mask);
+
 		mem_cgroup_calculate_protection(target_memcg, memcg);
 
 		if (mem_cgroup_below_min(target_memcg, memcg)) {
@@ -6491,6 +6495,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
 		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
 			    sc->priority);
 
+		trace_mm_vmscan_memcg_shrink_end(memcg,
+						 sc->nr_reclaimed - reclaimed);
+
 		/* Record the group's reclaim efficiency */
 		if (!sc->proactive)
 			vmpressure(sc->gfp_mask, memcg, false,
-- 
2.25.1


