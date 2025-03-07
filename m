Return-Path: <cgroups+bounces-6875-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 759C4A5608E
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 06:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68A9C7A6A6C
	for <lists+cgroups@lfdr.de>; Fri,  7 Mar 2025 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA95C199E94;
	Fri,  7 Mar 2025 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y23GtGUH"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1E218DB09
	for <cgroups@vger.kernel.org>; Fri,  7 Mar 2025 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741327185; cv=none; b=uSWdQx7JoB3MVfEKlWL3jKKs+XY/ppHGjA/nKUJy+DakVzo1XN3E/b3eMhhcaX6KOH1Uz9kHYCN9O3Chvu11nuizH1fImUahwCwvwO9wDTqOgF33JAEIQ4jIMT83X/fodrhp4cv/2bLRC/I10XKeDyvBNid2BvAjtZng+FFffjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741327185; c=relaxed/simple;
	bh=wwmac+s+ESlIyXNfnNVtMPr0GhgEwFZOhY1IMJmPMZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fcb8kCx5wUi1cHXYALydCoZv4sIDgPEtDVreFWTyhVVWrhRWxm1OhV1sx40ywzIigYX1xIFXPcvRISpR+ogZyllNLXGALmB4EWbKCuEqOk2B3jvSaEcNi//iYd4AT7pzVB++9nunp9yo6Hfsw8GYSI9QXzdovCMaFGQAJwHgw9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y23GtGUH; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741327181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7I8JlXAk7XOW8Ec0KDXoqsOGAqhiP+woZaSK8OFzW+A=;
	b=Y23GtGUH7snKv5PLNOK1WbMqZLI09sdw345e87VF5yfzvB/zAhflbUQmQTPf8N2U71HX42
	9iJ6OfxCBiKqGj8MEFCfnZc1JK4oC8B6AgkVL4L3HLXDrcT8fwDx3t+wBPGe8HsbMpY1Ot
	ecJDGe8A2vtpgskccGCGs0JM/0SsYNM=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [RFC PATCH] memcg: net: improve charging of incoming network traffic
Date: Thu,  6 Mar 2025 21:59:36 -0800
Message-ID: <20250307055936.3988572-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Memory cgroup accounting is expensive and to reduce the cost, the kernel
maintains per-cpu charge cache for a single memcg. So, if a charge
request comes for a different memcg, the kernel will flush the old
memcg's charge cache and then charge the newer memcg a fixed amount (64
pages), subtracts the charge request amount and stores the remaining in
the per-cpu charge cache for the newer memcg.

This mechanism is based on the assumption that the kernel, for locality,
keep a process on a CPU for long period of time and most of the charge
requests from that process will be served by that CPU's local charge
cache.

However this assumption breaks down for incoming network traffic in a
multi-tenant machine. We are in the process of running multiple
workloads on a single machine and if such workloads are network heavy,
we are seeing very high network memory accounting cost. We have observed
multiple CPUs spending almost 100% of their time in net_rx_action and
almost all of that time is spent in memcg accounting of the network
traffic.

More precisely, net_rx_action is serving packets from multiple workloads
and is observing/serving mix of packets of these workloads. The memcg
switch of per-cpu cache is very expensive and we are observing a lot of
memcg switches on the machine. Almost all the time is being spent on
charging new memcg and flushing older memcg cache. So, definitely we
need per-cpu cache that support multiple memcgs for this scenario.

This prototype implements a network specific scope based memcg charge
cache that supports holding charge for multiple memcgs. However this is
not the final design and I wanted to start the conversation on this
topic with some open questions below:

1. Should we keep existing per-cpu single memcg cache?
2. Should we have a network specific solution similar to this prototype
   or more general solution?
3. If we decide to have multi memcg charge cache, what should be the
   size? Should it be dynamic or static?
4. Do we really care about performance (throughput) in PREEMPT_RT?

Let me give my opinion on these questions:

A1. We definitely need to evolve the per-cpu charge cache. I am not
    happy with the irq disabling for memcg charging and stats code. I am
    planning to move towards two set of stocks, one for in_task() and
    the other for !in_task() (similar to active_memcg handling) and with
    that remove the irq disabling from the charge path. In the followup
    I want to expand this to the obj stocks as well and also remove the
    irq disabling from that.

A2. I think we need a general solution as I suspect kvfree_rcu_bulk()
    might be in a similar situation. However I think we can definitely
    use network specific knowledge to further improve network memory
    charging. For example, we know kernel uses GFP_ATOMIC for charging
    incoming traffic which always succeeds. We can exploit this
    knowledge to further improve network charging throughput.

A3. Here I think we need to start simple and make it more sophisticated
    as we see more data from production/field from multiple places. This
    can become complicated very easily. For example the evict policy for
    memcg charge cache.

A4. I don't think PREEMPT_RT is about throughput but it cares about
    latency but these memcg charge caches are about throughput. In
    addition PREEMPT_RT has made memcg code a lot messier (IMO). IMO the
    PREEMPT_RT kernel should just skip all per-cpu memcg caches
    including objcg ones and that would make code much simpler.

That is my take and I would really like opinions and suggestions from
others. BTW I want to resolve this issue asap as this is becoming a
blocker for multi-tenancy for us.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h | 37 +++++++++++++++++
 mm/memcontrol.c            | 83 ++++++++++++++++++++++++++++++++++++++
 net/core/dev.c             |  4 ++
 3 files changed, 124 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 57664e2a8fb7..3aa22b0261be 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1617,6 +1617,30 @@ extern struct static_key_false memcg_sockets_enabled_key;
 #define mem_cgroup_sockets_enabled static_branch_unlikely(&memcg_sockets_enabled_key)
 void mem_cgroup_sk_alloc(struct sock *sk);
 void mem_cgroup_sk_free(struct sock *sk);
+
+struct memcg_skmem_batch {
+	int size;
+	struct mem_cgroup *memcg[MEMCG_CHARGE_BATCH];
+	unsigned int nr_pages[MEMCG_CHARGE_BATCH];
+};
+
+void __mem_cgroup_batch_charge_skmem_begin(struct memcg_skmem_batch *batch);
+void __mem_cgroup_batch_charge_skmem_end(struct memcg_skmem_batch *batch);
+
+static inline void mem_cgroup_batch_charge_skmem_begin(struct memcg_skmem_batch *batch)
+{
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
+	   mem_cgroup_sockets_enabled)
+		__mem_cgroup_batch_charge_skmem_begin(batch);
+}
+
+static inline void mem_cgroup_batch_charge_skmem_end(struct memcg_skmem_batch *batch)
+{
+	if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
+	   mem_cgroup_sockets_enabled)
+		__mem_cgroup_batch_charge_skmem_end(batch);
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 #ifdef CONFIG_MEMCG_V1
@@ -1638,6 +1662,19 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg);
 #define mem_cgroup_sockets_enabled 0
 static inline void mem_cgroup_sk_alloc(struct sock *sk) { };
 static inline void mem_cgroup_sk_free(struct sock *sk) { };
+
+struct memcg_skmem_batch {};
+
+static inline void mem_cgroup_batch_charge_skmem_begin(
+					struct memcg_skmem_batch *batch)
+{
+}
+
+static inline void mem_cgroup_batch_charge_skmem_end(
+					struct memcg_skmem_batch *batch)
+{
+}
+
 static inline bool mem_cgroup_under_socket_pressure(struct mem_cgroup *memcg)
 {
 	return false;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 709b16057048..3afca4d055b3 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -88,6 +88,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(int_active_memcg);
 
 /* Socket memory accounting disabled? */
 static bool cgroup_memory_nosocket __ro_after_init;
+DEFINE_PER_CPU(struct memcg_skmem_batch *, int_skmem_batch);
 
 /* Kernel memory accounting disabled? */
 static bool cgroup_memory_nokmem __ro_after_init;
@@ -1775,6 +1776,57 @@ static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
 static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
 				     struct mem_cgroup *root_memcg);
 
