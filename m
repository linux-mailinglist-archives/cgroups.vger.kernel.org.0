Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479E547E929
	for <lists+cgroups@lfdr.de>; Thu, 23 Dec 2021 22:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350381AbhLWVil (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 23 Dec 2021 16:38:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350360AbhLWVil (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 23 Dec 2021 16:38:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640295520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mIiB2tmCLCxm5/agd9wee1S6uhwF711lKE9ChgbcsDw=;
        b=hXcxrR0I8MEnLl+bQW0aw5D9lpy54pRrUUuXSJQNIbBXf6mARq++uHMk6+xx5Hid7khmv+
        Uvaj4zrZ+JBVVAh22GyNUS0gmjOLwVnl8kKTRakti3Tu0ksgYfDWlFiIz1+Id56+oMc7nw
        PmEaRCViE4pVu9azywpeKCMHSDDDMSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-QTTKjd8PO3GFXfFZ5aGdug-1; Thu, 23 Dec 2021 16:38:39 -0500
X-MC-Unique: QTTKjd8PO3GFXfFZ5aGdug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C18611006AA4;
        Thu, 23 Dec 2021 21:38:37 +0000 (UTC)
Received: from [10.22.16.147] (unknown [10.22.16.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FA825F92A;
        Thu, 23 Dec 2021 21:38:36 +0000 (UTC)
Message-ID: <4fe30c89-df34-bbdb-a9a1-5519e0363cc5@redhat.com>
Date:   Thu, 23 Dec 2021 16:38:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC PATCH 2/3] mm/memcg: Add a local_lock_t for IRQ and TASK
 object.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20211222114111.2206248-1-bigeasy@linutronix.de>
 <20211222114111.2206248-3-bigeasy@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211222114111.2206248-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/22/21 06:41, Sebastian Andrzej Siewior wrote:
> The members of the per-CPU structure memcg_stock_pcp are protected
> either by disabling interrupts or by disabling preemption if the
> invocation occurred in process context.
> Disabling interrupts protects most of the structure excluding task_obj
> while disabling preemption protects only task_obj.
> This schema is incompatible with PREEMPT_RT because it creates atomic
> context in which actions are performed which require preemptible
> context. One example is obj_cgroup_release().
>
> The IRQ-disable and preempt-disable sections can be replaced with
> local_lock_t which preserves the explicit disabling of interrupts while
> keeps the code preemptible on PREEMPT_RT.
>
> The task_obj has been added for performance reason on non-preemptible
> kernels where preempt_disable() is a NOP. On the PREEMPT_RT preemption
> model preempt_disable() is always implemented. Also there are no memory
> allocations in_irq() context and softirqs are processed in (preemptible)
> process context. Therefore it makes sense to avoid using task_obj.
>
> Don't use task_obj on PREEMPT_RT and replace manual disabling of
> interrupts with a local_lock_t. This change requires some factoring:
>
> - drain_obj_stock() drops a reference on obj_cgroup which leads to an
>    invocation of obj_cgroup_release() if it is the last object. This in
>    turn leads to recursive locking of the local_lock_t. To avoid this,
>    obj_cgroup_release() is invoked outside of the locked section.
>
> - drain_obj_stock() gets a memcg_stock_pcp passed if the stock_lock has been
>    acquired (instead of the task_obj_lock) to avoid recursive locking later
>    in refill_stock().
>
> - drain_all_stock() disables preemption via get_cpu() and then invokes
>    drain_local_stock() if it is the local CPU to avoid scheduling a worker
>    (which invokes the same function). Disabling preemption here is
>    problematic due to the sleeping locks in drain_local_stock().
>    This can be avoided by always scheduling a worker, even for the local
>    CPU. Using cpus_read_lock() stabilizes cpu_online_mask which ensures
>    that no worker is scheduled for an offline CPU. Since there is no
>    flush_work(), it is still possible that a worker is invoked on the wrong
>    CPU but it is okay since it operates always on the local-CPU data.
>
> - drain_local_stock() is always invoked as a worker so it can be optimized
>    by removing in_task() (it is always true) and avoiding the "irq_save"
>    variant because interrupts are always enabled here. Operating on
>    task_obj first allows to acquire the lock_lock_t without lockdep
>    complains.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>   mm/memcontrol.c | 171 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 112 insertions(+), 59 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d2687d5ed544b..1e76f26be2c15 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -261,8 +261,10 @@ bool mem_cgroup_kmem_disabled(void)
>   	return cgroup_memory_nokmem;
>   }
>   
> +struct memcg_stock_pcp;
>   static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
> -				      unsigned int nr_pages);
> +				      unsigned int nr_pages,
> +				      struct memcg_stock_pcp *stock_pcp);

