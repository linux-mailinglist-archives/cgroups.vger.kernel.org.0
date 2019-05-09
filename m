Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB81B18DA2
	for <lists+cgroups@lfdr.de>; Thu,  9 May 2019 18:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfEIQGM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 9 May 2019 12:06:12 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39077 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfEIQGM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 9 May 2019 12:06:12 -0400
Received: by mail-yw1-f67.google.com with SMTP id w21so2293716ywd.6
        for <cgroups@vger.kernel.org>; Thu, 09 May 2019 09:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bZRaBuaJVzOagPgAxGnwl37KeIxRpAUuki7qHiwS7w=;
        b=lQJMF1J3Hq9E2jyZLMr011Qppcx+H+511s6SILzdH2F5jrBYvd7nkNxUY1FX0ESHU7
         EgKbptxzbUfCTPygnZGyReLUb6p9aZ5h7qv0WnVnKliRI4f8Lurl9Ge0Vs/nEGhf/jko
         JbCaUPv2yMdy3be/pvaZJp7d9vfwtZ5/67SB5faK9ry2CYsF92ymF5Dq6lJLWefmso/h
         1D1bPpKvuwR5vDBgRn24Uo/XG2Ix49bJ+Kw+A9NggKf4vPZougpgmSRsEstw0q4KVhn6
         WCWdjAJfCFckonpFRaVdI99ABUANiwAVNrk3EwUJS/3kNJTH/mlTAc2Ln+sA8c/Ma63n
         5Uig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bZRaBuaJVzOagPgAxGnwl37KeIxRpAUuki7qHiwS7w=;
        b=sVjsbkyGBn9jIUSF+sfuikrsaaJF6xVWu2NRkEtggXtTKI4vSdn1C0sM8si87ssT1+
         EMPlvD8UidKelTHSsJ0IbIrP4++2FwgSW++ZGxNPkP1sybrycwcCeB6+u+bOeuXc3G3B
         7YDUO/6ip8S3pf6l8ONep52dJd/TBS7WlMuv7Yo3e0PXyCs59zOTr/gRFiqx/OCzxr3P
         5gP9LWpf2tRpwUjwOL1S6bUBKgwg2tjoNXG2Dn9f0NggTGtJAO9t5XkhOM/Q3bLKU7nj
         Ktfu7o/uYo9vuwDutPZOC1LX8ZdAhUHC7u42pGozxf8J2nvLmBGRc5RQsYlVPq3kISTf
         07aw==
X-Gm-Message-State: APjAAAWb+/U5fp0o1zsSt3w6xsEMG+ARQJKzx/N5Rlo2xyCfMsQnzz2U
        Sld980xsqJogMDy0C0OEdqyEGRThhrZ1U3QO0puz4w==
X-Google-Smtp-Source: APXvYqweZrD+zILYGdfGDFSodB430IV2ssIGLyfSySK91X9eI9OCm0enlDb2HZZMq2Dl6OiaG9Agp2/SSX2hbrTSMcs=
X-Received: by 2002:a25:6708:: with SMTP id b8mr2579929ybc.377.1557417970993;
 Thu, 09 May 2019 09:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <359d98e6-044a-7686-8522-bdd2489e9456@suse.cz> <20190429105939.11962-1-jslaby@suse.cz>
 <20190509122526.ck25wscwanooxa3t@esperanza>
In-Reply-To: <20190509122526.ck25wscwanooxa3t@esperanza>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 9 May 2019 09:05:59 -0700
Message-ID: <CALvZod5MseXtY_BTHegdqBphCein20ou=zbvYymBJ9_zTUdWmg@mail.gmail.com>
Subject: Re: [PATCH] memcg: make it work on sparse non-0-node systems
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Jiri Slaby <jslaby@suse.cz>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 9, 2019 at 5:25 AM Vladimir Davydov <vdavydov.dev@gmail.com> wrote:
>
> On Mon, Apr 29, 2019 at 12:59:39PM +0200, Jiri Slaby wrote:
> > We have a single node system with node 0 disabled:
> >   Scanning NUMA topology in Northbridge 24
> >   Number of physical nodes 2
> >   Skipping disabled node 0
> >   Node 1 MemBase 0000000000000000 Limit 00000000fbff0000
> >   NODE_DATA(1) allocated [mem 0xfbfda000-0xfbfeffff]
> >
> > This causes crashes in memcg when system boots:
> >   BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
> >   #PF error: [normal kernel read fault]
> > ...
> >   RIP: 0010:list_lru_add+0x94/0x170
> > ...
> >   Call Trace:
> >    d_lru_add+0x44/0x50
> >    dput.part.34+0xfc/0x110
> >    __fput+0x108/0x230
> >    task_work_run+0x9f/0xc0
> >    exit_to_usermode_loop+0xf5/0x100
> >
> > It is reproducible as far as 4.12. I did not try older kernels. You have
> > to have a new enough systemd, e.g. 241 (the reason is unknown -- was not
> > investigated). Cannot be reproduced with systemd 234.
> >
> > The system crashes because the size of lru array is never updated in
> > memcg_update_all_list_lrus and the reads are past the zero-sized array,
> > causing dereferences of random memory.
> >
> > The root cause are list_lru_memcg_aware checks in the list_lru code.
> > The test in list_lru_memcg_aware is broken: it assumes node 0 is always
> > present, but it is not true on some systems as can be seen above.
> >
> > So fix this by checking the first online node instead of node 0.
> >
> > Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> > Cc: <cgroups@vger.kernel.org>
> > Cc: <linux-mm@kvack.org>
> > Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> > ---
> >  mm/list_lru.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> >
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index 0730bf8ff39f..7689910f1a91 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
> >
> >  static inline bool list_lru_memcg_aware(struct list_lru *lru)
> >  {
> > -     /*
> > -      * This needs node 0 to be always present, even
> > -      * in the systems supporting sparse numa ids.
> > -      */
> > -     return !!lru->node[0].memcg_lrus;
> > +     return !!lru->node[first_online_node].memcg_lrus;
> >  }
> >
> >  static inline struct list_lru_one *
>
> Yep, I didn't expect node 0 could ever be unavailable, my bad.
> The patch looks fine to me:
>
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
>
> However, I tend to agree with Michal that (ab)using node[0].memcg_lrus
> to check if a list_lru is memcg aware looks confusing. I guess we could
> simply add a bool flag to list_lru instead. Something like this, may be:
>

I think the bool flag approach is much better. No assumption on the
node initialization.

If we go with bool approach then add

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index aa5efd9351eb..d5ceb2839a2d 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -54,6 +54,7 @@ struct list_lru {
>  #ifdef CONFIG_MEMCG_KMEM
>         struct list_head        list;
>         int                     shrinker_id;
> +       bool                    memcg_aware;
>  #endif
>  };
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index 0730bf8ff39f..8e605e40a4c6 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -37,11 +37,7 @@ static int lru_shrinker_id(struct list_lru *lru)
>
>  static inline bool list_lru_memcg_aware(struct list_lru *lru)
>  {
> -       /*
> -        * This needs node 0 to be always present, even
> -        * in the systems supporting sparse numa ids.
> -        */
> -       return !!lru->node[0].memcg_lrus;
> +       return lru->memcg_aware;
>  }
>
>  static inline struct list_lru_one *
> @@ -451,6 +447,7 @@ static int memcg_init_list_lru(struct list_lru *lru, bool memcg_aware)
>  {
>         int i;
>
> +       lru->memcg_aware = memcg_aware;
>         if (!memcg_aware)
>                 return 0;
>
