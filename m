Return-Path: <cgroups+bounces-17321-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ahAUDNJUPmqQDwkAu9opvQ
	(envelope-from <cgroups+bounces-17321-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:30:42 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0326CC184
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 12:30:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17321-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17321-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA6633026E7C
	for <lists+cgroups@lfdr.de>; Fri, 26 Jun 2026 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5C3EFD02;
	Fri, 26 Jun 2026 10:29:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23A53ED3A9;
	Fri, 26 Jun 2026 10:29:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782469790; cv=none; b=R6GAFnUC0GdYDNXBsHwmJEAU/xDiwx4Oda8Pw2JFmQK/8Xl4l0RUShEiC7TlcrYrMTJWqD6sy/gdhwJxvatzYkYrWtUBoLClmKbj3IV3PRcwNSlc1dobxBdnSX8e5L+9FJVUvZGzcGRfYkcv893u6UhAC13CO5i+zCwGzYZxtyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782469790; c=relaxed/simple;
	bh=fy6M6sT+ZfTaNcD5yI8SgIcYOWMVc/sJnU+uXABwQfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3v/h1QQkBugAZuwFhPyEBx6RsKiQMLpcyIqESmxklvkX2s5eFqQCHzfA77dmLyhjuQwjQUWn4601jBRiGLIHwf3pDEPYpJ1kXlfn1vdl0ZPQ02ogI86i3HOo0piL4BtXAgrraYaRL0qnOBgZcOlD7H7TP079jj3jpfAUQ/9b7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0ACD21F65B;
	Fri, 26 Jun 2026 10:29:39 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: alexandre@ghiti.fr,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>,
	Barry Song <baohua@kernel.org>,
	Ben Segall <bsegall@google.com>,
	cgroups@vger.kernel.org,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Hildenbrand <david@kernel.org>,
	Dennis Zhou <dennis@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Kairui Song <kasong@tencent.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Tejun Heo <tj@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Wei Xu <weixugc@google.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Yuanchu Xie <yuanchu@google.com>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 5/9] mm: memcontrol: track MEMCG_KMEM per NUMA node
