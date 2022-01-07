Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB7487F81
	for <lists+cgroups@lfdr.de>; Sat,  8 Jan 2022 00:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiAGXmb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 7 Jan 2022 18:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiAGXmb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 7 Jan 2022 18:42:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E21C061574
        for <cgroups@vger.kernel.org>; Fri,  7 Jan 2022 15:42:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id q80-20020a252a53000000b006108776aa8fso5395978ybq.17
        for <cgroups@vger.kernel.org>; Fri, 07 Jan 2022 15:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f1pXGfsk7avYpPXu3PeJjHEizsy/IQrvYVZ7vLNdmGI=;
        b=TebD9wiX+C8MwdxWZ0VYyUFIfwlcBrKlegJNUBC42WT2g9QHmRDzcPCWX9qr9UdLCj
         dpl46yFNSqhInLq2LjVn7oBCVowiLmveaogZog6DEOPO6axxPsWT+LznA+3RzRcjpgBU
         CEtSW1w9wBgMHnBTSmgoSC/0Ij7cfgu4F5vhYtZwWeQJ6woRnMVVNGc/d9uXl+0eQMSD
         Saq7LdyXrzHyi0IYEW+BjuRsEV/UjvL1ciRejxGEnxRI68sRe0AVI8fJNUNjKx9ZhVYl
         t8G1IXGc8bs/ZkgcsoCfcpgu7LSY2dfekL8f2UMBv9bZ0wAVHbbB0Gn8/ArF6l/K4gT6
         hGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f1pXGfsk7avYpPXu3PeJjHEizsy/IQrvYVZ7vLNdmGI=;
        b=vbsaJtZsquD8ryhQAfCUMJvp0bDrB+a3emhxMYsARRmoM1W4LH25Hwnan5JhyBTTwp
         mM+9qQsLc0Ji8NWyauihNrDCivWO9VMeBvc6JGwPWAtsZCuucqQ+4XMshFhI9+PaDidz
         V5b7DwT2uNOebNUWAR9pItKj6jEUmqn7EHdQVQEBs9BYlqtR0TRB5cUi4u0RXTVXH9xz
         SWDfK0rf046d/hp8ObGUGVOMX7rTbCr441h6uVt6dARmy9Aolo3GlVG6R3x4wTRAWlj8
         EJ5hsvL0cqVNLSVdIQqQm8KnoosrbFwBpgUILy9U4MFL0qSKzQyloKCCSCnYhteh9M0+
         aT6w==
X-Gm-Message-State: AOAM530I2uYvZCBu6tZK2PXquGxFW1rLeG7yPv3AyQsc1nrxlprH5Q02
        l8fxXTq7r8i9WZJd4MLGuqUCRk01HfK1
X-Google-Smtp-Source: ABdhPJzodwUpF3ogCC2ZzwWTsJpUxVvsQNocM1flz4IkGFnNZVXeIBky/eXhk8rrT15s93xXB+lyJF3o+faZ
X-Received: from joshdon.svl.corp.google.com ([2620:15c:2cd:202:6b45:ed9d:9cdc:3f67])
 (user=joshdon job=sendgmr) by 2002:a25:908e:: with SMTP id
 t14mr4570299ybl.133.1641598950397; Fri, 07 Jan 2022 15:42:30 -0800 (PST)
Date:   Fri,  7 Jan 2022 15:41:37 -0800
Message-Id: <20220107234138.1765668-1-joshdon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH 1/2] cgroup: add cpu.stat_percpu
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

cpu.stat displays global metrics, such as cgroup usage. It would also be
useful to be able to break these down by cpu; to that end, this patch
adds a new interface, 'cpu.stat_percpu', to display the percpu values of
these stats.

Each line of the output corresponds to a particular metric. The format
of each line is the name of the metric, followed by space delimited
percpu values. The reason for this approach (vs having each line
correspond to a particular cpu) is to make it easier to display extra
subsystem-specific percpu fields.

