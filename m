Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A730172D4EE
	for <lists+cgroups@lfdr.de>; Tue, 13 Jun 2023 01:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjFLX2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Jun 2023 19:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjFLX2L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Jun 2023 19:28:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420CD10D8
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 16:28:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bc8ea14f4eeso2737554276.0
        for <cgroups@vger.kernel.org>; Mon, 12 Jun 2023 16:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686612488; x=1689204488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCytQCDhKbiqioymJHM+7olUPxDWofcnuBl6H0wZRyo=;
        b=Py2PwKTqVicb+jybRPotQ5wz2OFI2pFdUp6MtBJLqth76DODWnhYirm9qAZFJCn9bW
         281i9pI0o5ytyHAk3lwEKNiqTZdHZerKxsxxVr2zuW1bpPNd6CKDBPuVeXLo/GlDANDs
         UcYYo+LEDZ09I9IYPlMsGc7zA82INWsFTQEfpwKFJuEVnvI+FFXyY8/3xuNKFs22pUuJ
         CXTtdcqpgHkuiPuPAZJd4TQQgJMxitoVmJ6+fVM3kXHBBsscuqnjwYm+PSvdJMZFBI6U
         2aZ0HEvyH2iWj4NX580tJLx85S1DZD65IwdRg3olcss2TzXVPIL5gwt/JYsvb2ggaPsx
         DCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686612488; x=1689204488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCytQCDhKbiqioymJHM+7olUPxDWofcnuBl6H0wZRyo=;
        b=Aqy2BAUZDyhj9E7gziobJuwa1rtG1tPGc72zLBE1WeOi2FWwCv08UmGgQ+L8zoXgP6
         D/bNjCXMI5GcIXrQmlLLu92rvH9fcnmjCEqGz6Li2F5uoXt0lSRAaHiIBQx1Ep/qsNJ5
         /sQfw8ngi6EHEAhRtK5PaVJl+gVqrXSxE3tQ6WN9Iskv5Yob1hzHBQR9GEnm9oPdTO/9
         RB/fu2gyOnJ7wUdPfsYnGGyjz3h8XXaKmKOqdsTknEFathAd2MlOg7UQ/lwr3bkRH9zp
         MTkuKiSMTbsSwRf1XUiva483JjW+0ibPKce8DK5bZf6JhPnU9MZJqqSZM4BOi3wotddG
         QPKA==
X-Gm-Message-State: AC+VfDzTIDT6PxJlAjEG0RnxbXdDJpwNH1p2tfjMRu3pN6eMacWZW5Kx
        X1516RY/rA/ZH0zRCkas7h6ertB6a67+
X-Google-Smtp-Source: ACHHUZ5aWfZkRJ1YyLTuyqv4uxBbw9lQCn8sfsqyRzr5fg1bpKGLpcGj+5iA0uhDd+DG1IRKHaCBiLtCdVgG
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2d4:203:5b1e:752c:c184:9d6c])
 (user=joshdon job=sendgmr) by 2002:a25:4c42:0:b0:bc6:94e5:233e with SMTP id
 z63-20020a254c42000000b00bc694e5233emr74783yba.13.1686612488469; Mon, 12 Jun
 2023 16:28:08 -0700 (PDT)
Date:   Mon, 12 Jun 2023 16:27:48 -0700
In-Reply-To: <20230612232748.3948659-1-joshdon@google.com>
Mime-Version: 1.0
References: <20230612232748.3948659-1-joshdon@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230612232748.3948659-2-joshdon@google.com>
Subject: [PATCH v2 2/2] sched: add throttled time stat for throttled children
From:   Josh Don <joshdon@google.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiangling Kong <xiangling@google.com>,
        Josh Don <joshdon@google.com>
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

We currently export the total throttled time for cgroups that are given
a bandwidth limit. This patch extends this accounting to also account
the total time that each children cgroup has been throttled.

This is useful to understand the degree to which children have been
affected by the throttling control. Children which are not runnable
during the entire throttled period, for example, will not show any
self-throttling time during this period.

Expose this in a new interface, 'cpu.stat.local', which is similar to
how non-hierarchical events are accounted in 'memory.events.local'.

