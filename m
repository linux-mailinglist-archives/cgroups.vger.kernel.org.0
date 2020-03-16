Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3446B18731D
	for <lists+cgroups@lfdr.de>; Mon, 16 Mar 2020 20:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbgCPTNq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 16 Mar 2020 15:13:46 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36999 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732366AbgCPTNq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 16 Mar 2020 15:13:46 -0400
Received: by mail-qt1-f193.google.com with SMTP id l20so15257557qtp.4
        for <cgroups@vger.kernel.org>; Mon, 16 Mar 2020 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HClDbHcToluJ6uFsLTnoDEA3ZtCwPAYPbZR3l472Wo4=;
        b=KOgCti6JTFX/q6zu/ytDpttfs4YfoZ4KSBJ8ZnM6MCvHyUgC4xFTSI6Q0rlG1y4c7G
         UQcdo3bXYqUMQ26Q7VgKmA6mEe52gHRoSPdbHUtGNPrZeCGFSzSGBmJxk7En5KwC5Jj6
         DV+Zup73f+0TVdmxFIYz9Mj00IW0k6k4Gn9s7LEUTQhXUnJdFOJZGGNFPzS0QKdRNGxP
         YaakwSACFil0yXorFAQHrPHRnlSja7Y2m0DIhyZ8/bpd81Haw/NcSEqA2cmbiIVkk/Va
         OA+ES94LNdGMl8J86cOG8lWNObY8UQh3RFJAtmJ0GnHq7NYAXzdVLWzGPWiA78xll8HP
         j+Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HClDbHcToluJ6uFsLTnoDEA3ZtCwPAYPbZR3l472Wo4=;
        b=eACs+FgM16/Iq/q8pvpukyM0PsJRlRz6NUNratF0BBIxs9ThWLHOYkB6xhs6a/zSMD
         JJ7hYe3NstlQkBAq1LLKZ0AGuPtzRMDqvLWyIw08y/93MNZ9zHFH5WZX3C8mX3i4gxVT
         8PFles59GXAvtUHUHPFT4jwSYDiGH/RHvV77DJxpQLKbepdd6s8Dse0vDrrW8+iTqnSx
         makbJCCNNll5nC3RO3aNvE0j/ZqVbQYTj31bvzqqW/msV1x5kYBX6p7Dt7Lfr5ekYJBY
         xk7DW5/dykHCsyA1lAVtD91LTljnh2AgqEJsNT5UVp2Nys1MM2SDmEJ7nGNPenf5g98G
         wXjA==
X-Gm-Message-State: ANhLgQ3TQV6F00cZhxsH9EmNvmzVkrKoQ87rL6Z7utnrL1NymuRTB2fU
        POXxTaT7jkm0V10udLM3WSSAkg==
X-Google-Smtp-Source: ADFU+vsYDhSf0S17+QesdNohEZ8heC1OgLvJzrmA5EUVZJ61I8rq7L+9T+fUY/4+HoZ5jWB5Wq6tVA==
X-Received: by 2002:ac8:5209:: with SMTP id r9mr1657990qtn.61.1584386024947;
        Mon, 16 Mar 2020 12:13:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f40d])
        by smtp.gmail.com with ESMTPSA id d73sm363960qkg.113.2020.03.16.12.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 12:13:44 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 1/3] psi: fix cpu.pressure for cpu.max and competing cgroups
Date:   Mon, 16 Mar 2020 15:13:31 -0400
Message-Id: <20200316191333.115523-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316191333.115523-1-hannes@cmpxchg.org>
References: <20200316191333.115523-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

For simplicity, cpu pressure is defined as having more than one
runnable task on a given CPU. This works on the system-level, but it
has limitations in a cgrouped reality: When cpu.max is in use, it
doesn't capture the time in which a task is not executing on the CPU
due to throttling. Likewise, it doesn't capture the time in which a
competing cgroup is occupying the CPU - meaning it only reflects
cgroup-internal competitive pressure, not outside pressure.

Enable tracking of currently executing tasks, and then change the
definition of cpu pressure in a cgroup from

	NR_RUNNING > 1

to

	NR_RUNNING > ON_CPU

which will capture the effects of cpu.max as well as competition from
outside the cgroup.

