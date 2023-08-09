Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A2F775218
	for <lists+cgroups@lfdr.de>; Wed,  9 Aug 2023 06:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHIE6P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 9 Aug 2023 00:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHIE6O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 9 Aug 2023 00:58:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE26172A
        for <cgroups@vger.kernel.org>; Tue,  8 Aug 2023 21:58:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-563ab574cb5so4030557a12.1
        for <cgroups@vger.kernel.org>; Tue, 08 Aug 2023 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691557093; x=1692161893;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OYG5lfEUc9Di0uttH2eztXJ8fv3suEABmVSMtUffIT0=;
        b=quGljRI4w1RP9FtvOGqFbpKn287sq8n8yZxrVoBE8wYYqcAnuV/TkVeOTn+wchwE3e
         SA1f2P2LImZukMa8s5iU0UG7r/m+VsFAhDaPuxOBo5H44wylZPOCSmJJdmS6ZEwAkh7/
         jtHAbR0qSA8Wob2+ggf6h8hpDEhUh3u4eGFPmDb/IOVbX9xuUcq7EC6ZVjShiepu1hoW
         07R9B8SdYm2fi/uW3sOuASuXA70UXL8GWT79a/55rkSb0DuEdo7MP7i9j37geWuXJNJV
         1x3tT+mEB5XmgsUnZmx4RN2R1qZDAJ3tUB2y22gEJq6H3iE26Oi58NHGVuPHKganuZDL
         Zs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691557093; x=1692161893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYG5lfEUc9Di0uttH2eztXJ8fv3suEABmVSMtUffIT0=;
        b=Nvu2yTD/pMDWbpIoeIH3oiKJ/4ifUyPdqE2B6fVYEAEQSDf7rUEXpziyAS3WF7YFN9
         EPnPCTV7O+1X6iV/I3+guvyb/LBt+h/ebNDeGQRJC6Zw//fFDQn8Kuu69iLGS+mAQnhY
         8KzVvPYKZCCVMmIx1DyidO7BZa4joK7hAnN1QWUy9eUD0pGRSN/etgtxtwSAol5Phbt2
         YrbgXP2jIZ115DaemuymE3O7+gw7zs+BZ4ClvMQEb6so0Hg1N5qmGfnCi7YEJQQIQLJE
         Xj+JtrB8T4bma+kIlyZ0xEzcX+WvwaNbfEFW/gjxGxdfqGeyomcARMDWdd7+qFEX5+AJ
         5V4Q==
X-Gm-Message-State: AOJu0YwlRkc1OlUp6xUY2j8iyZYuNTOU0QoHp4tBP8lRW9CQCzoAr/yI
        /rfcVmWtKk10qPGKmJLB6NTK6RBK4u43LbzN
X-Google-Smtp-Source: AGHT+IHV+BEGRzksFj4rWRexYZy18kZxUIGbke/J1tUZG9BpzC9NszNaMqLp5jtlDBUuvrtC3RKXEW6jSuRbBnpK
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:3f0c:0:b0:563:8767:d83f with SMTP
 id m12-20020a633f0c000000b005638767d83fmr24521pga.7.1691557093131; Tue, 08
 Aug 2023 21:58:13 -0700 (PDT)
Date:   Wed,  9 Aug 2023 04:58:10 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809045810.1659356-1-yosryahmed@google.com>
Subject: [PATCH] mm: memcg: provide accurate stats for userspace reads
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
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

Over time, the memcg code added multiple optimizations to the stats
flushing path that introduce a tradeoff between accuracy and
performance. In some contexts (e.g. dirty throttling, refaults, etc), a
full rstat flush of the stats in the tree can be too expensive. Such
optimizations include [1]:
(a) Introducing a periodic background flusher to keep the size of the
update tree from growing unbounded.
(b) Allowing only one thread to flush at a time, and other concurrent
flushers just skip the flush. This avoids a thundering herd problem
when multiple reclaim/refault threads attempt to flush the stats at
once.
(c) Only executing a flush if the magnitude of the stats updates exceeds
a certain threshold.

These optimizations were necessary to make flushing feasible in
performance-critical paths, and they come at the cost of some accuracy
that we choose to live without. On the other hand, for flushes invoked
when userspace is reading the stats, the tradeoff is less appealing
This code path is not performance-critical, and the inaccuracies can
affect userspace behavior. For example, skipping flushing when there is
another ongoing flush is essentially a coin flip. We don't know if the
ongoing flush is done with the subtree of interest or not.

If userspace asks for stats, let's give it accurate stats. Without this
patch, we see regressions in userspace workloads due to stats inaccuracy
in some cases.

