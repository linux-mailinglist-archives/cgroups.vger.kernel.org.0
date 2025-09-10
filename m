Return-Path: <cgroups+bounces-9960-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90138B51F5A
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 19:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC78165254
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 17:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDA926E158;
	Wed, 10 Sep 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JjkHKO99"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C8C22FDEC;
	Wed, 10 Sep 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526459; cv=none; b=iHxt3rgq30Eai3rLo4IYkTr+ur3iUTi0x9t684mpLAvP30XiLqCSuTTmMmdaQOZ7fizcMgkOD6JMvkbGMBga35KuifZYY0kDv7qQUza8Q5kFCJjMZj2kaAQqrMS7nzX5QTYLpa+HEMo1aTAm8BiRsqRP6FlD0rDl8RDpstc7zRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526459; c=relaxed/simple;
	bh=eD2GJiQnhOSkLcei/zAvfev2NgI3FG/r3t1bYFETfXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiLAyLRxEdRk8lVPjY94eNKGULLXYc8ijlm8rx/8BtjrdEE5ZSO3INI9SocJMj8B1qDPPuYPAUzcHjLzQMVzMAHpwadUMeJR90X1vkcEI/oL9ClHQ2NDZm7K06AWds44ILXZGXwV4tLAyAB+7JmhdNRw527xEr9vHR836HAyw7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JjkHKO99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B10C4CEEB;
	Wed, 10 Sep 2025 17:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757526459;
	bh=eD2GJiQnhOSkLcei/zAvfev2NgI3FG/r3t1bYFETfXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JjkHKO99fsZ9SBh1vo+eD8ifISpj9+19oG9jN1SDiOso0eEoqM/jV2b3iKFnSZRp8
	 btfrbxHbQvjriG6IzZXhO7IFxtSiGaZtm7QDjYDatDvCIUxfCdpIEruM+rdcN0HLuh
	 yPXEdXPuiFIollrSsdwTeyj8Qiast52QdQsQJK8v6C1xoasXMJPtkNNf4BqLMALSt/
	 GaSbcgSI0ZXL0g8humFic7MIN1YG8zGs4p+gN8kZ9MqTNVFX/GS131f5ZBcWjNkmac
	 tVlHJpcRi0is4cOeWcEpG9TizXQDaJGPVbeVJGsjSlpm2le8YzIfDwb4KzEXsvYYDb
	 6X5zNYER7Vd3w==
Date: Wed, 10 Sep 2025 07:47:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Yi Tao <escape@linux.alibaba.com>
Cc: hannes@cmpxchg.org, mkoutny@suse.com, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] cgroup: replace global percpu_rwsem with per
 threadgroup resem when writing to cgroup.procs
Message-ID: <aMG5ucVGwlVLl4a_@slm.duckdns.org>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757486368.git.escape@linux.alibaba.com>
 <9d46438e61bcf7b5ffc9eb582081f4fcc99c2cbf.1757486368.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d46438e61bcf7b5ffc9eb582081f4fcc99c2cbf.1757486368.git.escape@linux.alibaba.com>

Applied to cgroup/for-6.18 with a comment update and
s/WARN_ONCE()/pr_warn_once()/ as the backtrace isn't likely helpful here.
The applied version follows:

------ 8< ------
From 0568f89d4fb82d98001baeb870e92f43cd1f7317 Mon Sep 17 00:00:00 2001
From: Yi Tao <escape@linux.alibaba.com>
Date: Wed, 10 Sep 2025 14:59:35 +0800
Subject: [PATCH] cgroup: replace global percpu_rwsem with per threadgroup
 resem when writing to cgroup.procs

The static usage pattern of creating a cgroup, enabling controllers,
and then seeding it with CLONE_INTO_CGROUP doesn't require write
locking cgroup_threadgroup_rwsem and thus doesn't benefit from this
patch.

To avoid affecting other users, the per threadgroup rwsem is only used
when the favordynmods is enabled.

As computer hardware advances, modern systems are typically equipped
with many CPU cores and large amounts of memory, enabling the deployment
of numerous applications. On such systems, container creation and
deletion become frequent operations, making cgroup process migration no
longer a cold path. This leads to noticeable contention with common
process operations such as fork, exec, and exit.

