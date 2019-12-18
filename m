Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97F8C124F7C
	for <lists+cgroups@lfdr.de>; Wed, 18 Dec 2019 18:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLRRiV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Dec 2019 12:38:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40849 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727368AbfLRRiU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Dec 2019 12:38:20 -0500
Received: from host.242.234.23.62.rev.coltfrance.com ([62.23.234.242] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ihdGp-00046Q-5w; Wed, 18 Dec 2019 17:37:59 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: [PATCH 2/3] clone3: allow spawning processes into cgroups
Date:   Wed, 18 Dec 2019 18:35:15 +0100
Message-Id: <20191218173516.7875-3-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191218173516.7875-1-christian.brauner@ubuntu.com>
References: <20191218173516.7875-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This adds support for creating a process in a different cgroup than its
parent. Callers can limit and account processes and threads right from
the moment they are spawned:
- A service manager can directly spawn new services into dedicated
  cgroups.
- A process can be directly created in a frozen cgroup and will be
  frozen as well.
- The initial accounting jitter experienced by process supervisors and
  daemons is eliminated with this.
- Threaded applications or even thread implementations can choose to
  create a specific cgroup layout where each thread is spawned
  directly into a dedicated cgroup.

This feature is limited to the unified hierarchy. Callers need to pass
an directory file descriptor for the target cgroup. The caller can
choose to pass an O_PATH file descriptor. All usual migration
restrictions apply, i.e. there can be no processes in inner nodes. In
general, creating a process directly in a target cgroup adheres to all
migration restrictions.

Cc: Tejun Heo <tj@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/cgroup-defs.h |   7 +-
 include/linux/cgroup.h      |  25 +++-
 include/linux/sched/task.h  |   4 +
 include/uapi/linux/sched.h  |   5 +
 kernel/cgroup/cgroup.c      | 254 +++++++++++++++++++++++++++++++-----
 kernel/cgroup/pids.c        |  25 +++-
 kernel/fork.c               |  18 ++-
 7 files changed, 287 insertions(+), 51 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 63097cb243cb..cd848c6bac4a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -33,6 +33,7 @@ struct kernfs_ops;
 struct kernfs_open_file;
 struct seq_file;
 struct poll_table_struct;
+struct kernel_clone_args;
 
 #define MAX_CGROUP_TYPE_NAMELEN 32
 #define MAX_CGROUP_ROOT_NAMELEN 64
@@ -628,8 +629,10 @@ struct cgroup_subsys {
 	void (*cancel_attach)(struct cgroup_taskset *tset);
 	void (*attach)(struct cgroup_taskset *tset);
 	void (*post_attach)(void);
-	int (*can_fork)(struct task_struct *task);
-	void (*cancel_fork)(struct task_struct *task);
+	int (*can_fork)(struct task_struct *parent, struct task_struct *child,
+			struct kernel_clone_args *kargs);
+	void (*cancel_fork)(struct task_struct *child,
+			    struct kernel_clone_args *kargs);
 	void (*fork)(struct task_struct *task);
 	void (*exit)(struct task_struct *task);
 	void (*release)(struct task_struct *task);
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index d7ddebd0cdec..69b97941addb 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -70,6 +70,7 @@ struct css_task_iter {
 
 extern struct cgroup_root cgrp_dfl_root;
 extern struct css_set init_css_set;
+struct kernel_clone_args;
 
 #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
 #include <linux/cgroup_subsys.h>
@@ -121,9 +122,15 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
 
 void cgroup_fork(struct task_struct *p);
-extern int cgroup_can_fork(struct task_struct *p);
-extern void cgroup_cancel_fork(struct task_struct *p);
-extern void cgroup_post_fork(struct task_struct *p);
+extern int cgroup_can_fork(struct task_struct *parent,
+			   struct task_struct *child,
+			   struct kernel_clone_args *kargs);
+extern void cgroup_cancel_fork(struct task_struct *p,
+			       struct kernel_clone_args *kargs);
+extern void cgroup_post_fork(struct task_struct *child,
+			     struct kernel_clone_args *kargs);
+extern int cgroup_lock_fork(struct kernel_clone_args *kargs);
+extern void cgroup_unlock_fork(struct kernel_clone_args *kargs);
 void cgroup_exit(struct task_struct *p);
 void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
@@ -707,9 +714,15 @@ static inline int cgroupstats_build(struct cgroupstats *stats,
 				    struct dentry *dentry) { return -EINVAL; }
 
 static inline void cgroup_fork(struct task_struct *p) {}
-static inline int cgroup_can_fork(struct task_struct *p) { return 0; }
-static inline void cgroup_cancel_fork(struct task_struct *p) {}
-static inline void cgroup_post_fork(struct task_struct *p) {}
+static inline int cgroup_can_fork(struct task_struct *parent,
+				  struct task_struct *child,
+				  struct kernel_clone_args *kargs) { return 0; }
+static inline void cgroup_cancel_fork(struct task_struct *p,
+				      struct kernel_clone_args *kargs) {}
+static inline void cgroup_post_fork(struct task_struct *child,
+				    struct kernel_clone_args *kargs) {}
+static int cgroup_lock_fork(struct kernel_clone_args *kargs) { return 0; }
+static void cgroup_unlock_fork(struct kernel_clone_args *kargs) {}
 static inline void cgroup_exit(struct task_struct *p) {}
 static inline void cgroup_release(struct task_struct *p) {}
 static inline void cgroup_free(struct task_struct *p) {}
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index f1879884238e..38359071236a 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -13,6 +13,7 @@
 struct task_struct;
 struct rusage;
 union thread_union;
+struct css_set;
 
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
@@ -29,6 +30,9 @@ struct kernel_clone_args {
 	pid_t *set_tid;
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
+	int cgroup;
+	struct cgroup *cgrp;
+	struct css_set *cset;
 };
 
 /*
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 4a0217832464..08620c220f30 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -35,6 +35,7 @@
 
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
+#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
 
 #ifndef __ASSEMBLY__
 /**
@@ -75,6 +76,8 @@
  * @set_tid_size: This defines the size of the array referenced
  *                in @set_tid. This cannot be larger than the
  *                kernel's limit of nested PID namespaces.
+ * @cgroup:       If CLONE_INTO_CGROUP is specified set this to
+ *                a file descriptor for the cgroup.
  *
  * The structure is versioned by size and thus extensible.
  * New struct members must go at the end of the struct and
@@ -91,11 +94,13 @@ struct clone_args {
 	__aligned_u64 tls;
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
+	__aligned_u64 cgroup;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
+#define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
 
 /*
  * Scheduling policies
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5ee06c1f7456..db3b697d6a51 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5882,21 +5882,155 @@ void cgroup_fork(struct task_struct *child)
 	INIT_LIST_HEAD(&child->cg_list);
 }
 
+static struct cgroup *cgroup_get_from_file(struct file *f)
+{
+	struct cgroup_subsys_state *css;
+	struct cgroup *cgrp;
+
+	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
+	if (IS_ERR(css))
+		return ERR_CAST(css);
+
+	cgrp = css->cgroup;
+	if (!cgroup_on_dfl(cgrp)) {
+		cgroup_put(cgrp);
+		return ERR_PTR(-EBADF);
+	}
+
+	return cgrp;
+}
+
 /**
- * cgroup_can_fork - called on a new task before the process is exposed
- * @child: the task in question.
+ * cgroup_css_set_fork - find or create a css_set for a child process
+ * @parent: the parent of the child process
+ * @kargs: the arguments passed to create the child process
+ *
+ * This functions finds or creates a new css_set which the child
+ * process will be attached to in cgroup_post_fork(). By default,
+ * the child process will be given the same css_set as its parent.
+ *
+ * If CLONE_INTO_CGROUP is specified this function will try to find an
+ * existing css_set which includes the request cgorup and if not create
+ * new css_set that the child will be attached to. After this function
+ * returns when CLONE_INTO_CGROUP is used we will hold a reference to the
+ * target cgroup. This is done so we can check whether the cgroup is
+ * still alive when we retake the cgroup_mutex in cgroup_lock_fork().
+ * The reference is dropped in cgroup_post_fork().
  *
- * This calls the subsystem can_fork() callbacks. If the can_fork() callback
- * returns an error, the fork aborts with that error code. This allows for
- * a cgroup subsystem to conditionally allow or deny new forks.
  */
-int cgroup_can_fork(struct task_struct *child)
+static int cgroup_css_set_fork(struct task_struct *parent,
+			       struct kernel_clone_args *kargs)
+	__acquires(&cgroup_mutex) __releases(&cgroup_mutex)
+{
+	int ret;
+	struct cgroup *dst_cgrp, *src_cgrp;
+	struct css_set *cset;
+	struct super_block *sb;
+	struct file *f;
+
+	spin_lock_irq(&css_set_lock);
+	cset = task_css_set(parent);
+	get_css_set(cset);
+	spin_unlock_irq(&css_set_lock);
+
+	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
+		kargs->cset = cset;
+		return 0;
+	}
+
+	f = fget_raw(kargs->cgroup);
+	if (!f) {
+		put_css_set(cset);
+		return -EBADF;
+	}
+	sb = f->f_path.dentry->d_sb;
+
+	dst_cgrp = cgroup_get_from_file(f);
+	if (IS_ERR(dst_cgrp)) {
+		put_css_set(cset);
+		fput(f);
+		return PTR_ERR(dst_cgrp);
+	}
+
+	mutex_lock(&cgroup_mutex);
+
+	spin_lock_irq(&css_set_lock);
+	src_cgrp = task_cgroup_from_root(parent, &cgrp_dfl_root);
+	spin_unlock_irq(&css_set_lock);
+
+	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp, sb,
+					!!(kargs->flags & CLONE_THREAD));
+	if (!ret)
+		kargs->cset = find_css_set(cset, dst_cgrp);
+
+	mutex_unlock(&cgroup_mutex);
+
+	put_css_set(cset);
+	fput(f);
+
+	if (!ret && !kargs->cset)
+		ret = -ENOMEM;
+
+	if (ret)
+		cgroup_put(dst_cgrp);
+	else
+		kargs->cgrp = dst_cgrp;
+
+	return ret;
+}
+
+/**
+ * cgroup_css_set_put_fork - drop references we took during fork
+ * @parent: the parent of the child process
+ * @kargs: the arguments passed to create the child process
+ *
+ * Drop references to the prepared css_set and target cgroup if
+ * CLONE_INTO_CGROUP was requested.
+ * This is only valid to call before fork()'s point of no return.
+ */
+static void cgroup_css_set_put_fork(struct kernel_clone_args *kargs)
+{
+	struct cgroup *cgrp;
+	struct css_set *cset;
+
+	if (!(kargs->flags & CLONE_INTO_CGROUP))
+		return;
+
+	cset = kargs->cset;
+	if (cset)
+		put_css_set(cset);
+	kargs->cset = NULL;
+
+	cgrp = kargs->cgrp;
+	if (cgrp)
+		cgroup_put(cgrp);
+	kargs->cgrp = NULL;
+}
+
+/**
+ * cgroup_can_fork - called on a new task before the process is exposed
+ * @parent: the parent process of @child
+ * @child: the child process of @parent
+ * @kargs: the arguments passed to create the child process
+ *
+ * This prepares a new css_set for the child process which the child will
+ * be attached to in cgroup_post_fork().
+ * This calls the subsystem can_fork() callbacks. If the cgroup_can_fork()
+ * callback returns an error, the fork aborts with that error code. This allows
+ * for a cgroup subsystem to conditionally allow or deny new forks.
+ */
+int cgroup_can_fork(struct task_struct *parent, struct task_struct *child,
+			struct kernel_clone_args *kargs)
 {
 	struct cgroup_subsys *ss;
 	int i, j, ret;
 
+	ret = cgroup_css_set_fork(parent, kargs);
+	if (ret)
+		return ret;
+
 	do_each_subsys_mask(ss, i, have_canfork_callback) {
-		ret = ss->can_fork(child);
+		ret = ss->can_fork(parent, child, kargs);
 		if (ret)
 			goto out_revert;
 	} while_each_subsys_mask();
@@ -5908,50 +6042,110 @@ int cgroup_can_fork(struct task_struct *child)
 		if (j >= i)
 			break;
 		if (ss->cancel_fork)
-			ss->cancel_fork(child);
+			ss->cancel_fork(child, kargs);
 	}
 
+	cgroup_css_set_put_fork(kargs);
+
 	return ret;
 }
 
 /**
  * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
- * @child: the task in question
+ * @child: the child process of @parent
+ * @kargs: the arguments passed to create the child process
  *
  * This calls the cancel_fork() callbacks if a fork failed *after*
- * cgroup_can_fork() succeded.
+ * cgroup_can_fork() succeded and cleans up references we took to
+ * prepare a new css_set for the child process in cgroup_can_fork().
  */
