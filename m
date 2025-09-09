Return-Path: <cgroups+bounces-9815-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47462B4A44E
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 09:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35787A1EEE
	for <lists+cgroups@lfdr.de>; Tue,  9 Sep 2025 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F9C244675;
	Tue,  9 Sep 2025 07:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u/Ws6pp6"
X-Original-To: cgroups@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244523D7F2;
	Tue,  9 Sep 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404549; cv=none; b=c7wvyJ27fEIhX0bHoIGpna+2Sym3BWo2dBKcu5Jw05Sw1uXt+UE2E89ZoAgb4iMzmDDbVDMI1hCEeoI5q23T9EzO7Z+eHncCB9e3EZ7Bli4+eQpEuwLud9+S/ljh0T/532tClgtj4NrJZ8cs3YZOGlsdh26SWkb+ty5YeoFEteA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404549; c=relaxed/simple;
	bh=MQNIWFXIGYqRfLqolINV5pkrx46U7YN+uDXMC8YLJAg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DNCCKLvtHa4BOathIpusuMW/NjoRl4uyTa4dWEeA6njwODrVvB6vgx3KFp9bDtgyDsg6hwv3L2NpL7a1RQ1LST9PiJNdW+9fDDCohoRK3oYJKQhVQZVM3wEVXQhtVLN/OAYW9E8X2xOS2LEvEOeeBS+5v9645ElNl7rystlUjl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u/Ws6pp6; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757404538; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=JahaFDOYLkjYX2+eJ9+FPO6GHiCSnDLa39UN+ObHkBo=;
	b=u/Ws6pp6G8Dmbxn+0iYnMoI/GvKsS7GQj2TWNHheq+7x7X9NR8ogMidsm81C0bH+Iyp3tno00z3DkGOR6sHNZu682EYUMcLSFn9yq2qjYeueOXSpAsFQP5AJe13+wWoxT0Zi6s6jjKbjRKirV1kAjncXHyKO/pZtlM9CqYnydbA=
Received: from localhost(mailfrom:escape@linux.alibaba.com fp:SMTPD_---0Wnd-YJQ_1757404537 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 15:55:38 +0800
From: Yi Tao <escape@linux.alibaba.com>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] cgroup: refactor the cgroup_attach_lock code to make it clearer
Date: Tue,  9 Sep 2025 15:55:30 +0800
Message-Id: <d4d27f16909eadf6a499971b63ed8bdacd85f71e.1757403652.git.escape@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <cover.1757403652.git.escape@linux.alibaba.com>
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com> <cover.1757403652.git.escape@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dynamic cgroup migration involving threadgroup locks can be in one of
three states: no lock held, holding the global lock, or holding a
per threadgroup lock. Explicitly declaring the different lock modes
to make the code easier to understand.

Signed-off-by: Yi Tao <escape@linux.alibaba.com>
---
 include/linux/cgroup-defs.h     | 11 ++++
 kernel/cgroup/cgroup-internal.h |  8 +--
 kernel/cgroup/cgroup-v1.c       | 14 ++---
 kernel/cgroup/cgroup.c          | 91 ++++++++++++++++++++++-----------
 4 files changed, 83 insertions(+), 41 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 552050bd2c02..d764eba041c6 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -146,6 +146,17 @@ enum {
 	__CFTYPE_ADDED		= (1 << 18),
 };
 
+enum {
+	/* Default */
+	CGRP_ATTACH_LOCK_GLOBAL,
+
+	/* When pid=0 && threadgroup=false, see comments in cgroup_procs_write_start */
+	CGRP_ATTACH_LOCK_NONE,
+
+	/* When favordynmods is on, see comments above CGRP_ROOT_FAVOR_DYNMODS */
+	CGRP_ATTACH_LOCK_PER_THREADGROUP,
+};
+
 /*
  * cgroup_file is the handle for a file instance created in a cgroup which
  * is used, for example, to generate file changed notifications.  This can
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 318cc7f22e2c..9de8ab47a335 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -249,12 +249,12 @@ int cgroup_migrate(struct task_struct *leader, bool threadgroup,
 
 int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 		       bool threadgroup);
-void cgroup_attach_lock(bool lock_threadgroup, struct task_struct *tsk);
-void cgroup_attach_unlock(bool lock_threadgroup, struct task_struct *tsk);
+void cgroup_attach_lock(int lock_mode, struct task_struct *tsk);
+void cgroup_attach_unlock(int lock_mode, struct task_struct *tsk);
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
-					     bool *locked)
+					     int *lock_mode)
 	__acquires(&cgroup_threadgroup_rwsem);
-void cgroup_procs_write_finish(struct task_struct *task, bool locked)
+void cgroup_procs_write_finish(struct task_struct *task, int locke_mode)
 	__releases(&cgroup_threadgroup_rwsem);
 
 void cgroup_lock_and_drain_offline(struct cgroup *cgrp);
diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 65e9b454780c..73d8dafe219f 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -68,7 +68,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 	int retval = 0;
 
 	cgroup_lock();
-	cgroup_attach_lock(true, NULL);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	for_each_root(root) {
 		struct cgroup *from_cgrp;
 
@@ -80,7 +80,7 @@ int cgroup_attach_task_all(struct task_struct *from, struct task_struct *tsk)
 		if (retval)
 			break;
 	}
-	cgroup_attach_unlock(true, NULL);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	cgroup_unlock();
 
 	return retval;
@@ -117,7 +117,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 
 	cgroup_lock();
 
-	cgroup_attach_lock(true, NULL);
+	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 
 	/* all tasks in @from are being moved, all csets are source */
 	spin_lock_irq(&css_set_lock);
