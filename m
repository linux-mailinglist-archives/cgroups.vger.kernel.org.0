Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A483CBE65
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 23:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbhGPVYs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 17:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhGPVYr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 17:24:47 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE3C06175F
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 14:21:51 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id u8-20020a6345480000b0290227a64be361so7907476pgk.9
        for <cgroups@vger.kernel.org>; Fri, 16 Jul 2021 14:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fk4tAuPxyFd0FobDfqVGnEYc2NrI1vYM+OgM2ictzdU=;
        b=OXccDO+93T+Duotqx23iOxbpOH2hC+t2wyXy/iHa5ryp9TQZRDeoCQhISflgiYg7tM
         M5RPsBIx4rTn+Esxk4YCBgUaupjIoT7QD7xFkyCVDOvHoFEEcFPiYTffQKjMcFmw4uWy
         QoEjHRAItFobqeqb2dfK4NviepC1QqWeio3br37scL6Ah/VHUDwACET67NB6gts4o4nE
         7Iw/p5Klw84ubiS67x6n7NG5WEisOg/FoVaAjpQkWqppTH2F73WnfdUspG0maB7oYER0
         ECDU32zKKRH2D6+oBmL/CuOeM0Yqgefpg+6EXVGy2KHYi4r36htIHXXorL+8WVsRmeLX
         l31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fk4tAuPxyFd0FobDfqVGnEYc2NrI1vYM+OgM2ictzdU=;
        b=qeN53nZGFdl5/zCwGfHCgYyHKsxaCBCaXjFaQyAZSN2kQ1Ss3YtpraIlRiEdS8Gn6+
         7yl69i+owMG2xuriGtLFEOW47zbXqYLpnYVkEBa4/7asl9QcJ9uClGDF1zqi2GHl4vyB
         ANjZqFPFnyDbaCpEqEthr9zu49AapwYzTja/cBKj4xapPSvgZoDFaj+pUk9b8fp9k34n
         6xzlJMrxR9UOGqvr5mlS9ZtTUESIdltyvAH071k0PqGAfBKVSfNBBruiuSZdFth9Kj0Z
         W9xErbKlGIgRnqtE7zu7qLJLeZ0zEeNLQi7zYygM5WYGHb0C8zkmTMGSnSSlKJSRaGJF
         hWJg==
X-Gm-Message-State: AOAM530oG6huOpghicSB/TUj6sHM1JIaQ611tQt7nQWAnCO+gH/++yvY
        +DTVpFnGjxldb4bpCyrD3gWIJiHDm/b/3A==
X-Google-Smtp-Source: ABdhPJwdhB+OPsjljhxCtg0io1DcatEsiYa5v6bw4qqoVEDz7s9GO+vvFJMxbUFkcKoNe0CqLZMXM0h49ePVow==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:7bfd:347c:6059:d68a])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:15c9:: with SMTP id
 lh9mr10582743pjb.111.1626470511140; Fri, 16 Jul 2021 14:21:51 -0700 (PDT)
Date:   Fri, 16 Jul 2021 14:21:37 -0700
In-Reply-To: <20210716212137.1391164-1-shakeelb@google.com>
Message-Id: <20210716212137.1391164-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20210716212137.1391164-1-shakeelb@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH v5 2/2] memcg: infrastructure to flush memcg stats
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At the moment memcg stats are read in four contexts:

1. memcg stat user interfaces
2. dirty throttling
3. page fault
4. memory reclaim

Currently the kernel flushes the stats for first two cases. Flushing the
stats for remaining two casese may have performance impact. Always
flushing the memcg stats on the page fault code path may negatively
impacts the performance of the applications. In addition flushing in the
memory reclaim code path, though treated as slowpath, can become the
source of contention for the global lock taken for stat flushing because
when system or memcg is under memory pressure, many tasks may enter the
reclaim path.

This patch uses following mechanisms to solve these challenges:

1. Periodically flush the stats from root memcg every 2 seconds. This
will time limit the out of sync stats.

