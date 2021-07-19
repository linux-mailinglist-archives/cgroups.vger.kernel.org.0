Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B073CD67F
	for <lists+cgroups@lfdr.de>; Mon, 19 Jul 2021 16:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhGSNme (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 19 Jul 2021 09:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhGSNmd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 19 Jul 2021 09:42:33 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9F1C061762
        for <cgroups@vger.kernel.org>; Mon, 19 Jul 2021 06:49:05 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id e20so26571443ljn.8
        for <cgroups@vger.kernel.org>; Mon, 19 Jul 2021 07:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9dzQVKu6j3ok3pHXGU2YjadQUcak15VnK5ptAnsE2nQ=;
        b=PklgTmTvSMwVinlTqF889GVxQI07YN5I6XZrLOHo5AcaDLtgY9qEx6V1VSo/dbLGL3
         zSk1uCn3zuUTz/voDm+IzpF7tmedV9j9ljnKcTGjqHZFlBSn0bQ3gqyam8KLtG1tVymq
         Dfea8Msy6UF7PAS2/AZif3mxDHCa9ZCGCVcoKh7L467wUhuMm0E+GaFU+4ckbUckoW07
         Ynn+l2syik4a7HttWnxq8QiHkkR0K7vQdpZxgsvrFo8G0d36QKY1zTrAJE1bwYF2K2pT
         2YHe4sLvToroZ3xd3xdSU+/9bwlYF2DjfpZpq2bWFFqrjG7tUQRqkMuC8HyVRPhoMhCg
         ieUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9dzQVKu6j3ok3pHXGU2YjadQUcak15VnK5ptAnsE2nQ=;
        b=fbwOHy2hbFHo2Kxpd1mcjMdcW3ulCsizBjlz/E1nas0GEsUHuuR6aCtDWHll00uuVK
         MnzBgHBnq3JYgZngKvd54byEU3iMUMfVxBWCe5otmbT+5ZmbJCsoVcEI6HOHdYYnXdZX
         6dPW4ZewIPxQWpFJGjkh4Nd1kUtHp5iUItMK5+ZY6GriPItmU6Xpe4MJRWnlzcm6GuXN
         XfwSiTLKfQfrvd0Fpvqh/UCCoIdmi0SjN7lTPzD91x4QEHdfyUG7Conc7wrw4gl+iAkv
         53p63CBONWYr7ybFspp327DNIaJmem6cW+VJe8HxSU+xHuga82xUiJ96lENRi5YbLYDW
         R7Gw==
X-Gm-Message-State: AOAM531cqIjKmw7N6oNXseHKKp+vyVKtlIEYW5nwv9URG/RBb3b4qG70
        jR/nNQqOd/yUmBe+06N5CiX0eo/gSgaaK4Ubqv7tIw==
X-Google-Smtp-Source: ABdhPJznrSaB4TOtEzW27uJeM+eMeQFYndBtHZ0hAiEPOSCm0wF35dhOk/esVicUm3rNhOLHrwNLdx7E7qjXMGEcZnY=
X-Received: by 2002:a2e:85d7:: with SMTP id h23mr23367010ljj.279.1626704590940;
 Mon, 19 Jul 2021 07:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod66KF-8xKB1dyY2twizDE=svE8iXT_nqvsrfWg1a92f4A@mail.gmail.com>
 <cover.1626688654.git.vvs@virtuozzo.com> <9123bca3-23bb-1361-c48f-e468c81ad4f6@virtuozzo.com>
 <CAJwJo6ZgXDoXevNRte4G3Phei8WcgJ897JebWDkQDnPYrgTTQA@mail.gmail.com>
In-Reply-To: <CAJwJo6ZgXDoXevNRte4G3Phei8WcgJ897JebWDkQDnPYrgTTQA@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 19 Jul 2021 07:22:59 -0700
Message-ID: <CALvZod7YhG1Ojp2Eyk=30OBzWr5_AyEW-c1AhQVDn7zpd6mpww@mail.gmail.com>
Subject: Re: [PATCH v5 02/16] memcg: enable accounting for IP address and
 routing-related objects
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 19, 2021 at 7:00 AM Dmitry Safonov <0x7f454c46@gmail.com> wrote:
>
> Hi Vasily,
>
> On Mon, 19 Jul 2021 at 11:45, Vasily Averin <vvs@virtuozzo.com> wrote:
> [..]
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index ae1f5d0..1bbf239 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -968,7 +968,7 @@ static __always_inline bool memcg_kmem_bypass(void)
> >                 return false;
> >
> >         /* Memcg to charge can't be determined. */
> > -       if (in_interrupt() || !current->mm || (current->flags & PF_KTHREAD))
> > +       if (!in_task() || !current->mm || (current->flags & PF_KTHREAD))
> >                 return true;
>
> This seems to do two separate things in one patch.
> Probably, it's better to separate them.
> (I may miss how route changes are related to more generic
> __alloc_pages() change)
>

It was requested to squash them together in some previous versions.
https://lore.kernel.org/linux-mm/YEiUIf0old+AZssa@dhcp22.suse.cz/
