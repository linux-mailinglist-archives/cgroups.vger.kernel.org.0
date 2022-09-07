Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35195AFB57
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 06:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIGEgM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 00:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiIGEgL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 00:36:11 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0617B8B2F6
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 21:36:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o14-20020a17090ab88e00b0020034a4415dso5937818pjr.6
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 21:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+ENncUdfOxJ4q/8LZk6DI50+XMWx6BeUwv0z4tw0gRY=;
        b=ZequgtabdjcCJmJYwHcuirxjXWYVxqBEGoqYBTddWUrFGxayaRDdkPPL35s5tGIzQ7
         oohJe3ane8IE/6VPhwguj78pXQyNyZra47KKc+c8xJKEHGorIcMzWmrmRlwLoA2dHS95
         NKjaOI9d+CsoGs/PtD5hTrcJmdjy8ugZzPcm9WEnuiDhAQdfC8LPWQBoQHOijfpRjQwf
         z49WK7LH8anfLpxSIpaWSL7mxkmp44ZTKIN3Eyolkfra/wn0h5geUklvCLjRgu/NHGQX
         q+Fnut9idgOpogDkYMQfi517Q0/kauc+cWYzh2xco62FeXGuOpev9tG1hUyiyQYR/ABl
         2HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+ENncUdfOxJ4q/8LZk6DI50+XMWx6BeUwv0z4tw0gRY=;
        b=FKk7sRuV80c4Ta2WRxDFWt/LQGDMH92dew3XajZeDb5MOGSUt9R05risdms1tRZoKW
         hfJEnvEldIA52CyNMoDZFFCUDZtv7J8ml0pEWt2muqtUoUy3MC5pQmK8TpjeUNjtvtiE
         QUz2CeKiMB8/gk6T7FuocjGn+j6V569jV8RqiWqKTvAPE3VEwD09NQ8ag5N90kpuqRZM
         ILIQ4E1dYtk0dS0beR3MyPwNRssBYybcSCVXuf6Hvh7nV48pzCdPcVw+bCz1urvXBvOn
         BXe8PCEC2T3/u+aOVW+tsY9BmZG+pcen1bvlyzkCUPXrR2uFL/vV7/AVo1pqmqYuiwWK
         8HSg==
X-Gm-Message-State: ACgBeo2mpTVOPjpuiNlt/6jsQB5t1OFsgR4JvZ8EiK5qZyGdpAat7YWb
        dEfKUxlaMXmytJT6bILKL3UuOCtDYLZ2iw==
X-Google-Smtp-Source: AA6agR4Tjj9UlQLSGOInlnJphRscUgepBu0Rn+Rxd2copVybQoevmw94qxSMGgA6pLc+G3qI0NNwikm2QKECmw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:10a:b0:200:2849:235f with SMTP id
 p10-20020a17090b010a00b002002849235fmr175469pjz.1.1662525368959; Tue, 06 Sep
 2022 21:36:08 -0700 (PDT)
Date:   Wed,  7 Sep 2022 04:35:35 +0000
In-Reply-To: <20220907043537.3457014-1-shakeelb@google.com>
Mime-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907043537.3457014-2-shakeelb@google.com>
Subject: [PATCH 1/3] memcg: extract memcg_vmstats from struct mem_cgroup
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
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

This is a preparatory patch to reduce the memory overhead of memory
cgroup. The struct memcg_vmstats is the largest object embedded into the
struct mem_cgroup. This patch extracts struct memcg_vmstats from struct
mem_cgroup to ease the following patches in reducing the size of struct
memcg_vmstats.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 include/linux/memcontrol.h | 37 +++----------------------
 mm/memcontrol.c            | 57 ++++++++++++++++++++++++++++++++------
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index ca0df42662ad..dc7d40e575d5 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -80,29 +80,8 @@ enum mem_cgroup_events_target {
 	MEM_CGROUP_NTARGETS,
 };
 
