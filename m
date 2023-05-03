Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA0A6F513D
	for <lists+cgroups@lfdr.de>; Wed,  3 May 2023 09:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjECHYE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 3 May 2023 03:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjECHX4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 3 May 2023 03:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F883C29
        for <cgroups@vger.kernel.org>; Wed,  3 May 2023 00:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683098585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nO1mzVdGNAoh4CAeozZUp/SmNYBwf5C/F+mNsOzIzh4=;
        b=XeuCjMMYQa3wlHlft5CpNc2tHabeKvnCGHrRYyS3WXCKWiJboRG0kzWIYPfFmuDfP1Q6bl
        1fMDwRI8Z+YxlhTbdcEt2zDljNGvGWUZZ8VFQ8gG4RjSoZsHE+jNfuwuT9ugTkkBeF3gAe
        +WNe3MWbgQqCkDQghgHtFo9KLwIpx3s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-Jq4WEGY5Nbmi4omsdbpAXQ-1; Wed, 03 May 2023 03:23:03 -0400
X-MC-Unique: Jq4WEGY5Nbmi4omsdbpAXQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f18c2b2110so14876895e9.3
        for <cgroups@vger.kernel.org>; Wed, 03 May 2023 00:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098582; x=1685690582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nO1mzVdGNAoh4CAeozZUp/SmNYBwf5C/F+mNsOzIzh4=;
        b=BgNGhEfmMGOyAjrpy+NjlzhrkMJJ/CwHLTApNh0SIGl5fkMy9WITUZ/AGglgVRnLUD
         dsQbWrBD3beD/0icnIa4xh8T+FUrDRG7pBegkc4m7SDGeiq59RSaWJk+Ci//nVYy6fZz
         EpgLPEfULGw8QNzhci+ie7P+d/QGE6fpHQqhsdZGskR0mozzHY2xQJHMN8GpQBdSJN2G
         XFAlcrlwWWmVtYbT7BJoRgF6GtPlcSeqL2KF9UHI4DX4BeHjRsoVkGeDrWnRVtaJpCG4
         LSRnjVe+itbx5Jk2o39wpBJqIKT3H12KGZbsYN3MFlmttaAhGA9v2za/hy99nZMS6Mgg
         7W7g==
X-Gm-Message-State: AC+VfDyQ+itFEKJ6U7O+BDYYZk9onv3vc5OupudSPjPyxFIUh1agBKkM
        jAX+V2FHspTlmyIJymum0/z/JlxFE9HsuqM5d5zxcE86vbFOa8O4fKBcAAbUXhUAonI8DNAO10a
        p3CPp/8GQrXN8gyroug==
X-Received: by 2002:a05:600c:cb:b0:3f1:7144:5e32 with SMTP id u11-20020a05600c00cb00b003f171445e32mr13784979wmm.35.1683098582099;
        Wed, 03 May 2023 00:23:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5uJl95UR4I+Ak10e4J5kdUij1Hr72aC9FXbYVEoJXKHiroFtQa6J78pru/5Ezk+5pnlCfIfA==
X-Received: by 2002:a05:600c:cb:b0:3f1:7144:5e32 with SMTP id u11-20020a05600c00cb00b003f171445e32mr13784948wmm.35.1683098581539;
        Wed, 03 May 2023 00:23:01 -0700 (PDT)
Received: from localhost.localdomain.com ([2a02:b127:8011:7489:32ac:78e2:be8c:a5fb])
        by smtp.gmail.com with ESMTPSA id k1-20020a7bc301000000b003eddc6aa5fasm947259wmj.39.2023.05.03.00.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:23:01 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Qais Yousef <qyousef@layalina.io>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: [PATCH v2 2/6] sched/cpuset: Bring back cpuset_mutex
