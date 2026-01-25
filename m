Return-Path: <cgroups+bounces-13425-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBIrCsuedmmOTAEAu9opvQ
	(envelope-from <cgroups+bounces-13425-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:52:59 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B886382E4D
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 23:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09299306040C
	for <lists+cgroups@lfdr.de>; Sun, 25 Jan 2026 22:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5823101D2;
	Sun, 25 Jan 2026 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXVJDGvG"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7830F53F;
	Sun, 25 Jan 2026 22:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769381298; cv=none; b=mO/k4uwU3aqcZyaZgWCMgqOcYM3mnWLqOllNk0fwDSEQDVvCXcT6/RZfygf17Vyqy9/zB9jVjmxQInzXUT6oOFGZH1lUnWC7OeHwr3hY9mPwUnv1kSRx7QcilmvwFaFElKK7Givo2DgQV9F042hQgVY2nGFpUzAOlYcyBAiJ76g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769381298; c=relaxed/simple;
	bh=PDoIYHuuiQUu4y1J8hgAkjDfFBft4fHDXLhrlxOrw90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIIJPN6ZzztEuZ9eQdIwdO5VHFwvorEhTEiQeLmmCxE5PEMYC2CE6GQrgZ5DqCbqpGekJIgqBwj8pJMPSJ30ZsV2vSFAsLVs4d2cLwzsK2bAtOWi622gywZqjf9x7NclyNSY4bv4Z7f2YgM0Vkf5FKVxIwideHs/wJIWbn8x+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FXVJDGvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E931C16AAE;
	Sun, 25 Jan 2026 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769381298;
	bh=PDoIYHuuiQUu4y1J8hgAkjDfFBft4fHDXLhrlxOrw90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FXVJDGvGd90ljUIRHA3Gq+xSNAPYbf5Of7csvzmr6nei4zcJ7mhopJ1z1alkU6Dfp
	 l0WYTDe1bqdAbAwqxkXWftB2h/QrmGaK47ERIpLMpl/XGWMaVeG01EE3V1cO3TJGhS
	 ycvJwK2yTD/h3Z7SN6aPzoayLR27DlQfuE/tsJutjBLeXZcEUkuJsyXWSUknHlc7ng
	 /RWRUd8FUCncSiL1IgasD696UCodzN9XukraV+QyWa2mKQaYlHjfSGb22+eWrZBBZs
	 piSO+onX1DUhkVV3zHKe6dKz2I61vJKBFw27FSgvAUZM0cDrmVaXHWYmGpF86sls9f
	 xf7nNq6/T22aQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Ridong <chenridong@huawei.com>,
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
Subject: [PATCH 18/33] cpuset: Propagate cpuset isolation update to workqueue through housekeeping
Date: Sun, 25 Jan 2026 23:45:25 +0100
Message-ID: <20260125224541.50226-19-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260125224541.50226-1-frederic@kernel.org>
References: <20260125224541.50226-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13425-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FREEMAIL_CC(0.00)[kernel.org,suse.com,linux-foundation.org,google.com,arm.com,huawei.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.dk,cmpxchg.org,gmail.com,linux.dev,infradead.org,linutronix.de,suse.cz,vger.kernel.org,lists.infradead.org,kvack.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[frederic@kernel.org,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B886382E4D
X-Rspamd-Action: no action

Until now, cpuset would propagate isolated partition changes to
workqueues so that unbound workers get properly reaffined.

Since housekeeping now centralizes, synchronize and propagates isolation
cpumask changes, perform the work from that subsystem for consolidation
and consistency purposes.

For simplification purpose, the target function is adapted to take the
new housekeeping mask instead of the isolated mask.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/workqueue.h |  2 +-
 init/Kconfig              |  1 +
 kernel/cgroup/cpuset.c    |  9 +++------
 kernel/sched/isolation.c  |  3 +++
 kernel/workqueue.c        | 17 ++++++++++-------
 5 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index dabc351cc127..a4749f56398f 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -588,7 +588,7 @@ struct workqueue_attrs *alloc_workqueue_attrs_noprof(void);
 void free_workqueue_attrs(struct workqueue_attrs *attrs);
 int apply_workqueue_attrs(struct workqueue_struct *wq,
 			  const struct workqueue_attrs *attrs);
-extern int workqueue_unbound_exclude_cpumask(cpumask_var_t cpumask);
+extern int workqueue_unbound_housekeeping_update(const struct cpumask *hk);
 
 extern bool queue_work_on(int cpu, struct workqueue_struct *wq,
 			struct work_struct *work);
diff --git a/init/Kconfig b/init/Kconfig
index fa79feb8fe57..518830fb812f 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1254,6 +1254,7 @@ config CPUSETS
 	bool "Cpuset controller"
 	depends on SMP
 	select UNION_FIND
+	select CPU_ISOLATION
 	help
 	  This option will let you create and manage CPUSETs which
 	  allow dynamically partitioning a system into sets of CPUs and
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index e146e1f34bf9..6309ec5d7b2a 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1482,15 +1482,12 @@ static void update_isolation_cpumasks(void)
 	if (!isolated_cpus_updating)
 		return;
 
-	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
-
-	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
-
 	ret = housekeeping_update(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
 
+	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
+	WARN_ON_ONCE(ret < 0);
+
 	isolated_cpus_updating = false;
 }
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 1e4c3154b0a4..5bcb6d760f20 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -121,6 +121,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 int housekeeping_update(struct cpumask *isol_mask)
 {
 	struct cpumask *trial, *old = NULL;
+	int err;
 
 	lockdep_assert_cpus_held();
 
@@ -148,6 +149,8 @@ int housekeeping_update(struct cpumask *isol_mask)
 	pci_probe_flush_workqueue();
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
+	err = workqueue_unbound_housekeeping_update(housekeeping_cpumask(HK_TYPE_DOMAIN));
+	WARN_ON_ONCE(err < 0);
 
 	kfree(old);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 253311af47c6..eb5660013222 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6959,13 +6959,16 @@ static int workqueue_apply_unbound_cpumask(const cpumask_var_t unbound_cpumask)
 }
 
 /**
- * workqueue_unbound_exclude_cpumask - Exclude given CPUs from unbound cpumask
- * @exclude_cpumask: the cpumask to be excluded from wq_unbound_cpumask
+ * workqueue_unbound_housekeeping_update - Propagate housekeeping cpumask update
+ * @hk: the new housekeeping cpumask
  *
- * This function can be called from cpuset code to provide a set of isolated
- * CPUs that should be excluded from wq_unbound_cpumask.
+ * Update the unbound workqueue cpumask on top of the new housekeeping cpumask such
+ * that the effective unbound affinity is the intersection of the new housekeeping
+ * with the requested affinity set via nohz_full=/isolcpus= or sysfs.
+ *
+ * Return: 0 on success and -errno on failure.
  */
-int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
+int workqueue_unbound_housekeeping_update(const struct cpumask *hk)
 {
 	cpumask_var_t cpumask;
 	int ret = 0;
@@ -6981,14 +6984,14 @@ int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
 	 * (HK_TYPE_WQ ∩ HK_TYPE_DOMAIN) house keeping mask and rewritten
 	 * by any subsequent write to workqueue/cpumask sysfs file.
 	 */
-	if (!cpumask_andnot(cpumask, wq_requested_unbound_cpumask, exclude_cpumask))
+	if (!cpumask_and(cpumask, wq_requested_unbound_cpumask, hk))
 		cpumask_copy(cpumask, wq_requested_unbound_cpumask);
 	if (!cpumask_equal(cpumask, wq_unbound_cpumask))
 		ret = workqueue_apply_unbound_cpumask(cpumask);
 
 	/* Save the current isolated cpumask & export it via sysfs */
 	if (!ret)
-		cpumask_copy(wq_isolated_cpumask, exclude_cpumask);
+		cpumask_andnot(wq_isolated_cpumask, cpu_possible_mask, hk);
 
 	mutex_unlock(&wq_pool_mutex);
 	free_cpumask_var(cpumask);
-- 
2.51.1


