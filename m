Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBAE51374A
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348499AbiD1OxC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348493AbiD1OxB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 10:53:01 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC32B1AA1
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:49:46 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i38so9389325ybj.13
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lB9G0cOuwnlKFcyDN4agu+9Zs72ednckPaeKqeZhvqE=;
        b=QL4NGu/PMkkIPar7VNuv3jRT/c6ouw14nCnTqVpJChB0AejQZ7vnndnVEG9yCJJCY6
         0leNwPkZaepZ10A7v4IKc2SX2Er/0wKPLdxwtJ90dZIJfvLaRKCo2QlN3FlutKJ9Mtct
         9mzt+oFJTZa0vH9oluHu5Oo468Zc4TJGWbLp5FA4yLX0OEM9SmFzIUTk44Khf5Ztn7QR
         ZZ2MCH3m0sq+pcWxq5vXq/3nw+G0QenB8/Ryh3/7vs54bYkp/VkRnbhOnuZ9+C2gK5do
         JUTP1SCv//HBqMnlNbo6xJysNdmK3QSHDSg4xadhk/JwWBirsxpn1QsjFpRm3irnB+82
         0djw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lB9G0cOuwnlKFcyDN4agu+9Zs72ednckPaeKqeZhvqE=;
        b=6FqMQL9m3jkS0L57bjQUaj2OCtE5i4LA8EsDTvdPiVikYpst7e1z8UhPxVwemKd2rD
         bj1YYN94gchsVRi8ot0gKzX7pDJgTgqTAhsl+9glMkQ1etprd9MIn6Jsv9KlY3OoNYkD
         LfA8B6TTpuRreJbcL8e/ggzFOmvITQwbEk0lrzLbE2sEKEiHXSaGwk8FdgfwsCHihI1Y
         0Hl1MEtyzXX6sKWCi+Rup7ENJCV37vpp6/zl99xzMb/BeLLDIBgfYTNRdIm4FOz9ut0m
         7PgGqehYkIteElp5+4QTo4Cjp7Z4I6xQM6wxAACNNQOs1zBqrRrc3azijTUyG/3ql4NG
         52YQ==
X-Gm-Message-State: AOAM531FvbPiXXz9mDkxU7c04FH1YlH6STzu7YJhM+FG9keW8PgyNdrU
        Ow2sYvfLbFK1P0Lz1NlJ/NEf5cldJghtvpJ4IjnUXw==
X-Google-Smtp-Source: ABdhPJzUQdQX91SAnTRZl5sWENvnOfqTxHX03AYbii6GzqLZ/7y3uMfL6wXsVAagf9bnS/GUWpnuZbwT6DtRp+BswjU=
X-Received: by 2002:a25:2e4e:0:b0:648:6652:ca6e with SMTP id
 b14-20020a252e4e000000b006486652ca6emr20288090ybn.345.1651157385608; Thu, 28
 Apr 2022 07:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org> <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org>
In-Reply-To: <YmqmWPrIagEEceN1@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 Apr 2022 07:49:33 -0700
Message-ID: <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 7:36 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Apr 27, 2022 at 04:36:22PM -0700, Shakeel Butt wrote:
> > On Wed, Apr 27, 2022 at 3:32 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
> > > > On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > > > > Hi Johannes,
> > > > >
> > > > > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > > > > Currently it requires poking at debugfs to figure out the size and
> > > > > > population of the zswap cache on a host. There are no counters for
> > > > > > reads and writes against the cache. As a result, it's difficult to
> > > > > > understand zswap behavior on production systems.
> > > > > >
> > > > > > Print zswap memory consumption and how many pages are zswapped out in
> > > > > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > > > >
> > > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > ---
> > > > > >  fs/proc/meminfo.c             |  7 +++++++
> > > > > >  include/linux/swap.h          |  5 +++++
> > > > > >  include/linux/vm_event_item.h |  4 ++++
> > > > > >  mm/vmstat.c                   |  4 ++++
> > > > > >  mm/zswap.c                    | 13 ++++++-------
> > > > > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > > > >
> > > > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > > > > --- a/fs/proc/meminfo.c
> > > > > > +++ b/fs/proc/meminfo.c
> > > > > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > > > >
> > > > > >   show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > >   show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > + seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > +            (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > + seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > +            (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > +            (PAGE_SHIFT - 10));
> > > > > > +#endif
> > > > >
> > > > > I agree it would be very handy to have the memory consumption in meminfo
> > > > >
> > > > > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > > > >
> > > > > If we really go this Zswap only metric instead of general term
> > > > > "Compressed", I'd like to post maybe "Zram:" with same reason
> > > > > in this patchset. Do you think that's better idea instead of
> > > > > introducing general term like "Compressed:" or something else?
> > > >
> > > > I'm fine with changing it to Compressed. If somebody cares about a
> > > > more detailed breakdown, we can add Zswap, Zram subsets as needed.
> > >
> > > It does raise the question what to do about cgroup, though. Should the
> > > control files (memory.zswap.current & memory.zswap.max) apply to zram
> > > in the future? If so, we should rename them, too.
> > >
> > > I'm not too familiar with zram, maybe you can provide some
> > > background. AFAIU, Google uses zram quite widely; all the more
> > > confusing why there is no container support for it yet.
> > >
> > > Could you shed some light?
> > >
> >
> > I can shed light on the datacenter workloads. We use cgroup (still on
> > v1) and zswap. For the workloads/applications, the swap (or zswap) is
> > transparent in the sense that they are charged exactly the same
> > irrespective of how much their memory is zswapped-out. Basically the
> > applications see the same usage which is actually v1's
> > memsw.usage_in_bytes. We dynamically increase the swap size if it is
> > low, so we are not really worried about one job hogging the swap
> > space.
> >
> > Regarding stats we actually do have them internally representing
> > compressed size and number of pages in zswap. The compressed size is
> > actually used for OOM victim selection. The memsw or v2's swap usage
> > in the presence of compression based swap does not actually tell how
> > much memory can potentially be released by evicting a job. For example
> > if there are two jobs 'A' and 'B'. Both of them have 100 pages
> > compressed but A's 100 pages are compressed to let's say 10 pages
> > while B's 100 pages are compressed to 70 pages. It is preferable to
> > kill B as that will release 70 pages. (This is a very simplified
> > explanation of what we actually do).
>
> Ah, so zram is really only used by the mobile stuff after all.
>
> In the DC, I guess you don't use disk swap in conjunction with zswap,
> so those writeback cache controls are less interesting to you?

Yes, we have some modifications to zswap to make it work without any
backing real swap. Though there is a future plan to move to zram
eventually.

>
> But it sounds like you would benefit from the zswap(ped) counters in
> memory.stat at least.

Yes and I think if we need zram specific counters/stats in future,
those can be added then.

>
> Thanks, that is enlightening!
