Return-Path: <cgroups+bounces-14760-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPH0HkVbsWmGtwIAu9opvQ
	(envelope-from <cgroups+bounces-14760-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 13:08:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E642636FD
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 13:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6EB4A303AE7D
	for <lists+cgroups@lfdr.de>; Wed, 11 Mar 2026 12:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66193DDDD6;
	Wed, 11 Mar 2026 12:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UBr1dlLZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3b/o61/S"
X-Original-To: cgroups@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208103C3422
	for <cgroups@vger.kernel.org>; Wed, 11 Mar 2026 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230915; cv=none; b=nj8M5O2ZbHE8YrAZAFKWBc0vk55khzgcjZam1X/p+iFUCScthcr01ddgK2SeGlpnnzJdkV3r4+ee3D8pB9sd9uPROYOEi88ZxpbHotifawJI0mwTARbNJHYnOFh6J8aOL43Me/RTJlyrSdtOKk8F0/vkVCX+vB2wcNXqb+xhWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230915; c=relaxed/simple;
	bh=efjC71zvjkjWfUprLrQvMvusj/zTTr5jRO24IkM4HL8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ErqA2HS/lX7hAh5nGMBJJW6m1vjF7e44cVb6/BE7r42f7KVIEMu9zMAf8VL7i/i4Gg8MLAC0uvnmqScmu60VPaKEfdHuykgdRk96eua9mGBPAGpvXxDqTBS8opH0qZAoDoD0HrIZoHqzqmPj2eYhU6aSp22Ll/tu38UMXrkYP4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UBr1dlLZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3b/o61/S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 11 Mar 2026 13:08:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773230911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bHpQtlcPZsjY2AgzGLmBLR+0aWL6BXrmVVrSWNkto/Q=;
	b=UBr1dlLZisqWKCTHwYahPDzSWJShAEMFkYLAtfD5UArjcSlHyqqzfLGc/185wdlLyUfrLD
	bmA3H2Q81QKTtAPVcUYC3PgSONWKZluEhV2GJlxdllJ4ir4MQqv23GO+cU6iILie5Wj+Re
	fhvDqsLOlsSpsL4HIDl3rJoBCl2hJsQn6D1IObVeZbrq9C56HItcSvk51Dbp5ocLZXkUE1
	5Hx9NzidsXNaethaTVr7GJqxRgTbzB8aR4PKkeLfsAM62prbASG/uA/LzXSRAsjpYwnels
	7KNEkphhRmpuRshAz/YPXPL/xhvmWPRE98Ci70LhNAMWYxpJs/Gnm9OQMAUMTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773230911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=bHpQtlcPZsjY2AgzGLmBLR+0aWL6BXrmVVrSWNkto/Q=;
	b=3b/o61/S3cEmYNmHbJo0oNPmaPVlHWb/RlvXBT7KZLgKPZy0jpPeQuJ1Aq5L8Z9+uk5we3
	lfRY16O4nTps7XBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: cgroups@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
	Ben Segall <bsegall@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] cgroup: Move cgroup_task_dead() to task_struct clean up
Message-ID: <20260311120829.rEHY-xh9@linutronix.de>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Queue-Id: 17E642636FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14760-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:email,linutronix.de:mid]
X-Rspamd-Action: no action

The cgroup clean up (via cgroup_task_dead()) has been moved to
finish_task_switch() so that sched_ext can observe the task attached to
its cgroups one last time before the task is gone.

This clean up has been added to irq_work on PREEMPT_RT because
finish_task_switch() is invoked with disabled preemption and
cgroup_task_dead() needs to acquire sleeping locks.

Invoking cgroup_task_dead() in finish_task_switch() is too late and
creates a small window in which the task is observed in the cgroup list
after it died and this confuses systemd. To close the window, tasks
which are exiting are no longer exposed to the user. Now there is no
reason to invoke cgroup_task_dead() in finish_task_switch() and it can
be delayed further so simplify the code.

Move cgroup_task_dead() to cgroup_task_free() which is invoked during
RCU clean up of the task_struct.