AFAICS, stock_pcp is set to indicate that the stock_lock has been 
acquired. Since stock_pcp, if set, should be the same as 
this_cpu_ptr(&memcg_stock), it is a bit confusing to pass it to a 
function that also does a percpu access to memcg_stock. Why don't you 
just pass a boolean, say, stock_locked to indicate this instead. It will 
be more clear and less confusing.


>   
>   static void obj_cgroup_release(struct percpu_ref *ref)
>   {
> @@ -296,7 +298,7 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>   	nr_pages = nr_bytes >> PAGE_SHIFT;
>   
>   	if (nr_pages)
> -		obj_cgroup_uncharge_pages(objcg, nr_pages);
> +		obj_cgroup_uncharge_pages(objcg, nr_pages, NULL);
>   
>   	spin_lock_irqsave(&css_set_lock, flags);
>   	list_del(&objcg->list);
> @@ -2120,26 +2122,40 @@ struct obj_stock {
>   };
>   
>   struct memcg_stock_pcp {
> +	/* Protects memcg_stock_pcp */
> +	local_lock_t stock_lock;
>   	struct mem_cgroup *cached; /* this never be root cgroup */
>   	unsigned int nr_pages;
> +#ifndef CONFIG_PREEMPT_RT
> +	/* Protects only task_obj */
> +	local_lock_t task_obj_lock;
>   	struct obj_stock task_obj;
> +#endif
>   	struct obj_stock irq_obj;
>   
>   	struct work_struct work;
>   	unsigned long flags;
>   #define FLUSHING_CACHED_CHARGE	0
>   };
> -static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
> +static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock) = {
> +	.stock_lock = INIT_LOCAL_LOCK(stock_lock),
> +#ifndef CONFIG_PREEMPT_RT
> +	.task_obj_lock = INIT_LOCAL_LOCK(task_obj_lock),
> +#endif
> +};
>   static DEFINE_MUTEX(percpu_charge_mutex);
>   
>   #ifdef CONFIG_MEMCG_KMEM
> -static void drain_obj_stock(struct obj_stock *stock);
> +static struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
> +					  struct memcg_stock_pcp *stock_pcp);
>   static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>   				     struct mem_cgroup *root_memcg);
>   
>   #else
> -static inline void drain_obj_stock(struct obj_stock *stock)
> +static inline struct obj_cgroup *drain_obj_stock(struct obj_stock *stock,
> +						 struct memcg_stock_pcp *stock_pcp)
>   {
> +	return NULL;
>   }
>   static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>   				     struct mem_cgroup *root_memcg)
> @@ -2168,7 +2184,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   	if (nr_pages > MEMCG_CHARGE_BATCH)
>   		return ret;
>   
> -	local_irq_save(flags);
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
>   
>   	stock = this_cpu_ptr(&memcg_stock);
>   	if (memcg == stock->cached && stock->nr_pages >= nr_pages) {
> @@ -2176,7 +2192,7 @@ static bool consume_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   		ret = true;
>   	}
>   
> -	local_irq_restore(flags);
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>   
>   	return ret;
>   }
> @@ -2204,38 +2220,43 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>   
>   static void drain_local_stock(struct work_struct *dummy)
>   {
> -	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
> +	struct memcg_stock_pcp *stock_pcp;
> +	struct obj_cgroup *old;
>   
>   	/*
>   	 * The only protection from cpu hotplug (memcg_hotplug_cpu_dead) vs.
>   	 * drain_stock races is that we always operate on local CPU stock
>   	 * here with IRQ disabled
>   	 */
> -	local_irq_save(flags);
> +#ifndef CONFIG_PREEMPT_RT
> +	local_lock(&memcg_stock.task_obj_lock);
> +	old = drain_obj_stock(&this_cpu_ptr(&memcg_stock)->task_obj, NULL);
> +	local_unlock(&memcg_stock.task_obj_lock);
> +	if (old)
> +		obj_cgroup_put(old);
> +#endif
>   
> -	stock = this_cpu_ptr(&memcg_stock);
> -	drain_obj_stock(&stock->irq_obj);
> -	if (in_task())
> -		drain_obj_stock(&stock->task_obj);
> -	drain_stock(stock);
> -	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> +	local_lock_irq(&memcg_stock.stock_lock);
> +	stock_pcp = this_cpu_ptr(&memcg_stock);
> +	old = drain_obj_stock(&stock_pcp->irq_obj, stock_pcp);
>   
> -	local_irq_restore(flags);
> +	drain_stock(stock_pcp);
> +	clear_bit(FLUSHING_CACHED_CHARGE, &stock_pcp->flags);
> +
> +	local_unlock_irq(&memcg_stock.stock_lock);
> +	if (old)
> +		obj_cgroup_put(old);
>   }
>   
>   /*
>    * Cache charges(val) to local per_cpu area.
>    * This will be consumed by consume_stock() function, later.
>    */
> -static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> +static void __refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> +			   struct memcg_stock_pcp *stock)
>   {
> -	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
> +	lockdep_assert_held(&stock->stock_lock);
>   
> -	local_irq_save(flags);
> -
> -	stock = this_cpu_ptr(&memcg_stock);
>   	if (stock->cached != memcg) { /* reset if necessary */
>   		drain_stock(stock);
>   		css_get(&memcg->css);
> @@ -2245,8 +2266,20 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>   
>   	if (stock->nr_pages > MEMCG_CHARGE_BATCH)
>   		drain_stock(stock);
> +}
>   
> -	local_irq_restore(flags);
> +static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages,
> +			 struct memcg_stock_pcp *stock_pcp)
> +{
> +	unsigned long flags;
> +
> +	if (stock_pcp) {
> +		__refill_stock(memcg, nr_pages, stock_pcp);
> +		return;
> +	}
> +	local_lock_irqsave(&memcg_stock.stock_lock, flags);
> +	__refill_stock(memcg, nr_pages, this_cpu_ptr(&memcg_stock));
> +	local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>   }
>   
>   /*
> @@ -2255,7 +2288,7 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
>    */
>   static void drain_all_stock(struct mem_cgroup *root_memcg)
>   {
> -	int cpu, curcpu;
> +	int cpu;
>   
>   	/* If someone's already draining, avoid adding running more workers. */
>   	if (!mutex_trylock(&percpu_charge_mutex))
> @@ -2266,7 +2299,7 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>   	 * as well as workers from this path always operate on the local
>   	 * per-cpu data. CPU up doesn't touch memcg_stock at all.
>   	 */
> -	curcpu = get_cpu();
> +	cpus_read_lock();
>   	for_each_online_cpu(cpu) {
>   		struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
>   		struct mem_cgroup *memcg;
> @@ -2282,14 +2315,10 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
>   		rcu_read_unlock();
>   
>   		if (flush &&
> -		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> -			if (cpu == curcpu)
> -				drain_local_stock(&stock->work);
> -			else
> -				schedule_work_on(cpu, &stock->work);
> -		}
> +		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
> +			schedule_work_on(cpu, &stock->work);
>   	}
> -	put_cpu();
> +	cpus_read_unlock();
>   	mutex_unlock(&percpu_charge_mutex);
>   }
>   
> @@ -2690,7 +2719,7 @@ static int try_charge_memcg(struct mem_cgroup *memcg, gfp_t gfp_mask,
>   
>   done_restock:
>   	if (batch > nr_pages)
> -		refill_stock(memcg, batch - nr_pages);
> +		refill_stock(memcg, batch - nr_pages, NULL);
>   
>   	/*
>   	 * If the hierarchy is above the normal consumption range, schedule
> @@ -2803,28 +2832,35 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>    * can only be accessed after disabling interrupt. User context code can
>    * access interrupt object stock, but not vice versa.
>    */
> -static inline struct obj_stock *get_obj_stock(unsigned long *pflags)
> +static inline struct obj_stock *get_obj_stock(unsigned long *pflags,
> +					      struct memcg_stock_pcp **stock_pcp)
>   {
>   	struct memcg_stock_pcp *stock;
>   
> +#ifndef CONFIG_PREEMPT_RT
>   	if (likely(in_task())) {
>   		*pflags = 0UL;
> -		preempt_disable();
> +		*stock_pcp = NULL;
> +		local_lock(&memcg_stock.task_obj_lock);
>   		stock = this_cpu_ptr(&memcg_stock);
>   		return &stock->task_obj;
>   	}
> -
> -	local_irq_save(*pflags);
> +#endif
> +	local_lock_irqsave(&memcg_stock.stock_lock, *pflags);
>   	stock = this_cpu_ptr(&memcg_stock);
> +	*stock_pcp = stock;
>   	return &stock->irq_obj;
>   }
>   
> -static inline void put_obj_stock(unsigned long flags)
> +static inline void put_obj_stock(unsigned long flags,
> +				 struct memcg_stock_pcp *stock_pcp)
>   {
> -	if (likely(in_task()))
> -		preempt_enable();
> +#ifndef CONFIG_PREEMPT_RT
> +	if (likely(!stock_pcp))
> +		local_unlock(&memcg_stock.task_obj_lock);
>   	else
> -		local_irq_restore(flags);
If you skip the "else" and add a "return", there will be a more natural 
indentation for the following lock_unlock_irqrestore(). Also we may not 
really need the additional stock_pcp argument here.
> +#endif
> +		local_unlock_irqrestore(&memcg_stock.stock_lock, flags);
>   }
Cheers,
Longman

