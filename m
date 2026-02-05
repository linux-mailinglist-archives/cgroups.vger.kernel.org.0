Return-Path: <cgroups+bounces-13713-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HxGLPpehGnS2gMAu9opvQ
	(envelope-from <cgroups+bounces-13713-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:12:26 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4372DF0650
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D50203072BE4
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9893921EB;
	Thu,  5 Feb 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cEFBJBp4"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850C3921D1
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282334; cv=none; b=U91h8S8rF1eT7LNaj9xoFvOAF5Drldz3ONpyRlBAbz+BWYB5JF4TcZ76Z/E90dLDA90SKsEAo3Pe5uB3JbippFV5m+s2mS7YqYAdr9Tb3fbbQ3LRb08q8xTh2gULlZ+tgFQ9ewk0/QfByprPbp2Pqc5kmW/spqNkjghC9PXCTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282334; c=relaxed/simple;
	bh=UuWnaWWqMbdHiYuNjBBXOZBTbbmmVtMidWSYsUiLjtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K/vjthX4V6QJ/P3HpkRqyj62C875uJChnhpp3qmJj3QCP6oikGZYd6QLG+/IGzHCruticTSGu0gYvsa3YgH2JG2zI0yMyqVhK7ufbbYIq+IARnkjeUMAxnTJp7iXm+YGkj66yhpYaCC4D5UEMn1swH9TGqt9A4o4JjIe63fHyD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cEFBJBp4; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770282332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q5kLmp7dpf/L0kz6scIBO58rmstn0CFdVVhrJfMBpSg=;
	b=cEFBJBp4fsTuERx8Stl5wVqoVd8E28YddbNBPlGZQpsWhshWUmhrZhkCbV82uRiXOLhIw5
	UyPwIXtYzd7wC5YsAMSw33sDBFwfI88TA8DSAxt3zZrGegp7SUF3MYRYpPRvFIV1h7xsPd
	F4YLuyhLUaPpe/JhULVpOT8604x/eto=
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
	lance.yang@linux.dev,
	bhe@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 29/31] mm: memcontrol: prepare for reparenting non-hierarchical stats
Date: Thu,  5 Feb 2026 17:01:48 +0800
Message-ID: <3ca234c643ecb484f17aa88187e0bce8949bdb6b.1770279888.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1770279888.git.zhengqi.arch@bytedance.com>
References: <cover.1770279888.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-13713-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 4372DF0650
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

To resolve the dying memcg issue, we need to reparent LRU folios of child
memcg to its parent memcg. This could cause problems for non-hierarchical
stats.

As Yosry Ahmed pointed out:

```
In short, if memory is charged to a dying cgroup at the time of
reparenting, when the memory gets uncharged the stats updates will occur
at the parent. This will update both hierarchical and non-hierarchical
stats of the parent, which would corrupt the parent's non-hierarchical
stats (because those counters were never incremented when the memory was
charged).
```

Now we have the following two types of non-hierarchical stats, and they
are only used in CONFIG_MEMCG_V1:

a. memcg->vmstats->state_local[i]
b. pn->lruvec_stats->state_local[i]

To ensure that these non-hierarchical stats work properly, we need to
reparent these non-hierarchical stats after reparenting LRU folios. To
this end, this commit makes the following preparations:

1. implement reparent_state_local() to reparent non-hierarchical stats
2. make css_killed_work_fn() to be called in rcu work, and implement
   get_non_dying_memcg_start() and get_non_dying_memcg_end() to avoid race
   between mod_memcg_state()/mod_memcg_lruvec_state()
   and reparent_state_local()
3. change these non-hierarchical stats to atomic_long_t type to avoid race
   between mem_cgroup_stat_aggregate() and reparent_state_local()

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h |   4 ++
 kernel/cgroup/cgroup.c     |   8 +--
 mm/memcontrol-v1.c         |  16 ++++++
 mm/memcontrol-v1.h         |   3 +
 mm/memcontrol.c            | 113 ++++++++++++++++++++++++++++++++++---
 5 files changed, 132 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 3970c102fe741..a4f6ab7eb98d6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -957,12 +957,16 @@ static inline void mod_memcg_page_state(struct page *page,
 
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
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 94788bd1fdf0e..dbf94a77018e6 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6043,8 +6043,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
  */
 static void css_killed_work_fn(struct work_struct *work)
 {
-	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_work);
+	struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
+				struct cgroup_subsys_state, destroy_rwork);
 
 	cgroup_lock();
 
