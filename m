Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C321136485E
	for <lists+cgroups@lfdr.de>; Mon, 19 Apr 2021 18:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhDSQjB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Apr 2021 12:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhDSQjA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Apr 2021 12:39:00 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7FBC061761
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 09:38:29 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id o2so13126505qtr.4
        for <cgroups@vger.kernel.org>; Mon, 19 Apr 2021 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vpCqSo1bi/Itljn0ARQBAE88SdcDOq4CLh+u6Q1ryxk=;
        b=U/sz0/KTAjVUZKU3ywblEqS+Xfp7IcXV20jwhosV0NhrBK3OLhAEz3ZxHF6YkzX2s5
         SLXvchft5Wow+756f0u3h9h1ovxymMTNqN09gzC7FMXeZ/RBj13ZWfXItLyWZAYWD2qt
         FXbF6BnRW/P8WyVHirhaHvhRGLDPUFpKj36Qs12Ug3/UaW9w0y2CfQ2NbKPa+KjQYVtW
         AXkyuJMsyoOLXhgXL+1OknkZ/wQJy/L+tSQn/XSUVXULwS7qn2ui7ZqRQKNA35oz4NM3
         Fr3KahNRnWKD6FRQLlQKD+Gt0C7IV8uTn+VsMoL0uran9OHtkyFSZ4GEsQ5BwK1a3SEL
         rqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vpCqSo1bi/Itljn0ARQBAE88SdcDOq4CLh+u6Q1ryxk=;
        b=DM+vXRnePOk2PVvFlYgbY8iTolkNj1y9+g6t1e+kuBzZIkFlh6QkZiYU8d4WqCtHXA
         I1edHBFoAzlISaY3wKibqD6s13EJTW2bDGUBjHgqRLksxCh4lr2/1BYMm+h9p1NiFMkg
         TVscOon++5f3FupdwFt/P49qHCrwYDEZzpnAFrcQu54pApCCOMICQT8aJZwrjCp+T+kl
         s8+KO3QfTi3T+GC3pz3axfWRlw/6B78VMdma5Jcevm0DVeApMXGy+1+Wli4WY9PSCCEn
         2Yd2QzEqMR4sRg7lHNcO/o4wylTO6P64hY/s203seqoOR/gLGxZb+osO7OH9BBft3N+8
         rZMQ==
X-Gm-Message-State: AOAM530g0v+h2UQF22CMGUhLwtU1cYFgYjvYOxBTZvQTOrHMxO8SVMhV
        8VpojtowKSG79wCVXKDesv+Wow==
X-Google-Smtp-Source: ABdhPJzb3uL7lMp8OSB1SKoU6Hb7bhiEV+btM2N//ZOVJ7VHEgyfXj+WLMpYxhiXniSItifgCTM9xw==
X-Received: by 2002:ac8:7cb9:: with SMTP id z25mr4226302qtv.361.1618850308559;
        Mon, 19 Apr 2021 09:38:28 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id w67sm10252775qkc.79.2021.04.19.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 09:38:27 -0700 (PDT)
Date:   Mon, 19 Apr 2021 12:38:27 -0400
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
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 2/5] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
Message-ID: <YH2yA1oZoyQoMhAH@cmpxchg.org>
References: <20210419000032.5432-1-longman@redhat.com>
 <20210419000032.5432-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419000032.5432-3-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sun, Apr 18, 2021 at 08:00:29PM -0400, Waiman Long wrote:
> Before the new slab memory controller with per object byte charging,
> charging and vmstat data update happen only when new slab pages are
> allocated or freed. Now they are done with every kmem_cache_alloc()
> and kmem_cache_free(). This causes additional overhead for workloads
> that generate a lot of alloc and free calls.
> 
> The memcg_stock_pcp is used to cache byte charge for a specific
> obj_cgroup to reduce that overhead. To further reducing it, this patch
> makes the vmstat data cached in the memcg_stock_pcp structure as well
> until it accumulates a page size worth of update or when other cached
> data change. Caching the vmstat data in the per-cpu stock eliminates two
> writes to non-hot cachelines for memcg specific as well as memcg-lruvecs
> specific vmstat data by a write to a hot local stock cacheline.
> 
> On a 2-socket Cascade Lake server with instrumentation enabled and this
> patch applied, it was found that about 20% (634400 out of 3243830)
> of the time when mod_objcg_state() is called leads to an actual call
> to __mod_objcg_state() after initial boot. When doing parallel kernel
> build, the figure was about 17% (24329265 out of 142512465). So caching
> the vmstat data reduces the number of calls to __mod_objcg_state()
> by more than 80%.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index dc9032f28f2e..693453f95d99 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2213,7 +2213,10 @@ struct memcg_stock_pcp {
>  
>  #ifdef CONFIG_MEMCG_KMEM
>  	struct obj_cgroup *cached_objcg;
> +	struct pglist_data *cached_pgdat;
>  	unsigned int nr_bytes;
> +	int vmstat_idx;
> +	int vmstat_bytes;
>  #endif
>  
>  	struct work_struct work;
> @@ -3150,8 +3153,9 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	css_put(&memcg->css);
>  }
>  
> -void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> -		     enum node_stat_item idx, int nr)
> +static inline void __mod_objcg_state(struct obj_cgroup *objcg,
> +				     struct pglist_data *pgdat,
> +				     enum node_stat_item idx, int nr)

