Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AE4BEB0E
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiBUS1q (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 13:27:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiBUS0d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 13:26:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91450C5
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 10:26:09 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645467967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RN3eik2uo1EctM+OaYMX4dV1IIZTzcai62Ou4T2C8MI=;
        b=1vApCCuCFLCVnwUREIQHWcdksagPbDPMp5qobiI+g78yRSK83zbAKFaZPB2kbA3ROMDvQg
        3ayC0PiusFfeSPA3rFJ0PaG/6KaMfKypKk+SZ6pkY7nuUDuRSj0YPPnDmbXnYl96ukfz7U
        CW+fQbwR/V5BVgOTGLrkwfmQ7bdYRx3D30W/HweaKkB22LQ4Ph/DYXHr3Fjo3PiqpzFIYE
        Sy5B16Ck3kE67xnZFtumY6zbJwiy1q9sho8fmj5tTjwWbVDnfnmP3aNsdejL08zYXcjSEU
        xLhEqlvuGofYYkBVvXoWUxpFvnimSq5AsCWRXBeGJLmHxEcsIf/yEMJisGHM6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645467967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RN3eik2uo1EctM+OaYMX4dV1IIZTzcai62Ou4T2C8MI=;
        b=O7C8ALSP31GhyqypNbjjuW452ZnkEaQusBz9/ltL5xauWYCKF5Q1vRkwEGn5LuTFoRhIMQ
        ony9SZEddg/3VUAA==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v4 1/6] mm/memcg: Revert ("mm/memcg: optimize user context object stock access")
Date:   Mon, 21 Feb 2022 19:25:35 +0100
Message-Id: <20220221182540.380526-2-bigeasy@linutronix.de>
In-Reply-To: <20220221182540.380526-1-bigeasy@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
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

From: Michal Hocko <mhocko@suse.com>

The optimisation is based on a micro benchmark where local_irq_save() is
more expensive than a preempt_disable(). There is no evidence that it is
visible in a real-world workload and there are CPUs where the opposite is
true (local_irq_save() is cheaper than preempt_disable()).

Based on micro benchmarks, the optimisation makes sense on PREEMPT_NONE
where preempt_disable() is optimized away. There is no improvement with
PREEMPT_DYNAMIC since the preemption counter is always available.

The optimization makes also the PREEMPT_RT integration more complicated
since most of the assumption are not true on PREEMPT_RT.

Revert the optimisation since it complicates the PREEMPT_RT integration
and the improvement is hardly visible.

[ bigeasy: Patch body around Michal's diff ]

Link: https://lore.kernel.org/all/YgOGkXXCrD%2F1k+p4@dhcp22.suse.cz
Link: https://lkml.kernel.org/r/YdX+INO9gQje6d0S@linutronix.de
Signed-off-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Roman Gushchin <guro@fb.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 94 ++++++++++++++-----------------------------------
 1 file changed, 27 insertions(+), 67 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3c4816147273a..8ab2dc75e70ec 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2078,23 +2078,17 @@ void unlock_page_memcg(struct page *page)
 	folio_memcg_unlock(page_folio(page));
 }
=20
-struct obj_stock {
+struct memcg_stock_pcp {
+	struct mem_cgroup *cached; /* this never be root cgroup */
+	unsigned int nr_pages;
+
 #ifdef CONFIG_MEMCG_KMEM
 	struct obj_cgroup *cached_objcg;
 	struct pglist_data *cached_pgdat;
 	unsigned int nr_bytes;
 	int nr_slab_reclaimable_b;
 	int nr_slab_unreclaimable_b;
-#else
-	int dummy[0];
 #endif
-};
-
-struct memcg_stock_pcp {
-	struct mem_cgroup *cached; /* this never be root cgroup */
-	unsigned int nr_pages;
-	struct obj_stock task_obj;
-	struct obj_stock irq_obj;
=20
 	struct work_struct work;
 	unsigned long flags;
@@ -2104,13 +2098,13 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg=
_stock);
 static DEFINE_MUTEX(percpu_charge_mutex);
=20
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct obj_stock *stock);
+static void drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages);
=20
 #else
-static inline void drain_obj_stock(struct obj_stock *stock)
+static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -2190,9 +2184,7 @@ static void drain_local_stock(struct work_struct *dum=
my)
 	local_irq_save(flags);
=20
 	stock =3D this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(&stock->irq_obj);
-	if (in_task())
-		drain_obj_stock(&stock->task_obj);
+	drain_obj_stock(stock);
 	drain_stock(stock);
 	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
=20
@@ -2767,41 +2759,6 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(=
struct obj_cgroup *objcg)
  */
 #define OBJCGS_CLEAR_MASK	(__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
