Return-Path: <cgroups+bounces-9642-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B52B6B41CC8
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 13:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 949514E4BAC
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709502F4A0B;
	Wed,  3 Sep 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FJVmHUrc"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DA22DCF73;
	Wed,  3 Sep 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756897881; cv=none; b=WBHUYEOE4LZourM+jjmit3qUZdHtiFjgTLjPMgVnhSIAVXwRrRi3qh0wS1PpOYDlKpjVuSVHaBZlHhiF5RSVrOkB8jhTbCHIV0lKNbbKfv/ULSO2EZDMu9L/xb2TRw2y3Myxje3T8NDqwgVNHi6LM1e1vyaBloks5NT39TDxMCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756897881; c=relaxed/simple;
	bh=BTl7Ul1H7ObYXERCYqHj7raHnCo2HuMR5afc9ARTz3M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2ADHGTeFArqi6JctztEWJExYohYGkOgi5CaGkkH5OgaDKAefcYmwVCd9mfK9I7FU4vmps0OvqUPOqcBS7Be67PZBK/82VAh1MY+UmZdI2k8F2TSC+E2bHhjdGuS+iU/Flkzbn+lopZGI6jcIliWfbVf7sE+PxyUnSpNIRyyR8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FJVmHUrc; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756897874; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hyxNaG6hnaqx4lIhRFM7XeK3Vg9++tSnE9rUBk2Oup4=;
	b=FJVmHUrcVvbDIyR98VHSL17zWeoyN12V39F5TvN9kzhRbA4DakOb6ufbgwAXq2aZVHt5KqfI8pgtAMYPPdg2XCdRnmPin+3uZ+IjNPrEgC38RAAqtbBL/mHRUrZ9qTO1hjVkWi9F1ENb+oG33yLC5GADT/6al7YfyBtzBrPvhPs=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0WnBdjdG_1756897874 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Sep 2025 19:11:14 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup: replace global percpu_rwsem with signal_struct->group_rwsem when writing cgroup.procs/threads
Date: Wed,  3 Sep 2025 19:11:07 +0800
Message-Id: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
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

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 include/linux/cgroup-defs.h     |  2 ++
 include/linux/sched/signal.h    |  4 +++
 init/init_task.c                |  3 ++
 kernel/cgroup/cgroup-internal.h |  6 ++--
 kernel/cgroup/cgroup-v1.c       |  8 ++---
 kernel/cgroup/cgroup.c          | 56 ++++++++++++++++++++-------------
 kernel/fork.c                   |  4 +++
 7 files changed, 55 insertions(+), 28 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..8e0fdad8a440 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -838,6 +838,7 @@ struct cgroup_of_peak {
 static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
 {
 	percpu_down_read(&cgroup_threadgroup_rwsem);
+	down_read(&tsk->signal->group_rwsem);
 }
 
 /**
@@ -848,6 +849,7 @@ static inline void cgroup_threadgroup_change_begin(struct task_struct *tsk)
  */
 static inline void cgroup_threadgroup_change_end(struct task_struct *tsk)
 {
+	up_read(&tsk->signal->group_rwsem);
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
index b14e61c64a34..572c24b7e947 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -249,8 +249,10 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
-void cgroup_attach_lock(bool lock_threadgroup);
-void cgroup_attach_unlock(bool lock_threadgroup);
+void cgroup_attach_lock(struct task_struct *tsk, bool lock_threadgroup,
+			bool global);
+void cgroup_attach_unlock(struct task_struct *tsk, bool lock_threadgroup,
+			  bool global);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     bool *locked)
 	__acquires(&cgroup_threadgroup_rwsem);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 2a4a387f867a..3e5ead8c5bc5 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	cgroup_lock();
-	cgroup_attach_lock(true);
+	cgroup_attach_lock(NULL, true, true);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	cgroup_attach_unlock(true);
+	cgroup_attach_unlock(NULL, true, true);
 	cgroup_unlock();
 
 	return retval;
@@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	cgroup_attach_lock(true);
+	cgroup_attach_lock(NULL, true, true);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(true);
+	cgroup_attach_unlock(NULL, true, true);
 	cgroup_unlock();
 	return ret;
 }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..4e1d80a2741f 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2480,21 +2480,31 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
  * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
  * CPU hotplug is disabled on entry.
  */
