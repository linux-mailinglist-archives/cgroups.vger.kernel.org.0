Return-Path: <cgroups+bounces-8178-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8A4AB61FF
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 07:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61CD07A9687
	for <lists+cgroups@lfdr.de>; Wed, 14 May 2025 05:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6591F582B;
	Wed, 14 May 2025 05:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ufan84iQ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E619E975
	for <cgroups@vger.kernel.org>; Wed, 14 May 2025 05:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199322; cv=none; b=XhLMg4w1FWmy1jFVZbehqJOrjD6RfcI5PZ/CgQDvew3/OZlpf0a/DT2xdZN/112ROh3jbQfkcymqkif+nUY9tZtHvkkPfc1JPT3hAQ8mOS/iCyQrLwvpQzhYYzkRz8oqSYiwsvdmfMvtRfv9V7s/vfzOygO8eGE18+cVnoX0JJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199322; c=relaxed/simple;
	bh=8jpCKcYevABsM1E+ovY62bcN7h6ecmAAnFb2kM2PaZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGqLaExHfsfwxLQzFCfYjuobA+SLB+GmcJuNIUjEIlmKe9IWqPaVdWC/e8UyuSqYpNyIlO/uaEzdIggez/qWNbB6KO/mkf/ZmFCvfZ17Sp8Pyv7l5gvvGKlSbcDV37jHHsiPe+GAnN5xpn80KTrijlf5YY83fk6pbD8SmSpJxKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ufan84iQ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747199317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lT1lWRIc39oQfhab/AvhtsB7gjFHkHKvP88N+9WuUp8=;
	b=Ufan84iQx4kZ6ny1kDkEoY8jcItoUy+lGSmiHmEWOC/vnxckDXJ8pN7FdgVYDVZtg8IOYP
	WwRCYapOwVegFLk0yijnYzo88XArgShFZK0r+JpUQyd24hpzeJ9fo5Y9u7BOR4rGgJOjDR
	Otlz62CicA3jypXQ1jSx2lqykI4LCkk=
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
Subject: [PATCH 2/7] memcg: move preempt disable to callers of memcg_rstat_updated
Date: Tue, 13 May 2025 22:08:08 -0700
Message-ID: <20250514050813.2526843-3-shakeel.butt@linux.dev>
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

Let's move the explicit preempt disable code to the callers of
memcg_rstat_updated and also remove the memcg_stats_lock and related
functions which ensures the callers of stats update functions have
disabled preemption because now the stats update functions are
explicitly disabling preemption.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/memcontrol.c | 74 +++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 55 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cb10bcd1028d..8c8e0e1acd71 100644
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
 	struct memcg_vmstats_percpu __percpu *statc_pcpu;
-	int cpu;
 	unsigned int stats_updates;
 
 	if (!val)
 		return;
 
-	/* Don't assume callers have preemption disabled. */
-	cpu = get_cpu();
-
 	css_rstat_updated(&memcg->css, cpu);
 	statc_pcpu = memcg->vmstats_percpu;
 	for (; statc_pcpu; statc_pcpu = this_cpu_ptr(statc_pcpu)->parent_pcpu) {
@@ -620,7 +594,6 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 			atomic64_add(stats_updates,
 				&this_cpu_ptr(statc_pcpu)->vmstats->stats_updates);
 	}
-	put_cpu();
 }
 
 static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force)
@@ -718,6 +691,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		       int val)
 {
 	int i = memcg_stats_index(idx);
+	int cpu;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -725,12 +699,14 @@ void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
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
@@ -759,6 +735,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
+	int cpu;
 
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
@@ -766,24 +743,7 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
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
@@ -792,9 +752,10 @@ static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
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
@@ -874,6 +835,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count)
 {
 	int i = memcg_events_index(idx);
+	int cpu;
 
 	if (mem_cgroup_disabled())
 		return;
@@ -881,11 +843,13 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
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


