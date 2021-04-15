Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F053236006D
	for <lists+cgroups@lfdr.de>; Thu, 15 Apr 2021 05:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhDOD2M (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 14 Apr 2021 23:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhDOD2M (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 14 Apr 2021 23:28:12 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA98C061574;
        Wed, 14 Apr 2021 20:27:50 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id dp18so6409274qvb.5;
        Wed, 14 Apr 2021 20:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZewygDwmHdq6xdev+sHHUZNlvlau4881WxunfG37r7A=;
        b=rXthvvKpJW5ubM3JhbMfyuP6GD/x2iw15KlAPPi8FDrLiadaHWY0VJ/vZqSA958+oi
         aYVuChvL8siJXaGEibL5KNTauCkk+/VUzBIZPBoVuo3PSWLFe2VZ9nMw+vO/UELzL989
         QNolmx63Igls8yqbffc7aqyzqNT5UIv8Ouy9lz2LZPRmK3VUPZCUv+B8POIN362B+DPy
         HSdDXzt890ZNc+LwDnz6U0ZzeMu3Owidfux5884QxIk27FpTtZSR15bqZE3Hhv7ZFjTp
         KvyQ94lZtMioin31k203Q1a0ipkNda/kmwyZYoiCe/ZeCKZ7wNfJNixRkcWzUqevAdrm
         K1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZewygDwmHdq6xdev+sHHUZNlvlau4881WxunfG37r7A=;
        b=Iq53mfkTht5bOLkLb9DUxa7tlt2Bl9+U4JZT0hvgz7GHGXO4NjDK5dqo+Jw2MEOdNb
         eaRhNDasBkTSgJyRw1xtREHI5sNBa8rRgPM9DxpMOpBWejZPTatyNgmoloKYlPzA5Pza
         jN1TM+sbYqssTdYyMH0uip+IXIhpb10r55pnncYWUpwJ9TG1sjEnyIy+vtoe2KQtakkr
         8w0ExBQxl4mOGP5F621VCmxECt0inlL5FJ9gyQXkgwS7QY0Jk8HtEVc6ZRpFmo9Wrq7g
         w7UwOvNbbIgZIHMSGwRpkLl0jYaNbGeCY3ED+HYfSFVz2kFhljHHeQ5dnELLNGDRrAyr
         G4WA==
X-Gm-Message-State: AOAM5322vPkzoM4PFvdKcDYwB5KEsJWoyizd3h4yqQP6gCS2koDyw2gS
        FJPATnRmaREocaXobAnRHg==
X-Google-Smtp-Source: ABdhPJz8ThtCjRqYYUJKvu3zV0fzdztY438WDuOL1Qj/w2AFsRaEewf/TIAUNdHmNuMApsfYFhtglg==
X-Received: by 2002:a05:6214:12e4:: with SMTP id w4mr1306969qvv.30.1618457269576;
        Wed, 14 Apr 2021 20:27:49 -0700 (PDT)
Received: from gabell (209-6-122-159.s2973.c3-0.arl-cbr1.sbo-arl.ma.cable.rcncustomer.com. [209.6.122.159])
        by smtp.gmail.com with ESMTPSA id d62sm1102401qkg.55.2021.04.14.20.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 20:27:49 -0700 (PDT)
Date:   Wed, 14 Apr 2021 23:27:46 -0400
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
Subject: Re: [PATCH v3 2/5] mm/memcg: Introduce
 obj_cgroup_uncharge_mod_state()
Message-ID: <20210415032746.hahhc5l5lbjhdvnr@gabell>
References: <20210414012027.5352-1-longman@redhat.com>
 <20210414012027.5352-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414012027.5352-3-longman@redhat.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 13, 2021 at 09:20:24PM -0400, Waiman Long wrote:
> In memcg_slab_free_hook()/pcpu_memcg_free_hook(), obj_cgroup_uncharge()
> is followed by mod_objcg_state()/mod_memcg_state(). Each of these
> function call goes through a separate irq_save/irq_restore cycle. That
> is inefficient.  Introduce a new function obj_cgroup_uncharge_mod_state()
> that combines them with a single irq_save/irq_restore cycle.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Acked-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memcontrol.h |  2 ++
>  mm/memcontrol.c            | 31 +++++++++++++++++++++++++++----
>  mm/percpu.c                |  9 ++-------
>  mm/slab.h                  |  6 +++---
>  4 files changed, 34 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 95f12996e66c..6890f999c1a3 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1592,6 +1592,8 @@ struct obj_cgroup *get_obj_cgroup_from_current(void);
>  
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
>  void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size);
> +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
> +				   struct pglist_data *pgdat, int idx);
>  
>  extern struct static_key_false memcg_kmem_enabled_key;
>  
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d66e1e38f8ac..b19100c68aa0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3225,12 +3225,9 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  	return false;
>  }
>  
> -static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> +static void __refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
>  	struct memcg_stock_pcp *stock;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
>  
>  	stock = this_cpu_ptr(&memcg_stock);
>  	if (stock->cached_objcg != objcg) { /* reset if necessary */
> @@ -3243,7 +3240,14 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  
>  	if (stock->nr_bytes > PAGE_SIZE)
>  		drain_obj_stock(stock);
> +}
> +
> +static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> +{
> +	unsigned long flags;
>  
> +	local_irq_save(flags);
> +	__refill_obj_stock(objcg, nr_bytes);
>  	local_irq_restore(flags);
>  }
>  
> @@ -3292,6 +3296,25 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>  	refill_obj_stock(objcg, size);
>  }
>  
> +void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
> +				   struct pglist_data *pgdat, int idx)
> +{
> +	unsigned long flags;
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec = NULL;
> +
> +	local_irq_save(flags);
> +	__refill_obj_stock(objcg, size);
> +
> +	rcu_read_lock();
> +	memcg = obj_cgroup_memcg(objcg);
> +	if (pgdat)
> +		lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +	__mod_memcg_lruvec_state(memcg, lruvec, idx, -(int)size);
> +	rcu_read_unlock();
> +	local_irq_restore(flags);
> +}
> +
>  #endif /* CONFIG_MEMCG_KMEM */
>  
>  /*
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 23308113a5ff..fd7aad6d7f90 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1631,13 +1631,8 @@ static void pcpu_memcg_free_hook(struct pcpu_chunk *chunk, int off, size_t size)
>  	objcg = chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT];
>  	chunk->obj_cgroups[off >> PCPU_MIN_ALLOC_SHIFT] = NULL;
>  
> -	obj_cgroup_uncharge(objcg, size * num_possible_cpus());
> -
> -	rcu_read_lock();
> -	mod_memcg_state(obj_cgroup_memcg(objcg), MEMCG_PERCPU_B,
> -			-(size * num_possible_cpus()));
> -	rcu_read_unlock();
> -
> +	obj_cgroup_uncharge_mod_state(objcg, size * num_possible_cpus(),
> +				      NULL, MEMCG_PERCPU_B);
>  	obj_cgroup_put(objcg);
>  }
>  
> diff --git a/mm/slab.h b/mm/slab.h
> index bc6c7545e487..677cdc52e641 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -366,9 +366,9 @@ static inline void memcg_slab_free_hook(struct kmem_cache *s_orig,
>  			continue;
>  
>  		objcgs[off] = NULL;
> -		obj_cgroup_uncharge(objcg, obj_full_size(s));
> -		mod_objcg_state(objcg, page_pgdat(page), cache_vmstat_idx(s),
> -				-obj_full_size(s));
> +		obj_cgroup_uncharge_mod_state(objcg, obj_full_size(s),
> +					      page_pgdat(page),
> +					      cache_vmstat_idx(s));
>  		obj_cgroup_put(objcg);
>  	}
>  }
> -- 
> 2.18.1
> 

Please feel free to add:

Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Thanks!
Masa
