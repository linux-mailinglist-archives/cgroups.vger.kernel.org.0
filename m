Return-Path: <cgroups+bounces-5281-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7702E9B1698
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 11:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C89282834
	for <lists+cgroups@lfdr.de>; Sat, 26 Oct 2024 09:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B9A1D1E91;
	Sat, 26 Oct 2024 09:45:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7859B13B294;
	Sat, 26 Oct 2024 09:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729935905; cv=none; b=YjYNXJjcUclUNQbDKm2pNI9+oRjzheSotSrU4E6XoTcEuwrYNHPA+HCK3fwfh27XwLqwkBE30nQ2WFb8uvEpzTeBSz2z8YgCxxfs6YtI/0xYYZZttu0csEPVRbyKOOjfQHcfMIfTKBfe48QWRjzPbMird4wq//QqUJt2uaR2biM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729935905; c=relaxed/simple;
	bh=KVVgZSvSrMLK7ROanPWnT1xUaFKAS9IjZs/aWgywtYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Il7T1JXAYRvNhOoIIgeAPfKpkY/6khuSkzUBgkfD7NMsmTtO9J/gvd/HeM2QaZ2OpxG0nR9NWsOzwrer1d9Hy21fdERBT2pC5QRSwSnT1WXW1CFy0FrwJGUSMHdHNWavB7JvZ4vtdmNosPlzBoq6RZf7U4aAth39uy0RVRmQ46w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XbF9g2GBXz4f3lVd;
	Sat, 26 Oct 2024 17:44:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A67381A018D;
	Sat, 26 Oct 2024 17:44:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.26])
	by APP4 (Coremail) with SMTP id gCh0CgAXl8MYuhxncHuqFA--.5222S2;
	Sat, 26 Oct 2024 17:44:57 +0800 (CST)
From: Xiu Jianfeng <xiujianfeng@huaweicloud.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	wangweiyang2@huawei.com
Subject: [PATCH -next] memcg: factor out mem_cgroup_stat_aggregate()
Date: Sat, 26 Oct 2024 09:34:07 +0000
Message-Id: <20241026093407.310955-1-xiujianfeng@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXl8MYuhxncHuqFA--.5222S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtryxGF4xGF4rGF4rAw1fWFg_yoW7uw1fpr
	ZxC343KF4UJw4DGa1fKa4UX34fZ34fXayUCFZ8ArySkF13tr1rZr10q34jvry5CFZxX34S
	vr4UKw1UC3y8AFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
	UAwIDUUUUU=
X-CM-SenderInfo: x0lxyxpdqiv03j6k3tpzhluzxrxghudrp/

From: Xiu Jianfeng <xiujianfeng@huawei.com>

Currently mem_cgroup_css_rstat_flush() is used to flush the per-CPU
statistics from a specified CPU into the global statistics of the
memcg. It processes three kinds of data in three for loops using exactly
the same method. Therefore, the for loop can be factored out and may
make the code more clean.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 mm/memcontrol.c | 129 ++++++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 59 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 17af08367c68..c3ae13c8f6fa 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3738,68 +3738,90 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
 
