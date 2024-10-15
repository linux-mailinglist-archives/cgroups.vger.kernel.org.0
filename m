Return-Path: <cgroups+bounces-5132-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CDC99FA6D
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 23:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB731F223AD
	for <lists+cgroups@lfdr.de>; Tue, 15 Oct 2024 21:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A0C22912E;
	Tue, 15 Oct 2024 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tq5qugG3"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF32122910D
	for <cgroups@vger.kernel.org>; Tue, 15 Oct 2024 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028271; cv=none; b=PtSlDB1vOxuGhwrabPnIeQvm+2nm7idnVDIywQBrIbIGX7guJtcBwXk3BR4UN3ezuL2/+5GPU1Q5yT7neCQRZkTyTX4S2v+A+AG2v6k2igxVlFo5jpSxNtUleS6yaUZfm4m3Ir6AkD1RLCEOOh4Zgsc2Jg6DfohnMQjd+It1zBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028271; c=relaxed/simple;
	bh=0UL++Gv2Ddo3rS6Nlwye9qh95QgpHjox9QWlt7Vn/W8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C4v6ylNOdZzXWUKnjPJUmc4YJun0GbmDR1zw3GjwCTOUyDO9amkJmyuBMfF7mWpeolrIFUA4+mIXW/qBG5bQdWoBykLP2ZfEzb4haY73eevmqdbbLbOOCu342W2gQjM27749ivk+9tNHE9IvDwN3APRFInCkrJsZGyHa1sRY7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tq5qugG3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729028266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bHLO0k40DlJvpKFDxsDix1kd1cXxAKJ76NZ9bnkBv4A=;
	b=Tq5qugG3KRstaJyKB2v7jem16OWo8hf1FE8Bk2YQgzaNsn5L5Hdh3YJAV1LW5CvgVMAUFm
	lf8psQxJxgAbqSinP0BMINvR6tRlx5cLmVZ/kcL4mCx3EKc/46+SZIu/HHOPv4O17G1fKs
	3jK+DM+OnL4o4CnT1FCz/hLi3lrc+pI=
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
	Meta kernel team <kernel-team@meta.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] memcg: add tracing for memcg stat updates
Date: Tue, 15 Oct 2024 14:37:21 -0700
Message-ID: <20241015213721.3804209-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The memcg stats are maintained in rstat infrastructure which provides very
fast updates side and reasonable read side.  However memcg added plethora
of stats and made the read side, which is cgroup rstat flush, very slow.
To solve that, threshold was added in the memcg stats read side i.e.  no
need to flush the stats if updates are within the threshold.

This threshold based improvement worked for sometime but more stats were
added to memcg and also the read codepath was getting triggered in the
performance sensitive paths which made threshold based ratelimiting
ineffective.  We need more visibility into the hot and cold stats i.e.
stats with a lot of updates.  Let's add trace to get that visibility.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: JP Kobryn <inwardvessel@gmail.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changes since v1:
- Used unsigned long type for memcg_rstat_events (Yosry)
- Kept the Acks and Reviews tag

 include/trace/events/memcg.h | 81 ++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c              | 13 +++++-
 2 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/memcg.h

diff --git a/include/trace/events/memcg.h b/include/trace/events/memcg.h
new file mode 100644
index 000000000000..8667e57816d2
--- /dev/null
+++ b/include/trace/events/memcg.h
@@ -0,0 +1,81 @@
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
+DECLARE_EVENT_CLASS(memcg_rstat_stats,
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
+DEFINE_EVENT(memcg_rstat_stats, mod_memcg_state,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+
+	TP_ARGS(memcg, item, val)
+);
+
+DEFINE_EVENT(memcg_rstat_stats, mod_memcg_lruvec_state,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, int val),
+
+	TP_ARGS(memcg, item, val)
+);
+
+DECLARE_EVENT_CLASS(memcg_rstat_events,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, unsigned long val),
+
+	TP_ARGS(memcg, item, val),
+
+	TP_STRUCT__entry(
+		__field(u64, id)
+		__field(int, item)
+		__field(unsigned long, val)
+	),
+
+	TP_fast_assign(
+		__entry->id = cgroup_id(memcg->css.cgroup);
+		__entry->item = item;
+		__entry->val = val;
+	),
+
+	TP_printk("memcg_id=%llu item=%d val=%lu",
+		  __entry->id, __entry->item, __entry->val)
+);
+
+DEFINE_EVENT(memcg_rstat_events, count_memcg_events,
+
+	TP_PROTO(struct mem_cgroup *memcg, int item, unsigned long val),
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


