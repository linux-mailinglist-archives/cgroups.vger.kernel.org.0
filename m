Return-Path: <cgroups+bounces-3333-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BBF915B67
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 03:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2336283F08
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 01:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2E361FF7;
	Tue, 25 Jun 2024 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ISVeAmKN"
X-Original-To: cgroups@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0E447A6B
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277196; cv=none; b=GI9m6x01EdHJjp45Kdq/ScNXTe07Rd+qVdiVBCHqgowrI8i8hCy8UTSOGA6OGSAcOJqge1oGMYgVkHOZTFa5iaNXUddPi9ujmulzoKmyjQbsomsvNvtcAsiYkr5iMHMOjhZaFJa2ctW82gvC83xBhPRunpeUM8rXssJOHqMkszQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277196; c=relaxed/simple;
	bh=nwggAZ9PcePaaA5PdLPWy8RfmfcWf7B9WGkKueeHe1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ+H14a7b2kzQZSSvHOerEbPbVCCtKIgM/jmgNI+Wjv4owmWNCe5HA6TgpWgp44hlphQAaaw6HDmX21uMAWOTiP4aQ2YIsshw0INgvNsldvb2Jkf6LB0ueKFyva9nVjdy3khWDoYCAkbzcDQ5FibZGPK1e2bfNInwgX/dHo2q1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ISVeAmKN; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: akpm@linux-foundation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719277192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zJ3ODeZAUzmBmpS974GYslSkPfIUFwRZ/UoK6P7Hc/E=;
	b=ISVeAmKN40Ye3C2e8nOk/sLPBa9vn5C3IabRiHVDyM7fVcdHK4iwaSqjQTJhI4w7xXS49+
	TcCWJ2eM9yk2nhKW0+YUkPaWA+XyEtwmvHmLWK2fKGT31wVjvJohmZARjIB/joYkrMpIKJ
	rjUqnhP5spuFw+Z/tNtF8zHs3mgraZA=
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
Subject: [PATCH v2 12/14] mm: memcg: group cgroup v1 memcg related declarations
Date: Mon, 24 Jun 2024 17:59:04 -0700
Message-ID: <20240625005906.106920-13-roman.gushchin@linux.dev>
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

Group all cgroup v1-related declarations at the end of memcontrol.h
and mm/memcontrol-v1.h with an intention to put them all together
under a config option later on. It should make things easier to
follow and maintain too.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h | 144 +++++++++++++++++++------------------
 mm/memcontrol-v1.h         |  89 ++++++++++++-----------
 2 files changed, 123 insertions(+), 110 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 588179d29849..a70d64ed04f5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -950,39 +950,13 @@ static inline void mem_cgroup_exit_user_fault(void)
 	current->in_user_fault = 0;
 }
 
-static inline bool task_in_memcg_oom(struct task_struct *p)
-{
-	return p->memcg_in_oom;
-}
-
-bool mem_cgroup_oom_synchronize(bool wait);
 struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
 					    struct mem_cgroup *oom_domain);
 void mem_cgroup_print_oom_group(struct mem_cgroup *memcg);
 
-void folio_memcg_lock(struct folio *folio);
-void folio_memcg_unlock(struct folio *folio);
-
 void __mod_memcg_state(struct mem_cgroup *memcg, enum memcg_stat_item idx,
 		       int val);
 
-/* try to stablize folio_memcg() for all the pages in a memcg */
-static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
-{
-	rcu_read_lock();
-
-	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
-		return true;
-
-	rcu_read_unlock();
-	return false;
-}
-
-static inline void mem_cgroup_unlock_pages(void)
-{
-	rcu_read_unlock();
-}
-
 /* idx can be of type enum memcg_stat_item or node_stat_item */
 static inline void mod_memcg_state(struct mem_cgroup *memcg,
 				   enum memcg_stat_item idx, int val)
@@ -1109,10 +1083,6 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
 
 void split_page_memcg(struct page *head, int old_order, int new_order);
 
-unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					gfp_t gfp_mask,
-					unsigned long *total_scanned);
-
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1423,26 +1393,6 @@ mem_cgroup_print_oom_meminfo(struct mem_cgroup *memcg)
 {
 }
 
-static inline void folio_memcg_lock(struct folio *folio)
-{
-}
-
-static inline void folio_memcg_unlock(struct folio *folio)
-{
-}
-
-static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
-{
-	/* to match folio_memcg_rcu() */
-	rcu_read_lock();
-	return true;
-}
-
-static inline void mem_cgroup_unlock_pages(void)
-{
-	rcu_read_unlock();
-}
-
 static inline void mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
 }
@@ -1455,16 +1405,6 @@ static inline void mem_cgroup_exit_user_fault(void)
 {
 }
 
-static inline bool task_in_memcg_oom(struct task_struct *p)
-{
-	return false;
-}
-
-static inline bool mem_cgroup_oom_synchronize(bool wait)
-{
-	return false;
-}
-
 static inline struct mem_cgroup *mem_cgroup_get_oom_group(
 	struct task_struct *victim, struct mem_cgroup *oom_domain)
 {
@@ -1558,14 +1498,6 @@ void count_memcg_event_mm(struct mm_struct *mm, enum vm_event_item idx)
 static inline void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 }