@@ -153,7 +153,7 @@ int cgroup_transfer_tasks(struct cgroup *to, struct cgroup *from)
 	} while (task && !ret);
 out_err:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(true, NULL);
+	cgroup_attach_unlock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
 	cgroup_unlock();
 	return ret;
 }
@@ -502,13 +502,13 @@ static ssize_t __cgroup1_procs_write(struct kernfs_open_file *of,
 	struct task_struct *task;
 	const struct cred *cred, *tcred;
 	ssize_t ret;
-	bool locked;
+	int lock_mode;
 
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
index 6e90b79e8fa3..a568629f7ed0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -2477,7 +2477,7 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
 
 /**
  * cgroup_attach_lock - Lock for ->attach()
- * @lock_threadgroup: whether to down_write rwsem
+ * @lock_mode: whether acquire and acquire which rwsem
  * @tsk: thread group to lock
  *
  * cgroup migration sometimes needs to stabilize threadgroups against forks and
@@ -2499,35 +2499,46 @@ EXPORT_SYMBOL_GPL(cgroup_path_ns);
  * write-locking cgroup_threadgroup_rwsem. This allows ->attach() to assume that
  * CPU hotplug is disabled on entry.
  *
- * When favordynmods is enabled, take per threadgroup rwsem to reduce overhead
- * on dynamic cgroup modifications. see the comment above
- * CGRP_ROOT_FAVOR_DYNMODS definition.
- *
  * tsk is not NULL only when writing to cgroup.procs.
  */
-void cgroup_attach_lock(bool lock_threadgroup, struct task_struct *tsk)
+void cgroup_attach_lock(int lock_mode, struct task_struct *tsk)
 {
 	cpus_read_lock();
-	if (lock_threadgroup) {
-		if (tsk && cgroup_enable_per_threadgroup_rwsem)
-			down_write(&tsk->signal->cgroup_threadgroup_rwsem);
-		else
-			percpu_down_write(&cgroup_threadgroup_rwsem);
+
+	switch (lock_mode) {
+	case CGRP_ATTACH_LOCK_NONE:
+		break;
+	case CGRP_ATTACH_LOCK_GLOBAL:
+		percpu_down_write(&cgroup_threadgroup_rwsem);
+		break;
+	case CGRP_ATTACH_LOCK_PER_THREADGROUP:
+		down_write(&tsk->signal->cgroup_threadgroup_rwsem);
+		break;
+	default:
+		pr_warn("cgroup: Unexpected attach lock mode.");
+		break;
 	}
 }
 
 /**
  * cgroup_attach_unlock - Undo cgroup_attach_lock()
- * @lock_threadgroup: whether to up_write rwsem
+ * @lock_mode: whether release and release which rwsem
  * @tsk: thread group to lock
  */
-void cgroup_attach_unlock(bool lock_threadgroup, struct task_struct *tsk)
-{
-	if (lock_threadgroup) {
-		if (tsk && cgroup_enable_per_threadgroup_rwsem)
-			up_write(&tsk->signal->cgroup_threadgroup_rwsem);
-		else
-			percpu_up_write(&cgroup_threadgroup_rwsem);
+void cgroup_attach_unlock(int lock_mode, struct task_struct *tsk)
+{
+	switch (lock_mode) {
+	case CGRP_ATTACH_LOCK_NONE:
+		break;
+	case CGRP_ATTACH_LOCK_GLOBAL:
+		percpu_up_write(&cgroup_threadgroup_rwsem);
+		break;
+	case CGRP_ATTACH_LOCK_PER_THREADGROUP:
+		up_write(&tsk->signal->cgroup_threadgroup_rwsem);
+		break;
+	default:
+		pr_warn("cgroup: Unexpected attach lock mode.");
+		break;
 	}
 	cpus_read_unlock();
 }
@@ -3002,7 +3013,7 @@ int cgroup_attach_task(struct cgroup *dst_cgrp, struct task_struct *leader,
 }
 
 struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
-					     bool *threadgroup_locked)
+					     int *lock_mode)
 {
 	struct task_struct *tsk;
 	pid_t pid;
@@ -3046,11 +3057,24 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
 	 * callers by cgroup_mutex.
 	 * Therefore, we can skip the global lock.
+	 *
+	 * When favordynmods is enabled, take per threadgroup rwsem to reduce
+	 * overhead on dynamic cgroup modifications. see the comment above
+	 * CGRP_ROOT_FAVOR_DYNMODS definition.
 	 */
 	lockdep_assert_held(&cgroup_mutex);
-	*threadgroup_locked = pid || threadgroup;
 
-	cgroup_attach_lock(*threadgroup_locked, tsk);
+	if (pid || threadgroup) {
+		if (cgroup_enable_per_threadgroup_rwsem)
+			*lock_mode = CGRP_ATTACH_LOCK_PER_THREADGROUP;
+		else
+			*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
+
+	} else {
+		*lock_mode = CGRP_ATTACH_LOCK_NONE;
+	}
+
+	cgroup_attach_lock(*lock_mode, tsk);
 
 	if (threadgroup) {
 		if (!thread_group_leader(tsk)) {
@@ -3061,7 +3085,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 			 * try again; this is
 			 * "double-double-toil-and-trouble-check locking".
 			 */
-			cgroup_attach_unlock(*threadgroup_locked, tsk);
+			cgroup_attach_unlock(*lock_mode, tsk);
 			put_task_struct(tsk);
 			goto retry_find_task;
 		}
@@ -3074,7 +3098,7 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
 	return tsk;
 }
 
-void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked)
+void cgroup_procs_write_finish(struct task_struct *task, int lock_mode)
 {
 	struct cgroup_subsys *ss;
 	int ssid;
@@ -3082,7 +3106,7 @@ void cgroup_procs_write_finish(struct task_struct *task, bool threadgroup_locked
 	/* release reference from cgroup_procs_write_start() */
 	put_task_struct(task);
 
-	cgroup_attach_unlock(threadgroup_locked, task);
+	cgroup_attach_unlock(lock_mode, task);
 
 	for_each_subsys(ss, ssid)
 		if (ss->post_attach)
@@ -3139,6 +3163,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	struct cgroup *dsct;
 	struct css_set *src_cset;
 	bool has_tasks;
+	int lock_mode;
 	int ret;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -3169,7 +3194,13 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	 * write-locking can be skipped safely.
 	 */
 	has_tasks = !list_empty(&mgctx.preloaded_src_csets);
-	cgroup_attach_lock(has_tasks, NULL);
+
+	if (has_tasks)
+		lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
+	else
+		lock_mode = CGRP_ATTACH_LOCK_NONE;
+
+	cgroup_attach_lock(lock_mode, NULL);
 
 	/* NULL dst indicates self on default hierarchy */
 	ret = cgroup_migrate_prepare_dst(&mgctx);
@@ -3190,7 +3221,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 	ret = cgroup_migrate_execute(&mgctx);
 out_finish:
 	cgroup_migrate_finish(&mgctx);
-	cgroup_attach_unlock(has_tasks, NULL);
+	cgroup_attach_unlock(lock_mode, NULL);
 	return ret;
 }
 
@@ -5291,13 +5322,13 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	struct task_struct *task;
 	const struct cred *saved_cred;
 	ssize_t ret;
-	bool threadgroup_locked;
+	int lock_mode;
 
 	dst_cgrp = cgroup_kn_lock_live(of->kn, false);
 	if (!dst_cgrp)
 		return -ENODEV;
 
-	task = cgroup_procs_write_start(buf, threadgroup, &threadgroup_locked);
+	task = cgroup_procs_write_start(buf, threadgroup, &lock_mode);
 	ret = PTR_ERR_OR_ZERO(task);
 	if (ret)
 		goto out_unlock;
@@ -5323,7 +5354,7 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	ret = cgroup_attach_task(dst_cgrp, task, threadgroup);
 
 out_finish:
-	cgroup_procs_write_finish(task, threadgroup_locked);
+	cgroup_procs_write_finish(task, lock_mode);
 out_unlock:
 	cgroup_kn_unlock(of->kn);
 
-- 
2.32.0.3.g01195cf9f


