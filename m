Return-Path: <cgroups+bounces-11315-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04949C186E9
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 07:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 623E150738F
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 06:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD66307AC4;
	Wed, 29 Oct 2025 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HTljxmxP"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6617D306B18;
	Wed, 29 Oct 2025 06:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718763; cv=none; b=h7oKvTdzc1Es14WHG+cR1XE0zatZobdLrmKuQQqdcO8mWTGRx292Oo3CGGzjOlQ9OcNqO+XUirf/0q0cqGasN6ipHO8H7na6DdZ47YZpBPNoTX7OTzqo6pYKPOITFOYWQafi+rntRdNTfVgvEsU5KJXXUN6zftFw+7gHO326+i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718763; c=relaxed/simple;
	bh=xLja+6Rkfm+qf7bLqyram6ZKvNu8oo/lxskLoz2t7VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TgMNP7HU55N0GRkwyjMFsdGL+1PP0vW1VncwvX7D2o+IrfPL+bFVEPm9sSloEJjC2Tqk+CJG/KdFB657pdk8jPjKFMD+P5bEP5UTRpAGsG9Iy3CKsb8dD69Zt2npu/YbSvgWjb3BKb380mtAdTksP4dC0pBWRAd97Gjr3d3cOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HTljxmxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D48AC16AAE;
	Wed, 29 Oct 2025 06:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718763;
	bh=xLja+6Rkfm+qf7bLqyram6ZKvNu8oo/lxskLoz2t7VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HTljxmxP4DbsKjGQyal+hr8dCYd2K/kw5Dk8Df3KNjHuaBOLqZnq5Qr2jEtycg7oO
	 8Jxq6y/g/tv9WMwhNlhfzhmoJizkhThZh1Bla+F5LnAgoWqi9/JOf5GHtUGF2b2xft
	 J8QgcBeb7mi3lmplgWE8SBOH+dXSPGQcDFEEtv2YKsrRPNdDNv9AuD0k5znOkpvDfk
	 EmoAjW0jOBRc6cxUFJWwYnt7c7UL1vBU10ACS7PVexLLBInBbdBCPGnFvArN9sR7ua
	 O8MxIHmA9MtJXC3uLdVBBiBVQr0LGUsUIrFH3HN6hVdO/GeJAhZHWxkujLZ/l8wbdh
	 gLGcsUUXJWCwg==
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
Subject: [PATCH 3/4] cgroup: Defer task cgroup unlink until after the task is done switching out
Date: Tue, 28 Oct 2025 20:19:17 -1000
Message-ID: <20251029061918.4179554-4-tj@kernel.org>
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

When a task exits, css_set_move_task(tsk, cset, NULL, false) unlinks the task
from its cgroup. From the cgroup's perspective, the task is now gone. If this
makes the cgroup empty, it can be removed, triggering ->css_offline() callbacks
that notify controllers the cgroup is going offline resource-wise.

However, the exiting task can still run, perform memory operations, and schedule
until the final context switch in finish_task_switch(). This creates a confusing
situation where controllers are told a cgroup is offline while resource
activities are still happening in it. While this hasn't broken existing
controllers, it has caused direct confusion for sched_ext schedulers.

Split cgroup_task_exit() into two functions. cgroup_task_exit() now only calls
the subsystem exit callbacks and continues to be called from do_exit(). The
css_set cleanup is moved to the new cgroup_task_dead() which is called from
finish_task_switch() after the final context switch, so that the cgroup only
appears empty after the task is truly done running.

This also reorders operations so that subsys->exit() is now called before
unlinking from the cgroup, which shouldn't break anything.

Cc: Dan Schatzberg <dschatzberg@meta.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h |  2 ++
 kernel/cgroup/cgroup.c | 23 ++++++++++++++---------
 kernel/sched/core.c    |  2 ++
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 4068035176c4..bc892e3b37ee 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -138,6 +138,7 @@ extern void cgroup_cancel_fork(struct task_struct *p,
 extern void cgroup_post_fork(struct task_struct *p,
 			     struct kernel_clone_args *kargs);
 void cgroup_task_exit(struct task_struct *p);
+void cgroup_task_dead(struct task_struct *p);
 void cgroup_task_release(struct task_struct *p);
 void cgroup_task_free(struct task_struct *p);
 
@@ -681,6 +682,7 @@ static inline void cgroup_cancel_fork(struct task_struct *p,
 static inline void cgroup_post_fork(struct task_struct *p,
 				    struct kernel_clone_args *kargs) {}
 static inline void cgroup_task_exit(struct task_struct *p) {}
+static inline void cgroup_task_dead(struct task_struct *p) {}
 static inline void cgroup_task_release(struct task_struct *p) {}
 static inline void cgroup_task_free(struct task_struct *p) {}
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b3c27900c5d2..aae180d56c8c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -944,7 +944,7 @@ static void css_set_move_task(struct task_struct *task,
 		/*
 		 * We are synchronized through cgroup_threadgroup_rwsem
 		 * against PF_EXITING setting such that we can't race
-		 * against cgroup_task_exit()/cgroup_task_free() dropping
+		 * against cgroup_task_dead()/cgroup_task_free() dropping
 		 * the css_set.
 		 */
 		WARN_ON_ONCE(task->flags & PF_EXITING);
@@ -6982,10 +6982,20 @@ void cgroup_post_fork(struct task_struct *child,
 void cgroup_task_exit(struct task_struct *tsk)
 {
 	struct cgroup_subsys *ss;
-	struct css_set *cset;
 	int i;
 
-	spin_lock_irq(&css_set_lock);
+	/* see cgroup_post_fork() for details */
+	do_each_subsys_mask(ss, i, have_exit_callback) {
+		ss->exit(tsk);
+	} while_each_subsys_mask();
+}
+
+void cgroup_task_dead(struct task_struct *tsk)
+{
+	struct css_set *cset;
+	unsigned long flags;
+
+	spin_lock_irqsave(&css_set_lock, flags);
 
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset = task_css_set(tsk);
@@ -7003,12 +7013,7 @@ void cgroup_task_exit(struct task_struct *tsk)
 		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
 		cgroup_update_frozen(task_dfl_cgroup(tsk));
 
-	spin_unlock_irq(&css_set_lock);
-
-	/* see cgroup_post_fork() for details */
-	do_each_subsys_mask(ss, i, have_exit_callback) {
-		ss->exit(tsk);
-	} while_each_subsys_mask();
+	spin_unlock_irqrestore(&css_set_lock, flags);
 }
 
 void cgroup_task_release(struct task_struct *task)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e2..40f12e37f60f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5222,6 +5222,8 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
+		cgroup_task_dead(prev);
+
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
-- 
2.51.1


