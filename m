Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D278F17E
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 18:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345223AbjHaQ4V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbjHaQ4U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 12:56:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D502EA3
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d78406dee59so889925276.0
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500976; x=1694105776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6NYJxZAD84nnU9JwFvW1AuIl8sWdu9iyZk6Te6FK6mM=;
        b=f5TwrrLQVQs8pMXqHmkmqQkVPc2MaEyjgy+aX+kJvW7rT4Dg5q6prhCC8QSp8VmIHq
         6HuE16PwcsqhVPr+QHJox7XQSenFriFl9iDzEbeNpbMTTIUpDTzElm1z5cuU7QJ1vjHi
         aP0Ld+RtBjX1/IIC8jsoYLrp/Yes09qLNKn4BNi3qsfjD+GSXS2gbrsJC4nPyGUD33b7
         8qyX1iym3qrmJZndu7UfZmKGk8UB4aYV+/KEuuCIUBL640wpuf/Ufr4ldVVqj/ElJe/d
         mldKigLldK1EyzfJ7ObQkwCs8w/dbgPfFIFwVoB7qOl7caFMUkGvJgmUTYN1k8XHEE1K
         U3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500976; x=1694105776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NYJxZAD84nnU9JwFvW1AuIl8sWdu9iyZk6Te6FK6mM=;
        b=MSifX+EyLnv+oVuMGzYj05Lb+b+HCaxMbkNFANUe2GYQVh4AQMjkJOeEmpYBxnf+Hz
         KlUz8+29FI29PxqeM6H0c2NQ2Y6CMWn9jULYpf5ANeQttK6/tzdqQlPOaEsuncLFWsRj
         8zRV8zFhbeHZi+sraIauv2QxlRp+g6BRKDLviT9hRwFXBX6F8CBIAbhDds76GFcS815E
         w/NfPeXUhFAS1cJ2SV8xuhlc+cxjjT2gE54AI4hyG1+h4Tq/RlDdFCezBRBwYZbBj2vw
         SM2OKoH4ig0KsGQit9Cx8TyzoidfzyVOnyih9XMejojGoF9e94AQ52rl3SfFiVJ/lplC
         PyyQ==
X-Gm-Message-State: AOJu0Yyk8j2e3C/cZd7ssxQeFXKdWBgbg5hC3h1ez69WD1N79cOMpuBa
        Y2SbqzM/YClkKIGesgnKX+FidpPpz0QR0ss7
X-Google-Smtp-Source: AGHT+IG+OUEj8IqQB30ouOiPIGWocFJhxTzlAMy3JDUj6cQD4hmj7r5Edc+cYhwbUNs50K1U4Cy6rv2ZeUvHgJsN
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a5b:d4a:0:b0:d73:bcb7:7282 with SMTP id
 f10-20020a5b0d4a000000b00d73bcb77282mr7521ybr.8.1693500976143; Thu, 31 Aug
 2023 09:56:16 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:56:08 +0000
In-Reply-To: <20230831165611.2610118-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831165611.2610118-2-yosryahmed@google.com>
Subject: [PATCH v4 1/4] mm: memcg: properly name and document unified stats flushing
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Most contexts that flush memcg stats use "unified" flushing, where
basically all flushers attempt to flush the entire hierarchy, but only
one flusher is allowed at a time, others skip flushing.

This is needed because we need to flush the stats from paths such as
reclaim or refaults, which may have high concurrency, especially on
large systems. Serializing such performance-sensitive paths can
introduce regressions, hence, unified flushing offers a tradeoff between
stats staleness and the performance impact of flushing stats.

Document this properly and explicitly by renaming the common flushing
helper from do_flush_stats() to do_unified_stats_flush(), and adding
documentation to describe unified flushing. Additionally, rename
flushing APIs to add "try" in the name, which implies that flushing will
not always happen. Also add proper documentation.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  8 ++---
 mm/memcontrol.c            | 61 +++++++++++++++++++++++++-------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  4 +--
 4 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 11810a2cfd2d..d517b0cc5221 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1034,8 +1034,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_ratelimited(void);
