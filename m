Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2477368F307
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 17:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBHQSQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 11:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbjBHQSM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 11:18:12 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A59FF0B;
        Wed,  8 Feb 2023 08:17:59 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id on9-20020a17090b1d0900b002300a96b358so2826326pjb.1;
        Wed, 08 Feb 2023 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rjNC6wFN/kvZ967lkXCFksTWIITOJM7ioTGLG1QbJic=;
        b=MdKSiLU3T+U7RUPheORPcLKDLU7zFgi4JZZPO1LrJGWnN8+HPuSKx7ePw8ypb9Qs0W
         mpXCYrc7p5qhXcIbCsRigyx7kMGe9X3C44lSu0GmHPxQCCu58gB72jbOtj0qc998vhon
         evvzSbzMewSQOWYxNXtV9KICNvWS0hKRJIN4AVQCp1YkBUiORLlUzSlk5ANksXsUGXZq
         A4KLYpvE4IlSmiydyMn1eaR1YquD1rjUxNDuXedEjEDrw1dsP/FVHsq+ioSwpUg2/+r0
         eI9qsm2QsVJN53M//OSKfKaSra1vXODyLgZbJK8i0mZu539ot4MpPPSeXvnPo9imEkf9
         +Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rjNC6wFN/kvZ967lkXCFksTWIITOJM7ioTGLG1QbJic=;
        b=3v0xa+ZI9E0slaG8BQE1hoi0K+0AjthqXbsqLixprwiwlL7qmejnegO+tCuGtX15dY
         37Jxpd8DU6p3IOwXb3JriHP4T/wGE3MGOVnLOJLlcY8nbxbSrpaVk82T1KqqM0bzYyxb
         MPEgEUl3ecnsrApACHq1MbO06xvjNwMiW6OoqeY7YKWqntqeh2cj+m02ncDo9WyFg3Nx
         1EJYnnuL8t7r+FBDjFhOPte7t7L6VP92SYd88wajq02UHOMz0y2SeW2XIPQkgOioUa6k
         iaPyfNsV9qJA33/UgqyYpOP3L8oCJtWFkF/NP+CpL/AvliWM/aJJShbpak6EBkSIWrqH
         l33Q==
X-Gm-Message-State: AO0yUKWHTlS7bPLNzSBLLH7jRAWDY/5lVXyaTCLC6hi/2k17OTnPbe2S
        uPNTosd0DxEWeWbA3RZD7Ps=
X-Google-Smtp-Source: AK7set/3AgqRNgsUdAY27Bp/tc9VBO8LsrcTbsoafKyFKft47fAqfTxgd9UC6s7+kxgrWqifxahvkg==
X-Received: by 2002:a05:6a21:9816:b0:bc:3290:5759 with SMTP id ue22-20020a056a21981600b000bc32905759mr5598182pzb.34.1675873078997;
        Wed, 08 Feb 2023 08:17:58 -0800 (PST)
Received: from KASONG-MB0.tencent.com ([115.171.40.195])
        by smtp.gmail.com with ESMTPSA id s21-20020a056a00195500b0059252afc069sm11445485pfk.64.2023.02.08.08.17.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 08:17:58 -0800 (PST)
From:   Kairui Song <ryncsn@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
        Kairui Song <ryncsn@gmail.com>
Subject: [PATCH 2/2] sched/psi: iterate through cgroups directly
Date:   Thu,  9 Feb 2023 00:16:54 +0800
Message-Id: <20230208161654.99556-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20230208161654.99556-1-ryncsn@gmail.com>
References: <20230208161654.99556-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Kairui Song <kasong@tencent.com>

psi_group->parent has the same hierarchy as the cgroup it's in.
So just iterate through cgroup instead.

By adjusting the iteration logic, save some space in psi_group
struct, and the performance is actually better. I see a measurable
performance gain using mmtests/perfpipe:

(AVG of 100 test, ops/sec, the higher the better)
KVM guest on a i7-9700:
        psi=0         root cgroup   5 levels of cgroup
Before: 59221         55352         47821
After:  60100         56036         50884

KVM guest on a Ryzen 9 5900HX:
        psi=0         root cgroup   5 levels of cgroup
Before: 144566        138919        128888
After:  145812        139580        133514

