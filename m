Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F6D50A388
	for <lists+cgroups@lfdr.de>; Thu, 21 Apr 2022 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbiDUPC7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Apr 2022 11:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389818AbiDUPCe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Apr 2022 11:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD0D94550D
        for <cgroups@vger.kernel.org>; Thu, 21 Apr 2022 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650553183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cWd6qru6wspoNXU4GQsmi6gX1Vj8SZ+oMWu2nZbwu+g=;
        b=Oxne7luR5YIuAOld87BzPc1G8PNPJBl9WgF/v2kXU5Z97Dak+8ziJzC/PVa6YASEKNj+Ei
        XiFSyJB/y4S0VWFxs61MVWmoAjzp+oFlZxznmVGBX1npatZwYLU7qN2XzR9ta5VTFXtu3S
        rqHwOo2lAA8H+u+8/d7JbFStTIa99Zs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-225-DrzwyEEFOJWmRfe3Ssmnhg-1; Thu, 21 Apr 2022 10:59:37 -0400
X-MC-Unique: DrzwyEEFOJWmRfe3Ssmnhg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EEE0D80005D;
        Thu, 21 Apr 2022 14:59:36 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 945B1145BEE7;
        Thu, 21 Apr 2022 14:59:36 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/memcg: Free percpu stats memory of dying memcg's
Date:   Thu, 21 Apr 2022 10:58:45 -0400
Message-Id: <20220421145845.1044652-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For systems with large number of CPUs, the majority of the memory
consumed by the mem_cgroup structure is actually the percpu stats
memory. When a large number of memory cgroups are continuously created
and destroyed (like in a container host), it is possible that more
and more mem_cgroup structures remained in the dying state holding up
increasing amount of percpu memory.

We can't free up the memory of the dying mem_cgroup structure due to
active references in some other places. However, the percpu stats memory
allocated to that mem_cgroup is a different story.

This patch adds a new percpu_stats_disabled variable to keep track of
the state of the percpu stats memory. If the variable is set, percpu
stats update will be disabled for that particular memcg. All the stats
update will be forward to its parent instead. Reading of the its percpu
stats will return 0.

The flushing and freeing of the percpu stats memory is a multi-step
process. The percpu_stats_disabled variable is set when the memcg is
being set to offline state. After a grace period with the help of RCU,
the percpu stats data are flushed and then freed.

This will greatly reduce the amount of memory held up by dying memory
cgroups.

By running a simple management tool for container 2000 times per test
run, below are the results of increases of percpu memory (as reported
in /proc/meminfo) and nr_dying_descendants in root's cgroup.stat.

  Unpatched kernel:

  Run    Percpu Memory Increase    nr_dying_descendants Increase
  ---    ----------------------    -----------------------------
   1           76032 kB                       209
   2           74112 kB                       208
   3           74112 kB                       207

  Patched kernel:

  Run    Percpu Memory Increase    nr_dying_descendants Increase
  ---    ----------------------    -----------------------------
   1            4224 kB                       207
   2            1536 kB                       209
   3               0 kB                       208

The x86-64 test system has 2 sockets and 96 threads. For the compiled
kernel, memcg_vmstats_percpu and lruvec_stats_percpu have a size of
2424 and 656 bytes respectively.  The mem_cgroup structure is just a
bit over 4k.  That translates to a percpu stats data size of 350.25
kB per memcg. That means 72852 kB of percpu data for 208 memcg's. This
matches pretty well with the unpatched kernel figures listed above.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/memcontrol.h |  13 ++++
 mm/memcontrol.c            | 122 +++++++++++++++++++++++++++++++------
 2 files changed, 115 insertions(+), 20 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89b14729d59f..3389b705e242 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -51,6 +51,13 @@ enum memcg_memory_event {
 	MEMCG_NR_MEMORY_EVENTS,
 };
 
