Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCF07A9F81
	for <lists+cgroups@lfdr.de>; Thu, 21 Sep 2023 22:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjIUUW6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Sep 2023 16:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjIUUWh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Sep 2023 16:22:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65C1D2B30
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 11:23:23 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e758d6236so18494117b3.1
        for <cgroups@vger.kernel.org>; Thu, 21 Sep 2023 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695320603; x=1695925403; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUfaq4QWGo6Pgq9+Gc0pYjCdwcXd4ikm64XsTJ+V7zI=;
        b=0PDufy/ZnXluTkgksrr/C8hG4DBTFLgh/21OjR4hP2ye+Bn8AU9BXRO2pLEX8WIm6U
         0iLNhyuczsTzf10SQ99wLFm/Nv3j9cHJaseOoq1G8wpTiTF7VFvgpCjWPJfscqxwMsjo
         x5tQAjNgUVXrB9Cm3divSZEDqMw4rDoEswEpZjaOllbHAgHRRsb1ttmCS67SEC90pNXf
         ki7XvkZn8xiXZ9+v8p+0BdErEPftUTVj/CjX62iyDWCFlvnKKvpcnmZ0A2QsgMBKM19r
         Gf0lz0GD0wCeBbUgfS1zHIaB1Bm54UoXHxPf7XJstRAoj8gVCiYztPFVLihPR+aEzNGH
         iS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695320603; x=1695925403;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUfaq4QWGo6Pgq9+Gc0pYjCdwcXd4ikm64XsTJ+V7zI=;
        b=Y6YfX7+OqH1hLA9IapyYtChqS5lALROI/dldXmnmjUW4OzP/wp8KaLe1HDk8svP6Yi
         hdy5K0fyxcaBYILpw71NPoEvdE0GVClMX5svJzWD8gr77Zwgzfr3MimgleTrzovw0I2U
         5fMtiy50+2dOsVoueuHAN6PmHbUcgomXQQeXK3j+KtrwKZL+uSZxcAwgtH+yJZM0e6y/
         XRvhdYs8XU7eC8mx1k9uGCq9BrWnNTxKgTwEroRxQyD+NU3lbVzCifAGvAp9EK0SscIJ
         nUH7eOUDM1Emg8/d4XNd9PkT1vX59I8bMRx+gZVQn7YtKLc/TCfjRnDQnY8SxWp94srF
         bfAg==
X-Gm-Message-State: AOJu0YyFHV6cGYs5kMJn5FqRPzHEA4RKWwWPVGMYDoxZNCMg3OQTgIsD
        jPPoZSeiMoILur0FpqXrSAL19ek0qZHdNp9F
X-Google-Smtp-Source: AGHT+IFBE/oPIuCJlO97tHApRysO3VNA0vvMKpAee95h86ybMubWU1dHAIDYmvCWr5CQMyHTNET+SuyM9GansnHQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:b656:0:b0:59b:f493:813c with SMTP
 id h22-20020a81b656000000b0059bf493813cmr74625ywk.9.1695283865279; Thu, 21
 Sep 2023 01:11:05 -0700 (PDT)
