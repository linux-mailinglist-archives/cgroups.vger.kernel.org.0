Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1464B30C2
	for <lists+cgroups@lfdr.de>; Fri, 11 Feb 2022 23:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354162AbiBKWgC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Feb 2022 17:36:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354161AbiBKWfz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Feb 2022 17:35:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A0ADDE
        for <cgroups@vger.kernel.org>; Fri, 11 Feb 2022 14:35:48 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644618946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMCWQW0SDu0uqiAgt2kpy4EF9GolTGKIHR3DGKCYBl8=;
        b=0/i8b8lyxSF1DUzKGBeh1uvqMA3YV2yu+up7hfMZU7O2rHwDLS8joxayjzbQKEi4LW0IWO
        +O6YbA/DC2XvBPS0uQVRFUZwBHpxoRhxL9P7jpuRHE7Gh6IQQgxH6zZmSC++R4boR+bMF9
        ZVqU2j7aYsPCqvjvuMYNWPme4M5BJVdMQ5RD91990UomPhKt30MeYYJbv04PXeyajAYE3Y
        k1P9IYt0YJYm4Q2CH6DGoZLNBs0jZGKBpsgp2jttr23OG62K04Wnj6BBOO2VLQfSKprr4K
        Agj2/+tpX+LxrjEEm8O8GO6aYekeshzjMowvRn8Pnbe3aA4Wl7nggAnpjoihdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644618946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMCWQW0SDu0uqiAgt2kpy4EF9GolTGKIHR3DGKCYBl8=;
        b=X9qPxQ+wTkfpcFEPhRYrsfXwIaBcKOYZalFtoYEme56LTg/h5yRKKgr/rwlzMUZ/XscxH6
        dRkHI9xW242A97Dw==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 4/4] mm/memcg: Protect memcg_stock with a local_lock_t
Date:   Fri, 11 Feb 2022 23:35:37 +0100
Message-Id: <20220211223537.2175879-5-bigeasy@linutronix.de>
In-Reply-To: <20220211223537.2175879-1-bigeasy@linutronix.de>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The members of the per-CPU structure memcg_stock_pcp are protected by
disabling interrupts. This is not working on PREEMPT_RT because it
creates atomic context in which actions are performed which require
preemptible context. One example is obj_cgroup_release().

The IRQ-disable sections can be replaced with local_lock_t which
preserves the explicit disabling of interrupts while keeps the code
preemptible on PREEMPT_RT.

drain_all_stock() disables preemption via get_cpu() and then invokes
drain_local_stock() if it is the local CPU to avoid scheduling a worker (wh=
ich
invokes the same function). Disabling preemption here is problematic due to=
 the
sleeping locks in drain_local_stock().
This can be avoided by always scheduling a worker, even for the local
CPU. Using cpus_read_lock() to stabilize the cpu_online_mask is not
needed since the worker operates always on the CPU-local data structure.
Should a CPU go offline then a two worker would perform the work and no
harm is done. Using cpus_read_lock() leads to a possible deadlock.

drain_obj_stock() drops a reference on obj_cgroup which leads to an invocat=
ion
of obj_cgroup_release() if it is the last object. This in turn leads to
recursive locking of the local_lock_t. To avoid this, obj_cgroup_release() =
is
invoked outside of the locked section.

obj_cgroup_uncharge_pages() can be invoked with the local_lock_t acquired a=
nd
without it. This will lead later to a recursion in refill_stock(). To
avoid the locking recursion provide obj_cgroup_uncharge_pages_locked()
which uses the locked version of refill_stock().

- Replace disabling interrupts for memcg_stock with a local_lock_t.

- Schedule a worker even for the local CPU instead of invoking it
  directly (in drain_all_stock()).

- Let drain_obj_stock() return the old struct obj_cgroup which is passed
  to obj_cgroup_put() outside of the locked section.

- Provide obj_cgroup_uncharge_pages_locked() which uses the locked
  version of refill_stock() to avoid recursive locking in
  drain_obj_stock().

Link: https://lkml.kernel.org/r/20220209014709.GA26885@xsang-OptiPlex-9020
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 101 ++++++++++++++++++++++++++++++------------------
 1 file changed, 63 insertions(+), 38 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 466466f285cea..f7120a92cf46e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2097,6 +2097,7 @@ void unlock_page_memcg(struct page *page)
 }
=20
 struct memcg_stock_pcp {
+	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
=20
@@ -2112,17 +2113,20 @@ struct memcg_stock_pcp {
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
+static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) =3D {
+	.stock_lock =3D INIT_LOCAL_LOCK(stock_lock),
+};
 static DEFINE_MUTEX(percpu_charge_mutex);
=20
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct memcg_stock_pcp *stock);
+static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
=20
 #else
