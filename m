Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3216F41F54C
	for <lists+cgroups@lfdr.de>; Fri,  1 Oct 2021 21:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbhJATCd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbhJATCc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 15:02:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC75C061775
        for <cgroups@vger.kernel.org>; Fri,  1 Oct 2021 12:00:48 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id t28-20020a63461c000000b00252078b83e4so6787755pga.15
        for <cgroups@vger.kernel.org>; Fri, 01 Oct 2021 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=6eaOrx6B9WTfA79dzFjS+JPlNyBUQULetUEsCbO4l+A=;
        b=gBoqBjumM+ARyiIKWQvUhK9hG+lBFscSv/woVNTb0aHmNmPO90ZO9aLhckcOu1nx6Z
         kVncrTjjIVtsO6zP4Puly78rWvi5zI4syAoJg4/QIv4c4j8JhOwD5de25nNbf3s31hW9
         vi3+1L86KkqQjIo144G+PdtXoCTd/6Q7Di62QOjw/PxHnJx3Hk0PMSZhnEh7NcaPxB0D
         wO52jucST0sPnaoXOGm89E8yqaj94mu0DhdcF8yZE0pkec7Q8IUwsEBsxqbyJN41GLgo
         NzechnLrbZvDq37r4XMfh7ag1p11dGoXLZ3K9KRG33RIg0CCOZVbukr4KuYbpRKGdLKl
         ISrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=6eaOrx6B9WTfA79dzFjS+JPlNyBUQULetUEsCbO4l+A=;
        b=2Sssk/hg3jyrlh+5j/HYOb7K2kI17Ik6vh6sat5W+amtAnWmlDUAlgoKt2YyE3zVT1
         KFMl4+HsGr7tn4ncxMV+OK+/ekm6oPDcPt74bKhnLSBycLuCxC9mVeFdrP9zuVUcBPNB
         fZ46P7Z4S9+Yv1fIxZ/yKQoJT5zZAo+15pltOMNFyW6uLLPDWNjWIUwWsJtffs5xZorb
         ulRWvw+gaYhpT52hmdymfgyUF5MCpfDVDCM+K1twXTe/Z2rGyVvaHV4EBBRDb4K/7V5v
         Xh1nlJ+SpNXScMsSheePLIsAYTVArK8B1wklaXGH7BfQbGCl5cqeaNugefxWEZh1AjSV
         fYqA==
X-Gm-Message-State: AOAM533TC9VfWuiqLGIDtNT88EX9zWDde7zCNxkpsDIYCtEW4bAiAo99
        DQAzmYzSR3Pjg4/VzdM+FvtEvcNr9PenTQ==
X-Google-Smtp-Source: ABdhPJx6IgvBeYEk+UPLwvs9Zhx5drq1IwkilKeIvGG35/M5gj+3M4JrFlVfvTWWs6+j9lVZmuYqGmq0Gg2hVg==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:af1a:f1cd:5283:aa67])
 (user=shakeelb job=sendgmr) by 2002:a17:90b:1258:: with SMTP id
 gx24mr5127236pjb.205.1633114847633; Fri, 01 Oct 2021 12:00:47 -0700 (PDT)
Date:   Fri,  1 Oct 2021 12:00:39 -0700
Message-Id: <20211001190040.48086-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 1/2] memcg: flush stats only if updated
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

At the moment, the kernel flushes the memcg stats on every refault and
also on every reclaim iteration.  Although rstat maintains per-cpu update
tree but on the flush the kernel still has to go through all the cpu rstat
update tree to check if there is anything to flush.  This patch adds the
tracking on the stats update side to make flush side more clever by
skipping the flush if there is no update.

The stats update codepath is very sensitive performance wise for many
workloads and benchmarks.  So, we can not follow what the commit
aa48e47e3906 ("memcg: infrastructure to flush memcg stats") did which was
triggering async flush through queue_work() and caused a lot performance
regression reports.  That got reverted by the commit 1f828223b799 ("memcg:
flush lruvec stats in the refault").

In this patch we kept the stats update codepath very minimal and let the
stats reader side to flush the stats only when the updates are over a
specific threshold.  For now the threshold is (nr_cpus * CHARGE_BATCH).

To evaluate the impact of this patch, an 8 GiB tmpfs file is created on a
system with swap-on-zram and the file was pushed to swap through
memory.force_empty interface.  On reading the whole file, the memcg stat
flush in the refault code path is triggered.  With this patch, we observed
63% reduction in the read time of 8 GiB file.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: "Michal Koutn=C3=BD" <mkoutny@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
Changelog since v1:
- Moved code and comment added as suggested by Johannes Weiner

 mm/memcontrol.c | 78 ++++++++++++++++++++++++++++++++++---------------
 1 file changed, 55 insertions(+), 23 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 7c9d5703700e..25f55636ca37 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -103,11 +103,6 @@ static bool do_memsw_account(void)
 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys) && !cgroup_memory_noswap=
