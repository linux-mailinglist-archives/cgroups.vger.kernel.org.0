Return-Path: <cgroups+bounces-9747-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E67BB46475
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239A61BC3206
	for <lists+cgroups@lfdr.de>; Fri,  5 Sep 2025 20:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1B213E90;
	Fri,  5 Sep 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QV2b/Sbb"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712221F4262
	for <cgroups@vger.kernel.org>; Fri,  5 Sep 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757103385; cv=none; b=K+zwWPgtetjQxmFpVbPoxhdkUcOWlvQzzg924oHVOhuI0aR5fnqmY1tQx1qDhfbrHG9A1/jaZdy6mYMPDxAX1xg8SkeUq2382vi/X0d0uARRumFVCS2jHuC+4+vP/DBwfTFPsW6zSb4PSj4+BloetpR2cE8O38jsOsBf9n7pw4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757103385; c=relaxed/simple;
	bh=PYydNVuJVxyjN/9o+HwTZKEJHyaF9EPelKAywftw3Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EQGdTbGrY6HrdKXOgwKfIirj0nftr7zit5xjBcx8xpms4I8rpiPoy5JcIFMPsM/nLBXJ1cnXk4p/Bn0D0Di04jgb43I4Crz0H/hIl6SrnkhqOsMLqUqswaIirlgfukB0bDoFticTf3I2aJhAZqkXm+/a+avS6ZHoVMQu7oBoamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QV2b/Sbb; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757103380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3YYDb0qAcN44JOLdZSoQVTNxvRczokE6j4vJhbAzTIg=;
	b=QV2b/Sbb4ipL5cZ9a9yJcNo8hdOASLTVa0TacgojNu7sZz20c2/nXWVL6boHbYt6djjB1S
	/OSgqE5jk4RYujgEEObAjaPqUIlE0+Uct8TGkoUtVptEPursmz+4wJNShlouI3aDznj5Ur
	xykcBXyVbRz92uQuPK1tNJxXM8sExhY=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Peilin Ye <yepeilin@google.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Date: Fri,  5 Sep 2025 13:16:06 -0700
Message-ID: <20250905201606.66198-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Generally memcg charging is allowed from all the contexts including NMI
where even spinning on spinlock can cause locking issues. However one
call chain was missed during the addition of memcg charging from any
context support. That is try_charge_memcg() -> memcg_memory_event() ->
cgroup_file_notify().

The possible function call tree under cgroup_file_notify() can acquire
many different spin locks in spinning mode. Some of them are
cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
just skip cgroup_file_notify() from memcg charging if the context does
not allow spinning.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 23 ++++++++++++++++-------
 mm/memcontrol.c            |  7 ++++---
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 9dc5b52672a6..054fa34c936a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -993,22 +993,25 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
 	count_memcg_events_mm(mm, idx, 1);
 }
 
-static inline void memcg_memory_event(struct mem_cgroup *memcg,
-				      enum memcg_memory_event event)
+static inline void __memcg_memory_event(struct mem_cgroup *memcg,
+					enum memcg_memory_event event,
+					bool allow_spinning)
 {
 	bool swap_event = event == MEMCG_SWAP_HIGH || event == MEMCG_SWAP_MAX ||
 			  event == MEMCG_SWAP_FAIL;
 
 	atomic_long_inc(&memcg->memory_events_local[event]);
-	if (!swap_event)
+	if (!swap_event && allow_spinning)
 		cgroup_file_notify(&memcg->events_local_file);
 
 	do {
 		atomic_long_inc(&memcg->memory_events[event]);
-		if (swap_event)
-			cgroup_file_notify(&memcg->swap_events_file);
-		else
-			cgroup_file_notify(&memcg->events_file);
+		if (allow_spinning) {
+			if (swap_event)
+				cgroup_file_notify(&memcg->swap_events_file);
+			else
+				cgroup_file_notify(&memcg->events_file);
+		}
 
 		if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 			break;
@@ -1018,6 +1021,12 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
 		 !mem_cgroup_is_root(memcg));
 }
 
+static inline void memcg_memory_event(struct mem_cgroup *memcg,
+				      enum memcg_memory_event event)
+{
+	__memcg_memory_event(memcg, event, true);
+}
+
 static inline void memcg_memory_event_mm(struct mm_struct *mm,
 					 enum memcg_memory_event event)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 257d2c76b730..dd5cd9d352f3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2306,12 +2306,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	bool raised_max_event = false;
 	unsigned long pflags;
+	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
 
 retry:
 	if (consume_stock(memcg, nr_pages))
 		return 0;
 
-	if (!gfpflags_allow_spinning(gfp_mask))
+	if (!allow_spinning)
 		/* Avoid the refill and flush of the older stock */
 		batch = nr_pages;
 
@@ -2347,7 +2348,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (!gfpflags_allow_blocking(gfp_mask))
 		goto nomem;
 
-	memcg_memory_event(mem_over_limit, MEMCG_MAX);
+	__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
 	raised_max_event = true;
 
 	psi_memstall_enter(&pflags);
@@ -2414,7 +2415,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * a MEMCG_MAX event.
 	 */
 	if (!raised_max_event)
-		memcg_memory_event(mem_over_limit, MEMCG_MAX);
+		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
 
 	/*
 	 * The allocation either can't fail or will lead to more memory
-- 
2.47.3


