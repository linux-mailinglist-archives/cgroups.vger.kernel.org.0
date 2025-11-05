Return-Path: <cgroups+bounces-11624-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD94C37E3D
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 22:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2893B04DB
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 21:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C513559D0;
	Wed,  5 Nov 2025 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knp5BQSS"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BEF34E749;
	Wed,  5 Nov 2025 21:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762376752; cv=none; b=VDBAA+P1ALllJIzWP9G+76VuejyXi1lwktMAFhstl4VLGz6Fm59SBj6Kiyxe4w5m0Qbx0pjNNNRxzysgyF7gTZsIwPvNxlH1ZE+W73xOy+gxDiQKwjytgwnOY6/Ks706VA7Se7ymL4yrOCIB+mczVRkdQei5hD8mU3e16StsYIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762376752; c=relaxed/simple;
	bh=F8RS6HxMEwD+CdqqVcGXcs4QntwP/aQ69bm2ypLXfL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4OTq+fKdjUfr7V4CmZHpg9ybDJk6eluIBsF2wZPJxAuwGiqkGLIYi/4mkNN8lU3zs7MM3k2/vzkpEEEhcJDbTurGOtF0Nk/SFOcJPo6DyztkJuep0l0xXaheG0Jq1ThsUj/bmGrY31JW4CyX5Wh6FH5Y90i96OiwztXqUkenFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knp5BQSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B768C116C6;
	Wed,  5 Nov 2025 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762376752;
	bh=F8RS6HxMEwD+CdqqVcGXcs4QntwP/aQ69bm2ypLXfL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Knp5BQSSwU501i5GIxnOcbJwTVtyFd53ptT/lFssQbFaYhKGEBfKTkv46MZZ5eSe1
	 qxuJjt66g7Sq6NeQA6NaWjGbi56uDFYVJbvkh8/lprQJWhDZFDxww7qnbY7RQvWEfY
	 Z55jySVJI3FlCGLh99LtrKlkWqidLK9czXsitcbTscRVs7X079FoC9rzCZ0GfbpRMe
	 XaOAMs+/PWPGsjQXVydlFUcSk0jAgQIS8NvlcbuFOG8eu84588igVhduPlmyPu9p/v
	 UTgVFquC2M3nQSL8WmvFgWOMy0XwEQlYhFjT5Fker0h+UYE/olRnCJKAsljLmgJGLu
	 Zyqg0u8oNPkQw==
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
Subject: [PATCH 14/31] sched/isolation: Flush memcg workqueues on cpuset isolated partition change
Date: Wed,  5 Nov 2025 22:03:30 +0100
Message-ID: <20251105210348.35256-15-frederic@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105210348.35256-1-frederic@kernel.org>
References: <20251105210348.35256-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HK_TYPE_DOMAIN housekeeping cpumask is now modifiable at runtime. In
order to synchronize against memcg workqueue to make sure that no
asynchronous draining is still pending or executing on a newly made
isolated CPU, the housekeeping susbsystem must flush the memcg
workqueues.

However the memcg workqueues can't be flushed easily since they are
queued to the main per-CPU workqueue pool.

Solve this with creating a memcg specific pool and provide and use the
appropriate flushing API.

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/memcontrol.h |  4 ++++
 kernel/sched/isolation.c   |  2 ++
 kernel/sched/sched.h       |  1 +
 mm/memcontrol.c            | 12 +++++++++++-
 4 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 873e510d6f8d..001200df63cf 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1074,6 +1074,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 	return id;
 }
 
+void mem_cgroup_flush_workqueue(void);
+
 extern int mem_cgroup_init(void);
 #else /* CONFIG_MEMCG */
 
@@ -1481,6 +1483,8 @@ static inline u64 cgroup_id_from_mm(struct mm_struct *mm)
 	return 0;
 }
 
+static inline void mem_cgroup_flush_workqueue(void) { }
+
 static inline int mem_cgroup_init(void) { return 0; }
 #endif /* CONFIG_MEMCG */
 
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 80a5b7c6400c..16c912dd91d2 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -145,6 +145,8 @@ int housekeeping_update(struct cpumask *mask, enum hk_type type)
 
 	synchronize_rcu();
 
+	mem_cgroup_flush_workqueue();
+
 	kfree(old);
 
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5a44e85d4864..77034d20b4e8 100644
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
index 1033e52ab6cf..4d1f680a4bb0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -95,6 +95,8 @@ static bool cgroup_memory_nokmem __ro_after_init;
 /* BPF memory accounting disabled? */
 static bool cgroup_memory_nobpf __ro_after_init;
 
+static struct workqueue_struct *memcg_wq __ro_after_init;
+
 static struct kmem_cache *memcg_cachep;
 static struct kmem_cache *memcg_pn_cachep;
 
@@ -1975,7 +1977,7 @@ static void schedule_drain_work(int cpu, struct work_struct *work)
 {
 	guard(rcu)();
 	if (!cpu_is_isolated(cpu))
-		schedule_work_on(cpu, work);
+		queue_work_on(cpu, memcg_wq, work);
 }
 
 /*
@@ -5092,6 +5094,11 @@ void mem_cgroup_sk_uncharge(const struct sock *sk, unsigned int nr_pages)
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
@@ -5134,6 +5141,9 @@ int __init mem_cgroup_init(void)
 	cpuhp_setup_state_nocalls(CPUHP_MM_MEMCQ_DEAD, "mm/memctrl:dead", NULL,
 				  memcg_hotplug_cpu_dead);
 
+	memcg_wq = alloc_workqueue("memcg", WQ_PERCPU, 0);
+	WARN_ON(!memcg_wq);
+
 	for_each_possible_cpu(cpu) {
 		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
 			  drain_local_memcg_stock);
-- 
2.51.0


