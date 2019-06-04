Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3883933CF5
	for <lists+cgroups@lfdr.de>; Tue,  4 Jun 2019 03:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbfFDB6f (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 Jun 2019 21:58:35 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:34101 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfFDB6f (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 3 Jun 2019 21:58:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0TTNnVvj_1559613510;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TTNnVvj_1559613510)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Jun 2019 09:58:30 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        Tejun Heo <tj@kernel.org>,
        Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Caspar Zhang <caspar@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [RFC PATCH 2/3] psi: cgroup v1 support
Date:   Tue,  4 Jun 2019 09:57:44 +0800
Message-Id: <20190604015745.78972-3-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.856.g8858448bb
In-Reply-To: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
References: <20190604015745.78972-1-joseph.qi@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Implements pressure stall tracking for cgroup v1.

Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
---
 kernel/sched/psi.c | 65 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 7acc632c3b82..909083c828d5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -719,13 +719,30 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 	return state_mask;
 }
 
-static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+static struct cgroup *psi_task_cgroup(struct task_struct *task, enum psi_res res)
+{
+	switch (res) {
+	case NR_PSI_RESOURCES:
+		return task_dfl_cgroup(task);
+	case PSI_IO:
+		return task_cgroup(task, io_cgrp_subsys.id);
+	case PSI_MEM:
+		return task_cgroup(task, memory_cgrp_subsys.id);
+	case PSI_CPU:
+		return task_cgroup(task, cpu_cgrp_subsys.id);
+	default:  /* won't reach here */
+		return NULL;
+	}
+}
+
+static struct psi_group *iterate_groups(struct task_struct *task, void **iter,
+					enum psi_res res)
 {
 #ifdef CONFIG_CGROUPS
 	struct cgroup *cgroup = NULL;
 
 	if (!*iter)
-		cgroup = task->cgroups->dfl_cgrp;
+		cgroup = psi_task_cgroup(task, res);
 	else if (*iter == &psi_system)
 		return NULL;
 	else
@@ -776,15 +793,45 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 		     wq_worker_last_func(task) == psi_avgs_work))
 		wake_clock = false;
 
-	while ((group = iterate_groups(task, &iter))) {
-		u32 state_mask = psi_group_change(group, cpu, clear, set);
+	if (cgroup_subsys_on_dfl(cpu_cgrp_subsys) ||
+	    cgroup_subsys_on_dfl(memory_cgrp_subsys) ||
+	    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
+		while ((group = iterate_groups(task, &iter, NR_PSI_RESOURCES))) {
+			u32 state_mask = psi_group_change(group, cpu, clear, set);
 
-		if (state_mask & group->poll_states)
-			psi_schedule_poll_work(group, 1);
+			if (state_mask & group->poll_states)
+				psi_schedule_poll_work(group, 1);
 
-		if (wake_clock && !delayed_work_pending(&group->avgs_work))
-			schedule_delayed_work(&group->avgs_work, PSI_FREQ);
+			if (wake_clock && !delayed_work_pending(&group->avgs_work))
+				schedule_delayed_work(&group->avgs_work, PSI_FREQ);
+		}
+	} else {
+		enum psi_task_count i;
+		enum psi_res res;
+		int psi_flags = clear | set;
+
+		for (i = NR_IOWAIT; i < NR_PSI_TASK_COUNTS; i++) {
+			if ((i == NR_IOWAIT) && (psi_flags & TSK_IOWAIT))
+				res = PSI_IO;
+			else if ((i == NR_MEMSTALL) && (psi_flags & TSK_MEMSTALL))
+				res = PSI_MEM;
+			else if ((i == NR_RUNNING) && (psi_flags & TSK_RUNNING))
+				res = PSI_CPU;
+			else
+				continue;
+
+			while ((group = iterate_groups(task, &iter, res))) {
+				u32 state_mask = psi_group_change(group, cpu, clear, set);
+
+				if (state_mask & group->poll_states)
+					psi_schedule_poll_work(group, 1);
+
+				if (wake_clock && !delayed_work_pending(&group->avgs_work))
+					schedule_delayed_work(&group->avgs_work, PSI_FREQ);
+			}
+		}
 	}
+
 }
 
 void psi_memstall_tick(struct task_struct *task, int cpu)
@@ -792,7 +839,7 @@ void psi_memstall_tick(struct task_struct *task, int cpu)
 	struct psi_group *group;
 	void *iter = NULL;
 
-	while ((group = iterate_groups(task, &iter))) {
+	while ((group = iterate_groups(task, &iter, PSI_MEM))) {
 		struct psi_group_cpu *groupc;
 
 		groupc = per_cpu_ptr(group->pcpu, cpu);
-- 
2.19.1.856.g8858448bb

