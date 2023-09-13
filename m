Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2121D79E0FA
	for <lists+cgroups@lfdr.de>; Wed, 13 Sep 2023 09:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjIMHjB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Sep 2023 03:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238612AbjIMHjA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Sep 2023 03:39:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62301984
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:38:56 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563ab574cb5so7103319a12.1
        for <cgroups@vger.kernel.org>; Wed, 13 Sep 2023 00:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694590736; x=1695195536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8wFSE4R6tL7pv8rA6Rke9m26hzyRIxknt8a2PL5Y0/4=;
        b=zvqGHrsYQLEWdL37E9GhBc1pvdSBzBKYoeDJst6KnjmRVf4xPPtLS2Qa1ZgSB3T1Ki
         C3l+iUWBbdRdyLGvvaUARoVBLQ4IG+xZT4ePLCeFsm9NGaJ0Aq7V8mHw1TTb4s4awXEx
         q/fdeHRGshjwXc/mV6kgZfbmMdcs5Mz+jwV5xpVoD8E391x5coZdQ/6Rs2fy2+isLa3K
         B2SuX+nQGDc3eGkM+8fOhxu3wpO0HumijHxGKhXTO2VQ56hgTesnU4eL41VbDKrgWlGa
         7H553DTeEndbpr2uVT9EcQbzA0mg1ufjBDC1xNWL8GWINXP9bl8vRMAwTnUgGgWP2AbP
         EbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694590736; x=1695195536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wFSE4R6tL7pv8rA6Rke9m26hzyRIxknt8a2PL5Y0/4=;
        b=KN81dpq7oql2zKcRn+lVjPBOup3Q1eDK3VkciEAdG0zYkSgqTE+wrnhp3shP5gJczp
         +97EgzoDGsVepEsB23jDq71I84fuhgZCI7qcpXom9EnZaArOfqJHdKU/t6cAkaicbbeB
         QAjJ99/E5NU0ajpTsPOWg5Dw6l/m90S+U8UqX2jh7+KsP7mMQdEVOoEm71wC7ufJKGfx
         whYS5NyzMhXH2JC5XJYG0ISOcz9E6Dg5kl6Wi13sMK4weh5/8bO6Wnd8M0U4aOFNxnnU
         Ixymf3f5yJHKHVtPfwN6nAqz6sB0Ob9PyqAorzQ2/aUuKwgZfWjgrPN8VVVaii6u0RQ4
         NCEg==
X-Gm-Message-State: AOJu0YxzIXera7ItMCkf7+LrR7PBuYNTpnFyc7naNP3ElMDBsHU/NL5w
        sD52vbN2T8893093wUs1QiDGF81OWF/c63m9
X-Google-Smtp-Source: AGHT+IH7x+NeMXFHRZHoocEmERPyLyLuDI56svfvzejgbaWkciesmXJkInMLMzn2vBpTjTv7kSbwSzaXeRtqWs08
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a63:8c4b:0:b0:577:b70e:56b5 with SMTP
 id q11-20020a638c4b000000b00577b70e56b5mr38740pgn.5.1694590736054; Wed, 13
 Sep 2023 00:38:56 -0700 (PDT)
Date:   Wed, 13 Sep 2023 07:38:46 +0000
In-Reply-To: <20230913073846.1528938-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230913073846.1528938-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230913073846.1528938-4-yosryahmed@google.com>
Subject: [PATCH 3/3] mm: memcg: optimize stats flushing for latency and accuracy
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Stats flushing for memcg currently follows the following rules:
- Always flush the entire memcg hierarchy (i.e. flush the root).
- Only one flusher is allowed at a time. If someone else tries to flush
  concurrently, they skip and return immediately.
- A periodic flusher flushes all the stats every 2 seconds.

The reason this approach is followed is because all flushes are
serialized by a global rstat spinlock. On the memcg side, flushing is
invoked from userspace reads as well as in-kernel flushers (e.g.
reclaim, refault, etc). This approach aims to avoid serializing all
flushers on the global lock, which can cause a significant performance
hit under high concurrency.

This approach has the following problems:
- Occasionally a userspace read of the stats of a non-root cgroup will
  be too expensive as it has to flush the entire hierarchy [1].
- Sometimes the stats accuracy are compromised if there is an ongoing
  flush, and we skip and return before the subtree of interest is
  actually flushed. This is more visible when reading stats from
  userspace, but can also affect in-kernel flushers.

