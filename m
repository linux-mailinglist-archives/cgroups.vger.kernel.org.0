Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4549A4C6453
	for <lists+cgroups@lfdr.de>; Mon, 28 Feb 2022 09:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiB1IHe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 28 Feb 2022 03:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiB1IHd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 28 Feb 2022 03:07:33 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C453E2F
        for <cgroups@vger.kernel.org>; Mon, 28 Feb 2022 00:06:55 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B7CF31F39E;
        Mon, 28 Feb 2022 08:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646035613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3e5pxvpLCEcNYRbknllT9dfKsoRIPJKJgji4WAezrw=;
        b=uqULMjeXpnVQ6MLq6+1Y3XOnxog2c0obIGXkPzz20XDVZibdc00i1eATYjIN+Zwper32rV
        Sn56BMN0t/Q1PjH4QsMlqCKyE3bPA0jesAm7LrQtSkJjQtTzz8A3fi6XaUfn7x0QL5vqBB
        RmHWUiovhIOJxPeMKl7BjnpHDZdl4E4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7C8DBA3B84;
        Mon, 28 Feb 2022 08:06:53 +0000 (UTC)
Date:   Mon, 28 Feb 2022 09:06:53 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v5 5/6] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <YhyCnQmyiTBUcJuR@dhcp22.suse.cz>
References: <20220226204144.1008339-1-bigeasy@linutronix.de>
 <20220226204144.1008339-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226204144.1008339-6-bigeasy@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 26-02-22 21:41:43, Sebastian Andrzej Siewior wrote:
