Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58C724C279
	for <lists+cgroups@lfdr.de>; Thu, 20 Aug 2020 17:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbgHTPrX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Aug 2020 11:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbgHTPqr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Aug 2020 11:46:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F56DC061342
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 08:46:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t23so2632912ljc.3
        for <cgroups@vger.kernel.org>; Thu, 20 Aug 2020 08:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1RrYNr31NQi6xNHXP2IRc+NcviE0ZSrBQayM98jfLA=;
        b=B66nR30x++j+0C6TC7iGxqjyYlJdwDK1j7E7nieS/4aXdOCO0M8a/jFKAtiw85Q+nG
         ieb5GxU155DY0Dh3SvFGyBaBDNAb6JRuhPmIt7S+QiiKGe2bQTwVYBoA1fGVAU6okfSJ
         RRiTXS4u+PFueBC8wjb2zeohu0Ie7ja9DN+i3K16n3LUK6HEk0fMCd6dWblnnKyS2ei7
         3eQdvarbSACmkDn6nfAzjuUUh8yXU7o3Jcg+0En+/v7rM1MxUqbvc/RReMDdW9up1bHA
         LT7SQl4hEfm16MsHes5PHoJ2qRPzuijyk+uljFR0v7utOJtWG3CitkqEh2kSy7/awP0c
         a3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1RrYNr31NQi6xNHXP2IRc+NcviE0ZSrBQayM98jfLA=;
        b=BqavxO6HQNA8pNQgqHbhpIYzJPFWbrpyl/U4wFJiKU+vgRBljGi5oRXg44y5nngNWx
         5CCAco3KYEpeCwbjOtz+c4jUu3b4LR0y/s98n3bvVJ+57hhT9ekmr7S4qCSTiZQMKIsD
         qy9TJYMyjPrTKo4bSTbTcbhlAGDbZx4M3rqD03tSOaAUSn1IC94PmJFfBDoyEQLt7sqo
         bwCls1OU500qX5UUKRD+E54TXTS2K3o3pMOwn19Gtyz80kkIZ6khQgRUznbaKDdYADSl
         Y5HZgvXeSCTqCQFazK6FcEFqyC74z7TZKDYEmIm3dTxLGVdOwGhjv520f8YHzodvOekP
         jquA==
X-Gm-Message-State: AOAM530jA3gGY/TyRdCUXSdPwpxZrxqfcquoGneor7g5GnEKGKjVzDhK
        Jf9+jYGg6hzOD7T+b3/T0seJGASmciZ7r4GE2KzgyQ==
X-Google-Smtp-Source: ABdhPJwoCdm+N1AxiYk/1lBjrYcLmf0ZuNk8IyAfuDNgXgQHz2fUUgkcpq+Tblv/Rig+AH7Vx7Rd11XIpM05l6TL+ws=
X-Received: by 2002:a2e:2a04:: with SMTP id q4mr1770388ljq.192.1597938403738;
 Thu, 20 Aug 2020 08:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200820130350.3211-1-longman@redhat.com> <20200820130350.3211-4-longman@redhat.com>
In-Reply-To: <20200820130350.3211-4-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 08:46:32 -0700
Message-ID: <CALvZod7cNkjgd_YWzPSFm=AeC8sy5kWspX3J_Q7237Q9+N5Pxw@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/memcg: Unify swap and memsw page counters
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Aug 20, 2020 at 6:04 AM Waiman Long <longman@redhat.com> wrote:
>
> The swap page counter is v2 only while memsw is v1 only. As v1 and v2
> controllers cannot be active at the same time, there is no point to keep
> both swap and memsw page counters in mem_cgroup. The previous patch has
> made sure that memsw page counter is updated and accessed only when in
> v1 code paths. So it is now safe to alias the v1 memsw page counter to v2
> swap page counter. This saves 14 long's in the size of mem_cgroup. This
> is a saving of 112 bytes for 64-bit archs.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/memcontrol.h | 3 +--
>  mm/memcontrol.c            | 8 +++++---
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index d0b036123c6a..d2a819d7db70 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -216,10 +216,9 @@ struct mem_cgroup {
>
>         /* Accounted resources */
>         struct page_counter memory;
> -       struct page_counter swap;
> +       struct page_counter swap;       /* memsw (memory+swap) for v1 */
>
>         /* Legacy consumer-oriented counters */
> -       struct page_counter memsw;
>         struct page_counter kmem;
>         struct page_counter tcpmem;
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d219dca5239f..04c3794cdc98 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -68,6 +68,11 @@
>
>  #include <trace/events/vmscan.h>
>
> +/*
> + * The v1 memsw page counter is aliased to the v2 swap page counter.
> + */
> +#define memsw  swap
> +

Personally I would prefer a union instead of #define.

>  struct cgroup_subsys memory_cgrp_subsys __read_mostly;
>  EXPORT_SYMBOL(memory_cgrp_subsys);
>
> @@ -5279,13 +5284,11 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>                 memcg->use_hierarchy = true;
>                 page_counter_init(&memcg->memory, &parent->memory);
>                 page_counter_init(&memcg->swap, &parent->swap);
> -               page_counter_init(&memcg->memsw, &parent->memsw);
>                 page_counter_init(&memcg->kmem, &parent->kmem);
>                 page_counter_init(&memcg->tcpmem, &parent->tcpmem);
>         } else {
>                 page_counter_init(&memcg->memory, NULL);
>                 page_counter_init(&memcg->swap, NULL);
> -               page_counter_init(&memcg->memsw, NULL);
>                 page_counter_init(&memcg->kmem, NULL);
>                 page_counter_init(&memcg->tcpmem, NULL);
>                 /*
> @@ -5414,7 +5417,6 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>
>         page_counter_set_max(&memcg->memory, PAGE_COUNTER_MAX);
>         page_counter_set_max(&memcg->swap, PAGE_COUNTER_MAX);
> -       page_counter_set_max(&memcg->memsw, PAGE_COUNTER_MAX);
>         page_counter_set_max(&memcg->kmem, PAGE_COUNTER_MAX);
>         page_counter_set_max(&memcg->tcpmem, PAGE_COUNTER_MAX);
>         page_counter_set_min(&memcg->memory, 0);
> --
> 2.18.1
>
