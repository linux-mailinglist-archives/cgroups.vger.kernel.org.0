Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848D97627B9
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 02:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjGZA3M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jul 2023 20:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjGZA3L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jul 2023 20:29:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A6310FD
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 17:29:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-55b2ab496ecso3181843a12.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jul 2023 17:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690331349; x=1690936149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zFtdwb3APNn9BFhytoOm2zBYpeQvZ7p6I7QfkX2ngXo=;
        b=TpUttPVberDynUN55a/PV3Hkc/gbY69rT2pJfNpoY+GTNgKc76uD0Ws41+S1vu9upt
         HdcZAqRDdgy+BZ9/OcSzS1+eLUayT06dFBbUZP852pAzgiG/RO5253qaRqwlNWxkHQC2
         xQ+XU2gtlb929X5zrhhn2VtkXVslXS8pI5o53GVX6UY4+Li5bFNZBKrTZYaJNoCDNn0/
         g/4UG0YGNvdyeOmkEE0EIGoEC4Q9jcGFAVw7s6smMkW7Rj8JTPkePWnuNXl+Jnn6cb48
         QG6zI20QyFyLYYpe17fxjLQvUDIC3IxITcU0s0dOufk40bH24hcMJtYbub0Lqg7bvnza
         WdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690331349; x=1690936149;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zFtdwb3APNn9BFhytoOm2zBYpeQvZ7p6I7QfkX2ngXo=;
        b=PQydb2mbUeJ053lRmVA+OPhVzgmSF8onG3sbXezpAwh9SiUS68HvifZTnor7CbF2pH
         nG46mQkMvnCZeZp1zBGieOF+HHjMuFvAvJricza9g/l5Y4vUwNzr7oLxzTnr8bLJssyL
         RABGLTRfukKMIT08SDSc7DucpHM2rojWJHY5wzxTPY080LGHsSuebk1AVC4m8W/7xgWS
         k/+JMDeqLofgBe4e4pVlybY0Sa56YzIA4DE3WgdSUYSTMbQa8yvbnys/r5obqbDXfCOR
         7ijUrUmxM32nDK3zjKwFNUmyIKEwEvtaEoahnCwQ0yyg331kQsYuuPQYnzSc6ewbpEuT
         zZfQ==
X-Gm-Message-State: ABy/qLbWqGcALcKFXlrd1drF+O6O9wFw3jfP9gwn++1edGuTAP4y6dO1
        WAzRJ995LjwqVgKgaj9i3h8W0Bf/PrCfh0JO
X-Google-Smtp-Source: APBJJlGpv/lmB9D4mhC4EimIMkJrIevPcEoC2bsCQucZc02Ly0ifQqwwRhMQwJ0e4/syS5zyNUySOmG7z59Wjqxc
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:7f1c:0:b0:553:3ba2:f36 with SMTP id
 a28-20020a637f1c000000b005533ba20f36mr3143pgd.9.1690331349329; Tue, 25 Jul
 2023 17:29:09 -0700 (PDT)
Date:   Wed, 26 Jul 2023 00:29:04 +0000
In-Reply-To: <20230726002904.655377-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230726002904.655377-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726002904.655377-2-yosryahmed@google.com>
Subject: [PATCH v2] mm: memcg: use rstat for non-hierarchical stats
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, memcg uses rstat to maintain hierarchical stats. Counters are
maintained for hierarchical stats at each memcg. Rstat tracks which
cgroups have updates on which cpus to keep those counters fresh on the
read-side.

For non-hierarchical stats, we do not maintain counters. Instead, the
percpu counters for a given stat need to be summed to get the
non-hierarchical stat value. The original implementation did the same.
At some point before rstat, non-hierarchical counters were introduced by
commit a983b5ebee57 ("mm: memcontrol: fix excessive complexity in
memory.stat reporting"). However, those counters were updated on the
performance critical write-side, which caused regressions, so they were
later removed by commit 815744d75152 ("mm: memcontrol: don't batch
updates of local VM stats and events"). See [1] for more detailed
history.

Kernel versions in between a983b5ebee57 & 815744d75152 (a year and a
half) enjoyed cheap reads of non-hierarchical stats, specifically on
cgroup v1. When moving to more recent kernels, a performance regression
for reading non-hierarchical stats is observed.

Now that we have rstat, we know exactly which percpu counters have
updates for each stat. We can maintain non-hierarchical counters again,
making reads much more efficient, without affecting the performance
critical write-side. Hence, add non-hierarchical (i.e local) counters
for the stats, and extend rstat flushing to keep those up-to-date.

A caveat is that we now a stats flush before reading
local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
or memcg_events_local(), where we previously only needed a flush to
read hierarchical stats. Most contexts reading non-hierarchical stats
are already doing a flush, add a flush to the only missing context in
count_shadow_nodes().

With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
machine with 256 cpus on cgroup v1:
 # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
 # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
 real	 0m0.125s
 user	 0m0.005s
 sys	 0m0.120s

After:
 real	 0m0.032s
 user	 0m0.005s
 sys	 0m0.027s

[1]https://lore.kernel.org/lkml/20230725201811.GA1231514@cmpxchg.org/

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---

v1 -> v2:
- Rewrite the changelog based on the history context provided by
  Johannes (Thanks!).
- Fix a subtle bug where updating a local counter would be missed if it
  was cancelled out by a pending update from child memcgs.

---
 include/linux/memcontrol.h |  7 ++--
 mm/memcontrol.c            | 67 +++++++++++++++++++++-----------------
 mm/workingset.c            |  1 +
 3 files changed, 43 insertions(+), 32 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 5818af8eca5a..a9f2861a57a5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -112,6 +112,9 @@ struct lruvec_stats {
 	/* Aggregated (CPU and subtree) state */
 	long state[NR_VM_NODE_STAT_ITEMS];
 
+	/* Non-hierarchical (CPU aggregated) state */
+	long state_local[NR_VM_NODE_STAT_ITEMS];
+
 	/* Pending child counts during tree propagation */
 	long state_pending[NR_VM_NODE_STAT_ITEMS];
 };
@@ -1020,14 +1023,12 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
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
index e8ca4bdcb03c..50f8035e998a 100644
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
@@ -5526,7 +5523,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct memcg_vmstats_percpu *statc;
-	long delta, v;
+	long delta, delta_cpu, v;
 	int i, nid;
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
@@ -5542,19 +5539,23 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
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
@@ -5562,18 +5563,22 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
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
@@ -5591,18 +5596,22 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
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
2.41.0.487.g6d72f3e995-goog

