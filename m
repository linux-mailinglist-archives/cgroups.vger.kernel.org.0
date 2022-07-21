Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866157C32E
	for <lists+cgroups@lfdr.de>; Thu, 21 Jul 2022 06:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiGUEGF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 21 Jul 2022 00:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiGUEFb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 21 Jul 2022 00:05:31 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F341EAC5
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:30 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b9so623055pfp.10
        for <cgroups@vger.kernel.org>; Wed, 20 Jul 2022 21:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nv+1NkEw7UxRZmLxeUo4cV9wyQ4QwqO39uBVndf0jCc=;
        b=bjY6/TWcojIR7yKS1J162GCjohPw3F5UgNwyHYopIXrwMDDhzYOMpRFhjZVlve2jnH
         kwdjjXY0qDCbrgsz9WqbVpRuWZ/Nk7Cif76tkZSmkDPqpohm0J91WwUChBE04lhb8UU6
         bMa1rinjFXXBuHRFDZOwH0rNyd98UByXccx+txf36+XCjX5EV3NqhMqC3PlNEnfNZQy4
         sHCEu0mXQGJwGoB3sYRlhw6YgYO8xUYWKpfM52re2Nmhn49YQgpmwu1sxezhoEs33P10
         4N27susZxutNT6NYKpZM7N3Cvs6ft7Km3OvrjajXEjV79pIlZYZeeEzOl/rfVJwGi1Mp
         499g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nv+1NkEw7UxRZmLxeUo4cV9wyQ4QwqO39uBVndf0jCc=;
        b=ToiFd0usYOXbvr+kBlRIgTo6wBYrmAjUqNCjw9z4RhAXOt7/u/NPM+UvX/R21Dh6UL
         oxQaf+P1aSJrZCvK9mKi8Yen4ea1690Fu3F4GoEG4Lq9xTMPhDWbd3BwEabde8Le5/AM
         hlhK6BP5xeaVBMJHo0dGr53ycqe5fFvH1MZN1WWswsY5/BuGgDd4L3OTJ/uzbD5SKOMu
         hBXa2Dxgtwoz5/vpRG3J1OvsDL6imVSMMfMoKCwkVr+y93Jk82M3tD8MsNuFtBLDdgiP
         hm8tz/3cgV+/+DPcBffs92mCju2KRFgAtXS4/SukG+SRT83qX6mCA7ElM2R38qW6Dca/
         d0Jg==
X-Gm-Message-State: AJIora818fhyG7LQ+YNCgZrR82BexAxaagP3PIDLEE9HeA0JLNVHB1RQ
        LoN6xJ7xU+spNFSljvDIlsf8XA==
X-Google-Smtp-Source: AGRyM1sKSRpfwuk39oniqXz1NHdVDkTE3JxCDh4X7ic+6gMr/6ie6K4T8h8l/Eo1heVC6xfCAUhd5A==
X-Received: by 2002:a62:7b57:0:b0:52a:bb3b:21fb with SMTP id w84-20020a627b57000000b0052abb3b21fbmr42255417pfc.21.1658376329881;
        Wed, 20 Jul 2022 21:05:29 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm384368pln.110.2022.07.20.21.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 21:05:29 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, surenb@google.com, mingo@redhat.com,
        peterz@infradead.org, tj@kernel.org, corbet@lwn.net,
        akpm@linux-foundation.org, rdunlap@infradead.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, cgroups@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 7/9] sched/psi: cache parent psi_group to speed up groups iterate
Date:   Thu, 21 Jul 2022 12:04:37 +0800
Message-Id: <20220721040439.2651-8-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220721040439.2651-1-zhouchengming@bytedance.com>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

We use iterate_groups() to iterate each level psi_group to update
PSI stats, which is a very hot path.

In current code, iterate_groups() have to use multiple branches and
cgroup_parent() to get parent psi_group for each level, which is not
very efficient.

This patch cache parent psi_group, only need to get psi_group of task
itself first, then just use group->parent to iterate.

And this patch is preparation for the following patch, in which we can
configure PSI to only account for leaf cgroups and system-wide.

Performance test on Intel Xeon Platinum with 3 levels of cgroup:

1. before the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.032 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 8.077 [sec]

       8.077648 usecs/op
         123798 ops/sec

