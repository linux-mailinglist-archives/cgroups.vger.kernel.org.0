Return-Path: <cgroups+bounces-10685-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E61FBD629E
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 22:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D44D4F7602
	for <lists+cgroups@lfdr.de>; Mon, 13 Oct 2025 20:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD730E853;
	Mon, 13 Oct 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y98xRz6h"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F747309DD2;
	Mon, 13 Oct 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387659; cv=none; b=B2zLN/qJdHvn5S9dkbT9qT+EhwlqhYeOFl3ypowywIlYqiyVat7aFOrgkfQYMvGqN7JVSeuCP6H7r77v/IkG0dvCkkubuStAZ/T0zmDldsIarDPv3XpIPhEBDuWV8DesrtgGij0i6eQDDqFA7NC7k7yJT2KzaYpy0GexXeqUjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387659; c=relaxed/simple;
	bh=FzweRnNZ3rpHmeDAR8nh52t/LTbWmLRPuC53BTe2K5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jScpBjUBvdR7USwZ3/DANUWioH/F+X2aUngsxncYKP/jWfAYk/Us4X4rzMrBAPgvbvPgnin09cUoLRT14hOpwB90Sny/b9Ws3ciDlSAed2TSc2xKR++Z0b6RuUPeRTxYGSMtsGO8RWP8ww86BVZJ/6mSmc9pHY2tTCLRx2EZhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y98xRz6h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D6CC4CEFE;
	Mon, 13 Oct 2025 20:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760387658;
	bh=FzweRnNZ3rpHmeDAR8nh52t/LTbWmLRPuC53BTe2K5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y98xRz6h268U7IXnYXzrzxvIyBXE9M4gvO1uYQ6zbCfgYvyI80M/P8QWh6KpXuZxX
	 dZbiZacrGK46gnAEvGqrVzaLZlxepcsYgdkIx7cY2Pu4MBgeZwLSq9x+83EuxwC2/S
	 WJLOqNPuUssMQwhkmAMZXyRoi9cKCyXdWuWW1rn1T3oONvX2Q8FKtyUaO35aJbeFWu
	 lN+cyfaTya9Kp6gC5ACu2fbOhJgP7PRASkBJp42jx81uo9wc1Uf9c41y2orTHSOWRO
	 SdkYXhyfRCXaIIOQOTkMg9CJGX7N0nz9xD3V1OoA68tqrAMKR9AdVO63kyriR9hDB7
	 cMHS0pLaC7LxA==
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
Subject: [PATCH 18/33] cpuset: Remove cpuset_cpu_is_isolated()
Date: Mon, 13 Oct 2025 22:31:31 +0200
Message-ID: <20251013203146.10162-19-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013203146.10162-1-frederic@kernel.org>
References: <20251013203146.10162-1-frederic@kernel.org>
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
index 94d5c835121b..0f50c152cf68 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -76,8 +76,7 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
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


