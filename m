Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207D1432472
	for <lists+cgroups@lfdr.de>; Mon, 18 Oct 2021 19:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232587AbhJRRPs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 18 Oct 2021 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbhJRRPr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 18 Oct 2021 13:15:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96536C06161C
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 10:13:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p16so1263805lfa.2
        for <cgroups@vger.kernel.org>; Mon, 18 Oct 2021 10:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DyNcrwLKTjtZ0VloCKphs+CNM4GqGJ0HGRhbR/SC9mk=;
        b=mijnuQhJ93hdYipWZXXygB5cY0SIRliRAWdWH3/kL+XbMVop56Aczh+/fs0SiJ4dTo
         1Jzme2KYKdg9zMBZ374t9j+jHm3BDMuePiHsAp43XySR+grbVlX7G+/IxLq8E/VDhRrf
         WkGghth9kDhfkSTT+6XINlNGdF89J7AvQIyRG4JrsOZcY94WatVDEuPklMLvBOmQGhYE
         RJbWGCaEyRLuT/L3C2y1WDN9KZe+1+5UKPx4GfqvCY/x1xeRxyXhtIkxYuq3knq0VGsZ
         okIJhAaFnB1/4Db26FYIwYsIepSIErmBT22pXILJNwPvl5f8TykZ59Qc4bLYd5U+j6A0
         fz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DyNcrwLKTjtZ0VloCKphs+CNM4GqGJ0HGRhbR/SC9mk=;
        b=3ubhKZq6r4Yc+EOF+XNZ1dGtrDe1ano7Q2H7yLlnbM+7xBuJb13eEKDqjQNz4GDQdl
         c94CWMb18QQ5aSPakJZgts8d9HK9MAJht3PXNVfYxPaLS3atdFpoSNeOnnwe5MkVPggv
         MaVW8PcH0LH9yehFtrCBXPFxtbpriFNZoNAoz4nuXmDCm5LFLvfN+w/iaVRomgyuvXZj
         QYIVIIncO6VNJvvh8GvOAgV3xmSX/HjcMQKRRsOZVWQkkzm0SUPwplVTGgT27cPXxyR3
         0F68gurThh3eyQKd8VKUBic0S8gHs2UdlYIJIs86deOF247Tf93MOBjJJrbFiTel8nSX
         IO0g==
X-Gm-Message-State: AOAM530DcahxA9ALAfS1I+jyAYh0omQgyrPKj58+d1zGLvNpf5vrK+ar
        KCQxLt6ZtcRRw7lVP5XUGxnbpC8+O2Cn2tM3Cbzs0A==
X-Google-Smtp-Source: ABdhPJy9C4YY6DPN5j6xi0NmPgIh1Q/YnUEACZ7btLDN5oJvzX5DpC6/4m/DKieWSXhrrtBlIYIA/sLEylOo4nTj5wA=
X-Received: by 2002:a05:6512:3d16:: with SMTP id d22mr964698lfv.20.1634577213797;
 Mon, 18 Oct 2021 10:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <9d10df01-0127-fb40-81c3-cc53c9733c3e@virtuozzo.com>
 <YW04jWSv6pQb2Goe@dhcp22.suse.cz> <6b751abe-aa52-d1d8-2631-ec471975cc3a@virtuozzo.com>
 <YW1gRz0rTkJrvc4L@dhcp22.suse.cz> <27dc0c49-a0d6-875b-49c6-0ef5c0cc3ac8@virtuozzo.com>
 <YW1oMxNkUCaAimmg@dhcp22.suse.cz> <CALvZod42uwgrg83CCKn6JgYqAQtR1RLJSuybNYjtkFo4wVgT1w@mail.gmail.com>
 <YW2mDDYRkXkQbZAR@dhcp22.suse.cz>
In-Reply-To: <YW2mDDYRkXkQbZAR@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 18 Oct 2021 10:13:22 -0700
Message-ID: <CALvZod4pET2ZYWwsEP3Q+uGpGNb+TEVgRg5yo1h+mRK-_ZB+Cw@mail.gmail.com>
Subject: Re: [PATCH memcg 0/1] false global OOM triggered by memcg-limited task
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 18, 2021 at 9:51 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 18-10-21 08:07:20, Shakeel Butt wrote:
> > On Mon, Oct 18, 2021 at 5:27 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > [restore the cc list]
> > >
> > > On Mon 18-10-21 15:14:26, Vasily Averin wrote:
> > > > On 18.10.2021 14:53, Michal Hocko wrote:
> > > > > On Mon 18-10-21 13:05:35, Vasily Averin wrote:
> > > > >> On 18.10.2021 12:04, Michal Hocko wrote:
> > > > >> Here we call try_charge_memcg() that return success and approve the allocation,
> > > > >> however then we hit into kmem limit and fail the allocation.
> > > > >
> > > > > Just to make sure I understand this would be for the v1 kmem explicit
> > > > > limit, correct?
> > > >
> > > > yes, I mean this limit.
> > >
> > > OK, thanks for the clarification. This is a known problem. Have a look
> > > at I think we consider that one to 0158115f702b ("memcg, kmem: deprecate
> > > kmem.limit_in_bytes"). We are reporting the deprecated and to-be removed
> > > status since 2019 without any actual report sugested by the kernel
> > > message. Maybe we should try and remove it and see whether that prompts
> > > some pushback.
> > >
> >
> > Yes, I think now should be the right time to take the next step for
> > deprecation of kmem limits:
> > https://lore.kernel.org/all/20201118175726.2453120-1-shakeelb@google.com/
>
> I completely forgot about your patch.  Anyway, it usually takes us years
> to deprecate something so let's stick with it and consider 2 years as
> years ;)
>

Sure, I will rebase and resend.
