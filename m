Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BA25AFB5B
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 06:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiIGEgc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 00:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIGEg0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 00:36:26 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED6B895DF
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 21:36:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id j6-20020a170902da8600b00176a4279ba4so5336209plx.18
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 21:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=khSX7Y4iv18onStJMmBrPhwF58VNn8i03Anirden96Q=;
        b=gemiZCbExV47bKx8wOek1aQ0u8hzbt+EnZzyGvpEX6V3hdl7+FzjhOMQFdg/BAePWs
         g1Phtex5qyjXcE0CH8qo/myIMYCKBorj4O/lYfXNAuZQE1nIXh6Y/UorToCbyrfqTc08
         w41m5Q1yfn7rEabS42x1kF04pr4Fz4DhfpdBQ7PAZvq2tOJI4kuvrPxvdDoYGIeFXtU7
         73wZp+rS4GUGDo8QZ9/BnYm7kUNxwjCsKt+VQJT//oAjo2bR/bpBZ7YFQnfETArjdfst
         yH5HuLvanOXbdhRwhVJR8If5nQVhIbTM14rXsNmexTs4BoP70k0Ts+2cN/b8E1sehylv
         kQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=khSX7Y4iv18onStJMmBrPhwF58VNn8i03Anirden96Q=;
        b=5Dz9D/MvLFTAJPPD6/lQYucM6S5g9XfVQKIuA3BTDIJhBXVYUOZeW54Sj9Hxt/8G2Q
         PYN4KvC0dKhBgmNEK8EkdDTOom1VWbXjEtdGRHfNETVmbleASaHerHhTwLpQWgMOZ+IK
         sgMezyjaWSoxVH5hk2pTk1bTfwns0J5K2rQnd3/BPyzSQDPIkDD2DBcb98k5DixsNFUv
         soGRh0BaQkE0eOb+oV7mRx68Oou5DlZIG97mrAK+tIIWcMSR0BrrWS4HByrxkvF+NsNu
         e5+q97Kwm6lB1hx2aWtAcKJmxsBPO/cYq/kr/tWJ2nGYihY/SB85sWIj05grNA2hRHPg
         GBow==
X-Gm-Message-State: ACgBeo3n63Yg1eKtGKhFvh6yWhZ+s1oUoOfTIF5A7llmMFNgT/EegcIE
        NRi+2ISmmzm6J1wblT4FawYU3CvHKR8kdQ==
X-Google-Smtp-Source: AA6agR5/ynpD4fcrcx0c8sHHlPJFfJQPloK/P5POaEbeKl2ov/6eY/SmFki7BrZyFFL0jRWVJtkjvAuQBWyeJQ==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a17:903:40c9:b0:176:e58c:f082 with SMTP
 id t9-20020a17090340c900b00176e58cf082mr1969898pld.60.1662525384705; Tue, 06
 Sep 2022 21:36:24 -0700 (PDT)
Date:   Wed,  7 Sep 2022 04:35:37 +0000
In-Reply-To: <20220907043537.3457014-1-shakeelb@google.com>
Mime-Version: 1.0
References: <20220907043537.3457014-1-shakeelb@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907043537.3457014-4-shakeelb@google.com>
Subject: [PATCH 3/3] memcg: reduce size of memcg vmstats structures
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The struct memcg_vmstats and struct memcg_vmstats_percpu contains two
arrays each for events of size NR_VM_EVENT_ITEMS which can be as large
as 110. However the memcg v1 only uses 4 of those while memcg v2 uses
15. The union of both is 17. On a 64 bit system, we are wasting
approximately ((110 - 17) * 8 * 2) * (nr_cpus + 1) bytes which is
significant on large machines.

