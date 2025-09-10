Return-Path: <cgroups+bounces-9864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00761B50EA1
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 09:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1201BC49DF
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 07:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A31D36124;
	Wed, 10 Sep 2025 07:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P/cWcHlS"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E650830648B;
	Wed, 10 Sep 2025 07:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487622; cv=none; b=DBKGcH6NT8kSmjDFgTU7mty0gLDkxtXc3kbUZJ8M+AzIDP/m+CZFCdvnUQnCNWdHSa1rANNxbE7yL3s3ICwuw0CCfeYbo8dlr7gWRwhCBD74fyxS+yTiBxWBJLD44okXalnYiEysSQIta+Nyzp5v8o/eg/2MaeINgu0wVwYAPeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487622; c=relaxed/simple;
	bh=iGWxDSh0YCMdLa0u6KtTEIYNEo1ZzTjy89BTzDWB+hM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mykXNVHGFmm56UhN45iTinjpk99RVkdXy4pNQAtO4KbRkON3D5h1mgOz46yibDrS7UpUAvmRsm9SCgZ/KkuXTzbkcJWoU36SFDD6lNGK2y87OJoQvdJtSylrbBYCgwWCh7WpI7KttT2X1psyWxFAlAE90PuhY6yl2aSx2jp+Ai4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P/cWcHlS; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757487606; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=sI93MSs3zgiNn0IVFfCd/36Uo2lYoPvYKtaMYzpcBrI=;
	b=P/cWcHlS+lyIhGh/6zN0hiSoRGiUnLY86fPxwa6kYhh1SuEHpK74QfeIjtwywVmfZbcnBQ1LJ/LV6iqxt83ddJXZKo89ZnhhhSNOTeI73yk7gwbMeUoTTceta9N5ZY3QKDofhxMnkB/2eai8dJs5tTN7wgr8dSNhfwTiLfuceQo=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Wnh7Nvn_1757487605 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 15:00:05 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] cgroup: replace global percpu_rwsem with per threadgroup resem when writing to cgroup.procs
Date: Wed, 10 Sep 2025 14:59:35 +0800
Message-Id: <9d46438e61bcf7b5ffc9eb582081f4fcc99c2cbf.1757486368.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <cover.1757486368.git.escape@linux.alibaba.com>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com> <cover.1757486368.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 include/linux/cgroup-defs.h     | 17 ++++++++-
 include/linux/sched/signal.h    |  4 ++
 init/init_task.c                |  3 ++
 kernel/cgroup/cgroup-internal.h |  6 ++-
 kernel/cgroup/cgroup-v1.c       |  8 ++--
 kernel/cgroup/cgroup.c          | 67 +++++++++++++++++++++++++--------
 kernel/fork.c                   |  4 ++
 7 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 213b0d01464f..fe29152bceff 100644
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
@@ -830,6 +839,7 @@ struct cgroup_subsys {
 };
 
 extern struct percpu_rw_semaphore cgroup_threadgroup_rwsem;
