Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55583360072
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 05:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhDOD3l (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 23:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhDOD3J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 23:29:09 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C57C06175F;
        Wed, 14 Apr 2021 20:28:39 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x11so23837842qkp.11;
        Wed, 14 Apr 2021 20:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F2io8dn7O8FmTLZrTw9xmH5Unf/0t5bYnV8ofZRQOu8=;
        b=luCkxGj1/kA9pWhPi3bAmmkC+ncXTRic0IUm9qRFx+R0ru5pX/RSyEwVA8YIWfPBJ2
         klLzh7gAvB9puIHNfcG4g5lOHEBWS59V3OiS8nV7sT8z8XAZidChx5W2ACVksDW55fxn
         anNkqrhjaB7kEGMIC/wiAgGhuVarwHehVRjQOGaefeXFeJMwTQUtnp0HUXB5muR8f/MD
         jUFIKdiLUBNaL6PYl0hdfPi/ZjjzDlGRQzThM7Izz8ZB5eNmCyT4SEqyhQknbchHWNi0
         TpntO06EQ/SlTi1ldL6a3cY/ycmniZ02R5vlvopfqoiUUVnXY3AhlXVPI+FBR3tVp1Xx
         W3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2io8dn7O8FmTLZrTw9xmH5Unf/0t5bYnV8ofZRQOu8=;
        b=owWrCC54EeXHSQGWJDuy0qDhaO3aUhxWL8g3E9rfKed0kT877lwNXk6i4fPzgupOKf
         IkQD7kOCyyzskGLQgjHwRKszaofgm6mO6rkeR95sVEhaKQreZrE4IcgzfO/QAUvZJTOC
         bs3LuCfYFiJRLJv7YS/qmwXm+qoUSZyq3gmDytTXdoZXYEzbPZ8GEHHTx7n3HiSGCT1R
         F8f7ijqPVKbRbVQk2WdhsBTUuuQg76VWEM1kYG2s6n6i/XPv+IbIkU44+zxeNSRpOrSc
         47ga3T3G+wfuWVmUebmOcx9fIohkShmqoFByxroz5STLaERFv+PqGCCKOPn4dKaicEkg
         xTTg==
X-Gm-Message-State: AOAM533h3MBmnzC6nOXqKFLQxXzwBoAM4fspyWzL/2YOBSnuLnZsTlB0
        M1gqC8vmQewOYLaMeCrzjg==
X-Google-Smtp-Source: ABdhPJzMfvpYmi7uRRNGWU7BuzMFKUJdnZd4dgkcEO8DxhW1Ub7DpzsTkc52wAqXjBP+gQ8A/fXrXA==
X-Received: by 2002:a37:4553:: with SMTP id s80mr1572435qka.167.1618457318843;
        Wed, 14 Apr 2021 20:28:38 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r189sm1057712qke.56.2021.04.14.20.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 20:28:38 -0700 (PDT)
Date:   Wed, 14 Apr 2021 23:28:36 -0400
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Optimize user context object stock
 access
Message-ID: <20210415032836.lohexqge3cvpsqoa@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-6-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:27PM -0400, Waiman Long wrote:
> Most kmem_cache_alloc() calls are from user context. With instrumentation
> enabled, the measured amount of kmem_cache_alloc() calls from non-task
> context was about 0.01% of the total.
> 
> The irq disable/enable sequence used in this case to access content
> from object stock is slow.  To optimize for user context access, there
> are now two object stocks for task context and interrupt context access
> respectively.
> 
> The task context object stock can be accessed after disabling preemption
> which is cheap in non-preempt kernel. The interrupt context object stock
> can only be accessed after disabling interrupt. User context code can
> access interrupt object stock, but not vice versa.
> 
> The mod_objcg_state() function is also modified to make sure that memcg
> and lruvec stat updates are done with interrupted disabled.
> 
> The downside of this change is that there are more data stored in local
> object stocks and not reflected in the charge counter and the vmstat
> arrays.  However, this is a small price to pay for better performance.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 74 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 59 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69f728383efe..8875e896e52b 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2229,7 +2229,8 @@ struct obj_stock {
>  struct memcg_stock_pcp {
>  	struct mem_cgroup *cached; /* this never be root cgroup */
>  	unsigned int nr_pages;
> -	struct obj_stock obj;
> +	struct obj_stock task_obj;
> +	struct obj_stock irq_obj;
>  
>  	struct work_struct work;
>  	unsigned long flags;
> @@ -2254,11 +2255,48 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  }
>  #endif
>  
> +/*
> + * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
> + * sequence used in this case to access content from object stock is slow.
> + * To optimize for user context access, there are now two object stocks for
> + * task context and interrupt context access respectively.
> + *
> + * The task context object stock can be accessed by disabling preemption only
> + * which is cheap in non-preempt kernel. The interrupt context object stock
> + * can only be accessed after disabling interrupt. User context code can
> + * access interrupt object stock, but not vice versa.
> + */
>  static inline struct obj_stock *current_obj_stock(void)
>  {
>  	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
>  
> -	return &stock->obj;
> +	return in_task() ? &stock->task_obj : &stock->irq_obj;
> +}
> +
> +#define get_obj_stock(flags)				\
> +({							\
> +	struct memcg_stock_pcp *stock;			\
> +	struct obj_stock *obj_stock;			\
> +							\
> +	if (in_task()) {				\
> +		preempt_disable();			\
> +		(flags) = -1L;				\
> +		stock = this_cpu_ptr(&memcg_stock);	\
> +		obj_stock = &stock->task_obj;		\
> +	} else {					\
> +		local_irq_save(flags);			\
> +		stock = this_cpu_ptr(&memcg_stock);	\
> +		obj_stock = &stock->irq_obj;		\
> +	}						\
> +	obj_stock;					\
> +})
> +
> +static inline void put_obj_stock(unsigned long flags)
> +{
> +	if (flags == -1L)
> +		preempt_enable();
> +	else
> +		local_irq_restore(flags);
>  }
>  
>  /**
> @@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
>  	local_irq_save(flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> -	drain_obj_stock(&stock->obj);
> +	drain_obj_stock(&stock->irq_obj);
> +	if (in_task())
> +		drain_obj_stock(&stock->task_obj);
>  	drain_stock(stock);
>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>  
> @@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>  	memcg = obj_cgroup_memcg(objcg);
>  	if (pgdat)
>  		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> +	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>  	rcu_read_unlock();
>  }
>  
> @@ -3193,15 +3233,14 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  	unsigned long flags;
>  	bool ret = false;
>  
> -	local_irq_save(flags);
> +	stock = get_obj_stock(flags);
>  
> -	stock = current_obj_stock();
>  	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
>  		stock->nr_bytes -= nr_bytes;
>  		ret = true;
>  	}
>  
> -	local_irq_restore(flags);
> +	put_obj_stock(flags);
>  
>  	return ret;
>  }
> @@ -3254,8 +3293,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  {
>  	struct mem_cgroup *memcg;
>  
> -	if (stock->obj.cached_objcg) {
> -		memcg = obj_cgroup_memcg(stock->obj.cached_objcg);
> +	if (in_task() && stock->task_obj.cached_objcg) {
> +		memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
> +		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
> +			return true;
> +	}
> +	if (stock->irq_obj.cached_objcg) {
> +		memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
>  		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
>  			return true;
>  	}
> @@ -3283,9 +3327,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	get_obj_stock(flags);
>  	__refill_obj_stock(objcg, nr_bytes);
> -	local_irq_restore(flags);
> +	put_obj_stock(flags);
>  }
>  
>  static void __mod_obj_stock_state(struct obj_cgroup *objcg,
> @@ -3325,9 +3369,9 @@ void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  {
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	get_obj_stock(flags);
>  	__mod_obj_stock_state(objcg, pgdat, idx, nr);
> -	local_irq_restore(flags);
> +	put_obj_stock(flags);
>  }
>  
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> @@ -3380,10 +3424,10 @@ void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
>  {
>  	unsigned long flags;
>  
> -	local_irq_save(flags);
> +	get_obj_stock(flags);
>  	__refill_obj_stock(objcg, size);
>  	__mod_obj_stock_state(objcg, pgdat, idx, -(int)size);
> -	local_irq_restore(flags);
> +	put_obj_stock(flags);
>  }
>  
>  #endif /* CONFIG_MEMCG_KMEM */
> -- 
> 2.18.1
> 

Please feel free to add:

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
