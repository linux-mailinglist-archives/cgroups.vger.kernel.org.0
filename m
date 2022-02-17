Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6E4B9C68
	for <lists+cgroups@lfdr.de>; Thu, 17 Feb 2022 10:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiBQJs0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 17 Feb 2022 04:48:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbiBQJsX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 17 Feb 2022 04:48:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732917060
        for <cgroups@vger.kernel.org>; Thu, 17 Feb 2022 01:48:09 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645091288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wI7PoqknI8hRH7tFrgvMNOkROXfGQbU72P/Xt0XNbhU=;
        b=4SDwHoLm3k4A54BR7OKuHB8prdpOKrYlJbubqWciPa9wLyo+xKVs5YcpniU+wgqXnVpC7W
        sJgBy/WdXlsQPn1gCMxAOsF6qeXDl+1J7qh42iv11z8+oZDZsS/BJQmi+QqodBK54+G/zP
        V1fjpDq7aHUsmDq8i+m5JaotL8OjLqPcQhiaX8RkkNAZvX68gbI8Ja10WksENxiXdSxPEP
        5G3Qvffdz0aOIRmC1wtxHuP+m2M9i8IpZBXfK0KuUQUw4QYGc14Gqia1st0DwEz2gP/q0g
        0jG+6BdN3c2QrQfIoLDVgWF3PTneqoTBvblRJAvL6uVI3P2V6HOGcZ2AOKveAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645091288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wI7PoqknI8hRH7tFrgvMNOkROXfGQbU72P/Xt0XNbhU=;
        b=2Miowt8Bh+315xArP7XQYRiOo05jb/fVb0aKUzHxqz2fVT7ed7bir51cIky2t1uNZ7gp2E
        NwHCXg48qk3ODTBA==
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
Subject: [PATCH v3 3/5] mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT where needed.
Date:   Thu, 17 Feb 2022 10:48:00 +0100
Message-Id: <20220217094802.3644569-4-bigeasy@linutronix.de>
In-Reply-To: <20220217094802.3644569-1-bigeasy@linutronix.de>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
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
 mm/memcontrol.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 0b5117ed2ae08..36ab3660f2c6d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -630,6 +630,28 @@ static DEFINE_SPINLOCK(stats_flush_lock);
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
@@ -706,6 +728,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 	pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg =3D pn->memcg;
=20
+	memcg_stats_lock();
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
=20
@@ -713,6 +736,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
=20
 	memcg_rstat_updated(memcg, val);
+	memcg_stats_unlock();
 }
=20
 /**
@@ -795,8 +819,10 @@ void __count_memcg_events(struct mem_cgroup *memcg, en=
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
@@ -7140,8 +7166,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_=
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
2.34.1

