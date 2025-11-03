Return-Path: <cgroups+bounces-11495-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C9BC2A710
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 08:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F324EF6A6
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC26D2C0F66;
	Mon,  3 Nov 2025 07:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="avRt75Sr"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5802BE7B5
	for <cgroups@vger.kernel.org>; Mon,  3 Nov 2025 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156411; cv=none; b=qSqDwjjMh0tvQvvBxjwLlrnwSFBsR8LlX70R7hbmvHOjOpZInrods5PGKddC/rRe3GeWUQt0x25LqiW/87E1oxucsG6sKq5BjGVNRytthJMeoC4FiKMwet9juMLmlRAvMuP7hP9Zjk98+V3Mwpg4AmhqOwUkKWQmMLrvXX16g0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156411; c=relaxed/simple;
	bh=DAl6x1WW+sdgvs4yNNBh1LtvTW7dfzKVhNfdGn4NeFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4ptmWf6Uo9xDo1ZamNYZB1viVYHIfhThL4Cl87D2cvR4LxeNxrBOgC4XWglETS5Vv6BIRNuMLhLGxQgTEBUWPCgjtZZPLyGAAmtxUZK9cMLmPAdgi6zlOhES6lYkCtQR96exwc4Yo3+zjGDPmOxSY3xyOZrMiJHFq+If0gykCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=avRt75Sr; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so706009b3a.0
        for <cgroups@vger.kernel.org>; Sun, 02 Nov 2025 23:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1762156408; x=1762761208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ba4jPz4GzIpOX2boFuFrVZ/wgd/V0hgb12GzaY8s2GM=;
        b=avRt75SrlEMRN6VHUrUG4/hxcSr/9e7hT8Lm4RVgI12j9XLFLeyv5LOpocBcQXqoHk
         AazKna8UPo/iQ9pIXo1ShuuTadSBN52RkDlzC2kWfV2k7++otXY+dRpyTopzKvObGoU/
         MhaiWdvXhB/sr4rEjHcy2IKPHBBYh9i52H4SE12JKUBui4IqiuPyKgVz0KkwI3qy0pcL
         UuTch5Gy0SG2WHkhXwFCrMqxkOWuYWrt9erQALgIviHqetle8/DSjEoGsfaPDLWFGgem
         5CRE4yo4kncazmWhFKnKLFNjQZmpda5lvwjGC2mptl+l6Ut8CwW0A1iovY7fEWFbKQWC
         utRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156408; x=1762761208;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ba4jPz4GzIpOX2boFuFrVZ/wgd/V0hgb12GzaY8s2GM=;
        b=owvCSoa7B0vHU6TdXcSS+LgOUbGO9QtTcstVLXr+mrjdu1Qz375qHpCyqTaBaEYeL9
         tGMCtGLirQSx/VZFcnukfN1UqjCZ3b8CtHi9In9Z9QEeKBjRDj/vxuMvjWXr6PhIyHgT
         LduDYEnU0ZsJ67nrnZbU/6ydahIy3RsXYfq7rXiVAtHgCIRLJ+trHb4pBD+7uBoIPKz+
         NgfwnONb752GKG2/7e7NDKj6Ryn/YAynBu+HV/CdB5D/5nLhlw3geS2RTb55s6+u08Fu
         Kll/1RlCho5ZqGhvTtBjsTqrp9UqhK68H1btMdvAgkvATk1jKKPHiROJo2dhKEmfHc6s
         qMeg==
X-Forwarded-Encrypted: i=1; AJvYcCUToFb0NzuUgzKnwd0DgP0LijNBWiDxOfURN5I7pML7U/7NrN8X4RACM0uWubheCxoFFMxvdZCj@vger.kernel.org
X-Gm-Message-State: AOJu0YyiLnQ5vVxGqkBAAPTCATAUs+PgJEkyCnhepu1AUsUSd30CcvUB
	rgoUGc9vNzs/ViNkh8zTzQO6os4RdlwRbMNk8V4T3NwUpUJyeX3tg6YinmYw9f9BsVE=
X-Gm-Gg: ASbGncv0DtHtgB30H2Pg6UugrgUFZp4p+GA2amtSxcH+3SNV7mk/sduABv6r7tHvaPp
	khFuPEpeE9S0bO97eS26ExELxWd8klWAS3OzQ04vSzApdr4R5wCvn2SIh424B1EEIaetzipy8q1
	E6JyY7W+NpfHCCCQLuoiceOp34ETd4aeWbSF2jHOXx0WdDqlCMxF9e1UK6DTAxPgNJV77WWrXP7
	+JHTV8M3Tjrn26L1W1wqW8RDRUNoc/gq6q6cMd4OF/IB5YHftvXGsKO8RZhg+tJ9k6No0dqC6Pt
	7LcumuyqnVuNRFhVCHh8OV1QQ6pwJxa9kfV/m7k2hJYXg5OtyzpKNzAHBPi8c69bsbxNvfJrhtq
	G/R4oP7c/ogpMMBb5VfxJWAoLQKkFylGF1hgDT42rSMc3kIJge0+dL0nUECZIAsyfzTse5l6x3G
	fCmawXB71sZNZyKw==
