Return-Path: <cgroups+bounces-9938-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC410B51CD0
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 18:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 459B417929D
	for <lists+cgroups@lfdr.de>; Wed, 10 Sep 2025 16:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD8F3375DD;
	Wed, 10 Sep 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="paNyjDhm"
X-Original-To: cgroups@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A863314BC;
	Wed, 10 Sep 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757520044; cv=none; b=Q7TRm4S9y03wZChX59LHzY+wL8JLD/018GsX2OB6zIug4OpD5L2hy0g512ZDetfokVZuR9XKUGG/nkIw/4lJWMoJIyOeNn24uXtOFBJl1q0Zm4Z5FGJmns/abr32kSCf4Gf6oe1PvEGP7lSGhl6p5Tq36K+NBaAmCuw+GxdT8NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757520044; c=relaxed/simple;
	bh=rIt1lwzsp9XzrZJT1bWsfyVgjSQqSvGb+smlHq7qH/A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GVodH72pNSHqJZmxh5DE3s6RXfsgf4CPZpakCNJlwhyly+UIRdhgtxhttCJGSkttloBzPFJH6HOgI69sEtjB3uBdYdw8NVCahazgS/qjBsQocFY8ug8fXKo9lhGfmVdpDy7veH32gtvuIYbAMYBoDRJmB1Iwa2+EIM43CcL1tL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=paNyjDhm; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=c76h7a/CjjaErQ2AyCehuglLa0jKRK4q3XvZjeWGlBI=; b=paNyjDhmVYhSaEVsZLHANoq5Yw
	dggdv+W6D0xAVmmCAo2UOX18Ijl4dpo4Zn6ioMhxta27uG5NejEfZF2Im+MnZM1G7run23ftLXa9C
	HbpLDFbjEHBI+l45pESmMByCfGudvmJm+WYWMEMT7QhbsHPP8RwPYvlwnTpHCllneFnXrPDejU/qk
	eDk+B63cZc7QfgcYnQkPEKu8vd/pVb+JP0AmlNine8s85nCxVw7dxTLdakg02lD5DwynQg52CfqBI
	cdIrOxjoavrV+cEE686OSJrnFsh7iNxW/rvToxaytR6d5zpEQosdiaWMgcdcvQ5dT3Tl3I2adBwRX
	pQX6Z84A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwNFG-00000005ufH-37qg;
	Wed, 10 Sep 2025 16:00:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 97E19302F33; Wed, 10 Sep 2025 18:00:28 +0200 (CEST)
Message-ID: <20250910155809.219537898@infradead.org>
User-Agent: quilt/0.68
Date: Wed, 10 Sep 2025 17:44:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tj@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
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
Subject: [PATCH 08/14] sched: Rename do_set_cpus_allowed()
References: <20250910154409.446470175@infradead.org>
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
@@ -1860,8 +1860,8 @@ extern int task_can_attach(struct task_s
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
@@ -4122,7 +4122,7 @@ bool cpuset_cpus_allowed_fallback(struct
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
@@ -2329,7 +2329,7 @@ unsigned long wait_task_inactive(struct
 }
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
+do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx);
 
 static void migrate_disable_switch(struct rq *rq, struct task_struct *p)
 {
@@ -2346,7 +2346,7 @@ static void migrate_disable_switch(struc
 
 	scoped_guard (task_rq_lock, p) {
 		update_rq_clock(scope.rq);
-		__do_set_cpus_allowed(p, &ac);
+		do_set_cpus_allowed(p, &ac);
 	}
 }
 
@@ -2697,7 +2697,7 @@ void set_cpus_allowed_common(struct task
 }
 
 static void
-__do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
+do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 {
 	struct rq *rq = task_rq(p);
 	bool queued, running;
@@ -2727,7 +2727,7 @@ __do_set_cpus_allowed(struct task_struct
  * Used for kthread_bind() and select_fallback_rq(), in both cases the user
  * affinity (if any) should be destroyed too.
  */
-void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
+void set_cpus_allowed_force(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct affinity_context ac = {
 		.new_mask  = new_mask,
@@ -2741,7 +2741,7 @@ void do_set_cpus_allowed(struct task_str
 
 	scoped_guard (__task_rq_lock, p) {
 		update_rq_clock(scope.rq);
-		__do_set_cpus_allowed(p, &ac);
+		do_set_cpus_allowed(p, &ac);
 	}
 
 	/*
@@ -2780,7 +2780,7 @@ int dup_user_cpus_ptr(struct task_struct
 	 * Use pi_lock to protect content of user_cpus_ptr
 	 *
 	 * Though unlikely, user_cpus_ptr can be reset to NULL by a concurrent
-	 * do_set_cpus_allowed().
+	 * set_cpus_allowed_force().
 	 */
 	raw_spin_lock_irqsave(&src->pi_lock, flags);
 	if (src->user_cpus_ptr) {
@@ -3108,7 +3108,7 @@ static int __set_cpus_allowed_ptr_locked
 		goto out;
 	}
 
-	__do_set_cpus_allowed(p, ctx);
+	do_set_cpus_allowed(p, ctx);
 
 	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);
 
@@ -3517,7 +3517,7 @@ static int select_fallback_rq(int cpu, s
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
@@ -2592,7 +2592,7 @@ static inline bool task_allowed_on_cpu(s
 static inline cpumask_t *alloc_user_cpus_ptr(int node)
 {
 	/*
-	 * See do_set_cpus_allowed() above for the rcu_head usage.
+	 * See set_cpus_allowed_force() above for the rcu_head usage.
 	 */
 	int size = max_t(int, cpumask_size(), sizeof(struct rcu_head));
 



