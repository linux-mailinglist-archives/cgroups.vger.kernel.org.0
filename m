Return-Path: <cgroups+bounces-17194-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Apj1FhrKOmosHAgAu9opvQ
	(envelope-from <cgroups+bounces-17194-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:02:02 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 729596B9585
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:02:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PEBIS7DD;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17194-lists+cgroups=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="cgroups+bounces-17194-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 482363007B1F
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E53911B6;
	Tue, 23 Jun 2026 18:01:47 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270A391E54
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:01:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237707; cv=none; b=tJjegPIYfJsVeh9pF+/yNHQ7iJeyGYkwghr7ppcNLpKiIurUjEDLfQo2xuh+zWcAAlgGfppHWp0CLT44t1d1+ofIirKFPhTBXqAS6oCf+t+qGzLZf5N3FFpZeMLEQ8HCdV0zNo6I/tMtp9V6Po8mjEd7/eIzN2a0biG/U6Fit0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237707; c=relaxed/simple;
	bh=QPQAa/1sIpnCzYX+dKRjwoCFkE8oNXwOY97xBv0/aWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo10BVi0ANZHJNMpG/LDnq2cd/wmbXzTvUmKpLAeGEvooyprw0SigsnZyUhuh1Yv2z/gIM4/RJ4DmBnhDuaiPFY9WGAJeqNkEWTtW9jXn0QyMK2tKMMREU/izwkThAWITUWqjwOOs3zNV1YurTYy7YLemj2TUWceWHEHpUdE+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PEBIS7DD; arc=none smtp.client-ip=209.85.167.181
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-489f3611e0cso183410b6e.1
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237692; x=1782842492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WC7esSJdpBo4cx7rkDb+TP6edbpeHpybFpObAVHlbJY=;
        b=PEBIS7DDhpwKPbQdktyQmujrkKmeC8+zNjTinQdqt/QId+yhomTLhKIIjQEQ8D6BS8
         0vvEtJ7DAn0BUjQCNyiFvussWeKYOWYBuSy5CwK1W1A8pVsF/I82OqSMyXu3FjEK2SiM
         MAmbB+X3CPA449i6YY5j64ATV+M6ho1q0hZhMZRDWHaKvaRMz/g4R3hQAnrmFwPjMDhH
         /hjNzeOVkz0Ei61RgdxkX+bgTTtqAa/IRZ1iduSZdTvgRgG6/+IFoK0xGTr/QF6nnL+H
         7W/sMIL4uQfxcvP5uVxr1wgxSfyFGnw5vnQOrAThvhwiavsxlpdaAVqRT0jQGZhlJA2p
         uK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237692; x=1782842492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WC7esSJdpBo4cx7rkDb+TP6edbpeHpybFpObAVHlbJY=;
        b=XWHLJHaJ6zvaPKwgRjk3BA02pbDJ9NxBTqE9Ilsrfvesw5uT9gwUFdZObWHtp7fTqV
         JJCgLa6HD1T7D+RPrZ7DjccKZt4PyYSxVKoQxqoBAzM5vcyJwD5fXquWeIYxEPuDafK3
         nq5lj1J/OOL4h6pXGpMka99Y/TQ5JpxIUbcccqzOLWr45uG+KXJHJARTlD4I4WTuYO1B
         gcICWtx6PJIqVWdWq4l70Wz00INgMAdY9NBAHAEX6qP+jTmW/5pehlnBr+4ogjLXd9YS
         IBbWPP3lDFzFW5+gsX5O49j6jMSemPLZLVNlnCeF6Zla6GydRlz5TM1kgCBaU4stvFWQ
         rtjw==
X-Forwarded-Encrypted: i=1; AFNElJ+3e50aNPvyyXj2ltPU1fLt4b+nZpy2ym8zVDycDjAMex1Fi7iF8lUYVnlM6CsoYt1B7BgJKonI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz9gkXLDlKxqlyraAvkd+A8pjteKYcrdwKFTMvaapy80Tv0SyK
	Ln1Nvv9R/FWuWY7mFYnXrmEjSMc9AEw0vX03RSZGg9BhwzWIVStBWJul
X-Gm-Gg: AfdE7clpJEfSuenADVnDbX0FAj6VUH/z7eZJDLhrASmLtvTudPanvRFz+Nu+bHfipxB
	UrlqqEsNFXMLNdBYMaCoeTDtBB6kt6CVsbRF+gR9n6J+CYnliwdpcFk7xGqXOVa/FC8iKa+dQS3
	p+FYBX41cg/zjlbFg//sNTkYwV5WCtGfYdodfXQCTdf5Sa1xWi7smPIa55XXcLJPhLtXGsxWXmW
	R+4hVoJXEbfBA5/V7JPoes6ypj59mqM/JVOWqR1kMCjofE3nhc6X8RhyKZQT+Sjdv7Kxrmioiuf
	xkz4GRE5Qhb4lUhUyG7DiO/W/hTpICCWcAfMT3+/EgMKsXcG4UtuoScVm2GPYagQhnkJ78ilc0B
	cMlTff030JdoNuHBAOIoeW4tX+/WFTa0+8P2qOm3l8zyfdlKhPzdFGI3TUbp0IqEV6GxH8qlsq/
	bv/V6zSifq3yogWitFOVS6oocQIpLU+o0TCiw+gxNd3Aw=
X-Received: by 2002:a05:6808:1387:b0:48a:199a:1fe2 with SMTP id 5614622812f47-48f60fa98b2mr2616645b6e.19.1782237691560;
        Tue, 23 Jun 2026 11:01:31 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:49::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aebb9cbe5sm7128201b6e.3.2026.06.23.11.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 11:01:31 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam.howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH v4 4/5] mm/memcontrol: convert memcg to use page_counter_stock
