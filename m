Return-Path: <cgroups+bounces-11628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13B8C37EA0
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 506141A23A08
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D4357729;
	Wed,  5 Nov 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rA4n9pw2"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565134CFD7;
	Wed,  5 Nov 2025 21:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376785; cv=none; b=CKTucnQ2SwL9X/ydI5nnpBgtVMzIss04WwG7f3SJ24GbhXPe/9hYrSF8s0OWr14GLUfVtgXEOpbmXFgDats8ZJTVrMUXW/GZlFcHDT3HgTXA41RAfzWvbef/JCZJfRYGVj4ch1zgxY4ibpRjCphAxvBpJi1R8aEOPMZxwSAXp+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376785; c=relaxed/simple;
	bh=1PXFAoSc5EaQ1yzCGftJTnGf1OCO/kq+1cRjiff+B0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edAW0JZIif02YosnmUkKsDks2FAJbzbKPezYBF/Z8BbRQrcTvlwPeDoobV7Rd9A5auHx7afqtfSPoc3uiG1XXX7Jjio+gTJsngLl+XYq8gyhx1q6M7M/gfWfBR3qLGDb2XGaKq6MNKGNa7DF5MdwSAFJPcCjsmD2KYSi2I7M/C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rA4n9pw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A479C116D0;
	Wed,  5 Nov 2025 21:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376784;
	bh=1PXFAoSc5EaQ1yzCGftJTnGf1OCO/kq+1cRjiff+B0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rA4n9pw2FOv+9hxUmMxi6GGt4SJ3mYCQWb06W9IiZHm52r67O+JOAmfjrIMDYzNSR
	 7hhMjSR+V0LaaEHgGb4EMGkqcbc7bh4k157CK1CGKnWGgH60SQaTfVEcf14bx2R1a7
	 W6AmRByimN4vv61qfnqKvrVtt84nUxX+ewRIrIERljtsHj4WPpzYQzQ3ro10IQ6UaJ
	 i2NEpKm2VX4EY/sin6yFQF7A7VLkFpIueTpaU6/WWugVABg+bzYoul5wol8HkxJPqI
	 0HmF/ZV2mQzCZGdW4X6JtSqcQOvv8qs5gwBPd8rNVz7Y8l7f4Pvcd6F+y4NHWaQkyb
	 mwjWG2dqzoj+Q==
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
Subject: [PATCH 18/31] cpuset: Remove cpuset_cpu_is_isolated()
Date: Wed,  5 Nov 2025 22:03:34 +0100
Message-ID: <20251105210348.35256-19-frederic@kernel.org>
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

The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
housekeeping cpumask. There is no usecase left interested in just
checking what is isolated by cpuset and not by the isolcpus= kernel
boot parameter.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuset.h          |  6 ------
 include/linux/sched/isolation.h |  4 +---
 kernel/cgroup/cpuset.c          | 12 ------------
 3 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 051d36fec578..a10775a4f702 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -78,7 +78,6 @@ extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
-extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -208,11 +207,6 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
 	return false;
 }
 
-static inline bool cpuset_cpu_is_isolated(int cpu)
-{
-	return false;
-}
-
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 {
 	return node_possible_map;
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index aaf2a672f8dc..a127629adb32 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -2,7 +2,6 @@
 #define _LINUX_SCHED_ISOLATION_H
 
 #include <linux/cpumask.h>
-#include <linux/cpuset.h>
 #include <linux/init.h>
 #include <linux/tick.h>
 
@@ -84,8 +83,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 static inline bool cpu_is_isolated(int cpu)
 {
 	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
-	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
-	       cpuset_cpu_is_isolated(cpu);
+	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
 }
 
 #endif /* _LINUX_SCHED_ISOLATION_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ea102e4695a5..e19d3375a4ec 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -29,7 +29,6 @@
 #include <linux/mempolicy.h>
 #include <linux/mm.h>
 #include <linux/memory.h>
-#include <linux/export.h>
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/deadline.h>
@@ -1405,17 +1404,6 @@ static void update_housekeeping_cpumask(bool isolcpus_updated)
 	WARN_ON_ONCE(ret < 0);
 }
 
-/**
- * cpuset_cpu_is_isolated - Check if the given CPU is isolated
- * @cpu: the CPU number to be checked
- * Return: true if CPU is used in an isolated partition, false otherwise
- */
-bool cpuset_cpu_is_isolated(int cpu)
-{
-	return cpumask_test_cpu(cpu, isolated_cpus);
-}
-EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
-
 /**
  * rm_siblings_excl_cpus - Remove exclusive CPUs that are used by sibling cpusets
  * @parent: Parent cpuset containing all siblings
-- 
2.51.0