-void cgroup_cancel_fork(struct task_struct *child)
+void cgroup_cancel_fork(struct task_struct *child,
+			struct kernel_clone_args *kargs)
 {
 	struct cgroup_subsys *ss;
 	int i;
 
 	for_each_subsys(ss, i)
 		if (ss->cancel_fork)
-			ss->cancel_fork(child);
+			ss->cancel_fork(child, kargs);
+
+	cgroup_css_set_put_fork(kargs);
 }
 
 /**
- * cgroup_post_fork - called on a new task after adding it to the task list
- * @child: the task in question
- *
- * Adds the task to the list running through its css_set if necessary and
- * call the subsystem fork() callbacks.  Has to be after the task is
- * visible on the task list in case we race with the first call to
- * cgroup_task_iter_start() - to guarantee that the new task ends up on its
- * list.
+ * cgroup_lock_fork - take cgroup mutex and verify cgroup is alive
+ * @kargs: the arguments passed to create the child process
+ *
+ * If CLONE_INTO_CGROUP was specified we take the cgroup mutex and
+ * check whether the target cgroup is still alive. If this function
+ * returns successfully we are protected against cgroup removal
+ * since rmdir acquires the cgroup mutex. cgroup_post_fork() can then
+ * safely attach the child process to its css_set which includes the
+ * new cgroup.
+ * Only call right before fork()'s point of no return.
  */
