Return-Path: <cgroups+bounces-13903-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +E/NA30FjmnO+gAAu9opvQ
	(envelope-from <cgroups+bounces-13903-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:53:17 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B46012FAC0
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 17:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0906931CEC2C
	for <lists+cgroups@lfdr.de>; Thu, 12 Feb 2026 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF7835E542;
	Thu, 12 Feb 2026 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aslKwIxj"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBCC2E645
	for <cgroups@vger.kernel.org>; Thu, 12 Feb 2026 16:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770914907; cv=none; b=JU+avrqXoV/LsFAcY8yb5vmZ3BzpmGt4ozlikV0zxgzfFkSX8LpGwXP37SmXemivFzP3K9wcmyYC3dj5sj9OClZkD0OUKBiSX5XssiVXycvmMtZABx0ArjMQji0TkIGP0bniPeS34Jioob1iU4WSKmhzMotcHnodcus0P2wSYfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770914907; c=relaxed/simple;
	bh=ocb4h7PxpCgLT8ddw7hxNLABaVPwyeBIxIlw7jEpoDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qA9zxIlCt3bD2n0xgwiB40QsTEOqDw6kmYUVYGh7x7AHcOhD28gDUNkkv77du3ySYyBcnIneTHktLA9VXdq/jL/8XrG/xLHmsOsHigmsXU6v9Nd1B4XbVrl9EipJDv9rc1jeK8dozCA3PSEwK5OoIuDQ07f+LAWj7N+A3LtoQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aslKwIxj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770914905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujXsVtZkdbe11x4mi/cE86wUSR+HJS2RKadyX3nfR/4=;
	b=aslKwIxjkn4zRtO6Xb0i+KG2npCHv7GdFsTBv/22zgrGI2TCcUY7w0FotRvFDv3S+KvInC
	kjhGKYjEjX76ca/rW5bS2z/jWSy15x7uRDJ/Rf1dJjgSH4ZvFGsqYZOZzVVtCvfbSt0btd
	A339tp4SLlQZylVuS7IMyAXsLItc3BM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-kWDOf_l4N1mV7KKkJhMkVA-1; Thu,
 12 Feb 2026 11:48:20 -0500
X-MC-Unique: kWDOf_l4N1mV7KKkJhMkVA-1
X-Mimecast-MFC-AGG-ID: kWDOf_l4N1mV7KKkJhMkVA_1770914898
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84F90180061C;
	Thu, 12 Feb 2026 16:48:18 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.194])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6D2181800465;
	Thu, 12 Feb 2026 16:48:13 +0000 (UTC)
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
Subject: [PATCH v5 5/6] cgroup/cpuset: Call housekeeping_update() without holding cpus_read_lock
Date: Thu, 12 Feb 2026 11:46:39 -0500
Message-ID: <20260212164640.2408295-6-longman@redhat.com>
In-Reply-To: <20260212164640.2408295-1-longman@redhat.com>
References: <20260212164640.2408295-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13903-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B46012FAC0
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

The lockdep_is_cpuset_held() is also updated to return true if either
cpuset_top_mutex or cpuset_mutex is held.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c        | 99 ++++++++++++++++++++++++++++++++---
 kernel/sched/isolation.c      |  4 +-
 kernel/time/timer_migration.c |  4 +-
 3 files changed, 93 insertions(+), 14 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 48b7f275085b..c6a97956a991 100644
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
@@ -135,6 +152,18 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
  */
 static bool		isolated_cpus_updating;	/* RWCS */
 
+/*
+ * Copy of isolated_cpus to be passed to housekeeping_update()
+ */
+static cpumask_var_t	isolated_hk_cpus;	/* T */
+
+/*
+ * Flag to prevent queuing more than one task_work to the same cpuset_top_mutex
+ * critical section.
+ */
+static bool		isolcpus_twork_queued;	/* T */
+
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -301,20 +330,24 @@ void lockdep_assert_cpuset_lock_held(void)
  */
 void cpuset_full_lock(void)
 {
+	mutex_lock(&cpuset_top_mutex);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 }
 
 void cpuset_full_unlock(void)
 {
+	isolcpus_twork_queued = false;
 	mutex_unlock(&cpuset_mutex);
 	cpus_read_unlock();
+	mutex_unlock(&cpuset_top_mutex);
 }
 
 #ifdef CONFIG_LOCKDEP
 bool lockdep_is_cpuset_held(void)
 {
-	return lockdep_is_held(&cpuset_mutex);
+	return lockdep_is_held(&cpuset_mutex) ||
+	       lockdep_is_held(&cpuset_top_mutex);
 }
 #endif
 
@@ -1338,6 +1371,28 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 	return false;
 }
 
+/*
+ * housekeeping_update() will only be called if isolated_cpus differs
+ * from isolated_hk_cpus. To be safe, rebuild_sched_domains() will always
+ * be called just in case there are still pending sched domains changes.
+ */
+static void isolcpus_tworkfn(struct callback_head *cb)
+{
+	bool update_hk = true;
+
+	guard(mutex)(&cpuset_top_mutex);
+	scoped_guard(spinlock_irq, &callback_lock) {
+		if (cpumask_equal(isolated_hk_cpus, isolated_cpus))
+			update_hk = false;
+		else
+			cpumask_copy(isolated_hk_cpus, isolated_cpus);
+	}
+	if (update_hk)
+		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus) < 0);
+	rebuild_sched_domains();
+	kfree(cb);
+}
+
 /*
  * update_isolation_cpumasks - Update external isolation related CPU masks
  *
@@ -1346,15 +1401,42 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
  */
 static void update_isolation_cpumasks(void)
 {
-	int ret;
+	struct callback_head *twork_cb;
 
 	if (!isolated_cpus_updating)
 		return;
+	else
+		isolated_cpus_updating = false;
+
+	/*
+	 * CPU hotplug shouldn't set isolated_cpus_updating.
+	 *
+	 * To have better flexibility and prevent the possibility of deadlock,
+	 * we defer the housekeeping_update() call to after the current cpuset
+	 * critical section has finished. This is done via the synchronous
+	 * task_work which will be executed right before returning to userspace.
+	 *
+	 * update_isolation_cpumasks() may be called more than once in the
+	 * same cpuset_mutex critical section.
+	 */
+	lockdep_assert_held(&cpuset_top_mutex);
+	if (isolcpus_twork_queued)
+		return;
 
-	ret = housekeeping_update(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
+	twork_cb = kzalloc(sizeof(struct callback_head), GFP_KERNEL);
+	if (!twork_cb)
+		return;
 
-	isolated_cpus_updating = false;
+	/*
+	 * isolcpus_tworkfn() will be invoked before returning to userspace
+	 */
+	init_task_work(twork_cb, isolcpus_tworkfn);
+	if (task_work_add(current, twork_cb, TWA_RESUME)) {
+		kfree(twork_cb);
+		WARN_ON_ONCE(1);	/* Current task shouldn't be exiting */
+	} else {
+		isolcpus_twork_queued = true;
+	}
 }
 
 /**
@@ -3689,6 +3771,7 @@ int __init cpuset_init(void)
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
index 6da9cd562b20..83428aa03aef 100644
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
 
@@ -1626,7 +1625,6 @@ static int __init tmigr_init_isolation(void)
 	cpumask_andnot(cpumask, cpu_possible_mask, housekeeping_cpumask(HK_TYPE_DOMAIN));
 
 	/* Protect against RCU torture hotplug testing */
-	guard(cpus_read_lock)();
 	return tmigr_isolated_exclude_cpumask(cpumask);
 }
 late_initcall(tmigr_init_isolation);
-- 
2.52.0


