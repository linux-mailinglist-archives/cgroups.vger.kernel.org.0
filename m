Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFAF513A74
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 18:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiD1Q6I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 12:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiD1Q6H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 12:58:07 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41C5AAB6D;
        Thu, 28 Apr 2022 09:54:52 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a11so4759830pff.1;
        Thu, 28 Apr 2022 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MvCOJLEv0diYuRsRJ3vfm9TWORadeU8jtlQyqpscZYs=;
        b=Wj8UXDdE0X8gpr6LoRyZmqUQOw2kxuuPyrfVfL1bKAAZqgSatnq6bYzfRifjXKI+FX
         Wm9USQkdGM8HZGBT7ts1RW4ABEbw+glCOKAVM2+/Kk3j//GfWRCpzt+Zh9uEuyVTS3RE
         +BSxCzbRHgD+qVLgtP8lSGFNihGOMbsjyBDNZ+gcJx/AHUi+zyX5Z2+nAFvx/N/QhlRS
         7PuL9T3OQ4hj5tyqcKkjBLDhVV7d5z9g2aOVx/D7OCeALJGjMrAi8pkEeLNK13IQC2D2
         fjsgAARRjCsT2bNtUGofF1e30Q8XgIa9z97MYStEAnk5Cs0NUbGtoiUeCTdfMFw3D/BW
         PvEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MvCOJLEv0diYuRsRJ3vfm9TWORadeU8jtlQyqpscZYs=;
        b=nyQouo1SJltt9db2f3Cxem80fh3mEfi2si3yKy0qKTWf6ol50YR+KVyX14lYEC3Uuj
         iV6M7189Ti+wtYmmtjcSj2r6B7G/prLzr6W+pc3laDTWE8qsE5FLdUzfDxmzO0c/VTfh
         6L0diJmurxzOswXzEuwddoI1KXG+Kz41eWcXNiBeA5zhP89S3Q2mMBiUzCxUzMVj5AoW
         2xTAcb7AyxiEO64kFOlIZwbFPbAqNjGvxpzYJrovSoJ5vd9ldOy3btj6gd0spAJF1Nzf
         2rnc9ySS+tttgSHdsMCmIZ8rT3RAKswRU8zfG7nQ58XCvT+0DHiUohkL/u6AkTGI23ax
         d8EQ==
X-Gm-Message-State: AOAM530H8GyxRdRMwgEwz/xqTdsHQJn+n26UPwiJOYhm5tLPlRLhHX1M
        A6UCVCpYPGNtdSij8Urqq2/KYXiWZk10LUF4m34=
X-Google-Smtp-Source: ABdhPJwOi4QlvWVAg2x0n7sXu+D03SSjc9/9+Z2qP7Q8SICby6ygCVP2AF2/o6d5nA40Vvl1UIFzJlKaHhWZ+diI4kk=
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id
 w17-20020a656951000000b003810f10ccaamr28256271pgq.587.1651164892221; Thu, 28
 Apr 2022 09:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org> <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org> <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
In-Reply-To: <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Apr 2022 09:54:39 -0700
Message-ID: <CAHbLzkqOUkaud4hQZeAbnO3T6VJpku4aKn1EYv9RunB+Kmu9Sg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 7:49 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Apr 28, 2022 at 7:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 04:36:22PM -0700, Shakeel Butt wrote:
> > > On Wed, Apr 27, 2022 at 3:32 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
> > > > > On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > > > > > Hi Johannes,
> > > > > >
> > > > > > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > > > > > Currently it requires poking at debugfs to figure out the size and
> > > > > > > population of the zswap cache on a host. There are no counters for
> > > > > > > reads and writes against the cache. As a result, it's difficult to
> > > > > > > understand zswap behavior on production systems.
> > > > > > >
> > > > > > > Print zswap memory consumption and how many pages are zswapped out in
> > > > > > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > > > > >
> > > > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > > ---
> > > > > > >  fs/proc/meminfo.c             |  7 +++++++
> > > > > > >  include/linux/swap.h          |  5 +++++
> > > > > > >  include/linux/vm_event_item.h |  4 ++++
> > > > > > >  mm/vmstat.c                   |  4 ++++
> > > > > > >  mm/zswap.c                    | 13 ++++++-------
> > > > > > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > > > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > > > > > --- a/fs/proc/meminfo.c
> > > > > > > +++ b/fs/proc/meminfo.c
> > > > > > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > > > > >
> > > > > > >   show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > > >   show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > > + seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > > +            (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > > + seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > > +            (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > > +            (PAGE_SHIFT - 10));
> > > > > > > +#endif
> > > > > >
> > > > > > I agree it would be very handy to have the memory consumption in meminfo
> > > > > >
> > > > > > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > > > > >
> > > > > > If we really go this Zswap only metric instead of general term
> > > > > > "Compressed", I'd like to post maybe "Zram:" with same reason
> > > > > > in this patchset. Do you think that's better idea instead of
> > > > > > introducing general term like "Compressed:" or something else?
> > > > >
> > > > > I'm fine with changing it to Compressed. If somebody cares about a
> > > > > more detailed breakdown, we can add Zswap, Zram subsets as needed.
> > > >
> > > > It does raise the question what to do about cgroup, though. Should the
> > > > control files (memory.zswap.current & memory.zswap.max) apply to zram
> > > > in the future? If so, we should rename them, too.
> > > >
> > > > I'm not too familiar with zram, maybe you can provide some
> > > > background. AFAIU, Google uses zram quite widely; all the more
> > > > confusing why there is no container support for it yet.
> > > >
> > > > Could you shed some light?
> > > >
> > >
> > > I can shed light on the datacenter workloads. We use cgroup (still on
> > > v1) and zswap. For the workloads/applications, the swap (or zswap) is
> > > transparent in the sense that they are charged exactly the same
> > > irrespective of how much their memory is zswapped-out. Basically the
> > > applications see the same usage which is actually v1's
> > > memsw.usage_in_bytes. We dynamically increase the swap size if it is
> > > low, so we are not really worried about one job hogging the swap
> > > space.
> > >
> > > Regarding stats we actually do have them internally representing
> > > compressed size and number of pages in zswap. The compressed size is
> > > actually used for OOM victim selection. The memsw or v2's swap usage
> > > in the presence of compression based swap does not actually tell how
> > > much memory can potentially be released by evicting a job. For example
> > > if there are two jobs 'A' and 'B'. Both of them have 100 pages
> > > compressed but A's 100 pages are compressed to let's say 10 pages
> > > while B's 100 pages are compressed to 70 pages. It is preferable to
> > > kill B as that will release 70 pages. (This is a very simplified
> > > explanation of what we actually do).
> >
> > Ah, so zram is really only used by the mobile stuff after all.
> >
> > In the DC, I guess you don't use disk swap in conjunction with zswap,
> > so those writeback cache controls are less interesting to you?
>
> Yes, we have some modifications to zswap to make it work without any
> backing real swap. Though there is a future plan to move to zram
> eventually.

Interesting, if so why not just simply use zram?

>
> >
> > But it sounds like you would benefit from the zswap(ped) counters in
> > memory.stat at least.
>
> Yes and I think if we need zram specific counters/stats in future,
> those can be added then.
>
> >
> > Thanks, that is enlightening!
>
