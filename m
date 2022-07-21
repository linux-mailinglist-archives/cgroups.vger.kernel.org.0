Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6BA57C334
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGUEG3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGUEFt (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:49 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94D52E9FD
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:40 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id s18-20020a17090aa11200b001f1e9e2438cso4023901pjp.2
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IajutrYR1gNldwnX+rwhURWEvmgjhBqy7g0eKQMrBVs=;
        b=UnxLTwZRABkrK5soWvqW5KuugHBHwTDqjNtjq9rDE9oDCJT2dmpwUaBzxANv/yqa3W
         Vw665jPOgVDi3e2/19NQL1VJrgoHHZN7tq9+MO15GHDsqb1kMKFZbLYYGpHcmelECSyt
         jaKalYKYWN0QBeF8mpL99kV419pD4QLzFhdQPvoxMeuQBz2YKEcVHFOhd+ijmnSHCU4j
         LD+jT1Ib06Vdb1zsIsHuX8xDzijvEtrrTyqYnjz56Ryk2bSBRiMLQDPhe2ZFNuNZz2Z4
         EP7S2RTJML8twwVepBbW6lg1kqWMwfBBuKPzGDtxaA9N91e5hTulGJPBOCzT2zVd8ZFN
         v0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IajutrYR1gNldwnX+rwhURWEvmgjhBqy7g0eKQMrBVs=;
        b=1g74+zhRzvyWcqwTEuYqMVzbg/aZN8OrAiKNE73JfnqNa5d4zTkvE1KN6bxbgKyQUk
         21TfXzeWR5S3FWVDUjj6I9qYP0ihE8+fDSh6QYefFoyF3H39wI4v0jvgpqjGxJ+IVBcn
         u9Kh4v6nPff24nwP3Ee0ShZtSfrONRswr4LPFegSJdsa/mbmcsyQqe4xUoa7T8ANxxVE
         x0cRnto20qOBYWF3KC+r8MuJfyaw+o2kLVZ6rmG89f6uM1YHhIY4xVUslH1aFvMY+Vqy
         OBnoE7PW7PMC/OYOYTUjBSTugBoqzfFHqw0pZ0pfZh/Uc6AAELepydr/30RJZMyS3co7
         cLWg==
X-Gm-Message-State: AJIora8INWB62WBUuc6pSJ/l7c7FB/hEWQpRD2JxbgB5uC/crnJ7uRds
        ac3/ofQ11uarr/2w7dBoOjltfk0o/y85KA==
X-Google-Smtp-Source: AGRyM1uPJwgj7AqMyj+5vZko6fV+c6MYVQ1nKW7O6lLwEGglY6UbZr1YquCVRjcgQcRntK0ORrDZkg==
X-Received: by 2002:a17:90a:9488:b0:1f2:2768:facf with SMTP id s8-20020a17090a948800b001f22768facfmr4044039pjo.38.1658376340385;
        Wed, 20 Jul 2022 21:05:40 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:40 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 9/9] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Date:   Thu, 21 Jul 2022 12:04:39 +0800
Message-Id: <20220721040439.2651-10-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Now PSI already tracked workload pressure stall information for
CPU, memory and IO. Apart from these, IRQ/SOFTIRQ could have
obvious impact on some workload productivity, such as web service
workload.

When CONFIG_IRQ_TIME_ACCOUNTING, we can get IRQ/SOFTIRQ delta time
from update_rq_clock_task(), in which we can record that delta
to CPU curr task's cgroups as PSI_IRQ_FULL status.

Note we don't use PSI_IRQ_SOME since IRQ/SOFTIRQ always happen in
the current task on the CPU, make nothing productive could run
even if it were runnable, so we only use PSI_IRQ_FULL.

For performance impact consideration, this is enabled by default when
CONFIG_IRQ_TIME_ACCOUNTING, but can be disabled by kernel cmdline
parameter "psi_irq=".

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 include/linux/psi.h                           |  1 +
 include/linux/psi_types.h                     |  7 +-
 kernel/cgroup/cgroup.c                        | 27 +++++++
 kernel/sched/core.c                           |  1 +
 kernel/sched/psi.c                            | 76 ++++++++++++++++++-
 kernel/sched/stats.h                          | 13 ++++
 7 files changed, 126 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6beef5b8bc36..1067dde299a0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4425,6 +4425,11 @@
 			Format: <bool>
 			default: enabled
 
