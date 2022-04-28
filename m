Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD9513A90
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 19:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350438AbiD1RDU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiD1RDP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 13:03:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5433CB6E6C;
        Thu, 28 Apr 2022 10:00:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id p8so4754373pfh.8;
        Thu, 28 Apr 2022 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKoQLCE5QMTMrIGLTJY1kxJyHUoONkb0Gy4SuEWS0GE=;
        b=fxeueu8VW95lCTu3U4S7QQ7urrruCXgenZaSZ8Efn2e0LxvgPJHS342ODIIIPp3hcT
         uOQAztYG1cCYw+W+Wd7ETh4G1/swry7JpFeHY97RTW/D9MXIO7fENG5FmU8NqsjKCt4F
         q1kdkO+7f69TEHtdSSZ9tPJ4o9pJWWbRoUQa4Z4stuxm+8K+cVDJJHEoUJ8BqgEJVFCq
         hvn6X1HzUezhAtQYsgKsd3TKqVxgoQ6/99c/faIDYrfvubGnJ4sXq7YoqgCUuR07DhTK
         IiefdnjxvRZiPB9I6Z7MVg+4y4P5/Lgw9clrwYWO7fDCqycmmRmLVdxcguWt5sXoLnZj
         gkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKoQLCE5QMTMrIGLTJY1kxJyHUoONkb0Gy4SuEWS0GE=;
        b=imi3B4TWRgLjrzU5uX0vghcvfjWmIjODpEjG3+9rmfKhQp2seFEiCdjjg5zSoSDC1D
         A1/QOo8AKqgY2cJjTuiG8dqso0sPPSQ+3k7TUCYQixFEAE7GfABSD5RUPBWMfAIyXbJ9
         9eItdUDBSWjh/5KNbxyZ73wY9KNvErmzPbXm3+psu8Kga4D4mrJvL4T3Ef9MGL7e0oDh
         oicxhL6uCrXWO8oxNfTL/dlxFmFY8zvCiim6JBRO7A8NnDsAHlmpvdu2zODix33rfR+k
         lTzI1KHEbbX2z28Zv/MwZKQBSb2CFcrsglYsAxD20VIt4hIlChk1jETpkRJdfcHNMv+j
         6IdQ==
X-Gm-Message-State: AOAM532It+C173a3Eagl1Rr7tD65RO/H3QapjDDKawp+pkLNm9A/3Vml
        beuW//P9NvG7/Gc8bZCal9cij4DUiGJnR+r4NkM=
X-Google-Smtp-Source: ABdhPJyOtC8mKemhdbsAJhHWUFBkCtVHX+XexkIctZ62HnFiQGPZfn81YIEam3BcPDQfFQECJsj5m7gNbDHubTU2qCA=
X-Received: by 2002:a65:6951:0:b0:381:f10:ccaa with SMTP id
 w17-20020a656951000000b003810f10ccaamr28272870pgq.587.1651165199780; Thu, 28
 Apr 2022 09:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org> <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org> <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
 <Ymqv25+8IX2wqKzu@cmpxchg.org>
In-Reply-To: <Ymqv25+8IX2wqKzu@cmpxchg.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Apr 2022 09:59:47 -0700
Message-ID: <CAHbLzkrNJVtsTvSvxc066Af65z0z2CkgyoHT33ER-+8qE6X9Uw@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
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

