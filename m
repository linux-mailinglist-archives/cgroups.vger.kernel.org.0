Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68155783586
	for <lists+cgroups@lfdr.de>; Tue, 22 Aug 2023 00:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbjHUWUi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Aug 2023 18:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjHUWUb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Aug 2023 18:20:31 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B2E13D
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 15:20:23 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fee769fd53so21997835e9.1
        for <cgroups@vger.kernel.org>; Mon, 21 Aug 2023 15:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1692656422; x=1693261222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpGjJfq2A5e/X8d46OpXuARncKFR8DhE1r7cPJGjpx4=;
        b=rAFNwqoY4bRodYJUStwJPrMc2Rhr1zW3fNK6IM9tEe/wXNPO9+NhisW451IOq2jvGr
         9f4WCZ9i0KDk4D1dUimsaqCoWrRMd6QvE64G3wZzu0To0atYPknlCc/7oM7l2Qi/CuDl
         8+yvgFs5E9xqpUsppYVEOXSKLeIW5YzS+MwFeiA74dp6Oz/43RNrmmRvTcQd3/NdIvhE
         xp9yyMbgSEgD7J54DxqdociS7YyokCCgPAdsFnz41+G3+yGOyrulTw0Gzo+wwq3FxxVx
         YLctCIC0FnPMZbdvuWExO/MqsxvwS7wjnPd1JWtmWgzR570cRLOET966Ly4/CjLjj7XC
         GvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656422; x=1693261222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpGjJfq2A5e/X8d46OpXuARncKFR8DhE1r7cPJGjpx4=;
        b=HdTdG9K5ASRkoiONaVl4JKvd/QpPORL3e0OopShcJRIlXZIiIEYCM5ogwJfnVZITQN
         eaeGWGcH1IPAxND80npkGmKFxNwslt9bQmT1kw1V35+/oIFx24J7mkKRIQAuhg4P3l6F
         d1csIQlMbcZ7OVJ4Kweek1+PH7+MnMIOjfxPLL86Lk2hYFbrVzZwB+ysaD2xLxctbnlG
         Kd2Rd3kUpL/aObQH+9fFpO+LmN3vdVMYPJ/UeNbf4DEuUnqcAAMHiN8RwUoju3v2W9WL
         A/UpOZ+xlUSNPVc5fuGhQycWMziGS/z0B2wp94ztx88ySSJha+LFlPrHRlm1uMNyYYtf
         VUDQ==
X-Gm-Message-State: AOJu0Yy9iOtd0lZaOvU0h9jdexyYKilteyqLO0D1SVkgrnkUeT88OUUC
        O2Wpsd0e0ztD91NUiyyYt04u7g==
X-Google-Smtp-Source: AGHT+IGJ4z12t08PyGUU45S7zGTQoTjObR5R6efH4aUo4Z9bdm7KWxX9ksN4gZXW0dathImLK51SjQ==
X-Received: by 2002:a1c:7705:0:b0:3fb:d1db:5454 with SMTP id t5-20020a1c7705000000b003fbd1db5454mr6285051wmi.35.1692656422306;
        Mon, 21 Aug 2023 15:20:22 -0700 (PDT)
Received: from airbuntu.. (host109-151-228-137.range109-151.btcentralplus.com. [109.151.228.137])
        by smtp.gmail.com with ESMTPSA id hn40-20020a05600ca3a800b003fe61c33df5sm17751154wmb.3.2023.08.21.15.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 15:20:21 -0700 (PDT)
From:   Qais Yousef <qyousef@layalina.io>
To:     stable@vger.kernel.org
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Hao Luo <haoluo@google.com>,
        John Stultz <jstultz@google.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 2/6] sched/cpuset: Bring back cpuset_mutex
Date:   Mon, 21 Aug 2023 23:19:52 +0100
Message-Id: <20230821221956.698117-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821221956.698117-1-qyousef@layalina.io>
References: <20230821221956.698117-1-qyousef@layalina.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Juri Lelli <juri.lelli@redhat.com>

