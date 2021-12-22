Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A024B47D125
	for <lists+cgroups@lfdr.de>; Wed, 22 Dec 2021 12:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbhLVLlW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 06:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbhLVLlW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 06:41:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA2CC06173F
        for <cgroups@vger.kernel.org>; Wed, 22 Dec 2021 03:41:21 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640173280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUscNupxAInGNFwdgPxE24F7XsB5NZIGxnYUda6WoJA=;
        b=bcjoPvk55c8sAaoa4q4VH8gB+SPU56a6QMGfWd0AfqBzVu3AeAt8CCDMhe16bhDtBok1UD
        usKttDwFRFWs1/Ezqralb/mLw6YJ0YTfpIGTBz49xbWW9wf5FKPMM3yCKn249Ktxmvk1Sc
        EHv3w9lS0/Hu651QBvj5pAtNn8uZxp0PFHbdmpzDB4zARDrzdsb6r9qhN1v8cpWH0JY9T3
        mDjcgxykAiwCcprtHLugrtzNLyh8kGRZ+2pgh+iSFLHbP9EyFYHZlk6B3QI6F8xuNlaXFc
        K3GwPKRKxAMG4tsqLw7CcAab5ZOJuL9VE7sMvnVlQ4t8tyXs3kVDqAU9Fls7rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640173280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUscNupxAInGNFwdgPxE24F7XsB5NZIGxnYUda6WoJA=;
        b=RucXExCrOFfGkre/X3jLYZdkXqI6Sh25YhnYIuGWSVc208J6vybnoQ1tw2htJE3pia7ZJf
        mpOWiyHmHescuOCQ==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 3/3] mm/memcg: Allow the task_obj optimization only on non-PREEMPTIBLE kernels.
Date:   Wed, 22 Dec 2021 12:41:11 +0100
Message-Id: <20211222114111.2206248-4-bigeasy@linutronix.de>
In-Reply-To: <20211222114111.2206248-1-bigeasy@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
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

Restrict the optimisation to !CONFIG_PREEMPTION kernels.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1e76f26be2c15..92180f1aa9edc 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -2126,7 +2126,7 @@ struct memcg_stock_pcp {
 	local_lock_t stock_lock;
 	struct mem_cgroup *cached; /* this never be root cgroup */
 	unsigned int nr_pages;
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	/* Protects only task_obj */
 	local_lock_t task_obj_lock;
 	struct obj_stock task_obj;
@@ -2139,7 +2139,7 @@ struct memcg_stock_pcp {
 };
 static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) =3D {
 	.stock_lock =3D INIT_LOCAL_LOCK(stock_lock),
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	.task_obj_lock =3D INIT_LOCAL_LOCK(task_obj_lock),
 #endif
 };
@@ -2228,7 +2228,7 @@ static void drain_local_stock(struct work_struct *dum=
my)
 	 * drain_stock races is that we always operate on local CPU stock
 	 * here with IRQ disabled
 	 */
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	local_lock(&memcg_stock.task_obj_lock);
 	old =3D drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
 	local_unlock(&memcg_stock.task_obj_lock);
@@ -2837,7 +2837,7 @@ static inline struct obj_stock *get_obj_stock(unsigne=
d long *pflags,
 {
 	struct memcg_stock_pcp *stock;
=20
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	if (likely(in_task())) {
 		*pflags =3D 0UL;
 		*stock_pcp =3D NULL;
@@ -2855,7 +2855,7 @@ static inline struct obj_stock *get_obj_stock(unsigne=
d long *pflags,
 static inline void put_obj_stock(unsigned long flags,
 				 struct memcg_stock_pcp *stock_pcp)
 {
-#ifndef CONFIG_PREEMPT_RT
+#ifndef CONFIG_PREEMPTION
 	if (likely(!stock_pcp))
 		local_unlock(&memcg_stock.task_obj_lock);
 	else
@@ -3267,7 +3267,7 @@ static bool obj_stock_flush_required(struct memcg_sto=
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

