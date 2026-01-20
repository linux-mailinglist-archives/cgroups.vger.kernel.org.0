Return-Path: <cgroups+bounces-13328-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLDNLqWkb2lIDwAAu9opvQ
	(envelope-from <cgroups+bounces-13328-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 16:52:05 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7046C52
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 16:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE3F1741332
	for <lists+cgroups@lfdr.de>; Tue, 20 Jan 2026 13:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0018443CEF1;
	Tue, 20 Jan 2026 13:57:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B445B366566;
	Tue, 20 Jan 2026 13:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917473; cv=none; b=KUP8orO0DBc7n8o36zkV60pqQJpT8ZpVEJVg9v+999OUZzuKUlBfY1hSzExvUNT0Gm+QiYjKLHLWj+toYOa6Z5thaM5RsfDfAGLvUCH91eQNiGDaC6Q9Au4gYB7bnV8J0+r/yINHXkS9Lut1sYJd4twbKud1KJQpj77IpA2bwYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917473; c=relaxed/simple;
	bh=B9DDkUbgb+A+315xGa2xitiV/1txUYHcvSOAZtxYLbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FVaiw1nvUdSXtubtn3krVqaKnfSD1+JyoGqsEO+28rBKxd7dXymKu0yaMlxhP4DdGH2YU77mUbGeGu3uW27yIoyahwGLjxzlmJqboJ+uUch06I5dHpiZ/t7Hg7gWG/ubCOQ3mS7rLvVCeCNnYxtiVq3CpqUDq4Z0clI5gGxkxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dwTR75BsvzYQvJC;
	Tue, 20 Jan 2026 21:57:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9925A4056D;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
Received: from hulk-vt.huawei.com (unknown [10.67.174.121])
	by APP4 (Coremail) with SMTP id gCh0CgCnCPnQiW9pwhTxEQ--.10691S9;
	Tue, 20 Jan 2026 21:57:47 +0800 (CST)
From: Chen Ridong <chenridong@huaweicloud.com>
To: akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	hannes@cmpxchg.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	zhengqi.arch@bytedance.com
Cc: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	lujialin4@huawei.com,
	chenridong@huaweicloud.com,
	ryncsn@gmail.com
Subject: [RFC PATCH -next 7/7] mm/mglru: remove memcg lru
Date: Tue, 20 Jan 2026 13:42:56 +0000
Message-Id: <20260120134256.2271710-8-chenridong@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260120134256.2271710-1-chenridong@huaweicloud.com>
References: <20260120134256.2271710-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCPnQiW9pwhTxEQ--.10691S9
X-Coremail-Antispam: 1UD129KBjvAXoW3Kw1ftw4kKry3tw15Wr18AFb_yoW8XF47to
	WSvr4DC3Zagr18Xw18ZrsFyF9xZF4DKryrXw15JwsrC3W2vrn8Wr4DJw4UGFyfJF1rGay0
	vryYqw1UXrZ3Jw13n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOV7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
	Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
	84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
	WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRRyxRDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Spamd-Result: default: False [0.24 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,huawei.com,huaweicloud.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13328-lists,cgroups=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,huaweicloud.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 60F7046C52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chen Ridong <chenridong@huawei.com>

Now that the previous patch has switched global reclaim to use
mem_cgroup_iter, the specialized memcg LRU infrastructure is no longer
needed. This patch removes all related code:

Signed-off-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/mm/multigen_lru.rst |  30 ------
 include/linux/mmzone.h            |  89 -----------------
 mm/memcontrol-v1.c                |   6 --
 mm/memcontrol.c                   |   4 -
 mm/mm_init.c                      |   1 -
 mm/vmscan.c                       | 156 +-----------------------------
 6 files changed, 2 insertions(+), 284 deletions(-)

diff --git a/Documentation/mm/multigen_lru.rst b/Documentation/mm/multigen_lru.rst
index 52ed5092022f..bf8547e2f592 100644
--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -220,36 +220,6 @@ time domain because a CPU can scan pages at different rates under
 varying memory pressure. It calculates a moving average for each new
 generation to avoid being permanently locked in a suboptimal state.
 
-Memcg LRU
----------
-An memcg LRU is a per-node LRU of memcgs. It is also an LRU of LRUs,
-since each node and memcg combination has an LRU of folios (see
-``mem_cgroup_lruvec()``). Its goal is to improve the scalability of
-global reclaim, which is critical to system-wide memory overcommit in
-data centers. Note that memcg LRU only applies to global reclaim.
-
-The basic structure of an memcg LRU can be understood by an analogy to
-the active/inactive LRU (of folios):
-
-1. It has the young and the old (generations), i.e., the counterparts
-   to the active and the inactive;
-2. The increment of ``max_seq`` triggers promotion, i.e., the
-   counterpart to activation;
-3. Other events trigger similar operations, e.g., offlining an memcg
-   triggers demotion, i.e., the counterpart to deactivation.
-
-In terms of global reclaim, it has two distinct features:
-
-1. Sharding, which allows each thread to start at a random memcg (in
-   the old generation) and improves parallelism;
-2. Eventual fairness, which allows direct reclaim to bail out at will
-   and reduces latency without affecting fairness over some time.
-
-In terms of traversing memcgs during global reclaim, it improves the
-best-case complexity from O(n) to O(1) and does not affect the
-worst-case complexity O(n). Therefore, on average, it has a sublinear
-complexity.
-
 Summary
 -------
 The multi-gen LRU (of folios) can be disassembled into the following
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index cf3095198db6..5bb7ed3fa238 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -509,12 +509,6 @@ struct lru_gen_folio {
 	atomic_long_t refaulted[NR_HIST_GENS][ANON_AND_FILE][MAX_NR_TIERS];
 	/* whether the multi-gen LRU is enabled */
 	bool enabled;
-	/* the memcg generation this lru_gen_folio belongs to */
-	u8 gen;
-	/* the list segment this lru_gen_folio belongs to */
-	u8 seg;
-	/* per-node lru_gen_folio list for global reclaim */
-	struct hlist_nulls_node list;
 };
 
 enum {
@@ -558,79 +552,14 @@ struct lru_gen_mm_walk {
 	bool force_scan;
 };
 
-/*
- * For each node, memcgs are divided into two generations: the old and the
- * young. For each generation, memcgs are randomly sharded into multiple bins
- * to improve scalability. For each bin, the hlist_nulls is virtually divided
- * into three segments: the head, the tail and the default.
- *
- * An onlining memcg is added to the tail of a random bin in the old generation.
- * The eviction starts at the head of a random bin in the old generation. The
- * per-node memcg generation counter, whose reminder (mod MEMCG_NR_GENS) indexes
- * the old generation, is incremented when all its bins become empty.
- *
- * There are four operations:
- * 1. MEMCG_LRU_HEAD, which moves a memcg to the head of a random bin in its
- *    current generation (old or young) and updates its "seg" to "head";
- * 2. MEMCG_LRU_TAIL, which moves a memcg to the tail of a random bin in its
- *    current generation (old or young) and updates its "seg" to "tail";
- * 3. MEMCG_LRU_OLD, which moves a memcg to the head of a random bin in the old
- *    generation, updates its "gen" to "old" and resets its "seg" to "default";
- * 4. MEMCG_LRU_YOUNG, which moves a memcg to the tail of a random bin in the
- *    young generation, updates its "gen" to "young" and resets its "seg" to
- *    "default".
- *
- * The events that trigger the above operations are:
- * 1. Exceeding the soft limit, which triggers MEMCG_LRU_HEAD;
- * 2. The first attempt to reclaim a memcg below low, which triggers
- *    MEMCG_LRU_TAIL;
- * 3. The first attempt to reclaim a memcg offlined or below reclaimable size
- *    threshold, which triggers MEMCG_LRU_TAIL;
- * 4. The second attempt to reclaim a memcg offlined or below reclaimable size
- *    threshold, which triggers MEMCG_LRU_YOUNG;
- * 5. Attempting to reclaim a memcg below min, which triggers MEMCG_LRU_YOUNG;
- * 6. Finishing the aging on the eviction path, which triggers MEMCG_LRU_YOUNG;
- * 7. Offlining a memcg, which triggers MEMCG_LRU_OLD.
- *
- * Notes:
- * 1. Memcg LRU only applies to global reclaim, and the round-robin incrementing
- *    of their max_seq counters ensures the eventual fairness to all eligible
- *    memcgs. For memcg reclaim, it still relies on mem_cgroup_iter().
- * 2. There are only two valid generations: old (seq) and young (seq+1).
- *    MEMCG_NR_GENS is set to three so that when reading the generation counter
- *    locklessly, a stale value (seq-1) does not wraparound to young.
- */
-#define MEMCG_NR_GENS	3
-#define MEMCG_NR_BINS	8
-
-struct lru_gen_memcg {
-	/* the per-node memcg generation counter */
-	unsigned long seq;
-	/* each memcg has one lru_gen_folio per node */
-	unsigned long nr_memcgs[MEMCG_NR_GENS];
-	/* per-node lru_gen_folio list for global reclaim */
-	struct hlist_nulls_head	fifo[MEMCG_NR_GENS][MEMCG_NR_BINS];
-	/* protects the above */
-	spinlock_t lock;
-};
-
-void lru_gen_init_pgdat(struct pglist_data *pgdat);
 void lru_gen_init_lruvec(struct lruvec *lruvec);
 bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw);
 
 void lru_gen_init_memcg(struct mem_cgroup *memcg);
 void lru_gen_exit_memcg(struct mem_cgroup *memcg);
-void lru_gen_online_memcg(struct mem_cgroup *memcg);
-void lru_gen_offline_memcg(struct mem_cgroup *memcg);
-void lru_gen_release_memcg(struct mem_cgroup *memcg);
-void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid);
 
 #else /* !CONFIG_LRU_GEN */
 
-static inline void lru_gen_init_pgdat(struct pglist_data *pgdat)
-{
-}
-
 static inline void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 }
