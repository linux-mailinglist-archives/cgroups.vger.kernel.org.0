Return-Path: <cgroups+bounces-11251-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 157BBC1509E
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 15:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46241B2200A
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 14:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB4C335BA0;
	Tue, 28 Oct 2025 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P1ZV/Rzo"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593D1331A4A
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660174; cv=none; b=B88yRuYJPPWKPCL9RqaaFQC3tUmmPMugCipZMy2BCYAuR2SyjcB8ff8d8gq6vMKCkf2fzdZ64S32EIW0e+M5BDktLiYpcPzoDJLikHO25xSW9ISE9W7c8erBxNbbO1U6l1AlvnmQrDw7bpPW6n5AXbYPZrHtAmIlwwr0phfvG6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660174; c=relaxed/simple;
	bh=oAdOqRMHHvyzbSZokDAr0MwFqcSbrb1dIfMR6SMUzIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dlw88rLpBJJhlSme57+N2hBZ4Bh8ob8BeGVXhbTOLHhm7WAbRcebdWC8eZTMqk87anf/q3tmNQtG3D1KnkJY6DnHtbVQQXIHm1SvNiuv44NSzfmg8LCfNQgBT5ctD6UretRN/tVzbyoicwVlyc0O5Tb2Sc6geyGGZHvAlON1ASg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P1ZV/Rzo; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660169;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJMTup4HmkOG1M/S4B2pqIfmE4VeQgyqIHJuLcuLAMw=;
	b=P1ZV/Rzo0zukdIZKNWkACft52p0bD9mj8vgl3w2tvfgkoYsM7iiIP2iysPyTViots9XuqC
	noF/6I8rjwF/84+02CM7BpyUGv3CRb/Qox7oaKjHs4FP018QD6ncfhErqR+b/ZbIChrrsd
	p1x2z3bmLs4Qym6k9dPwJf+DKz4vUt0=
From: Qi Zheng <qi.zheng@linux.dev>
To: hannes@cmpxchg.org,
	hughd@google.com,
	mhocko@suse.com,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	harry.yoo@oracle.com,
	imran.f.khan@oracle.com,
	kamalesh.babulal@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v1 06/26] mm: memcontrol: return root object cgroup for root memory cgroup
Date: Tue, 28 Oct 2025 21:58:19 +0800
Message-ID: <5e9743f291e7ca7b8f052775e993090ed66cfa80.1761658310.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1761658310.git.zhengqi.arch@bytedance.com>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Muchun Song <songmuchun@bytedance.com>

Memory cgroup functions such as get_mem_cgroup_from_folio() and
get_mem_cgroup_from_mm() return a valid memory cgroup pointer,
even for the root memory cgroup. In contrast, the situation for
object cgroups has been different.

Previously, the root object cgroup couldn't be returned because
it didn't exist. Now that a valid root object cgroup exists, for
the sake of consistency, it's necessary to align the behavior of
object-cgroup-related operations with that of memory cgroup APIs.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h | 29 +++++++++++++++++-------
 mm/memcontrol.c            | 45 ++++++++++++++++++++------------------
 mm/percpu.c                |  2 +-
 3 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6185d8399a54e..9fdbd4970021d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -332,6 +332,7 @@ struct mem_cgroup {
 #define MEMCG_CHARGE_BATCH 64U
 
 extern struct mem_cgroup *root_mem_cgroup;
+extern struct obj_cgroup *root_obj_cgroup;
 
 enum page_memcg_data_flags {
 	/* page->memcg_data is a pointer to an slabobj_ext vector */
@@ -549,6 +550,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return (memcg == root_mem_cgroup);
 }
 
+static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
+{
+	return objcg == root_obj_cgroup;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
@@ -773,23 +779,26 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 
 static inline bool obj_cgroup_tryget(struct obj_cgroup *objcg)
 {
+	if (obj_cgroup_is_root(objcg))
+		return true;
 	return percpu_ref_tryget(&objcg->refcnt);
 }
 
-static inline void obj_cgroup_get(struct obj_cgroup *objcg)
+static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
+				       unsigned long nr)
 {
-	percpu_ref_get(&objcg->refcnt);
+	if (!obj_cgroup_is_root(objcg))
+		percpu_ref_get_many(&objcg->refcnt, nr);
 }
 
-static inline void obj_cgroup_get_many(struct obj_cgroup *objcg,
-				       unsigned long nr)
+static inline void obj_cgroup_get(struct obj_cgroup *objcg)
 {
-	percpu_ref_get_many(&objcg->refcnt, nr);
+	obj_cgroup_get_many(objcg, 1);
 }
 
 static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 {
-	if (objcg)
+	if (objcg && !obj_cgroup_is_root(objcg))
 		percpu_ref_put(&objcg->refcnt);
 }
 
@@ -1094,6 +1103,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
 	return true;
 }
 
