Return-Path: <cgroups+bounces-14491-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK3fIRlfo2myBQUAu9opvQ
	(envelope-from <cgroups+bounces-14491-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 22:33:13 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9291C923F
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 22:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4525832BEB29
	for <lists+cgroups@lfdr.de>; Sat, 28 Feb 2026 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4333E7161;
	Sat, 28 Feb 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yfql9eeJ"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3E3E7158;
	Sat, 28 Feb 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305682; cv=none; b=sFQDZCjXLgp5KBqaqtxh/d7gP2gSAPsapAG1k3ybqci+zhlZR9GG52HGrb7bcqN42vyYvgE7w320HmEzQLQS0EjjkZQF5ZPQ5KdeEDwNdUmdFqtDp6YQMPlfMIw/Ru9rSDoekuajwI+qnW3NmmTRAIcghFddFEJ9MfyTt2zUrwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305682; c=relaxed/simple;
	bh=ECFj6PIlpgHGhqNluMLaNy+SmRjHOXDaaWlrfELFWo0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E0xDn3aisxB9l0a6ZlEOIar3CFIwQN81asQro/tDaKE2b1FyAp5z2bR6yJZqzx4VAdzwgTVG0BnaU268sih32s4PFBECfVEXmx9yykdFWpWkNy/TBN1E+E188138MyqxPBR3fDeIDBsHw+BsC0DhSsRETbKpAzyJSlfFa0ggS7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yfql9eeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2702FC116D0;
	Sat, 28 Feb 2026 19:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1772305682;
	bh=ECFj6PIlpgHGhqNluMLaNy+SmRjHOXDaaWlrfELFWo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=yfql9eeJU+5rH9cNSzrzpm/RDZf7mTiaCCY25VcG+3U0s9O2PQ5HPfwAl8tKdillT
	 VDaJjVMqrk6F5sF7EKI/xo+I9pi6J89yETNqcyg64igqrmsRoBIpbxAhwj58eVG8Q3
	 Cs66D+FaBMq7EiWWU36EFJXdEU1+PNSH//muc41A=
Date: Sat, 28 Feb 2026 11:08:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com,
 roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev,
 david@kernel.org, lorenzo.stoakes@oracle.com, ziy@nvidia.com,
 harry.yoo@oracle.com, yosry.ahmed@linux.dev, imran.f.khan@oracle.com,
 kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, chenridong@huaweicloud.com, mkoutny@suse.com,
 hamzamahfooz@linux.microsoft.com, apais@linux.microsoft.com,
 lance.yang@linux.dev, bhe@redhat.com, usamaarif642@gmail.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, Yosry Ahmed <yosry@kernel.org>
Subject: Re: [PATCH v5 update 29/32] mm: memcontrol: prepare for reparenting
 non-hierarchical stats
Message-Id: <20260228110800.50bfca2a90912142c11e2922@linux-foundation.org>
In-Reply-To: <20260228072556.31793-1-qi.zheng@linux.dev>
References: <ef13e5974343b37ae2a0e28aff03ea2d033cb888.1772005110.git.zhengqi.arch@bytedance.com>
	<20260228072556.31793-1-qi.zheng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14491-lists,cgroups=lfdr.de];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[cmpxchg.org,google.com,suse.com,linux.dev,kernel.org,oracle.com,nvidia.com,huaweicloud.com,linux.microsoft.com,redhat.com,gmail.com,kvack.org,vger.kernel.org,bytedance.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:mid,linux-foundation.org:dkim]
X-Rspamd-Queue-Id: 8F9291C923F
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 15:25:56 +0800 Qi Zheng <qi.zheng@linux.dev> wrote:

> To resolve the dying memcg issue, we need to reparent LRU folios of child
> memcg to its parent memcg. This could cause problems for non-hierarchical
> stats.
> 
> As Yosry Ahmed pointed out:
> 
> ```
> In short, if memory is charged to a dying cgroup at the time of
> reparenting, when the memory gets uncharged the stats updates will occur
> at the parent. This will update both hierarchical and non-hierarchical
> stats of the parent, which would corrupt the parent's non-hierarchical
> stats (because those counters were never incremented when the memory was
> charged).
> ```
> 
> Now we have the following two types of non-hierarchical stats, and they
> are only used in CONFIG_MEMCG_V1:
> 
> a. memcg->vmstats->state_local[i]
> b. pn->lruvec_stats->state_local[i]
> 
> To ensure that these non-hierarchical stats work properly, we need to
> reparent these non-hierarchical stats after reparenting LRU folios. To
> this end, this commit makes the following preparations:
> 
> 1. implement reparent_state_local() to reparent non-hierarchical stats
> 2. make css_killed_work_fn() to be called in rcu work, and implement
>    get_non_dying_memcg_start() and get_non_dying_memcg_end() to avoid race
>    between mod_memcg_state()/mod_memcg_lruvec_state()
>    and reparent_state_local()

