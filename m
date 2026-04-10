Return-Path: <cgroups+bounces-15216-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJHVKNBm2Wm8pQgAu9opvQ
	(envelope-from <cgroups+bounces-15216-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:08:32 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5897F3DCBDE
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 23:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 324753055293
	for <lists+cgroups@lfdr.de>; Fri, 10 Apr 2026 21:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38113A9DB6;
	Fri, 10 Apr 2026 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItBj9Hn3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E73A9D87
	for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775855277; cv=none; b=gOT5HK2NvmPvDbLQf72z4kh/gSSmN7QsoWT9SWalgwycVXQw7ZpctumCcxIsPZmKunfIh+cEBtWd1XHqKAIQxL+3SrXPvePDjtEDEvzST18lVjQn+75M/CvxEVG0Ai2OTjaEm/loMx1YaHxSD4lec1m4d7SbbgmWox7M3j3x0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775855277; c=relaxed/simple;
	bh=r6+/9SqOs2RB195ZYMzM4gRcuwfE30J1dxzxYtTjG6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rF4j/NR2E3bUJTD2PcfVZYiVpLssEDle6q+e+b5UEQIhzIDpi/mIKTui+v/v2Ll/wl4AQWCHBQQuF7ARRa3sOjfXHALhyVVF9UIWT15LzeDHn896nn3B4eclAvQDr3HVqSpDCxX8Xa+saGT7rce+FRoap7jC4MatKriObIQpIWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItBj9Hn3; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4645dde00a7so2004800b6e.1
        for <cgroups@vger.kernel.org>; Fri, 10 Apr 2026 14:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775855273; x=1776460073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG5z20IDuVvS6OHbornUz1JNtNJjBAIARiXrIBCPKa0=;
        b=ItBj9Hn3tZeR+tJcvspODcQicEs8G6kbmviItnGoGz48BE4xuBrSH4VeRxvux9eEt9
         fjRQEkM9isj1c4GCmj1r6vIeJgnxwRbMqpPZ/TgUA2Rby1+1eHxMoBKeq09FkAd4go+H
         hW2dD7qTUV0XZ+Yho3CltpzZQaBzj/N4wHRxN4M9wGzbQe+/SjgObodnGtj7ypbKFu8m
         Zb9doBkXoAt4i7UZBK1fMX3dbY1RdCX9u+dmtLYEnHjxFbbeOSrC1YJaGz3vGHmWKS8P
         xyqIP3ZmCth0QeeqyR+e6pURWscMETX8e16jgocwOijfGLZPkZ76j4fy0rypUiIKegdf
         OIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775855273; x=1776460073;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PG5z20IDuVvS6OHbornUz1JNtNJjBAIARiXrIBCPKa0=;
        b=Dm5kkwtA1fVtDS/kgnibuj5ERC98gVFPONNbcQhKrvF1hDulBEoV8b5G1hZOoKz/SP
         7mFUU6+S4RprctB/M5fx2cYZpW/p8D/Pn/P48sBFSymYeCSA9Q28si1fPOrGgcwuOfXq
         RHGTl36OY94CuoHftnf76+QhsoVTgF3GFiyW/5UZ3/V3sYsziqw8NrOqYATfxvEqZjZu
         /gU4pmJXjq3iYwE4PcfSuIkZ7TA1YkRIwtL8HEzUfz5cNELojLNmknO08Ky+FmslP/yA
         6S7qJI1HszhSZv3kLC2wV41lwlboIZE+wA95uUCK5eY2zaSoh9+FKkmz+KWVvsTHYD4g
         RRzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQTaP09H9qjhj2pwepTUW0fKotgEPqt6PjS39cV+5yJNRXSlsZnoDy3342jkEcB6JHCxrp1uGX@vger.kernel.org
X-Gm-Message-State: AOJu0YwnZZYAXt3c8w0sRiANmfEymcYw42tHcChLv8mZjHOChPB/WGBd
	iopCnJtvuoGfJQwrw+3Ql95Pdgn0bxQ9A+2SIz2OUl5b7PIR5aN3jiHj
X-Gm-Gg: AeBDievXwTmDtdT1WMSdxyXA4/KYYEmWdslZq5rl670Lly+XxDUJ/jZ5bsShqhyQJ4m
	/ubUTZL8JIya0kXm65pDR+jIOCb1D4pjNIp+NPF7TYeDHV8nHNC5SNkfsQKWLCRyuXhOJPOE9AA
	bevIctiKrkgryiAb/PGZya1W0S/iCd9S/WO7R5GuCq3BDYsbwVo4OWUcGbvN0Uu/1dA0Q+PKCNb
	y2oJtieolhPsRe2dghhGTuiOH376AGcXSQpPAyY7me7RLqTw/kYNyffwCnsJQ9iTr3w74ac7QvG
	sfdqmJi2byRSbpUbYaXZD4/8SjukUgWeknICgUERKBAnyKg9Os4AFQ545o3na0hX9Y3i38OiT6J
	EqTvVTa30DoBC34PkMSxo9D7kDa+q8q5uFF/WjQgYOaUuvx/m8pZSjx3Lxob3MxydGFm1m2Tbaj
	jDfBRGLflMuAyLMLcpTLEp
X-Received: by 2002:a05:6808:1985:b0:46e:c1cd:8661 with SMTP id 5614622812f47-478b64b05d0mr2208429b6e.2.1775855272803;
        Fri, 10 Apr 2026 14:07:52 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-478a2f5580asm2152863b6e.12.2026.04.10.14.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 14:07:52 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH 5/8 RFC] mm/memcontrol: convert memcg to use page_counter_stock
