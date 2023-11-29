Return-Path: <cgroups+bounces-667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD2D7FCD6C
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 04:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7364B1C21038
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 03:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22AB5667;
	Wed, 29 Nov 2023 03:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3a8C/86a"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758D1BCA
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:10 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db40b699d0fso7194785276.2
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701228130; x=1701832930; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oWg7ecS8tkDtiG8j3csNG9DywOjBZaeV4aEKsxpY4X4=;
        b=3a8C/86aGmX7wva/oHIC5RABl6eqyBs4oRc/adrnqjBRF+tRrlwf9C8eH+vTbfHvQf
         RBRBmgJadnqlL9dY0pjPxAuOWQncHnw6bK4muZgLddSJPyWMsPntwaTQ2046qL2VP2eL
         abzUUxgHQ2bScm0s5fD4otCIpEqMIWKF7XN5kh/8QNyGdiMkkT8GFDNFi4/MlxMEPM6t
         E47BOfi9F2VW/cNrejEHqngP76SMmfGimbnxX9qnMjvJKX4AZvHd+cqGUUiS7hExDJ86
         jpnaUswusGa/dm6nP+qskWFIrx58Ui+wIJjqb8LgFq/B+u38ha6h+7MwpUnSeAoLeKTg
         KAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228130; x=1701832930;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWg7ecS8tkDtiG8j3csNG9DywOjBZaeV4aEKsxpY4X4=;
        b=Wflpym92TSEmHtx+O7kWCz7MLG5P2clsBuiCj7JYjbBA8OQ5lz95ENFipGD2DYJUmr
         +4QWJmUj2Cp6a8bvKz2Ff5xNDCgeYyKmDh765CSzmvqAudbr/E3tCAkv+u4uZdOiBZc4
         HElBZE/z2mv6DQKpDlwMLXO/RnEkJTDG63GcD9xs+kZrq0VShLnUzvdN/tNcsPatUzAs
         3qTcis1rU4FirsPE39/jNvNpUh4IiZZg7diTfnvK9A9IFGfneI4uvInZ09dqAwN7pIAE
         EbcQJbKDTd71vfdiMUt25Th4o/UrVrKg3CXdJobu51tjmVA4gqtjWzSPMAxcZmv6vcUn
         X/3Q==
X-Gm-Message-State: AOJu0YyrkXQhARn0ghQ8/Is278klriXp/MR2kQsxd5s0ZKqJn0+j3+na
	iydFH6sXHfVnjmm3cDgB+cK2qKtz5UGlYsBd
X-Google-Smtp-Source: AGHT+IHkZzgEF3saSuZ8F4MVz1DNDW5QnvlvrCcYaR56TX+2LRE7uU69+zXwHvSxVqNELBuh7iHssPpF/A4H8k10
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:6f8b:0:b0:db3:f436:5714 with SMTP
 id k133-20020a256f8b000000b00db3f4365714mr586243ybc.0.1701228129872; Tue, 28
 Nov 2023 19:22:09 -0800 (PST)
Date: Wed, 29 Nov 2023 03:21:53 +0000
In-Reply-To: <20231129032154.3710765-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129032154.3710765-6-yosryahmed@google.com>
Subject: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

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
  actually flushed, yielding stale stats (by up to 2s due to periodic
  flushing). This is more visible when reading stats from userspace,
  but can also affect in-kernel flushers.

The latter problem is particulary a concern when userspace reads stats
after an event occurs, but gets stats from before the event. Examples:
- When memory usage / pressure spikes, a userspace OOM handler may look
  at the stats of different memcgs to select a victim based on various
  heuristics (e.g. how much private memory will be freed by killing
  this). Reading stale stats from before the usage spike in this case
  may cause a wrongful OOM kill.
- A proactive reclaimer may read the stats after writing to
  memory.reclaim to measure the success of the reclaim operation. Stale
  stats from before reclaim may give a false negative.
- Reading the stats of a parent and a child memcg may be inconsistent
  (child larger than parent), if the flush doesn't happen when the
  parent is read, but happens when the child is read.

As for in-kernel flushers, they will occasionally get stale stats. No
regressions are currently known from this, but if there are regressions,
they would be very difficult to debug and link to the source of the
problem.

This patch aims to fix these problems by restoring subtree flushing,
and removing the unified/coalesced flushing logic that skips flushing if
there is an ongoing flush. This change would introduce a significant
regression with global stats flushing thresholds. With per-memcg stats
flushing thresholds, this seems to perform really well. The thresholds
protect the underlying lock from unnecessary contention.

Add a mutex to protect the underlying rstat lock from excessive memcg
flushing. The thresholds are re-checked after the mutex is grabbed to
make sure that a concurrent flush did not already get the subtree we are
trying to flush. A call to cgroup_rstat_flush() is not cheap, even if
there are no pending updates.

