Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA8676F303
	for <lists+cgroups@lfdr.de>; Thu,  3 Aug 2023 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjHCSv1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Aug 2023 14:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjHCSv0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Aug 2023 14:51:26 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE2344B9
        for <cgroups@vger.kernel.org>; Thu,  3 Aug 2023 11:50:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5840614b13cso21298997b3.0
        for <cgroups@vger.kernel.org>; Thu, 03 Aug 2023 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691088649; x=1691693449;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1XyQ/ZegLbwguWS1UpeIGzNx959kwuq92WVqqIghPaA=;
        b=5lrHqege0J6Q+nTQjju/1hs3TARjmexNgoAE2A9oG9GF2NC2KD1hUJ7HaPG/gRMhkQ
         rRQefydgm0kytCsXqbAgd1S2i3d+MPxOQDcxsSH4Af3Cte4QEiM6ZJlmNkwNNVN7IIiH
         1XEc6we68gQMUoCp/2JetDLXcbXQIHYLfl1LdUl+vosg84WXC8GWVXbgc6uyLZldxyeT
         PTOSMPGWfrM0L9cioRb7+Dil5J5+VfpN94tUq/Josdqo5hq3xuHtMIernY6tKkN8d8wr
         Z7EfeopWF6FEzvu6p1JCiglQluqndliVsPsd1kTtqooCDKQNUF1UFsMM0F3tAsVDZqyA
         ZR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691088649; x=1691693449;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XyQ/ZegLbwguWS1UpeIGzNx959kwuq92WVqqIghPaA=;
        b=JP8QxmChO9fuk6otNm9pkKt0JDyFItkKS1y/9QRpzbhY8lCcVeSQCpcESWK9zTDLci
         XcYWBh60dpkEECvxAnj69uSioYqAowePoJhCm5SirV55zdb1Cl5H/2e+dbCR4gA9oCv9
         KBikSSI4AL5EScIcyzmB56eaEKprXVAihi7UFXfQI21iwcryuycdly/BpAY0ShA4492z
         /tvpWPX3/tBYkCZEqleaR2mpVPfkdHSow9St+wqPlAwrJVuJ8pKsQy1k3rP+27T6z1qf
         XxIMSksB3eP6RBFybIbY944y1g6b+OfN1ZiEpL+ZDnt8ox2Ak88r9z4HYvlZf2Yhul9M
         OdLQ==
X-Gm-Message-State: ABy/qLZsxG+GolQFk96NU3vCS7WZ/ZZDzpsxuyCXiGpym2kk1XCN2YjL
        RpUNw5Sa7oFaI7SZbv5U9mt0Aoqq/vSHeoie
X-Google-Smtp-Source: APBJJlHI2nVKiol9et2npfTT5QKoKbQD2ArkaR13nsAGLsR8kw/O9V61X2Ty/DNHrqH+I1hNa2NJ+dRN6ofI4XIw
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a81:788e:0:b0:57a:6019:62aa with SMTP
 id t136-20020a81788e000000b0057a601962aamr263668ywc.5.1691088649209; Thu, 03
 Aug 2023 11:50:49 -0700 (PDT)
Date:   Thu,  3 Aug 2023 18:50:46 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803185046.1385770-1-yosryahmed@google.com>
Subject: [PATCH v4] mm: memcg: use rstat for non-hierarchical stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, memcg uses rstat to maintain aggregated hierarchical stats.
Counters are maintained for hierarchical stats at each memcg.  Rstat
tracks which cgroups have updates on which cpus to keep those counters
fresh on the read-side.