+enum percpu_stats_state {
+	MEMCG_PERCPU_STATS_ACTIVE = 0,
+	MEMCG_PERCPU_STATS_DISABLED,
+	MEMCG_PERCPU_STATS_FLUSHED,
+	MEMCG_PERCPU_STATS_FREED
+};
+
 struct mem_cgroup_reclaim_cookie {
 	pg_data_t *pgdat;
 	unsigned int generation;
@@ -299,6 +306,12 @@ struct mem_cgroup {
 	unsigned long		move_lock_flags;
 
 	MEMCG_PADDING(_pad1_);
+	/*
+	 * Disable percpu stats when offline, flush and free them after one
+	 * grace period.
+	 */
+	struct rcu_work		percpu_stats_rwork;
+	enum percpu_stats_state percpu_stats_disabled;
 
 	/* memory.stat */
 	struct memcg_vmstats	vmstats;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 08cbe23a8b94..1a5ba7035249 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -665,6 +665,31 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
+/*
+ * Return the active percpu stats memcg and optionally mem_cgroup_per_node.
+ *
+ * When percpu_stats_disabled, the percpu stats update is transferred to
+ * its parent.
+ */
+static inline struct mem_cgroup *
+percpu_stats_memcg(struct mem_cgroup *memcg, struct mem_cgroup_per_node **pn)
+{
+	while (unlikely(memcg->percpu_stats_disabled)) {
+		int nid;
+
+		if (pn) {
+			for_each_node(nid) {
+				if (*pn == memcg->nodeinfo[nid])
+					break;
+			}
+		}
+		memcg = parent_mem_cgroup(memcg);
+		if (pn)
+			*pn = memcg->nodeinfo[nid];
+	}
+	return memcg;
+}
+
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -676,6 +701,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 	if (mem_cgroup_disabled())
 		return;
 
+	memcg = percpu_stats_memcg(memcg, NULL);
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 	memcg_rstat_updated(memcg, val);
 }
@@ -686,6 +712,9 @@ static unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx)
 	long x = 0;
 	int cpu;
 
+	if (unlikely(memcg->percpu_stats_disabled))
+		return 0;
+
 	for_each_possible_cpu(cpu)
 		x += per_cpu(memcg->vmstats_percpu->state[idx], cpu);
 #ifdef CONFIG_SMP
@@ -702,7 +731,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	struct mem_cgroup *memcg;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	memcg = pn->memcg;
+	memcg = percpu_stats_memcg(pn->memcg, &pn);
 
 	/*
 	 * The caller from rmap relay on disabled preemption becase they never
@@ -814,6 +843,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 {
 	if (mem_cgroup_disabled())
 		return;
+	memcg = percpu_stats_memcg(memcg, NULL);
 
 	memcg_stats_lock();
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
@@ -831,6 +861,9 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 	long x = 0;
 	int cpu;
 
+	if (unlikely(memcg->percpu_stats_disabled))
+		return 0;
+
 	for_each_possible_cpu(cpu)
 		x += per_cpu(memcg->vmstats_percpu->events[event], cpu);
 	return x;
@@ -839,6 +872,8 @@ static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 int nr_pages)
 {
+	memcg = percpu_stats_memcg(memcg, NULL);
+
 	/* pagein of a big page is an event. So, ignore page size */
 	if (nr_pages > 0)
 		__count_memcg_events(memcg, PGPGIN, 1);
@@ -855,6 +890,8 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 {
 	unsigned long val, next;
 
+	memcg = percpu_stats_memcg(memcg, NULL);
+
 	val = __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
 	next = __this_cpu_read(memcg->vmstats_percpu->targets[target]);
 	/* from time_after() in jiffies.h */
@@ -5051,7 +5088,6 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return;
 
-	free_percpu(pn->lruvec_stats_percpu);
 	kfree(pn);
 }
 
@@ -5061,7 +5097,6 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
-	free_percpu(memcg->vmstats_percpu);
 	kfree(memcg);
 }
 
@@ -5132,6 +5167,44 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	return ERR_PTR(error);
 }
 