;
 }
=20
-/* memcg and lruvec stats flushing */
-static void flush_memcg_stats_dwork(struct work_struct *w);
-static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork)=
;
-static DEFINE_SPINLOCK(stats_flush_lock);
-
 #define THRESHOLDS_EVENTS_TARGET 128
 #define SOFTLIMIT_EVENTS_TARGET 1024
=20
@@ -613,6 +608,56 @@ mem_cgroup_largest_soft_limit_node(struct mem_cgroup_t=
ree_per_node *mctz)
 	return mz;
 }
=20
+/*
+ * memcg and lruvec stats flushing
+ *
+ * Many codepaths leading to stats update or read are performance sensitiv=
e and
+ * adding stats flushing in such codepaths is not desirable. So, to optimi=
ze the
+ * flushing the kernel does:
+ *
+ * 1) Periodically and asynchronously flush the stats every 2 seconds to n=
ot let
+ *    rstat update tree grow unbounded.
+ *
+ * 2) Flush the stats synchronously on reader side only when there are mor=
e than
+ *    (MEMCG_CHARGE_BATCH * nr_cpus) update events. Though this optimizati=
on
+ *    will let stats be out of sync by atmost (MEMCG_CHARGE_BATCH * nr_cpu=
s) but
+ *    only for 2 seconds due to (1).
+ */
+static void flush_memcg_stats_dwork(struct work_struct *w);
+static DECLARE_DEFERRABLE_WORK(stats_flush_dwork, flush_memcg_stats_dwork)=
;
+static DEFINE_SPINLOCK(stats_flush_lock);
+static DEFINE_PER_CPU(unsigned int, stats_updates);
+static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
+
+static inline void memcg_rstat_updated(struct mem_cgroup *memcg)
+{
+	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	if (!(__this_cpu_inc_return(stats_updates) % MEMCG_CHARGE_BATCH))
+		atomic_inc(&stats_flush_threshold);
+}
+
+static void __mem_cgroup_flush_stats(void)
+{
+	if (!spin_trylock(&stats_flush_lock))
+		return;
+
+	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
+	atomic_set(&stats_flush_threshold, 0);
+	spin_unlock(&stats_flush_lock);
+}
+
+void mem_cgroup_flush_stats(void)
+{
+	if (atomic_read(&stats_flush_threshold) > num_online_cpus())
+		__mem_cgroup_flush_stats();
+}
+
+static void flush_memcg_stats_dwork(struct work_struct *w)
+{
+	mem_cgroup_flush_stats();
+	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, 2UL*HZ);
+}
+
 /**
  * __mod_memcg_state - update cgroup memory statistics
  * @memcg: the memory cgroup
@@ -625,7 +670,7 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int id=
x, int val)
 		return;
=20
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
-	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	memcg_rstat_updated(memcg);
 }
=20
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -653,10 +698,12 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, =
enum node_stat_item idx,
 	memcg =3D pn->memcg;
=20
 	/* Update memcg */
-	__mod_memcg_state(memcg, idx, val);
+	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
=20
 	/* Update lruvec */
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
+
+	memcg_rstat_updated(memcg);
 }
=20
 /**
@@ -758,7 +805,7 @@ void __count_memcg_events(struct mem_cgroup *memcg, enu=
m vm_event_item idx,
 		return;
=20
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
-	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	memcg_rstat_updated(memcg);
 }
=20
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -5342,21 +5389,6 @@ static void mem_cgroup_css_reset(struct cgroup_subsy=
s_state *css)
 	memcg_wb_domain_size_changed(memcg);
 }
=20
-void mem_cgroup_flush_stats(void)
-{
-	if (!spin_trylock(&stats_flush_lock))
-		return;
-
-	cgroup_rstat_flush_irqsafe(root_mem_cgroup->css.cgroup);
-	spin_unlock(&stats_flush_lock);
-}
-
-static void flush_memcg_stats_dwork(struct work_struct *w)
-{
-	mem_cgroup_flush_stats();
-	queue_delayed_work(system_unbound_wq, &stats_flush_dwork, 2UL*HZ);
-}
-
 static void mem_cgroup_css_rstat_flush(struct cgroup_subsys_state *css, in=
t cpu)
 {
 	struct mem_cgroup *memcg =3D mem_cgroup_from_css(css);
--=20
2.33.0.800.g4c38ced690-goog

