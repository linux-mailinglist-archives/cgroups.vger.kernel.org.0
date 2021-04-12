Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B65735D3BF
	for <lists+cgroups@lfdr.de>; Tue, 13 Apr 2021 01:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243680AbhDLXOo (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 12 Apr 2021 19:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbhDLXOm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 12 Apr 2021 19:14:42 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E97C061756
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 16:14:23 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id n138so24178315lfa.3
        for <cgroups@vger.kernel.org>; Mon, 12 Apr 2021 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/duzMH/OTq6aaOv0cDTj1fS9M5eKwgWI2Ns6h3aePII=;
        b=NQ1YkeyiLSUMD3jWDiGlc6wYoFZTbrTUVCYIGGrWuZqu87Dn3X0VLGDBLQwLx7pKwu
         /JEpw2GxwEpZJiN7Q2hten9sbEV8lUkUN+HGTSj6WXhrUuK4B/ihsvysUzvp6jN1jrOT
         iJOX1wVmhk9ANkOmQy8M20dshGYkGVBzEgfR5cUuHTT4hRCKlNliYyge/CWCKShmjy9/
         0Wj2cykBVj6158M/fVwGueo1LTOzMAieRuPpe9Z2ULeCJfKHVWWN8hSkkaIQr+03gLIi
         6bBbSqVV8/rNNlgMQ0QmCKi0Fs1IQQ6y0IbuwxbQbvKveEwvx7N+AQeCyMcOGKq+n/kv
         uP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/duzMH/OTq6aaOv0cDTj1fS9M5eKwgWI2Ns6h3aePII=;
        b=mSyV46AIBwzLKFUqqPV9kTRph2BRubdjaMFGXKspEjnmxzhTp03L43IIHiHO7AgZ9z
         qsaDmKsXN+htoMSD61IUviaVisRVS/wemrdO/csDmQ+BrEzAtOlzKTY6j7by0UaxgGHK
         VYiBzO44ry/ggFCtVhZAgl0ICpkFx8GKTjpgCVooDvfU56hA7jirZvJDpp5XouLlULYP
         pJfFyxse0KcOkFURoNBP5cmg6NEq+oOOY6uUxtfyeD56aCfLwnn1Kr9kjXm+dniSsCF8
         0Qw8VUNeZpYPmRrPyVQ0ktLYQP5Fx9Odwpf3P1aUXcoG8U/FUJIJarOlYUrs69lFYbm/
         Q2Tg==
X-Gm-Message-State: AOAM531cum/jkfvpfWVBi5uph0DU+BO/7OXHqxVjQ3ls0jAchJB5CJd2
        5OZNcjh7tPlYBoPGEcg6MbwqvPr8ZrHq3TVoi0FHPQ==
X-Google-Smtp-Source: ABdhPJzCyBQTUhS/VAijry16x1b+ynmJqq7HaLNObZMA41fFqdeUQTFoHoDT9JU3LYprSh+tTD9AYd0xB5Q0T/v2HzY=
X-Received: by 2002:a05:6512:3703:: with SMTP id z3mr20217180lfr.358.1618269261596;
 Mon, 12 Apr 2021 16:14:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210412225503.15119-1-longman@redhat.com> <20210412225503.15119-6-longman@redhat.com>
 <CALvZod6_dOKfnhprpzoFNmC2cLu1F35dNZvnu-DHTNOxYmeq2g@mail.gmail.com>
In-Reply-To: <CALvZod6_dOKfnhprpzoFNmC2cLu1F35dNZvnu-DHTNOxYmeq2g@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 12 Apr 2021 16:14:10 -0700
Message-ID: <CALvZod4CUMOBOkC8NjXXJ_qu3kvhcw+zrux+c516BMcAuHTcuA@mail.gmail.com>
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

On Mon, Apr 12, 2021 at 4:10 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Apr 12, 2021 at 3:55 PM Waiman Long <longman@redhat.com> wrote:
> >
> > Most kmem_cache_alloc() calls are from user context. With instrumentation
> > enabled, the measured amount of kmem_cache_alloc() calls from non-task
> > context was about 0.01% of the total.
> >
> > The irq disable/enable sequence used in this case to access content
> > from object stock is slow.  To optimize for user context access, there
> > are now two object stocks for task context and interrupt context access
> > respectively.
> >
> > The task context object stock can be accessed after disabling preemption
> > which is cheap in non-preempt kernel. The interrupt context object stock
> > can only be accessed after disabling interrupt. User context code can
> > access interrupt object stock, but not vice versa.
> >
> > The mod_objcg_state() function is also modified to make sure that memcg
> > and lruvec stat updates are done with interrupted disabled.
> >
> > The downside of this change is that there are more data stored in local
> > object stocks and not reflected in the charge counter and the vmstat
> > arrays.  However, this is a small price to pay for better performance.
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > Acked-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/memcontrol.c | 73 +++++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 59 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 69f728383efe..29f2df76644a 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2229,7 +2229,8 @@ struct obj_stock {
> >  struct memcg_stock_pcp {
> >         struct mem_cgroup *cached; /* this never be root cgroup */
> >         unsigned int nr_pages;
> > -       struct obj_stock obj;
> > +       struct obj_stock task_obj;
> > +       struct obj_stock irq_obj;
> >
> >         struct work_struct work;
> >         unsigned long flags;
> > @@ -2254,11 +2255,48 @@ static bool obj_stock_flush_required(struct memcg_stock_pcp *stock,
> >  }
> >  #endif
> >
> > +/*
> > + * Most kmem_cache_alloc() calls are from user context. The irq disable/enable
> > + * sequence used in this case to access content from object stock is slow.
> > + * To optimize for user context access, there are now two object stocks for
> > + * task context and interrupt context access respectively.
> > + *
> > + * The task context object stock can be accessed by disabling preemption only
> > + * which is cheap in non-preempt kernel. The interrupt context object stock
> > + * can only be accessed after disabling interrupt. User context code can
> > + * access interrupt object stock, but not vice versa.
> > + */
> >  static inline struct obj_stock *current_obj_stock(void)
> >  {
> >         struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> >
> > -       return &stock->obj;
> > +       return in_task() ? &stock->task_obj : &stock->irq_obj;
> > +}
> > +
> > +#define get_obj_stock(flags)                           \
> > +({                                                     \
> > +       struct memcg_stock_pcp *stock;                  \
> > +       struct obj_stock *obj_stock;                    \
> > +                                                       \
> > +       if (in_task()) {                                \
> > +               preempt_disable();                      \
> > +               (flags) = -1L;                          \
> > +               stock = this_cpu_ptr(&memcg_stock);     \
>
> The above line was missing in the previous version.
>
> > +               obj_stock = &stock->task_obj;           \
> > +       } else {                                        \
> > +               local_irq_save(flags);                  \
> > +               stock = this_cpu_ptr(&memcg_stock);     \
> > +               obj_stock = &stock->irq_obj;            \
> > +       }                                               \
> > +       obj_stock;                                      \
> > +})
> > +
> > +static inline void put_obj_stock(unsigned long flags)
> > +{
> > +       if (flags == -1L)
> > +               preempt_enable();
> > +       else
> > +               local_irq_restore(flags);
> >  }
> >
> >  /**
> > @@ -2327,7 +2365,9 @@ static void drain_local_stock(struct work_struct *dummy)
> >         local_irq_save(flags);
> >
> >         stock = this_cpu_ptr(&memcg_stock);
> > -       drain_obj_stock(&stock->obj);
> > +       drain_obj_stock(&stock->irq_obj);
> > +       if (in_task())
> > +               drain_obj_stock(&stock->task_obj);
> >         drain_stock(stock);
> >         clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> >
> > @@ -3183,7 +3223,7 @@ static inline void mod_objcg_state(struct obj_cgroup *objcg,
> >         memcg = obj_cgroup_memcg(objcg);
> >         if (pgdat)
> >                 lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > -       __mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> > +       mod_memcg_lruvec_state(memcg, lruvec, idx, nr);
> >         rcu_read_unlock();
> >  }
> >
> > @@ -3193,7 +3233,7 @@ static bool consume_obj_stock(struct obj_cgroup *objcg, unsigned int nr_bytes)
> >         unsigned long flags;
> >         bool ret = false;
> >
> > -       local_irq_save(flags);
> > +       stock = get_obj_stock(flags);
> >
> >         stock = current_obj_stock();
>
> The above is redundant.
>

After cleanup you can add:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