-void cgroup_attach_lock(bool lock_threadgroup)
+void cgroup_attach_lock(struct task_struct *tsk,
+			       bool lock_threadgroup, bool global)
 {
 	cpus_read_lock();
-	if (lock_threadgroup)
-		percpu_down_write(&cgroup_threadgroup_rwsem);
+	if (lock_threadgroup) {
+		if (global)
+			percpu_down_write(&cgroup_threadgroup_rwsem);
+		else
+			down_write(&tsk->signal->group_rwsem);
+	}
 }
 
 /**
  * cgroup_attach_unlock - Undo cgroup_attach_lock()
  * @lock_threadgroup: whether to up_write cgroup_threadgroup_rwsem
  */
-void cgroup_attach_unlock(bool lock_threadgroup)
+void cgroup_attach_unlock(struct task_struct *tsk,
+				 bool lock_threadgroup, bool global)
 {
-	if (lock_threadgroup)
-		percpu_up_write(&cgroup_threadgroup_rwsem);
+	if (lock_threadgroup) {
+		if (global)
+			percpu_up_write(&cgroup_threadgroup_rwsem);
+		else
+			up_write(&tsk->signal->group_rwsem);
+	}
 	cpus_read_unlock();
 }
 
@@ -2970,12 +2980,23 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 					     bool *threadgroup_locked)
 {
-	struct task_struct *tsk;
+	struct task_struct *tsk, *tmp_tsk;
 	pid_t pid;
 
 	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
 		return ERR_PTR(-EINVAL);
 
+	rcu_read_lock();
+	if (pid) {
+		tsk = find_task_by_vpid(pid);
+		if (!tsk) {
+			tsk = ERR_PTR(-ESRCH);
+			goto out_unlock_rcu;
+		}
+	} else {
+		tsk = current;
+	}
+
 	/*
 	 * If we migrate a single thread, we don't care about threadgroup
 	 * stability. If the thread is `current`, it won't exit(2) under our
@@ -2986,18 +3007,9 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 */
 	lockdep_assert_held(&cgroup_mutex);
 	*threadgroup_locked = pid || threadgroup;
-	cgroup_attach_lock(*threadgroup_locked);
 
-	rcu_read_lock();
-	if (pid) {
-		tsk = find_task_by_vpid(pid);
-		if (!tsk) {
-			tsk = ERR_PTR(-ESRCH);
-			goto out_unlock_threadgroup;
-		}
-	} else {
-		tsk = current;
-	}
+	tmp_tsk = tsk;
+	cgroup_attach_lock(tmp_tsk, *threadgroup_locked, false);
 
 	if (threadgroup)
 		tsk = tsk->group_leader;
@@ -3017,7 +3029,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	goto out_unlock_rcu;
 
 out_unlock_threadgroup:
-	cgroup_attach_unlock(*threadgroup_locked);
+	cgroup_attach_unlock(tmp_tsk, *threadgroup_locked, false);
 	*threadgroup_locked = false;
 out_unlock_rcu:
 	rcu_read_unlock();
@@ -3032,7 +3044,7 @@ void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked
 	/* release reference from cgroup_procs_write_start() */
 	put_task_struct(task);
 
-	cgroup_attach_unlock(threadgroup_locked);
+	cgroup_attach_unlock(task, threadgroup_locked, false);
 
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
@@ -3119,7 +3131,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	 * write-locking can be skipped safely.
 	 */
 	has_tasks = !list_empty(&mgctx.preloaded_src_csets);
-	cgroup_attach_lock(has_tasks);
+	cgroup_attach_lock(NULL, has_tasks, true);
 
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3140,7 +3152,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(has_tasks);
+	cgroup_attach_unlock(NULL, has_tasks, true);
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


