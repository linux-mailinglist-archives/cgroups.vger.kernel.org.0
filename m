Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA74C5806
	for <lists+cgroups@lfdr.de>; Sat, 26 Feb 2022 21:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiBZUmb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 26 Feb 2022 15:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiBZUma (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 26 Feb 2022 15:42:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C9324910A
        for <cgroups@vger.kernel.org>; Sat, 26 Feb 2022 12:41:54 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645908111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YS66z6alTYMGsVDzNzJq2eTXDHgOItRSpB1pj7Q+ytc=;
        b=0zG06eHrX29uzQQn4QVAihEnqnMQ3hNjHFNicdDLIjmk2NXJRzQEc5fBCHQIxigdN4OKQd
        Q9CrG73vVSxjkH8va6vh9gae9OgBBGX+g+Yzb0ygjI0x7ACjJKMGPiCi95Hx8W2X9KYicJ
        x8B6U9FQ6DknwMpAuIkvNhAw1hRoEgTV/61veXYTjW9SVPsVJkPIy/+duOSXXsnI4WShJ+
        Yj6INtsw3aRa3ciazQtzrLZ0HmrAW+5wQk0L7hUWk4ePss6GGGkC2m0g/u/hUC/B31lmW0
        B1jL2YcMOu64JMEjkMPBMb1GLKRAFoI0FyOjdAekhebMoFCZUwGx/0fQ/hGygw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645908111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YS66z6alTYMGsVDzNzJq2eTXDHgOItRSpB1pj7Q+ytc=;
        b=jnxx0J31h+fMUtAah4t0ydb8Slbj8/niBtT+XegK2aad0o0hvaPEKJgwmTYpcWxmuJ/t9t
        k/9D2qIx2qSIEcCw==
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
Subject: [PATCH v5 5/6] mm/memcg: Protect memcg_stock with a local_lock_t
Date:   Sat, 26 Feb 2022 21:41:43 +0100
Message-Id: <20220226204144.1008339-6-bigeasy@linutronix.de>
In-Reply-To: <20220226204144.1008339-1-bigeasy@linutronix.de>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
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

- Let drain_obj_stock() return the old struct obj_cgroup which is passed
  to obj_cgroup_put() outside of the locked section.

- Provide obj_cgroup_uncharge_pages_locked() which uses the locked
  version of refill_stock() to avoid recursive locking in
  drain_obj_stock().

Link: https://lkml.kernel.org/r/20220209014709.GA26885@xsang-OptiPlex-9020
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 59 +++++++++++++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 21 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 4d049b4691afd..6439b0089d392 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2135,6 +2135,7 @@ void unlock_page_memcg(struct page *page)
 }
=20
 struct memcg_stock_pcp {
+	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
=20
@@ -2150,18 +2151,21 @@ struct memcg_stock_pcp {
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
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages);
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
@@ -2193,7 +2197,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (memcg =3D=3D stock->cached && stock->nr_pages >=3D nr_pages) {
@@ -2201,7 +2205,7 @@ static bool consume_stock(struct mem_cgroup *memcg, u=
nsigned int nr_pages)
 		ret =3D true;
 	}
=20
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
=20
 	return ret;
 }
@@ -2230,6 +2234,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 static void drain_local_stock(struct work_struct *dummy)
 {
 	struct memcg_stock_pcp *stock;
+	struct obj_cgroup *old =3D NULL;
 	unsigned long flags;
=20
 	/*
@@ -2237,14 +2242,16 @@ static void drain_local_stock(struct work_struct *d=
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
@@ -2271,9 +2278,9 @@ static void refill_stock(struct mem_cgroup *memcg, un=
signed int nr_pages)
 {
 	unsigned long flags;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 	__refill_stock(memcg, nr_pages);
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 }
=20
 /*
@@ -3100,10 +3107,11 @@ void mod_objcg_state(struct obj_cgroup *objcg, stru=
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
@@ -3112,7 +3120,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct=
 pglist_data *pgdat,
 	 * changes.
 	 */
 	if (stock->cached_objcg !=3D objcg) {
-		drain_obj_stock(stock);
+		old =3D drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
 		stock->nr_bytes =3D atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3156,7 +3164,9 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct=
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
@@ -3165,7 +3175,7 @@ static bool consume_obj_stock(struct obj_cgroup *objc=
g, unsigned int nr_bytes)
 	unsigned long flags;
 	bool ret =3D false;
=20
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
 	if (objcg =3D=3D stock->cached_objcg && stock->nr_bytes >=3D nr_bytes) {
@@ -3173,17 +3183,17 @@ static bool consume_obj_stock(struct obj_cgroup *ob=
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
@@ -3233,8 +3243,12 @@ static void drain_obj_stock(struct memcg_stock_pcp *=
stock)
 		stock->cached_pgdat =3D NULL;
 	}
=20
-	obj_cgroup_put(old);
 	stock->cached_objcg =3D NULL;
+	/*
+	 * The `old' objects needs to be released by the caller via
+	 * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
+	 */
+	return old;
 }
=20
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3255,14 +3269,15 @@ static void refill_obj_stock(struct obj_cgroup *obj=
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
@@ -3276,7 +3291,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg=
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
2.35.1

