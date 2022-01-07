Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61986487F83
	for <lists+cgroups@lfdr.de>; Sat,  8 Jan 2022 00:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiAGXmu (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 18:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiAGXmu (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 18:42:50 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C73FC06173E
        for <cgroups@vger.kernel.org>; Fri,  7 Jan 2022 15:42:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id c132-20020a251c8a000000b0060c39ab7d36so14997521ybc.12
        for <cgroups@vger.kernel.org>; Fri, 07 Jan 2022 15:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2DWvp//3Q4yIoQ+o5FXT1XMOs+uIg0K1Ihqyj5GEKzk=;
        b=CDZUrbgYoy2kyMQ3cCImLTduxMD1MNoq9yjv54w+dxdNOOsufykHAUZZl84Mvr4GqS
         8JL6va2C8IR0F5/LbaXmXqznqXSdErQs27qf8AI4EwFuoiEtIPCMI6fraoYWtsQT79//
         GJG3CCFAMBtaZ2gWvdvC05yZ4e10iFpqSoWgWDb4svhOeGJSufiIzCqC2r7+QYJgqrLx
         OovGpsXagiXAJrzI3tXe2+8Yw3Zivd3ZXwKMizS64DQyKEeA30PBDVa4xjTsj6xFlyjG
         tVHI66ivpyXD1SiW/uIka2SyKk3H+1FUsj6P0A+UmhxVB1uSjBJfcHQV67NE1u7bNlqv
         iDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2DWvp//3Q4yIoQ+o5FXT1XMOs+uIg0K1Ihqyj5GEKzk=;
        b=o017NGGsSiU2mtg/Zkuo1jN2NfCv3Bb30Z18BrOFasMJ3mlLHgLejZMkp7quUKw6gy
         c7SqcV8SMcHerAw8CyxWlmMDJWudDzx/h0UGoAZZ9vvbCazSLmQkbh17jTnTIfdhWuOP
         m1dCONoi5lxvVHQWBdqsqhnR1Um85Je42MPDr/fFWHeECRVoIOwfKgg6ibed5hmRUgv2
         FXKbuvgcDmrZXWzUmWv682Vivf09RYMWHFnXumBTjegQJ+LLGDrsT+CwH9PkdYlUt1uY
         oMwP7URM3XyfNGn9lt+ZEjLTh/IgimxySKQPcGTRwYW0jkz9vr/x9gcEgh0/cKN5f7xr
         j2Bw==
X-Gm-Message-State: AOAM531Uz7ENKw/KigFaRZQAY430eFOjHo5ES4luaoOCeyiVnp8dsHou
        SxR4CfjXvTaT7QnJJz1MzhEGYEiyhRO0
X-Google-Smtp-Source: ABdhPJwwaAsSrNP8ziqZZpaFQdtwtBRwe86M4X0+/NtQKIKK5Tyd3vkwqsE1lG7H5hiY4hK7qhSztHO8f3b0
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:6b45:ed9d:9cdc:3f67])
 (user=joshdon job=sendgmr) by 2002:a25:a061:: with SMTP id
 x88mr57296509ybh.633.1641598968768; Fri, 07 Jan 2022 15:42:48 -0800 (PST)
Date:   Fri,  7 Jan 2022 15:41:38 -0800
In-Reply-To: <20220107234138.1765668-1-joshdon@google.com>
Message-Id: <20220107234138.1765668-2-joshdon@google.com>
Mime-Version: 1.0
References: <20220107234138.1765668-1-joshdon@google.com>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 2/2] sched: show percpu throttled stats
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
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now that we have a cpu.stat_percpu interface, we can expose some
statistics percpu. From the cpu controller, CFS bandwidth throttling
time is a useful metric to expose percpu.

