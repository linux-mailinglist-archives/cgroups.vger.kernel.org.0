Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA28078F186
	for <lists+cgroups@lfdr.de>; Thu, 31 Aug 2023 18:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346590AbjHaQ4a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 31 Aug 2023 12:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346634AbjHaQ43 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 31 Aug 2023 12:56:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F64DCFF
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7493303b5cso889071276.2
        for <cgroups@vger.kernel.org>; Thu, 31 Aug 2023 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693500982; x=1694105782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVjKd06WEqwLUbomPNwpng6u2PnrisAzbeEHsBpSLQA=;
        b=W38E5uAeTvyzvdugULNx6GuUlSmhzK+I1kCU5GpDRcJ/kzbDYMV1Zpgq3yvogCW+HO
         a0u1glBoatfXyeCi5dgKcnvjkmpqHQVt5p96qMBgQ4BpDaCVmJd2g9Sn47VyHINS6ZC5
         ip1m/0C/p5Kk00qY0HhGlwqUdf6zss1JkrqMgMj37Ag0nlc/atAxGJoDTHRQieBEwkyd
         gQp2xt5/QtSgFC219yqziibx6jWWlEcqeux7rSE1dzLAqdyWJDyoQX5Op0VOfUXGPO3y
         ghSojvpv6+c296PaorTE6B016I4p+0Bxg/OafrYRFGt/Ez6FSKXw/E/CsMa8zgshkxqz
         WSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693500982; x=1694105782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVjKd06WEqwLUbomPNwpng6u2PnrisAzbeEHsBpSLQA=;
        b=RWegRRHHY5ySKxwSRSee5pC0X/Kq0H3I/vE2vce40BUpM0i+NJulHkITZeM2DvpCTw
         1J+tROkKpifKjQqaZkSCIy3cc4HV0HBydJIkVD4kL2Ts39q3p6zSNcgmXs8i7Afr0Gwy
         RvbOuTeL8/dTQds2zIeiIQ+A22Ncglb+Po0W9SnVe7ET0NzvheOe4ITZKeKGKSZG6Y5v
         /lZtKnrSdNUwHSlCUXWuJw9yMokSo0ZVHr6El4Ighraa1klltqxez1fEvj/xPWZdbSoL
         5XSYIuF1sCCq3/xlxtJN1VS1TPOlnjd4fN2fk3QzMbvjW5Nw0Wg3w9sp+0TXoCSJ/ZzK
         pFHw==
X-Gm-Message-State: AOJu0Yxy1sEfgPXo7vCtLD4mtMmEMKrnSmB8JAneEI4wdJxmAKxyGIFe
        DSoOP15LAs7NJfZ9/NVrG23ovFo2ZhBdllZg
X-Google-Smtp-Source: AGHT+IEy8G064MlfVtEPW2U+DbL+KGFNApMore566FGW/RELtpuRVjTr6mp/8DBxtEe5U/4TTDMHu8xHlFoQIToU
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a25:ba90:0:b0:d72:8661:ee29 with SMTP
 id s16-20020a25ba90000000b00d728661ee29mr6359ybg.2.1693500982588; Thu, 31 Aug
 2023 09:56:22 -0700 (PDT)
Date:   Thu, 31 Aug 2023 16:56:11 +0000
In-Reply-To: <20230831165611.2610118-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230831165611.2610118-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230831165611.2610118-5-yosryahmed@google.com>
Subject: [PATCH v4 4/4] mm: memcg: use non-unified stats flushing for
 userspace reads
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

Unified flushing allows for great concurrency for paths that attempt to
flush the stats, at the expense of potential staleness and a single
flusher paying the extra cost of flushing the full tree.

This tradeoff makes sense for in-kernel flushers that may observe high
concurrency (e.g. reclaim, refault). For userspace readers, stale stats
may be unexpected and problematic, especially when such stats are used
for critical paths such as userspace OOM handling. Additionally, a
userspace reader will occasionally pay the cost of flushing the entire
hierarchy, which also causes problems in some cases [1].

Opt userspace reads out of unified flushing. This makes the cost of
reading the stats more predictable (proportional to the size of the
subtree), as well as the freshness of the stats. Userspace readers are
not expected to have similar concurrency to in-kernel flushers,
serializing them among themselves and among in-kernel flushers should be
okay. Nonetheless, for extra safety, introduce a mutex when flushing for
userspace readers to make sure only a single userspace reader can compete
with in-kernel flushers at a time. This takes away userspace ability to
directly influence or hurt in-kernel lock contention.

An alternative is to remove flushing from the stats reading path
completely, and rely on the periodic flusher. This should be accompanied
by making the periodic flushing period tunable, and providing an
interface for userspace to force a flush, following a similar model to
/proc/vmstat. However, such a change will be hard to reverse if the
implementation needs to be changed because:
- The cost of reading stats will be very cheap and we won't be able to
  take that back easily.
- There are user-visible interfaces involved.

Hence, let's go with the change that's most reversible first and revisit
as needed.

This was tested on a machine with 256 cpus by running a synthetic test
script [2] that creates 50 top-level cgroups, each with 5 children (250
leaf cgroups). Each leaf cgroup has 10 processes running that allocate
memory beyond the cgroup limit, invoking reclaim (which is an in-kernel
unified flusher). Concurrently, one thread is spawned per-cgroup to read
the stats every second (including root, top-level, and leaf cgroups --
so total 251 threads). No significant regressions were observed in the
total run time, which means that userspace readers are not significantly
affecting in-kernel flushers:

Base (mm-unstable):

real	0m22.500s
user	0m9.399s
sys	73m41.381s

real	0m22.749s
user	0m15.648s
sys	73m13.113s

real	0m22.466s
user	0m10.000s
sys	73m11.933s

With this patch:

real	0m23.092s
user	0m10.110s
sys	75m42.774s

real	0m22.277s
user	0m10.443s
sys	72m7.182s

real	0m24.127s
user	0m12.617s
sys	78m52.765s

[1]https://lore.kernel.org/lkml/CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com/
[2]https://lore.kernel.org/lkml/CAJD7tka13M-zVZTyQJYL1iUAYvuQ1fcHbCjcOBZcz6POYTV-4g@mail.gmail.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 94d5a6751a9e..46a7abf71c73 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -588,6 +588,7 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
+static DEFINE_MUTEX(stats_user_flush_mutex);
 static atomic_t stats_unified_flush_ongoing = ATOMIC_INIT(0);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 static u64 flush_next_time;
@@ -655,6 +656,21 @@ static void do_stats_flush(struct mem_cgroup *memcg)
 	cgroup_rstat_flush(memcg->css.cgroup);
 }
 
+/*
+ * mem_cgroup_user_flush_stats - do a stats flush for a user read
+ * @memcg: memory cgroup to flush
+ *
+ * Flush the subtree of @memcg. A mutex is used for userspace readers to gate
+ * the global rstat spinlock. This protects in-kernel flushers from userspace
+ * readers hogging the lock.
+ */
+static void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
+{
+	mutex_lock(&stats_user_flush_mutex);
+	do_stats_flush(memcg);
+	mutex_unlock(&stats_user_flush_mutex);
+}
+
 /*
  * do_unified_stats_flush - do a unified flush of memory cgroup statistics
  *
@@ -1608,7 +1624,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_try_flush_stats();
+	mem_cgroup_user_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4050,7 +4066,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_try_flush_stats();
+	mem_cgroup_user_flush_stats(memcg);
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4125,7 +4141,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_try_flush_stats();
+	mem_cgroup_user_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -6642,7 +6658,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_try_flush_stats();
+	mem_cgroup_user_flush_stats(memcg);
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