Date:   Wed,  3 May 2023 09:22:24 +0200
Message-Id: <20230503072228.115707-3-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503072228.115707-1-juri.lelli@redhat.com>
References: <20230503072228.115707-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Turns out percpu_cpuset_rwsem - commit 1243dc518c9d ("cgroup/cpuset:
Convert cpuset_mutex to percpu_rwsem") - wasn't such a brilliant idea,
as it has been reported to cause slowdowns in workloads that need to
change cpuset configuration frequently and it is also not implementing
priority inheritance (which causes troubles with realtime workloads).

Convert percpu_cpuset_rwsem back to regular cpuset_mutex. Also grab it
only for SCHED_DEADLINE tasks (other policies don't care about stable
cpusets anyway).

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 include/linux/cpuset.h |   8 +--
 kernel/cgroup/cpuset.c | 157 ++++++++++++++++++++---------------------
 kernel/sched/core.c    |  22 ++++--
 3 files changed, 97 insertions(+), 90 deletions(-)

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
index 428ab46291e2..ee66be215fb9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -366,22 +366,21 @@ static struct cpuset top_cpuset = {
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
+ * structures.
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
@@ -403,16 +402,16 @@ static struct cpuset top_cpuset = {
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
@@ -496,7 +495,7 @@ static inline bool partition_is_populated(struct cpuset *cs,
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_mask.
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_cpus(struct task_struct *tsk,
 				  struct cpumask *pmask)
@@ -538,7 +537,7 @@ static void guarantee_online_cpus(struct task_struct *tsk,
  * One way or another, we guarantee to return some non-empty subset
  * of node_states[N_MEMORY].
  *
- * Call with callback_lock or cpuset_rwsem held.
+ * Call with callback_lock or cpuset_mutex held.
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
@@ -550,7 +549,7 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 /*
  * update task's spread flag if cpuset's page/slab spread flag is set
  *
- * Call with callback_lock or cpuset_rwsem held. The check can be skipped
+ * Call with callback_lock or cpuset_mutex held. The check can be skipped
  * if on default hierarchy.
  */
 static void cpuset_update_task_spread_flags(struct cpuset *cs,
@@ -575,7 +574,7 @@ static void cpuset_update_task_spread_flags(struct cpuset *cs,
  *
  * One cpuset is a subset of another if all its allowed CPUs and
  * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.  Call holding cpuset_rwsem.
+ * are only set if the other's are set.  Call holding cpuset_mutex.
  */
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
@@ -713,7 +712,7 @@ static int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
  * If we replaced the flag and mask values of the current cpuset
  * (cur) with those values in the trial cpuset (trial), would
  * our various subset and exclusive rules still be valid?  Presumes
- * cpuset_rwsem held.
+ * cpuset_mutex held.
  *
  * 'cur' is the address of an actual, in-use cpuset.  Operations
  * such as list traversal that depend on the actual address of the
@@ -829,7 +828,7 @@ static void update_domain_attr_tree(struct sched_domain_attr *dattr,
 	rcu_read_unlock();
 }
 
-/* Must be called with cpuset_rwsem held.  */
+/* Must be called with cpuset_mutex held.  */
 static inline int nr_cpusets(void)
 {
 	/* jump label reference count + the top-level cpuset */
@@ -855,7 +854,7 @@ static inline int nr_cpusets(void)
  * domains when operating in the severe memory shortage situations
  * that could cause allocation failures below.
  *
- * Must be called with cpuset_rwsem held.
+ * Must be called with cpuset_mutex held.
  *
  * The three key local variables below are:
  *    cp - cpuset pointer, used (together with pos_css) to perform a
@@ -1084,7 +1083,7 @@ static void dl_rebuild_rd_accounting(void)
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
 	lockdep_assert_held(&sched_domains_mutex);
 
@@ -1134,7 +1133,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
  *
- * Call with cpuset_rwsem held.  Takes cpus_read_lock().
+ * Call with cpuset_mutex held.  Takes cpus_read_lock().
  */
 static void rebuild_sched_domains_locked(void)
 {
@@ -1145,7 +1144,7 @@ static void rebuild_sched_domains_locked(void)
 	int ndoms;
 
 	lockdep_assert_cpus_held();
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * If we have raced with CPU hotplug, return early to avoid
@@ -1196,9 +1195,9 @@ static void rebuild_sched_domains_locked(void)
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
 
@@ -1208,7 +1207,7 @@ void rebuild_sched_domains(void)
  * @new_cpus: the temp variable for the new effective_cpus mask
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
- * effective cpuset's.  As this function is called with cpuset_rwsem held,
+ * effective cpuset's.  As this function is called with cpuset_mutex held,
  * cpuset membership stays stable. For top_cpuset, task_cpu_possible_mask()
  * is used instead of effective_cpus to make sure all offline CPUs are also
  * included as hotplug code won't update cpumasks for tasks in top_cpuset.
@@ -1322,7 +1321,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 	int old_prs, new_prs;
 	int part_error = PERR_NONE;	/* Partition error? */
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * The parent must be a partition root.
@@ -1545,7 +1544,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
  *
  * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				 bool force)
@@ -1705,7 +1704,7 @@ static void update_sibling_cpumasks(struct cpuset *parent, struct cpuset *cs,
 	struct cpuset *sibling;
 	struct cgroup_subsys_state *pos_css;
 
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	/*
 	 * Check all its siblings and call update_cpumasks_hier()
@@ -1955,12 +1954,12 @@ static void *cpuset_being_rebound;
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
 
@@ -1973,7 +1972,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
 	 * take while holding tasklist_lock.  Forks can happen - the
 	 * mpol_dup() cpuset_being_rebound check will catch such forks,
 	 * and rebind their vma mempolicies too.  Because we still hold
-	 * the global cpuset_rwsem, we know that no other rebind effort
+	 * the global cpuset_mutex, we know that no other rebind effort
 	 * will be contending for the global variable cpuset_being_rebound.
 	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
 	 * is idempotent.  Also migrate pages in each mm to new nodes.
@@ -2019,7 +2018,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
  *
  * On legacy hierarchy, effective_mems will be the same with mems_allowed.
  *
- * Called with cpuset_rwsem held
+ * Called with cpuset_mutex held
  */
 static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 {
@@ -2072,7 +2071,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
  * mempolicies and if the cpuset is marked 'memory_migrate',
  * migrate the tasks pages to the new memory.
  *
- * Call with cpuset_rwsem held. May take callback_lock during call.
+ * Call with cpuset_mutex held. May take callback_lock during call.
  * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
  * lock each such tasks mm->mmap_lock, scan its vma's and rebind
  * their mempolicies to the cpusets new mems_allowed.
@@ -2164,7 +2163,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
  * @cs: the cpuset in which each task's spread flags needs to be changed
  *
  * Iterate through each task of @cs updating its spread flags.  As this
- * function is called with cpuset_rwsem held, cpuset membership stays
+ * function is called with cpuset_mutex held, cpuset membership stays
  * stable.
  */
 static void update_tasks_flags(struct cpuset *cs)
@@ -2184,7 +2183,7 @@ static void update_tasks_flags(struct cpuset *cs)
  * cs:		the cpuset to update
  * turning_on: 	whether the flag is being set or cleared
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -2234,7 +2233,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * @new_prs: new partition root state
  * Return: 0 if successful, != 0 if error
  *
- * Call with cpuset_rwsem held.
+ * Call with cpuset_mutex held.
  */
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
@@ -2472,7 +2471,7 @@ static int cpuset_can_attach_check(struct cpuset *cs)
 	return 0;
 }
 
-/* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
+/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
@@ -2484,7 +2483,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	cpuset_attach_old_cs = task_cs(cgroup_taskset_first(tset, &css));
 	cs = css_cs(css);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs);
@@ -2506,7 +2505,7 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	 */
 	cs->attach_in_progress++;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -2518,15 +2517,15 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
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
@@ -2535,7 +2534,7 @@ static nodemask_t cpuset_attach_nodemask_to;
 
 static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
 {
-	percpu_rwsem_assert_held(&cpuset_rwsem);
+	lockdep_assert_held(&cpuset_mutex);
 
 	if (cs != &top_cpuset)
 		guarantee_online_cpus(task, cpus_attach);
@@ -2565,7 +2564,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	cs = css_cs(css);
 
 	lockdep_assert_cpus_held();	/* see cgroup_attach_lock() */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	cpus_updated = !cpumask_equal(cs->effective_cpus,
 				      oldcs->effective_cpus);
 	mems_updated = !nodes_equal(cs->effective_mems, oldcs->effective_mems);
@@ -2626,7 +2625,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /* The various types of files and directories in a cpuset file system */
@@ -2658,7 +2657,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs)) {
 		retval = -ENODEV;
 		goto out_unlock;
@@ -2694,7 +2693,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2707,7 +2706,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 	int retval = -ENODEV;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2720,7 +2719,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
 		break;
 	}
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return retval;
 }
@@ -2753,7 +2752,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	 * operation like this one can lead to a deadlock through kernfs
 	 * active_ref protection.  Let's break the protection.  Losing the
 	 * protection is okay as we check whether @cs is online after
-	 * grabbing cpuset_rwsem anyway.  This only happens on the legacy
+	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
 	 * hierarchies.
 	 */
 	css_get(&cs->css);
@@ -2761,7 +2760,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	flush_work(&cpuset_hotplug_work);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	if (!is_cpuset_online(cs))
 		goto out_unlock;
 
@@ -2785,7 +2784,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 
 	free_cpuset(trialcs);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	kernfs_unbreak_active_protection(of->kn);
 	css_put(&cs->css);
@@ -2933,13 +2932,13 @@ static ssize_t sched_partition_write(struct kernfs_open_file *of, char *buf,
 
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
@@ -3156,7 +3155,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 		return 0;
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	set_bit(CS_ONLINE, &cs->flags);
 	if (is_spread_page(parent))
@@ -3207,7 +3206,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
 	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
 	spin_unlock_irq(&callback_lock);
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 	return 0;
 }
@@ -3228,7 +3227,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	struct cpuset *cs = css_cs(css);
 
 	cpus_read_lock();
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	if (is_partition_valid(cs))
 		update_prstate(cs, 0);
@@ -3247,7 +3246,7 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
 	cpuset_dec();
 	clear_bit(CS_ONLINE, &cs->flags);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
 }
 
@@ -3260,7 +3259,7 @@ static void cpuset_css_free(struct cgroup_subsys_state *css)
 
 static void cpuset_bind(struct cgroup_subsys_state *root_css)
 {
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	spin_lock_irq(&callback_lock);
 
 	if (is_in_v2_mode()) {
@@ -3273,7 +3272,7 @@ static void cpuset_bind(struct cgroup_subsys_state *root_css)
 	}
 
 	spin_unlock_irq(&callback_lock);
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /*
@@ -3294,7 +3293,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 		return 0;
 
 	lockdep_assert_held(&cgroup_mutex);
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* Check to see if task is allowed in the cpuset */
 	ret = cpuset_can_attach_check(cs);
@@ -3315,7 +3314,7 @@ static int cpuset_can_fork(struct task_struct *task, struct css_set *cset)
 	 */
 	cs->attach_in_progress++;
 out_unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 	return ret;
 }
 
@@ -3331,11 +3330,11 @@ static void cpuset_cancel_fork(struct task_struct *task, struct css_set *cset)
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
@@ -3363,7 +3362,7 @@ static void cpuset_fork(struct task_struct *task)
 	}
 
 	/* CLONE_INTO_CGROUP */
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 	guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
 	cpuset_attach_task(cs, task);
 
@@ -3371,7 +3370,7 @@ static void cpuset_fork(struct task_struct *task)
 	if (!cs->attach_in_progress)
 		wake_up(&cpuset_attach_wq);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 struct cgroup_subsys cpuset_cgrp_subsys = {
@@ -3472,7 +3471,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	is_empty = cpumask_empty(cs->cpus_allowed) ||
 		   nodes_empty(cs->mems_allowed);
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/*
 	 * Move tasks to the nearest ancestor with execution resources,
@@ -3482,7 +3481,7 @@ hotplug_update_tasks_legacy(struct cpuset *cs,
 	if (is_empty)
 		remove_tasks_in_empty_cpuset(cs);
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 }
 
 static void
@@ -3533,14 +3532,14 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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
 
@@ -3637,7 +3636,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 					    cpus_updated, mems_updated);
 
 unlock:
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 }
 
 /**
@@ -3667,7 +3666,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 	if (on_dfl && !alloc_cpumasks(NULL, &tmp))
 		ptmp = &tmp;
 
-	percpu_down_write(&cpuset_rwsem);
+	mutex_lock(&cpuset_mutex);
 
 	/* fetch the available cpus/mems and find out which changed how */
 	cpumask_copy(&new_cpus, cpu_active_mask);
@@ -3724,7 +3723,7 @@ static void cpuset_hotplug_workfn(struct work_struct *work)
 		update_tasks_nodemask(&top_cpuset);
 	}
 
-	percpu_up_write(&cpuset_rwsem);
+	mutex_unlock(&cpuset_mutex);
 
 	/* if cpus or mems changed, we need to propagate to descendants */
 	if (cpus_updated || mems_updated) {
@@ -4155,7 +4154,7 @@ void __cpuset_memory_pressure_bump(void)
  *  - Used for /proc/<pid>/cpuset.
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_rwsem, keeping cpuset_attach() from changing it
+ *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
  *    anyway.
  */
 int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..d826bec1c522 100644
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
2.40.1

