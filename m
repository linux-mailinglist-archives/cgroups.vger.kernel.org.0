Return-Path: <cgroups+bounces-13611-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAhgGa4FgWkCDwMAu9opvQ
	(envelope-from <cgroups+bounces-13611-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:14:38 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D655CD0FD1
	for <lists+cgroups@lfdr.de>; Mon, 02 Feb 2026 21:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CC0530603FC
	for <lists+cgroups@lfdr.de>; Mon,  2 Feb 2026 20:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F519378D94;
	Mon,  2 Feb 2026 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LzOVR9Pc"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59475366DD2
	for <cgroups@vger.kernel.org>; Mon,  2 Feb 2026 20:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770063167; cv=none; b=SQy7WNh86Q2l8FjAKpEJBAndONOql2ZtCruda5qRbPTmSh5aCZ/1Bkww7nymlFZzV43VlLUDzczE/YRYQm/TGT+fpbagPLZiTrnMhSbg3DZz5mproB0PfUAfnRMSIjAG03MTp7SlCa3jJ2gECzS7B+eabFshJshsWXkFpOfwUdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770063167; c=relaxed/simple;
	bh=4J0nnXn3KVyKJkTTVpWrUd7pXOLMzeIvtJ5CK/5/vBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7aMB0KkSQsaUhdKMLN3Y69ub3LcjHn6Sst0iDqJhRB5r5Y4MHANWblWEoGPmh9IzEYBbLH9llmk4iK60niqUcy3drkuG/BUdvm3rW2CkWqpWTOqs6hrqp3SKrAd9vdDs5rlsqomJchk39BLQm2niEXCotIYjmZrnKNzG3MreYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LzOVR9Pc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770063164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmmN1NiOTP3GWsQ57pPx1chhGVQoHjV21SUcJpPPfxc=;
	b=LzOVR9PcJkPMws3bVCgHdCdfEwUEv2jds4TwtSheQBY125jLgCRJULKxtDYzahKFy64TQW
	0zAig8PCCtb/C++RNBDcn0o5Vc3LcN7oiBBjeGP0SmEEP6gbtxzgYjmWc0o545i05Rab9t
	tT9OMYptfTIY+sxht+RAu8kNzXHdX9c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-mEA_9K3MN2SMJjFKrXAV_A-1; Mon,
 02 Feb 2026 15:12:31 -0500
X-MC-Unique: mEA_9K3MN2SMJjFKrXAV_A-1
X-Mimecast-MFC-AGG-ID: mEA_9K3MN2SMJjFKrXAV_A_1770063149
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23DE519560A7;
	Mon,  2 Feb 2026 20:12:29 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 053F019560B4;
	Mon,  2 Feb 2026 20:12:25 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Chen Ridong <chenridong@huaweicloud.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH/for-next v3 3/3] cgroup/cpuset: Call housekeeping_update() without holding cpus_read_lock
Date: Mon,  2 Feb 2026 15:11:44 -0500
Message-ID: <20260202201144.1669260-4-longman@redhat.com>
In-Reply-To: <20260202201144.1669260-1-longman@redhat.com>
References: <20260202201144.1669260-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13611-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D655CD0FD1
X-Rspamd-Action: no action

The current cpuset partition code is able to dynamically update
the sched domains of a running system and the corresponding
HK_TYPE_DOMAIN housekeeping cpumask to perform what is essentally the
"isolcpus=domain,..." boot command line feature at run time.

