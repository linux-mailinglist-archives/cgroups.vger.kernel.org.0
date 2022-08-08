Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7A58C737
	for <lists+cgroups@lfdr.de>; Mon,  8 Aug 2022 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbiHHLGS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Aug 2022 07:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242940AbiHHLFk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Aug 2022 07:05:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7A0634F
        for <cgroups@vger.kernel.org>; Mon,  8 Aug 2022 04:05:24 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r69so1725850pgr.2
        for <cgroups@vger.kernel.org>; Mon, 08 Aug 2022 04:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9POYeDaYW7dtn4XhApQfMlcQg9lt0ElNIM/9f/TV/5E=;
        b=OZ3MLAf56eTu/xwNZPNVcUkfq+qDU59H/XlcOYLDD9rxbjRorHzl5ExkQJf+sKjXyk
         Uywpm2rhNUjZgOJUHr+BDDZFXYGAChF2FVEZWDtfCNjWznbdnKI4RWsW3hwkDEWZ7CAX
         OFGH913FUIcQHQjYFODmCm++dzsTRQey+/Ienv6jdQDiBFT2HUwqBsZz3rSIQZTDe0Gs
         qQVjT0fvUHMyxNdL8UlvO+R69FWMt0IMWltX4I3frkyGghIe7xcsOPa95uexCJaKkL6u
         Aen/ACE4QTM0a6KhGD9MtEvhlMOTNs2uNEfDRWQZNjH5yT9sEFfT4h9vaJbaIVNJmr8T
         xelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9POYeDaYW7dtn4XhApQfMlcQg9lt0ElNIM/9f/TV/5E=;
        b=utr5naJYGT/FAOWub9bwx5s7J/f/HWGEK/FSqrVJCD+DEhmOacsbm6yQ2dNijmU28g
         eegGtn7RcTWWu+kXO6+sY0tzvx5sBio7LDVBJutfvJBQyCoiCnFapw83c6WwGp5nIdp8
         wZAMM7HIOsJUZC2sCg+Dg4C/DDQFWb78nnYFZN0S94aEWxQRGMqAYK6dPoqXOP3Nyg9v
         tAfS+9zf4vaoMWU6KX+gJQFh01Dvjtxx8NTSLK+WlmymetU01H04BNrUG0Uw1b7YLGVv
         7rx6QTkt2oMIB2n7sOUnnWbZ+8JKWPdQOT9/nSq/UKjU8RRWrE1VylmHYrlAZcSAwZkM
         xuiA==
X-Gm-Message-State: ACgBeo3TLfeYp4kbuG4fCCAN1EpR31908dJW82OCWV2kDIK4rOI1fzsY
        PFDX0lhpjLMOtPawwWOAICAqoA==
X-Google-Smtp-Source: AA6agR5CHqkMZvGrY3BOz9NP31v2sEpmcPeURzj70Kpu6UGaeJ4mw7ASU/0Ow1vSJLmsKKcfjSHvTQ==
X-Received: by 2002:a05:6a00:240f:b0:52e:f99d:1157 with SMTP id z15-20020a056a00240f00b0052ef99d1157mr8930124pfh.70.1659956724220;
        Mon, 08 Aug 2022 04:05:24 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id o12-20020aa7978c000000b0052dbad1ea2esm8393180pfp.6.2022.08.08.04.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:05:23 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     hannes@cmpxchg.org, tj@kernel.org, corbet@lwn.net,
        surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH v2 09/10] sched/psi: per-cgroup PSI stats disable/re-enable interface
Date:   Mon,  8 Aug 2022 19:03:40 +0800
Message-Id: <20220808110341.15799-10-zhouchengming@bytedance.com>
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

PSI accounts stalls for each cgroup separately and aggregates it
at each level of the hierarchy. This may cause non-negligible overhead
for some workloads when under deep level of the hierarchy.

commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
make PSI to skip per-cgroup stall accounting, only account system-wide
to avoid this each level overhead.

But for our use case, we also want leaf cgroup PSI stats accounted for
userspace adjustment on that cgroup, apart from only system-wide adjustment.

So this patch introduce a per-cgroup PSI stats disable/re-enable
interface "cgroup.psi", which is a read-write single value file that
allowed values are "0" and "1", the defaults is "1" so per-cgroup
PSI stats is enabled by default.

Implementation details:

It should be relatively straight-forward to disable and re-enable
state aggregation, time tracking, averaging on a per-cgroup level,
if we can live with losing history from while it was disabled.
I.e. the avgs will restart from 0, total= will have gaps.

But it's hard or complex to stop/restart groupc->tasks[] updates,
which is not implemented in this patch. So we always update
groupc->tasks[] and PSI_ONCPU bit in psi_group_change() even when
the cgroup PSI stats is disabled.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  7 ++++
 include/linux/psi.h                     |  2 ++
 include/linux/psi_types.h               |  2 ++
 kernel/cgroup/cgroup.c                  | 43 +++++++++++++++++++++++++
 kernel/sched/psi.c                      | 40 +++++++++++++++++++----
 5 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index dd84e34bc051..ade40506ab80 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -968,6 +968,13 @@ All cgroup core files are prefixed with "cgroup."
 	killing cgroups is a process directed operation, i.e. it affects
 	the whole thread-group.
 