That's a big update (delta patch is below).

What did it all do?

I've bookmarked these reviewer comments:

https://lkml.kernel.org/r/CAO9r8zOhZgrym6oSrtg7b+HmNHEfWuAzZ0i8eYhm5-OEnfFLdw@mail.gmail.com
https://lkml.kernel.org/r/aZ-R87JfacQ2gGq1@linux.dev
https://lkml.kernel.org/r/aZ-kefGBeT-RzGcG@linux.dev

Were they all addressed in some fashion?


 include/linux/memcontrol.h |    1 
 mm/memcontrol-v1.h         |    1 
 mm/memcontrol.c            |   89 ++++++++++++++++++++++++++---------
 3 files changed, 68 insertions(+), 23 deletions(-)

--- a/include/linux/memcontrol.h~mm-memcontrol-prepare-for-reparenting-non-hierarchical-stats-update
+++ a/include/linux/memcontrol.h
@@ -956,7 +956,6 @@ static inline void mod_memcg_page_state(
 
 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
-
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 bool memcg_stat_item_valid(int idx);
 bool memcg_vm_event_item_valid(enum vm_event_item idx);
--- a/mm/memcontrol.c~mm-memcontrol-prepare-for-reparenting-non-hierarchical-stats-update
+++ a/mm/memcontrol.c
@@ -234,11 +234,19 @@ static inline void reparent_state_local(
 	if (cgroup_subsys_on_dfl(memory_cgrp_subsys))
 		return;
 
+	/*
+	 * Reparent stats exposed non-hierarchically. Flush @memcg's stats first
+	 * to read its stats accurately , and conservatively flush @parent's
+	 * stats after reparenting to avoid hiding a potentially large stat
+	 * update (e.g. from callers of mem_cgroup_flush_stats_ratelimited()).
+	 */
 	__mem_cgroup_flush_stats(memcg, true);
 
 	/* The following counts are all non-hierarchical and need to be reparented. */
 	reparent_memcg1_state_local(memcg, parent);
 	reparent_memcg1_lruvec_state_local(memcg, parent);
+
+	__mem_cgroup_flush_stats(parent, true);
 }
 #else
 static inline void reparent_state_local(struct mem_cgroup *memcg, struct mem_cgroup *parent)
@@ -442,7 +450,7 @@ struct lruvec_stats {
 	long state[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Non-hierarchical (CPU aggregated) state */
-	atomic_long_t state_local[NR_MEMCG_NODE_STAT_ITEMS];
+	long state_local[NR_MEMCG_NODE_STAT_ITEMS];
 
 	/* Pending child counts during tree propagation */
 	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
@@ -485,7 +493,7 @@ unsigned long lruvec_page_state_local(st
 		return 0;
 
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
-	x = atomic_long_read(&(pn->lruvec_stats->state_local[i]));
+	x = READ_ONCE(pn->lruvec_stats->state_local[i]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -494,6 +502,9 @@ unsigned long lruvec_page_state_local(st
 }
 
 #ifdef CONFIG_MEMCG_V1
+static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+				     enum node_stat_item idx, int val);
+
 void reparent_memcg_lruvec_state_local(struct mem_cgroup *memcg,
 				       struct mem_cgroup *parent, int idx)
 {
@@ -506,12 +517,10 @@ void reparent_memcg_lruvec_state_local(s
 	for_each_node(nid) {
 		struct lruvec *child_lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(nid));
 		struct lruvec *parent_lruvec = mem_cgroup_lruvec(parent, NODE_DATA(nid));
-		struct mem_cgroup_per_node *parent_pn;
 		unsigned long value = lruvec_page_state_local(child_lruvec, idx);
 
-		parent_pn = container_of(parent_lruvec, struct mem_cgroup_per_node, lruvec);
-
-		atomic_long_add(value, &(parent_pn->lruvec_stats->state_local[i]));
+		__mod_memcg_lruvec_state(child_lruvec, idx, -value);
+		__mod_memcg_lruvec_state(parent_lruvec, idx, value);
 	}
 }
 #endif
@@ -598,7 +607,7 @@ struct memcg_vmstats {
 	unsigned long		events[NR_MEMCG_EVENTS];
 
 	/* Non-hierarchical (CPU aggregated) page state & events */
-	atomic_long_t		state_local[MEMCG_VMSTAT_SIZE];
+	long			state_local[MEMCG_VMSTAT_SIZE];
 	unsigned long		events_local[NR_MEMCG_EVENTS];
 
 	/* Pending child counts during tree propagation */
@@ -835,7 +844,7 @@ unsigned long memcg_page_state_local(str
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return 0;
 
-	x = atomic_long_read(&(memcg->vmstats->state_local[i]));
+	x = READ_ONCE(memcg->vmstats->state_local[i]);
 #ifdef CONFIG_SMP
 	if (x < 0)
 		x = 0;
@@ -843,6 +852,51 @@ unsigned long memcg_page_state_local(str
 	return x;
 }
 
+static void __mod_memcg_state(struct mem_cgroup *memcg,
+			      enum memcg_stat_item idx, int val)
+{
+	int i = memcg_stats_index(idx);
+	int cpu;
+
+	if (mem_cgroup_disabled())
+		return;
+
+	cpu = get_cpu();
+
+	this_cpu_add(memcg->vmstats_percpu->state[i], val);
+	val = memcg_state_val_in_pages(idx, val);
+	memcg_rstat_updated(memcg, val, cpu);
+	trace_mod_memcg_state(memcg, idx, val);
+
+	put_cpu();
+}
+
+static void __mod_memcg_lruvec_state(struct lruvec *lruvec,
+				     enum node_stat_item idx, int val)
+{
+	struct mem_cgroup_per_node *pn;
+	struct mem_cgroup *memcg;
+	int i = memcg_stats_index(idx);
+	int cpu;
+
+	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
+	memcg = pn->memcg;
+
+	cpu = get_cpu();
+
+	/* Update memcg */
+	this_cpu_add(memcg->vmstats_percpu->state[i], val);
+
+	/* Update lruvec */
+	this_cpu_add(pn->lruvec_stats_percpu->state[i], val);
+
+	val = memcg_state_val_in_pages(idx, val);
+	memcg_rstat_updated(memcg, val, cpu);
+	trace_mod_memcg_lruvec_state(memcg, idx, val);
+
+	put_cpu();
+}
+
 void reparent_memcg_state_local(struct mem_cgroup *memcg,
 				struct mem_cgroup *parent, int idx)
 {
@@ -852,7 +906,8 @@ void reparent_memcg_state_local(struct m
 	if (WARN_ONCE(BAD_STAT_IDX(i), "%s: missing stat item %d\n", __func__, idx))
 		return;
 
-	atomic_long_add(value, &(parent->vmstats->state_local[i]));
+	__mod_memcg_state(memcg, idx, -value);
+	__mod_memcg_state(parent, idx, value);
 }
 #endif
 
@@ -4174,8 +4229,6 @@ struct aggregate_control {
 	long *aggregate;
 	/* pointer to the non-hierarchichal (CPU aggregated) counters */
 	long *local;
-	/* pointer to the atomic non-hierarchichal (CPU aggregated) counters */
-	atomic_long_t *alocal;
 	/* pointer to the pending child counters during tree propagation */
 	long *pending;
 	/* pointer to the parent's pending counters, could be NULL */
@@ -4213,12 +4266,8 @@ static void mem_cgroup_stat_aggregate(st
 		}
 
 		/* Aggregate counts on this level and propagate upwards */
-		if (delta_cpu) {
-			if (ac->local)
-				ac->local[i] += delta_cpu;
-			else if (ac->alocal)
-				atomic_long_add(delta_cpu, &(ac->alocal[i]));
-		}
+		if (delta_cpu)
+			ac->local[i] += delta_cpu;
 
 		if (delta) {
 			ac->aggregate[i] += delta;
@@ -4289,8 +4338,7 @@ static void mem_cgroup_css_rstat_flush(s
 
 	ac = (struct aggregate_control) {
 		.aggregate = memcg->vmstats->state,
-		.local = NULL,
-		.alocal = memcg->vmstats->state_local,
+		.local = memcg->vmstats->state_local,
 		.pending = memcg->vmstats->state_pending,
 		.ppending = parent ? parent->vmstats->state_pending : NULL,
 		.cstat = statc->state,
@@ -4323,8 +4371,7 @@ static void mem_cgroup_css_rstat_flush(s
 
 		ac = (struct aggregate_control) {
 			.aggregate = lstats->state,
-			.local = NULL,
-			.alocal = lstats->state_local,
+			.local = lstats->state_local,
 			.pending = lstats->state_pending,
 			.ppending = plstats ? plstats->state_pending : NULL,
 			.cstat = lstatc->state,
--- a/mm/memcontrol-v1.h~mm-memcontrol-prepare-for-reparenting-non-hierarchical-stats-update
+++ a/mm/memcontrol-v1.h
@@ -45,7 +45,6 @@ static inline bool do_memsw_account(void
 
 unsigned long memcg_events_local(struct mem_cgroup *memcg, int event);
 unsigned long memcg_page_state_local(struct mem_cgroup *memcg, int idx);
-void mod_memcg_page_state_local(struct mem_cgroup *memcg, int idx, unsigned long val);
 unsigned long memcg_page_state_local_output(struct mem_cgroup *memcg, int item);
 bool memcg1_alloc_events(struct mem_cgroup *memcg);
 void memcg1_free_events(struct mem_cgroup *memcg);
_


