Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01945A16FD
	for <lists+cgroups@lfdr.de>; Thu, 25 Aug 2022 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbiHYQpJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Aug 2022 12:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243301AbiHYQo3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 25 Aug 2022 12:44:29 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BBBB6A9
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:43:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id jm11so18977675plb.13
        for <cgroups@vger.kernel.org>; Thu, 25 Aug 2022 09:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=8zSngJc0xooKlhE/eQjAwV0zhxYwm2DfMI4ravCBhpE=;
        b=D+ohCdSoPVccePne5Gid2JiTeKZqocAN3FD1vrYNzCpnJbHRz5hIi/1TRMVHQ0HIwz
         GVmN8A5X9dnG+q/oKffUMwIbrxodEg7BealiuWVjXIQ+90TuZoXD1AT3dgz0MR7c1O8T
         lLgttUw7WIfT3eAuMPKxNkMjwBgPQEXy/w08At9hZMmTlcimFixKbSbjlJFQQrGAks5T
         pu5fGDqLpWMnTkji365OfZRBignV18vKe0InFhM9h9BxcpzkoNqsjfazV8Bpugv/Lqdn
         MT/KWpC0DndoymR5fszcOTx8aaG4blVJsveEBqXo8wBcUmyHns+CBnT5Hnx6fek9My5E
         vsrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=8zSngJc0xooKlhE/eQjAwV0zhxYwm2DfMI4ravCBhpE=;
        b=mziAobvUDOnZdAfclD8PL5IIMpieh2T5YIpPURD3MgSDWFzvLet7fC/qMkWVTVeTmg
         cnrkhuF/RfuzG1TtdomxG3y9PpHi5g/ItL+jLmp56TTa5cGPegeT801jAlO52yXiSzPv
         6RM+H5LKMA0WQLAucQOLCema4CTPBqhK99CvqeMmoOoEGsRBYyq9c4N0T/0S8ZVBYq/n
         5je1sAezPvtpSF80zQ3L9YVPgB7c/B+t0zunMr4I7yWisnv/jRZct0A8rDXqaKpHPzH6
         HSkZxbnLUxGfZJ4LoDsamPfdG9YchL+XFDZDLC3bex8k+lqmo/ONGBByg2v7paiAfNih
         HT5A==
X-Gm-Message-State: ACgBeo0LqpRoUIpD0wCI+l8o1wbE45Dip1npbPpYPhkoIRqHjtaawm9i
        2ATg1IQ3oh7BM21ouiaREXzz5Q==
X-Google-Smtp-Source: AA6agR7No0v6NdwYsouySAcbkLmWVPRuKBYQ7KrrUeD7+S3LiXtQouYYpWbR6ycHJtcuwBJALiPCLA==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr15017462pjb.164.1661445792470;
        Thu, 25 Aug 2022 09:43:12 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id b18-20020a62a112000000b005362314bf80sm12779408pff.67.2022.08.25.09.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 09:43:12 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, mkoutny@suse.com,
        surenb@google.com
Cc:     mingo@redhat.com, peterz@infradead.org, gregkh@linuxfoundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v4 07/10] sched/psi: add PSI_IRQ to track IRQ/SOFTIRQ pressure
Date:   Fri, 26 Aug 2022 00:41:08 +0800
Message-Id: <20220825164111.29534-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164111.29534-1-zhouchengming@bytedance.com>
References: <20220825164111.29534-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 Documentation/admin-guide/cgroup-v2.rst |  6 ++
 include/linux/psi_types.h               | 10 +++-
 kernel/cgroup/cgroup.c                  | 27 +++++++++
 kernel/sched/core.c                     |  1 +
 kernel/sched/psi.c                      | 74 ++++++++++++++++++++++++-
 kernel/sched/stats.h                    |  2 +
 6 files changed, 116 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index be4a77baf784..971c418bc778 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -976,6 +976,12 @@ All cgroup core files are prefixed with "cgroup."
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
index 54cb74946db4..40c28171cd91 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -42,7 +42,10 @@ enum psi_res {
 	PSI_IO,
 	PSI_MEM,
 	PSI_CPU,
-	NR_PSI_RESOURCES = 3,
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	PSI_IRQ,
+#endif
+	NR_PSI_RESOURCES,
 };
 
 /*
@@ -58,9 +61,12 @@ enum psi_states {
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
 	PSI_CPU_FULL,
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	PSI_IRQ_FULL,
+#endif
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 7,
+	NR_PSI_STATES,
 };
 
 /* Use one bit in the state mask to track TSK_ONCPU */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 2f79ddf9a85d..371131a8b6f8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3731,6 +3731,23 @@ static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
 	return cgroup_pressure_write(of, buf, nbytes, PSI_CPU);
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+static int cgroup_irq_pressure_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : cgrp->psi;
+
+	return psi_show(seq, psi, PSI_IRQ);
+}
+
+static ssize_t cgroup_irq_pressure_write(struct kernfs_open_file *of,
+					 char *buf, size_t nbytes,
+					 loff_t off)
+{
+	return cgroup_pressure_write(of, buf, nbytes, PSI_IRQ);
+}
+#endif
+
 static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 					  poll_table *pt)
 {
@@ -5150,6 +5167,16 @@ static struct cftype cgroup_base_files[] = {
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
index 61436b8e0337..178f9836ae96 100644
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
index 4702a770e272..2545a78f82d8 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -904,6 +904,36 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	}
 }
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
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
+#endif
+
 /**
  * psi_memstall_enter - mark the beginning of a memory stall section
  * @flags: flags to handle nested sections
@@ -1065,6 +1095,7 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 {
+	bool only_full = false;
 	int full;
 	u64 now;
 
@@ -1079,7 +1110,11 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2; full++) {
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	only_full = res == PSI_IRQ;
+#endif
+
+	for (full = 0; full < 2 - only_full; full++) {
 		unsigned long avg[3] = { 0, };
 		u64 total = 0;
 		int w;
@@ -1093,7 +1128,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		}
 
 		seq_printf(m, "%s avg10=%lu.%02lu avg60=%lu.%02lu avg300=%lu.%02lu total=%llu\n",
-			   full ? "full" : "some",
+			   full || only_full ? "full" : "some",
 			   LOAD_INT(avg[0]), LOAD_FRAC(avg[0]),
 			   LOAD_INT(avg[1]), LOAD_FRAC(avg[1]),
 			   LOAD_INT(avg[2]), LOAD_FRAC(avg[2]),
@@ -1121,6 +1156,11 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 	else
 		return ERR_PTR(-EINVAL);
 
+#ifdef CONFIG_IRQ_TIME_ACCOUNTING
+	if (res == PSI_IRQ && --state != PSI_IRQ_FULL)
+		return ERR_PTR(-EINVAL);
+#endif
+
 	if (state >= PSI_NONIDLE)
 		return ERR_PTR(-EINVAL);
 
@@ -1405,6 +1445,33 @@ static const struct proc_ops psi_cpu_proc_ops = {
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
@@ -1412,6 +1479,9 @@ static int __init psi_proc_init(void)
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
index c39b467ece43..84a188913cc9 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -110,6 +110,7 @@ __schedstats_from_se(struct sched_entity *se)
 void psi_task_change(struct task_struct *task, int clear, int set);
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep);
+void psi_account_irqtime(struct task_struct *task, u32 delta);
 
 /*
  * PSI tracks state that persists across sleeps, such as iowaits and
@@ -205,6 +206,7 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
 static inline void psi_sched_switch(struct task_struct *prev,
 				    struct task_struct *next,
 				    bool sleep) {}
+static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-- 
2.37.2

