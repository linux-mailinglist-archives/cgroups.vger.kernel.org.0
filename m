Return-Path: <cgroups+bounces-8241-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2308DABA2ED
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67DE506660
	for <lists+cgroups@lfdr.de>; Fri, 16 May 2025 18:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A2C280008;
	Fri, 16 May 2025 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jdw9JAwJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6A27FD73
	for <cgroups@vger.kernel.org>; Fri, 16 May 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420368; cv=none; b=Z2BYYOdjDldQMzYjqkIyE7T8isH+0Kv+BliEFvZHVsysmJE7MhoO6ZU3f9AuV6MOJJefYrXAcg7Jqx8w0dAKPG62hsP3kmkiqoyAgngE1mSJj8c956gC6v1BfOXG/dVngWZ5QVZFZFTYZLXXDHXIzd5///2eulf9ZYT8k0d7hXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420368; c=relaxed/simple;
	bh=/j5grWFzR0cjLnb6szug0veGlSKKF33wbGyFIYIE5hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuLwu5ijk/FMOYsdoCX7pebO9BEca8eXbUDoOX+5v5Mm4W8JSpRz7BV84Y1f56WY53cXo7V2m4uSakb3HQJm0VL43IIRdIRs5oyIVrlCTYS7LtbDjTseVP8WdZLFZj99P5aZvUrOjR1djbIN/NTNd0Bl/8P1Z61E1DMKNPaLOUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jdw9JAwJ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747420364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evzcF8YYbapJWM/5H39TcTDHkMfCB1DFP3fd94phXVE=;
	b=jdw9JAwJea9s6TpFcnLTHiSqKvKTyjIlS2TvVYhMqApGexY3zMs4ot1is0MHQJaZwFmWkQ
	BahySWmK7l0vxeKRxbiFgP3mA+eFiytVL7Q2T/ke7PFkDzvdCFJtG6xmOl6Plq8sJm9ReJ
	AYSw46EVVEF69gxptIuFXp2YpOwD59E=
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
Subject: [PATCH v3 2/5] memcg: nmi safe memcg stats for specific archs
Date: Fri, 16 May 2025 11:32:28 -0700
Message-ID: <20250516183231.1615590-3-shakeel.butt@linux.dev>
In-Reply-To: <20250516183231.1615590-1-shakeel.butt@linux.dev>
References: <20250516183231.1615590-1-shakeel.butt@linux.dev>
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
 include/linux/memcontrol.h | 20 ++++++++++++++--
 mm/memcontrol.c            | 49 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 53920528821f..b10ae2388c27 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -62,9 +62,15 @@ struct mem_cgroup_reclaim_cookie {
 
 #ifdef CONFIG_MEMCG
 
-#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || \
-	!defined(CONFIG_HAVE_NMI) || defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
+#if defined(CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS) || !defined(CONFIG_HAVE_NMI)
+
+#define MEMCG_SUPPORTS_NMI_CHARGING
+
+#elif defined(ARCH_HAVE_NMI_SAFE_CMPXCHG)
+
 #define MEMCG_SUPPORTS_NMI_CHARGING
+#define MEMCG_NMI_NEED_ATOMIC
+
 #endif
 
 #define MEM_CGROUP_ID_SHIFT	16
@@ -118,6 +124,12 @@ struct mem_cgroup_per_node {
 	CACHELINE_PADDING(_pad2_);
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
+
+#ifdef MEMCG_NMI_NEED_ATOMIC
+	/* slab stats for nmi context */
+	atomic_t		slab_reclaimable;
+	atomic_t		slab_unreclaimable;
+#endif
 };
 
 struct mem_cgroup_threshold {
@@ -241,6 +253,10 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
+	/* MEMCG_KMEM for nmi context */
+	atomic_t		kmem_stat;
+#endif
 	/*
 	 * Hint of reclaim pressure for socket memroy management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0f182e4a9da0..a2f75f3537eb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3979,6 +3979,53 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 	}
 }
 
+#ifdef MEMCG_NMI_NEED_ATOMIC
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
@@ -3987,6 +4034,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct aggregate_control ac;
 	int nid;
 
+	flush_nmi_stats(memcg, parent, cpu);
+
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
 	ac = (struct aggregate_control) {
-- 
2.47.1


