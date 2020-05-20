Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3021DA661
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 02:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgETAWG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgETAWG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 May 2020 20:22:06 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07E2C061A0E
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 17:22:05 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x27so1038742lfg.9
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTql++3gFASshPrg+T0nmbJwBgbfv14jSHy1pTffRhU=;
        b=NiUCaCohQuLliM+U2l50qqLl57m8zQFJsQk3xhIisLLSkrO4qnnyY4emxRxJ5aAruF
         PjefQUYiKxx5vRTksxhTvVAiq5LGu6NPL/tKYyIAzl1NQj+qX2YWvoWRbQ3XtE66OCMs
         dnJqRiiOUfnMr7z+qZXG3oJ2wGUgaki2nxodtQIEGJMybq8cxprMZ4brtnXlhmtqh/kQ
         TS682Hpjz6G/JybgJ3AhDnMwqldcFpPE1CAzWXuY1tz4QyxI6pn4i6MZE976sZ9W0wFa
         3kGFcrvISClJst13OMTGf4Qj9hfJhMx4G1Y/XGxZcGxQw1Fj6N3BJJXOtO4sMqM6MHJX
         xw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTql++3gFASshPrg+T0nmbJwBgbfv14jSHy1pTffRhU=;
        b=jsKLHcdkt/eiaZHAYm2rSY2dDZSyUhDc699DfgD7cZ8MyoOlRiJPPXzU73jaqRyYk2
         2r1K+V/8uvNRRvsI8SyC9aD6cltHasxbD+XMhTb2OigGUkdqvwB7sgTdIH5ZHyyQzPRl
         Qp9IW4lXodJh7TjGJjhwY9mrK3SqqLhlSrtn4Ztp6ffGaAZKkYlVrVdYQaAkqSglPMJ1
         zCppMIPmhQSHetXI1uweIr3U+rNPzegnqkItTkZC1mJRZvgefPgLdpg5/azKVfOm5/Om
         k1pMhE141HM2WnB4F+Dr4A7FObWqYpeJXqQCCnTZcQbGhWoi6SNX2T1H8T135iq2wDSK
         DYLA==
X-Gm-Message-State: AOAM532we7MJDv1RTlt9F+TMYXhuFfOtHtnepeQmjtnbHfebCfWzmvWy
        u6V4JCn33Bofnvi+JG7PxOPI/naMchZnGzZuO7DjTg==
X-Google-Smtp-Source: ABdhPJy9ROJxomItmrADQjVlnzCuJBnkg4tO6Kxdpsc6GXhgYC4Viz6PRyUGb0WclS0G5ZKq+fkXbxoW3J1j7BkB81U=
X-Received: by 2002:ac2:5ccf:: with SMTP id f15mr884299lfq.216.1589934123686;
 Tue, 19 May 2020 17:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200519171938.3569605-1-kuba@kernel.org> <20200519171938.3569605-4-kuba@kernel.org>
 <CALvZod4i2sBWcbKe3MHMuSMV3ywWwQx1Xr-abEqPS6n8vioC7w@mail.gmail.com> <20200519161438.4f11ddec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200519161438.4f11ddec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 May 2020 17:21:52 -0700
Message-ID: <CALvZod52fmmdcXOCBEW=yE_nSxiJv5PrUV_jALOHC0wh47zVAg@mail.gmail.com>
Subject: Re: [PATCH mm v4 3/4] mm: move cgroup high memory limit setting into
 struct page_counter
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 19, 2020 at 4:14 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Tue, 19 May 2020 15:15:41 -0700 Shakeel Butt wrote:
> > > --- a/mm/page_counter.c
> > > +++ b/mm/page_counter.c
> > > @@ -198,6 +198,11 @@ int page_counter_set_max(struct page_counter *counter, unsigned long nr_pages)
> > >         }
> > >  }
> > >
> > > +void page_counter_set_high(struct page_counter *counter, unsigned long nr_pages)
> > > +{
> > > +       WRITE_ONCE(counter->high, nr_pages);
> > > +}
> > > +
> >
> > Any reason not to make this static inline like
> > page_counter_is_above_high() and in page_counter.h?
>
> My reason was consistency with other page_counter_set_xyz() helpers,
> but obviously happy to change if needed...

I think it should be in the header and inlined.
