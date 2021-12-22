Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D271947D123
	for <lists+cgroups@lfdr.de>; Wed, 22 Dec 2021 12:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbhLVLlW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Dec 2021 06:41:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhLVLlU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Dec 2021 06:41:20 -0500
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640173279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yft2/5r6EVO3JzmEvsALpkpwi74bPqzdoozMCIubZx8=;
        b=pOw5kNMyB6XOy/Unv2vaRj6VI4mttvzxO0ZoEyRZOtsTemnrZgXe9y7ZE3o4GNGm6M6CFT
        4hJPSSc9fuLikRDCqaKhIDUyhZ525Ilz03qUWZ9cJbj6qcjhhvEXiUYmvfLEDMp+S/JNg+
        fWxwUJ5qhQeRpFNJoI08/t5n5QiS07gQMhfIM6t5bDhSPu1LVWod50QYiDv5FSRyhrS6B8
        jsrGKULY+w0LXb2FrDUIWGmJSjoT6Gt3vXQl5YM6LHhz09mEBy5QSwOa3ZhpV7jf/zhx2K
        DMXGwfqIS/XgffBiVSDMtJtcoCxsoXnr72IWW4jAyn1pgjoEZD5eDGygiOIHJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640173279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yft2/5r6EVO3JzmEvsALpkpwi74bPqzdoozMCIubZx8=;
        b=c4hUYgLkfCPKlFS+LQNaZv/FhIkIEekHgNpFhxGBE1Km2sbcdHUb1LddZQgBqWswMVzMMa
        8v/q3Ez2h2/szKCg==
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC PATCH 1/3] mm/memcg: Protect per-CPU counter by disabling preemption on PREEMPT_RT
Date:   Wed, 22 Dec 2021 12:41:09 +0100
Message-Id: <20211222114111.2206248-2-bigeasy@linutronix.de>
In-Reply-To: <20211222114111.2206248-1-bigeasy@linutronix.de>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

The per-CPU counter are modified with the non-atomic modifier. The
consistency is ensure by disabling interrupts for the update.
This breaks on PREEMPT_RT because some sections additionally
acquire a spinlock_t lock (which becomes sleeping and must not be
acquired with disabled interrupts). Another problem is that
mem_cgroup_swapout() expects to be invoked with disabled interrupts
because the caller has to acquire a spinlock_t which is acquired with
disabled interrupts. Since spinlock_t never disables interrupts on
PREEMPT_RT the interrupts are never disabled at this point.

The code is never called from in_irq() context on PREEMPT_RT therefore
disabling preemption during the update is sufficient on PREEMPT_RT. The
sections with disabled preemption must exclude memcg_check_events() so
that spinlock_t locks can still be acquired (for instance in
eventfd_signal()).

Don't disable interrupts during updates of the per-CPU variables,
instead use shorter sections which disable preemption.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/memcontrol.c | 74 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 14 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2ed5f2a0879d3..d2687d5ed544b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -671,8 +671,14 @@ void __mod_memcg_state(struct mem_cgroup *memcg, int i=
dx, int val)
 	if (mem_cgroup_disabled())
 		return;
=20
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 	memcg_rstat_updated(memcg);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
=20
 /* idx can be of type enum memcg_stat_item or node_stat_item. */
@@ -699,6 +705,9 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 	pn =3D container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg =3D pn->memcg;
=20
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
=20
@@ -706,6 +715,9 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, en=
um node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
=20
 	memcg_rstat_updated(memcg);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
=20
 /**
@@ -788,8 +800,13 @@ void __count_memcg_events(struct mem_cgroup *memcg, en=
um vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
=20
+	if (IS_ENABLED(PREEMPT_RT))
+		preempt_disable();
+
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
 	memcg_rstat_updated(memcg);
+	if (IS_ENABLED(PREEMPT_RT))
+		preempt_enable();
 }
=20
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -810,6 +827,9 @@ static unsigned long memcg_events_local(struct mem_cgro=
up *memcg, int event)
 static void mem_cgroup_charge_statistics(struct mem_cgroup *memcg,
 					 int nr_pages)
 {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
+
 	/* pagein of a big page is an event. So, ignore page size */
 	if (nr_pages > 0)
 		__count_memcg_events(memcg, PGPGIN, 1);
