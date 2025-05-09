Return-Path: <cgroups+bounces-8117-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B654DAB203A
	for <lists+cgroups@lfdr.de>; Sat, 10 May 2025 01:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22634E21B0
	for <lists+cgroups@lfdr.de>; Fri,  9 May 2025 23:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C78264FB3;
	Fri,  9 May 2025 23:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="upWllJvj"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A733264A6E
	for <cgroups@vger.kernel.org>; Fri,  9 May 2025 23:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833390; cv=none; b=mQDufBR2AGPVbNVtKLCATztDK9KOB6z/hLFZ1plATZijfr+Q8WqknMpJ/f2uUBZ2JF4tb+LBJXb/Ln+ZZOqEHVmr8HaoLnyDuupI5464+uTGpJntmuRpgfXX0a/6Qrv5Xl5s9B/m/AaLzxP3+r3LwEJym1MKdRiK/kuTjNWnfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833390; c=relaxed/simple;
	bh=ttO/rNXMOFu7x9J9T+CWk2+ldj6KPz/NdfaSP620rhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7KMCkslQxI+FhnZ0ZhVPVGPqwCu97p1mCcSdhObZWa3E72YYQmIZaLfl/hgKwUNLqWTH+Al1TIkX4GJgfLOMMwQaybcuz2rAeFGE238H57+D4CA4dYefjbKzbj7+vsc1EE84eopXKD5Hw5EnMYx4icokLqaIKjIeZXoGOe5fWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=upWllJvj; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746833375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4a7blvwRplGNz94ltPdS2ZfQLa5WT241cOYcMci6OlE=;
	b=upWllJvjyssR355V9DxEy9YgOOnuM89e6EPEsSsj7BWpMwwxp18AEvxIVmgLgmeEaGKgeo
	23A2iciBm/qv6J/AqonpZylyfBuq6k00afaI7tJOGCpnwjZv4YIehpGlovweg5WjsUX5MN
	jVL1akwm51bHymPVW1JHokRABqrvvYM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Vlastimil Babka <vbabka@suse.cz>,
	Alexei Starovoitov <ast@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/4] memcg: add infra for nmi safe memcg stats
Date: Fri,  9 May 2025 16:28:56 -0700
Message-ID: <20250509232859.657525-2-shakeel.butt@linux.dev>
In-Reply-To: <20250509232859.657525-1-shakeel.butt@linux.dev>
References: <20250509232859.657525-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

BPF programs can trigger memcg charging in nmi context and at the moment
memcg charging code path for kernel memory does not have support for nmi
context. To support kernel memory charging for nmi support, we need to
make objcg charging nmi safe and also memcg stats nmi.

At the moment, the memcg stats which get updated in the objcg charging
path are MEMCG_KMEM, NR_SLAB_RECLAIMABLE_B & NR_SLAB_UNRECLAIMABLE_B.
Rather than adding support for all memcg stats to be nmi safe, let's
just add infra to make these three stats nmi safe which this patch is
doing.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 308c01bf98f5..ed9acb68652a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -113,6 +113,9 @@ struct mem_cgroup_per_node {
 	CACHELINE_PADDING(_pad2_);
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
+	/* slab stats for nmi context */
+	atomic64_t		slab_reclaimable;
+	atomic64_t		slab_unreclaimable;
 };
 
 struct mem_cgroup_threshold {
@@ -236,6 +239,9 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
+	/* MEMCG_KMEM for nmi context */
+	atomic64_t		kmem_stat;
+
 	/*
 	 * Hint of reclaim pressure for socket memroy management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9ea6e5591cab..7200f6930daf 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4023,6 +4023,47 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 	}
 }
 
+static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
+			    int cpu)
+{
+	int nid;
+
+	if (atomic64_read(&memcg->kmem_stat)) {
+		s64 kmem = atomic64_xchg(&memcg->kmem_stat, 0);
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
+		if (atomic64_read(&pn->slab_reclaimable)) {
+			s64 slab = atomic64_xchg(&pn->slab_reclaimable, 0);
+			int index = memcg_stats_index(NR_SLAB_RECLAIMABLE_B);
+
+			lstats->state[index] += slab;
+			if (plstats)
+				plstats->state_pending[index] += slab;
+		}
+		if (atomic64_read(&pn->slab_unreclaimable)) {
+			s64 slab = atomic64_xchg(&pn->slab_unreclaimable, 0);
+			int index = memcg_stats_index(NR_SLAB_UNRECLAIMABLE_B);
+
+			lstats->state[index] += slab;
+			if (plstats)
+				plstats->state_pending[index] += slab;
+		}
+	}
+}
+
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -4031,6 +4072,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct aggregate_control ac;
 	int nid;
 
+	flush_nmi_stats(memcg, parent, cpu);
+
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
 	ac = (struct aggregate_control) {
-- 
2.47.1


