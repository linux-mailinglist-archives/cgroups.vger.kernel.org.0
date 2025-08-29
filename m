Return-Path: <cgroups+bounces-9484-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD040B3BFEA
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD273A9A11
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 15:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D4322DA9;
	Fri, 29 Aug 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpArFLeU"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D232BF3F;
	Fri, 29 Aug 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482550; cv=none; b=VD9lZz6Pz9iqDNEQkZs8YlYxTsAHpgcV5iWUB7SEKJPcdXSYyWtItT+qZaSKbk9BSPDoC/O2VpBghFeT3H6SXE4VbyqQLVmwpacvzWW4r29/a+BwnR06zvfgkc/tsnG0FbY/pWR0Z//R8ATtrTleYjkv+Iub4CZJr1N4w3SCSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482550; c=relaxed/simple;
	bh=0MmDFM8cuV7a81MntpOUNOOq2tPG55qK8I3sBVoNvr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gDG4Y4FJKNm1U2xB4rfWVMO2zE1Ikzl+uAXOhPNOzzh54cny0z5J/QpLJuwxUAolRnssGfV1O1NGQn6pCaEoNjA+B+hG3AD3LC+YnNTCT6qrWZf4/SWp8yWIp5QMAl+9VnKYSTnI2xoQD3+uudr7yX2i9MPIvflW0QANKxC4h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpArFLeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05701C4CEF6;
	Fri, 29 Aug 2025 15:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482549;
	bh=0MmDFM8cuV7a81MntpOUNOOq2tPG55qK8I3sBVoNvr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gpArFLeUPdjT2XzgUdMI+hLmDi2Bvuj3aVpBZLqtbJnR5s5IS5cT7De5UKRfxtvh4
	 tIn/wBTFAdsw8xjSxw4xK0dNjUo2Y5bQFuKhfaF+TS7999GGLV4j5z3TpFooKtOlVb
	 of63g+avpmpqFMYEDSDyCcl/avQjoyMSPH0HyzpHRqbXrSHYCr12CIqbMT/KhrcemO
	 41EJXlhKpwagSWE+hR6a51gloSKkHFmgllksobGZLm7ueTmouH+GNWHtPkIWudncWT
	 9mnQJ+sqzwDHpV35iOLC3BRO+7c98+z+plz75CbiTEjD/VybBSqIWjD0R1FMQsh1ae
	 LpRKupQtrVXeA==
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
Subject: [PATCH 17/33] cpuset: Propagate cpuset isolation update to workqueue through housekeeping
Date: Fri, 29 Aug 2025 17:47:58 +0200
Message-ID: <20250829154814.47015-18-frederic@kernel.org>
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
index 45d5dd470ff6..19fee865ce2a 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -588,7 +588,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
-extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
+extern int workqueue_unbound_exclude_cpumask(const struct cpumask *cpumask);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/init/Kconfig b/init/Kconfig
index 836320251219..af05cf89db12 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1230,6 +1230,7 @@ config CPUSETS
 	bool "Cpuset controller"
 	depends on SMP
 	select UNION_FIND
+	select CPU_ISOLATION
 	help
 	  This option will let you create and manage CPUSETs which
 	  allow dynamically partitioning a system into sets of CPUs and
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 4f2bc68332a7..eb8d01d23af6 100644
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
index 86ce39aa1e9f..5baf1621a56e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -102,6 +102,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 int housekeeping_update(struct cpumask *mask, enum hk_type type)
 {
 	struct cpumask *trial, *old = NULL;
+	int err;
 
 	if (type != HK_TYPE_DOMAIN)
 		return -ENOTSUPP;
@@ -126,10 +127,11 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
+	err = workqueue_unbound_exclude_cpumask(housekeeping_cpumask(type));
 
 	kfree(old);
 
-	return 0;
+	return err;
 }
 
 void __init housekeeping_init(void)
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c3..63dcc1d8b317 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6921,7 +6921,7 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
  * This function can be called from cpuset code to provide a set of isolated
  * CPUs that should be excluded from wq_unbound_cpumask.
  */
-int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
+int workqueue_unbound_exclude_cpumask(const struct cpumask *exclude_cpumask)
 {
 	cpumask_var_t cpumask;
 	int ret = 0;
-- 
2.51.0


