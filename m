Return-Path: <cgroups+bounces-8613-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE0AE1E8B
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 17:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65A277B2828
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F28B2EBDEE;
	Fri, 20 Jun 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy0N0utz"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEEA2D29C9;
	Fri, 20 Jun 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433035; cv=none; b=uh8TFqr+xU2oAiKlIW+/jqRRgedH+tp4rVdcRlRbxfnaWCcXKaifdvAJumMmWRgrwMnh7vKbj4i27dZJw4d7tXPwflZF1RsOiHQmGuESZYqASpKOWX4EIjgby3M2iBRY0A3BboH7o7XsUGUmsSsmbDhKzsQGK4YmMxYuXSmPuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433035; c=relaxed/simple;
	bh=hhGPWkGQrxw1S/pBsDoaibkt3XaUAIfOsG7Kc7rzLcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OboRD8UEf0RyFytCQw0mi2+NiEQ1UMVwb0CdtYycROWjnaUrLWIU0H4DxGAyVTkJKamBrskh3nTVB3L7rezNHhMb61agWlRyen7a9+tuJPaGMCgQ1ZpyXjKQ2+OZlAfo1NPtLFS/14q7vyveXWA9byisvSrz07GpvUQJbCe+CnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy0N0utz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9743AC4CEE3;
	Fri, 20 Jun 2025 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433035;
	bh=hhGPWkGQrxw1S/pBsDoaibkt3XaUAIfOsG7Kc7rzLcQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yy0N0utzuGBhQFbw9ReKQeM1tox8v+dreF3+kezh3/WytRnYXvjUQf33trg23knpb
	 0JPj6403jaHtjZC/E1ILEw4vQTNFpbY9CeW9K4P+EJhsAWKfKH+zoedjVVs6aYF6FU
	 M+5JKByw/yoOLiBlPT3BDooZAasroww/8N8JdNmdo/fHmW5jAUCANU1jwujYVeKIb/
	 5qGTuLABW2OFJ6OthAvIaFR/paPH3eIRUCim0/gGsZaAUoOvnSylaG8JSpIdX1O/s3
	 hXT9H4mqXSLQHBNMhgKz+IE9FHEk2RhJc1IyBSvDiRjNeXWsvrSPyw0BP6hthwwC8+
	 HZFXVhnz/vYSg==
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
Subject: [PATCH 15/27] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Date: Fri, 20 Jun 2025 17:22:56 +0200
Message-ID: <20250620152308.27492-16-frederic@kernel.org>
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

Until now, HK_TYPE_DOMAIN used to only include boot defined isolated
CPUs passed through isolcpus= boot option. Users interested in also
knowing the runtime defined isolated CPUs through cpuset must use
different APIs: cpuset_cpu_is_isolated(), cpu_is_isolated(), etc...

There are many drawbacks to that approach:

1) Most interested subsystems want to know about all isolated CPUs, not
  just those defined on boot time.

2) cpuset_cpu_is_isolated() / cpu_is_isolated() are not synchronized with
  concurrent cpuset changes.

3) Further cpuset modifications are not propagated to subsystems

Solve 1) and 2) and centralize all isolated CPUs within the
HK_TYPE_DOMAIN housekeeping cpumask under the housekeeping lock.

Subsystems can rely on the housekeeping lock or RCU to synchronize
against concurrent changes.

The propagation mentioned in 3) will be handled in further patches.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h |  5 ++-
 kernel/cgroup/cpuset.c          |  2 +
 kernel/sched/isolation.c        | 71 ++++++++++++++++++++++++++++++---
 kernel/sched/sched.h            |  1 +
 4 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 731506d312d2..f1b309f18511 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -36,7 +36,7 @@ extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 {
-	if (housekeeping_flags & BIT(type))
+	if (READ_ONCE(housekeeping_flags) & BIT(type))
 		return housekeeping_test_cpu(cpu, type);
 	else
 		return true;
@@ -45,6 +45,8 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 extern void housekeeping_lock(void);
 extern void housekeeping_unlock(void);
 
+extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
+
 extern void __init housekeeping_init(void);
 
 #else
@@ -79,6 +81,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 
 static inline void housekeeping_lock(void) { }
 static inline void housekeeping_unlock(void) { }
+static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 8221b6a7da46..5f169a56f06c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1351,6 +1351,8 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
 
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
+	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
+	WARN_ON_ONCE(ret < 0);
 }
 
 /**
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 75505668dcb9..7814d60be87e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -23,7 +23,7 @@ DEFINE_STATIC_PERCPU_RWSEM(housekeeping_pcpu_lock);
 
 bool housekeeping_enabled(enum hk_type type)
 {
-	return !!(housekeeping_flags & BIT(type));
+	return !!(READ_ONCE(housekeeping_flags) & BIT(type));
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
@@ -37,12 +37,39 @@ void housekeeping_unlock(void)
 	percpu_up_read(&housekeeping_pcpu_lock);
 }
 
+static bool housekeeping_dereference_check(enum hk_type type)
+{
+	if (type == HK_TYPE_DOMAIN) {
+		if (system_state == SYSTEM_BOOTING)
+			return true;
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
+			return true;
+		if (percpu_rwsem_is_held(&housekeeping_pcpu_lock))
+			return true;
+		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
+			return true;
+
+		return false;
+	}
+
+	return true;
+}
+
+static inline struct cpumask *__housekeeping_cpumask(enum hk_type type)
+{
+	return rcu_dereference_check(housekeeping_cpumasks[type],
+				     housekeeping_dereference_check(type));
+}
+
 const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
-	if (housekeeping_flags & BIT(type)) {
-		return rcu_dereference_check(housekeeping_cpumasks[type], 1);
-	}
-	return cpu_possible_mask;
+	const struct cpumask *mask = NULL;
+
+	if (READ_ONCE(housekeeping_flags) & BIT(type))
+		mask = __housekeeping_cpumask(type);
+	if (!mask)
+		mask = cpu_possible_mask;
+	return mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
 
@@ -80,12 +107,44 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
 
 bool housekeeping_test_cpu(int cpu, enum hk_type type)
 {
-	if (housekeeping_flags & BIT(type))
+	if (READ_ONCE(housekeeping_flags) & BIT(type))
 		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+int housekeeping_update(struct cpumask *mask, enum hk_type type)
+{
+	struct cpumask *trial, *old = NULL;
+
+	if (type != HK_TYPE_DOMAIN)
+		return -ENOTSUPP;
+
+	trial = kmalloc(sizeof(*trial), GFP_KERNEL);
+	if (!trial)
+		return -ENOMEM;
+
+	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), mask);
+	if (!cpumask_intersects(trial, cpu_online_mask)) {
+		kfree(trial);
+		return -EINVAL;
+	}
+
+	percpu_down_write(&housekeeping_pcpu_lock);
+	if (housekeeping_flags & BIT(type))
+		old = __housekeeping_cpumask(type);
+	else
+		WRITE_ONCE(housekeeping_flags, housekeeping_flags | BIT(type));
+	rcu_assign_pointer(housekeeping_cpumasks[type], trial);
+	percpu_up_write(&housekeeping_pcpu_lock);
+
+	synchronize_rcu();
+
+	kfree(old);
+
+	return 0;
+}
+
 void __init housekeeping_init(void)
 {
 	enum hk_type type;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 407e7f5ad929..04094567cad4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -30,6 +30,7 @@
 #include <linux/context_tracking.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask_api.h>
+#include <linux/cpuset.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/fs_api.h>
-- 
2.48.1


