Return-Path: <cgroups+bounces-13204-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 75675D1E735
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4D558301C54D
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BDD396B7D;
	Wed, 14 Jan 2026 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hP2Zk2ST"
X-Original-To: cgroups@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1734A797
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 11:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768390587; cv=none; b=XDrCENEOal1eGveWoS01WU3Va4IRBrRXpJF0ElTlvBH2WGuED4cQ1rWSq9IYH2yFCU8H8s+XvDqfsOAIZGKh2SslfofAu+1AML6z3VEiBAzbdmF0OdvMlKEkgH5X/xwFr6ROM9t88cFi9Rk8jW3bUhU0gX3/1y3tySh6a2wrgrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768390587; c=relaxed/simple;
	bh=p9Vglr5K1UPYxrr6EUmCRtY2AADI8eJzvA6GbDKoW7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CEMOXUUqGhiM+GZKdY8qp9S6lV0uK9qtJOnXcjMw6vLtDyPEgKjtxpbsJbT8HI9hbk9OoEka88MDXy2+gVsKyTLVnCmBvlGIhCxZ5DIJvpLXnIEU4eMEH6ZocpH/YyKaxCigmnoLqvTlfa66QZVzLwL2fL3cxP/iCLwUWgAlrnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hP2Zk2ST; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768390584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPjfXOeLD3JqDz3IDoD+k8CQ2UhiNCnYJI1wQcwmWYE=;
	b=hP2Zk2ST5tXGQJs5jKumpXbTNEQa6cSN/QefSYfwvZwTZLcduImseVBv4ckkJPsodJ4g7m
	6lzvZCv7rw8zQHewhdAtzt+yN2TQdS1KXkKxaIdyajvzKgAvJA4AkBi8RnfsO+xbt9Jtnv
	CekD4YJFeHRZG9Mh3bbOdcqJngsDuaY=
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
Subject: [PATCH v3 28/30] mm: memcontrol: prepare for reparenting state_local
Date: Wed, 14 Jan 2026 19:32:55 +0800
Message-ID: <b11a0bde9fe18673a61a79398f226ad7cb04a894.1768389889.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1768389889.git.zhengqi.arch@bytedance.com>
References: <cover.1768389889.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

To resolve the dying memcg issue, we need to reparent LRU folios of child
memcg to its parent memcg. The following counts are all non-hierarchical
and need to be reparented to prevent the counts of parent memcg overflow.

1. memcg->vmstats->state_local[i]
2. pn->lruvec_stats->state_local[i]

This commit implements the specific function, which will be used during
the reparenting process.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h |  4 +++
 mm/memcontrol-v1.c         | 16 +++++++++++
 mm/memcontrol-v1.h         |  3 ++
 mm/memcontrol.c            | 56 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 26c3c0e375f58..f84a23f13ffb4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -963,12 +963,16 @@ static inline void mod_memcg_page_state(struct page *page,
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
+void reparent_memcg_state_local(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent, int idx);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 bool memcg_stat_item_valid(int idx);
 bool memcg_vm_event_item_valid(enum vm_event_item idx);
 unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx);
 unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
+void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
+				       struct mem_cgroup *parent, int idx);
 
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index f0ef650d2317b..800606135e7ba 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1898,6 +1898,22 @@ static const unsigned int memcg1_events[] = {
 	PGMAJFAULT,
 };
 
+void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++)
+		reparent_memcg_state_local(memcg, parent, memcg1_stats[i]);
+}
+
+void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++)
+		reparent_memcg_lruvec_state_local(memcg, parent, memcg1_stats[i]);
+}
+
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 {
 	unsigned long memory, memsw;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index eb3c3c1056574..45528195d3578 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -41,6 +41,7 @@ static inline bool do_memsw_account(void)
 
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
+void mod_memcg_page_state_local(struct mem_cgroup *memcg, int idx, unsigned long val);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 bool memcg1_alloc_events(struct mem_cgroup *memcg);
 void memcg1_free_events(struct mem_cgroup *memcg);
@@ -73,6 +74,8 @@ void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
 			   unsigned long nr_memory, int nid);
 
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
+void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
 
 void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 70583394f421f..7aa32b97c9f17 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -225,6 +225,28 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
 	return objcg;
 }
 
+#ifdef CONFIG_MEMCG_V1
+static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg, bool force);
+
+static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	synchronize_rcu();
+
+	__mem_cgroup_flush_stats(memcg, true);
+
+	/* The following counts are all non-hierarchical and need to be reparented. */
+	reparent_memcg1_state_local(memcg, parent);
+	reparent_memcg1_lruvec_state_local(memcg, parent);
+}
+#else
+static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+{
+}
+#endif
+
 static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
 	spin_lock_irq(&objcg_lock);
@@ -458,6 +480,28 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
+void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
+				       struct mem_cgroup *parent, int idx)
+{
+	int i = memcg_stats_index(idx);
+	int nid;
+
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
+		return;
+
+	for_each_node(nid) {
+		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
+		struct mem_cgroup_per_node *parent_pn;
+		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
+
+		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
+
+		WRITE_ONCE(parent_pn->lruvec_stats->state_local[i],
+			   parent_pn->lruvec_stats->state_local[i] + value);
+	}
+}
+
 /* Subset of vm_event_item to report for memcg event stats */
 static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_MEMCG_V1
@@ -757,6 +801,18 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 #endif
 	return x;
 }
+
+void reparent_memcg_state_local(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent, int idx)
+{
+	int i = memcg_stats_index(idx);
+	unsigned long value = memcg_page_state_local(memcg, idx);
+
+	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
+		return;
+
+	WRITE_ONCE(parent->vmstats->state_local[i], parent->vmstats->state_local[i] + value);
+}
 #endif
 
 static void mod_memcg_lruvec_state(struct lruvec *lruvec,
-- 
2.20.1


