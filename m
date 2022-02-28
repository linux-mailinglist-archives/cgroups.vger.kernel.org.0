Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F162E4C644E
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 09:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiB1IG0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 03:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiB1IG0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 03:06:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8D53E1C
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 00:05:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 79CE9212B9;
        Mon, 28 Feb 2022 08:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646035546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CJjGxGd7NICkj5b0VAQYPCrTSysai2RJYd5eFJEnd78=;
        b=tuU/U3Gl9PZdvqweWp8cOFKJlXkNf9e90mjY+OOr1Bc8dLF/W2/aELwz4HPXBpbWbwN48O
        9Zx1qMK2Meb54IludRz7QplC7YyqlA8aQtsM4Clwrp3Cbg4JZTF2kRmXo8bPUuEz1p4O6U
        aDkpYdlvUVq9pHqT8mcTl7MkNV2VHcQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 48925A3B85;
        Mon, 28 Feb 2022 08:05:46 +0000 (UTC)
Date:   Mon, 28 Feb 2022 09:05:45 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v5 3/6] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Message-ID: <YhyCWQYL8vxRSLrd@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-4-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226204144.1008339-4-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 26-02-22 21:41:41, Sebastian Andrzej Siewior wrote:
> The per-CPU counter are modified with the non-atomic modifier. The
> consistency is ensured by disabling interrupts for the update.
> On non PREEMPT_RT configuration this works because acquiring a
> spinlock_t typed lock with the _irq() suffix disables interrupts. On
> PREEMPT_RT configurations the RMW operation can be interrupted.
> 
> Another problem is that mem_cgroup_swapout() expects to be invoked with
> disabled interrupts because the caller has to acquire a spinlock_t which
> is acquired with disabled interrupts. Since spinlock_t never disables
> interrupts on PREEMPT_RT the interrupts are never disabled at this
> point.
> 
> The code is never called from in_irq() context on PREEMPT_RT therefore
> disabling preemption during the update is sufficient on PREEMPT_RT.
> The sections which explicitly disable interrupts can remain on
> PREEMPT_RT because the sections remain short and they don't involve
> sleeping locks (memcg_check_events() is doing nothing on PREEMPT_RT).
> 
> Disable preemption during update of the per-CPU variables which do not
> explicitly disable interrupts.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com

Acked-by: Michal Hocko <mhocko@suse.com>

TBH I am not a fan of the counter special casing for the debugging
enabled warnings but I do not feel strong enough to push you trhough an
additional version round.

Thanks!

> ---
>  mm/memcontrol.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 0b5117ed2ae08..238ea77aade5d 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -630,6 +630,35 @@ static DEFINE_SPINLOCK(stats_flush_lock);
>  static DEFINE_PER_CPU(unsigned int, stats_updates);
>  static atomic_t stats_flush_threshold = ATOMIC_INIT(0);
>  
> +/*
> + * Accessors to ensure that preemption is disabled on PREEMPT_RT because it can
> + * not rely on this as part of an acquired spinlock_t lock. These functions are
> + * never used in hardirq context on PREEMPT_RT and therefore disabling preemtion
> + * is sufficient.
> + */
> +static void memcg_stats_lock(void)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +      preempt_disable();
> +#else
> +      VM_BUG_ON(!irqs_disabled());
> +#endif
> +}
> +
> +static void __memcg_stats_lock(void)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +      preempt_disable();
> +#endif
> +}
> +
> +static void memcg_stats_unlock(void)
> +{
> +#ifdef CONFIG_PREEMPT_RT
> +      preempt_enable();
> +#endif
> +}
> +
>  static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
>  {
>  	unsigned int x;
> @@ -706,6 +735,27 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>  	memcg = pn->memcg;
>  
> +	/*
> +	 * The caller from rmap relay on disabled preemption becase they never
> +	 * update their counter from in-interrupt context. For these two
> +	 * counters we check that the update is never performed from an
> +	 * interrupt context while other caller need to have disabled interrupt.
> +	 */
> +	__memcg_stats_lock();
> +	if (IS_ENABLED(CONFIG_DEBUG_VM) && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		switch (idx) {
> +		case NR_ANON_MAPPED:
> +		case NR_FILE_MAPPED:
> +		case NR_ANON_THPS:
> +		case NR_SHMEM_PMDMAPPED:
> +		case NR_FILE_PMDMAPPED:
> +			WARN_ON_ONCE(!in_task());
> +			break;
> +		default:
> +			WARN_ON_ONCE(!irqs_disabled());
> +		}
> +	}
> +
>  	/* Update memcg */
>  	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
>  
> @@ -713,6 +763,7 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
>  
>  	memcg_rstat_updated(memcg, val);
> +	memcg_stats_unlock();
>  }
>  
>  /**
> @@ -795,8 +846,10 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  	if (mem_cgroup_disabled())
>  		return;
>  
> +	memcg_stats_lock();
>  	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
>  	memcg_rstat_updated(memcg, count);
> +	memcg_stats_unlock();
>  }
>  
>  static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
> @@ -7140,8 +7193,9 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	 * important here to have the interrupts disabled because it is the
>  	 * only synchronisation we have for updating the per-CPU variables.
>  	 */
> -	VM_BUG_ON(!irqs_disabled());
> +	memcg_stats_lock();
>  	mem_cgroup_charge_statistics(memcg, -nr_entries);
> +	memcg_stats_unlock();
>  	memcg_check_events(memcg, page_to_nid(page));
>  
>  	css_put(&memcg->css);
> -- 
> 2.35.1

-- 
Michal Hocko
SUSE Labs
