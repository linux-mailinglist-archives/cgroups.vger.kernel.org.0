Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B33B51CC0C
	for <lists+cgroups@lfdr.de>; Fri,  6 May 2022 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiEEW2p (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 May 2022 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiEEW2o (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 May 2022 18:28:44 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B99289BA
        for <cgroups@vger.kernel.org>; Thu,  5 May 2022 15:25:04 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id z144so5523265vsz.13
        for <cgroups@vger.kernel.org>; Thu, 05 May 2022 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTU61zGXmWFiJ96Frh3Jz27MZBWaPQRzBHvvGIgt+qo=;
        b=QZRowjxdyK3cW28/2AurA6uZk0guOaXUobYrDQoZCXWjvLQ/UqqjkspA5cq5vJ+lmO
         +3VbOyg8tu+9HHC1yNMS9fsG78gc0LDsxRKGKuxDPRLFtxvfi6CwNOqKaTu2udwfQwkv
         kR9lBSbM5k/K8gXDLSshvj7HkXa/BzC0t91oaM4geJKTL/jxwdmyKz/neojgz/Uo6xaw
         AOiiQ8YF0qfzCUU3y/7/icQ5tkmKsKoBTJn5cIyN71HYj/JFEs9X81LOQVThWl5uXnKb
         3HnpMtxMR/nY9nHCaG3a0wOMj9PnPQKa4DCx8yQwXiLEURUhuk9+smXGAN7Fyv6N/LU0
         tzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTU61zGXmWFiJ96Frh3Jz27MZBWaPQRzBHvvGIgt+qo=;
        b=uwPUr+3AL8A14I/TbtftATCAG8letXk0TI8R6WWZm4i4G9IuFjapmgF1/klpxJ1bJ2
         WwIdw8ghIpvK2+cLU7YEhqgxxDv5+jbV3MD+/FUi6zuZ/U6wFTvOpsk6Zdk7fS/LHlN/
         javNsgr1EXKsM0wAb4yo4KcFUgHzyHu4ebhDCOgNBP0sC+f0S699gxDhkE+vw6yq60hy
         K07o3UnPgDsexkytiaar8R+P/tIWMRZlE+B0eYRRiGOEmO12pR2YEFASfNf4pS8cqCSd
         AU1vAnS0YUshnrVhGLU5J8RTu+D+D1JoN/ZKqTQzog90Ku3IpygIrhW5eKjNmu/CPpfd
         hzQA==
X-Gm-Message-State: AOAM533hjC5qI/KJo+FOSV5iP4woGUVcgsAAqyd8M3ABVXlBkGjuJXa3
        F4J9RDtNNnEMCLiXj9FuieYTkJPCzu74s3fpcL3g6Q==
X-Google-Smtp-Source: ABdhPJzSTIXaeYs3GBff5g8EE46n+pwTbaDmDqbFn++uI37hHmsvQXFL1UGe+27TlhuxLyn320oDrpT4/PNoNTSXYm8=
X-Received: by 2002:a67:c29e:0:b0:32d:1090:54cb with SMTP id
 k30-20020a67c29e000000b0032d109054cbmr108667vsj.56.1651789502928; Thu, 05 May
 2022 15:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org> <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org> <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
 <CAHbLzkqOUkaud4hQZeAbnO3T6VJpku4aKn1EYv9RunB+Kmu9Sg@mail.gmail.com> <CALvZod5CReJZeGxkX9i6k7+R+3kF5dikXx9akbiP_L0j4Qu=6A@mail.gmail.com>
In-Reply-To: <CALvZod5CReJZeGxkX9i6k7+R+3kF5dikXx9akbiP_L0j4Qu=6A@mail.gmail.com>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Fri, 6 May 2022 07:24:51 +0900
Message-ID: <CABCjUKAoTmqvyBbFH7A188s8Hwi1XbLgfb6znzgFOuRWBMBxig@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 6, 2022 at 4:33 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Apr 28, 2022 at 9:54 AM Yang Shi <shy828301@gmail.com> wrote:
> >
> [...]
> > > Yes, we have some modifications to zswap to make it work without any
> > > backing real swap. Though there is a future plan to move to zram
> > > eventually.
> >
> > Interesting, if so why not just simply use zram?
> >
>
> Historical reasons. When we started trying out the zswap, I think zram
> was still in staging or not stable enough (Suleiman can give a better
> answer).

One of the reasons we chose zswap instead of zram is that zswap can
reject pages.
Also, we wanted to have per-memcg pools, which zswap made much easier to do.

-- Suleiman
