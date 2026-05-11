Return-Path: <cgroups+bounces-15789-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OL18OPw7AmrYpQEAu9opvQ
	(envelope-from <cgroups+bounces-15789-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:28:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B29A515DCC
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 22:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED6A30166FA
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 20:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD833803D3;
	Mon, 11 May 2026 20:26:12 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DA437FF51;
	Mon, 11 May 2026 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531171; cv=none; b=Zylo3e5bINaVqwMeJtB1V5Lz4tAs9ETDxER+sgH8tMPc8783TlnS18EQMMhPPpcxuGGGvKHktUukvYixmoctH4zl9di7B1u7ZlOPW96pQ35forvUH9Q6F80pKMxubC97XhWGLek2N78C+o0hlGJ7yGCb8CjZ3BQl8n1MXgaxJkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531171; c=relaxed/simple;
	bh=GDUTVCLbaqnFxJHy/T1zq9alaGPwroXfhDoW1ClGD0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQTlPMaK2WlvhF6xTerQEkfKn0+EusyfNc9GXoaqNevs1gLn3nM+1YTBKJypsl4d/MXYBOUMTjPOBJn8gDJ5X6mooBLsVDZ0R9n/HQ9UDZq0oiZGcCwPWsKI1zzQhFjVj7j2IixL1/B8L0L/3NTuR5ZiZPMUYIjg+Sq//lO8nSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 053FD3ECD9;
	Mon, 11 May 2026 20:26:02 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 4/8] mm: memcontrol: track MEMCG_KMEM per NUMA node
Date: Mon, 11 May 2026 22:20:39 +0200
Message-ID: <20260511202136.330358-5-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511202136.330358-1-alex@ghiti.fr>
References: <20260511202136.330358-1-alex@ghiti.fr>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGASuQ7DzVEqE1yqVdt2m1IEMvyeiZ424ZAVS1woSZRBsZRcHOaYxo/wRroa9V549fgoGhwPyYnAfDpxQNFtzkxj0I5TMeBg/5jBppJQkWIBRGnFCdwyKb3+iAwjbc6HCyc2w6Fq1RMe0bJWfA1ndpco4RPwk+ydi46o3tuXnoPGtt57UGuv0fBX6aLFC8egYVKjqd5+b/oNYSj52BJhnje7YewqzwfY3MT59q3IHUZSXd+23dBE9VioRxzwOkioSO0aPH0PeFEsizQ7P2RVgZRWW0PznWL4m6swkEsBSSzcbL/DhTQy/lqZtdEuHj15ch+irNHdmG3iRmpUdYJcCG6UFYwppZMwjrObvHgS58EMHksvqWQIt2KoQM0PZI1xpseSbGrSzDpknKQ+GFdNcw6nOnuQ7+BHS8KOGvpiRrvIYuNxZheuDRqrTykhxMCB4UABVryh8YDbWheFsYjuf47s1ibUxyV/k+zNA2KBvnrWQo+TqY1nHZR1pKRBn4vA1Js2TB6x2+e46F3wkLynXmRZ7UOBPtwrw/U8L6g1VS5gQu7/v9h7bC/QwawE1PkD4NW825qh3+uTm/QJcU5xEOFLVpUaL4Atbgj7z+hHtFPYRb2xCf+4dewwOSer5gMqtqckA2iapVf+FiWW+VV5nGaibP2+vS0guMGZW1Df2SyvQ
X-Rspamd-Queue-Id: 4B29A515DCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-15789-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ghiti.fr];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,gentwo.org,gmail.com,chromium.org,google.com,tencent.com,oracle.com,kvack.org,vger.kernel.org,ghiti.fr];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.658];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:email,ghiti.fr:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patch gets rid of MEMCG_KMEM and wires all the "generic" functions
by introducing per-node obj_cgroup objects.

Note that it does not convert the kmem users to proper per-memcg-per-node
accounting now, this is done in upcoming patches.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 include/linux/memcontrol.h | 23 ++++++++++----
 include/linux/mmzone.h     |  1 +
 mm/memcontrol.c            | 64 ++++++++++++++++++++++++--------------
 mm/vmstat.c                |  1 +
 4 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 568ab08f42af..17cf823160e4 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -35,7 +35,6 @@ enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
-	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
 	MEMCG_ZSWAP_INCOMP,