-void cgroup_post_fork(struct task_struct *child)
+int cgroup_lock_fork(struct kernel_clone_args *kargs)
+	__acquires(&cgroup_mutex)
+{
+	struct cgroup *cgrp;
+
+	if (!(kargs->flags & CLONE_INTO_CGROUP))
+		return 0;
+
+	cgrp = kargs->cgrp;
+	if (!cgrp)
+		return 0;
+
+	mutex_lock(&cgroup_mutex);
+
+	if (!cgroup_is_dead(cgrp))
+		return 0;
+
+	mutex_unlock(&cgroup_mutex);
+	return -ENODEV;
+}
+
+/**
+ * cgroup_unlock_fork - drop the cgroup mutex if we had to take it
+ * @kargs: the arguments passed to create the child process
+ *
+ * If CLONE_INTO_CGROUP was specified drop the reference
+ * we took on the target cgroup in cgroup_css_set_fork() and
+ * release the cgroup mutex.
+ */
+void cgroup_unlock_fork(struct kernel_clone_args *kargs)
+	__releases(&cgroup_mutex)
+{
+	struct cgroup *cgrp;
+
+	if (!(kargs->flags & CLONE_INTO_CGROUP))
+		return;
+
+	mutex_unlock(&cgroup_mutex);
+
+	cgrp = kargs->cgrp;
+	cgroup_put(cgrp);
+	kargs->cgrp = NULL;
+}
+
+/**
+ * cgroup_post_fork - finalize cgroup setup for the child process
+ * @child: the child process
+ * @kargs: the arguments passed to create the child process
+ *
+ * Attach the child process to its css_set calling the subsystem fork()
+ * callbacks.
+ */
+void cgroup_post_fork(struct task_struct *child,
+		      struct kernel_clone_args *kargs)
 {
 	struct cgroup_subsys *ss;
-	struct css_set *cset;
+	struct css_set *cset = kargs->cset;
 	int i;
 
 	spin_lock_irq(&css_set_lock);
 
 	WARN_ON_ONCE(!list_empty(&child->cg_list));
-	cset = task_css_set(current); /* current is @child's parent */
-	get_css_set(cset);
 	cset->nr_tasks++;
 	css_set_move_task(child, NULL, cset, false);
 
@@ -6170,7 +6364,6 @@ EXPORT_SYMBOL_GPL(cgroup_get_from_path);
  */
 struct cgroup *cgroup_get_from_fd(int fd)
 {
-	struct cgroup_subsys_state *css;
 	struct cgroup *cgrp;
 	struct file *f;
 
@@ -6178,17 +6371,8 @@ struct cgroup *cgroup_get_from_fd(int fd)
 	if (!f)
 		return ERR_PTR(-EBADF);
 
-	css = css_tryget_online_from_dir(f->f_path.dentry, NULL);
+	cgrp = cgroup_get_from_file(f);
 	fput(f);
-	if (IS_ERR(css))
-		return ERR_CAST(css);
-
-	cgrp = css->cgroup;
-	if (!cgroup_on_dfl(cgrp)) {
-		cgroup_put(cgrp);
-		return ERR_PTR(-EBADF);
-	}
-
 	return cgrp;
 }
 EXPORT_SYMBOL_GPL(cgroup_get_from_fd);
diff --git a/kernel/cgroup/pids.c b/kernel/cgroup/pids.c
index 138059eb730d..e5955bc1fb00 100644
--- a/kernel/cgroup/pids.c
+++ b/kernel/cgroup/pids.c
@@ -33,6 +33,7 @@
 #include <linux/atomic.h>
 #include <linux/cgroup.h>
 #include <linux/slab.h>
+#include <linux/sched/task.h>
 
 #define PIDS_MAX (PID_MAX_LIMIT + 1ULL)
 #define PIDS_MAX_STR "max"
@@ -214,13 +215,21 @@ static void pids_cancel_attach(struct cgroup_taskset *tset)
  * task_css_check(true) in pids_can_fork() and pids_cancel_fork() relies
  * on cgroup_threadgroup_change_begin() held by the copy_process().
  */
-static int pids_can_fork(struct task_struct *task)
+static int pids_can_fork(struct task_struct *parent, struct task_struct *child,
+			 struct kernel_clone_args *args)
 {
+	struct css_set *new_cset = NULL;
 	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids;
 	int err;
 
-	css = task_css_check(current, pids_cgrp_id, true);
+	if (args)
+		new_cset = args->cset;
+
+	if (!new_cset)
+		css = task_css_check(current, pids_cgrp_id, true);
+	else
+		css = new_cset->subsys[pids_cgrp_id];
 	pids = css_pids(css);
 	err = pids_try_charge(pids, 1);
 	if (err) {
@@ -235,12 +244,20 @@ static int pids_can_fork(struct task_struct *task)
 	return err;
 }
 
-static void pids_cancel_fork(struct task_struct *task)
+static void pids_cancel_fork(struct task_struct *task,
+			     struct kernel_clone_args *args)
 {
+	struct css_set *new_cset = NULL;
 	struct cgroup_subsys_state *css;
 	struct pids_cgroup *pids;
 
-	css = task_css_check(current, pids_cgrp_id, true);
+	if (args)
+		new_cset = args->cset;
+
+	if (!new_cset)
+		css = task_css_check(current, pids_cgrp_id, true);
+	else
+		css = new_cset->subsys[pids_cgrp_id];
 	pids = css_pids(css);
 	pids_uncharge(pids, 1);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 2508a4f238a3..59868af9ac4f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2172,7 +2172,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 * between here and cgroup_post_fork() if an organisation operation is in
 	 * progress.
 	 */
-	retval = cgroup_can_fork(p);
+	retval = cgroup_can_fork(current, p, args);
 	if (retval)
 		goto bad_fork_cgroup_threadgroup_change_end;
 
@@ -2226,6 +2226,10 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cancel_cgroup;
 	}
 
+	retval = cgroup_lock_fork(args);
+	if (retval)
+		goto bad_fork_cancel_cgroup;
+
 	/* past the last point of failure */
 	if (pidfile)
 		fd_install(pidfd, pidfile);
@@ -2279,7 +2283,8 @@ static __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 
 	proc_fork_connector(p);
-	cgroup_post_fork(p);
+	cgroup_post_fork(p, args);
+	cgroup_unlock_fork(args);
 	cgroup_threadgroup_change_end(current);
 	perf_event_fork(p);
 
@@ -2291,7 +2296,7 @@ static __latent_entropy struct task_struct *copy_process(
 bad_fork_cancel_cgroup:
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
-	cgroup_cancel_fork(p);
+	cgroup_cancel_fork(p, args);
 bad_fork_cgroup_threadgroup_change_end:
 	cgroup_threadgroup_change_end(current);
 bad_fork_put_pidfd:
@@ -2612,6 +2617,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     !valid_signal(args.exit_signal)))
 		return -EINVAL;
 
+	if ((args.flags & CLONE_INTO_CGROUP) && args.cgroup < 0)
+		return -EINVAL;
+
 	*kargs = (struct kernel_clone_args){
 		.flags		= args.flags,
 		.pidfd		= u64_to_user_ptr(args.pidfd),
@@ -2622,6 +2630,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		.stack_size	= args.stack_size,
 		.tls		= args.tls,
 		.set_tid_size	= args.set_tid_size,
+		.cgroup		= args.cgroup,
 	};
 
 	if (args.set_tid &&
@@ -2665,7 +2674,8 @@ static inline bool clone3_stack_valid(struct kernel_clone_args *kargs)
 static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
-	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND))
+	if (kargs->flags &
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
 		return false;
 
 	/*
-- 
2.24.0

