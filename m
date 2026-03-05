Return-Path: <cgroups+bounces-14667-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kONbF4dyqWks7wAAu9opvQ
	(envelope-from <cgroups+bounces-14667-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:09:43 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADB1211567
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FE56315C6F9
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC99A3A0B34;
	Thu,  5 Mar 2026 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eE/2iDHg"
X-Original-To: cgroups@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBA03A0B36
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 11:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711987; cv=none; b=kaINipiPfb1VqRZJAWwf+vziwXLLHfDe6BKbDtqdhgx/jD6clx89SIb3oB66h5fgdx/apzyJJb6JGqFxah/xLublTSdfTZ/ECkn+Xksaj4oBbRTHmhGlrVO8jiJ5Nut9wYLhDQlyZOubtfkcki6vmSulILvMmUUKCAxY9PFq/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711987; c=relaxed/simple;
	bh=PrqCF9HLEMi54cS1XE53/eSgDp1R0X08k2aknO/wmZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u7S362kVLi/reKIEH10y1ZkNOTQ63bCRA8Sg6jMQGF0YLttVgWvH7YeYRRHIlSLys8n4WR7T43vQlO2+dMCxL5PjK3JSJq1Fpz4413ZekVltEdiZczGTrQ4oecFqKyq1skpkFBLG096hAhjHaCl9vtDuwVeSzwjsDWIq1DPzwpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eE/2iDHg; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772711982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=000wQrhgOQlDoscfHVaYYyHCVpTODCn4mRL9PBdBKCM=;
	b=eE/2iDHgDMQ63mmeDwbJuI5AHuk2LFgHFiuTu8V95o3mZZejkhTq3yRUqwRjXVqXXvXjZE
	fVF9mmbIvtEj+il2YBtAJnoX/oA9M3C2JpjP2oDcitVmYdstJrgDWXiqNwNIZ7VL+kpOI3
	6ZH8O7BA15WAoPabnZd56p72EyWfoYc=
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
Subject: [PATCH v6 31/33] mm: memcontrol: convert objcg to be per-memcg per-node type
Date: Thu,  5 Mar 2026 19:52:49 +0800
Message-ID: <56c04b1c5d54f75ccdc12896df6c1ca35403ecc3.1772711148.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1772711148.git.zhengqi.arch@bytedance.com>
References: <cover.1772711148.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CADB1211567
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14667-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bytedance.com:mid,bytedance.com:email]
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

Convert objcg to be per-memcg per-node type, so that when reparent LRU
folios later, we can hold the lru lock at the node level, thus avoiding
holding too many lru locks at once.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 23 +++++------
 include/linux/sched.h      |  2 +-
 mm/memcontrol.c            | 79 +++++++++++++++++++++++---------------
 3 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index d2748e672fd88..57d86decf2830 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -116,6 +116,16 @@ struct mem_cgroup_per_node {
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 	struct mem_cgroup_reclaim_iter	iter;
 
+	/*
+	 * objcg is wiped out as a part of the objcg repaprenting process.
+	 * orig_objcg preserves a pointer (and a reference) to the original
+	 * objcg until the end of live of memcg.
+	 */
+	struct obj_cgroup __rcu	*objcg;
+	struct obj_cgroup	*orig_objcg;
+	/* list of inherited objcgs, protected by objcg_lock */
+	struct list_head objcg_list;
+
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
 	/* slab stats for nmi context */
 	atomic_t		slab_reclaimable;
@@ -180,6 +190,7 @@ struct obj_cgroup {
 		struct list_head list; /* protected by objcg_lock */
 		struct rcu_head rcu;
 	};
+	bool is_root;
 };
 
 /*
@@ -258,15 +269,6 @@ struct mem_cgroup {
 	seqlock_t		socket_pressure_seqlock;
 #endif
 	int kmemcg_id;
-	/*
-	 * memcg->objcg is wiped out as a part of the objcg repaprenting
-	 * process. memcg->orig_objcg preserves a pointer (and a reference)
-	 * to the original objcg until the end of live of memcg.
-	 */
-	struct obj_cgroup __rcu	*objcg;
-	struct obj_cgroup	*orig_objcg;
-	/* list of inherited objcgs, protected by objcg_lock */
-	struct list_head objcg_list;
 
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
@@ -333,7 +335,6 @@ struct mem_cgroup {
 #define MEMCG_CHARGE_BATCH 64U
 
 extern struct mem_cgroup *root_mem_cgroup;
-extern struct obj_cgroup *root_obj_cgroup;
 
 enum page_memcg_data_flags {
 	/* page->memcg_data is a pointer to an slabobj_ext vector */
@@ -552,7 +553,7 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 
 static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
 {
-	return objcg == root_obj_cgroup;
+	return objcg->is_root;
 }
 
 static inline bool mem_cgroup_disabled(void)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a7b4a980eb2f0..7b63b7b74f414 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1533,7 +1533,7 @@ struct task_struct {
 	/* Used by memcontrol for targeted memcg charge: */
 	struct mem_cgroup		*active_memcg;
 
-	/* Cache for current->cgroups->memcg->objcg lookups: */
+	/* Cache for current->cgroups->memcg->nodeinfo[nid]->objcg lookups: */
 	struct obj_cgroup		*objcg;
 #endif
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b0519a16f5684..e31c58bc89188 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -84,8 +84,6 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 EXPORT_SYMBOL(root_mem_cgroup);
 
-struct obj_cgroup *root_obj_cgroup __read_mostly;
-
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
@@ -210,18 +208,21 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
 }
 
 static inline struct obj_cgroup *__memcg_reparent_objcgs(struct mem_cgroup *memcg,
-							 struct mem_cgroup *parent)
+							 struct mem_cgroup *parent,
+							 int nid)
 {
 	struct obj_cgroup *objcg, *iter;
+	struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+	struct mem_cgroup_per_node *parent_pn = parent->nodeinfo[nid];
 
-	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
+	objcg = rcu_replace_pointer(pn->objcg, NULL, true);
 	/* 1) Ready to reparent active objcg. */
-	list_add(&objcg->list, &memcg->objcg_list);
+	list_add(&objcg->list, &pn->objcg_list);
 	/* 2) Reparent active objcg and already reparented objcgs to parent. */
-	list_for_each_entry(iter, &memcg->objcg_list, list)
+	list_for_each_entry(iter, &pn->objcg_list, list)
 		WRITE_ONCE(iter->memcg, parent);
 	/* 3) Move already reparented objcgs to the parent's list */
-	list_splice(&memcg->objcg_list, &parent->objcg_list);
+	list_splice(&pn->objcg_list, &parent_pn->objcg_list);
 
 	return objcg;
 }
@@ -268,14 +269,17 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 {
 	struct obj_cgroup *objcg;
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
+	int nid;
 
-	reparent_locks(memcg, parent);
+	for_each_node(nid) {
+		reparent_locks(memcg, parent);
 
-	objcg = __memcg_reparent_objcgs(memcg, parent);
+		objcg = __memcg_reparent_objcgs(memcg, parent, nid);
 
-	reparent_unlocks(memcg, parent);
+		reparent_unlocks(memcg, parent);
 
-	percpu_ref_kill(&objcg->refcnt);
+		percpu_ref_kill(&objcg->refcnt);
+	}
 }
 
 /*
@@ -2877,8 +2881,10 @@ struct mem_cgroup *mem_cgroup_from_virt(void *p)
 
 static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 {
+	int nid = numa_node_id();
+
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		struct obj_cgroup *objcg = rcu_dereference(memcg->objcg);
+		struct obj_cgroup *objcg = rcu_dereference(memcg->nodeinfo[nid]->objcg);
 
 		if (likely(objcg && obj_cgroup_tryget(objcg)))
 			return objcg;
@@ -2942,6 +2948,7 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 {
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
+	int nid = numa_node_id();
 
 	if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi())
 		return NULL;
@@ -2958,14 +2965,14 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 		 * Objcg reference is kept by the task, so it's safe
 		 * to use the objcg by the current task.
 		 */
-		return objcg ? : root_obj_cgroup;
+		return objcg ? : rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
 	}
 
 	memcg = this_cpu_read(int_active_memcg);
 	if (unlikely(memcg))
 		goto from_memcg;
 