Date: Tue, 23 Jun 2026 11:01:22 -0700
Message-ID: <20260623180124.868655-5-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
References: <20260623180124.868655-1-joshua.hahnjy@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17194-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:liam.howlett@oracle.com,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 729596B9585

Now with all of the memcg_stock handling logic replicated in
page_counter_stock, switch memcg to use the page_counter_stock for the
memory (and for cgroup v1 users, memsw) page_counters.

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

drain_all_stock and memcg_hotplug_cpu_dead also now use the page_counter
stock drain variant, which uses remote atomic_xchg to retrieve stock
across CPUs, instead of scheduling asynchronous work.

Finally, as a side-effect of separating the per-memcg stock to per-
page_counter, the memsw and memory page_counters have independent stock.
This means that the reported memsw may transiently be lower than memory
usage if the stock for memory and memsw page_counters go out of sync.

Note that obj_stock is untouched by this change.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/memcontrol.c | 87 +++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 46 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 306658fd55512..846800917af49 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2269,39 +2269,36 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 		queue_work_on(cpu, memcg_wq, work);
 }
 
+static void memcg_drain_stock(struct mem_cgroup *memcg, int cpu)
+{
+	page_counter_drain_stock(&memcg->memory, cpu);
+	if (do_memsw_account())
+		page_counter_drain_stock(&memcg->memsw, cpu);
+}
+
 /*
  * Drains all per-CPU charge caches for given root_memcg resp. subtree
  * of the hierarchy under it.
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
+	for_each_mem_cgroup_tree(memcg, root_memcg) {
+		for_each_online_cpu(cpu)
+			memcg_drain_stock(memcg, cpu);
+	}
+
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
@@ -2318,9 +2315,13 @@ void drain_all_stock(struct mem_cgroup *root_memcg)
 
 static int memcg_hotplug_cpu_dead(unsigned int cpu)
 {
+	struct mem_cgroup *memcg;
+
 	/* no need for the local lock */
 	drain_obj_stock(&per_cpu(obj_stock, cpu));
-	drain_stock_fully(&per_cpu(memcg_stock, cpu));
+
+	for_each_mem_cgroup(memcg)
+		memcg_drain_stock(memcg, cpu);
 
 	return 0;
 }