2. Asynchronously flush the stats after fixed number of stat updates.
In the worst case the stat can be out of sync by O(nr_cpus * BATCH) for
2 seconds.

3. For avoiding thundering herd to flush the stats particularly from the
memory reclaim context, introduce memcg local spinlock and let only one
flusher active at a time. This could have been done through
cgroup_rstat_lock lock but that lock is used by other subsystem and for
userspace reading memcg stats. So, it is better to keep flushers
introduced by this patch decoupled from cgroup_rstat_lock. However we
would have to use irqsafe version of rstat flush but that is fine as
this code path will be flushing for whole tree and do the work for
everyone. No one will be waiting for that worker.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
Changes since v4:
- Fixed the sleep-in-wrong context bug report by Yang Yingliang
  <yangyingliang@huawei.com> and Marek Szyprowski
  <m.szyprowski@samsung.com>.

Changes since v3:
- Add back the sigoff

Changes since v2:
- Changed the subject of the patch
- Added mechanism to bound errors to nr_cpus instead of nr_cgroups
- memcg local lock to let one active flusher

Changes since v1:
- use system_unbound_wq for flushing the memcg stats

 include/linux/memcontrol.h |  6 ++++++
 mm/memcontrol.c            | 34 ++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |  6 ++++++
 3 files changed, 46 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 0bfa0409af22..fa095a94ae56 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -991,6 +991,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return x;
 }
 
+void mem_cgroup_flush_stats(void);
+
 void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 			      int val);
 void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
@@ -1400,6 +1402,10 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
 	return node_page_state(lruvec_pgdat(lruvec), idx);
 }
 
+static inline void mem_cgroup_flush_stats(void)
+{
+}
+
 static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
 					    enum node_stat_item idx, int val)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 848d711bf576..0a05ce5cd045 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -103,6 +103,14 @@ static bool do_memsw_account(void)
 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_noswap;
 }
 
+/* memcg and lruvec stats flushing */
+static void flush_memcg_stats_dwork(struct work_struct *w);
+static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
+static void flush_memcg_stats_work(struct work_struct *w);
+static DECLARE_WORK(stats_flush_work, flush_memcg_stats_work);
+static DEFINE_PER_CPU(unsigned int, stats_flush_threshold);
+static DEFINE_SPINLOCK(stats_flush_lock);
+
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
 
@@ -685,6 +693,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
+	if (!(__this_cpu_inc_return(stats_flush_threshold) % MEMCG_CHARGE_BATCH))
+		queue_work(system_unbound_wq, &stats_flush_work);
 }
 
 /**
@@ -5248,6 +5258,10 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
 	/* Online state pins memcg ID, memcg ID pins CSS */
 	refcount_set(&memcg->id.ref, 1);
 	css_get(css);
+
+	if (unlikely(mem_cgroup_is_root(memcg)))
+		queue_delayed_work(system_unbound_wq, &stats_flush_dwork,
+				   2UL*HZ);
 	return 0;
 }
 
@@ -5339,6 +5353,26 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
 
+void mem_cgroup_flush_stats(void)
+{
+	if (!spin_trylock(&stats_flush_lock))
+		return;
+
+	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
+	spin_unlock(&stats_flush_lock);
+}
+
+static void flush_memcg_stats_dwork(struct work_struct *w)
+{
+	mem_cgroup_flush_stats();
+	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, 2UL*HZ);
+}
+
+static void flush_memcg_stats_work(struct work_struct *w)
+{
+	mem_cgroup_flush_stats();
+}
+
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a7602f71ec04..1cc05ab8ca15 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2893,6 +2893,12 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	target_lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup, pgdat);
 
 again:
+	/*
+	 * Flush the memory cgroup stats, so that we read accurate per-memcg
+	 * lruvec stats for heuristics.
+	 */
+	mem_cgroup_flush_stats();
+
 	memset(&sc->nr, 0, sizeof(sc->nr));
 
 	nr_reclaimed = sc->nr_reclaimed;
-- 
2.32.0.402.g57bb445576-goog