+void mem_cgroup_try_flush_stats(void);
+void mem_cgroup_try_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1519,11 +1519,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
-static inline void mem_cgroup_flush_stats(void)
+static inline void mem_cgroup_try_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_ratelimited(void)
+static inline void mem_cgroup_try_flush_stats_ratelimited(void)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cf57fe9318d5..2d0ec828a1c4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -588,7 +588,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
-static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
+static atomic_t stats_unified_flush_ongoing = ATOMIC_INIT(0);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 static u64 flush_next_time;
 
@@ -630,7 +630,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 		/*
 		 * If stats_flush_threshold exceeds the threshold
 		 * (>num_online_cpus()), cgroup stats update will be triggered
-		 * in __mem_cgroup_flush_stats(). Increasing this var further
+		 * in mem_cgroup_try_flush_stats(). Increasing this var further
 		 * is redundant and simply adds overhead in atomic update.
 		 */
 		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
@@ -639,15 +639,19 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(void)
+/*
+ * do_unified_stats_flush - do a unified flush of memory cgroup statistics
+ *
+ * A unified flush tries to flush the entire hierarchy, but skips if there is
+ * another ongoing flush. This is meant for flushers that may have a lot of
+ * concurrency (e.g. reclaim, refault, etc), and should not be serialized to
+ * avoid slowing down performance-sensitive paths. A unified flush may skip, and
+ * hence may yield stale stats.
+ */
+static void do_unified_stats_flush(void)
 {
-	/*
-	 * We always flush the entire tree, so concurrent flushers can just
-	 * skip. This avoids a thundering herd problem on the rstat global lock
-	 * from memcg flushers (e.g. reclaim, refault, etc).
-	 */
-	if (atomic_read(&stats_flush_ongoing) ||
-	    atomic_xchg(&stats_flush_ongoing, 1))
+	if (atomic_read(&stats_unified_flush_ongoing) ||
+	    atomic_xchg(&stats_unified_flush_ongoing, 1))
 		return;
 
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
@@ -655,19 +659,34 @@ static void do_flush_stats(void)
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
 	atomic_set(&stats_flush_threshold, 0);
-	atomic_set(&stats_flush_ongoing, 0);
+	atomic_set(&stats_unified_flush_ongoing, 0);
 }
 
-void mem_cgroup_flush_stats(void)
+/*
+ * mem_cgroup_try_flush_stats - try to flush memory cgroup statistics
+ *
+ * Try to flush the stats of all memcgs that have stat updates since the last
+ * flush. We do not flush the stats if:
+ * - The magnitude of the pending updates is below a certain threshold.
+ * - There is another ongoing unified flush (see do_unified_stats_flush()).
+ *
+ * Hence, the stats may be stale, but ideally by less than FLUSH_TIME due to
+ * periodic flushing.
+ */
+void mem_cgroup_try_flush_stats(void)
 {
 	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
-		do_flush_stats();
+		do_unified_stats_flush();
 }
 
-void mem_cgroup_flush_stats_ratelimited(void)
+/*
+ * Like mem_cgroup_try_flush_stats(), but only flushes if the periodic flusher
+ * is late.
+ */
+void mem_cgroup_try_flush_stats_ratelimited(void)
 {
 	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
-		mem_cgroup_flush_stats();
+		mem_cgroup_try_flush_stats();
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -676,7 +695,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Always flush here so that flushing in latency-sensitive paths is
 	 * as cheap as possible.
 	 */
-	do_flush_stats();
+	do_unified_stats_flush();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -1576,7 +1595,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4018,7 +4037,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4093,7 +4112,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4595,7 +4614,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -6610,7 +6629,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c7c149cb8d66..457a18921fda 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2923,7 +2923,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_try_flush_stats();
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..affb8699e58d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -520,7 +520,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 	}
 
 	/* Flush stats (and potentially sleep) before holding RCU read lock */
-	mem_cgroup_flush_stats_ratelimited();
+	mem_cgroup_try_flush_stats_ratelimited();
 
 	rcu_read_lock();
 
@@ -664,7 +664,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
-		mem_cgroup_flush_stats();
+		mem_cgroup_try_flush_stats();
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