Signed-off-by: Josh Don <joshdon@google.com>
---
 include/linux/cgroup-defs.h     |   5 +
 kernel/cgroup/cgroup-internal.h |   1 +
 kernel/cgroup/cgroup.c          |  10 ++
 kernel/cgroup/rstat.c           | 159 ++++++++++++++++++++++++++++----
 4 files changed, 155 insertions(+), 20 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index db2e147e069f..7778a011f457 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -461,6 +461,11 @@ struct cgroup {
 	struct cgroup_base_stat bstat;
 	struct prev_cputime prev_cputime;	/* for printing out cputime */
 
+	/* Per-cpu basic resource statistics. These are NULL on root. */
+	struct cgroup_base_stat __percpu *bstat_cpu;
+	struct cgroup_base_stat __percpu *last_bstat_cpu;
+	struct prev_cputime __percpu *prev_cputime_cpu;
+
 	/*
 	 * list of pidlists, up to two for each namespace (one for procs, one
 	 * for tasks); created on demand.
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index bfbeabc17a9d..07e932c4f875 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -254,6 +254,7 @@ int cgroup_rstat_init(struct cgroup *cgrp);
 void cgroup_rstat_exit(struct cgroup *cgrp);
 void cgroup_rstat_boot(void);
 void cgroup_base_stat_cputime_show(struct seq_file *seq);
+void cgroup_base_stat_percpu_cputime_show(struct seq_file *seq);
 
 /*
  * namespace.c
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 919194de39c8..4f5ddce529eb 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3604,6 +3604,12 @@ static int cpu_stat_show(struct seq_file *seq, void *v)
 	return ret;
 }
 
+static int cpu_stat_percpu_show(struct seq_file *seq, void *v)
+{
+	cgroup_base_stat_percpu_cputime_show(seq);
+	return 0;
+}
+
 #ifdef CONFIG_PSI
 static int cgroup_io_pressure_show(struct seq_file *seq, void *v)
 {
@@ -5014,6 +5020,10 @@ static struct cftype cgroup_base_files[] = {
 		.name = "cpu.stat",
 		.seq_show = cpu_stat_show,
 	},
+	{
+		.name = "cpu.stat_percpu",
+		.seq_show = cpu_stat_percpu_show,
+	},
 #ifdef CONFIG_PSI
 	{
 		.name = "io.pressure",
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 1486768f2318..1af37333e5bf 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -253,7 +253,19 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 	if (!cgrp->rstat_cpu) {
 		cgrp->rstat_cpu = alloc_percpu(struct cgroup_rstat_cpu);
 		if (!cgrp->rstat_cpu)
-			return -ENOMEM;
+			goto error_nomem;
+
+		cgrp->last_bstat_cpu = alloc_percpu(struct cgroup_base_stat);
+		if (!cgrp->last_bstat_cpu)
+			goto error_nomem;
+
+		cgrp->bstat_cpu = alloc_percpu(struct cgroup_base_stat);
+		if (!cgrp->bstat_cpu)
+			goto error_nomem;
+
+		cgrp->prev_cputime_cpu = alloc_percpu(struct prev_cputime);
+		if (!cgrp->prev_cputime_cpu)
+			goto error_nomem;
 	}
 
 	/* ->updated_children list is self terminated */
@@ -265,6 +277,21 @@ int cgroup_rstat_init(struct cgroup *cgrp)
 	}
 
 	return 0;
+
+error_nomem:
+	free_percpu(cgrp->rstat_cpu);
+	cgrp->rstat_cpu = NULL;
+
+	free_percpu(cgrp->last_bstat_cpu);
+	cgrp->last_bstat_cpu = NULL;
+
+	free_percpu(cgrp->bstat_cpu);
+	cgrp->bstat_cpu = NULL;
+
+	free_percpu(cgrp->prev_cputime_cpu);
+	cgrp->prev_cputime_cpu = NULL;
+
+	return -ENOMEM;
 }
 
 void cgroup_rstat_exit(struct cgroup *cgrp)
