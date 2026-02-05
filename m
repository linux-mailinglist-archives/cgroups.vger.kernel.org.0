Return-Path: <cgroups+bounces-13714-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFMMJs9ihGkK2wMAu9opvQ
	(envelope-from <cgroups+bounces-13714-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:28:47 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2879F0BAC
	for <lists+cgroups@lfdr.de>; Thu, 05 Feb 2026 10:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6F86D304F6B4
	for <lists+cgroups@lfdr.de>; Thu,  5 Feb 2026 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777A137AA6F;
	Thu,  5 Feb 2026 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I2kS9MEF"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019A36E48C
	for <cgroups@vger.kernel.org>; Thu,  5 Feb 2026 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770282347; cv=none; b=A8KBQICw8x/uMLQtOt+0u+MwmQpnnB/U/X4b36U+MICyFrfZxMsNo1HRdSUn8Bwd1EXPvj/6Vokuzj6bhD8tWcqcXm3t/V+rgwEaYqz7rKGANKlqSgEM9hKDqL8bhVAcL0LTH1yKWwoibmYqpfnyKKy95GRJUDGhTYwwJGP7zKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770282347; c=relaxed/simple;
	bh=bM7vmMYSZQdKgQqfIf/f23O4rlScycCzxth0GrcfihQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLVQZwX65EzOZt99/jX4nkWtmiDAGwHNPXplenLydyQ7Sw0LTzfdatYNAywsFnV7Su4GDee4j5j99K7JD7phCFBVhJjPlwSzJbVvAaWqr2hTTeVueIsWNO0DUSymYlTs8vnal4tC6bm5L/RV4wgs3Zbn9ZHiMCTTh3x+BemOX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I2kS9MEF; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770282345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8JSIks0tXwWUqJFSSaNFYyF319s5P2AVApSBDKth2o=;
	b=I2kS9MEFCNl3PuIuAo1qoTU0dBZZQMj39NOvIgHkCWmLZoVt7/VbOBQWo+ooYwwkWeRTBf
	UR059EqfR7+rIYIx04NrxsS5xbO3fa3eN4t/xMgne4BQAS5XvD+1PDnENsWb9OO3ceifP3
	j1tRc/YMiZkl0z23bV0SaMB/kJG4W9Y=
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
	Muchun Song <songmuchun@bytedance.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 30/31] mm: memcontrol: eliminate the problem of dying memory cgroup for LRU folios
