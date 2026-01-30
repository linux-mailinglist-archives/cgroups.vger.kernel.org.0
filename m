Return-Path: <cgroups+bounces-13549-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IvqFhLSfGlbOwIAu9opvQ
	(envelope-from <cgroups+bounces-13549-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 16:45:22 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C6EBC2AE
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 16:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E216A305C48D
	for <lists+cgroups@lfdr.de>; Fri, 30 Jan 2026 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CAE339870;
	Fri, 30 Jan 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK7e4wPF"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA0D33A005
	for <cgroups@vger.kernel.org>; Fri, 30 Jan 2026 15:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787808; cv=none; b=tXclNd5uqCq82ddNmngVZx+gPPCYJWjGScsYLD2ZU7QZ2LtH59s+zXbl1m9TBvIyc8cFL2Z5XDroxGJdtxNEJegJNkH/Y5TtGnBniKrQgd6o+8/DYt4CSweWhcobEv0KXqhG+gSD/g/QcebpuG97/kwoTsXDA6UnfH3r0JFuJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787808; c=relaxed/simple;
	bh=T2oo+u+rYREFNiQ7OyCEZAINqInfJOANoSlf5zc78Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p34hGcmwvcujJcm4wDlh+wdJ1uAnCCuw9tu8UheEZYDsirLd+ZREIW8doFxuXDHe3OhnS6PQrUnGgmxRXbi4/eF3bYkzJScowoAJn6yUg/wx4IRDEDeByVPbwzEdp0an3t+YoppSC45VPBSMy1nAFnh8o5+Jd+9bnSVt6GAUpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TK7e4wPF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769787803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+Mmp0HEd0UoabcYz6w6wdEVNi9tGA66TJkg869sXNk=;
	b=TK7e4wPF9WC3ZhNjtG/5UnIZ/kNmAiq/f5TRIGmT03K7udIP5sDbgzGPGOx+tuoV62vbhc
	MDki0GZY9b1vQLp3tZ+Oirzr1y8WHa6NKvd5CEqDrQeQxHBPb072GTudehpZ51kN5hOTdD
	ZXGHmj1qY+DRJuv8epNkJuttL9QSCUk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-nnM8lOpzNaqgg4H5U5Y1ZA-1; Fri,
 30 Jan 2026 10:43:19 -0500
X-MC-Unique: nnM8lOpzNaqgg4H5U5Y1ZA-1
X-Mimecast-MFC-AGG-ID: nnM8lOpzNaqgg4H5U5Y1ZA_1769787797
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E98719560B3;
	Fri, 30 Jan 2026 15:43:16 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5772A1800995;
	Fri, 30 Jan 2026 15:43:13 +0000 (UTC)
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
Subject: [PATCH/for-next v2 2/2] cgroup/cpuset: Introduce a new top level cpuset_top_mutex
Date: Fri, 30 Jan 2026 10:42:54 -0500
Message-ID: <20260130154254.1422113-3-longman@redhat.com>
In-Reply-To: <20260130154254.1422113-1-longman@redhat.com>
References: <20260130154254.1422113-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13549-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5C6EBC2AE
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

One way to do that is to introduce a new top level cpuset_top_mutex
which will be acquired first.  This new cpuset_top_mutex will provide
the need mutual exclusion without the need to hold cpus_read_lock().

As cpus_read_lock() is now no longer held when
tmigr_isolated_exclude_cpumask() is called, it needs to acquire it
directly.

The lockdep_is_cpuset_held() is also updated to check the new
cpuset_top_mutex.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c        | 101 +++++++++++++++++++++++-----------
 kernel/sched/isolation.c      |   4 +-
 kernel/time/timer_migration.c |   3 +-
 3 files changed, 70 insertions(+), 38 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 0b0eb1df09d5..edccfa2df9da 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -78,13 +78,13 @@ static cpumask_var_t	subpartitions_cpus;
 static cpumask_var_t	isolated_cpus;
 
 /*
- * isolated_cpus updating flag (protected by cpuset_mutex)
+ * isolated_cpus updating flag (protected by cpuset_top_mutex)
  * Set if isolated_cpus is going to be updated in the current
  * cpuset_mutex crtical section.
  */
 static bool isolated_cpus_updating;
 
-/* Both cpuset_mutex and cpus_read_locked acquired */
+/* cpuset_top_mutex acquired */
 static bool cpuset_locked;
 
 /*
@@ -222,29 +222,44 @@ struct cpuset top_cpuset = {
 };
 
 /*
- * There are two global locks guarding cpuset structures - cpuset_mutex and
- * callback_lock. The cpuset code uses only cpuset_mutex. Other kernel
- * subsystems can use cpuset_lock()/cpuset_unlock() to prevent change to cpuset
- * structures. Note that cpuset_mutex needs to be a mutex as it is used in
- * paths that rely on priority inheritance (e.g. scheduler - on RT) for
- * correctness.
+ * CPUSET Locking Convention
+ * -------------------------
  *
- * A task must hold both locks to modify cpusets.  If a task holds
- * cpuset_mutex, it blocks others, ensuring that it is the only task able to
- * also acquire callback_lock and be able to modify cpusets.  It can perform
- * various checks on the cpuset structure first, knowing nothing will change.
- * It can also allocate memory while just holding cpuset_mutex.  While it is
- * performing these checks, various callback routines can briefly acquire
- * callback_lock to query cpusets.  Once it is ready to make the changes, it
- * takes callback_lock, blocking everyone else.
+ * Below are the four global locks guarding cpuset structures in lock
+ * acquisition order:
+ *  - cpuset_top_mutex
+ *  - cpu_hotplug_lock (cpus_read_lock/cpus_write_lock)
+ *  - cpuset_mutex
+ *  - callback_lock (raw spinlock)
  *
- * Calls to the kernel memory allocator can not be made while holding
- * callback_lock, as that would risk double tripping on callback_lock
- * from one of the callbacks into the cpuset code from within
- * __alloc_pages().
+ * The first cpuset_top_mutex will be held except when calling into
+ * cpuset_handle_hotplug() from the CPU hotplug code where cpus_write_lock
+ * and cpuset_mutex will be held instead.
  *
- * If a task is only holding callback_lock, then it has read-only
- * access to cpusets.
+ * As cpuset will now indirectly flush a number of different workqueues in
+ * housekeeping_update() when the set of isolated CPUs is going to be changed,
+ * it may not be safe from the circular locking perspective to hold the
+ * cpus_read_lock. So cpus_read_lock and cpuset_mutex will be released before
+ * calling housekeeping_update() and re-acquired afterward.
+ *
+ * A task must hold all the remaining three locks to modify externally visible
+ * or used fields of cpusets, though some of the internally used cpuset fields
+ * can be modified without holding callback_lock. If only reliable read access
+ * of the externally used fields are needed, a task can hold either
+ * cpuset_mutex or callback_lock which are exposed to other subsystems.
+ *
+ * If a task holds cpu_hotplug_lock and cpuset_mutex, it blocks others,
+ * ensuring that it is the only task able to also acquire callback_lock and
+ * be able to modify cpusets.  It can perform various checks on the cpuset
+ * structure first, knowing nothing will change. It can also allocate memory
+ * without holding callback_lock. While it is performing these checks, various
+ * callback routines can briefly acquire callback_lock to query cpusets.  Once
+ * it is ready to make the changes, it takes callback_lock, blocking everyone
+ * else.
+ *
+ * Calls to the kernel memory allocator cannot be made while holding
+ * callback_lock which is a spinlock, as the memory allocator may sleep or
+ * call back into cpuset code and acquire callback_lock.
  *
  * Now, the task_struct fields mems_allowed and mempolicy may be changed
  * by other task, we use alloc_lock in the task_struct fields to protect
@@ -255,6 +270,7 @@ struct cpuset top_cpuset = {
  * cpumasks and nodemasks.
  */
 
+static DEFINE_MUTEX(cpuset_top_mutex);
 static DEFINE_MUTEX(cpuset_mutex);
 
 /**
@@ -278,6 +294,18 @@ void lockdep_assert_cpuset_lock_held(void)
 	lockdep_assert_held(&cpuset_mutex);
 }
 
+static void cpuset_partial_lock(void)
+{
+	cpus_read_lock();
+	mutex_lock(&cpuset_mutex);
+}
+
+static void cpuset_partial_unlock(void)
+{
+	mutex_unlock(&cpuset_mutex);
+	cpus_read_unlock();
+}
+
 /**
  * cpuset_full_lock - Acquire full protection for cpuset modification
  *
@@ -286,22 +314,22 @@ void lockdep_assert_cpuset_lock_held(void)
  */
 void cpuset_full_lock(void)
 {
-	cpus_read_lock();
-	mutex_lock(&cpuset_mutex);
+	mutex_lock(&cpuset_top_mutex);
+	cpuset_partial_lock();
 	cpuset_locked = true;
 }
 
 void cpuset_full_unlock(void)
 {
 	cpuset_locked = false;
-	mutex_unlock(&cpuset_mutex);
-	cpus_read_unlock();
+	cpuset_partial_unlock();
+	mutex_unlock(&cpuset_top_mutex);
 }
 
 #ifdef CONFIG_LOCKDEP
 bool lockdep_is_cpuset_held(void)
 {
-	return lockdep_is_held(&cpuset_mutex);
+	return lockdep_is_held(&cpuset_top_mutex);
 }
 #endif
 
@@ -1292,12 +1320,12 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
 
 static void isolcpus_workfn(struct work_struct *work)
 {
-	cpuset_full_lock();
-	if (isolated_cpus_updating) {
-		WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
-		isolated_cpus_updating = false;
-	}
-	cpuset_full_unlock();
+	guard(mutex)(&cpuset_top_mutex);
+	if (!isolated_cpus_updating)
+		return;
+
+	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
+	isolated_cpus_updating = false;
 }
 
 /*
@@ -1331,8 +1359,15 @@ static void update_isolation_cpumasks(void)
 		return;
 	}
 
+	lockdep_assert_held(&cpuset_top_mutex);
+	/*
+	 * Release cpus_read_lock & cpuset_mutex before calling
+	 * housekeeping_update() and re-acquiring them afterward.
+	 */
+	cpuset_partial_unlock();
 	WARN_ON_ONCE(housekeeping_update(isolated_cpus) < 0);
 	isolated_cpus_updating = false;
+	cpuset_partial_lock();
 }
 
 /**
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


