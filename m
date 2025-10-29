Return-Path: <cgroups+bounces-11313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4891C186CE
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 07:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D38A51A67578
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 06:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3FA92E2DD4;
	Wed, 29 Oct 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCSAI/Ju"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A850302161;
	Wed, 29 Oct 2025 06:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718761; cv=none; b=PPpZPWOcasgSwCrVDVjnaM7xOJv2HIiSpqiflIekxjk4PumTkoaKhkC6JMgRNt9Pc4oEEBRoF8A4t6if4P2VY5SdA0WZmaiOq9kJV0qt4wYeDuduNrDjAmbIinuR1YRZIG81Ykb4N7WY89YisY7luN7lhlc8mIrxmtoEnU7oPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718761; c=relaxed/simple;
	bh=C3qiyb0AGlf68bONmjvKkvJoAeN9b4+b7I5Eu1bkWB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOQs85DgVBsH6JqFCfPMEuEDi1/Yvum4z/CmfI0sxg34kyp8sy+BbCE/jD3OvV41phbx6fcyMA5q9vUVngszXQ3j+Yc+IwvJBc48cpUnDli9wb2fEIJ81MozUKJ6jxugaZvMJfPlgYWESRIGnNuADxT15rGR4PtR5t+RJ58md2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCSAI/Ju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC75C4CEFB;
	Wed, 29 Oct 2025 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718761;
	bh=C3qiyb0AGlf68bONmjvKkvJoAeN9b4+b7I5Eu1bkWB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCSAI/Ju9X17B6lcmWaPmviBoHWjWp5QBlCWt7e/iq9fmps5z3J/VoRhmi7GKD4ES
	 EFiEYBuj1FLfPzJx1AVs5tFN0/DzPYL4VQOglt8rQgl2VJNq19cYTD6Vl61KonlY00
	 vGcHjlwSHzl3xqlrcjEsi61ecm7aLeBZ8Qw5BIp+kTgdR/Y4zNmMAcNasGXvzjBM/U
	 ySdfCSEjkFaKQmLy0mcfYR4eSwD13IUN9xGc835DaV7P15aLiChJo3DCq5KP8lxG5r
	 H6dQnF9wkvxIFUPCTlYDbZ4IlZSySeofSAFWCBmQf0F++uAaALJ+xG788S63YkqZHK
	 WiqX3x5ALmrdw==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] cgroup: Rename cgroup lifecycle hooks to cgroup_task_*()
Date: Tue, 28 Oct 2025 20:19:15 -1000
Message-ID: <20251029061918.4179554-2-tj@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251029061918.4179554-1-tj@kernel.org>
References: <20251029061918.4179554-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current names cgroup_exit(), cgroup_release(), and cgroup_free() are
confusing because they look like they're operating on cgroups themselves when
they're actually task lifecycle hooks. For example, cgroup_init() initializes
the cgroup subsystem while cgroup_exit() is a task exit notification to
cgroup. Rename them to cgroup_task_exit(), cgroup_task_release(), and
cgroup_task_free() to make it clear that these operate on tasks.

Cc: Dan Schatzberg <dschatzberg@meta.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h   | 12 ++++++------
 kernel/cgroup/cgroup.c   | 11 ++++++-----
 kernel/exit.c            |  4 ++--
 kernel/fork.c            |  2 +-
 kernel/sched/autogroup.c |  4 ++--
 5 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 6ed477338b16..4068035176c4 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -137,9 +137,9 @@ extern void cgroup_cancel_fork(struct task_struct *p,
 			       struct kernel_clone_args *kargs);
 extern void cgroup_post_fork(struct task_struct *p,
 			     struct kernel_clone_args *kargs);
-void cgroup_exit(struct task_struct *p);
-void cgroup_release(struct task_struct *p);
-void cgroup_free(struct task_struct *p);
+void cgroup_task_exit(struct task_struct *p);
+void cgroup_task_release(struct task_struct *p);
+void cgroup_task_free(struct task_struct *p);
 
 int cgroup_init_early(void);
 int cgroup_init(void);
@@ -680,9 +680,9 @@ static inline void cgroup_cancel_fork(struct task_struct *p,
 				      struct kernel_clone_args *kargs) {}
 static inline void cgroup_post_fork(struct task_struct *p,
 				    struct kernel_clone_args *kargs) {}
