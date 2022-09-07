Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC315AFFD1
	for <lists+cgroups@lfdr.de>; Wed,  7 Sep 2022 11:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIGJDz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 7 Sep 2022 05:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiIGJDy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 7 Sep 2022 05:03:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA14AF480
        for <cgroups@vger.kernel.org>; Wed,  7 Sep 2022 02:03:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e68so921771pfe.1
        for <cgroups@vger.kernel.org>; Wed, 07 Sep 2022 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Z934rlNstfofpuyWEurIb+XEjfuq990ZSdiH3EvHyDc=;
        b=d8iv/xnJfP5vvzSSAHeGHVaPpyoQSjFvtA9P6dbF3rOgTmFoI5A5RuUR0xOhO6zKD4
         eeYrI4xm1/Sr8aYEfDhDvQLBHtaR6PB9wKh4gUjfR0/o1+KjCtjrwU7gl+7JHzw4jSdY
         TFpX22xWQPT7rLibuT/DYhHuQCkOxK79FMOlxwqY0IIukkRFyVUL2E/pNpHEXLbN81oj
         ySNBTEwbvIlNHNegEiBeoC1FH2uqGY4pixSJl+zFONb/qlmwMaKA+2u7DadUWzzAepo8
         rLZ19vO70JGo1mdTaMTz5UcHWPb9UgXsvIL+QqoPleXUOcBKGACqLDTI+S8GjhPjFxjl
         1tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Z934rlNstfofpuyWEurIb+XEjfuq990ZSdiH3EvHyDc=;
        b=F2BTUeyrW1INqy1ahX+Nk6x7dTM1eQlIoG9vkpvlPl7wxIGLscj9+aRT7WJ5bBVvCG
         24QNSt5KpQI8BzXbFHBLVovGynmvrGWsR22RTlUO4GlRZyEuSwQj6XFc/fnAPEphP7fn
         YCs9ymYAubl7fuFp978nyrp2JM9Rkix3K02LBIS2RSPBDPxzGq+eCbDqjBO8e69bmFk8
         0Ci3aUvCRCIL6dQOiXCF1capQoe2q0W2pRs78LqZK9BrT3Lah+SL/oyPU/rJkt8VNXJC
         zBR4dqbInF2R87O917bo07N83fqD4wF4l4281tyT5Ims/D3iOzYBNbb7hYAAHpa5yYBY
         SD7g==
X-Gm-Message-State: ACgBeo2tPyj3Le7rlmusVS+4uhPWLTwnWYXvohMoaV+ZqFBllrm2YV1H
        a6hPmnyCDaoTYFUyYAeOrduauA==
X-Google-Smtp-Source: AA6agR7iN9BJBRAkt9ypzmep6EHv0C0pDSFCGX8r0vobkuIuHom8V/eFvhAf0l0hepgON++SOZHBSw==
X-Received: by 2002:a63:8549:0:b0:434:3c39:4fe0 with SMTP id u70-20020a638549000000b004343c394fe0mr2498448pgd.221.1662541432330;
        Wed, 07 Sep 2022 02:03:52 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id n8-20020a170903110800b0016d6963cb12sm11679514plh.304.2022.09.07.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 02:03:51 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     peterz@infradead.org
Cc:     hannes@cmpxchg.org, tj@kernel.org, surenb@google.com,
        mkoutny@suse.com, mingo@redhat.com, gregkh@linuxfoundation.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] sched/psi: Per-cgroup PSI accounting disable/re-enable interface
Date:   Wed,  7 Sep 2022 17:03:32 +0800
Message-Id: <20220907090332.2078-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220825164111.29534-11-zhouchengming@bytedance.com>
References: <20220825164111.29534-11-zhouchengming@bytedance.com>
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

So this patch introduce a per-cgroup PSI accounting disable/re-enable
interface "cgroup.pressure", which is a read-write single value file that
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
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
Updated version to fix build error when !CONFIG_PSI.
---
 Documentation/admin-guide/cgroup-v2.rst | 17 ++++++
 include/linux/cgroup-defs.h             |  3 ++
 include/linux/psi.h                     |  2 +
 include/linux/psi_types.h               |  3 ++
 kernel/cgroup/cgroup.c                  | 70 ++++++++++++++++++++++---
 kernel/sched/psi.c                      | 70 ++++++++++++++++++++++---
 6 files changed, 152 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 971c418bc778..4cad4e2b31ec 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -976,6 +976,23 @@ All cgroup core files are prefixed with "cgroup."
 	killing cgroups is a process directed operation, i.e. it affects
 	the whole thread-group.
 