After this patch, a cgroup running `stress -c 1` with a cpu.max
setting of 5000 10000 shows ~50% continuous CPU pressure.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/psi_types.h | 10 +++++++++-
 kernel/sched/core.c       |  2 ++
 kernel/sched/psi.c        | 12 +++++++-----
 kernel/sched/stats.h      | 28 ++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 07aaf9b82241..4b7258495a04 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -14,13 +14,21 @@ enum psi_task_count {
 	NR_IOWAIT,
 	NR_MEMSTALL,
 	NR_RUNNING,
-	NR_PSI_TASK_COUNTS = 3,
+	/*
+	 * This can't have values other than 0 or 1 and could be
+	 * implemented as a bit flag. But for now we still have room
+	 * in the first cacheline of psi_group_cpu, and this way we
+	 * don't have to special case any state tracking for it.
+	 */
+	NR_ONCPU,
+	NR_PSI_TASK_COUNTS = 4,
 };
 
 /* Task state bitmasks */
 #define TSK_IOWAIT	(1 << NR_IOWAIT)
 #define TSK_MEMSTALL	(1 << NR_MEMSTALL)
 #define TSK_RUNNING	(1 << NR_RUNNING)
+#define TSK_ONCPU	(1 << NR_ONCPU)
 
 /* Resources that workloads could be stalled on */
 enum psi_res {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1a9983da4408..f920fbf5dcd1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4074,6 +4074,8 @@ static void __sched notrace __schedule(bool preempt)
 		 */
 		++*switch_count;
 
+		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
+
 		trace_sched_switch(preempt, prev, next);
 
 		/* Also unlocks the rq: */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 028520702717..50128297a4f9 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -225,7 +225,7 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 	case PSI_MEM_FULL:
 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
 	case PSI_CPU_SOME:
-		return tasks[NR_RUNNING] > 1;
+		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -695,10 +695,10 @@ static u32 psi_group_change(struct psi_group *group, int cpu,
 		if (!(m & (1 << t)))
 			continue;
 		if (groupc->tasks[t] == 0 && !psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u] clear=%x set=%x\n",
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
-					clear, set);
+					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
 		groupc->tasks[t]--;
@@ -916,9 +916,11 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	rq = task_rq_lock(task, &rf);
 
-	if (task_on_rq_queued(task))
+	if (task_on_rq_queued(task)) {
 		task_flags = TSK_RUNNING;
-	else if (task->in_iowait)
+		if (task_current(rq, task))
+			task_flags |= TSK_ONCPU;
+	} else if (task->in_iowait)
 		task_flags = TSK_IOWAIT;
 
 	if (task->flags & PF_MEMSTALL)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index ba683fe81a6e..6ff0ac1a803f 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -93,6 +93,14 @@ static inline void psi_dequeue(struct task_struct *p, bool sleep)
 		if (p->flags & PF_MEMSTALL)
 			clear |= TSK_MEMSTALL;
 	} else {
+		/*
+		 * When a task sleeps, schedule() dequeues it before
+		 * switching to the next one. Merge the clearing of
+		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
+		 * psi_task_change() call in psi_sched_switch().
+		 */
+		clear |= TSK_ONCPU;
+
 		if (p->in_iowait)
 			set |= TSK_IOWAIT;
 	}
@@ -126,6 +134,23 @@ static inline void psi_ttwu_dequeue(struct task_struct *p)
 	}
 }
 
+static inline void psi_sched_switch(struct task_struct *prev,
+				    struct task_struct *next,
+				    bool sleep)
+{
+	if (static_branch_likely(&psi_disabled))
+		return;
+
+	/*
+	 * Clear the TSK_ONCPU state if the task was preempted. If
+	 * it's a voluntary sleep, dequeue will have taken care of it.
+	 */
+	if (!sleep)
+		psi_task_change(prev, TSK_ONCPU, 0);
+
+	psi_task_change(next, 0, TSK_ONCPU);
+}
+
 static inline void psi_task_tick(struct rq *rq)
 {
 	if (static_branch_likely(&psi_disabled))
@@ -138,6 +163,9 @@ static inline void psi_task_tick(struct rq *rq)
 static inline void psi_enqueue(struct task_struct *p, bool wakeup) {}
 static inline void psi_dequeue(struct task_struct *p, bool sleep) {}
 static inline void psi_ttwu_dequeue(struct task_struct *p) {}
+static inline void psi_sched_switch(struct task_struct *prev,
+				    struct task_struct *next,
+				    bool sleep) {}
 static inline void psi_task_tick(struct rq *rq) {}
 #endif /* CONFIG_PSI */
 
-- 
2.25.1

