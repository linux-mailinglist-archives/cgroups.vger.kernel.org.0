Return-Path: <cgroups+bounces-10278-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6320CB87BF6
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 04:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A5A1B24627
	for <lists+cgroups@lfdr.de>; Fri, 19 Sep 2025 02:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EEC24DFF3;
	Fri, 19 Sep 2025 02:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eYMR3My2"
X-Original-To: cgroups@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8E32459FD
	for <cgroups@vger.kernel.org>; Fri, 19 Sep 2025 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758250152; cv=none; b=kQl/6pr3KeU9CYfmvemaZiogazOWNyzdo0p+rWDvnfCb6sbO59nJsN/cqaQ5WWBFwFYiLyKWAS29eUHFRfoufPhNUBOn3Eb2SROyxHyC4yBRPK/nV5ntBHllNItLq4exIUFwOP524ACQw9c5NGazEPV7Toxmr8cghBAfc+0IAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758250152; c=relaxed/simple;
	bh=CS3SrhHGAuGkBr7hmqNoYLasrhOBrVQu2ZjclyYK/Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITD6mGKil7wBBWHspktdGMpa85kWtkDbKFubj5JFA8s1rvdv5b+QsqSzV3FL6/su5DAbyc46b6fCWABeCK9pLsEErJRq7ZR/NgIDZjGtbMyS/ws7vf5t21rmh9f3kSU13DrMvIb+AY9gOWOIpkDDqFOYFiYy487OrJJ7/33qpyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eYMR3My2; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Sep 2025 19:49:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758250147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QqZyQZcoeHlrOOiTQqItbAzvsXWRLXScDq7yxQ6zIhg=;
	b=eYMR3My2q96I0w45HjiMc5eI+Tbb/qiY3f/qo5BwzEzCQO5RiSnBpuHfyj7mt61J+J3bY3
	PWXDdbCGHKao6O98bht2HJa0iu4W8ploFpkw0O6vbWMpeGFcdtG1FziqynjrtUwpaaBeQy
	mU2yaeddKDsJyFN2Isg5hUKU4R/IHi8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Peilin Ye <yepeilin@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] memcg: skip cgroup_file_notify if spinning is not allowed
Message-ID: <5qi2llyzf7gklncflo6gxoozljbm4h3tpnuv4u4ej4ztysvi6f@x44v7nz2wdzd>
References: <20250905201606.66198-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905201606.66198-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 05, 2025 at 01:16:06PM -0700, Shakeel Butt wrote:
> Generally memcg charging is allowed from all the contexts including NMI
> where even spinning on spinlock can cause locking issues. However one
> call chain was missed during the addition of memcg charging from any
> context support. That is try_charge_memcg() -> memcg_memory_event() ->
> cgroup_file_notify().
> 
> The possible function call tree under cgroup_file_notify() can acquire
> many different spin locks in spinning mode. Some of them are
> cgroup_file_kn_lock, kernfs_notify_lock, pool_workqeue's lock. So, let's
> just skip cgroup_file_notify() from memcg charging if the context does
> not allow spinning.
> 
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>

Here I am just pasting the irq_work based prototype which is build
tested only for now and sharing it early to show how it looks. Overall I
think it is adding too much complexity which is not worth it. We have to
add per-cpu irq_work and then for each memcg we have to add per-cpu
lockless node to queue the deferred event update. Also more reasoning is
needed to make sure the updates are not missed by the deferred work.

Anyways, this is the early prototype. Unless there are comments on how
to make it better, I will ask Andrew to just pick the previous patch I
sent.


From d58d772f306454f0dffa94bfb32195496c450892 Mon Sep 17 00:00:00 2001
From: Shakeel Butt <shakeel.butt@linux.dev>
Date: Thu, 18 Sep 2025 19:25:37 -0700
Subject: [PATCH] memcg: add support for deferred max memcg event

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 include/linux/memcontrol.h |  3 ++
 mm/memcontrol.c            | 85 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 84 insertions(+), 4 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 16fe0306e50e..3f803957e05d 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -69,6 +69,7 @@ struct mem_cgroup_id {
 	refcount_t ref;
 };
 
+struct deferred_events_percpu;
 struct memcg_vmstats_percpu;
 struct memcg1_events_percpu;
 struct memcg_vmstats;
@@ -268,6 +269,8 @@ struct mem_cgroup {
 
 	struct memcg_vmstats_percpu __percpu *vmstats_percpu;
 
+	struct deferred_events_percpu __percpu *deferred_events;
+
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head cgwb_list;
 	struct wb_domain cgwb_domain;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e090f29eb03b..a34cb728c5c6 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -132,6 +132,63 @@ bool mem_cgroup_kmem_disabled(void)
 	return cgroup_memory_nokmem;
 }
 
