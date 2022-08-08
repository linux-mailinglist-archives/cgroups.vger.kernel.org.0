Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2800158C735
	for <lists+cgroups@lfdr.de>; Mon,  8 Aug 2022 13:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242891AbiHHLGL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Aug 2022 07:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242799AbiHHLF0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Aug 2022 07:05:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC61125E5
        for <cgroups@vger.kernel.org>; Mon,  8 Aug 2022 04:05:17 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f30so7407740pfq.4
        for <cgroups@vger.kernel.org>; Mon, 08 Aug 2022 04:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sog88LybOCvHlT3337HIqyED+jJvkJWFArOosiQRxf4=;
        b=Zpu1ApVNsDKL+42r1juQPvCQE1XgOHQj3uARY1TQVApNITl5jeKONnWMX8pNs9276N
         +ZZX/RKmLJwZ1FZl27idZ4QZ5EHzI/XYj1SRooDFCfxXYlyp9vDEH8nClb6H5YDAZIKa
         D7lCbXp+II8c8AYDH5UntEiEBercHof/byjMh3pTkcu5Ox4WmR+RN2ggtd0ZrYfR2Tn9
         uqnvbkL/jyqf5jBBc0c7igtQz0m58DniYfYZDAarxgKlm8orvR6xRrPyHtzuvaNiXpDB
         6fsIh7ekJFbUALYvvTgDt6ndwQrAKjl1gATeMsN+m2ixp0v8QKr6bfV8/z9N8JqPfQQi
         rDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sog88LybOCvHlT3337HIqyED+jJvkJWFArOosiQRxf4=;
        b=lPNtxunCKm6vIHGebNhxYfltFsV9jBy8hVYDVOQNxZDKhEnPjd9nHR5BwHcYhgs0xI
         NuWpaaC5unvm/VnHizDQPJ61Z8tJo1tps7fok1kspQC/aXvaqQi6AWaQN3uP1kpkSgsa
         ujumHhTe3dL+6qQCUASINTR4gNaG+D42mPStxjGMYNsbbyUFEWJoShQKn5e5+mwnp0SH
         Nt/RIGsqAq2UGYrk/OzUCp56AnLTRQP9aerDlqKXV+kGibw+be46+1nueaDzQ0g792TC
         dpay3PmWqjr9aBecrv7CDDUF3RnNY/hWLfOycab+QdWrwxZN9dLhH4rwYXPivGMYY2HU
         6Nmg==
X-Gm-Message-State: ACgBeo2+Pl1W8cUkGI0lu+z7e2UTbUelMA1GMBnnQpQehJ8INOeRu42g
        xkhcGP1A8/2DkIgjUu+Z6lpLDQ==
X-Google-Smtp-Source: AA6agR4jQ9e7D1IPq9yJMgv0wDu2KkbYixhuGq1dVqhvSMr8p/sDkC8ibPXnsuWKkvKhElKS/3kFaQ==
X-Received: by 2002:a05:6a00:14c7:b0:52e:efb7:bd05 with SMTP id w7-20020a056a0014c700b0052eefb7bd05mr9628890pfu.24.1659956716533;
        Mon, 08 Aug 2022 04:05:16 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:05:16 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 08/10] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Date:   Mon,  8 Aug 2022 19:03:39 +0800
Message-Id: <20220808110341.15799-9-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220808110341.15799-1-zhouchengming@bytedance.com>
References: <20220808110341.15799-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  6 +++
 include/linux/psi_types.h               |  6 ++-
 kernel/cgroup/cgroup.c                  | 27 ++++++++++
 kernel/sched/core.c                     |  1 +
 kernel/sched/psi.c                      | 65 ++++++++++++++++++++++++-
 kernel/sched/stats.h                    |  2 +
 6 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 176298f2f4de..dd84e34bc051 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -968,6 +968,12 @@ All cgroup core files are prefixed with "cgroup."
 	killing cgroups is a process directed operation, i.e. it affects
 	the whole thread-group.
 
+  irq.pressure
+	A read-write nested-keyed file.
+
+	Shows pressure stall information for IRQ/SOFTIRQ. See
+	:ref:`Documentation/accounting/psi.rst <psi>` for details.
+
 Controllers
 ===========
 
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 54cb74946db4..4677655f6ca1 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -42,7 +42,8 @@ enum psi_res {
 	PSI_IO,
 	PSI_MEM,
 	PSI_CPU,
-	NR_PSI_RESOURCES = 3,
+	PSI_IRQ,
+	NR_PSI_RESOURCES = 4,
 };
 
 /*
@@ -58,9 +59,10 @@ enum psi_states {
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
 	PSI_CPU_FULL,
+	PSI_IRQ_FULL,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 7,
+	NR_PSI_STATES = 8,
 };
 
 /* Use one bit in the state mask to track TSK_ONCPU */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5f88117fc81e..91de8ff7fa50 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3692,6 +3692,23 @@ static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
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
@@ -5088,6 +5105,16 @@ static struct cftype cgroup_base_files[] = {
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
index 3aa401689f7e..4cfb6ab32142 100644
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
index 1c675715ed33..58f8092c938f 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -910,6 +910,34 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	}
 }
 
+void psi_account_irqtime(struct task_struct *task, u32 delta)
+{
+	int cpu = task_cpu(task);
+	void *iter = NULL;
+	struct psi_group *group;
+	struct psi_group_cpu *groupc;
+	u64 now;
+
+	if (!task->pid)
+		return;
+
+	now = cpu_clock(cpu);
+
+	while ((group = iterate_groups(task, &iter))) {
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
@@ -1078,7 +1106,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2; full++) {
+	for (full = 0; full < 2 - (res == PSI_IRQ); full++) {
 		unsigned long avg[3] = { 0, };
 		u64 total = 0;
 		int w;
@@ -1092,7 +1120,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		}
 
 		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
-			   full ? "full" : "some",
+			   full || (res == PSI_IRQ) ? "full" : "some",
 			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
 			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
 			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
@@ -1120,6 +1148,9 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	else
 		return ERR_PTR(-EINVAL);
 
+	if ((res == PSI_IRQ) && (--state != PSI_IRQ_FULL))
+		return ERR_PTR(-EINVAL);
+
 	if (state >= PSI_NONIDLE)
 		return ERR_PTR(-EINVAL);
 
@@ -1404,6 +1435,33 @@ static const struct proc_ops psi_cpu_proc_ops = {
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
@@ -1411,6 +1469,9 @@ static int __init psi_proc_init(void)
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
index e930b8fa6253..8b6cfc7a56f5 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -111,6 +111,7 @@ void psi_change_groups(struct task_struct *task, int clear, int set);
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
+void psi_account_irqtime(struct task_struct *task, u32 delta);
 
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -203,6 +204,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
+static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.36.1

