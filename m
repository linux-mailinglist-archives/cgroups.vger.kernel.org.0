Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6085AC237
	for <lists+cgroups@lfdr.de>; Sun,  4 Sep 2022 06:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiIDEDA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 4 Sep 2022 00:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiIDEC7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 4 Sep 2022 00:02:59 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67D6357F0
        for <cgroups@vger.kernel.org>; Sat,  3 Sep 2022 21:02:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ev6-20020a17090aeac600b0020031370f86so1116755pjb.1
        for <cgroups@vger.kernel.org>; Sat, 03 Sep 2022 21:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=S+YO3HVtXRaQAdmhc0xL9yDdiDnXmc6HtfEihdsrkxU=;
        b=G/xyMTjqN25DfHQfHmSq9gbGrVtnQYsU9pE34TFjGdzut/IEZqtJpTBtSnF/rWsIty
         ivgbtvSqb88BDwy5UwbF3IdPIAzVbYxfGH2QVkw/PXnVL1QrHbcGrA0Kbf33hgjPZl5a
         s5+ClxGOTPJqkc/xcWJY8aCHNVbafxuc6x+7+v7hlaqBtkyIzFKxI8e9CPMdToMjZYM+
         8N17f33TQjfpMSild0clJCnzMu8TWSZ0DUHilBVGnfGnyGMGuMmzMSs6959kI8Jt0/35
         0wmoj1f/ahDVOLwCPapajNcc86QMiUQyY8vGG7IrqqMTQFLPg+OkRi7j7V6FxeeVhp5P
         4tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=S+YO3HVtXRaQAdmhc0xL9yDdiDnXmc6HtfEihdsrkxU=;
        b=iEFL7LxVNnW9qsb6PAM455SCyikZlLQq+GxD3vgsvWw1HrMOdWxfUlcKduSk81+sP4
         BvZn2gAM509rKWNx52ex3MysjieJJrGktk8ZfcAPqbdz7iBYP3JUoC/Tcw8ZgYkZNG7K
         pN8xJrbXQg6TLZTPlPIrnoukN/Ebbpd0Avh83iTUO34wUmXFjput3qikDWiLVtBUkmVm
         Nt5NrTAqoTlQvoX1/tlRU+kpK65MyopEWjfWMBMtfmUoNw2GPSKA0r9LKUBoO57Cs5s2
         aHjih32+LSAzF+/3vMjSuvWoc2UzzV+Jmg7GZFgzlk/as8FAc957Ay94WRpr50rK51ts
         j7xA==
X-Gm-Message-State: ACgBeo1kSlj0EqlgptdNbXy+voDmjtpn6hEytjMGLxKeBYyvfmbQ9XT+
        NwmvsscfAiMj0JF6BKVKD9Tucg==
X-Google-Smtp-Source: AA6agR4u+y7CvWBgghC/S5UaKpqRGOBtA2FIlUvoCt6KXMDXbzaR61tE2sSyL3dVvGCg0R1JDh0oEw==
X-Received: by 2002:a17:90b:1804:b0:1fb:141:a09d with SMTP id lw4-20020a17090b180400b001fb0141a09dmr12658281pjb.170.1662264176961;
        Sat, 03 Sep 2022 21:02:56 -0700 (PDT)
Received: from R911R1VA-1UT.inc.bytedance.com ([220.243.131.6])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b0017555cef23asm4192668plh.232.2022.09.03.21.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 21:02:56 -0700 (PDT)
From:   hezhongkun <hezhongkun.hzk@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] cgroup/cpuset: Add a new isolated mems.policy type.
Date:   Sun,  4 Sep 2022 12:02:41 +0800
Message-Id: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.30.2
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

From: Zhongkun He <hezhongkun.hzk@bytedance.com>

Mempolicy is difficult to use because it is set in-process
via a system call. We want to make it easier to use mempolicy
in cpuset, and  we can control low-priority cgroups to
allocate memory in specified nodes. So this patch want to
adds the mempolicy interface in cpuset.

The mempolicy priority of cpuset is lower than the task.
The order of getting the policy is:
	1) vma mempolicy
	2) task->mempolicy
	3) cpuset->mempolicy
	4) default policy.

cpuset's policy is owned by itself, but descendants will
get the default mempolicy from parent.

How to use the mempolicy interface:
	echo prefer:2 > /sys/fs/cgroup/zz/cpuset.mems.policy
	echo bind:1-3 > /sys/fs/cgroup/zz/cpuset.mems.policy
        echo interleave:0,1,2,3 >/sys/fs/cgroup/zz/cpuset.mems.policy
