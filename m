Return-Path: <cgroups+bounces-11316-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED67FC186E6
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 07:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E706F1C65A52
	for <lists+cgroups@lfdr.de>; Wed, 29 Oct 2025 06:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A89330ACE5;
	Wed, 29 Oct 2025 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WW2j3Lpl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79E73090D7;
	Wed, 29 Oct 2025 06:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718764; cv=none; b=uArzMtG+FpJV4hxT7Px8zAT5CQsBMIYZNAALLNwvis26E67kO+dGuqqVYE5W1id8NupcxrTrzQZY9OqBB9oBbRxauWHpdrPDwZbSPaXo11jmDRZb+6h3ndqxKJjs7zuenbWEVSfcrWbnlYetbvjrvB4HFzWa5omxfa/mpvY8a2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718764; c=relaxed/simple;
	bh=dki8nbEv4ptLcRQV89oVJKBG9e0Mf4cnUWQSzd2iXDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csYX8MoTiOp6kY71SGljxwLqteN7x5+Nifcd7S1aouI8kdqkSWKpvnVDNKbVyKYVWO80mwfHiliro2Vq/W7FNn35meEP0ekv4ij2M/awMkun6aGFpGxxoi4d9odK3wsRc0RWEOCGxEfejo8nToF5X/z7PeNLPdqVtfj3QKrmOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WW2j3Lpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37238C4CEFB;
	Wed, 29 Oct 2025 06:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761718764;
	bh=dki8nbEv4ptLcRQV89oVJKBG9e0Mf4cnUWQSzd2iXDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WW2j3Lpl0ywQwK42Njugukie2hynAJSok5DBhtbtB8DV3MGgSvGbya6NQVSTaLWxJ
	 1u6USythLZvxCXW2kTVyXrO3Mlw669uh3BD2SnCTWP+K45WeXlmT/8yIUEZORz0j+R
	 eOoCtozhoFksLgauzWXw2gyupxM46le70Qq/K3o+dpbvy60KkCt4cjMzBnZ0ZvRKRi
	 jfxoTPk3LwRXG8+0haeaDnGfpI2MAs5EcvsCyMFCW3bZ9uzygWQ02XFwNfLitN3k3/
	 Trr8BM7VQmqW5vNUZtBEcip7lltZBZqFZ0JQSlpXpjqEF49AHjrW3DvhyGob5lFLF0
	 jEzXOApas9BaQ==
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
Subject: [PATCH 4/4] sched_ext: Fix cgroup exit ordering by moving sched_ext_free() to finish_task_switch()
Date: Tue, 28 Oct 2025 20:19:18 -1000
Message-ID: <20251029061918.4179554-5-tj@kernel.org>
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

sched_ext_free() was called from __put_task_struct() when the last reference
to the task is dropped, which could be long after the task has finished
running. This causes cgroup-related problems:

- ops.task_init() can be called on a cgroup which didn't get ops.cgroup_init()'d
  during scheduler load.

- ops.cgroup_exit() could be called before ops.exit_task() is called on all
  member tasks, leading to incorrect exit ordering.

Fix by moving it to finish_task_switch() to be called right after the final
context switch away from the dying task, matching when sched_class->task_dead()
is called. Rename it to sched_ext_dead() to match the new calling context.

By calling sched_ext_dead() before cgroup_task_dead(), we ensure that:

- Tasks visible on scx_tasks list have valid cgroups during scheduler load,
  as cgroup_mutex prevents cgroup destruction while the task is still linked.

- All member tasks have ops.exit_task() called and are removed from scx_tasks
  before the cgroup can be destroyed and trigger ops.cgroup_exit().

This fix is made possible by the cgroup_task_dead() split in the previous patch.

This also makes more sense resource-wise as there's no point in keeping
scheduler side resources around for dead tasks.

Reported-by: Dan Schatzberg <dschatzberg@meta.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 include/linux/sched/ext.h | 4 ++--
 kernel/fork.c             | 1 -
 kernel/sched/core.c       | 6 ++++++
 kernel/sched/ext.c        | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d82b7a9b0658..d7dd77be571f 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -207,14 +207,14 @@ struct sched_ext_entity {
 	struct list_head	tasks_node;
 };
 
-void sched_ext_free(struct task_struct *p);
+void sched_ext_dead(struct task_struct *p);
 void print_scx_info(const char *log_lvl, struct task_struct *p);
 void scx_softlockup(u32 dur_s);
 bool scx_rcu_cpu_stall(void);
 
 #else	/* !CONFIG_SCHED_CLASS_EXT */
 
-static inline void sched_ext_free(struct task_struct *p) {}
+static inline void sched_ext_dead(struct task_struct *p) {}
 static inline void print_scx_info(const char *log_lvl, struct task_struct *p) {}
 static inline void scx_softlockup(u32 dur_s) {}
 static inline bool scx_rcu_cpu_stall(void) { return false; }
diff --git a/kernel/fork.c b/kernel/fork.c
index 960c39c9c264..5ae37909a813 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -736,7 +736,6 @@ void __put_task_struct(struct task_struct *tsk)
 	WARN_ON(tsk == current);
 
 	unwind_task_free(tsk);
-	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_task_free(tsk);
 	task_numa_free(tsk, true);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 40f12e37f60f..d4dbffb27a66 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5222,6 +5222,12 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
+		/*
+		 * sched_ext_dead() must come before cgroup_task_dead() to
+		 * prevent cgroups from being removed while its member tasks are
+		 * visible to SCX schedulers.
+		 */
+		sched_ext_dead(prev);
 		cgroup_task_dead(prev);
 
 		/* Task is done with its stack. */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..840bc76210c8 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2926,7 +2926,7 @@ void scx_cancel_fork(struct task_struct *p)
 	percpu_up_read(&scx_fork_rwsem);
 }
 
-void sched_ext_free(struct task_struct *p)
+void sched_ext_dead(struct task_struct *p)
 {
 	unsigned long flags;
 
-- 
2.51.1


