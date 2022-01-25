Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70EA49B921
	for <lists+cgroups@lfdr.de>; Tue, 25 Jan 2022 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1585930AbiAYQpm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 25 Jan 2022 11:45:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359286AbiAYQnp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 25 Jan 2022 11:43:45 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643129024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9c5aIkenG1kJx7yYAvc5/l4pcRmYkPR3oK3gG7L0IE=;
        b=JV0IxcO6w+adnIgRoA0JhtfDB4D212kDPUNeZHpKJmwVdv/uzmQFSdUrhIsqQxMmFXrMCH
        Ji28kt4Y0UMTL+92+7W5tsxJDeuvtlzj+s5JSrcDTfz1ctNzBcYOepP+r1sT34qXRug3va
        tiNU7C4Aiew1egy8LeJwE5MlfySToHcPd9U9ouB9q1PHnQfkyLq91VPBrY7G6sXZkSen+a
        TLge+adUj5MUe+Svu8nPtad5zVcJITpk3qYN9wQsu8v9s7u4AuXll3r7ItyXO/Lvl/A9Si
        D7S4BFYwT2ROw8Cu3vBhk3EPtNLOdFc446zci0L3lLT18aodfhTKdEmxKfRaMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643129024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9c5aIkenG1kJx7yYAvc5/l4pcRmYkPR3oK3gG7L0IE=;
        b=5haeDRHpxSlrgKIOZULzTpzZfpWwlEjYdyd+4Zih4INVUIXoIrR2uJVrCKxJ78j1g0qaVB
        hcPFFt1t8ho+rvAw==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] mm/memcg: Allow the task_obj optimization only on non-PREEMPTIBLE kernels.
Date:   Tue, 25 Jan 2022 17:43:37 +0100
Message-Id: <20220125164337.2071854-5-bigeasy@linutronix.de>
In-Reply-To: <20220125164337.2071854-1-bigeasy@linutronix.de>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Based on my understanding the optimisation with task_obj for in_task()
mask sense on non-PREEMPTIBLE kernels because preempt_disable()/enable()
is optimized away. This could be then restricted to !CONFIG_PREEMPTION kern=
el
instead to only PREEMPT_RT.
With CONFIG_PREEMPT_DYNAMIC a non-PREEMPTIBLE kernel can also be
configured but these kernels always have preempt_disable()/enable()
present so it probably makes no sense here for the optimisation.

I did a micro benchmark with disabled interrupts and a loop of
100.000.000 invokcations of kfree(kmalloc()). Based on the results it
makes no sense to add an exception based on dynamic preemption.

Restrict the optimisation to !CONFIG_PREEMPTION kernels.

Link: https://lore.kernel.org/all/YdX+INO9gQje6d0S@linutronix.de
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2d8be88c00888..20ea8f28ad99b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2030,7 +2030,7 @@ struct memcg_stock_pcp {
 	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	/* Protects only task_obj */
 	local_lock_t task_obj_lock;
 	struct obj_stock task_obj;
@@ -2043,7 +2043,7 @@ struct memcg_stock_pcp {
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) =3D {
 	.stock_lock =3D INIT_LOCAL_LOCK(stock_lock),
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	.task_obj_lock =3D INIT_LOCAL_LOCK(task_obj_lock),
 #endif
 };
@@ -2132,7 +2132,7 @@ static void drain_local_stock(struct work_struct *dum=
my)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	local_lock(&memcg_stock.task_obj_lock);
 	old =3D drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
 	local_unlock(&memcg_stock.task_obj_lock);
@@ -2741,7 +2741,7 @@ static inline struct obj_stock *get_obj_stock(unsigne=
d long *pflags,
 {
 	struct memcg_stock_pcp *stock;
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	if (likely(in_task())) {
 		*pflags =3D 0UL;
 		*stock_lock_acquried =3D false;
@@ -2759,7 +2759,7 @@ static inline struct obj_stock *get_obj_stock(unsigne=
d long *pflags,
 static inline void put_obj_stock(unsigned long flags,
 				 bool stock_lock_acquried)
 {
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	if (likely(!stock_lock_acquried)) {
 		local_unlock(&memcg_stock.task_obj_lock);
 		return;
@@ -3177,7 +3177,7 @@ static bool obj_stock_flush_required(struct memcg_sto=
ck_pcp *stock,
 {
 	struct mem_cgroup *memcg;
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	if (in_task() && stock->task_obj.cached_objcg) {
 		memcg =3D obj_cgroup_memcg(stock->task_obj.cached_objcg);
 		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
--=20
2.34.1