Non-hierarchical stats are currently not covered by rstat.  Their per-cpu
counters are summed up on every read, which is expensive.  The original
implementation did the same.  At some point before rstat, non-hierarchical
aggregated counters were introduced by commit a983b5ebee57 ("mm:
memcontrol: fix excessive complexity in memory.stat reporting").  However,
those counters were updated on the performance critical write-side, which
caused regressions, so they were later removed by commit 815744d75152
("mm: memcontrol: don't batch updates of local VM stats and events").  See
[1] for more detailed history.

Kernel versions in between a983b5ebee57 & 815744d75152 (a year and a half)
enjoyed cheap reads of non-hierarchical stats, specifically on cgroup v1.
When moving to more recent kernels, a performance regression for reading
non-hierarchical stats is observed.

Now that we have rstat, we know exactly which percpu counters have updates
for each stat.  We can maintain non-hierarchical counters again, making
reads much more efficient, without affecting the performance critical
write-side.  Hence, add non-hierarchical (i.e local) counters for the
stats, and extend rstat flushing to keep those up-to-date.

A caveat is that we now need a stats flush before reading
local/non-hierarchical stats through {memcg/lruvec}_page_state_local() or
memcg_events_local(), where we previously only needed a flush to read
hierarchical stats.  Most contexts reading non-hierarchical stats are
already doing a flush, add a flush to the only missing context in
count_shadow_nodes().

With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
machine with 256 cpus on cgroup v1:

 # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
 # time cat /sys/fs/cgroup/memory/cg*/memory.stat > /dev/null
 real	 0m0.125s
 user	 0m0.005s
 sys	 0m0.120s

After:
 real	 0m0.032s
 user	 0m0.005s
 sys	 0m0.027s

To make sure there are no regressions on cgroup v2, I ran an artificial
reclaim/refault stress test [2] that creates (NR_CPUS *
2) cgroups, assigns them limits, runs a worker process in each cgroup
that allocates tmpfs memory equal to quadruple the limit (to invoke
reclaim continuously), and then reads back the entire file (to invoke
refaults). All workers are run in parallel, and zram is used as a
swapping backend. Both reclaim and refault have conditional stats
flushing. I ran this on a machine with 112 cpus, once on mm-unstable,
and once on mm-unstable with this patch reverted.

(1) A few runs without this patch:

 # time ./stress_reclaim_refault.sh
 real 0m9.949s
 user 0m0.496s
 sys 14m44.974s

 # time ./stress_reclaim_refault.sh
 real 0m10.049s
 user 0m0.486s
 sys 14m55.791s

 # time ./stress_reclaim_refault.sh
 real 0m9.984s
 user 0m0.481s
 sys 14m53.841s

(2) A few runs with this patch:

 # time ./stress_reclaim_refault.sh
 real 0m9.885s
 user 0m0.486s
 sys 14m48.753s

 # time ./stress_reclaim_refault.sh
 real 0m9.903s
 user 0m0.495s
 sys 14m48.339s

 # time ./stress_reclaim_refault.sh
 real 0m9.861s
 user 0m0.507s
 sys 14m49.317s

No regressions are observed with this patch. There is actually a very
slight improvement. If I have to guess, maybe it's because we avoid
the percpu loop in count_shadow_nodes() when calling
lruvec_page_state_local(), but I could not prove this using perf, it's
probably in the noise.

[1] https://lore.kernel.org/lkml/20230725201811.GA1231514@cmpxchg.org/
[2] https://lore.kernel.org/lkml/CAJD7tkb17x=qwoO37uxyYXLEUVp15BQKR+Xfh7Sg9Hx-wTQ_=w@mail.gmail.com/

Link: https://lkml.kernel.org/r/20230726153223.821757-2-yosryahmed@google.com
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
---

v3 -> v4:
- Added A-b from Michal Hocko (Thanks!).
- Amended the changelog with additional testing for regressions (as
  requested by Michal Hocko).

v3: https://lore.kernel.org/lkml/20230726153223.821757-2-yosryahmed@google.com/

---
 include/linux/memcontrol.h |  7 ++--
 mm/memcontrol.c            | 67 +++++++++++++++++++++-----------------
 mm/workingset.c            |  1 +
 3 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 058fb748e128..e765d1ff9cbb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -111,6 +111,9 @@ struct lruvec_stats {
 	/* Aggregated (CPU and subtree) state */
 	long state[NR_VM_NODE_STAT_ITEMS];
 
+	/* Non-hierarchical (CPU aggregated) state */
+	long state_local[NR_VM_NODE_STAT_ITEMS];
+
 	/* Pending child counts during tree propagation */
 	long state_pending[NR_VM_NODE_STAT_ITEMS];
 };
@@ -1019,14 +1022,12 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 {
 	struct mem_cgroup_per_node *pn;
 	long x = 0;
-	int cpu;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	for_each_possible_cpu(cpu)
-		x += per_cpu(pn->lruvec_stats_percpu->state[idx], cpu);
+	x = READ_ONCE(pn->lruvec_stats.state_local[idx]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 062d925336cb..35d7e66ab032 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -742,6 +742,10 @@ struct memcg_vmstats {
 	long			state[MEMCG_NR_STAT];
 	unsigned long		events[NR_MEMCG_EVENTS];
 
+	/* Non-hierarchical (CPU aggregated) page state & events */
+	long			state_local[MEMCG_NR_STAT];
+	unsigned long		events_local[NR_MEMCG_EVENTS];
+
 	/* Pending child counts during tree propagation */
 	long			state_pending[MEMCG_NR_STAT];
 	unsigned long		events_pending[NR_MEMCG_EVENTS];
@@ -775,11 +779,8 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
 static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 {
-	long x = 0;
-	int cpu;
+	long x = READ_ONCE(memcg->vmstats->state_local[idx]);
 
-	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_percpu->state[idx], cpu);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -926,16 +927,12 @@ static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 
 static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
-	long x = 0;
-	int cpu;
 	int index = memcg_events_index(event);
 
 	if (index < 0)
 		return 0;
 
-	for_each_possible_cpu(cpu)
-		x += per_cpu(memcg->vmstats_percpu->events[index], cpu);
-	return x;
+	return READ_ONCE(memcg->vmstats->events_local[index]);
 }
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
@@ -5517,7 +5514,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct memcg_vmstats_percpu *statc;
-	long delta, v;
+	long delta, delta_cpu, v;
 	int i, nid;
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
@@ -5533,19 +5530,23 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			memcg->vmstats->state_pending[i] = 0;
 
 		/* Add CPU changes on this level since the last flush */
+		delta_cpu = 0;
 		v = READ_ONCE(statc->state[i]);
 		if (v != statc->state_prev[i]) {
-			delta += v - statc->state_prev[i];
+			delta_cpu = v - statc->state_prev[i];
+			delta += delta_cpu;
 			statc->state_prev[i] = v;
 		}
 
-		if (!delta)
-			continue;
-
 		/* Aggregate counts on this level and propagate upwards */
-		memcg->vmstats->state[i] += delta;
-		if (parent)
-			parent->vmstats->state_pending[i] += delta;
+		if (delta_cpu)
+			memcg->vmstats->state_local[i] += delta_cpu;
+
+		if (delta) {
+			memcg->vmstats->state[i] += delta;
+			if (parent)
+				parent->vmstats->state_pending[i] += delta;
+		}
 	}
 
 	for (i = 0; i < NR_MEMCG_EVENTS; i++) {
@@ -5553,18 +5554,22 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (delta)
 			memcg->vmstats->events_pending[i] = 0;
 
+		delta_cpu = 0;
 		v = READ_ONCE(statc->events[i]);
 		if (v != statc->events_prev[i]) {
-			delta += v - statc->events_prev[i];
+			delta_cpu = v - statc->events_prev[i];
+			delta += delta_cpu;
 			statc->events_prev[i] = v;
 		}
 
-		if (!delta)
-			continue;
+		if (delta_cpu)
+			memcg->vmstats->events_local[i] += delta_cpu;
 
-		memcg->vmstats->events[i] += delta;
-		if (parent)
-			parent->vmstats->events_pending[i] += delta;
+		if (delta) {
+			memcg->vmstats->events[i] += delta;
+			if (parent)
+				parent->vmstats->events_pending[i] += delta;
+		}
 	}
 
 	for_each_node_state(nid, N_MEMORY) {
@@ -5582,18 +5587,22 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			if (delta)
 				pn->lruvec_stats.state_pending[i] = 0;
 
+			delta_cpu = 0;
 			v = READ_ONCE(lstatc->state[i]);
 			if (v != lstatc->state_prev[i]) {
-				delta += v - lstatc->state_prev[i];
+				delta_cpu = v - lstatc->state_prev[i];
+				delta += delta_cpu;
 				lstatc->state_prev[i] = v;
 			}
 
-			if (!delta)
-				continue;
+			if (delta_cpu)
+				pn->lruvec_stats.state_local[i] += delta_cpu;
 
-			pn->lruvec_stats.state[i] += delta;
-			if (ppn)
-				ppn->lruvec_stats.state_pending[i] += delta;
+			if (delta) {
+				pn->lruvec_stats.state[i] += delta;
+				if (ppn)
+					ppn->lruvec_stats.state_pending[i] += delta;
+			}
 		}
 	}
 }
diff --git a/mm/workingset.c b/mm/workingset.c
index 4686ae363000..da58a26d0d4d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -664,6 +664,7 @@ static unsigned long count_shadow_nodes(struct shrinker *shrinker,
 		struct lruvec *lruvec;
 		int i;
 
+		mem_cgroup_flush_stats();
 		lruvec = mem_cgroup_lruvec(sc->memcg, NODE_DATA(sc->nid));
 		for (pages = 0, i = 0; i < NR_LRU_LISTS; i++)
 			pages += lruvec_page_state_local(lruvec,
-- 
2.41.0.585.gd2178a4bd4-goog

