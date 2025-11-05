Return-Path: <cgroups+bounces-11638-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8EAC37EB5
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8278034E8EA
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C73F350A18;
	Wed,  5 Nov 2025 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLDkMjKl"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028534CFA0;
	Wed,  5 Nov 2025 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376863; cv=none; b=LP8USN7mSA3cxpGJwS6/DTv24bIqH050KD3LXKloGd1jxB81LmlwL/CeFHIPPBKZ6iQV+7lqeL8w2kf6xHcDntsMxVD125BslTFkhH4Ku3yu0pWIxRiiTiXgDxPIKGtN6csSCj7eZo4IfowU5QmA4hFuMuzOB/1qsDZWfQ2XGpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376863; c=relaxed/simple;
	bh=6jwYeig2zqPrmwGwM4pQrsHIUOv6qqFjI/kog2VhZlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgLz+Xe/VVEZA4bOcbzxgTA9j/Np3x0XAZd8+M4d2RxH1xx0iKpf225dt4tg5zQfRQPXC13I9sWaUxMkV63KedSg0uoRjb3JpF1+8ZU9POlv13E/P/PwfWKW1p8NBpF1qdix11gacMC/KLL/2wj8nPmIjwRfOEqkAItJLKqJ6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLDkMjKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0115EC116B1;
	Wed,  5 Nov 2025 21:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376863;
	bh=6jwYeig2zqPrmwGwM4pQrsHIUOv6qqFjI/kog2VhZlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WLDkMjKlR2GjM6ul10cb70ghHeSr5aremTf7CjKkC/5QKjY04kalvpwuwnKK4I5NY
	 IEO/g7jz17F5MZF1gqOpJNb6UxGmp6JHci/Qa5aPe7GOuNcZsnGK1YtNlkgGRrC+ka
	 DxmVtLqKmpAvFgJvU4RPxh/CZbJHpONR7S74p0VLnz8YRnymh5W+/aGYeh++jcRsgR
	 Js/L3sSGqqg+cb6eDfgLzf69RQ8Pqw98poq7YGmCkDDJT8etX5MyL8Z/gL95TOFsqr
	 BJ5Uly3TzQphQ9EKLsa+FCZImOjNeyUAZRabscSXCaRpMuJc99OamaZpN1Fx7tIPjT
	 6iPf8Cpfdggkw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	cgroups@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 28/31] kthread: Honour kthreads preferred affinity after cpuset changes
Date: Wed,  5 Nov 2025 22:03:44 +0100
Message-ID: <20251105210348.35256-29-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
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
 kernel/kthread.c         | 41 ++++++++++++++++++++++++++++++----------
 kernel/sched/isolation.c |  2 ++
 4 files changed, 36 insertions(+), 13 deletions(-)

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
index 817c07a7a1b4..bc3f18ead7c8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1182,11 +1182,10 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
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
index 69d70baceba2..f535d4e66a71 100644
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
@@ -929,7 +922,8 @@ static int kthreads_online_cpu(unsigned int cpu)
 		/*
 		 * Unbound kthreads without preferred affinity are already affine
 		 * to housekeeping, whether those CPUs are online or not. So no need
-		 * to handle newly online CPUs for them.
+		 * to handle newly online CPUs for them. However housekeeping changes
+		 * have to be applied.
 		 *
 		 * But kthreads with a preferred affinity or node are different:
 		 * if none of their preferred CPUs are online and part of
@@ -937,7 +931,7 @@ static int kthreads_online_cpu(unsigned int cpu)
 		 * But as soon as one of their preferred CPU becomes online, they must
 		 * be affine to them.
 		 */
-		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
+		if (force || k->preferred_affinity || k->node != NUMA_NO_NODE) {
 			kthread_fetch_affinity(k, affinity);
 			set_cpus_allowed_ptr(k->task, affinity);
 		}
@@ -948,6 +942,33 @@ static int kthreads_online_cpu(unsigned int cpu)
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
index bad5fdf7e991..bc77c87e93ac 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -151,6 +151,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
 	err = workqueue_unbound_housekeeping_update(housekeeping_cpumask(type));
+	WARN_ON_ONCE(err < 0);
+	err = kthreads_update_housekeeping();
 
 	kfree(old);
 
-- 
2.51.0


