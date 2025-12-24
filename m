Return-Path: <cgroups+bounces-12671-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 360B9CDC720
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 15:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57CAF30B2660
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FB634DCDF;
	Wed, 24 Dec 2025 13:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pr5HuSZo"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D268734DCC2;
	Wed, 24 Dec 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584088; cv=none; b=Vs94r+fxUBcJ9yKmNQRhl/p3++qHWQP5ueCwvYhXZUZlE71XzaKNrVtFTDEQxuAjMIQAYAwpn0IQfa+NXaHbvsI7uB69M36xYU2enMr+PWcZefYuVEck07k2FlWdQ97AO6vp1cOlTpByYo1UlQfZUYoHePhzilzC0gZHm1ONkzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584088; c=relaxed/simple;
	bh=jRCoFlzyfuayI8vSy1m9CD6aytBJoPvIXpyfG/mhfAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2eMKlBU+xjaj9jHmoezgnbt2lDJfO4ww3B9k04JDJl5ByH3vVYXHUHACWkYE3iiKfgnDObItDbMojki7r/4OZxe+ZSXBEW/baaj9rK5+yeQwQLLo9kztRth9ZH/Bmyg4IJdGvoQt2gvWeJAgZjfTgYI+42roTYCTw7xC2tvXEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pr5HuSZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AE3C116D0;
	Wed, 24 Dec 2025 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766584086;
	bh=jRCoFlzyfuayI8vSy1m9CD6aytBJoPvIXpyfG/mhfAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pr5HuSZoG4USHnZLUx/JbPQALrUvUK8KLMlPNf3RNPQYBvUJyXuFWCvoeAdFUmGpk
	 onTs1ggtsk7Hr7pWy0UvYqkDHALzxswmO/L9npavYTPzNxSRKxvVoJU50FP8347aId
	 TuQAnWWA/lyLwjkVP7Cb3KHK87AXK8XdzT+fw7RAK1ldpSZloT0yfgXXX6wu1PAxnH
	 jlplLKYFcQvjUXzRIrk3OXA7JoOF1BG0lv98MLCIU7CGkqU1mzB4cx276Zebo49kYx
	 7ZWe6czGA1zxX+kT3mZb37CAW9O4zg9Ny44j7Sd4YWc7N7PiERQoabpsgMpty4Uvs3
	 Ted2C+CATIKCg==
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
Date: Wed, 24 Dec 2025 14:45:05 +0100
Message-ID: <20251224134520.33231-19-frederic@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251224134520.33231-1-frederic@kernel.org>
References: <20251224134520.33231-1-frederic@kernel.org>
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

For simplification purpose, the target function is adapted to take the
new housekeeping mask instead of the isolated mask.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/workqueue.h |  2 +-
 init/Kconfig              |  1 +
 kernel/cgroup/cpuset.c    |  9 +++------
 kernel/sched/isolation.c  |  4 +++-
 kernel/workqueue.c        | 17 ++++++++++-------
 5 files changed, 18 insertions(+), 15 deletions(-)

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
index e13e32491ebf..a492d23dd622 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1484,15 +1484,12 @@ static void update_isolation_cpumasks(void)
 
 	lockdep_assert_cpus_held();
 
-	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
-
-	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
-	WARN_ON_ONCE(ret < 0);
-
 	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
 	WARN_ON_ONCE(ret < 0);
 
+	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
+	WARN_ON_ONCE(ret < 0);
+
 	isolated_cpus_updating = false;
 }
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7dbe037ea8df..d224bca299ed 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -121,6 +121,7 @@ EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
 {
 	struct cpumask *trial, *old = NULL;
+	int err;
 
 	if (type != HK_TYPE_DOMAIN)
 		return -ENOTSUPP;
@@ -149,10 +150,11 @@ int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
 	pci_probe_flush_workqueue();
 	mem_cgroup_flush_workqueue();
 	vmstat_flush_workqueue();
+	err = workqueue_unbound_housekeeping_update(housekeeping_cpumask(type));
 
 	kfree(old);
 
-	return 0;
+	return err;
 }
 
 void __init housekeeping_init(void)
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


