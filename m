Return-Path: <cgroups+bounces-4298-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2B9528BF
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 07:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881221C21C15
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 05:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBDA558BC;
	Thu, 15 Aug 2024 05:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NYVUPZKR"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90DE770FB
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698334; cv=none; b=UJrx/aVgjdSNoDRFNnRYt4CoFCU4GFkYcJZvQGxAF+N7HKUwb8thAjn9+9gdB4HtJ33/kV97lBOi8aOOaVzrHrbadjsra+p2+UzqphXyDY6pAetdQ7kbIEHBCwNXN9LRF9A8dQEkX0N8RB1yjddN6bxU3vZ06SmFL44le07nqk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698334; c=relaxed/simple;
	bh=MKb9TW3XdiHBxtx0ixgaD7Un8jsOM0OHH6SCCv6yV9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlKNzy5M2GfeL6eJhMGnFcx3VbhUFqk78CW39FuIbc/wRzmKPsnP7UeQ5l7OthGSuqBTlc9gUMWdszr0UvLCj3U2/NG7tUVFr//Xs+0OXvvyK8YORLTHxKgiDyHUU1vtJ/uo//4xQbb3VCqlHQg7IRMuJASV0qE+gDa5+OivjCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NYVUPZKR; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0zs8JI6aVxhuUibp1uzMfh5rP7bzFpoEcwMysAA/4Ek=;
	b=NYVUPZKRDyftYd4jWKz6eJxpMyBBS3VYXLMedsgvZjz0oPrIH3OYf1IEUOh5sCV80li/Yu
	lRk4xUdMr+RC9MPZFLr5K+eHQNx/j4b06zQD++GNIoNGumkjKOsymupdndD2XKl7eIJPZ/
	fZZxpp/v/SLIuu1a9AMlglYO45I0+R4=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"T . J . Mercier" <tjmercier@google.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 4/7] memcg: move v1 events and statistics code to v1 file
Date: Wed, 14 Aug 2024 22:04:50 -0700
Message-ID: <20240815050453.1298138-5-shakeel.butt@linux.dev>
In-Reply-To: <20240815050453.1298138-1-shakeel.butt@linux.dev>
References: <20240815050453.1298138-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently the common code path for charge commit, swapout and batched
uncharge are executing v1 only code which is completely useless for the
v2 deployments where CONFIG_MEMCG_V1 is disabled. In addition, it is
mucking with IRQs which might be slow on some architectures. Let's move
all of this code to v1 only code and remove them from v2 only
deployments.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol-v1.c | 37 +++++++++++++++++++++++++++++++++++++
 mm/memcontrol-v1.h | 14 ++++++++++++++
 mm/memcontrol.c    | 33 ++++-----------------------------
 3 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 73587e6417c5..ffb7246b3f35 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -1502,6 +1502,43 @@ void memcg1_check_events(struct mem_cgroup *memcg, int nid)
 	}
 }
 
+void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	memcg1_charge_statistics(memcg, folio_nr_pages(folio));
+	memcg1_check_events(memcg, folio_nid(folio));
+	local_irq_restore(flags);
+}
+
+void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg)
+{
+	/*
+	 * Interrupts should be disabled here because the caller holds the
+	 * i_pages lock which is taken with interrupts-off. It is
+	 * important here to have the interrupts disabled because it is the
+	 * only synchronisation we have for updating the per-CPU variables.
+	 */
+	preempt_disable_nested();
+	VM_WARN_ON_IRQS_ENABLED();
+	memcg1_charge_statistics(memcg, -folio_nr_pages(folio));
+	preempt_enable_nested();
+	memcg1_check_events(memcg, folio_nid(folio));
+}
+
+void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
+			   unsigned long nr_memory, int nid)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	__count_memcg_events(memcg, PGPGOUT, pgpgout);
+	__this_cpu_add(memcg->events_percpu->nr_page_events, nr_memory);
+	memcg1_check_events(memcg, nid);
+	local_irq_restore(flags);
+}
+
 static int compare_thresholds(const void *a, const void *b)
 {
 	const struct mem_cgroup_threshold *_a = a;
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index ef72d0b7c5c6..376d021a2bf4 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -118,6 +118,11 @@ void memcg1_oom_recover(struct mem_cgroup *memcg);
 void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
 void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 
+void memcg1_commit_charge(struct folio *folio, struct mem_cgroup *memcg);
+void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg);
+void memcg1_uncharge_batch(struct mem_cgroup *memcg, unsigned long pgpgout,
+			   unsigned long nr_memory, int nid);
+
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 
 void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages);
