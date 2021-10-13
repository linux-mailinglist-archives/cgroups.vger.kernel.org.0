Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA4142CF49
	for <lists+cgroups@lfdr.de>; Thu, 14 Oct 2021 01:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhJMXrx (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Oct 2021 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhJMXrx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Oct 2021 19:47:53 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F73FC061570
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 16:45:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x27so18774257lfa.9
        for <cgroups@vger.kernel.org>; Wed, 13 Oct 2021 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIPgO8yQiZn6tL7PQw0ynB/vmiHfdbnsw7Yxik4Gs5c=;
        b=Zo/oxYeUHUiu5epy5RMTUChC69BfvR/wzXIz5N5eUMfhimDPUDYzklPhtmFozV4kR2
         nql9Z92aM87i6pjK6Xmv7cDjU1nKQ8VNvISZjUcdFcl7sX54/5sivvQJF0112hHD5cAu
         6FSMFfQxpW8Bhe8w72Ns8DjQaO2vBG6jBTMjYQV4l81pQMst03i4Drd2f9IF2na682+u
         HpGrHoNfUa0Gg0sRUqFJbuOs+PoVDiErmce946h8Kc/RfXxI9lviBiTCLqjrAlsVcFt2
         tYwVoR5zv7LJqtTFU0rkKAiE4bscZAQWKs3CO77dpKj2PYCI1awVeJ1tAWTq6ZcVwPKh
         tq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIPgO8yQiZn6tL7PQw0ynB/vmiHfdbnsw7Yxik4Gs5c=;
        b=CyC8+KVZD58tuRzzwVro2pIrC9XR1ZF96ol23LCmt+eHboXxVmRGdYmWsP8R3iido1
         uMjzkuzU6B00zG/L07eM//nzdl18Mlc3TqMSROlZ+y0dhPLyR21a2oCnDz+HNT7W0vUE
         skTXUaj9mUJiCdGgnycR9OZhT4FMvmpY6s9oxJWS24f0n7OcV8FP6RHGedxCP/SFdfdB
         EL8mtq3KKIgA8BT4RI1rCx0yvfPmzIQ6VDykheIs5WRINLrITyGoLNs6V7jX4hy3qPLA
         wZQrhGK+UcVRDQw5gQ62Yfdaov0AbGWaclqfvJ1O3n0omRB5Bf6zZHX74AZh4q/6E+E5
         +afw==
X-Gm-Message-State: AOAM533u4gfEMnLGhAzviwxGg1hNFBTWCzyjRKHgkLbjysqYrW6Sy9VZ
        ns0r7Ku1CjbG9KNDvuBjnejnzK1h85HNmv5+c7QmmA==
X-Google-Smtp-Source: ABdhPJyDl1zBaewozzQDXu7rBd1rwYDCVVOiWOdbVlTGe18dat8YOQKe98Nhwh+PQ2I1FOPDIsFZfw1RoMqyaWqm+x0=
X-Received: by 2002:a05:6512:131b:: with SMTP id x27mr1851832lfu.210.1634168747346;
 Wed, 13 Oct 2021 16:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211013194338.1804247-1-shakeelb@google.com> <YWdXv+RBjXvdmsK+@carbon.DHCP.thefacebook.com>
 <CALvZod6ZppPNk2XfvKFfdPhrsSF6NbSBKrOOOc6UyJMfDEfKoQ@mail.gmail.com> <YWdoj9FZy2B4oLj8@carbon.DHCP.thefacebook.com>
In-Reply-To: <YWdoj9FZy2B4oLj8@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Oct 2021 16:45:35 -0700
Message-ID: <CALvZod7oYyGvHAQVO5fg5eCJefeU1J70iUS6-9k0gQ2S8-y7NQ@mail.gmail.com>
Subject: Re: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 13, 2021 at 4:15 PM Roman Gushchin <guro@fb.com> wrote:
>
[...]
> > >
> > > Isn't it a bit too aggressive?
> > >
> > > How about
> > >     if (WARN_ON_ONCE(gfp & __GFP_ACCOUNT))
> >
> > We actually know that kvmalloc(__GFP_ACCOUNT) users exist and can
> > trigger bulk page allocator through vmalloc, so I don't think the
> > warning would be any helpful.
> >
> > >        gfp &= ~__GFP_ACCOUNT;
> >
> > Bulk allocator is best effort, so callers have adequate fallbacks.
> > Transparently disabling accounting would be unexpected.
>
> I see...
>
> Shouldn't we then move this check to an upper level?
>
> E.g.:
>
> if (!(gfp & __GFP_ACCOUNT))
>    call_into_bulk_allocator();
> else
>    call_into_per_page_allocator();
>

If we add this check in the upper level (e.g. in vm_area_alloc_pages()
) then I think we would need WARN_ON_ONCE(gfp & __GFP_ACCOUNT) in the
bulk allocator to detect future users.

At the moment I am more inclined towards this patch's approach. Let's
say in future we find there is a __GFP_ACCOUNT allocation which can
benefit from bulk allocator and we decide to add such support in bulk
allocator then we would not need to change the bulk allocator callers
at that time just the bulk allocator.
