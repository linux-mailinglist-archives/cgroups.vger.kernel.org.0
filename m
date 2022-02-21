Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF76D4BE529
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 19:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356456AbiBULbn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 06:31:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356454AbiBULbn (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 06:31:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525319E
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 03:31:20 -0800 (PST)
Date:   Mon, 21 Feb 2022 12:31:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645443078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RulSMPiCVHplqpEdAg1RSNzopKMgaNgDwROyd5kzhU4=;
        b=ygUsaiTcDR+YlYfCOVWfPbfQf/So/3FCW/1vcZ1r6O/gZ2uUd2cOkrbTYu7EXiVVCRtZB9
        9M5gS95vfitEMWKspuml850mok/MtwaGbTmnGPH4KXpZ//JvGcSHviDSp0eNDzMPY+cgle
        0G/uKP2CehjErGJMA6QkgawDKeQjXz8xuHYr30BOOZVmk1M3Ux4X6cK5nrhWHplRcNBhWz
        xoL0OnZqhIJvgUL/5J0D0ns6PohpEQ0vJS9wpvg941pIglsRnIxYIWNekdXaMM0L75qO29
        HP7MSCOivDHhNpSxDsPBeJJU2z5vxRscUEexNQo2/BjDO7F5CQ8cUxx/PiQD6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645443078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RulSMPiCVHplqpEdAg1RSNzopKMgaNgDwROyd5kzhU4=;
        b=JYXtgNXu15YB09O4e1vbfUTzL3s4Xp30WcFxpRTR4AKtOAYP5bVC0eTdATimWakaj2Wcw0
        op4C0mo+TYJGeKDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v3 3/5] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YhN4BSQ1RLomLoyl@linutronix.de>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-4-bigeasy@linutronix.de>
 <CALvZod4eZWVfibhxu0P0ZQ35cB=vDbde=VNeXiBZfED=k3YPOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALvZod4eZWVfibhxu0P0ZQ35cB=vDbde=VNeXiBZfED=k3YPOQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-18 09:25:29 [-0800], Shakeel Butt wrote:
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 0b5117ed2ae08..36ab3660f2c6d 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -630,6 +630,28 @@ static DEFINE_SPINLOCK(stats_flush_lock);
> >  static DEFINE_PER_CPU(unsigned int, stats_updates);
> >  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
> >
> > +/*
> > + * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
> > + * not rely on this as part of an acquired spinlock_t lock. These functions are
> > + * never used in hardirq context on PREEMPT_RT and therefore disabling preemtion
> > + * is sufficient.
> > + */
> > +static void memcg_stats_lock(void)
> > +{
> > +#ifdef CONFIG_PREEMPT_RT
> > +      preempt_disable();
> > +#else
> > +      VM_BUG_ON(!irqs_disabled());
> > +#endif
> > +}
> > +
> > +static void memcg_stats_unlock(void)
> > +{
> > +#ifdef CONFIG_PREEMPT_RT
> > +      preempt_enable();
> > +#endif
> > +}
> > +
> >  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
> >  {
> >         unsigned int x;
> > @@ -706,6 +728,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> >         pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> >         memcg = pn->memcg;)
> >
> > +       memcg_stats_lock();
> 
> The call chains from rmap.c have not really disabled irqs. Actually
> there is a comment in do_page_add_anon_rmap() "We use the irq-unsafe
> __{inc|mod}_zone_page_stat because these counters are not modified in
> interrupt context, and pte lock(a spinlock) is held, which implies
> preemption disabled".
> 
> VM_BUG_ON(!irqs_disabled()) within memcg_stats_lock() would be giving
> false error reports for CONFIG_PREEMPT_NONE kernels.

So three caller, including do_page_add_anon_rmap():
   __mod_lruvec_page_state() -> __mod_lruvec_state() -> __mod_memcg_lruvec_state()

is affected. Here we get false warnings because interrupts may not be
disabled and it is intended. Hmmm.
The odd part is that this only affects certain idx so any kind of
additional debugging would need to take this into account.
What about memcg_rstat_updated()? It does:

|         x = __this_cpu_add_return(stats_updates, abs(val));
|         if (x > MEMCG_CHARGE_BATCH) {
|                 atomic_add(x / MEMCG_CHARGE_BATCH, &stats_flush_threshold);
|                 __this_cpu_write(stats_updates, 0);
|         }

The writes to stats_updates can happen from IRQ-context and with
disabled preemption only. So this is not good, right?

Sebastian