+static inline bool obj_cgroup_is_root(const struct obj_cgroup *objcg)
+{
+	return true;
+}
+
 static inline bool mem_cgroup_disabled(void)
 {
 	return true;
@@ -1710,8 +1724,7 @@ static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
 {
 	struct obj_cgroup *objcg = current_obj_cgroup();
 
-	if (objcg)
-		obj_cgroup_get(objcg);
+	obj_cgroup_get(objcg);
 
 	return objcg;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2afd7f99ca101..d484b632c790f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -83,6 +83,8 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 EXPORT_SYMBOL(root_mem_cgroup);
 
+struct obj_cgroup *root_obj_cgroup __read_mostly;
+
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
@@ -2642,15 +2644,14 @@ struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
 
 static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 {
-	struct obj_cgroup *objcg = NULL;
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		struct obj_cgroup *objcg = rcu_dereference(memcg->objcg);
 
-	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
-		objcg = rcu_dereference(memcg->objcg);
 		if (likely(objcg && obj_cgroup_tryget(objcg)))
-			break;
-		objcg = NULL;
+			return objcg;
 	}
-	return objcg;
+
+	return NULL;
 }
 
 static struct obj_cgroup *current_objcg_update(void)
@@ -2724,18 +2725,17 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 		 * Objcg reference is kept by the task, so it's safe
 		 * to use the objcg by the current task.
 		 */
-		return objcg;
+		return objcg ? : root_obj_cgroup;
 	}
 
 	memcg = this_cpu_read(int_active_memcg);
 	if (unlikely(memcg))
 		goto from_memcg;
 
-	return NULL;
+	return root_obj_cgroup;
 
 from_memcg:
-	objcg = NULL;
-	for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
 		/*
 		 * Memcg pointer is protected by scope (see set_active_memcg())
 		 * and is pinning the corresponding objcg, so objcg can't go
@@ -2744,10 +2744,10 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
 		 */
 		objcg = rcu_dereference_check(memcg->objcg, 1);
 		if (likely(objcg))
-			break;
+			return objcg;
 	}
 
-	return objcg;
+	return root_obj_cgroup;
 }
 
 struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
@@ -2761,14 +2761,8 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 		objcg = __folio_objcg(folio);
 		obj_cgroup_get(objcg);
 	} else {
-		struct mem_cgroup *memcg;
-
 		rcu_read_lock();
-		memcg = __folio_memcg(folio);
-		if (memcg)
-			objcg = __get_obj_cgroup_from_memcg(memcg);
-		else
-			objcg = NULL;
+		objcg = __get_obj_cgroup_from_memcg(__folio_memcg(folio));
 		rcu_read_unlock();
 	}
 	return objcg;
@@ -2871,7 +2865,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	int ret = 0;
 
 	objcg = current_obj_cgroup();
-	if (objcg) {
+	if (!obj_cgroup_is_root(objcg)) {
 		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
 		if (!ret) {
 			obj_cgroup_get(objcg);
@@ -3172,7 +3166,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	 * obj_cgroup_get() is used to get a permanent reference.
 	 */
 	objcg = current_obj_cgroup();
-	if (!objcg)
+	if (obj_cgroup_is_root(objcg))
 		return true;
 
 	/*
@@ -3859,6 +3853,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (!objcg)
 		goto free_shrinker;
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		root_obj_cgroup = objcg;
+
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 	obj_cgroup_get(objcg);
@@ -5479,6 +5476,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	if (obj_cgroup_is_root(objcg))
+		return;
+
 	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
 
 	/* PF_MEMALLOC context, charging must succeed */
@@ -5506,6 +5506,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	if (obj_cgroup_is_root(objcg))
+		return;
+
 	obj_cgroup_uncharge(objcg, size);
 
 	rcu_read_lock();
diff --git a/mm/percpu.c b/mm/percpu.c
index 81462ce5866e1..78bdffe1fcb57 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1616,7 +1616,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 		return true;
 
 	objcg = current_obj_cgroup();
-	if (!objcg)
+	if (obj_cgroup_is_root(objcg))
 		return true;
 
 	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))
-- 
2.20.1


