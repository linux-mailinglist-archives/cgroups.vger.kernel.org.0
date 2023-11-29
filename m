Return-Path: <cgroups+bounces-664-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F81C7FCD67
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 04:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CA628341F
	for <lists+cgroups@lfdr.de>; Wed, 29 Nov 2023 03:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0859F5680;
	Wed, 29 Nov 2023 03:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtI3wGiu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570B81AD
	for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd573c2cccso4105137b3.1
        for <cgroups@vger.kernel.org>; Tue, 28 Nov 2023 19:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701228124; x=1701832924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkGBNY4lxNmyHcFXPaFanJxG5Xvmyz6hflPyUWhCGXY=;
        b=YtI3wGiuF2vBfJ/bhNxTx+CJjiClIj7Dc2az9zQ2c6JwiFXDKlIBVDho8pWaZdhCDU
         33wCrBiFdpkMI6PKyyLctqUPQdddCAYWRJa3Asjm5tOusAc/o8lsV4ixSoGRxpC1pFN3
         c5RFSFlhOU8ZtI8GZC+qerok6eN7o6Ff0pdIazbmYdv+2dUiYG9LMme78euskK4MPg/J
         C5HjdGk+UywjN8gLyzjYy/rNWj1Ihf1oGWFj6xkbNLrsIS7XswQL/SftKOpQRWtO5JEK
         /+MpRsTdk3QN2el3QaRuHteUytk/+dYY4xfS8JKYS5nnHyxuy40Zer9ikuq3osC4vayg
         AvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701228124; x=1701832924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkGBNY4lxNmyHcFXPaFanJxG5Xvmyz6hflPyUWhCGXY=;
        b=YeUYt9PHrs2GOpgZqtwzU5XDQoET7OamyFb/XjdaOsexX5cUkhTrr24ivdlRVCFQlY
         NovWye317mVjIvDJm5QBhGr86fggPH28/d1d2MZY0LHJYtxpwbF+eWUNjRp7GZ2ZB/pX
         D7ZJLLVHgKgNmPI1FII6buIuKh/TkRI5Np70qoAdI+sfus3SfAyYhNCtFMlpicYlWKyo
         2JgbD+xTwkG1SnaugNFey5x1x1xtU/J3LONv8FpwKh7gm2uYEy7Rpu8VvDB9o753rksz
         M9l8KhzXa8GV5J6NnhGU6Zxrj0VC2gGNrAe0586aItSF5xGHmHKlWDsQ3zyqJNhjvJNc
         /+ow==
X-Gm-Message-State: AOJu0Yyq2S07dguSXcluucLycPUm/5e0jp7eQYPOD6aJZQN3343a0i0u
	2rNEjBjM87lDqlSK7+/j3S4pizjPgEt65e7d
X-Google-Smtp-Source: AGHT+IGgU2pugrxnPiU5pgzoPzMJYEV1VVlpcCDjt+l6Df6QyQjrSFotV7ovT+35/w/aqiFCJqQcbTtkApU+OqYQ
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:3692:b0:5d1:6732:25a0 with
 SMTP id fu18-20020a05690c369200b005d1673225a0mr197147ywb.4.1701228124565;
 Tue, 28 Nov 2023 19:22:04 -0800 (PST)
Date: Wed, 29 Nov 2023 03:21:50 +0000
In-Reply-To: <20231129032154.3710765-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231129032154.3710765-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231129032154.3710765-3-yosryahmed@google.com>
Subject: [mm-unstable v4 2/5] mm: memcg: move vmstats structs definition above
 flushing code
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com, 
	Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

The following patch will make use of those structs in the flushing code,
so move their definitions (and a few other dependencies) a little bit up
to reduce the diff noise in the following patch.

No functional change intended.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Tested-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 148 ++++++++++++++++++++++++------------------------
 1 file changed, 74 insertions(+), 74 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 61435bd037cb4..cf05b97c1e824 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -573,6 +573,80 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
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
+	ZSWP_WB,
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
@@ -684,80 +758,6 @@ static void flush_memcg_stats_dwork(struct work_struct *w)
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
-	ZSWP_WB,
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
2.43.0.rc1.413.gea7ed67945-goog


