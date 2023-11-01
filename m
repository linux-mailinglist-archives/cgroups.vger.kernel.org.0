Return-Path: <cgroups+bounces-139-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 643867DDF61
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 11:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879781C20DEC
	for <lists+cgroups@lfdr.de>; Wed,  1 Nov 2023 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E7910977;
	Wed,  1 Nov 2023 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ITydPT6H"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731877473;
	Wed,  1 Nov 2023 10:29:01 +0000 (UTC)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6246E92;
	Wed,  1 Nov 2023 03:28:52 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4CE2E100002;
	Wed,  1 Nov 2023 13:28:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4CE2E100002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1698834530;
	bh=zCPacf57FSqxrGG9gY+g6RYvl7Lu5qlKOE+d98c3Zi0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ITydPT6H7oESdjce3b3rVNtP7ZXGiAvh+dWNOoFyzXQJicTPbAogyAoNAz7Sxqjep
	 AldIYSpxJUJUphdHnjU6LdtQH3ywy+ljT9eg2o9EwnGArrvT5dAvnJ2+4OP5A3nkmA
	 NJJxW8g0y9Qt+pzRuExNKn2Xj2ZEQ+7+C8y7MbFRU4btr7AAypM9j7dY3j2Rd37CzV
	 G3SmTEmFjCh8SNS2mw9BcgU3n10ulMxSLUylPS0H+ii2buOQEPRilKPxFLLXWphyHv
	 Jy4MiYmndJBkS0wgngoBkA7rmyk+IM3JmVpa6KvmwPSe5sm7hR5V7W2xTp3559i+N5
	 M3jEfjV7/rVmQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed,  1 Nov 2023 13:28:50 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Wed, 1 Nov 2023 13:28:49 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>, <hannes@cmpxchg.org>,
	<mhocko@kernel.org>, <roman.gushchin@linux.dev>, <shakeelb@google.com>,
	<muchun.song@linux.dev>, <akpm@linux-foundation.org>
CC: <kernel@sberdevices.ru>, <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v1 1/2] mm: memcg: print out cgroup name in the memcg tracepoints
Date: Wed, 1 Nov 2023 13:28:36 +0300
Message-ID: <20231101102837.25205-2-ddrokosov@salutedevices.com>
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
X-KSMG-AntiSpam-Info: LuaCore: 543 543 1e3516af5cdd92079dfeb0e292c8747a62cb1ee4, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/11/01 06:18:00 #22376334
X-KSMG-AntiVirus-Status: Clean, skipped

Sometimes it is necessary to understand in which memcg tracepoint event
occurred. The function cgroup_name() is a useful tool for this purpose.
To integrate cgroup_name() into the existing memcg tracepoints, this
patch introduces a new tracepoint template for the begin() and end()
events, utilizing static __array() to store the cgroup name.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 include/trace/events/vmscan.h | 77 +++++++++++++++++++++++++++++------
 mm/vmscan.c                   |  8 ++--
 2 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
index d2123dd960d5..124bc22866c8 100644
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -141,19 +141,47 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_direct_reclaim_b
 );
 
 #ifdef CONFIG_MEMCG
-DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_begin_template,
 
-	TP_ARGS(order, gfp_flags)
+	TP_PROTO(const struct mem_cgroup *memcg, int order, gfp_t gfp_flags),
+
+	TP_ARGS(memcg, order, gfp_flags),
+
+	TP_STRUCT__entry(
+		__field(int, order)
+		__field(unsigned long, gfp_flags)
+		__array(char, name, NAME_MAX + 1)
+	),
+
+	TP_fast_assign(
+		__entry->order = order;
+		__entry->gfp_flags = (__force unsigned long)gfp_flags;
+		cgroup_name(memcg->css.cgroup,
+			__entry->name,
+			sizeof(__entry->name));
+	),
+
+	TP_printk("memcg=%s order=%d gfp_flags=%s",
+		__entry->name,
+		__entry->order,
+		show_gfp_flags(__entry->gfp_flags))
 );
 
