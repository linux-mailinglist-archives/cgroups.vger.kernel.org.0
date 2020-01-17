Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93C02141089
	for <lists+cgroups@lfdr.de>; Fri, 17 Jan 2020 19:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgAQSM3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 17 Jan 2020 13:12:29 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52141 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgAQSM3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 17 Jan 2020 13:12:29 -0500
Received: from ip5f5bd679.dynamic.kabel-deutschland.de ([95.91.214.121] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1isW6c-0005Yu-Qe; Fri, 17 Jan 2020 18:12:26 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org
Subject: [PATCH v4 3/6] cgroup: refactor fork helpers
Date:   Fri, 17 Jan 2020 19:12:16 +0100
Message-Id: <20200117181219.14542-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200117181219.14542-1-christian.brauner@ubuntu.com>
References: <20200117181219.14542-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This refactors the fork helpers so they can be easily modified in the
next patches. The patch just passes in the parent task_struct and moves
the cgroup threadgroup rwsem grab and release into the helpers. The
don't need to be directly exposed in fork.c.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
patch not present

/* v2 */
patch not present

/* v3 */
Link: https://lore.kernel.org/r/20200117002143.15559-4-christian.brauner@ubuntu.com
patch introduced
- Tejun Heo <tj@kernel.org>:
  - split into separate commmit

/* v4 */
unchanged
---
 include/linux/cgroup.h | 18 +++++++++-----
 kernel/cgroup/cgroup.c | 56 ++++++++++++++++++++++++++----------------
 kernel/fork.c          | 12 +++------
 3 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index d7ddebd0cdec..5349465bfac1 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -121,9 +121,12 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 		     struct pid *pid, struct task_struct *tsk);
 
 void cgroup_fork(struct task_struct *p);
-extern int cgroup_can_fork(struct task_struct *p);
-extern void cgroup_cancel_fork(struct task_struct *p);
-extern void cgroup_post_fork(struct task_struct *p);
+extern int cgroup_can_fork(struct task_struct *parent,
+			   struct task_struct *child);
+extern void cgroup_cancel_fork(struct task_struct *parent,
+			       struct task_struct *child);
+extern void cgroup_post_fork(struct task_struct *parent,
+			     struct task_struct *child);
 void cgroup_exit(struct task_struct *p);
 void cgroup_release(struct task_struct *p);
 void cgroup_free(struct task_struct *p);
@@ -707,9 +710,12 @@ static inline int cgroupstats_build(struct cgroupstats *stats,
 				    struct dentry *dentry) { return -EINVAL; }
 
 static inline void cgroup_fork(struct task_struct *p) {}
-static inline int cgroup_can_fork(struct task_struct *p) { return 0; }
-static inline void cgroup_cancel_fork(struct task_struct *p) {}
-static inline void cgroup_post_fork(struct task_struct *p) {}
+static inline int cgroup_can_fork(struct task_struct *parent,
+				  struct task_struct *child) { return 0; }
+static inline void cgroup_cancel_fork(struct task_struct *parent,
+			       struct task_struct *child) {};
+static inline void cgroup_post_fork(struct task_struct *parent,
+				    struct task_struct *child) {};
 static inline void cgroup_exit(struct task_struct *p) {}
 static inline void cgroup_release(struct task_struct *p) {}
 static inline void cgroup_free(struct task_struct *p) {}
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index f05efc2677c8..49d8cf087e10 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5902,17 +5902,22 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 
 /**
  * cgroup_can_fork - called on a new task before the process is exposed
- * @child: the task in question.
+ * @parent: the parent process of @child
+ * @child: the child process of @parent
+ * @kargs: the arguments passed to create the child process
  *
- * This calls the subsystem can_fork() callbacks. If the can_fork() callback
- * returns an error, the fork aborts with that error code. This allows for
- * a cgroup subsystem to conditionally allow or deny new forks.
+ * This calls the subsystem can_fork() callbacks. If the cgroup_can_fork()
+ * callback returns an error, the fork aborts with that error code. This
+ * allows for a cgroup subsystem to conditionally allow or deny new forks.
  */