@@ -150,6 +155,15 @@ static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
 static inline void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages) {}
 static inline void memcg1_check_events(struct mem_cgroup *memcg, int nid) {}
 
+static inline void memcg1_commit_charge(struct folio *folio,
+					struct mem_cgroup *memcg) {}
+
+static inline void memcg1_swapout(struct folio *folio, struct mem_cgroup *memcg) {}
+
+static inline void memcg1_uncharge_batch(struct mem_cgroup *memcg,
+					 unsigned long pgpgout,
+					 unsigned long nr_memory, int nid) {}
+
 static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
 
 static inline void memcg1_account_kmem(struct mem_cgroup *memcg, int nr_pages) {}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index f8db9924d5dc..c4b06f26ccfd 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2383,11 +2383,7 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 {
 	css_get(&memcg->css);
 	commit_charge(folio, memcg);
-
-	local_irq_disable();
-	memcg1_charge_statistics(memcg, folio_nr_pages(folio));
-	memcg1_check_events(memcg, folio_nid(folio));
-	local_irq_enable();
+	memcg1_commit_charge(folio, memcg);
 }
 
 static inline void __mod_objcg_mlstate(struct obj_cgroup *objcg,
@@ -4608,8 +4604,6 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
-	unsigned long flags;
-
 	if (ug->nr_memory) {
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
 		if (do_memsw_account())
@@ -4621,11 +4615,7 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		memcg1_oom_recover(ug->memcg);
 	}
 
-	local_irq_save(flags);
-	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->events_percpu->nr_page_events, ug->nr_memory);
-	memcg1_check_events(ug->memcg, ug->nid);
-	local_irq_restore(flags);
+	memcg1_uncharge_batch(ug->memcg, ug->pgpgout, ug->nr_memory, ug->nid);
 
 	/* drop reference from uncharge_folio */
 	css_put(&ug->memcg->css);
@@ -4732,7 +4722,6 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 {
 	struct mem_cgroup *memcg;
 	long nr_pages = folio_nr_pages(new);
-	unsigned long flags;
 
 	VM_BUG_ON_FOLIO(!folio_test_locked(old), old);
 	VM_BUG_ON_FOLIO(!folio_test_locked(new), new);
@@ -4760,11 +4749,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 
 	css_get(&memcg->css);
 	commit_charge(new, memcg);
-
-	local_irq_save(flags);
-	memcg1_charge_statistics(memcg, nr_pages);
-	memcg1_check_events(memcg, folio_nid(new));
-	local_irq_restore(flags);
+	memcg1_commit_charge(new, memcg);
 }
 
 /**
@@ -5000,17 +4985,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 		page_counter_uncharge(&memcg->memsw, nr_entries);
 	}
 
-	/*
-	 * Interrupts should be disabled here because the caller holds the
-	 * i_pages lock which is taken with interrupts-off. It is
-	 * important here to have the interrupts disabled because it is the
-	 * only synchronisation we have for updating the per-CPU variables.
-	 */
-	memcg_stats_lock();
-	memcg1_charge_statistics(memcg, -nr_entries);
-	memcg_stats_unlock();
-	memcg1_check_events(memcg, folio_nid(folio));
-
+	memcg1_swapout(folio, memcg);
 	css_put(&memcg->css);
 }
 
-- 
2.43.5