Date: Thu,  5 Feb 2026 17:01:49 +0800
Message-ID: <9e332cc8436b6092dd6ef9c2d5f69072bb38eaf6.1770279888.git.zhengqi.arch@bytedance.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-13714-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qi.zheng@linux.dev,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B2879F0BAC
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
 mm/memcontrol.c            | 200 +++++++++++++++++++++++--------------
 3 files changed, 159 insertions(+), 133 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a4f6ab7eb98d6..15eec4ee00c29 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -369,9 +369,6 @@ enum objext_flags {
 #define OBJEXTS_FLAGS_MASK (__NR_OBJEXTS_FLAGS - 1)
 
 #ifdef CONFIG_MEMCG
-
-static inline bool folio_memcg_kmem(struct folio *folio);
-
 /*
  * After the initialization objcg->memcg is always pointing at
  * a valid memcg, but can be atomically swapped to the parent memcg.
@@ -385,43 +382,19 @@ static inline struct mem_cgroup *obj_cgroup_memcg(struct obj_cgroup *objcg)
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
@@ -435,21 +408,30 @@ static inline struct obj_cgroup *__folio_objcg(struct folio *folio)
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
@@ -473,15 +455,10 @@ static inline bool folio_memcg_charged(struct folio *folio)
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
@@ -490,18 +467,14 @@ static inline struct mem_cgroup *folio_memcg_check(struct folio *folio)
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
index a427bb205763b..401ba65470410 100644
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
@@ -647,7 +649,7 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
 
-	if (!mem_cgroup_is_root(memcg))
+	if (!obj_cgroup_is_root(objcg))
 		page_counter_uncharge(&memcg->memory, nr_entries);
 
 	if (memcg != swap_memcg) {
@@ -668,7 +670,8 @@ void memcg1_swapout(struct folio *folio, swp_entry_t entry)
 	preempt_enable_nested();
 	memcg1_check_events(memcg, folio_nid(folio));
 
-	css_put(&memcg->css);
+	rcu_read_unlock();
+	obj_cgroup_put(objcg);
 }
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e7d4e4ff411b6..0e0efaa511d3d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -247,11 +247,25 @@ static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgr
 
 static inline void reparent_locks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
+	int nid, nest = 0;
+
 	spin_lock_irq(&objcg_lock);
+	for_each_node(nid) {
+		spin_lock_nested(&mem_cgroup_lruvec(memcg,
+				 NODE_DATA(nid))->lru_lock, nest++);
+		spin_lock_nested(&mem_cgroup_lruvec(parent,
+				 NODE_DATA(nid))->lru_lock, nest++);
+	}
 }
 
 static inline void reparent_unlocks(struct mem_cgroup *memcg, struct mem_cgroup *parent)
 {
+	int nid;
+
+	for_each_node(nid) {
+		spin_unlock(&mem_cgroup_lruvec(parent, NODE_DATA(nid))->lru_lock);
+		spin_unlock(&mem_cgroup_lruvec(memcg, NODE_DATA(nid))->lru_lock);
+	}
 	spin_unlock_irq(&objcg_lock);
 }
 
@@ -260,12 +274,28 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
 	struct obj_cgroup *objcg;
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 
+retry:
+	if (lru_gen_enabled())
+		max_lru_gen_memcg(parent);
+
 	reparent_locks(memcg, parent);
+	if (lru_gen_enabled()) {
+		if (!recheck_lru_gen_max_memcg(parent)) {
+			reparent_unlocks(memcg, parent);
+			cond_resched();
+			goto retry;
+		}
+		lru_gen_reparent_memcg(memcg, parent);
+	} else {
+		lru_reparent_memcg(memcg, parent);
+	}
 
 	objcg = __memcg_reparent_objcgs(memcg, parent);
 
 	reparent_unlocks(memcg, parent);
 
+	reparent_state_local(memcg, parent);
+
 	percpu_ref_kill(&objcg->refcnt);
 }
 
@@ -809,9 +839,14 @@ void mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 
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
@@ -852,6 +887,7 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 				     enum node_stat_item idx,
 				     int val)
 {
+	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 	struct mem_cgroup_per_node *pn;
 	struct mem_cgroup *memcg;
 	int i = memcg_stats_index(idx);
@@ -865,14 +901,18 @@ static void mod_memcg_lruvec_state(struct lruvec *lruvec,
 
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
@@ -1098,6 +1138,8 @@ struct mem_cgroup *get_mem_cgroup_from_current(void)
 /**
  * get_mem_cgroup_from_folio - Obtain a reference on a given folio's memcg.
  * @folio: folio from which memcg should be extracted.
+ *
+ * See folio_memcg() for folio->objcg/memcg binding rules.
  */
 struct mem_cgroup *get_mem_cgroup_from_folio(struct folio *folio)
 {
@@ -2711,17 +2753,17 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2833,6 +2875,17 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
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
@@ -2933,17 +2986,10 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
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
 
@@ -3459,7 +3505,7 @@ void folio_split_memcg_refs(struct folio *folio, unsigned old_order,
 		return;
 
 	new_refs = (1 << (old_order - new_order)) - 1;
-	css_get_many(&__folio_memcg(folio)->css, new_refs);
+	obj_cgroup_get_many(folio_objcg(folio), new_refs);
 }
 
 static void memcg_online_kmem(struct mem_cgroup *memcg)
@@ -4890,16 +4936,20 @@ void mem_cgroup_calculate_protection(struct mem_cgroup *root,
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
+		ret = try_charge(memcg, gfp, folio_nr_pages(folio));
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
 
@@ -4985,7 +5035,7 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 }
 
 struct uncharge_gather {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	unsigned long nr_memory;
 	unsigned long pgpgout;
 	unsigned long nr_kmem;
@@ -4999,58 +5049,52 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 
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
@@ -5058,20 +5102,17 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
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
@@ -5095,7 +5136,7 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 	uncharge_gather_clear(&ug);
 	for (i = 0; i < folios->nr; i++)
 		uncharge_folio(folios->folios[i], &ug);
-	if (ug.memcg)
+	if (ug.objcg)
 		uncharge_batch(&ug);
 }
 
@@ -5112,6 +5153,7 @@ void __mem_cgroup_uncharge_folios(struct folio_batch *folios)
 void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 	long nr_pages = folio_nr_pages(new);
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
@@ -5126,21 +5168,24 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
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
@@ -5156,7 +5201,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
  */
 void mem_cgroup_migrate(struct folio *old, struct folio *new)
 {
-	struct mem_cgroup *memcg;
+	struct obj_cgroup *objcg;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
 	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
@@ -5167,18 +5212,18 @@ void mem_cgroup_migrate(struct folio *old, struct folio *new)
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
@@ -5361,22 +5406,27 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
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
 
 	memcg = mem_cgroup_private_id_get_online(memcg);
+	/* memcg is pined by memcg ID. */
+	rcu_read_unlock();
 
 	if (!mem_cgroup_is_root(memcg) &&
 	    !page_counter_try_charge(&memcg->swap, nr_pages, &counter)) {
-- 
2.20.1