-static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+struct aggregate_control {
+	/* pointer to the aggregated (CPU and subtree aggregated) counters */
+	long *aggregate;
+	/* pointer to the non-hierarchichal (CPU aggregated) counters */
+	long *local;
+	/* pointer to the pending child counters during tree propagation */
+	long *pending;
+	/* pointer to the parent's pending counters, could be NULL */
+	long *ppending;
+	/* pointer to the percpu counters to be aggregated */
+	long *cstat;
+	/* pointer to the percpu counters of the last aggregation*/
+	long *cstat_prev;
+	/* size of the above counters */
+	int size;
+};
+
+static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 {
-	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
-	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
-	struct memcg_vmstats_percpu *statc;
+	int i;
 	long delta, delta_cpu, v;
-	int i, nid;
-
-	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
-	for (i = 0; i < MEMCG_VMSTAT_SIZE; i++) {
+	for (i = 0; i < ac->size; i++) {
 		/*
 		 * Collect the aggregated propagation counts of groups
 		 * below us. We're in a per-cpu loop here and this is
 		 * a global counter, so the first cycle will get them.
 		 */
-		delta = memcg->vmstats->state_pending[i];
+		delta = ac->pending[i];
 		if (delta)
-			memcg->vmstats->state_pending[i] = 0;
+			ac->pending[i] = 0;
 
 		/* Add CPU changes on this level since the last flush */
 		delta_cpu = 0;
-		v = READ_ONCE(statc->state[i]);
-		if (v != statc->state_prev[i]) {
-			delta_cpu = v - statc->state_prev[i];
+		v = READ_ONCE(ac->cstat[i]);
+		if (v != ac->cstat_prev[i]) {
+			delta_cpu = v - ac->cstat_prev[i];
 			delta += delta_cpu;
-			statc->state_prev[i] = v;
+			ac->cstat_prev[i] = v;
 		}
 
 		/* Aggregate counts on this level and propagate upwards */
 		if (delta_cpu)
-			memcg->vmstats->state_local[i] += delta_cpu;
+			ac->local[i] += delta_cpu;
 
 		if (delta) {
-			memcg->vmstats->state[i] += delta;
-			if (parent)
-				parent->vmstats->state_pending[i] += delta;
+			ac->aggregate[i] += delta;
+			if (ac->ppending)
+				ac->ppending[i] += delta;
 		}
 	}
+}
 
-	for (i = 0; i < NR_MEMCG_EVENTS; i++) {
-		delta = memcg->vmstats->events_pending[i];
-		if (delta)
-			memcg->vmstats->events_pending[i] = 0;
-
-		delta_cpu = 0;
-		v = READ_ONCE(statc->events[i]);
-		if (v != statc->events_prev[i]) {
-			delta_cpu = v - statc->events_prev[i];
-			delta += delta_cpu;
-			statc->events_prev[i] = v;
-		}
+static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+	struct memcg_vmstats_percpu *statc;
+	struct aggregate_control ac;
+	int nid;
 
-		if (delta_cpu)
-			memcg->vmstats->events_local[i] += delta_cpu;
+	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
-		if (delta) {
-			memcg->vmstats->events[i] += delta;
-			if (parent)
-				parent->vmstats->events_pending[i] += delta;
-		}
-	}
+	ac = (struct aggregate_control) {
+		.aggregate = memcg->vmstats->state,
+		.local = memcg->vmstats->state_local,
+		.pending = memcg->vmstats->state_pending,
+		.ppending = parent ? parent->vmstats->state_pending : NULL,
+		.cstat = statc->state,
+		.cstat_prev = statc->state_prev,
+		.size = MEMCG_VMSTAT_SIZE,
+	};
+	mem_cgroup_stat_aggregate(&ac);
+
+	ac = (struct aggregate_control) {
+		.aggregate = memcg->vmstats->events,
+		.local = memcg->vmstats->events_local,
+		.pending = memcg->vmstats->events_pending,
+		.ppending = parent ? parent->vmstats->events_pending : NULL,
+		.cstat = statc->events,
+		.cstat_prev = statc->events_prev,
+		.size = NR_MEMCG_EVENTS,
+	};
+	mem_cgroup_stat_aggregate(&ac);
 
 	for_each_node_state(nid, N_MEMORY) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
@@ -3812,28 +3834,17 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 		lstatc = per_cpu_ptr(pn->lruvec_stats_percpu, cpu);
 
-		for (i = 0; i < NR_MEMCG_NODE_STAT_ITEMS; i++) {
-			delta = lstats->state_pending[i];
-			if (delta)
-				lstats->state_pending[i] = 0;
-
-			delta_cpu = 0;
-			v = READ_ONCE(lstatc->state[i]);
-			if (v != lstatc->state_prev[i]) {
-				delta_cpu = v - lstatc->state_prev[i];
-				delta += delta_cpu;
-				lstatc->state_prev[i] = v;
-			}
-
-			if (delta_cpu)
-				lstats->state_local[i] += delta_cpu;
+		ac = (struct aggregate_control) {
+			.aggregate = lstats->state,
+			.local = lstats->state_local,
+			.pending = lstats->state_pending,
+			.ppending = plstats ? plstats->state_pending : NULL,
+			.cstat = lstatc->state,
+			.cstat_prev = lstatc->state_prev,
+			.size = NR_MEMCG_NODE_STAT_ITEMS,
+		};
+		mem_cgroup_stat_aggregate(&ac);
 
-			if (delta) {
-				lstats->state[i] += delta;
-				if (plstats)
-					plstats->state_pending[i] += delta;
-			}
-		}
 	}
 	WRITE_ONCE(statc->stats_updates, 0);
 	/* We are in a per-cpu loop here, only do the atomic write once */
-- 
2.34.1