+static inline bool consume_batch_stock(struct mem_cgroup *memcg,
+				       unsigned int nr_pages)
+{
+	int i;
+	struct memcg_skmem_batch *batch;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_task() ||
+	    !this_cpu_read(int_skmem_batch))
+		return false;
+
+	batch = this_cpu_read(int_skmem_batch);
+	for (i = 0; i < batch->size; ++i) {
+		if (batch->memcg[i] == memcg) {
+			if (nr_pages <= batch->nr_pages[i]) {
+				batch->nr_pages[i] -= nr_pages;
+				return true;
+			}
+			return false;
+		}
+	}
+	return false;
+}
+
+static inline bool refill_stock_batch(struct mem_cgroup *memcg,
+				      unsigned int nr_pages)
+{
+	int i;
+	struct memcg_skmem_batch *batch;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_task() ||
+	    !this_cpu_read(int_skmem_batch))
+		return false;
+
+	batch = this_cpu_read(int_skmem_batch);
+	for (i = 0; i < batch->size; ++i) {
+		if (memcg == batch->memcg[i]) {
+			batch->nr_pages[i] += nr_pages;
+			return true;
+		}
+	}
+
+	if (i == MEMCG_CHARGE_BATCH)
+		return false;
+
+	/* i == batch->size */
+	batch->memcg[i] = memcg;
+	batch->nr_pages[i] = nr_pages;
+	batch->size++;
+	return true;
+}
+
 /**
  * consume_stock: Try to consume stocked charge on this cpu.
  * @memcg: memcg to consume from.
@@ -1795,6 +1847,9 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
 	unsigned long flags;
 	bool ret = false;
 
+	if (consume_batch_stock(memcg, nr_pages))
+		return true;
+
 	if (nr_pages > MEMCG_CHARGE_BATCH)
 		return ret;
 
@@ -1887,6 +1942,9 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
 {
 	unsigned long flags;
 
+	if (refill_stock_batch(memcg, nr_pages))
+		return;
+
 	if (!localtry_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
 		/*
 		 * In case of unlikely failure to lock percpu stock_lock
@@ -4894,6 +4952,31 @@ void mem_cgroup_sk_free(struct sock *sk)
 		css_put(&sk->sk_memcg->css);
 }
 
+void __mem_cgroup_batch_charge_skmem_begin(struct memcg_skmem_batch *batch)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_task() ||
+	    this_cpu_read(int_skmem_batch))
+		return;
+
+	this_cpu_write(int_skmem_batch, batch);
+}
+
+void __mem_cgroup_batch_charge_skmem_end(struct memcg_skmem_batch *batch)
+{
+	int i;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) || in_task() ||
+	    batch != this_cpu_read(int_skmem_batch))
+		return;
+
+	this_cpu_write(int_skmem_batch, NULL);
+	for (i = 0; i < batch->size; ++i) {
+		if (batch->nr_pages[i])
+			page_counter_uncharge(&batch->memcg[i]->memory,
+					      batch->nr_pages[i]);
+	}
+}
+
 /**
  * mem_cgroup_charge_skmem - charge socket memory
  * @memcg: memcg to charge
diff --git a/net/core/dev.c b/net/core/dev.c
index 0eba6e4f8ccb..846305d019c6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7484,9 +7484,12 @@ static __latent_entropy void net_rx_action(void)
 		usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs));
 	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
 	int budget = READ_ONCE(net_hotdata.netdev_budget);
+	struct memcg_skmem_batch batch = {};
 	LIST_HEAD(list);
 	LIST_HEAD(repoll);
 
+	mem_cgroup_batch_charge_skmem_begin(&batch);
+
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 start:
 	sd->in_net_rx_action = true;
@@ -7542,6 +7545,7 @@ static __latent_entropy void net_rx_action(void)
 	net_rps_action_and_irq_enable(sd);
 end:
 	bpf_net_ctx_clear(bpf_net_ctx);
+	mem_cgroup_batch_charge_skmem_end(&batch);
 }
 
 struct netdev_adjacent {
-- 
2.43.5


