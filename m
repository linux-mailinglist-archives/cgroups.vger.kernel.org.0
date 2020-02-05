Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5D1531BE
	for <lists+cgroups@lfdr.de>; Wed,  5 Feb 2020 14:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgBEN0s (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 5 Feb 2020 08:26:48 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:56955 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728057AbgBEN0s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 5 Feb 2020 08:26:48 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein.fritz.box)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1izKhZ-00035h-Ma; Wed, 05 Feb 2020 13:26:45 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v6 3/6] cgroup: refactor fork helpers
Date:   Wed,  5 Feb 2020 14:26:20 +0100
Message-Id: <20200205132623.670015-4-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200205132623.670015-1-christian.brauner@ubuntu.com>
References: <20200205132623.670015-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

This refactors the fork helpers so they can be easily modified in the
next patches. The patch just moves the cgroup threadgroup rwsem grab and
release into the helpers. They don't need to be directly exposed in fork.c.

Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Li Zefan <lizefan@huawei.com>
Cc: cgroups@vger.kernel.org
Acked-by: Michal Koutný <mkoutny@suse.com>
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
Link: https://lore.kernel.org/r/20200117181219.14542-4-christian.brauner@ubuntu.com
unchanged

/* v5 */
Link: https://lore.kernel.org/r/20200121154844.411-4-christian.brauner@ubuntu.com
- Oleg Nesterov <oleg@redhat.com>:
  - remove struct task_struct *parent argument from clone helpers in favor of
    using current directly
- Christian Brauner <christian.brauner@ubuntu.com>:
  - fix typo in commit message

/* v6 */
- Michal Koutný <mkoutny@suse.com>:
  - Remove "kargs" comments leftover from rebasing. They only become relevant
    in later commits.
---
 kernel/cgroup/cgroup.c | 44 +++++++++++++++++++++++++-----------------
 kernel/fork.c          |  6 +-----
 2 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7c1c8677849e..991f10662e95 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5895,17 +5895,20 @@ static struct cgroup *cgroup_get_from_file(struct file *f)
 
 /**
  * cgroup_can_fork - called on a new task before the process is exposed
- * @child: the task in question.
+ * @child: the child process
  *
- * This calls the subsystem can_fork() callbacks. If the can_fork() callback
- * returns an error, the fork aborts with that error code. This allows for
- * a cgroup subsystem to conditionally allow or deny new forks.
+ * This calls the subsystem can_fork() callbacks. If the cgroup_can_fork()
+ * callback returns an error, the fork aborts with that error code. This
+ * allows for a cgroup subsystem to conditionally allow or deny new forks.
  */
 int cgroup_can_fork(struct task_struct *child)
+	__acquires(&cgroup_threadgroup_rwsem) __releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	int i, j, ret;
 
+	cgroup_threadgroup_change_begin(current);
+
 	do_each_subsys_mask(ss, i, have_canfork_callback) {
 		ret = ss->can_fork(child);
 		if (ret)
@@ -5922,17 +5925,20 @@ int cgroup_can_fork(struct task_struct *child)
 			ss->cancel_fork(child);
 	}
 
+	cgroup_threadgroup_change_end(current);
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
+  * cgroup_cancel_fork - called if a fork failed after cgroup_can_fork()
+  * @child: the child process
+  *
+  * This calls the cancel_fork() callbacks if a fork failed *after*
+  * cgroup_can_fork() succeded.
+  */
 void cgroup_cancel_fork(struct task_struct *child)
+	__releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	int i;
@@ -5940,19 +5946,19 @@ void cgroup_cancel_fork(struct task_struct *child)
 	for_each_subsys(ss, i)
 		if (ss->cancel_fork)
 			ss->cancel_fork(child);
+
+	cgroup_threadgroup_change_end(current);
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
+ * @child: the child process
+ *
+ * Attach the child process to its css_set calling the subsystem fork()
+ * callbacks.
  */
 void cgroup_post_fork(struct task_struct *child)
+	__releases(&cgroup_threadgroup_rwsem)
 {
 	struct cgroup_subsys *ss;
 	struct css_set *cset;
@@ -5995,6 +6001,8 @@ void cgroup_post_fork(struct task_struct *child)
 	do_each_subsys_mask(ss, i, have_fork_callback) {
 		ss->fork(child);
 	} while_each_subsys_mask();
+
+	cgroup_threadgroup_change_end(current);
 }
 
 /**
diff --git a/kernel/fork.c b/kernel/fork.c
index 080809560072..ca5de25690c8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2165,7 +2165,6 @@ static __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->thread_group);
 	p->task_works = NULL;
 
-	cgroup_threadgroup_change_begin(current);
 	/*
 	 * Ensure that the cgroup subsystem policies allow the new process to be
 	 * forked. It should be noted the the new process's css_set can be changed
@@ -2174,7 +2173,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	retval = cgroup_can_fork(p);
 	if (retval)
-		goto bad_fork_cgroup_threadgroup_change_end;
+		goto bad_fork_put_pidfd;
 
 	/*
 	 * From this point on we must avoid any synchronous user-space
@@ -2280,7 +2279,6 @@ static __latent_entropy struct task_struct *copy_process(
 
 	proc_fork_connector(p);
 	cgroup_post_fork(p);
-	cgroup_threadgroup_change_end(current);
 	perf_event_fork(p);
 
 	trace_task_newtask(p, clone_flags);
@@ -2292,8 +2290,6 @@ static __latent_entropy struct task_struct *copy_process(
 	spin_unlock(&current->sighand->siglock);
 	write_unlock_irq(&tasklist_lock);
 	cgroup_cancel_fork(p);
-bad_fork_cgroup_threadgroup_change_end:
-	cgroup_threadgroup_change_end(current);
 bad_fork_put_pidfd:
 	if (clone_flags & CLONE_PIDFD) {
 		fput(pidfile);
-- 
2.25.0