=20
-/*
- * Most kmem_cache_alloc() calls are from user context. The irq disable/en=
able
- * sequence used in this case to access content from object stock is slow.
- * To optimize for user context access, there are now two object stocks for
- * task context and interrupt context access respectively.
- *
- * The task context object stock can be accessed by disabling preemption o=
nly
- * which is cheap in non-preempt kernel. The interrupt context object stock
- * can only be accessed after disabling interrupt. User context code can
- * access interrupt object stock, but not vice versa.
- */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
-{
-	struct memcg_stock_pcp *stock;
-
-	if (likely(in_task())) {
-		*pflags =3D 0UL;
-		preempt_disable();
-		stock =3D this_cpu_ptr(&memcg_stock);
-		return &stock->task_obj;
-	}
-
-	local_irq_save(*pflags);
-	stock =3D this_cpu_ptr(&memcg_stock);
-	return &stock->irq_obj;
-}
-
-static inline void put_obj_stock(unsigned long flags)
-{
-	if (likely(in_task()))
-		preempt_enable();
-	else
-		local_irq_restore(flags);
-}
-
 /*
  * mod_objcg_mlstate() may be called with irq enabled, so
  * mod_memcg_lruvec_state() should be used.
@@ -3082,10 +3039,13 @@ void __memcg_kmem_uncharge_page(struct page *page, =
int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
+	struct memcg_stock_pcp *stock;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
 	int *bytes;
=20
+	local_irq_save(flags);
+	stock =3D this_cpu_ptr(&memcg_stock);
+
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
@@ -3136,26 +3096,29 @@ void mod_objcg_state(struct obj_cgroup *objcg, stru=
ct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
=20
-	put_obj_stock(flags);
+	local_irq_restore(flags);
 }
=20
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_by=
tes)
 {
+	struct memcg_stock_pcp *stock;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
 	bool ret =3D false;
=20
+	local_irq_save(flags);
+
+	stock =3D this_cpu_ptr(&memcg_stock);
 	if (objcg =3D=3D stock->cached_objcg && stock->nr_bytes >=3D nr_bytes) {
 		stock->nr_bytes -=3D nr_bytes;
 		ret =3D true;
 	}
=20
-	put_obj_stock(flags);
+	local_irq_restore(flags);
=20
 	return ret;
 }
=20
-static void drain_obj_stock(struct obj_stock *stock)
+static void drain_obj_stock(struct memcg_stock_pcp *stock)
 {
 	struct obj_cgroup *old =3D stock->cached_objcg;
=20
@@ -3211,13 +3174,8 @@ static bool obj_stock_flush_required(struct memcg_st=
ock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
=20
-	if (in_task() && stock->task_obj.cached_objcg) {
-		memcg =3D obj_cgroup_memcg(stock->task_obj.cached_objcg);
-		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
-			return true;
-	}
-	if (stock->irq_obj.cached_objcg) {
-		memcg =3D obj_cgroup_memcg(stock->irq_obj.cached_objcg);
+	if (stock->cached_objcg) {
+		memcg =3D obj_cgroup_memcg(stock->cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
@@ -3228,10 +3186,13 @@ static bool obj_stock_flush_required(struct memcg_s=
tock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_byt=
es,
 			     bool allow_uncharge)
 {
+	struct memcg_stock_pcp *stock;
 	unsigned long flags;
-	struct obj_stock *stock =3D get_obj_stock(&flags);
 	unsigned int nr_pages =3D 0;
=20
+	local_irq_save(flags);
+
+	stock =3D this_cpu_ptr(&memcg_stock);
 	if (stock->cached_objcg !=3D objcg) { /* reset if necessary */
 		drain_obj_stock(stock);
 		obj_cgroup_get(objcg);
@@ -3247,7 +3208,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg=
, unsigned int nr_bytes,
 		stock->nr_bytes &=3D (PAGE_SIZE - 1);
 	}
=20
-	put_obj_stock(flags);
+	local_irq_restore(flags);
=20
 	if (nr_pages)
 		obj_cgroup_uncharge_pages(objcg, nr_pages);
@@ -6812,7 +6773,6 @@ static void uncharge_folio(struct folio *folio, struc=
t uncharge_gather *ug)
 	long nr_pages;
 	struct mem_cgroup *memcg;
 	struct obj_cgroup *objcg;
-	bool use_objcg =3D folio_memcg_kmem(folio);
=20
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
=20
@@ -6821,7 +6781,7 @@ static void uncharge_folio(struct folio *folio, struc=
t uncharge_gather *ug)
 	 * folio memcg or objcg at this point, we have fully
 	 * exclusive access to the folio.
 	 */
-	if (use_objcg) {
+	if (folio_memcg_kmem(folio)) {
 		objcg =3D __folio_objcg(folio);
 		/*
 		 * This get matches the put at the end of the function and
@@ -6849,7 +6809,7 @@ static void uncharge_folio(struct folio *folio, struc=
t uncharge_gather *ug)
=20
 	nr_pages =3D folio_nr_pages(folio);
=20
-	if (use_objcg) {
+	if (folio_memcg_kmem(folio)) {
 		ug->nr_memory +=3D nr_pages;
 		ug->nr_kmem +=3D nr_pages;
=20
--=20
2.35.1

