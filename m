Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568B347D124
	for <lists+cgroups@lfdr.de>; Wed, 22 Dec 2021 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbhLVLlW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 06:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbhLVLlV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 06:41:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C3C061574
        for <cgroups@vger.kernel.org>; Wed, 22 Dec 2021 03:41:21 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640173280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbjlozVMz2Wkr17DO5VtsJrNAByqWrtYZ+vXHGFGCQY=;
        b=wJDUuc3OLMQa6e0ckxz6JRN9jML8UX7O14RsNSDPOAAAeadYK6nnymXmxgpLrpQCnPq5vL
        tUnHXi1ADU2/9As7/bQcerpPrN6ayjuPjwLg6qgc2OZVHPA2AA+EkMTgm57Mi/0D4PMvuR
        7HSdOmc0EhkOGFYueNx1yeW93mhnVpqZS/qgx2pU/vs94AXiie5/FwaiS9YPDhq0EtJQg2
        SL2ivHjWbnqoUcypJ7xpqQAzHfK7EshEFkgp8wMry4NRRneetBbu9reef2xPTjxTfgPk8f
        dFyVc9LsOpDz0lMvXEjWIh3olbobmM/zvSPe1SoYH7DWWZeNOmuLwEsxtl714g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640173280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LbjlozVMz2Wkr17DO5VtsJrNAByqWrtYZ+vXHGFGCQY=;
        b=y/rG53sKbirgF0Cjjn3BPg0rqdfxlOiJyc5eDqXHlqQWU+HXEZrw9F7lYFT+43/EeKKf76
        SuA2D/DnctTGhnBA==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 2/3] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Date:   Wed, 22 Dec 2021 12:41:10 +0100
Message-Id: <20211222114111.2206248-3-bigeasy@linutronix.de>
In-Reply-To: <20211222114111.2206248-1-bigeasy@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The members of the per-CPU structure memcg_stock_pcp are protected
either by disabling interrupts or by disabling preemption if the
invocation occurred in process context.
Disabling interrupts protects most of the structure excluding task_obj
while disabling preemption protects only task_obj.
This schema is incompatible with PREEMPT_RT because it creates atomic
context in which actions are performed which require preemptible
context. One example is obj_cgroup_release().

The IRQ-disable and preempt-disable sections can be replaced with
local_lock_t which preserves the explicit disabling of interrupts while
keeps the code preemptible on PREEMPT_RT.

The task_obj has been added for performance reason on non-preemptible
kernels where preempt_disable() is a NOP. On the PREEMPT_RT preemption
model preempt_disable() is always implemented. Also there are no memory
allocations in_irq() context and softirqs are processed in (preemptible)
process context. Therefore it makes sense to avoid using task_obj.

Don't use task_obj on PREEMPT_RT and replace manual disabling of
interrupts with a local_lock_t. This change requires some factoring:

- drain_obj_stock() drops a reference on obj_cgroup which leads to an
  invocation of obj_cgroup_release() if it is the last object. This in
  turn leads to recursive locking of the local_lock_t. To avoid this,
  obj_cgroup_release() is invoked outside of the locked section.

- drain_obj_stock() gets a memcg_stock_pcp passed if the stock_lock has been
  acquired (instead of the task_obj_lock) to avoid recursive locking later
  in refill_stock().

- drain_all_stock() disables preemption via get_cpu() and then invokes
  drain_local_stock() if it is the local CPU to avoid scheduling a worker
  (which invokes the same function). Disabling preemption here is
  problematic due to the sleeping locks in drain_local_stock().
  This can be avoided by always scheduling a worker, even for the local
  CPU. Using cpus_read_lock() stabilizes cpu_online_mask which ensures
  that no worker is scheduled for an offline CPU. Since there is no
  flush_work(), it is still possible that a worker is invoked on the wrong
  CPU but it is okay since it operates always on the local-CPU data.

- drain_local_stock() is always invoked as a worker so it can be optimized
  by removing in_task() (it is always true) and avoiding the "irq_save"
  variant because interrupts are always enabled here. Operating on
  task_obj first allows to acquire the lock_lock_t without lockdep
  complains.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 171 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 112 insertions(+), 59 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d2687d5ed544b..1e76f26be2c15 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,8 +261,10 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
=20
+struct memcg_stock_pcp;
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+				      unsigned int nr_pages,
+				      struct memcg_stock_pcp *stock_pcp);
=20
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -296,7 +298,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages =3D nr_bytes >> PAGE_SHIFT;
=20
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
=20
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -2120,26 +2122,40 @@ struct obj_stock {
 };