@@ -648,22 +577,6 @@ static inline void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 {
 }
 
-static inline void lru_gen_online_memcg(struct mem_cgroup *memcg)
-{
-}
-
-static inline void lru_gen_offline_memcg(struct mem_cgroup *memcg)
-{
-}
-
-static inline void lru_gen_release_memcg(struct mem_cgroup *memcg)
-{
-}
-
-static inline void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
-{
-}
-
 #endif /* CONFIG_LRU_GEN */
 
 struct lruvec {
@@ -1503,8 +1416,6 @@ typedef struct pglist_data {
 #ifdef CONFIG_LRU_GEN
 	/* kswap mm walk data */
 	struct lru_gen_mm_walk mm_walk;
-	/* lru_gen_folio list */
-	struct lru_gen_memcg memcg_lru;
 #endif
 
 	CACHELINE_PADDING(_pad2_);
diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
index f0ef650d2317..3f0fd1141f37 100644
--- a/mm/memcontrol-v1.c
+++ b/mm/memcontrol-v1.c
@@ -182,12 +182,6 @@ static void memcg1_update_tree(struct mem_cgroup *memcg, int nid)
 	struct mem_cgroup_per_node *mz;
 	struct mem_cgroup_tree_per_node *mctz;
 
-	if (lru_gen_enabled()) {
-		if (soft_limit_excess(memcg))
-			lru_gen_soft_reclaim(memcg, nid);
-		return;
-	}
-
 	mctz = soft_limit_tree.rb_tree_per_node[nid];
 	if (!mctz)
 		return;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 675d49ad7e2c..f9aace496881 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3894,8 +3894,6 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	if (unlikely(mem_cgroup_is_root(memcg)) && !mem_cgroup_disabled())
 		queue_delayed_work(system_dfl_wq, &stats_flush_dwork,
 				   FLUSH_TIME);
-	lru_gen_online_memcg(memcg);
-
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
@@ -3935,7 +3933,6 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	reparent_deferred_split_queue(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
-	lru_gen_offline_memcg(memcg);
 
 	drain_all_stock(memcg);
 
@@ -3947,7 +3944,6 @@ static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 
 	invalidate_reclaim_iterators(memcg);
-	lru_gen_release_memcg(memcg);
 }
 
 static void mem_cgroup_css_free(struct cgroup_subsys_state *css)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 46ac915558d4..262238925c50 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1742,7 +1742,6 @@ static void __init free_area_init_node(int nid)
 	pgdat_set_deferred_range(pgdat);
 
 	free_area_init_core(pgdat);
-	lru_gen_init_pgdat(pgdat);
 }
 
 /* Any regular or high memory on that node? */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index d4eaa8221174..0946ba0af064 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2726,9 +2726,6 @@ static bool should_clear_pmd_young(void)
 #define for_each_evictable_type(type, swappiness)			\
 	for ((type) = min_type(swappiness); (type) <= max_type(swappiness); (type)++)
 
-#define get_memcg_gen(seq)	((seq) % MEMCG_NR_GENS)
-#define get_memcg_bin(bin)	((bin) % MEMCG_NR_BINS)
-
 static struct lruvec *get_lruvec(struct mem_cgroup *memcg, int nid)
 {
 	struct pglist_data *pgdat = NODE_DATA(nid);
@@ -4315,140 +4312,6 @@ bool lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 	return true;
 }
 
-/******************************************************************************
- *                          memcg LRU
- ******************************************************************************/
-
-/* see the comment on MEMCG_NR_GENS */
-enum {
-	MEMCG_LRU_NOP,
-	MEMCG_LRU_HEAD,
-	MEMCG_LRU_TAIL,
-	MEMCG_LRU_OLD,
-	MEMCG_LRU_YOUNG,
-};
-
-static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
-{
-	int seg;
-	int old, new;
-	unsigned long flags;
-	int bin = get_random_u32_below(MEMCG_NR_BINS);
-	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
-
-	spin_lock_irqsave(&pgdat->memcg_lru.lock, flags);
-
-	VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
-
-	seg = 0;
-	new = old = lruvec->lrugen.gen;
-
-	/* see the comment on MEMCG_NR_GENS */
-	if (op == MEMCG_LRU_HEAD)
-		seg = MEMCG_LRU_HEAD;
-	else if (op == MEMCG_LRU_TAIL)
-		seg = MEMCG_LRU_TAIL;
-	else if (op == MEMCG_LRU_OLD)
-		new = get_memcg_gen(pgdat->memcg_lru.seq);
-	else if (op == MEMCG_LRU_YOUNG)
-		new = get_memcg_gen(pgdat->memcg_lru.seq + 1);
-	else
-		VM_WARN_ON_ONCE(true);
-
-	WRITE_ONCE(lruvec->lrugen.seg, seg);
-	WRITE_ONCE(lruvec->lrugen.gen, new);
-
-	hlist_nulls_del_rcu(&lruvec->lrugen.list);
-
-	if (op == MEMCG_LRU_HEAD || op == MEMCG_LRU_OLD)
-		hlist_nulls_add_head_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
-	else
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[new][bin]);
-
-	pgdat->memcg_lru.nr_memcgs[old]--;
-	pgdat->memcg_lru.nr_memcgs[new]++;
-
-	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
-		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
-
-	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
-}
-
-#ifdef CONFIG_MEMCG
-
-void lru_gen_online_memcg(struct mem_cgroup *memcg)
-{
-	int gen;
-	int nid;
-	int bin = get_random_u32_below(MEMCG_NR_BINS);
-
-	for_each_node(nid) {
-		struct pglist_data *pgdat = NODE_DATA(nid);
-		struct lruvec *lruvec = get_lruvec(memcg, nid);
-
-		spin_lock_irq(&pgdat->memcg_lru.lock);
-
-		VM_WARN_ON_ONCE(!hlist_nulls_unhashed(&lruvec->lrugen.list));
-
-		gen = get_memcg_gen(pgdat->memcg_lru.seq);
-
-		lruvec->lrugen.gen = gen;
-
-		hlist_nulls_add_tail_rcu(&lruvec->lrugen.list, &pgdat->memcg_lru.fifo[gen][bin]);
-		pgdat->memcg_lru.nr_memcgs[gen]++;
-
-		spin_unlock_irq(&pgdat->memcg_lru.lock);
-	}
-}
-
-void lru_gen_offline_memcg(struct mem_cgroup *memcg)
-{
-	int nid;
-
-	for_each_node(nid) {
-		struct lruvec *lruvec = get_lruvec(memcg, nid);
-
-		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_OLD);
-	}
-}
-
-void lru_gen_release_memcg(struct mem_cgroup *memcg)
-{
-	int gen;
-	int nid;
-
-	for_each_node(nid) {
-		struct pglist_data *pgdat = NODE_DATA(nid);
-		struct lruvec *lruvec = get_lruvec(memcg, nid);
-
-		spin_lock_irq(&pgdat->memcg_lru.lock);
-
-		if (hlist_nulls_unhashed(&lruvec->lrugen.list))
-			goto unlock;
-
-		gen = lruvec->lrugen.gen;
-
-		hlist_nulls_del_init_rcu(&lruvec->lrugen.list);
-		pgdat->memcg_lru.nr_memcgs[gen]--;
-
-		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
-			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
-unlock:
-		spin_unlock_irq(&pgdat->memcg_lru.lock);
-	}
-}
-
-void lru_gen_soft_reclaim(struct mem_cgroup *memcg, int nid)
-{
-	struct lruvec *lruvec = get_lruvec(memcg, nid);
-
-	/* see the comment on MEMCG_NR_GENS */
-	if (READ_ONCE(lruvec->lrugen.seg) != MEMCG_LRU_HEAD)
-		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_HEAD);
-}
-
-#endif /* CONFIG_MEMCG */
-
 /******************************************************************************
  *                          the eviction
  ******************************************************************************/