The housekeeping cpumask update requires flushing a number of different
workqueues which may not be safe with cpus_read_lock() held as the
workqueue flushing code may acquire cpus_read_lock() or acquiring locks
which have locking dependency with cpus_read_lock() down the chain. Below
is an example of such circular locking problem.

  ======================================================
  WARNING: possible circular locking dependency detected
  6.18.0-test+ #2 Tainted: G S
  ------------------------------------------------------
  test_cpuset_prs/10971 is trying to acquire lock:
  ffff888112ba4958 ((wq_completion)sync_wq){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x7a/0x180

  but task is already holding lock:
  ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130

  which lock already depends on the new lock.

  the existing dependency chain (in reverse order) is:
  -> #4 (cpuset_mutex){+.+.}-{4:4}:
  -> #3 (cpu_hotplug_lock){++++}-{0:0}:
  -> #2 (rtnl_mutex){+.+.}-{4:4}:
  -> #1 ((work_completion)(&arg.work)){+.+.}-{0:0}:
  -> #0 ((wq_completion)sync_wq){+.+.}-{0:0}:

  Chain exists of:
    (wq_completion)sync_wq --> cpu_hotplug_lock --> cpuset_mutex

  5 locks held by test_cpuset_prs/10971:
   #0: ffff88816810e440 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0
   #1: ffff8891ab620890 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x260/0x5f0
   #2: ffff8890a78b83e8 (kn->active#187){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2b6/0x5f0
   #3: ffffffffadf32900 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_partition_write+0x77/0x130
   #4: ffffffffae47f450 (cpuset_mutex){+.+.}-{4:4}, at: cpuset_partition_write+0x85/0x130

  Call Trace:
   <TASK>
     :
   touch_wq_lockdep_map+0x93/0x180
   __flush_workqueue+0x111/0x10b0
   housekeeping_update+0x12d/0x2d0
   update_parent_effective_cpumask+0x595/0x2440
   update_prstate+0x89d/0xce0
   cpuset_partition_write+0xc5/0x130
   cgroup_file_write+0x1a5/0x680
   kernfs_fop_write_iter+0x3df/0x5f0
   vfs_write+0x525/0xfd0
   ksys_write+0xf9/0x1d0
   do_syscall_64+0x95/0x520
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

To avoid such a circular locking dependency problem, we have to
call housekeeping_update() without holding the cpus_read_lock() and
cpuset_mutex. The current set of wq's flushed by housekeeping_update()
may not have work functions that call cpus_read_lock() directly,
but we are likely to extend the list of wq's that are flushed in the
future. Moreover, the current set of work functions may hold locks that
may have cpu_hotplug_lock down the dependency chain.

One way to do that is to defer the housekeeping_update() call after
the current cpuset critical section has finished without holding
cpus_read_lock. For cpuset control file write, this can be done by
deferring it using task_work right before returning to userspace.

To enable mutual exclusion between the housekeeping_update() call and
other cpuset control file write actions, a new top level cpuset_top_mutex
is introduced. This new mutex will be acquired first to allow sharing
variables used by both code paths. However, cpuset update from CPU
hotplug can still happen in parallel with the housekeeping_update()
call, though that should be rare in production environment.

As cpus_read_lock() is now no longer held when
tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
directly.

The lockdep_is_cpuset_held() is also updated to check the new
cpuset_top_mutex.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c        | 103 +++++++++++++++++++++++++++-------
 kernel/sched/isolation.c      |   4 +-
 kernel/time/timer_migration.c |   3 +-
 3 files changed, 86 insertions(+), 24 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e98a2e953392..d2f51f40f87e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -65,14 +65,28 @@ static const char * const perr_strings[] = {
  * CPUSET Locking Convention
  * -------------------------
  *
- * Below are the three global locks guarding cpuset structures in lock
+ * Below are the four global/local locks guarding cpuset structures in lock
  * acquisition order:
+ *  - cpuset_top_mutex
  *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
  *  - cpuset_mutex
  *  - callback_lock (raw spinlock)
  *
- * A task must hold all the three locks to modify externally visible or
- * used fields of cpusets, though some of the internally used cpuset fields
+ * As cpuset will now indirectly flush a number of different workqueues in
+ * housekeeping_update() to update housekeeping cpumasks when the set of
+ * isolated CPUs is going to be changed, it may be vulnerable to deadlock
+ * if we hold cpus_read_lock while calling into housekeeping_update().
+ *
+ * The first cpuset_top_mutex will be held except when calling into
+ * cpuset_handle_hotplug() from the CPU hotplug code where cpus_write_lock
+ * and cpuset_mutex will be held instead. The main purpose of this mutex
+ * is to prevent regular cpuset control file write actions from interfering
+ * with the call to housekeeping_update(), though CPU hotplug operation can
+ * still happen in parallel. This mutex also provides protection for some
+ * internal variables.
+ *
+ * A task must hold all the remaining three locks to modify externally visible
+ * or used fields of cpusets, though some of the internally used cpuset fields
  * and internal variables can be modified without holding callback_lock. If only
  * reliable read access of the externally used fields are needed, a task can
  * hold either cpuset_mutex or callback_lock which are exposed to other
@@ -100,6 +114,7 @@ static const char * const perr_strings[] = {
  * cpumasks and nodemasks.
  */
 
+static DEFINE_MUTEX(cpuset_top_mutex);
 static DEFINE_MUTEX(cpuset_mutex);
 
 /*
@@ -111,6 +126,8 @@ static DEFINE_MUTEX(cpuset_mutex);
  *
  * CSCB: Readable by holding either cpuset_mutex or callback_lock. Writable
  *	 by holding both cpuset_mutex and callback_lock.
+ *
+ * T:	 Read/write-able by holding the cpuset_top_mutex.
  */
 
 /*
@@ -135,6 +152,13 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
  */
 static bool		isolated_cpus_updating;	/* RWCS */
 
+/*
+ * Copy of isolated_cpus to be processed by housekeeping_update()
+ */
+static cpumask_var_t	isolated_hk_cpus;	/* T */
+static bool		isolcpus_twork_queued;	/* T */
+
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -298,6 +322,7 @@ void lockdep_assert_cpuset_lock_held(void)
  */
 void cpuset_full_lock(void)
 {
+	mutex_lock(&cpuset_top_mutex);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 }
@@ -306,12 +331,13 @@ void cpuset_full_unlock(void)
 {
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
+	mutex_unlock(&cpuset_top_mutex);
 }
 
 #ifdef CONFIG_LOCKDEP
 bool lockdep_is_cpuset_held(void)
 {
-	return lockdep_is_held(&cpuset_mutex);
+	return lockdep_is_held(&cpuset_top_mutex);
 }
 #endif
 
@@ -1302,15 +1328,38 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
-static void isolcpus_workfn(struct work_struct *work)
+/*
+ * housekeeping_update() will only be called if isolated_cpus differs
+ * from isolated_hk_cpus. To be safe, rebuild_sched_domains() will always
+ * be called just in case there are still pending sched domains changes.
+ */
+static void do_housekeeping_update(bool *flag)
 {
-	cpuset_full_lock();
-	if (isolated_cpus_updating) {
-		isolated_cpus_updating = false;
-		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
-		rebuild_sched_domains_locked();
+	bool update_hk = true;
+
+	guard(mutex)(&cpuset_top_mutex);
+	if (flag)
+		*flag = false;
+	scoped_guard(spinlock_irq, &callback_lock) {
+		if (cpumask_equal(isolated_hk_cpus, isolated_cpus))
+			update_hk = false;
+		else
+			cpumask_copy(isolated_hk_cpus, isolated_cpus);
 	}
-	cpuset_full_unlock();
+	if (update_hk)
+		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus) < 0);
+	rebuild_sched_domains();
+}
+
+static void isolcpus_workfn(struct work_struct *work)
+{
+	do_housekeeping_update(NULL);
+}
+
+static void isolcpus_tworkfn(struct callback_head *cb)
+{
+	/* Clear isolcpus_twork_queued */
+	do_housekeeping_update(&isolcpus_twork_queued);
 }
 
 /*
@@ -1322,9 +1371,15 @@ static void isolcpus_workfn(struct work_struct *work)
 static void update_isolation_cpumasks(void)
 {
 	static DECLARE_WORK(isolcpus_work, isolcpus_workfn);
+	static struct callback_head twork_cb;
 
 	if (!isolated_cpus_updating)
 		return;
+	else
+		isolated_cpus_updating = false;
+
+	/* Also defer sched domains regeneration to the wq or task_work */
+	force_sd_rebuild = false;
 
 	/*
 	 * This function can be reached either directly from regular cpuset
@@ -1332,10 +1387,10 @@ static void update_isolation_cpumasks(void)
 	 * the per-cpu kthread that calls cpuset_handle_hotplug() on behalf
 	 * of the task that initiates CPU shutdown or bringup.
 	 *
-	 * To have better flexibility and prevent the possibility of deadlock
-	 * when calling from CPU hotplug, we defer the housekeeping_update()
-	 * call to after the current cpuset critical section has finished.
-	 * This is done via workqueue.
+	 * To have better flexibility and prevent the possibility of deadlock,
+	 * we defer the housekeeping_update() call to after the current
+	 * cpuset critical section has finished. This is done via task_work
+	 * for cpuset control file write and workqueue for CPU hotplug.
 	 */
 	if (current->flags & PF_KTHREAD) {
 		/*
@@ -1343,13 +1398,22 @@ static void update_isolation_cpumasks(void)
 		 * item that is still pending.
 		 */
 		queue_work(system_unbound_wq, &isolcpus_work);
-		/* Also defer sched domains regeneration to the work function */
-		force_sd_rebuild = false;
 		return;
 	}
 
-	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
-	isolated_cpus_updating = false;
+	/*
+	 * update_isolation_cpumasks() may be called more than once in the
+	 * same cpuset_mutex critical section.
+	 */
+	lockdep_assert_held(&cpuset_top_mutex);
+	if (isolcpus_twork_queued)
+		return;
+
+	init_task_work(&twork_cb, isolcpus_tworkfn);
+	if (!task_work_add(current, &twork_cb, TWA_RESUME))
+		isolcpus_twork_queued = true;
+	else
+		WARN_ON_ONCE(1);	/* Current task shouldn't be exiting */
 }
 
 /**
@@ -3657,6 +3721,7 @@ int __init cpuset_init(void)
 	BUG_ON(!alloc_cpumask_var(&top_cpuset.exclusive_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&subpartitions_cpus, GFP_KERNEL));
 	BUG_ON(!zalloc_cpumask_var(&isolated_cpus, GFP_KERNEL));
+	BUG_ON(!zalloc_cpumask_var(&isolated_hk_cpus, GFP_KERNEL));
 
 	cpumask_setall(top_cpuset.cpus_allowed);
 	nodes_setall(top_cpuset.mems_allowed);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 3b725d39c06e..ef152d401fe2 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -123,8 +123,6 @@ int housekeeping_update(struct cpumask *isol_mask)
 	struct cpumask *trial, *old = NULL;
 	int err;
 
-	lockdep_assert_cpus_held();
-
 	trial = kmalloc(cpumask_size(), GFP_KERNEL);
 	if (!trial)
 		return -ENOMEM;
@@ -136,7 +134,7 @@ int housekeeping_update(struct cpumask *isol_mask)
 	}
 
 	if (!housekeeping.flags)
-		static_branch_enable_cpuslocked(&housekeeping_overridden);
+		static_branch_enable(&housekeeping_overridden);
 
 	if (housekeeping.flags & HK_FLAG_DOMAIN)
 		old = housekeeping_cpumask_dereference(HK_TYPE_DOMAIN);
diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 6da9cd562b20..244a8d025e78 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1559,8 +1559,6 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
 	cpumask_var_t cpumask __free(free_cpumask_var) = CPUMASK_VAR_NULL;
 	int cpu;
 
-	lockdep_assert_cpus_held();
-
 	if (!works)
 		return -ENOMEM;
 	if (!alloc_cpumask_var(&cpumask, GFP_KERNEL))
@@ -1570,6 +1568,7 @@ int tmigr_isolated_exclude_cpumask(struct cpumask *exclude_cpumask)
 	 * First set previously isolated CPUs as available (unisolate).
 	 * This cpumask contains only CPUs that switched to available now.
 	 */
+	guard(cpus_read_lock)();
 	cpumask_andnot(cpumask, cpu_online_mask, exclude_cpumask);
 	cpumask_andnot(cpumask, cpumask, tmigr_available_cpumask);
 
-- 
2.52.0


