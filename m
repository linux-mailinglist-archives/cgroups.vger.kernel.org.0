Return-Path: <cgroups+bounces-9705-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBABCB43A5E
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 13:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FFF3B8E52
	for <lists+cgroups@lfdr.de>; Thu,  4 Sep 2025 11:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CC82D3A6A;
	Thu,  4 Sep 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NEzo0jaW"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CBB2E8B86;
	Thu,  4 Sep 2025 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756985990; cv=none; b=ZNZ3rIGiuYV1FGKW6Dp6rB/3ox/kBQn4FOSKiX+wXqoyWNO/I5JvYEbIa1wGZAUlhfBTT80698H50UOmsJTqKmGvrdFm4HY70MqybSPnfjomh2370ZC/YHn8BRXm2DBCrbKyTMVB1uznwIY3qlKBpE7L/VhoqbntnRpJfa5kscQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756985990; c=relaxed/simple;
	bh=DZepiSpB0MWOMCVJMbk3dCCRESGNJpXLIUzy51tx2/M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P1D+kCuxZStrt5cBB504nFE1zkQgyL6meqlKSKTiarls8fEjjym5PulPqJwLnY2Mm/C8VJmk13clkNHMuIEC3frvWXf1D1iyxbwH8xIVAVTHCojcNfqlt3zh/syvXDNiZvJUXbsn1qopwjMgPAdziYG/7bdGM88PeQvgR6GUhig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NEzo0jaW; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756985979; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Ykh9Bx/xKTiRxIBj7sGNrUvPDC6SQywKTi0R07OkmQs=;
	b=NEzo0jaWADArVKFmqqlZ0Z/GqyuyQIo6jUxVJmlWy1x/3f3ewNb/IMxcV0VBhuQH2ENUA6vO9LL3NzLlRQf4hgla3EftsZF3RToTIkHMbyH0ZQME9nzXmiNBH7x8cfTETwmuPM/LGLohPjJzNBCdBmKt+jIvoO2Z5VTMjhqT0vI=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnG0v0u_1756985978 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 04 Sep 2025 19:39:38 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] cgroup: replace global percpu_rwsem with signal_struct->group_rwsem when writing cgroup.procs/threads
Date: Thu,  4 Sep 2025 19:39:32 +0800
Message-Id: <068d58f1f497bc4971c6ac0bae58bf53b98451fd.1756985260.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <cover.1756985260.git.escape@linux.alibaba.com>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com> <cover.1756985260.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

To avoid affecting other users, the per-thread-group rwsem is only used
when the `favordynmods` flag is enabled.

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 include/linux/cgroup-defs.h     |  6 +++
 include/linux/sched/signal.h    |  4 ++
 init/init_task.c                |  3 ++
 kernel/cgroup/cgroup-internal.h |  4 +-
 kernel/cgroup/cgroup-v1.c       |  8 ++--
 kernel/cgroup/cgroup.c          | 72 +++++++++++++++++++--------------
 kernel/fork.c                   |  4 ++
 7 files changed, 64 insertions(+), 37 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..0c068dc3e08d 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -828,6 +828,8 @@ struct cgroup_of_peak {
 	struct list_head	list;
 };
 
