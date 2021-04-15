Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07268360071
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 05:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhDOD3k (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 23:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhDOD3K (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 23:29:10 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA89C061756;
        Wed, 14 Apr 2021 20:28:23 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id m16so16548284qtx.9;
        Wed, 14 Apr 2021 20:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GdhHYsB8bOsa0eVuM5ITMWOP/eGp5o+C93zFwUv80RI=;
        b=ZX8WWiYfe9ouAFYnUCatkW3kFti2km6xAK/jSGgTiTdTc2K18FI6zAorC7CA5wE2CN
         +DE70z6Pa/oY35NHF+/pTm51zbCUXPfI6VQT7lEKc8tj7AxIe/hJIBFHIwu7ejtNQ2h/
         flyV+dLY/XR9dV8cVrdqZBbqZ+zbO10663BLQo5S32lrGzbJxPIDgr5gD4izz3w6/Mro
         31GxQRer8ofsumn6fMeSSqdt90rRYd9Q5lQ3b74aIKYMpXtYIHAc8rO9nN3FfX4rVCXN
         IOB6DHt+cuKDLRa4vfSTKiPXqgzcZN4HdUYexdmER71oMsDpRviW2rKkSoYLM4wzJr+J
         TQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GdhHYsB8bOsa0eVuM5ITMWOP/eGp5o+C93zFwUv80RI=;
        b=Rskg+vdhzEsFzboufVepdYeu39L70etzgyjquDqAsLs4A46Jg/m1OSPy31VB7vihKI
         PlEAjpg8EVCkvrAlkYXbEsHt2FNcAC/BMqFWLrcDTyXSF0/8uCM23tVo2+bPlSh7aLPj
         7Wn8gi+w1nL7XoIadFwP2OGz7SBv/KW5abqcIfSKqEwvMA3wmzOOrvCpJ3BRmLv+0aG4
         rMwlmMsa9XrqkLeTk9QGxGYV2dFjkKIF3+pA0F/9E894UsLOYTF52RB/GKN/kKJCEpzG
         ypqgft+jRpJAVXW+MCWZWtuhU2BPa8nuWCuP7hOM+i/+hRM0yklk9Rpcgu15ger9XWrf
         1jIw==
X-Gm-Message-State: AOAM533dZxCfAzeA2cLhCIWv877ET9OTTUVtqpOznItcpzjtMbRA8quF
        oEnjSSaoYDY9vETWRVNF2Q==
X-Google-Smtp-Source: ABdhPJxrInFbxTRYLpfkrv9pzAfOYzjnKDDtaMpVgvyyk+nMwNbSCG4q4AybbdB5727ZTidhpuqDBw==
X-Received: by 2002:ac8:6d0d:: with SMTP id o13mr1191320qtt.267.1618457302451;
        Wed, 14 Apr 2021 20:28:22 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id r9sm943214qtf.62.2021.04.14.20.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 20:28:22 -0700 (PDT)
Date:   Wed, 14 Apr 2021 23:28:20 -0400
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
Subject: Re: [PATCH v3 4/5] mm/memcg: Separate out object stock data into its
 own struct
Message-ID: <20210415032820.coutviukiyieiysm@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-5-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:26PM -0400, Waiman Long wrote:
> The object stock data stored in struct memcg_stock_pcp are independent
> of the other page based data stored there. Separating them out into
> their own struct to highlight the independency.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  mm/memcontrol.c | 41 ++++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 539c3b632e47..69f728383efe 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2214,17 +2214,22 @@ void unlock_page_memcg(struct page *page)
>  }
>  EXPORT_SYMBOL(unlock_page_memcg);
>  
> -struct memcg_stock_pcp {
> -	struct mem_cgroup *cached; /* this never be root cgroup */
> -	unsigned int nr_pages;
> -
> +struct obj_stock {
>  #ifdef CONFIG_MEMCG_KMEM
>  	struct obj_cgroup *cached_objcg;
>  	struct pglist_data *cached_pgdat;
>  	unsigned int nr_bytes;
>  	int vmstat_idx;
>  	int vmstat_bytes;
> +#else
> +	int dummy[0];
>  #endif
> +};
> +
> +struct memcg_stock_pcp {
> +	struct mem_cgroup *cached; /* this never be root cgroup */
> +	unsigned int nr_pages;
> +	struct obj_stock obj;
>  
>  	struct work_struct work;
>  	unsigned long flags;
> @@ -2234,12 +2239,12 @@ static DEFINE_PER_CPU(struct memcg_stock_pcp, memcg_stock);
>  static DEFINE_MUTEX(percpu_charge_mutex);
>  
>  #ifdef CONFIG_MEMCG_KMEM
> -static void drain_obj_stock(struct memcg_stock_pcp *stock);
> +static void drain_obj_stock(struct obj_stock *stock);
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  				     struct mem_cgroup *root_memcg);
>  
>  #else
> -static inline void drain_obj_stock(struct memcg_stock_pcp *stock)
> +static inline void drain_obj_stock(struct obj_stock *stock)
>  {
>  }
>  static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> @@ -2249,6 +2254,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  }
>  #endif
>  
> +static inline struct obj_stock *current_obj_stock(void)
> +{
> +	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> +
> +	return &stock->obj;
> +}
> +
>  /**
>   * consume_stock: Try to consume stocked charge on this cpu.
>   * @memcg: memcg to consume from.
> @@ -2315,7 +2327,7 @@ static void drain_local_stock(struct work_struct *dummy)
>  	local_irq_save(flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
> -	drain_obj_stock(stock);
> +	drain_obj_stock(&stock->obj);
>  	drain_stock(stock);
>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>  
> @@ -3177,13 +3189,13 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>  
>  static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
> -	struct memcg_stock_pcp *stock;
> +	struct obj_stock *stock;
>  	unsigned long flags;
>  	bool ret = false;
>  
>  	local_irq_save(flags);
>  
> -	stock = this_cpu_ptr(&memcg_stock);
> +	stock = current_obj_stock();
>  	if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
>  		stock->nr_bytes -= nr_bytes;
>  		ret = true;
> @@ -3194,7 +3206,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  	return ret;
>  }
>  
> -static void drain_obj_stock(struct memcg_stock_pcp *stock)
> +static void drain_obj_stock(struct obj_stock *stock)
>  {
>  	struct obj_cgroup *old = stock->cached_objcg;
>  
> @@ -3242,8 +3254,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  {
>  	struct mem_cgroup *memcg;
>  
> -	if (stock->cached_objcg) {
> -		memcg = obj_cgroup_memcg(stock->cached_objcg);
> +	if (stock->obj.cached_objcg) {
> +		memcg = obj_cgroup_memcg(stock->obj.cached_objcg);
>  		if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
>  			return true;
>  	}
> @@ -3253,9 +3265,8 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  
>  static void __refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
> -	struct memcg_stock_pcp *stock;
> +	struct obj_stock *stock = current_obj_stock();
>  
> -	stock = this_cpu_ptr(&memcg_stock);
>  	if (stock->cached_objcg != objcg) { /* reset if necessary */
>  		drain_obj_stock(stock);
>  		obj_cgroup_get(objcg);
> @@ -3280,7 +3291,7 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  static void __mod_obj_stock_state(struct obj_cgroup *objcg,
>  				  struct pglist_data *pgdat, int idx, int nr)
>  {
> -	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> +	struct obj_stock *stock = current_obj_stock();
>  
>  	if (stock->cached_objcg != objcg) {
>  		/* Output the current data as is */
> -- 
> 2.18.1
> 
Please feel free to add:

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
