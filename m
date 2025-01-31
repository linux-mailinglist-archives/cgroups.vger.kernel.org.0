Return-Path: <cgroups+bounces-6404-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F9FA2381E
	for <lists+cgroups@lfdr.de>; Fri, 31 Jan 2025 01:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 438601888013
	for <lists+cgroups@lfdr.de>; Fri, 31 Jan 2025 00:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C477632;
	Fri, 31 Jan 2025 00:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hKvFsPh/"
X-Original-To: cgroups@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC048323D
	for <cgroups@vger.kernel.org>; Fri, 31 Jan 2025 00:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738281979; cv=none; b=nLPYj5wub9RRi7f44430q9Cf1YtqZUhFQ5v2nmzbPwLTdPUjlqPOpa129Cmk8sv58VxxQR4idJ6zXij5qJ348LkceD41lOsSoc2ng05HlQybQqErKtyJlN9rMBiP9m3jpQc4Hs9UYV8Fwqq432jSjpHfDDKRKufYWDZkzDqz/4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738281979; c=relaxed/simple;
	bh=PIoUnJHk89m7IKL8EjscmZ658K/xqTtmuSHmmC2MlSc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dy365IwbgCYl/ZU//B5FiW+WpzI5PLoM8IFG5K+MWqGgyw0w5ZOGnQOyC8GsKjVJJkRu8eWjuu9Mkang6pBSIGntfNJq4YR23s7UY4AYyqB6PUnjFxWD7lIwZTOBC2Tp2lxzqEiWqQGFUeE5G8zuLhk5CPSTQJq5WKITgVs1nao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hKvFsPh/; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738281963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fy6PSBjEhWO5F6baEThGkls7hDcROVyek5p6WWL2O3w=;
	b=hKvFsPh/q0QhDOek+LULFnkeWJl0+8VDESr9m2TKzUT03KPJO5wCqefdQTiKkDM2V18NW9
	n0WDbEDm6P1qhU8e+s0j5wWk8POAe0KhvzCNOb7UTRnS5XIziTkv2g8ohi+S95Pn33vip3
	HjS/Tg8/RTbVfbVIv7/VdLIQpkZBxTo=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: Christian Brauner <brauner@kernel.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH] cgroup: fix race between fork and cgroup.kill
Date: Thu, 30 Jan 2025 16:05:42 -0800
Message-ID: <20250131000542.1394856-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Tejun reported the following race between fork() and cgroup.kill at [1].

Tejun:
  I was looking at cgroup.kill implementation and wondering whether there
  could be a race window. So, __cgroup_kill() does the following:

   k1. Set CGRP_KILL.
   k2. Iterate tasks and deliver SIGKILL.
   k3. Clear CGRP_KILL.

  The copy_process() does the following:

   c1. Copy a bunch of stuff.
   c2. Grab siglock.
   c3. Check fatal_signal_pending().
   c4. Commit to forking.
   c5. Release siglock.
   c6. Call cgroup_post_fork() which puts the task on the css_set and tests
       CGRP_KILL.

  The intention seems to be that either a forking task gets SIGKILL and
  terminates on c3 or it sees CGRP_KILL on c6 and kills the child. However, I
  don't see what guarantees that k3 can't happen before c6. ie. After a
  forking task passes c5, k2 can take place and then before the forking task
  reaches c6, k3 can happen. Then, nobody would send SIGKILL to the child.
  What am I missing?

This is indeed a race. One way to fix this race is by taking
cgroup_threadgroup_rwsem in write mode in __cgroup_kill() as the fork()
side takes cgroup_threadgroup_rwsem in read mode from cgroup_can_fork()
to cgroup_post_fork(). However that would be heavy handed as this adds
one more potential stall scenario for cgroup.kill which is usually
called under extreme situation like memory pressure.

To fix this race, let's maintain a sequence number per cgroup which gets
incremented on __cgroup_kill() call. On the fork() side, the
cgroup_can_fork() will cache the sequence number locally and recheck it
against the cgroup's sequence number at cgroup_post_fork() site. If the
sequence numbers mismatch, it means __cgroup_kill() can been called and
we should send SIGKILL to the newly created task.