Date: Fri, 26 Jun 2026 12:20:54 +0200
Message-ID: <20260626102358.1603618-6-alex@ghiti.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626102358.1603618-1-alex@ghiti.fr>
References: <20260626102358.1603618-1-alex@ghiti.fr>
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
X-GND-Cause: dmFkZTGdhs9xuqAzUROmmsJvsJjXlJZ0qeTIQWv1SwQGarWmGYIa0sFgvk5TpQ9jfrltusvZoPk8YdWn3PZEEalLBjdfHMe7NqNuZrhxSoChbVpy5Nep8byl3DHWVqDvp22mXFzlNO8942ydLlAkQ+L6aO+eIgnDvtvprJXn6Gk9sJGXK+ptPbEvnkFg0hCg1QwOx0jFi2oA3CD11zGmtPZ3Qj90hnJeuAwCdkM5UQT74WjOHTYJqjH6/g55DRp4gxglIvoWlT1Dy8heeGbvllTWUsmkWwtaP9Gq6rx1FN35MPiV+ZgrCHBylug5kSysqz4Bd4NnZNgsc26P0Z686fWBs04NmhDwJhRVUM511DOXL7IqzWPOEjEgB/QpJP6wf7Ur6bAZjKtcFUzy3c7uwImkbKgeFMzFpKuZTmoRC5EfVKrmvyqU8R4oK2AWp8fY+l9ov3UtyvlcviFq6iZwIRQv0dRr0H080tw081br9wjabs/4DorJCqi3zz2rKa40PV7BmVrpQVPEUQJD+UFXwROdU0MvLAyhWUKDyLJakdHOQdFCWxPJgpjMKTKj4/4OArD7AD86mZ87p7kz/z0WJFDaDvzk5KMgxRdDMJG1WY5B+ciyUyqtiDasAbdicuGnw8yF0b2KdSqUTsZybjqcHuXD7V17cgJ1q9CRxPXBghnegPIVJQ
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17321-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[ghiti.fr];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:alexandre@ghiti.fr,m:akpm@linux-foundation.org,m:axelrasmussen@google.com,m:baohua@kernel.org,m:bsegall@google.com,m:cgroups@vger.kernel.org,m:chengming.zhou@linux.dev,m:cl@gentwo.org,m:david@kernel.org,m:dennis@kernel.org,m:dietmar.eggemann@arm.com,m:mingo@redhat.com,m:hannes@cmpxchg.org,m:juri.lelli@redhat.com,m:kasong@tencent.com,m:kent.overstreet@linux.dev,m:kprateek.nayak@amd.com,m:liam@infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:ljs@kernel.org,m:mgorman@suse.de,m:mhocko@kernel.org,m:rppt@kernel.org,m:minchan@kernel.org,m:muchun.song@linux.dev,m:nphamcs@gmail.com,m:peterz@infradead.org,m:qi.zheng@linux.dev,m:roman.gushchin@linux.dev,m:senozhatsky@chromium.org,m:shakeel.butt@linux.dev,m:rostedt@goodmis.org,m:surenb@google.com,m:tj@kernel.org,m:vschneid@redhat.com,m:vincent.guittot@linaro.org,m:vbabka@kernel.org,m:weixugc@google.com,m:yosry@kernel.org,m:yuanchu@google.com,m:alex@ghiti.fr,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,linux.dev,gentwo.org,arm.com,redhat.com,cmpxchg.org,tencent.com,amd.com,infradead.org,kvack.org,suse.de,gmail.com,chromium.org,goodmis.org,linaro.org,ghiti.fr];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@ghiti.fr,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ghiti.fr:email,ghiti.fr:mid,ghiti.fr:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A0326CC184

This patch gets rid of MEMCG_KMEM and wires all the "generic" functions
by introducing per-node obj_cgroup objects.

