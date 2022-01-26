Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF2049C712
	for <lists+cgroups@lfdr.de>; Wed, 26 Jan 2022 11:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbiAZKGn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jan 2022 05:06:43 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54476 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239581AbiAZKGm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jan 2022 05:06:42 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 097F521114;
        Wed, 26 Jan 2022 10:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643191601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc+O4qBPW4+4JwfdlJrJ12w5z2zicMvaXn+FLH7dtLU=;
        b=oYCqCLE26R94qDsi94Mz/G/MzCDOFnae/JVBIUJ4sXtBAYEIoY8mO7J1qiEXWOZtzS/E59
        SNp0yjpmjs07GPWUQAl7pfONmM6yIZxACcGhc/o5XrJPoqTtmSrCTzJQnl0LEQu1ZougIh
        kMKliB4qsn1scWL1SyKAh1FpEd026eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643191601;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jc+O4qBPW4+4JwfdlJrJ12w5z2zicMvaXn+FLH7dtLU=;
        b=3ic1Mlo3OCYFX6fQFinK+6IqJVVKfeMGKjIwLrTDrXXxal7uPGptvmCDw6OAdRa0E/Q+z0
        faTM2IqzxKN94ZAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD4FC13B8A;
        Wed, 26 Jan 2022 10:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SM9VMTAd8WH1XwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 26 Jan 2022 10:06:40 +0000
Message-ID: <86eeed07-b7dc-b387-ea4d-1a4a41334fe3@suse.cz>
Date:   Wed, 26 Jan 2022 11:06:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/4] mm/memcg: Protect per-CPU counter by disabling
 preemption on PREEMPT_RT where needed.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
References: <20220125164337.2071854-1-bigeasy@linutronix.de>
 <20220125164337.2071854-3-bigeasy@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220125164337.2071854-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 1/25/22 17:43, Sebastian Andrzej Siewior wrote:
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

So it's like c68ed7945701 ("mm/vmstat: protect per cpu variables with
preempt disable on RT") but we still don't want a wrapper of those
constructs so they don't spread further, right :)

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/memcontrol.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 36d27db673ca9..3d1b7cdd83db0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -667,6 +667,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
>  	memcg = pn->memcg;
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_disable();
>  	/* Update memcg */
>  	__this_cpu_add(memcg->vmstats_percpu->state[idx], val);
>  
> @@ -674,6 +676,8 @@ void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  	__this_cpu_add(pn->lruvec_stats_percpu->state[idx], val);
>  
>  	memcg_rstat_updated(memcg, val);
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		preempt_enable();
>  }
>  
>  /**
> @@ -756,8 +760,12 @@ void __count_memcg_events(struct mem_cgroup *memcg, enum vm_event_item idx,
>  	if (mem_cgroup_disabled())
>  		return;
>  
> +	if (IS_ENABLED(PREEMPT_RT))
> +		preempt_disable();
>  	__this_cpu_add(memcg->vmstats_percpu->events[idx], count);
>  	memcg_rstat_updated(memcg, count);
> +	if (IS_ENABLED(PREEMPT_RT))
> +		preempt_enable();
>  }
>  
>  static unsigned long memcg_events(struct mem_cgroup *memcg, int event)
> @@ -7194,9 +7202,18 @@ void mem_cgroup_swapout(struct page *page, swp_entry_t entry)
>  	 * i_pages lock which is taken with interrupts-off. It is
>  	 * important here to have the interrupts disabled because it is the
>  	 * only synchronisation we have for updating the per-CPU variables.
> +	 * On PREEMPT_RT interrupts are never disabled and the updates to per-CPU
> +	 * variables are synchronised by keeping preemption disabled.
>  	 */
> -	VM_BUG_ON(!irqs_disabled());
> -	mem_cgroup_charge_statistics(memcg, -nr_entries);
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		VM_BUG_ON(!irqs_disabled());
> +		mem_cgroup_charge_statistics(memcg, -nr_entries);
> +	} else {
> +		preempt_disable();
> +		mem_cgroup_charge_statistics(memcg, -nr_entries);
> +		preempt_enable();
> +	}
> +
>  	memcg_check_events(memcg, page_to_nid(page));
>  
>  	css_put(&memcg->css);

