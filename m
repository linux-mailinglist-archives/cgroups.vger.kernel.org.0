Return-Path: <cgroups+bounces-14343-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL7fG9OrnmntWgQAu9opvQ
	(envelope-from <cgroups+bounces-14343-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:59:15 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C318193DC0
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 08:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7E3423055034
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 07:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9150F30C343;
	Wed, 25 Feb 2026 07:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CWavkArw"
X-Original-To: cgroups@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6253D30BF69
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772006208; cv=none; b=XUrOYEj5YGJitg0w4/MikGmSK7XWL7ruiSHScaCjOb4L9PS69v1d4Gw61f4B6IWGTAabv3kH9oOVdbQUG4VjfpYxPpny7uRFVGtPDu0GgklNOvm7iaCLZCRuGQn60rnDdJFWKhbynjewv2RQrk0Q2FOJL4Gve68IwloHEEhc34A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772006208; c=relaxed/simple;
	bh=oL+rlVzEs8c2V8pRbb13uM/EV/AO1k3MQpOdbmOVexA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ITzLzNcYgfsCeGEu0+Jq5qUQVuH7hy/5KpR+V+Ls0Pc5OqZdy4rh73TS2OnCfiqF39qPYGugfpqHQw2pdnEv4fM5x1ujq/IPyMY9tqJM05o2N6+n5hLdLDYuDij8XcZ4pmeKogmt0Bpb54WM3QB9wwgCa9wMgro+oBYV/e/aWIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CWavkArw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772006204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sO3xPVTV2vMKK43Qj7TVPP/Fyp00smzPwZrC6YsEjcM=;
	b=CWavkArwNsS2BdzHMSFBCm44dnvzB/pALf7q2TkATGTQG/s08nulN6EZtI5QGlCiHQqp1Y
	ILMqQ4hyE+q7PV57wuxeJVWh93bZmJpq4DzBQfcyyLSkCQuFvmAPm0VvrwyLDvjBfVMC+a
	j+m9WUohawvt7DSKDFv0ffusuqUAF/g=
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
Subject: [PATCH v5 31/32] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
Date: Wed, 25 Feb 2026 15:53:14 +0800
Message-ID: <ff5a945386f168faa877901d569296592cdaadc3.1772005110.git.zhengqi.arch@bytedance.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-14343-lists,cgroups=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux-foundation.org,linux.microsoft.com,redhat.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:dkim,bytedance.com:mid,bytedance.com:email]
X-Rspamd-Queue-Id: 8C318193DC0
X-Rspamd-Action: no action

From: Muchun Song <songmuchun@bytedance.com>

Now that everything is set up, switch folio->memcg_data pointers to
objcgs, update the accessors, and execute reparenting on cgroup death.

Finally, folio->memcg_data of LRU folios and kmem folios will always
point to an object cgroup pointer. The folio->memcg_data of slab
folios will point to an vector of object cgroups.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/memcontrol.h |  77 +++++---------
 mm/memcontrol-v1.c         |  15 +--
 mm/memcontrol.c            | 199 ++++++++++++++++++++++---------------
 3 files changed, 154 insertions(+), 137 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 487c66d9e5304..2edb60aeb4a42 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -371,9 +371,6 @@ enum objext_flags {
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
 
 #ifdef CONFIG_MEMCG
-
-static inline bool folio_memcg_kmem(struct folio *folio);
-
 /*
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
@@ -387,43 +384,19 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
 }
 
 /*
- * __folio_memcg - Get the memory cgroup associated with a non-kmem folio
- * @folio: Pointer to the folio.
- *
- * Returns a pointer to the memory cgroup associated with the folio,
- * or NULL. This function assumes that the folio is known to have a
- * proper memory cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * kmem folios.
- */
-static inline struct mem_cgroup *__folio_memcg(struct folio *folio)
-{
-	unsigned long memcg_data = folio->memcg_data;
-
-	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
-	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_KMEM, folio);
-
-	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-}
-
-/*
- * __folio_objcg - get the object cgroup associated with a kmem folio.
+ * folio_objcg - get the object cgroup associated with a folio.
  * @folio: Pointer to the folio.
  *
  * Returns a pointer to the object cgroup associated with the folio,
  * or NULL. This function assumes that the folio is known to have a
- * proper object cgroup pointer. It's not safe to call this function
- * against some type of folios, e.g. slab folios or ex-slab folios or
- * LRU folios.
+ * proper object cgroup pointer.
  */