+  cgroup.psi
+	A read-write single value file that allowed values are "0" and "1".
+	The default is "1".
+
+	Writing "0" to the file will disable the cgroup PSI stats accounting.
+	Writing "1" to the file will re-enable the cgroup PSI stats accounting.
+
   irq.pressure
 	A read-write nested-keyed file.
 
diff --git a/include/linux/psi.h b/include/linux/psi.h
index aa168a038242..1138ccffd76b 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -33,6 +33,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr, struct file *file,
 int psi_cgroup_alloc(struct cgroup *cgrp);
 void psi_cgroup_free(struct cgroup *cgrp);
 void cgroup_move_task(struct task_struct *p, struct css_set *to);
+void psi_cgroup_enable(struct psi_group *group, bool enable);
 #endif
 
 #else /* CONFIG_PSI */
@@ -54,6 +55,7 @@ static inline void cgroup_move_task(struct task_struct *p, struct css_set *to)
 {
 	rcu_assign_pointer(p->cgroups, to);
 }
+static inline void psi_cgroup_enable(struct psi_group *group, bool enable) {}
 #endif
 
 #endif /* CONFIG_PSI */
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index 4677655f6ca1..fced39e255aa 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -147,6 +147,8 @@ struct psi_trigger {
 };
 
 struct psi_group {
+	bool enabled;
+
 	/* Protects data used by the aggregator */
 	struct mutex avgs_lock;
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 91de8ff7fa50..6ba56983b5a5 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3709,6 +3709,43 @@ static ssize_t cgroup_irq_pressure_write(struct kernfs_open_file *of,
 }
 #endif
 
+static int cgroup_psi_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+
+	seq_printf(seq, "%d\n", psi->enabled);
+
+	return 0;
+}
+
+static ssize_t cgroup_psi_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	ssize_t ret;
+	int enable;
+	struct cgroup *cgrp;
+	struct psi_group *psi;
+
+	ret = kstrtoint(strstrip(buf), 0, &enable);
+	if (ret)
+		return ret;
+
+	if (enable < 0 || enable > 1)
+		return -ERANGE;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENOENT;
+
+	psi = cgroup_ino(cgrp) == 1 ? &psi_system : &cgrp->psi;
+	psi_cgroup_enable(psi, enable);
+
+	cgroup_kn_unlock(of->kn);
+
+	return nbytes;
+}
+
 static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 					  poll_table *pt)
 {
@@ -5115,6 +5152,12 @@ static struct cftype cgroup_base_files[] = {
 		.release = cgroup_pressure_release,
 	},
 #endif
+	{
+		.name = "cgroup.psi",
+		.flags = CFTYPE_PRESSURE,
+		.seq_show = cgroup_psi_show,
+		.write = cgroup_psi_write,
+	},
 #endif /* CONFIG_PSI */
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 58f8092c938f..9df1686ee02d 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -181,6 +181,7 @@ static void group_init(struct psi_group *group)
 {
 	int cpu;
 
+	group->enabled = true;
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
@@ -700,17 +701,16 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	groupc = per_cpu_ptr(group->pcpu, cpu);
 
 	/*
-	 * First we assess the aggregate resource states this CPU's
-	 * tasks have been in since the last change, and account any
-	 * SOME and FULL time these may have resulted in.
-	 *
-	 * Then we update the task counts according to the state
+	 * First we update the task counts according to the state
 	 * change requested through the @clear and @set bits.
+	 *
+	 * Then if the cgroup PSI stats accounting enabled, we
+	 * assess the aggregate resource states this CPU's tasks
+	 * have been in since the last change, and account any
+	 * SOME and FULL time these may have resulted in.
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, now);
-
 	/*
 	 * Start with TSK_ONCPU, which doesn't have a corresponding
 	 * task count - it's just a boolean flag directly encoded in
@@ -750,6 +750,14 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
+	if (!group->enabled) {
+		if (groupc->state_mask & (1 << PSI_NONIDLE))
+			record_times(groupc, now);
+		groupc->state_mask = state_mask;
+		write_seqcount_end(&groupc->seq);
+		return;
+	}
+
 	for (s = 0; s < NR_PSI_STATES; s++) {
 		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
 			state_mask |= (1 << s);
@@ -766,6 +774,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	if (unlikely((state_mask & PSI_ONCPU) && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
+	record_times(groupc, now);
 	groupc->state_mask = state_mask;
 
 	write_seqcount_end(&groupc->seq);
@@ -1088,6 +1097,23 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	task_rq_unlock(rq, task, &rf);
 }
+
+void psi_cgroup_enable(struct psi_group *group, bool enable)
+{
+	struct psi_group_cpu *groupc;
+	int cpu;
+	u64 now;
+
+	if (group->enabled == enable)
+		return;
+	group->enabled = enable;
+
+	for_each_possible_cpu(cpu) {
+		groupc = per_cpu_ptr(group->pcpu, cpu);
+		now = cpu_clock(cpu);
+		psi_group_change(group, cpu, 0, 0, now, true);
+	}
+}
 #endif /* CONFIG_CGROUPS */
 
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
-- 
2.36.1

