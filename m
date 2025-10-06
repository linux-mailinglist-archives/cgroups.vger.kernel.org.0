Return-Path: <cgroups+bounces-10557-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12000BBDC16
	for <lists+cgroups@lfdr.de>; Mon, 06 Oct 2025 12:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B435C18976FB
	for <lists+cgroups@lfdr.de>; Mon,  6 Oct 2025 10:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D42270EBF;
	Mon,  6 Oct 2025 10:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oiOtLHZM"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31326A0A7;
	Mon,  6 Oct 2025 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759747564; cv=none; b=GDj8g3EdaMMQ5KbLfVytO85UAqa6MYAcf+UJtGK81MUiQQqifokRhLIqC/+3vvmepbeUk/QHe2pkN3Ugw33a5Nwr2PB0az5NHD1f6kpn9cCZscV/9s7GYhB0ntwNIKVVH6OFUeFalVRn0TS5GrutkO2VHZDURofm/yM8IIgmuzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759747564; c=relaxed/simple;
	bh=/WwwZQpNkiY7Vdc4Weg9Fg9nNoU6Mnp6DBjM+eZYf8I=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ABDiOsoP6n9R/MLRfFwQ0qIRLOz5kC1aEG5xJ3uetek0NvZgvbALKYEm77IPlqg+tTDQJkbWMPHtSprkuAFoWrxQYNkP/G+CyWBGiFScKWolMWmiyoLEpVSIwOck15T70eBgGbMsTlfQ2nAN8ah9T4X4rVJi6BKzOq22dDUVOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oiOtLHZM; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=lpYK8Skx9AKfVTqEY+qoQ2vsAZoz9EAzmFb7n9Ub3w8=; b=oiOtLHZM4VVX831snSxca0UWII
	4ovkSgEwHbd5HucpXYZQxOybSamhOPYIQoxt6ntruYHE+4B/FXi+FdRNw8QhcZlmLB2zk8LEZdvCT
	MpabLZHaqY2CQPJ0MJDwp4t76HAZvgV+omYRsusFEWwvCZST+FPRa0ChBzVmQzinjwGLwGH9AB5AF
	/CcNPVWIz4yBXGiNyEFClWv7nnXXEdRK9i6imJYsrsVN0ZRPuOYAh4JXmkG6iPT0I155CdNbJklnq
	TzMXe6iA9P3Br8WY/GB28u8lTxdR2yP8CPzneIcSkICmSPQ3SUzWu+l30YqIUvecWkpTOBjDzZSC5
	2h9xT+kw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5iiz-0000000Grds-0Egh;
	Mon, 06 Oct 2025 10:45:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id DD8B130300D; Mon, 06 Oct 2025 12:45:47 +0200 (CEST)
Message-ID: <20251006104527.451083206@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 06 Oct 2025 12:44:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@kernel.org,
 juri.lelli@redhat.com,
 vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com,
 rostedt@goodmis.org,
 bsegall@google.com,
 mgorman@suse.de,
 vschneid@redhat.com,
 longman@redhat.com,
 hannes@cmpxchg.org,
 mkoutny@suse.com,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 cgroups@vger.kernel.org,
 sched-ext@lists.linux.dev,
 liuwenfang@honor.com,
 tglx@linutronix.de
