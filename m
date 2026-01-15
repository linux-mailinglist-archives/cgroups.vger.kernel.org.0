Return-Path: <cgroups+bounces-13244-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DB4D23FB7
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 11:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BED11301F7C4
	for <lists+cgroups@lfdr.de>; Thu, 15 Jan 2026 10:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D0636C0A6;
	Thu, 15 Jan 2026 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gd1WwsIh"
X-Original-To: cgroups@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC036BCD8
	for <cgroups@vger.kernel.org>; Thu, 15 Jan 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768473748; cv=none; b=TZ7pRAJOuSMfTDcBisUzZFoGxFxP3Qr7sfyotVmoquo33O5WYspJXfK3dU1OxJIK6Mn1Dy059Tpwq+PDgpGp2s/zgB7pE5KikAUGRKqeZqbKRABjf1yO+nv6XcKDh+jYqCM/HkpXNSlrBZL1/yMEmb3fkC2yPLG9qFYOWTpZtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768473748; c=relaxed/simple;
	bh=yeLT8ea22Q+eQ+HR8faVgUCzSzHvWZ5LtzNVc+qcdc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/JlS+B2MjWbL9eefWXe9z0y5EVoes1fgz76YZ1vr/GFGzobwFihR8z01KRbdqrXSAs7/hhYGdi/ooWOKOjTFyrFb8LceK/vWsm3Y0zWGA15+/lP026SZT42Clm8d21n/GWnbP78M/MUPAB6TD7HocHH6jRds7UbRaO+8AmbvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gd1WwsIh; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768473743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E21X6Rw5hX+kzgnPEdRnLJU6eESdHa8WNZNfTERO9us=;
	b=Gd1WwsIhns0nEOkvgNwLvRtzBTjlgigfzTtsf/Lb9TtF1sy9u8ynT8tTtHvToPAmD9bKkj
	jySAiCoogyimKgEEdnUnz4OYpXIgetozQzJOLMdwOln6mXBS6sD9efPIvExQ3Bck6SDxKt
	gdtnGkpuXaea0OZt5Mg6e1+YFZ9zmVw=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	yosry.ahmed@linux.dev,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	chenridong@huaweicloud.com,
	mkoutny@suse.com,
	akpm@linux-foundation.org,
	hamzamahfooz@linux.microsoft.com,
	apais@linux.microsoft.com,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 28/30 fix 2/2] mm: memcontrol: change state_locals to atomic_long_t type
Date: Thu, 15 Jan 2026 18:41:39 +0800
Message-ID: <4aad240fe536ce024c002087b2c395a197928e8a.1768473427.git.zhengqi.arch@bytedance.com>
In-Reply-To: <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
References: <e5afd1b5ae95d70f82433b9b4e13201342d16707.1768473427.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 mm/memcontrol.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b7b35143d4d2d..c303c483f55a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -456,7 +456,7 @@ struct lruvec_stats {
 	long state[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Non-hierarchical (CPU aggregated) state */
-	long state_local[NR_MEMCG_NODE_STAT_ITEMS];
+	atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Pending child counts during tree propagation */
 	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
@@ -499,7 +499,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
+	x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -524,8 +524,7 @@ static void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
 
 		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
 
-		WRITE_ONCE(parent_pn->lruvec_stats->state_local[i],
-			   parent_pn->lruvec_stats->state_local[i] + value);
+		atomic_long_add(value, &(parent_pn->lruvec_stats->state_local[i]));
 	}
 }
 
@@ -620,8 +619,8 @@ struct memcg_vmstats {
 	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_VMSTAT_SIZE];
-	unsigned long		events_local[NR_MEMCG_EVENTS];
+	atomic_long_t		state_local[MEMCG_VMSTAT_SIZE];
+	atomic_long_t		events_local[NR_MEMCG_EVENTS];
 
 	/* Pending child counts during tree propagation */
 	long			state_pending[MEMCG_VMSTAT_SIZE];
@@ -824,7 +823,7 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
-	x = READ_ONCE(memcg->vmstats->state_local[i]);
+	x = atomic_long_read(&(memcg->vmstats->state_local[i]));
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -841,7 +840,7 @@ void reparent_memcg_state_local(struct mem_cgroup *memcg,
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
-	WRITE_ONCE(parent->vmstats->state_local[i], parent->vmstats->state_local[i] + value);
+	atomic_long_add(value, &(parent->vmstats->state_local[i]));
 }
 #endif
 
@@ -1001,7 +1000,7 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, event))
 		return 0;
 
-	return READ_ONCE(memcg->vmstats->events_local[i]);
+	return atomic_long_read(&(memcg->vmstats->events_local[i]));
 }
 #endif
 
@@ -4126,7 +4125,7 @@ struct aggregate_control {
 	/* pointer to the aggregated (CPU and subtree aggregated) counters */
 	long *aggregate;
 	/* pointer to the non-hierarchichal (CPU aggregated) counters */
-	long *local;
+	atomic_long_t *local;
 	/* pointer to the pending child counters during tree propagation */
 	long *pending;
 	/* pointer to the parent's pending counters, could be NULL */
@@ -4165,7 +4164,7 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 
 		/* Aggregate counts on this level and propagate upwards */
 		if (delta_cpu)
-			ac->local[i] += delta_cpu;
+			atomic_long_add(delta_cpu, &(ac->local[i]));
 
 		if (delta) {
 			ac->aggregate[i] += delta;
-- 
2.20.1