@@ -284,6 +311,12 @@ void cgroup_rstat_exit(struct cgroup *cgrp)
 
 	free_percpu(cgrp->rstat_cpu);
 	cgrp->rstat_cpu = NULL;
+	free_percpu(cgrp->last_bstat_cpu);
+	cgrp->last_bstat_cpu = NULL;
+	free_percpu(cgrp->bstat_cpu);
+	cgrp->bstat_cpu = NULL;
+	free_percpu(cgrp->prev_cputime_cpu);
+	cgrp->prev_cputime_cpu = NULL;
 }
 
 void __init cgroup_rstat_boot(void)
@@ -319,22 +352,29 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 	struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
 	struct cgroup *parent = cgroup_parent(cgrp);
 	struct cgroup_base_stat cur, delta;
+	struct cgroup_base_stat *bstat_cpu, *last_bstat_cpu;
 	unsigned seq;
 
 	/* Root-level stats are sourced from system-wide CPU stats */
 	if (!parent)
 		return;
 
+	/* these are not present on root */
+	bstat_cpu = per_cpu_ptr(cgrp->bstat_cpu, cpu);
+	last_bstat_cpu = per_cpu_ptr(cgrp->last_bstat_cpu, cpu);
+
 	/* fetch the current per-cpu values */
 	do {
 		seq = __u64_stats_fetch_begin(&rstatc->bsync);
 		cur.cputime = rstatc->bstat.cputime;
 	} while (__u64_stats_fetch_retry(&rstatc->bsync, seq));
 
+
 	/* propagate percpu delta to global */
 	delta = cur;
 	cgroup_base_stat_sub(&delta, &rstatc->last_bstat);
 	cgroup_base_stat_add(&cgrp->bstat, &delta);
+	cgroup_base_stat_add(bstat_cpu, &delta);
 	cgroup_base_stat_add(&rstatc->last_bstat, &delta);
 
 	/* propagate global delta to parent (unless that's root) */
@@ -343,6 +383,11 @@ static void cgroup_base_stat_flush(struct cgroup *cgrp, int cpu)
 		cgroup_base_stat_sub(&delta, &cgrp->last_bstat);
 		cgroup_base_stat_add(&parent->bstat, &delta);
 		cgroup_base_stat_add(&cgrp->last_bstat, &delta);
+
+		delta = *bstat_cpu;
+		cgroup_base_stat_sub(&delta, last_bstat_cpu);
+		cgroup_base_stat_add(per_cpu_ptr(parent->bstat_cpu, cpu), &delta);
+		cgroup_base_stat_add(last_bstat_cpu, &delta);
 	}
 }
 
@@ -400,6 +445,30 @@ void __cgroup_account_cputime_field(struct cgroup *cgrp,
 	cgroup_base_stat_cputime_account_end(cgrp, rstatc, flags);
 }
 
