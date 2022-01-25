Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5697249B922
	for <lists+cgroups@lfdr.de>; Tue, 25 Jan 2022 17:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349966AbiAYQpn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jan 2022 11:45:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357448AbiAYQnp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jan 2022 11:43:45 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643129023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sjx/G4Nq5lUKRGClg/X/YwsLFNB9oFEPXMYuUSsWKQ=;
        b=0JFNHF6ecQ8E5BsuYnJOd0MZlDY4OF31VRX7u532pEtZ5A7tJl/6Uh63ghWgGBgZXWBofN
        Dh+dxbyk42OUYMrXerCc5OEbk6Lh1GAQMVjTvYLQA553WBUzHeqbLow9vPUGZ8Wq6ZPcHO
        Ru/NlDlbp7JSOAhGlKJMqfv74N680zM/KfPM7TdqZgEWWDhxzv7EnpQUDXzTx6E5417Iqj
        5qKzlJGDvIfABQPTQocMkBLgosfbCnThX8p6PGiz/uL72yOTjuB6p7WgMRhdlbdre3jKuh
        /c0ofLyiZQwgn0axBYbodx6JCxsAx57K9vMEtTpWNMtpZj7IwkjhJcSRBhStnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643129023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2sjx/G4Nq5lUKRGClg/X/YwsLFNB9oFEPXMYuUSsWKQ=;
        b=iGVHds1gJIhTOdIN/a0qQUnKoM7sL7rAB9+F7S952Eef5IXTeBllt6OA77Mpi1Q4V5Ctlw
        CIK2ibElmSKwUYBg==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] mm/memcg: Add a local_lock_t for IRQ and TASK object.
Date:   Tue, 25 Jan 2022 17:43:36 +0100
Message-Id: <20220125164337.2071854-4-bigeasy@linutronix.de>
In-Reply-To: <20220125164337.2071854-1-bigeasy@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
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
 mm/memcontrol.c | 174 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 114 insertions(+), 60 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3d1b7cdd83db0..2d8be88c00888 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -260,8 +260,10 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
=20
+struct memcg_stock_pcp;
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+				      unsigned int nr_pages,
+				      bool stock_lock_acquried);
=20
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -295,7 +297,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages =3D nr_bytes >> PAGE_SHIFT;
=20
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
=20
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -2024,26 +2026,40 @@ struct obj_stock {
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
+					  bool stock_lock_acquried);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
=20
 #else
-static inline void drain_obj_stock(struct obj_stock *stock)
+static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+						 bool stock_lock_acquried)
 {
+	return NULL;
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
@@ -2072,7 +2088,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (memcg =3D=3D stock->cached && stock->nr_pages >=3D nr_pages) {
@@ -2080,7 +2096,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 		ret =3D true;
 	}
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
=20
 	return ret;
 }
@@ -2108,38 +2124,43 @@ static void drain_stock(struct memcg_stock_pcp *sto=
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
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	struct memcg_stock_pcp *stock =3D this_cpu_ptr(&memcg_stock);
=20
-	local_irq_save(flags);
-
-	stock =3D this_cpu_ptr(&memcg_stock);
+	lockdep_assert_held(&stock->stock_lock);
 	if (stock->cached !=3D memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
@@ -2149,8 +2170,20 @@ static void refill_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
=20
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
=20
-	local_irq_restore(flags);
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
+			 bool stock_lock_acquried)
+{
+	unsigned long flags;
+
+	if (stock_lock_acquried) {
+		__refill_stock(memcg, nr_pages);
+		return;
+	}
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	__refill_stock(memcg, nr_pages);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
=20
 /*
@@ -2159,7 +2192,7 @@ static void refill_stock(struct mem_cgroup *memcg, un=
signed int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu, curcpu;
+	int cpu;
=20
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2170,7 +2203,7 @@ static void drain_all_stock(struct mem_cgroup *root_m=
emcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu =3D get_cpu();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock =3D &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2186,14 +2219,10 @@ static void drain_all_stock(struct mem_cgroup *root=
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
@@ -2594,7 +2623,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg,=
 gfp_t gfp_mask,
=20
 done_restock:
 	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
+		refill_stock(memcg, batch - nr_pages, false);
=20
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -2707,28 +2736,36 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg=
(struct obj_cgroup *objcg)
  * can only be accessed after disabling interrupt. User context code can
  * access interrupt object stock, but not vice versa.
  */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
+static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
+					      bool *stock_lock_acquried)
 {
 	struct memcg_stock_pcp *stock;
=20
+#ifndef CONFIG_PREEMPT_RT
 	if (likely(in_task())) {
 		*pflags =3D 0UL;
-		preempt_disable();
+		*stock_lock_acquried =3D false;
+		local_lock(&memcg_stock.task_obj_lock);
 		stock =3D this_cpu_ptr(&memcg_stock);
 		return &stock->task_obj;
 	}
-
-	local_irq_save(*pflags);
+#endif
+	*stock_lock_acquried =3D true;
+	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
 	stock =3D this_cpu_ptr(&memcg_stock);
 	return &stock->irq_obj;
 }
=20
-static inline void put_obj_stock(unsigned long flags)
+static inline void put_obj_stock(unsigned long flags,
+				 bool stock_lock_acquried)
 {
-	if (likely(in_task()))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
+#ifndef CONFIG_PREEMPT_RT
+	if (likely(!stock_lock_acquried)) {
+		local_unlock(&memcg_stock.task_obj_lock);
+		return;
+	}
+#endif
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
=20
 /*
@@ -2911,7 +2948,8 @@ static void memcg_free_cache_id(int id)
  * @nr_pages: number of pages to uncharge
  */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages)
+				      unsigned int nr_pages,
+				      bool stock_lock_acquried)
 {
 	struct mem_cgroup *memcg;
=20
@@ -2919,7 +2957,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgro=
up *objcg,
=20
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, stock_lock_acquried);
=20
 	css_put(&memcg->css);
 }
