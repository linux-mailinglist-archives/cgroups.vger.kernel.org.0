Return-Path: <cgroups+bounces-830-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A04380619E
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 23:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEF81F21667
	for <lists+cgroups@lfdr.de>; Tue,  5 Dec 2023 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8846E2D5;
	Tue,  5 Dec 2023 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1IcpWgn"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC42181
	for <cgroups@vger.kernel.org>; Tue,  5 Dec 2023 14:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701814949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dd8Gk/6yuQhjnMyi4P3XBRZAXca0Ynw9je2fzWn9dCc=;
	b=e1IcpWgnU34S0oV5wir22Wzz0J2wZe+PfhgKO6B7hhl1VoprUeWzdIbTEhSxDvwc0Pz5ko
	7PKHC2V4oWB6hjBZUjbiLqy2rb0VjkuXZdqvpDx/9L+38hQRYTK0Ju1dpDFjLIfSVfSlTu
	F82+3xMMILFu7X7nlhOc2Mse/EBH9/o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-T3-aAeCqM9WgxgBvKthgAA-1; Tue, 05 Dec 2023 17:22:26 -0500
X-MC-Unique: T3-aAeCqM9WgxgBvKthgAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1651E102F081;
	Tue,  5 Dec 2023 22:22:24 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.88])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2EE182166B35;
	Tue,  5 Dec 2023 22:22:23 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mrunal Patel <mpatel@redhat.com>,
	Ryan Phillips <rphillips@redhat.com>,
	Brent Rowsell <browsell@redhat.com>,
	Peter Hunt <pehunt@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2] cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated() check
Date: Tue,  5 Dec 2023 17:21:14 -0500
Message-Id: <20231205222114.773446-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Currently, the cpu_is_isolated() function checks only the statically
isolated CPUs specified via the "isolcpus" and "nohz_full" kernel
command line options. This function is used by vmstat and memcg to
reduce interference with isolated CPUs by not doing stat flushing
or scheduling works on those CPUs.

Workloads running on isolated CPUs within isolated cpuset
partitions should receive the same treatment to reduce unnecessary
interference. This patch introduces a new cpuset_cpu_is_isolated()
function to be called by cpu_is_isolated() so that the set of dynamically
created cpuset isolated CPUs will be included in the check.

Assuming that testing a bit in a cpumask is atomic, no synchronization
primitive is currently used to synchronize access to the cpuset's
isolated_cpus mask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cpuset.h          |  6 ++++++
 include/linux/sched/isolation.h |  4 +++-
 kernel/cgroup/cpuset.c          | 11 +++++++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index d629094fac6e..875d12598bd2 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -77,6 +77,7 @@ extern void cpuset_lock(void);
 extern void cpuset_unlock(void);
 extern void cpuset_cpus_allowed(struct task_struct *p, struct cpumask *mask);
 extern bool cpuset_cpus_allowed_fallback(struct task_struct *p);
+extern bool cpuset_cpu_is_isolated(int cpu);
 extern nodemask_t cpuset_mems_allowed(struct task_struct *p);
 #define cpuset_current_mems_allowed (current->mems_allowed)
 void cpuset_init_current_mems_allowed(void);
@@ -207,6 +208,11 @@ static inline bool cpuset_cpus_allowed_fallback(struct task_struct *p)
 	return false;
 }
 
+static inline bool cpuset_cpu_is_isolated(int cpu)
+{
+	return false;
+}
+
 static inline nodemask_t cpuset_mems_allowed(struct task_struct *p)
 {
 	return node_possible_map;
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index fe1a46f30d24..2b461129d1fa 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -2,6 +2,7 @@
 #define _LINUX_SCHED_ISOLATION_H
 
 #include <linux/cpumask.h>
+#include <linux/cpuset.h>
 #include <linux/init.h>
 #include <linux/tick.h>
 
@@ -67,7 +68,8 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
 static inline bool cpu_is_isolated(int cpu)
 {
 	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
-		 !housekeeping_test_cpu(cpu, HK_TYPE_TICK);
+	       !housekeeping_test_cpu(cpu, HK_TYPE_TICK) ||
+	       cpuset_cpu_is_isolated(cpu);
 }
 
 #endif /* _LINUX_SCHED_ISOLATION_H */
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2a16df86c55c..dfbb16aca9f4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1518,6 +1518,17 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
 	WARN_ON_ONCE(ret < 0);
 }
 
+/**
+ * cpuset_cpu_is_isolated - Check if the given CPU is isolated
+ * @cpu: the CPU number to be checked
+ * Return: true if CPU is used in an isolated partition, false otherwise
+ */
+bool cpuset_cpu_is_isolated(int cpu)
+{
+	return cpumask_test_cpu(cpu, isolated_cpus);
+}
+EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
+
 /*
  * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
  * @cs: cpuset
-- 
2.39.3


