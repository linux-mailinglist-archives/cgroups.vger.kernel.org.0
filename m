Return-Path: <cgroups+bounces-16224-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Iv1Nx3WEGrYeQYAu9opvQ
	(envelope-from <cgroups+bounces-16224-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:18:05 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E35BB13A
	for <lists+cgroups@lfdr.de>; Sat, 23 May 2026 00:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C6430A9FFA
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 22:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B9C399003;
	Fri, 22 May 2026 22:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AukS9c6c"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61319395DAC
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 22:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487602; cv=none; b=IUtvCzme5uY4f5GF4ytFg69btX1JZGxEtZ4KFGjwriB/u5qfUMKYARZAaYKMYxORgh3gfvhcnx8WM6IvQc1sDn3buyPdQG0t8FJV43lIMzuiGKO4w6skeMrztP4jzBQvBQF0mB9jYbBzPrin0sLwSJ7I/egZdM+n/N0wlwWHJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487602; c=relaxed/simple;
	bh=bY2Vrdbc9B72qquzLFSKVwqLesr2njXFUXExStd+pnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRwrQs0iaCmqeILZc2up4vswPQ6n7uK88X8kKCgYbCXRUA9sOj6nzkgldmWGJ72WU70Trtrf3JsAxIPTRXQwT6dG40lNDf3LwyGawWHVmHlSiIZ5vLy0E83d76a6t8PjAu7hts4K5EJv9lG2V2fBV8QqaLWLg5qf3e7Gt3ayfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AukS9c6c; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e613b4f268so502046a34.1
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779487598; x=1780092398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=coCEHSpY96h8xPt3azS5bgHLcKMYgGKS1j3gGbJhNfs=;
        b=AukS9c6chUgO2SSEH1MaKjRXfptn1SGmAuIe10zhOKVdAptS1/c8XXCGquHn6eUFG6
         D0lroqGZdxBFVw6sCOqBfxqdJfvdq+5lO6/HQfbmbQghqxQjLH6Tisi6YCyPWyfGbqFU
         52lIUCdzRwc/7bDHlJlGG/qGhBAbCM7jy+Y8xLs7jNTu1JUseWQzEyd0bhMboKkJZFJL
         JoGWdWOCO8BuKgrVcZ5xv7rUQnDm1ImCyi4ZN0uJr5uo9WKSSW6+m1wpfWW/8SdMRh8V
         8JBQ25izbpvzzH/cHM9WhqgxGQFhuNiRExQOXSs4JMi4IUEEzkzC1wHfudX+qqVeUaBh
         imIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779487598; x=1780092398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=coCEHSpY96h8xPt3azS5bgHLcKMYgGKS1j3gGbJhNfs=;
        b=Mw6Wd0GjwGL/JAHU00HaZmI2KJFvvUB4NLh/rJ1ndvaxo01CkarvKFoWCHYkpMd49x
         LDKOpEu/QZYkgkMuhWEg50/GQ+4mAXbPGuaJbUL26w/wxfaVdb9tse7zUlCnur2WFMgP
         ljVrJGt+l0VSbud5zbH3xO/pFF8m04d4LQhjQ506nYJfxezmCxFbRcgKXLjpoE38zmD0
         cmDChVAbEbeACFI2Gl2oGENlZWiZmVQzaQCBD6x1ckTgimMZbMWurYnlXMElYqzb8LHG
         L2draty7DT0IAUdz4oX4QJidzziklRd5dW0qh6pjUxOJQeTbcBFFrPSqbkcOSWG6dwmI
         /2Eg==
X-Forwarded-Encrypted: i=1; AFNElJ9rezkoHsg0MOnpY38NIwi3TdsCx26zJX9mqtRtGIxDEZElfHpk/4JFGk7oyO/YOl1PVFt5k0zm@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVhOMowudL4LC9vdeL36vKQ+8CYcf+YtRhByQuOOGScfViZWE
	CoPhlwgXP5mUj3awF0P959IrBTSw46IQVYpZipPOudEJApg43R4aK7p7
X-Gm-Gg: Acq92OGyUgkr3+BPJmxXAJ1/fk8ImF2jnnJGwnj07YDL3+erv22WDzhW3Sey1oLP+4M
	eSpO0DTscCAQNayGX4OmgeCKzFGCx5Y1QNz+gfd/h7gnUtiaVeEeqkFxPHTk41f+0rARnH1mYqv
	biemxk9rY3Hg19pnoEMlbZ5/BGD7iA86no1KWa81KkwA6j/2DUjTjZU1LB3KO0xhL21iJKNG0qC
	uu1+DKI9NAuJRj2ViFn9zaLsOugPgfYq/ytFN/6OcmfspE4APb/i3RZeWB6GMdW7B7D1pkQ0VNq
	zDzojdb/u91Zzub5IOF8HmK+cqIL7Jadgd5N3Y8wf2ABIcgj8WQGqYbBvkw1nWIV98F9MsB1TK4
	MQC8/TmsNJpsIa/mHHOeZZY2ry1a4YTlqJP01KR8I1Tqz1n1xG3bHnH+GxBviW52xw/72/Q4YlS
	j7Wt9B/N4zev1Qq1bDX2vJUtbePkkdP98MSjTP2xjbQpmK2b+KcEkWZYrKg/NSrc0=
X-Received: by 2002:a05:6820:1789:b0:696:834d:cd15 with SMTP id 006d021491bc7-69d7fcaa869mr2248091eaf.7.1779487598260;
        Fri, 22 May 2026 15:06:38 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69d83a4eef1sm1506487eaf.11.2026.05.22.15.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 15:06:37 -0700 (PDT)
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
Subject: [PATCH 4/7 v2] mm/memcontrol: convert memcg to use page_counter_stock
Date: Fri, 22 May 2026 15:06:22 -0700
Message-ID: <20260522220627.1150804-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
References: <20260522220627.1150804-1-joshua.hahnjy@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-16224-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 497E35BB13A
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
index 051b82ebf371c..cb1ea17e03730 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2053,6 +2053,17 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
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
@@ -2064,28 +2075,16 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
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
@@ -2102,9 +2101,13 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
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
@@ -2379,7 +2382,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
-	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
@@ -2392,31 +2394,19 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2513,9 +2503,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 
 done_restock:
-	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
-
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
@@ -2552,7 +2539,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			 * and distribute reclaim work and delay penalties
 			 * based on how much each task is actually allocating.
 			 */
-			current->memcg_nr_pages_over_high += batch;
+			current->memcg_nr_pages_over_high += nr_pages;
 			set_notify_resume(current);
 			break;
 		}
@@ -2858,7 +2845,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
-		refill_stock(memcg, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 
 	css_put(&memcg->css);
 }
@@ -3797,6 +3784,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	page_counter_free_stock(&memcg->memory);
+	page_counter_free_stock(&memcg->memsw);
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
 	__mem_cgroup_free(memcg);
@@ -3956,6 +3945,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
 
+	/* failure is nonfatal, charges fall back to direct hierarchy */
+	page_counter_enable_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
 	 *
@@ -3994,6 +3986,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	lru_gen_offline_memcg(memcg);
 
 	drain_all_stock(memcg);
+	page_counter_disable_stock(&memcg->memory);
 
 	mem_cgroup_private_id_put(memcg, 1);
 }
@@ -5185,7 +5178,7 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	page_counter_uncharge(&memcg->memory, nr_pages);
 }
 
 void mem_cgroup_flush_workqueue(void)
@@ -5238,12 +5231,9 @@ int __init mem_cgroup_init(void)
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