+/* See root_cgroup_cputime. Note that this does not first reset cputime. */
+static void root_cgroup_add_cputime_cpu(struct task_cputime *cputime, int cpu)
+{
+	struct kernel_cpustat kcpustat;
+	u64 *cpustat = kcpustat.cpustat;
+	u64 user = 0;
+	u64 sys = 0;
+
+	kcpustat_cpu_fetch(&kcpustat, cpu);
+
+	user += cpustat[CPUTIME_USER];
+	user += cpustat[CPUTIME_NICE];
+	cputime->utime += user;
+
+	sys += cpustat[CPUTIME_SYSTEM];
+	sys += cpustat[CPUTIME_IRQ];
+	sys += cpustat[CPUTIME_SOFTIRQ];
+	cputime->stime += sys;
+
+	cputime->sum_exec_runtime += user;
+	cputime->sum_exec_runtime += sys;
+	cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
+}
+
 /*
  * compute the cputime for the root cgroup by getting the per cpu data
  * at a global level, then categorizing the fields in a manner consistent
@@ -414,25 +483,7 @@ static void root_cgroup_cputime(struct task_cputime *cputime)
 	cputime->utime = 0;
 	cputime->sum_exec_runtime = 0;
 	for_each_possible_cpu(i) {
-		struct kernel_cpustat kcpustat;
-		u64 *cpustat = kcpustat.cpustat;
-		u64 user = 0;
-		u64 sys = 0;
-
-		kcpustat_cpu_fetch(&kcpustat, i);
-
-		user += cpustat[CPUTIME_USER];
-		user += cpustat[CPUTIME_NICE];
-		cputime->utime += user;
-
-		sys += cpustat[CPUTIME_SYSTEM];
-		sys += cpustat[CPUTIME_IRQ];
-		sys += cpustat[CPUTIME_SOFTIRQ];
-		cputime->stime += sys;
-
-		cputime->sum_exec_runtime += user;
-		cputime->sum_exec_runtime += sys;
-		cputime->sum_exec_runtime += cpustat[CPUTIME_STEAL];
+		root_cgroup_add_cputime_cpu(cputime, i);
 	}
 }
 
@@ -464,3 +515,71 @@ void cgroup_base_stat_cputime_show(struct seq_file *seq)
 		   "system_usec %llu\n",
 		   usage, utime, stime);
 }
+
+void cgroup_base_stat_percpu_cputime_show(struct seq_file *seq)
+{
+	static DEFINE_MUTEX(mutex);
+	static DEFINE_PER_CPU(struct cgroup_base_stat, cached_percpu_stats);
+	struct cgroup_base_stat *cached_bstat;
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	u64 val;
+	int cpu;
+
+	/* protects cached_percpu_stats */
+	mutex_lock(&mutex);
+
+	if (cgroup_parent(cgrp)) {
+		struct cgroup_base_stat *bstat_cpu;
+
+		cgroup_rstat_flush_hold(cgrp);
+
+		for_each_possible_cpu(cpu) {
+			bstat_cpu = per_cpu_ptr(cgrp->bstat_cpu, cpu);
+			cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
+
+			cached_bstat->cputime.sum_exec_runtime =
+				bstat_cpu->cputime.sum_exec_runtime;
+			cputime_adjust(&bstat_cpu->cputime,
+				       per_cpu_ptr(cgrp->prev_cputime_cpu, cpu),
+				       &cached_bstat->cputime.utime,
+				       &cached_bstat->cputime.stime);
+		}
+
+		cgroup_rstat_flush_release();
+	} else {
+		for_each_possible_cpu(cpu) {
+			cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
+			memset(cached_bstat, 0, sizeof(*cached_bstat));
+			root_cgroup_add_cputime_cpu(&cached_bstat->cputime, cpu);
+		}
+	}
+
+	seq_puts(seq, "usage_usec");
+	for_each_possible_cpu(cpu) {
+		cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
+		val = cached_bstat->cputime.sum_exec_runtime;
+		do_div(val, NSEC_PER_USEC);
+		seq_printf(seq, " %llu", val);
+	}
+	seq_puts(seq, "\n");
+
+	seq_puts(seq, "user_usec");
+	for_each_possible_cpu(cpu) {
+		cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
+		val = cached_bstat->cputime.utime;
+		do_div(val, NSEC_PER_USEC);
+		seq_printf(seq, " %llu", val);
+	}
+	seq_puts(seq, "\n");
+
+	seq_puts(seq, "system_usec");
+	for_each_possible_cpu(cpu) {
+		cached_bstat = per_cpu_ptr(&cached_percpu_stats, cpu);
+		val = cached_bstat->cputime.stime;
+		do_div(val, NSEC_PER_USEC);
+		seq_printf(seq, " %llu", val);
+	}
+	seq_puts(seq, "\n");
+
+	mutex_unlock(&mutex);
+}
-- 
2.34.1.575.g55b058a8bb-goog

