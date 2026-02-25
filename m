Return-Path: <cgroups+bounces-14348-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIPTNBDGnmkuXQQAu9opvQ
	(envelope-from <cgroups+bounces-14348-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 10:51:12 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFD4195507
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 10:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D57FF300D9FB
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6AB33CE90;
	Wed, 25 Feb 2026 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CPe+l3kF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F71530148C;
	Wed, 25 Feb 2026 09:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772012732; cv=none; b=TkoRG4XVP44ILJqba8rAS0nHCkXXgzEKxedpoXk1kdYSgc1fx/97fjuIPE/wcBx3aKm8KDOzu8z9lj7YMXiawPi/0e78ggnXJPyyLaXR7sXcj+Z5WXOn1KkurLrvpvlaWf9DyjanwnohRHtOIeEY0ZtijSAD89a70RUYuz5pozk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772012732; c=relaxed/simple;
	bh=svMfOC/67GRig/j4qn/tWpcwlQY5drSnlTRyGs3BenE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcZqiA4aOZwsd5VKDBf4AuDZwhr7ZmDjsBmqTOglyDMz4vCBWCWwWhUuis2zAMts011mDblwyUlJmgkTPmAz+K+MX+B8mmpxRrwkDS6PCPhu2LiM/wQ4CStjNpMGdvClkeBNYp2BxEXmRUs4vnwMZgoYW/VQmKDtWiY2DI+L0LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CPe+l3kF; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772012728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FhuAyl241CW382or6lcoabauCcaKPEH8lUmsbyHD+is=;
	b=CPe+l3kFC7+Vh8T+pai1Hzv8lKTKwr/mmp6U/dd4cmhegSxmBTJHK0CHI5s9ooLgbu0KTi
	egrCTAso0yCFB/d4S8/a/Gn8pW80a9eyo9d0V0UNrxdZZu/CVDbISt3Sq0DO54NzJdji0j
	l55CCASNHixYJIuwTQ3GFjQ8TXR9A4M=
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
Subject: [PATCH v5 update 30/32] mm: memcontrol: convert objcg to be per-memcg per-node type
Date: Wed, 25 Feb 2026 17:44:56 +0800
Message-ID: <20260225094456.74145-1-qi.zheng@linux.dev>
In-Reply-To: <0f915487ffc653cf6ea19335c21c01aa06004641.1772005110.git.zhengqi.arch@bytedance.com>
References: <0f915487ffc653cf6ea19335c21c01aa06004641.1772005110.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14348-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bytedance.com:email]
X-Rspamd-Queue-Id: 4DFD4195507
X-Rspamd-Action: no action

From: Qi Zheng <zhengqi.arch@bytedance.com>

Convert objcg to be per-memcg per-node type, so that when reparent LRU
folios later, we can hold the lru lock at the node level, thus avoiding
holding too many lru locks at once.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
changlog:
 - fix a missing root_obj_cgroup conversion and completely delete
   root_obj_cgroup.

 include/linux/memcontrol.h | 23 +++++------
 include/linux/sched.h      |  2 +-
 mm/memcontrol.c            | 79 +++++++++++++++++++++++---------------
 3 files changed, 62 insertions(+), 42 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 45d911dd903e7..6e11552a90618 100644
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
index 63210b2222243..0755be8dcdfb6 100644
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
@@ -260,14 +261,17 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
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
@@ -2859,8 +2863,10 @@ struct mem_cgroup *mem_cgroup_from_virt(void *p)
 
 static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 {
+	int nid = numa_node_id();
+
 	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
-		struct obj_cgroup *objcg = rcu_dereference(memcg->objcg);
+		struct obj_cgroup *objcg = rcu_dereference(memcg->nodeinfo[nid]->objcg);
 
 		if (likely(objcg && obj_cgroup_tryget(objcg)))
 			return objcg;
@@ -2924,6 +2930,7 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 {
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
+	int nid = numa_node_id();
 
 	if (IS_ENABLED(CONFIG_MEMCG_NMI_UNSAFE) && in_nmi())
 		return NULL;
@@ -2940,14 +2947,14 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
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
@@ -2957,12 +2964,12 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
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
@@ -3859,6 +3866,8 @@ static bool alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn->lruvec_stats_percpu)
 		goto fail;
 
+	INIT_LIST_HEAD(&pn->objcg_list);
+
 	lruvec_init(&pn->lruvec);
 	pn->memcg = memcg;
 
@@ -3873,10 +3882,12 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
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
@@ -3947,7 +3958,6 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 #endif
 	memcg1_memcg_init(memcg);
 	memcg->kmemcg_id = -1;
-	INIT_LIST_HEAD(&memcg->objcg_list);
 #ifdef CONFIG_CGROUP_WRITEBACK
 	INIT_LIST_HEAD(&memcg->cgwb_list);
 	for (i = 0; i < MEMCG_CGWB_FRN_CNT; i++)
@@ -4024,6 +4034,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct obj_cgroup *objcg;
+	int nid;
 
 	memcg_online_kmem(memcg);
 
@@ -4035,17 +4046,19 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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
@@ -4069,7 +4082,13 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
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


