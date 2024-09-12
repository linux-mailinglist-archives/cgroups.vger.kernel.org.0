Return-Path: <cgroups+bounces-4863-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA0976F46
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 19:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2FA1C23AD8
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 17:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C11BF7E0;
	Thu, 12 Sep 2024 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgLaFnB1"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8C1BD002;
	Thu, 12 Sep 2024 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160840; cv=none; b=cnieQmGouL8AFV0RoTuxannvqcEYHYZLgi0apfv0mtn43MiflArvq2rRLXbwUQ//47r0ZSSNQ3njMeC/7SW+tO/Mb/fm78jPT3pYX3MIMeQFeHzwE3Plkc9OjPrNtkQZSEDFDjTs8fDxCoJueif5KGJt9f4VFo1Rw0PeEJ5gadw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160840; c=relaxed/simple;
	bh=KfNRQc93TEGAaXFVAF2BmMspYXFWrd4w0+3BoJcUMg4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=MWTHfk+xJggv0iGSytoIBMWSPalWD3aCDge+ik29cEcDcLmLezqHeKt5hFlmQSAT/ueGDUYn4i8aUWWPgMTEtf9ppnFlSfz3h4GHO75DawDdmnJnJ2GM1bZF5pJKoJiZouxgPGERtrBLHdUfQHV5bspHbTg8eJX1kOb0rN1Z2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgLaFnB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD3DC4CEC3;
	Thu, 12 Sep 2024 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726160839;
	bh=KfNRQc93TEGAaXFVAF2BmMspYXFWrd4w0+3BoJcUMg4=;
	h=Subject:From:To:Cc:Date:From;
	b=DgLaFnB17ltCkzgBofaUE6aO0k9SUTr3zeYW87Q0EktlJALh+TYoIaIxoFZFLrG4h
	 JdoNS2KmvNUme5kdWyhpruPwdpnYainy5jXu/e5bNF7/mip/JRo8rchtsgfQN8L3dA
	 fQmrGjEjO8vU/CaLd42xXuQ/S1NKvyUKgNgKqIRHT3t9xwxoT2ybQW1vZTkUUFsdhd
	 0SQsWSGlaHYoMyzA2XlbiDTrGBtXKK+2XRcqpSOhFt2uKoWDXM9ZHqUfuk/VzK2GaX
	 UnJuUt5IphTR6PahU/D1pVKQZKKvWcEWbe4b9mJ0nZLLPHl9HqxVkIHXhhEO4UBSa+
	 smg+chNyE1FNw==
Subject: [PATCH V11] cgroup/rstat: Avoid flushing if there is an ongoing root
 flush
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: tj@kernel.org, cgroups@vger.kernel.org, yosryahmed@google.com,
 shakeel.butt@linux.dev
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, hannes@cmpxchg.org,
 lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 12 Sep 2024 19:07:15 +0200
Message-ID: <172616070094.2055617.17676042522679701515.stgit@firesoul>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This patch reintroduces and generalizes the "stats_flush_ongoing" concept
to avoid redundant flushes if there is an ongoing flush at cgroup root
level, addressing production lock contention issues on the global cgroup
rstat lock.

In this revision userspace readers will wait for the ongoing flusher to
complete before returning, to avoid reading out-dated stats just before
they get updated. Generally in-kernel users will attempt to skip the
flush in-order to get out of the lock contention state. Some in-kernel
users of the cgroup_rstat_flush() API depend on waiting for the flush to
complete before continuing. This patch introduce the call
cgroup_rstat_flush_relaxed() with a wait_for_flush option to satisfy both
use-cases.

At Cloudflare, we observed significant performance degradation due to
lock contention on the rstat lock, primarily caused by kswapd. The
specific mem_cgroup_flush_stats() call inlined in shrink_node, which
takes the rstat lock, is particularly problematic.

On our 12 NUMA node machines, each with a kswapd kthread per NUMA node, we
noted severe lock contention on the rstat lock, causing 12 CPUs to waste
cycles spinning every time kswapd runs. Fleet-wide stats (/proc/N/schedstat)
for kthreads revealed that we are burning an average of 20,000 CPU cores
fleet-wide on kswapd, primarily due to spinning on the rstat lock.

Here's a brief overview of the issue:
- __alloc_pages_slowpath calls wake_all_kswapds, causing all kswapdN threads
  to wake up simultaneously.