@@ -819,12 +839,19 @@ static void mem_cgroup_charge_statistics(struct mem_c=
group *memcg,
 	}
=20
 	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
 }
=20
 static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
 				       enum mem_cgroup_events_target target)
 {
 	unsigned long val, next;
+	bool ret =3D false;
+
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_disable();
=20
 	val =3D __this_cpu_read(memcg->vmstats_percpu->nr_page_events);
 	next =3D __this_cpu_read(memcg->vmstats_percpu->targets[target]);
@@ -841,9 +868,11 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgro=
up *memcg,
 			break;
 		}
 		__this_cpu_write(memcg->vmstats_percpu->targets[target], next);
-		return true;
+		ret =3D true;
 	}
-	return false;
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		preempt_enable();
+	return ret;
 }
=20
 /*
@@ -5645,12 +5674,14 @@ static int mem_cgroup_move_account(struct page *pag=
e,
 	ret =3D 0;
 	nid =3D folio_nid(folio);
=20
-	local_irq_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	mem_cgroup_charge_statistics(to, nr_pages);
 	memcg_check_events(to, nid);
 	mem_cgroup_charge_statistics(from, -nr_pages);
 	memcg_check_events(from, nid);
-	local_irq_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 out_unlock:
 	folio_unlock(folio);
 out:
@@ -6670,10 +6701,12 @@ static int charge_memcg(struct folio *folio, struct=
 mem_cgroup *memcg,
 	css_get(&memcg->css);
 	commit_charge(folio, memcg);
=20
-	local_irq_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(folio));
-	local_irq_enable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
 out:
 	return ret;
 }
@@ -6785,11 +6818,20 @@ static void uncharge_batch(const struct uncharge_ga=
ther *ug)
 		memcg_oom_recover(ug->memcg);
 	}
=20
-	local_irq_save(flags);
-	__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
-	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
-	memcg_check_events(ug->memcg, ug->nid);
-	local_irq_restore(flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		local_irq_save(flags);
+		__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
+		__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+		memcg_check_events(ug->memcg, ug->nid);
+		local_irq_restore(flags);
+	} else {
+		preempt_disable();
+		__count_memcg_events(ug->memcg, PGPGOUT, ug->pgpgout);
+		__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_memory);
+		preempt_enable();
+
+		memcg_check_events(ug->memcg, ug->nid);
+	}
=20
 	/* drop reference from uncharge_folio */
 	css_put(&ug->memcg->css);
@@ -6930,10 +6972,12 @@ void mem_cgroup_migrate(struct folio *old, struct f=
olio *new)
 	css_get(&memcg->css);
 	commit_charge(new, memcg);
=20
-	local_irq_save(flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_save(flags);
 	mem_cgroup_charge_statistics(memcg, nr_pages);
 	memcg_check_events(memcg, folio_nid(new));
-	local_irq_restore(flags);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_restore(flags);
 }
=20
 DEFINE_STATIC_KEY_FALSE(memcg_sockets_enabled_key);
@@ -7157,8 +7201,10 @@ void mem_cgroup_swapout(struct page *page, swp_entry=
_t entry)
 	 * i_pages lock which is taken with interrupts-off. It is
 	 * important here to have the interrupts disabled because it is the
 	 * only synchronisation we have for updating the per-CPU variables.
+	 * On PREEMPT_RT interrupts are never disabled and the updates to per-CPU
+	 * variables are synchronised by keeping preemption disabled.
 	 */
-	VM_BUG_ON(!irqs_disabled());
+	VM_BUG_ON(!IS_ENABLED(CONFIG_PREEMPT_RT) && !irqs_disabled());
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
 	memcg_check_events(memcg, page_to_nid(page));
=20
--=20
2.34.1

