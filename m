Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7F36006B
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 05:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhDOD14 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 23:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDOD14 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 23:27:56 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4227C061574;
        Wed, 14 Apr 2021 20:27:33 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id e13so14035237qkl.6;
        Wed, 14 Apr 2021 20:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WGneuPMuqwsLZuYUx1MDg8rpmFuqA1AoL/n4rHb8onU=;
        b=MT6yXYLz6Gu4mKeh8MYHphXkiHEUgmVgysk/YoJsfHMKtGN8DFgVTFzCQ10Eoa6bEq
         RvweRk9dVPhw/zDu84mfbtDLpGuP96LtKeT8z9WauS+L3clxB4QlAjAQF0S4n88pKlfU
         tSKH652P9V37+DYSKrdq3n1goHZQGXLQYqA3jYXdUTi0We/IEEHjoaWRCunqfhFxtuUB
         Sd4E+oim9W7U2jFwj/cK2oRKLckKg4MVzv3eQF0b5ipand/7FEZQBFeEuOxS7JKjdcA+
         hoAZeuOeXWYNObBNYiBiMf83VD0Ejt0WMz/jtftbSKB5nsQMCY2vUuTzQ2HN4+s9mRQ0
         jrXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WGneuPMuqwsLZuYUx1MDg8rpmFuqA1AoL/n4rHb8onU=;
        b=VJQ1uKdvbOywVtzriJRwGDxqBcgj9vIrueMbziyXBu+/IUamdPxqsZyGzirqE5RCEg
         2B13mQlk2pIeet63wJhU+k37pS0dvt4yvKxsZLq94dAfdK3XkkiOct0665QydFGe0PJY
         Sr4R33v/RqAu6qg/KHVIqKMJcSG4tk6rfqPdEN6vZvNANRtkraFBoiFwquzqoyohOeBu
         8tfm16dFq8BddUL6RNFeIgH2+50CSmap4O9OjZn51+8ts12kCqdAn7L7cSFZyyUU/iQE
         cVjDcwP/q+kBWh7EjiC5u1bHqpLz7tUFhQgvrkQxFWZNw5vvNDUS0MUk0Vh5zecYnUW0
         vB4A==
X-Gm-Message-State: AOAM531BTbcIyhXyHYPWQFRIfBwfgsrh5fxvMaX+/TP/J1xI2LvDIegp
        G19VsYzmfYeDVsTP9Gaevw==
X-Google-Smtp-Source: ABdhPJzzuwf5A6mZYjBYLrXX6acMPyQcLfPmNF24CFZOhHRkOTiS6APBQ6TXAwX3b/2MDR+BJib2uQ==
X-Received: by 2002:ae9:ee07:: with SMTP id i7mr1512200qkg.233.1618457253189;
        Wed, 14 Apr 2021 20:27:33 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id z28sm1036975qtm.1.2021.04.14.20.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 20:27:32 -0700 (PDT)
Date:   Wed, 14 Apr 2021 23:27:30 -0400
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
Subject: Re: [PATCH v3 1/5] mm/memcg: Pass both memcg and lruvec to
 mod_memcg_lruvec_state()
Message-ID: <20210415032730.mgw6yty22vdzhgjl@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-2-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:23PM -0400, Waiman Long wrote:
> The caller of mod_memcg_lruvec_state() has both memcg and lruvec readily
> available. So both of them are now passed to mod_memcg_lruvec_state()
> and __mod_memcg_lruvec_state(). The __mod_memcg_lruvec_state() is
> updated to allow either of the two parameters to be set to null. This
> makes mod_memcg_lruvec_state() equivalent to mod_memcg_state() if lruvec
> is null.
> 
> The new __mod_memcg_lruvec_state() function will be used in the next
> patch as a replacement of mod_memcg_state() in mm/percpu.c for the
> consolidation of the memory uncharge and vmstat update functions in
> the kmem_cache_free() path.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> ---
>  include/linux/memcontrol.h | 12 +++++++-----
>  mm/memcontrol.c            | 19 +++++++++++++------
>  mm/slab.h                  |  2 +-
>  3 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0c04d39a7967..95f12996e66c 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -955,8 +955,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return x;
>  }
>  
> -void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			      int val);
> +void __mod_memcg_lruvec_state(struct mem_cgroup *memcg, struct lruvec *lruvec,
> +			      enum node_stat_item idx, int val);
>  void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val);
>  
>  static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
> @@ -969,13 +969,14 @@ static inline void mod_lruvec_kmem_state(void *p, enum node_stat_item idx,
>  	local_irq_restore(flags);
>  }
>  
> -static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
> +static inline void mod_memcg_lruvec_state(struct mem_cgroup *memcg,
> +					  struct lruvec *lruvec,
>  					  enum node_stat_item idx, int val)
>  {
>  	unsigned long flags;
>  
>  	local_irq_save(flags);
> -	__mod_memcg_lruvec_state(lruvec, idx, val);
> +	__mod_memcg_lruvec_state(memcg, lruvec, idx, val);
>  	local_irq_restore(flags);
>  }
>  
> @@ -1369,7 +1370,8 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>  	return node_page_state(lruvec_pgdat(lruvec), idx);
>  }
>  
> -static inline void __mod_memcg_lruvec_state(struct lruvec *lruvec,
> +static inline void __mod_memcg_lruvec_state(struct mem_cgroup *memcg,
> +					    struct lruvec *lruvec,
>  					    enum node_stat_item idx, int val)
>  {
>  }
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e064ac0d850a..d66e1e38f8ac 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -799,20 +799,27 @@ parent_nodeinfo(struct mem_cgroup_per_node *pn, int nid)
>  	return mem_cgroup_nodeinfo(parent, nid);
>  }
>  
> -void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> -			      int val)
> +/*
> + * Either one of memcg or lruvec can be NULL, but not both.
> + */
> +void __mod_memcg_lruvec_state(struct mem_cgroup *memcg, struct lruvec *lruvec,
> +			      enum node_stat_item idx, int val)
>  {
>  	struct mem_cgroup_per_node *pn;
> -	struct mem_cgroup *memcg;
>  	long x, threshold = MEMCG_CHARGE_BATCH;
>  
> +	/* Update lruvec */
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	memcg = pn->memcg;
> +
> +	if (!memcg)
> +		memcg = pn->memcg;
>  
>  	/* Update memcg */
>  	__mod_memcg_state(memcg, idx, val);
>  
> -	/* Update lruvec */
> +	if (!lruvec)
> +		return;
> +
>  	__this_cpu_add(pn->lruvec_stat_local->count[idx], val);
>  
>  	if (vmstat_item_in_bytes(idx))
> @@ -848,7 +855,7 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  
>  	/* Update memcg and lruvec */
>  	if (!mem_cgroup_disabled())
> -		__mod_memcg_lruvec_state(lruvec, idx, val);
> +		__mod_memcg_lruvec_state(NULL, lruvec, idx, val);
>  }
>  
>  void __mod_lruvec_page_state(struct page *page, enum node_stat_item idx,
> diff --git a/mm/slab.h b/mm/slab.h
> index 076582f58f68..bc6c7545e487 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -293,7 +293,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>  	rcu_read_lock();
>  	memcg = obj_cgroup_memcg(objcg);
>  	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -	mod_memcg_lruvec_state(lruvec, idx, nr);
> +	mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.18.1
> 

Please feel free to add:

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