+extern bool cgroup_enable_per_threadgroup_rwsem;
 
 struct cgroup_of_peak {
 	unsigned long		value;
@@ -841,11 +851,14 @@ struct cgroup_of_peak {
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
@@ -856,6 +869,8 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
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
index f3838888ea6f..db48550bc4cc 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	cgroup_lock();
-	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	cgroup_unlock();
 
 	return retval;
@@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	cgroup_unlock();
 	return ret;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 756807164091..344424dd365b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -216,6 +216,14 @@ static u16 have_canfork_callback __read_mostly;
 
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
@@ -1302,14 +1310,24 @@ void cgroup_favor_dynmods(struct cgroup_root *root, bool favor)
 {
 	bool favoring = root->flags & CGRP_ROOT_FAVOR_DYNMODS;
 
-	/* see the comment above CGRP_ROOT_FAVOR_DYNMODS definition */
+	/*
+	 * see the comment above CGRP_ROOT_FAVOR_DYNMODS definition.
+	 * favordynmods can flip while task is between
+	 * cgroup_threadgroup_change_begin and cgroup_threadgroup_change_end,
+	 * so down_write global cgroup_threadgroup_rwsem to synchronize them.
+	 */
+	percpu_down_write(&cgroup_threadgroup_rwsem);
 	if (favor && !favoring) {
+		cgroup_enable_per_threadgroup_rwsem = true;
 		rcu_sync_enter(&cgroup_threadgroup_rwsem.rss);
 		root->flags |= CGRP_ROOT_FAVOR_DYNMODS;
 	} else if (!favor && favoring) {
+		if (cgroup_enable_per_threadgroup_rwsem)
+			WARN_ONCE(1, "cgroup favordynmods: per threadgroup rwsem mechanism can't be disabled\n");
 		rcu_sync_exit(&cgroup_threadgroup_rwsem.rss);
 		root->flags &= ~CGRP_ROOT_FAVOR_DYNMODS;
 	}
+	percpu_up_write(&cgroup_threadgroup_rwsem);
 }
 
 static int cgroup_init_root_id(struct cgroup_root *root)
@@ -2459,7 +2477,8 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
 /**
  * cgroup_attach_lock - Lock for ->attach()
- * @lock_mode: whether to down_write cgroup_threadgroup_rwsem
+ * @lock_mode: whether acquire and acquire which rwsem
+ * @tsk: thread group to lock
  *
  * cgroup migration sometimes needs to stabilize threadgroups against forks and
  * exits by write-locking cgroup_threadgroup_rwsem. However, some ->attach()
@@ -2479,8 +2498,15 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
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
 
@@ -2490,6 +2516,9 @@ void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode)
 	case CGRP_ATTACH_LOCK_GLOBAL:
 		percpu_down_write(&cgroup_threadgroup_rwsem);
 		break;
+	case CGRP_ATTACH_LOCK_PER_THREADGROUP:
+		down_write(&tsk->signal->cgroup_threadgroup_rwsem);
+		break;
 	default:
 		pr_warn("cgroup: Unexpected attach lock mode.");
 		break;
@@ -2498,9 +2527,11 @@ void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode)
 
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
@@ -2508,6 +2539,9 @@ void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode)
 	case CGRP_ATTACH_LOCK_GLOBAL:
 		percpu_up_write(&cgroup_threadgroup_rwsem);
 		break;
+	case CGRP_ATTACH_LOCK_PER_THREADGROUP:
+		up_write(&tsk->signal->cgroup_threadgroup_rwsem);
+		break;
 	default:
 		pr_warn("cgroup: Unexpected attach lock mode.");
 		break;
@@ -3019,7 +3053,6 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 		tsk = ERR_PTR(-EINVAL);
 		goto out_unlock_rcu;
 	}
-
 	get_task_struct(tsk);
 	rcu_read_unlock();
 
@@ -3033,12 +3066,16 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
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
@@ -3049,7 +3086,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 			 * try again; this is
 			 * "double-double-toil-and-trouble-check locking".
 			 */
-			cgroup_attach_unlock(*lock_mode);
+			cgroup_attach_unlock(*lock_mode, tsk);
 			put_task_struct(tsk);
 			goto retry_find_task;
 		}
@@ -3068,11 +3105,11 @@ void cgroup_procs_write_finish(struct task_struct *task,
 	struct cgroup_subsys *ss;
 	int ssid;
 
+	cgroup_attach_unlock(lock_mode, task);
+
 	/* release reference from cgroup_procs_write_start() */
 	put_task_struct(task);
 
-	cgroup_attach_unlock(lock_mode);
-
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
 			ss->post_attach();
@@ -3165,7 +3202,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	else
 		lock_mode = CGRP_ATTACH_LOCK_NONE;
 
-	cgroup_attach_lock(lock_mode);
+	cgroup_attach_lock(lock_mode, NULL);
 
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3186,7 +3223,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
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
2.32.0.3.g01195cf9f


