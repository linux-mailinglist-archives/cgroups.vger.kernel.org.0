Return-Path: <cgroups+bounces-16673-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /hUbFsrvImrYfQEAu9opvQ
	(envelope-from <cgroups+bounces-16673-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CFB649772
	for <lists+cgroups@lfdr.de>; Fri, 05 Jun 2026 17:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BlIN9Kd8;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-16673-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-16673-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92633311DA1C
	for <lists+cgroups@lfdr.de>; Fri,  5 Jun 2026 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B91419A4;
	Fri,  5 Jun 2026 15:36:17 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AA53B5314
	for <cgroups@vger.kernel.org>; Fri,  5 Jun 2026 15:36:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673776; cv=none; b=Eh4rOmwsn11hGkahSwpBLeqRNrkd2ScfU/thx+wHRHZfZp8AKlePIknQ0v3lU1mqSZv37FbRxq+kEy+ALBd964FXJpOUZn2sq/yed+qKPpg5YQFbmM8VYUV1ovTef80UFUpru2KWUfcNaHXAmjHjLlQlp4liKMFlahaVNrZSTGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673776; c=relaxed/simple;
	bh=YARM61p7OCvIlSHd3e+h/5q9hPtEiViLCkKf0hA0Dwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvSUTdaqaIufYe0u+lZA5aYXXeVeadunymM20rLQh25kN3iM4Rm0+O+o/BcYx5mDsMwE5eC3RswcU9nj+6ArTnFZHhAsL6F/57h9SSrzKoa0XVFWpAgXHOx7tGvkVolEVGHIeOmKsVyQL2/Sp2jMHrFmPJdhIvkgFa4Ky9Px7I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlIN9Kd8; arc=none smtp.client-ip=209.85.160.42
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43f1f2b82c6so1549594fac.3
        for <cgroups@vger.kernel.org>; Fri, 05 Jun 2026 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780673770; x=1781278570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QT7NBEIym2G0kzWniqTa/IOK3LykjdeMwTsMHCm4gYI=;
        b=BlIN9Kd8V0sZyE9w/u/W+jKR2KgCw1LX4b5olG3fsLhhu4oewo7H0geesRynJarwSW
         1NM96ncEt1xtD0KMpOmsS3adN9DbpKSt9CDo9C09RAt6Rx9t3Aa0e/6hQFcWDGrJ7evL
         J1JAcrIkyk4ZdaclTbtujjljsYhpCotxaRnOvJ+l7aNjFd/PCazWhTWz01ftcQ5Eh9pd
         DtMXKFJuKC5wecIbG+WLndJC3XPF9b3FslZ5K9IDl6WtP4MngA941hsc69EGb2CYtCO/
         vS3MhRwVMcA5Spfr1uzsQyYrfAtm0LKg8lECzUUELBZhdeh11KpP4jl7f7Y30m8v0m8C
         6Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780673770; x=1781278570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QT7NBEIym2G0kzWniqTa/IOK3LykjdeMwTsMHCm4gYI=;
        b=ZS4Tul43x550c9j27lTFvi+DL9il6OWQcvnUH/1VocJTCcqEFHMw5rIa4I25PYdoYm
         0BdD/hzFozXB3FicsVsL4bHJqQr1DlFZG2/55qhdLt1GrzFQhKo9wL1xpEPhSlaHBe3w
         hbgq3hNbgdXjV5SXLYQS2wKt3f8X0ti3y0LJlDSwdKXFczCV+i4EGSHbu6ZzazdfjNjL
         6ghvckBawKj/C5EQO6jr+b3yvXN6up4T9Mpw4GODPvTyKCRLGBCNtSNv8mMK3xphPgQl
         51AIwcZWUdgILeHZW4wr9DPt04nnM8gg95WJVW0MriEfNOJcyBm4+DVuc+0QmdaTEH5h
         1kLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aHdDRNfNWYCTXOqd/Q8+R7MPA0zLNomyGot+aHB7FFH7Rmyiq/t+/Ws6d5Lj8JiHVAvKXV3Sq@vger.kernel.org
X-Gm-Message-State: AOJu0YwIIY4aitc3We/9iWMAvk95i5XbiWOLnVMmAE+ftX/BHC2xh9qz
	9EzlRwM1urzOm3VU6aT0TGlDBWe8mXz2Ynj8QBUhPp5PgMMS6eODIcNgHtrCSQ==
X-Gm-Gg: Acq92OFv3vJuqyclAuIWGJnCH390MAyvSdAQ+HoALL5TSYxfiV4TwqJHANOXAiU5ilw
	CLmLw3pghN7rRfaDXku79fBoOlz8TQwbdv/qqvuwlth1ffMYUATDMQOHY6i8Pv7MGS9Gh8q5Jcr
	GUHUQq++iS8SWicuTNDsRFvHxsAPw4I2UB9p4CapS2LUxP0sQz8PkOVp3HVakei7Vq+Lhdtqo5u
	RFjDIPc8OPtLW2PAoWcCONBsvztykwVlFBqtx4vpq2QjzqUIwvl5DLsVKCI3iG1JyYOueJ28pgh
	PJCq5eE+0RVVUHqVm+Upw+y4GlOoZrEQ5DTzFuLhdIFps5UUeFQoyBAEAdq1Pcr4Z1KvKqh5f2v
	3hGO6oEy3X4Dy8czAQwnahSjohUTfbpv7JUbrO3yrt2niRkSyu5rafkiuIp7TRdG/FgxuL7ghtF
	qKpYTOZC2fGJojsjd0BtKqMSxRZZ3VBAodHdmK1qFmSK/qjPtDMo8OAqd412ms081P
X-Received: by 2002:a05:6870:6488:b0:430:b01:1f79 with SMTP id 586e51a60fabf-4413d248508mr2239934fac.2.1780673769704;
        Fri, 05 Jun 2026 08:36:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:54::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8295b38sm8359180fac.10.2026.06.05.08.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:36:09 -0700 (PDT)
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
Subject: [PATCH 4/6 v3] mm/memcontrol: convert memcg to use page_counter_stock
Date: Fri,  5 Jun 2026 08:36:00 -0700
Message-ID: <20260605153603.234296-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
References: <20260605153603.234296-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16673-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cmpxchg.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98CFB649772

Now with all of the memcg_stock handling logic replicated in
page_counter_stock, switch memcg to use the page_counter_stock.

There are a few details that have changed:

First, the old special-casing for the !allow_spinning check to avoid
refilling and flushing of the old stock is removed. This special casing
was important previously, because refilling the stock could do a lot of
extra work by evicting one of 7 random victim memcgs in the percpu
memcg_stock slots. In the new per-counter design, refilling stock just
adds pages to the counter's own local cache without affecting other memcgs,
so the original reason for the special case no longer applies.

Also, we can now fail during page_counter_alloc_stock(), if there is
not enough memory to allocate a percpu page_counter_stock. This failure
is rare and nonfatal; the system can continue to operate, with the page
counter working without stock and falling back to walking the hierarchy.

Finally, drain_all_stock is restructured to iterate CPUs in the outer
loop (rather than memcgs) to be able to schedule draining all memcgs
via a single work_on_cpu call. It reduces the number of synchronous
per-CPU work calls from O(memcgs * CPUs) to just O(CPUs).

We also skip isolated CPUs, as schedule_drain_work() did before. We
don't need its guard(rcu) here though; that rcu section existed to
order async work scheduling against cpumask updates and workqueue
flushes, which would lead to drain work pending.
Since all work here is synchronous, we don't leave any work behind.

Note that obj_stock remains untouched by these changes, and that memsw
stock will be handled in the next patch.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 80 ++++++++++++++++++++++---------------------------
 1 file changed, 36 insertions(+), 44 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 56cd4af082326..562ed9301f5a4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2269,6 +2269,17 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
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
@@ -2280,28 +2291,18 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
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
+	for_each_online_cpu(cpu) {
+		if (!cpu_is_isolated(cpu))
+			work_on_cpu(cpu, drain_stock_on_cpu, root_memcg);
+	}
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
@@ -2318,9 +2319,13 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
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
@@ -2595,7 +2600,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
-	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
@@ -2608,31 +2612,19 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2729,9 +2721,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 
 done_restock:
-	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
-
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
@@ -2768,7 +2757,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			 * and distribute reclaim work and delay penalties
 			 * based on how much each task is actually allocating.
 			 */
-			current->memcg_nr_pages_over_high += batch;
+			current->memcg_nr_pages_over_high += nr_pages;
 			set_notify_resume(current);
 			break;
 		}
@@ -3073,7 +3062,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
-		refill_stock(memcg, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 
 	css_put(&memcg->css);
 }
@@ -4077,6 +4066,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	page_counter_free_stock(&memcg->memory);
+	page_counter_free_stock(&memcg->memsw);
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
 	__mem_cgroup_free(memcg);
@@ -4244,6 +4235,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
 
+	/* failure is nonfatal, charges fall back to direct hierarchy */
+	page_counter_alloc_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
 	 *
@@ -4304,6 +4298,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	wb_memcg_offline(memcg);
 	lru_gen_offline_memcg(memcg);
 
+	page_counter_disable_stock(&memcg->memory);
 	drain_all_stock(memcg);
 
 	mem_cgroup_private_id_put(memcg, 1);
@@ -5499,7 +5494,7 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	page_counter_uncharge(&memcg->memory, nr_pages);
 }
 
 void mem_cgroup_flush_workqueue(void)
@@ -5552,12 +5547,9 @@ int __init mem_cgroup_init(void)
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


