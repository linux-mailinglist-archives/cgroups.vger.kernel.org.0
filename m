Return-Path: <cgroups+bounces-5090-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063649979AF
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 02:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F40CB20D25
	for <lists+cgroups@lfdr.de>; Thu, 10 Oct 2024 00:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E592911712;
	Thu, 10 Oct 2024 00:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kBzn2ELn"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F61C144
	for <cgroups@vger.kernel.org>; Thu, 10 Oct 2024 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728520594; cv=none; b=pML9JHJlQztrHZPkFq4nQVfy1+Kd5f4ehauRKfZoBMZ3y6LGUkfFKmmjO5gEGbxh60lYnpLR2wn0Nbl9AH8sHpt3Tn/gBA8UbRRASDTzAt23/S91XcfYDOkAgqdlbCWdXEz1BNtfZl/zjIYrSj8sl/5fYHb4iHUeeZry0+4Dh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728520594; c=relaxed/simple;
	bh=R+xzyQ94QsdT6lNQ0WgQFG0zxvIKIkFmW8mQuSTVZhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvZNH+9pvLY1ukJwwIuVLzTmQEqYw/5Ry3y2q2SM4ExjxD33bxPItYWnwbMsLQ6Wz7uGXESr922PyWCPUV6qSbUR4DADr5W2mxQCgc7Ta5wAqZb8pEYNGZ7Pnh5Nytm7Rk0mAH725NEDiPjUtKTxHuE9279/A1HF7z4XlAPFL68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kBzn2ELn; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728520588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E4azzCPSUP2ym5GbRLYr6Ea8ttlwwCo8y2/9zZR2OjY=;
	b=kBzn2ELnca3IMfd44T9vN70huxNFinLsPBYXxBTonV6AZLRrQ/yXoCUIuADpphbCHwN+GV
	eJQXbweYBN/8Vk8rrPstw9HqODQxcXxhf96pFu++SblmDmUJh6Oe7vaDHnzyeLxlCWVFrW
	DTFZlrso4hRz/xaS4Qv6GJDamWGhc3U=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	JP Kobryn <inwardvessel@gmail.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: add tracing for memcg stat updates
Date: Wed,  9 Oct 2024 17:35:50 -0700
Message-ID: <20241010003550.3695245-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg stats are maintained in rstat infrastructure which provides
very fast updates side and reasonable read side. However memcg added
plethora of stats and made the read side, which is cgroup rstat flush,
very slow. To solve that, threshold was added in the memcg stats read
side i.e. no need to flush the stats if updates are within the
threshold.

This threshold based improvement worked for sometime but more stats were
added to memcg and also the read codepath was getting triggered in the
performance sensitive paths which made threshold based ratelimiting
ineffective. We need more visibility into the hot and cold stats i.e.
stats with a lot of updates. Let's add trace to get that visibility.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/trace/events/memcg.h | 59 ++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c              | 13 ++++++--
 2 files changed, 70 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/memcg.h

diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
new file mode 100644
index 000000000000..913db9aba580
--- /dev/null
+++ b/include/trace/events/memcg.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM memcg
+
+#if !defined(_TRACE_MEMCG_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MEMCG_H
+
+#include <linux/memcontrol.h>
+#include <linux/tracepoint.h>
+
+
+DECLARE_EVENT_CLASS(memcg_rstat,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+
+	TP_ARGS(memcg, item, val),
+
+	TP_STRUCT__entry(
+		__field(u64, id)
+		__field(int, item)
+		__field(int, val)
+	),
+
+	TP_fast_assign(
+		__entry->id = cgroup_id(memcg->css.cgroup);
+		__entry->item = item;
+		__entry->val = val;
+	),
+
+	TP_printk("memcg_id=%llu item=%d val=%d",
+		  __entry->id, __entry->item, __entry->val)
+);
+
+DEFINE_EVENT(memcg_rstat, mod_memcg_state,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+
+	TP_ARGS(memcg, item, val)
+);
+
+DEFINE_EVENT(memcg_rstat, mod_memcg_lruvec_state,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+
+	TP_ARGS(memcg, item, val)
+);
+
+DEFINE_EVENT(memcg_rstat, count_memcg_events,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+
+	TP_ARGS(memcg, item, val)
+);
+
+
+#endif /* _TRACE_MEMCG_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c098fd7f5c5e..17af08367c68 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -71,6 +71,10 @@
 
 #include <linux/uaccess.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/memcg.h>
+#undef CREATE_TRACE_POINTS
+
 #include <trace/events/vmscan.h>
 
 struct cgroup_subsys memory_cgrp_subsys __read_mostly;
@@ -682,7 +686,9 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
-	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
+	val = memcg_state_val_in_pages(idx, val);
+	memcg_rstat_updated(memcg, val);
+	trace_mod_memcg_state(memcg, idx, val);
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -741,7 +747,9 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
 
-	memcg_rstat_updated(memcg, memcg_state_val_in_pages(idx, val));
+	val = memcg_state_val_in_pages(idx, val);
+	memcg_rstat_updated(memcg, val);
+	trace_mod_memcg_lruvec_state(memcg, idx, val);
 	memcg_stats_unlock();
 }
 
@@ -832,6 +840,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	memcg_stats_lock();
 	__this_cpu_add(memcg->vmstats_percpu->events[i], count);
 	memcg_rstat_updated(memcg, count);
+	trace_count_memcg_events(memcg, idx, count);
 	memcg_stats_unlock();
 }
 
-- 
2.43.5


