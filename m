Return-Path: <cgroups+bounces-4297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6790B9528BD
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 07:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01062B2458A
	for <lists+cgroups@lfdr.de>; Thu, 15 Aug 2024 05:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A97603F;
	Thu, 15 Aug 2024 05:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SSufFwWC"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410EB57CA7
	for <cgroups@vger.kernel.org>; Thu, 15 Aug 2024 05:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723698331; cv=none; b=g5XFfkmx5SL5X/PyRlDNkRTTsO601QFceRsamv80T952qtuGii3RJyzuO2B3V8I2nW/+Ws9i+fiZpp3b1iUus/FNMmZ8ktufOcpOta/Ofei1PbOl+yO9ByB3G1WghLazQOJXrFWxsfYikhcLcuTeJcmOdq+5BwYP2yx3V5DsfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723698331; c=relaxed/simple;
	bh=w2nLldFMuC5Tr8Vr6K5HqqB5Y9jJ5YmbY7CMAtSZ01E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRl2UWVjqGzo2M9lxdQrxkutMDZ3vWB/5hJaNB78WUuqi/JAyuMVTtSfWqsewRN4m3l83UKH5F/yUdrfOpgRgYIMoGipdsJw8bY4AY6HF6Qqp3ZeCVnXS4dKVy94Lv8dwWGn21ncoBC1b/RL6XbtqmIVfMn7fbBkwfMsQavaZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SSufFwWC; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723698327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zygVeQZHpWPOjOtuooWei0ElZsFf2qNUmjbZYRpm8Xo=;
	b=SSufFwWCrJB8eaH9sXXX9w33eVNxPwPO5BWCNuheXLzNVABd7WZoEprGHuGIUwlN5GrBBN
	bVriG0DCZ4Y2PnWVKHGPrswvS5dnKDx0K7ZRYh+l9vgp2IrJN7Zpuj595kZK5teC4UFSfz
	Cy3IRk3vBQKDfZD2kKNw68eArrfs2y8=
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
Subject: [PATCH 3/7] memcg: move mem_cgroup_charge_statistics to v1 code
Date: Wed, 14 Aug 2024 22:04:49 -0700
Message-ID: <20240815050453.1298138-4-shakeel.butt@linux.dev>
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

There are no callers of mem_cgroup_charge_statistics() in the v2 code
base, so move it to the v1 only code and rename it to
memcg1_charge_statistics().

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 mm/memcontrol-v1.c | 17 +++++++++++++++--
 mm/memcontrol-v1.h |  3 ++-
 mm/memcontrol.c    | 19 +++----------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index 0ce1807ba468..73587e6417c5 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -853,9 +853,9 @@ static int mem_cgroup_move_account(struct folio *folio,
 	nid = folio_nid(folio);
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(to, nr_pages);
+	memcg1_charge_statistics(to, nr_pages);
 	memcg1_check_events(to, nid);
-	mem_cgroup_charge_statistics(from, -nr_pages);
+	memcg1_charge_statistics(from, -nr_pages);
 	memcg1_check_events(from, nid);
 	local_irq_enable();
 out:
@@ -1439,6 +1439,19 @@ static void mem_cgroup_threshold(struct mem_cgroup *memcg)
 	}
 }
 
+void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
+{
+	/* pagein of a big page is an event. So, ignore page size */
+	if (nr_pages > 0)
+		__count_memcg_events(memcg, PGPGIN, 1);
+	else {
+		__count_memcg_events(memcg, PGPGOUT, 1);
+		nr_pages = -nr_pages; /* for event */
+	}
+
+	__this_cpu_add(memcg->events_percpu->nr_page_events, nr_pages);
+}
+
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index fb7d439f19de..ef72d0b7c5c6 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -7,7 +7,6 @@
 
 /* Cgroup v1 and v2 common declarations */
 
-void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
 int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		     unsigned int nr_pages);
 
@@ -116,6 +115,7 @@ bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
 void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
 void memcg1_oom_recover(struct mem_cgroup *memcg);
 
+void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
 void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
@@ -147,6 +147,7 @@ static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) {
 static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
 static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
 
+static inline void memcg1_charge_statistics(struct mem_cgroup *memcg, int nr_pages) {}
 static inline void memcg1_check_events(struct mem_cgroup *memcg, int nid) {}
 
 static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7ea511119567..f8db9924d5dc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -848,19 +848,6 @@ unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 	return READ_ONCE(memcg->vmstats->events_local[i]);
 }
 
-void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
-{
-	/* pagein of a big page is an event. So, ignore page size */
-	if (nr_pages > 0)
-		__count_memcg_events(memcg, PGPGIN, 1);
-	else {
-		__count_memcg_events(memcg, PGPGOUT, 1);
-		nr_pages = -nr_pages; /* for event */
-	}
-
-	__this_cpu_add(memcg->events_percpu->nr_page_events, nr_pages);
-}
-
 struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
 {
 	/*
@@ -2398,7 +2385,7 @@ void mem_cgroup_commit_charge(struct folio *folio, struct mem_cgroup *memcg)
 	commit_charge(folio, memcg);
 
 	local_irq_disable();
-	mem_cgroup_charge_statistics(memcg, folio_nr_pages(folio));
+	memcg1_charge_statistics(memcg, folio_nr_pages(folio));
 	memcg1_check_events(memcg, folio_nid(folio));
 	local_irq_enable();
 }
@@ -4775,7 +4762,7 @@ void mem_cgroup_replace_folio(struct folio *old, struct folio *new)
 	commit_charge(new, memcg);
 
 	local_irq_save(flags);
-	mem_cgroup_charge_statistics(memcg, nr_pages);
+	memcg1_charge_statistics(memcg, nr_pages);
 	memcg1_check_events(memcg, folio_nid(new));
 	local_irq_restore(flags);
 }
@@ -5020,7 +5007,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
 	memcg_stats_lock();
-	mem_cgroup_charge_statistics(memcg, -nr_entries);
+	memcg1_charge_statistics(memcg, -nr_entries);
 	memcg_stats_unlock();
 	memcg1_check_events(memcg, folio_nid(folio));
 
-- 
2.43.5


