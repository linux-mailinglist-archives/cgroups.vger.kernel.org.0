Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85154065CA
	for <lists+cgroups@lfdr.de>; Fri, 10 Sep 2021 04:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhIJCok (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 Sep 2021 22:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229896AbhIJCok (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 Sep 2021 22:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631241809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=c0Qqn1R6NM2ft9tQ6JqKfdeZB/DHI04ObjgVzFBUDVc=;
        b=jOvgH5ngoYpXVZmAZuTgWNWkdY06LDzYMHuKWyX6PVx7fO454KIFBRVYLzSt/p6tnYbO96
        T5UbZEZJnpTLsO650jlj3rEb9qz8f6AYa+ZsfaCrRe3lRXk+5A/JMJaXXBJLYipmP5xlF4
        LbmKL4vhvHYfWvmL5SmA8rhHqwEBY2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-2sN03F2PPrqc46xIDQLQLQ-1; Thu, 09 Sep 2021 22:43:28 -0400
X-MC-Unique: 2sN03F2PPrqc46xIDQLQLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B9CF80196C;
        Fri, 10 Sep 2021 02:43:27 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B6D760E1C;
        Fri, 10 Sep 2021 02:43:26 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] cgroup/cpuset: Change references of cpuset_mutex to cpuset_rwsem
Date:   Thu,  9 Sep 2021 22:42:56 -0400
Message-Id: <20210910024256.7615-2-longman@redhat.com>
In-Reply-To: <20210910024256.7615-1-longman@redhat.com>
References: <20210910024256.7615-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Since commit 1243dc518c9d ("cgroup/cpuset: Convert cpuset_mutex to
percpu_rwsem"), cpuset_mutex has been replaced by cpuset_rwsem which is
a percpu rwsem. However, the comments in kernel/cgroup/cpuset.c still
reference cpuset_mutex which are now incorrect.

Change all the references of cpuset_mutex to cpuset_rwsem.

Fixes: 1243dc518c9d ("cgroup/cpuset: Convert cpuset_mutex to percpu_rwsem")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 56 ++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 27 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index df1ccf4558f8..2a9695ccb65f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -311,17 +311,19 @@ static struct cpuset top_cpuset = {
 		if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
 
 /*
- * There are two global locks guarding cpuset structures - cpuset_mutex and
+ * There are two global locks guarding cpuset structures - cpuset_rwsem and
  * callback_lock. We also require taking task_lock() when dereferencing a
  * task's cpuset pointer. See "The task_lock() exception", at the end of this
- * comment.
+ * comment.  The cpuset code uses only cpuset_rwsem write lock.  Other
+ * kernel subsystems can use cpuset_read_lock()/cpuset_read_unlock() to
+ * prevent change to cpuset structures.
  *
  * A task must hold both locks to modify cpusets.  If a task holds
- * cpuset_mutex, then it blocks others wanting that mutex, ensuring that it
+ * cpuset_rwsem, it blocks others wanting that rwsem, ensuring that it
  * is the only task able to also acquire callback_lock and be able to
  * modify cpusets.  It can perform various checks on the cpuset structure
  * first, knowing nothing will change.  It can also allocate memory while
- * just holding cpuset_mutex.  While it is performing these checks, various
+ * just holding cpuset_rwsem.  While it is performing these checks, various
  * callback routines can briefly acquire callback_lock to query cpusets.
  * Once it is ready to make the changes, it takes callback_lock, blocking
  * everyone else.
@@ -393,7 +395,7 @@ static inline bool is_in_v2_mode(void)
  * One way or another, we guarantee to return some non-empty subset
  * of cpu_online_mask.
  *
- * Call with callback_lock or cpuset_mutex held.
+ * Call with callback_lock or cpuset_rwsem held.
  */
 static void guarantee_online_cpus(struct task_struct *tsk,
 				  struct cpumask *pmask)
@@ -435,7 +437,7 @@ static void guarantee_online_cpus(struct task_struct *tsk,
  * One way or another, we guarantee to return some non-empty subset
  * of node_states[N_MEMORY].
  *
- * Call with callback_lock or cpuset_mutex held.
+ * Call with callback_lock or cpuset_rwsem held.
  */
 static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 {
@@ -447,7 +449,7 @@ static void guarantee_online_mems(struct cpuset *cs, nodemask_t *pmask)
 /*
  * update task's spread flag if cpuset's page/slab spread flag is set
  *
- * Call with callback_lock or cpuset_mutex held.
+ * Call with callback_lock or cpuset_rwsem held.
  */
 static void cpuset_update_task_spread_flag(struct cpuset *cs,
 					struct task_struct *tsk)
@@ -468,7 +470,7 @@ static void cpuset_update_task_spread_flag(struct cpuset *cs,
  *
  * One cpuset is a subset of another if all its allowed CPUs and
  * Memory Nodes are a subset of the other, and its exclusive flags
- * are only set if the other's are set.  Call holding cpuset_mutex.
+ * are only set if the other's are set.  Call holding cpuset_rwsem.
  */
 
 static int is_cpuset_subset(const struct cpuset *p, const struct cpuset *q)
@@ -577,7 +579,7 @@ static inline void free_cpuset(struct cpuset *cs)
  * If we replaced the flag and mask values of the current cpuset
  * (cur) with those values in the trial cpuset (trial), would
  * our various subset and exclusive rules still be valid?  Presumes
- * cpuset_mutex held.
+ * cpuset_rwsem held.
  *
  * 'cur' is the address of an actual, in-use cpuset.  Operations
  * such as list traversal that depend on the actual address of the
@@ -700,7 +702,7 @@ static void update_domain_attr_tree(struct sched_domain_attr *dattr,
 	rcu_read_unlock();
 }
 
-/* Must be called with cpuset_mutex held.  */
+/* Must be called with cpuset_rwsem held.  */
 static inline int nr_cpusets(void)
 {
 	/* jump label reference count + the top-level cpuset */
@@ -726,7 +728,7 @@ static inline int nr_cpusets(void)
  * domains when operating in the severe memory shortage situations
  * that could cause allocation failures below.
  *
- * Must be called with cpuset_mutex held.
+ * Must be called with cpuset_rwsem held.
  *
  * The three key local variables below are:
  *    cp - cpuset pointer, used (together with pos_css) to perform a
@@ -1005,7 +1007,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
  * 'cpus' is removed, then call this routine to rebuild the
  * scheduler's dynamic sched domains.
  *
- * Call with cpuset_mutex held.  Takes cpus_read_lock().
+ * Call with cpuset_rwsem held.  Takes cpus_read_lock().
  */
 static void rebuild_sched_domains_locked(void)
 {
@@ -1078,7 +1080,7 @@ void rebuild_sched_domains(void)
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
  *
  * Iterate through each task of @cs updating its cpus_allowed to the
- * effective cpuset's.  As this function is called with cpuset_mutex held,
+ * effective cpuset's.  As this function is called with cpuset_rwsem held,
  * cpuset membership stays stable.
  */
 static void update_tasks_cpumask(struct cpuset *cs)
@@ -1347,7 +1349,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
  *
  * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
  *
- * Called with cpuset_mutex held
+ * Called with cpuset_rwsem held
  */
 static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 {
@@ -1704,12 +1706,12 @@ static void *cpuset_being_rebound;
  * @cs: the cpuset in which each task's mems_allowed mask needs to be changed
  *
  * Iterate through each task of @cs updating its mems_allowed to the
- * effective cpuset's.  As this function is called with cpuset_mutex held,
+ * effective cpuset's.  As this function is called with cpuset_rwsem held,
  * cpuset membership stays stable.
  */
 static void update_tasks_nodemask(struct cpuset *cs)
 {
-	static nodemask_t newmems;	/* protected by cpuset_mutex */
+	static nodemask_t newmems;	/* protected by cpuset_rwsem */
 	struct css_task_iter it;
 	struct task_struct *task;
 
@@ -1722,7 +1724,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
 	 * take while holding tasklist_lock.  Forks can happen - the
 	 * mpol_dup() cpuset_being_rebound check will catch such forks,
 	 * and rebind their vma mempolicies too.  Because we still hold
-	 * the global cpuset_mutex, we know that no other rebind effort
+	 * the global cpuset_rwsem, we know that no other rebind effort
 	 * will be contending for the global variable cpuset_being_rebound.
 	 * It's ok if we rebind the same mm twice; mpol_rebind_mm()
 	 * is idempotent.  Also migrate pages in each mm to new nodes.
@@ -1768,7 +1770,7 @@ static void update_tasks_nodemask(struct cpuset *cs)
  *
  * On legacy hierarchy, effective_mems will be the same with mems_allowed.
  *
- * Called with cpuset_mutex held
+ * Called with cpuset_rwsem held
  */
 static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
 {
@@ -1821,7 +1823,7 @@ static void update_nodemasks_hier(struct cpuset *cs, nodemask_t *new_mems)
  * mempolicies and if the cpuset is marked 'memory_migrate',
  * migrate the tasks pages to the new memory.
  *
- * Call with cpuset_mutex held. May take callback_lock during call.
+ * Call with cpuset_rwsem held. May take callback_lock during call.
  * Will take tasklist_lock, scan tasklist for tasks in cpuset cs,
  * lock each such tasks mm->mmap_lock, scan its vma's and rebind
  * their mempolicies to the cpusets new mems_allowed.
@@ -1911,7 +1913,7 @@ static int update_relax_domain_level(struct cpuset *cs, s64 val)
  * @cs: the cpuset in which each task's spread flags needs to be changed
  *
  * Iterate through each task of @cs updating its spread flags.  As this
- * function is called with cpuset_mutex held, cpuset membership stays
+ * function is called with cpuset_rwsem held, cpuset membership stays
  * stable.
  */
 static void update_tasks_flags(struct cpuset *cs)
@@ -1931,7 +1933,7 @@ static void update_tasks_flags(struct cpuset *cs)
  * cs:		the cpuset to update
  * turning_on: 	whether the flag is being set or cleared
  *
- * Call with cpuset_mutex held.
+ * Call with cpuset_rwsem held.
  */
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
@@ -1980,7 +1982,7 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * cs: the cpuset to update
  * new_prs: new partition root state
  *
- * Call with cpuset_mutex held.
+ * Call with cpuset_rwsem held.
  */
 static int update_prstate(struct cpuset *cs, int new_prs)
 {
@@ -2167,7 +2169,7 @@ static int fmeter_getrate(struct fmeter *fmp)
 
 static struct cpuset *cpuset_attach_old_cs;
 
-/* Called by cgroups to determine if a cpuset is usable; cpuset_mutex held */
+/* Called by cgroups to determine if a cpuset is usable; cpuset_rwsem held */
 static int cpuset_can_attach(struct cgroup_taskset *tset)
 {
 	struct cgroup_subsys_state *css;
@@ -2219,7 +2221,7 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
 }
 
 /*
- * Protected by cpuset_mutex.  cpus_attach is used only by cpuset_attach()
+ * Protected by cpuset_rwsem.  cpus_attach is used only by cpuset_attach()
  * but we can't allocate it dynamically there.  Define it global and
  * allocate from cpuset_init().
  */
@@ -2227,7 +2229,7 @@ static cpumask_var_t cpus_attach;
 
 static void cpuset_attach(struct cgroup_taskset *tset)
 {
-	/* static buf protected by cpuset_mutex */
+	/* static buf protected by cpuset_rwsem */
 	static nodemask_t cpuset_attach_nodemask_to;
 	struct task_struct *task;
 	struct task_struct *leader;
@@ -2417,7 +2419,7 @@ static ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	 * operation like this one can lead to a deadlock through kernfs
 	 * active_ref protection.  Let's break the protection.  Losing the
 	 * protection is okay as we check whether @cs is online after
-	 * grabbing cpuset_mutex anyway.  This only happens on the legacy
+	 * grabbing cpuset_rwsem anyway.  This only happens on the legacy
 	 * hierarchies.
 	 */
 	css_get(&cs->css);
@@ -3672,7 +3674,7 @@ void __cpuset_memory_pressure_bump(void)
  *  - Used for /proc/<pid>/cpuset.
  *  - No need to task_lock(tsk) on this tsk->cpuset reference, as it
  *    doesn't really matter if tsk->cpuset changes after we read it,
- *    and we take cpuset_mutex, keeping cpuset_attach() from changing it
+ *    and we take cpuset_rwsem, keeping cpuset_attach() from changing it
  *    anyway.
  */
 int proc_cpuset_show(struct seq_file *m, struct pid_namespace *ns,
-- 
2.18.1

