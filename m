Return-Path: <cgroups+bounces-8617-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF2AE1EA3
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 17:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A1E166F11
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 15:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34832EFD82;
	Fri, 20 Jun 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAjCYF5W"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08872DCC05;
	Fri, 20 Jun 2025 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433064; cv=none; b=GDhjxaKEkaK4Pvf8e710YZ4563k4orXERzK+p/frX+qIj1yYkZ4GQb55gCREy48haXj7FkjIPrbGsllt7jXrj9KZ0F400d/BHaeGctkvkTDygIXqAlXuujvd4tutwrAPXLnRMKvWMLzBEvq7GMyoBFrgo4Fi46mF3Lui51Udacc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433064; c=relaxed/simple;
	bh=7c2L9Rkr1Q3nbhXIN3mYilgx0lbW4iBrIbPuK7IzLQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RNGXvzBf3JZ5/CoCzhE3pQINYmhWszPQX9DL37TlKImS6l5hv8YooB1hejs6x6wfc7AMrSRWWC9pjB41FXvwUoPdH0g7uTrRppDdJoA5djlAIbaIfFcj6znPx5oc4suWr57vovGoisWS5JRqIUy1OTnGBaXlFCExEa90gug+AMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAjCYF5W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CBCC4CEF1;
	Fri, 20 Jun 2025 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433064;
	bh=7c2L9Rkr1Q3nbhXIN3mYilgx0lbW4iBrIbPuK7IzLQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAjCYF5WIBh0wREJw2JnCFFkjoim4hOhMVvtZxkqoTv+Ps9zV8by/OD9UQrsm12aE
	 +4xutNHniS1BMpSZUpFV67R9hJtLpOCbGoGw57X+hhqKKx7wiR2SjLZvuBtpAoPGqN
	 boINr+Yvf8YFLTceOTik+6EUnuOvo36c8hiRSQGB+sUPMZf5hb3OYP6A2E4Bg0Hkif
	 AaBHkB1vcT03yFmzHg5hAXAvLgT53+HOc3Lr40yK1q5QY1gza/ZeD6t26woyiNaa+s
	 KcOBM0OgYeN4IBYTUdbOS/1WANJQb0QgpyvRWUCRe1lDOnmiDFQUkyftbf3LftJUc1
	 k7SkbLWM/z0rQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 26/27] kthread: Honour kthreads preferred affinity after cpuset changes
Date: Fri, 20 Jun 2025 17:23:07 +0200
Message-ID: <20250620152308.27492-27-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250620152308.27492-1-frederic@kernel.org>
References: <20250620152308.27492-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When cpuset isolated partitions get updated, unbound kthreads get
indifferently affine to all non isolated CPUs, regardless of their
individual affinity preferences.

For example kswapd is a per-node kthread that prefers to be affine to
the node it refers to. Whenever an isolated partition is created,
updated or deleted, kswapd's node affinity is going to be broken if any
CPU in the related node is not isolated because kswapd will be affine
globally.

Fix this with letting the consolidated kthread managed affinity code do
the affinity update on behalf of cpuset.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/kthread.h  |  1 +
 kernel/cgroup/cpuset.c   |  5 ++---
 kernel/kthread.c         | 38 +++++++++++++++++++++++++++++---------
 kernel/sched/isolation.c |  2 ++
 4 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 8d27403888ce..c92c1149ee6e 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -100,6 +100,7 @@ void kthread_unpark(struct task_struct *k);
 void kthread_parkme(void);
 void kthread_exit(long result) __noreturn;
 void kthread_complete_and_exit(struct completion *, long) __noreturn;
+int kthreads_update_housekeeping(void);
 
 int kthreadd(void *unused);
 extern struct task_struct *kthreadd_task;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index db80e72681ed..99ee187d941b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1130,11 +1130,10 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
 		if (top_cs) {
 			/*
+			 * PF_KTHREAD tasks are handled by housekeeping.
 			 * PF_NO_SETAFFINITY tasks are ignored.
-			 * All per cpu kthreads should have PF_NO_SETAFFINITY
-			 * flag set, see kthread_set_per_cpu().
 			 */
-			if (task->flags & PF_NO_SETAFFINITY)
+			if (task->flags & (PF_KTHREAD | PF_NO_SETAFFINITY))
 				continue;
 			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
 		} else {
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 42cd6e119335..8c1268c2cee9 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -896,14 +896,7 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
 	return ret;
 }
 
-/*
- * Re-affine kthreads according to their preferences
- * and the newly online CPU. The CPU down part is handled
- * by select_fallback_rq() which default re-affines to
- * housekeepers from other nodes in case the preferred
- * affinity doesn't apply anymore.
- */
-static int kthreads_online_cpu(unsigned int cpu)
+static int kthreads_update_affinity(bool force)
 {
 	cpumask_var_t affinity;
 	struct kthread *k;
@@ -926,7 +919,7 @@ static int kthreads_online_cpu(unsigned int cpu)
 			continue;
 		}
 
-		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
+		if (force || k->preferred_affinity || k->node != NUMA_NO_NODE) {
 			kthread_fetch_affinity(k, affinity);
 			set_cpus_allowed_ptr(k->task, affinity);
 		}
@@ -937,6 +930,33 @@ static int kthreads_online_cpu(unsigned int cpu)
 	return ret;
 }
 
+/**
+ * kthreads_update_housekeeping - Update kthreads affinity on cpuset change
+ *
+ * When cpuset changes a partition type to/from "isolated" or updates related
+ * cpumasks, propagate the housekeeping cpumask change to preferred kthreads
+ * affinity.
+ *
+ * Returns 0 if successful, -ENOMEM if temporary mask couldn't
+ * be allocated or -EINVAL in case of internal error.
+ */
+int kthreads_update_housekeeping(void)
+{
+	return kthreads_update_affinity(true);
+}
+
+/*
+ * Re-affine kthreads according to their preferences
+ * and the newly online CPU. The CPU down part is handled
+ * by select_fallback_rq() which default re-affines to
+ * housekeepers from other nodes in case the preferred
+ * affinity doesn't apply anymore.
+ */
+static int kthreads_online_cpu(unsigned int cpu)
+{
+	return kthreads_update_affinity(false);
+}
+
 static int kthreads_init(void)
 {
 	return cpuhp_setup_state(CPUHP_AP_KTHREADS_ONLINE, "kthreads:online",
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index e4e4fcd4cb2c..2750b80a5511 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -144,6 +144,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
 	err = workqueue_unbound_exclude_cpumask(housekeeping_cpumask(type));
+	WARN_ON_ONCE(err < 0);
+	err = kthreads_update_housekeeping();
 
 	kfree(old);
 
-- 
2.48.1


