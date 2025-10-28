Return-Path: <cgroups+bounces-11238-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6B4C12CC4
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 04:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35DD01AA7300
	for <lists+cgroups@lfdr.de>; Tue, 28 Oct 2025 03:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2074B280329;
	Tue, 28 Oct 2025 03:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7OtKh9a"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1ED27FD44
	for <cgroups@vger.kernel.org>; Tue, 28 Oct 2025 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623081; cv=none; b=md2/TK/pLWlCqpZhzTx5DYW32TOGnDRtT/94h93N2JPwuS4qxOrjPCp5E24Ro/nvwyZooJLxECe15aQVT2aVqAl02SRgIwyGHAovJbpsSW3/XyKMNxbw+Eg59OWyG5tlqRux2EBLJfcIwafZN1TjEoedYTF9m3PrzG5xJqmFF4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623081; c=relaxed/simple;
	bh=pkIXgLPS067ti28/pkxAS7WedcmKZnXYQr26AX9croA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s8bs55+1B5oIzJhZdigBy9Nz4yXmnvaGRmolhg06fcRm/PL2iegWtd/laygHyg5b9/9VD3poub5YZzmJ6HVvX7nlMnGkgAaYIrYpjMt875pZMhQ20LyC4MLRh+rtz0iCs+1OAfaqTFuc3E9G44Dmfwjliq6cJICVT1yEfYH4HeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7OtKh9a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761623078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsRifqcw0qam8kbmnOiIajFJpiQM+jrQfgn3lQBdMtI=;
	b=P7OtKh9aztropbN6RB8OoYHpc6qwRCwtk9TN5N1RiQUU0prMM2JX5t+HFgS5bY1AhWeRtp
	kXRm+HqSYRTToMI/XQSPPy1FmfGM+FF20x3a/HnHYnYZ+lXuZ5ebc2QjqYPrCo8xLHwbCc
	osugVsZjgo4awnv97jRkLz5qWOBFAWE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-KWpaNaHyPs-mIOric-R6fQ-1; Mon,
 27 Oct 2025 23:44:36 -0400
X-MC-Unique: KWpaNaHyPs-mIOric-R6fQ-1
X-Mimecast-MFC-AGG-ID: KWpaNaHyPs-mIOric-R6fQ_1761623074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BBDF41800C32;
	Tue, 28 Oct 2025 03:44:33 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.72.112.84])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57C9B1800451;
	Tue, 28 Oct 2025 03:44:23 +0000 (UTC)
From: Pingfan Liu <piliu@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Pingfan Liu <piliu@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCHv4 2/2] sched/deadline: Walk up cpuset hierarchy to decide root domain when hot-unplug
Date: Tue, 28 Oct 2025 11:43:56 +0800
Message-ID: <20251028034357.11055-2-piliu@redhat.com>
In-Reply-To: <20251028034357.11055-1-piliu@redhat.com>
References: <20251028034357.11055-1-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

*** Bug description ***
When testing kexec-reboot on a 144 cpus machine with
isolcpus=managed_irq,domain,1-71,73-143 in kernel command line, I
encounter the following bug:

[   97.114759] psci: CPU142 killed (polled 0 ms)
[   97.333236] Failed to offline CPU143 - error=-16
[   97.333246] ------------[ cut here ]------------
[   97.342682] kernel BUG at kernel/cpu.c:1569!
[   97.347049] Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
[...]

In essence, the issue originates from the CPU hot-removal process, not
limited to kexec. It can be reproduced by writing a SCHED_DEADLINE
program that waits indefinitely on a semaphore, spawning multiple
instances to ensure some run on CPU 72, and then offlining CPUs 1–143
one by one. When attempting this, CPU 143 failed to go offline.
  bash -c 'taskset -cp 0 $$ && for i in {1..143}; do echo 0 > /sys/devices/system/cpu/cpu$i/online 2>/dev/null; done'

