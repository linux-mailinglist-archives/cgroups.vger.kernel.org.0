Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 335522539B
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 17:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfEUPQv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 11:16:51 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37748 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfEUPQv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 May 2019 11:16:51 -0400
Received: by mail-pl1-f193.google.com with SMTP id p15so8602295pll.4
        for <cgroups@vger.kernel.org>; Tue, 21 May 2019 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vrg5abMyMrA/Oyy7NYVIaBdRIazxG5RLmR80PbEB3d4=;
        b=CXGnUo0NOi4At02ITCCmdyHJ0AwOqIlU0nQykBnSRQSU+lhNfqbW2hqm+PBjYDrNgH
         lhaKBx8BCeTXCIi2XympJ0T1+J+/hCxdfmPujbrmmgZI8FasBx++X988gr0VU8W6+u6a
         T5nReELXdCpJqbrco5rCliUK508JgLBGELt4od7nGkimwgDXuxeo70gH0ibDkHCD0x1Y
         30Ynm4iYfj8JY3KISIHJUd/1hyesf4eBRhb49P+37XwsIths3GottOjy3eiKnE7v8Rgt
         Y3/XVZfFmyE+4Vc5oQFKP+n7Hi0ubyjBv5Bf5jZoLZgXHXpSSIred2rXbzJv1aeuSW4x
         z3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vrg5abMyMrA/Oyy7NYVIaBdRIazxG5RLmR80PbEB3d4=;
        b=XZpb/IqJKDb1wxAbI0jnl0PFLR6qPrvverDsGiK7ZdkRxJsB2sa+VT1GuY/6Q0JDNw
         0JaQCHZoDT9nMEbtNDiUUWDLk8tBk4eXwYFaHSZzYbu7e2nn7clIjLpTQZNB4Ug6WGfd
         nZKNLAer9x6x9oaLerzNNCC3mxF+KryU5cHHkIukCFQFZGQXiG0d9AFJTUtruv9/9I/k
         myjPJCcdw6jQDkITwb7aLd9aoxqRO1NUKhmSBszoOur703xjZahT023iEssASy7idwl6
         g0J7tJGuzhGpP+MGR1edKmr+++cAw26j9kWotC6x25uGuCTaTSzMPxiugJaPXCr6oCKh
         AXwA==
X-Gm-Message-State: APjAAAX7vIpDYtQ31eXxQcrQ6mzL8HecN9tdQCHl87gBzd3QUIxpEO/p
        CnHl4TGDv01yaITU+uxY+YjIYQ==
X-Google-Smtp-Source: APXvYqzbATTqdyKAC0CB4fuXle7r+DgZw4voGOd0swqaxdX3fNcD3yEd+FSrsFjoN+9qNUPodak3wQ==
X-Received: by 2002:a17:902:a70f:: with SMTP id w15mr13184209plq.222.1558451810064;
        Tue, 21 May 2019 08:16:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:5a76])
        by smtp.gmail.com with ESMTPSA id m6sm31800996pgr.18.2019.05.21.08.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 08:16:49 -0700 (PDT)
Date:   Tue, 21 May 2019 11:16:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <rong.a.chen@intel.com>, lkp@01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org
Subject: [PATCH] mm: memcontrol: don't batch updates of local VM stats and
 events
Message-ID: <20190521151647.GB2870@cmpxchg.org>
References: <20190520063534.GB19312@shao2-debian>
 <20190520215328.GA1186@cmpxchg.org>
 <20190521134646.GE19312@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521134646.GE19312@shao2-debian>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The kernel test robot noticed a 26% will-it-scale pagefault regression
