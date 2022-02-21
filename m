Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A984BEAD0
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 20:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiBUS1j (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 13:27:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiBUS0e (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 13:26:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E19104
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 10:26:09 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645467968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhIX9mEl0Y4GS1fqt77hXQzHnJzFniwXtr6Zzcbhm14=;
        b=y4ZjMoft3dUhg82VAyCXNnj4TUZ8/YT4rIi1eWuuosk3W7zj2Kj4bgYKTGp/W8K0Yat08y
        pwnTsutmbVr/TWsV4xTF4xnXkWDcdMQuKXMvc33FH2IjPiBPhy/+6br+sgzDL6okcsAMzZ
        qCzq/sTz0acGvxXDNFNht+X8Ghmcz/dCTQZEOczc0tK7ACVBA7CulETbWIxu3bBacchn5o
        QoAV5WA6qgjFqDWU50aA/emoNs5XY9lAowOzzlutRAJvb41Mov+8PGkisQn/ifrdWmFkkx
        rLwoty/fNx1t/H7mNqjDzQJ6nFMH1T9J5psVx4xGLPgKKY0GprMgwrw8S+hVxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645467968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HhIX9mEl0Y4GS1fqt77hXQzHnJzFniwXtr6Zzcbhm14=;
        b=fCu9+uWm1Uoey+0RgETsmgRjbNz/TCaNKY45VgG105E+5NS2o8FuWVA6NLYWyA86l4gXqK
        cN7QZ41H/hO+R7CA==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 3/6] mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT where needed.
Date:   Mon, 21 Feb 2022 19:25:37 +0100
Message-Id: <20220221182540.380526-4-bigeasy@linutronix.de>
In-Reply-To: <20220221182540.380526-1-bigeasy@linutronix.de>
References: <20220221182540.380526-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The per-CPU counter are modified with the non-atomic modifier. The
consistency is ensured by disabling interrupts for the update.
On non PREEMPT_RT configuration this works because acquiring a
spinlock_t typed lock with the _irq() suffix disables interrupts. On
PREEMPT_RT configurations the RMW operation can be interrupted.

Another problem is that mem_cgroup_swapout() expects to be invoked with
disabled interrupts because the caller has to acquire a spinlock_t which
is acquired with disabled interrupts. Since spinlock_t never disables
interrupts on PREEMPT_RT the interrupts are never disabled at this
point.

The code is never called from in_irq() context on PREEMPT_RT therefore
disabling preemption during the update is sufficient on PREEMPT_RT.
The sections which explicitly disable interrupts can remain on
PREEMPT_RT because the sections remain short and they don't involve
sleeping locks (memcg_check_events() is doing nothing on PREEMPT_RT).

Disable preemption during update of the per-CPU variables which do not
explicitly disable interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Roman Gushchin <guro@fb.com>
---
 mm/memcontrol.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b5117ed2ae08..28174c099aa1f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -630,6 +630,35 @@ static DEFINE_SPINLOCK(stats_flush_lock);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_threshold =3D ATOMIC_INIT(0);
=20
+/*
+ * Accessors to ensure that preemption is disabled on PREEMPT_RT because i=
t can
+ * not rely on this as part of an acquired spinlock_t lock. These function=
s are
+ * never used in hardirq context on PREEMPT_RT and therefore disabling pre=
emtion
+ * is sufficient.
+ */
+static void memcg_stats_lock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+      preempt_disable();
+#else
+      VM_BUG_ON(!irqs_disabled());
+#endif
+}
+
+static void __memcg_stats_lock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+      preempt_disable();
+#endif
+}
+
+static void memcg_stats_unlock(void)
+{
+#ifdef CONFIG_PREEMPT_RT
+      preempt_enable();
+#endif
+}
+
 static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
@@ -706,6 +735,20 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, e=
num node_stat_item idx,
 	pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg =3D pn->memcg;
=20
+	/*
+	 * The caller from rmap relay on disabled preemption becase they never
+	 * update their counter from in-interrupt context. For these two
+	 * counters we check that the update is never performed from an
+	 * interrupt context while other caller need to have disabled interrupt.
+	 */
+	__memcg_stats_lock();
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+		if (idx =3D=3D NR_ANON_MAPPED || idx =3D=3D NR_FILE_MAPPED)
+			WARN_ON_ONCE(!in_task());
+		else
+			WARN_ON_ONCE(!irqs_disabled());
+	}
+
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
=20
@@ -713,6 +756,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
=20
 	memcg_rstat_updated(memcg, val);
+	memcg_stats_unlock();
 }
=20
 /**
@@ -795,8 +839,10 @@ void __count_memcg_events(struct mem_cgroup *memcg, en=
um vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
=20
+	memcg_stats_lock();
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
 	memcg_rstat_updated(memcg, count);
+	memcg_stats_unlock();
 }
=20
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -7140,8 +7186,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_=
t entry)
 	 * important here to have the interrupts disabled because it is the
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
-	VM_BUG_ON(!irqs_disabled());
+	memcg_stats_lock();
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
+	memcg_stats_unlock();
 	memcg_check_events(memcg, page_to_nid(page));
=20
 	css_put(&memcg->css);
--=20
2.35.1

