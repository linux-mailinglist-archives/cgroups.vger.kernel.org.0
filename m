Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC507BF14F
	for <lists+cgroups@lfdr.de>; Tue, 10 Oct 2023 05:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441970AbjJJDVd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Oct 2023 23:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441975AbjJJDV3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Oct 2023 23:21:29 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F73AAF
        for <cgroups@vger.kernel.org>; Mon,  9 Oct 2023 20:21:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f7d109926so79987027b3.2
        for <cgroups@vger.kernel.org>; Mon, 09 Oct 2023 20:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696908085; x=1697512885; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XEDO979juocfA6e748Gdg1ojA/11BVhtMp+K0OvWH0c=;
        b=cFy98PfiP1+ILre97PV1XvTfRsee/TTpqaTzPcb3lr1BPgIL0Ad5lTdIa415wsXVHg
         HuB/Hj3rQnaFIaGVZqqCy4MoHYCCZcPUekhXpQ/enyXWmNWV64aiUWHTE0Xz54v4r4HW
         B8CI2VOMQuGIyT13hvqx5JsRUnTfTVdXmX731migJxMCa8/oE7DOCuZskaK+GgEjP8u2
         LIumpbii48bruRrZMfoHp/IbZJjd17RSQGfidbFMBzQEKdg9+PovxJhfNQ+KCPEXbD5U
         UnohDJ+VYmnYzffFzV/yWz4u1niGoDp/JhjHjhV8QUEOzsHaKe89SDIP3n0HCU5vCutq
         A4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696908085; x=1697512885;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XEDO979juocfA6e748Gdg1ojA/11BVhtMp+K0OvWH0c=;
        b=CTGSgI3AnsMW20SYkIhVWK0p7g3RjHAPuWcxNwHckRjd061y7bROBsVkU2csSLybi7
         Pu1Nvb2bndi2a26TRKczuZMDdnZ4yBXNQiUjDdzvGRMZOM0GNS8yMMsNhomh+iH5fqr1
         4ISZC5jxdVKliBUECvPwD3GveOkIsdcvyEerD0dtbSBz1k1RQEclGLw3CxWfmdP2e+ah
         4owR4ZC/Jw0LoQxqQz1GMcLhhx9tsTk5AWSmrKSuLqkFU8CkL9y/MZiKL45/PyRhUBTx
         70Blg08fKoFl/OJ0gIxUHGn+GO/nPs1H33YqBwUOrkaPGt7xFM2h5yXLkzLTcVAXG5Lv
         /PDg==
X-Gm-Message-State: AOJu0YwFeQechCjri8gtrpO6S7iXlGrHfWyGS1xAJNLT3JxPSnqMBbBq
        O8hce3AVHL2jb8/sEdK1uQmMwbQMJxK+TSbX
X-Google-Smtp-Source: AGHT+IG8kcJ/dn9Ahg31ZEvjLGaGuCajxb48R9RWsECmkth4fjZtYHFlyQOjLuGiUbhEeB/vJfn9WBvb6ywt7IeI
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:b209:0:b0:59b:e1db:562c with SMTP
 id q9-20020a81b209000000b0059be1db562cmr319164ywh.5.1696908085640; Mon, 09
 Oct 2023 20:21:25 -0700 (PDT)
Date:   Tue, 10 Oct 2023 03:21:14 +0000
In-Reply-To: <20231010032117.1577496-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20231010032117.1577496-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231010032117.1577496-4-yosryahmed@google.com>
Subject: [PATCH v2 3/5] mm: memcg: make stats flushing threshold per-memcg
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
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

A global counter for the magnitude of memcg stats update is maintained
on the memcg side to avoid invoking rstat flushes when the pending
updates are not significant. This avoids unnecessary flushes, which are
not very cheap even if there isn't a lot of stats to flush. It also
avoids unnecessary lock contention on the underlying global rstat lock.

Make this threshold per-memcg. The scheme is followed where percpu (now
also per-memcg) counters are incremented in the update path, and only
propagated to per-memcg atomics when they exceed a certain threshold.

This provides two benefits:
(a) On large machines with a lot of memcgs, the global threshold can be
reached relatively fast, so guarding the underlying lock becomes less
effective. Making the threshold per-memcg avoids this.

(b) Having a global threshold makes it hard to do subtree flushes, as we
cannot reset the global counter except for a full flush. Per-memcg
counters removes this as a blocker from doing subtree flushes, which
helps avoid unnecessary work when the stats of a small subtree are
needed.

Nothing is free, of course. This comes at a cost:
(a) A new per-cpu counter per memcg, consuming NR_CPUS * NR_MEMCGS * 4
bytes. The extra memory usage is insigificant.

(b) More work on the update side, although in the common case it will
only be percpu counter updates. The amount of work scales with the
number of ancestors (i.e. tree depth). This is not a new concept, adding
a cgroup to the rstat tree involves a parent loop, so is charging.
Testing results below show no significant regressions.