This patch reduces the size of the given structures by adding one
indirection and only stores array of events which are actually used by
the memcg code. With this patch, the size of memcg_vmstats has reduced
from 2544 bytes to 1056 bytes while the size of memcg_vmstats_percpu has
reduced from 2568 bytes to 1080 bytes.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 52 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 9 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d0ccc16ed416..a60012be6140 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -671,6 +671,8 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 
 /* Subset of vm_event_item to report for memcg event stats */
 static const unsigned int memcg_vm_event_stat[] = {
+	PGPGIN,
+	PGPGOUT,
 	PGSCAN_KSWAPD,
 	PGSCAN_DIRECT,
 	PGSTEAL_KSWAPD,
@@ -692,14 +694,30 @@ static const unsigned int memcg_vm_event_stat[] = {
 #endif
 };
 
+#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
+static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
+
+static void init_memcg_events(void)
+{
+	int i;
+
+	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
+		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
+}
+
+static inline int memcg_events_index(enum vm_event_item idx)
+{
+	return mem_cgroup_events_index[idx] - 1;
+}
+
 struct memcg_vmstats_percpu {
 	/* Local (CPU and cgroup) page state & events */
 	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_VM_EVENT_ITEMS];
+	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Delta calculation for lockless upward propagation */
 	long			state_prev[MEMCG_NR_STAT];
-	unsigned long		events_prev[NR_VM_EVENT_ITEMS];
+	unsigned long		events_prev[NR_MEMCG_EVENTS];
 
 	/* Cgroup1: threshold notifications & softlimit tree updates */
 	unsigned long		nr_page_events;
@@ -709,11 +727,11 @@ struct memcg_vmstats_percpu {
 struct memcg_vmstats {
 	/* Aggregated (CPU and subtree) page state & events */
 	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_VM_EVENT_ITEMS];
+	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Pending child counts during tree propagation */
 	long			state_pending[MEMCG_NR_STAT];
-	unsigned long		events_pending[NR_VM_EVENT_ITEMS];
+	unsigned long		events_pending[NR_MEMCG_EVENTS];
 };
 
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
@@ -873,24 +891,34 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
 void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 			  unsigned long count)
 {
-	if (mem_cgroup_disabled())
+	int index = memcg_events_index(idx);
+
+	if (mem_cgroup_disabled() || index < 0)
 		return;
 
 	memcg_stats_lock();
-	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
+	__this_cpu_add(memcg->vmstats_percpu->events[index], count);
 	memcg_rstat_updated(memcg, count);
 	memcg_stats_unlock();
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
 {
-	return READ_ONCE(memcg->vmstats->events[event]);
+	int index = memcg_events_index(event);
+
+	if (index < 0)
+		return 0;
+	return READ_ONCE(memcg->vmstats->events[index]);
 }
 
 static unsigned long memcg_events_local(struct mem_cgroup *memcg, int event)
 {
 	long x = 0;
 	int cpu;
+	int index = memcg_events_index(event);
+
+	if (index < 0)
+		return 0;
 
 	for_each_possible_cpu(cpu)
 		x += per_cpu(memcg->vmstats_percpu->events[event], cpu);
@@ -1564,10 +1592,15 @@ static void memory_stat_format(struct mem_cgroup *memcg, char *buf, int bufsize)
 		       memcg_events(memcg, PGSTEAL_KSWAPD) +
 		       memcg_events(memcg, PGSTEAL_DIRECT));
 
-	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++)
+	for (i = 0; i < ARRAY_SIZE(memcg_vm_event_stat); i++) {
+		if (memcg_vm_event_stat[i] == PGPGIN ||
+		    memcg_vm_event_stat[i] == PGPGOUT)
+			continue;
+
 		seq_buf_printf(&s, "%s %lu\n",
 			       vm_event_name(memcg_vm_event_stat[i]),
 			       memcg_events(memcg, memcg_vm_event_stat[i]));
+	}
 
 	/* The above should easily fit into one page */
 	WARN_ON_ONCE(seq_buf_has_overflowed(&s));
@@ -5309,6 +5342,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
 		page_counter_init(&memcg->kmem, &parent->kmem);
 		page_counter_init(&memcg->tcpmem, &parent->tcpmem);
 	} else {
+		init_memcg_events();
 		page_counter_init(&memcg->memory, NULL);
 		page_counter_init(&memcg->swap, NULL);
 		page_counter_init(&memcg->kmem, NULL);
@@ -5477,7 +5511,7 @@ static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 			parent->vmstats->state_pending[i] += delta;
 	}
 
-	for (i = 0; i < NR_VM_EVENT_ITEMS; i++) {
+	for (i = 0; i < NR_MEMCG_EVENTS; i++) {
 		delta = memcg->vmstats->events_pending[i];
 		if (delta)
 			memcg->vmstats->events_pending[i] = 0;
-- 
2.37.2.789.g6183377224-goog

