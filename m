Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD1B513706
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 16:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbiD1OkC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 10:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiD1OkB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 10:40:01 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81023A18B
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:36:45 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id ay11so3606707qtb.4
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WFlJkOfk15NGrQhxv5mf1fq2mbY+OoNRwusqbuzmzEU=;
        b=l3r/onUHmQhKurEb2MmuqTXIGKacb8ViJBaLYyf+twuXMUBihf+B3MBsv17Xfiay0H
         8JVsqnCiFWovT6jFSNWuarrJyrz7adpSQSuA4xRfagtMPfo7xLpwKIsb5YjM7H4fh51I
         BFa9M6LR87c+MrzMT3ZYLL/Mjse6QfUuYbfR4e0zsZkbnHCyI6iQX4fXVaFPENgL5Ysh
         m1EVuNaK3mz5wC1m3+QhSvMoVBFPVuSNnUQXGqBaSEHTv8SwaIEjAEnr9JdjiSKm3NLk
         RWdWeO4ka8yrjfqioBzv5EIY9PtdODiU86CaI5a2hwGlKCBo8Quup03qWtZoPir1F2gT
         ceEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WFlJkOfk15NGrQhxv5mf1fq2mbY+OoNRwusqbuzmzEU=;
        b=Shm0lQw5W5O4cTQZFudrdtYonspr6PB3INN5LtWyD+LorvDBfBz1/OM92/usI7QNtU
         V/xTvufK2PiMj/qtMbzyir55LYJTEz3N+1cSzYEO11LfNNLm+smKK/LFCCv85NCHsuCT
         ujJG86D4RTlJ3D2KhglXKL2K40MmE/sDb8CHnYiral0gUsvfunc9k9feVMERMVPGg7FT
         FFPYSPU2EmPa+EovQZMnavrrcmy3HHUzhjwMsDytxdEGZvUi3bo6BfnMu41IB29M8/W4
         vl3tV764WM7Spjq8ZrwUKte0uy8zQseWf2Tyoe6VFrYa1bEy21BMjjt5hltKeFxxgmQI
         RfSQ==
X-Gm-Message-State: AOAM530ix8BjzsNpfkv/qj/EO8C6q2A5DGaEUuSOAjvQKXOtu0tYragw
        kWoIV3YHwZp1XpvlGax4gFlg8w==
X-Google-Smtp-Source: ABdhPJxydHYZgVlCIpywoE4cAW3PmOlamsU1d4FRdEbPWtKbPCpDUrDL84wgLILtBbdhwDFCjVKqWg==
X-Received: by 2002:a05:622a:19a6:b0:2f3:65fa:5dde with SMTP id u38-20020a05622a19a600b002f365fa5ddemr15543798qtc.472.1651156605083;
        Thu, 28 Apr 2022 07:36:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id t19-20020ac85893000000b002e1afa26591sm112168qta.52.2022.04.28.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:36:44 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:36:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YmqmWPrIagEEceN1@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org>
 <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 04:36:22PM -0700, Shakeel Butt wrote:
> On Wed, Apr 27, 2022 at 3:32 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
> > > On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > > > Hi Johannes,
> > > >
> > > > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > > > Currently it requires poking at debugfs to figure out the size and
> > > > > population of the zswap cache on a host. There are no counters for
> > > > > reads and writes against the cache. As a result, it's difficult to
> > > > > understand zswap behavior on production systems.
> > > > >
> > > > > Print zswap memory consumption and how many pages are zswapped out in
> > > > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > > >
> > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > ---
> > > > >  fs/proc/meminfo.c             |  7 +++++++
> > > > >  include/linux/swap.h          |  5 +++++
> > > > >  include/linux/vm_event_item.h |  4 ++++
> > > > >  mm/vmstat.c                   |  4 ++++
> > > > >  mm/zswap.c                    | 13 ++++++-------
> > > > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > > > --- a/fs/proc/meminfo.c
> > > > > +++ b/fs/proc/meminfo.c
> > > > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > > >
> > > > >   show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > >   show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > +#ifdef CONFIG_ZSWAP
> > > > > + seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > +            (unsigned long)(zswap_pool_total_size >> 10));
> > > > > + seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > +            (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > +            (PAGE_SHIFT - 10));
> > > > > +#endif
> > > >
> > > > I agree it would be very handy to have the memory consumption in meminfo
> > > >
> > > > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > > >
> > > > If we really go this Zswap only metric instead of general term
> > > > "Compressed", I'd like to post maybe "Zram:" with same reason
> > > > in this patchset. Do you think that's better idea instead of
> > > > introducing general term like "Compressed:" or something else?
> > >
> > > I'm fine with changing it to Compressed. If somebody cares about a
> > > more detailed breakdown, we can add Zswap, Zram subsets as needed.
> >
> > It does raise the question what to do about cgroup, though. Should the
> > control files (memory.zswap.current & memory.zswap.max) apply to zram
> > in the future? If so, we should rename them, too.
> >
> > I'm not too familiar with zram, maybe you can provide some
> > background. AFAIU, Google uses zram quite widely; all the more
> > confusing why there is no container support for it yet.
> >
> > Could you shed some light?
> >
> 
> I can shed light on the datacenter workloads. We use cgroup (still on
> v1) and zswap. For the workloads/applications, the swap (or zswap) is
> transparent in the sense that they are charged exactly the same
> irrespective of how much their memory is zswapped-out. Basically the
> applications see the same usage which is actually v1's
> memsw.usage_in_bytes. We dynamically increase the swap size if it is
> low, so we are not really worried about one job hogging the swap
> space.
> 
> Regarding stats we actually do have them internally representing
> compressed size and number of pages in zswap. The compressed size is
> actually used for OOM victim selection. The memsw or v2's swap usage
> in the presence of compression based swap does not actually tell how
> much memory can potentially be released by evicting a job. For example
> if there are two jobs 'A' and 'B'. Both of them have 100 pages
> compressed but A's 100 pages are compressed to let's say 10 pages
> while B's 100 pages are compressed to 70 pages. It is preferable to
> kill B as that will release 70 pages. (This is a very simplified
> explanation of what we actually do).

Ah, so zram is really only used by the mobile stuff after all.

In the DC, I guess you don't use disk swap in conjunction with zswap,
so those writeback cache controls are less interesting to you?

But it sounds like you would benefit from the zswap(ped) counters in
memory.stat at least.

Thanks, that is enlightening!
