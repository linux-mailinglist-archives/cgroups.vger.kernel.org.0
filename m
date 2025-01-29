Return-Path: <cgroups+bounces-6375-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFF9A22464
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 20:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5169C1883438
	for <lists+cgroups@lfdr.de>; Wed, 29 Jan 2025 19:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C041E230E;
	Wed, 29 Jan 2025 19:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fyT+/RMt"
X-Original-To: cgroups@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E321E1A25
	for <cgroups@vger.kernel.org>; Wed, 29 Jan 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738177743; cv=none; b=Pjaf0bv0B52QkP7v3ODOpM1/qR7Hw38L90peRHNGqCzon8XCK/9EyZMUDEDgVemr63IUq/LH3msFoYUhNo437MjQ2Fm0cwnDpI2V5S0oKyHNPOJhIukuWO1xXsaVB8peA7XCmFLkM2u0AwqozJWnRQhZAS3jAw76jtlGyS8Go7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738177743; c=relaxed/simple;
	bh=ETSnYPpBol5TovSZCr6weJqWVGFKsnAPWAmjuCt0blM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HndcPk/uYWh8BpkD/msdf5/K9Mwi48UQ2qwyTmWPJ7Lzltdt/kS2QkhqlkBbRVs5x37lAD7CMfUSAYaMadfsXDqd37RG2C7wlBTIz3oOrGwPf9GEwaESIcuE7MStUakE7KojbtpjOeFL9cEDcWdJt335Be3i7+5xksbbBHiTR5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fyT+/RMt; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 29 Jan 2025 11:08:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738177729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjaFGfiXvf7orXD1rkuKW4CYeNoXdb0iJw2qsbgXT7Q=;
	b=fyT+/RMtTe8HDsbhMvoHufeGLCM4qedOwc0j7Kz7ioiPAHVXyE2T6gKbCmTJwcu4MU7BuK
	trFuJTbMzQo7umzN/UMosi87av9xMEKDCKytRbEB7dcL+5awUNNQUefq7jKBC322527m6M
	fmJA3dzWgraaKAdfMUFH/3vq7+pRvfE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: Maybe a race window in cgroup.kill?
Message-ID: <lelekt53th2kq7dpz6r7gkifpnxwyk6hwhdko4elshj5qqik3e@cjlyam5ttaoe>
References: <Z5QHE2Qn-QZ6M-KW@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5QHE2Qn-QZ6M-KW@slm.duckdns.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Jan 24, 2025 at 11:33:07AM -1000, Tejun Heo wrote:
> Hello, Christian.
> 
> I was looking at cgroup.kill implementation and wondering whether there
> could be a race window. So, __cgroup_kill() does the following:
> 
>  k1. Set CGRP_KILL.
>  k2. Iterate tasks and deliver SIGKILL.
>  k3. Clear CGRP_KILL.
> 
> The copy_process() does the following:
> 
>  c1. Copy a bunch of stuff.
>  c2. Grab siglock.
>  c3. Check fatal_signal_pending().
>  c4. Commit to forking.
>  c5. Release siglock.
>  c6. Call cgroup_post_fork() which puts the task on the css_set and tests
>      CGRP_KILL.
> 
> The intention seems to be that either a forking task gets SIGKILL and
> terminates on c3 or it sees CGRP_KILL on c6 and kills the child. However, I
> don't see what guarantees that k3 can't happen before c6. ie. After a
> forking task passes c5, k2 can take place and then before the forking task
> reaches c6, k3 can happen. Then, nobody would send SIGKILL to the child.
> What am I missing?
> 
> Thanks.

I think this is indeed the race though small. One way to fix this is by
taking cgroup_threadgroup_rwsem in write mode in __cgroup_kill() as the
fork side takes it in read mode from cgroup_can_fork() to
cgroup_post_fork(). Though I think we should avoid that as this adds
one more potential stall scenario for cgroup.kill which is usually
triggered under extreme situation (memory pressure). I have prototyped a
sequence number based approach below. If that is acceptable then I can
proposed the patch with detailed commit message.


From e9362c5884ea67867ed4fe7e3bb7de7f750a97fc Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Wed, 29 Jan 2025 10:53:21 -0800
Subject: [PATCH] cgroup: fix race between fork and cgroup.kill

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/cgroup-defs.h |  6 +++---
 include/linux/sched/task.h  |  1 +
 kernel/cgroup/cgroup.c      | 17 +++++++++--------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 1b20d2d8ef7c..0d8c12c0efdb 100644
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
@@ -520,6 +517,9 @@ struct cgroup {
 	struct cgroup_rstat_cpu __percpu *rstat_cpu;
 	struct list_head rstat_css_list;
 
+	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	unsigned long kill_seq;
+
 	/*
 	 * Add padding to separate the read mostly rstat_cpu and
 	 * rstat_css_list into a different cacheline from the following
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb0..ce56ae0a9cbb 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -43,6 +43,7 @@ struct kernel_clone_args {
 	void *fn_arg;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	unsigned long kill_seq;
 };
 
 /*
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 805764cf14e2..5aec3b7bc084 100644
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
@@ -6488,6 +6484,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
+	kargs->kill_seq = kargs->cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6670,6 +6667,7 @@ void cgroup_post_fork(struct task_struct *child,
 {
 	unsigned long cgrp_flags = 0;
 	bool kill = false;
+	unsigned long cgrp_kill_seq = 0;
 	struct cgroup_subsys *ss;
 	struct css_set *cset;
 	int i;
@@ -6681,10 +6679,13 @@ void cgroup_post_fork(struct task_struct *child,
 
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
@@ -6719,7 +6720,7 @@ void cgroup_post_fork(struct task_struct *child,
 		 * child down right after we finished preparing it for
 		 * userspace.
 		 */
-		kill = test_bit(CGRP_KILL, &cgrp_flags);
+		kill = kargs->kill_seq != cgrp_kill_seq;
 	}
 
 	spin_unlock_irq(&css_set_lock);
-- 
2.43.5