from commit 42a300353577 ("mm: memcontrol: fix recursive statistics
correctness & scalabilty"). This appears to be caused by bouncing the
additional cachelines from the new hierarchical statistics counters.

We can fix this by getting rid of the batched local counters instead.

Originally, there were *only* group-local counters, and they were
fully maintained per cpu. A reader of a stats file high up in the
cgroup tree would have to walk the entire subtree and collect each
level's per-cpu counters to get the recursive view. This was
prohibitively expensive, and so we switched to per-cpu batched updates
of the local counters during a983b5ebee57 ("mm: memcontrol: fix
excessive complexity in memory.stat reporting"), reducing the
complexity from nr_subgroups * nr_cpus to nr_subgroups.

With growing machines and cgroup trees, the tree walk itself became
too expensive for monitoring top-level groups, and this is when the
culprit patch added hierarchy counters on each cgroup level. When the
per-cpu batch size would be reached, both the local and the hierarchy
counters would get batch-updated from the per-cpu delta simultaneously.

This makes local and hierarchical counter reads blazingly fast, but it
unfortunately makes the write-side too cache line intense.

Since local counter reads were never a problem - we only centralized
them to accelerate the hierarchy walk - and use of the local counters
are becoming rarer due to replacement with hierarchical views (ongoing
rework in the page reclaim and workingset code), we can make those
local counters unbatched per-cpu counters again.

The scheme will then be as such:

   when a memcg statistic changes, the writer will:
   - update the local counter (per-cpu)
   - update the batch counter (per-cpu). If the batch is full:
   - spill the batch into the group's atomic_t
   - spill the batch into all ancestors' atomic_ts
   - empty out the batch counter (per-cpu)

   when a local memcg counter is read, the reader will:
   - collect the local counter from all cpus

   when a hiearchy memcg counter is read, the reader will:
   - read the atomic_t

We might be able to simplify this further and make the recursive
counters unbatched per-cpu counters as well (batch upward propagation,
but leave per-cpu collection to the readers), but that will require a
more in-depth analysis and testing of all the callsites. Deal with the
immediate regression for now.

Fixes: 42a300353577 ("mm: memcontrol: fix recursive statistics correctness & scalabilty")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Tested-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/memcontrol.h | 26 ++++++++++++++++--------
 mm/memcontrol.c            | 41 ++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bc74d6a4407c..2d23ae7bd36d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -126,9 +126,12 @@ struct memcg_shrinker_map {
 struct mem_cgroup_per_node {
 	struct lruvec		lruvec;
 
+	/* Legacy local VM stats */
+	struct lruvec_stat __percpu *lruvec_stat_local;
+
+	/* Subtree VM stats (batched updates) */
 	struct lruvec_stat __percpu *lruvec_stat_cpu;
 	atomic_long_t		lruvec_stat[NR_VM_NODE_STAT_ITEMS];
-	atomic_long_t		lruvec_stat_local[NR_VM_NODE_STAT_ITEMS];
 
 	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
 
@@ -274,17 +277,18 @@ struct mem_cgroup {
 	atomic_t		moving_account;
 	struct task_struct	*move_lock_task;
 
-	/* memory.stat */
+	/* Legacy local VM stats and events */
+	struct memcg_vmstats_percpu __percpu *vmstats_local;
+
+	/* Subtree VM stats and events (batched updates) */
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
 	MEMCG_PADDING(_pad2_);
 
 	atomic_long_t		vmstats[MEMCG_NR_STAT];
-	atomic_long_t		vmstats_local[MEMCG_NR_STAT];
-
 	atomic_long_t		vmevents[NR_VM_EVENT_ITEMS];
-	atomic_long_t		vmevents_local[NR_VM_EVENT_ITEMS];
 
+	/* memory.events */
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
 
 	unsigned long		socket_pressure;
@@ -576,7 +580,11 @@ static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 static inline unsigned long memcg_page_state_local(struct mem_cgroup *memcg,
 						   int idx)
 {
-	long x = atomic_long_read(&memcg->vmstats_local[idx]);
+	long x = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		x += per_cpu(memcg->vmstats_local->stat[idx], cpu);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -650,13 +658,15 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 						    enum node_stat_item idx)
 {
 	struct mem_cgroup_per_node *pn;
-	long x;
+	long x = 0;
+	int cpu;
 
 	if (mem_cgroup_disabled())
 		return node_page_state(lruvec_pgdat(lruvec), idx);
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = atomic_long_read(&pn->lruvec_stat_local[idx]);
+	for_each_possible_cpu(cpu)
+		x += per_cpu(pn->lruvec_stat_local->count[idx], cpu);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e50a2db5b4ff..8d42e5c7bf37 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -700,11 +700,12 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 	if (mem_cgroup_disabled())
 		return;
 
+	__this_cpu_add(memcg->vmstats_local->stat[idx], val);
+
 	x = val + __this_cpu_read(memcg->vmstats_percpu->stat[idx]);
 	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
 		struct mem_cgroup *mi;
 
-		atomic_long_add(x, &memcg->vmstats_local[idx]);
 		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
 			atomic_long_add(x, &mi->vmstats[idx]);
 		x = 0;
@@ -754,11 +755,12 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__mod_memcg_state(memcg, idx, val);
 
 	/* Update lruvec */
+	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
+
 	x = val + __this_cpu_read(pn->lruvec_stat_cpu->count[idx]);
 	if (unlikely(abs(x) > MEMCG_CHARGE_BATCH)) {
 		struct mem_cgroup_per_node *pi;
 
-		atomic_long_add(x, &pn->lruvec_stat_local[idx]);
 		for (pi = pn; pi; pi = parent_nodeinfo(pi, pgdat->node_id))
 			atomic_long_add(x, &pi->lruvec_stat[idx]);
 		x = 0;
@@ -780,11 +782,12 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
+	__this_cpu_add(memcg->vmstats_local->events[idx], count);
+
 	x = count + __this_cpu_read(memcg->vmstats_percpu->events[idx]);
 	if (unlikely(x > MEMCG_CHARGE_BATCH)) {
 		struct mem_cgroup *mi;
 
-		atomic_long_add(x, &memcg->vmevents_local[idx]);
 		for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
 			atomic_long_add(x, &mi->vmevents[idx]);
 		x = 0;
@@ -799,7 +802,12 @@ static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 
 static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
-	return atomic_long_read(&memcg->vmevents_local[event]);
+	long x = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		x += per_cpu(memcg->vmstats_local->events[event], cpu);
+	return x;
 }
 
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
@@ -2200,11 +2208,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			long x;
 
 			x = this_cpu_xchg(memcg->vmstats_percpu->stat[i], 0);
-			if (x) {
-				atomic_long_add(x, &memcg->vmstats_local[i]);
+			if (x)
 				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
 					atomic_long_add(x, &memcg->vmstats[i]);
-			}
 
 			if (i >= NR_VM_NODE_STAT_ITEMS)
 				continue;
@@ -2214,12 +2220,10 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 
 				pn = mem_cgroup_nodeinfo(memcg, nid);
 				x = this_cpu_xchg(pn->lruvec_stat_cpu->count[i], 0);
-				if (x) {
-					atomic_long_add(x, &pn->lruvec_stat_local[i]);
+				if (x)
 					do {
 						atomic_long_add(x, &pn->lruvec_stat[i]);
 					} while ((pn = parent_nodeinfo(pn, nid)));
-				}
 			}
 		}
 
@@ -2227,11 +2231,9 @@ static int memcg_hotplug_cpu_dead(unsigned int cpu)
 			long x;
 
 			x = this_cpu_xchg(memcg->vmstats_percpu->events[i], 0);
-			if (x) {
-				atomic_long_add(x, &memcg->vmevents_local[i]);
+			if (x)
 				for (mi = memcg; mi; mi = parent_mem_cgroup(mi))
 					atomic_long_add(x, &memcg->vmevents[i]);
-			}
 		}
 	}
 
@@ -4492,8 +4494,15 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 	if (!pn)
 		return 1;
 
+	pn->lruvec_stat_local = alloc_percpu(struct lruvec_stat);
+	if (!pn->lruvec_stat_local) {
+		kfree(pn);
+		return 1;
+	}
+
 	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
 	if (!pn->lruvec_stat_cpu) {
+		free_percpu(pn->lruvec_stat_local);
 		kfree(pn);
 		return 1;
 	}
@@ -4515,6 +4524,7 @@ static void free_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 		return;
 
 	free_percpu(pn->lruvec_stat_cpu);
+	free_percpu(pn->lruvec_stat_local);
 	kfree(pn);
 }
 
@@ -4525,6 +4535,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
 	free_percpu(memcg->vmstats_percpu);
+	free_percpu(memcg->vmstats_local);
 	kfree(memcg);
 }
 
@@ -4553,6 +4564,10 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 	if (memcg->id.id < 0)
 		goto fail;
 
+	memcg->vmstats_local = alloc_percpu(struct memcg_vmstats_percpu);
+	if (!memcg->vmstats_local)
+		goto fail;
+
 	memcg->vmstats_percpu = alloc_percpu(struct memcg_vmstats_percpu);
 	if (!memcg->vmstats_percpu)
 		goto fail;
-- 
2.21.0

