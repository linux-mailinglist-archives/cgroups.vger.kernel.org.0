Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B904834CF
	for <lists+cgroups@lfdr.de>; Mon,  3 Jan 2022 17:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233842AbiACQez (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jan 2022 11:34:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiACQez (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jan 2022 11:34:55 -0500
Date:   Mon, 3 Jan 2022 17:34:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641227693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJJqeqmcHfmkwvNfUihtleIzaR0PM11KL9zKK7nkiF4=;
        b=4e1S9vQMj441ofAYu+Fv/HsfDnKTm7hRM/fG897iNbXZI5hKS5wkAsqS0dJkF/cZI77pKa
        WwDRV2ItXKWsRs0lebkuD/+J74NM5pXFD0sqcLXHweTRPtL0gxnarmqjV1rjD2GBiQgfl7
        LNFLS7D3JByYUJPr9x8jqq/luQDnhEcFH2O/Q8pYC6l67ReXy6U4y7u3V6/7CHSZAr1Q1p
        UqxNOXQtKOqHEpxLmqeA00MV5dFt1LX77FOnCnZuvMQ8v1lJzsp7ANZqTcPSfGpi7OeSnT
        /RwE6vVx+tRsEpqj2UCahvPnxw6qZbffROEH90UprFb1KE8ywXYiIsxTcfqqIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641227693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WJJqeqmcHfmkwvNfUihtleIzaR0PM11KL9zKK7nkiF4=;
        b=FxgML4tDyGRSDW6Q3oiPKYGCk6pvGFM+Zmg8lMVO+VwW08t5psnfXzQ4Lk9CViOdhnNzbn
        NNSvMlYJ9qe4MpBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Waiman Long <longman@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 2/3] mm/memcg: Add a local_lock_t for IRQ and TASK
 object.
Message-ID: <YdMlrFPvb94rzv8Z@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-3-bigeasy@linutronix.de>
 <4fe30c89-df34-bbdb-a9a1-5519e0363cc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4fe30c89-df34-bbdb-a9a1-5519e0363cc5@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2021-12-23 16:38:35 [-0500], Waiman Long wrote:
> AFAICS, stock_pcp is set to indicate that the stock_lock has been acquired.
> Since stock_pcp, if set, should be the same as this_cpu_ptr(&memcg_stock),
> it is a bit confusing to pass it to a function that also does a percpu
> access to memcg_stock. Why don't you just pass a boolean, say, stock_locked
> to indicate this instead. It will be more clear and less confusing.

Something like this then?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d2687d5ed544b..05fdc4801da6b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -261,8 +261,10 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
+struct memcg_stock_pcp;
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages);
+				      unsigned int nr_pages,
+				      bool stock_lock_acquried);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
 {
@@ -296,7 +298,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
 	nr_pages = nr_bytes >> PAGE_SHIFT;
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 
 	spin_lock_irqsave(&css_set_lock, flags);
 	list_del(&objcg->list);
@@ -2120,26 +2122,40 @@ struct obj_stock {
 };
 
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
 
 	struct work_struct work;
 	unsigned long flags;
 #define FLUSHING_CACHED_CHARGE	0
 };
-static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
+static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
+	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
+#ifndef CONFIG_PREEMPT_RT
+	.task_obj_lock = INIT_LOCAL_LOCK(task_obj_lock),
+#endif
+};
 static DEFINE_MUTEX(percpu_charge_mutex);
 
 #ifdef CONFIG_MEMCG_KMEM
-static void drain_obj_stock(struct obj_stock *stock);
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  bool stock_lock_acquried);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
 #else
-static inline void drain_obj_stock(struct obj_stock *stock)
+static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+						 bool stock_lock_acquried)
 {
+	return NULL;
 }
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg)
@@ -2168,7 +2184,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&memcg_stock.stock_lock, flags);
 
 	stock = this_cpu_ptr(&memcg_stock);
 	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
@@ -2176,7 +2192,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 		ret = true;
 	}
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
 
 	return ret;
 }