This patch aims to solve both problems by reworking how flushing
currently works as follows:
- Without contention, there is no need to flush the entire tree. In this
  case, only flush the subtree of interest. This avoids the latency of a
  full root flush if unnecessary.
- With contention, fallback to a coalesced (aka unified) flush of the
  entire hierarchy, a root flush. In this case, instead of returning
  immediately if a root flush is ongoing, wait for it to finish
  *without* attempting to acquire the lock or flush. This is done using
  a completion. Compared to competing directly on the underlying lock,
  this approach makes concurrent flushing a synchronization point
  instead of a serialization point. Once  a root flush finishes, *all*
  waiters can wake up and continue at once.
- Finally, with very high contention, bound the number of waiters to the
  number of online cpus. This keeps the flush latency bounded at the tail
  (very high concurrency). We fallback to sacrificing stats freshness only
  in such cases in favor of performance.

This was tested in two ways on a machine with 384 cpus:
- A synthetic test with 5000 concurrent workers doing allocations and
  reclaim, as well as 1000 readers for memory.stat (variation of [2]).
  No significant regressions were noticed in the total runtime.
  Note that if concurrent flushers compete directly on the spinlock
  instead of waiting for a completion, this test shows 2x-3x slowdowns.
  Even though subsequent flushers would have nothing to flush, just the
  serialization and lock contention is a major problem. Using a
  completion for synchronization instead seems to overcome this problem.

- A synthetic stress test for concurrently reading memcg stats provided
  by Wei Xu.
  With 10k threads reading the stats every 100ms:
  - 98.8% of reads take <100us
  - 1.09% of reads take 100us to 1ms.
  - 0.11% of reads take 1ms to 10ms.
  - Almost no reads take more than 10ms.
  With 10k threads reading the stats every 10ms:
  - 82.3% of reads take <100us.
  - 4.2% of reads take 100us to 1ms.
  - 4.7% of reads take 1ms to 10ms.
  - 8.8% of reads take 10ms to 100ms.
  - Almost no reads take more than 100ms.

[1] https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com/

[weixugc@google.com: suggested the fallback logic and bounding the
number of waiters]

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |   4 +-
 mm/memcontrol.c            | 100 ++++++++++++++++++++++++++++---------
 mm/vmscan.c                |   2 +-
 mm/workingset.c            |   8 ++-
 4 files changed, 85 insertions(+), 29 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 11810a2cfd2d..4453cd3fc4b8 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1034,7 +1034,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-void mem_cgroup_flush_stats(void);
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
@@ -1519,7 +1519,7 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
-static inline void mem_cgroup_flush_stats(void)
+static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d729870505f1..edff41e4b4e7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -588,7 +588,6 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
-static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 /* stats_updates_order is in multiples of MEMCG_CHARGE_BATCH */
 static atomic_t stats_updates_order = ATOMIC_INIT(0);
 static u64 flush_last_time;