2. after the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.032 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 7.758 [sec]

       7.758354 usecs/op
         128893 ops/sec

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/psi_types.h |  2 ++
 kernel/sched/psi.c        | 48 ++++++++++++++++++++-------------------
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index c7fe7c089718..c124f7d186d0 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -147,6 +147,8 @@ struct psi_trigger {
 };
 
 struct psi_group {
+	struct psi_group *parent;
+
 	/* Protects data used by the aggregator */
 	struct mutex avgs_lock;
 
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index aa40bf888102..2228cbf3bdd3 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -758,30 +758,22 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		schedule_delayed_work(&group->avgs_work, PSI_FREQ);
 }
 
-static struct psi_group *iterate_groups(struct task_struct *task, void **iter)
+static inline struct psi_group *task_psi_group(struct task_struct *task)
 {
-	if (*iter == &psi_system)
-		return NULL;
-
 #ifdef CONFIG_CGROUPS
 	if (static_branch_likely(&psi_cgroups_enabled)) {
-		struct cgroup *cgroup = NULL;
-
-		if (!*iter)
-			cgroup = task->cgroups->dfl_cgrp;
-		else
-			cgroup = cgroup_parent(*iter);
+		struct cgroup *cgroup = task_dfl_cgroup(task);
 
-		if (cgroup && cgroup_parent(cgroup)) {
-			*iter = cgroup;
+		if (cgroup && cgroup_parent(cgroup))
 			return cgroup_psi(cgroup);
-		}
 	}
 #endif
-	*iter = &psi_system;
 	return &psi_system;
 }
 
+#define for_each_psi_group(group) \
+	for (; group; group = group->parent)
+
 static void psi_flags_change(struct task_struct *task, int clear, int set)
 {
 	if (((task->psi_flags & set) ||
@@ -799,12 +791,11 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 
 void psi_change_groups(struct task_struct *task, int clear, int set)
 {
+	struct psi_group *group = task_psi_group(task);
 	int cpu = task_cpu(task);
-	struct psi_group *group;
-	void *iter = NULL;
 	u64 now = cpu_clock(cpu);
 
-	while ((group = iterate_groups(task, &iter)))
+	for_each_psi_group(group)
 		psi_group_change(group, cpu, clear, set, now, true);
 }
 
@@ -822,7 +813,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 {
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
-	void *iter;
 	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
@@ -833,8 +823,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 * we reach the first common ancestor. Iterate @next's
 		 * ancestors only until we encounter @prev's ONCPU.
 		 */
-		iter = NULL;
-		while ((group = iterate_groups(next, &iter))) {
+		group = task_psi_group(next);
+		for_each_psi_group(group) {
 			if (per_cpu_ptr(group->pcpu, cpu)->tasks[NR_ONCPU]) {
 				common = group;
 				break;
@@ -874,9 +864,12 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		psi_flags_change(prev, clear, set);
 
-		iter = NULL;
-		while ((group = iterate_groups(prev, &iter)) && group != common)
+		group = task_psi_group(prev);
+		for_each_psi_group(group) {
+			if (group == common)
+				break;
 			psi_group_change(group, cpu, clear, set, now, wake_clock);
+		}
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
@@ -884,7 +877,8 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		 */
 		if (sleep || unlikely(prev->in_memstall != next->in_memstall)) {
 			clear &= ~TSK_ONCPU;
-			for (; group; group = iterate_groups(prev, &iter))
+
+			for_each_psi_group(group)
 				psi_group_change(group, cpu, clear, set, now, true);
 		}
 	}
@@ -953,6 +947,8 @@ void psi_memstall_leave(unsigned long *flags)
 #ifdef CONFIG_CGROUPS
 int psi_cgroup_alloc(struct cgroup *cgroup)
 {
+	struct cgroup *parent;
+
 	if (!static_branch_likely(&psi_cgroups_enabled))
 		return 0;
 
@@ -960,6 +956,12 @@ int psi_cgroup_alloc(struct cgroup *cgroup)
 	if (!cgroup->psi.pcpu)
 		return -ENOMEM;
 	group_init(&cgroup->psi);
+
+	parent = cgroup_parent(cgroup);
+	if (parent && cgroup_parent(parent))
+		cgroup->psi.parent = cgroup_psi(parent);
+	else
+		cgroup->psi.parent = &psi_system;
 	return 0;
 }
 
-- 
2.36.1