Signed-off-by: Kairui Song <kasong@tencent.com>
Signed-off-by: Kairui Song <ryncsn@gmail.com>
---
 include/linux/psi_types.h |  1 -
 kernel/sched/psi.c        | 47 ++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 1e0a0d7ace3a..4066b846ce4a 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -154,7 +154,6 @@ struct psi_trigger {
 };
 
 struct psi_group {
-	struct psi_group *parent;
 	bool enabled;
 
 	/* Protects data used by the aggregator */
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 8ac8b81bfee6..c74f8ce46f81 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -858,15 +858,34 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 }
 
-static inline struct psi_group *task_psi_group(struct task_struct *task)
+static inline struct psi_group *psi_iter_first(struct task_struct *task, void **iter)
 {
 #ifdef CONFIG_CGROUPS
-	if (static_branch_likely(&psi_cgroups_enabled))
-		return cgroup_psi(task_dfl_cgroup(task));
+	if (static_branch_likely(&psi_cgroups_enabled)) {
+		struct cgroup *cgroup = task_dfl_cgroup(task);
+
+		*iter = cgroup_parent(cgroup);
+		return cgroup_psi(cgroup);
+	}
 #endif
 	return &psi_system;
 }
 
+static inline struct psi_group *psi_iter_next(void **iter)
+{
+#ifdef CONFIG_CGROUPS
+	if (static_branch_likely(&psi_cgroups_enabled)) {
+		struct cgroup *cgroup = *iter;
+
+		if (cgroup) {
+			*iter = cgroup_parent(cgroup);
+			return cgroup_psi(cgroup);
+		}
+	}
+#endif
+	return NULL;
+}
+
 static void psi_flags_change(struct task_struct *task, int clear, int set)
 {
 	if (((task->psi_flags & set) ||
@@ -886,6 +905,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
+	void *iter;
 	u64 now;
 
 	if (!task->pid)
@@ -895,16 +915,17 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 
 	now = cpu_clock(cpu);
 
-	group = task_psi_group(task);
+	group = psi_iter_first(task, &iter);
 	do {
 		psi_group_change(group, cpu, clear, set, now, true);
-	} while ((group = group->parent));
+	} while ((group = psi_iter_next(&iter)));
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		     bool sleep)
 {
 	struct psi_group *group, *common = NULL;
+	void *iter;
 	int cpu = task_cpu(prev);
 	u64 now = cpu_clock(cpu);
 
@@ -915,7 +936,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * ancestors with @prev, those will already have @prev's
 		 * TSK_ONCPU bit set, and we can stop the iteration there.
 		 */
-		group = task_psi_group(next);
+		group = psi_iter_first(prev, &iter);
 		do {
 			if (per_cpu_ptr(group->pcpu, cpu)->state_mask &
 			    PSI_ONCPU) {
@@ -924,7 +945,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 			}
 
 			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
-		} while ((group = group->parent));
+		} while ((group = psi_iter_next(&iter)));
 	}
 
 	if (prev->pid) {
@@ -957,12 +978,12 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		psi_flags_change(prev, clear, set);
 
-		group = task_psi_group(prev);
+		group = psi_iter_first(prev, &iter);
 		do {
 			if (group == common)
 				break;
 			psi_group_change(group, cpu, clear, set, now, wake_clock);
-		} while ((group = group->parent));
+		} while ((group = psi_iter_next(&iter)));
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If there are
@@ -972,7 +993,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
 			clear &= ~TSK_ONCPU;
-			for (; group; group = group->parent)
+			for (; group; group = psi_iter_next(&iter))
 				psi_group_change(group, cpu, clear, set, now, wake_clock);
 		}
 	}
@@ -983,6 +1004,7 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 {
 	int cpu = task_cpu(task);
 	struct psi_group *group;
+	void *iter;
 	struct psi_group_cpu *groupc;
 	u64 now;
 
@@ -991,7 +1013,7 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 
 	now = cpu_clock(cpu);
 
-	group = task_psi_group(task);
+	group = psi_iter_first(task, &iter);
 	do {
 		if (!group->enabled)
 			continue;
@@ -1007,7 +1029,7 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 
 		if (group->poll_states & (1 << PSI_IRQ_FULL))
 			psi_schedule_poll_work(group, 1, false);
-	} while ((group = group->parent));
+	} while ((group = psi_iter_next(&iter)));
 }
 #endif
 
@@ -1089,7 +1111,6 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 		return -ENOMEM;
 	}
 	group_init(cgroup->psi);
-	cgroup->psi->parent = cgroup_psi(cgroup_parent(cgroup));
 	return 0;
 }
 
-- 
2.39.1