- The kswapd thread invokes shrink_node (via balance_pgdat), triggering the
  cgroup rstat flush operation as part of its work.
- balance_pgdat() has a NULL value in target_mem_cgroup, causing
  mem_cgroup_flush_stats() to flush with root_mem_cgroup.

The kernel previously addressed this with a "stats_flush_ongoing" concept,
which was removed in commit 7d7ef0a4686a ("mm: memcg: restore subtree stats
flushing"). This patch reintroduces and generalizes the concept to apply to
all users of cgroup rstat, not just memcg.

It have been a general theme to replace mem_cgroup_flush_stats() with
mem_cgroup_flush_stats_ratelimited every time we see a new case of this
issue. This will hide the contention issue until something starves the
kthread that does the periodic 2 second flush (for 2 periods). In
production we are seeing kthreads getting starved longer than 20 seconds.
This often happens in connection with OOM killer. This recreates the
kswapd lock contention situation at a very unfortunate point in time.
Thus, it makes sense to have this ongoing flusher lock contention
protection in place.

In this patch only a root cgroup can become the ongoing flusher, as this solves
the production issue. Letting other levels becoming ongoing flusher cause root
cgroup to contend on the lock again.

This change significantly reduces lock contention, especially in
environments with multiple NUMA nodes, thereby improving overall system
performance.

Fixes: 7d7ef0a4686a ("mm: memcg: restore subtree stats flushing").
Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
---
v11:
 - Address Yosry request to wait-for-flush for userspace readers

V10: https://lore.kernel.org/all/172547884995.206112.808619042206173396.stgit@firesoul/

 block/blk-cgroup.c         |    2 -
 include/linux/cgroup.h     |    1 
 include/linux/memcontrol.h |    1 
 kernel/cgroup/rstat.c      |  133 ++++++++++++++++++++++++++++++++++++++++++--
 mm/memcontrol.c            |   40 +++++++++----
 mm/vmscan.c                |    2 -
 mm/zswap.c                 |    2 -
 7 files changed, 157 insertions(+), 24 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 37e6cc91d576..058393e7665a 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1200,7 +1200,7 @@ static int blkcg_print_stat(struct seq_file *sf, void *v)
 	if (!seq_css(sf)->parent)
 		blkcg_fill_root_iostats();
 	else
-		cgroup_rstat_flush(blkcg->css.cgroup);
+		cgroup_rstat_flush_relaxed(blkcg->css.cgroup, true);
 
 	rcu_read_lock();
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 2150ca60394b..ff65bc100ca5 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -691,6 +691,7 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
 void cgroup_rstat_flush(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
 void cgroup_rstat_flush_release(struct cgroup *cgrp);
+int cgroup_rstat_flush_relaxed(struct cgroup *cgrp, bool wait_for_flush);
 
 /*
  * Basic resource stats.
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 030d34e9d117..7e24c5e1327f 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1026,6 +1026,7 @@ unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 				      enum node_stat_item idx);
 
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg);
+void mem_cgroup_flush_stats_relaxed(struct mem_cgroup *memcg);
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg);
 
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index a06b45272411..80a4b949138f 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -11,6 +11,9 @@
 
 static DEFINE_SPINLOCK(cgroup_rstat_lock);
 static DEFINE_PER_CPU(raw_spinlock_t, cgroup_rstat_cpu_lock);
+static struct cgroup *cgrp_rstat_ongoing_flusher = NULL;
+static struct task_struct *cgrp_rstat_ongoing_flusher_ID = NULL;
+static DEFINE_MUTEX(cgrp_rstat_ongoing_flusher_serialize);
 
 static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu);
 
@@ -299,6 +302,68 @@ static inline void __cgroup_rstat_unlock(struct cgroup *cgrp, int cpu_in_loop)
 	spin_unlock_irq(&cgroup_rstat_lock);
 }
 
+static inline bool cgroup_is_root(struct cgroup *cgrp)
+{
+	return cgroup_parent(cgrp) == NULL;
+}
+
+/**
+ * cgroup_rstat_trylock_flusher - Trylock that checks for on ongoing flusher
+ * @cgrp: target cgroup
+ * @strict: always lock and ignore/skip ongoing flusher checks
+ *
+ * Function return value follow trylock semantics. Returning true when lock is
+ * obtained. Returning false when not locked and it detected flushing can be
+ * skipped as another ongoing flusher is taking care of the flush.
+ *
+ * For callers that depend on flush completing before returning a strict option
+ * is provided.
+ */
+static bool cgroup_rstat_trylock_flusher(struct cgroup *cgrp, bool strict)
+{
+	struct cgroup *ongoing;
+
+	if (strict)
+		goto lock;
+
+	/*
+	 * Check if ongoing flusher is already taking care of this.  Descendant
+	 * check is necessary due to cgroup v1 supporting multiple root's.
+	 */
+	ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
+	if (ongoing && cgroup_is_descendant(cgrp, ongoing))
+		return false;
+
+	/* Grab right to be ongoing flusher */
+	if (!ongoing && cgroup_is_root(cgrp)) {
+		struct cgroup *old;
+
+		old = cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
+		if (old) {
+			/* Lost race for being ongoing flusher */
+			if (cgroup_is_descendant(cgrp, old))
+				return false;
+		}
+		/* Due to lock yield combined with strict mode record ID */
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);
+	}
+lock:
+	__cgroup_rstat_lock(cgrp, -1);
+
+	return true;
+}
+
+static void cgroup_rstat_unlock_flusher(struct cgroup *cgrp)
+{
+	if (cgrp == READ_ONCE(cgrp_rstat_ongoing_flusher) &&
+	    READ_ONCE(cgrp_rstat_ongoing_flusher_ID) == current) {
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, NULL);
+		WRITE_ONCE(cgrp_rstat_ongoing_flusher, NULL);
+	}
+
+	__cgroup_rstat_unlock(cgrp, -1);
+}
+
 /* see cgroup_rstat_flush() */
 static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock) __acquires(&cgroup_rstat_lock)