(c) The error margin in the stats for the system as a whole increases
from NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH *
NR_MEMCGS. This is probably fine because we have a similar per-memcg
error in charges coming from percpu stocks, and we have a periodic
flusher that makes sure we always flush all the stats every 2s anyway.

This patch was tested to make sure no significant regressions are
introduced on the update path as follows. The following benchmarks were
ran in a cgroup that is 4 levels deep (/sys/fs/cgroup/a/b/c/d), which is
deeper than a usual setup:

(a) neper [1] with 1000 flows and 100 threads (single machine). The
values in the table are the average of server and client throughputs in
mbps after 30 iterations, each running for 30s:

				tcp_rr		tcp_stream
Base				9504218.56	357366.84
Patched				9656205.68	356978.39
Delta				+1.6%		-0.1%
Standard Deviation		0.95%		1.03%

An increase in the performance of tcp_rr doesn't really make sense, but
it's probably in the noise. The same tests were ran with 1 flow and 1
thread but the throughput was too noisy to make any conclusions (the
averages did not show regressions nonetheless).

Looking at perf for one iteration of the above test, __mod_memcg_state()
(which is where memcg_rstat_updated() is called) does not show up at all
without this patch, but it shows up with this patch as 1.06% for tcp_rr
and 0.36% for tcp_stream.

(b) "stress-ng --vm 0 -t 1m --times --perf". I don't understand
stress-ng very well, so I am not sure that's the best way to test this,
but it spawns 384 workers and spits a lot of metrics which looks nice :)
I picked a few ones that seem to be relevant to the stats update path. I
also included cache misses as this patch introduce more atomics that may
bounce between cpu caches:

Metric			Base		Patched		Delta
Cache Misses		3.394 B/sec 	3.433 B/sec	+1.14%
Cache L1D Read		0.148 T/sec	0.154 T/sec	+4.05%
Cache L1D Read Miss	20.430 B/sec	21.820 B/sec	+6.8%
Page Faults Total	4.304 M/sec	4.535 M/sec	+5.4%
Page Faults Minor	4.304 M/sec	4.535 M/sec	+5.4%
Page Faults Major	18.794 /sec	0.000 /sec
Kmalloc			0.153 M/sec	0.152 M/sec	-0.65%
Kfree			0.152 M/sec	0.153 M/sec	+0.65%
MM Page Alloc		4.640 M/sec	4.898 M/sec	+5.56%
MM Page Free		4.639 M/sec	4.897 M/sec	+5.56%
Lock Contention Begin	0.362 M/sec	0.479 M/sec	+32.32%
Lock Contention End	0.362 M/sec	0.479 M/sec	+32.32%
page-cache add		238.057 /sec	0.000 /sec
page-cache del		6.265 /sec	6.267 /sec	-0.03%

This is only using a single run in each case. I am not sure what to
make out of most of these numbers, but they mostly seem in the noise
(some better, some worse). The lock contention numbers are interesting.
I am not sure if higher is better or worse here. No new locks or lock
sections are introduced by this patch either way.

Looking at perf, __mod_memcg_state() shows up as 0.00% with and without
this patch. This is suspicious, but I verified while stress-ng is
running that all the threads are in the right cgroup.

(3) will-it-scale page_fault tests. These tests (specifically
per_process_ops in page_fault3 test) detected a 25.9% regression before
for a change in the stats update path [2]. These are the
numbers from 30 runs (+ is good):

             LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
------------------------------+-------------+-------------+-------------
  page_fault1_per_process_ops |             |             |            |
  (A) base                    | 265207.738  | 262941.000  | 12112.379  |
  (B) patched                 | 249249.191  | 248781.000  | 8767.457   |
                              | -6.02%      | -5.39%      |            |
  page_fault1_per_thread_ops  |             |             |            |
  (A) base                    | 241618.484  | 240209.000  | 10162.207  |
  (B) patched                 | 229820.671  | 229108.000  | 7506.582   |
                              | -4.88%      | -4.62%      |            |
  page_fault1_scalability     |             |             |
  (A) base                    | 0.03545     | 0.035705    | 0.0015837  |
  (B) patched                 | 0.029952    | 0.029957    | 0.0013551  |
                              | -9.29%      | -9.35%      |            |
  page_fault2_per_process_ops |             |             |
  (A) base                    | 203916.148  | 203496.000  | 2908.331   |
  (B) patched                 | 186975.419  | 187023.000  | 1991.100   |
                              | -6.85%      | -6.90%      |            |
  page_fault2_per_thread_ops  |             |             |
  (A) base                    | 170604.972  | 170532.000  | 1624.834   |
  (B) patched                 | 163100.260  | 163263.000  | 1517.967   |
                              | -4.40%      | -4.26%      |            |
  page_fault2_scalability     |             |             |
  (A) base                    | 0.054603    | 0.054693    | 0.00080196 |
  (B) patched                 | 0.044882    | 0.044957    | 0.0011766  |
                              | -0.05%      | +0.33%      |            |
  page_fault3_per_process_ops |             |             |
  (A) base                    | 1299821.099 | 1297918.000 | 9882.872   |
  (B) patched                 | 1248700.839 | 1247168.000 | 8454.891   |
                              | -3.93%      | -3.91%      |            |
  page_fault3_per_thread_ops  |             |             |
  (A) base                    | 387216.963  | 387115.000  | 1605.760   |
  (B) patched                 | 368538.213  | 368826.000  | 1852.594   |
                              | -4.82%      | -4.72%      |            |
  page_fault3_scalability     |             |             |
  (A) base                    | 0.59909     | 0.59367     | 0.01256    |
  (B) patched                 | 0.59995     | 0.59769     | 0.010088   |
                              | +0.14%      | +0.68%      |            |

