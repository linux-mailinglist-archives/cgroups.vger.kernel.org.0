Return-Path: <cgroups+bounces-10366-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26859B936C1
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 00:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9EB188E72B
	for <lists+cgroups@lfdr.de>; Mon, 22 Sep 2025 22:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5EC2F83C2;
	Mon, 22 Sep 2025 22:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZIesPBQ0"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5234D1E502
	for <cgroups@vger.kernel.org>; Mon, 22 Sep 2025 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758578552; cv=none; b=oih4Ni+s5kVBa134yEzGT//ijWBIY0DKex6eRN51gin+JGVQu2Ksp92LxyFsr+u7TvgnjZV7HdAt6xrqcdLCwBzrAjTosB2TtKLkUFj5dqfx4BKmHEfhKdWKU24HbUGyyEx0FcMAikUWGmqL18VtT9brStA2XHxRf7vXeB6Xicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758578552; c=relaxed/simple;
	bh=LWWy1NSMrdokOxRy9TWCPxhDNVSdaHvZSyTj7oBWRf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mPLkxm5Z+C5YaGX6URlZaGh0J7Rnn5cnD7DsF6LX0ilrXWkLZs0AI3/qzzX98EFeqSlh6CpS5PPZJ2ytn2DUtwdIWmw6q6orz9Tqi0X5qwpjVSiMsTytIvfSEolqgEx2Y8phSINWN1XIH78EE/taV3JY5ZfPtP5UYV4o8XTLkMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZIesPBQ0; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758578536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LvQMnsu791EG1tpjwy9I3544++reF65dwLMnGRELwws=;
	b=ZIesPBQ0zAl1Vmukqxmtt0XIK/MVh1ffyqQa8stAcXpFk9CsnyvK3u7hKV5bkDVd50Tz9d
	518QauXNlAT2j4sE8owNxzkvVG0kvid9zfQUuEIbqqYr7Or6i+wsuhQ7AAQ3ymIsoYuF80
	BhhlByeyTe56tg6TFdwmWHKUtJCGNNw=
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
	Meta kernel team <kernel-team@meta.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2] memcg: skip cgroup_file_notify if spinning is not allowed
Date: Mon, 22 Sep 2025 15:02:03 -0700
Message-ID: <20250922220203.261714-1-shakeel.butt@linux.dev>
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

Alternative approach was also explored where instead of skipping
cgroup_file_notify(), we defer the memcg event processing to irq_work
[1]. However it adds complexity and it was decided to keep things simple
until we need more memcg events with !allow_spinning requirement.

Link: https://lore.kernel.org/all/5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd/ [1]
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
---
Changes since v1:
- Add warning if !allow_spinning is used with memcg events other than
  MEMCG_MAX (requested by Roman)

 include/linux/memcontrol.h | 26 +++++++++++++++++++-------
 mm/memcontrol.c            |  7 ++++---
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 16fe0306e50e..873e510d6f8d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1001,22 +1001,28 @@ static inline void count_memcg_event_mm(struct mm_struct *mm,
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
 
+	/* For now only MEMCG_MAX can happen with !allow_spinning context. */
+	VM_WARN_ON_ONCE(!allow_spinning && event != MEMCG_MAX);
+
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
@@ -1026,6 +1032,12 @@ static inline void memcg_memory_event(struct mem_cgroup *memcg,
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
index e090f29eb03b..4deda33625f4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2307,12 +2307,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
 
@@ -2348,7 +2349,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (!gfpflags_allow_blocking(gfp_mask))
 		goto nomem;
 
-	memcg_memory_event(mem_over_limit, MEMCG_MAX);
+	__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
 	raised_max_event = true;
 
 	psi_memstall_enter(&pflags);
@@ -2415,7 +2416,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * a MEMCG_MAX event.
 	 */
 	if (!raised_max_event)
-		memcg_memory_event(mem_over_limit, MEMCG_MAX);
+		__memcg_memory_event(mem_over_limit, MEMCG_MAX, allow_spinning);
 
 	/*
 	 * The allocation either can't fail or will lead to more memory
-- 
2.47.3


