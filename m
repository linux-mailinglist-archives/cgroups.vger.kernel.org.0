Return-Path: <cgroups+bounces-8190-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9FCAB7490
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 20:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD3218940B1
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 18:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3878288524;
	Wed, 14 May 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L9zMuLin"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C12882A5
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248144; cv=none; b=pJJg8uvm6l9LNTHcKiQxNpQ66SxIIpnuNmmpm1hjfirfQGClqoc+sOW5I1prhYIAjgeBRSP6G5SbwOaAxSNP0Ia070fnNpTrW8o7HJ286AXgggrlXLNVKIkFkfyvlzCsJ5fRugwtNycILj8IGu1iXRawBrrUFKO7cbpMZoupsU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248144; c=relaxed/simple;
	bh=3Fr0cQ+G90nKuUSZg94me3gC2Oyt2UO3Hef1WWjs74U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz/sJnw7RY74a1msRCDFvW2q6mqCpIZO6sGfRe8HkDzmGtv3ETrhM3eK4hYCdBS/ezcCblbCL/nWw/O/I3cQFUus18+XJQjpmja3GDgwssBEnC3criZPDn0s9snZTQ2UzUSSqkqQXAcqj5FhffwQx93jpvAc3KkJhMiAAr2cYIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L9zMuLin; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747248139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1JZROuIroIvEzIUKiaMX+NW2Feg9mUr1VdRm7ju+Rc=;
	b=L9zMuLin+KdSVhzEN0SGMJKsSLDXu2kWmM+sbQ2yv1PrTje8O/eF0Gy1pQg2iugldzHZ+T
	M7psiGTwbuAYe7PTX0V1VJcEOxef1/R4hP0pUoImfGXbfRl58KPC0yIkyYMzoNlqhdjxFf
	e8EZzcrUZShSAZ0loYLOk0N7rzBcYl8=
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
Subject: [PATCH v2 1/7] memcg: memcg_rstat_updated re-entrant safe against irqs
Date: Wed, 14 May 2025 11:41:52 -0700
Message-ID: <20250514184158.3471331-2-shakeel.butt@linux.dev>
In-Reply-To: <20250514184158.3471331-1-shakeel.butt@linux.dev>
References: <20250514184158.3471331-1-shakeel.butt@linux.dev>
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
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 89476a71a18d..2464a58fbf17 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -505,8 +505,8 @@ struct memcg_vmstats_percpu {
 	unsigned int			stats_updates;
 
 	/* Cached pointers for fast iteration in memcg_rstat_updated() */
-	struct memcg_vmstats_percpu	*parent;
-	struct memcg_vmstats		*vmstats;
+	struct memcg_vmstats_percpu __percpu	*parent_pcpu;
+	struct memcg_vmstats			*vmstats;
 
 	/* The above should fit a single cacheline for memcg_rstat_updated() */
 
@@ -588,16 +588,21 @@ static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
+	struct memcg_vmstats_percpu __percpu *statc_pcpu;
 	struct memcg_vmstats_percpu *statc;
-	int cpu = smp_processor_id();
+	int cpu;
 	unsigned int stats_updates;
 
 	if (!val)
 		return;
 
+	/* Don't assume callers have preemption disabled. */
+	cpu = get_cpu();
+
 	cgroup_rstat_updated(memcg->css.cgroup, cpu);
-	statc = this_cpu_ptr(memcg->vmstats_percpu);
-	for (; statc; statc = statc->parent) {
+	statc_pcpu = memcg->vmstats_percpu;
+	for (; statc_pcpu; statc_pcpu = statc->parent_pcpu) {
+		statc = this_cpu_ptr(statc_pcpu);
 		/*
 		 * If @memcg is already flushable then all its ancestors are
 		 * flushable as well and also there is no need to increase
@@ -606,14 +611,15 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 		if (memcg_vmstats_needs_flush(statc->vmstats))
 			break;
 
-		stats_updates = READ_ONCE(statc->stats_updates) + abs(val);
-		WRITE_ONCE(statc->stats_updates, stats_updates);
+		stats_updates = this_cpu_add_return(statc_pcpu->stats_updates,
+						    abs(val));
 		if (stats_updates < MEMCG_CHARGE_BATCH)
 			continue;
 
+		stats_updates = this_cpu_xchg(statc_pcpu->stats_updates, 0);
 		atomic64_add(stats_updates, &statc->vmstats->stats_updates);
-		WRITE_ONCE(statc->stats_updates, 0);
 	}
+	put_cpu();
 }
 
 static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
@@ -3691,7 +3697,7 @@ static void mem_cgroup_free(struct mem_cgroup *memcg)
 
 static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
-	struct memcg_vmstats_percpu *statc, *pstatc;
+	struct memcg_vmstats_percpu *statc, __percpu *pstatc_pcpu;
 	struct mem_cgroup *memcg;
 	int node, cpu;
 	int __maybe_unused i;
@@ -3722,9 +3728,9 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 
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


