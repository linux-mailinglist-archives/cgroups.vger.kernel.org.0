Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECFC71275A8
	for <lists+cgroups@lfdr.de>; Fri, 20 Dec 2019 07:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbfLTG0W (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 20 Dec 2019 01:26:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37554 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfLTG0V (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 20 Dec 2019 01:26:21 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so4638107pfn.4;
        Thu, 19 Dec 2019 22:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sLQwYn83trd9XP0m0VSg2ROtVjHj/MiokIdaMbs0cVg=;
        b=P/w4T7YlmdltPydFyxnyFx8IP3iRFTt6ngWTIipJ8X9+t5RdFUxp0GmzwR1y8cFoil
         0Un/ojBgwFRQxx3bN0PrWfAWJnbYKK2RbXFj0gs2mIC5ZTQmbP8wDEnZYR4R3UF3Bven
         LDChDt+bkb1McC8Dypn3T53eBELy4Oc523i8oTZpCdB2Z/JniO0d7xSON9wNI7wLMtp8
         AVmUWj/t0Xnt5gKGC4ECIybmU5CaUf9itm+km1cb8eFHxzuDbf99lhtW7PjtYqSbFxco
         DUTK3lDOAjFLXYfhLdmE0mvzLW9ssveAi0aExIyEyF7Az6gntHBK8UUXAAASFni9YFC5
         XIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sLQwYn83trd9XP0m0VSg2ROtVjHj/MiokIdaMbs0cVg=;
        b=eHOdIEN9djBwaqWhmmYk3wnYCYkSW/dG7BLEhgFA1saWbKzm/+/Cq5AJmEgtYI62rw
         BAKjUqIqRsuTO8z0ziHlQWsjFqDRp2KSR82qcfx0MQ/+XXI+ECQSkbKiNN7dAM8SN2C8
         rjN14yqnUWrocvvlzODbq/MMyZw7eo7KSjnixnJd5hmTMLpamenyv40q4K2Rj4zPb0eQ
         jKeW+fUx1fUXJoXKVFSqmoTWLnSeT1iqfo6lvee8lQestqdXnbKzDIiVb4vZRic+ikiU
         P0CvknGBrcIczygZUQFuJ7Ok1c07YzUmAl4BIITzcKOZXZb1jLbbmRaD3/43ImNwZ9eJ
         7GuA==
X-Gm-Message-State: APjAAAVTm+yXpXZyhbPeR2HA+hP0Da8cjPNQBvRODxoZCF6/uv/xy2v2
        rrz5AJLlupcN+Ym9v96x1PjQ8B8wyVI=
X-Google-Smtp-Source: APXvYqy0UUWibb6exuBS3rItPtIaJrg0uC4VXYXtj0dKoxluNWpPOzAefrFh8N6Qx556bVbVRyAtbw==
X-Received: by 2002:aa7:8007:: with SMTP id j7mr14295020pfi.73.1576823180794;
        Thu, 19 Dec 2019 22:26:20 -0800 (PST)
Received: from TENCENT64 ([150.109.127.35])
        by smtp.gmail.com with ESMTPSA id 203sm11218039pfy.185.2019.12.19.22.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Dec 2019 22:26:20 -0800 (PST)
From:   zgpeng.linux@gmail.com
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        vdavydov.dev@gmail.com, shakeelb@google.com
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, zgpeng <zgpeng@tencent.com>
Subject: [PATCH] oom: choose a more suitable process to kill while all processes are not killable
Date:   Fri, 20 Dec 2019 14:26:12 +0800
Message-Id: <1576823172-25943-1-git-send-email-zgpeng.linux@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: zgpeng <zgpeng@tencent.com>

It has been found in multiple business scenarios that when a oom occurs
in a cgroup, the process that consumes the most memory in the cgroup is 
not killed first. Analysis of the reasons found that each process in the
cgroup oom_score_adj is set to -998, oom_badness in the calculation of 
points, if points is negative, uniformly set it to 1. For these processes 
that should not be killed, the kernel does not distinguish which process 
consumes the most memory. As a result, there is a phenomenon that a 
process with low memory consumption may be killed first. In addition, 
when the memory is large, even if oom_score_adj is not set so small, 
such as -1, there will be similar problems.

Based on the scenario mentioned above, the existing oom killer can be 
optimized. In this patch, oom_badness is optimized so that when points 
are negative, it can also distinguish which process consumes the most 
memory. Therefore, when oom occurs, the process with the largest memory 
consumption can be killed first.

Signed-off-by: zgpeng <zgpeng@tencent.com>
---
 drivers/tty/sysrq.c |  1 +
 fs/proc/base.c      |  6 ++++--
 include/linux/oom.h |  4 ++--
 mm/memcontrol.c     |  1 +
 mm/oom_kill.c       | 21 +++++++++------------
 mm/page_alloc.c     |  1 +
 6 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index 573b205..1fe79d9 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -367,6 +367,7 @@ static void moom_callback(struct work_struct *ignored)
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
 		.order = -1,
+		.chosen_points = LONG_MIN,
 	};
 
 	mutex_lock(&oom_lock);
diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea950..2c7c4e0 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -548,9 +548,11 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
 			  struct pid *pid, struct task_struct *task)
 {
 	unsigned long totalpages = totalram_pages() + total_swap_pages;
-	unsigned long points = 0;
+	long points = 0;
 
-	points = oom_badness(task, totalpages) * 1000 / totalpages;
+	points = oom_badness(task, totalpages);
+	points = points > 0 ? points : 1;
+	points = points * 1000 / totalpages;
 	seq_printf(m, "%lu\n", points);
 
 	return 0;
diff --git a/include/linux/oom.h b/include/linux/oom.h
index c696c26..2d2b898 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -48,7 +48,7 @@ struct oom_control {
 	/* Used by oom implementation, do not set */
 	unsigned long totalpages;
 	struct task_struct *chosen;
-	unsigned long chosen_points;
+	long chosen_points;
 
 	/* Used to print the constraint info. */
 	enum oom_constraint constraint;
@@ -107,7 +107,7 @@ static inline vm_fault_t check_stable_address_space(struct mm_struct *mm)
 
 bool __oom_reap_task_mm(struct mm_struct *mm);
 
-extern unsigned long oom_badness(struct task_struct *p,
+extern long oom_badness(struct task_struct *p,
 		unsigned long totalpages);
 
 extern bool out_of_memory(struct oom_control *oc);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c5b5f74..73e2381 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1563,6 +1563,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 		.memcg = memcg,
 		.gfp_mask = gfp_mask,
 		.order = order,
+		.chosen_points = LONG_MIN,
 	};
 	bool ret;
 
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 71e3ace..160f364 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -195,17 +195,17 @@ static bool is_dump_unreclaim_slabs(void)
  * predictable as possible.  The goal is to return the highest value for the
  * task consuming the most memory to avoid subsequent oom failures.
  */
-unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
+long oom_badness(struct task_struct *p, unsigned long totalpages)
 {
 	long points;
 	long adj;
 
 	if (oom_unkillable_task(p))
-		return 0;
+		return LONG_MIN;
 
 	p = find_lock_task_mm(p);
 	if (!p)
-		return 0;
+		return LONG_MIN;
 
 	/*
 	 * Do not even consider tasks which are explicitly marked oom
@@ -217,7 +217,7 @@ unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
 			test_bit(MMF_OOM_SKIP, &p->mm->flags) ||
 			in_vfork(p)) {
 		task_unlock(p);
-		return 0;
+		return LONG_MIN;
 	}
 
 	/*
@@ -232,11 +232,7 @@ unsigned long oom_badness(struct task_struct *p, unsigned long totalpages)
 	adj *= totalpages / 1000;
 	points += adj;
 
-	/*
-	 * Never return 0 for an eligible task regardless of the root bonus and
-	 * oom_score_adj (oom_score_adj can't be OOM_SCORE_ADJ_MIN here).
-	 */
-	return points > 0 ? points : 1;
+	return points;
 }
 
 static const char * const oom_constraint_text[] = {
@@ -309,7 +305,7 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 static int oom_evaluate_task(struct task_struct *task, void *arg)
 {
 	struct oom_control *oc = arg;
-	unsigned long points;
+	long points;
 
 	if (oom_unkillable_task(task))
 		goto next;
@@ -335,12 +331,12 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	 * killed first if it triggers an oom, then select it.
 	 */
 	if (oom_task_origin(task)) {
-		points = ULONG_MAX;
+		points = LONG_MAX;
 		goto select;
 	}
 
 	points = oom_badness(task, oc->totalpages);
-	if (!points || points < oc->chosen_points)
+	if (points == LONG_MIN || points < oc->chosen_points)
 		goto next;
 
 select:
@@ -1126,6 +1122,7 @@ void pagefault_out_of_memory(void)
 		.memcg = NULL,
 		.gfp_mask = 0,
 		.order = 0,
+		.chosen_points = LONG_MIN,
 	};
 
 	if (mem_cgroup_oom_synchronize(true))
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4785a8a..63ccb2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3797,6 +3797,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 		.memcg = NULL,
 		.gfp_mask = gfp_mask,
 		.order = order,
+		.chosen_points = LONG_MIN,
 	};
 	struct page *page;
 
-- 
1.8.3.1

