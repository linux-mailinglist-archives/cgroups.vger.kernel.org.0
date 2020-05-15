Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D581D55C8
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 18:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOQWl (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 12:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgEOQWk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 12:22:40 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B86C061A0C
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 09:22:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 188so2297099lfa.10
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LwkHsen3NI9Qjxc8I+4g+FNh2Cs/D3EN1SDGWhqmxT8=;
        b=aohSNYsozE1gmyNt6a/bn8p591nfusDxfsuZvl6ankPpMCbYC99qbtKvt5NCGEakzU
         p7zkMnAUWEiSnhbKL/KRZBv1d7Dg3YJO+zmwtNfTThMwsRi7DEFGQjyIRoUFzlVHjc8p
         Dua2yaPxAQk9gtoMWnKgcgnm8pYEumr6+/iGbqoVphcwZ3s3lBUgnPStjR349BAuYVN6
         Qd3+dkNmId7D6L8XTOAGxIJvsWmurSbhfQgcAqcIwC1E1V4fY3uf3pQms06iqbxnwCn3
         ks1X7eTOkQRetzceSzg6MVptj7ipgCT8dKXcC75kXbqKVlanO+uYBTWa8P2ZHk0fxJoD
         yKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LwkHsen3NI9Qjxc8I+4g+FNh2Cs/D3EN1SDGWhqmxT8=;
        b=D9A0L17GY1PD6VrPF7ToojZExTgGA+0o4yHD1Oy0TimKV1y6myb9RSnEHTXlz+kpiN
         pmHRG5vVKvcfeeFT1pLnxWnUDOnQrcYOU0r0vK+D7/BqIi48KGbccN3S8jyKPGw+Prss
         nHHNWnHHjpxRbC/c8Me6vw0ayiChf/YtA+jy3WGTgWNM5lqYS129axhev/PzZdRhKbzo
         6+1u5vemv+mfxve8uh5OrLr1oEdhQ4Gea0yfCLbvmksTrZzPGSac+bwR/uEAJA+vSWQT
         IbFeMeGpxWc9Jo+BgI/7p6JGLMBoAiAQnFxpKbRGvTJ7VJLw2chvL6oyv77iANbQUI3G
         2NKg==
X-Gm-Message-State: AOAM533xDgum7rDFO1mEjhVlpRbvGNy496TDLsMVpT1uOgKOcByOj/FI
        ibxTYT6a4t0/lpRFA8zHKBwFDEoO2iTGG2wrTtM13iFXq/Y=
X-Google-Smtp-Source: ABdhPJwtHDG5d0ionxp8evYgrtSGB+uXgAcoNWPS8OnV64FG0RF2o/3NiHh9jk2ZXuaOYY278V/ZOZLXtF0SZD3dSro=
X-Received: by 2002:a19:c85:: with SMTP id 127mr2957442lfm.189.1589559757341;
 Fri, 15 May 2020 09:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <e6927a82-949c-bdfd-d717-0a14743c6759@huawei.com>
 <20200513090502.GV29153@dhcp22.suse.cz> <76f71776-d049-7407-8574-86b6e9d80704@huawei.com>
 <20200513112905.GX29153@dhcp22.suse.cz> <3a721f62-5a66-8bc5-247b-5c8b7c51c555@huawei.com>
 <20200513161110.GA70427@carbon.DHCP.thefacebook.com> <20e89344-cf00-8b0c-64c3-0ac7efd601e6@huawei.com>
 <20200514225259.GA81563@carbon.dhcp.thefacebook.com> <20200515065645.GD29153@dhcp22.suse.cz>
 <bad0e16b-7141-94c0-45f6-6ed03926b5f8@huawei.com> <20200515083458.GK29153@dhcp22.suse.cz>
In-Reply-To: <20200515083458.GK29153@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 May 2020 09:22:25 -0700
Message-ID: <CALvZod64-Yc0firp9C8MNhEaF6FTiKmSx2B3HOrvi8GkyOD-7g@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: Fix memcg_kmem_bypass() for remote memcg charging
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Zefan Li <lizefan@huawei.com>, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 1:35 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 15-05-20 16:20:04, Li Zefan wrote:
> > On 2020/5/15 14:56, Michal Hocko wrote:
> > > On Thu 14-05-20 15:52:59, Roman Gushchin wrote:
> [...]
> > >>> I thought the user should ensure not do this, but now I think it makes sense to just bypass
> > >>> the interrupt case.
> > >>
> > >> I think now it's mostly a legacy of the opt-out kernel memory accounting.
> > >> Actually we can relax this requirement by forcibly overcommit the memory cgroup
> > >> if the allocation is happening from the irq context, and punish it afterwards.
> > >> Idk how much we wanna this, hopefully nobody is allocating large non-temporarily
> > >> objects from an irq.
> > >
> > > I do not think we want to pretend that remote charging from the IRQ
> > > context is supported. Why don't we simply WARN_ON(in_interrupt()) there?
> > >
> >
> > How about:
> >
> > static inline bool memcg_kmem_bypass(void)
> > {
> >         if (in_interrupt()) {
> >                 WARN_ON(current->active_memcg);
> >                 return true;
> >         }
>
> Why not simply
>
>         if (WARN_ON_ONCE(in_interrupt())
>                 return true;
>
> the idea is that we want to catch any __GFP_ACCOUNT user from IRQ
> context because this just doesn't work and we do not plan to support it
> for now and foreseeable future. If this is reduced only to active_memcg
> then we are only getting a partial picture.
>

There are SLAB_ACCOUNT kmem caches which do allocations in IRQ context
(see sk_prot_alloc()), so, either we make charging work in IRQ or no
warnings at all.