To alleviate the contention between cgroup process migration and
operations like process fork, this patch modifies lock to take the write
lock on signal_struct->group_rwsem when writing pid to
cgroup.procs/threads instead of holding a global write lock.

Cgroup process migration has historically relied on
signal_struct->group_rwsem to protect thread group integrity. In commit
<1ed1328792ff> ("sched, cgroup: replace signal_struct->group_rwsem with
a global percpu_rwsem"), this was changed to a global
cgroup_threadgroup_rwsem. The advantage of using a global lock was
simplified handling of process group migrations. This patch retains the
use of the global lock for protecting process group migration, while
reducing contention by using per thread group lock during
cgroup.procs/threads writes.

The locking behavior is as follows:

write cgroup.procs/threads  | process fork,exec,exit | process group migration
------------------------------------------------------------------------------
cgroup_lock()               | down_read(&g_rwsem)    | cgroup_lock()
down_write(&p_rwsem)        | down_read(&p_rwsem)    | down_write(&g_rwsem)
critical section            | critical section       | critical section
up_write(&p_rwsem)          | up_read(&p_rwsem)      | up_write(&g_rwsem)
cgroup_unlock()             | up_read(&g_rwsem)      | cgroup_unlock()

g_rwsem denotes cgroup_threadgroup_rwsem, p_rwsem denotes
signal_struct->group_rwsem.

This patch eliminates contention between cgroup migration and fork
operations for threads that belong to different thread groups, thereby
reducing the long-tail latency of cgroup migrations and lowering system
load.

With this patch, under heavy fork and exec interference, the long-tail
latency of cgroup migration has been reduced from milliseconds to
microseconds. Under heavy cgroup migration interference, the multi-CPU
score of the spawn test case in UnixBench increased by 9%.

tj: Update comment in cgroup_favor_dynmods() and switch WARN_ONCE() to
    pr_warn_once().

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup-defs.h     | 17 +++++++-
 include/linux/sched/signal.h    |  4 ++
 init/init_task.c                |  3 ++
 kernel/cgroup/cgroup-internal.h |  6 ++-
 kernel/cgroup/cgroup-v1.c       |  8 ++--
 kernel/cgroup/cgroup.c          | 73 ++++++++++++++++++++++++++-------
 kernel/fork.c                   |  4 ++
 7 files changed, 93 insertions(+), 22 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index ff3c7d0e3e01..93318fce31f3 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -91,6 +91,12 @@ enum {
 	 * cgroup_threadgroup_rwsem. This makes hot path operations such as
 	 * forks and exits into the slow path and more expensive.
 	 *
+	 * Alleviate the contention between fork, exec, exit operations and
+	 * writing to cgroup.procs by taking a per threadgroup rwsem instead of
+	 * the global cgroup_threadgroup_rwsem. Fork and other operations
+	 * from threads in different thread groups no longer contend with
+	 * writing to cgroup.procs.
+	 *
 	 * The static usage pattern of creating a cgroup, enabling controllers,
 	 * and then seeding it with CLONE_INTO_CGROUP doesn't require write
 	 * locking cgroup_threadgroup_rwsem and thus doesn't benefit from
@@ -146,6 +152,9 @@ enum cgroup_attach_lock_mode {
 
 	/* When pid=0 && threadgroup=false, see comments in cgroup_procs_write_start */
 	CGRP_ATTACH_LOCK_NONE,
+
+	/* When favordynmods is on, see comments above CGRP_ROOT_FAVOR_DYNMODS */
+	CGRP_ATTACH_LOCK_PER_THREADGROUP,
 };
 
 /*
@@ -846,6 +855,7 @@ struct cgroup_subsys {
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
+extern bool cgroup_enable_per_threadgroup_rwsem;
 
 struct cgroup_of_peak {
 	unsigned long		value;
@@ -857,11 +867,14 @@ struct cgroup_of_peak {
  * @tsk: target task
  *
  * Allows cgroup operations to synchronize against threadgroup changes
- * using a percpu_rw_semaphore.
+ * using a global percpu_rw_semaphore and a per threadgroup rw_semaphore when
+ * favordynmods is on. See the comment above CGRP_ROOT_FAVOR_DYNMODS definition.
  */
 static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
 {
 	percpu_down_read(&cgroup_threadgroup_rwsem);
+	if (cgroup_enable_per_threadgroup_rwsem)
+		down_read(&tsk->signal->cgroup_threadgroup_rwsem);
 }
 
 /**
@@ -872,6 +885,8 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
  */
 static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
 {
+	if (cgroup_enable_per_threadgroup_rwsem)
+		up_read(&tsk->signal->cgroup_threadgroup_rwsem);
 	percpu_up_read(&cgroup_threadgroup_rwsem);
 }
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1ef1edbaaf79..7d6449982822 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -226,6 +226,10 @@ struct signal_struct {
 	struct tty_audit_buf *tty_audit_buf;
 #endif
 
+#ifdef CONFIG_CGROUPS
+	struct rw_semaphore cgroup_threadgroup_rwsem;
+#endif
+
 	/*
 	 * Thread is the potential origin of an oom condition; kill first on
 	 * oom
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..a55e2189206f 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -27,6 +27,9 @@ static struct signal_struct init_signals = {
 	},
 	.multiprocess	= HLIST_HEAD_INIT,
 	.rlim		= INIT_RLIMITS,
+#ifdef CONFIG_CGROUPS
+	.cgroup_threadgroup_rwsem	= __RWSEM_INITIALIZER(init_signals.cgroup_threadgroup_rwsem),
+#endif
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index a6d6f30b6f65..22051b4f1ccb 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -249,8 +249,10 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
-void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode);
-void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode);
+void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode,
+			struct task_struct *tsk);
+void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode,
+			  struct task_struct *tsk);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     enum cgroup_attach_lock_mode *lock_mode)
 	__acquires(&cgroup_threadgroup_rwsem);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 852ebe7ca3a1..a9e029b570c8 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -69,7 +69,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	cgroup_lock();
-	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -81,7 +81,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	cgroup_unlock();
 
 	return retval;
@@ -118,7 +118,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -154,7 +154,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	cgroup_unlock();
 	return ret;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a6b81b48bb70..fed701df1167 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -239,6 +239,14 @@ static u16 have_canfork_callback __read_mostly;
 
 static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
 
+/*
+ * Write protected by cgroup_mutex and write-lock of cgroup_threadgroup_rwsem,
+ * read protected by either.
+ *
+ * Can only be turned on, but not turned off.
+ */
+bool cgroup_enable_per_threadgroup_rwsem __read_mostly;
+
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
 	.ns.count	= REFCOUNT_INIT(2),
@@ -1325,14 +1333,30 @@ void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
 {
 	bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
 
-	/* see the comment above CGRP_ROOT_FAVOR_DYNMODS definition */
+	/*
+	 * see the comment above CGRP_ROOT_FAVOR_DYNMODS definition.
+	 * favordynmods can flip while task is between
+	 * cgroup_threadgroup_change_begin() and end(), so down_write global
+	 * cgroup_threadgroup_rwsem to synchronize them.
+	 *
+	 * Once cgroup_enable_per_threadgroup_rwsem is enabled, holding
+	 * cgroup_threadgroup_rwsem doesn't exlude tasks between
+	 * cgroup_thread_group_change_begin() and end() and thus it's unsafe to
+	 * turn off. As the scenario is unlikely, simply disallow disabling once
+	 * enabled and print out a warning.
+	 */
+	percpu_down_write(&cgroup_threadgroup_rwsem);
 	if (favor && !favoring) {
+		cgroup_enable_per_threadgroup_rwsem = true;
 		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
 		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
 	} else if (!favor && favoring) {
+		if (cgroup_enable_per_threadgroup_rwsem)
+			pr_warn_once("cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled\n");
 		rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
 		root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
 	}
+	percpu_up_write(&cgroup_threadgroup_rwsem);
 }
 
 static int cgroup_init_root_id(struct cgroup_root *root)
@@ -2482,7 +2506,8 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
 /**
  * cgroup_attach_lock - Lock for ->attach()
- * @lock_mode: whether to down_write cgroup_threadgroup_rwsem
+ * @lock_mode: whether acquire and acquire which rwsem
+ * @tsk: thread group to lock
  *
  * cgroup migration sometimes needs to stabilize threadgroups against forks and
  * exits by write-locking cgroup_threadgroup_rwsem. However, some ->attach()
@@ -2502,8 +2527,15 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
  * Resolve the situation by always acquiring cpus_read_lock() before optionally
  * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
  * CPU hotplug is disabled on entry.
+ *
+ * When favordynmods is enabled, take per threadgroup rwsem to reduce overhead
+ * on dynamic cgroup modifications. see the comment above
+ * CGRP_ROOT_FAVOR_DYNMODS definition.
+ *
+ * tsk is not NULL only when writing to cgroup.procs.
  */
-void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode)
+void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode,
+			struct task_struct *tsk)
 {
 	cpus_read_lock();
 
@@ -2513,6 +2545,9 @@ void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode)
 	case CGRP_ATTACH_LOCK_GLOBAL:
 		percpu_down_write(&cgroup_threadgroup_rwsem);
 		break;
+	case CGRP_ATTACH_LOCK_PER_THREADGROUP:
+		down_write(&tsk->signal->cgroup_threadgroup_rwsem);
+		break;
 	default:
 		pr_warn("cgroup: Unexpected attach lock mode.");
 		break;
@@ -2521,9 +2556,11 @@ void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode)
 
 /**
  * cgroup_attach_unlock - Undo cgroup_attach_lock()
- * @lock_mode: whether to up_write cgroup_threadgroup_rwsem
+ * @lock_mode: whether release and release which rwsem
+ * @tsk: thread group to lock
  */