@@ -126,9 +125,10 @@ struct mem_cgroup_per_node {
 	struct list_head objcg_list;
 
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
-	/* slab stats for nmi context */
+	/* slab and kmem stats for nmi context */
 	atomic_t		slab_reclaimable;
 	atomic_t		slab_unreclaimable;
+	atomic_t		kmem;
 #endif
 };
 
@@ -190,6 +190,7 @@ struct obj_cgroup {
 		struct rcu_head rcu;
 	};
 	bool is_root;
+	int nid;
 };
 
 /*
@@ -254,10 +255,6 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
-#ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
-	/* MEMCG_KMEM for nmi context */
-	atomic_t		kmem_stat;
-#endif
 	/*
 	 * Hint of reclaim pressure for socket memroy management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
@@ -776,6 +773,20 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 		percpu_ref_put(&objcg->refcnt);
 }
 
+static inline struct obj_cgroup *obj_cgroup_get_nid(struct obj_cgroup *objcg,
+						    int nid)
+{
+	struct obj_cgroup *nid_objcg;
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	memcg = obj_cgroup_memcg(objcg);
+	nid_objcg = rcu_dereference(memcg->nodeinfo[nid]->objcg);
+	rcu_read_unlock();
+
+	return nid_objcg;
+}
+
 static inline bool mem_cgroup_tryget(struct mem_cgroup *memcg)
 {
 	return !memcg || css_tryget(&memcg->css);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9adb2ad21da5..97eb168fd7f3 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -326,6 +326,7 @@ enum node_stat_item {
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
+	NR_KMEM,
 	NR_BALLOON_PAGES,
 	NR_KERNEL_FILE_PAGES,
 	NR_GPU_ACTIVE,	/* Pages assigned to GPU objects */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index aaaa6a8b9f15..979a847e542a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -136,6 +136,7 @@ bool mem_cgroup_kmem_disabled(void)
 }
 
 static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
+static void mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx, int val);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -170,9 +171,11 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 
 	if (nr_pages) {
 		struct mem_cgroup *memcg;
+		struct lruvec *lruvec;
 
 		memcg = get_mem_cgroup_from_objcg(objcg);
-		mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+		lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(objcg->nid));
+		mod_lruvec_state(lruvec, NR_KMEM, -nr_pages);
 		memcg1_account_kmem(memcg, -nr_pages);
 		if (!mem_cgroup_is_root(memcg))
 			memcg_uncharge(memcg, nr_pages);
@@ -423,13 +426,13 @@ static const unsigned int memcg_node_stat_items[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
+	NR_KMEM,
 };
 
 static const unsigned int memcg_stat_items[] = {
 	MEMCG_SWAP,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
-	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
 	MEMCG_ZSWAP_INCOMP,
@@ -1537,7 +1540,7 @@ struct memory_stat {
 static const struct memory_stat memory_stats[] = {
 	{ "anon",			NR_ANON_MAPPED			},
 	{ "file",			NR_FILE_PAGES			},
-	{ "kernel",			MEMCG_KMEM			},
+	{ "kernel",			NR_KMEM				},
 	{ "kernel_stack",		NR_KERNEL_STACK_KB		},
 	{ "pagetables",			NR_PAGETABLE			},
 	{ "sec_pagetables",		NR_SECONDARY_PAGETABLE		},
@@ -3004,20 +3007,26 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
 }
 
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
-static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
+static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int nid, int val)
 {
 	if (likely(!in_nmi())) {
-		mod_memcg_state(memcg, MEMCG_KMEM, val);
+		struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+
+		mod_lruvec_state(lruvec, NR_KMEM, val);
 	} else {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
+
 		/* preemption is disabled in_nmi(). */
 		css_rstat_updated(&memcg->css, smp_processor_id());
-		atomic_add(val, &memcg->kmem_stat);
+		atomic_add(val, &pn->kmem);
 	}
 }
 #else
-static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int val)
+static inline void account_kmem_nmi_safe(struct mem_cgroup *memcg, int nid, int val)
 {
-	mod_memcg_state(memcg, MEMCG_KMEM, val);
+	struct lruvec *lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
+
+	mod_lruvec_state(lruvec, NR_KMEM, val);
 }
 #endif
 
