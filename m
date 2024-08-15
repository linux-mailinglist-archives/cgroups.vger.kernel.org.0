Return-Path: <cgroups+bounces-4300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7BE9528C3
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 07:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 879AFB25232
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 05:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C7C13C677;
	Thu, 15 Aug 2024 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WP7X0cSU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B813A268
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698341; cv=none; b=ooiNkgHqby7Ya+spNJolCVddh+JmCmvz9PrErM23RJxSK2JmKlVspEJI3T4+v9wdQsbgpyEpB81QOhGjycQwbY08jtE88tkfgfAHzm2YUhh/cpk2mGm69w0KizrFNBfuJdOeFJs62oIpaVPesXE6SImcGLh0zi9wbCFcKKfMTEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698341; c=relaxed/simple;
	bh=tvrUq+seSyEUdxeh/sbcETpwD7Kl2eSvP2ggPYdVO08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVbBfwfmJHU97kBJQjIgexe/jD+tagg6FIcNviSBFeGWwcP74L2+AXbcfG+oJPwqaI5cW+6fQ/LkkBprSMn5duk5A4JRxPs6MaDDiACoxo2ICFpw0Vx7cxEr+ru/w2jTMEb9PpIcN1I+ixEH7TYJNev0wohh0MQR7370QU/VC/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WP7X0cSU; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VYCZowvOZdc7ruHIIQXRY16w2zXEYkmh9LCBLV9ujoU=;
	b=WP7X0cSUyHiZ4+RCUxJqB0xZEH6v5O2C7+QSCEYDQ2TRI05iHw9COqAeX0BwDbAN6DiHiA
	CjD2EZQ3q3DpSHkQKw1zthwY9fNApeaGXkV4jW0SMc4aMnVWGioC/q1zXwiZuRlA1DIV4k
	UpSi9xYB1LjAJK/yHmXtSeIAHYa2K1g=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 6/7] memcg: allocate v1 event percpu only on v1 deployment
Date: Wed, 14 Aug 2024 22:04:52 -0700
Message-ID: <20240815050453.1298138-7-shakeel.butt@linux.dev>
In-Reply-To: <20240815050453.1298138-1-shakeel.butt@linux.dev>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently memcg->events_percpu gets allocated on v2 deployments. Let's
move the allocation to v1 only codebase. This is not needed in v2.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h |  3 ++-
 mm/memcontrol-v1.c         | 19 +++++++++++++++++++
 mm/memcontrol-v1.h         | 26 +++++++-------------------
 3 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e21a1541adeb..1f86d01d3b97 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -255,7 +255,6 @@ struct mem_cgroup {
 	struct list_head objcg_list;
 
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
-	struct memcg1_events_percpu __percpu *events_percpu;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head cgwb_list;
@@ -277,6 +276,8 @@ struct mem_cgroup {
 	struct page_counter kmem;		/* v1 only */
 	struct page_counter tcpmem;		/* v1 only */
 
+	struct memcg1_events_percpu __percpu *events_percpu;
+
 	unsigned long soft_limit;
 
 	/* protected by memcg_oom_lock */
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 0589d08c1599..81d8819f13cd 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1442,6 +1442,12 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
 	}
 }
 
+/* Cgroup1: threshold notifications & softlimit tree updates */
+struct memcg1_events_percpu {
+	unsigned long nr_page_events;
+	unsigned long targets[MEM_CGROUP_NTARGETS];
+};
+
 static void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
 {
 	/* pagein of a big page is an event. So, ignore page size */
@@ -3049,6 +3055,19 @@ bool memcg1_charge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages,
 	return false;
 }
 
+bool memcg1_alloc_events(struct mem_cgroup *memcg)
+{
+	memcg->events_percpu = alloc_percpu_gfp(struct memcg1_events_percpu,
+						GFP_KERNEL_ACCOUNT);
+	return !!memcg->events_percpu;
+}
+
+void memcg1_free_events(struct mem_cgroup *memcg)
+{
+	if (memcg->events_percpu)
+		free_percpu(memcg->events_percpu);
+}
+
 static int __init memcg1_init(void)
 {
 	int node;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 0a9f3f9c2362..3bb8b3030e61 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -55,12 +55,6 @@ enum mem_cgroup_events_target {
 	MEM_CGROUP_NTARGETS,
 };
 
-/* Cgroup1: threshold notifications & softlimit tree updates */
-struct memcg1_events_percpu {
-	unsigned long nr_page_events;
-	unsigned long targets[MEM_CGROUP_NTARGETS];
-};
-
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 
 void drain_all_stock(struct mem_cgroup *root_memcg);
@@ -72,21 +66,12 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
-static inline bool memcg1_alloc_events(struct mem_cgroup *memcg)
-{
-	memcg->events_percpu = alloc_percpu_gfp(struct memcg1_events_percpu,
-						GFP_KERNEL_ACCOUNT);
-	return !!memcg->events_percpu;
-}
-
-static inline void memcg1_free_events(struct mem_cgroup *memcg)
-{
-	if (memcg->events_percpu)
-		free_percpu(memcg->events_percpu);
-}
-
 /* Cgroup v1-specific declarations */
 #ifdef CONFIG_MEMCG_V1
+
+bool memcg1_alloc_events(struct mem_cgroup *memcg);
+void memcg1_free_events(struct mem_cgroup *memcg);
+
 void memcg1_memcg_init(struct mem_cgroup *memcg);
 void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
@@ -139,6 +124,9 @@ extern struct cftype mem_cgroup_legacy_files[];
 
 #else	/* CONFIG_MEMCG_V1 */
 
+static inline bool memcg1_alloc_events(struct mem_cgroup *memcg) { return true; }
+static inline void memcg1_free_events(struct mem_cgroup *memcg) {}
+
 static inline void memcg1_memcg_init(struct mem_cgroup *memcg) {}
 static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
-- 
2.43.5


