Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E792361178
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 19:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhDORxz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 15 Apr 2021 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhDORxy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 15 Apr 2021 13:53:54 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE274C061756
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 10:53:29 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id er3so3618954qvb.6
        for <cgroups@vger.kernel.org>; Thu, 15 Apr 2021 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=INGh5k1Yj8szNl1l5Z8qYaD8P6YvvcJTSCldK0t4pLE=;
        b=q+VO14PGTuNSIxED5tGGeUakeYctoqOQ0nJkbh0Vvp7quHEzTPE5abUN2YsdznM5oi
         mXTFT434TbT7mysw7yWGazDjFqRq+YmsxrjpomEQAuHY96tmqCLoZt7lqa4LSklgrn9e
         uRS8Dp45ihliK04vKKPAdld1KQQ8qm+2NHe3vYYeu4UyWirtudNSFErs29T78GJ5CPjs
         wWwqc/PKCWJfxwTi5zqIU7TqrW6iJZcOQST2Om59t0knllllekcuN9GVeodH7qf/zBjG
         vlkhN+abb/sMuFNbNaCiRCTNmyGsiuzKUuCtDMAtF/1y4UXWAHmF0/mC0tMCBJ0rIwiC
         psKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INGh5k1Yj8szNl1l5Z8qYaD8P6YvvcJTSCldK0t4pLE=;
        b=R5o0jWF4y9uRt4H01Zsl4GZ3zOXnNTo0lXvI6sOWfNHKzj+ii5Sosl0n+BUmza+nn6
         0keNEaPUe6qzaev203vKh/swMBSbO/xn98iVC5wwytc9ne1kX6hsaCadxDpPLFg0HZYw
         kZTfZVnFpIhhIojmmcQt1dJspJiugBE+9Lq8UgLcsgVvAIgaoGhPXUxDpz+W7hskrLZ0
         fzhhl0O1DCRmkSoUCnHyJqt/q/rGuI1w0A5xMI8pWGRulEDpBYbSQe9h72Q7QX14QQ1h
         XQQyg9M3JO+YLooCCkmq8yIQ7f2YAHixDkPa9teYR776BgiQS/eOODN5x+Pskb5zC63n
         lXrg==
X-Gm-Message-State: AOAM533LvVlsuGZJVjE2DBuXEBs/q+1tlXoEn/8bEabJdYh7y8gByl+q
        c6v5A42HS/FadlY2rIk6MFBrZA==
X-Google-Smtp-Source: ABdhPJzo+DulslHHMeIPKQfo+X00FLdIMTkZOLHNkCdxeB60C8i7fQG8oyQ9R9/2zBJktP2rCdoqbw==
X-Received: by 2002:a0c:e2c5:: with SMTP id t5mr4255809qvl.27.1618509209056;
        Thu, 15 Apr 2021 10:53:29 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id a11sm2470206qkn.12.2021.04.15.10.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 10:53:28 -0700 (PDT)
Date:   Thu, 15 Apr 2021 13:53:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
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
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Optimize user context object stock
 access
Message-ID: <YHh9l1+TUIzzFBtO@cmpxchg.org>
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

This makes sense, and also explains the previous patch a bit
better. But please merge those two.

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

Please make them both functions and use 'unsigned long *flags'.

Also I'm not sure doing in_task() twice would actually be more
expensive than the == -1 special case, and easier to understand.

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

This is actually a bug introduced in the earlier patch, isn't it?
Calling __mod_memcg_lruvec_state() without irqs disabled...
