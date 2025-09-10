Return-Path: <cgroups+bounces-9862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCF6B50E9D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 09:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8363B4E2430
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 07:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC67306D23;
	Wed, 10 Sep 2025 06:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lomyvRQV"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEFE30597D;
	Wed, 10 Sep 2025 06:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757487597; cv=none; b=fSiFxryUHkihWNKSTA7HBxNq7KDd+Dz2Lsk2mfIOrsEyuz11Sj/IJvlJi7WbfWU5nmeekcJO4m8hfOML91LwgLF/RAPT4jOLuoQDGM65M9pkRzW1axDz5i8dW+6yr0j8PEa/+4oUzFU8s9SeYeuYlhhNN76CwP+v0DCjWG8FJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757487597; c=relaxed/simple;
	bh=J/Gm1Sv89L/EDnUsOv0d/PklkOhFoC7F8qrqO/p60QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WZ0qkO4nw+c3zXviooW/SngrLZwuzeilLiludDT5kr5FXqiGxRT9mdqTX8W7QrU9iRIZ9Xx02hg5Kzr4i7P3bSt5uT+l2cOTp6MK95f47PsmdHnZFQi8Zg+ymU2DxncO1gVf/bQqKmj0p+JIaQyxOUwPqqbgCisYkSYIDMzcKHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lomyvRQV; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757487592; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=yNqA+q0Witmyp4c0usUgj6F+Z4vsbMGnPFPUvlgeXh0=;
	b=lomyvRQVgbPrF/f4JACALjVB4kCBw7OW2X9J/cCK3mwm6/L6JwLEADfFy2mWFlCLuyLjemKGGiWN/Xtr0yVwpsrAELTNTca4J9zDFujRnuq9Sv0jxnHd7REqQqvLTKk8rfxLEUWqTNCTdKXA0hI10MgldzMmbzn/VWb6P/KhvY0=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Wnh5VbJ_1757487591 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 14:59:52 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] cgroup: refactor the cgroup_attach_lock code to make it clearer
Date: Wed, 10 Sep 2025 14:59:33 +0800
Message-Id: <e1c56f0ac5826010dbbddf781641306a0cf666cd.1757486368.git.escape@linux.alibaba.com>
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

Dynamic cgroup migration involving threadgroup locks can be in one of
two states: no lock held, or holding the global lock. Explicitly
declaring the different lock modes to make the code easier to
understand and facilitates future extensions of the lock modes.

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 include/linux/cgroup-defs.h     |  8 ++++
 kernel/cgroup/cgroup-internal.h |  9 +++--
 kernel/cgroup/cgroup-v1.c       | 14 +++----
 kernel/cgroup/cgroup.c          | 67 ++++++++++++++++++++++++---------
 4 files changed, 69 insertions(+), 29 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 6b93a64115fe..213b0d01464f 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -140,6 +140,14 @@ enum {
 	__CFTYPE_ADDED		= (1 << 18),
 };
 
+enum cgroup_attach_lock_mode {
+	/* Default */
+	CGRP_ATTACH_LOCK_GLOBAL,
+
+	/* When pid=0 && threadgroup=false, see comments in cgroup_procs_write_start */
+	CGRP_ATTACH_LOCK_NONE,
+};
+
 /*
  * cgroup_file is the handle for a file instance created in a cgroup which
  * is used, for example, to generate file changed notifications.  This can
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index b14e61c64a34..a6d6f30b6f65 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -249,12 +249,13 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
-void cgroup_attach_lock(bool lock_threadgroup);
-void cgroup_attach_unlock(bool lock_threadgroup);
+void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode);
+void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
-					     bool *locked)
+					     enum cgroup_attach_lock_mode *lock_mode)
 	__acquires(&cgroup_threadgroup_rwsem);
-void cgroup_procs_write_finish(struct task_struct *task, bool locked)
+void cgroup_procs_write_finish(struct task_struct *task,
+			       enum cgroup_attach_lock_mode lock_mode)
 	__releases(&cgroup_threadgroup_rwsem);
 
 void cgroup_lock_and_drain_offline(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 2a4a387f867a..f3838888ea6f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	cgroup_lock();
-	cgroup_attach_lock(true);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	cgroup_attach_unlock(true);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL);
 	cgroup_unlock();
 
 	return retval;
@@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	cgroup_attach_lock(true);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(true);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL);
 	cgroup_unlock();
 	return ret;
 }
@@ -502,13 +502,13 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	struct task_struct *task;
 	const struct cred *cred, *tcred;
 	ssize_t ret;
-	bool locked;
+	enum cgroup_attach_lock_mode lock_mode;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, threadgroup, &locked);
+	task = cgroup_procs_write_start(buf, threadgroup, &lock_mode);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
@@ -531,7 +531,7 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	ret = cgroup_attach_task(cgrp, task, threadgroup);
 
 out_finish:
-	cgroup_procs_write_finish(task, locked);
+	cgroup_procs_write_finish(task, lock_mode);
 out_unlock:
 	cgroup_kn_unlock(of->kn);
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 312c6a8b55bb..2b88c7abaa00 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2459,7 +2459,7 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
 /**
  * cgroup_attach_lock - Lock for ->attach()
- * @lock_threadgroup: whether to down_write cgroup_threadgroup_rwsem
+ * @lock_mode: whether to down_write cgroup_threadgroup_rwsem
  *
  * cgroup migration sometimes needs to stabilize threadgroups against forks and
  * exits by write-locking cgroup_threadgroup_rwsem. However, some ->attach()
@@ -2480,21 +2480,39 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
  * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
  * CPU hotplug is disabled on entry.
  */