=20
 struct memcg_stock_pcp {
+	/* Protects memcg_stock_pcp */
+	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
+#ifndef CONFIG_PREEMPT_RT
+	/* Protects only task_obj */
+	local_lock_t task_obj_lock;
 	struct obj_stock task_obj;
+#endif
 	struct obj_stock irq_obj;
=20
 	struct work_struct work;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
+static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) =3D {
+	.stock_lock =3D INIT_LOCAL_LOCK(stock_lock),
+#ifndef CONFIG_PREEMPT_RT
+	.task_obj_lock =3D INIT_LOCAL_LOCK(task_obj_lock),
+#endif
+};
 static DEFINE_MUTEX(percpu_charge_mutex);
=20
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct obj_stock *stock);
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  struct memcg_stock_pcp *stock_pcp);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
=20
 #else
-static inline void drain_obj_stock(struct obj_stock *stock)
+static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+						 struct memcg_stock_pcp *stock_pcp)
 {
+	return NULL;
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
@@ -2168,7 +2184,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (memcg =3D=3D stock->cached && stock->nr_pages >=3D nr_pages) {
@@ -2176,7 +2192,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 		ret =3D true;
 	}
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
=20
 	return ret;
 }
@@ -2204,38 +2220,43 @@ static void drain_stock(struct memcg_stock_pcp *sto=
ck)
=20
 static void drain_local_stock(struct work_struct *dummy)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	struct memcg_stock_pcp *stock_pcp;
+	struct obj_cgroup *old;
=20
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_irq_save(flags);
+#ifndef CONFIG_PREEMPT_RT
+	local_lock(&memcg_stock.task_obj_lock);
+	old =3D drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
+	local_unlock(&memcg_stock.task_obj_lock);
+	if (old)
+		obj_cgroup_put(old);
+#endif
=20
-	stock =3D this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(&stock->irq_obj);
-	if (in_task())
-		drain_obj_stock(&stock->task_obj);
-	drain_stock(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	local_lock_irq(&memcg_stock.stock_lock);
+	stock_pcp =3D this_cpu_ptr(&memcg_stock);
+	old =3D drain_obj_stock(&stock_pcp->irq_obj, stock_pcp);
=20
-	local_irq_restore(flags);
+	drain_stock(stock_pcp);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock_pcp->flags);
+
+	local_unlock_irq(&memcg_stock.stock_lock);
+	if (old)
+		obj_cgroup_put(old);
 }
=20
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			   struct memcg_stock_pcp *stock)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	lockdep_assert_held(&stock->stock_lock);
=20
-	local_irq_save(flags);
-
-	stock =3D this_cpu_ptr(&memcg_stock);
 	if (stock->cached !=3D memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
@@ -2245,8 +2266,20 @@ static void refill_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
=20
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
=20
-	local_irq_restore(flags);
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			 struct memcg_stock_pcp *stock_pcp)
+{
+	unsigned long flags;
+
+	if (stock_pcp) {
+		__refill_stock(memcg, nr_pages, stock_pcp);
+		return;
+	}
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	__refill_stock(memcg, nr_pages, this_cpu_ptr(&memcg_stock));
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
=20
 /*
@@ -2255,7 +2288,7 @@ static void refill_stock(struct mem_cgroup *memcg, un=
signed int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu, curcpu;
+	int cpu;
=20
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2266,7 +2299,7 @@ static void drain_all_stock(struct mem_cgroup *root_m=
emcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu =3D get_cpu();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock =3D &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2282,14 +2315,10 @@ static void drain_all_stock(struct mem_cgroup *root=
_memcg)
 		rcu_read_unlock();
=20
 		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
-			if (cpu =3D=3D curcpu)
-				drain_local_stock(&stock->work);
-			else
-				schedule_work_on(cpu, &stock->work);
-		}
+		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
+			schedule_work_on(cpu, &stock->work);
 	}
-	put_cpu();
+	cpus_read_unlock();
 	mutex_unlock(&percpu_charge_mutex);
 }
=20
@@ -2690,7 +2719,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg,=
 gfp_t gfp_mask,
=20
 done_restock:
 	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
+		refill_stock(memcg, batch - nr_pages, NULL);
=20
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -2803,28 +2832,35 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg=
(struct obj_cgroup *objcg)
  * can only be accessed after disabling interrupt. User context code can
  * access interrupt object stock, but not vice versa.
  */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
+static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
+					      struct memcg_stock_pcp **stock_pcp)
 {
 	struct memcg_stock_pcp *stock;
=20
+#ifndef CONFIG_PREEMPT_RT
 	if (likely(in_task())) {
 		*pflags =3D 0UL;
-		preempt_disable();
+		*stock_pcp =3D NULL;
+		local_lock(&memcg_stock.task_obj_lock);
 		stock =3D this_cpu_ptr(&memcg_stock);
 		return &stock->task_obj;
 	}
-
-	local_irq_save(*pflags);
+#endif
+	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
 	stock =3D this_cpu_ptr(&memcg_stock);
+	*stock_pcp =3D stock;
 	return &stock->irq_obj;
 }
