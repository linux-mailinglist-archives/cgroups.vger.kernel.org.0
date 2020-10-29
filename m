Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00D229F641
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 21:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgJ2UfL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgJ2UfL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 16:35:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9098C0613D4
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 13:35:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l2so5064353lfk.0
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 13:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XV2GOJYljlEE+y8Fc2upH2so5LQLqqQFfNl/qA4qXms=;
        b=ZDafbgdWjCYVWb2fYN22STVuj4OuN68Nk3oJX2aD4PBwf6emSzHP79/hypkJKAypWU
         39EfEDu9Bc9wTVDFhx+C0to6aZ56jTsTIq3joLV1KilN3iGKc94/TwETmzHNovo7OqpV
         v5V29xRb3fdut5xJdax8hQGV57s2384VMJeksTLBSUezvvBM+nnTkXacAma1QueQ5zJL
         VKXkL0TEgTsihNQXg9cOyUB4E1xY2yQY4VdiFnvcMcC08TaWFxXjZEJ2tX/xlZdAT+2J
         jxoi5Z6RM6TWwOJH3cRUf3YnNkuDLX8v5F+kDq8HSmRip2hmjbQX5s4eu0sywa/qjihw
         5egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XV2GOJYljlEE+y8Fc2upH2so5LQLqqQFfNl/qA4qXms=;
        b=gFRS+8/94fLpjVfy5JpfHC1dUDWxmO8suRG2BwXiX0v15qBpV1VlNQ0JN2GKQ5KBqD
         JzkJk75NdQwboBcK0Df2y6VyilL0tRBm86XGTnlEvsgwyL4R3nkXKYsrf9iHWnZoRPzm
         CqBWHKnv6lmUetgs4wWJDAGYaG9hQFHHRAxwL3Xz8Dk8U6WuNoJB0ycHvPLtXQwGGX5D
         QaYOzmZgNieY+wxfX493TnZ5792cfU3+Sw+iEJorNEPR0F6EgbI58dE0ne78Ca9BYu+l
         rk8LceCSDEShXjd6mYuaVruSjUids4ss0MFRLBlRmsNrS2xxi22jkfmtG7qBeZRDb+F6
         CpHg==
X-Gm-Message-State: AOAM533UxUgSn3C9489+HacSuUNKYOX/+b/HVfXZX4h+UvP4q3tAAfea
        h1Fudo3mIyoRlmebIPyM86G//+/vjwubJ1HlXuajdg==
X-Google-Smtp-Source: ABdhPJzToJVR9lbEl9kreiI8zU1CLCJ/Mn6i7FmBBW6CH96l0Neszh4F9GkSq7pRBLOFabPREx6qJEeYRpYZo/lG0pU=
X-Received: by 2002:a19:85c2:: with SMTP id h185mr2405045lfd.494.1604003708840;
 Thu, 29 Oct 2020 13:35:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com>
 <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com> <20201029170955.GI827280@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201029170955.GI827280@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 29 Oct 2020 13:34:57 -0700
Message-ID: <CALvZod65MhzQiwGgLM89_gZzCFDaeSZofn08viPgcvra0JRvSg@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix return child memcg objcg for root memcg
To:     Roman Gushchin <guro@fb.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Chris Down <chris@chrisdown.name>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, esyr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>, areber@redhat.com,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Oct 29, 2020 at 10:10 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Thu, Oct 29, 2020 at 08:48:45AM -0700, Shakeel Butt wrote:
> > On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > Consider the following memcg hierarchy.
> > >
> > >                     root
> > >                    /    \
> > >                   A      B
> > >
> > > If we get the objcg of memcg A failed,
> >
> > Please fix the above statement.
> >
> > > the get_obj_cgroup_from_current
> > > can return the wrong objcg for the root memcg.
> > >
> > > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > ---
> > >  changelog in v2:
> > >  1. Do not use a comparison with the root_mem_cgroup
> > >
> > >  mm/memcontrol.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 1337775b04f3..8c8b4c3ed5a0 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > >                 objcg = rcu_dereference(memcg->objcg);
> > >                 if (objcg && obj_cgroup_tryget(objcg))
> > >                         break;
> > > +               objcg = NULL;
> >
> > Roman, in your cleanup, are you planning to have objcg for root memcg as well?
>
> Yes. I'll just change the for loop to include the root_mem_cgroup.
>

Then do we really need this patch since it's not tagged for stable?
