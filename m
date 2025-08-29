Return-Path: <cgroups+bounces-9482-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7628B3BFEC
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 17:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3A511889595
	for <lists+cgroups@lfdr.de>; Fri, 29 Aug 2025 15:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21CF338F37;
	Fri, 29 Aug 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGTUIbf4"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7713277B4;
	Fri, 29 Aug 2025 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482540; cv=none; b=cxwzyhB0h5Omd7FVMcL6+07AzqX5shrD456UxZZ2/SJURmpmKb9eNoGDCGhcwgmqwThAt2W9LyDHOJgms4LRV9oVkRfTFAcjsL3hIemK8t8A2P6KAX7I0fZTw/AbXJxLWRfruEX7RFHFyFJbcUYFidFf9/fXaz0dySJSazqOrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482540; c=relaxed/simple;
	bh=g05kmaCWh9kz1yQbOgKAwo02zbhbBJem0FHbC3D9l4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQUvZqwSSnd9c1XDiyGRKFag9m8H3NXFAiYqQxZyXFuOTJgjSaE76aA6d3N7DCQmfoOTRdo39sJnkHrS6pPMgj4zVAFnY8+BIHChaXR7Wi+clqSsJcU6qSl4Tb3npO+phdhNxzkat5gC6j4hL1enl2EGWj5szzNIwVYqPFToKKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGTUIbf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C553C4CEF6;
	Fri, 29 Aug 2025 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482539;
	bh=g05kmaCWh9kz1yQbOgKAwo02zbhbBJem0FHbC3D9l4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGTUIbf4zz1cc1V5OW0z+uuFGmmh71QLrS0tzI72BsW6ksimZ6s8fGz4XRCyjZVHO
	 Ud9N+Ls6gp6mfjeQ5d2NXR9Rv+DO2EbERvrRVJ/O44hHoUm2x8XZ9ECWeN39YhbH/p
	 3gXeWAqmogFmZ52hpwv0j0AfOsXgIimnCQYKGDr5FP8YPHUcHWiTjFJEcOMY6iombU
	 b+nsu7vYxOwRR2w3yzk4BNwfzFLxvIn2dbMZWQojn3JNfo3yhF6NMeNhOZFTMIt+8L
	 rYGNTP/lC8zZ2tkJDnludtyxiDmn2VZHO8afTThalTdifySD47ISQ6usdbtUfPwji1
	 Xdqnul7SAbJnA==
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
Subject: [PATCH 14/33] cpuset: Update HK_TYPE_DOMAIN cpumask from cpuset
Date: Fri, 29 Aug 2025 17:47:55 +0200
Message-ID: <20250829154814.47015-15-frederic@kernel.org>
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
 include/linux/sched/isolation.h |  4 +-
 kernel/cgroup/cpuset.c          |  2 +
 kernel/sched/isolation.c        | 65 ++++++++++++++++++++++++++++++---
 kernel/sched/sched.h            |  1 +
 4 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 9262378760b1..199d0fc4646f 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -36,12 +36,13 @@ extern bool housekeeping_test_cpu(int cpu, enum hk_type type);
 
 static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 {
-	if (housekeeping_flags & BIT(type))
+	if (READ_ONCE(housekeeping_flags) & BIT(type))
 		return housekeeping_test_cpu(cpu, type);
 	else
 		return true;
 }
 
+extern int housekeeping_update(struct cpumask *mask, enum hk_type type);
 extern void __init housekeeping_init(void);
 
 #else
@@ -74,6 +75,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 	return true;
 }
 
+static inline int housekeeping_update(struct cpumask *mask, enum hk_type type) { return 0; }
 static inline void housekeeping_init(void) { }
 #endif /* CONFIG_CPU_ISOLATION */
 
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2d2fc74bc00c..4f2bc68332a7 100644
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
index 5ddb8dc5ca91..48f3b6b20604 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -23,16 +23,39 @@ EXPORT_SYMBOL_GPL(housekeeping_flags);
 
 bool housekeeping_enabled(enum hk_type type)
 {
-	return !!(housekeeping_flags & BIT(type));
+	return !!(READ_ONCE(housekeeping_flags) & BIT(type));
 }
 EXPORT_SYMBOL_GPL(housekeeping_enabled);
 
+static bool housekeeping_dereference_check(enum hk_type type)
+{
+	if (type == HK_TYPE_DOMAIN) {
+		if (IS_ENABLED(CONFIG_HOTPLUG_CPU) && lockdep_is_cpus_write_held())
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
 
@@ -70,12 +93,42 @@ EXPORT_SYMBOL_GPL(housekeeping_affine);
 
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
+	if (housekeeping_flags & BIT(type))
+		old = __housekeeping_cpumask(type);
+	else
+		WRITE_ONCE(housekeeping_flags, housekeeping_flags | BIT(type));
+	rcu_assign_pointer(housekeeping_cpumasks[type], trial);
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
index 0b1a233dcabf..d3512138027b 100644
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
2.51.0