@@ -6065,8 +6065,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
 	if (atomic_dec_and_test(&css->online_cnt)) {
-		INIT_WORK(&css->destroy_work, css_killed_work_fn);
-		queue_work(cgroup_offline_wq, &css->destroy_work);
+		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
+		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
 	}
 }
 
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index c6078cd7f7e53..a427bb205763b 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1887,6 +1887,22 @@ static const unsigned int memcg1_events[] = {
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
+	for (i = 0; i < NR_LRU_LISTS; i++)
+		reparent_memcg_lruvec_state_local(memcg, parent, i);
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
index c9b5dfd822d0a..e7d4e4ff411b6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -225,6 +225,26 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
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
@@ -407,7 +427,7 @@ struct lruvec_stats {
 	long state[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Non-hierarchical (CPU aggregated) state */
-	long state_local[NR_MEMCG_NODE_STAT_ITEMS];
+	atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Pending child counts during tree propagation */
 	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
@@ -450,7 +470,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
+	x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -458,6 +478,27 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
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
+		atomic_long_add(value, &(parent_pn->lruvec_stats->state_local[i]));
+	}
+}
+
 /* Subset of vm_event_item to report for memcg event stats */
 static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_MEMCG_V1
@@ -549,7 +590,7 @@ struct memcg_vmstats {
 	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_VMSTAT_SIZE];
+	atomic_long_t		state_local[MEMCG_VMSTAT_SIZE];
 	unsigned long		events_local[NR_MEMCG_EVENTS];
 
 	/* Pending child counts during tree propagation */
@@ -712,6 +753,42 @@ static int memcg_state_val_in_pages(int idx, int val)
 		return max(val * unit / PAGE_SIZE, 1UL);
 }
 
+#ifdef CONFIG_MEMCG_V1
+/*
+ * Used in mod_memcg_state() and mod_memcg_lruvec_state() to avoid race with
+ * reparenting of non-hierarchical state_locals.
+ */
+static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
+{
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return memcg;
+
+	rcu_read_lock();
+
+	while (memcg_is_dying(memcg))
+		memcg = parent_mem_cgroup(memcg);
+
+	return memcg;
+}
+
+static inline void get_non_dying_memcg_end(void)
+{
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
+		return;
+
+	rcu_read_unlock();
+}
+#else
+static inline struct mem_cgroup *get_non_dying_memcg_start(struct mem_cgroup *memcg)
+{
+	return memcg;
+}
+
+static inline void get_non_dying_memcg_end(void)
+{
+}
+#endif
+
 /**
  * mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -750,13 +827,25 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
-	x = READ_ONCE(memcg->vmstats->state_local[i]);
+	x = atomic_long_read(&(memcg->vmstats->state_local[i]));
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
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
+	atomic_long_add(value, &(parent->vmstats->state_local[i]));
+}
 #endif
 
 static void mod_memcg_lruvec_state(struct lruvec *lruvec,
@@ -4061,6 +4150,8 @@ struct aggregate_control {
 	long *aggregate;
 	/* pointer to the non-hierarchichal (CPU aggregated) counters */
 	long *local;
+	/* pointer to the atomic non-hierarchichal (CPU aggregated) counters */
+	atomic_long_t *alocal;
 	/* pointer to the pending child counters during tree propagation */
 	long *pending;
 	/* pointer to the parent's pending counters, could be NULL */
@@ -4098,8 +4189,12 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
 		}
 
 		/* Aggregate counts on this level and propagate upwards */
-		if (delta_cpu)
-			ac->local[i] += delta_cpu;
+		if (delta_cpu) {
+			if (ac->local)
+				ac->local[i] += delta_cpu;
+			else if (ac->alocal)
+				atomic_long_add(delta_cpu, &(ac->alocal[i]));
+		}
 
 		if (delta) {
 			ac->aggregate[i] += delta;
@@ -4170,7 +4265,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 	ac = (struct aggregate_control) {
 		.aggregate = memcg->vmstats->state,
-		.local = memcg->vmstats->state_local,
+		.local = NULL,
+		.alocal = memcg->vmstats->state_local,
 		.pending = memcg->vmstats->state_pending,
 		.ppending = parent ? parent->vmstats->state_pending : NULL,
 		.cstat = statc->state,
@@ -4203,7 +4299,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 		ac = (struct aggregate_control) {
 			.aggregate = lstats->state,
-			.local = lstats->state_local,
+			.local = NULL,
+			.alocal = lstats->state_local,
 			.pending = lstats->state_pending,
 			.ppending = plstats ? plstats->state_pending : NULL,
 			.cstat = lstatc->state,
-- 
2.20.1


