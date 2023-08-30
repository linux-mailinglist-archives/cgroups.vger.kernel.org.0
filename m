Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B078DE10
	for <lists+cgroups@lfdr.de>; Wed, 30 Aug 2023 20:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344120AbjH3S5N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Aug 2023 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343996AbjH3Rxx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Aug 2023 13:53:53 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881CA193
        for <cgroups@vger.kernel.org>; Wed, 30 Aug 2023 10:53:49 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56c379a8250so106420a12.0
        for <cgroups@vger.kernel.org>; Wed, 30 Aug 2023 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693418029; x=1694022829; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ogw2uZiCm/cMvQMuQo8tpOc+9Ut9ubidtzhSqT66zzA=;
        b=fZgmV0PC3o4SJvvy85lmytwI2Y6MM31miKftQCxc9opLz9rcfn/2Y+PHR71hs8wyn+
         39aQ4U/ciEMXDw4i00dtbprEnR1HSsm1Cnze+Z7EJEffrz56lzwOakUUY46UY2tZdPAu
         3qtBubwRTMv4KJBTPv4NqFOcAt0epDTxX2ptfN+FMrTx1J+KwaF5xewUHspDlOj4TrDJ
         5acoCIHs0nSiq/V6bd68NS8nw1VT/IyLWMFWBHJ4g9xjhfcOVDGlkjzGhZ4LpJU4Jf5w
         nDvZ/+lsjt6JWv/qHUaVp4SgCu+SCPcvJ0zz3aaTeKUbmvQXE1tT0yyoyllVnN8XXKMv
         O5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693418029; x=1694022829;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ogw2uZiCm/cMvQMuQo8tpOc+9Ut9ubidtzhSqT66zzA=;
        b=iIaUUgJy0SpY2oM6NnwuhzzBH73XPUy/+z/Ysn7MbOu2HLfpRqpjioDwvnIui1/4Uz
         6OJ/Yab7Tza7uZgh4V2NpYp+QrFYh3JzoLsK8srRneHQB2VDh8mur6NU8AgTMqVWtswD
         0X9Mqrvo4dhhQb0H+xY2CA3xr8rvJ+bFML4umYpIiVvwuNKW8nAfEZWCXHNIEFlbHLa/
         97lYOW7Koa3UhNWzRDSkYdG46rglLTbuK7FVvujP/rJedyR5OzYIk1EaRHt3iUQABhjZ
         S0i0lbWEi72xzO3+SA4isGRNu6U/Ol1ZRqpt3YDsXVZuRC3ggIAz6undBQWzRYFMFoXM
         KJ2w==
X-Gm-Message-State: AOJu0YytqQ+c6ZV8y60Xp1/jOGv8Fx/DjglzzRo6eIdU3gMzI2PCoPjN
        2xvyWPmE20oVjgtH1Aec4Eu0qbI3gFCJYaHR
X-Google-Smtp-Source: AGHT+IEDvg6/Dv2ZCiJE47oEUfI2O/1AZvAH6hhLiJqKfB4icsZoJ0gRHnfLWPgfZWkICJoRQkM/9BaaldrxU8Ck
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:3c54:0:b0:56c:24c2:488d with SMTP
 id i20-20020a633c54000000b0056c24c2488dmr486119pgn.4.1693418029016; Wed, 30
 Aug 2023 10:53:49 -0700 (PDT)
Date:   Wed, 30 Aug 2023 17:53:35 +0000
In-Reply-To: <20230830175335.1536008-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230830175335.1536008-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Message-ID: <20230830175335.1536008-5-yosryahmed@google.com>
Subject: [PATCH v3 4/4] mm: memcg: use non-unified stats flushing for
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
        autolearn=ham autolearn_force=no version=3.4.6
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
index 94d5a6751a9e..1544c3964f19 100644
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
+void mem_cgroup_user_flush_stats(struct mem_cgroup *memcg)
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