=20
-static inline void put_obj_stock(unsigned long flags)
+static inline void put_obj_stock(unsigned long flags,
+				 struct memcg_stock_pcp *stock_pcp)
 {
-	if (likely(in_task()))
-		preempt_enable();
+#ifndef CONFIG_PREEMPT_RT
+	if (likely(!stock_pcp))
+		local_unlock(&memcg_stock.task_obj_lock);
 	else
-		local_irq_restore(flags);
+#endif
+		local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
=20
 /*
@@ -3002,7 +3038,8 @@ static void memcg_free_cache_id(int id)
  * @nr_pages: number of pages to uncharge
  */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages)
+				      unsigned int nr_pages,
+				      struct memcg_stock_pcp *stock_pcp)
 {
 	struct mem_cgroup *memcg;
=20
@@ -3010,7 +3047,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgro=
up *objcg,
=20
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, stock_pcp);
=20
 	css_put(&memcg->css);
 }
@@ -3084,7 +3121,7 @@ void __memcg_kmem_uncharge_page(struct page *page, in=
t order)
 		return;
=20
 	objcg =3D __folio_objcg(folio);
-	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
 	folio->memcg_data =3D 0;
 	obj_cgroup_put(objcg);
 }
@@ -3092,17 +3129,21 @@ void __memcg_kmem_uncharge_page(struct page *page, =
int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
+	struct memcg_stock_pcp *stock_pcp;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
+	struct obj_cgroup *old =3D NULL;
+	struct obj_stock *stock;
 	int *bytes;
=20
+	stock =3D get_obj_stock(&flags, &stock_pcp);
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
 	 * changes.
 	 */
 	if (stock->cached_objcg !=3D objcg) {
-		drain_obj_stock(stock);
+		old =3D drain_obj_stock(stock, stock_pcp);
+
 		obj_cgroup_get(objcg);
 		stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3146,38 +3187,43 @@ void mod_objcg_state(struct obj_cgroup *objcg, stru=
ct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
=20
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_pcp);
+	if (old)
+		obj_cgroup_put(old);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_by=
tes)
 {
+	struct memcg_stock_pcp *stock_pcp;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
+	struct obj_stock *stock;
 	bool ret =3D false;
=20
+	stock =3D get_obj_stock(&flags, &stock_pcp);
 	if (objcg =3D=3D stock->cached_objcg && stock->nr_bytes >=3D nr_bytes) {
 		stock->nr_bytes -=3D nr_bytes;
 		ret =3D true;
 	}
=20
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_pcp);
=20
 	return ret;
 }
=20
-static void drain_obj_stock(struct obj_stock *stock)
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  struct memcg_stock_pcp *stock_pcp)
 {
 	struct obj_cgroup *old =3D stock->cached_objcg;
=20
 	if (!old)
-		return;
+		return NULL;
=20
 	if (stock->nr_bytes) {
 		unsigned int nr_pages =3D stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes =3D stock->nr_bytes & (PAGE_SIZE - 1);
=20
 		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages);
+			obj_cgroup_uncharge_pages(old, nr_pages, stock_pcp);
=20
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3212,8 +3258,8 @@ static void drain_obj_stock(struct obj_stock *stock)
 		stock->cached_pgdat =3D NULL;
 	}
=20
-	obj_cgroup_put(old);
 	stock->cached_objcg =3D NULL;
+	return old;
 }
=20
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3221,11 +3267,13 @@ static bool obj_stock_flush_required(struct memcg_s=
tock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
=20
+#ifndef CONFIG_PREEMPT_RT
 	if (in_task() && stock->task_obj.cached_objcg) {
 		memcg =3D obj_cgroup_memcg(stock->task_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
+#endif
 	if (stock->irq_obj.cached_objcg) {
 		memcg =3D obj_cgroup_memcg(stock->irq_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
@@ -3238,12 +3286,15 @@ static bool obj_stock_flush_required(struct memcg_s=
tock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_byt=
es,
 			     bool allow_uncharge)
 {
+	struct memcg_stock_pcp *stock_pcp;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
+	struct obj_stock *stock;
 	unsigned int nr_pages =3D 0;
+	struct obj_cgroup *old =3D NULL;
=20
+	stock =3D get_obj_stock(&flags, &stock_pcp);
 	if (stock->cached_objcg !=3D objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		old =3D drain_obj_stock(stock, stock_pcp);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg =3D objcg;
 		stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
@@ -3257,10 +3308,12 @@ static void refill_obj_stock(struct obj_cgroup *obj=
cg, unsigned int nr_bytes,
 		stock->nr_bytes &=3D (PAGE_SIZE - 1);
 	}
=20
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_pcp);
+	if (old)
+		obj_cgroup_put(old);
=20
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
 }
=20
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -7061,7 +7114,7 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *mem=
cg, unsigned int nr_pages)
=20
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
=20
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, NULL);
 }
=20
 static int __init cgroup_memory(char *s)
--=20
2.34.1

