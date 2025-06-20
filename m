Return-Path: <cgroups+bounces-8616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69454AE1EAF
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 17:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EC61C26803
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E0B2ED164;
	Fri, 20 Jun 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpWgXKar"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD02ED841;
	Fri, 20 Jun 2025 15:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433047; cv=none; b=ZMcyOgGA//8mRZ4bJ8FNRmihvHOMqJpnLhMaiU7KTNrgswbyprUi+tvEkdYmiBD+2pnSGSeEsO3ah+wZsi4k8/CHtqkSxFQQ4jMwdzqk1+4xSBVJHTWpW1EtxYm/k2KzwHDEk03SBg/mFcjIVZX5ha+fnZ+rwoyku08lqGoDs+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433047; c=relaxed/simple;
	bh=7DejguHPFkVxCftEAVKS/blsYBEuLHXPel4oIb+v3f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihIA8qfRb6b4y+xMfCRKk/UXTHOR+ID2DjXDlICxXBvwer/GFKvUFn5fJ4TeZXrzEzE1F5SGh07LDzttId7iZ07q4b8pH8p6zFmXCrkv/dMTZm5XnlRk12aoVLM2eHFWqf6MNVpfbyCbfnypwQcRaX0cJyYAyuekCcxAyw47h/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpWgXKar; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430BBC4CEF2;
	Fri, 20 Jun 2025 15:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433047;
	bh=7DejguHPFkVxCftEAVKS/blsYBEuLHXPel4oIb+v3f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kpWgXKarrRUtUnKUt5+ZVIZfbqScBpWkbAn+u9HqYb9Wr//Ar4DiV3rkVQ3OcHZBo
	 no7GUOdf7pDHa3xI9qj5A7+lmJ45X2oHgU0VuXmj4UUjdJgfBWlBboj+4PUWNqCXFs
	 mvrjp6H4OuxIJiMLABQCG9H1ZtVd78d0Y+wgZssVZ3iAczsS8DhfDeGAGPmI8Jkb2G
	 XsNMubQU+Ku7m3VdqZiTZwbMq0nHvdoBvCevozdf2o7Br58pxHMMaembQMIx/KwIsW
	 RonzrriigUG2cGDU6WrBRFfBr5q7z/ccCy4/0zmEkjMAmQtAvREDDrjAw8/HoW5qwl
	 qAIyEPSolef4Q==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org
Subject: [PATCH 19/27] cpuset: Remove cpuset_cpu_is_isolated()
Date: Fri, 20 Jun 2025 17:23:00 +0200
Message-ID: <20250620152308.27492-20-frederic@kernel.org>
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

The set of cpuset isolated CPUs is now included in HK_TYPE_DOMAIN
housekeeping cpumask. There is no usecase left interested in just
checking what is isolated by cpuset and not by the isolcpus= kernel
boot parameter.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/cpuset.h          |  6 ------
 include/linux/sched/isolation.h |  3 +--
 kernel/cgroup/cpuset.c          | 12 ------------
 3 files changed, 1 insertion(+), 20 deletions(-)

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
index f1b309f18511..9f039dfb5739 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -89,8 +89,7 @@ static inline void housekeeping_init(void) { }
 static inline bool cpu_is_isolated(int cpu)
 {
 	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
-	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
-	       cpuset_cpu_is_isolated(cpu);
+	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
 }
 
 DEFINE_LOCK_GUARD_0(housekeeping, housekeeping_lock(), housekeeping_unlock())
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 98b1ea0ad336..db80e72681ed 100644
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
@@ -1353,17 +1352,6 @@ static void update_housekeeping_cpumask(bool isolcpus_updated)
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
 /*
  * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
  * @cs: cpuset
-- 
2.48.1