-static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
+static inline struct obj_cgroup *folio_objcg(struct folio *folio)
 {
 	unsigned long memcg_data = folio->memcg_data;
 
 	VM_BUG_ON_FOLIO(folio_test_slab(folio), folio);
 	VM_BUG_ON_FOLIO(memcg_data & MEMCG_DATA_OBJEXTS, folio);
-	VM_BUG_ON_FOLIO(!(memcg_data & MEMCG_DATA_KMEM), folio);
 
 	return (struct obj_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 }
@@ -437,21 +410,30 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
  * proper memory cgroup pointer. It's not safe to call this function
  * against some type of folios, e.g. slab folios or ex-slab folios.
  *
- * For a non-kmem folio any of the following ensures folio and memcg binding
- * stability:
+ * For a folio any of the following ensures folio and objcg binding stability:
  *
  * - the folio lock
  * - LRU isolation
  * - exclusive reference
  *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * Based on the stable binding of folio and objcg, for a folio any of the
+ * following ensures folio and memcg binding stability:
+ *
+ * - cgroup_mutex
+ * - the lruvec lock
+ *
+ * If the caller only want to ensure that the page counters of memcg are
+ * updated correctly, ensure that the binding stability of folio and objcg
+ * is sufficient.
+ *
+ * Note: The caller should hold an rcu read lock or cgroup_mutex to protect
+ * memcg associated with a folio from being released.
  */
 static inline struct mem_cgroup *folio_memcg(struct folio *folio)
 {
-	if (folio_memcg_kmem(folio))
-		return obj_cgroup_memcg(__folio_objcg(folio));
-	return __folio_memcg(folio);
+	struct obj_cgroup *objcg = folio_objcg(folio);
+
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 /*
@@ -475,15 +457,10 @@ static inline bool folio_memcg_charged(struct folio *folio)
  * has an associated memory cgroup pointer or an object cgroups vector or
  * an object cgroup.
  *
- * For a non-kmem folio any of the following ensures folio and memcg binding
- * stability:
+ * The page and objcg or memcg binding rules can refer to folio_memcg().
  *
- * - the folio lock
- * - LRU isolation
- * - exclusive reference
- *
- * For a kmem folio a caller should hold an rcu read lock to protect memcg
- * associated with a kmem folio from being released.
+ * A caller should hold an rcu read lock to protect memcg associated with a
+ * page from being released.
  */
 static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 {
@@ -492,18 +469,14 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
 	 * for slabs, READ_ONCE() should be used here.
 	 */
 	unsigned long memcg_data = READ_ONCE(folio->memcg_data);
+	struct obj_cgroup *objcg;
 
 	if (memcg_data & MEMCG_DATA_OBJEXTS)
 		return NULL;
 
-	if (memcg_data & MEMCG_DATA_KMEM) {
-		struct obj_cgroup *objcg;
-
-		objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
-		return obj_cgroup_memcg(objcg);
-	}
+	objcg = (void *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
 
-	return (struct mem_cgroup *)(memcg_data & ~OBJEXTS_FLAGS_MASK);
+	return objcg ? obj_cgroup_memcg(objcg) : NULL;
 }
 
 static inline struct mem_cgroup *page_memcg_check(struct page *page)
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 51fb4406f45cf..427cc45c3c369 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -613,6 +613,7 @@ void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 {
 	struct mem_cgroup *memcg, *swap_memcg;
+	struct obj_cgroup *objcg;
 	unsigned int nr_entries;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
@@ -624,12 +625,13 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	if (!do_memsw_account())
 		return;
 
-	memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
+	objcg = folio_objcg(folio);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+	if (!objcg)
 		return;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
 	/*
 	 * In case the memcg owning these pages has been offlined and doesn't
 	 * have an ID allocated to it anymore, charge the closest online
@@ -644,7 +646,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!obj_cgroup_is_root(objcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
 	if (memcg != swap_memcg) {
@@ -665,7 +667,8 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	preempt_enable_nested();
 	memcg1_check_events(memcg, folio_nid(folio));
 
-	css_put(&memcg->css);
+	rcu_read_unlock();
+	obj_cgroup_put(objcg);
 }
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index edc785438a65b..e990c432a9ac4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -249,13 +249,17 @@ static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
 }
 #endif
 
-static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid)
 {
 	spin_lock_irq(&objcg_lock);
+	spin_lock_nested(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock, 1);
+	spin_lock_nested(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock, 2);
 }
 
-static inline void reparent_unlocks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
+static inline void reparent_unlocks(struct mem_cgroup *memcg, struct mem_cgroup *parent, int nid)
 {
+	spin_unlock(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock);
+	spin_unlock(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock);
 	spin_unlock_irq(&objcg_lock);
 }
 
@@ -266,14 +270,31 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	int nid;
 
 	for_each_node(nid) {
-		reparent_locks(memcg, parent);
+retry:
+		if (lru_gen_enabled())
+			max_lru_gen_memcg(parent, nid);
+
+		reparent_locks(memcg, parent, nid);
+
+		if (lru_gen_enabled()) {
+			if (!recheck_lru_gen_max_memcg(parent, nid)) {
+				reparent_unlocks(memcg, parent, nid);
+				cond_resched();
+				goto retry;
+			}
+			lru_gen_reparent_memcg(memcg, parent, nid);
+		} else {
+			lru_reparent_memcg(memcg, parent, nid);
+		}
 
 		objcg = __memcg_reparent_objcgs(memcg, parent, nid);
 
-		reparent_unlocks(memcg, parent);
+		reparent_unlocks(memcg, parent, nid);
 
 		percpu_ref_kill(&objcg->refcnt);
 	}
+
+	reparent_state_local(memcg, parent);
 }
 
 /*
@@ -823,9 +844,14 @@ void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 
 	cpu = get_cpu();
 
+	memcg = get_non_dying_memcg_start(memcg);
+
 	this_cpu_add(memcg->vmstats_percpu->state[i], val);
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val, cpu);
+
+	get_non_dying_memcg_end();
+
 	trace_mod_memcg_state(memcg, idx, val);
 
 	put_cpu();
@@ -866,6 +892,7 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 				     enum node_stat_item idx,
 				     int val)
 {
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
@@ -879,14 +906,18 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 
 	cpu = get_cpu();
 
+	memcg = get_non_dying_memcg_start(memcg);
+	pn = memcg->nodeinfo[pgdat->node_id];
+
 	/* Update memcg */
 	this_cpu_add(memcg->vmstats_percpu->state[i], val);
-
 	/* Update lruvec */
 	this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
-
 	val = memcg_state_val_in_pages(idx, val);
 	memcg_rstat_updated(memcg, val, cpu);
+
+	get_non_dying_memcg_end();
+
 	trace_mod_memcg_lruvec_state(memcg, idx, val);
 
 	put_cpu();
@@ -1112,6 +1143,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
 /**
  * get_mem_cgroup_from_folio - Obtain a reference on a given folio's memcg.
  * @folio: folio from which memcg should be extracted.
+ *
+ * See folio_memcg() for folio->objcg/memcg binding rules.
  */
 struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 {
@@ -2753,17 +2786,17 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return try_charge_memcg(memcg, gfp_mask, nr_pages);
 }
 
-static void commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+static void commit_charge(struct folio *folio, struct obj_cgroup *objcg)
 {
 	VM_BUG_ON_FOLIO(folio_memcg_charged(folio), folio);
 	/*
-	 * Any of the following ensures page's memcg stability:
+	 * Any of the following ensures folio's objcg stability:
 	 *
 	 * - the page lock
 	 * - LRU isolation
 	 * - exclusive reference
 	 */
-	folio->memcg_data = (unsigned long)memcg;
+	folio->memcg_data = (unsigned long)objcg;
 }
 
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
@@ -2877,6 +2910,17 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
 	return NULL;
 }
 
+static inline struct obj_cgroup *get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
+{
+	struct obj_cgroup *objcg;
+
+	rcu_read_lock();
+	objcg = __get_obj_cgroup_from_memcg(memcg);
+	rcu_read_unlock();
+
+	return objcg;
+}
+
 static struct obj_cgroup *current_objcg_update(void)
 {
 	struct mem_cgroup *memcg;
@@ -2978,17 +3022,10 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 {
 	struct obj_cgroup *objcg;
 
-	if (!memcg_kmem_online())
-		return NULL;
-
-	if (folio_memcg_kmem(folio)) {
-		objcg = __folio_objcg(folio);
+	objcg = folio_objcg(folio);
+	if (objcg)
 		obj_cgroup_get(objcg);
-	} else {
-		rcu_read_lock();
-		objcg = __get_obj_cgroup_from_memcg(__folio_memcg(folio));
-		rcu_read_unlock();
-	}
+
 	return objcg;
 }
 
@@ -3504,7 +3541,7 @@ void folio_split_memcg_refs(struct folio *folio, unsigned old_order,
 		return;
 
 	new_refs = (1 << (old_order - new_order)) - 1;
-	css_get_many(&__folio_memcg(folio)->css, new_refs);
+	obj_cgroup_get_many(folio_objcg(folio), new_refs);
 }
 
 static void memcg_online_kmem(struct mem_cgroup *memcg)
@@ -4941,16 +4978,20 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
 static int charge_memcg(struct folio *folio, struct mem_cgroup *memcg,
 			gfp_t gfp)
 {
-	int ret;
-
-	ret = try_charge(memcg, gfp, folio_nr_pages(folio));
-	if (ret)
-		goto out;
+	int ret = 0;
+	struct obj_cgroup *objcg;
 
-	css_get(&memcg->css);
-	commit_charge(folio, memcg);
+	objcg = get_obj_cgroup_from_memcg(memcg);
+	/* Do not account at the root objcg level. */
+	if (!obj_cgroup_is_root(objcg))
+		ret = try_charge_memcg(memcg, gfp, folio_nr_pages(folio));
+	if (ret) {
+		obj_cgroup_put(objcg);
+		return ret;
+	}
+	commit_charge(folio, objcg);
 	memcg1_commit_charge(folio, memcg);
-out:
+
 	return ret;
 }
 
@@ -5036,7 +5077,7 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 }
 
 struct uncharge_gather {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
@@ -5050,58 +5091,52 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(ug->objcg);
 	if (ug->nr_memory) {
-		memcg_uncharge(ug->memcg, ug->nr_memory);
+		memcg_uncharge(memcg, ug->nr_memory);
 		if (ug->nr_kmem) {
-			mod_memcg_state(ug->memcg, MEMCG_KMEM, -ug->nr_kmem);
-			memcg1_account_kmem(ug->memcg, -ug->nr_kmem);
+			mod_memcg_state(memcg, MEMCG_KMEM, -ug->nr_kmem);
+			memcg1_account_kmem(memcg, -ug->nr_kmem);
 		}
-		memcg1_oom_recover(ug->memcg);
+		memcg1_oom_recover(memcg);
 	}
 
-	memcg1_uncharge_batch(ug->memcg, ug->pgpgout, ug->nr_memory, ug->nid);
+	memcg1_uncharge_batch(memcg, ug->pgpgout, ug->nr_memory, ug->nid);
+	rcu_read_unlock();
 
 	/* drop reference from uncharge_folio */
-	css_put(&ug->memcg->css);
+	obj_cgroup_put(ug->objcg);
 }
 
 static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 {
 	long nr_pages;
-	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
-	 * folio memcg or objcg at this point, we have fully
-	 * exclusive access to the folio.
+	 * folio objcg at this point, we have fully exclusive
+	 * access to the folio.
 	 */
-	if (folio_memcg_kmem(folio)) {
-		objcg = __folio_objcg(folio);
-		/*
-		 * This get matches the put at the end of the function and
-		 * kmem pages do not hold memcg references anymore.
-		 */
-		memcg = get_mem_cgroup_from_objcg(objcg);
-	} else {
-		memcg = __folio_memcg(folio);
-	}
-
-	if (!memcg)
+	objcg = folio_objcg(folio);
+	if (!objcg)
 		return;
 
-	if (ug->memcg != memcg) {
-		if (ug->memcg) {
+	if (ug->objcg != objcg) {
+		if (ug->objcg) {
 			uncharge_batch(ug);
 			uncharge_gather_clear(ug);
 		}
-		ug->memcg = memcg;
+		ug->objcg = objcg;
 		ug->nid = folio_nid(folio);
 
-		/* pairs with css_put in uncharge_batch */
-		css_get(&memcg->css);
+		/* pairs with obj_cgroup_put in uncharge_batch */
+		obj_cgroup_get(objcg);
 	}
 
 	nr_pages = folio_nr_pages(folio);
@@ -5109,20 +5144,17 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	if (folio_memcg_kmem(folio)) {
 		ug->nr_memory += nr_pages;
 		ug->nr_kmem += nr_pages;
-
-		folio->memcg_data = 0;
-		obj_cgroup_put(objcg);
 	} else {
 		/* LRU pages aren't accounted at the root level */
-		if (!mem_cgroup_is_root(memcg))
+		if (!obj_cgroup_is_root(objcg))
 			ug->nr_memory += nr_pages;
 		ug->pgpgout++;
 
 		WARN_ON_ONCE(folio_unqueue_deferred_split(folio));
-		folio->memcg_data = 0;
 	}
 
-	css_put(&memcg->css);
+	folio->memcg_data = 0;
+	obj_cgroup_put(objcg);
 }
 
 void __mem_cgroup_uncharge(struct folio *folio)
@@ -5146,7 +5178,7 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	uncharge_gather_clear(&ug);
 	for (i = 0; i < folios->nr; i++)
 		uncharge_folio(folios->folios[i], &ug);
-	if (ug.memcg)
+	if (ug.objcg)
 		uncharge_batch(&ug);
 }
 
@@ -5163,6 +5195,7 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	long nr_pages = folio_nr_pages(new);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
@@ -5177,21 +5210,24 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 	if (folio_memcg_charged(new))
 		return;
 
-	memcg = folio_memcg(old);
-	VM_WARN_ON_ONCE_FOLIO(!memcg, old);
-	if (!memcg)
+	objcg = folio_objcg(old);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, old);
+	if (!objcg)
 		return;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
 	/* Force-charge the new page. The old one will be freed soon */
-	if (!mem_cgroup_is_root(memcg)) {
+	if (!obj_cgroup_is_root(objcg)) {
 		page_counter_charge(&memcg->memory, nr_pages);
 		if (do_memsw_account())
 			page_counter_charge(&memcg->memsw, nr_pages);
 	}
 
-	css_get(&memcg->css);
-	commit_charge(new, memcg);
+	obj_cgroup_get(objcg);
+	commit_charge(new, objcg);
 	memcg1_commit_charge(new, memcg);
+	rcu_read_unlock();
 }
 
 /**
@@ -5207,7 +5243,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
  */
 void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
 	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
@@ -5218,18 +5254,18 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
 	if (mem_cgroup_disabled())
 		return;
 
-	memcg = folio_memcg(old);
+	objcg = folio_objcg(old);
 	/*
-	 * Note that it is normal to see !memcg for a hugetlb folio.
+	 * Note that it is normal to see !objcg for a hugetlb folio.
 	 * For e.g, it could have been allocated when memory_hugetlb_accounting
 	 * was not selected.
 	 */
-	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !memcg, old);
-	if (!memcg)
+	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(old) && !objcg, old);
+	if (!objcg)
 		return;
 
-	/* Transfer the charge and the css ref */
-	commit_charge(new, memcg);
+	/* Transfer the charge and the objcg ref */
+	commit_charge(new, objcg);
 
 	/* Warning should never happen, so don't worry about refcount non-0 */
 	WARN_ON_ONCE(folio_unqueue_deferred_split(old));
@@ -5412,22 +5448,27 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 	unsigned int nr_pages = folio_nr_pages(folio);
 	struct page_counter *counter;
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
 	if (do_memsw_account())
 		return 0;
 
-	memcg = folio_memcg(folio);
-
-	VM_WARN_ON_ONCE_FOLIO(!memcg, folio);
-	if (!memcg)
+	objcg = folio_objcg(folio);
+	VM_WARN_ON_ONCE_FOLIO(!objcg, folio);
+	if (!objcg)
 		return 0;
 
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
 	if (!entry.val) {
 		memcg_memory_event(memcg, MEMCG_SWAP_FAIL);
+		rcu_read_unlock();
 		return 0;
 	}
 
 	memcg = mem_cgroup_private_id_get_online(memcg, nr_pages);
+	/* memcg is pined by memcg ID. */
+	rcu_read_unlock();
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
-- 
2.20.1


