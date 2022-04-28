Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42EFE513C40
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 21:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351303AbiD1UCL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 16:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbiD1UCK (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 16:02:10 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AABBF319;
        Thu, 28 Apr 2022 12:58:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r9so5208704pjo.5;
        Thu, 28 Apr 2022 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CWnSkaOj39Eo0MGVGB4CJor11LXSPlLfWV+GUOsVzCc=;
        b=iW3DMp+dOdK/4HP31Sy7KPZbhFBRdqimi4fA59MhyZdC98Y8fc2ZP1qahsmBpnfEcy
         GkJwDhtvl9HdMwaFd35PPDRE7EJMqINfj6BiafO0mHEqH4yc2OCTA86IFVqxubIQKQq9
         7wrwd/4GuCzPd/I9ZuGO5GC9jvi5qkdQf2zQJguyfFoAtrGS18cYs51zPtA0HMUJxxgx
         1WHk11NC1hzBdp632cVF2q0li06ZhtZryq/yhVdz5UEgz1RfViXtIL2oYxlOBjmD9kL8
         2gx4AsdeV9kqccTRkXrXV+qBu3sORY7rt6cl3yrHomSW4cRAJP4vNtoVA57i+XffaibL
         SvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=CWnSkaOj39Eo0MGVGB4CJor11LXSPlLfWV+GUOsVzCc=;
        b=W8x8G3wW2vt7Kxay5VClXX4Mhc44Vdy/9m/rNhZNAltGXN8yHweQeMSkGIqqXx4BD0
         EGYEDQuzLjSYs0tWVRElTtPeMEl1kvGSVA7FGi4o6RGMSbtkZhH/Nv/lTVI/VFofx8N7
         RfRSoJh4sjAZxjXUOokgrNa2+dBNgsYoZD46U7vQsCqmhYgyW/N2YKh3jYp9NaH4CKN7
         x3TYUq0KNpmyRe14V2AhTRDgSZ2LnJCzRVyC2DYM+KAz11HExclvx1HC3GKXYPJZevqP
         d1pbkFcKDa+TVtu99NLiDoP53NryJz343DNaTdfTsfPDv/CFHpGT19+NFVib7Hef5Mnf
         InuQ==
X-Gm-Message-State: AOAM533HaczLJpvM/Z3vlQX4r2i+kXQtyihcvamW7OezjloBg0KuCOT0
        Y+Yr3rQd9f0mZwpyb+YzKm9mgDHEKxw=
X-Google-Smtp-Source: ABdhPJw5l+h1G/hbga/MH615HY+bxS4Ph0HiIRnibzBE5bTor+Gvt7/ZFzqWglDSfU1ARkn60Zo/Og==
X-Received: by 2002:a17:902:d583:b0:15d:11f5:59f5 with SMTP id k3-20020a170902d58300b0015d11f559f5mr23062233plh.37.1651175933932;
        Thu, 28 Apr 2022 12:58:53 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:dc95:713b:f72c:4ad4])
        by smtp.gmail.com with ESMTPSA id c10-20020a62f84a000000b0050d86052958sm587980pfm.125.2022.04.28.12.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 12:58:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 28 Apr 2022 12:58:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <Ymrx+yZ4i86LZpE9@google.com>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <YmnA0Da90IURbxrM@google.com>
 <Ymqj93gEEzu2Gb3U@cmpxchg.org>
 <YmrICbP6bDJqDv5R@google.com>
 <YmrNiY3VhdMbfTq1@cmpxchg.org>
 <YmrPgWs5WPabIBQk@google.com>
 <YmreNLge7b+FBC30@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmreNLge7b+FBC30@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 02:34:28PM -0400, Johannes Weiner wrote:
> On Thu, Apr 28, 2022 at 10:31:45AM -0700, Minchan Kim wrote:
> > On Thu, Apr 28, 2022 at 01:23:21PM -0400, Johannes Weiner wrote:
> > > On Thu, Apr 28, 2022 at 09:59:53AM -0700, Minchan Kim wrote:
> > > > On Thu, Apr 28, 2022 at 10:25:59AM -0400, Johannes Weiner wrote:
> > > > > On Wed, Apr 27, 2022 at 03:16:48PM -0700, Minchan Kim wrote:
> > > > > > On Wed, Apr 27, 2022 at 05:20:29PM -0400, Johannes Weiner wrote:
> > > > > > > On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > > > > > > > Hi Johannes,
> > > > > > > > 
> > > > > > > > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > > > > > > > Currently it requires poking at debugfs to figure out the size and
> > > > > > > > > population of the zswap cache on a host. There are no counters for
> > > > > > > > > reads and writes against the cache. As a result, it's difficult to
> > > > > > > > > understand zswap behavior on production systems.
> > > > > > > > > 
> > > > > > > > > Print zswap memory consumption and how many pages are zswapped out in
> > > > > > > > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > > > > > ---
> > > > > > > > >  fs/proc/meminfo.c             |  7 +++++++
> > > > > > > > >  include/linux/swap.h          |  5 +++++
> > > > > > > > >  include/linux/vm_event_item.h |  4 ++++
> > > > > > > > >  mm/vmstat.c                   |  4 ++++
> > > > > > > > >  mm/zswap.c                    | 13 ++++++-------
> > > > > > > > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > > > > > > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > > > > > > > --- a/fs/proc/meminfo.c
> > > > > > > > > +++ b/fs/proc/meminfo.c
> > > > > > > > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > > > > > > > >  
> > > > > > > > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > > > > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > > > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > > > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > > > > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > > > > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > > > > +		   (PAGE_SHIFT - 10));
> > > > > > > > > +#endif
> > > > > > > > 
> > > > > > > > I agree it would be very handy to have the memory consumption in meminfo
> > > > > > > > 
> > > > > > > > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > > > > > > > 
> > > > > > > > If we really go this Zswap only metric instead of general term
> > > > > > > > "Compressed", I'd like to post maybe "Zram:" with same reason
> > > > > > > > in this patchset. Do you think that's better idea instead of
> > > > > > > > introducing general term like "Compressed:" or something else?
> > > > > > > 
> > > > > > > I'm fine with changing it to Compressed. If somebody cares about a
> > > > > > > more detailed breakdown, we can add Zswap, Zram subsets as needed.
> > > > > > 
> > > > > > Thanks! Please consider ZSWPIN to rename more general term, too.
> > > > > 
> > > > > That doesn't make sense to me.
> > > > > 
> > > > > Zram is a swap backend, its traffic is accounted in PSWPIN/OUT. Zswap
> > > > > is a writeback cache on top of the swap backend. It has pages
> > > > > entering, refaulting, and being written back to the swap backend
> > > > > (PSWPOUT). A zswpout and a zramout are different things.
> > > > 
> > > > Think about that system has two swap devices (storage + zram).
> > > > I think it's useful to know how many swap IO comes from zram
> > > > and rest of them are storage.
> > > 
> > > Hm, isn't this comparable to having one swap on flash and one swap on
> > > a rotating disk? /sys/block/*/stat should be able to tell you how
> > > traffic is distributed, no?
> > 
> > That raises me a same question. Could you also look at the zswap stat
> > instead of adding it into vmstat? (If zswap doesn't have the counter,
> > couldn't we simply add new stat in sysfs?)
> 
> My point is that for regular swap backends there is already
> PSWP*. Distinguishing traffic between two swap backends is legitimate
> of course, but zram is not really special compared to other backends
> from that POV. It's only special in its memory consumption.
> 
> zswap *is* special, though. Even though some people use it *like* a
> swap backend, it's also a cache on top of swap. zswap loads and stores
> do not show up in PSWP*. And they shouldn't, because in a cache
> configuration, you still need the separate PSWP* stats to understand
> cache eviction behavior and cache miss ratio. memory -> zswap is
> ZSWPOUT; zswap -> disk is PSWPOUT; PSWPIN is a cache miss etc.
> 
> > I thought the patch aims for exposting statistics to grab easier
> > using popular meminfo and vmstat and wanted to leverage it for
> > zram, too.
> 
> Right. zram and zswap overlap in their functionality and have similar
> deficits in their stats. Both should be fixed, I'm not opposing
> that. But IMO we should be careful about conflating
> them. Fundamentally, one is a block device, the other is an MM-native
> cache layer that sits on top of block devices. Drawing false
> equivalencies between them will come back to haunt us.

Make sense to me.
