Return-Path: <cgroups+bounces-14643-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDFDLEdwqWnH7AAAu9opvQ
	(envelope-from <cgroups+bounces-14643-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:00:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A12110EC
	for <lists+cgroups@lfdr.de>; Thu, 05 Mar 2026 13:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA3AB309969E
	for <lists+cgroups@lfdr.de>; Thu,  5 Mar 2026 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA4A396B77;
	Thu,  5 Mar 2026 11:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G9yd0bJY"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40E385527
	for <cgroups@vger.kernel.org>; Thu,  5 Mar 2026 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711723; cv=none; b=kR1yh8Hh9O4dfw84jIZnCmVw5ISCE9xZfCdLN9ys618xepFKGC7WfCt6AK3FpqCkJ5BGbtqr25std/0UI9ta2yyNV1VXjZyKiB5euhpaRxXV5m4JofIvdFagbeQzW880oxh6Z49Hmopt7Nbw3wlBNK2C6u7/Fa9pQfepKMXmLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711723; c=relaxed/simple;
	bh=YK+t5CTl8EPDUsoOw7ny5aygya8Rr8ynuaR2JM88IBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQkKtf0neNEtJzEAw0sLb9TYruYKjNIrPAcapPqMKZudCdmpfoPLlMQ2RadgWp9heVBtcfz02YA6mQJRwlsIhpii+VqxJuxAgeV5hcWoFiRcB44XbR+ygdv/kH6w3a8/u0CBb5tdE7dSK78QBoSxeDH4lKOUV87w7QoCZgfcpvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G9yd0bJY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772711719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3gH8AiiD/E862U1vIIy8+gSWs5lK6UcmktqNCNUwlo=;
	b=G9yd0bJYkANT5mpRufTilwpomjklsp+K616yc33Ot9NCkpPjKnwko/VPQyc2OPUkwUySPv
	e8C3Dx4abZrIyiaAP5f5yPyb1Ng0JG4ShmU2TDZ7W0/cycBFg8GDOFAn1NTWxuXarYubof
	nk2CernPtz5XauqcvXxSuGVD+3B5xWo=
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
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v6 07/33] mm: memcontrol: return root object cgroup for root memory cgroup
Date: Thu,  5 Mar 2026 19:52:25 +0800
Message-ID: <e9c3f40ba7681d9753372d4ee2ac7a0216848b95.1772711148.git.zhengqi.arch@bytedance.com>
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
X-Rspamd-Queue-Id: 2C1A12110EC
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
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14643-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:mid,bytedance.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oracle.com:email,linux.dev:dkim,linux.dev:email,cmpxchg.org:email]
X-Rspamd-Action: no action

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
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/memcontrol.h | 26 +++++++++++++++++-----
 mm/memcontrol.c            | 45 ++++++++++++++++++++------------------
 mm/percpu.c                |  2 +-
 3 files changed, 45 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 52b1d8f3942e1..f4b6158b77d8e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -333,6 +333,7 @@ struct mem_cgroup {
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
@@ -775,23 +781,26 @@ struct mem_cgroup *mem_cgroup_from_css(struct cgroup_subsys_state *css){
 
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
 
@@ -1088,6 +1097,11 @@ static inline bool mem_cgroup_is_root(struct mem_cgroup *memcg)
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
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 508ee182c032e..a60b692fb75a9 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -84,6 +84,8 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
 struct mem_cgroup *root_mem_cgroup __read_mostly;
 EXPORT_SYMBOL(root_mem_cgroup);
 
+struct obj_cgroup *root_obj_cgroup __read_mostly;
+
 /* Active memory cgroup to use from an interrupt context */
 DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
 EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
@@ -2740,15 +2742,14 @@ struct mem_cgroup *mem_cgroup_from_virt(void *p)
 
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
@@ -2822,18 +2823,17 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
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
@@ -2842,10 +2842,10 @@ __always_inline struct obj_cgroup *current_obj_cgroup(void)
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
@@ -2859,14 +2859,8 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
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
@@ -2969,7 +2963,7 @@ int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
 	int ret = 0;
 
 	objcg = current_obj_cgroup();
-	if (objcg) {
+	if (objcg && !obj_cgroup_is_root(objcg)) {
 		ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
 		if (!ret) {
 			obj_cgroup_get(objcg);
@@ -3270,7 +3264,7 @@ bool __memcg_slab_post_alloc_hook(struct kmem_cache *s, struct list_lru *lru,
 	 * obj_cgroup_get() is used to get a permanent reference.
 	 */
 	objcg = current_obj_cgroup();
-	if (!objcg)
+	if (!objcg || obj_cgroup_is_root(objcg))
 		return true;
 
 	/*
@@ -3928,6 +3922,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (!objcg)
 		goto free_shrinker;
 
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		root_obj_cgroup = objcg;
+
 	objcg->memcg = memcg;
 	rcu_assign_pointer(memcg->objcg, objcg);
 	obj_cgroup_get(objcg);
@@ -5558,6 +5555,9 @@ void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	if (obj_cgroup_is_root(objcg))
+		return;
+
 	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
 
 	/* PF_MEMALLOC context, charging must succeed */
@@ -5587,6 +5587,9 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	if (obj_cgroup_is_root(objcg))
+		return;
+
 	obj_cgroup_uncharge(objcg, size);
 
 	rcu_read_lock();
diff --git a/mm/percpu.c b/mm/percpu.c
index a2107bdebf0b5..b0676b8054ed0 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1622,7 +1622,7 @@ static bool pcpu_memcg_pre_alloc_hook(size_t size, gfp_t gfp,
 		return true;
 
 	objcg = current_obj_cgroup();
-	if (!objcg)
+	if (!objcg || obj_cgroup_is_root(objcg))
 		return true;
 
 	if (obj_cgroup_charge(objcg, gfp, pcpu_obj_full_size(size)))
-- 
2.20.1