Signed-off-by: Josh Don <joshdon@google.com>
---
 include/linux/cgroup-defs.h |  3 ++-
 kernel/cgroup/cgroup.c      | 15 +++++++++++----
 kernel/sched/core.c         | 38 +++++++++++++++++++++++++++++++++++--
 kernel/sched/fair.c         |  5 ++++-
 kernel/sched/sched.h        |  1 +
 5 files changed, 54 insertions(+), 8 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 7778a011f457..e6903a6e0a10 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -636,7 +636,8 @@ struct cgroup_subsys {
 	void (*css_reset)(struct cgroup_subsys_state *css);
 	void (*css_rstat_flush)(struct cgroup_subsys_state *css, int cpu);
 	int (*css_extra_stat_show)(struct seq_file *seq,
-				   struct cgroup_subsys_state *css);
+				   struct cgroup_subsys_state *css,
+				   bool percpu);
 
 	int (*can_attach)(struct cgroup_taskset *tset);
 	void (*cancel_attach)(struct cgroup_taskset *tset);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4f5ddce529eb..05d9aeb3ff48 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3574,7 +3574,8 @@ static int cgroup_stat_show(struct seq_file *seq, void *v)
 }
 
 static int __maybe_unused cgroup_extra_stat_show(struct seq_file *seq,
-						 struct cgroup *cgrp, int ssid)
+						 struct cgroup *cgrp, int ssid,
+						 bool percpu)
 {
 	struct cgroup_subsys *ss = cgroup_subsys[ssid];
 	struct cgroup_subsys_state *css;
@@ -3587,7 +3588,7 @@ static int __maybe_unused cgroup_extra_stat_show(struct seq_file *seq,
 	if (!css)
 		return 0;
 
-	ret = ss->css_extra_stat_show(seq, css);
+	ret = ss->css_extra_stat_show(seq, css, percpu);
 	css_put(css);
 	return ret;
 }
@@ -3599,15 +3600,21 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 
 	cgroup_base_stat_cputime_show(seq);
 #ifdef CONFIG_CGROUP_SCHED
-	ret = cgroup_extra_stat_show(seq, cgrp, cpu_cgrp_id);
+	ret = cgroup_extra_stat_show(seq, cgrp, cpu_cgrp_id, /*percpu=*/false);
 #endif
 	return ret;
 }
 
 static int cpu_stat_percpu_show(struct seq_file *seq, void *v)
 {
+	struct cgroup __maybe_unused *cgrp = seq_css(seq)->cgroup;
+	int ret = 0;
+
 	cgroup_base_stat_percpu_cputime_show(seq);
-	return 0;
+#ifdef CONFIG_CGROUP_SCHED
+	ret = cgroup_extra_stat_show(seq, cgrp, cpu_cgrp_id, /*percpu=*/true);
+#endif
+	return ret;
 }
 
 #ifdef CONFIG_PSI
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4604e80fac5e..8b383e58aaa2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10651,8 +10651,8 @@ static struct cftype cpu_legacy_files[] = {
 	{ }	/* Terminate */
 };
 
-static int cpu_extra_stat_show(struct seq_file *sf,
-			       struct cgroup_subsys_state *css)
+static void __cpu_extra_stat_show(struct seq_file *sf,
+				  struct cgroup_subsys_state *css)
 {
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
@@ -10674,6 +10674,40 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 			   throttled_usec, cfs_b->nr_burst, burst_usec);
 	}
 #endif
+}
+
+static void __cpu_extra_stat_percpu_show(struct seq_file *sf,
+					 struct cgroup_subsys_state *css)
+{
+#ifdef CONFIG_CFS_BANDWIDTH
+	{
+		struct task_group *tg = css_tg(css);
+		struct cfs_rq *cfs_rq;
+		u64 throttled_usec;
+		int cpu;
+
+		seq_puts(sf, "throttled_usec");
+		for_each_possible_cpu(cpu) {
+			cfs_rq = tg->cfs_rq[cpu];
+
+			throttled_usec = READ_ONCE(cfs_rq->throttled_time);
+			do_div(throttled_usec, NSEC_PER_USEC);
+
+			seq_printf(sf, " %llu", throttled_usec);
+		}
+		seq_puts(sf, "\n");
+	}
+#endif
+}
+
+static int cpu_extra_stat_show(struct seq_file *sf,
+			       struct cgroup_subsys_state *css,
+			       bool percpu)
+{
+	if (percpu)
+		__cpu_extra_stat_percpu_show(sf, css);
+	else
+		__cpu_extra_stat_show(sf, css);
 	return 0;
 }
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4b463e015cd..2de0ce23ee99 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4878,6 +4878,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
 	long task_delta, idle_task_delta;
+	u64 throttled_time;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
 
@@ -4886,7 +4887,9 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	update_rq_clock(rq);
 
 	raw_spin_lock(&cfs_b->lock);
-	cfs_b->throttled_time += rq_clock(rq) - cfs_rq->throttled_clock;
+	throttled_time = rq_clock(rq) - cfs_rq->throttled_clock;
+	cfs_b->throttled_time += throttled_time;
+	cfs_rq->throttled_time += throttled_time;
 	list_del_rcu(&cfs_rq->throttled_list);
 	raw_spin_unlock(&cfs_b->lock);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be905739..c1ac2b8d8dd5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -620,6 +620,7 @@ struct cfs_rq {
 	u64			throttled_clock;
 	u64			throttled_clock_task;
 	u64			throttled_clock_task_time;
+	u64			throttled_time;
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
-- 
2.34.1.575.g55b058a8bb-goog

