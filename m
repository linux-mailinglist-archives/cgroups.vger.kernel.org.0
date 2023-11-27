Return-Path: <cgroups+bounces-562-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8147F9835
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 05:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B38280DB4
	for <lists+cgroups@lfdr.de>; Mon, 27 Nov 2023 04:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF23253A0;
	Mon, 27 Nov 2023 04:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSfbnK6w"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7642A12D
	for <cgroups@vger.kernel.org>; Sun, 26 Nov 2023 20:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701058840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pKVtOlZpPOEAj5lNTi1dWbItOap9Z0LKbf6VYUUDvbg=;
	b=bSfbnK6wNLeInzjgr0xfgYNehx/k0/kxwyRs/1WcDwEG4t288q/Eqbnjeu942DyqyTrfGW
	pD3wWvI9C/Nt8bRBz1kA2chaS4ZL63eWCQNzG2rokTNtrifjcHr8e5hYAH6V541QszLou8
	6R+RfqcGlbQszbGEORVbKRsBCUru4Ys=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-j3AE3EJcPLitu_hjDmnbBg-1; Sun, 26 Nov 2023 23:20:36 -0500
X-MC-Unique: j3AE3EJcPLitu_hjDmnbBg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28C3981D8A1;
	Mon, 27 Nov 2023 04:20:36 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.84])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8543410EA1;
	Mon, 27 Nov 2023 04:20:35 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 2/2] cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated() check
Date: Sun, 26 Nov 2023 23:19:56 -0500
Message-Id: <20231127041956.266026-3-longman@redhat.com>
In-Reply-To: <20231127041956.266026-1-longman@redhat.com>
References: <20231127041956.266026-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

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

To minimize overhead of calling cpuset_cpu_is_isolated(), a seqcount
is used to protect read access of the isolated cpumask without taking
the cpuset_mutex or callback_lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cpuset.h          |  6 ++++++
 include/linux/sched/isolation.h |  4 +++-
 kernel/cgroup/cpuset.c          | 25 +++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

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
index e34bbb0e2f24..4adb6d2209ca 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -208,8 +208,13 @@ static cpumask_var_t	subpartitions_cpus;
 
 /*
  * Exclusive CPUs in isolated partitions
+ *
+ * The isolcpus_seq is used to protect read access to isolated_cpus without
+ * taking callback_lock or cpuset_mutex while write access requires taking
+ * both cpuset_mutex and callback_lock.
  */
 static cpumask_var_t	isolated_cpus;
+static seqcount_t isolcpus_seq = SEQCNT_ZERO(isolcpus_seq);
 
 /* List of remote partition root children */
 static struct list_head remote_children;
@@ -1435,10 +1440,12 @@ static void reset_partition_data(struct cpuset *cs)
 static void partition_xcpus_newstate(int old_prs, int new_prs, struct cpumask *xcpus)
 {
 	WARN_ON_ONCE(old_prs == new_prs);
+	write_seqcount_begin(&isolcpus_seq);
 	if (new_prs == PRS_ISOLATED)
 		cpumask_or(isolated_cpus, isolated_cpus, xcpus);
 	else
 		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
+	write_seqcount_end(&isolcpus_seq);
 }
 
 /*
@@ -1518,6 +1525,24 @@ static void update_unbound_workqueue_cpumask(bool isolcpus_updated)
 	WARN_ON_ONCE(ret < 0);
 }
 
+/**
+ * cpuset_cpu_is_isolated - Check if the given CPU is isolated
+ * @cpu: the CPU number to be checked
+ * Return: true if CPU is used in an isolated partition, false otherwise
+ */
+bool cpuset_cpu_is_isolated(int cpu)
+{
+	unsigned int seq;
+	bool ret;
+
+	do {
+		seq = read_seqcount_begin(&isolcpus_seq);
+		ret = cpumask_test_cpu(cpu, isolated_cpus);
+	} while (read_seqcount_retry(&isolcpus_seq, seq));
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
+
 /*
  * compute_effective_exclusive_cpumask - compute effective exclusive CPUs
  * @cs: cpuset
-- 
2.39.3