-DEFINE_EVENT(mm_vmscan_direct_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_reclaim_begin,
 
-	TP_PROTO(int order, gfp_t gfp_flags),
+	TP_PROTO(const struct mem_cgroup *memcg, int order, gfp_t gfp_flags),
 
-	TP_ARGS(order, gfp_flags)
+	TP_ARGS(memcg, order, gfp_flags)
+);
+
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_begin_template, mm_vmscan_memcg_softlimit_reclaim_begin,
+
+	TP_PROTO(const struct mem_cgroup *memcg, int order, gfp_t gfp_flags),
+
+	TP_ARGS(memcg, order, gfp_flags)
 );
+
 #endif /* CONFIG_MEMCG */
 
 DECLARE_EVENT_CLASS(mm_vmscan_direct_reclaim_end_template,
@@ -181,19 +209,44 @@ DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_direct_reclaim_end
 );
 
 #ifdef CONFIG_MEMCG
-DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+DECLARE_EVENT_CLASS(mm_vmscan_memcg_reclaim_end_template,
 
-	TP_ARGS(nr_reclaimed)
+	TP_PROTO(const struct mem_cgroup *memcg, unsigned long nr_reclaimed),
+
+	TP_ARGS(memcg, nr_reclaimed),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, nr_reclaimed)
+		__array(char, name, NAME_MAX + 1)
+	),
+
+	TP_fast_assign(
+		__entry->nr_reclaimed = nr_reclaimed;
+		cgroup_name(memcg->css.cgroup,
+			__entry->name,
+			sizeof(__entry->name));
+	),
+
+	TP_printk("memcg=%s nr_reclaimed=%lu",
+		__entry->name,
+		__entry->nr_reclaimed)
 );
 
-DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_memcg_softlimit_reclaim_end,
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_reclaim_end,
 
-	TP_PROTO(unsigned long nr_reclaimed),
+	TP_PROTO(const struct mem_cgroup *memcg, unsigned long nr_reclaimed),
 
-	TP_ARGS(nr_reclaimed)
+	TP_ARGS(memcg, nr_reclaimed)
 );
+
+DEFINE_EVENT(mm_vmscan_memcg_reclaim_end_template, mm_vmscan_memcg_softlimit_reclaim_end,
+
+	TP_PROTO(const struct mem_cgroup *memcg, unsigned long nr_reclaimed),
+
+	TP_ARGS(memcg, nr_reclaimed)
+);
+
 #endif /* CONFIG_MEMCG */
 
 TRACE_EVENT(mm_shrink_slab_start,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1080209a568b..4309eaf188b4 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -7088,7 +7088,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	sc.gfp_mask = (gfp_mask & GFP_RECLAIM_MASK) |
 			(GFP_HIGHUSER_MOVABLE & ~GFP_RECLAIM_MASK);
 
-	trace_mm_vmscan_memcg_softlimit_reclaim_begin(sc.order,
+	trace_mm_vmscan_memcg_softlimit_reclaim_begin(memcg, sc.order,
 						      sc.gfp_mask);
 
 	/*
@@ -7100,7 +7100,7 @@ unsigned long mem_cgroup_shrink_node(struct mem_cgroup *memcg,
 	 */
 	shrink_lruvec(lruvec, &sc);
 
-	trace_mm_vmscan_memcg_softlimit_reclaim_end(sc.nr_reclaimed);
+	trace_mm_vmscan_memcg_softlimit_reclaim_end(memcg, sc.nr_reclaimed);
 
 	*nr_scanned = sc.nr_scanned;
 
@@ -7134,13 +7134,13 @@ unsigned long try_to_free_mem_cgroup_pages(struct mem_cgroup *memcg,
 	struct zonelist *zonelist = node_zonelist(numa_node_id(), sc.gfp_mask);
 
 	set_task_reclaim_state(current, &sc.reclaim_state);
-	trace_mm_vmscan_memcg_reclaim_begin(0, sc.gfp_mask);
+	trace_mm_vmscan_memcg_reclaim_begin(memcg, 0, sc.gfp_mask);
 	noreclaim_flag = memalloc_noreclaim_save();
 
 	nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
 
 	memalloc_noreclaim_restore(noreclaim_flag);
-	trace_mm_vmscan_memcg_reclaim_end(nr_reclaimed);
+	trace_mm_vmscan_memcg_reclaim_end(memcg, nr_reclaimed);
 	set_task_reclaim_state(current, NULL);
 
 	return nr_reclaimed;
-- 
2.25.1