+extern bool have_favordynmods;
+
 /**
  * cgroup_threadgroup_change_begin - threadgroup exclusion for cgroups
  * @tsk: target task
@@ -838,6 +840,8 @@ struct cgroup_of_peak {
 static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
 {
 	percpu_down_read(&cgroup_threadgroup_rwsem);
+	if (have_favordynmods)
+		down_read(&tsk->signal->group_rwsem);
 }
 
 /**
@@ -848,6 +852,8 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
  */
 static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
 {
+	if (have_favordynmods)
+		up_read(&tsk->signal->group_rwsem);
 	percpu_up_read(&cgroup_threadgroup_rwsem);
 }
 
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 1ef1edbaaf79..86fbc99a9174 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -226,6 +226,10 @@ struct signal_struct {
 	struct tty_audit_buf *tty_audit_buf;
 #endif
 
+#ifdef CONFIG_CGROUPS
+	struct rw_semaphore group_rwsem;
+#endif
+
 	/*
 	 * Thread is the potential origin of an oom condition; kill first on
 	 * oom
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..0450093924a7 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -27,6 +27,9 @@ static struct signal_struct init_signals = {
 	},
 	.multiprocess	= HLIST_HEAD_INIT,
 	.rlim		= INIT_RLIMITS,
+#ifdef CONFIG_CGROUPS
+	.group_rwsem	= __RWSEM_INITIALIZER(init_signals.group_rwsem),
+#endif
 	.cred_guard_mutex = __MUTEX_INITIALIZER(init_signals.cred_guard_mutex),
 	.exec_update_lock = __RWSEM_INITIALIZER(init_signals.exec_update_lock),
 #ifdef CONFIG_POSIX_TIMERS
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index b14e61c64a34..35005543f0c7 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -249,8 +249,8 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
-void cgroup_attach_lock(bool lock_threadgroup);
-void cgroup_attach_unlock(bool lock_threadgroup);
+void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup);
+void cgroup_attach_unlock(struct task_struct *tsk, bool lock_threadgroup);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     bool *locked)
 	__acquires(&cgroup_threadgroup_rwsem);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 2a4a387f867a..9f1a4d1fc741 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	cgroup_lock();
-	cgroup_attach_lock(true);
+	cgroup_attach_lock(NULL, true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	cgroup_attach_unlock(true);
+	cgroup_attach_unlock(NULL, true);
 	cgroup_unlock();
 
 	return retval;
@@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	cgroup_attach_lock(true);
+	cgroup_attach_lock(NULL, true);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(true);
+	cgroup_attach_unlock(NULL, true);
 	cgroup_unlock();
 	return ret;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..22b1659b623c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -214,7 +214,7 @@ static u16 have_exit_callback __read_mostly;
 static u16 have_release_callback __read_mostly;
 static u16 have_canfork_callback __read_mostly;
 
-static bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
+bool have_favordynmods __ro_after_init = IS_ENABLED(CONFIG_CGROUP_FAVOR_DYNMODS);
 
 /* cgroup namespace for init task */
 struct cgroup_namespace init_cgroup_ns = {
@@ -2459,7 +2459,8 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
 /**
  * cgroup_attach_lock - Lock for ->attach()
- * @lock_threadgroup: whether to down_write cgroup_threadgroup_rwsem
+ * @tsk: thread group to lock
+ * @lock_threadgroup: whether to down_write rwsem
  *
  * cgroup migration sometimes needs to stabilize threadgroups against forks and
  * exits by write-locking cgroup_threadgroup_rwsem. However, some ->attach()
@@ -2480,21 +2481,30 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
  * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
  * CPU hotplug is disabled on entry.
  */
-void cgroup_attach_lock(bool lock_threadgroup)
+void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup)
 {
 	cpus_read_lock();
-	if (lock_threadgroup)
-		percpu_down_write(&cgroup_threadgroup_rwsem);
+	if (lock_threadgroup) {
+		if (tsk && favor_dynmods)
+			down_write(&tsk->signal->group_rwsem);
+		else
+			percpu_down_write(&cgroup_threadgroup_rwsem);
+	}
 }
 
 /**
  * cgroup_attach_unlock - Undo cgroup_attach_lock()
- * @lock_threadgroup: whether to up_write cgroup_threadgroup_rwsem
+ * @tsk: thread group to lock
+ * @lock_threadgroup: whether to up_write rwsem
  */
-void cgroup_attach_unlock(bool lock_threadgroup)
+void cgroup_attach_unlock(struct task_struct *tsk, bool lock_threadgroup)
 {
-	if (lock_threadgroup)
-		percpu_up_write(&cgroup_threadgroup_rwsem);
+	if (lock_threadgroup) {
+		if (tsk && favor_dynmods)
+			up_write(&tsk->signal->group_rwsem);
+		else
+			percpu_up_write(&cgroup_threadgroup_rwsem);
+	}
 	cpus_read_unlock();
 }
 
@@ -2976,24 +2986,12 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
 		return ERR_PTR(-EINVAL);
 
-	/*
-	 * If we migrate a single thread, we don't care about threadgroup
-	 * stability. If the thread is `current`, it won't exit(2) under our
-	 * hands or change PID through exec(2). We exclude
-	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
-	 * callers by cgroup_mutex.
-	 * Therefore, we can skip the global lock.
-	 */
-	lockdep_assert_held(&cgroup_mutex);
-	*threadgroup_locked = pid || threadgroup;
-	cgroup_attach_lock(*threadgroup_locked);
-
 	rcu_read_lock();
 	if (pid) {
 		tsk = find_task_by_vpid(pid);
 		if (!tsk) {
 			tsk = ERR_PTR(-ESRCH);
-			goto out_unlock_threadgroup;
+			goto out_unlock_rcu;
 		}
 	} else {
 		tsk = current;
@@ -3010,15 +3008,27 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 */
 	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
 		tsk = ERR_PTR(-EINVAL);
-		goto out_unlock_threadgroup;
+		goto out_unlock_rcu;
 	}
-
 	get_task_struct(tsk);
-	goto out_unlock_rcu;
 
-out_unlock_threadgroup:
-	cgroup_attach_unlock(*threadgroup_locked);
-	*threadgroup_locked = false;
+	rcu_read_unlock();
+
+	/*
+	 * If we migrate a single thread, we don't care about threadgroup
+	 * stability. If the thread is `current`, it won't exit(2) under our
+	 * hands or change PID through exec(2). We exclude
+	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
+	 * callers by cgroup_mutex.
+	 * Therefore, we can skip the global lock.
+	 */
+	lockdep_assert_held(&cgroup_mutex);
+	*threadgroup_locked = pid || threadgroup;
+
+	cgroup_attach_lock(tsk, *threadgroup_locked);
+
+	return tsk;
+
 out_unlock_rcu:
 	rcu_read_unlock();
 	return tsk;
@@ -3032,7 +3042,7 @@ void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked
 	/* release reference from cgroup_procs_write_start() */
 	put_task_struct(task);
 
-	cgroup_attach_unlock(threadgroup_locked);
+	cgroup_attach_unlock(task, threadgroup_locked);
 
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
@@ -3119,7 +3129,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	 * write-locking can be skipped safely.
 	 */
 	has_tasks = !list_empty(&mgctx.preloaded_src_csets);
-	cgroup_attach_lock(has_tasks);
+	cgroup_attach_lock(NULL, has_tasks);
 
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3140,7 +3150,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(has_tasks);
+	cgroup_attach_unlock(NULL, has_tasks);
 	return ret;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index af673856499d..5218f9b93c77 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1688,6 +1688,10 @@ static int copy_signal(unsigned long clone_flags, struct task_struct *tsk)
 	tty_audit_fork(sig);
 	sched_autogroup_fork(sig);
 
+#ifdef CONFIG_CGROUPS
+	init_rwsem(&sig->group_rwsem);
+#endif
+
 	sig->oom_score_adj = current->signal->oom_score_adj;
 	sig->oom_score_adj_min = current->signal->oom_score_adj_min;
 
-- 
2.32.0.3.g01195cf9f