+/*
+ * Flush and free the percpu stats
+ */
+static void percpu_stats_free_rwork_fn(struct work_struct *work)
+{
+	struct mem_cgroup *memcg = container_of(to_rcu_work(work),
+						struct mem_cgroup,
+						percpu_stats_rwork);
+	int node;
+
+
+	cgroup_rstat_flush_hold(memcg->css.cgroup);
+	memcg->percpu_stats_disabled = MEMCG_PERCPU_STATS_FLUSHED;
+	cgroup_rstat_flush_release();
+
+	for_each_node(node) {
+		struct mem_cgroup_per_node *pn = memcg->nodeinfo[node];
+
+		if (pn)
+			free_percpu(pn->lruvec_stats_percpu);
+	}
+	free_percpu(memcg->vmstats_percpu);
+	memcg->percpu_stats_disabled = MEMCG_PERCPU_STATS_FREED;
+	mem_cgroup_id_put(memcg);
+}
+
+static void memcg_percpu_stats_disable(struct mem_cgroup *memcg)
+{
+	memcg->percpu_stats_disabled = MEMCG_PERCPU_STATS_DISABLED;
+	INIT_RCU_WORK(&memcg->percpu_stats_rwork, percpu_stats_free_rwork_fn);
+	queue_rcu_work(system_wq, &memcg->percpu_stats_rwork);
+}
+
+static inline bool memcg_percpu_stats_gone(struct mem_cgroup *memcg)
+{
+	return memcg->percpu_stats_disabled >= MEMCG_PERCPU_STATS_FLUSHED;
+}
+
 static struct cgroup_subsys_state * __ref
 mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 {
@@ -5227,7 +5300,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 
 	drain_all_stock(memcg);
 
-	mem_cgroup_id_put(memcg);
+	memcg_percpu_stats_disable(memcg);
 }
 
 static void mem_cgroup_css_released(struct cgroup_subsys_state *css)
@@ -5308,11 +5381,13 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (delta)
 			memcg->vmstats.state_pending[i] = 0;
 
-		/* Add CPU changes on this level since the last flush */
-		v = READ_ONCE(statc->state[i]);
-		if (v != statc->state_prev[i]) {
-			delta += v - statc->state_prev[i];
-			statc->state_prev[i] = v;
+		if (!memcg_percpu_stats_gone(memcg)) {
+			/* Add CPU changes on this level since the last flush */
+			v = READ_ONCE(statc->state[i]);
+			if (v != statc->state_prev[i]) {
+				delta += v - statc->state_prev[i];
+				statc->state_prev[i] = v;
+			}
 		}
 
 		if (!delta)
@@ -5329,10 +5404,12 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (delta)
 			memcg->vmstats.events_pending[i] = 0;
 
-		v = READ_ONCE(statc->events[i]);
-		if (v != statc->events_prev[i]) {
-			delta += v - statc->events_prev[i];
-			statc->events_prev[i] = v;
+		if (!memcg_percpu_stats_gone(memcg)) {
+			v = READ_ONCE(statc->events[i]);
+			if (v != statc->events_prev[i]) {
+				delta += v - statc->events_prev[i];
+				statc->events_prev[i] = v;
+			}
 		}
 
 		if (!delta)
@@ -5358,10 +5435,12 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			if (delta)
 				pn->lruvec_stats.state_pending[i] = 0;
 
-			v = READ_ONCE(lstatc->state[i]);
-			if (v != lstatc->state_prev[i]) {
-				delta += v - lstatc->state_prev[i];
-				lstatc->state_prev[i] = v;
+			if (!memcg_percpu_stats_gone(memcg)) {
+				v = READ_ONCE(lstatc->state[i]);
+				if (v != lstatc->state_prev[i]) {
+					delta += v - lstatc->state_prev[i];
+					lstatc->state_prev[i] = v;
+				}
 			}
 
 			if (!delta)
@@ -6730,6 +6809,7 @@ static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 static void uncharge_batch(const struct uncharge_gather *ug)
 {
 	unsigned long flags;
+	struct mem_cgroup *memcg;
 
 	if (ug->nr_memory) {
 		page_counter_uncharge(&ug->memcg->memory, ug->nr_memory);
@@ -6740,10 +6820,12 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 		memcg_oom_recover(ug->memcg);
 	}
 
+	memcg = percpu_stats_memcg(ug->memcg, NULL);
+
 	local_irq_save(flags);
-	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->nid);
+	__count_memcg_events(memcg, PGPGOUT, ug->pgpgout);
+	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+	memcg_check_events(memcg, ug->nid);
 	local_irq_restore(flags);
 
 	/* drop reference from uncharge_folio */
-- 
2.27.0

