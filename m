Return-Path: <cgroups+bounces-14098-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMusNtn/mWliXwMAu9opvQ
	(envelope-from <cgroups+bounces-14098-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:25 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 108A716D9AF
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 19:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5686C3027591
	for <lists+cgroups@lfdr.de>; Sat, 21 Feb 2026 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420453176E0;
	Sat, 21 Feb 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="grj9Qp0R"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D203148BF
	for <cgroups@vger.kernel.org>; Sat, 21 Feb 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771700129; cv=none; b=N9XUyvqMneUdw2Aexvb4uaNN9jDzohsnVrPJysqsaI9o//yYeqpBWQ4yMa5y4Ng7KDHq9MuR0aXROlCkPXwuVEKW7SR215E1pJC3e78obDzlTmajeJ4et6UPQplMOOYCITLz1PeGb090v6xgVMSl+R1w5lOl+hsCnw06ABU5YIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771700129; c=relaxed/simple;
	bh=sCsHRcyKcERjUNKeUpJE7elYWPVKzxonGlxyHXoVLTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVBcS1hvHsWV/wS/ChHcNrSOwy3Dsk4Y0cIjLMiiXRbkOhrcRXYSq8/SMkBRr+0BkIZcqIfiClxSq9RtS2g73BbbzlawdQj0gZ2vcHe+PYbp1vPGKHe7hIsSdp0uTeKNBDBiSBMtpHQwXS8wR+T+WO1qKSNGYT0dO69aOtaVfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=grj9Qp0R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771700126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4vR+Shf01bTPXjClL10ebMyrEpjUBxnF56CNK7mE1M=;
	b=grj9Qp0R/3yQdsydDM5IVetZZRp4HuX5uamvYNh9OTomwh7MWusOmacTFeeCDwpZHUCDuO
	aK8HPsL334u9PLUf3CazDPvITUFHjZnshOokEAOVBD/WjIcYjezTwVHNAaqyyxu7Fqhqsn
	uxjCSk1Tuy5guSqfC3WGFQlvCkIUaZ0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-9Of_0gChN2a-XvmWHzG-ig-1; Sat,
 21 Feb 2026 13:55:23 -0500
X-MC-Unique: 9Of_0gChN2a-XvmWHzG-ig-1
X-Mimecast-MFC-AGG-ID: 9Of_0gChN2a-XvmWHzG-ig_1771700121
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EFCB31956088;
	Sat, 21 Feb 2026 18:55:20 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FE18195419E;
	Sat, 21 Feb 2026 18:55:16 +0000 (UTC)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v6 8/8] cgroup/cpuset: Call housekeeping_update() without holding cpus_read_lock
Date: Sat, 21 Feb 2026 13:54:18 -0500
Message-ID: <20260221185418.29319-9-longman@redhat.com>
In-Reply-To: <20260221185418.29319-1-longman@redhat.com>
References: <20260221185418.29319-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14098-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longman@redhat.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 108A716D9AF
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

So housekeeping_update() is now called after releasing cpus_read_lock
and cpuset_mutex at the end of a cpuset operation. These two locks are
then re-acquired later beforce calling rebuild_sched_domains_locked().

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

Fixes: 03ff73510169 ("cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c        | 47 +++++++++++++++++++++++++++++++----
 kernel/sched/isolation.c      |  4 +--
 kernel/time/timer_migration.c |  4 +--
 3 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2c80bfc30bbc..dbda09391b19 100644
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
@@ -134,6 +151,11 @@ static cpumask_var_t	isolated_cpus;		/* CSCB */
  */
 static bool		update_housekeeping;	/* RWCS */
 
+/*
+ * Copy of isolated_cpus to be passed to housekeeping_update()
+ */
+static cpumask_var_t	isolated_hk_cpus;	/* T */
+
 /*
  * A flag to force sched domain rebuild at the end of an operation.
  * It can be set in
@@ -297,6 +319,7 @@ void lockdep_assert_cpuset_lock_held(void)
  */
 void cpuset_full_lock(void)
 {
+	mutex_lock(&cpuset_top_mutex);
 	cpus_read_lock();
 	mutex_lock(&cpuset_mutex);
 }
@@ -305,12 +328,14 @@ void cpuset_full_unlock(void)
 {
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
 
@@ -1314,9 +1339,20 @@ static void update_hk_sched_domains(void)
 {
 	if (update_housekeeping) {
 		/* Updating HK cpumasks implies rebuild sched domains */
-		WARN_ON_ONCE(housekeeping_update(isolated_cpus));
 		update_housekeeping = false;
 		force_sd_rebuild = true;
+		cpumask_copy(isolated_hk_cpus, isolated_cpus);
+
+		/*
+		 * housekeeping_update() is now called without holding
+		 * cpus_read_lock and cpuset_mutex. Only top_cpuset_mutex
+		 * is still being held for mutual exclusion.
+		 */
+		mutex_unlock(&cpuset_mutex);
+		cpus_read_unlock();
+		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
+		cpus_read_lock();
+		mutex_lock(&cpuset_mutex);
 	}
 	/* force_sd_rebuild will be cleared in rebuild_sched_domains_locked() */
 	if (force_sd_rebuild)
@@ -3634,6 +3670,7 @@ int __init cpuset_init(void)
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
2.53.0


