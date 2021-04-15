Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD5F36006F
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 05:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhDOD2a (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 23:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDOD23 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 23:28:29 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598AFC061574;
        Wed, 14 Apr 2021 20:28:07 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id e13so14036100qkl.6;
        Wed, 14 Apr 2021 20:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=m17Nqgjz0MhuOrfVFu4NTDUq9FTlxz2SNblNA/EjtAc=;
        b=IelGevI7ys156Xel0Ojr6AOGgz2DL9GNzpOQZLbSB7TD7nSN8OXMHQFMTN91u+cIwz
         LU4RXtxDWQwL88ol0sDrBbHkfMvKNGDxc1IVf9OO99DFobYm6YTP6/Ue5mVdWMFlCtGP
         BqnRsNyyz0SjHuQAw33703kpcM6zH0FfjbHZ6M3OnmzcR6eDY3Zob5d+1ZyO1QqvG7Jc
         IA7A2dte8R9Hw2a//ATA6BDd5rUfR6deNDW4xU+U2XWS5/2kgIZfEXchDa76+/Q2bFpJ
         QY49J0uCkARbHJdc6qOGctdXqCmdAsWgayFqLOjik4EkRjVEFNVvWnrxEdz564JFp14f
         XQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m17Nqgjz0MhuOrfVFu4NTDUq9FTlxz2SNblNA/EjtAc=;
        b=Fx9n2jqbkVqH6BQdVdd2HfdYUZOC6YO14+VD/m1w5rpAEe4obNoUrQ+d3GSlc3zHCp
         OmQMX2J4QKDG07iZNNOUnhuAdttXrzEMfXwV2g3Uw0wAX6N+GQgUsQPv1WA7fMtT7uJC
         5ostnVw416qkAMN+8IcDfvDtbcS+/xoSr+tPlwQYCC7SHosa9bpu4sRmQ2BbKyZUkEh7
         n0+ZViB2sGBhu6Nk/UPpMJrdCc03JwZK5v+VpWghXDB3YghWyMAG5HIILvq0ZCI+LADw
         rpRL7hVD1OUYylKZ4EV6v0eRTj/X82eVvM4QWxZMOgwP53iWt8/XrbJAz06JQixnhAe1
         s2LA==
X-Gm-Message-State: AOAM5315RptUY+bnVr/uSe5MR2EXO+WVilkUDE3wTKpg9WS66QX913Lo
        ALaPgh35dIKz/mHtULjp7Q==
X-Google-Smtp-Source: ABdhPJzzXY9Sz84kCLFE8eEFQO5lLKJZOTYpTNXvrSva0sVBm8QnUuaZGD9cao1Hq6cm0BnCqEmBEQ==
X-Received: by 2002:a05:620a:d5e:: with SMTP id o30mr1550096qkl.288.1618457286603;
        Wed, 14 Apr 2021 20:28:06 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r189sm1057077qke.56.2021.04.14.20.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 20:28:06 -0700 (PDT)
Date:   Wed, 14 Apr 2021 23:28:04 -0400
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
Subject: Re: [PATCH v3 3/5] mm/memcg: Cache vmstat data in percpu
 memcg_stock_pcp
Message-ID: <20210415032804.kocbusnrmaambbkr@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-4-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:25PM -0400, Waiman Long wrote:
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
> data change.
> 
> On a 2-socket Cascade Lake server with instrumentation enabled and this
> patch applied, it was found that about 17% (946796 out of 5515184) of the
> time when __mod_obj_stock_state() is called leads to an actual call to
> mod_objcg_state() after initial boot. When doing parallel kernel build,
> the figure was about 16% (21894614 out of 139780628). So caching the
> vmstat data reduces the number of calls to mod_objcg_state() by more
> than 80%.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 78 +++++++++++++++++++++++++++++++++++++++++++------
>  mm/slab.h       | 26 +++++++----------
>  2 files changed, 79 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b19100c68aa0..539c3b632e47 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2220,7 +2220,10 @@ struct memcg_stock_pcp {
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
> @@ -3157,6 +3160,21 @@ void __memcg_kmem_uncharge_page(struct page *page, int order)
>  	css_put(&memcg->css);
>  }
>  
> +static inline void mod_objcg_state(struct obj_cgroup *objcg,
> +				   struct pglist_data *pgdat,
> +				   enum node_stat_item idx, int nr)
> +{
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec = NULL;
> +
> +	rcu_read_lock();
> +	memcg = obj_cgroup_memcg(objcg);
> +	if (pgdat)
> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	__mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> +	rcu_read_unlock();
> +}
> +
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
>  	struct memcg_stock_pcp *stock;
> @@ -3207,6 +3225,14 @@ static void drain_obj_stock(struct memcg_stock_pcp *stock)
>  		stock->nr_bytes = 0;
>  	}
>  
> +	if (stock->vmstat_bytes) {
> +		mod_objcg_state(old, stock->cached_pgdat, stock->vmstat_idx,
> +				stock->vmstat_bytes);
> +		stock->vmstat_bytes = 0;
> +		stock->vmstat_idx = 0;
> +		stock->cached_pgdat = NULL;
> +	}
> +
>  	obj_cgroup_put(old);
>  	stock->cached_objcg = NULL;
>  }
> @@ -3251,6 +3277,48 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  	local_irq_restore(flags);
>  }
>  
> +static void __mod_obj_stock_state(struct obj_cgroup *objcg,
> +				  struct pglist_data *pgdat, int idx, int nr)
> +{
> +	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> +
> +	if (stock->cached_objcg != objcg) {
> +		/* Output the current data as is */
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
> +	} else {
> +		stock->vmstat_bytes += nr;
> +		if (abs(nr) > PAGE_SIZE) {
> +			nr = stock->vmstat_bytes;
> +			stock->vmstat_bytes = 0;
> +		} else {
> +			nr = 0;
> +		}
> +	}
> +	if (nr)
> +		mod_objcg_state(objcg, pgdat, idx, nr);
> +}
> +
> +void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +			 int idx, int nr)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	__mod_obj_stock_state(objcg, pgdat, idx, nr);
> +	local_irq_restore(flags);
> +}
> +
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>  {
>  	struct mem_cgroup *memcg;
> @@ -3300,18 +3368,10 @@ void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
>  				   struct pglist_data *pgdat, int idx)
>  {
>  	unsigned long flags;
> -	struct mem_cgroup *memcg;
> -	struct lruvec *lruvec = NULL;
>  
>  	local_irq_save(flags);
>  	__refill_obj_stock(objcg, size);
> -
> -	rcu_read_lock();
> -	memcg = obj_cgroup_memcg(objcg);
> -	if (pgdat)
> -		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	__mod_memcg_lruvec_state(memcg, lruvec, idx, -(int)size);
> -	rcu_read_unlock();
> +	__mod_obj_stock_state(objcg, pgdat, idx, -(int)size);
>  	local_irq_restore(flags);
>  }
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index 677cdc52e641..03bd9813422b 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -239,6 +239,8 @@ static inline bool kmem_cache_debug_flags(struct kmem_cache *s, slab_flags_t fla
>  #ifdef CONFIG_MEMCG_KMEM
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>  				 gfp_t gfp, bool new_page);
> +void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
> +			 int idx, int nr);
>  
>  static inline void memcg_free_page_obj_cgroups(struct page *page)
>  {
> @@ -283,20 +285,6 @@ static inline bool memcg_slab_pre_alloc_hook(struct kmem_cache *s,
>  	return true;
>  }
>  
> -static inline void mod_objcg_state(struct obj_cgroup *objcg,
> -				   struct pglist_data *pgdat,
> -				   enum node_stat_item idx, int nr)
> -{
> -	struct mem_cgroup *memcg;
> -	struct lruvec *lruvec;
> -
> -	rcu_read_lock();
> -	memcg = obj_cgroup_memcg(objcg);
> -	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> -	rcu_read_unlock();
> -}
> -
>  static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  					      struct obj_cgroup *objcg,
>  					      gfp_t flags, size_t size,
> @@ -324,8 +312,9 @@ static inline void memcg_slab_post_alloc_hook(struct kmem_cache *s,
>  			off = obj_to_index(s, page, p[i]);
>  			obj_cgroup_get(objcg);
>  			page_objcgs(page)[off] = objcg;
> -			mod_objcg_state(objcg, page_pgdat(page),
> -					cache_vmstat_idx(s), obj_full_size(s));
> +			mod_obj_stock_state(objcg, page_pgdat(page),
> +					    cache_vmstat_idx(s),
> +					    obj_full_size(s));
>  		} else {
>  			obj_cgroup_uncharge(objcg, obj_full_size(s));
>  		}
> @@ -408,6 +397,11 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s,
>  					void **p, int objects)
>  {
>  }
> +
> +static inline void mod_obj_stock_state(struct obj_cgroup *objcg,
> +				       struct pglist_data *pgdat, int idx, int nr)
> +{
> +}
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  static inline struct kmem_cache *virt_to_cache(const void *obj)
> -- 
> 2.18.1
> 

Please feel free to add:

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
