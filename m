Return-Path: <cgroups+bounces-12745-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164FCDE62D
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 07:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA5E8300955F
	for <lists+cgroups@lfdr.de>; Fri, 26 Dec 2025 06:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF525F99B;
	Fri, 26 Dec 2025 06:43:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65692135A53;
	Fri, 26 Dec 2025 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766731390; cv=none; b=Cml3iFnn2Lwl6FyUIyKESAoUAx7PVBBm9bq25FYcuBnDeqhWpwSJuFSGKbuCCK+WlgMUhUSkeV5cdbT9s/lOBs8WhmawrOzClv9HrCB+JvI5TIMwowud5e7aJWBAzP0IkP7HM7uKZcvhu9UJhekwqGbwflIOj8jdVNxdWuF1zuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766731390; c=relaxed/simple;
	bh=85dRWxXAkss1rfCttGCq1dfEscAuYvzzUvD5bUUfauo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+J428W5ES8rz5/qhdVrSvtDYXZsvWHMtFaFVL8nY4RcEHe15ai3DTwfQUMIdMvo3VAm6P1pdokvPPLyEBiePtWw0vp+LSyK1CeS0hteFspYyZ/6nnF4wzrF7uHDJKNv9wdoTjiOlmMkUhy9SR+73Qhh+ywMr87S4YLyHgXQShc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id A9DBA8B2A3F; Fri, 26 Dec 2025 14:42:59 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm/memcg: scale memory.high penalty based on refault recency
Date: Fri, 26 Dec 2025 14:42:55 +0800
Message-ID: <20251226064257.245581-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@shopee.com>

Problem
-------
We observed an issue in production where a workload continuously
triggering memory.high also generates massive disk IO READ, causing
system-wide performance degradation.

This happens because memory.high penalty is currently based solely on
the overage amount, not the actual impact of that overage:

1. A memcg over memory.high reclaiming cold/unused pages
   → minimal system impact, light penalty is appropriate

2. A memcg over memory.high with hot pages being continuously
   reclaimed and refaulted → severe IO pressure, needs heavy penalty