@@ -2204,38 +2220,43 @@ static void drain_stock(struct memcg_stock_pcp *stock)
 
 static void drain_local_stock(struct work_struct *dummy)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	struct memcg_stock_pcp *stock_pcp;
+	struct obj_cgroup *old;
 
 	/*
 	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-	local_irq_save(flags);
+#ifndef CONFIG_PREEMPT_RT
+	local_lock(&memcg_stock.task_obj_lock);
+	old = drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
+	local_unlock(&memcg_stock.task_obj_lock);
+	if (old)
+		obj_cgroup_put(old);
+#endif
 
-	stock = this_cpu_ptr(&memcg_stock);
-	drain_obj_stock(&stock->irq_obj);
-	if (in_task())
-		drain_obj_stock(&stock->task_obj);
-	drain_stock(stock);
-	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
+	local_lock_irq(&memcg_stock.stock_lock);
+	stock_pcp = this_cpu_ptr(&memcg_stock);
+	old = drain_obj_stock(&stock_pcp->irq_obj, stock_pcp);
 
-	local_irq_restore(flags);
+	drain_stock(stock_pcp);
+	clear_bit(FLUSHING_CACHED_CHARGE, &stock_pcp->flags);
+
+	local_unlock_irq(&memcg_stock.stock_lock);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 /*
  * Cache charges(val) to local per_cpu area.
  * This will be consumed by consume_stock() function, later.
  */
-static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
+static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
-	struct memcg_stock_pcp *stock;
-	unsigned long flags;
+	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
 
-	local_irq_save(flags);
-
-	stock = this_cpu_ptr(&memcg_stock);
+	lockdep_assert_held(&stock->stock_lock);
 	if (stock->cached != memcg) { /* reset if necessary */
 		drain_stock(stock);
 		css_get(&memcg->css);
@@ -2245,8 +2266,20 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
 		drain_stock(stock);
+}
 
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
 
 /*
@@ -2255,7 +2288,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
  */
 static void drain_all_stock(struct mem_cgroup *root_memcg)
 {
-	int cpu, curcpu;
+	int cpu;
 
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
@@ -2266,7 +2299,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 	 * as well as workers from this path always operate on the local
 	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
 	 */
-	curcpu = get_cpu();
+	cpus_read_lock();
 	for_each_online_cpu(cpu) {
 		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
 		struct mem_cgroup *memcg;
@@ -2282,14 +2315,10 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
 		rcu_read_unlock();
 
 		if (flush &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
-			if (cpu == curcpu)
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
 
@@ -2690,7 +2719,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 done_restock:
 	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
+		refill_stock(memcg, batch - nr_pages, false);
 
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
@@ -2803,28 +2832,36 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
  * can only be accessed after disabling interrupt. User context code can
  * access interrupt object stock, but not vice versa.
  */
-static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
+static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
+					      bool *stock_lock_acquried)
 {
 	struct memcg_stock_pcp *stock;
 
+#ifndef CONFIG_PREEMPT_RT
 	if (likely(in_task())) {
 		*pflags = 0UL;
-		preempt_disable();
+		*stock_lock_acquried = false;
+		local_lock(&memcg_stock.task_obj_lock);
 		stock = this_cpu_ptr(&memcg_stock);
 		return &stock->task_obj;
 	}
-
-	local_irq_save(*pflags);
+#endif
+	*stock_lock_acquried = true;
+	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
 	stock = this_cpu_ptr(&memcg_stock);
 	return &stock->irq_obj;
 }
 
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
 
 /*
@@ -3002,7 +3039,8 @@ static void memcg_free_cache_id(int id)
  * @nr_pages: number of pages to uncharge
  */
 static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
-				      unsigned int nr_pages)
+				      unsigned int nr_pages,
+				      bool stock_lock_acquried)
 {
 	struct mem_cgroup *memcg;
 
@@ -3010,7 +3048,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		page_counter_uncharge(&memcg->kmem, nr_pages);
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, stock_lock_acquried);
 
 	css_put(&memcg->css);
 }
