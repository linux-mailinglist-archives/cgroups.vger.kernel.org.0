Return-Path: <cgroups+bounces-10973-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA500BF944B
	for <lists+cgroups@lfdr.de>; Wed, 22 Oct 2025 01:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EF4918A7DF6
	for <lists+cgroups@lfdr.de>; Tue, 21 Oct 2025 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF202C15BB;
	Tue, 21 Oct 2025 23:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m77/AqGx"
X-Original-To: cgroups@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3002BE64C
	for <cgroups@vger.kernel.org>; Tue, 21 Oct 2025 23:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090294; cv=none; b=Y7piy3thwnjDi/Raq6DPJJ3NhgrHwqCgNmaMSbZ9OedFI7LsqWRtGbdu8lqYFWL8L9Ek0BrouOr+dRmH2bbQs168Lxbeb1nUR6UZRBudPYfZWFO+1kTyW9U4w62oqwEqnCCz9jJxUZhywWLJuvqrPc/8bx/55tCIwZndfeaRsME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090294; c=relaxed/simple;
	bh=92IgDehqE5ut21dy4TsITRyoa3CQDJ0kvVual9ynUDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pF6kQT9+KbFloMMxw45QGQ0hzEVc3Pp7wlRTYaQVe8/SmXX8aO2TorHbz8vI4CjJIpgTaSCUPIZczM5jI3sHGpjoAt70h+efPoTZVGtcfkmQFtgPiagIHCW6jMZWL5/eVbIEf8OPZxKedo2JmY4NBG3yXQMjg5n3GqlC13bHYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m77/AqGx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761090288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0m7npUBSf5o4yjDCd8zm+922gGFcJ0A29MB3XlxsDkQ=;
	b=m77/AqGxEWO9nu0IM9sZqAjEg3798PSwzQclIVvw50s1wbc0OEs1BlytuEp/FS9nWlYYyM
	RxxW7wBJu9Jbehs44nvPGpt9S4HMV+oPILVkqf6hJd2eJESXgmwMDxDVixuBCAQ9vNNUhU
	Qzic/zCOzHxspVLRor4yTB0I3MbiebM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: manually uninline __memcg_memory_event
Date: Tue, 21 Oct 2025 16:44:25 -0700
Message-ID: <20251021234425.1885471-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function __memcg_memory_event has been unnecessarily marked inline
even when it is not really performance critical. It is usually called
to track extreme conditions. Over the time, it has evolved to include
more functionality and inlining it is causing more harm.

Before the patch:
$ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
   text    data     bss     dec     hex filename
  35645   10574    4192   50411    c4eb mm/memcontrol.o
  54738    1658       0   56396    dc4c net/ipv4/tcp_input.o
  34644    1065       0   35709    8b7d net/ipv4/tcp_output.o

After the patch:
$ size mm/memcontrol.o net/ipv4/tcp_input.o net/ipv4/tcp_output.o
   text    data     bss     dec     hex filename
  35137   10446    4192   49775    c26f mm/memcontrol.o
  54322    1562       0   55884    da4c net/ipv4/tcp_input.o
  34492    1017       0   35509    8ab5 net/ipv4/tcp_output.o

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 32 ++------------------------------
 mm/memcontrol.c            | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d37e7c93bb8c..8d2e250535a8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1002,36 +1002,8 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 	count_memcg_events_mm(mm, idx, 1);
 }
 
-static inline void __memcg_memory_event(struct mem_cgroup *memcg,
-					enum memcg_memory_event event,
-					bool allow_spinning)
-{
-	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
-			  event == MEMCG_SWAP_FAIL;
-
-	/* For now only MEMCG_MAX can happen with !allow_spinning context. */
-	VM_WARN_ON_ONCE(!allow_spinning && event != MEMCG_MAX);
-
-	atomic_long_inc(&memcg->memory_events_local[event]);
-	if (!swap_event && allow_spinning)
-		cgroup_file_notify(&memcg->events_local_file);
-
-	do {
-		atomic_long_inc(&memcg->memory_events[event]);
-		if (allow_spinning) {
-			if (swap_event)
-				cgroup_file_notify(&memcg->swap_events_file);
-			else
-				cgroup_file_notify(&memcg->events_file);
-		}
-
-		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
-			break;
-		if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
-			break;
-	} while ((memcg = parent_mem_cgroup(memcg)) &&
-		 !mem_cgroup_is_root(memcg));
-}
+void __memcg_memory_event(struct mem_cgroup *memcg,
+			  enum memcg_memory_event event, bool allow_spinning);
 
 static inline void memcg_memory_event(struct mem_cgroup *memcg,
 				      enum memcg_memory_event event)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1a95049d8b88..93f7c76f0ce9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1626,6 +1626,37 @@ unsigned long mem_cgroup_size(struct mem_cgroup *memcg)
 	return page_counter_read(&memcg->memory);
 }
 
+void __memcg_memory_event(struct mem_cgroup *memcg,
+			  enum memcg_memory_event event, bool allow_spinning)
+{
+	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
+			  event == MEMCG_SWAP_FAIL;
+
+	/* For now only MEMCG_MAX can happen with !allow_spinning context. */
+	VM_WARN_ON_ONCE(!allow_spinning && event != MEMCG_MAX);
+
+	atomic_long_inc(&memcg->memory_events_local[event]);
+	if (!swap_event && allow_spinning)
+		cgroup_file_notify(&memcg->events_local_file);
+
+	do {
+		atomic_long_inc(&memcg->memory_events[event]);
+		if (allow_spinning) {
+			if (swap_event)
+				cgroup_file_notify(&memcg->swap_events_file);
+			else
+				cgroup_file_notify(&memcg->events_file);
+		}
+
+		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
+			break;
+		if (cgrp_dfl_root.flags & CGRP_ROOT_MEMORY_LOCAL_EVENTS)
+			break;
+	} while ((memcg = parent_mem_cgroup(memcg)) &&
+		 !mem_cgroup_is_root(memcg));
+}
+EXPORT_SYMBOL(__memcg_memory_event);
+
 static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 				     int order)
 {
-- 
2.47.3