@@ -333,6 +398,19 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
 	}
 }
 
+static int __cgroup_rstat_flush(struct cgroup *cgrp, bool strict)
+{
+	might_sleep();
+
+	if (!cgroup_rstat_trylock_flusher(cgrp, strict))
+		return false;
+
+	cgroup_rstat_flush_locked(cgrp);
+	cgroup_rstat_unlock_flusher(cgrp);
+
+	return true;
+}
+
 /**
  * cgroup_rstat_flush - flush stats in @cgrp's subtree
  * @cgrp: target cgroup
@@ -348,11 +426,49 @@ static void cgroup_rstat_flush_locked(struct cgroup *cgrp)
  */
 __bpf_kfunc void cgroup_rstat_flush(struct cgroup *cgrp)
 {
-	might_sleep();
+	__cgroup_rstat_flush(cgrp, true);
+}
 
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
-	__cgroup_rstat_unlock(cgrp, -1);
+int cgroup_rstat_flush_relaxed(struct cgroup *cgrp, bool wait_for_flush)
+{
+	bool flushed = __cgroup_rstat_flush(cgrp, false);
+
+	if (!flushed && wait_for_flush) {
+		/*
+		 * Reaching here we know an ongoing flusher is running, that
+		 * will take care of flushing for us, but for caller to read
+		 * accurate stats we want to wait for this ongoing flusher.
+		 *
+		 * TODO: When lock becomes mutex and no-yielding this code can
+		 * be simplifed as we can just sleep on the mutex lock.
+		 */
+		struct task_struct *id, *cur_id;
+		u64 timeout;
+
+		id = READ_ONCE(cgrp_rstat_ongoing_flusher_ID);
+		timeout = jiffies_64 + msecs_to_jiffies(50);
+
+		if (!id)
+			return false;
+
+		cond_resched();
+		/* We might get lucky and flush already completed */
+		cur_id = READ_ONCE(cgrp_rstat_ongoing_flusher_ID);
+
+		/* Due to lock yield, make sure "id" flusher completes */
+		while (cur_id == id && time_before64(jiffies_64, timeout)) {
+			cond_resched();
+			/* Use mutex to reduce stress on global lock */
+			mutex_lock(&cgrp_rstat_ongoing_flusher_serialize);
+			__cgroup_rstat_lock(cgrp, -1);
+			/* Get lock with ongoing can happen due to yielding */
+			cur_id = READ_ONCE(cgrp_rstat_ongoing_flusher_ID);
+			__cgroup_rstat_unlock(cgrp, -1);
+			mutex_unlock(&cgrp_rstat_ongoing_flusher_serialize);
+		}
+	}
+
+	return flushed;
 }
 
 /**
@@ -368,8 +484,11 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 	__acquires(&cgroup_rstat_lock)
 {
 	might_sleep();
-	__cgroup_rstat_lock(cgrp, -1);
-	cgroup_rstat_flush_locked(cgrp);
+
+	if (cgroup_rstat_trylock_flusher(cgrp, false))
+		cgroup_rstat_flush_locked(cgrp);
+	else
+		__cgroup_rstat_lock(cgrp, -1);
 }
 
 /**
@@ -379,7 +498,7 @@ void cgroup_rstat_flush_hold(struct cgroup *cgrp)
 void cgroup_rstat_flush_release(struct cgroup *cgrp)
 	__releases(&cgroup_rstat_lock)
 {
-	__cgroup_rstat_unlock(cgrp, -1);
+	cgroup_rstat_unlock_flusher(cgrp);
 }
 
 int cgroup_rstat_init(struct cgroup *cgrp)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 71fe2a95b8bd..6694f7a859b5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -871,12 +871,26 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(struct mem_cgroup *memcg)
+static void do_flush_stats(struct mem_cgroup *memcg, bool wait_for_flush)
 {
-	if (mem_cgroup_is_root(memcg))
-		WRITE_ONCE(flush_last_time, jiffies_64);
+	bool flushed = cgroup_rstat_flush_relaxed(memcg->css.cgroup,
+						  wait_for_flush);
 
-	cgroup_rstat_flush(memcg->css.cgroup);
+	if (mem_cgroup_is_root(memcg) && flushed)
+		    WRITE_ONCE(flush_last_time, jiffies_64);
+}
+
+static void __mem_cgroup_flush_stats(struct mem_cgroup *memcg,
+				     bool wait_for_flush)
+{
+	if (mem_cgroup_disabled())
+		return;
+
+	if (!memcg)
+		memcg = root_mem_cgroup;
+
+	if (memcg_vmstats_needs_flush(memcg->vmstats))
+		do_flush_stats(memcg, wait_for_flush);
 }
 
 /*
@@ -890,21 +904,19 @@ static void do_flush_stats(struct mem_cgroup *memcg)
  */
 void mem_cgroup_flush_stats(struct mem_cgroup *memcg)
 {
-	if (mem_cgroup_disabled())
-		return;
-
-	if (!memcg)
-		memcg = root_mem_cgroup;
+	__mem_cgroup_flush_stats(memcg, true);
+}
 