-void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode)
+void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode,
+			  struct task_struct *tsk)
 {
 	switch (lock_mode) {
 	case CGRP_ATTACH_LOCK_NONE:
@@ -2531,6 +2568,9 @@ void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode)
 	case CGRP_ATTACH_LOCK_GLOBAL:
 		percpu_up_write(&cgroup_threadgroup_rwsem);
 		break;
+	case CGRP_ATTACH_LOCK_PER_THREADGROUP:
+		up_write(&tsk->signal->cgroup_threadgroup_rwsem);
+		break;
 	default:
 		pr_warn("cgroup: Unexpected attach lock mode.");
 		break;
@@ -3042,7 +3082,6 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 		tsk = ERR_PTR(-EINVAL);
 		goto out_unlock_rcu;
 	}
-
 	get_task_struct(tsk);
 	rcu_read_unlock();
 
@@ -3055,12 +3094,16 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 */
 	lockdep_assert_held(&cgroup_mutex);
 
-	if (pid || threadgroup)
-		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
-	else
+	if (pid || threadgroup) {
+		if (cgroup_enable_per_threadgroup_rwsem)
+			*lock_mode = CGRP_ATTACH_LOCK_PER_THREADGROUP;
+		else
+			*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
+	} else {
 		*lock_mode = CGRP_ATTACH_LOCK_NONE;
+	}
 
