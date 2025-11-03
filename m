Return-Path: <cgroups+bounces-11539-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 348F7C2E03E
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 21:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4A0D4E30C9
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0229AB11;
	Mon,  3 Nov 2025 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4psvQl0"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D023126BF7;
	Mon,  3 Nov 2025 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762201515; cv=none; b=lJS/e5EYsCeGOEEj1HiTE8FwBw8eNZ0dskLwhUAPhzjKo4W2r0Tnhjb4wq/49wZbPzSeyN5V8love4Le5gAjmkcdNxhIQdZxTxeKy/t8nPQu+dPne4crg0s02SHleyGOEHzoKRwqg9TEFLihhVU9AtG+a/V9b4+y7l32dHeo5bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762201515; c=relaxed/simple;
	bh=aEgnJlyfzWp8fThSQ4OM+O3pG35kSgbH17JXrQ+FdlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL0afOj1xNnosH691n4HzMvKXkh+6LJdRb1QONDeFbKs5ss3ZUe3ZCGPZC/qMIjR4gFGzDFWYe7Vdp+cJFpnb9PeO4W2pML6PnUuU3IN+EQdEjZDZiTwGwz9EJbsopiIPGofRnz0M/7YgU5Ub27G/2/98puRxI+44XpW4jcPVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4psvQl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02FDC4CEE7;
	Mon,  3 Nov 2025 20:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762201514;
	bh=aEgnJlyfzWp8fThSQ4OM+O3pG35kSgbH17JXrQ+FdlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V4psvQl0z84Z4sXf5uVch59ApH7TYr2HnVtdo8FDZj2APg37pf+9xRoRlhHeX1J2G
	 yaldtblbv4f082D2TgnYnGGpswzd5Y0QCV9H4GM3cF5GuwsDojQsxf5FFlLO6YiCv8
	 jn1znhpt1z9YC6ddKhsfiEEPSxTmFIoWxu6Cz6AT2bEkycEV/R+PA2ll51zDyBiV7w
	 bE9EwV28ZZiFT4ClMYHjHMctwXr9cTRHkFdmSEoWIWo1fnILpw/glVxXjAcfkkBYmj
	 sdyR5U0tEZGkdE9RsVX79f5CIXkQXMYJiOgQc8AMHh4oP1D+kzHSn2v5Wsqf7cnLVk
	 pdUd5XK3JtnSA==
Date: Mon, 3 Nov 2025 10:25:13 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, sched-ext@lists.linux.dev
Subject: [PATCH v2 4/4] sched_ext: Fix cgroup exit ordering by moving
 sched_ext_free() to finish_task_switch()
Message-ID: <aQkPqUSMr5L0spd8@slm.duckdns.org>
References: <20251029061918.4179554-1-tj@kernel.org>
 <20251029061918.4179554-5-tj@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029061918.4179554-5-tj@kernel.org>

sched_ext_free() was called from __put_task_struct() when the last reference
to the task is dropped, which could be long after the task has finished
running. This causes cgroup-related problems:

- ops.init_task() can be called on a cgroup which didn't get ops.cgroup_init()'d
  during scheduler load, because the cgroup might be destroyed/unlinked
  while the zombie or dead task is still lingering on the scx_tasks list.

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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
v2: - Description correction and update (Andrea Righi).

 include/linux/sched/ext.h |    4 ++--
 kernel/fork.c             |    1 -
 kernel/sched/core.c       |    6 ++++++
 kernel/sched/ext.c        |    2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

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
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -736,7 +736,6 @@ void __put_task_struct(struct task_struc
 	WARN_ON(tsk == current);
 
 	unwind_task_free(tsk);
-	sched_ext_free(tsk);
 	io_uring_free(tsk);
 	cgroup_task_free(tsk);
 	task_numa_free(tsk, true);
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5222,6 +5222,12 @@ static struct rq *finish_task_switch(str
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
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2926,7 +2926,7 @@ void scx_cancel_fork(struct task_struct
 	percpu_up_read(&scx_fork_rwsem);
 }
 
-void sched_ext_free(struct task_struct *p)
+void sched_ext_dead(struct task_struct *p)
 {
 	unsigned long flags;
 

