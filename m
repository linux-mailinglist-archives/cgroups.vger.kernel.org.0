Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070523716C9
	for <lists+cgroups@lfdr.de>; Mon,  3 May 2021 16:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhECOlL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 3 May 2021 10:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhECOlL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 3 May 2021 10:41:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04B59611AE;
        Mon,  3 May 2021 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620052818;
        bh=IScLRmkNH/N2JOOZQL8ADKhnMLVaT/9xwpGAx27Q3Ec=;
        h=From:To:Cc:Subject:Date:From;
        b=UPEk1j2ceFm3AOBfWi8sccSL+MxyPC/OqJ7gbGTCOb3pc8zU3mcHO6bAGTkqw1zpA
         pOcCo100RkQmBEOQmNxUPVLF0uUzTQvQNWUq0TkoAbZ/dB5M69aQPV7Muv7reB+N7J
         duazmw+je76vOH1xyPLqNkW5UHCRedvoCmUaulTN3bIeLg0IyGb5Rh9ltwn/X8xbv/
         E9JY4T0UkA3OLUopKvCULV+qbirOF2gx2Wl+zESb3KIfe3k0GCOET++fFvZHLs/gzK
         WgDX1+19PMlx69rQEe75sDoXUfI6gsfRanrGhUEvX/qox9hT9Gf3ASfDZiPPwxw9K+
         elYGSwkVV+84Q==
From:   Christian Brauner <brauner@kernel.org>
To:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/5] cgroup: introduce cgroup.kill
Date:   Mon,  3 May 2021 16:39:19 +0200
Message-Id: <20210503143922.3093755-1-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=qXUYyXGseTIaNFY05LIqZtFxp0MX530dT5fMpXJcCWk=; m=qR/fD0+6QrmKKQEP7tmLwbD+e28CoI6y5DKkvGvib+M=; p=G/B+mTZByUyyekkG+H6iLBx7VU8E8f4C+Zb8TfgXdqw=; g=fcd67576ba96721ad2660c536ef33d24449df089
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJAK7wAKCRCRxhvAZXjconfKAP0SPZc o9bDficUE/erhpeOllzxCA7v9qMUUIY42T+ueLgEAjIt/sFhgclX27ZgPoLjj68w+TAVFR7BzY8SD 9GuZxQ0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Introduce the cgroup.kill file. It does what it says on the tin and
allows a caller to kill a cgroup by writing "1" into cgroup.kill.
The file is available in non-root cgroups.

Killing cgroups is a process directed operation, i.e. the whole
thread-group is affected. Consequently trying to write to cgroup.kill in
threaded cgroups will be rejected and EOPNOTSUPP returned. This behavior
aligns with cgroup.procs where reads in threaded-cgroups are rejected
with EOPNOTSUPP.

The cgroup.kill file is write-only since killing a cgroup is an event
not which makes it different from e.g. freezer where a cgroup
transitions between the two states.

As with all new cgroup features cgroup.kill is recursive by default.

Killing a cgroup is protected against concurrent migrations through the
cgroup mutex. To protect against forkbombs and to mitigate the effect of
racing forks a new CGRP_KILL css set lock protected flag is introduced
that is set prior to killing a cgroup and unset after the cgroup has
been killed. We can then check in cgroup_post_fork() where we hold the
css set lock already whether the cgroup is currently being killed. If so
we send the child a SIGKILL signal immediately taking it down as soon as
it returns to userspace. To make the killing of the child semantically
clean it is killed after all cgroup attachment operations have been
finalized.

There are various use-cases of this interface:
- Containers usually have a conservative layout where each container
  usually has a delegated cgroup. For such layouts there is a 1:1
  mapping between container and cgroup. If the container in addition
  uses a separate pid namespace then killing a container usually becomes
  a simple kill -9 <container-init-pid> from an ancestor pid namespace.
  However, there are quite a few scenarios where that isn't true. For
  example, there are containers that share the cgroup with other
  processes on purpose that are supposed to be bound to the lifetime of
  the container but are not in the same pidns of the container.
  Containers that are in a delegated cgroup but share the pid namespace
  with the host or other containers.
- Service managers such as systemd use cgroups to group and organize
  processes belonging to a service. They usually rely on a recursive
  algorithm now to kill a service. With cgroup.kill this becomes a
  simple write to cgroup.kill.