-void cgroup_attach_lock(bool lock_threadgroup)
+void cgroup_attach_lock(enum cgroup_attach_lock_mode lock_mode)
 {
 	cpus_read_lock();
-	if (lock_threadgroup)
+
+	switch (lock_mode) {
+	case CGRP_ATTACH_LOCK_NONE:
+		break;
+	case CGRP_ATTACH_LOCK_GLOBAL:
 		percpu_down_write(&cgroup_threadgroup_rwsem);
+		break;
+	default:
+		pr_warn("cgroup: Unexpected attach lock mode.");
+		break;
+	}
 }
 
 /**
  * cgroup_attach_unlock - Undo cgroup_attach_lock()
- * @lock_threadgroup: whether to up_write cgroup_threadgroup_rwsem
+ * @lock_mode: whether to up_write cgroup_threadgroup_rwsem
  */
-void cgroup_attach_unlock(bool lock_threadgroup)
+void cgroup_attach_unlock(enum cgroup_attach_lock_mode lock_mode)
 {
-	if (lock_threadgroup)
+	switch (lock_mode) {
+	case CGRP_ATTACH_LOCK_NONE:
+		break;
+	case CGRP_ATTACH_LOCK_GLOBAL:
 		percpu_up_write(&cgroup_threadgroup_rwsem);
+		break;
+	default:
+		pr_warn("cgroup: Unexpected attach lock mode.");
+		break;
+	}
+
 	cpus_read_unlock();
 }
 
@@ -2968,7 +2986,7 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 }
 
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
-					     bool *threadgroup_locked)
+					     enum cgroup_attach_lock_mode *lock_mode)
 {
 	struct task_struct *tsk;
 	pid_t pid;
@@ -2985,8 +3003,13 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 * Therefore, we can skip the global lock.
 	 */
 	lockdep_assert_held(&cgroup_mutex);
-	*threadgroup_locked = pid || threadgroup;
-	cgroup_attach_lock(*threadgroup_locked);
+
+	if (pid || threadgroup)
+		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
+	else
+		*lock_mode = CGRP_ATTACH_LOCK_NONE;
+
+	cgroup_attach_lock(*lock_mode);
 
 	rcu_read_lock();
 	if (pid) {
@@ -3017,14 +3040,15 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	goto out_unlock_rcu;
 
 out_unlock_threadgroup:
-	cgroup_attach_unlock(*threadgroup_locked);
-	*threadgroup_locked = false;
+	cgroup_attach_unlock(*lock_mode);
+	*lock_mode = CGRP_ATTACH_LOCK_NONE;
 out_unlock_rcu:
 	rcu_read_unlock();
 	return tsk;
 }
 
-void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked)
+void cgroup_procs_write_finish(struct task_struct *task,
+			       enum cgroup_attach_lock_mode lock_mode)
 {
 	struct cgroup_subsys *ss;
 	int ssid;
@@ -3032,7 +3056,7 @@ void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked
 	/* release reference from cgroup_procs_write_start() */
 	put_task_struct(task);
 
-	cgroup_attach_unlock(threadgroup_locked);
+	cgroup_attach_unlock(lock_mode);
 
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
@@ -3088,6 +3112,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	struct cgroup_subsys_state *d_css;
 	struct cgroup *dsct;
 	struct css_set *src_cset;
+	enum cgroup_attach_lock_mode lock_mode;
 	bool has_tasks;
 	int ret;
 
@@ -3119,7 +3144,13 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	 * write-locking can be skipped safely.
 	 */
 	has_tasks = !list_empty(&mgctx.preloaded_src_csets);
-	cgroup_attach_lock(has_tasks);
+
+	if (has_tasks)
+		lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
+	else
+		lock_mode = CGRP_ATTACH_LOCK_NONE;
+
+	cgroup_attach_lock(lock_mode);
 
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3140,7 +3171,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(has_tasks);
+	cgroup_attach_unlock(lock_mode);
 	return ret;
 }
 
@@ -5241,13 +5272,13 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	struct task_struct *task;
 	const struct cred *saved_cred;
 	ssize_t ret;
-	bool threadgroup_locked;
+	enum cgroup_attach_lock_mode lock_mode;
 
 	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!dst_cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, threadgroup, &threadgroup_locked);
+	task = cgroup_procs_write_start(buf, threadgroup, &lock_mode);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
@@ -5273,7 +5304,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	ret = cgroup_attach_task(dst_cgrp, task, threadgroup);
 
 out_finish:
-	cgroup_procs_write_finish(task, threadgroup_locked);
+	cgroup_procs_write_finish(task, lock_mode);
 out_unlock:
 	cgroup_kn_unlock(of->kn);
 
-- 
2.32.0.3.g01195cf9f