@@ -2595,7 +2596,6 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			    unsigned int nr_pages)
 {
-	unsigned int batch = max(MEMCG_CHARGE_BATCH, nr_pages);
 	int nr_retries = MAX_RECLAIM_RETRIES;
 	struct mem_cgroup *mem_over_limit;
 	struct page_counter *counter;
@@ -2606,36 +2606,30 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool raised_max_event = false;
 	unsigned long pflags;
 	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
+	unsigned long nr_charged = 0;
 
 retry:
-	if (consume_stock(memcg, nr_pages))
-		return 0;
-
-	if (!allow_spinning)
-		/* Avoid the refill and flush of the older stock */
-		batch = nr_pages;
-
 	reclaim_options = MEMCG_RECLAIM_MAY_SWAP;
 	if (do_memsw_account() &&
-	    !page_counter_try_charge(&memcg->memsw, batch, &counter)) {
+	    !page_counter_try_charge_stock(&memcg->memsw, nr_pages,
+					   &counter, NULL)) {
 		mem_over_limit = mem_cgroup_from_counter(counter, memsw);
 		reclaim_options &= ~MEMCG_RECLAIM_MAY_SWAP;
 		goto reclaim;
 	}
 
-	if (page_counter_try_charge(&memcg->memory, batch, &counter))
-		goto done_restock;
+	if (page_counter_try_charge_stock(&memcg->memory, nr_pages,
+					  &counter, &nr_charged)) {
+		if (!nr_charged)
+			return 0;
+		goto handle_high;
+	}
 
 	if (do_memsw_account())
-		page_counter_uncharge(&memcg->memsw, batch);
+		page_counter_uncharge(&memcg->memsw, nr_pages);
 	mem_over_limit = mem_cgroup_from_counter(counter, memory);
 
 reclaim:
-	if (batch > nr_pages) {
-		batch = nr_pages;
-		goto retry;
-	}
-
 	/*
 	 * Prevent unbounded recursion when reclaim operations need to
 	 * allocate memory. This might exceed the limits temporarily,
@@ -2731,10 +2725,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 
 	return 0;
 
-done_restock:
-	if (batch > nr_pages)
-		refill_stock(memcg, batch - nr_pages);
-
+handle_high:
 	/*
 	 * If the hierarchy is above the normal consumption range, schedule
 	 * reclaim on returning to userland.  We can perform reclaim here
@@ -2771,7 +2762,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 			 * and distribute reclaim work and delay penalties
 			 * based on how much each task is actually allocating.
 			 */
-			current->memcg_nr_pages_over_high += batch;
+			current->memcg_nr_pages_over_high += nr_charged;
 			set_notify_resume(current);
 			break;
 		}
@@ -3076,7 +3067,7 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
 	account_kmem_nmi_safe(memcg, -nr_pages);
 	memcg1_account_kmem(memcg, -nr_pages);
 	if (!mem_cgroup_is_root(memcg))
-		refill_stock(memcg, nr_pages);
+		memcg_uncharge(memcg, nr_pages);
 
 	css_put(&memcg->css);
 }
@@ -4080,6 +4071,8 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 static void mem_cgroup_free(struct mem_cgroup *memcg)
 {
+	page_counter_free_stock(&memcg->memory);
+	page_counter_free_stock(&memcg->memsw);
 	lru_gen_exit_memcg(memcg);
 	memcg_wb_domain_exit(memcg);
 	__mem_cgroup_free(memcg);
@@ -4247,6 +4240,11 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
 
+	/* failure is nonfatal, charges fall back to direct hierarchy */
+	page_counter_alloc_stock(&memcg->memory, MEMCG_CHARGE_BATCH);
+	if (do_memsw_account())
+		page_counter_alloc_stock(&memcg->memsw, MEMCG_CHARGE_BATCH);
+
 	/*
 	 * Ensure mem_cgroup_from_private_id() works once we're fully online.
 	 *
@@ -5502,7 +5500,7 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
 
 	mod_memcg_state(memcg, MEMCG_SOCK, -nr_pages);
 
-	refill_stock(memcg, nr_pages);
+	page_counter_uncharge(&memcg->memory, nr_pages);
 }
 
 void mem_cgroup_flush_workqueue(void)
@@ -5555,12 +5553,9 @@ int __init mem_cgroup_init(void)
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


