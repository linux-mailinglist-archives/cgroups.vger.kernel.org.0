Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 146666CCCFE
	for <lists+cgroups@lfdr.de>; Wed, 29 Mar 2023 00:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjC1WRY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 Mar 2023 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjC1WRP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 Mar 2023 18:17:15 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD92272A
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 15:17:02 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id i7-20020a626d07000000b005d29737db06so6411719pfc.15
        for <cgroups@vger.kernel.org>; Tue, 28 Mar 2023 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rItEK+KYvsSIiuNXlyB23Cs11TTT5fJ8aFIXbrMiIEw=;
        b=IxPRAGCqLmO64hebIOFNkgw1YGUDJSVyfgVVBwxUcvdgL59f7l4LN5zMPrXb+jjbv/
         44AuhCK3u7FtNfz2jZoS0YDY1UIo89Iub/aEWQsolPiMTjtNQ86ze7JWsd1EKsY5Y1Aw
         07n0xvSJnL2lwlEm697GGmrpvMBX0F+5BNT3XjdQx09Cev4XnMOYZ7hcuMbACVnhAT8t
         T+Q0avDfvu5GCgeBYFMaudoWaGLkL6vKFSabNVsNzlmPSiAqWuR+oN/II5DxoATas6tB
         N+Po8vyHrMmHA1KarR8lOaWajBlxLkTT4ktZV7Et/fSUfAvv7rnsRtElYoPsoIvIEGG6
         moFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041822;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rItEK+KYvsSIiuNXlyB23Cs11TTT5fJ8aFIXbrMiIEw=;
        b=sbmKLY2DcrryxEyrNatBM4C+tFVkuW2Zi+E5hXpCECsNtZOFG8mIGx5/zUxT7iI6yL
         TqqMZP0cGFQ3d0gMUXI02keOUWrKOj67aMQNhjl+DGnfniz98QxknbCDAmqwPseDvFm9
         GO3KZmeNVCqiIhnyxQt6LVyZVF7kmAhUSEqCSZf1bz+f/VOXpy3hhO5XkhshmomC0wgo
         r0BgqL0061+0WpFRwyoZvG/ptPiH08+QeXncxX3OGV28xfiC7PvqcJDYJcN2gI9wzGt9
         yDjjVk00AvA6SWrddO7SiQ0ngebR5YWSh6MU9gzaC3juHs2sCyJqHJ+MNaLZCc1jsmIk
         uABg==
X-Gm-Message-State: AAQBX9ca0hCuBAjBcCo1Xf7cyyZDVIKGqoTNnczB4RetrDOxO6XcImCj
        YF2T6HUvDt7HFuZyJfSQ5LNZkEAahssYsLBj
X-Google-Smtp-Source: AKy350bXvyCoGIAXSg9szgc2JGdZUl73nsfa2Et7WueltHgrvj0bY0SpfT6d/5uVqOXZZR9I4CnMF+3pkDT4wLPq
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:ce08:0:b0:50c:6cd:cace with SMTP id
 y8-20020a63ce08000000b0050c06cdcacemr4745262pgf.2.1680041821773; Tue, 28 Mar
 2023 15:17:01 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:41 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-7-yosryahmed@google.com>
Subject: [PATCH v2 6/9] memcg: sleep during flushing stats in safe contexts
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, all contexts that flush memcg stats do so with sleeping not
allowed. Some of these contexts are perfectly safe to sleep in, such as
reading cgroup files from userspace or the background periodic flusher.

Refactor the code to make mem_cgroup_flush_stats() non-atomic (aka
sleepable), and provide a separate atomic version. The atomic version is
used in reclaim, refault, writeback, and in mem_cgroup_usage(). All
other code paths are left to use the non-atomic version. This includes
callbacks for userspace reads and the periodic flusher.

Since refault is the only caller of mem_cgroup_flush_stats_ratelimited(),
change it to mem_cgroup_flush_stats_atomic_ratelimited(). Reclaim and
refault code paths are modified to do non-atomic flushing in separate
later patches -- so it will eventually be changed back to
mem_cgroup_flush_stats_ratelimited().

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h |  9 ++++++--
 mm/memcontrol.c            | 45 ++++++++++++++++++++++++++++++--------
 mm/vmscan.c                |  2 +-
 mm/workingset.c            |  2 +-
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ac3f3b3a45e2..b424ba3ebd09 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1037,7 +1037,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 }
 
 void mem_cgroup_flush_stats(void);
