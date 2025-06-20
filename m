Return-Path: <cgroups+bounces-8614-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0ABDAE1E9C
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 17:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18345A32E5
	for <lists+cgroups@lfdr.de>; Fri, 20 Jun 2025 15:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80412ECD38;
	Fri, 20 Jun 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuDPDV0N"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932582ECD13;
	Fri, 20 Jun 2025 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433039; cv=none; b=pdlmNGQfL7Atn0XrzS1RVPMfNBPpY3zgVcCTP+Ag1gC+OiGcoPoYWyXYmZxyq983XWpOO69ES0+JFQT9WheKolOUP4GSmHo7SuncJTuhXhQ8KthNut5y3cPNBXl6NlrD88dtjVtN6K/V/3D+1ubkMhXkQaUUTLScleU/Q0JE3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433039; c=relaxed/simple;
	bh=puBcn1RLjuMlGziYQtO8T9w0Hol7ZIDbbn6QvjDV/zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=duevx1ixkbQICAsEDxoRStdBy+2wHyaHjeWo7qm3t/KXWTVX6rP9SNL815DTyDozFwNg1HRYbSgrWVLHYY8kcAMIcqnyghy0cpdiVuIBetaAyEPVzl8vf4h5YET4YXNTPU6fsGjvC/fmlS5+30aQtjzHZ44DOo5jjxmF8v1LJqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuDPDV0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBFDC4CEE3;
	Fri, 20 Jun 2025 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433039;
	bh=puBcn1RLjuMlGziYQtO8T9w0Hol7ZIDbbn6QvjDV/zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZuDPDV0NqIta2HyKRSmvefpltNr5OQmlAiOy9JNjBp+KZ7zcKekZkV7tLDeT3G9FC
	 B/xYcs9tQuK3L5hIeu3TK7veaQeloAMkKamwtfMv9j3wyItFJ4Jeyumk+lanosdVam
	 h6v8DnSe9cqMa2epNROFZmS3FTYQlORrrO5dSX6Oe6zjXsdM5PHYt0SJEddqQSwRhM
	 r8oWPFNNGOLwoy1BcwIn1UxB2q+NCo+QdxAzjbG01MEn7Q0JYWLL6RMd8XkyVh3qW2
	 MUtEaCFkMso3v8JTsxk5WyijDJMv3M/XMPmcVJo1eyD/+QqlZ8A2cFCJu/fzktD0hH
	 lFIS1EL3Rqvvw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Zijlstra <peterz@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Waiman Long <longman@redhat.com>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 16/27] sched/isolation: Flush memcg workqueues on cpuset isolated partition change
Date: Fri, 20 Jun 2025 17:22:57 +0200
Message-ID: <20250620152308.27492-17-frederic@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250620152308.27492-1-frederic@kernel.org>
References: <20250620152308.27492-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HK_TYPE_DOMAIN housekeeping cpumask is now modifyable at runtime. In
order to synchronize against memcg workqueue to make sure that no
asynchronous draining is still pending or executing on a newly made
isolated CPU, the housekeeping susbsystem must flush the memcg
workqueues.

However the memcg workqueues can't be flushed easily since they are
queued to the main per-CPU workqueue pool.

Solve this with creating a memcg specific pool and provide and use the
appropriate flushing API.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/memcontrol.h |  4 ++++
 kernel/sched/isolation.c   |  2 ++
 kernel/sched/sched.h       |  1 +
 mm/memcontrol.c            | 12 +++++++++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 87b6688f124a..ef5036c6bf04 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1046,6 +1046,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 	return id;
 }
 
+void mem_cgroup_flush_workqueue(void);
+
 extern int mem_cgroup_init(void);
 #else /* CONFIG_MEMCG */
 
@@ -1451,6 +1453,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 	return 0;
 }
 
+static inline void mem_cgroup_flush_workqueue(void) { }
+
 static inline int mem_cgroup_init(void) { return 0; }
 #endif /* CONFIG_MEMCG */
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7814d60be87e..6fb0c7956516 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -140,6 +140,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 
 	synchronize_rcu();
 
+	mem_cgroup_flush_workqueue();
+
 	kfree(old);
 
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 04094567cad4..53107c021fe9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -44,6 +44,7 @@
 #include <linux/lockdep_api.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
+#include <linux/memcontrol.h>
 #include <linux/minmax.h>
 #include <linux/mm.h>
 #include <linux/module.h>
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 29d44af6c426..928b90cdb5ba 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -96,6 +96,8 @@ static bool cgroup_memory_nokmem __ro_after_init;
 /* BPF memory accounting disabled? */
 static bool cgroup_memory_nobpf __ro_after_init;
 
+static struct workqueue_struct *memcg_wq __ro_after_init;
+
 static struct kmem_cache *memcg_cachep;
 static struct kmem_cache *memcg_pn_cachep;
 
@@ -1979,7 +1981,7 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 {
 	housekeeping_lock();
 	if (!cpu_is_isolated(cpu))
-		schedule_work_on(cpu, work);
+		queue_work_on(cpu, memcg_wq, work);
 	housekeeping_unlock();
 }
 
@@ -5140,6 +5142,11 @@ void mem_cgroup_uncharge_skmem(struct mem_cgroup *memcg, unsigned int nr_pages)
 	refill_stock(memcg, nr_pages);
 }
 
+void mem_cgroup_flush_workqueue(void)
+{
+	flush_workqueue(memcg_wq);
+}
+
 static int __init cgroup_memory(char *s)
 {
 	char *token;
@@ -5182,6 +5189,9 @@ int __init mem_cgroup_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
+	memcg_wq = alloc_workqueue("memcg", 0, 0);
+	WARN_ON(!memcg_wq);
+
 	for_each_possible_cpu(cpu) {
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_memcg_stock);
-- 
2.48.1


