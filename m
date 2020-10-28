Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A4029DC75
	for <lists+cgroups@lfdr.de>; Thu, 29 Oct 2020 01:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388585AbgJ2Aac (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 20:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgJ2A2c (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 20:28:32 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C68C0613CF
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 17:28:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t6so446802plq.11
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 17:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yam/p71AJ8As7tsiU5BDigXfn1EtsRyjjS0tu9YDXrE=;
        b=zI0AZyeopougGJaeeJKxiy2HLVVsv26SHyuC9lZGn3mHVPG4adTo3D+aO+j0XR44ci
         FfTwaVnJRPi9zVvA6hpf1ZaFfoCoURpS9XHlqQg+ZrxnBO+E8rPyP0tqmQnY3nnjeq9r
         5VGafNNKYn89gOl63qP9XNkAmVpb19eKTiDG3hK4i8x4UAVa72s7TO+CBx0vfglLdF1+
         APNMSS+vFOYw1EXZr6atQtq2nZsb9X0cMA/NSVed5Q/XK5jmkE6PRoRpodiGA9qxLOTT
         qkdrX0ZygO5jnlaXcOL8hyXIPHhNTjGGK/dgRNviCW59mfPLSiuYuaCRwSiCT2KtnBYY
         zj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yam/p71AJ8As7tsiU5BDigXfn1EtsRyjjS0tu9YDXrE=;
        b=R7wdUih61//9VKHZvsnv4M/ER2XzzXfMRhlIA7oazJc4EUwUEOM9G9d3laMlpKvjHK
         TPJVAuJB993vksbbQF6XM/1vJ8/2RL1vZgVnb/spykfLj9f06OhMsO3QOzcJSKkqF9kF
         Rw51zhIf5ubL55TQS9fw3ZrN14VVKe4QV3Dzp4ESCYyTs5MHx/MavC6LKnq2JNeO7VF/
         Px6KaScIUTFFttWR/3W/nCjy6l2SwWRKiHuFI5574kjg2TdyFOU/lqldq7ClKBSYW1mN
         Kkn/4cRiyyXYlxETrWLBlodUQnncNJPKTh3u6oF9DqWmZ0PvEOFFNchcmAC+T7EUXtMR
         CFSA==
X-Gm-Message-State: AOAM531d6+fky9fgZW6Ds8MgBCqHzglAx04Jw3uESvKMWkBq4ENBwe+5
        1t1tlCwP5eKuYEK8JSOQEuwzJ1j6JcR8X72+tm02wpzE9ETbVJ1n
X-Google-Smtp-Source: ABdhPJzcyOPjVfOlUg3PViyAu/gl+jzGPcviCKBDSBikqH/3CYMmhNba4abq3ls5eRn44xWfRFIFC7RRs9VhhTS4d7U=
X-Received: by 2002:a17:902:6803:b029:d2:42a6:312 with SMTP id
 h3-20020a1709026803b02900d242a60312mr5401682plk.24.1603856909433; Tue, 27 Oct
 2020 20:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-5-songmuchun@bytedance.com> <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
 <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com>
In-Reply-To: <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 28 Oct 2020 11:47:52 +0800
Message-ID: <CAMZfGtWP9k8kCY0QxRdoLn1MQ8aiP_R_bRqLYiuGdznRdgFk6g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 4/5] mm: memcg/slab: Fix root memcg vmstats
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
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

On Wed, Oct 28, 2020 at 10:56 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Wed, Oct 28, 2020 at 2:48 AM Roman Gushchin <guro@fb.com> wrote:
> >
> > On Tue, Oct 27, 2020 at 04:02:55PM +0800, Muchun Song wrote:
> > > If we reparent the slab objects to the root memcg, when we free
> > > the slab object, we need to update the per-memcg vmstats to keep
> > > it correct for the root memcg. Now this at least affects the vmstat
> > > of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> > > size is smaller than the PAGE_SIZE.
> > >
> > > Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >
> > Can you, please, drop this patch for now?
> >
> > I'm working on a bigger cleanup related to the handling of the root memory
> > cgroup (I sent a link earlier in this thread), which already does a similar change.
> > There are several issues like this one, so it will be nice to fix them all at once.
>
> I have read the patch of https://lkml.org/lkml/2020/10/14/869. You
> mean this patch
> fixes this issue? It chooses to uncharge the root memcg. But here we may need to

Here I mean "It chooses to not uncharge the root memcg", sorry.

> uncharge the root memcg to keep root vmstats correct. If we do not do
> this, we can
> see the wrong vmstats via root memory.stat(e.g. NR_KERNEL_STACK_KB).
>
> Thanks.
>
> >
> > Thank you!
> >
> > > ---
> > >  mm/memcontrol.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > index 22b4fb941b54..70345b15b150 100644
> > > --- a/mm/memcontrol.c
> > > +++ b/mm/memcontrol.c
> > > @@ -875,8 +875,13 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
> > >       rcu_read_lock();
> > >       memcg = mem_cgroup_from_obj(p);
> > >
> > > -     /* Untracked pages have no memcg, no lruvec. Update only the node */
> > > -     if (!memcg || memcg == root_mem_cgroup) {
> > > +     /*
> > > +      * Untracked pages have no memcg, no lruvec. Update only the
> > > +      * node. If we reparent the slab objects to the root memcg,
> > > +      * when we free the slab object, we need to update the per-memcg
> > > +      * vmstats to keep it correct for the root memcg.
> > > +      */
> > > +     if (!memcg) {
> > >               __mod_node_page_state(pgdat, idx, val);
> > >       } else {
> > >               lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > > --
> > > 2.20.1
> > >
>
>
>
> --
> Yours,
> Muchun



-- 
Yours,
Muchun
