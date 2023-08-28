Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4942478BB84
	for <lists+cgroups@lfdr.de>; Tue, 29 Aug 2023 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjH1Xdw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Aug 2023 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbjH1Xd1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Aug 2023 19:33:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FF512D
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 16:33:24 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-268476c3b2aso5425572a91.1
        for <cgroups@vger.kernel.org>; Mon, 28 Aug 2023 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693265604; x=1693870404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9qA6GTuqMP/rKfRIqhAnRSpZvROd0PfSA6OAmdp3iwc=;
        b=Y50mBPgL4ZnkSNZPluDfxqKm78sl1PPL8DiBaO19bDXgbRQJe1evxnOtKTQpEKaJt9
         q6TFZ3ydpr0Iw287D1OlWUwjUcpdUuXymoPCstZstIPkQOj45oKQlFtnKtjN/mbLEvhM
         o9GCuUO1ZEUXUUx28qzHrrmiTuYE2TYf6adAH5P9xxUWLusmQEIv/Oe70pHaiYbwOVfm
         oMqTZe5koJnHF0raIu3Xd3TXHK4UNZwUPvI/t+PGnq6Qn7V4/toAyK3UAB+IEgfCPW4e
         xQTid6or7KJCLcX0Z+QlSvZSxNkrkenRrCxd7dBhnnRCQKzILS7s/2q/I8bBvCq1Ofti
         cLVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265604; x=1693870404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qA6GTuqMP/rKfRIqhAnRSpZvROd0PfSA6OAmdp3iwc=;
        b=Nk5730QTgrw7Q9pM85UD8S/K6h1oSLAaWft0yMLZeAyQJy7CVQV90Kkjc86hKpADD1
         GbpNf6cyuDxNaz9BAG0fHOT9x0zyqwnZabu0Dktw/TvCsOduGbTB4geaEuQLhRTIPitF
         6I4WrWtGSrCmg8VY1mmu+l3htD/11nMBUxQM6RoPtNdoZW96jrFNW3hs9Lhsui1YItU4
         FAW8ROBv33X0Q+eqA67O3zVfOc4gWQvbMNSyistF8MHaOodI4YDmCp5nFNCZ+1n1Z+Ox
         goTQqRQw03sWQG3HF0SlVgUVYUQ7PyZIcwmrQ/yLuw0X3a6qCj161m5x+bXkJQOAEfzF
         NJzA==
X-Gm-Message-State: AOJu0YxK1NJBQj5G7rpgY+3EGAR1nWyC9pyMtLyLh/MWpgIpjyL8rUKY
        UqYAuIZnuyQsaykAo4HXkRshY3K5kcR4dqhM
X-Google-Smtp-Source: AGHT+IFAK9Y6dgVDrmbxac+NiYlaeGIY5ZOe1MFU0Kqd9mAZdB6yEnhkHBiWrdmzYBIlnQNCLJdURVSriZmVyWHy
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:408a:b0:26d:5ce:b77f with SMTP
 id l10-20020a17090a408a00b0026d05ceb77fmr272628pjg.1.1693265604159; Mon, 28
 Aug 2023 16:33:24 -0700 (PDT)
Date:   Mon, 28 Aug 2023 23:33:15 +0000
In-Reply-To: <20230828233319.340712-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230828233319.340712-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230828233319.340712-2-yosryahmed@google.com>
Subject: [PATCH v2 1/4] mm: memcg: properly name and document unified stats flushing
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 include/linux/memcontrol.h |  8 +++---
 mm/memcontrol.c            | 53 ++++++++++++++++++++++++++------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  4 +--
 4 files changed, 43 insertions(+), 24 deletions(-)

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
index cf57fe9318d5..c6150ea54d48 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -630,7 +630,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 		/*
 		 * If stats_flush_threshold exceeds the threshold
 		 * (>num_online_cpus()), cgroup stats update will be triggered
-		 * in __mem_cgroup_flush_stats(). Increasing this var further
+		 * in mem_cgroup_try_flush_stats(). Increasing this var further
 		 * is redundant and simply adds overhead in atomic update.
 		 */
 		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
@@ -639,13 +639,17 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
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
 	if (atomic_read(&stats_flush_ongoing) ||
 	    atomic_xchg(&stats_flush_ongoing, 1))
 		return;
@@ -658,16 +662,31 @@ static void do_flush_stats(void)
 	atomic_set(&stats_flush_ongoing, 0);
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

