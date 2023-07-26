Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE00763B1E
	for <lists+cgroups@lfdr.de>; Wed, 26 Jul 2023 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjGZPc2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jul 2023 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjGZPc2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jul 2023 11:32:28 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D02137
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:32:26 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55b2ab496ecso3587458a12.2
        for <cgroups@vger.kernel.org>; Wed, 26 Jul 2023 08:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690385546; x=1690990346;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6e7KuyR5qZ6xCXotERLteVBuiZtk31A4XosqK7/beqs=;
        b=hfmPlDHM//CdQxH+FNIMT9hQbrC5TE6d8oSs8Vv3mFiP4Yxwh7Xq1zE+ghsQM8ajLS
         olrZ91m4ZNbAzyVhUJhdPivUPF6QJQRQAayqxgM/FN2zEJid/T6tjet02urwcqQxVKF1
         pCg+I6e+Ta528ZDcEtCTuCt6TiQlXHF0HP2YCupLkIaW60OXug/z+5yCXlDH2YCLILTA
         PUkeLHGe6j/IAncLqmGK1bNCU6UJ4OjkbCI4ofsyLm+1RTbDqmHfZec680qFCaCQj7om
         es60ZBquPQbMI1+MuI/U2OxUwsiZfBb73DZrgdsIzZP2dRli5JaZWa5K+FXgQMJU/qLp
         hJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690385546; x=1690990346;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6e7KuyR5qZ6xCXotERLteVBuiZtk31A4XosqK7/beqs=;
        b=A35qpYBlUlHaqe1YqyqyLYWv1gZ43nnuMVLj9Fl3lsjyZ6fgnbXMm0yaC379kClOO1
         a/GDrDJO3Pr//rypdPAoZV6q/KvvH+OmK6v9K2E7wNWO5wms4SxlYTxrcVv9OPEoubA+
         E8OrsEgDbLGF/I/c8XJJ4At912EqElbJ67wZoCnoU7S3UGarUBrtXSwLkYEt1tXULDcU
         UhWGtWcuorHYn0nE8goBeKdvvmts13Ig2hooQq/VsGY+AFw+wU6T97rpPQS6BQ1uZEhU
         M90EWiFM1QvAshoTnpz7/NKP62iZ6Of2n9UT3TVpfK++Jf/z5uRu7kpxNla3I/GgXXKc
         SaGQ==
X-Gm-Message-State: ABy/qLZFxGyCCfeAwe1WqPtsWepV12hiRelIwmACYbl6ElsMSAKN08+d
        CGgnim+Oe7uGeROt/M9ekyin6CGHaKTGqZx0
X-Google-Smtp-Source: APBJJlEV1psb6hrUYzZ2qUbPMrxy2521kIy5mUO3uhqYVmcWuVNKPwnbr0Im3ZM2ll6UD7qKcSrZwb+nh29ttbHg
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a63:7f1c:0:b0:553:3ba2:f36 with SMTP id
 a28-20020a637f1c000000b005533ba20f36mr10273pgd.9.1690385546207; Wed, 26 Jul
 2023 08:32:26 -0700 (PDT)
Date:   Wed, 26 Jul 2023 15:32:22 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230726153223.821757-1-yosryahmed@google.com>
Subject: [PATCH] mm: memcg: use rstat for non-hierarchical stats
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Currently, memcg uses rstat to maintain hierarchical stats. The rstat
framework keeps track of which cgroups have updates on which cpus.

For non-hierarchical stats, as memcg moved to rstat, they are no longer
readily available as counters. Instead, the percpu counters for a given
stat need to be summed to get the non-hierarchical stat value. This
causes a performance regression when reading non-hierarchical stats on
kernels where memcg moved to using rstat. This is especially visible
when reading memory.stat on cgroup v1. There are also some code paths
internal to the kernel that read such non-hierarchical stats.

It is inefficient to iterate and sum counters in all cpus when the rstat
framework knows exactly when a percpu counter has an update. Instead,
maintain cpu-aggregated non-hierarchical counters for each stat. During
an rstat flush, keep those updated as well. When reading
non-hierarchical stats, we no longer need to iterate cpus, we just need
to read the maintainer counters, similar to hierarchical stats.

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

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/memcontrol.h |  7 ++++---
 mm/memcontrol.c            | 32 +++++++++++++++++++-------------
 mm/workingset.c            |  1 +
 3 files changed, 24 insertions(+), 16 deletions(-)

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
index e8ca4bdcb03c..90a22637818e 100644
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
@@ -5542,9 +5539,11 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
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
 
@@ -5553,6 +5552,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 
 		/* Aggregate counts on this level and propagate upwards */
 		memcg->vmstats->state[i] += delta;
+		memcg->vmstats->state_local[i] += delta_cpu;
 		if (parent)
 			parent->vmstats->state_pending[i] += delta;
 	}
@@ -5562,9 +5562,11 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
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
 
@@ -5572,6 +5574,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			continue;
 
 		memcg->vmstats->events[i] += delta;
+		memcg->vmstats->events_local[i] += delta_cpu;
 		if (parent)
 			parent->vmstats->events_pending[i] += delta;
 	}
@@ -5591,9 +5594,11 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
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
 
@@ -5601,6 +5606,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 				continue;
 
 			pn->lruvec_stats.state[i] += delta;
+			pn->lruvec_stats.state_local[i] += delta_cpu;
 			if (ppn)
 				ppn->lruvec_stats.state_pending[i] += delta;
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
2.41.0.255.g8b1d071c50-goog

