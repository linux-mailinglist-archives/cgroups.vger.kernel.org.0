Return-Path: <cgroups+bounces-12667-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF05CDC977
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 15:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99CD83044E91
	for <lists+cgroups@lfdr.de>; Wed, 24 Dec 2025 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3074233D6FC;
	Wed, 24 Dec 2025 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWBEXiFX"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C4C23C503;
	Wed, 24 Dec 2025 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766584053; cv=none; b=OcFs/TwKRh66cEndRaOxF1j/r8FPsrv/XS0fqNSzgUHjzkuuldc1NFVtFn9GBWiN/9SLHi1RnufI/W6QubgbMn2YSb9y1cylZI0Q7sW0KkNTSz161qR4+EaYk0RJk9gJRTfAkt/7Azjrow7n07Bw77W1jJwTFts5uTv3SUS5rmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766584053; c=relaxed/simple;
	bh=bEcbX7KWei/F/tdd1dqLNOJQoJehpFK4YPlUxFH95Ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TU2rs41rEisyvxqt9XAoH0lx2O6USstphQgQpen5051nuAlBLZl1Gq/eAm9UqZohIYKcxO3l+X8WSJoyY3VdAnPJjrwqypVOEhKATnH+D9LSfqnsEGW6zRcmydkIf1+HRvyTgEQnX5VtFJsUtTucCC+sqQD9FwUQVTIZUnk2QFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rWBEXiFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 132F5C19421;
	Wed, 24 Dec 2025 13:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766584052;
	bh=bEcbX7KWei/F/tdd1dqLNOJQoJehpFK4YPlUxFH95Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rWBEXiFXFwOZeezwfBkkOxMAGA/N78W09k3qvuwX4GdIGU32CYAGAwxja/awX8kkV
	 J3lGm3qkjnrv1DU4n/D3+knMeI8Y5sCMVs98kJIYMO9pHkuOD4PJxshTq7F7pfChdh
	 i6PLAj9PGKTA/Zbb+TvC70uO+moyUZEEsRNxfxmYtaBRk0qczG15CJ/HqGyXIucU3w
	 ZHCxrfSt5EWat662ghZxFaCSH0yQ3CKEivUeErRRJgr5sCzrmz5BnpwgNdwOt/I8Zw
	 zCM2WZWmJBoBBojR9P4JLjLFjxus1c6N0lyGSId+Y0oAPl7VMqgeQTYyVkQ8EjgU12
	 My41ZMotzUzjQ==
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
Subject: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Date: Wed, 24 Dec 2025 14:45:01 +0100
Message-ID: <20251224134520.33231-15-frederic@kernel.org>
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
HK_TYPE_DOMAIN housekeeping cpumask.

Subsystems can rely on RCU to synchronize against concurrent changes.

The propagation mentioned in 3) will be handled in further patches.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched/isolation.h |  7 +++
 kernel/cgroup/cpuset.c          |  3 ++
 kernel/sched/isolation.c        | 76 ++++++++++++++++++++++++++++++---
 kernel/sched/sched.h            |  1 +
 4 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 109a2149e21a..6842a1ba4d13 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -9,6 +9,11 @@
 enum hk_type {
 	/* Revert of boot-time isolcpus= argument */
 	HK_TYPE_DOMAIN_BOOT,
+	/*
+	 * Same as HK_TYPE_DOMAIN_BOOT but also includes the
+	 * revert of cpuset isolated partitions. As such it
+	 * is always a subset of HK_TYPE_DOMAIN_BOOT.
+	 */
 	HK_TYPE_DOMAIN,
 	/* Revert of boot-time isolcpus=managed_irq argument */
 	HK_TYPE_MANAGED_IRQ,
@@ -35,6 +40,7 @@ extern const struct cpumask *housekeeping_cpumask(enum hk_type type);
 extern bool housekeeping_enabled(enum hk_type type);
 extern void housekeeping_affine(struct task_struct *t, enum hk_type type);
 extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
+extern int housekeeping_update(struct cpumask *isol_mask, enum hk_type type);
 extern void __init housekeeping_init(void);
 
 #else
@@ -62,6 +68,7 @@ static inline bool housekeeping_test_cpu(int cpu, enum hk_type type)
 	return true;
 }
 
