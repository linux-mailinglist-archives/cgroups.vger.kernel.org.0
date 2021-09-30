Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09C441D27E
	for <lists+cgroups@lfdr.de>; Thu, 30 Sep 2021 06:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhI3EtN (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 Sep 2021 00:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhI3EtK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 Sep 2021 00:49:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A99C06176A
        for <cgroups@vger.kernel.org>; Wed, 29 Sep 2021 21:47:27 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id i20-20020aa796f4000000b00447c2f4d37bso3085420pfq.22
        for <cgroups@vger.kernel.org>; Wed, 29 Sep 2021 21:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=8iSDbwVHcLjIGb+FNAeM8Z7fJcNOoEVp1tR+zgdQ3tk=;
        b=ZvVHnNiP3I5iA4kndR/KFrSjz/XRG3SNhzrYtsHrv6nYpWfgS11lbdgnwalrhTQxPw
         gUXnr0ppOFu/OYRztH34Ga469sm7p2eFREnC1lMUECpJ5nr4YP+T8w3w7+3M7khgpUcX
         sfsMqAlQ8bs6Kh2tVGwD40grHqL15xYDgsGKjR6MQE1ze//ztY8nOQYA8rByTD+o6PZS
         ZVXfGBXRK2lEUrvKaUmg/hv0j5WsnRwaPsHwOGXiy32X+x+9gHQly+aTQaKtTv7hedXf
         66CdwUw8K6emOzFWGnJmkXA15O9MRO/Ld09tIIU6RdWFebmBB8R0BNXllcf2VvVn2vGs
         ZUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=8iSDbwVHcLjIGb+FNAeM8Z7fJcNOoEVp1tR+zgdQ3tk=;
        b=W9zEKcUPZ+U1NfubXzYLjQ9rCsKFJ3OUDxsPKM3HTIoFXSLGShEs3nfz3CS9JyRzZS
         GBnIXJzMETqloLWjiN8u/E0xRcGiAWSMHboH0xihbYcAaa+BJ6nNoDERhEJKUYD957gT
         uE6q8fwAjBzMBlZb/oEhKEHoREI5Gw3ledN/DpS3QxLbaSuETnMRre6JAUph0rFLAGqi
         R78SLgY9hMcsgN4cUKCunZ4qFUdQpG7JBn/DCID+LQk00kaP4ukvg1BAJVrJZwcu3mKo
         Z83JPlYvZ1jFZ4f62EEUOoiTYHFy3lgFS+VO40/uLIkeLJ7/tsmwLl0CPxgmR2B6bzWg
         Mi8w==
X-Gm-Message-State: AOAM530PZ73c2Ouu72wmj3PlfZwsRb7RdStvvDbr04w/28U4OAYoD+7q
        xVtCrKVSGqPb/9Dw1+Q83Kn2I3xopKcDhA==
X-Google-Smtp-Source: ABdhPJzYoIhmmUYXvt/79ki4qSrM4WaWtWsCWSaj/1EfMbrR4wE4IvcteqnEo8nZwY+9ax8V9SLla+e+lQbQ0w==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:4f8a:fdf0:d4ae:6a30])
 (user=shakeelb job=sendgmr) by 2002:a63:724b:: with SMTP id
 c11mr3184147pgn.9.1632977246883; Wed, 29 Sep 2021 21:47:26 -0700 (PDT)
Date:   Wed, 29 Sep 2021 21:47:10 -0700
Message-Id: <20210930044711.2892660-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH 1/2] memcg: flush stats only if updated
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At the moment, the kernel flushes the memcg stats on every refault and
also on every reclaim iteration. Although rstat maintains per-cpu update
tree but on the flush the kernel still has to go through all the cpu
rstat update tree to check if there is anything to flush. This patch
adds the tracking on the stats update side to make flush side more
clever by skipping the flush if there is no update.

The stats update codepath is very sensitive performance wise for many
workloads and benchmarks. So, we can not follow what the commit
aa48e47e3906 ("memcg: infrastructure to flush memcg stats") did which
was triggering async flush through queue_work() and caused a lot
performance regression reports. That got reverted by the commit
1f828223b799 ("memcg: flush lruvec stats in the refault").

In this patch we kept the stats update codepath very minimal and let the
stats reader side to flush the stats only when the updates are over a
specific threshold. For now the threshold is (nr_cpus * CHARGE_BATCH).

To evaluate the impact of this patch, an 8 GiB tmpfs file is created on
a system with swap-on-zram and the file was pushed to swap through
memory.force_empty interface. On reading the whole file, the memcg stat
flush in the refault code path is triggered. With this patch, we
bserved 63% reduction in the read time of 8 GiB file.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/memcontrol.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6da5020a8656..933dde29c67b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -107,6 +107,8 @@ static bool do_memsw_account(void)
 static void flush_memcg_stats_dwork(struct work_struct *w);
 static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork);
 static DEFINE_SPINLOCK(stats_flush_lock);
+static DEFINE_PER_CPU(unsigned int, stats_updates);
+static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
@@ -635,6 +637,13 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
 	return mz;
 }
 
+static inline void memcg_rstat_updated(struct mem_cgroup *memcg)
+{
+	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	if (!(__this_cpu_inc_return(stats_updates) % MEMCG_CHARGE_BATCH))
+		atomic_inc(&stats_flush_threshold);
+}
+
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -647,7 +656,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int idx, int val)
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
-	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	memcg_rstat_updated(memcg);
 }
 
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -675,10 +684,12 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	memcg = pn->memcg;
 
 	/* Update memcg */
-	__mod_memcg_state(memcg, idx, val);
+	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
+
+	memcg_rstat_updated(memcg);
 }
 
 /**
@@ -780,7 +791,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 		return;
 
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
-	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	memcg_rstat_updated(memcg);
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -5341,15 +5352,22 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
 
-void mem_cgroup_flush_stats(void)
+static void __mem_cgroup_flush_stats(void)
 {
 	if (!spin_trylock(&stats_flush_lock))
 		return;
 
 	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
+	atomic_set(&stats_flush_threshold, 0);
 	spin_unlock(&stats_flush_lock);
 }
 
+void mem_cgroup_flush_stats(void)
+{
+	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
+		__mem_cgroup_flush_stats();
+}
+
 static void flush_memcg_stats_dwork(struct work_struct *w)
 {
 	mem_cgroup_flush_stats();
-- 
2.33.0.685.g46640cef36-goog

