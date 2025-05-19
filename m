Return-Path: <cgroups+bounces-8256-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A75FABB524
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 08:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A78A1756DE
	for <lists+cgroups@lfdr.de>; Mon, 19 May 2025 06:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F462451F0;
	Mon, 19 May 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YTR+k8xZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B22459C8
	for <cgroups@vger.kernel.org>; Mon, 19 May 2025 06:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747636344; cv=none; b=YhNygLCmH/bbYQHPGvItvVpDGadYSuRq40fHRNCCqyTsL4yb+2Y2ATs+Ze1csATOhaOx5o/XOEgS0uDRMMlMyOnuRhxQMhFNxxMOiT1ByWIik09JvaVQytU/YDFPtSQR5j7cjudIma4aWG3cC36+H97qorTicjkCc76wPEENkyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747636344; c=relaxed/simple;
	bh=D/I2qedm5u30mWcuOzGDmO7VRrhOYwaQkfa84DO/ABA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmUkAOiuP4MvXMqL6sNsdoZjpe3mXwJpJWk3P5VY0AtyjWkzNgSktbDTyORwGHqoj8PXlX4l26OeL4r0vcXUbNd//MEimKjqKqVktWXef8PWCiB7aAsl1QZCauvf3bYUQDAd8S9zwOL7JPBYGmEUvLEjYIKrP55UlIHDsnf0xTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YTR+k8xZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747636338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NI3xirp7ao0Fx3rWIO8hGtK9meMvvQYF3ylZpIHjujo=;
	b=YTR+k8xZ05MCc/6JcE3uYiLGWmAbv1cuLzYsqzq439kB4VxbzUeZk55mBbbNYbtjXtxmpY
	qMw+AozgxRFQqB0Aya1A1XnGEMp8N0A0a7Wp+nf6zAR2ZXPEwYjLBCV6GA+8nSb1EJdsDm
	hYzeDputBXbEylRKfHiOw5c2v/fvrFE=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Harry Yoo <harry.yoo@oracle.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v4 2/5] memcg: nmi safe memcg stats for specific archs
Date: Sun, 18 May 2025 23:31:39 -0700
Message-ID: <20250519063142.111219-3-shakeel.butt@linux.dev>
In-Reply-To: <20250519063142.111219-1-shakeel.butt@linux.dev>
References: <20250519063142.111219-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are archs which have NMI but does not support this_cpu_* ops
safely in the nmi context but they support safe atomic ops in nmi
context. For such archs, let's add infra to use atomic ops for the memcg
stats which can be updated in nmi.

At the moment, the memcg stats which get updated in the objcg charging
path are MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B.
Rather than adding support for all memcg stats to be nmi safe, let's
just add infra to make these three stats nmi safe which this patch is
doing.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/memcontrol.h | 10 ++++++++
 init/Kconfig               |  7 ++++++
 mm/memcontrol.c            | 49 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index f7848f73f41c..87b6688f124a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -113,6 +113,12 @@ struct mem_cgroup_per_node {
 	CACHELINE_PADDING(_pad2_);
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
+
+#ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
+	/* slab stats for nmi context */
+	atomic_t		slab_reclaimable;
+	atomic_t		slab_unreclaimable;
+#endif
 };
 
 struct mem_cgroup_threshold {
@@ -236,6 +242,10 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
+#ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
+	/* MEMCG_KMEM for nmi context */
+	atomic_t		kmem_stat;
+#endif
 	/*
 	 * Hint of reclaim pressure for socket memroy management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
diff --git a/init/Kconfig b/init/Kconfig
index a2aa49cfb8bd..e9f47baa34e0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1013,6 +1013,13 @@ config MEMCG_NMI_UNSAFE
 	depends on !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && !ARCH_HAVE_NMI_SAFE_CMPXCHG
 	default y
 
+config MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
+	bool
+	depends on MEMCG
+	depends on HAVE_NMI
+	depends on !ARCH_HAS_NMI_SAFE_THIS_CPU_OPS && ARCH_HAVE_NMI_SAFE_CMPXCHG
+	default y
+
 config MEMCG_V1
 	bool "Legacy cgroup v1 memory controller"
 	depends on MEMCG
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 532e2c06ea60..e3f0b298308a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3967,6 +3967,53 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 	}
 }
 
+#ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
+static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
+			    int cpu)
+{
+	int nid;
+
+	if (atomic_read(&memcg->kmem_stat)) {
+		int kmem = atomic_xchg(&memcg->kmem_stat, 0);
+		int index = memcg_stats_index(MEMCG_KMEM);
+
+		memcg->vmstats->state[index] += kmem;
+		if (parent)
+			parent->vmstats->state_pending[index] += kmem;
+	}
+
+	for_each_node_state(nid, N_MEMORY) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+		struct lruvec_stats *lstats = pn->lruvec_stats;
+		struct lruvec_stats *plstats = NULL;
+
+		if (parent)
+			plstats = parent->nodeinfo[nid]->lruvec_stats;
+
+		if (atomic_read(&pn->slab_reclaimable)) {
+			int slab = atomic_xchg(&pn->slab_reclaimable, 0);
+			int index = memcg_stats_index(NR_SLAB_RECLAIMABLE_B);
+
+			lstats->state[index] += slab;
+			if (plstats)
+				plstats->state_pending[index] += slab;
+		}
+		if (atomic_read(&pn->slab_unreclaimable)) {
+			int slab = atomic_xchg(&pn->slab_unreclaimable, 0);
+			int index = memcg_stats_index(NR_SLAB_UNRECLAIMABLE_B);
+
+			lstats->state[index] += slab;
+			if (plstats)
+				plstats->state_pending[index] += slab;
+		}
+	}
+}
+#else
+static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
+			    int cpu)
+{}
+#endif
+
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -3975,6 +4022,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct aggregate_control ac;
 	int nid;
 
+	flush_nmi_stats(memcg, parent, cpu);
+
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
 	ac = (struct aggregate_control) {
-- 
2.47.1


