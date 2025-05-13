Return-Path: <cgroups+bounces-8149-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1638DAB49F9
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13F2619E8431
	for <lists+cgroups@lfdr.de>; Tue, 13 May 2025 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6861E47CA;
	Tue, 13 May 2025 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C3EQVIw8"
X-Original-To: cgroups@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A771A1DFD95
	for <cgroups@vger.kernel.org>; Tue, 13 May 2025 03:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106033; cv=none; b=sIZPEDGYPPD+IMrhrhp9xkTE/JJNSndVdYTfMnXE9crctE0Lz8uXocH/ISbFgJhyqPHOAEniYQ5JUZl4py21OyjQyjEzESVEoyGrb34RFgmaFalVbRamfaX4eUnVe8DtCa3l04lralFB8UQ9VBrNt2XIn/KxPYkqSTk59sgRrBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106033; c=relaxed/simple;
	bh=+rnUk1ve1loqahnQwcEmGR/tx0jbO1Z8D8Z1kS5bT4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0eQYUqWYYNAlh0JX+cDi0eL3umO7Mo6Rw2E6EOFFeq+Y9o2YoGrKOH6+xrOd5R/tlJvB7Rbnoh3RHwNQV+5/Ov3qg7HPrNBfItommToToQu+VOfMsbB4Z2YAxPCEApk1zCYv7KgcmPkbLhhOA9dPgxI7wt8e7dbyOUg/JfVOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C3EQVIw8; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747106028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8sFVhv+XawDkwe/3YGMSQXN4zaIyJz49c278HEHQGA=;
	b=C3EQVIw8Y1nTVChBcJCKWIBxYqV4/Y1lz/1Ujxcqedmdus/MZqYNUvrgok9fdfCOPb626J
	esIQ4xLECOxawcCDqHWReJVu3iDYZQmbVGRspPyxWAJtsTt0J07twE74pSmbLhyaf4m8YA
	KuJRH8xcc9tkRoSw146PCOltrl4otFI=
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
Subject: [RFC PATCH 2/7] memcg: move preempt disable to callers of memcg_rstat_updated
Date: Mon, 12 May 2025 20:13:11 -0700
Message-ID: <20250513031316.2147548-3-shakeel.butt@linux.dev>
In-Reply-To: <20250513031316.2147548-1-shakeel.butt@linux.dev>
References: <20250513031316.2147548-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Let's move the explicit preempt disable code to the callers of
memcg_rstat_updated and also remove the memcg_stats_lock and related
functions which ensures the callers of stats update functions have
disabled preemption because now the stats update functions are
explicitly disabling preemption.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol.c | 74 +++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 55 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2c4c095bf26c..62450e7991d8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -558,47 +558,21 @@ static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
 
-/*
- * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
- * not rely on this as part of an acquired spinlock_t lock. These functions are
- * never used in hardirq context on PREEMPT_RT and therefore disabling preemtion
- * is sufficient.
- */
-static void memcg_stats_lock(void)
-{
-	preempt_disable_nested();
-	VM_WARN_ON_IRQS_ENABLED();
-}
-
-static void __memcg_stats_lock(void)
-{
-	preempt_disable_nested();
-}
-
-static void memcg_stats_unlock(void)
-{
-	preempt_enable_nested();
-}
-
-
 static bool memcg_vmstats_needs_flush(struct memcg_vmstats *vmstats)
 {
 	return atomic64_read(&vmstats->stats_updates) >
 		MEMCG_CHARGE_BATCH * num_online_cpus();
 }
 
-static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
+static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val,
+				       int cpu)
 {
 	struct memcg_vmstats_percpu *statc;
-	int cpu;
 	int stats_updates;
 
 	if (!val)
 		return;
 
-	/* Don't assume callers have preemption disabled. */
-	cpu = get_cpu();
-
 	cgroup_rstat_updated(memcg->css.cgroup, cpu);
 	statc = this_cpu_ptr(memcg->vmstats_percpu);
 	for (; statc; statc = statc->parent) {
@@ -619,7 +593,6 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 			atomic64_add(stats_updates,
 				     &statc->vmstats->stats_updates);
 	}
-	put_cpu();
 }
 
 static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
@@ -717,6 +690,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		       int val)
 {
 	int i = memcg_stats_index(idx);
+	int cpu;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -724,12 +698,14 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
-	memcg_stats_lock();
+	cpu = get_cpu();
+
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	val = memcg_state_val_in_pages(idx, val);
-	memcg_rstat_updated(memcg, val);
+	memcg_rstat_updated(memcg, val, cpu);
 	trace_mod_memcg_state(memcg, idx, val);
-	memcg_stats_unlock();
+
+	put_cpu();
 }
 
 #ifdef CONFIG_MEMCG_V1
@@ -758,6 +734,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
+	int cpu;
 
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
@@ -765,24 +742,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
-	/*
-	 * The caller from rmap relies on disabled preemption because they never
-	 * update their counter from in-interrupt context. For these two
-	 * counters we check that the update is never performed from an
-	 * interrupt context while other caller need to have disabled interrupt.
-	 */
-	__memcg_stats_lock();
-	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
-		switch (idx) {
-		case NR_ANON_MAPPED:
-		case NR_FILE_MAPPED:
-		case NR_ANON_THPS:
-			WARN_ON_ONCE(!in_task());
-			break;
-		default:
-			VM_WARN_ON_IRQS_ENABLED();
-		}
-	}
+	cpu = get_cpu();
 
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[i], val);
@@ -791,9 +751,10 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
 
 	val = memcg_state_val_in_pages(idx, val);
-	memcg_rstat_updated(memcg, val);
+	memcg_rstat_updated(memcg, val, cpu);
 	trace_mod_memcg_lruvec_state(memcg, idx, val);
-	memcg_stats_unlock();
+
+	put_cpu();
 }
 
 /**
@@ -873,6 +834,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count)
 {
 	int i = memcg_events_index(idx);
+	int cpu;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -880,11 +842,13 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
-	memcg_stats_lock();
+	cpu = get_cpu();
+
 	__this_cpu_add(memcg->vmstats_percpu->events[i], count);
-	memcg_rstat_updated(memcg, count);
+	memcg_rstat_updated(memcg, count, cpu);
 	trace_count_memcg_events(memcg, idx, count);
-	memcg_stats_unlock();
+
+	put_cpu();
 }
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event)
-- 
2.47.1


