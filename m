Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2941F646
	for <lists+cgroups@lfdr.de>; Fri,  1 Oct 2021 22:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhJAUZ7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 1 Oct 2021 16:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhJAUZ7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 1 Oct 2021 16:25:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B78C061775
        for <cgroups@vger.kernel.org>; Fri,  1 Oct 2021 13:24:14 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id y26so43400055lfa.11
        for <cgroups@vger.kernel.org>; Fri, 01 Oct 2021 13:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrYh61lOh+sxhsAAWd+QrLGaxeWWjn0UIN5WqeIFSDE=;
        b=CIdjNlyXFPPFBGpyYYj0DJwCz0IqLNKsi1GKRN6Upp9HWbEU9CjtboL96tj37LHbg6
         04qOPPQBhN0GrMgwsRABS91/Ds0j1+EBLQFi8dWQc880qQJXulAs6MfN89TKXKtCCr0P
         Sh84UDgjYPFJpIN1kiUOAXLBW5APRRFe5PspYZKdFcqqOL+QOk+yfDr9OzTHlG9HUc/x
         0TQ1zikI6RkxTDPqsyeyjcylOVDtET4Qd3WcHG08eTkizI7m4WWU57tk/xcxPnxbYToZ
         +2F38b4U13y/e2aBExzOVi/t8RpeoNqPHYG54th4nKn/4khpD3PmVcfmEQKHyL53r7+h
         p51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrYh61lOh+sxhsAAWd+QrLGaxeWWjn0UIN5WqeIFSDE=;
        b=dQ1AqzFMtJv7L7QxBXNcp0Fqbh+IQggK9loxn4uAOTZgrPneJc1euEgU3ipot2Nq42
         ckJa+CkmKjIgQfNzupdXrbhtghirjhIk7XMFeRU6ZhXUGq9WQ7ICjLdJVCEF5IVkcqtV
         5qqOWwSin0mTkpGJV15xk7IGX4JnIBk6GgG7SsCsMosZk5NsyZnGilRmcDt6Igx7xTnR
         j6lQHHtqiE+KQN2H9oQCEL7+QiFyh5C35g3CYLdF2JwougVp8LyC3oCVt98Wb7alcfj7
         a6Hqnm/Exj1DR83KaFmagy2squ7hOv2ME9Trxdz6b4lVAM3OzVqGDfpEOjFyZGEKzJI1
         VbNg==
X-Gm-Message-State: AOAM531WzIceWh1Rgc8b0Uh0wmCFTAI0hVEMY/+8RsaBX1VERs7Mn8L7
        GNwN9l3362EZP/kStI200jS91yLtRkt91WgDXMVG5g==
X-Google-Smtp-Source: ABdhPJyhi51NOjaxUHPOQ8y17HqPDMIgRkMxeXgUvXMVYaJg/knTK8g8F56cLwDzKL+NX0fT6lEBqbE2Tb+ZDsb3e6k=
X-Received: by 2002:a05:6512:3b21:: with SMTP id f33mr57551lfv.8.1633119852539;
 Fri, 01 Oct 2021 13:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211001190938.14050-1-longman@redhat.com> <20211001190938.14050-4-longman@redhat.com>
In-Reply-To: <20211001190938.14050-4-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 1 Oct 2021 13:24:01 -0700
Message-ID: <CALvZod42VDSMy4E47snF-8yToSkt7no1h=KnYmQnH2dz2CDPLQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm, memcg: Ensure valid memcg from objcg within a RCU
 critical section
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Oct 1, 2021 at 12:10 PM Waiman Long <longman@redhat.com> wrote:
>
> To ensure that a to-be-offlined memcg fetched from objcg remains
> valid (has non-zero reference count) within a RCU critical section,
> a synchronize_rcu() call is inserted at the end of memcg_offline_kmem().
>
> With that change, we no longer need to use css_tryget()
> in get_mem_cgroup_from_objcg() as the final css_put() in
> css_killed_work_fn() would not have been called yet.
>
> The obj_cgroup_uncharge_pages() function is simplifed to perform
> the whole uncharge operation within a RCU critical section saving a
> css_get()/css_put() pair.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  mm/memcontrol.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8177f253a127..1dbb37d96e49 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2769,10 +2769,8 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
>         struct mem_cgroup *memcg;
>
>         rcu_read_lock();
> -retry:
>         memcg = obj_cgroup_memcg(objcg);
> -       if (unlikely(!css_tryget(&memcg->css)))
> -               goto retry;
> +       css_get(&memcg->css);
>         rcu_read_unlock();
>
>         return memcg;
> @@ -2947,13 +2945,14 @@ static void obj_cgroup_uncharge_pages(struct obj_cgroup *objcg,
>  {
>         struct mem_cgroup *memcg;
>
> -       memcg = get_mem_cgroup_from_objcg(objcg);
> +       rcu_read_lock();
> +       memcg = obj_cgroup_memcg(objcg);
>
>         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
>                 page_counter_uncharge(&memcg->kmem, nr_pages);
>         refill_stock(memcg, nr_pages);
>
> -       css_put(&memcg->css);
> +       rcu_read_unlock();
>  }
>
>  /*
> @@ -3672,6 +3671,13 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>         memcg_drain_all_list_lrus(kmemcg_id, parent);
>
>         memcg_free_cache_id(kmemcg_id);
> +
> +       /*
> +        * To ensure that a to-be-offlined memcg fetched from objcg remains
> +        * valid within a RCU critical section, we need to wait here until
> +        * the a grace period has elapsed.
> +        */
> +       synchronize_rcu();

This is called with cgroup_mutex held from css_offline path and
synchronize_rcu() can be very expensive on a busy system, so, this
will indirectly impact all the code paths which take cgroup_mutex.

>  }
>  #else
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
> --
> 2.18.1
>