`
*** Issue ***
Tracking down this issue, I found that dl_bw_deactivate() returned
-EBUSY, which caused sched_cpu_deactivate() to fail on the last CPU.
But that is not the fact, and contributed by the following factors:
When a CPU is inactive, cpu_rq()->rd is set to def_root_domain. For an
blocked-state deadline task (in this case, "cppc_fie"), it was not
migrated to CPU0, and its task_rq() information is stale. So its rq->rd
points to def_root_domain instead of the one shared with CPU0.  As a
result, its bandwidth is wrongly accounted into a wrong root domain
during domain rebuild.

The key point is that root_domain is only tracked through active rq->rd.
To avoid using a global data structure to track all root_domains in the
system, there should be a method to locate an active CPU within the
corresponding root_domain.

*** Solution ***
To locate the active cpu, the following rules for deadline
sub-system is useful
  -1.any cpu belongs to a unique root domain at a given time
  -2.DL bandwidth checker ensures that the root domain has active cpus.

Now, let's examine the blocked-state task P.
If P is attached to a cpuset that is a partition root, it is
straightforward to find an active CPU.
If P is attached to a cpuset that has changed from 'root' to 'member',
the active CPUs are grouped into the parent root domain. Naturally, the
CPUs' capacity and reserved DL bandwidth are taken into account in the
ancestor root domain. (In practice, it may be unsafe to attach P to an
arbitrary root domain, since that domain may lack sufficient DL
bandwidth for P.) Again, it is straightforward to find an active CPU in
the ancestor root domain.

This patch groups CPUs into isolated and housekeeping sets. For the
housekeeping group, it walks up the cpuset hierarchy to find active CPUs
in P's root domain and retrieves the valid rd from cpu_rq(cpu)->rd.

Signed-off-by: Pingfan Liu <piliu@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: "Michal Koutný" <mkoutny@suse.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Pierre Gondois <pierre.gondois@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Valentin Schneider <vschneid@redhat.com>
To: cgroups@vger.kernel.org
To: linux-kernel@vger.kernel.org
---
v3 -> v4:
rename function with cpuset_ prefix
improve commit log

 include/linux/cpuset.h  | 18 ++++++++++++++++++
 kernel/cgroup/cpuset.c  | 26 ++++++++++++++++++++++++++
 kernel/sched/deadline.c | 30 ++++++++++++++++++++++++------
 3 files changed, 68 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 2ddb256187b51..d4da93e51b37b 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/sched/topology.h>
 #include <linux/sched/task.h>
+#include <linux/sched/housekeeping.h>
 #include <linux/cpumask.h>
 #include <linux/nodemask.h>
 #include <linux/mm.h>
@@ -130,6 +131,7 @@ extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
 extern void cpuset_reset_sched_domains(void);
+extern void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus);
 
 /*
  * read_mems_allowed_begin is required when making decisions involving
@@ -276,6 +278,22 @@ static inline void cpuset_reset_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
+static inline void cpuset_get_task_effective_cpus(struct task_struct *p,
+		struct cpumask *cpus)
+{
+	const struct cpumask *hk_msk;
+
+	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
+		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
+			/* isolated cpus belong to a root domain */
+			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
+			return;
+		}
+	}
+	cpumask_and(cpus, cpu_active_mask, hk_msk);
+}
+
 static inline void cpuset_print_current_mems_allowed(void)
 {
 }
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675d..6ad88018f1a4e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1102,6 +1102,32 @@ void cpuset_reset_sched_domains(void)
 	mutex_unlock(&cpuset_mutex);
 }
 
+/* caller hold RCU read lock */
+void cpuset_get_task_effective_cpus(struct task_struct *p, struct cpumask *cpus)
+{
+	const struct cpumask *hk_msk;
+	struct cpuset *cs;
+
+	hk_msk = housekeeping_cpumask(HK_TYPE_DOMAIN);
+	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
+		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
+			/* isolated cpus belong to a root domain */
+			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
+			return;
+		}
+	}
+	/* In HK_TYPE_DOMAIN, cpuset can be applied */
+	cs = task_cs(p);
+	while (cs != &top_cpuset) {
+		if (is_sched_load_balance(cs))
+			break;
+		cs = parent_cs(cs);
+	}
+
+	/* For top_cpuset, its effective_cpus does not exclude isolated cpu */
+	cpumask_and(cpus, cs->effective_cpus, hk_msk);
+}
+
 /**
  * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 72c1f72463c75..a3a43baf4314e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2884,6 +2884,8 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq_flags rf;
 	struct rq *rq;
 	struct dl_bw *dl_b;
+	unsigned int cpu;
+	struct cpumask msk;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
@@ -2891,16 +2893,32 @@ void dl_add_task_root_domain(struct task_struct *p)
 		return;
 	}
 
-	rq = __task_rq_lock(p, &rf);
-
+	/* prevent race among cpu hotplug, changing of partition_root_state */
+	lockdep_assert_cpus_held();
+	/*
+	 * If @p is in blocked state, task_cpu() may be not active. In that
+	 * case, rq->rd does not trace a correct root_domain. On the other hand,
+	 * @p must belong to an root_domain at any given time, which must have
+	 * active rq, whose rq->rd traces the valid root domain.
+	 */
+	cpuset_get_task_effective_cpus(p, &msk);
+	cpu = cpumask_first_and(cpu_active_mask, &msk);
+	/*
+	 * If a root domain reserves bandwidth for a DL task, the DL bandwidth
+	 * check prevents CPU hot removal from deactivating all CPUs in that
+	 * domain.
+	 */
+	BUG_ON(cpu >= nr_cpu_ids);
+	rq = cpu_rq(cpu);
+	/*
+	 * This point is under the protection of cpu_hotplug_lock. Hence
+	 * rq->rd is stable.
+	 */
 	dl_b = &rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
-
 	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
-
 	raw_spin_unlock(&dl_b->lock);
-
-	task_rq_unlock(rq, p, &rf);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
 
 void dl_clear_root_domain(struct root_domain *rd)
-- 
2.49.0


