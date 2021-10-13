Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C587B42C68E
	for <lists+cgroups@lfdr.de>; Wed, 13 Oct 2021 18:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhJMQnc (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhJMQnc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 12:43:32 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B21C061570
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 09:41:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u18so14392600lfd.12
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 09:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPgT6NXkn4m3r7Gqf6Xmq+r6xoZWYcfKJwECpES7gkc=;
        b=j68WJ+Mb8FMm8l4fHho6NGTbOMBz8V0Esm2L6IrXhNA4GrhqPjtC5bpmOiBZd6f/SJ
         hVygO36l2sFF8R34+9Q8XkwmIi0piebgNava8RuVeQwHa6bCvsGFsLpTEmNn7aHZX3wI
         eyD+/2xd6PmgZZLbIh2rCbvv2q/TsOiRUsaa25+sW5t+RjDNFiFduRI4g4CO/4XbeHrm
         PB31+y8sTL3/fi58B0snsJWsdDDf4qlvvs5PshkrUWq2pk64SvvtcNLGNa6x+QHh83od
         GFap54IAUwgcHkV6ZdM6uPMGnIiXsZa67MZH0t1OysgFihi8CYe/q7+/lvQ58teM0na0
         cgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPgT6NXkn4m3r7Gqf6Xmq+r6xoZWYcfKJwECpES7gkc=;
        b=h/1ZtQsgud4mEKfN7KuU57PzfPu0S43XGhm+qBkTSTW7LDsmkJPXm6dZHBElwsQVxL
         BCI4tDyQ+d6+T/phiBUGD5A0ExrfGrWAIMgzhubjaawbw91ud/9/9i8LE0d9k3xUoAB1
         Bd04MiVwAvnIWuMbVFQNVYnegwSsrChzQZT1r4RoZ9t67XGHHvkHlGYMH5sqTQaJxO0H
         Kdsec56BfIaE+xsDaklfv71soqI6ar4wvwniBYUmOXixfN87okltzorgUInb+MVYPRNy
         9Go8IundSwfRjyR8uxafOQ67+oVKkJSMv0/3WO/g0ELguWyq0yPesHK6L2t3pqEL0Nn0
         +tdQ==
X-Gm-Message-State: AOAM531310pbuMbcnwM4wDZ/0CbtmN4cK+pzButni/6vQTunHcdjJhDi
        HmopIqqKX1kzUtMBhdQWdc7ZO/3taBk7aYG4UB7Mxg==
X-Google-Smtp-Source: ABdhPJxQ7dROOW3GwYwJZv5cEP72W9nSPXf3G+FjF80FpcnyLSbosTXFRKMtNJ72yGKJsFPgIFJuaApet6UQxb5ou5s=
X-Received: by 2002:ac2:4e02:: with SMTP id e2mr113350lfr.264.1634143286611;
 Wed, 13 Oct 2021 09:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com>
 <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com> <YWWrai/ChIgycgCo@dhcp22.suse.cz>
 <CALvZod7LpEY98r=pD-k=WbOT-z=Ux16Mfmv3s7PDtJg6=ZStgw@mail.gmail.com> <YWXS09ZBhZSy6FQQ@dhcp22.suse.cz>
In-Reply-To: <YWXS09ZBhZSy6FQQ@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 09:41:15 -0700
Message-ID: <CALvZod6K6UXxDrkHp=mVDV7O-fAtmRkgMDngPazBhcyDUNxy_Q@mail.gmail.com>
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in __alloc_pages_bulk
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 12, 2021 at 11:24 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 12-10-21 09:08:38, Shakeel Butt wrote:
> > On Tue, Oct 12, 2021 at 8:36 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Tue 12-10-21 17:58:21, Vasily Averin wrote:
> > > > Enable memory accounting for bulk page allocator.
> > >
> > > ENOCHANGELOG
> > >
> > > And I have to say I am not very happy about the solution. It adds a very
> > > tricky code where it splits different charging steps apart.
> > >
> > > Would it be just too inefficient to charge page-by-page once all pages
> > > are already taken away from the pcp lists? This bulk should be small so
> > > this shouldn't really cause massive problems. I mean something like
> > >
> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > > index b37435c274cf..8bcd69195ef5 100644
> > > --- a/mm/page_alloc.c
> > > +++ b/mm/page_alloc.c
> > > @@ -5308,6 +5308,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
> > >
> > >         local_unlock_irqrestore(&pagesets.lock, flags);
> > >
> > > +       if (memcg_kmem_enabled() && (gfp & __GFP_ACCOUNT)) {
> > > +               /* charge pages here */
> > > +       }
> >
> > It is not that simple because __alloc_pages_bulk only allocate pages
> > for empty slots in the page_array provided by the caller.
> >
> > The failure handling for post charging would be more complicated.
>
> If this is really that complicated (I haven't tried) then it would be
> much more simple to completely skip the bulk allocator for __GFP_ACCOUNT
> rather than add a tricky code. The bulk allocator is meant to be used
> for ultra hot paths and memcg charging along with the reclaim doesn't
> really fit into that model anyway. Or are there any actual users who
> really need bulk allocator optimization and also need memcg accounting?

Bulk allocator is being used for vmalloc and we have several
kvmalloc() with __GFP_ACCOUNT allocations.

It seems like Vasily has some ideas, so let's wait for his next version.