X-Google-Smtp-Source: AGHT+IGWNo1R+qKvdYnQyYk2CzdvOoi6Va0W2v8DV/ljaASF7VURewKuzp1i6g4RA/RRpxV0UmwQ/w==
X-Received: by 2002:a05:6a20:7344:b0:311:99:7524 with SMTP id adf61e73a8af0-348ca351af3mr15450451637.18.1762156407934;
        Sun, 02 Nov 2025 23:53:27 -0800 (PST)
Received: from .shopee.com ([122.11.166.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a16652sm34552a91.20.2025.11.02.23.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 23:53:27 -0800 (PST)
From: Leon Huang Fu <leon.huangfu@shopee.com>
To: stable@vger.kernel.org,
	greg@kroah.com
Cc: tj@kernel.org,
	lizefan.x@bytedance.com,
	hannes@cmpxchg.org,
	corbet@lwn.net,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeelb@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	sjenning@redhat.com,
	ddstreet@ieee.org,
	vitaly.wool@konsulko.com,
	lance.yang@linux.dev,
	leon.huangfu@shopee.com,
	shy828301@gmail.com,
	yosryahmed@google.com,
	sashal@kernel.org,
	vishal.moola@gmail.com,
	cerasuolodomenico@gmail.com,
	nphamcs@gmail.com,
	cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Chris Li <chrisl@kernel.org>,
	Greg Thelen <gthelen@google.com>,
	Ivan Babrou <ivan@cloudflare.com>,
	Michal Koutny <mkoutny@suse.com>,
	Waiman Long <longman@redhat.com>,
	Wei Xu <weixugc@google.com>
Subject: [PATCH 6.6.y 5/7] mm: memcg: make stats flushing threshold per-memcg
Date: Mon,  3 Nov 2025 15:51:33 +0800
Message-ID: <20251103075135.20254-6-leon.huangfu@shopee.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103075135.20254-1-leon.huangfu@shopee.com>
References: <20251103075135.20254-1-leon.huangfu@shopee.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yosry Ahmed <yosryahmed@google.com>

[ Upstream commit 8d59d2214c2362e7a9d185d80b613e632581af7b ]

A global counter for the magnitude of memcg stats update is maintained on
the memcg side to avoid invoking rstat flushes when the pending updates
are not significant.  This avoids unnecessary flushes, which are not very
cheap even if there isn't a lot of stats to flush.  It also avoids
unnecessary lock contention on the underlying global rstat lock.

Make this threshold per-memcg.  The scheme is followed where percpu (now
also per-memcg) counters are incremented in the update path, and only
propagated to per-memcg atomics when they exceed a certain threshold.

This provides two benefits: (a) On large machines with a lot of memcgs,
the global threshold can be reached relatively fast, so guarding the
underlying lock becomes less effective.  Making the threshold per-memcg
avoids this.

(b) Having a global threshold makes it hard to do subtree flushes, as we
cannot reset the global counter except for a full flush.  Per-memcg
counters removes this as a blocker from doing subtree flushes, which helps
avoid unnecessary work when the stats of a small subtree are needed.

Nothing is free, of course.  This comes at a cost: (a) A new per-cpu
counter per memcg, consuming NR_CPUS * NR_MEMCGS * 4 bytes.  The extra
memory usage is insigificant.

(b) More work on the update side, although in the common case it will only
be percpu counter updates.  The amount of work scales with the number of
ancestors (i.e.  tree depth).  This is not a new concept, adding a cgroup
to the rstat tree involves a parent loop, so is charging.  Testing results
below show no significant regressions.

(c) The error margin in the stats for the system as a whole increases from
NR_CPUS * MEMCG_CHARGE_BATCH to NR_CPUS * MEMCG_CHARGE_BATCH * NR_MEMCGS.
This is probably fine because we have a similar per-memcg error in charges
coming from percpu stocks, and we have a periodic flusher that makes sure
we always flush all the stats every 2s anyway.

This patch was tested to make sure no significant regressions are
introduced on the update path as follows.  The following benchmarks were
ran in a cgroup that is 2 levels deep (/sys/fs/cgroup/a/b/):

(1) Running 22 instances of netperf on a 44 cpu machine with
hyperthreading disabled. All instances are run in a level 2 cgroup, as
well as netserver:
  # netserver -6
  # netperf -6 -H ::1 -l 60 -t TCP_SENDFILE -- -m 10K

Averaging 20 runs, the numbers are as follows:
Base: 40198.0 mbps
Patched: 38629.7 mbps (-3.9%)

The regression is minimal, especially for 22 instances in the same
cgroup sharing all ancestors (so updating the same atomics).

(2) will-it-scale page_fault tests. These tests (specifically
per_process_ops in page_fault3 test) detected a 25.9% regression before
for a change in the stats update path [1]. These are the
numbers from 10 runs (+ is good) on a machine with 256 cpus:

             LABEL            |     MEAN    |   MEDIAN    |   STDDEV   |
------------------------------+-------------+-------------+-------------
  page_fault1_per_process_ops |             |             |            |
  (A) base                    | 270249.164  | 265437.000  | 13451.836  |
  (B) patched                 | 261368.709  | 255725.000  | 13394.767  |
                              | -3.29%      | -3.66%      |            |
  page_fault1_per_thread_ops  |             |             |            |
  (A) base                    | 242111.345  | 239737.000  | 10026.031  |
  (B) patched                 | 237057.109  | 235305.000  | 9769.687   |
                              | -2.09%      | -1.85%      |            |
  page_fault1_scalability     |             |             |
  (A) base                    | 0.034387    | 0.035168    | 0.0018283  |
  (B) patched                 | 0.033988    | 0.034573    | 0.0018056  |
                              | -1.16%      | -1.69%      |            |
  page_fault2_per_process_ops |             |             |
  (A) base                    | 203561.836  | 203301.000  | 2550.764   |
  (B) patched                 | 197195.945  | 197746.000  | 2264.263   |
                              | -3.13%      | -2.73%      |            |
  page_fault2_per_thread_ops  |             |             |
  (A) base                    | 171046.473  | 170776.000  | 1509.679   |
  (B) patched                 | 166626.327  | 166406.000  | 768.753    |
                              | -2.58%      | -2.56%      |            |
  page_fault2_scalability     |             |             |
  (A) base                    | 0.054026    | 0.053821    | 0.00062121 |
  (B) patched                 | 0.053329    | 0.05306     | 0.00048394 |
                              | -1.29%      | -1.41%      |            |
  page_fault3_per_process_ops |             |             |
  (A) base                    | 1295807.782 | 1297550.000 | 5907.585   |
  (B) patched                 | 1275579.873 | 1273359.000 | 8759.160   |
                              | -1.56%      | -1.86%      |            |
  page_fault3_per_thread_ops  |             |             |
  (A) base                    | 391234.164  | 390860.000  | 1760.720   |
  (B) patched                 | 377231.273  | 376369.000  | 1874.971   |
                              | -3.58%      | -3.71%      |            |
  page_fault3_scalability     |             |             |
  (A) base                    | 0.60369     | 0.60072     | 0.0083029  |
  (B) patched                 | 0.61733     | 0.61544     | 0.009855   |
                              | +2.26%      | +2.45%      |            |

All regressions seem to be minimal, and within the normal variance for the
benchmark.  The fix for [1] assumes that 3% is noise -- and there were no
further practical complaints), so hopefully this means that such
variations in these microbenchmarks do not reflect on practical workloads.

(3) I also ran stress-ng in a nested cgroup and did not observe any
obvious regressions.

[1]https://lore.kernel.org/all/20190520063534.GB19312@shao2-debian/

Link: https://lkml.kernel.org/r/20231129032154.3710765-4-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Cc: Chris Li <chrisl@kernel.org>
Cc: Greg Thelen <gthelen@google.com>
Cc: Ivan Babrou <ivan@cloudflare.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutny <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Wei Xu <weixugc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Leon Huang Fu <leon.huangfu@shopee.com>
---
 mm/memcontrol.c | 50 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 157be6820fd1..c31a5364f325 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -628,6 +628,9 @@ struct memcg_vmstats_percpu {
 	/* Cgroup1: threshold notifications & softlimit tree updates */
 	unsigned long		nr_page_events;
 	unsigned long		targets[MEM_CGROUP_NTARGETS];
+
+	/* Stats updates since the last flush */
+	unsigned int		stats_updates;
 };

 struct memcg_vmstats {
@@ -642,6 +645,9 @@ struct memcg_vmstats {
 	/* Pending child counts during tree propagation */
 	long			state_pending[MEMCG_NR_STAT];
 	unsigned long		events_pending[NR_MEMCG_EVENTS];
+
+	/* Stats updates since the last flush */
+	atomic64_t		stats_updates;
 };

 /*
@@ -661,9 +667,7 @@ struct memcg_vmstats {
  */
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
-static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_ongoing = ATOMIC_INIT(0);
-static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 static u64 flush_last_time;

 #define FLUSH_TIME (2UL*HZ)
@@ -690,26 +694,37 @@ static void memcg_stats_unlock(void)
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

@@ -728,13 +743,12 @@ static void do_flush_stats(void)

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

@@ -748,8 +762,8 @@ void mem_cgroup_flush_stats_ratelimited(void)
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
@@ -5658,6 +5672,10 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			}
 		}
 	}
+	statc->stats_updates = 0;
+	/* We are in a per-cpu loop here, only do the atomic write once */
+	if (atomic64_read(&memcg->vmstats->stats_updates))
+		atomic64_set(&memcg->vmstats->stats_updates, 0);
 }

 #ifdef CONFIG_MMU
--
2.50.1

