Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5929D7CF
	for <lists+cgroups@lfdr.de>; Wed, 28 Oct 2020 23:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbgJ1W1G (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 28 Oct 2020 18:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733120AbgJ1W0v (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 28 Oct 2020 18:26:51 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C312C0613CF
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 15:26:51 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x203so1208434oia.10
        for <cgroups@vger.kernel.org>; Wed, 28 Oct 2020 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=haZrmfpmntdtUu2HCrdM+P5anuz4VVrL1riml318t4Y=;
        b=Wzk2Avtec2wOG385ie+/41UyVjBLOdjL67AfpTMKR1mWo6L8Zr7gbQPfRXt0daWbLj
         9eIB3qmpCLwzx260I5fxzOXhphezCgWwHOKXei6mqi7QJCLgPp1CjDceRVH/VQ+T04tP
         Zp86Sl6fFQHrllc1YWvLf5gS7HNMYxqKEt2BklLyD5IESzi12hAxi4Mx5L6ZjoARRl5z
         sPqXr9IRoISiz3eC5SCMsbpQn7okBqOVhaov6DVO+UGsl3Q+x8qCxRofoIlNWcwpekWD
         /4ri1aA6jajwfQ1lbm6ANjSbkWqAQC6vPpi5cTlU0sW9mFfnbh9Fj6+s+Gm3xin24haD
         uMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=haZrmfpmntdtUu2HCrdM+P5anuz4VVrL1riml318t4Y=;
        b=QNplLGNJGDH/9+WdQQbrkk6PgLXfyWMizFhe/Q4Xr2eLrVcxfWF0v/XG25xV0frLfc
         T5WIzGI9+5/Y5mreBc39ojgYxjpM3wreuwunNoSwTzkZ3bVM9T675BoUr0D+j1RkGnLt
         HwaKDQ+5KJMo1Vrt9SOSwu3DyHeCRJMKxwFNiQGIvQnVYPRAfyRuPyhmj0ggl58L81Ia
         GyPiWvlCZWVIdj6/K6/SsrALcZ9vOV5SQBVM1Rh3FwN2LtViKaFaK7L4ZCDV9LgrWkuc
         IwWN/rPzRyhJlZxTXvm5+WqgIsHmI8G5u7ymvYMAUax4X0ZPsjWe7dw+IJIAUx2Ds1TT
         ENZw==
X-Gm-Message-State: AOAM530WpZkBdkHs1/NQ/29z2Bgx+GAVbDkG6IB/CAErkxKbuJWV/Ew5
        jLqz+3b5SzDnm2EEPfC0U1EarAZm3mJ1Jv6RK7JxG9onuDNB2BSE
X-Google-Smtp-Source: ABdhPJxJ9lMlqruIazh/zmZBtfs/xi9mwEd63/HHgyDcIyU0v+lL5EPTcLvnSae+vVd+E1dNAvJuDTLaKiW21MT/xdI=
X-Received: by 2002:a17:90a:890f:: with SMTP id u15mr4764490pjn.147.1603853816824;
 Tue, 27 Oct 2020 19:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20201027080256.76497-1-songmuchun@bytedance.com>
 <20201027080256.76497-5-songmuchun@bytedance.com> <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
In-Reply-To: <20201027184835.GB827280@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 28 Oct 2020 10:56:20 +0800
Message-ID: <CAMZfGtU1aViokYk1hkHbYEiqW5QNi49UTd-QTrkycLqj6Q+-8g@mail.gmail.com>
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

On Wed, Oct 28, 2020 at 2:48 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Oct 27, 2020 at 04:02:55PM +0800, Muchun Song wrote:
> > If we reparent the slab objects to the root memcg, when we free
> > the slab object, we need to update the per-memcg vmstats to keep
> > it correct for the root memcg. Now this at least affects the vmstat
> > of NR_KERNEL_STACK_KB for !CONFIG_VMAP_STACK when the thread stack
> > size is smaller than the PAGE_SIZE.
> >
> > Fixes: ec9f02384f60 ("mm: workingset: fix vmstat counters for shadow nodes")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Can you, please, drop this patch for now?
>
> I'm working on a bigger cleanup related to the handling of the root memory
> cgroup (I sent a link earlier in this thread), which already does a similar change.
> There are several issues like this one, so it will be nice to fix them all at once.

I have read the patch of https://lkml.org/lkml/2020/10/14/869. You
mean this patch
fixes this issue? It chooses to uncharge the root memcg. But here we may need to
uncharge the root memcg to keep root vmstats correct. If we do not do
this, we can
see the wrong vmstats via root memory.stat(e.g. NR_KERNEL_STACK_KB).

Thanks.

>
> Thank you!
>
> > ---
> >  mm/memcontrol.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 22b4fb941b54..70345b15b150 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -875,8 +875,13 @@ void __mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
> >       rcu_read_lock();
> >       memcg = mem_cgroup_from_obj(p);
> >
> > -     /* Untracked pages have no memcg, no lruvec. Update only the node */
> > -     if (!memcg || memcg == root_mem_cgroup) {
> > +     /*
> > +      * Untracked pages have no memcg, no lruvec. Update only the
> > +      * node. If we reparent the slab objects to the root memcg,
> > +      * when we free the slab object, we need to update the per-memcg
> > +      * vmstats to keep it correct for the root memcg.
> > +      */
> > +     if (!memcg) {
> >               __mod_node_page_state(pgdat, idx, val);
> >       } else {
> >               lruvec = mem_cgroup_lruvec(memcg, pgdat);
> > --
> > 2.20.1
> >



-- 
Yours,
Muchun