Date:   Thu, 21 Sep 2023 08:10:54 +0000
In-Reply-To: <20230921081057.3440885-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230921081057.3440885-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Message-ID: <20230921081057.3440885-3-yosryahmed@google.com>
Subject: [PATCH 2/5] mm: memcg: move vmstats structs definition above flushing code
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
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The following patch will make use of those structs in the flushing code,
so move their definitions (and a few other dependencies) a little bit up
to reduce the diff noise in the following patch.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/memcontrol.c | 146 ++++++++++++++++++++++++------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 49562dfdeab2..ef7ad66a9e4c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -570,6 +570,79 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+/* Subset of vm_event_item to report for memcg event stats */
+static const unsigned int memcg_vm_event_stat[] = {
+	PGPGIN,
+	PGPGOUT,
+	PGSCAN_KSWAPD,
+	PGSCAN_DIRECT,
+	PGSCAN_KHUGEPAGED,
+	PGSTEAL_KSWAPD,
+	PGSTEAL_DIRECT,
+	PGSTEAL_KHUGEPAGED,
+	PGFAULT,
+	PGMAJFAULT,
+	PGREFILL,
+	PGACTIVATE,
+	PGDEACTIVATE,
+	PGLAZYFREE,
+	PGLAZYFREED,
+#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
+	ZSWPIN,
+	ZSWPOUT,
+#endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	THP_FAULT_ALLOC,
+	THP_COLLAPSE_ALLOC,
+	THP_SWPOUT,
+	THP_SWPOUT_FALLBACK,
+#endif
+};
+
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
+struct memcg_vmstats_percpu {
+	/* Local (CPU and cgroup) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Delta calculation for lockless upward propagation */
+	long			state_prev[MEMCG_NR_STAT];
+	unsigned long		events_prev[NR_MEMCG_EVENTS];
+
+	/* Cgroup1: threshold notifications & softlimit tree updates */
+	unsigned long		nr_page_events;
+	unsigned long		targets[MEM_CGROUP_NTARGETS];
+};
+
+struct memcg_vmstats {
+	/* Aggregated (CPU and subtree) page state & events */
+	long			state[MEMCG_NR_STAT];
+	unsigned long		events[NR_MEMCG_EVENTS];
+
+	/* Non-hierarchical (CPU aggregated) page state & events */
+	long			state_local[MEMCG_NR_STAT];
+	unsigned long		events_local[NR_MEMCG_EVENTS];
+
+	/* Pending child counts during tree propagation */
+	long			state_pending[MEMCG_NR_STAT];
+	unsigned long		events_pending[NR_MEMCG_EVENTS];
+};
+
 /*
  * memcg and lruvec stats flushing
  *
@@ -681,79 +754,6 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
 	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, FLUSH_TIME);
 }
 
-/* Subset of vm_event_item to report for memcg event stats */
-static const unsigned int memcg_vm_event_stat[] = {
-	PGPGIN,
-	PGPGOUT,
-	PGSCAN_KSWAPD,
-	PGSCAN_DIRECT,
-	PGSCAN_KHUGEPAGED,
-	PGSTEAL_KSWAPD,
-	PGSTEAL_DIRECT,
-	PGSTEAL_KHUGEPAGED,
-	PGFAULT,
-	PGMAJFAULT,
-	PGREFILL,
-	PGACTIVATE,
-	PGDEACTIVATE,
-	PGLAZYFREE,
-	PGLAZYFREED,
-#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
-	ZSWPIN,
-	ZSWPOUT,
-#endif
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	THP_FAULT_ALLOC,
-	THP_COLLAPSE_ALLOC,
-	THP_SWPOUT,
-	THP_SWPOUT_FALLBACK,
-#endif
-};
-
-#define NR_MEMCG_EVENTS ARRAY_SIZE(memcg_vm_event_stat)
-static int mem_cgroup_events_index[NR_VM_EVENT_ITEMS] __read_mostly;
-
-static void init_memcg_events(void)
-{
-	int i;
-
-	for (i = 0; i < NR_MEMCG_EVENTS; ++i)
-		mem_cgroup_events_index[memcg_vm_event_stat[i]] = i + 1;
-}
-
-static inline int memcg_events_index(enum vm_event_item idx)
-{
-	return mem_cgroup_events_index[idx] - 1;
-}
-
-struct memcg_vmstats_percpu {
-	/* Local (CPU and cgroup) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Delta calculation for lockless upward propagation */
-	long			state_prev[MEMCG_NR_STAT];
-	unsigned long		events_prev[NR_MEMCG_EVENTS];
-
-	/* Cgroup1: threshold notifications & softlimit tree updates */
-	unsigned long		nr_page_events;
-	unsigned long		targets[MEM_CGROUP_NTARGETS];
-};
-
-struct memcg_vmstats {
-	/* Aggregated (CPU and subtree) page state & events */
-	long			state[MEMCG_NR_STAT];
-	unsigned long		events[NR_MEMCG_EVENTS];
-
-	/* Non-hierarchical (CPU aggregated) page state & events */
-	long			state_local[MEMCG_NR_STAT];
-	unsigned long		events_local[NR_MEMCG_EVENTS];
-
-	/* Pending child counts during tree propagation */
-	long			state_pending[MEMCG_NR_STAT];
-	unsigned long		events_pending[NR_MEMCG_EVENTS];
-};
-
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx)
 {
 	long x = READ_ONCE(memcg->vmstats->state[idx]);
-- 
2.42.0.459.ge4e396fd5e-goog