@@ -4945,8 +4808,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 
 	set_mm_walk(NULL, sc->proactive);
 
-	if (try_to_shrink_lruvec(lruvec, sc))
-		lru_gen_rotate_memcg(lruvec, MEMCG_LRU_YOUNG);
+	try_to_shrink_lruvec(lruvec, sc);
 
 	clear_mm_walk();
 
@@ -5575,18 +5437,6 @@ static const struct file_operations lru_gen_ro_fops = {
  *                          initialization
  ******************************************************************************/
 
-void lru_gen_init_pgdat(struct pglist_data *pgdat)
-{
-	int i, j;
-
-	spin_lock_init(&pgdat->memcg_lru.lock);
-
-	for (i = 0; i < MEMCG_NR_GENS; i++) {
-		for (j = 0; j < MEMCG_NR_BINS; j++)
-			INIT_HLIST_NULLS_HEAD(&pgdat->memcg_lru.fifo[i][j], i);
-	}
-}
-
 void lru_gen_init_lruvec(struct lruvec *lruvec)
 {
 	int i;
@@ -5633,9 +5483,7 @@ void lru_gen_exit_memcg(struct mem_cgroup *memcg)
 		struct lru_gen_mm_state *mm_state = get_mm_state(lruvec);
 
 		VM_WARN_ON_ONCE(memchr_inv(lruvec->lrugen.nr_pages, 0,
-					   sizeof(lruvec->lrugen.nr_pages)));
-
-		lruvec->lrugen.list.next = LIST_POISON1;
+				   sizeof(lruvec->lrugen.nr_pages)));
 
 		if (!mm_state)
 			continue;
-- 
2.34.1