Note that it does not convert the kmem users to proper per-memcg-per-node
accounting now, this is done in upcoming patches.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 include/linux/memcontrol.h | 19 +++++++----
 include/linux/mmzone.h     |  1 +
 mm/memcontrol.c            | 64 ++++++++++++++++++++++++--------------
 mm/vmstat.c                |  1 +
 4 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 8f419ee54510..a60fa197a973 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -36,7 +36,6 @@ enum memcg_stat_item {
 	MEMCG_SWAP = NR_VM_NODE_STAT_ITEMS,
 	MEMCG_SOCK,
 	MEMCG_PERCPU_B,
-	MEMCG_KMEM,
 	MEMCG_ZSWAP_B,
 	MEMCG_ZSWAPPED,
 	MEMCG_ZSWAP_INCOMP,
@@ -127,9 +126,10 @@ struct mem_cgroup_per_node {
 	struct list_head objcg_list;
 
 #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
-	/* slab stats for nmi context */
+	/* slab and kmem stats for nmi context */
 	atomic_t		slab_reclaimable;
 	atomic_t		slab_unreclaimable;
+	atomic_t		kmem;
 #endif
 };
 
@@ -191,6 +191,7 @@ struct obj_cgroup {
 		struct rcu_head rcu;
 	};
 	bool is_root;
+	int nid;
 };
 
 /*
@@ -255,10 +256,6 @@ struct mem_cgroup {
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 	atomic_long_t		memory_events_local[MEMCG_NR_MEMORY_EVENTS];
 
-#ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
-	/* MEMCG_KMEM for nmi context */
-	atomic_t		kmem_stat;
-#endif
 	/*
 	 * Hint of reclaim pressure for socket memroy management. Note
 	 * that this indicator should NOT be used in legacy cgroup mode
@@ -773,6 +770,16 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
 		percpu_ref_put(&objcg->refcnt);
 }
 
+static inline struct obj_cgroup *obj_cgroup_nid(struct obj_cgroup *objcg,
+						int nid)
+{
+	struct mem_cgroup *memcg = obj_cgroup_memcg(objcg);
+
+	/* Borrowed RCU lookup: takes no reference, caller must hold RCU. */
+	WARN_ON_ONCE(!rcu_read_lock_held());
+	return rcu_dereference(memcg->nodeinfo[nid]->objcg);
+}
+
 static inline bool mem_cgroup_tryget(struct mem_cgroup *memcg)
 {
 	return !memcg || css_tryget(&memcg->css);
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ca2712187147..753fdf9dc80f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -327,6 +327,7 @@ enum node_stat_item {
 #ifdef CONFIG_HUGETLB_PAGE
 	NR_HUGETLB,
 #endif
+	NR_KMEM,
 	NR_BALLOON_PAGES,
 	NR_KERNEL_FILE_PAGES,
 	NR_GPU_ACTIVE,	/* Pages assigned to GPU objects */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 480fba12a217..c6a0d8463400 100644
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
@@ -1546,7 +1549,7 @@ struct memory_stat {
 static const struct memory_stat memory_stats[] = {
 	{ "anon",			NR_ANON_MAPPED			},
 	{ "file",			NR_FILE_PAGES			},
-	{ "kernel",			MEMCG_KMEM			},
+	{ "kernel",			NR_KMEM				},
 	{ "kernel_stack",		NR_KERNEL_STACK_KB		},
 	{ "pagetables",			NR_PAGETABLE			},
 	{ "sec_pagetables",		NR_SECONDARY_PAGETABLE		},
@@ -3052,20 +3055,26 @@ struct obj_cgroup *get_obj_cgroup_from_folio(struct folio *folio)
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
 		__css_rstat_updated(&memcg->css, smp_processor_id());
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
 
@@ -3081,7 +3090,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	memcg = get_mem_cgroup_from_objcg(objcg);
 
-	account_kmem_nmi_safe(memcg, -nr_pages);
+	account_kmem_nmi_safe(memcg, objcg->nid, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
 		refill_stock(memcg, nr_pages);
@@ -3109,7 +3118,7 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
 	if (ret)
 		goto out;
 
-	account_kmem_nmi_safe(memcg, nr_pages);
+	account_kmem_nmi_safe(memcg, objcg->nid, nr_pages);
 	memcg1_account_kmem(memcg, nr_pages);
 out:
 	css_put(&memcg->css);
@@ -3337,10 +3346,11 @@ static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
 
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
@@ -3349,7 +3359,7 @@ static void drain_obj_stock_slot(struct obj_stock_pcp *stock, int i)
 		}
 
 		/*
-		 * The leftover is flushed to the centralized per-memcg value.
+		 * The leftover is flushed to the per-node per-memcg value.
 		 * On the next attempt to refill obj stock it will be moved
 		 * to a per-cpu stock (probably, on an other CPU), see
 		 * refill_obj_stock().
@@ -3548,7 +3558,7 @@ void obj_cgroup_account_kmem(struct obj_cgroup *objcg, unsigned int nr_pages)
 
 	rcu_read_lock();
 	memcg = obj_cgroup_memcg(objcg);
-	account_kmem_nmi_safe(memcg, nr_pages);
+	account_kmem_nmi_safe(memcg, objcg->nid, nr_pages);
 	memcg1_account_kmem(memcg, nr_pages);
 	rcu_read_unlock();
 }
@@ -4302,6 +4312,7 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 		if (unlikely(mem_cgroup_is_root(memcg)))
 			objcg->is_root = true;
 
+		objcg->nid = nid;
 		objcg->memcg = memcg;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->objcg, objcg);
 		obj_cgroup_get(objcg);
@@ -4505,15 +4516,6 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
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
@@ -4544,6 +4546,18 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
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
@@ -5332,7 +5346,9 @@ static void uncharge_batch(const struct uncharge_gather *ug)
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