- Userspace OOM implementations can make good use of this feature to
  efficiently take down whole cgroups quickly.
- The kill program can gain a new
  kill --cgroup /sys/fs/cgroup/delegated
  flag to take down cgroups.

A few observations about the semantics:
- If parent and child are in the same cgroup and CLONE_INTO_CGROUP is
  not specified we are not taking cgroup mutex meaning the cgroup can be
  killed while a process in that cgroup is forking.
  If the kill request happens right before cgroup_can_fork() and before
  the parent grabs its siglock the parent is guaranteed to see the
  pending SIGKILL. In addition we perform another check in
  cgroup_post_fork() whether the cgroup is being killed and is so take
  down the child (see above). This is robust enough and protects gainst
  forkbombs. If userspace really really wants to have stricter
  protection the simple solution would be to grab the write side of the
  cgroup threadgroup rwsem which will force all ongoing forks to
  complete before killing starts. We concluded that this is not
  necessary as the semantics for concurrent forking should simply align
  with freezer where a similar check as cgroup_post_fork() is performed.

  For all other cases CLONE_INTO_CGROUP is required. In this case we
  will grab the cgroup mutex so the cgroup can't be killed while we
  fork. Once we're done with the fork and have dropped cgroup mutex we
  are visible and will be found by any subsequent kill request.
- We obviously don't kill kthreads. This means a cgroup that has a
  kthread will not become empty after killing and consequently no
  unpopulated event will be generated. The assumption is that kthreads
  should be in the root cgroup only anyway so this is not an issue.
- We skip killing tasks that already have pending fatal signals.
- Freezer doesn't care about tasks in different pid namespaces, i.e. if
  you have two tasks in different pid namespaces the cgroup would still
  be frozen. The cgroup.kill mechanism consequently behaves the same
  way, i.e. we kill all processes and ignore in which pid namespace they
  exist.
- If the caller is located in a cgroup that is killed the caller will
  obviously be killed as well.

Cc: Shakeel Butt <shakeelb@google.com>
Cc: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: cgroups@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---

The series can be pulled from

git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/cgroup.kill.v5.14

/* v2 */
- Roman Gushchin <guro@fb.com>:
  - Retrieve cgrp->flags only once and check CGRP_* bits on it.
---
 include/linux/cgroup-defs.h |   3 +
 kernel/cgroup/cgroup.c      | 127 ++++++++++++++++++++++++++++++++----
 2 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 559ee05f86b2..43fef771009a 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -71,6 +71,9 @@ enum {
 
 	/* Cgroup is frozen. */
 	CGRP_FROZEN,
+
+	/* Control group has to be killed. */
+	CGRP_KILL,
 };
 
 /* cgroup_root->flags */
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 9153b20e5cc6..aee84b99534a 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3654,6 +3654,80 @@ static ssize_t cgroup_freeze_write(struct kernfs_open_file *of,
 	return nbytes;
 }
 