There is some microbenchmarks regressions (and some minute improvements),
but nothing outside the normal variance of this benchmark between kernel
versions. The fix for [2]  assumes that 3% is noise -- and there were no
further practical complaints), so hopefully this means that such variations
in these microbenchmarks do not reflect on practical workloads.

[1]https://github.com/google/neper
[2]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a393f1399a2b..9a586893bd3e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -627,6 +627,9 @@ struct memcg_vmstats_percpu {
 	/* Cgroup1: threshold notifications & softlimit tree updates */
 	unsigned long		nr_page_events;
 	unsigned long		targets[MEM_CGROUP_NTARGETS];
+
+	/* Stats updates since the last flush */
+	unsigned int		stats_updates;
 };
 
 struct memcg_vmstats {
@@ -641,6 +644,9 @@ struct memcg_vmstats {
 	/* Pending child counts during tree propagation */
 	long			state_pending[MEMCG_NR_STAT];
 	unsigned long		events_pending[NR_MEMCG_EVENTS];
+
+	/* Stats updates since the last flush */
+	atomic64_t		stats_updates;
 };
 
 /*
@@ -660,9 +666,7 @@ struct memcg_vmstats {
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
-static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 static u64 flush_last_time;
 
 #define FLUSH_TIME (2UL*HZ)
@@ -689,26 +693,37 @@ static void memcg_stats_unlock(void)
 	preempt_enable_nested();
 }
 
+
+static bool memcg_should_flush_stats(struct mem_cgroup *memcg)
+{
+	return atomic64_read(&memcg->vmstats->stats_updates) >
+		MEMCG_CHARGE_BATCH * num_online_cpus();
+}
+
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
+	int cpu = smp_processor_id();
 	unsigned int x;
 
 	if (!val)
 		return;
 
-	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	cgroup_rstat_updated(memcg->css.cgroup, cpu);
+
+	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
+		x = __this_cpu_add_return(memcg->vmstats_percpu->stats_updates,
+					  abs(val));
+
+		if (x < MEMCG_CHARGE_BATCH)
+			continue;
 
-	x = __this_cpu_add_return(stats_updates, abs(val));
-	if (x > MEMCG_CHARGE_BATCH) {
 		/*
-		 * If stats_flush_threshold exceeds the threshold
-		 * (>num_online_cpus()), cgroup stats update will be triggered
-		 * in __mem_cgroup_flush_stats(). Increasing this var further
-		 * is redundant and simply adds overhead in atomic update.
+		 * If @memcg is already flush-able, increasing stats_updates is
+		 * redundant. Avoid the overhead of the atomic update.
 		 */
-		if (atomic_read(&stats_flush_threshold) <= num_online_cpus())
-			atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
-		__this_cpu_write(stats_updates, 0);
+		if (!memcg_should_flush_stats(memcg))
+			atomic64_add(x, &memcg->vmstats->stats_updates);
+		__this_cpu_write(memcg->vmstats_percpu->stats_updates, 0);
 	}
 }
 
@@ -727,13 +742,12 @@ static void do_flush_stats(void)
 
 	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
 
-	atomic_set(&stats_flush_threshold, 0);
 	atomic_set(&stats_flush_ongoing, 0);
 }
 
 void mem_cgroup_flush_stats(void)
 {
-	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
+	if (memcg_should_flush_stats(root_mem_cgroup))
 		do_flush_stats();
 }
 
@@ -747,8 +761,8 @@ void mem_cgroup_flush_stats_ratelimited(void)
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
 	/*
-	 * Always flush here so that flushing in latency-sensitive paths is
-	 * as cheap as possible.
+	 * Deliberately ignore memcg_should_flush_stats() here so that flushing
+	 * in latency-sensitive paths is as cheap as possible.
 	 */
 	do_flush_stats();
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
@@ -5803,6 +5817,9 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			}
 		}
 	}
+	/* We are in a per-cpu loop here, only do the atomic write once */
+	if (atomic64_read(&memcg->vmstats->stats_updates))
+		atomic64_set(&memcg->vmstats->stats_updates, 0);
 }
 
 #ifdef CONFIG_MMU
-- 
2.42.0.609.gbb76f46606-goog

