Return-Path: <cgroups+bounces-9487-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C448B3BFE7
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 17:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640957B4CDE
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 15:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE533451B2;
	Fri, 29 Aug 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rDs5VGew"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F8E343D74;
	Fri, 29 Aug 2025 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482579; cv=none; b=OcCW+aYzfTSaYQeTNNEhVxiS/vjaaBMS+l+iW5OVee7XvpThOYYyTlcF+I7V7dW2Z6rrX7FUiEgig1VYlo0RimPOZi9xkQ8VesD/qmRRCQYG4slCrtehX6t283fe5zlHj6hQQR/9kc7JxafbQYlvcuDMP9yliQ4J8DPkW2uj9QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482579; c=relaxed/simple;
	bh=hpG0dj5iV2xivxvSMNh4a8MoQwil4rwPsTJqI4z5o6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NVfDnMdVU8RLaMnJbctdmpLvyqdOjvxTgiIJIIbeWwSe5su7UXGUwXbTDAstmWMwsDvkfqJpZJ4OZXR5l2xl9qnvheEGAOqmerGQpTla+LfQ6TcBcjeahMXDkYMXlVqeiB9vP5+cYeyaSLKM6vh9n2ihkfuqmEPRceMduy3JRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rDs5VGew; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E17CC4CEF6;
	Fri, 29 Aug 2025 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482579;
	bh=hpG0dj5iV2xivxvSMNh4a8MoQwil4rwPsTJqI4z5o6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rDs5VGew0+CnTFohXhAoiPDU0BkhoLd+XDyY4j6GP4lx9U0ivy8IfGFyQzhIbdQyq
	 EM86AKCYd15Nyz156BWF16K6jqlA88Et+JA5A7rxo17pBS1oeCbt9GwyhzxZ5FsbSL
	 NVoO8J49QMSVjTANp24I8JzP+r2nQ2pJLXIvMe8gHxHMYthGWq+OrgNG+P4I3+ezjz
	 CeePJ4k44ZN0rzgv/q5TLpptoXowwYGRVmBMhuV5A/tiwFERvEqbBCxy0x/FDGOgnD
	 ekTIf/1+to/q75hHZ+84Fovd1+b88ukUT9XioYG72xOUKiP3mOJI6XkLNnxEdg8YjK
	 ypB4P4tEKZj8A==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 28/33] kthread: Honour kthreads preferred affinity after cpuset changes
Date: Fri, 29 Aug 2025 17:48:09 +0200
Message-ID: <20250829154814.47015-29-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829154814.47015-1-frederic@kernel.org>
References: <20250829154814.47015-1-frederic@kernel.org>
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
index cf99ea844c1d..e76711fa7d34 100644
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
index 8d0c8c4c7e46..4d3cc04e5e8b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -896,14 +896,7 @@ int kthread_affine_preferred(struct task_struct *p, const struct cpumask *mask)
 }
 EXPORT_SYMBOL_GPL(kthread_affine_preferred);
 
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
index 5baf1621a56e..51392eb9b221 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -128,6 +128,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
 	err = workqueue_unbound_exclude_cpumask(housekeeping_cpumask(type));
+	WARN_ON_ONCE(err < 0);
+	err = kthreads_update_housekeeping();
 
 	kfree(old);
 
-- 
2.51.0


