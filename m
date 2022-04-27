Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0218512791
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 01:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiD0Xju (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 19:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiD0Xjs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 19:39:48 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3BF45AD7
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 16:36:34 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i24so2813254pfa.7
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FL5RmqjsnS96RItXhleCXY3INxI4L38U8zTk4H4kbRM=;
        b=Fnjww4kTfxvDYxU1OPnCUQ05Dg7DEB2VNmgBa3iIVs1YziXLL5NPY22PxqWXh7lRlB
         8vuXugqSz74/dVRL6IV85uoBkg1Axric6AIQ3KCnilEj1X6Rj1CCpiY1X8QSqFEDtLjL
         x0EE+oQBe8Dvrs0rULZGjGplV+5cDIqQ7DQh2uofwdi1gqfXibZiQZSWhIX6812SQDV0
         ooiysKmKTdtVuGN7sNGxHt52RH6aaUff+q46TbfeovpbaLTjLAzpyfjWwLcRjtDoU3Za
         xFMGzikPBEx43dvuCJzWa0IU2IwO8irzQo5Ik4kcOU1/KW/jP+bE1ULp+1XD6wXL12nD
         7wHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FL5RmqjsnS96RItXhleCXY3INxI4L38U8zTk4H4kbRM=;
        b=EwpCrttfh4USQiqWWljaXbZBQhk73bY+jcw7ZZ4rwF1Y/7ND1FtTccD9GdzSMxH2Bh
         08brC5RS0ihMyX3u9r94inbXaY4IuP2leuFd9L6VZjEt51dcasgxuEvE33aVTzOmiuqv
         9uwCTH37q+51htXy7MiX5wBa3Ul/zg5+FX+EXghCCbdP7ibJbfvNkDyOZ7LVe9gXlR/U
         lU12vXweZ4RHANPZJCDhASC+Ky81utKT/GCijl58ScZoF0GXmraYBSe0fpMQEnbodU3I
         ePXTL5sXWluCPwT7r+tuF2oYxsXHn1790AkrRjJ+iwMkTcs4Cxp/ToxllnoUhdnIvLIF
         f4gg==
X-Gm-Message-State: AOAM532uBLjqcok8iHIVLljv+APIuzWl9KZNuYsj6+ejb93HbGnpK7bw
        GsnzPM3wajO3F+rBObePN9sPhDCp5V/Jqm60di3GWg==
X-Google-Smtp-Source: ABdhPJy4UALwll6c0xGRrMjr2HG+8qWZYoDKSENmN8Qp6glp0VyRbdy5DcsshId0F3jOAIOJmkP3RA8JC+4vWUV+Y8A=
X-Received: by 2002:a63:9502:0:b0:386:3916:ca8e with SMTP id
 p2-20020a639502000000b003863916ca8emr25446320pgd.357.1651102592948; Wed, 27
 Apr 2022 16:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org> <Ymm3WpvJWby4gaD/@cmpxchg.org>
In-Reply-To: <Ymm3WpvJWby4gaD/@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 27 Apr 2022 16:36:22 -0700
Message-ID: <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 3:32 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
> > On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > > Hi Johannes,
> > >
> > > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > > Currently it requires poking at debugfs to figure out the size and
> > > > population of the zswap cache on a host. There are no counters for
> > > > reads and writes against the cache. As a result, it's difficult to
> > > > understand zswap behavior on production systems.
> > > >
> > > > Print zswap memory consumption and how many pages are zswapped out in
> > > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > >
> > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > ---
> > > >  fs/proc/meminfo.c             |  7 +++++++
> > > >  include/linux/swap.h          |  5 +++++
> > > >  include/linux/vm_event_item.h |  4 ++++
> > > >  mm/vmstat.c                   |  4 ++++
> > > >  mm/zswap.c                    | 13 ++++++-------
> > > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > > --- a/fs/proc/meminfo.c
> > > > +++ b/fs/proc/meminfo.c
> > > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > >
> > > >   show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > >   show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > +#ifdef CONFIG_ZSWAP
> > > > + seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > +            (unsigned long)(zswap_pool_total_size >> 10));
> > > > + seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > +            (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > +            (PAGE_SHIFT - 10));
> > > > +#endif
> > >
> > > I agree it would be very handy to have the memory consumption in meminfo
> > >
> > > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > >
> > > If we really go this Zswap only metric instead of general term
> > > "Compressed", I'd like to post maybe "Zram:" with same reason
> > > in this patchset. Do you think that's better idea instead of
> > > introducing general term like "Compressed:" or something else?
> >
> > I'm fine with changing it to Compressed. If somebody cares about a
> > more detailed breakdown, we can add Zswap, Zram subsets as needed.
>
> It does raise the question what to do about cgroup, though. Should the
> control files (memory.zswap.current & memory.zswap.max) apply to zram
> in the future? If so, we should rename them, too.
>
> I'm not too familiar with zram, maybe you can provide some
> background. AFAIU, Google uses zram quite widely; all the more
> confusing why there is no container support for it yet.
>
> Could you shed some light?
>

I can shed light on the datacenter workloads. We use cgroup (still on
v1) and zswap. For the workloads/applications, the swap (or zswap) is
transparent in the sense that they are charged exactly the same
irrespective of how much their memory is zswapped-out. Basically the
applications see the same usage which is actually v1's
memsw.usage_in_bytes. We dynamically increase the swap size if it is
low, so we are not really worried about one job hogging the swap
space.

Regarding stats we actually do have them internally representing
compressed size and number of pages in zswap. The compressed size is
actually used for OOM victim selection. The memsw or v2's swap usage
in the presence of compression based swap does not actually tell how
much memory can potentially be released by evicting a job. For example
if there are two jobs 'A' and 'B'. Both of them have 100 pages
compressed but A's 100 pages are compressed to let's say 10 pages
while B's 100 pages are compressed to 70 pages. It is preferable to
kill B as that will release 70 pages. (This is a very simplified
explanation of what we actually do).
