Return-Path: <cgroups+bounces-3334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59978915B6C
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0E871F22874
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBFA70CC8;
	Tue, 25 Jun 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xZ/trUm1"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD3161FD3
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277198; cv=none; b=UUHbiu8v0EkDCzMKTIL9e7gEyvOTuKYdpoYAGJF2m91GI3ejrznpfNNUXRH/GHuwWDhw6pPELW4CgGj0ov8AI8NmU/Wn13wyT3/+gndNo7+ypEbHu8i8nrJkSZfhgqlo7kPD9qcFvlAwnc/tDeumoT6OEgSwlNq0PHvhPsTq6iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277198; c=relaxed/simple;
	bh=DXbBSXMMQBlOnmcmQav3CtTvcCGhGgqyFQgW+B/FlMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXRHoJHSdwyNukmXXrTf2gU1t5C5RaWDMIl4nl8ZjlpgdzLYH6Ok+IX04OggSKKEo63mWX5lZ2HSyAoErhFReI8BVhIn2VQ+MokZr0AS8uGXOuIHwJxIeVxYEQTYylX0/kpX+RwEOvB5g7+bSyu2PZA+Wzn1e1qQax4FX9C1Z9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xZ/trUm1; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKa/FfyHPEH4o1sFdYYdtwpHqrQqG+YVicTF0vyr7Es=;
	b=xZ/trUm1bPRxjkxHdfwXYw23D8g3nT4RuyvbkwX3GrpmF6OUjQPtABVAGUzjlLOXtMZzFy
	N73Jm3sr4Sw/t537Ch/wnspIKfD3obUNU29cQ4gbrd662+v0CBRE7p65+BiGKRMKacyg7m
	gBsWfxX0p2NJAop6892EaPa5rPKrxWk=
X-Envelope-To: hannes@cmpxchg.org
X-Envelope-To: mhocko@kernel.org
X-Envelope-To: shakeel.butt@linux.dev
X-Envelope-To: muchun.song@linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: cgroups@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: roman.gushchin@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 13/14] mm: memcg: put cgroup v1-related members of task_struct under config option
Date: Mon, 24 Jun 2024 17:59:05 -0700
Message-ID: <20240625005906.106920-14-roman.gushchin@linux.dev>
In-Reply-To: <20240625005906.106920-1-roman.gushchin@linux.dev>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Guard cgroup v1-related members of task_struct under the CONFIG_MEMCG_V1
config option, so that users who adopted cgroup v2 don't have to waste
the memory for fields which are never accessed.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  6 +++---
 init/Kconfig               |  9 +++++++++
 mm/Makefile                |  3 ++-
 mm/memcontrol-v1.h         | 21 ++++++++++++++++++++-
 mm/memcontrol.c            | 10 +++++++---
 5 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a70d64ed04f5..796cfa842346 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1851,7 +1851,7 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 
 /* Cgroup v1-related declarations */
 
-#ifdef CONFIG_MEMCG
+#ifdef CONFIG_MEMCG_V1
 unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
 					gfp_t gfp_mask,
 					unsigned long *total_scanned);
@@ -1883,7 +1883,7 @@ static inline void mem_cgroup_unlock_pages(void)
 	rcu_read_unlock();
 }
 
-#else /* CONFIG_MEMCG */
+#else /* CONFIG_MEMCG_V1 */
 static inline
 unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
 					gfp_t gfp_mask,
@@ -1922,6 +1922,6 @@ static inline bool mem_cgroup_oom_synchronize(bool wait)
 	return false;
 }
 
-#endif /* CONFIG_MEMCG */
+#endif /* CONFIG_MEMCG_V1 */
 
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/init/Kconfig b/init/Kconfig
index febdea2afc3b..5191b6435b4e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -969,6 +969,15 @@ config MEMCG
 	help
 	  Provides control over the memory footprint of tasks in a cgroup.
 
+config MEMCG_V1
+	bool "Legacy memory controller"
+	depends on MEMCG
+	default n
+	help
+	  Legacy cgroup v1 memory controller.
+
+	  San N is unsure.
+
 config MEMCG_KMEM
 	bool
 	depends on MEMCG
diff --git a/mm/Makefile b/mm/Makefile
index 124d4dea2035..d2915f8c9dc0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -96,7 +96,8 @@ obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
-obj-$(CONFIG_MEMCG) += memcontrol.o memcontrol-v1.o vmpressure.o
+obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
+obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
 obj-$(CONFIG_MEMCG) += swap_cgroup.o
 endif
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 89d420793048..64b053d7f131 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -75,7 +75,7 @@ unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
 /* Cgroup v1-specific declarations */
-
+#ifdef CONFIG_MEMCG_V1
 void memcg1_remove_from_trees(struct mem_cgroup *memcg);
 
 static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
@@ -110,4 +110,23 @@ void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 extern struct cftype memsw_files[];
 extern struct cftype mem_cgroup_legacy_files[];
 
+#else	/* CONFIG_MEMCG_V1 */
+
+static inline void memcg1_remove_from_trees(struct mem_cgroup *memcg) {}
+static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg) {}
+static inline bool memcg1_wait_acct_move(struct mem_cgroup *memcg) { return false; }
+static inline void memcg1_css_offline(struct mem_cgroup *memcg) {}
+
+static inline bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked) { return true; }
+static inline void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked) {}
+static inline void memcg1_oom_recover(struct mem_cgroup *memcg) {}
+
+static inline void memcg1_check_events(struct mem_cgroup *memcg, int nid) {}
+
+static inline void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s) {}
+
+extern struct cftype memsw_files[];
+extern struct cftype mem_cgroup_legacy_files[];
+#endif	/* CONFIG_MEMCG_V1 */
+
 #endif	/* __MM_MEMCONTROL_V1_H */
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c7341e811945..d2e1f8baeae8 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4471,18 +4471,20 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.css_free = mem_cgroup_css_free,
 	.css_reset = mem_cgroup_css_reset,
 	.css_rstat_flush = mem_cgroup_css_rstat_flush,
-	.can_attach = memcg1_can_attach,
 #if defined(CONFIG_LRU_GEN) || defined(CONFIG_MEMCG_KMEM)
 	.attach = mem_cgroup_attach,
 #endif
-	.cancel_attach = memcg1_cancel_attach,
-	.post_attach = memcg1_move_task,
 #ifdef CONFIG_MEMCG_KMEM
 	.fork = mem_cgroup_fork,
 	.exit = mem_cgroup_exit,
 #endif
 	.dfl_cftypes = memory_files,
+#ifdef CONFIG_MEMCG_V1
+	.can_attach = memcg1_can_attach,
+	.cancel_attach = memcg1_cancel_attach,
+	.post_attach = memcg1_move_task,
 	.legacy_cftypes = mem_cgroup_legacy_files,
+#endif
 	.early_init = 0,
 };
 
@@ -5653,7 +5655,9 @@ static int __init mem_cgroup_swap_init(void)
 		return 0;
 
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, swap_files));
+#ifdef CONFIG_MEMCG_V1
 	WARN_ON(cgroup_add_legacy_cftypes(&memory_cgrp_subsys, memsw_files));
+#endif
 #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
 	WARN_ON(cgroup_add_dfl_cftypes(&memory_cgrp_subsys, zswap_files));
 #endif
-- 
2.45.2