Reported-by: Tejun Heo <tj@kernel.org>
Closes: https://lore.kernel.org/all/Z5QHE2Qn-QZ6M-KW@slm.duckdns.org/ [1]
Fixes: 661ee6280931 ("cgroup: introduce cgroup.kill")
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/cgroup-defs.h |  6 +++---
 include/linux/sched/task.h  |  1 +
 kernel/cgroup/cgroup.c      | 20 ++++++++++++--------
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1b20d2d8ef7c..17960a1e858d 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -71,9 +71,6 @@ enum {
 
 	/* Cgroup is frozen. */
 	CGRP_FROZEN,
-
-	/* Control group has to be killed. */
-	CGRP_KILL,
 };
 
 /* cgroup_root->flags */
@@ -461,6 +458,9 @@ struct cgroup {
 
 	int nr_threaded_children;	/* # of live threaded child cgroups */
 
+	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	unsigned int kill_seq;
+
 	struct kernfs_node *kn;		/* cgroup kernfs entry */
 	struct cgroup_file procs_file;	/* handle for "cgroup.procs" */
 	struct cgroup_file events_file;	/* handle for "cgroup.events" */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb0..ca1db4b92c32 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -43,6 +43,7 @@ struct kernel_clone_args {
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	unsigned int kill_seq;
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index d9061bd55436..afc665b7b1fe 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4013,7 +4013,7 @@ static void __cgroup_kill(struct cgroup *cgrp)
 	lockdep_assert_held(&cgroup_mutex);
 
 	spin_lock_irq(&css_set_lock);
-	set_bit(CGRP_KILL, &cgrp->flags);
+	cgrp->kill_seq++;
 	spin_unlock_irq(&css_set_lock);
 
 	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
@@ -4029,10 +4029,6 @@ static void __cgroup_kill(struct cgroup *cgrp)
 		send_sig(SIGKILL, task, 0);
 	}
 	css_task_iter_end(&it);
-
-	spin_lock_irq(&css_set_lock);
-	clear_bit(CGRP_KILL, &cgrp->flags);
-	spin_unlock_irq(&css_set_lock);
 }
 
 static void cgroup_kill(struct cgroup *cgrp)
@@ -6488,6 +6484,10 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
+	if (kargs->cgrp)
+		kargs->kill_seq = kargs->cgrp->kill_seq;
+	else
+		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6668,6 +6668,7 @@ void cgroup_post_fork(struct task_struct *child,
 		      struct kernel_clone_args *kargs)
 	__releases(&cgroup_threadgroup_rwsem) __releases(&cgroup_mutex)
 {
+	unsigned int cgrp_kill_seq = 0;
 	unsigned long cgrp_flags = 0;
 	bool kill = false;
 	struct cgroup_subsys *ss;
@@ -6681,10 +6682,13 @@ void cgroup_post_fork(struct task_struct *child,
 
 	/* init tasks are special, only link regular threads */
 	if (likely(child->pid)) {
-		if (kargs->cgrp)
+		if (kargs->cgrp) {
 			cgrp_flags = kargs->cgrp->flags;
-		else
+			cgrp_kill_seq = kargs->cgrp->kill_seq;
+		} else {
 			cgrp_flags = cset->dfl_cgrp->flags;
+			cgrp_kill_seq = cset->dfl_cgrp->kill_seq;
+		}
 
 		WARN_ON_ONCE(!list_empty(&child->cg_list));
 		cset->nr_tasks++;
@@ -6719,7 +6723,7 @@ void cgroup_post_fork(struct task_struct *child,
 		 * child down right after we finished preparing it for
 		 * userspace.
 		 */
-		kill = test_bit(CGRP_KILL, &cgrp_flags);
+		kill = kargs->kill_seq != cgrp_kill_seq;
 	}
 
 	spin_unlock_irq(&css_set_lock);
-- 
2.43.5