-
-static inline
-unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
-					gfp_t gfp_mask,
-					unsigned long *total_scanned)
-{
-	return 0;
-}
 #endif /* CONFIG_MEMCG */
 
 /*
@@ -1916,4 +1848,80 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
 }
 #endif
 
+
+/* Cgroup v1-related declarations */
+
+#ifdef CONFIG_MEMCG
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned);
+
+bool mem_cgroup_oom_synchronize(bool wait);
+
+static inline bool task_in_memcg_oom(struct task_struct *p)
+{
+	return p->memcg_in_oom;
+}
+
+void folio_memcg_lock(struct folio *folio);
+void folio_memcg_unlock(struct folio *folio);
+
+/* try to stablize folio_memcg() for all the pages in a memcg */
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	rcu_read_lock();
+
+	if (mem_cgroup_disabled() || !atomic_read(&memcg->moving_account))
+		return true;
+
+	rcu_read_unlock();
+	return false;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
+#else /* CONFIG_MEMCG */
+static inline
+unsigned long memcg1_soft_limit_reclaim(pg_data_t *pgdat, int order,
+					gfp_t gfp_mask,
+					unsigned long *total_scanned)
+{
+	return 0;
+}
+
+static inline void folio_memcg_lock(struct folio *folio)
+{
+}
+
+static inline void folio_memcg_unlock(struct folio *folio)
+{
+}
+
+static inline bool mem_cgroup_trylock_pages(struct mem_cgroup *memcg)
+{
+	/* to match folio_memcg_rcu() */
+	rcu_read_lock();
+	return true;
+}
+
+static inline void mem_cgroup_unlock_pages(void)
+{
+	rcu_read_unlock();
+}
+
+static inline bool task_in_memcg_oom(struct task_struct *p)
+{
+	return false;
+}
+
+static inline bool mem_cgroup_oom_synchronize(bool wait)
+{
+	return false;
+}
+
+#endif /* CONFIG_MEMCG */
+
 #endif /* _LINUX_MEMCONTROL_H */
diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 7d6ac4a4fb36..89d420793048 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -5,15 +5,9 @@
 
 #include <linux/cgroup-defs.h>
 
-void memcg1_remove_from_trees(struct mem_cgroup *memcg);
-
-static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
-{
-	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
-}
+/* Cgroup v1 and v2 common declarations */
 
 void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages);
-void memcg1_check_events(struct mem_cgroup *memcg, int nid);
 int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		     unsigned int nr_pages);
 
@@ -29,30 +23,6 @@ static inline int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
 void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n);
 void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 
-bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
-struct cgroup_taskset;
-int memcg1_can_attach(struct cgroup_taskset *tset);
-void memcg1_cancel_attach(struct cgroup_taskset *tset);
-void memcg1_move_task(void);
-
-/*
- * Per memcg event counter is incremented at every pagein/pageout. With THP,
- * it will be incremented by the number of pages. This counter is used
- * to trigger some periodic events. This is straightforward and better
- * than using jiffies etc. to handle periodic memcg event.
- */
-enum mem_cgroup_events_target {
-	MEM_CGROUP_TARGET_THRESH,
-	MEM_CGROUP_TARGET_SOFTLIMIT,
-	MEM_CGROUP_NTARGETS,
-};
-
-/* Whether legacy memory+swap accounting is active */
-static bool do_memsw_account(void)
-{
-	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
-}
-
 /*
  * Iteration constructs for visiting all cgroups (under a tree).  If
  * loops are exited prematurely (break), mem_cgroup_iter_break() must
@@ -68,24 +38,28 @@ static bool do_memsw_account(void)
 	     iter != NULL;				\
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
-void memcg1_css_offline(struct mem_cgroup *memcg);
+/* Whether legacy memory+swap accounting is active */
+static bool do_memsw_account(void)
+{
+	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
+}
 
-/* for encoding cft->private value on file */
-enum res_type {
-	_MEM,
-	_MEMSWAP,
-	_KMEM,
-	_TCP,
+/*
+ * Per memcg event counter is incremented at every pagein/pageout. With THP,
+ * it will be incremented by the number of pages. This counter is used
+ * to trigger some periodic events. This is straightforward and better
+ * than using jiffies etc. to handle periodic memcg event.
+ */
+enum mem_cgroup_events_target {
+	MEM_CGROUP_TARGET_THRESH,
+	MEM_CGROUP_TARGET_SOFTLIMIT,
+	MEM_CGROUP_NTARGETS,
 };
 
 bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				enum mem_cgroup_events_target target);
 unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 
-bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
-void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
-void memcg1_oom_recover(struct mem_cgroup *memcg);
-
 void drain_all_stock(struct mem_cgroup *root_memcg);
 unsigned long mem_cgroup_nr_lru_pages(struct mem_cgroup *memcg,
 				      unsigned int lru_mask, bool tree);
@@ -100,6 +74,37 @@ unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 int memory_stat_show(struct seq_file *m, void *v);
 
+/* Cgroup v1-specific declarations */
+
+void memcg1_remove_from_trees(struct mem_cgroup *memcg);
+
+static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
+{
+	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
+}
+
+bool memcg1_wait_acct_move(struct mem_cgroup *memcg);
+
+struct cgroup_taskset;
+int memcg1_can_attach(struct cgroup_taskset *tset);
+void memcg1_cancel_attach(struct cgroup_taskset *tset);
+void memcg1_move_task(void);
+void memcg1_css_offline(struct mem_cgroup *memcg);
+
+/* for encoding cft->private value on file */
+enum res_type {
+	_MEM,
+	_MEMSWAP,
+	_KMEM,
+	_TCP,
+};
+
+bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
+void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
+void memcg1_oom_recover(struct mem_cgroup *memcg);
+
+void memcg1_check_events(struct mem_cgroup *memcg, int nid);
+
 void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s);
 
 extern struct cftype memsw_files[];
-- 
2.45.2