Rework the do_flush_stats() helper to accept a "full" boolean argument.
For a "full" flush, if there is an ongoing flush, do not skip. Instead
wait for the flush to complete. Introduce a new
mem_cgroup_flush_stats_full() interface that use this full flush, and
also does not check if the magnitude of the updates exceeds the
threshold. Use mem_cgroup_flush_stats_full() in code paths where stats
are flushed due to a userspace read. This essentially undos optimzations
(b) and (c) above for flushes triggered by userspace reads.

[1] https://lore.kernel.org/lkml/20210716212137.1391164-2-shakeelb@google.com/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---

I want to argue that this is what we should be doing for all flushing
contexts, not just userspace reads (i.e all flushes should be "full").
Skipping if a flush is ongoing is too brittle. There is a significant
chance that the stats of the cgroup we care about is not fully flushed.
Waiting for an ongoing flush to finish ensures correctness while still
avoiding the thundering herd problem on the rstat flush lock.

Having said that, there is a higher chance of regression if we add the
wait in more critical paths (e.g. reclaim, refaults), so I opt-ed to do
this for userspace reads for now. We have complaints about inaccuracy in
userspace reads, but no complaints about inaccuracy in other paths so
far (although it would be really difficult to tie a reclaim/refault
problem to a partial stats flush anyway).

---
 mm/memcontrol.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e041ba827e59..38e227f7127d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -630,7 +630,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 		/*
 		 * If stats_flush_threshold exceeds the threshold
 		 * (>num_online_cpus()), cgroup stats update will be triggered
-		 * in __mem_cgroup_flush_stats(). Increasing this var further
+		 * in mem_cgroup_flush_stats(). Increasing this var further
 		 * is redundant and simply adds overhead in atomic update.
 		 */
 		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
@@ -639,17 +639,24 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 	}
 }
 
-static void do_flush_stats(void)
+static void do_flush_stats(bool full)
 {
+	if (!atomic_read(&stats_flush_ongoing) &&
+	    !atomic_xchg(&stats_flush_ongoing, 1))
+		goto flush;
+
 	/*
-	 * We always flush the entire tree, so concurrent flushers can just
-	 * skip. This avoids a thundering herd problem on the rstat global lock
-	 * from memcg flushers (e.g. reclaim, refault, etc).
+	 * We always flush the entire tree, so concurrent flushers can choose to
+	 * skip if accuracy is not critical. Otherwise, wait for the ongoing
+	 * flush to complete. This avoids a thundering herd problem on the rstat
+	 * global lock from memcg flushers (e.g. reclaim, refault, etc).
 	 */
-	if (atomic_read(&stats_flush_ongoing) ||
-	    atomic_xchg(&stats_flush_ongoing, 1))
-		return;
-
+	while (full && atomic_read(&stats_flush_ongoing) == 1) {
+		if (!cond_resched())
+			cpu_relax();
+	}
+	return;
+flush:
 	WRITE_ONCE(flush_next_time, jiffies_64 + 2*FLUSH_TIME);
 
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
@@ -661,7 +668,12 @@ static void do_flush_stats(void)
 void mem_cgroup_flush_stats(void)
 {
 	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
-		do_flush_stats();
+		do_flush_stats(false);
+}
+
+static void mem_cgroup_flush_stats_full(void)
+{
+	do_flush_stats(true);
 }
 
 void mem_cgroup_flush_stats_ratelimited(void)
@@ -676,7 +688,7 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	 * Always flush here so that flushing in latency-sensitive paths is
 	 * as cheap as possible.
 	 */
-	do_flush_stats();
+	do_flush_stats(false);
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
@@ -1576,7 +1588,7 @@ static void memcg_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 	 *
 	 * Current memory state:
 	 */
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_full();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		u64 size;
@@ -4018,7 +4030,7 @@ static int memcg_numa_stat_show(struct seq_file *m, void *v)
 	int nid;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_full();
 
 	for (stat = stats; stat < stats + ARRAY_SIZE(stats); stat++) {
 		seq_printf(m, "%s=%lu", stat->name,
@@ -4093,7 +4105,7 @@ static void memcg1_stat_format(struct mem_cgroup *memcg, struct seq_buf *s)
 
 	BUILD_BUG_ON(ARRAY_SIZE(memcg1_stat_names) != ARRAY_SIZE(memcg1_stats));
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_full();
 
 	for (i = 0; i < ARRAY_SIZE(memcg1_stats); i++) {
 		unsigned long nr;
@@ -6610,7 +6622,7 @@ static int memory_numa_stat_show(struct seq_file *m, void *v)
 	int i;
 	struct mem_cgroup *memcg = mem_cgroup_from_seq(m);
 
-	mem_cgroup_flush_stats();
+	mem_cgroup_flush_stats_full();
 
 	for (i = 0; i < ARRAY_SIZE(memory_stats); i++) {
 		int nid;
-- 
2.41.0.640.ga95def55d0-goog