+static void __cgroup_kill(struct cgroup *cgrp)
+{
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	spin_lock_irq(&css_set_lock);
+	set_bit(CGRP_KILL, &cgrp->flags);
+	spin_unlock_irq(&css_set_lock);
+
+	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
+	while ((task = css_task_iter_next(&it))) {
+		/* Ignore kernel threads here. */
+		if (task->flags & PF_KTHREAD)
+			continue;
+
+		/* Skip tasks that are already dying. */
+		if (__fatal_signal_pending(task))
+			continue;
+
+		send_sig(SIGKILL, task, 0);
+	}
+	css_task_iter_end(&it);
+
+	spin_lock_irq(&css_set_lock);
+	clear_bit(CGRP_KILL, &cgrp->flags);
+	spin_unlock_irq(&css_set_lock);
+}
+
+static void cgroup_kill(struct cgroup *cgrp)
+{
+	struct cgroup_subsys_state *css;
+	struct cgroup *dsct;
+
+	lockdep_assert_held(&cgroup_mutex);
+
+	cgroup_for_each_live_descendant_pre(dsct, css, cgrp)
+		__cgroup_kill(dsct);
+}
+
+static ssize_t cgroup_kill_write(struct kernfs_open_file *of, char *buf,
+				 size_t nbytes, loff_t off)
+{
+	ssize_t ret = 0;
+	int kill;
+	struct cgroup *cgrp;
+
+	ret = kstrtoint(strstrip(buf), 0, &kill);
+	if (ret)
+		return ret;
+
+	if (kill != 1)
+		return -ERANGE;
+
+	cgrp = cgroup_kn_lock_live(of->kn, false);
+	if (!cgrp)
+		return -ENOENT;
+
+	/*
+	 * Killing is a process directed operation, i.e. the whole thread-group
+	 * is taken down so act like we do for cgroup.procs and only make this
+	 * writable in non-threaded cgroups.
+	 */
+	if (cgroup_is_threaded(cgrp))
+		ret = -EOPNOTSUPP;
+	else
+		cgroup_kill(cgrp);
+
+	cgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
 static int cgroup_file_open(struct kernfs_open_file *of)
 {
 	struct cftype *cft = of_cft(of);
@@ -4846,6 +4920,11 @@ static struct cftype cgroup_base_files[] = {
 		.seq_show = cgroup_freeze_show,
 		.write = cgroup_freeze_write,
 	},
+	{
+		.name = "cgroup.kill",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.write = cgroup_kill_write,
+	},
 	{
 		.name = "cpu.stat",
 		.seq_show = cpu_stat_show,
@@ -6077,6 +6156,8 @@ void cgroup_post_fork(struct task_struct *child,
 		      struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	unsigned long cgrp_flags = 0;
+	bool kill = false;
 	struct cgroup_subsys *ss;
 	struct css_set *cset;
 	int i;
@@ -6088,6 +6169,11 @@ void cgroup_post_fork(struct task_struct *child,
 
 	/* init tasks are special, only link regular threads */
 	if (likely(child->pid)) {
+		if (kargs->cgrp)
+			cgrp_flags = kargs->cgrp->flags;
+		else
+			cgrp_flags = cset->dfl_cgrp->flags;
+
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
 		css_set_move_task(child, NULL, cset, false);
@@ -6096,23 +6182,32 @@ void cgroup_post_fork(struct task_struct *child,
 		cset = NULL;
 	}
 
-	/*
-	 * If the cgroup has to be frozen, the new task has too.  Let's set
-	 * the JOBCTL_TRAP_FREEZE jobctl bit to get the task into the
-	 * frozen state.
-	 */
-	if (unlikely(cgroup_task_freeze(child))) {
-		spin_lock(&child->sighand->siglock);
-		WARN_ON_ONCE(child->frozen);
-		child->jobctl |= JOBCTL_TRAP_FREEZE;
-		spin_unlock(&child->sighand->siglock);
+	if (!(child->flags & PF_KTHREAD)) {
+		if (test_bit(CGRP_FREEZE, &cgrp_flags)) {
+			/*
+			 * If the cgroup has to be frozen, the new task has
+			 * too. Let's set the JOBCTL_TRAP_FREEZE jobctl bit to
+			 * get the task into the frozen state.
+			 */
+			spin_lock(&child->sighand->siglock);
+			WARN_ON_ONCE(child->frozen);
+			child->jobctl |= JOBCTL_TRAP_FREEZE;
+			spin_unlock(&child->sighand->siglock);
+
+			/*
+			 * Calling cgroup_update_frozen() isn't required here,
+			 * because it will be called anyway a bit later from
+			 * do_freezer_trap(). So we avoid cgroup's transient
+			 * switch from the frozen state and back.
+			 */
+		}
 
 		/*
-		 * Calling cgroup_update_frozen() isn't required here,
-		 * because it will be called anyway a bit later from
-		 * do_freezer_trap(). So we avoid cgroup's transient switch
-		 * from the frozen state and back.
+		 * If the cgroup is to be killed notice it now and take the
+		 * child down right after we finished preparing it for
+		 * userspace.
 		 */
+		kill = test_bit(CGRP_KILL, &cgrp_flags);
 	}
 
 	spin_unlock_irq(&css_set_lock);
@@ -6135,6 +6230,10 @@ void cgroup_post_fork(struct task_struct *child,
 		put_css_set(rcset);
 	}
 
+	/* Cgroup has to be killed so take down child immediately. */
+	if (kill)
+		send_sig(SIGKILL, child, 0);
+
 	cgroup_css_set_put_fork(kargs);
 }
 

base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.27.0