-	cgroup_attach_lock(*lock_mode);
+	cgroup_attach_lock(*lock_mode, tsk);
 
 	if (threadgroup) {
 		if (!thread_group_leader(tsk)) {
@@ -3069,7 +3112,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 			 * may strip us of our leadership. If this happens,
 			 * throw this task away and try again.
 			 */
-			cgroup_attach_unlock(*lock_mode);
+			cgroup_attach_unlock(*lock_mode, tsk);
 			put_task_struct(tsk);
 			goto retry_find_task;
 		}
@@ -3085,10 +3128,10 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 void cgroup_procs_write_finish(struct task_struct *task,
 			       enum cgroup_attach_lock_mode lock_mode)
 {
+	cgroup_attach_unlock(lock_mode, task);
+
 	/* release reference from cgroup_procs_write_start() */
 	put_task_struct(task);
-
-	cgroup_attach_unlock(lock_mode);
 }
 
 static void cgroup_print_ss_mask(struct seq_file *seq, u16 ss_mask)
@@ -3178,7 +3221,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	else
 		lock_mode = CGRP_ATTACH_LOCK_NONE;
 
-	cgroup_attach_lock(lock_mode);
+	cgroup_attach_lock(lock_mode, NULL);
 
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3199,7 +3242,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(lock_mode);
+	cgroup_attach_unlock(lock_mode, NULL);
 	return ret;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index c4ada32598bd..9a039867ecfd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1688,6 +1688,10 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	tty_audit_fork(sig);
 	sched_autogroup_fork(sig);
 
+#ifdef CONFIG_CGROUPS
+	init_rwsem(&sig->cgroup_threadgroup_rwsem);
+#endif
+
 	sig->oom_score_adj = current->signal->oom_score_adj;
 	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
 
-- 
2.51.0