Subject: [PATCH 08/12] sched: Rename do_set_cpus_allowed()
References: <20251006104402.946760805@infradead.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Hopefully saner naming.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h  |    4 ++--
 kernel/cgroup/cpuset.c |    2 +-
 kernel/kthread.c       |    4 ++--
 kernel/sched/core.c    |   16 ++++++++--------
 kernel/sched/sched.h   |    2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1861,8 +1861,8 @@ extern int task_can_attach(struct task_s
 extern int dl_bw_alloc(int cpu, u64 dl_bw);
 extern void dl_bw_free(int cpu, u64 dl_bw);
 
-/* do_set_cpus_allowed() - consider using set_cpus_allowed_ptr() instead */
-extern void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask);
+/* set_cpus_allowed_force() - consider using set_cpus_allowed_ptr() instead */
+extern void set_cpus_allowed_force(struct task_struct *p, const struct cpumask *new_mask);
 
 /**
  * set_cpus_allowed_ptr - set CPU affinity mask of a task
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4180,7 +4180,7 @@ bool cpuset_cpus_allowed_fallback(struct
 	rcu_read_lock();
 	cs_mask = task_cs(tsk)->cpus_allowed;
 	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask)) {
-		do_set_cpus_allowed(tsk, cs_mask);
+		set_cpus_allowed_force(tsk, cs_mask);
 		changed = true;
 	}
 	rcu_read_unlock();
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -599,7 +599,7 @@ static void __kthread_bind_mask(struct t
 	}
 
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
-		do_set_cpus_allowed(p, mask);
+		set_cpus_allowed_force(p, mask);
 
 	/* It's safe because the task is inactive. */
 	p->flags |= PF_NO_SETAFFINITY;
@@ -880,7 +880,7 @@ int kthread_affine_preferred(struct task
 	kthread_fetch_affinity(kthread, affinity);
 
 	scoped_guard (raw_spinlock_irqsave, &p->pi_lock)
-		do_set_cpus_allowed(p, affinity);
+		set_cpus_allowed_force(p, affinity);
 
 	mutex_unlock(&kthreads_hotplug_lock);
 out:
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2331,7 +2331,7 @@ unsigned long wait_task_inactive(struct
 }
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
+do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
 
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
@@ -2348,7 +2348,7 @@ static void migrate_disable_switch(struc
 
 	scoped_guard (task_rq_lock, p) {
 		update_rq_clock(scope.rq);
-		__do_set_cpus_allowed(p, &ac);
+		do_set_cpus_allowed(p, &ac);
 	}
 }
 
@@ -2662,7 +2662,7 @@ void set_cpus_allowed_common(struct task
 }
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
+do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -2692,7 +2692,7 @@ __do_set_cpus_allowed(struct task_struct
  * Used for kthread_bind() and select_fallback_rq(), in both cases the user
  * affinity (if any) should be destroyed too.
  */
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+void set_cpus_allowed_force(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct affinity_context ac = {
 		.new_mask  = new_mask,
@@ -2706,7 +2706,7 @@ void do_set_cpus_allowed(struct task_str
 
 	scoped_guard (__task_rq_lock, p) {
 		update_rq_clock(scope.rq);
-		__do_set_cpus_allowed(p, &ac);
+		do_set_cpus_allowed(p, &ac);
 	}
 
 	/*
@@ -2745,7 +2745,7 @@ int dup_user_cpus_ptr(struct task_struct
 	 * Use pi_lock to protect content of user_cpus_ptr
 	 *
 	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
-	 * do_set_cpus_allowed().
+	 * set_cpus_allowed_force().
 	 */
 	raw_spin_lock_irqsave(&src->pi_lock, flags);
 	if (src->user_cpus_ptr) {
@@ -3073,7 +3073,7 @@ static int __set_cpus_allowed_ptr_locked
 		goto out;
 	}
 
-	__do_set_cpus_allowed(p, ctx);
+	do_set_cpus_allowed(p, ctx);
 
 	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
 
@@ -3482,7 +3482,7 @@ static int select_fallback_rq(int cpu, s
 			}
 			fallthrough;
 		case possible:
-			do_set_cpus_allowed(p, task_cpu_fallback_mask(p));
+			set_cpus_allowed_force(p, task_cpu_fallback_mask(p));
 			state = fail;
 			break;
 		case fail:
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2617,7 +2617,7 @@ static inline bool task_allowed_on_cpu(s
 static inline cpumask_t *alloc_user_cpus_ptr(int node)
 {
 	/*
-	 * See do_set_cpus_allowed() above for the rcu_head usage.
+	 * See set_cpus_allowed_force() above for the rcu_head usage.
 	 */
 	int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
 