@@ -3084,7 +3122,7 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 		return;
 
 	objcg = __folio_objcg(folio);
-	obj_cgroup_uncharge_pages(objcg, nr_pages);
+	obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 	folio->memcg_data = 0;
 	obj_cgroup_put(objcg);
 }
@@ -3092,17 +3130,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
 void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 		     enum node_stat_item idx, int nr)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_cgroup *old = NULL;
+	struct obj_stock *stock;
 	int *bytes;
 
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	/*
 	 * Save vmstat data in stock and skip vmstat array update unless
 	 * accumulating over a page of vmstat data or when pgdat or idx
 	 * changes.
 	 */
 	if (stock->cached_objcg != objcg) {
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock, stock_lock_acquried);
+
 		obj_cgroup_get(objcg);
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
 				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
@@ -3146,38 +3188,43 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
 	if (nr)
 		mod_objcg_mlstate(objcg, pgdat, idx, nr);
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
+	if (old)
+		obj_cgroup_put(old);
 }
 
 static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_stock *stock;
 	bool ret = false;
 
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
 		stock->nr_bytes -= nr_bytes;
 		ret = true;
 	}
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
 
 	return ret;
 }
 
-static void drain_obj_stock(struct obj_stock *stock)
+static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
+					  bool stock_lock_acquried)
 {
 	struct obj_cgroup *old = stock->cached_objcg;
 
 	if (!old)
-		return;
+		return NULL;
 
 	if (stock->nr_bytes) {
 		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
 		unsigned int nr_bytes = stock->nr_bytes & (PAGE_SIZE - 1);
 
 		if (nr_pages)
-			obj_cgroup_uncharge_pages(old, nr_pages);
+			obj_cgroup_uncharge_pages(old, nr_pages, stock_lock_acquried);
 
 		/*
 		 * The leftover is flushed to the centralized per-memcg value.
@@ -3212,8 +3259,8 @@ static void drain_obj_stock(struct obj_stock *stock)
 		stock->cached_pgdat = NULL;
 	}
 
-	obj_cgroup_put(old);
 	stock->cached_objcg = NULL;
+	return old;
 }
 
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
@@ -3221,11 +3268,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 {
 	struct mem_cgroup *memcg;
 
+#ifndef CONFIG_PREEMPT_RT
 	if (in_task() && stock->task_obj.cached_objcg) {
 		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
 			return true;
 	}
+#endif
 	if (stock->irq_obj.cached_objcg) {
 		memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
@@ -3238,12 +3287,15 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 			     bool allow_uncharge)
 {
+	bool stock_lock_acquried;
 	unsigned long flags;
-	struct obj_stock *stock = get_obj_stock(&flags);
+	struct obj_stock *stock;
 	unsigned int nr_pages = 0;
+	struct obj_cgroup *old = NULL;
 
+	stock = get_obj_stock(&flags, &stock_lock_acquried);
 	if (stock->cached_objcg != objcg) { /* reset if necessary */
-		drain_obj_stock(stock);
+		old = drain_obj_stock(stock, stock_lock_acquried);
 		obj_cgroup_get(objcg);
 		stock->cached_objcg = objcg;
 		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
@@ -3257,10 +3309,12 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
 		stock->nr_bytes &= (PAGE_SIZE - 1);
 	}
 
-	put_obj_stock(flags);
+	put_obj_stock(flags, stock_lock_acquried);
+	if (old)
+		obj_cgroup_put(old);
 
 	if (nr_pages)
-		obj_cgroup_uncharge_pages(objcg, nr_pages);
+		obj_cgroup_uncharge_pages(objcg, nr_pages, false);
 }
 
 int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
@@ -7061,7 +7115,7 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	refill_stock(memcg, nr_pages, false);
 }
 
 static int __init cgroup_memory(char *s)
-- 
2.34.1