This naming is dangerous, as the __mod_foo naming scheme we use
everywhere else suggests it's the same function as mod_foo() just with
preemption/irqs disabled.

> @@ -3159,10 +3163,53 @@ void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	mod_memcg_lruvec_state(lruvec, idx, nr);
> +	__mod_memcg_lruvec_state(lruvec, idx, nr);
>  	rcu_read_unlock();
>  }
>  
> +void mod_objcg_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +		     enum node_stat_item idx, int nr)
> +{
> +	struct memcg_stock_pcp *stock;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	stock = this_cpu_ptr(&memcg_stock);
> +
> +	/*
> +	 * Save vmstat data in stock and skip vmstat array update unless
> +	 * accumulating over a page of vmstat data or when pgdat or idx
> +	 * changes.
> +	 */
> +	if (stock->cached_objcg != objcg) {
> +		/* Output the current data as is */

When you get here with the wrong objcg and hit the cold path, it's
usually immediately followed by an uncharge -> refill_obj_stock() that
will then flush and reset cached_objcg.

Instead of doing two cold paths, why not flush the old objcg right
away and set the new so that refill_obj_stock() can use the fast path?

> +	} else if (!stock->vmstat_bytes) {
> +		/* Save the current data */
> +		stock->vmstat_bytes = nr;
> +		stock->vmstat_idx = idx;
> +		stock->cached_pgdat = pgdat;
> +		nr = 0;
> +	} else if ((stock->cached_pgdat != pgdat) ||
> +		   (stock->vmstat_idx != idx)) {
> +		/* Output the cached data & save the current data */
> +		swap(nr, stock->vmstat_bytes);
> +		swap(idx, stock->vmstat_idx);
> +		swap(pgdat, stock->cached_pgdat);

Is this optimization worth doing?

You later split vmstat_bytes and idx doesn't change anymore.

How often does the pgdat change? This is a per-cpu cache after all,
and the numa node a given cpu allocates from tends to not change that
often. Even with interleaving mode, which I think is pretty rare, the
interleaving happens at the slab/page level, not the object level, and
the cache isn't bigger than a page anyway.

> +	} else {
> +		stock->vmstat_bytes += nr;
> +		if (abs(stock->vmstat_bytes) > PAGE_SIZE) {
> +			nr = stock->vmstat_bytes;
> +			stock->vmstat_bytes = 0;
> +		} else {
> +			nr = 0;
> +		}

..and this is the regular overflow handling done by the objcg and
memcg charge stock as well.

How about this?

	if (stock->cached_objcg != objcg ||
	    stock->cached_pgdat != pgdat ||
	    stock->vmstat_idx != idx) {
		drain_obj_stock(stock);
		obj_cgroup_get(objcg);
		stock->cached_objcg = objcg;
		stock->nr_bytes = atomic_xchg(&objcg->nr_charged_bytes, 0);
		stock->vmstat_idx = idx;
	}
	stock->vmstat_bytes += nr_bytes;

	if (abs(stock->vmstat_bytes > PAGE_SIZE))
		drain_obj_stock(stock);

(Maybe we could be clever, here since the charge and stat caches are
the same size: don't flush an oversized charge cache from
refill_obj_stock in the charge path, but leave it to the
mod_objcg_state() that follows; likewise don't flush an undersized
vmstat stock from mod_objcg_state() in the uncharge path, but leave it
to the refill_obj_stock() that follows. Could get a bit complicated...)

> @@ -3213,6 +3260,17 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		stock->nr_bytes = 0;
>  	}
>  
> +	/*
> +	 * Flush the vmstat data in current stock
> +	 */
> +	if (stock->vmstat_bytes) {
> +		__mod_objcg_state(old, stock->cached_pgdat, stock->vmstat_idx,
> +				  stock->vmstat_bytes);

... then inline __mod_objcg_state() here into the only caller, and
there won't be any need to come up with a better name.

> +		stock->cached_pgdat = NULL;
> +		stock->vmstat_bytes = 0;
> +		stock->vmstat_idx = 0;
> +	}
> +
>  	obj_cgroup_put(old);
>  	stock->cached_objcg = NULL;
