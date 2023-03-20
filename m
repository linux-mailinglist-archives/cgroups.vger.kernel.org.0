Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2251D6C0938
	for <lists+cgroups@lfdr.de>; Mon, 20 Mar 2023 04:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjCTDMa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 19 Mar 2023 23:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCTDM2 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 19 Mar 2023 23:12:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A340E3B5;
        Sun, 19 Mar 2023 20:12:26 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pg0800992znYTs;
        Mon, 20 Mar 2023 11:09:19 +0800 (CST)
Received: from ci.huawei.com (10.67.175.89) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 20 Mar
 2023 11:12:23 +0800
From:   Cai Xinchen <caixinchen1@huawei.com>
To:     <songmuchun@bytedance.com>, <akpm@linux-foundation.org>,
        <hannes@cmpxchg.org>, <longman@redhat.com>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>
CC:     <cgroups@vger.kernel.org>, <duanxiongchun@bytedance.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <yosryahmed@google.com>, <mpenttil@redhat.com>
Subject: [PATCH 1/1] mm: memcontrol: fix vmstats_percpu state incorrect subtraction after reparent
Date:   Mon, 20 Mar 2023 03:06:48 +0000
Message-ID: <20230320030648.50663-2-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230320030648.50663-1-caixinchen1@huawei.com>
References: <20230320030648.50663-1-caixinchen1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.89]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

When memcg C is offllined, its pages are reparented to memcg P,
so far P->vmstats (hierarchical) have those pages, and
P->vmstats_percpu (non-hierarchical) don't. When those pages get
uncharged, P->vmstats (hierachical) decreases, which is correct,
but P->vmstats_percpu (non-hierarchical) also decreases, which
is wrong, as those stats were never added to P->vmstats_percpu to
begin with. If the reparented memory exceeds the original
non-hierarchical memory in P, some arg such as cache which is shown
in memory.stat will be zero (if x < 0, it shows 0)

To solve this problem, after reparent memcg, we should use
cgroup_rstat_updated to add cgrp to rstat updated tree, and then after
css refcount == 0, cgroup_rstat_flush is called by css_release_work_fn
and css->flags is set as CSS_RELEASED. We propagate state in
vmstat_percpu of struct mem_cgroup to its parent if css->flags is
CSS_RELEASED. We use reparent_state to record those state and
reparent_tag to ensure propagate vmstats_percpu of dying memcg only
once. When mem_cgroup_css_rstat_flush is called, we
add reparent_state to parent_memcg->vmstats_percpu->state and
memcg->vmstgats_percpu->state_prev in locked context. The delta
between state and state_prev would not change. So some accumulative
 value of vmstats_percpu (such as cache in memory.stat) will be
shown correctly. And this patch does not produce delta between state
and state_prev in vmstats_percpu which will be added to vmstats.

Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 kernel/cgroup/cgroup.c |  5 +++++
 mm/memcontrol.c        | 43 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 935e8121b21e..11138ee09a61 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5384,12 +5384,17 @@ static void css_release_work_fn(struct work_struct *work)
 		container_of(work, struct cgroup_subsys_state, destroy_work);
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
+	int cpu;
 
 	mutex_lock(&cgroup_mutex);
 
 	css->flags |= CSS_RELEASED;
 	list_del_rcu(&css->sibling);
 
+	/* update all cgrp rstat because reparent rstat flush */
+	for_each_possible_cpu(cpu)
+		cgroup_rstat_updated(cgrp, cpu);
+
 	if (ss) {
 		/* css release path */
 		if (!list_empty(&css->rstat_css_node)) {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 77929d08c8c9..658d42dc9820 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -842,6 +842,9 @@ struct memcg_vmstats_percpu {
 	/* Cgroup1: threshold notifications & softlimit tree updates */
 	unsigned long		nr_page_events;
 	unsigned long		targets[MEM_CGROUP_NTARGETS];
+
+	/* Tag for propagate vmstat_percpu, 1 for start, 0 for stop */
+	long			reparent_tag;
 };
 
 struct memcg_vmstats {
@@ -852,6 +855,9 @@ struct memcg_vmstats {
 	/* Pending child counts during tree propagation */
 	long			state_pending[MEMCG_NR_STAT];
 	unsigned long		events_pending[NR_MEMCG_EVENTS];
+
+	/* Propagate vmstat_percpu after reparent */
+	long			reparent_state[MEMCG_NR_STAT];
 };
 
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
@@ -5558,6 +5564,17 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	return -ENOMEM;
 }
 
+static void set_reparent_tag_for_vmstats(struct mem_cgroup *memcg)
+{
+	int cpu;
+	struct memcg_vmstats_percpu *statc;
+
+	for_each_possible_cpu(cpu) {
+		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
+		WRITE_ONCE(statc->reparent_tag, 1);
+	}
+}
+
 static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
@@ -5579,6 +5596,7 @@ static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
 	page_counter_set_low(&memcg->memory, 0);
 
 	memcg_reparent_objcgs(memcg);
+	set_reparent_tag_for_vmstats(memcg);
 	memcg_offline_kmem(memcg);
 	reparent_shrinker_deferred(memcg);
 	wb_memcg_offline(memcg);
@@ -5653,8 +5671,9 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
 	struct mem_cgroup *parent = parent_mem_cgroup(memcg);
 	struct memcg_vmstats_percpu *statc;
-	long delta, v;
+	long delta, v, reparent_v;
 	int i, nid;
+	bool reparent = false;
 
 	statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 
@@ -5668,6 +5687,10 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (delta)
 			memcg->vmstats->state_pending[i] = 0;
 
+		reparent_v = memcg->vmstats->reparent_state[i];
+		if (reparent_v)
+			memcg->vmstats->reparent_state[i] = 0;
+
 		/* Add CPU changes on this level since the last flush */
 		v = READ_ONCE(statc->state[i]);
 		if (v != statc->state_prev[i]) {
@@ -5675,6 +5698,21 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			statc->state_prev[i] = v;
 		}
 
+		/* if reparent tag is set, this cgroup is offline and reparent.
+		 * if css->flags & CSS_RELEASED, this cgroup will be released
+		 * soon. We should propagate memcg's vmstats_percpu to its parent.
+		 */
+		if (READ_ONCE(statc->reparent_tag) &&
+			css->flags & CSS_RELEASED && parent) {
+			parent->vmstats->reparent_state[i] += v + reparent_v;
+			reparent = true;
+		} else if (reparent_v) {
+			__this_cpu_add(memcg->vmstats_percpu->state[i],
+				reparent_v);
+			__this_cpu_add(memcg->vmstats_percpu->state_prev[i],
+				reparent_v);
+		}
+
 		if (!delta)
 			continue;
 
@@ -5684,6 +5722,9 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			parent->vmstats->state_pending[i] += delta;
 	}
 
+	if (reparent)
+		WRITE_ONCE(statc->reparent_tag, 0);
+
 	for (i = 0; i < NR_MEMCG_EVENTS; i++) {
 		delta = memcg->vmstats->events_pending[i];
 		if (delta)
-- 
2.17.1

