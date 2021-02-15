Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB631B811
	for <lists+cgroups@lfdr.de>; Mon, 15 Feb 2021 12:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhBOLfe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Feb 2021 06:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhBOLfb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Feb 2021 06:35:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9F2C061756
        for <cgroups@vger.kernel.org>; Mon, 15 Feb 2021 03:34:50 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so3743418pjs.4
        for <cgroups@vger.kernel.org>; Mon, 15 Feb 2021 03:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l865vVupJANTr8r5LWdTPagS4MMpwqLzjm7i9kZsffo=;
        b=DIldKF3h+HGUTTkXdgO1HcOE27rqK13KgreCr9rYNZM8vICXYReY2h1jmZuKluHWy6
         u0OVEHaui4daB/x4TMYYhtClWcVjd1m0fdqohXkkGUvciosAGNz19JMJKwZjpgsgVYun
         on/KKfyItRgN7nvYufhX57/gHvVHvbYZ85k5wudAbXNnIkIYvWm3I+a1huWJHa/WETt+
         T3XhrQqmyWPiGhhIldBpdvNYQe8AVk5kWi2g7mr8bcIlLaXchSl9uV+bYshA2SdQP43t
         LhLaWW0/L8V7oh/rZ7cmJNLPSF9/zdfqgLlci7t0NEXtRvi0YuqKCmENP0WrKrJ+Awnv
         5k7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l865vVupJANTr8r5LWdTPagS4MMpwqLzjm7i9kZsffo=;
        b=i9NOVTgVidjqhyHQKidl+dujDfxeWo2++kVp7NG/SkCyAj3T6bwYw6VwsWdi52nwz8
         4CSnBajJNbVrBoVy3V+IHQ/c0TtTA80gIL7WgQjerrzveotKW9RSmivESA6tEmkUIC+E
         zHrdVswMbS1/B8cVRqisVBxUvpuCtA0nDv5jstGQ2IrZqRxR0Ml9D0z5nC1s37ZNq9ef
         If8bsjN+93bmQujM5prh+Idgf9oRt3/Kz65B0uOeXNESpW6W+0RbX42Ru0zLUu+ptieC
         pidulK1ix9APxgX3pWYzmXBjBsAmCHLLCT4l5fC5NsUtqeMS2G807c7JSFIvEFwpRXkq
         dc1Q==
X-Gm-Message-State: AOAM533EnZt/MoXCyCpTwq1LiV0LsZMZlTKbOBsxEieCbdHpzyjjdmdF
        Ghv6iq285RHb3GnfHTNWux89yVZ4PBNG42EqwIMyx6CEISu06Q==
X-Google-Smtp-Source: ABdhPJwxcxvwODy8C+DbFH/mkU9NvXGvPpfF0/C61BusA2btA/ciWluIl8Up2QQUeiwNml5TBWl1KweOn9KuNLOY9fs=
X-Received: by 2002:a17:902:9341:b029:e1:7b4e:57a8 with SMTP id
 g1-20020a1709029341b02900e17b4e57a8mr14845364plp.34.1613388890312; Mon, 15
 Feb 2021 03:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20210212170159.32153-1-songmuchun@bytedance.com>
 <20210212170159.32153-3-songmuchun@bytedance.com> <YCpBUm2N4Bqm5PM5@dhcp22.suse.cz>
 <CAMZfGtVkh-DeYLLo8Nn7kHMCq055RSvL03eON1iqmhydYiQ-iQ@mail.gmail.com> <YCpMo6gLFyqANsgd@dhcp22.suse.cz>
In-Reply-To: <YCpMo6gLFyqANsgd@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 15 Feb 2021 19:34:13 +0800
Message-ID: <CAMZfGtUD3H6e+s_n+2q9aE3ABKJaooRj_vyELBaTTVUssSK-NA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 3/4] mm: memcontrol: bail out early when id
 is zero
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Feb 15, 2021 at 6:27 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 15-02-21 18:09:44, Muchun Song wrote:
> > On Mon, Feb 15, 2021 at 5:39 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Sat 13-02-21 01:01:58, Muchun Song wrote:
> > > > The memcg ID cannot be zero, but we can pass zero to mem_cgroup_from_id,
> > > > so idr_find() is pointless and wastes CPU cycles.
> > >
> > > Is this possible at all to happen? If not why should we add a test for
> > > _all_ invocations?
> >
> > Yeah, this indeed can happen. If we allocate a new swap cache page
> > and charge it via mem_cgroup_charge, then the page will uncharge
> > the swap counter via mem_cgroup_uncharge_swap. When the swap
> > entry is indeed freed, we will call mem_cgroup_uncharge_swap again,
> > In this routine, we can pass zero to mem_cgroup_from_id. Right?
>
> If the above claim is correct, which I would need to double check then
> it should have been part of the changelog! Please think of your poor
> reviewers and the time they have to invest into the review.

The easy way may be adding a printk to mem_cgroup_from_id when
the parameter is zero.

>
> I would also like to see your waste of CPU cycles argument to be backed
> by something. Are we talking about cycles due to an additional function

Yeah, when the parameter is already zero, idr_find() must return zero.
So I think that the additional function call is unnecessary. I have added
a printk to mem_cgroup_from_id, I found the parameter can be zero
several times.

> call? Is this really something we should even care about?

Maybe not. Just my thoughts.

Thanks.

>
> > > >
> > > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > > ---
> > > >  mm/memcontrol.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index a3f26522765a..68ed4b297c13 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5173,6 +5173,9 @@ static inline void mem_cgroup_id_put(struct mem_cgroup *memcg)
> > > >  struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
> > > >  {
> > > >       WARN_ON_ONCE(!rcu_read_lock_held());
> > > > +     /* The memcg ID cannot be zero. */
> > > > +     if (id == 0)
> > > > +             return NULL;
> > > >       return idr_find(&mem_cgroup_idr, id);
> > > >  }
> > > >
> > > > --
> > > > 2.11.0
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
>
> --
> Michal Hocko
> SUSE Labs
