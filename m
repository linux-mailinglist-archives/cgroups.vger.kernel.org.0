Return-Path: <cgroups+bounces-8635-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C430AEAAC0
	for <lists+cgroups@lfdr.de>; Fri, 27 Jun 2025 01:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D9E3A4614
	for <lists+cgroups@lfdr.de>; Thu, 26 Jun 2025 23:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E1F225785;
	Thu, 26 Jun 2025 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xlm/+sHJ"
X-Original-To: cgroups@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC4221FB8
	for <cgroups@vger.kernel.org>; Thu, 26 Jun 2025 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981123; cv=none; b=q3Z+s4j7qkxEFMyVDEBWoYafT4y6Id/Du+QKoHvTipYobBUl2lxQ96O6a7xrW96qBbOKz1731BfbP0Lh3tUke9Wy2PLJp9HwbnmB9FrBE/LOB81W7l9xZ3dE8BbE6pA5QCj+Bm6fv7KdZpduOk85pJ4uJRlkHxsJ479t+z9WjOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981123; c=relaxed/simple;
	bh=IHkXWKg1D5MCQg9GrBN5Djp17CQbGWPWj7dvSe0jvts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAGI6xBFAN8LAmpB/ZyMS41ic6rdv8H8VtUOKoYjEBo9FLA07Vk1vpegS3yamUvqjhUCji7lMxzDGn/EODRLdchr7tk1SM50s55alRrzDMOUE13yeLxnb/APi2m5wP1nu/gsyHeDwjBdMBNABeX0qBOQ8hAykyVEd33Yd6o/J/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xlm/+sHJ; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 26 Jun 2025 16:38:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750981109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x+p1GkYHskRpx352iokJ2/ibgcF8JqaS68YqWzxLlIw=;
	b=Xlm/+sHJ9a9AvjfJxvljezL9tKVFP6Hw7NIxfinr8LnTmmjWSVV0Lmf5HOIoclE4Y0QD0Q
	95G06zuBU+BPZInr+tIAOEQpETahHM0iwa71DHp5wUuoxB/PzjQeZ7pyZSNRIS91f6I1zR
	J4ctzmswx4CBctLkhdeHLeneRGyqEh4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Tejun Heo <tj@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, JP Kobryn <inwardvessel@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Ying Huang <huang.ying.caritas@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Alexei Starovoitov <ast@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	bpf@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] llist: add [READ|WRITE]_ONCE tags for llist_node