Fixes: 9311e6c29b34 ("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/cgroup.h |  2 --
 include/linux/sched.h  |  3 ---
 kernel/cgroup/cgroup.c | 56 ++----------------------------------------
 kernel/sched/core.c    |  6 -----
 4 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index bc892e3b37eea..4068035176c41 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -138,7 +138,6 @@ extern void cgroup_cancel_fork(struct task_struct *p,
 extern void cgroup_post_fork(struct task_struct *p,
 			     struct kernel_clone_args *kargs);
 void cgroup_task_exit(struct task_struct *p);
-void cgroup_task_dead(struct task_struct *p);
 void cgroup_task_release(struct task_struct *p);
 void cgroup_task_free(struct task_struct *p);
 
@@ -682,7 +681,6 @@ static inline void cgroup_cancel_fork(struct task_struct *p,
 static inline void cgroup_post_fork(struct task_struct *p,
 				    struct kernel_clone_args *kargs) {}
 static inline void cgroup_task_exit(struct task_struct *p) {}
-static inline void cgroup_task_dead(struct task_struct *p) {}
 static inline void cgroup_task_release(struct task_struct *p) {}
 static inline void cgroup_task_free(struct task_struct *p) {}
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a7b4a980eb2f0..375d0c958081d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1321,9 +1321,6 @@ struct task_struct {
 	struct css_set __rcu		*cgroups;
 	/* cg_list protected by css_set_lock and tsk->alloc_lock: */
 	struct list_head		cg_list;
-#ifdef CONFIG_PREEMPT_RT
-	struct llist_node		cg_dead_lnode;
-#endif	/* CONFIG_PREEMPT_RT */
 #endif	/* CONFIG_CGROUPS */
 #ifdef CONFIG_X86_CPU_RESCTRL
 	u32				closid;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 7921633ea1058..684b773cd5cb4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -285,7 +285,6 @@ static void kill_css(struct cgroup_subsys_state *css);
 static int cgroup_addrm_files(struct cgroup_subsys_state *css,
 			      struct cgroup *cgrp, struct cftype cfts[],
 			      bool is_add);
-static void cgroup_rt_init(void);
 
 #ifdef CONFIG_DEBUG_CGROUP_REF
 #define CGROUP_REF_FN_ATTRS	noinline
@@ -6362,7 +6361,6 @@ int __init cgroup_init(void)
 	BUG_ON(ss_rstat_init(NULL));
 
 	get_user_ns(init_cgroup_ns.user_ns);
-	cgroup_rt_init();
 
 	cgroup_lock();
 
@@ -6993,7 +6991,7 @@ void cgroup_task_exit(struct task_struct *tsk)
 	} while_each_subsys_mask();
 }
 
-static void do_cgroup_task_dead(struct task_struct *tsk)
+static void cgroup_task_dead(struct task_struct *tsk)
 {
 	struct css_set *cset;
 	unsigned long flags;
@@ -7019,57 +7017,6 @@ static void do_cgroup_task_dead(struct task_struct *tsk)
 	spin_unlock_irqrestore(&css_set_lock, flags);
 }
 
-#ifdef CONFIG_PREEMPT_RT
-/*
- * cgroup_task_dead() is called from finish_task_switch() which doesn't allow
- * scheduling even in RT. As the task_dead path requires grabbing css_set_lock,
- * this lead to sleeping in the invalid context warning bug. css_set_lock is too
- * big to become a raw_spinlock. The task_dead path doesn't need to run
- * synchronously but can't be delayed indefinitely either as the dead task pins
- * the cgroup and task_struct can be pinned indefinitely. Bounce through lazy
- * irq_work to allow batching while ensuring timely completion.
- */
-static DEFINE_PER_CPU(struct llist_head, cgrp_dead_tasks);
-static DEFINE_PER_CPU(struct irq_work, cgrp_dead_tasks_iwork);
-
-static void cgrp_dead_tasks_iwork_fn(struct irq_work *iwork)
-{
-	struct llist_node *lnode;
-	struct task_struct *task, *next;
-
-	lnode = llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
-	llist_for_each_entry_safe(task, next, lnode, cg_dead_lnode) {
-		do_cgroup_task_dead(task);
-		put_task_struct(task);
-	}
-}
-
-static void __init cgroup_rt_init(void)
-{
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		init_llist_head(per_cpu_ptr(&cgrp_dead_tasks, cpu));
-		per_cpu(cgrp_dead_tasks_iwork, cpu) =
-			IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);
-	}
-}
-
-void cgroup_task_dead(struct task_struct *task)
-{
-	get_task_struct(task);
-	llist_add(&task->cg_dead_lnode, this_cpu_ptr(&cgrp_dead_tasks));
-	irq_work_queue(this_cpu_ptr(&cgrp_dead_tasks_iwork));
-}
-#else	/* CONFIG_PREEMPT_RT */
-static void __init cgroup_rt_init(void) {}
-
-void cgroup_task_dead(struct task_struct *task)
-{
-	do_cgroup_task_dead(task);
-}
-#endif	/* CONFIG_PREEMPT_RT */
-
 void cgroup_task_release(struct task_struct *task)
 {
 	struct cgroup_subsys *ss;
@@ -7084,6 +7031,7 @@ void cgroup_task_free(struct task_struct *task)
 {
 	struct css_set *cset = task_css_set(task);
 
+	cgroup_task_dead(task);
 	if (!list_empty(&task->cg_list)) {
 		spin_lock_irq(&css_set_lock);
 		css_set_skip_task_iters(task_css_set(task), task);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b7f77c165a6e0..0e67f6db3204a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5181,13 +5181,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
-		/*
-		 * sched_ext_dead() must come before cgroup_task_dead() to
-		 * prevent cgroups from being removed while its member tasks are
-		 * visible to SCX schedulers.
-		 */
 		sched_ext_dead(prev);
-		cgroup_task_dead(prev);
 
 		/* Task is done with its stack. */
 		put_task_stack(prev);
-- 
2.53.0