+struct deferred_events_percpu {
+	atomic_t max_events;
+	struct mem_cgroup *memcg_owner;
+	struct llist_node lnode;
+};
+
+struct defer_memcg_events {
+	struct llist_head memcg_llist;
+	struct irq_work work;
+};
+
+static void process_deferred_events(struct irq_work *work)
+{
+	struct defer_memcg_events *events = container_of(work,
+						struct defer_memcg_events, work);
+	struct llist_node *lnode;
+
+	while (lnode = llist_del_first_init(&events->memcg_llist)) {
+		int i, num;
+		struct deferred_events_percpu *eventsc;
+
+		eventsc = container_of(lnode, struct deferred_events_percpu, lnode);
+
+		if (!atomic_read(&eventsc->max_events))
+			continue;
+		num = atomic_xchg(&eventsc->max_events, 0);
+		if (!num)
+			continue;
+		for (i = 0; i < num; i++)
+			memcg_memory_event(eventsc->memcg_owner, MEMCG_MAX);
+	}
+}
+
+static DEFINE_PER_CPU(struct defer_memcg_events, postpone_events) = {
+	.memcg_llist = LLIST_HEAD_INIT(memcg_llist),
+	.work = IRQ_WORK_INIT(process_deferred_events),
+};
+
+static void memcg_memory_max_event_queue(struct mem_cgroup *memcg)
+{
+	int cpu;
+	struct defer_memcg_events *devents;
+	struct deferred_events_percpu *dmemcg_events;
+
+	cpu = get_cpu();
+	devents = per_cpu_ptr(&postpone_events, cpu);
+	dmemcg_events = per_cpu_ptr(memcg->deferred_events, cpu);
+
+	atomic_inc(&dmemcg_events->max_events);
+	// barrier here to make sure that if following llist_add returns false,
+	// the corresponding llist_del_first_init will see our increment.
+	if (llist_add(&dmemcg_events->lnode, &devents->memcg_llist))
+		irq_work_queue(&devents->work);
+
+	put_cpu();
+}
+
 static void memcg_uncharge(struct mem_cgroup *memcg, unsigned int nr_pages);
 
 static void obj_cgroup_release(struct percpu_ref *ref)
@@ -2307,12 +2364,13 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	bool drained = false;
 	bool raised_max_event = false;
 	unsigned long pflags;
+	bool allow_spinning = gfpflags_allow_spinning(gfp_mask);
 
 retry:
 	if (consume_stock(memcg, nr_pages))
 		return 0;
 
-	if (!gfpflags_allow_spinning(gfp_mask))
+	if (!allow_spinning)
 		/* Avoid the refill and flush of the older stock */
 		batch = nr_pages;
 
@@ -2348,7 +2406,10 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	if (!gfpflags_allow_blocking(gfp_mask))
 		goto nomem;
 
-	memcg_memory_event(mem_over_limit, MEMCG_MAX);
+	if (allow_spinning)
+		memcg_memory_event(mem_over_limit, MEMCG_MAX);
+	else
+		memcg_memory_max_event_queue(mem_over_limit);
 	raised_max_event = true;
 
 	psi_memstall_enter(&pflags);
@@ -2414,8 +2475,12 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 * If the allocation has to be enforced, don't forget to raise
 	 * a MEMCG_MAX event.
 	 */
-	if (!raised_max_event)
-		memcg_memory_event(mem_over_limit, MEMCG_MAX);
+	if (!raised_max_event) {
+		if (allow_spinning)
+			memcg_memory_event(mem_over_limit, MEMCG_MAX);
+		else
+			memcg_memory_max_event_queue(mem_over_limit);
+	}
 
 	/*
 	 * The allocation either can't fail or will lead to more memory
@@ -3689,6 +3754,7 @@ static void __mem_cgroup_free(struct mem_cgroup *memcg)
 		free_mem_cgroup_per_node_info(memcg->nodeinfo[node]);
 	memcg1_free_events(memcg);
 	kfree(memcg->vmstats);
+	free_percpu(memcg->deferred_events);
 	free_percpu(memcg->vmstats_percpu);
 	kfree(memcg);
 }
@@ -3704,6 +3770,7 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 {
 	struct memcg_vmstats_percpu *statc;
 	struct memcg_vmstats_percpu __percpu *pstatc_pcpu;
+	struct deferred_events_percpu *devents;
 	struct mem_cgroup *memcg;
 	int node, cpu;
 	int __maybe_unused i;
@@ -3729,6 +3796,11 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 	if (!memcg->vmstats_percpu)
 		goto fail;
 
+	memcg->deferred_events = alloc_percpu_gfp(struct deferred_events_percpu,
+						  GFP_KERNEL_ACCOUNT);
+	if (!memcg->deferred_events)
+		goto fail;
+
 	if (!memcg1_alloc_events(memcg))
 		goto fail;
 
@@ -3738,6 +3810,11 @@ static struct mem_cgroup *mem_cgroup_alloc(struct mem_cgroup *parent)
 		statc = per_cpu_ptr(memcg->vmstats_percpu, cpu);
 		statc->parent_pcpu = parent ? pstatc_pcpu : NULL;
 		statc->vmstats = memcg->vmstats;
+
+		devents = per_cpu_ptr(memcg->deferred_events, cpu);
+		atomic_set(&devents->max_events, 0);
+		devents->memcg_owner = memcg;
+		init_llist_node(&devents->lnode);
 	}
 
 	for_each_node(node)
-- 
2.47.3


