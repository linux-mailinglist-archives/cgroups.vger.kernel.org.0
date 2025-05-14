Return-Path: <cgroups+bounces-8176-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 627CDAB61FB
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 07:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE50119E36D2
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 05:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2781F4623;
	Wed, 14 May 2025 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="clfLkUdZ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6161F4169
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 05:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199318; cv=none; b=rrZdQSvSFg/XJr0BPujLi9gZQBWFbERkqM2/S2YXAtLGfs/1mY57VViMMtfQk4bFo5l+aJ+aerlr7Zshh37Q8kCIY6/nFoFStqrsv7cAbZkfFpGgnTpqZSuKdrAt07UxhKwEzJdIYZFaTfpWMo1rK+FrNDnxOaBzeFk2WfjN770=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199318; c=relaxed/simple;
	bh=RG9eTvAXCp/BCxIURb/14CMPEMU/XhGJRwyRB7eMJ4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plIYA9Pz/KkGiPFemkMaT8TgJUPfeyjLfLBjXYu87JpejIacf0tTu9r+/yHZOOL9HKsNJB0XN57sooAH+4zDTneXcy9mUBBQM6amK9NYHFhT7DcKaubAnYYBSknSDmvgLDPgicT0BA05Xer7/gw9eHvtUnrC3UxU/O86hIqssIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=clfLkUdZ; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747199313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zTCWWrV0l4ME9vJBQdx9lnHLC7UBjeIHK4sO6n82O0w=;
	b=clfLkUdZQCeY4LqSnalnqCiuGz+eMS9VvbrRqDlJq//1jNxS3/xkzuZH0dAccVoNF2esh9
	AoAfroMAbkmB8hJml6UIrG23bU6WvwkGvr/OeR1DT+8bEraK8BLD3NB2tddQZPLwAPo/7V
	ddblr4d4JckNJE3bSKj7MOy1KgFTcPw=
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
	bpf@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH 1/7] memcg: memcg_rstat_updated re-entrant safe against irqs
Date: Tue, 13 May 2025 22:08:07 -0700
Message-ID: <20250514050813.2526843-2-shakeel.butt@linux.dev>
In-Reply-To: <20250514050813.2526843-1-shakeel.butt@linux.dev>
References: <20250514050813.2526843-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The function memcg_rstat_updated() is used to track the memcg stats
updates for optimizing the flushes. At the moment, it is not re-entrant
safe and the callers disabled irqs before calling. However to achieve
the goal of updating memcg stats without irqs, memcg_rstat_updated()
needs to be re-entrant safe against irqs.

This patch makes memcg_rstat_updated() re-entrant safe using this_cpu_*
ops. On archs with CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS, this patch is
also making memcg_rstat_updated() nmi safe.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a713f160d669..cb10bcd1028d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -506,8 +506,8 @@ struct memcg_vmstats_percpu {
 	unsigned int			stats_updates;
 
 	/* Cached pointers for fast iteration in memcg_rstat_updated() */
-	struct memcg_vmstats_percpu	*parent;
-	struct memcg_vmstats		*vmstats;
+	struct memcg_vmstats_percpu __percpu	*parent_pcpu;
+	struct memcg_vmstats			*vmstats;
 
 	/* The above should fit a single cacheline for memcg_rstat_updated() */
 
@@ -589,32 +589,38 @@ static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
-	struct memcg_vmstats_percpu *statc;
-	int cpu = smp_processor_id();
+	struct memcg_vmstats_percpu __percpu *statc_pcpu;
+	int cpu;
 	unsigned int stats_updates;
 
 	if (!val)
 		return;
 
+	/* Don't assume callers have preemption disabled. */
+	cpu = get_cpu();
+
 	css_rstat_updated(&memcg->css, cpu);
-	statc = this_cpu_ptr(memcg->vmstats_percpu);
-	for (; statc; statc = statc->parent) {
+	statc_pcpu = memcg->vmstats_percpu;
+	for (; statc_pcpu; statc_pcpu = this_cpu_ptr(statc_pcpu)->parent_pcpu) {
 		/*
 		 * If @memcg is already flushable then all its ancestors are
 		 * flushable as well and also there is no need to increase
 		 * stats_updates.
 		 */
-		if (memcg_vmstats_needs_flush(statc->vmstats))
+		if (memcg_vmstats_needs_flush(this_cpu_ptr(statc_pcpu)->vmstats))
 			break;
 
-		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
-		WRITE_ONCE(statc->stats_updates, stats_updates);
+		stats_updates = this_cpu_add_return(statc_pcpu->stats_updates,
+						    abs(val));
 		if (stats_updates < MEMCG_CHARGE_BATCH)
 			continue;
 
-		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
-		WRITE_ONCE(statc->stats_updates, 0);
+		stats_updates = this_cpu_xchg(statc_pcpu->stats_updates, 0);
+		if (stats_updates)
+			atomic64_add(stats_updates,
+				&this_cpu_ptr(statc_pcpu)->vmstats->stats_updates);
 	}
+	put_cpu();
 }
 
 static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
@@ -3716,7 +3722,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 
 static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
-	struct memcg_vmstats_percpu *statc, *pstatc;
+	struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
 	int __maybe_unused i;
@@ -3747,9 +3753,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 
 	for_each_possible_cpu(cpu) {
 		if (parent)
-			pstatc = per_cpu_ptr(parent->vmstats_percpu, cpu);
+			pstatc_pcpu = parent->vmstats_percpu;
 		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
-		statc->parent = parent ? pstatc : NULL;
+		statc->parent_pcpu = parent ? pstatc_pcpu : NULL;
 		statc->vmstats = memcg->vmstats;
 	}
 
-- 
2.47.1