-static inline void cgroup_exit(struct task_struct *p) {}
-static inline void cgroup_release(struct task_struct *p) {}
-static inline void cgroup_free(struct task_struct *p) {}
+static inline void cgroup_task_exit(struct task_struct *p) {}
+static inline void cgroup_task_release(struct task_struct *p) {}
+static inline void cgroup_task_free(struct task_struct *p) {}
 
 static inline int cgroup_init_early(void) { return 0; }
 static inline int cgroup_init(void) { return 0; }
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 6ae5f48cf64e..826b7fd2f85d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -944,7 +944,8 @@ static void css_set_move_task(struct task_struct *task,
 		/*
 		 * We are synchronized through cgroup_threadgroup_rwsem
 		 * against PF_EXITING setting such that we can't race
-		 * against cgroup_exit()/cgroup_free() dropping the css_set.
+		 * against cgroup_task_exit()/cgroup_task_free() dropping
+		 * the css_set.
 		 */
 		WARN_ON_ONCE(task->flags & PF_EXITING);
 
@@ -6972,13 +6973,13 @@ void cgroup_post_fork(struct task_struct *child,
 }
 
 /**
- * cgroup_exit - detach cgroup from exiting task
+ * cgroup_task_exit - detach cgroup from exiting task
  * @tsk: pointer to task_struct of exiting process
  *
  * Description: Detach cgroup from @tsk.
  *
  */
-void cgroup_exit(struct task_struct *tsk)
+void cgroup_task_exit(struct task_struct *tsk)
 {
 	struct cgroup_subsys *ss;
 	struct css_set *cset;
@@ -7010,7 +7011,7 @@ void cgroup_exit(struct task_struct *tsk)
 	} while_each_subsys_mask();
 }
 
-void cgroup_release(struct task_struct *task)
+void cgroup_task_release(struct task_struct *task)
 {
 	struct cgroup_subsys *ss;
 	int ssid;
@@ -7027,7 +7028,7 @@ void cgroup_release(struct task_struct *task)
 	}
 }
 
-void cgroup_free(struct task_struct *task)
+void cgroup_task_free(struct task_struct *task)
 {
 	struct css_set *cset = task_css_set(task);
 	put_css_set(cset);
diff --git a/kernel/exit.c b/kernel/exit.c
index 9f74e8f1c431..46173461e8de 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -257,7 +257,7 @@ void release_task(struct task_struct *p)
 	rcu_read_unlock();
 
 	pidfs_exit(p);
-	cgroup_release(p);
+	cgroup_task_release(p);
 
 	/* Retrieve @thread_pid before __unhash_process() may set it to NULL. */
 	thread_pid = task_pid(p);
@@ -967,7 +967,7 @@ void __noreturn do_exit(long code)
 	exit_thread(tsk);
 
 	sched_autogroup_exit_task(tsk);
-	cgroup_exit(tsk);
+	cgroup_task_exit(tsk);
 
 	/*
 	 * FIXME: do that only when needed, using sched_exit tracepoint
diff --git a/kernel/fork.c b/kernel/fork.c
index 3da0f08615a9..960c39c9c264 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -738,7 +738,7 @@ void __put_task_struct(struct task_struct *tsk)
 	unwind_task_free(tsk);
 	sched_ext_free(tsk);
 	io_uring_free(tsk);
-	cgroup_free(tsk);
+	cgroup_task_free(tsk);
 	task_numa_free(tsk, true);
 	security_task_free(tsk);
 	exit_creds(tsk);
diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index cdea931aae30..954137775f38 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -178,8 +178,8 @@ autogroup_move_group(struct task_struct *p, struct autogroup *ag)
 	 * this process can already run with task_group() == prev->tg or we can
 	 * race with cgroup code which can read autogroup = prev under rq->lock.
 	 * In the latter case for_each_thread() can not miss a migrating thread,
-	 * cpu_cgroup_attach() must not be possible after cgroup_exit() and it
-	 * can't be removed from thread list, we hold ->siglock.
+	 * cpu_cgroup_attach() must not be possible after cgroup_task_exit()
+	 * and it can't be removed from thread list, we hold ->siglock.
 	 *
 	 * If an exiting thread was already removed from thread list we rely on
 	 * sched_autogroup_exit_task().
-- 
2.51.1


