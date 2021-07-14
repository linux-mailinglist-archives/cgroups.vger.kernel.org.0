Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713C03C7B1E
	for <lists+cgroups@lfdr.de>; Wed, 14 Jul 2021 03:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237258AbhGNBnK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Jul 2021 21:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237335AbhGNBmz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Jul 2021 21:42:55 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5015BC0613E9
        for <cgroups@vger.kernel.org>; Tue, 13 Jul 2021 18:40:04 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id t10-20020a170902b20ab029011b9ceafaafso445559plr.11
        for <cgroups@vger.kernel.org>; Tue, 13 Jul 2021 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jLscKY8MsULms0fvtcTak+GIEHQetCwpE1fAuvW3yyY=;
        b=PaLGOBkWv7L7oDiKIQHgLWDy9I2orfI9UkJ8egtWmvzjTcESIBurojiEXUoKI0LR17
         rLqOXqPd7J6PUH656jeqHI5WROAb7PVyCxY7k/uLWIC4XouzyX8Te+eZTnneAqWaM+Gd
         6NyOaTR/UpFHr1ty9GcWTQsNJL+bylqan9AjcDVcr/8HayY7zj5m+YqUM9JmxzLGzxb+
         RJA/tENjEafeav126UVIj3mzIDDhMvGx5NGQbyWIw2xUDy5JoC1oJEEcwJjJrz/z2Dun
         qeQKDkzzYbGcM1KMrUTodrlNOMW/xU/u3W4oP/hqqi01pQaRM9yw0C70ibzgSd9j4TMe
         92YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jLscKY8MsULms0fvtcTak+GIEHQetCwpE1fAuvW3yyY=;
        b=lzGnhY7rcFUsx3t90AlxY+iT2ic5csQkFCT5ETr3zYCU9Q+7VwpMDHtqA7s9i+1oQc
         QiZf7WpvJ3j1+j5pIdTZGv/773js9bnW3RRqUgkCAPB4ouLmGgWjLQM31QOsZeWrEo+n
         DqSXmEYJhsOqIZTcA11TN7ech18QEfwoRnxi7rc10wdgelUzYjr2kQ/mlyNf8+XyYcg3
         cIjbEnSZyJjOWjqU5/F7Aza3pGokJONs13utSzo/8JFu2OhaUoG3zbSLz9ysqVswuPc0
         XX9TNJ5wX40qblhoVloT/NfSZmyHrBOW8wfK5Las4ioabFpiU4DPS4UAK0s+7EiYo0y5
         CDUw==
X-Gm-Message-State: AOAM531YIZEfpmfcwVcfV+568cJbk5UdwI70aUlZY5orxzbAFMo6qOIx
        /UzhQXnMRPrT2SWt4ISn9yEdz6NlWTJwtQ==
X-Google-Smtp-Source: ABdhPJwA3thbvsSzPhr/MAHXPgK7qlEBeXwubW3WCFqJt49b9sDIh57ZwUKHKKQKWI4da5mzLkJNQ3MwZvE3Qg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:c6c:5381:cc6a:6baa])
 (user=shakeelb job=sendgmr) by 2002:a63:5117:: with SMTP id
 f23mr6887746pgb.200.1626226803521; Tue, 13 Jul 2021 18:40:03 -0700 (PDT)
Date:   Tue, 13 Jul 2021 18:39:48 -0700
In-Reply-To: <20210714013948.270662-1-shakeelb@google.com>
Message-Id: <20210714013948.270662-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20210714013948.270662-1-shakeelb@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v4 2/2] memcg: infrastructure to flush memcg stats
From:   Shakeel Butt <shakeelb@google.com>
To:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hillf Danton <hdanton@sina.com>,
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
introduced by this patch decoupled from cgroup_rstat_lock.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
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
index 848d711bf576..39a00991fc80 100644
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
+	cgroup_rstat_flush(root_mem_cgroup->css.cgroup);
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
2.32.0.93.g670b81a890-goog