Signed-off-by: Josh Don <joshdon@google.com>
---
v2:
- moved export to new cpu.stat.local file, per Tejun's recommendation

 include/linux/cgroup-defs.h |  2 ++
 kernel/cgroup/cgroup.c      | 34 ++++++++++++++++++++++++++++
 kernel/sched/core.c         | 44 +++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c         | 21 +++++++++++++++++-
 kernel/sched/sched.h        |  2 ++
 5 files changed, 102 insertions(+), 1 deletion(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8a0d5466c7be..ae20dbb885d6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -661,6 +661,8 @@ struct cgroup_subsys {
 	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
 				   struct cgroup_subsys_state *css);
+	int (*css_local_stat_show)(struct seq_file *seq,
+				   struct cgroup_subsys_state *css);
 
 	int (*can_attach)(struct cgroup_taskset *tset);
 	void (*cancel_attach)(struct cgroup_taskset *tset);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b26ae200abef..eafbdb58ee81 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3726,6 +3726,36 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
+static int __maybe_unused cgroup_local_stat_show(struct seq_file *seq,
+						 struct cgroup *cgrp, int ssid)
+{
+	struct cgroup_subsys *ss = cgroup_subsys[ssid];
+	struct cgroup_subsys_state *css;
+	int ret;
+
+	if (!ss->css_local_stat_show)
+		return 0;
+
+	css = cgroup_tryget_css(cgrp, ss);
+	if (!css)
+		return 0;
+
+	ret = ss->css_local_stat_show(seq, css);
+	css_put(css);
+	return ret;
+}
+
+static int cpu_local_stat_show(struct seq_file *seq, void *v)
+{
+	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
+	int ret = 0;
+
+#ifdef CONFIG_CGROUP_SCHED
+	ret = cgroup_local_stat_show(seq, cgrp, cpu_cgrp_id);
+#endif
+	return ret;
+}
+
 #ifdef CONFIG_PSI
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
@@ -5276,6 +5306,10 @@ static struct cftype cgroup_base_files[] = {
 		.name = "cpu.stat",
 		.seq_show = cpu_stat_show,
 	},
+	{
+		.name = "cpu.stat.local",
+		.seq_show = cpu_local_stat_show,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..02e1a1a78bd0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11103,6 +11103,27 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 
 	return 0;
 }
+
+static u64 throttled_time_self(struct task_group *tg)
+{
+	int i;
+	u64 total = 0;
+
+	for_each_possible_cpu(i) {
+		total += READ_ONCE(tg->cfs_rq[i]->throttled_clock_self_time);
+	}
+
+	return total;
+}
+
+static int cpu_cfs_local_stat_show(struct seq_file *sf, void *v)
+{
+	struct task_group *tg = css_tg(seq_css(sf));
+
+	seq_printf(sf, "throttled_time %llu\n", throttled_time_self(tg));
+
+	return 0;
+}
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
@@ -11179,6 +11200,10 @@ static struct cftype cpu_legacy_files[] = {
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
 	},
+	{
+		.name = "stat.local",
+		.seq_show = cpu_cfs_local_stat_show,
+	},
 #endif
 #ifdef CONFIG_RT_GROUP_SCHED
 	{
@@ -11235,6 +11260,24 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	return 0;
 }
 
+static int cpu_local_stat_show(struct seq_file *sf,
+			       struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_CFS_BANDWIDTH
+	{
+		struct task_group *tg = css_tg(css);
+		u64 throttled_self_usec;
+
+		throttled_self_usec = throttled_time_self(tg);
+		do_div(throttled_self_usec, NSEC_PER_USEC);
+
+		seq_printf(sf, "throttled_usec %llu\n",
+			   throttled_self_usec);
+	}
+#endif
+	return 0;
+}
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 static u64 cpu_weight_read_u64(struct cgroup_subsys_state *css,
 			       struct cftype *cft)
@@ -11413,6 +11456,7 @@ struct cgroup_subsys cpu_cgrp_subsys = {
 	.css_released	= cpu_cgroup_css_released,
 	.css_free	= cpu_cgroup_css_free,
 	.css_extra_stat_show = cpu_extra_stat_show,
+	.css_local_stat_show = cpu_local_stat_show,
 #ifdef CONFIG_RT_GROUP_SCHED
 	.can_attach	= cpu_cgroup_can_attach,
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ddd5dc18b238..606885fc67be 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4877,8 +4877,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 			list_add_leaf_cfs_rq(cfs_rq);
 		} else {
 #ifdef CONFIG_CFS_BANDWIDTH
+			struct rq *rq = rq_of(cfs_rq);
+
 			if (!cfs_rq->throttled_clock)
-				cfs_rq->throttled_clock = rq_clock(rq_of(cfs_rq));
+				cfs_rq->throttled_clock = rq_clock(rq);
+			if (!cfs_rq->throttled_clock_self)
+				cfs_rq->throttled_clock_self = rq_clock(rq);
 #endif
 		}
 	}
@@ -5385,6 +5389,17 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
+	if (cfs_rq->throttled_clock_self) {
+		u64 delta = rq_clock(rq) - cfs_rq->throttled_clock_self;
+
+		cfs_rq->throttled_clock_self = 0;
+
+		if (SCHED_WARN_ON((s64)delta < 0))
+			delta = 0;
+
+		cfs_rq->throttled_clock_self_time += delta;
+	}
+
 	return 0;
 }
 
@@ -5400,6 +5415,10 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	}
 	cfs_rq->throttle_count++;
 
+	SCHED_WARN_ON(cfs_rq->throttled_clock_self);
+	if (cfs_rq->nr_running)
+		cfs_rq->throttled_clock_self = rq_clock(rq);
+
 	return 0;
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 678446251c35..1d4c2434ec9b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -642,6 +642,8 @@ struct cfs_rq {
 	u64			throttled_clock;
 	u64			throttled_clock_pelt;
 	u64			throttled_clock_pelt_time;
+	u64			throttled_clock_self;
+	u64			throttled_clock_self_time;
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
-- 
2.41.0.162.gfafddb0af9-goog

