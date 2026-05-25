Return-Path: <cgroups+bounces-16256-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFU9MKOdFGqpOwcAu9opvQ
	(envelope-from <cgroups+bounces-16256-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:06:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4295CDEA8
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 21:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98BA33025157
	for <lists+cgroups@lfdr.de>; Mon, 25 May 2026 19:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B5E37F019;
	Mon, 25 May 2026 19:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esVFmqup"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAD73939AE
	for <cgroups@vger.kernel.org>; Mon, 25 May 2026 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779735909; cv=none; b=OvXdyNXk2FJo/heHe/zEKYtZpkVKhrXmaNprqdVmK+jNhDnlNS0wDgz/r++PiZyLpfYI2o6xtTqfPOuK7A1JmioGqjl5NXJ8TjsyA9MWNr+1vhxamlKAx2dnQkSil1pbCmEAMblarmJjw30Ahos/kC+bglBrTKp9Y6saEDR6Dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779735909; c=relaxed/simple;
	bh=MThEOTa6itexIrgtSFecsTGMxxH6TnoRzC6AGdLiF28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fym9OJW7JQT/WajC8uaT7LPpzwmR78cpTCjFVjFAQVWfeIfILkCNs+WUt5mWW4ef6bqDJElEowgOqL8Z/wp4WxkvuNvyNThBOv+6Qfj0TNYtt1kk/yMZjHYjAAczYUHwipPVh6gUn8g+kszfl5t6HIHBIW43U3QBzH+IosQWCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esVFmqup; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-69d79fc48d2so2745147eaf.1
        for <cgroups@vger.kernel.org>; Mon, 25 May 2026 12:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779735907; x=1780340707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtAatjseL4y/ybWN2OirmEntLqGpzhQX4p1MNNqGB8M=;
        b=esVFmqupdpfG9qcampNsSBEVaP7ZRaPskpA9anA0i55y+kVcM4871W48oYTH/1Qtlo
         x1HUZ7RI4tTkl3O/esvn7N4Ghw7Wbl4FWml2Ay9/jZOQkZYSl1rUfOSK1Vlz6QyCxqYa
         gu+bjyhct1hk4H2RLmak41cObZQ9MYai19ERTdXMSUB1dukSf/G0G6dN6qsM7vwLbwB9
         BLrGKPa+oxqlJJjqbYOYScpoVUcRW1O9JY1cSAQYt4BWAiOu33K5PEM78tHvr+SpyKEs
         UPiDW9Hebs1qbwqu+rbWe+mp87G0IA/E7x7XP0bU0xLtN/cWnZOgNldxZ1TscBFa3G2X
         PAJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779735907; x=1780340707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xtAatjseL4y/ybWN2OirmEntLqGpzhQX4p1MNNqGB8M=;
        b=SOhn4yoqALnuLC5LEdFvGcNOt16Tdb7+Baw/E857dLiR3bCvIQswSloXH/ANzQRxrk
         l6aA2PeBW7yctnA0KNQ4Vzajd3mfkJAR3X5nyfNWLPcikt+hhxso/YMFjjZ+Kekz/nYk
         OGD45XQY0800uQHaz3UumLsmiMGIqSrKSSKuMpx3aAAWm+S/xN27MeIjGv3kAQ9PlTnX
         rSgjcGRaYvmMio2OOVGyEJarG9SnbQ9777TyaQ74RFD8MaAv/UrLviByz0jBBHzlIrpv
         RoWBWQnbKU/bsBAZwaYH0y/3bgNsXkc9wNZAtbaDUQkPw7nxrAKvfLQ/d7aGAdLJ0hbZ
         zPJQ==
X-Forwarded-Encrypted: i=1; AFNElJ/4vfQOoaWZl0VDyOzNuH8BPcq6UtREixGbvt7Z5ZXnNJWwxSG/HtN2ELFFxx7dOYI3g3cz0rSw@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDyv93lPL23Eus73guAQgPAkE2iFT1pnm5AROKvTjz+S/KFln
	FN9Ti1VWfcohRE5Efouz3X9Y+E0jN1zcFfA63PBMUZBGdnHhWkA963Oq
X-Gm-Gg: Acq92OHz9CBy63uh4QRnlrh2KhTp386rappgP4hPYzRPHnXmhwp1WHFGWCl+EBGW8rH
	19J95zxQZ9ZOJNG0PEbKjEmI4BrB8iA7QwiK/bihMe/z97YSI4mEWyVTz8BWQMqzEB79l57Aznc
	24EsJwEgmom9RocStHXlL5Gyj5wh5gW0LL/61XZnIckroOg75DHC4XZWnjoLFz2yVeGRqAcLhwA
	QlP4K74OkzXLDcadqn9ngWro3Pbc3Z0FaprYvitANoDlvJqRLA1X+hQVw+yPNlw8flvHPhhqCRe
	cF8XQUkGVgepj4xdUuBzX26ije4Y6dL400C6F6JesDrm45W/BGDSMKt5bq/lleN5KHampOM5pIB
	DSckKWPZCmED1R+V0Wki142SuaThImVLU7kHLPUYjholj6WLBdMARid94Tr5HEOzrOZx6Vp4mZT
	fcn4R7F0hI1PUSTgmthhkkDACzbSMVyE4kjlB/ADPLDBR3zjuSLoJy8GruS9b1hGQq
X-Received: by 2002:a05:6820:198b:b0:69d:c626:c404 with SMTP id 006d021491bc7-69dc626c494mr1351814eaf.24.1779735906675;
        Mon, 25 May 2026 12:05:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:43::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d8370df8asm5673853eaf.6.2026.05.25.12.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:05:05 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 4/7 v3] mm/memcontrol: convert memcg to use page_counter_stock