@@ -639,36 +638,87 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(void)
+/*
+ * do_flush_stats - flush the statistics of a memory cgroup and its tree
+ * @memcg: the memory cgroup to flush
+ * @wait: wait for an ongoing root flush to complete before returning
+ *
+ * All flushes are serialized by the underlying rstat global lock. If there is
+ * no contention, we try to only flush the subtree of the passed @memcg to
+ * minimize the work. Otherwise, we coalesce multiple flushing requests into a
+ * single flush of the root memcg. When there is an ongoing root flush, we wait
+ * for its completion (unless otherwise requested), to get fresh stats. If the
+ * number of waiters exceeds the number of cpus just skip the flush to bound the
+ * flush latency at the tail with very high concurrency.
+ *
+ * This is a trade-off between stats accuracy and flush latency.
+ */
+static void do_flush_stats(struct mem_cgroup *memcg, bool wait)
 {
+	static DECLARE_COMPLETION(root_flush_done);
+	static DEFINE_SPINLOCK(root_flusher_lock);
+	static DEFINE_MUTEX(subtree_flush_mutex);
+	static atomic_t waiters = ATOMIC_INIT(0);
+	static bool root_flush_ongoing;
+	bool root_flusher = false;
+
+	/* Ongoing root flush, just wait for it (unless otherwise requested) */
+	if (READ_ONCE(root_flush_ongoing))
+		goto root_flush_or_wait;
+
 	/*
-	 * We always flush the entire tree, so concurrent flushers can just
-	 * skip. This avoids a thundering herd problem on the rstat global lock
-	 * from memcg flushers (e.g. reclaim, refault, etc).
+	 * Opportunistically try to only flush the requested subtree. Otherwise
+	 * fallback to a coalesced flush below.
 	 */
-	if (atomic_read(&stats_flush_ongoing) ||
-	    atomic_xchg(&stats_flush_ongoing, 1))
+	if (!mem_cgroup_is_root(memcg) && mutex_trylock(&subtree_flush_mutex)) {
+		cgroup_rstat_flush(memcg->css.cgroup);
+		mutex_unlock(&subtree_flush_mutex);
 		return;
+	}
 
-	WRITE_ONCE(flush_last_time, jiffies_64);
-
-	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	/* A coalesced root flush is in order. Are we the designated flusher? */
+	spin_lock(&root_flusher_lock);
+	if (!READ_ONCE(root_flush_ongoing)) {
+		reinit_completion(&root_flush_done);
+		/*
+		 * We must reset the completion before setting
+		 * root_flush_ongoing. Otherwise, waiters may call
+		 * wait_for_completion() and immediately return before we flush.
+		 */
+		smp_wmb();
+		WRITE_ONCE(root_flush_ongoing, true);
+		root_flusher = true;
+	}
+	spin_unlock(&root_flusher_lock);
 
-	atomic_set(&stats_updates_order, 0);
-	atomic_set(&stats_flush_ongoing, 0);
+root_flush_or_wait:
+	if (root_flusher) {
+		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+		complete_all(&root_flush_done);
+		atomic_set(&stats_updates_order, 0);
+		WRITE_ONCE(flush_last_time, jiffies_64);
+		WRITE_ONCE(root_flush_ongoing, false);
+	} else if (wait && atomic_add_unless(&waiters, 1, num_online_cpus())) {
+		smp_rmb(); /* see smp_wmb() above */
+		wait_for_completion_interruptible(&root_flush_done);
+		atomic_dec(&waiters);
+	}
 }
 
-void mem_cgroup_flush_stats(void)
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
 	if (atomic_read(&stats_updates_order) > STATS_FLUSH_THRESHOLD)
-		do_flush_stats();
+		do_flush_stats(memcg, true);
 }
 
 void mem_cgroup_flush_stats_ratelimited(void)
 {
 	/* Only flush if the periodic flusher is one full cycle late */
 	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats(root_mem_cgroup);
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -677,7 +727,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore stats_updates_order here so that flushing in
 	 * latency-sensitive paths is as cheap as possible.
 	 */
-	do_flush_stats();
+	do_flush_stats(root_mem_cgroup, false);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -1577,7 +1627,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4019,7 +4069,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4094,7 +4144,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4596,7 +4646,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -6606,7 +6656,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
@@ -7764,7 +7814,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		cgroup_rstat_flush(memcg->css.cgroup);
+		mem_cgroup_flush_stats(memcg);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
@@ -7829,8 +7879,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
 static u64 zswap_current_read(struct cgroup_subsys_state *css,
 			      struct cftype *cft)
 {
-	cgroup_rstat_flush(css->cgroup);
-	return memcg_page_state(mem_cgroup_from_css(css), MEMCG_ZSWAP_B);
+	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
+
+	mem_cgroup_flush_stats(memcg);
+	return memcg_page_state(memcg, MEMCG_ZSWAP_B);
 }
 
 static int zswap_max_show(struct seq_file *m, void *v)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6f13394b112e..fc356b9bc003 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2923,7 +2923,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(sc->target_mem_cgroup);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/workingset.c b/mm/workingset.c
index da58a26d0d4d..13cbccf907f1 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -519,7 +519,11 @@ void workingset_refault(struct folio *folio, void *shadow)
 		return;
 	}
 
-	/* Flush stats (and potentially sleep) before holding RCU read lock */
+	/*
+	 * Flush stats (and potentially sleep) before holding RCU read lock
+	 * XXX: This can be reworked to pass in a memcg, similar to
+	 * mem_cgroup_flush_stats().
+	 */
 	mem_cgroup_flush_stats_ratelimited();
 
 	rcu_read_lock();
@@ -664,7 +668,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats(sc->memcg);
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
-- 
2.42.0.283.g2d96d420d3-goog