-int cgroup_can_fork(struct task_struct *child)
+int cgroup_can_fork(struct task_struct *parent, struct task_struct *child)
+	__acquires(&cgroup_threadgroup_rwsem) __releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	int i, j, ret;
 
+	cgroup_threadgroup_change_begin(parent);
+
 	do_each_subsys_mask(ss, i, have_canfork_callback) {
 		ret = ss->can_fork(child);
 		if (ret)
@@ -5929,17 +5934,22 @@ int cgroup_can_fork(struct task_struct *child)
 			ss->cancel_fork(child);
 	}
 
+	cgroup_threadgroup_change_end(parent);
+
 	return ret;
 }
 
 /**
- * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
- * @child: the task in question
- *
- * This calls the cancel_fork() callbacks if a fork failed *after*
- * cgroup_can_fork() succeded.
- */
-void cgroup_cancel_fork(struct task_struct *child)
+  * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
+  * @parent: the parent process of @child
+  * @child: the child process of @parent
+  * @kargs: the arguments passed to create the child process
+  *
+  * This calls the cancel_fork() callbacks if a fork failed *after*
+  * cgroup_can_fork() succeded.
+  */
+void cgroup_cancel_fork(struct task_struct *parent, struct task_struct *child)
+	__releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	int i;
@@ -5947,19 +5957,21 @@ void cgroup_cancel_fork(struct task_struct *child)
 	for_each_subsys(ss, i)
 		if (ss->cancel_fork)
 			ss->cancel_fork(child);
+
+	cgroup_threadgroup_change_end(parent);
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
+ * cgroup_post_fork - finalize cgroup setup for the child process
+ * @parent: the parent process of @child
+ * @child: the child process of @parent
+ * @kargs: the arguments passed to create the child process
+ *
+ * Attach the child process to its css_set calling the subsystem fork()
+ * callbacks.
  */
-void cgroup_post_fork(struct task_struct *child)
+void cgroup_post_fork(struct task_struct *parent, struct task_struct *child)
+	__releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	struct css_set *cset;
@@ -6002,6 +6014,8 @@ void cgroup_post_fork(struct task_struct *child)
 	do_each_subsys_mask(ss, i, have_fork_callback) {
 		ss->fork(child);
 	} while_each_subsys_mask();
+
+	cgroup_threadgroup_change_end(parent);
 }
 
 /**
diff --git a/kernel/fork.c b/kernel/fork.c
index 080809560072..c76758dbd594 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2165,16 +2165,15 @@ static __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->thread_group);
 	p->task_works = NULL;
 
-	cgroup_threadgroup_change_begin(current);
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted the the new process's css_set can be changed
 	 * between here and cgroup_post_fork() if an organisation operation is in
 	 * progress.
 	 */
-	retval = cgroup_can_fork(p);
+	retval = cgroup_can_fork(current, p);
 	if (retval)
-		goto bad_fork_cgroup_threadgroup_change_end;
+		goto bad_fork_put_pidfd;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2279,8 +2278,7 @@ static __latent_entropy struct task_struct *copy_process(
 	write_unlock_irq(&tasklist_lock);
 
 	proc_fork_connector(p);
-	cgroup_post_fork(p);
-	cgroup_threadgroup_change_end(current);
+	cgroup_post_fork(current, p);
 	perf_event_fork(p);
 
 	trace_task_newtask(p, clone_flags);
@@ -2291,9 +2289,7 @@ static __latent_entropy struct task_struct *copy_process(
 bad_fork_cancel_cgroup:
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
-	cgroup_cancel_fork(p);
-bad_fork_cgroup_threadgroup_change_end:
-	cgroup_threadgroup_change_end(current);
+	cgroup_cancel_fork(current, p);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
 		fput(pidfile);
-- 
2.25.0

