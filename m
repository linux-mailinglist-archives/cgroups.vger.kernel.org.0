Return-Path: <cgroups+bounces-8615-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6CAAE1EAC
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 17:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E8C1C24ED8
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465CB2ED15A;
	Fri, 20 Jun 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy9+tazX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010F02ED151;
	Fri, 20 Jun 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433045; cv=none; b=mm+R3zu8gonFJMHIvsqV/sXs5CWwO6WMrxw0nAUI7HtIBwTAIRNdTsXbX0RjVauFHS7CE/9ZHTxK3+ZWH5cauNkxoXQ3BmshBUbdFRV5rOZbHjTsDsaV2PBQ7DQLzP5eQx40Ipwmj3TO74a/EVYmvgvVMD2sMGgMjr1Lg63F/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433045; c=relaxed/simple;
	bh=9V0n3RkIDJ8tgZuANPwTkG5LhMQIqvQ3Cah86/5LM3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UI7gGzEPqetwJaE/fsenpxa6/N/N5TaWqFqivz+eSDnFll+TZWh5/StmgWPexIcyJwRIQznxN7+uFOYUjIk0zRIBHQnGdzh72t6IFUYWo82Y187eP1fxiMeAkZe2a7EijI33GfhjHQ1fqD/A+DbX8znc7uSFrHJDHbkVAT6KZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy9+tazX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46AD0C4CEE3;
	Fri, 20 Jun 2025 15:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433044;
	bh=9V0n3RkIDJ8tgZuANPwTkG5LhMQIqvQ3Cah86/5LM3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hy9+tazXLVopXk6HxaS8WpZzonRumoRBM7gZXiF9a6M93nejHjUhbe9VIbFBqge0T
	 jbCdJLjnKueb0sAmzqGq8JCBq6yPC5MzrxmpdYx7LjSZMmLOdpH/ECIaPtQMmmlVb5
	 JUrkONdygArMKD/JDMaRx77MDimWrumB2A3MsPpEVzN5w4KYyAioabVYXSHdoMUU0H
	 JRp9rUx2vaOxtaskQSShCw6H1p11GCfx3xwMaorTXQbGF+mtr98TBpuRUkw02MDlQ7
	 1xXYL0cDe3yeZWnZxtxu3iyvU7x1QVBP7b9UU4/7o1rxTnG/Jeow9ygu+jtedtbG/2
	 wgTpjuxmFnE9g==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 18/27] cpuset: Propagate cpuset isolation update to workqueue through housekeeping
Date: Fri, 20 Jun 2025 17:22:59 +0200
Message-ID: <20250620152308.27492-19-frederic@kernel.org>
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

Until now, cpuset would propagate isolated partition changes to
workqueues so that unbound workers get properly reaffined.

Since housekeeping now centralizes, synchronize and propagates isolation
cpumask changes, perform the work from that subsystem for consolidation
and consistency purposes.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/workqueue.h |  2 +-
 init/Kconfig              |  1 +
 kernel/cgroup/cpuset.c    | 14 ++++++--------
 kernel/sched/isolation.c  |  4 +++-
 kernel/workqueue.c        |  2 +-
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 6e30f275da77..8a32c594bba1 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -581,7 +581,7 @@ struct workqueue_attrs *alloc_workqueue_attrs(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
-extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
+extern int workqueue_unbound_exclude_cpumask(const struct cpumask *cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/init/Kconfig b/init/Kconfig
index af4c2f085455..b7cbb6e01e8d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1205,6 +1205,7 @@ config CPUSETS
 	bool "Cpuset controller"
 	depends on SMP
 	select UNION_FIND
+	select CPU_ISOLATION
 	help
 	  This option will let you create and manage CPUSETs which
 	  allow dynamically partitioning a system into sets of CPUs and
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5f169a56f06c..98b1ea0ad336 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1340,7 +1340,7 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return isolcpus_updated;
 }
 
-static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
+static void update_housekeeping_cpumask(bool isolcpus_updated)
 {
 	int ret;
 
@@ -1349,8 +1349,6 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
 	if (!isolcpus_updated)
 		return;
 
-	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
 	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
 	WARN_ON_ONCE(ret < 0);
 }
@@ -1473,7 +1471,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_housekeeping_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
 	cs->prs_err = 0;
 
@@ -1514,7 +1512,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	compute_effective_exclusive_cpumask(cs, NULL, NULL);
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_housekeeping_cpumask(isolcpus_updated);
 	cpuset_force_rebuild();
 
 	/*
@@ -1583,7 +1581,7 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	if (xcpus)
 		cpumask_copy(cs->exclusive_cpus, xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_housekeeping_cpumask(isolcpus_updated);
 	if (adding || deleting)
 		cpuset_force_rebuild();
 
@@ -1947,7 +1945,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		WARN_ON_ONCE(parent->nr_subparts < 0);
 	}
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_housekeeping_cpumask(isolcpus_updated);
 
 	if ((old_prs != new_prs) && (cmd == partcmd_update))
 		update_partition_exclusive_flag(cs, new_prs);
@@ -2972,7 +2970,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	else if (isolcpus_updated)
 		isolated_cpus_update(old_prs, new_prs, cs->effective_xcpus);
 	spin_unlock_irq(&callback_lock);
-	update_unbound_workqueue_cpumask(isolcpus_updated);
+	update_housekeeping_cpumask(isolcpus_updated);
 
 	/* Force update if switching back to member & update effective_xcpus */
 	update_cpumasks_hier(cs, &tmpmask, !new_prs);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 0119685796be..e4e4fcd4cb2c 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -116,6 +116,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 int housekeeping_update(struct cpumask *mask, enum hk_type type)
 {
 	struct cpumask *trial, *old = NULL;
+	int err;
 
 	if (type != HK_TYPE_DOMAIN)
 		return -ENOTSUPP;
@@ -142,10 +143,11 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
+	err = workqueue_unbound_exclude_cpumask(housekeeping_cpumask(type));
 
 	kfree(old);
 
-	return 0;
+	return err;
 }
 
 void __init housekeeping_init(void)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 97f37b5bae66..e55fcf980c5d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6948,7 +6948,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
  * This function can be called from cpuset code to provide a set of isolated
  * CPUs that should be excluded from wq_unbound_cpumask.
  */
-int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
+int workqueue_unbound_exclude_cpumask(const struct cpumask *exclude_cpumask)
 {
 	cpumask_var_t cpumask;
 	int ret = 0;
-- 
2.48.1