Both cases receive identical penalties today. Users are forced to
combine memory.high with io.max as a workaround, but this is:
- The wrong abstraction level (memory policy shouldn't require IO tuning)
- Hard to configure correctly across different storage devices
- Unintuitive for users who only want memory control

Reproduction
------------
A simple test program demonstrates the issue:

    int fd = open("./200MB.file", O_RDWR|O_CREAT, 777);
    char *mem = mmap(NULL, size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    while (1) {
        for (size_t i = 0; i < size; i += 4096) {
            if (mem[rand() % size] != 0)
                return -1;
        }
    }

Run with memory.high constraint:

    cgcreate -g io,cpu,cpuset,memory:/always_high
    cgset -r cpuset.cpus=0 always_high
    cgset -r memory.high=150M always_high
    cgexec -g cpu,cpuset,memory:/always_high ./high_test 200 &

Solution
--------
Incorporate refault recency into the penalty calculation. If a refault
occurred recently when memory.high is triggered, it indicates active
thrashing and warrants additional throttling.

Why not use refault counters directly?
- Refault statistics (WORKINGSET_REFAULT_*) are aggregated periodically,
  not available in real-time for accurate delta calculation
- Calling mem_cgroup_flush_stats() on every charge would be prohibitively
  expensive in the hot path
- Due to readahead, the same refault count can represent vastly different
  IO loads, making counter-based estimation unreliable

The timestamp-based approach is:
- O(1) cost: single timestamp read and comparison
- Self-calibrating: penalty scales naturally with refault frequency
- Conservative: only triggers when refault and memory.high event
  occur in close temporal proximity

When refault_penalty is active:
- Skip the "reclaim made progress" retry loop to apply throttling sooner
- Skip the "penalty too small" bypass to ensure some delay is applied
- Add refault-based delay to the overage-based delay

Results
-------
Before this patch (memory.high triggered, severe thrashing):

    sar -d 1
    Time          DEV       tps     rkB/s    %util
    04:17:42      sda   3242.00  272684.00   89.60
    04:17:43      sda   3412.00  251160.00   91.60
    04:17:44      sda   3185.00  254532.00   88.00
    04:17:45      sda   3230.00  253332.00   88.40
    04:17:46      sda   3416.00  224712.00   92.40
    04:17:47      sda   3613.00  206612.00   94.40

After this patch (memory.high triggered, thrashing mitigated):

    sar -d 1
    Time          DEV       tps     rkB/s    %util
    04:08:57      sda    512.00    2048.00    5.60
    04:08:58      sda    576.00    2304.00    6.80
    04:08:59      sda    512.00    2048.00    6.80
    04:09:00      sda    536.00    2144.00    4.80
    04:09:01      sda    552.00    2208.00   10.40
    04:09:02      sda    512.00    2048.00    9.20

After this patch with MADV_RANDOM (no readahead):

    sar -d 1
    Time          DEV       tps     rkB/s    %util
    04:27:03      sda     40.00    5880.00    0.00
    04:27:04      sda     41.00    6472.00    0.00
    04:27:05      sda     37.00    4716.00    0.00
    04:27:06      sda     48.00    8512.00    0.00
    04:27:07      sda     33.00    4556.00    0.00

The patch reduces disk utilization from ~90% to ~6-10%, effectively
preventing memory.high-induced thrashing from overwhelming the IO
subsystem.

Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
---
 include/linux/memcontrol.h |  3 +++
 mm/memcontrol.c            | 41 +++++++++++++++++++++++++++++++++++---
 mm/workingset.c            |  8 ++++++++
 3 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fd400082313a..fc53de2485d6 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -321,6 +321,9 @@ struct mem_cgroup {
 	spinlock_t event_list_lock;
 #endif /* CONFIG_MEMCG_V1 */
 
+	/* Timestamp of most recent refault, for thrashing detection */
+	u64 last_refault;
+
 	struct mem_cgroup_per_node *nodeinfo[];
 };
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75fc22a33b28..0dd42cce6926 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2226,6 +2226,38 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
 	return penalty_jiffies * nr_pages / MEMCG_CHARGE_BATCH;
 }
 
+/*
+ * Check if a refault occurred recently, indicating active thrashing.
+ * Returns additional penalty jiffies based on refault recency.
+ *
+ * We use timestamp rather than refault counters because:
+ * 1. Counter aggregation is periodic and expensive to flush
+ * 2. Readahead makes counter-to-IO correlation unreliable
+ * 3. Timestamp gives us recency which directly reflects thrashing intensity
+ */
+static unsigned long calculate_refault(struct mem_cgroup *memcg)
+{
+	unsigned long last_refault = READ_ONCE(memcg->last_refault);
+	unsigned long now = jiffies;
+	long diff;
+
+	/*
+	 * Only care about refaults within the last second. The closer
+	 * the refault is to now, the higher the penalty:
+	 *
+	 *   diff = 1 tick   -> penalty = HZ      (capped to HZ/10 = 100ms)
+	 *   diff = HZ/10    -> penalty = 10 ticks = 10ms
+	 *   diff = HZ/2     -> penalty = 2 ticks  = 2ms
+	 *   diff >= HZ      -> penalty = 0        (too old, not thrashing)
+	 */
+	if (last_refault && time_before(now, last_refault + HZ)) {
+		diff = max((long)now - (long)last_refault, 1L);
+		/* Cap at 100ms to avoid excessive delays */
+		return min(HZ / diff, HZ / 10);
+	}
+	return 0;
+}
+
 /*
  * Reclaims memory over the high limit. Called directly from
  * try_charge() (context permitting), as well as from the userland
@@ -2233,6 +2265,7 @@ static unsigned long calculate_high_delay(struct mem_cgroup *memcg,
  */
 void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 {
+	unsigned long refault_penalty;
 	unsigned long penalty_jiffies;
 	unsigned long pflags;
 	unsigned long nr_reclaimed;
@@ -2279,12 +2312,14 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	penalty_jiffies += calculate_high_delay(memcg, nr_pages,
 						swap_find_max_overage(memcg));
 
+	refault_penalty = calculate_refault(memcg);
+
 	/*
 	 * Clamp the max delay per usermode return so as to still keep the
 	 * application moving forwards and also permit diagnostics, albeit
 	 * extremely slowly.
 	 */
-	penalty_jiffies = min(penalty_jiffies, MEMCG_MAX_HIGH_DELAY_JIFFIES);
+	penalty_jiffies = min(penalty_jiffies + refault_penalty, MEMCG_MAX_HIGH_DELAY_JIFFIES);
 
 	/*
 	 * Don't sleep if the amount of jiffies this memcg owes us is so low
@@ -2292,7 +2327,7 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	 * go only a small amount over their memory.high value and maybe haven't
 	 * been aggressively reclaimed enough yet.
 	 */
-	if (penalty_jiffies <= HZ / 100)
+	if (!refault_penalty && penalty_jiffies <= HZ / 100)
 		goto out;
 
 	/*
@@ -2300,7 +2335,7 @@ void __mem_cgroup_handle_over_high(gfp_t gfp_mask)
 	 * memory.high, we want to encourage that rather than doing allocator
 	 * throttling.
 	 */
-	if (nr_reclaimed || nr_retries--) {
+	if (!refault_penalty && (nr_reclaimed || nr_retries--)) {
 		in_retry = true;
 		goto retry_reclaim;
 	}
diff --git a/mm/workingset.c b/mm/workingset.c
index e9f05634747a..96e3c07e38ad 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -290,6 +290,7 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	struct lru_gen_folio *lrugen;
 	int type = folio_is_file_lru(folio);
 	int delta = folio_nr_pages(folio);
+	struct mem_cgroup *memcg;
 
 	rcu_read_lock();
 
@@ -297,6 +298,10 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	if (lruvec != folio_lruvec(folio))
 		goto unlock;
 
+	memcg = folio_memcg(folio);
+	if (memcg)
+		WRITE_ONCE(memcg->last_refault, jiffies);
+
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
 
 	if (!recent)
@@ -561,6 +566,9 @@ void workingset_refault(struct folio *folio, void *shadow)
 	pgdat = folio_pgdat(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
+	if (memcg)
+		WRITE_ONCE(memcg->last_refault, jiffies);
+
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	if (!workingset_test_recent(shadow, file, &workingset, true))
-- 
2.43.0


