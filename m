Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB6529B00F
	for <lists+cgroups@lfdr.de>; Tue, 27 Oct 2020 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757046AbgJ0OP4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 27 Oct 2020 10:15:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34957 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757038AbgJ0OPz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 27 Oct 2020 10:15:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id 1so830414ple.2
        for <cgroups@vger.kernel.org>; Tue, 27 Oct 2020 07:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQKyukY3sNn8vMLwkS9RR/i1T1+mtDwNzg2ru7tNBSs=;
        b=e7JqdiWEdyM8LSjR0QByZe6uB/TUuo5WmCWoJ2tghcFKu/g92h7L2egphj/wJCExaG
         JXD9+u/ECQIOwwZVqiPs/MauJpBNOVCKAhboe5J/Z7LG9YRuLEleWNjcCn9WtqhJNO3o
         49oK0+EVYHTA1BlEJ4ct3b0UDVWSsubPtihkoXv8mgHOzV0Xe4fPKn9p2M470AQzvz/7
         qPnPXPoSKAUZlm2+h9DOw2DRGBNeBP9efzJDSVQEpUbq4lndcCYRdgEnWLPz0NKYK7zz
         C8smlVbEJ0xzZ8HjFn38SKPvBWz+Q0eY8btSFAA/nplFKZegw1b7ieiWi+eNO+xsu6ae
         jp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQKyukY3sNn8vMLwkS9RR/i1T1+mtDwNzg2ru7tNBSs=;
        b=LFHzCqoyL8HrDvVpGmSqhPu7MuBkR882KEL4pfvRLqMuKQtQHweND8zTaM+l9m2k0O
         qXf5dkGKuEdWWuQVuORW23ifhWvRe9ZeVKFnV+If3mAmaiA2OJSoPoDCuK0ZCBa1MMgj
         WNLskTCirffcAsu2t2iYIMuzJsKveUyaea1tsYNqinu3Ar23X4QWqSZ9nTP5TdsK8XOs
         mUHWCWLjutwta+SbpLn4bo6J32GSiJOcsPGPOYoDy73G2klW+K1mR86lJK3JNUX+uw7j
         XkloQKkyTl/RWNOitXwAC9lRBraDa/m6BO0NccqK5Ifm0cxUWkfWwLwqOaxAjP1v1b2y
         LrgA==
X-Gm-Message-State: AOAM531fsyWER0xeW8oHYpBwWDWLcMxR7Il87i7WjESXjG2ynjIjF0NS
        qU+WhIgXh9iYnyi0dDL/PFUUwq6WmX8THipGnHbAtw==
X-Google-Smtp-Source: ABdhPJxNAz2qfK78FLwUuT+HxqGc6qfBGIvHzVQWHXky+sDLyZvezHhwafmoNl3ff9piTGKinjqr8m4za/hx9/mV/G8=
X-Received: by 2002:a17:90b:198d:: with SMTP id mv13mr2255516pjb.13.1603808153898;
 Tue, 27 Oct 2020 07:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-6-songmuchun@bytedance.com> <20201027133639.GT20500@dhcp22.suse.cz>
In-Reply-To: <20201027133639.GT20500@dhcp22.suse.cz>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 27 Oct 2020 22:15:16 +0800
Message-ID: <CAMZfGtUDguQkO0nF8Vt5qUVmmu4rCQcXx4nOhqUBSLnMYs2_BA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5/5] mm: memcontrol: Simplify the mem_cgroup_page_lruvec
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, laoar.shao@gmail.com,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 27, 2020 at 9:36 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 27-10-20 16:02:56, Muchun Song wrote:
> > We can reuse the code of mem_cgroup_lruvec() to simplify the code
> > of the mem_cgroup_page_lruvec().
>
> yes, removing the code duplication is reasonable. But ...
>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  include/linux/memcontrol.h | 44 +++++++++++++++++++++++++++-----------
> >  mm/memcontrol.c            | 40 ----------------------------------
> >  2 files changed, 32 insertions(+), 52 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 95807bf6be64..5e8480e54cd8 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -451,16 +451,9 @@ mem_cgroup_nodeinfo(struct mem_cgroup *memcg, int nid)
> >       return memcg->nodeinfo[nid];
> >  }
> >
> > -/**
> > - * mem_cgroup_lruvec - get the lru list vector for a memcg & node
> > - * @memcg: memcg of the wanted lruvec
> > - *
> > - * Returns the lru list vector holding pages for a given @memcg &
> > - * @node combination. This can be the node lruvec, if the memory
> > - * controller is disabled.
> > - */
> > -static inline struct lruvec *mem_cgroup_lruvec(struct mem_cgroup *memcg,
> > -                                            struct pglist_data *pgdat)
> > +static inline struct lruvec *mem_cgroup_node_lruvec(struct mem_cgroup *memcg,
> > +                                                 struct pglist_data *pgdat,
> > +                                                 int nid)
>
> This is just wrong interface. Either take nid or pgdat. You do not want
> both because that just begs for wrong usage.

If we want to avoid abuse of mem_cgroup_node_lruvec. We can move
those functions to the memcontrol.c. And add the "static" attribute to the
mem_cgroup_node_lruvec. Just export mem_cgroup_lruvec and
mem_cgroup_page_lruvec. Is this OK?

Thanks.

> --
> Michal Hocko
> SUSE Labs

-- 
Yours,
Muchun