@@ -3033,7 +3042,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	account_kmem_nmi_safe(memcg, -nr_pages);
+	account_kmem_nmi_safe(memcg, objcg->nid, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
 		refill_stock(memcg, nr_pages);
@@ -3061,7 +3070,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	account_kmem_nmi_safe(memcg, nr_pages);
+	account_kmem_nmi_safe(memcg, objcg->nid, nr_pages);
 	memcg1_account_kmem(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
@@ -3238,10 +3247,11 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 
 		if (nr_pages) {
 			struct mem_cgroup *memcg;
+			struct lruvec *lruvec;
 
 			memcg = get_mem_cgroup_from_objcg(old);
-
-			mod_memcg_state(memcg, MEMCG_KMEM, -nr_pages);
+			lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(old->nid));
+			mod_lruvec_state(lruvec, NR_KMEM, -nr_pages);
 			memcg1_account_kmem(memcg, -nr_pages);
 			if (!mem_cgroup_is_root(memcg))
 				memcg_uncharge(memcg, nr_pages);
@@ -3250,7 +3260,7 @@ static void drain_obj_stock(struct obj_stock_pcp *stock)
 		}
 
 		/*
-		 * The leftover is flushed to the centralized per-memcg value.
+		 * The leftover is flushed to the per-node per-memcg value.
 		 * On the next attempt to refill obj stock it will be moved
 		 * to a per-cpu stock (probably, on an other CPU), see
 		 * refill_obj_stock().
@@ -3417,7 +3427,7 @@ void obj_cgroup_account_kmem(struct obj_cgroup *objcg, unsigned int nr_pages)
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	account_kmem_nmi_safe(memcg, nr_pages);
+	account_kmem_nmi_safe(memcg, objcg->nid, nr_pages);
 	memcg1_account_kmem(memcg, nr_pages);
 	rcu_read_unlock();
 }
@@ -4165,6 +4175,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		if (unlikely(mem_cgroup_is_root(memcg)))
 			objcg->is_root = true;
 
+		objcg->nid = nid;
 		objcg->memcg = memcg;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->objcg, objcg);
 		obj_cgroup_get(objcg);
@@ -4369,15 +4380,6 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 {
 	int nid;
 
-	if (atomic_read(&memcg->kmem_stat)) {
-		int kmem = atomic_xchg(&memcg->kmem_stat, 0);
-		int index = memcg_stats_index(MEMCG_KMEM);
-
-		memcg->vmstats->state[index] += kmem;
-		if (parent)
-			parent->vmstats->state_pending[index] += kmem;
-	}
-
 	for_each_node_state(nid, N_MEMORY) {
 		struct mem_cgroup_per_node *pn = memcg->nodeinfo[nid];
 		struct lruvec_stats *lstats = pn->lruvec_stats;
@@ -4408,6 +4410,18 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 			if (parent)
 				parent->vmstats->state_pending[index] += slab;
 		}
+		if (atomic_read(&pn->kmem)) {
+			int kmem = atomic_xchg(&pn->kmem, 0);
+			int index = memcg_stats_index(NR_KMEM);
+
+			mod_node_page_state(NODE_DATA(nid), NR_KMEM, kmem);
+			lstats->state[index] += kmem;
+			memcg->vmstats->state[index] += kmem;
+			if (plstats)
+				plstats->state_pending[index] += kmem;
+			if (parent)
+				parent->vmstats->state_pending[index] += kmem;
+		}
 	}
 }
 #else
@@ -5173,7 +5187,9 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	if (ug->nr_memory) {
 		memcg_uncharge(memcg, ug->nr_memory);
 		if (ug->nr_kmem) {
-			mod_memcg_state(memcg, MEMCG_KMEM, -ug->nr_kmem);
+			struct lruvec *lruvec =
+				mem_cgroup_lruvec(memcg, NODE_DATA(ug->objcg->nid));
+			mod_lruvec_state(lruvec, NR_KMEM, -ug->nr_kmem);
 			memcg1_account_kmem(memcg, -ug->nr_kmem);
 		}
 		memcg1_oom_recover(memcg);
diff --git a/mm/vmstat.c b/mm/vmstat.c
index f534972f517d..d55437d1852e 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1293,6 +1293,7 @@ const char * const vmstat_text[] = {
 #ifdef CONFIG_HUGETLB_PAGE
 	[I(NR_HUGETLB)]				= "nr_hugetlb",
 #endif
+	[I(NR_KMEM)]				= "nr_kmem",
 	[I(NR_BALLOON_PAGES)]			= "nr_balloon_pages",
 	[I(NR_KERNEL_FILE_PAGES)]		= "nr_kernel_file_pages",
 	[I(NR_GPU_ACTIVE)]			= "nr_gpu_active",
-- 
2.54.0


