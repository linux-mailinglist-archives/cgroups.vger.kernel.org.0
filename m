Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7147F6D0E85
	for <lists+cgroups@lfdr.de>; Thu, 30 Mar 2023 21:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjC3TSZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Mar 2023 15:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjC3TSU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Mar 2023 15:18:20 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217251025F
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 12:18:13 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q9-20020a170902dac900b001a18ceff5ebso11612273plx.4
        for <cgroups@vger.kernel.org>; Thu, 30 Mar 2023 12:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4K13XuzFhLt0ZIgNSFirN/NTpinGGuhSsjDOtu88ZFQ=;
        b=nHw0e79hZFaw3nf4LyIXmmhTYfA1FbBbf2dimkl5At5Psg3CjvNgu6oG6xad78uoN/
         S2j2UYV8EipalJrwt2zNvbI6g73PyAp4x9X0MELejGCTtg493QkbzRVplqF8mo+gd+ZT
         v2g6y/Uq/dc/IcDqjVuG6qTAXC3lltOSedgQENPqcdYx34VNoyr/anJbPmkUtw6k7KGZ
         kbHnvz3Vd5/Dm/bxM/NXhZiy/XES3eJpoxargQYJd3pDWMStv8K0/vXl6hkWv2MnHLzC
         WyPbqSXfAwOToFWCyu1C3jP4ndGUE9RCrti/toBLaYuvsaopTHlhvDYChxTi2n0kxppd
         O1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4K13XuzFhLt0ZIgNSFirN/NTpinGGuhSsjDOtu88ZFQ=;
        b=cHY5yWdRH5hSp8kat8IpUlqlD3pDIEtfSR333xnvIOUbm1GWIPGNkuXEGLEJ/uYpI7
         Tc73MYWioSVSSZ8rHrpKUHQvIFuBXTQr4jEk2V+S5Q6uBYM4xfzDm8/Rfu8W3u7LD8Sd
         XLxeaP2M8ESmhcOzKFp3k1ag8M3PjYSF1dZsyGj9B/ffOWnq9FNEtV/4YKnlBL4reazm
         khNlqyksMiipiGH565j0FcSGBlbOIv3P8f4jDs5jk2GX/WtxLmPEU8iG0TCV7y67ljxG
         KtlmRjwtT1t94H3RowyyAIZMPZztby8PHvq0JUUSA4vfvZ4sIiEuA9TuuaOFrEG7Dhn/
         SZFw==
X-Gm-Message-State: AAQBX9dOIJnlt2umpPf1F25TMrJMnA5WrC43kUpky7qoYE3fSQF1qSBD
        MAKsjxWUTkzU1++7PQaU5LVHXmTUb2GFHLSC
X-Google-Smtp-Source: AKy350YSzgQBtWYiTKsbkJ1oQdlD62/Xn6W7mjRdu2TN+RxVPyaHwSjuEqzrgKulPryFVMSvh1+rAuiwX+ctKyIl
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:1914:0:b0:50b:de95:af77 with SMTP
 id z20-20020a631914000000b0050bde95af77mr2125406pgl.1.1680203892860; Thu, 30
 Mar 2023 12:18:12 -0700 (PDT)
Date:   Thu, 30 Mar 2023 19:17:58 +0000
In-Reply-To: <20230330191801.1967435-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230330191801.1967435-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330191801.1967435-6-yosryahmed@google.com>
Subject: [PATCH v3 5/8] memcg: sleep during flushing stats in safe contexts
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
        Yosry Ahmed <yosryahmed@google.com>,
        Michal Hocko <mhocko@suse.com>
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
Flushing is an expensive operation that scales with the number of cpus
and the number of cgroups in the system, so avoid doing it atomically
where possible.

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
Acked-by: Michal Hocko <mhocko@suse.com>
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