This patch was tested in two ways to ensure the latency of flushing is
up to bar, on a machine with 384 cpus:
- A synthetic test with 5000 concurrent workers in 500 cgroups doing
  allocations and reclaim, as well as 1000 readers for memory.stat
  (variation of [2]). No regressions were noticed in the total runtime.
  Note that significant regressions in this test are observed with
  global stats thresholds, but not with per-memcg thresholds.

- A synthetic stress test for concurrently reading memcg stats while
  memory allocation/freeing workers are running in the background,
  provided by Wei Xu [3]. With 250k threads reading the stats every
  100ms in 50k cgroups, 99.9% of reads take <= 50us. Less than 0.01%
  of reads take more than 1ms, and no reads take more than 100ms.

[1] https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/
[2] https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CAAPL-u9D2b=iF5Lf_cRnKxUfkiEe0AMDTu6yhrUAzX0b6a6rDg@mail.gmail.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
---
 include/linux/memcontrol.h |  8 ++--
 mm/memcontrol.c            | 75 +++++++++++++++++++++++---------------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            | 10 +++--
 4 files changed, 58 insertions(+), 37 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index a568f70a26774..8673140683e6e 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1050,8 +1050,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
-void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_ratelimited(void);
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
+void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1566,11 +1566,11 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
-static inline void mem_cgroup_flush_stats(void)
+static inline void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
 }
 
-static inline void mem_cgroup_flush_stats_ratelimited(void)
+static inline void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 93b483b379aa1..5d300318bf18a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -670,7 +670,6 @@ struct memcg_vmstats {
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
 static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
@@ -731,35 +730,47 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(void)
+static void do_flush_stats(struct mem_cgroup *memcg)
 {
-	/*
-	 * We always flush the entire tree, so concurrent flushers can just
-	 * skip. This avoids a thundering herd problem on the rstat global lock
-	 * from memcg flushers (e.g. reclaim, refault, etc).
-	 */
-	if (atomic_read(&stats_flush_ongoing) ||
-	    atomic_xchg(&stats_flush_ongoing, 1))
-		return;
-
-	WRITE_ONCE(flush_last_time, jiffies_64);
-
-	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+	if (mem_cgroup_is_root(memcg))
+		WRITE_ONCE(flush_last_time, jiffies_64);
 
-	atomic_set(&stats_flush_ongoing, 0);
+	cgroup_rstat_flush(memcg->css.cgroup);
 }
 
-void mem_cgroup_flush_stats(void)
+/*
+ * mem_cgroup_flush_stats - flush the stats of a memory cgroup subtree
+ * @memcg: root of the subtree to flush
+ *
+ * Flushing is serialized by the underlying global rstat lock. There is also a
+ * minimum amount of work to be done even if there are no stat updates to flush.
+ * Hence, we only flush the stats if the updates delta exceeds a threshold. This
+ * avoids unnecessary work and contention on the underlying lock.
+ */
+void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
-	if (memcg_should_flush_stats(root_mem_cgroup))
-		do_flush_stats();
+	static DEFINE_MUTEX(memcg_stats_flush_mutex);
+
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	if (memcg_should_flush_stats(memcg)) {
+		mutex_lock(&memcg_stats_flush_mutex);
+		/* Check again after locking, another flush may have occurred */
+		if (memcg_should_flush_stats(memcg))
+			do_flush_stats(memcg);
+		mutex_unlock(&memcg_stats_flush_mutex);
+	}
 }
 
-void mem_cgroup_flush_stats_ratelimited(void)
+void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 	/* Only flush if the periodic flusher is one full cycle late */
 	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats(memcg);
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -768,7 +779,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore memcg_should_flush_stats() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
-	do_flush_stats();
+	do_flush_stats(root_mem_cgroup);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -1664,7 +1675,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4214,7 +4225,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4295,7 +4306,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -4791,7 +4802,7 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
@@ -6886,7 +6897,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
@@ -8125,7 +8136,11 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 			break;
 		}
 
-		cgroup_rstat_flush(memcg->css.cgroup);
+		/*
+		 * mem_cgroup_flush_stats() ignores small changes. Use
+		 * do_flush_stats() directly to get accurate stats for charging.
+		 */
+		do_flush_stats(memcg);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
@@ -8190,8 +8205,10 @@ void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size)
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
index d8c3338fee0fb..0b8a0107d58d8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2250,7 +2250,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats(sc->target_mem_cgroup);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/workingset.c b/mm/workingset.c
index dce41577a49d2..7d3dacab8451a 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -464,8 +464,12 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 
 	rcu_read_unlock();
 
-	/* Flush stats (and potentially sleep) outside the RCU read section */
-	mem_cgroup_flush_stats_ratelimited();
+	/*
+	 * Flush stats (and potentially sleep) outside the RCU read section.
+	 * XXX: With per-memcg flushing and thresholding, is ratelimiting
+	 * still needed here?
+	 */
+	mem_cgroup_flush_stats_ratelimited(eviction_memcg);
 
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
@@ -676,7 +680,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats(sc->memcg);
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
-- 
2.43.0.rc1.413.gea7ed67945-goog