On Thu, Apr 28, 2022 at 8:17 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, Apr 28, 2022 at 07:49:33AM -0700, Shakeel Butt wrote:
> > On Thu, Apr 28, 2022 at 7:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 04:36:22PM -0700, Shakeel Butt wrote:
> > > > On Wed, Apr 27, 2022 at 3:32 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > >
> > > > > On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
> > > > > > On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > > > > > > Hi Johannes,
> > > > > > >
> > > > > > > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > > > > > > Currently it requires poking at debugfs to figure out the size and
> > > > > > > > population of the zswap cache on a host. There are no counters for
> > > > > > > > reads and writes against the cache. As a result, it's difficult to
> > > > > > > > understand zswap behavior on production systems.
> > > > > > > >
> > > > > > > > Print zswap memory consumption and how many pages are zswapped out in
> > > > > > > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > > > > > >
> > > > > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > > > ---
> > > > > > > >  fs/proc/meminfo.c             |  7 +++++++
> > > > > > > >  include/linux/swap.h          |  5 +++++
> > > > > > > >  include/linux/vm_event_item.h |  4 ++++
> > > > > > > >  mm/vmstat.c                   |  4 ++++
> > > > > > > >  mm/zswap.c                    | 13 ++++++-------
> > > > > > > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > > > > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > > > > > > --- a/fs/proc/meminfo.c
> > > > > > > > +++ b/fs/proc/meminfo.c
> > > > > > > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > > > > > >
> > > > > > > >   show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > > > >   show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > > > + seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > > > +            (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > > > + seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > > > +            (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > > > +            (PAGE_SHIFT - 10));
> > > > > > > > +#endif
> > > > > > >
> > > > > > > I agree it would be very handy to have the memory consumption in meminfo
> > > > > > >
> > > > > > > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > > > > > >
> > > > > > > If we really go this Zswap only metric instead of general term
> > > > > > > "Compressed", I'd like to post maybe "Zram:" with same reason
> > > > > > > in this patchset. Do you think that's better idea instead of
> > > > > > > introducing general term like "Compressed:" or something else?
> > > > > >
> > > > > > I'm fine with changing it to Compressed. If somebody cares about a
> > > > > > more detailed breakdown, we can add Zswap, Zram subsets as needed.
> > > > >
> > > > > It does raise the question what to do about cgroup, though. Should the
> > > > > control files (memory.zswap.current & memory.zswap.max) apply to zram
> > > > > in the future? If so, we should rename them, too.
> > > > >
> > > > > I'm not too familiar with zram, maybe you can provide some
> > > > > background. AFAIU, Google uses zram quite widely; all the more
> > > > > confusing why there is no container support for it yet.
> > > > >
> > > > > Could you shed some light?
> > > > >
> > > >
> > > > I can shed light on the datacenter workloads. We use cgroup (still on
> > > > v1) and zswap. For the workloads/applications, the swap (or zswap) is
> > > > transparent in the sense that they are charged exactly the same
> > > > irrespective of how much their memory is zswapped-out. Basically the
> > > > applications see the same usage which is actually v1's
> > > > memsw.usage_in_bytes. We dynamically increase the swap size if it is
> > > > low, so we are not really worried about one job hogging the swap
> > > > space.
> > > >
> > > > Regarding stats we actually do have them internally representing
> > > > compressed size and number of pages in zswap. The compressed size is
> > > > actually used for OOM victim selection. The memsw or v2's swap usage
> > > > in the presence of compression based swap does not actually tell how
> > > > much memory can potentially be released by evicting a job. For example
> > > > if there are two jobs 'A' and 'B'. Both of them have 100 pages
> > > > compressed but A's 100 pages are compressed to let's say 10 pages
> > > > while B's 100 pages are compressed to 70 pages. It is preferable to
> > > > kill B as that will release 70 pages. (This is a very simplified
> > > > explanation of what we actually do).
> > >
> > > Ah, so zram is really only used by the mobile stuff after all.
> > >
> > > In the DC, I guess you don't use disk swap in conjunction with zswap,
> > > so those writeback cache controls are less interesting to you?
> >
> > Yes, we have some modifications to zswap to make it work without any
> > backing real swap.
>
> Not sure if you can share them, but I would be interested in those
> changes. We have real backing swap, but because of the way swap
> entries are allocated, pages stored in zswap will consume physical
> disk slots. So on top of regular swap, you need to provision disk
> space for zswap as well, which is unfortunate.

Yes, exactly. For our usecase I noticed the swap backend is used up,
but there is no writeback from zswap to swap backend at all. The
bright side is it may mean the compression ratio is high for our
workload, but the disk space is actually wasted.

>
> What could be useful is a separate swap entry address space that maps
> zswap slots and disk slots alike. This would fix the above problem. It
> would have the added benefit of making swapoff much simpler and faster
> too, as it doesn't need to chase down page tables to free disk slots.

I was thinking about this too, but it seems not easy since the swap
slot on swap backen is allocated when the page is added to swap, but
not entry on zswap since zswap is just a cache and invisible to
vmscan. If we have separate entries for zswap and swap backend, it
would be complicated to convert zswap entries to swap backend entries
since we may have to traverse rmap to find all the PTEs mapped to
zswap entry in order to convert them to swap backend entry.

>
> > > But it sounds like you would benefit from the zswap(ped) counters in
> > > memory.stat at least.
> >
> > Yes and I think if we need zram specific counters/stats in future,
> > those can be added then.
>
> I agree.
>