commit 111cd11bbc54850f24191c52ff217da88a5e639b upstream.

Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
as it has been reported to cause slowdowns in workloads that need to
change cpuset configuration frequently and it is also not implementing
priority inheritance (which causes troubles with realtime workloads).

Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
only for SCHED_DEADLINE tasks (other policies don't care about stable
cpusets anyway).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 111cd11bbc54850f24191c52ff217da88a5e639b)
Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/cpuset.h |   8 +--
 kernel/cgroup/cpuset.c | 159 +++++++++++++++++++++--------------------
 kernel/sched/core.c    |  22 ++++--
 3 files changed, 99 insertions(+), 90 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 980b76a1237e..f90e6325d707 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -71,8 +71,8 @@ extern void cpuset_init_smp(void);
 extern void cpuset_force_rebuild(void);
 extern void cpuset_update_active_cpus(void);
 extern void cpuset_wait_for_hotplug(void);
-extern void cpuset_read_lock(void);
-extern void cpuset_read_unlock(void);
+extern void cpuset_lock(void);
+extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
@@ -189,8 +189,8 @@ static inline void cpuset_update_active_cpus(void)
 
 static inline void cpuset_wait_for_hotplug(void) { }
 
-static inline void cpuset_read_lock(void) { }
-static inline void cpuset_read_unlock(void) { }
+static inline void cpuset_lock(void) { }
+static inline void cpuset_unlock(void) { }
 
 static inline void cpuset_cpus_allowed(struct task_struct *p,
 				       struct cpumask *mask)
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 428ab46291e2..041c0809adaf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -366,22 +366,23 @@ static struct cpuset top_cpuset = {
 		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
 
 /*
- * There are two global locks guarding cpuset structures - cpuset_rwsem and
+ * There are two global locks guarding cpuset structures - cpuset_mutex and
  * callback_lock. We also require taking task_lock() when dereferencing a
  * task's cpuset pointer. See "The task_lock() exception", at the end of this
- * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
- * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
- * prevent change to cpuset structures.
+ * comment.  The cpuset code uses only cpuset_mutex. Other kernel subsystems
+ * can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
+ * structures. Note that cpuset_mutex needs to be a mutex as it is used in
+ * paths that rely on priority inheritance (e.g. scheduler - on RT) for
+ * correctness.
  *
  * A task must hold both locks to modify cpusets.  If a task holds
- * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
- * is the only task able to also acquire callback_lock and be able to
- * modify cpusets.  It can perform various checks on the cpuset structure
- * first, knowing nothing will change.  It can also allocate memory while
- * just holding cpuset_rwsem.  While it is performing these checks, various
- * callback routines can briefly acquire callback_lock to query cpusets.
- * Once it is ready to make the changes, it takes callback_lock, blocking
- * everyone else.
+ * cpuset_mutex, it blocks others, ensuring that it is the only task able to
+ * also acquire callback_lock and be able to modify cpusets.  It can perform
+ * various checks on the cpuset structure first, knowing nothing will change.
+ * It can also allocate memory while just holding cpuset_mutex.  While it is
+ * performing these checks, various callback routines can briefly acquire
+ * callback_lock to query cpusets.  Once it is ready to make the changes, it
+ * takes callback_lock, blocking everyone else.
  *
  * Calls to the kernel memory allocator can not be made while holding
  * callback_lock, as that would risk double tripping on callback_lock
@@ -403,16 +404,16 @@ static struct cpuset top_cpuset = {
  * guidelines for accessing subsystem state in kernel/cgroup.c
  */
 
-DEFINE_STATIC_PERCPU_RWSEM(cpuset_rwsem);
+static DEFINE_MUTEX(cpuset_mutex);
 
-void cpuset_read_lock(void)
+void cpuset_lock(void)
 {
-	percpu_down_read(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
-void cpuset_read_unlock(void)
+void cpuset_unlock(void)
 {
-	percpu_up_read(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 static DEFINE_SPINLOCK(callback_lock);
@@ -496,7 +497,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_mask.
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_cpus(struct task_struct *tsk,
 				  struct cpumask *pmask)
@@ -538,7 +539,7 @@ static void guarantee_online_cpus(struct task_struct *tsk,
  * One way or another, we guarantee to return some non-empty subset
  * of node_states[N_MEMORY].
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
@@ -550,7 +551,7 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 /*
  * update task's spread flag if cpuset's page/slab spread flag is set
  *
- * Call with callback_lock or cpuset_rwsem held. The check can be skipped
+ * Call with callback_lock or cpuset_mutex held. The check can be skipped
  * if on default hierarchy.
  */
 static void cpuset_update_task_spread_flags(struct cpuset *cs,
@@ -575,7 +576,7 @@ static void cpuset_update_task_spread_flags(struct cpuset *cs,
  *
  * One cpuset is a subset of another if all its allowed CPUs and
  * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.  Call holding cpuset_rwsem.
+ * are only set if the other's are set.  Call holding cpuset_mutex.
  */
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
@@ -713,7 +714,7 @@ static int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
  * If we replaced the flag and mask values of the current cpuset
  * (cur) with those values in the trial cpuset (trial), would
  * our various subset and exclusive rules still be valid?  Presumes
- * cpuset_rwsem held.
+ * cpuset_mutex held.
  *
  * 'cur' is the address of an actual, in-use cpuset.  Operations
  * such as list traversal that depend on the actual address of the
@@ -829,7 +830,7 @@ static void update_domain_attr_tree(struct sched_domain_attr *dattr,
 	rcu_read_unlock();
 }
 
-/* Must be called with cpuset_rwsem held.  */
+/* Must be called with cpuset_mutex held.  */
 static inline int nr_cpusets(void)
 {
 	/* jump label reference count + the top-level cpuset */
@@ -855,7 +856,7 @@ static inline int nr_cpusets(void)
  * domains when operating in the severe memory shortage situations
  * that could cause allocation failures below.
  *
- * Must be called with cpuset_rwsem held.
+ * Must be called with cpuset_mutex held.
  *
  * The three key local variables below are:
  *    cp - cpuset pointer, used (together with pos_css) to perform a
@@ -1084,7 +1085,7 @@ static void dl_rebuild_rd_accounting(void)
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -1134,7 +1135,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
  *
- * Call with cpuset_rwsem held.  Takes cpus_read_lock().
+ * Call with cpuset_mutex held.  Takes cpus_read_lock().
  */
 static void rebuild_sched_domains_locked(void)
 {
@@ -1145,7 +1146,7 @@ static void rebuild_sched_domains_locked(void)
 	int ndoms;
 
 	lockdep_assert_cpus_held();
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
@@ -1196,9 +1197,9 @@ static void rebuild_sched_domains_locked(void)
 void rebuild_sched_domains(void)
 {
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	rebuild_sched_domains_locked();
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
 
@@ -1208,7 +1209,7 @@ void rebuild_sched_domains(void)
  * @new_cpus: the temp variable for the new effective_cpus mask
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
- * effective cpuset's.  As this function is called with cpuset_rwsem held,
+ * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mask()
  * is used instead of effective_cpus to make sure all offline CPUs are also
  * included as hotplug code won't update cpumasks for tasks in top_cpuset.
@@ -1322,7 +1323,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * The parent must be a partition root.
@@ -1545,7 +1546,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
  *
  * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				 bool force)
@@ -1705,7 +1706,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
@@ -1955,12 +1956,12 @@ static void *cpuset_being_rebound;
  * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
  *
  * Iterate through each task of @cs updating its mems_allowed to the
- * effective cpuset's.  As this function is called with cpuset_rwsem held,
+ * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable.
  */
 static void update_tasks_nodemask(struct cpuset *cs)
 {
-	static nodemask_t newmems;	/* protected by cpuset_rwsem */
+	static nodemask_t newmems;	/* protected by cpuset_mutex */
 	struct css_task_iter it;
 	struct task_struct *task;
 
@@ -1973,7 +1974,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
 	 * take while holding tasklist_lock.  Forks can happen - the
 	 * mpol_dup() cpuset_being_rebound check will catch such forks,
 	 * and rebind their vma mempolicies too.  Because we still hold
-	 * the global cpuset_rwsem, we know that no other rebind effort
+	 * the global cpuset_mutex, we know that no other rebind effort
 	 * will be contending for the global variable cpuset_being_rebound.
 	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
 	 * is idempotent.  Also migrate pages in each mm to new nodes.
@@ -2019,7 +2020,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
  *
  * On legacy hierarchy, effective_mems will be the same with mems_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 {
@@ -2072,7 +2073,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
  * mempolicies and if the cpuset is marked 'memory_migrate',
  * migrate the tasks pages to the new memory.
  *
- * Call with cpuset_rwsem held. May take callback_lock during call.
+ * Call with cpuset_mutex held. May take callback_lock during call.
  * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
  * lock each such tasks mm->mmap_lock, scan its vma's and rebind
  * their mempolicies to the cpusets new mems_allowed.
@@ -2164,7 +2165,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
  * @cs: the cpuset in which each task's spread flags needs to be changed
  *
  * Iterate through each task of @cs updating its spread flags.  As this
- * function is called with cpuset_rwsem held, cpuset membership stays
+ * function is called with cpuset_mutex held, cpuset membership stays
  * stable.
  */
 static void update_tasks_flags(struct cpuset *cs)
@@ -2184,7 +2185,7 @@ static void update_tasks_flags(struct cpuset *cs)
  * cs:		the cpuset to update
  * turning_on: 	whether the flag is being set or cleared
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -2234,7 +2235,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * @new_prs: new partition root state
  * Return: 0 if successful, != 0 if error
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
@@ -2472,7 +2473,7 @@ static int cpuset_can_attach_check(struct cpuset *cs)
 	return 0;
 }
 
-/* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
+/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
@@ -2484,7 +2485,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs);
@@ -2506,7 +2507,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 */
 	cs->attach_in_progress++;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -2518,15 +2519,15 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 	cgroup_taskset_first(tset, &css);
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
- * Protected by cpuset_rwsem. cpus_attach is used only by cpuset_attach_task()
+ * Protected by cpuset_mutex. cpus_attach is used only by cpuset_attach_task()
  * but we can't allocate it dynamically there.  Define it global and
  * allocate from cpuset_init().
  */
@@ -2535,7 +2536,7 @@ static nodemask_t cpuset_attach_nodemask_to;
 
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	if (cs != &top_cpuset)
 		guarantee_online_cpus(task, cpus_attach);
@@ -2565,7 +2566,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cpus_updated = !cpumask_equal(cs->effective_cpus,
 				      oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
@@ -2626,7 +2627,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /* The various types of files and directories in a cpuset file system */
@@ -2658,7 +2659,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -2694,7 +2695,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2707,7 +2708,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = -ENODEV;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2720,7 +2721,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2753,7 +2754,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	 * operation like this one can lead to a deadlock through kernfs
 	 * active_ref protection.  Let's break the protection.  Losing the
 	 * protection is okay as we check whether @cs is online after
-	 * grabbing cpuset_rwsem anyway.  This only happens on the legacy
+	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
 	 * hierarchies.
 	 */
 	css_get(&cs->css);
@@ -2761,7 +2762,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	flush_work(&cpuset_hotplug_work);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2785,7 +2786,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
@@ -2933,13 +2934,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 
 	css_get(&cs->css);
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
 	retval = update_prstate(cs, val);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	css_put(&cs->css);
 	return retval ?: nbytes;
@@ -3156,7 +3157,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		return 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
@@ -3207,7 +3208,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return 0;
 }
@@ -3228,7 +3229,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	struct cpuset *cs = css_cs(css);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	if (is_partition_valid(cs))
 		update_prstate(cs, 0);
@@ -3247,7 +3248,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
 
@@ -3260,7 +3261,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
@@ -3273,7 +3274,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 	}
 
 	spin_unlock_irq(&callback_lock);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -3294,7 +3295,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 		return 0;
 
 	lockdep_assert_held(&cgroup_mutex);
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs);
@@ -3315,7 +3316,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	 */
 	cs->attach_in_progress++;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -3331,11 +3332,11 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
 	if (same_cs)
 		return;
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cs->attach_in_progress--;
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -3363,7 +3364,7 @@ static void cpuset_fork(struct task_struct *task)
 	}
 
 	/* CLONE_INTO_CGROUP */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	cpuset_attach_task(cs, task);
 
@@ -3371,7 +3372,7 @@ static void cpuset_fork(struct task_struct *task)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 struct cgroup_subsys cpuset_cgrp_subsys = {
@@ -3472,7 +3473,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
@@ -3482,7 +3483,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	if (is_empty)
 		remove_tasks_in_empty_cpuset(cs);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
 static void
@@ -3533,14 +3534,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 retry:
 	wait_event(cpuset_attach_wq, cs->attach_in_progress == 0);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/*
 	 * We have raced with task attaching. We wait until attaching
 	 * is finished, so we won't attach a task to an empty cpuset.
 	 */
 	if (cs->attach_in_progress) {
-		percpu_up_write(&cpuset_rwsem);
+		mutex_unlock(&cpuset_mutex);
 		goto retry;
 	}
 
@@ -3637,7 +3638,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 					    cpus_updated, mems_updated);
 
 unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /**
@@ -3667,7 +3668,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
@@ -3724,7 +3725,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		update_tasks_nodemask(&top_cpuset);
 	}
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/* if cpus or mems changed, we need to propagate to descendants */
 	if (cpus_updated || mems_updated) {
@@ -4155,7 +4156,7 @@ void __cpuset_memory_pressure_bump(void)
  *  - Used for /proc/<pid>/cpuset.
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_rwsem, keeping cpuset_attach() from changing it
+ *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
  *    anyway.
  */
 int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a68d1276bab0..72cd267e3821 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7590,6 +7590,7 @@ static int __sched_setscheduler(struct task_struct *p,
 	int reset_on_fork;
 	int queue_flags = DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct rq *rq;
+	bool cpuset_locked = false;
 
 	/* The pi code expects interrupts enabled */
 	BUG_ON(pi && in_interrupt());
@@ -7639,8 +7640,14 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
-	if (pi)
-		cpuset_read_lock();
+	/*
+	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
+	 * information.
+	 */
+	if (dl_policy(policy) || dl_policy(p->policy)) {
+		cpuset_locked = true;
+		cpuset_lock();
+	}
 
 	/*
 	 * Make sure no PI-waiters arrive (or leave) while we are
@@ -7716,8 +7723,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (pi)
-			cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		goto recheck;
 	}
 
@@ -7784,7 +7791,8 @@ static int __sched_setscheduler(struct task_struct *p,
 	task_rq_unlock(rq, p, &rf);
 
 	if (pi) {
-		cpuset_read_unlock();
+		if (cpuset_locked)
+			cpuset_unlock();
 		rt_mutex_adjust_pi(p);
 	}
 
@@ -7796,8 +7804,8 @@ static int __sched_setscheduler(struct task_struct *p,
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
-	if (pi)
-		cpuset_read_unlock();
+	if (cpuset_locked)
+		cpuset_unlock();
 	return retval;
 }
 
-- 
2.34.1

