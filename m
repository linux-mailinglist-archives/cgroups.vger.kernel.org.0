Return-Path: <cgroups+bounces-14341-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0CN9G1CrnmntWgQAu9opvQ
	(envelope-from <cgroups+bounces-14341-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:57:04 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FA4193D26
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EBFF303C4E3
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33ED30C62B;
	Wed, 25 Feb 2026 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fnng9NxN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A730BBB9
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006184; cv=none; b=oKF2q5r49i2JIy/do6JGICGQ1oYYIXToxDv6Rs2Dz3E6gB9nTqGDumEMdb0sobYdCY+vQfUK4IsEStrRaI8dlCTdatUtUnHNp+Hkeq813QqvFBjqMqmH0SqusCjZ5lITVX1lJGIPtwf6RI+/lAZlpakggoHR7N3uyemPWY2L8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006184; c=relaxed/simple;
	bh=bGgvZXP6lVO5FMcopAbYmuaaqw/V/52x07POfleXQew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XpVyvCfOG9Xqs1fSEnPdps22LWZUbISBX6m7OsYT35M1iJPXQA5Nc3mdkO3G7fvbKeVW8w2SbmOmQqnBFccqY5u/as4Up/h5Poy3eKg0qVX0n6d/jtT2LIzvtDQMF3nJesMeed8e+lI+/WHhSkA5Fv3XBNpRwNaM0rZAUtaiPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fnng9NxN; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772006181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rudIknK3Co4enoGw+e5q9iMbCGsfaLu1FJFwhiN9DPs=;
	b=Fnng9NxN9VbqQqK6RGjNMs9gDULKBTZBmNki1Tx672OH7lMmOjVb6GGX/bfk1kQiMTPLB6
	gds3r37RnwZjoVquWhXhybiZZmO+NMJeseKns8FJPGEM3FodSLr/zE8UDM2iyH68lkMbnt
	Ccj2CISllIH+Vu2CFKekt1jkT8AyLpw=
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
	bhe@redhat.com,
	usamaarif642@gmail.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v5 29/32] mm: memcontrol: prepare for reparenting non-hierarchical stats
Date: Wed, 25 Feb 2026 15:53:12 +0800
Message-ID: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1772005110.git.zhengqi.arch@bytedance.com>
References: <cover.1772005110.git.zhengqi.arch@bytedance.com>
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
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14341-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,bytedance.com:mid,bytedance.com:email]
X-Rspamd-Queue-Id: 11FA4193D26
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
 include/linux/memcontrol.h |   1 +
 kernel/cgroup/cgroup.c     |   8 +--
 mm/memcontrol-v1.c         |  16 ++++++
 mm/memcontrol-v1.h         |   8 +++
 mm/memcontrol.c            | 115 ++++++++++++++++++++++++++++++++++---
 5 files changed, 136 insertions(+), 12 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d2748e672fd88..45d911dd903e7 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -957,6 +957,7 @@ static inline void mod_memcg_page_state(struct page *page,
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
+
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 bool memcg_stat_item_valid(int idx);
 bool memcg_vm_event_item_valid(enum vm_event_item idx);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index be1d71dda3179..74344e3931743 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6044,8 +6044,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
  */
 static void css_killed_work_fn(struct work_struct *work)
 {
-	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_work);
+	struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
+				struct cgroup_subsys_state, destroy_rwork);
 
 	cgroup_lock();
 
@@ -6066,8 +6066,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
 		container_of(ref, struct cgroup_subsys_state, refcnt);
 
 	if (atomic_dec_and_test(&css->online_cnt)) {
-		INIT_WORK(&css->destroy_work, css_killed_work_fn);
-		queue_work(cgroup_offline_wq, &css->destroy_work);
+		INIT_RCU_WORK(&css->destroy_rwork, css_killed_work_fn);
+		queue_rcu_work(cgroup_offline_wq, &css->destroy_rwork);
 	}
 }
 
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index fe42ef664f1e1..51fb4406f45cf 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1897,6 +1897,22 @@ static const unsigned int memcg1_events[] = {
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
index 4041b5027a94b..d1db1f883f066 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -45,6 +45,7 @@ static inline bool do_memsw_account(void)
 
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
+void mod_memcg_page_state_local(struct mem_cgroup *memcg, int idx, unsigned long val);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 bool memcg1_alloc_events(struct mem_cgroup *memcg);
 void memcg1_free_events(struct mem_cgroup *memcg);
@@ -77,6 +78,13 @@ void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
 			   unsigned long nr_memory, int nid);
 
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
+void reparent_memcg1_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+void reparent_memcg1_lruvec_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent);
+
+void reparent_memcg_state_local(struct mem_cgroup *memcg,
+				struct mem_cgroup *parent, int idx);
+void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
+				       struct mem_cgroup *parent, int idx);
 
 void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
 static inline bool memcg1_tcpmem_active(struct mem_cgroup *memcg)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5929e397c3c31..63210b2222243 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -226,6 +226,26 @@ static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memc
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
@@ -422,7 +442,7 @@ struct lruvec_stats {
 	long state[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Non-hierarchical (CPU aggregated) state */
-	long state_local[NR_MEMCG_NODE_STAT_ITEMS];
+	atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Pending child counts during tree propagation */
 	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
@@ -465,7 +485,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
+	x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -473,6 +493,29 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
+#ifdef CONFIG_MEMCG_V1
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
+#endif
+
 /* Subset of vm_event_item to report for memcg event stats */
 static const unsigned int memcg_vm_event_stat[] = {
 #ifdef CONFIG_MEMCG_V1
@@ -555,7 +598,7 @@ struct memcg_vmstats {
 	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_VMSTAT_SIZE];
+	atomic_long_t		state_local[MEMCG_VMSTAT_SIZE];
 	unsigned long		events_local[NR_MEMCG_EVENTS];
 
 	/* Pending child counts during tree propagation */
@@ -718,6 +761,42 @@ static int memcg_state_val_in_pages(int idx, int val)
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
@@ -756,13 +835,25 @@ unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
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
@@ -4083,6 +4174,8 @@ struct aggregate_control {
 	long *aggregate;
 	/* pointer to the non-hierarchichal (CPU aggregated) counters */
 	long *local;
+	/* pointer to the atomic non-hierarchichal (CPU aggregated) counters */
+	atomic_long_t *alocal;
 	/* pointer to the pending child counters during tree propagation */
 	long *pending;
 	/* pointer to the parent's pending counters, could be NULL */
@@ -4120,8 +4213,12 @@ static void mem_cgroup_stat_aggregate(struct aggregate_control *ac)
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
@@ -4192,7 +4289,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 	ac = (struct aggregate_control) {
 		.aggregate = memcg->vmstats->state,
-		.local = memcg->vmstats->state_local,
+		.local = NULL,
+		.alocal = memcg->vmstats->state_local,
 		.pending = memcg->vmstats->state_pending,
 		.ppending = parent ? parent->vmstats->state_pending : NULL,
 		.cstat = statc->state,
@@ -4225,7 +4323,8 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
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