-static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
+static inline struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *s=
tock)
 {
+	return NULL;
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
@@ -2151,7 +2155,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (memcg =3D=3D stock->cached && stock->nr_pages >=3D nr_pages) {
@@ -2159,7 +2163,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 		ret =3D true;
 	}
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
=20
 	return ret;
 }
@@ -2188,6 +2192,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 static void drain_local_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old =3D NULL;
 	unsigned long flags;
=20
 	/*
@@ -2195,26 +2200,25 @@ static void drain_local_stock(struct work_struct *d=
ummy)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(stock);
+	old =3D drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
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
 	struct memcg_stock_pcp *stock;
-	unsigned long flags;
-
-	local_irq_save(flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (stock->cached !=3D memcg) { /* reset if necessary */
@@ -2226,8 +2230,15 @@ static void refill_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
=20
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
=20
-	local_irq_restore(flags);
+static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+{
+	unsigned long flags;
+
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
+	__refill_stock(memcg, nr_pages);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
=20
 /*
@@ -2236,7 +2247,7 @@ static void refill_stock(struct mem_cgroup *memcg, un=
signed int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu, curcpu;
+	int cpu;
=20
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2247,7 +2258,6 @@ static void drain_all_stock(struct mem_cgroup *root_m=
emcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu =3D get_cpu();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock =3D &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2263,14 +2273,9 @@ static void drain_all_stock(struct mem_cgroup *root_=
memcg)
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
 	mutex_unlock(&percpu_charge_mutex);
 }
=20
@@ -2948,12 +2953,13 @@ static void memcg_free_cache_id(int id)
 }
=20
 /*
- * obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a obj=
cg
+ * __obj_cgroup_uncharge_pages: uncharge a number of kernel pages from a o=
bjcg
  * @objcg: object cgroup to uncharge
  * @nr_pages: number of pages to uncharge
  */
-static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages)
+static void __obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
+					unsigned int nr_pages,
+					void (*refill)(struct mem_cgroup *memcg, unsigned int nr_pages))
 {
 	struct mem_cgroup *memcg;
=20
@@ -2961,11 +2967,24 @@ static void obj_cgroup_uncharge_pages(struct obj_cg=
roup *objcg,
=20
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages);
+	refill(memcg, nr_pages);
=20
 	css_put(&memcg->css);
 }
=20
+static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
+				      unsigned int nr_pages)
+{
+	__obj_cgroup_uncharge_pages(objcg, nr_pages, refill_stock);
+}
+
+static void obj_cgroup_uncharge_pages_locked(struct obj_cgroup *objcg,
+					     unsigned int nr_pages)
+{
+	__obj_cgroup_uncharge_pages(objcg, nr_pages, __refill_stock);
+}
+
+
 /*
  * obj_cgroup_charge_pages: charge a number of kernel pages to a objcg
  * @objcg: object cgroup to charge
@@ -3044,10 +3063,11 @@ void mod_objcg_state(struct obj_cgroup *objcg, stru=
ct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old =3D NULL;
 	unsigned long flags;
 	int *bytes;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	stock =3D this_cpu_ptr(&memcg_stock);
=20
 	/*
@@ -3056,7 +3076,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct=
 pglist_data *pgdat,
 	 * changes.
 	 */
 	if (stock->cached_objcg !=3D objcg) {
-		drain_obj_stock(stock);
+		old =3D drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3100,7 +3120,9 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct=
 pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	if (old)
+		obj_cgroup_put(old);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_by=
tes)
@@ -3109,7 +3131,7 @@ static bool consume_obj_stock(struct obj_cgroup *objc=
g, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret =3D false;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (objcg =3D=3D stock->cached_objcg && stock->nr_bytes >=3D nr_bytes) {
@@ -3117,24 +3139,24 @@ static bool consume_obj_stock(struct obj_cgroup *ob=
jcg, unsigned int nr_bytes)
 		ret =3D true;
 	}
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
=20
 	return ret;
 }
=20
-static void drain_obj_stock(struct memcg_stock_pcp *stock)
+static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
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
+			obj_cgroup_uncharge_pages_locked(old, nr_pages);
=20
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3169,8 +3191,8 @@ static void drain_obj_stock(struct memcg_stock_pcp *s=
tock)
 		stock->cached_pgdat =3D NULL;
 	}
=20
-	obj_cgroup_put(old);
 	stock->cached_objcg =3D NULL;
+	return old;
 }
=20
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3191,14 +3213,15 @@ static void refill_obj_stock(struct obj_cgroup *obj=
cg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old =3D NULL;
 	unsigned long flags;
 	unsigned int nr_pages =3D 0;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (stock->cached_objcg !=3D objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		old =3D drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg =3D objcg;
 		stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
@@ -3212,7 +3235,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg=
, unsigned int nr_bytes,
 		stock->nr_bytes &=3D (PAGE_SIZE - 1);
 	}
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
+	if (old)
+		obj_cgroup_put(old);
=20
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
--=20
2.34.1