-struct memcg_vmstats_percpu {
-	/* Local (CPU and cgroup) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_VM_EVENT_ITEMS];
-
-	/* Delta calculation for lockless upward propagation */
-	long			state_prev[MEMCG_NR_STAT];
-	unsigned long		events_prev[NR_VM_EVENT_ITEMS];
-
-	/* Cgroup1: threshold notifications & softlimit tree updates */
-	unsigned long		nr_page_events;
-	unsigned long		targets[MEM_CGROUP_NTARGETS];
-};
-
-struct memcg_vmstats {
-	/* Aggregated (CPU and subtree) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_VM_EVENT_ITEMS];
-
-	/* Pending child counts during tree propagation */
-	long			state_pending[MEMCG_NR_STAT];
-	unsigned long		events_pending[NR_VM_EVENT_ITEMS];
-};
+struct memcg_vmstats_percpu;
+struct memcg_vmstats;
 
 struct mem_cgroup_reclaim_iter {
 	struct mem_cgroup *position;
@@ -298,7 +277,7 @@ struct mem_cgroup {
 	CACHELINE_PADDING(_pad1_);
 
 	/* memory.stat */
-	struct memcg_vmstats	vmstats;
+	struct memcg_vmstats	*vmstats;
 
 	/* memory.events */
 	atomic_long_t		memory_events[MEMCG_NR_MEMORY_EVENTS];
@@ -1001,15 +980,7 @@ static inline void mod_memcg_page_state(struct page *page,
 	rcu_read_unlock();
 }
 
-static inline unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
-{
-	long x = READ_ONCE(memcg->vmstats.state[idx]);
-#ifdef CONFIG_SMP
-	if (x < 0)
-		x = 0;
-#endif
-	return x;
-}
+unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
 
 static inline unsigned long lruvec_page_state(struct lruvec *lruvec,
 					      enum node_stat_item idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0a1a8a846870..b195d4ca2a72 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -669,6 +669,40 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
+struct memcg_vmstats_percpu {
+	/* Local (CPU and cgroup) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_VM_EVENT_ITEMS];
+
+	/* Delta calculation for lockless upward propagation */
+	long			state_prev[MEMCG_NR_STAT];
+	unsigned long		events_prev[NR_VM_EVENT_ITEMS];
+
+	/* Cgroup1: threshold notifications & softlimit tree updates */
+	unsigned long		nr_page_events;
+	unsigned long		targets[MEM_CGROUP_NTARGETS];
+};
+
+struct memcg_vmstats {
+	/* Aggregated (CPU and subtree) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_VM_EVENT_ITEMS];
+
+	/* Pending child counts during tree propagation */
+	long			state_pending[MEMCG_NR_STAT];
+	unsigned long		events_pending[NR_VM_EVENT_ITEMS];
+};
+
+unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
+{
+	long x = READ_ONCE(memcg->vmstats->state[idx]);
+#ifdef CONFIG_SMP
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -827,7 +861,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
-	return READ_ONCE(memcg->vmstats.events[event]);
+	return READ_ONCE(memcg->vmstats->events[event]);
 }
 
 static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
@@ -5170,6 +5204,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 
 	for_each_node(node)
 		free_mem_cgroup_per_node_info(memcg, node);
+	kfree(memcg->vmstats);
 	free_percpu(memcg->vmstats_percpu);
 	kfree(memcg);
 }
@@ -5199,6 +5234,10 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
 		goto fail;
 	}
 
+	memcg->vmstats = kzalloc(sizeof(struct memcg_vmstats), GFP_KERNEL);
+	if (!memcg->vmstats)
+		goto fail;
+
 	memcg->vmstats_percpu = alloc_percpu_gfp(struct memcg_vmstats_percpu,
 						 GFP_KERNEL_ACCOUNT);
 	if (!memcg->vmstats_percpu)
@@ -5418,9 +5457,9 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		 * below us. We're in a per-cpu loop here and this is
 		 * a global counter, so the first cycle will get them.
 		 */
-		delta = memcg->vmstats.state_pending[i];
+		delta = memcg->vmstats->state_pending[i];
 		if (delta)
-			memcg->vmstats.state_pending[i] = 0;
+			memcg->vmstats->state_pending[i] = 0;
 
 		/* Add CPU changes on this level since the last flush */
 		v = READ_ONCE(statc->state[i]);
@@ -5433,15 +5472,15 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			continue;
 
 		/* Aggregate counts on this level and propagate upwards */
-		memcg->vmstats.state[i] += delta;
+		memcg->vmstats->state[i] += delta;
 		if (parent)
-			parent->vmstats.state_pending[i] += delta;
+			parent->vmstats->state_pending[i] += delta;
 	}
 
 	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
-		delta = memcg->vmstats.events_pending[i];
+		delta = memcg->vmstats->events_pending[i];
 		if (delta)
-			memcg->vmstats.events_pending[i] = 0;
+			memcg->vmstats->events_pending[i] = 0;
 
 		v = READ_ONCE(statc->events[i]);
 		if (v != statc->events_prev[i]) {
@@ -5452,9 +5491,9 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 		if (!delta)
 			continue;
 
-		memcg->vmstats.events[i] += delta;
+		memcg->vmstats->events[i] += delta;
 		if (parent)
-			parent->vmstats.events_pending[i] += delta;
+			parent->vmstats->events_pending[i] += delta;
 	}
 
 	for_each_node_state(nid, N_MEMORY) {
-- 
2.37.2.789.g6183377224-goog