+  cgroup.pressure
+	A read-write single value file that allowed values are "0" and "1".
+	The default is "1".
+
+	Writing "0" to the file will disable the cgroup PSI accounting.
+	Writing "1" to the file will re-enable the cgroup PSI accounting.
+
+	This control attribute is not hierarchical, so disable or enable PSI
+	accounting in a cgroup does not affect PSI accounting in descendants
+	and doesn't need pass enablement via ancestors from root.
+
+	The reason this control attribute exists is that PSI accounts stalls for
+	each cgroup separately and aggregates it at each level of the hierarchy.
+	This may cause non-negligible overhead for some workloads when under
+	deep level of the hierarchy, in which case this control attribute can
+	be used to disable PSI accounting in the non-leaf cgroups.
+
   irq.pressure
 	A read-write nested-keyed file.
 
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 4bcf56b3491c..7df76b318245 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -428,6 +428,9 @@ struct cgroup {
 	struct cgroup_file procs_file;	/* handle for "cgroup.procs" */
 	struct cgroup_file events_file;	/* handle for "cgroup.events" */
 
+	/* handles for "{cpu,memory,io,irq}.pressure" */
+	struct cgroup_file psi_files[NR_PSI_RESOURCES];
+
 	/*
 	 * The bitmask of subsystems enabled on the child cgroups.
 	 * ->subtree_control is the one configured through
diff --git a/include/linux/psi.h b/include/linux/psi.h
index 362a74ca1d3b..b029a847def1 100644
--- a/include/linux/psi.h
+++ b/include/linux/psi.h
@@ -39,6 +39,7 @@ static inline struct psi_group *cgroup_psi(struct cgroup *cgrp)
 int psi_cgroup_alloc(struct cgroup *cgrp);
 void psi_cgroup_free(struct cgroup *cgrp);
 void cgroup_move_task(struct task_struct *p, struct css_set *to);
+void psi_cgroup_restart(struct psi_group *group);
 #endif
 
 #else /* CONFIG_PSI */
@@ -60,6 +61,7 @@ static inline void cgroup_move_task(struct task_struct *p, struct css_set *to)
 {
 	rcu_assign_pointer(p->cgroups, to);
 }
+static inline void psi_cgroup_restart(struct psi_group *group) {}
 #endif
 
 #endif /* CONFIG_PSI */
diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index a0b746258c68..6e4372735068 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -152,6 +152,7 @@ struct psi_trigger {
 
 struct psi_group {
 	struct psi_group *parent;
+	bool enabled;
 
 	/* Protects data used by the aggregator */
 	struct mutex avgs_lock;
@@ -194,6 +195,8 @@ struct psi_group {
 
 #else /* CONFIG_PSI */
 
+#define NR_PSI_RESOURCES	0
+
 struct psi_group { };
 
 #endif /* CONFIG_PSI */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 4f72a71820db..0bca8f29361d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3708,8 +3708,8 @@ static int cgroup_cpu_pressure_show(struct seq_file *seq, void *v)
 	return psi_show(seq, psi, PSI_CPU);
 }
 
-static ssize_t cgroup_pressure_write(struct kernfs_open_file *of, char *buf,
-					  size_t nbytes, enum psi_res res)
+static ssize_t pressure_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, enum psi_res res)
 {
 	struct cgroup_file_ctx *ctx = of->priv;
 	struct psi_trigger *new;
@@ -3746,21 +3746,21 @@ static ssize_t cgroup_io_pressure_write(struct kernfs_open_file *of,
 					  char *buf, size_t nbytes,
 					  loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_IO);
+	return pressure_write(of, buf, nbytes, PSI_IO);
 }
 
 static ssize_t cgroup_memory_pressure_write(struct kernfs_open_file *of,
 					  char *buf, size_t nbytes,
 					  loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_MEM);
+	return pressure_write(of, buf, nbytes, PSI_MEM);
 }
 
 static ssize_t cgroup_cpu_pressure_write(struct kernfs_open_file *of,
 					  char *buf, size_t nbytes,
 					  loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_CPU);
+	return pressure_write(of, buf, nbytes, PSI_CPU);
 }
 
 #ifdef CONFIG_IRQ_TIME_ACCOUNTING
@@ -3776,10 +3776,58 @@ static ssize_t cgroup_irq_pressure_write(struct kernfs_open_file *of,
 					 char *buf, size_t nbytes,
 					 loff_t off)
 {
-	return cgroup_pressure_write(of, buf, nbytes, PSI_IRQ);
+	return pressure_write(of, buf, nbytes, PSI_IRQ);
 }
 #endif
 