Date: Mon, 25 May 2026 12:04:51 -0700
Message-ID: <20260525190455.2843786-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
References: <20260525190455.2843786-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16256-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3E4295CDEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now with all of the memcg_stock handling logic replicated in
page_counter_stock, switch memcg to use the page_counter_stock.

There are a few details that have changed:

First, the old special-casing for the !allow_spinning check to avoid
refilling and flushing of the old stock is removed. This special casing
was important previously, because refilling the stock could do a lot of
extra work by evicting one of 7 random victim memcgs in the percpu
memcg_stock slots. In the new per-counter design, refilling stock just adds
pages to the counter's own local cache without affecting other memcgs,
so the original reason for the special case no longer applies.

Also, we can now fail during page_counter_enable_stock(), if there is
not enough memory to allocate a percpu page_counter_stock. This failure
is rare and nonfatal; the system can continue to operate, with the page
counter working without stock and falling back to walking the hierarchy.

Finally, drain_all_stock is restructured to iterate CPUs in the outer
loop (rather than memcgs) to be able to schedule draining all memcgs
via a single work_on_cpu call. It reduces the number of synchronous
per-CPU work calls from O(memcgs * CPUs) to just O(CPUs).

Note that obj_stock remains untouched by these changes.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 78 +++++++++++++++++++++----------------------------
 1 file changed, 34 insertions(+), 44 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 368efc1455e35..952c6f7430395 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2260,6 +2260,17 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 		queue_work_on(cpu, memcg_wq, work);
 }
 
+static long drain_stock_on_cpu(void *arg)
+{
+	struct mem_cgroup *root_memcg = arg;
+	struct mem_cgroup *memcg;
+
+	for_each_mem_cgroup_tree(memcg, root_memcg)
+		page_counter_drain_stock_local(&memcg->memory);
+
+	return 0;
+}
+
 /*
  * Drains all per-CPU charge caches for given root_memcg resp. subtree
  * of the hierarchy under it.
@@ -2271,28 +2282,16 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 	/* If someone's already draining, avoid adding running more workers. */
 	if (!mutex_trylock(&percpu_charge_mutex))
 		return;