@@ -2993,7 +3031,7 @@ void __memcg_kmem_uncharge_page(struct page *page, in=
t order)
 		return;
=20
 	objcg =3D __folio_objcg(folio);
-	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 	folio->memcg_data =3D 0;
 	obj_cgroup_put(objcg);
 }
@@ -3001,17 +3039,21 @@ void __memcg_kmem_uncharge_page(struct page *page, =
int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
+	struct obj_cgroup *old =3D NULL;
+	struct obj_stock *stock;
 	int *bytes;
=20
+	stock =3D get_obj_stock(&flags, &stock_lock_acquried);
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
 	 * changes.
 	 */
 	if (stock->cached_objcg !=3D objcg) {
-		drain_obj_stock(stock);
+		old =3D drain_obj_stock(stock, stock_lock_acquried);
+
 		obj_cgroup_get(objcg);
 		stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3055,38 +3097,43 @@ void mod_objcg_state(struct obj_cgroup *objcg, stru=
ct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
=20
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
+	if (old)
+		obj_cgroup_put(old);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_by=
tes)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
+	struct obj_stock *stock;
 	bool ret =3D false;
=20
+	stock =3D get_obj_stock(&flags, &stock_lock_acquried);
 	if (objcg =3D=3D stock->cached_objcg && stock->nr_bytes >=3D nr_bytes) {
 		stock->nr_bytes -=3D nr_bytes;
 		ret =3D true;
 	}
=20
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
=20
 	return ret;
 }
=20
-static void drain_obj_stock(struct obj_stock *stock)
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  bool stock_lock_acquried)
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
+			obj_cgroup_uncharge_pages(old, nr_pages, stock_lock_acquried);
=20
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3121,8 +3168,8 @@ static void drain_obj_stock(struct obj_stock *stock)
 		stock->cached_pgdat =3D NULL;
 	}
=20
-	obj_cgroup_put(old);
 	stock->cached_objcg =3D NULL;
+	return old;
 }
=20
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3130,11 +3177,13 @@ static bool obj_stock_flush_required(struct memcg_s=
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
@@ -3147,12 +3196,15 @@ static bool obj_stock_flush_required(struct memcg_s=
tock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_byt=
es,
 			     bool allow_uncharge)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
+	struct obj_stock *stock;
 	unsigned int nr_pages =3D 0;
+	struct obj_cgroup *old =3D NULL;
=20
+	stock =3D get_obj_stock(&flags, &stock_lock_acquried);
 	if (stock->cached_objcg !=3D objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		old =3D drain_obj_stock(stock, stock_lock_acquried);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg =3D objcg;
 		stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
@@ -3166,10 +3218,12 @@ static void refill_obj_stock(struct obj_cgroup *obj=
cg, unsigned int nr_bytes,
 		stock->nr_bytes &=3D (PAGE_SIZE - 1);
 	}
=20
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
+	if (old)
+		obj_cgroup_put(old);
=20
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 }
=20
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -7062,7 +7116,7 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *mem=
cg, unsigned int nr_pages)
=20
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
=20
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, false);
 }
=20
 static int __init cgroup_memory(char *s)
--=20
2.34.1