-void mem_cgroup_flush_stats_ratelimited(void);
+void mem_cgroup_flush_stats_atomic(void);
+void mem_cgroup_flush_stats_atomic_ratelimited(void);
 
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
@@ -1535,7 +1536,11 @@ static inline void mem_cgroup_flush_stats(void)
 {
 }
 
-static inline void mem_cgroup_flush_stats_ratelimited(void)
+static inline void mem_cgroup_flush_stats_atomic(void)
+{
+}
+
+static inline void mem_cgroup_flush_stats_atomic_ratelimited(void)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 65750f8b8259..a2ce3aa10d94 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -634,7 +634,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void __mem_cgroup_flush_stats(void)
+static void do_flush_stats(bool atomic)
 {
 	/*
 	 * We always flush the entire tree, so concurrent flushers can just
@@ -646,26 +646,46 @@ static void __mem_cgroup_flush_stats(void)
 		return;
 
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
-	cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
+
+	if (atomic)
+		cgroup_rstat_flush_atomic(root_mem_cgroup->css.cgroup);
+	else
+		cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
+
 	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
+static bool should_flush_stats(void)
+{
+	return atomic_read(&stats_flush_threshold) > num_online_cpus();
+}
+
 void mem_cgroup_flush_stats(void)
 {
-	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
-		__mem_cgroup_flush_stats();
+	if (should_flush_stats())
+		do_flush_stats(false);
 }
 
-void mem_cgroup_flush_stats_ratelimited(void)
+void mem_cgroup_flush_stats_atomic(void)
+{
+	if (should_flush_stats())
+		do_flush_stats(true);
+}
+
+void mem_cgroup_flush_stats_atomic_ratelimited(void)
 {
 	if (time_after64(jiffies_64, READ_ONCE(flush_next_time)))
-		mem_cgroup_flush_stats();
+		mem_cgroup_flush_stats_atomic();
 }
 
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
-	__mem_cgroup_flush_stats();
+	/*
+	 * Always flush here so that flushing in latency-sensitive paths is
+	 * as cheap as possible.
+	 */
+	do_flush_stats(false);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -3685,9 +3705,12 @@ static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
 		 * done from irq context; use stale stats in this case.
 		 * Arguably, usage threshold events are not reliable on the root
 		 * memcg anyway since its usage is ill-defined.
+		 *
+		 * Additionally, other call paths through memcg_check_events()
+		 * disable irqs, so make sure we are flushing stats atomically.
 		 */
 		if (in_task())
-			mem_cgroup_flush_stats();
+			mem_cgroup_flush_stats_atomic();
 		val = memcg_page_state(memcg, NR_FILE_PAGES) +
 			memcg_page_state(memcg, NR_ANON_MAPPED);
 		if (swap)
@@ -4610,7 +4633,11 @@ void mem_cgroup_wb_stats(struct bdi_writeback *wb, unsigned long *pfilepages,
 	struct mem_cgroup *memcg = mem_cgroup_from_css(wb->memcg_css);
 	struct mem_cgroup *parent;
 
-	mem_cgroup_flush_stats();
+	/*
+	 * wb_writeback() takes a spinlock and calls
+	 * wb_over_bg_thresh()->mem_cgroup_wb_stats(). Do not sleep.
+	 */
+	mem_cgroup_flush_stats_atomic();
 
 	*pdirty = memcg_page_state(memcg, NR_FILE_DIRTY);
 	*pwriteback = memcg_page_state(memcg, NR_WRITEBACK);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9c1c5e8b24b8..a9511ccb936f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2845,7 +2845,7 @@ static void prepare_scan_count(pg_data_t *pgdat, struct scan_control *sc)
 	 * Flush the memory cgroup stats, so that we read accurate per-memcg
 	 * lruvec stats for heuristics.
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_atomic();
 
 	/*
 	 * Determine the scan balance between anon and file LRUs.
diff --git a/mm/workingset.c b/mm/workingset.c
index af862c6738c3..dab0c362b9e3 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -462,7 +462,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 
 	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 
-	mem_cgroup_flush_stats_ratelimited();
+	mem_cgroup_flush_stats_atomic_ratelimited();
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
-- 
2.40.0.348.gf938b09366-goog