Message-ID: <fyyks2xnzytr5hybzxeb4srrmrr64dxacwrcjd7v7anttjdy3s@hgp2s2th2t5m>
References: <20250626190550.4170599-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626190550.4170599-1-shakeel.butt@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 26, 2025 at 12:05:50PM -0700, Shakeel Butt wrote:
> Before the commit 36df6e3dbd7e ("cgroup: make css_rstat_updated nmi
> safe"), the struct llist_node is expected to be private to the one
> inserting the node to the lockless list or the one removing the node
> from the lockless list. After the mentioned commit, the llist_node in
> the rstat code is per-cpu shared between the stacked contexts i.e.
> process, softirq, hardirq & nmi.
> 
> KCSAN reported the following race:
> 
>  Reported by Kernel Concurrency Sanitizer on:
>  CPU: 60 UID: 0 PID: 5425 ... 6.16.0-rc3-next-20250626 #1 NONE
>  Tainted: [E]=UNSIGNED_MODULE
>  Hardware name: ...
>  ==================================================================
>  ==================================================================
>  BUG: KCSAN: data-race in css_rstat_flush / css_rstat_updated
>  write to 0xffffe8fffe1c85f0 of 8 bytes by task 1061 on cpu 1:
>   css_rstat_flush+0x1b8/0xeb0
>   __mem_cgroup_flush_stats+0x184/0x190
>   flush_memcg_stats_dwork+0x22/0x50
>   process_one_work+0x335/0x630
>   worker_thread+0x5f1/0x8a0
>   kthread+0x197/0x340
>   ret_from_fork+0xd3/0x110
>   ret_from_fork_asm+0x11/0x20
>  read to 0xffffe8fffe1c85f0 of 8 bytes by task 3551 on cpu 15:
>   css_rstat_updated+0x81/0x180
>   mod_memcg_lruvec_state+0x113/0x2d0
>   __mod_lruvec_state+0x3d/0x50
>   lru_add+0x21e/0x3f0
>   folio_batch_move_lru+0x80/0x1b0
>   __folio_batch_add_and_move+0xd7/0x160
>   folio_add_lru_vma+0x42/0x50
>   do_anonymous_page+0x892/0xe90
>   __handle_mm_fault+0xfaa/0x1520
>   handle_mm_fault+0xdc/0x350
>   do_user_addr_fault+0x1dc/0x650
>   exc_page_fault+0x5c/0x110
>   asm_exc_page_fault+0x22/0x30
>  value changed: 0xffffe8fffe18e0d0 -> 0xffffe8fffe1c85f0
> 
> $ ./scripts/faddr2line vmlinux css_rstat_flush+0x1b8/0xeb0
> css_rstat_flush+0x1b8/0xeb0:
> init_llist_node at include/linux/llist.h:86
> (inlined by) llist_del_first_init at include/linux/llist.h:308
> (inlined by) css_process_update_tree at kernel/cgroup/rstat.c:148
> (inlined by) css_rstat_updated_list at kernel/cgroup/rstat.c:258
> (inlined by) css_rstat_flush at kernel/cgroup/rstat.c:389
> 
> $ ./scripts/faddr2line vmlinux css_rstat_updated+0x81/0x180
> css_rstat_updated+0x81/0x180:
> css_rstat_updated at kernel/cgroup/rstat.c:90 (discriminator 1)
> 
> These are expected race and a simple READ_ONCE/WRITE_ONCE resolves these
> reports.

Tejun privately communicated that though the race is benign, we should
document it better instead of just silencing kcsan.

More specifically the llist_on_list() check on the update side and the
init_llist_node() reset on the flush side needs to coornidate to
guarantee that either the updater should get false from llist_on_list()
and it adds the node to the lockless list or the flush side get the
updated stats from concurrent updaters.

To guarantee that, on the update side we need a barrier between stats
update and llist_on_list() check and on the flush side, a barrier in
between init_llist_node() and the actual stats flush.

However do we really need such a guarantee and can we be fine with the
race? Particularly the update side is very performance critical path and
adding a barrier might be very costly. I think this race is benign and
we can just document it and then ignore it.

Tejun, is something like following acceptable? I know you mentioned to
add the barrier on the flush but I am wondering if we are not adding
barrier on the update side, what's the point to add it on the flush
side. Let me know if you still prefer to add the barrier on the flush
side.

diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index c8a48cf83878..02258b43abb3 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -86,8 +86,12 @@ __bpf_kfunc void css_rstat_updated(struct cgroup_subsys_state *css, int cpu)
 		return;
 
 	rstatc = css_rstat_cpu(css, cpu);
-	/* If already on list return. */
-	if (llist_on_list(&rstatc->lnode))
+	/*
+	 * If already on list return.
+	 *
+	 * TODO: add detailed comment on the potential race.
+	 */
+	if (data_race(llist_on_list(&rstatc->lnode)))
 		return;
 
 	/*
@@ -145,9 +149,13 @@ static void css_process_update_tree(struct cgroup_subsys *ss, int cpu)
 	struct llist_head *lhead = ss_lhead_cpu(ss, cpu);
 	struct llist_node *lnode;
 
-	while ((lnode = llist_del_first_init(lhead))) {
+	while ((lnode = data_race(llist_del_first_init(lhead)))) {
 		struct css_rstat_cpu *rstatc;
 
+		/*
+		 * TODO: add detailed comment and maybe smp_mb().
+		 */
+
 		rstatc = container_of(lnode, struct css_rstat_cpu, lnode);
 		__css_process_update_tree(rstatc->owner, cpu);
 	}

