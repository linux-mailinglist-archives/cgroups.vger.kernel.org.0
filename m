Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E695329F0CC
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 17:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgJ2QJg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Oct 2020 12:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgJ2QJg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Oct 2020 12:09:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906EC0613D2
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:09:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x13so2713314pfa.9
        for <cgroups@vger.kernel.org>; Thu, 29 Oct 2020 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+mBWfRe+OIpv7WsNMP7DYo0jsOnffJofR1p3pyhBTUE=;
        b=aAk00euheapwS9xRA1bncmzHvN9I+6nyRyTCd3xMc2dkkXTXJBxXHQPbZj5LEfqx2a
         5P+ylRRBoUhWmx7cNyr2tT/0FsGSiu3nvxnCMR60vF9ivHhn7fN6PfuI7sSI1nTmTQmo
         Cpv5WwRe5QSPQqqek07hNLOVeAKodbAY9krPKSDnktsyWuvqYizgHIugu8JcKb31NMV+
         OkdSCjhNrEIJar/D7QI6ipEpTto94dnCyjP78etZHXvq5x1mi0cYudGrBkKUQoTv7PFr
         aKrrRWp/VwMw6wgCLeR+efWZkXG26cYmtDRxlzGMJkKASKCh05U6EQc7wd9f0/9YGzS6
         Wz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+mBWfRe+OIpv7WsNMP7DYo0jsOnffJofR1p3pyhBTUE=;
        b=fs+qrnv4FQvafYBZg8QiYNR6vytp5rtP8GZup+ANJb/QjxZvnYEhm2L8pnvnHH+Pz6
         7n3qEn8ZKsJWP+bti2N8tX4OWk/TvZxPXCt9l7wg5d3tdEaNyzwokVxRne/A5BEsk5Vv
         MFN8vE1yAO9jKKttLq99SWTsNsBYoMLhIIqeJ1msb2rXKXyFxOh6/kCamKsQtVOPDLMs
         gWt5Xd4gs5iMzDtkfybN+ZnrHMY5sJtiZ40+DcokmDDCToiIcRoaEOUHcpJwuqMGuvab
         ONouoOduJwZmstJH9x8YkQcg10XtL7/Bg4WnDc9Hjmby2NKk8icYiWCxeI/+mWzxRSA+
         uLZw==
X-Gm-Message-State: AOAM533z6g9v57QRXuE8f1Rf2O62Mcu2Ue1GIjBlNc9o+tIIQybh7imG
        0DUK0myIvqzgkUwWYtHkHkuZfD5THvj25DUFJzVSNg==
X-Google-Smtp-Source: ABdhPJyjZSv9zU0BpVf3RV54xkfmJECDMC0KfJwx2jtsWDnpqEhS8GqFik3yU3J6Jq1TgwaIlpsiZUFmG06Lkbixnj4=
X-Received: by 2002:a17:90a:890f:: with SMTP id u15mr44881pjn.147.1603987776051;
 Thu, 29 Oct 2020 09:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com> <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
In-Reply-To: <CALvZod6p_y2fTEK5fzAL=JfPsguqYbttgWC4_GPc=rF1PsN6TQ@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 30 Oct 2020 00:08:58 +0800
Message-ID: <CAMZfGtW38sFcdpnx3Xx+RgRL37WzpQsq8qvfdnmhbh4H9Ex0cg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] mm: memcg/slab: Fix return child memcg
 objcg for root memcg
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
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

On Thu, Oct 29, 2020 at 11:48 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Oct 27, 2020 at 8:50 PM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > Consider the following memcg hierarchy.
> >
> >                     root
> >                    /    \
> >                   A      B
> >
> > If we get the objcg of memcg A failed,
>
> Please fix the above statement.

Sorry, could you be more specific, I don't quite understand.
Thanks.


>
> > the get_obj_cgroup_from_current
> > can return the wrong objcg for the root memcg.
> >
> > Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  changelog in v2:
> >  1. Do not use a comparison with the root_mem_cgroup
> >
> >  mm/memcontrol.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 1337775b04f3..8c8b4c3ed5a0 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -2961,6 +2961,7 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> >                 objcg = rcu_dereference(memcg->objcg);
> >                 if (objcg && obj_cgroup_tryget(objcg))
> >                         break;
> > +               objcg = NULL;
>
> Roman, in your cleanup, are you planning to have objcg for root memcg as well?
>
> >         }
> >         rcu_read_unlock();
> >
> > --
> > 2.20.1
> >



--
Yours,
Muchun
