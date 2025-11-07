Return-Path: <cgroups+bounces-11678-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C01C41FD7
	for <lists+cgroups@lfdr.de>; Sat, 08 Nov 2025 00:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 253354E1D48
	for <lists+cgroups@lfdr.de>; Fri,  7 Nov 2025 23:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE22B314B96;
	Fri,  7 Nov 2025 23:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CJdquOFk"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A488B29E10B
	for <cgroups@vger.kernel.org>; Fri,  7 Nov 2025 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558854; cv=none; b=cAH1L0+kx7cnbtzn4pZIyPYIUx0DwU3KmQC/vRtHMi4k0I3275GULn1oGyaeqrKSTU7rXf0bcUe7y5MfTSw5F29Wy0FjsNRL8srW/I4J/eJlDXp9PHB0tEQHG2QhFheKgdcQ/x1KqobHIT0VjahK2efpjG1W6I/qH2I5VlU2GWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558854; c=relaxed/simple;
	bh=9DIh0ei5MKefQ/qdF5iYFlmczisqQRwbN9NQUjhQN+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ko7hPSf1SERjMoP7xIA6OfMjkDQGh8jsK1bWqrwnTprTwfvQoaG+0dH6/ayBrTPPLOXSfI97C+VzfKiA31iwyJweneSCSIfgSZemM/hdqyNvhSTETv2/oy8VcE5ycrzakD0vhh9KT2Dm7Xii8rnlNQle+uleiQdsw/WLrvn4+CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CJdquOFk; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762558850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/IBXXmQT6HU9XyqJOJH4DC8oXV/wM5t8TSqxI0nVn0E=;
	b=CJdquOFkgso7i4s8SSmNNC0ZzfMELSZNYUpwf6zqIIQ/zYA33bEJWPtRQaUh/8XtjGDUs2
	EbwO8BPL4v0NIoBKt6oLehSqCnJw0oTtg/tSr38hP5jijKmVa1O/VCTUrSh5Dm/NaYqI1m
	Fsqsa5stw7fanplmYSNHUSqMhB5vnPs=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] mm: memcg: dump memcg protection info on oom or alloc failures
Date: Fri,  7 Nov 2025 15:40:41 -0800
Message-ID: <20251107234041.3632644-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently kernel dumps memory state on oom and allocation failures. One
of the question usually raised on those dumps is why the kernel has not
reclaimed the reclaimable memory instead of triggering oom. One
potential reason is the usage of memory protection provided by memcg.
So, let's also dump the memory protected by the memcg in such reports to
ease the debugging.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h |  5 +++++
 mm/memcontrol.c            | 13 +++++++++++++
 mm/oom_kill.c              |  1 +
 mm/page_alloc.c            |  1 +
 4 files changed, 20 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8d2e250535a8..6861f0ff02b5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1779,6 +1779,7 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
 	return memcg ? css_is_dying(&memcg->css) : false;
 }
 
+void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg);
 #else
 static inline bool mem_cgroup_kmem_disabled(void)
 {
@@ -1850,6 +1851,10 @@ static inline bool memcg_is_dying(struct mem_cgroup *memcg)
 {
 	return false;
 }
+
+static inline void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
+{
+}
 #endif /* CONFIG_MEMCG */
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c34029e92bab..623446821b00 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5636,3 +5636,16 @@ bool mem_cgroup_node_allowed(struct mem_cgroup *memcg, int nid)
 {
 	return memcg ? cpuset_node_allowed(memcg->css.cgroup, nid) : true;
 }
+
+void mem_cgroup_show_protected_memory(struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled() || !cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	pr_warn("Memory cgroup min protection %lukB -- low protection %lukB",
+		K(atomic_long_read(&memcg->memory.children_min_usage)*PAGE_SIZE),
+		K(atomic_long_read(&memcg->memory.children_low_usage)*PAGE_SIZE));
+}
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c145b0feecc1..5eb11fbba704 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -472,6 +472,7 @@ static void dump_header(struct oom_control *oc)
 		if (should_dump_unreclaim_slab())
 			dump_unreclaimable_slab();
 	}
+	mem_cgroup_show_protected_memory(oc->memcg);
 	if (sysctl_oom_dump_tasks)
 		dump_tasks(oc);
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e4efda1158b2..26be5734253f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3977,6 +3977,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
 		filter &= ~SHOW_MEM_FILTER_NODES;
 
 	__show_mem(filter, nodemask, gfp_zone(gfp_mask));
+	mem_cgroup_show_protected_memory(NULL);
 }
 
 void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
-- 
2.47.3