+	psi_irq=	[KNL] Enable or disable IRQ/SOFTIRQ pressure stall
+			information tracking.
+			Format: <bool>
+			default: enabled when CONFIG_IRQ_TIME_ACCOUNTING.
+
 	psmouse.proto=	[HW,MOUSE] Highest PS2 mouse protocol extension to
 			probe for; one of (bare|imps|exps|lifebook|any).
 	psmouse.rate=	[HW,MOUSE] Set desired mouse report rate, in reports
diff --git a/include/linux/psi.h b/include/linux/psi.h
index aa168a038242..f5cf3e45d5a5 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -14,6 +14,7 @@ struct css_set;
 #ifdef CONFIG_PSI
 
 extern struct static_key_false psi_disabled;
+extern struct static_key_true psi_irq_enabled;
 extern struct psi_group psi_system;
 
 void psi_init(void);
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index c124f7d186d0..195f123b1cd1 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -47,7 +47,8 @@ enum psi_res {
 	PSI_IO,
 	PSI_MEM,
 	PSI_CPU,
-	NR_PSI_RESOURCES = 3,
+	PSI_IRQ,
+	NR_PSI_RESOURCES = 4,
 };
 
 /*
@@ -63,9 +64,11 @@ enum psi_states {
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
 	PSI_CPU_FULL,
+	PSI_IRQ_SOME,
+	PSI_IRQ_FULL,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 7,
+	NR_PSI_STATES = 9,
 };
 
 enum psi_aggregators {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1424da7ed2c4..cf61df0ac892 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3683,6 +3683,23 @@ static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
 	return cgroup_pressure_write(of, buf, nbytes, PSI_CPU);
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static int cgroup_irq_pressure_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+
+	return psi_show(seq, psi, PSI_IRQ);
+}
+
+static ssize_t cgroup_irq_pressure_write(struct kernfs_open_file *of,
+					  char *buf, size_t nbytes,
+					  loff_t off)
+{
+	return cgroup_pressure_write(of, buf, nbytes, PSI_IRQ);
+}
+#endif
+
 static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 					  poll_table *pt)
 {
@@ -5079,6 +5096,16 @@ static struct cftype cgroup_base_files[] = {
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
 	},
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	{
+		.name = "irq.pressure",
+		.flags = CFTYPE_PRESSURE,
+		.seq_show = cgroup_irq_pressure_show,
+		.write = cgroup_irq_pressure_write,
+		.poll = cgroup_pressure_poll,
+		.release = cgroup_pressure_release,
+	},
+#endif
 #endif /* CONFIG_PSI */
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f5f2d3542b05..08637cfb7ed9 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -708,6 +708,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 
 	rq->prev_irq_time += irq_delta;
 	delta -= irq_delta;
+	psi_account_irqtime(rq->curr, irq_delta);
 #endif
 #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
 	if (static_key_false((&paravirt_steal_rq_enabled))) {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8d76920f47b3..6a0894e28780 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -141,6 +141,7 @@ static int psi_bug __read_mostly;
 
 DEFINE_STATIC_KEY_FALSE(psi_disabled);
 DEFINE_STATIC_KEY_TRUE(psi_cgroups_enabled);
+DEFINE_STATIC_KEY_TRUE(psi_irq_enabled);
 
 #ifdef CONFIG_PSI_DEFAULT_DISABLED
 static bool psi_enable;
@@ -150,6 +151,12 @@ static bool psi_enable = true;
 
 static bool psi_inner_cgroup __read_mostly = true;
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static bool psi_irq_enable = true;
+#else
+static bool psi_irq_enable;
+#endif
+
 static int __init setup_psi(char *str)
 {
 	return kstrtobool(str, &psi_enable) == 0;
@@ -162,6 +169,12 @@ static int __init setup_psi_inner_cgroup(char *str)
 }
 __setup("psi_inner_cgroup=", setup_psi_inner_cgroup);
 
+static int __init setup_psi_irq(char *str)
+{
+	return kstrtobool(str, &psi_irq_enable) == 0;
+}
+__setup("psi_irq=", setup_psi_irq);
+
 /* Running averages - we need to be higher-res than loadavg */
 #define PSI_FREQ	(2*HZ+1)	/* 2 sec intervals */
 #define EXP_10s		1677		/* 1/exp(2s/10s) as fixed-point */
@@ -215,12 +228,16 @@ void __init psi_init(void)
 	if (!psi_enable) {
 		static_branch_enable(&psi_disabled);
 		static_branch_disable(&psi_cgroups_enabled);
+		static_branch_disable(&psi_irq_enabled);
 		return;
 	}
 
 	if (!cgroup_psi_enabled())
 		static_branch_disable(&psi_cgroups_enabled);
 
+	if (!psi_irq_enable)
+		static_branch_disable(&psi_irq_enabled);
+
 	psi_period = jiffies_to_nsecs(PSI_FREQ);
 	group_init(&psi_system);
 }
