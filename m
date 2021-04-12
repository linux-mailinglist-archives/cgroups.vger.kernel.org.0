Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF12B35D3BB
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 01:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbhDLXL0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241965AbhDLXLZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 19:11:25 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0877C061756
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 16:11:06 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id v140so24141019lfa.4
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EB6M69ykRfOk8CNylVX2Xu1iWxE7slXxBQnBQQyoh0Q=;
        b=m/kjHFSDwzv3BbnwILdEAMEu34wkDzXHctkxqs41nUPCderXN+P0otyZ/WoqmpvyaW
         TYIBp8v6+r+6x5LJacRAqdsbIJCAgjXrYssLGqWZCmUb9eGhrTCTMWAcgzxg9lIU5qj1
         F4ZfuoVmEuJ3bfPsaJ43rYq8BkCdkd+bIKPz/jUO37ijQy9qEAcEMDM01kcyIHWlFcDF
         UMTlwSGJGeuuYBZ/eUPPOybdNcFMZQ8AnNR6kErXat2ZPeYVRNMSjTlt8Kt+CBTOTqU+
         jT2R/iUAnGSvAbYZxeVSbqND2Ldcavcbm/1ZTIUb7J2HkhjcfvL3t2C9zBRWfilXTSEm
         KYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EB6M69ykRfOk8CNylVX2Xu1iWxE7slXxBQnBQQyoh0Q=;
        b=i1q9yhswZFcCU65Dm2+i8AAKiDIxl7EqrxLPn9Pjl5nlwkBEfKj/5d+04zoIXCrocG
         yECGdEtpSQvo6woa7nQ7wlq47701Kght9eh7wGktg/wm1V9oJu5mQnjiQdkIhaMpjUH0
         Xv9x1tXKDwOwtehpDcIAxomzV35rLNIpTtpL/QFHK5YTc5HwnCcc6rDvunvrdOM5tG1O
         3+wLd3qW0wgptlDDWDXi0PH3kHleAfHRLxMfdkG+xVBZ7LNa5Lx9f95pOPZmnJmJuopB
         /ywUShJfap/l8hgbxCwRJwfa3l5h0dbTCuEAple21lY0+x7fx/LHQ6TUkv4mZnbAqRuy
         tOoA==
X-Gm-Message-State: AOAM53002qI0xRhYUykcmPFwAbZfeQmseqCT3DZXulgn+ffLi9nDpmJD
        4jWVpxY8Y16yxkLVAnrvUo9/F1FR20/pM+75grkwHw==
X-Google-Smtp-Source: ABdhPJzMX4OiuvyU6Y9R8hJ7f8iPiZlikv/N+32inGJEK1DkwPToxpRVbqW/4cVoydeOpfUpnT90qqYGopPMYu+cAXQ=
X-Received: by 2002:a05:6512:2019:: with SMTP id a25mr11022613lfb.347.1618269065084;
 Mon, 12 Apr 2021 16:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210412225503.15119-1-longman@redhat.com> <20210412225503.15119-6-longman@redhat.com>
In-Reply-To: <20210412225503.15119-6-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 16:10:53 -0700
Message-ID: <CALvZod6_dOKfnhprpzoFNmC2cLu1F35dNZvnu-DHTNOxYmeq2g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm/memcg: Optimize user context object stock access
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
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Chris Down <chris@chrisdown.name>,
        Yafang Shao <laoar.shao@gmail.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Apr 12, 2021 at 3:55 PM Waiman Long <longman@redhat.com> wrote:
>
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
> ---
>  mm/memcontrol.c | 73 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 59 insertions(+), 14 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 69f728383efe..29f2df76644a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2229,7 +2229,8 @@ struct obj_stock {
>  struct memcg_stock_pcp {
>         struct mem_cgroup *cached; /* this never be root cgroup */
>         unsigned int nr_pages;
> -       struct obj_stock obj;
> +       struct obj_stock task_obj;
> +       struct obj_stock irq_obj;
>
>         struct work_struct work;
>         unsigned long flags;
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
>         struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
>
> -       return &stock->obj;
> +       return in_task() ? &stock->task_obj : &stock->irq_obj;
> +}
> +
> +#define get_obj_stock(flags)                           \
> +({                                                     \
> +       struct memcg_stock_pcp *stock;                  \
> +       struct obj_stock *obj_stock;                    \
> +                                                       \
> +       if (in_task()) {                                \
> +               preempt_disable();                      \
> +               (flags) = -1L;                          \
> +               stock = this_cpu_ptr(&memcg_stock);     \

The above line was missing in the previous version.

> +               obj_stock = &stock->task_obj;           \
> +       } else {                                        \
> +               local_irq_save(flags);                  \
> +               stock = this_cpu_ptr(&memcg_stock);     \
> +               obj_stock = &stock->irq_obj;            \
> +       }                                               \
> +       obj_stock;                                      \
> +})
> +
> +static inline void put_obj_stock(unsigned long flags)
> +{
> +       if (flags == -1L)
> +               preempt_enable();
> +       else
> +               local_irq_restore(flags);
>  }
>
>  /**
> @@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
>         local_irq_save(flags);
>
>         stock = this_cpu_ptr(&memcg_stock);
> -       drain_obj_stock(&stock->obj);
> +       drain_obj_stock(&stock->irq_obj);
> +       if (in_task())
> +               drain_obj_stock(&stock->task_obj);
>         drain_stock(stock);
>         clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>
> @@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
>         memcg = obj_cgroup_memcg(objcg);
>         if (pgdat)
>                 lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -       __mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> +       mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
>         rcu_read_unlock();
>  }
>
> @@ -3193,7 +3233,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>         unsigned long flags;
>         bool ret = false;
>
> -       local_irq_save(flags);
> +       stock = get_obj_stock(flags);
>
>         stock = current_obj_stock();

The above is redundant.

>         if (objcg == stock->cached_objcg && stock->nr_bytes >= nr_bytes) {
> @@ -3201,7 +3241,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>                 ret = true;
>         }
>
> -       local_irq_restore(flags);
> +       put_obj_stock(flags);
>
>         return ret;
>  }
> @@ -3254,8 +3294,13 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
>  {
>         struct mem_cgroup *memcg;
>
> -       if (stock->obj.cached_objcg) {
> -               memcg = obj_cgroup_memcg(stock->obj.cached_objcg);
> +       if (in_task() && stock->task_obj.cached_objcg) {
> +               memcg = obj_cgroup_memcg(stock->task_obj.cached_objcg);
> +               if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
> +                       return true;
> +       }
> +       if (stock->irq_obj.cached_objcg) {
> +               memcg = obj_cgroup_memcg(stock->irq_obj.cached_objcg);
>                 if (memcg && mem_cgroup_is_descendant(memcg, root_memcg))
>                         return true;
>         }
> @@ -3283,9 +3328,9 @@ static void refill_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
>  {
>         unsigned long flags;
>
> -       local_irq_save(flags);
> +       get_obj_stock(flags);
>         __refill_obj_stock(objcg, nr_bytes);
> -       local_irq_restore(flags);
> +       put_obj_stock(flags);
>  }
>
>  static void __mod_obj_stock_state(struct obj_cgroup *objcg,
> @@ -3325,9 +3370,9 @@ void mod_obj_stock_state(struct obj_cgroup *objcg, struct pglist_data *pgdat,
>  {
>         unsigned long flags;
>
> -       local_irq_save(flags);
> +       get_obj_stock(flags);
>         __mod_obj_stock_state(objcg, pgdat, idx, nr);
> -       local_irq_restore(flags);
> +       put_obj_stock(flags);
>  }
>
>  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
> @@ -3380,10 +3425,10 @@ void obj_cgroup_uncharge_mod_state(struct obj_cgroup *objcg, size_t size,
>  {
>         unsigned long flags;
>
> -       local_irq_save(flags);
> +       get_obj_stock(flags);
>         __refill_obj_stock(objcg, size);
>         __mod_obj_stock_state(objcg, pgdat, idx, -(int)size);
> -       local_irq_restore(flags);
> +       put_obj_stock(flags);
>  }
>
>  #endif /* CONFIG_MEMCG_KMEM */
> --
> 2.18.1
>
