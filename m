Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94CB2F5325
	for <lists+cgroups@lfdr.de>; Wed, 13 Jan 2021 20:15:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbhAMTNs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 13 Jan 2021 14:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728355AbhAMTNr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 13 Jan 2021 14:13:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AACC061786
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 11:13:07 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 23so4374259lfg.10
        for <cgroups@vger.kernel.org>; Wed, 13 Jan 2021 11:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+qn9UKmISGqyuqrg148xyc55NGo3+P99P9eHwbXFks=;
        b=e1lWlrbSHGOadgLWl4yAg0TYAsrtiz9LRHk6SRNsnzPtIQqCuldKL1eq6Ryfk62/Lg
         HEqxNPjNuL2uJVZgjTuNsDb3sRYrPCu72vDogxVGm1xalOh7So+npokdRFzfAUgnxAKI
         AEGDGxQdnSMCtU3fAmR8N+90S/reL47zvPBpePRxPQuiI06xFzleYXPqhT+rhuSF3dgA
         ETEpN/5TZwmad6T52YfZbwSX1fyfEZV5qQKrSSED8hhFjuxq2Fy9krdE2ErAcGtjNIjX
         wuxVEABsyP1pJu1+J559gEfq3GbRwgFPWvEJE2wCGyS9M+Kt1lbDJmn5bvFmgBUXJsO1
         KUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+qn9UKmISGqyuqrg148xyc55NGo3+P99P9eHwbXFks=;
        b=L7z1yo6ohyEUblgloBGXsbNvi60eeVZiEohNO2vG3suOhwS9nu13mF6SwXUDrI7S14
         +8w5/2P8nQGw7u/qOizkHAi+/qzZn7GuPfAraDguIYUxeDFQzRc3TWDIru8jFbGKo6jX
         5O8xxv6HNMTm7yzbqsRR3zWU+PgRUvEhbH5eKdv7IQc/Ts2zZ4q6MOvWfmk81m65wkIj
         DuiNGOO1tGxMZ+dYDwNiVyBoKSOCUB1eB/KHVtqPq+83GZ3gypCBjrrD6SLDclcFOAQ4
         WKC9bXtDo9x+/u9vzVGJA3oa00+v/7WtKJexIJ5x9zx9w8Gp1N5YB0O/L8apFJ1BwJOq
         wv8g==
X-Gm-Message-State: AOAM532y85QtGxdGuOInO0CHbD0IuMEkDF2FqLVE/NeCvCVpLWVx817Y
        S2mfkqES9bk2JLpdFAJpalEgbOXNqUHorrM/dD9I1g==
X-Google-Smtp-Source: ABdhPJy1Lbe6OSS5ubzI/FRHddg/ikE95Xpjjl+xZ7EMAS2W+qa33nEmxdNWb04+aJ3xO8fbHolzl54KJqiQ2OZdZbw=
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr1499438lfp.117.1610565185286;
 Wed, 13 Jan 2021 11:13:05 -0800 (PST)
MIME-Version: 1.0
References: <20210112214105.1440932-1-shakeelb@google.com> <20210112233108.GD99586@carbon.dhcp.thefacebook.com>
 <CAOFY-A3=mCvfvMYBJvDL1LfjgYgc3kzebRNgeg0F+e=E1hMPXA@mail.gmail.com>
 <20210112234822.GA134064@carbon.dhcp.thefacebook.com> <CAOFY-A2YbE3_GGq-QpVOHTmd=35Lt-rxi8gpXBcNVKvUzrzSNg@mail.gmail.com>
 <CALvZod4am_dNcj2+YZmraCj0+BYHB9PnQqKcrhiOnV8gzd+S3w@mail.gmail.com> <20210113184302.GA355124@carbon.dhcp.thefacebook.com>
In-Reply-To: <20210113184302.GA355124@carbon.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 13 Jan 2021 11:12:54 -0800
Message-ID: <CALvZod4V3M=P8_Z14asBG8bKa=mYic4_OPLeoz5M7J5tsx=Gug@mail.gmail.com>
Subject: Re: [PATCH] mm: net: memcg accounting for TCP rx zerocopy
To:     Roman Gushchin <guro@fb.com>
Cc:     Arjun Roy <arjunroy@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jan 13, 2021 at 10:43 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jan 12, 2021 at 04:18:44PM -0800, Shakeel Butt wrote:
> > On Tue, Jan 12, 2021 at 4:12 PM Arjun Roy <arjunroy@google.com> wrote:
> > >
> > > On Tue, Jan 12, 2021 at 3:48 PM Roman Gushchin <guro@fb.com> wrote:
> > > >
> > [snip]
> > > > Historically we have a corresponding vmstat counter to each charged page.
> > > > It helps with finding accounting/stastistics issues: we can check that
> > > > memory.current ~= anon + file + sock + slab + percpu + stack.
> > > > It would be nice to preserve such ability.
> > > >
> > >
> > > Perhaps one option would be to have it count as a file page, or have a
> > > new category.
> > >
> >
> > Oh these are actually already accounted for in NR_FILE_MAPPED.
>
> Well, it's confusing. Can't we fix this by looking at the new page memcg flag?

Yes we can. I am inclined more towards just using NR_FILE_PAGES (as
Arjun suggested) instead of adding a new metric.