@@ -893,6 +910,28 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	}
 }
 
+void psi_groups_account_irqtime(struct task_struct *task, u32 delta)
+{
+	struct psi_group *group = task_psi_group(task);
+	int cpu = task_cpu(task);
+	u64 now = cpu_clock(cpu);
+	struct psi_group_cpu *groupc;
+
+	for_each_psi_group(group) {
+		groupc = per_cpu_ptr(group->pcpu, cpu);
+
+		write_seqcount_begin(&groupc->seq);
+
+		record_times(groupc, now);
+		groupc->times[PSI_IRQ_FULL] += delta;
+
+		write_seqcount_end(&groupc->seq);
+
+		if (group->poll_states & (1 << PSI_IRQ_FULL))
+			psi_schedule_poll_work(group, 1);
+	}
+}
+
 /**
  * psi_memstall_enter - mark the beginning of a memory stall section
  * @flags: flags to handle nested sections
@@ -1069,7 +1108,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2; full++) {
+	for (full = (res == PSI_IRQ); full < 2; full++) {
 		unsigned long avg[3] = { 0, };
 		u64 total = 0;
 		int w;
@@ -1111,9 +1150,12 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	else
 		return ERR_PTR(-EINVAL);
 
-	if (state >= PSI_NONIDLE)
+	if (state >= PSI_NONIDLE || state == PSI_IRQ_SOME)
 		return ERR_PTR(-EINVAL);
 
+	if (!static_branch_likely(&psi_irq_enabled) && state == PSI_IRQ_FULL)
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (window_us < WINDOW_MIN_US ||
 		window_us > WINDOW_MAX_US)
 		return ERR_PTR(-EINVAL);
@@ -1395,6 +1437,33 @@ static const struct proc_ops psi_cpu_proc_ops = {
 	.proc_release	= psi_fop_release,
 };
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static int psi_irq_show(struct seq_file *m, void *v)
+{
+	return psi_show(m, &psi_system, PSI_IRQ);
+}
+
+static int psi_irq_open(struct inode *inode, struct file *file)
+{
+	return psi_open(file, psi_irq_show);
+}
+
+static ssize_t psi_irq_write(struct file *file, const char __user *user_buf,
+			     size_t nbytes, loff_t *ppos)
+{
+	return psi_write(file, user_buf, nbytes, PSI_IRQ);
+}
+
+static const struct proc_ops psi_irq_proc_ops = {
+	.proc_open	= psi_irq_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_write	= psi_irq_write,
+	.proc_poll	= psi_fop_poll,
+	.proc_release	= psi_fop_release,
+};
+#endif
+
 static int __init psi_proc_init(void)
 {
 	if (psi_enable) {
@@ -1402,6 +1471,9 @@ static int __init psi_proc_init(void)
 		proc_create("pressure/io", 0666, NULL, &psi_io_proc_ops);
 		proc_create("pressure/memory", 0666, NULL, &psi_memory_proc_ops);
 		proc_create("pressure/cpu", 0666, NULL, &psi_cpu_proc_ops);
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+		proc_create("pressure/irq", 0666, NULL, &psi_irq_proc_ops);
+#endif
 	}
 	return 0;
 }
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index e930b8fa6253..10926cdaccc8 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -111,6 +111,7 @@ void psi_change_groups(struct task_struct *task, int clear, int set);
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
+void psi_groups_account_irqtime(struct task_struct *task, u32 delta);
 
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -196,6 +197,17 @@ static inline void psi_sched_switch(struct task_struct *prev,
 	psi_task_switch(prev, next, sleep);
 }
 
+static inline void psi_account_irqtime(struct task_struct *task, u32 delta)
+{
+	if (!static_branch_likely(&psi_irq_enabled))
+		return;
+
+	if (!task->pid)
+		return;
+
+	psi_groups_account_irqtime(task, delta);
+}
+
 #else /* CONFIG_PSI */
 static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
 static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
@@ -203,6 +215,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
+static inline void psi_account_irqtime(struct task_struct *curr, u32 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.36.1

