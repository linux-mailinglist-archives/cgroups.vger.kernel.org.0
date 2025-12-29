Return-Path: <cgroups+bounces-12787-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA2CE5E0C
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 04:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80C430076AA
	for <lists+cgroups@lfdr.de>; Mon, 29 Dec 2025 03:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8ED1E633C;
	Mon, 29 Dec 2025 03:48:27 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from localhost.localdomain (unknown [147.136.157.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D45EEB3;
	Mon, 29 Dec 2025 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.136.157.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980107; cv=none; b=XXFREN0tcKxOoMKI305JXmCh8j1QBJ5nJjp9YnWWS5QVzU8YLkDS4wfBSwYJSgU6ysFVxkCmMO3F3sHSezFeuO5W3/n+kQDQdbnTaXK7Zbo9xK5OHwsXx+bAESl5z2NNWp/QjGkYVgPbuEiDs6fJ+l+9qzCo+1kA9NF1CkVS7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980107; c=relaxed/simple;
	bh=emCgqtNTEaNbbpQqbd2eL5PlJ1A5CdzCYzojCqudhd8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qXgfRLEoxoeyOGMBV9NCAqphdjA3O7SkHkAjLvLTjbwpK+oUiB5a7TrzE5q3dCU3AV8fZNwT6/MzJL7FsQHMZu64cNZCaupOh/wc4bUwijcw1XgPm00ysy10KK8DD9VciWfuGzatkwgMeGeRIbv50lSbUo71ZsG8XmMDDnJr9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=none smtp.mailfrom=localhost.localdomain; arc=none smtp.client-ip=147.136.157.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=localhost.localdomain
Received: by localhost.localdomain (Postfix, from userid 1007)
	id 6FB4A8AA380; Mon, 29 Dec 2025 11:40:09 +0800 (+08)
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: linux-mm@kvack.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/memcg: scale memory.high penalty based on refault recency
Date: Mon, 29 Dec 2025 11:39:55 +0800
Message-ID: <20251229033957.296257-1-jiayuan.chen@linux.dev>
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

After this patch with MADV_RANDOM (no readahead):

    sar -d 1
    Time          DEV       tps     rkB/s    %util
    04:08:57      sda    512.00    2048.00    5.60
    04:08:58      sda    576.00    2304.00    6.80
    04:08:59      sda    512.00    2048.00    6.80
    04:09:00      sda    536.00    2144.00    4.80
    04:09:01      sda    552.00    2208.00   10.40
    04:09:02      sda    512.00    2048.00    9.20

After this patch (memory.high triggered, thrashing mitigated):
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
v1 -> v2 : fix compile error when CONFIG_MEMCG is disabled
---
 include/linux/memcontrol.h | 26 ++++++++++++++++++++++++
 mm/memcontrol.c            | 41 +++++++++++++++++++++++++++++++++++---
 mm/workingset.c            |  4 ++++
 3 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index fd400082313a..98d4268457c0 100644
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
 
@@ -1038,6 +1041,20 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 }
 
 extern int mem_cgroup_init(void);
+
+static inline void mem_cgroup_update_last_refault(struct mem_cgroup *memcg)
+{
+	if (memcg)
+		WRITE_ONCE(memcg->last_refault, jiffies);
+}
+
+static inline unsigned long mem_cgroup_get_last_refault(struct mem_cgroup *memcg)
+{
+	if (memcg)
+		return READ_ONCE(memcg->last_refault);
+
+	return 0;
+}
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1433,6 +1450,15 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 }
 
 static inline int mem_cgroup_init(void) { return 0; }
+
+static inline void mem_cgroup_update_last_refault(struct mem_cgroup *memcg)
+{
+}
+
+static inline unsigned long mem_cgroup_get_last_refault(struct mem_cgroup *memcg)
+{
+	return 0;
+}
 #endif /* CONFIG_MEMCG */
 
 /*
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 75fc22a33b28..04f3a2511cbb 100644
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
+	unsigned long last_refault = mem_cgroup_get_last_refault(memcg);
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
index e9f05634747a..597fcab497f4 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -297,6 +297,8 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	if (lruvec != folio_lruvec(folio))
 		goto unlock;
 
+	mem_cgroup_update_last_refault(folio_memcg(folio));
+
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + type, delta);
 
 	if (!recent)
@@ -561,6 +563,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	pgdat = folio_pgdat(folio);
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
+	mem_cgroup_update_last_refault(memcg);
+
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
 	if (!workingset_test_recent(shadow, file, &workingset, true))
-- 
2.43.0