-	return root_obj_cgroup;
+	return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
 
 from_memcg:
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
@@ -2975,12 +2982,12 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 		 * away and can be used within the scope without any additional
 		 * protection.
 		 */
-		objcg = rcu_dereference_check(memcg->objcg, 1);
+		objcg = rcu_dereference_check(memcg->nodeinfo[nid]->objcg, 1);
 		if (likely(objcg))
 			return objcg;
 	}
 
-	return root_obj_cgroup;
+	return rcu_dereference_check(root_mem_cgroup->nodeinfo[nid]->objcg, 1);
 }
 
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
@@ -3877,6 +3884,8 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn->lruvec_stats_percpu)
 		goto fail;
 
+	INIT_LIST_HEAD(&pn->objcg_list);
+
 	lruvec_init(&pn->lruvec);
 	pn->memcg = memcg;
 
@@ -3891,10 +3900,12 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 {
 	int node;
 
-	obj_cgroup_put(memcg->orig_objcg);
+	for_each_node(node) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
 
-	for_each_node(node)
-		free_mem_cgroup_per_node_info(memcg->nodeinfo[node]);
+		obj_cgroup_put(pn->orig_objcg);
+		free_mem_cgroup_per_node_info(pn);
+	}
 	memcg1_free_events(memcg);
 	kfree(memcg->vmstats);
 	free_percpu(memcg->vmstats_percpu);
@@ -3965,7 +3976,6 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 #endif
 	memcg1_memcg_init(memcg);
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -4042,6 +4052,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct obj_cgroup *objcg;
+	int nid;
 
 	memcg_online_kmem(memcg);
 
@@ -4053,17 +4064,19 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (alloc_shrinker_info(memcg))
 		goto offline_kmem;
 
-	objcg = obj_cgroup_alloc();
-	if (!objcg)
-		goto free_shrinker;
+	for_each_node(nid) {
+		objcg = obj_cgroup_alloc();
+		if (!objcg)
+			goto free_objcg;
 
-	if (unlikely(mem_cgroup_is_root(memcg)))
-		root_obj_cgroup = objcg;
+		if (unlikely(mem_cgroup_is_root(memcg)))
+			objcg->is_root = true;
 
-	objcg->memcg = memcg;
-	rcu_assign_pointer(memcg->objcg, objcg);
-	obj_cgroup_get(objcg);
-	memcg->orig_objcg = objcg;
+		objcg->memcg = memcg;
+		rcu_assign_pointer(memcg->nodeinfo[nid]->objcg, objcg);
+		obj_cgroup_get(objcg);
+		memcg->nodeinfo[nid]->orig_objcg = objcg;
+	}
 
 	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
 		queue_delayed_work(system_dfl_wq, &stats_flush_dwork,
@@ -4087,7 +4100,13 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	xa_store(&mem_cgroup_private_ids, memcg->id.id, memcg, GFP_KERNEL);
 
 	return 0;
-free_shrinker:
+free_objcg:
+	for_each_node(nid) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+
+		if (pn && pn->orig_objcg)
+			obj_cgroup_put(pn->orig_objcg);
+	}
 	free_shrinker_info(memcg);
 offline_kmem:
 	memcg_offline_kmem(memcg);
-- 
2.20.1