Date: Fri, 10 Apr 2026 14:06:59 -0700
Message-ID: <20260410210742.550489-6-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
References: <20260410210742.550489-1-joshua.hahnjy@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-15216-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cmpxchg.org:email]
X-Rspamd-Queue-Id: 5897F3DCBDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now with all of the memcg_stock handling logic replicated in
page_counter_stock, switch memcg to use the page_counter_stock.

There are a few details that have changed:

First, the old special-casing for the !allow_spinning check to avoid
refilling and flushing of the old stock is removed. This special casing
was important previously, because refilling the stock could do a lot of
extra work by evicting one of 7 random victim memcgs in the percpu
memcg_stock slots.

Now that we no longer randomly evict other memcg stocks, refilling just
adds extra pages to the local cache. While there may be extra work
attempted when trying to refill (rather than just servicing the exact
number of pages requested), this is much less work than the flushing of
other memcgs' stock.

Secondly, stock checking is folded into the memory page_counter. This
means that for cgroupv1 users who use the memsw page_counter, they will
always incur the cost of hierarchically charging for memsw. One possible
workaround for this is to introduce a separate stock for memsw, which
would allow for separate stock checks for both memsw and memory,
restoring the fastpath behavior.

Finally, we can now fail during page_counter_enable_stock(), if there is
not enough memory to allocate a percpu page_counter_stock. This failure
is rare and nonfatal; the system can continue to operate, with the page
counter working without stock and falling back to walking the hierarchy.

Note that obj_stock remains untouched by these changes.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c   | 68 +++++++++++++++++------------------------------
 mm/page_counter.c |  5 +---
 2 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c3d98ab41f1f1..27d2edd5a7832 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2238,33 +2238,22 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
  */
 void drain_all_stock(struct mem_cgroup *root_memcg)
 {
+	struct mem_cgroup *memcg;
 	int cpu, curcpu;
 
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
+	for_each_mem_cgroup_tree(memcg, root_memcg)
+		page_counter_drain_stock(&memcg->memory);
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
@@ -2281,9 +2270,13 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
+	struct mem_cgroup *memcg;
+
 	/* no need for the local lock */
 	drain_obj_stock(&per_cpu(obj_stock, cpu));
-	drain_stock_fully(&per_cpu(memcg_stock, cpu));
+
+	for_each_mem_cgroup(memcg)
+		page_counter_drain_cpu(&memcg->memory, cpu);
 
 	return 0;
 }
@@ -2558,7 +2551,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
-	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
@@ -2571,31 +2563,19 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
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
@@ -2692,9 +2672,6 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	return 0;
 
 done_restock:
-	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
-
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
@@ -2731,7 +2708,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			 * and distribute reclaim work and delay penalties
 			 * based on how much each task is actually allocating.
 			 */
-			current->memcg_nr_pages_over_high += batch;
+			current->memcg_nr_pages_over_high += nr_pages;
 			set_notify_resume(current);
 			break;
 		}
@@ -3036,7 +3013,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
-		refill_stock(memcg, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 
 	css_put(&memcg->css);
 }
@@ -3957,6 +3934,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	page_counter_free_stock(&memcg->memory);
+	page_counter_free_stock(&memcg->memsw);
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
 	__mem_cgroup_free(memcg);
@@ -4130,6 +4109,9 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
 
+	/* failure is nonfatal, charges fall back to direct hierarchy */
+	page_counter_enable_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
 	 *
@@ -4192,6 +4174,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	lru_gen_offline_memcg(memcg);
 
 	drain_all_stock(memcg);
+	page_counter_disable_stock(&memcg->memory);
 
 	mem_cgroup_private_id_put(memcg, 1);
 }
@@ -5382,7 +5365,7 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	page_counter_uncharge(&memcg->memory, nr_pages);
 }
 
 void mem_cgroup_flush_workqueue(void)
@@ -5435,12 +5418,9 @@ int __init mem_cgroup_init(void)
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
diff --git a/mm/page_counter.c b/mm/page_counter.c
index 28c2e6442f7d3..51148ca3a5b63 100644
--- a/mm/page_counter.c
+++ b/mm/page_counter.c
@@ -421,10 +421,7 @@ static long page_counter_drain_stock_cpu(void *arg)
 
 	return 0;
 }
-/*
- * Drain per-cpu stock across all online CPUs. Caller (drain_all_stock) is
- * already protected by a mutex, all future callers must serialize as well.
- */
+
 void page_counter_drain_stock(struct page_counter *counter)
 {
 	int cpu;
-- 
2.52.0