Show the policy:
	cat /sys/fs/cgroup/zz/cpuset.mems.policy
		prefer:2
	cat /sys/fs/cgroup/zz/cpuset.mems.policy
		bind:1-3
	cat /sys/fs/cgroup/zz/cpuset.mems.policy
		interleave:0-3
Clear the policy:
	echo default > /sys/fs/cgroup/zz/cpuset.mems.policy

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 include/linux/mempolicy.h |   9 ++
 include/linux/sched.h     |   2 +
 kernel/cgroup/cpuset.c    | 182 +++++++++++++++++++++++++++++++++++++-
 kernel/fork.c             |   1 +
 mm/mempolicy.c            |  25 ++++--
 5 files changed, 209 insertions(+), 10 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 668389b4b53d..41c4b28fb71f 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -142,6 +142,7 @@ extern void numa_default_policy(void);
 extern void numa_policy_init(void);
 extern void mpol_rebind_task(struct task_struct *tsk, const nodemask_t *new);
 extern void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new);
+extern void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask);
 
 extern int huge_node(struct vm_area_struct *vma,
 				unsigned long addr, gfp_t gfp_flags,
@@ -211,6 +212,11 @@ static inline void mpol_get(struct mempolicy *pol)
 {
 }
 
+static inline struct mempolicy *mpol_dup(struct mempolicy *pol)
+{
+	return NULL;
+}
+
 struct shared_policy {};
 
 static inline void mpol_shared_policy_init(struct shared_policy *sp,
@@ -252,6 +258,9 @@ static inline void mpol_rebind_task(struct task_struct *tsk,
 static inline void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 }
+static inline void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
+{
+}
 
 static inline int huge_node(struct vm_area_struct *vma,
 				unsigned long addr, gfp_t gfp_flags,
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a5c711..f935e1707e7c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1236,6 +1236,8 @@ struct task_struct {
 	unsigned long			preempt_disable_ip;
 #endif
 #ifdef CONFIG_NUMA
+	/* cpuset memory policy */
+	struct mempolicy		*cs_mpol;
 	/* Protected by alloc_lock: */
 	struct mempolicy		*mempolicy;
 	short				il_prev;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1f3a55297f39..19fd359dc8d8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -118,6 +118,9 @@ struct cpuset {
 	cpumask_var_t effective_cpus;
 	nodemask_t effective_mems;
 
+	/*cpuset mem policy */
+	struct mempolicy *mempolicy;
+
 	/*
 	 * CPUs allocated to child sub-partitions (default hierarchy only)
 	 * - CPUs granted by the parent = effective_cpus U subparts_cpus
@@ -378,6 +381,10 @@ static void cpuset_hotplug_workfn(struct work_struct *work);
 static DECLARE_WORK(cpuset_hotplug_work, cpuset_hotplug_workfn);
 
 static DECLARE_WAIT_QUEUE_HEAD(cpuset_attach_wq);
+static void cpuset_change_task_cs_mpol(struct task_struct *tsk,
+		struct mempolicy *mpol);
+static inline void update_cs_mpol_nodemask(struct cpuset *cs,
+		struct mempolicy *mpol);
 
 static inline void check_insane_mems_config(nodemask_t *nodes)
 {
@@ -570,7 +577,10 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
 	if (!trial)
 		return NULL;
 
+	mpol_get(trial->mempolicy);
+
 	if (alloc_cpumasks(trial, NULL)) {
+		mpol_put(trial->mempolicy);
 		kfree(trial);
 		return NULL;
 	}
@@ -587,6 +597,7 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
 static inline void free_cpuset(struct cpuset *cs)
 {
 	free_cpumasks(cs, NULL);
+	mpol_put(cs->mempolicy);
 	kfree(cs);
 }
 
@@ -1849,6 +1860,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 
 		spin_lock_irq(&callback_lock);
 		cp->effective_mems = *new_mems;
+		update_cs_mpol_nodemask(cp, cp->mempolicy);
 		spin_unlock_irq(&callback_lock);
 
 		WARN_ON(!is_in_v2_mode() &&
@@ -2304,7 +2316,8 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 		 * fail.  TODO: have a better way to handle failure here
 		 */
 		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
-
+		/*update the cpuset mempolicy to task*/
+		cpuset_change_task_cs_mpol(task, cs->mempolicy);
 		cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
 		cpuset_update_task_spread_flag(cs, task);
 	}
@@ -2441,6 +2454,140 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	return retval;
 }
 
+#ifdef CONFIG_NUMA
+
+/*update the mpol nodemask based on cpuset  nodemask*/
+static inline void update_cs_mpol_nodemask(struct cpuset *cs, struct mempolicy *mpol)
+{
+	nodemask_t newmems;
+
+	if (!mpol)
+		return;
+	nodes_and(newmems, cs->effective_mems, mpol->w.user_nodemask);
+
+	/*If no intersection between effective_mems and mpol user_nodemask,
+	 *use effective_mems to allocate mems.
+	 */
+	if (!nodes_weight(newmems))
+		newmems = cs->effective_mems;
+	mpol_rebind_policy(mpol, &newmems);
+}
+
+/*update cpuset policy for task*/
+static void cpuset_change_task_cs_mpol(struct task_struct *tsk,
+		struct mempolicy *mpol)
+{
+	struct mempolicy *old = NULL;
+
+	task_lock(tsk);
+	local_irq_disable();
+	write_seqcount_begin(&tsk->mems_allowed_seq);
+
+	old = tsk->cs_mpol;
+	tsk->cs_mpol = mpol;
+	mpol_get(mpol);
+	tsk->il_prev = 0;
+
+	write_seqcount_end(&tsk->mems_allowed_seq);
+	local_irq_enable();
+	task_unlock(tsk);
+	mpol_put(old);
+}
+
+static void update_tasks_cs_mpol(struct cpuset *cs)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	css_task_iter_start(&cs->css, 0, &it);
+
+	while ((task = css_task_iter_next(&it)))
+		cpuset_change_task_cs_mpol(task, cs->mempolicy);
+	css_task_iter_end(&it);
+}
+
+/* change cpuset mempolicy */
+static ssize_t cpuset_mpol_write(struct kernfs_open_file *of,
+		char *buf, size_t nbytes, loff_t off)
+{
+	struct mempolicy *mpol, *old = NULL;
+	struct cpuset *cs = css_cs(of_css(of));
+	nodemask_t cs_allowed;
+	int err = -ENODEV;
+
+	css_get(&cs->css);
+	kernfs_break_active_protection(of->kn);
+	percpu_down_write(&cpuset_rwsem);
+
+	if (!is_cpuset_online(cs))
+		goto out_unlock;
+
+	buf = strstrip(buf);
+	err = mpol_parse_str(buf, &mpol);
+
+	if (err) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	spin_lock_irq(&callback_lock);
+	old = cs->mempolicy;
+	update_cs_mpol_nodemask(cs, mpol);
+	cs->mempolicy = mpol;
+	spin_unlock_irq(&callback_lock);
+
+	update_tasks_cs_mpol(cs);
+
+out_unlock:
+	percpu_up_write(&cpuset_rwsem);
+	kernfs_unbreak_active_protection(of->kn);
+	css_put(&cs->css);
+
+	if (old) {
+	/*Wait for outstanding programs to complete.*/
+		synchronize_rcu();
+		mpol_put(old);
+	}
+	return err ?: nbytes;
+}
+
+/*show cpuset mempolicy*/
+static int cpuset_mpol_show(struct seq_file *seq, void *v)
+{
+	char buffer[64];
+	int ret = 0;
+	struct mempolicy *mpol;
+	struct cpuset *cs = css_cs(seq_css(seq));
+
+	memset(buffer, 0, sizeof(buffer));
+	spin_lock_irq(&callback_lock);
+	mpol = cs->mempolicy;
+
+	if (!mpol || mpol->mode == MPOL_DEFAULT)
+		goto out_unlock;
+
+	mpol_to_str(buffer, sizeof(buffer), mpol);
+	seq_printf(seq, buffer);
+	seq_putc(seq, '\n');
+
+out_unlock:
+	spin_unlock_irq(&callback_lock);
+	return ret;
+}
+
+#else
+static void cpuset_change_task_cs_mpol(struct task_struct *tsk,
+		struct mempolicy *mpol)
+{
+}
+
+static inline void update_cs_mpol_nodemask(struct cpuset *cs,
+		struct mempolicy *mpol)
+{
+}
+
+#endif
+
 /*
  * Common handling for a write to a "cpus" or "mems" file.
  */
@@ -2678,7 +2825,14 @@ static struct cftype legacy_files[] = {
 		.seq_show = cpuset_common_seq_show,
 		.private = FILE_EFFECTIVE_MEMLIST,
 	},
-
+#ifdef CONFIG_NUMA
+	{
+		.name = "mems_policy",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpuset_mpol_show,
+		.write = cpuset_mpol_write,
+	},
+#endif
 	{
 		.name = "cpu_exclusive",
 		.read_u64 = cpuset_read_u64,
@@ -2786,7 +2940,14 @@ static struct cftype dfl_files[] = {
 		.seq_show = cpuset_common_seq_show,
 		.private = FILE_EFFECTIVE_MEMLIST,
 	},
-
+#ifdef CONFIG_NUMA
+	{
+		.name = "mems.policy",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = cpuset_mpol_show,
+		.write = cpuset_mpol_write,
+	},
+#endif
 	{
 		.name = "cpus.partition",
 		.seq_show = sched_partition_show,
@@ -2835,6 +2996,21 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
 	fmeter_init(&cs->fmeter);
 	cs->relax_domain_level = -1;
 
+	if (IS_ENABLED(CONFIG_NUMA)) {
+		struct cpuset *pcs = css_cs(parent_css);
+		struct mempolicy *new;
+
+		/*Inherit mempolicy from parent.*/
+		spin_lock_irq(&callback_lock);
+		new = mpol_dup(pcs->mempolicy);
+
+		if (IS_ERR(new))
+			new = NULL;
+
+		cs->mempolicy = new;
+		spin_unlock_irq(&callback_lock);
+	}
+
 	/* Set CS_MEMORY_MIGRATE for default hierarchy */
 	if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
 		__set_bit(CS_MEMORY_MIGRATE, &cs->flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index 90c85b17bf69..3f695449e2a5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2190,6 +2190,7 @@ static __latent_entropy struct task_struct *copy_process(
 		p->mempolicy = NULL;
 		goto bad_fork_cleanup_delayacct;
 	}
+	mpol_get(p->cs_mpol); /*ref cpuset mempolicy*/
 #endif
 #ifdef CONFIG_CPUSETS
 	p->cpuset_mem_spread_rotor = NUMA_NO_NODE;
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index b73d3248d976..144f79887df9 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -158,9 +158,15 @@ int numa_map_to_online_node(int node)
 }
 EXPORT_SYMBOL_GPL(numa_map_to_online_node);
 
+static inline struct mempolicy *task_or_cs_mpol(struct task_struct *p)
+{
+	return p->mempolicy ?
+		p->mempolicy : p->cs_mpol;
+}
+
 struct mempolicy *get_task_policy(struct task_struct *p)
 {
-	struct mempolicy *pol = p->mempolicy;
+	struct mempolicy *pol = task_or_cs_mpol(p);
 	int node;
 
 	if (pol)
@@ -349,7 +355,7 @@ static void mpol_rebind_preferred(struct mempolicy *pol,
  * policies are protected by task->mems_allowed_seq to prevent a premature
  * OOM/allocation failure due to parallel nodemask modification.
  */
-static void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
+void mpol_rebind_policy(struct mempolicy *pol, const nodemask_t *newmask)
 {
 	if (!pol || pol->mode == MPOL_LOCAL)
 		return;
@@ -1895,7 +1901,7 @@ unsigned int mempolicy_slab_node(void)
 	if (!in_task())
 		return node;
 
-	policy = current->mempolicy;
+	policy = task_or_cs_mpol(current);
 	if (!policy)
 		return node;
 
@@ -2043,7 +2049,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 		return false;
 
 	task_lock(current);
-	mempolicy = current->mempolicy;
+	mempolicy = task_or_cs_mpol(current);
 	switch (mempolicy->mode) {
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
@@ -2633,13 +2639,16 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
  */
 void mpol_put_task_policy(struct task_struct *task)
 {
-	struct mempolicy *pol;
+	struct mempolicy *pol, *cs_pol;
 
 	task_lock(task);
 	pol = task->mempolicy;
+	cs_pol = task->cs_mpol;
+	task->cs_mpol = NULL;
 	task->mempolicy = NULL;
 	task_unlock(task);
 	mpol_put(pol);
+	mpol_put(cs_pol);
 }
 
 static void sp_delete(struct shared_policy *sp, struct sp_node *n)
@@ -2957,8 +2966,7 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
 
-
-#ifdef CONFIG_TMPFS
+#if defined(CONFIG_TMPFS) || defined(CONFIG_NUMA)
 /**
  * mpol_parse_str - parse string to mempolicy, for tmpfs mpol mount option.
  * @str:  string containing mempolicy to parse
@@ -3054,6 +3062,9 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 			mode_flags |= MPOL_F_RELATIVE_NODES;
 		else
 			goto out;
+	} else {
+		/*use static mode_flags in default*/
+		mode_flags |= MPOL_F_STATIC_NODES;
 	}
 
 	new = mpol_new(mode, mode_flags, &nodes);

base-commit: c40e8341e3b3bb27e3a65b06b5b454626234c4f0
-- 
2.25.1