-	if (memcg_vmstats_needs_flush(memcg->vmstats))
-		do_flush_stats(memcg);
+void mem_cgroup_flush_stats_relaxed(struct mem_cgroup *memcg)
+{
+	__mem_cgroup_flush_stats(memcg, false);
 }
 
 void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
 {
 	/* Only flush if the periodic flusher is one full cycle late */
 	if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
-		mem_cgroup_flush_stats(memcg);
+		mem_cgroup_flush_stats_relaxed(memcg);
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
@@ -913,7 +925,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Deliberately ignore memcg_vmstats_needs_flush() here so that flushing
 	 * in latency-sensitive paths is as cheap as possible.
 	 */
-	do_flush_stats(root_mem_cgroup);
+	do_flush_stats(root_mem_cgroup, false);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -8369,7 +8381,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
 		 * mem_cgroup_flush_stats() ignores small changes. Use
 		 * do_flush_stats() directly to get accurate stats for charging.
 		 */
-		do_flush_stats(memcg);
+		do_flush_stats(memcg, true);
 		pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
 		if (pages < max)
 			continue;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..ab1411545572 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2247,7 +2247,7 @@ static void prepare_scan_control(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats(sc->target_mem_cgroup);
+	mem_cgroup_flush_stats_relaxed(sc->target_mem_cgroup);
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/zswap.c b/mm/zswap.c
index a50e2986cd2f..db72afe37ba2 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1237,7 +1237,7 @@ static unsigned long zswap_shrinker_count(struct shrinker *shrinker,
 	 * Without memcg, use the zswap pool-wide metrics.
 	 */
 	if (!mem_cgroup_disabled()) {
-		mem_cgroup_flush_stats(memcg);
+		mem_cgroup_flush_stats_relaxed(memcg);
 		nr_backing = memcg_page_state(memcg, MEMCG_ZSWAP_B) >> PAGE_SHIFT;
 		nr_stored = memcg_page_state(memcg, MEMCG_ZSWAPPED);
 	} else {