+static int cgroup_pressure_show(struct seq_file *seq, void *v)
+{
+	struct cgroup *cgrp = seq_css(seq)->cgroup;
+	struct psi_group *psi = cgroup_psi(cgrp);
+
+	seq_printf(seq, "%d\n", psi->enabled);
+
+	return 0;
+}
+
+static ssize_t cgroup_pressure_write(struct kernfs_open_file *of,
+				     char *buf, size_t nbytes,
+				     loff_t off)
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
+	psi = cgroup_psi(cgrp);
+	if (psi->enabled != enable) {
+		int i;
+
+		/* show or hide {cpu,memory,io,irq}.pressure files */
+		for (i = 0; i < NR_PSI_RESOURCES; i++)
+			cgroup_file_show(&cgrp->psi_files[i], enable);
+
+		psi->enabled = enable;
+		if (enable)
+			psi_cgroup_restart(psi);
+	}
+
+	cgroup_kn_unlock(of->kn);
+
+	return nbytes;
+}
+
 static __poll_t cgroup_pressure_poll(struct kernfs_open_file *of,
 					  poll_table *pt)
 {
@@ -5155,6 +5203,7 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "io.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_IO]),
 		.seq_show = cgroup_io_pressure_show,
 		.write = cgroup_io_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5163,6 +5212,7 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "memory.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_MEM]),
 		.seq_show = cgroup_memory_pressure_show,
 		.write = cgroup_memory_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5171,6 +5221,7 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "cpu.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_CPU]),
 		.seq_show = cgroup_cpu_pressure_show,
 		.write = cgroup_cpu_pressure_write,
 		.poll = cgroup_pressure_poll,
@@ -5180,12 +5231,19 @@ static struct cftype cgroup_base_files[] = {
 	{
 		.name = "irq.pressure",
 		.flags = CFTYPE_PRESSURE,
+		.file_offset = offsetof(struct cgroup, psi_files[PSI_IRQ]),
 		.seq_show = cgroup_irq_pressure_show,
 		.write = cgroup_irq_pressure_write,
 		.poll = cgroup_pressure_poll,
 		.release = cgroup_pressure_release,
 	},
 #endif
+	{
+		.name = "cgroup.pressure",
+		.flags = CFTYPE_PRESSURE,
+		.seq_show = cgroup_pressure_show,
+		.write = cgroup_pressure_write,
+	},
 #endif /* CONFIG_PSI */
 	{ }	/* terminate */
 };
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 9a8aee80a087..9711827e31e5 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -181,6 +181,7 @@ static void group_init(struct psi_group *group)
 {
 	int cpu;
 
+	group->enabled = true;
 	for_each_possible_cpu(cpu)
 		seqcount_init(&per_cpu_ptr(group->pcpu, cpu)->seq);
 	group->avg_last_update = sched_clock();
@@ -696,17 +697,16 @@ static void psi_group_change(struct psi_group *group, int cpu,
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
@@ -745,6 +745,23 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (set & (1 << t))
 			groupc->tasks[t]++;
 
+	if (!group->enabled) {
+		/*
+		 * On the first group change after disabling PSI, conclude
+		 * the current state and flush its time. This is unlikely
+		 * to matter to the user, but aggregation (get_recent_times)
+		 * may have already incorporated the live state into times_prev;
+		 * avoid a delta sample underflow when PSI is later re-enabled.
+		 */
+		if (unlikely(groupc->state_mask & (1 << PSI_NONIDLE)))
+			record_times(groupc, now);
+
+		groupc->state_mask = state_mask;
+
+		write_seqcount_end(&groupc->seq);
+		return;
+	}
+
 	for (s = 0; s < NR_PSI_STATES; s++) {
 		if (test_state(groupc->tasks, s, state_mask & PSI_ONCPU))
 			state_mask |= (1 << s);
@@ -761,6 +778,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	if (unlikely((state_mask & PSI_ONCPU) && cpu_curr(cpu)->in_memstall))
 		state_mask |= (1 << PSI_MEM_FULL);
 
+	record_times(groupc, now);
+
 	groupc->state_mask = state_mask;
 
 	write_seqcount_end(&groupc->seq);
@@ -907,6 +926,9 @@ void psi_account_irqtime(struct task_struct *task, u32 delta)
 
 	group = task_psi_group(task);
 	do {
+		if (!group->enabled)
+			continue;
+
 		groupc = per_cpu_ptr(group->pcpu, cpu);
 
 		write_seqcount_begin(&groupc->seq);
@@ -1080,6 +1102,40 @@ void cgroup_move_task(struct task_struct *task, struct css_set *to)
 
 	task_rq_unlock(rq, task, &rf);
 }
+
+void psi_cgroup_restart(struct psi_group *group)
+{
+	int cpu;
+
+	/*
+	 * After we disable psi_group->enabled, we don't actually
+	 * stop percpu tasks accounting in each psi_group_cpu,
+	 * instead only stop test_state() loop, record_times()
+	 * and averaging worker, see psi_group_change() for details.
+	 *
+	 * When disable cgroup PSI, this function has nothing to sync
+	 * since cgroup pressure files are hidden and percpu psi_group_cpu
+	 * would see !psi_group->enabled and only do task accounting.
+	 *
+	 * When re-enable cgroup PSI, this function use psi_group_change()
+	 * to get correct state mask from test_state() loop on tasks[],
+	 * and restart groupc->state_start from now, use .clear = .set = 0
+	 * here since no task status really changed.
+	 */
+	if (!group->enabled)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct rq *rq = cpu_rq(cpu);
+		struct rq_flags rf;
+		u64 now;
+
+		rq_lock_irq(rq, &rf);
+		now = cpu_clock(cpu);
+		psi_group_change(group, cpu, 0, 0, now, true);
+		rq_unlock_irq(rq, &rf);
+	}
+}
 #endif /* CONFIG_CGROUPS */
 
 int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
-- 
2.37.2

