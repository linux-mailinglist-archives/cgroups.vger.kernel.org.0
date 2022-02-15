Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F044B7874
	for <lists+cgroups@lfdr.de>; Tue, 15 Feb 2022 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiBOSBU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 15 Feb 2022 13:01:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiBOSBS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 15 Feb 2022 13:01:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C8A10660A
        for <cgroups@vger.kernel.org>; Tue, 15 Feb 2022 10:01:06 -0800 (PST)
Date:   Tue, 15 Feb 2022 19:01:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644948063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q51LtZ2w/96ITqPXE16sCnoUk2TYcGVB7Ha6CRaE3C4=;
        b=e/8WehrcariZC3ulS2jIlDHBgj49qR4qabiVUXjKm1eLXzcuNQQd3ZqOWGMIGqadwJk338
        vTQ9YMSeFmQWo03dsxB7raczJiFSWfuPLljmkbLnskBFL4wGayG6mCQOVTEbZNSTn4NJXu
        KclurHNMc6sQi7G7HJ+dM2LcosMpCjNP9w0pByUvXnF02T0wtY8JwI17KHLJNsJTK7fQ5Z
        GjljbJ3Oz3fjkn/8Zi1CZtQsBcwPTOZcyvNkfdHShZa/qcaZkdBjAbW+rnijcMBxF1zbzm
        AWaPm/JIXRwMr2sEdD6OWZdAlZ8/GDoBaITGnwdXCnCjJKefW2waFOOxZdzhug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644948063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q51LtZ2w/96ITqPXE16sCnoUk2TYcGVB7Ha6CRaE3C4=;
        b=WVM3mcP/CXCZ3b7ewDccoCOtQP6a4TAwiW0zeHLt1cN+Eki3oGaX9STQ/9KMq8dYRDUu7o
        u5ViBf7OrQneS4DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v2 3/4] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YgvqXqya2Aoo93/y@linutronix.de>
References: <20220211223537.2175879-1-bigeasy@linutronix.de>
 <20220211223537.2175879-4-bigeasy@linutronix.de>
 <YgqHSIa/WvJSXERe@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YgqHSIa/WvJSXERe@cmpxchg.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-14 11:46:00 [-0500], Johannes Weiner wrote:
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c1caa662946dc..466466f285cea 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -705,6 +705,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> >  	memcg = pn->memcg;
> >  
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		preempt_disable();
> >  	/* Update memcg */
> >  	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
> >  
> > @@ -712,6 +714,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >  	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
> >  
> >  	memcg_rstat_updated(memcg, val);
> > +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> > +		preempt_enable();
> >  }
> 
> I notice you didn't annoate __mod_memcg_state(). I suppose that is
> because it's called with explicit local_irq_disable(), and that
> disables preemption on rt? And you only need another preempt_disable()
> for stacks that rely on coming from spin_lock_irq(save)?

Correct. The code is not used in_hardirq() on PREEMPT_RT so
preempt_disable() is sufficient. I didn't bother to replace all
local_irq_save() with preempt_disable() since it is probably not worth
it.
And yes: spin_lock_irq() does not disable interrupts so I need something
here to ensure that the RMW operation is not interrupted.

> That makes sense, but it's difficult to maintain. It'll easily break
> if somebody adds more memory accounting sites that may also rely on an
> irq-disabled spinlock somewhere.
> 
> So better to make this an unconditional locking protocol:
> 
> static void memcg_stats_lock(void)
> {
> #ifdef CONFIG_PREEMPT_RT
> 	preempt_disable();
> #else
> 	VM_BUG_ON(!irqs_disabled());
> #endif
> }
> 
> static void memcg_stats_unlock(void)
> {
> #ifdef CONFIG_PREEMPT_RT
> 	preempt_enable();
> #endif
> }
> 
> and always use these around the counter updates.

Something like the following perhaps? I didn't add anything to
__mod_memcg_state() since it has no users besides the one which does
local_irq_save().

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index c1caa662946dc..69130a5fe3d51 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -629,6 +629,28 @@ static DEFINE_SPINLOCK(stats_flush_lock);
 static DEFINE_PER_CPU(unsigned int, stats_updates);
 static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
 
+/*
+ * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
+ * not rely on this as part of an acquired spinlock_t lock. These functions are
+ * never used in hardirq context on PREEMPT_RT and therefore disabling preemtion
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
@@ -705,6 +727,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
 	memcg = pn->memcg;
 
+	memcg_stats_lock();
 	/* Update memcg */
 	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
 
@@ -712,6 +735,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
 	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
 
 	memcg_rstat_updated(memcg, val);
+	memcg_stats_unlock();
 }
 
 /**
@@ -794,8 +818,10 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
 	if (mem_cgroup_disabled())
 		return;
 
+	memcg_stats_lock();
 	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
 	memcg_rstat_updated(memcg, count);
+	memcg_stats_unlock();
 }
 
 static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
@@ -7149,8 +7175,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
 	 * important here to have the interrupts disabled because it is the
 	 * only synchronisation we have for updating the per-CPU variables.
 	 */
-	VM_BUG_ON(!irqs_disabled());
+	memcg_stats_lock();
 	mem_cgroup_charge_statistics(memcg, -nr_entries);
+	memcg_stats_unlock();
 	memcg_check_events(memcg, page_to_nid(page));
 
 	css_put(&memcg->css);
-- 
2.34.1