-	/*
-	 * Notify other cpus that system-wide "drain" is running
-	 * We do not care about races with the cpu hotplug because cpu down
-	 * as well as workers from this path always operate on the local
-	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
-	 */
+
+	for_each_online_cpu(cpu)
+		work_on_cpu(cpu, drain_stock_on_cpu, root_memcg);
+
+	/* Drain obj_stock on all online CPUs */
 	migrate_disable();
 	curcpu = smp_processor_id();
 	for_each_online_cpu(cpu) {
-		struct memcg_stock_pcp *memcg_st = &per_cpu(memcg_stock, cpu);
 		struct obj_stock_pcp *obj_st = &per_cpu(obj_stock, cpu);
 
-		if (!test_bit(FLUSHING_CACHED_CHARGE, &memcg_st->flags) &&
-		    is_memcg_drain_needed(memcg_st, root_memcg) &&
-		    !test_and_set_bit(FLUSHING_CACHED_CHARGE,
-				      &memcg_st->flags)) {
-			if (cpu == curcpu)
-				drain_local_memcg_stock(&memcg_st->work);
-			else
-				schedule_drain_work(cpu, &memcg_st->work);
-		}
-
 		if (!test_bit(FLUSHING_CACHED_CHARGE, &obj_st->flags) &&
 		    obj_stock_flush_required(obj_st, root_memcg) &&
 		    !test_and_set_bit(FLUSHING_CACHED_CHARGE,
@@ -2309,9 +2308,13 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
+	struct mem_cgroup *memcg;
+
 	/* no need for the local lock */
 	drain_obj_stock(&per_cpu(obj_stock, cpu));
-	drain_stock_fully(&per_cpu(memcg_stock, cpu));
+
+	for_each_mem_cgroup(memcg)
+		page_counter_drain_stock_cpu(&memcg->memory, cpu);
 
 	return 0;
 }
@@ -2586,7 +2589,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
-	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
@@ -2599,31 +2601,19 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
 
 retry:
-	if (consume_stock(memcg, nr_pages))
-		return 0;
-
-	if (!allow_spinning)
-		/* Avoid the refill and flush of the older stock */
-		batch = nr_pages;
-
 	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	if (!do_memsw_account() ||
-	    page_counter_try_charge(&memcg->memsw, batch, &counter)) {
-		if (page_counter_try_charge(&memcg->memory, batch, &counter))
+	    page_counter_try_charge(&memcg->memsw, nr_pages, &counter)) {
+		if (page_counter_try_charge(&memcg->memory, nr_pages, &counter))
 			goto done_restock;
 		if (do_memsw_account())
-			page_counter_uncharge(&memcg->memsw, batch);
+			page_counter_uncharge(&memcg->memsw, nr_pages);
 		mem_over_limit = mem_cgroup_from_counter(counter, memory);
 	} else {
 		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
 		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
 	}
 
-	if (batch > nr_pages) {
-		batch = nr_pages;
-		goto retry;
-	}
-
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
@@ -2720,9 +2710,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 
 done_restock:
-	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
-
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
@@ -2759,7 +2746,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			 * and distribute reclaim work and delay penalties
 			 * based on how much each task is actually allocating.
 			 */
-			current->memcg_nr_pages_over_high += batch;
+			current->memcg_nr_pages_over_high += nr_pages;
 			set_notify_resume(current);
 			break;
 		}
@@ -3064,7 +3051,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
-		refill_stock(memcg, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 
 	css_put(&memcg->css);
 }
@@ -4096,6 +4083,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	page_counter_free_stock(&memcg->memory);
+	page_counter_free_stock(&memcg->memsw);
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
 	__mem_cgroup_free(memcg);
@@ -4268,6 +4257,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
 
+	/* failure is nonfatal, charges fall back to direct hierarchy */
+	page_counter_enable_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
 	 *
@@ -4330,6 +4322,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	lru_gen_offline_memcg(memcg);
 
 	drain_all_stock(memcg);
+	page_counter_disable_stock(&memcg->memory);
 
 	mem_cgroup_private_id_put(memcg, 1);
 }
@@ -5524,7 +5517,7 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	page_counter_uncharge(&memcg->memory, nr_pages);
 }
 
 void mem_cgroup_flush_workqueue(void)
@@ -5577,12 +5570,9 @@ int __init mem_cgroup_init(void)
 	memcg_wq = alloc_workqueue("memcg", WQ_PERCPU, 0);
 	WARN_ON(!memcg_wq);
 
-	for_each_possible_cpu(cpu) {
-		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
-			  drain_local_memcg_stock);
+	for_each_possible_cpu(cpu)
 		INIT_WORK(&per_cpu_ptr(&obj_stock, cpu)->work,
 			  drain_local_obj_stock);
-	}
 
 	memcg_size = struct_size_t(struct mem_cgroup, nodeinfo, nr_node_ids);
 	memcg_cachep = kmem_cache_create("mem_cgroup", memcg_size, 0,
-- 
2.53.0-Meta