> The members of the per-CPU structure memcg_stock_pcp are protected by
> disabling interrupts. This is not working on PREEMPT_RT because it
> creates atomic context in which actions are performed which require
> preemptible context. One example is obj_cgroup_release().
> 
> The IRQ-disable sections can be replaced with local_lock_t which
> preserves the explicit disabling of interrupts while keeps the code
> preemptible on PREEMPT_RT.
> 
> drain_obj_stock() drops a reference on obj_cgroup which leads to an invocation
> of obj_cgroup_release() if it is the last object. This in turn leads to
> recursive locking of the local_lock_t. To avoid this, obj_cgroup_release() is
> invoked outside of the locked section.
> 
> obj_cgroup_uncharge_pages() can be invoked with the local_lock_t acquired and
> without it. This will lead later to a recursion in refill_stock(). To
> avoid the locking recursion provide obj_cgroup_uncharge_pages_locked()
> which uses the locked version of refill_stock().
> 
> - Replace disabling interrupts for memcg_stock with a local_lock_t.
> 
> - Let drain_obj_stock() return the old struct obj_cgroup which is passed
>   to obj_cgroup_put() outside of the locked section.
> 
> - Provide obj_cgroup_uncharge_pages_locked() which uses the locked
>   version of refill_stock() to avoid recursive locking in
>   drain_obj_stock().
> 
> Link: https://lkml.kernel.org/r/20220209014709.GA26885@xsang-OptiPlex-9020
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I thought I have already acked this one. Anyway
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 59 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 4d049b4691afd..6439b0089d392 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2135,6 +2135,7 @@ void unlock_page_memcg(struct page *page)
>  }
>  
>  struct memcg_stock_pcp {
> +	local_lock_t stock_lock;
>  	struct mem_cgroup *cached; /* this never be root cgroup */
>  	unsigned int nr_pages;
>  
> @@ -2150,18 +2151,21 @@ struct memcg_stock_pcp {
>  	unsigned long flags;
>  #define FLUSHING_CACHED_CHARGE	0
>  };
> -static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> +static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
> +	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
> +};
>  static DEFINE_MUTEX(percpu_charge_mutex);
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -static void drain_obj_stock(struct memcg_stock_pcp *stock);
> +static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock);
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  				     struct mem_cgroup *root_memcg);
>  static void memcg_account_kmem(struct mem_cgroup *memcg, int nr_pages);
>  
>  #else
> -static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
> +static inline struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>  {
> +	return NULL;
>  }
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  				     struct mem_cgroup *root_memcg)
> @@ -2193,7 +2197,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  	if (nr_pages > MEMCG_CHARGE_BATCH)
>  		return ret;
>  
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
> @@ -2201,7 +2205,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  		ret = true;
>  	}
>  
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>  
>  	return ret;
>  }
> @@ -2230,6 +2234,7 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>  static void drain_local_stock(struct work_struct *dummy)
>  {
>  	struct memcg_stock_pcp *stock;
> +	struct obj_cgroup *old = NULL;
>  	unsigned long flags;
>  
>  	/*
> @@ -2237,14 +2242,16 @@ static void drain_local_stock(struct work_struct *dummy)
>  	 * drain_stock races is that we always operate on local CPU stock
>  	 * here with IRQ disabled
>  	 */
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> -	drain_obj_stock(stock);
> +	old = drain_obj_stock(stock);
>  	drain_stock(stock);
>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>  
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	if (old)
> +		obj_cgroup_put(old);
>  }
>  
>  /*
> @@ -2271,9 +2278,9 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>  {
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  	__refill_stock(memcg, nr_pages);
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>  }
>  
>  /*
> @@ -3100,10 +3107,11 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  		     enum node_stat_item idx, int nr)
>  {
>  	struct memcg_stock_pcp *stock;
> +	struct obj_cgroup *old = NULL;
>  	unsigned long flags;
>  	int *bytes;
>  
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  	stock = this_cpu_ptr(&memcg_stock);
>  
>  	/*
> @@ -3112,7 +3120,7 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  	 * changes.
>  	 */
>  	if (stock->cached_objcg != objcg) {
> -		drain_obj_stock(stock);
> +		old = drain_obj_stock(stock);
>  		obj_cgroup_get(objcg);
>  		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
>  				? atomic_xchg(&objcg->nr_charged_bytes, 0) : 0;
> @@ -3156,7 +3164,9 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  	if (nr)
>  		mod_objcg_mlstate(objcg, pgdat, idx, nr);
>  
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	if (old)
> +		obj_cgroup_put(old);
>  }
>  
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> @@ -3165,7 +3175,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  	unsigned long flags;
>  	bool ret = false;
>  
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
> @@ -3173,17 +3183,17 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  		ret = true;
>  	}
>  
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>  
>  	return ret;
>  }
>  
> -static void drain_obj_stock(struct memcg_stock_pcp *stock)
> +static struct obj_cgroup *drain_obj_stock(struct memcg_stock_pcp *stock)
>  {
>  	struct obj_cgroup *old = stock->cached_objcg;
>  
>  	if (!old)
> -		return;
> +		return NULL;
>  
>  	if (stock->nr_bytes) {
>  		unsigned int nr_pages = stock->nr_bytes >> PAGE_SHIFT;
> @@ -3233,8 +3243,12 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		stock->cached_pgdat = NULL;
>  	}
>  
> -	obj_cgroup_put(old);
>  	stock->cached_objcg = NULL;
> +	/*
> +	 * The `old' objects needs to be released by the caller via
> +	 * obj_cgroup_put() outside of memcg_stock_pcp::stock_lock.
> +	 */
> +	return old;
>  }
>  
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> @@ -3255,14 +3269,15 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  			     bool allow_uncharge)
>  {
>  	struct memcg_stock_pcp *stock;
> +	struct obj_cgroup *old = NULL;
>  	unsigned long flags;
>  	unsigned int nr_pages = 0;
>  
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (stock->cached_objcg != objcg) { /* reset if necessary */
> -		drain_obj_stock(stock);
> +		old = drain_obj_stock(stock);
>  		obj_cgroup_get(objcg);
>  		stock->cached_objcg = objcg;
>  		stock->nr_bytes = atomic_read(&objcg->nr_charged_bytes)
> @@ -3276,7 +3291,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes,
>  		stock->nr_bytes &= (PAGE_SIZE - 1);
>  	}
>  
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
> +	if (old)
> +		obj_cgroup_put(old);
>  
>  	if (nr_pages)
>  		obj_cgroup_uncharge_pages(objcg, nr_pages);
> -- 
> 2.35.1

-- 
Michal Hocko
SUSE Labs
