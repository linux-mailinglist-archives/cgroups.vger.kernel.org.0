Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B972ACB9B
	for <lists+cgroups@lfdr.de>; Tue, 10 Nov 2020 04:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgKJDUX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 9 Nov 2020 22:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKJDUX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 9 Nov 2020 22:20:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE807C0613D3
        for <cgroups@vger.kernel.org>; Mon,  9 Nov 2020 19:20:22 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f38so8947973pgm.2
        for <cgroups@vger.kernel.org>; Mon, 09 Nov 2020 19:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmZMs4GZmfJF8Fdhkv3dMimRPyWWITH+SYPWeKRj3iE=;
        b=V/8PpzAY+tj3MaT3pbJokjVFCPodRWTiKBOOsxnc5JOelQuZm4fKIz3aMJU/9mRavo
         6sqeUvW5CF7aOdRtY24WWtf2pnqJpF6d8QJqegvaLZWlSk/lE5qKa8f9bUj7N5h1IQH/
         itrE++Uoz4EefemYNYYiOcGrNoUn2daqWgwXx9XFCXw7jGEwXXw/A/mnlNz10/GU4On0
         UIRYmMjY3KcKBgYFoGlwvJGK9vaTuP87RBUE8AxVQ8BegKaXClTX48zscvECI+cAzrC8
         /hw44C1Mv1tGKJ4OEgTd0Cs5LFv7Mdj6tIPvPQt2S9UL1uhUyTDGWkF49IJYJTIM7OCB
         X3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmZMs4GZmfJF8Fdhkv3dMimRPyWWITH+SYPWeKRj3iE=;
        b=kHet7lCFwBA/imcGP/St+OCab6tsQIEvEMU2lkHHIMeo3iU+X5P7FcoiSgzBrN1z0E
         jDHyLF7QAJLhRA4XvEdrxhgjA+EITXMiRdc5ewOXVs3nxbnQP5EtFFd6Gzk6lWQoBBd+
         DgPPsUyhppTsjThbBTl/NKevMtmZHT3TOPtlVQu8/m6ec4aBjPOLJL2k6q8AElWOnAtj
         BXKPDLw6yiaGqCPW1ThG0IYHxokBCxk8HYLNWxYCinZBuYW6AOtcXLZZ12d6VXJgBGew
         ksbOeYUoYkdd2Sdv6NN2nQZsa+AeMcaf3SanPn6jC/m/3TvqqV06t+mXXZferTbf03MA
         Fbnw==
X-Gm-Message-State: AOAM531NTx8OqG7ilw50ecSOWVDv2S50S2Bd/Bsm2aGWSY6KUhXxyJfV
        hsXkPbohN4Fy1gIhR8Q+3QrUuUKicJjqP3fDfpGpfQ==
X-Google-Smtp-Source: ABdhPJy4bpxnsO5pklMkzSdiRHsoNta+GW29EFNBoBI7DxyYuC5HlF/QzQP409Ri9BAAjtrnI8ByVVoN0Qb7Sm3Jyr4=
X-Received: by 2002:a63:7408:: with SMTP id p8mr14936096pgc.273.1604978422039;
 Mon, 09 Nov 2020 19:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20201028035013.99711-1-songmuchun@bytedance.com> <20201028035013.99711-2-songmuchun@bytedance.com>
In-Reply-To: <20201028035013.99711-2-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 10 Nov 2020 11:19:46 +0800
Message-ID: <CAMZfGtVgtJ0BdL_tXzgC3qh5Bn+0GpJJNHyE5RzEm=B3GO5q2w@mail.gmail.com>
Subject: Re: [PATCH v2] mm: memcg/slab: Fix use after free in obj_cgroup_charge
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>, esyr@redhat.com,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>, areber@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 28, 2020 at 11:50 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> The rcu_read_lock/unlock only can guarantee that the memcg will
> not be freed, but it cannot guarantee the success of css_get to
> memcg.
>
> If the whole process of a cgroup offlining is completed between
> reading a objcg->memcg pointer and bumping the css reference on
> another CPU, and there are exactly 0 external references to this
> memory cgroup (how we get to the obj_cgroup_charge() then?),
> css_get() can change the ref counter from 0 back to 1.
>
> Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Hi Andrew,

Maybe you forgot to add this to the queue for the merge window?

Thanks.

> ---
>  changelog in v2:
>  1. Add unlikely and update the commit log suggested by Roman.
>
>  mm/memcontrol.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 8c8b4c3ed5a0..d9cdf899c6fc 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3221,8 +3221,10 @@ int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size)
>          * independently later.
>          */
>         rcu_read_lock();
> +retry:
>         memcg = obj_cgroup_memcg(objcg);
> -       css_get(&memcg->css);
> +       if (unlikely(!css_tryget(&memcg->css)))
> +               goto retry;
>         rcu_read_unlock();
>
>         nr_pages = size >> PAGE_SHIFT;
> --
> 2.20.1
>


--
Yours,
Muchun