+static inline int housekeeping_update(struct cpumask *isol_mask, enum hk_type type) { return 0; }
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 5e2e3514c22e..e13e32491ebf 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1490,6 +1490,9 @@ static void update_isolation_cpumasks(void)
 	ret = tmigr_isolated_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
 
+	ret = housekeeping_update(isolated_cpus, HK_TYPE_DOMAIN);
+	WARN_ON_ONCE(ret < 0);
+
 	isolated_cpus_updating = false;
 }
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 83be49ec2b06..a124f1119f2e 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -29,18 +29,48 @@ static struct housekeeping housekeeping;
 
 bool housekeeping_enabled(enum hk_type type)
 {
-	return !!(housekeeping.flags & BIT(type));
+	return !!(READ_ONCE(housekeeping.flags) & BIT(type));
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
+static bool housekeeping_dereference_check(enum hk_type type)
+{
+	if (IS_ENABLED(CONFIG_LOCKDEP) && type == HK_TYPE_DOMAIN) {
+		/* Cpuset isn't even writable yet? */
+		if (system_state <= SYSTEM_SCHEDULING)
+			return true;
+
+		/* CPU hotplug write locked, so cpuset partition can't be overwritten */
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
+			return true;
+
+		/* Cpuset lock held, partitions not writable */
+		if (IS_ENABLED(CONFIG_CPUSETS) && lockdep_is_cpuset_held())
+			return true;
+
+		return false;
+	}
+
+	return true;
+}
+
+static inline struct cpumask *housekeeping_cpumask_dereference(enum hk_type type)
+{
+	return rcu_dereference_all_check(housekeeping.cpumasks[type],
+					 housekeeping_dereference_check(type));
+}
+
 const struct cpumask *housekeeping_cpumask(enum hk_type type)
 {
+	const struct cpumask *mask = NULL;
+
 	if (static_branch_unlikely(&housekeeping_overridden)) {
-		if (housekeeping.flags & BIT(type)) {
-			return rcu_dereference_check(housekeeping.cpumasks[type], 1);
-		}
+		if (READ_ONCE(housekeeping.flags) & BIT(type))
+			mask = housekeeping_cpumask_dereference(type);
 	}
-	return cpu_possible_mask;
+	if (!mask)
+		mask = cpu_possible_mask;
+	return mask;
 }
 EXPORT_SYMBOL_GPL(housekeeping_cpumask);
 
@@ -80,12 +110,46 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
 
 bool housekeeping_test_cpu(int cpu, enum hk_type type)
 {
-	if (static_branch_unlikely(&housekeeping_overridden) && housekeeping.flags & BIT(type))
+	if (static_branch_unlikely(&housekeeping_overridden) &&
+	    READ_ONCE(housekeeping.flags) & BIT(type))
 		return cpumask_test_cpu(cpu, housekeeping_cpumask(type));
 	return true;
 }
 EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
 
+int housekeeping_update(struct cpumask *isol_mask, enum hk_type type)
+{
+	struct cpumask *trial, *old = NULL;
+
+	if (type != HK_TYPE_DOMAIN)
+		return -ENOTSUPP;
+
+	trial = kmalloc(cpumask_size(), GFP_KERNEL);
+	if (!trial)
+		return -ENOMEM;
+
+	cpumask_andnot(trial, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT), isol_mask);
+	if (!cpumask_intersects(trial, cpu_online_mask)) {
+		kfree(trial);
+		return -EINVAL;
+	}
+
+	if (!housekeeping.flags)
+		static_branch_enable(&housekeeping_overridden);
+
+	if (housekeeping.flags & BIT(type))
+		old = housekeeping_cpumask_dereference(type);
+	else
+		WRITE_ONCE(housekeeping.flags, housekeeping.flags | BIT(type));
+	rcu_assign_pointer(housekeeping.cpumasks[type], trial);
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
index 475bdab3b8db..653e898a996a 100644
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
2.51.1


