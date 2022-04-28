Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4688C513BA0
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 20:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350876AbiD1SiY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 14:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348000AbiD1SiX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 14:38:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9751F13F89
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 11:35:06 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s4so4318600qkh.0
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 11:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ugQMiswQ3FtlNfbd5S1Cs00NrebB6/yQ6qlB0CbEuo=;
        b=izbzVdnqmdIK+VBGaeAtYzR/4stEUIQ3i/Tzy1/5c4UYIQWW2afku1oa7qX6ptYYbX
         ujtlmErIsLSRWIoaCYtSOLP6d1a9oXeyUw8m4EvkXplGd2vYDZvJtiuj0x3UBD0C/ur8
         qdRqnZnrgu2OKhWFt63OPZ084rWufen4ke6QRR+ndfY1lpfW5QX9gHVCi5Aj5SnlJCIR
         syhtIXV2zw/Mr3lPQCjjLmGUIkBwoayr639kpy7XCAOlMj5gm73pFbqywUndB5V77qWT
         bNOz+bGnwiJyh5gynO83kU+KhEy2RwLPyyMJ+rkTED4rBrVxNt+bTs+F0Bvtte96NmOQ
         Hecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ugQMiswQ3FtlNfbd5S1Cs00NrebB6/yQ6qlB0CbEuo=;
        b=6+PPvX2QxLSfsXYXwkdomq8Bv97y4uhe/Eqgh5w3o/XgO6eHRzNmrxqu9g+shEBz1t
         1wVSpElCG3fWiDJ1F4eAGazPauImn1O1GlgPkGSBXmF7HCJXrE0ktbDyB9qW3SRTXFVx
         MzmK4Ib305g/jqmo14O8iXi2joL3AutDxNrwlYI/r8g3v04dIWdNV44y2EfDerhXXUtt
         5JtQTxIygVviQlW2ubX7s1WeBnJ4Yz8Mt2KjlEFsPGhNOyFxVrCVEskXrDmkjDqeBghH
         lQNJcMw32iFxhNjwxnxow4GN8Pr1OYF9ldJCgrM1PG4MFNp3IW7b+ZOAFVqOxtdDehzN
         eQ5Q==
X-Gm-Message-State: AOAM533jk0wRVY0Ow0rACgAt8CihW/LvziqRzawVVEORjaNAqweMnY9n
        SEmxxn/ksvwuxkSXjdYujWARmQ==
X-Google-Smtp-Source: ABdhPJzJLSBxlhNYP8hU3o4notM7XrlTWB3+RyEKfhUd63EyjB+FcZ3NxJckIKkwSVEGpnuShiJkxQ==
X-Received: by 2002:a37:9dc9:0:b0:69f:9e56:68ec with SMTP id g192-20020a379dc9000000b0069f9e5668ecmr3395964qke.394.1651170905671;
        Thu, 28 Apr 2022 11:35:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id c27-20020ac84e1b000000b002f3851fcac0sm375767qtw.65.2022.04.28.11.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 11:35:05 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:34:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YmreNLge7b+FBC30@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <YmnA0Da90IURbxrM@google.com>
 <Ymqj93gEEzu2Gb3U@cmpxchg.org>
 <YmrICbP6bDJqDv5R@google.com>
 <YmrNiY3VhdMbfTq1@cmpxchg.org>
 <YmrPgWs5WPabIBQk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmrPgWs5WPabIBQk@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 10:31:45AM -0700, Minchan Kim wrote:
> On Thu, Apr 28, 2022 at 01:23:21PM -0400, Johannes Weiner wrote:
> > On Thu, Apr 28, 2022 at 09:59:53AM -0700, Minchan Kim wrote:
> > > On Thu, Apr 28, 2022 at 10:25:59AM -0400, Johannes Weiner wrote:
> > > > On Wed, Apr 27, 2022 at 03:16:48PM -0700, Minchan Kim wrote:
> > > > > On Wed, Apr 27, 2022 at 05:20:29PM -0400, Johannes Weiner wrote:
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
> > > > > > > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > > > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > > > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > > > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > > > +		   (PAGE_SHIFT - 10));
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
> > > > > Thanks! Please consider ZSWPIN to rename more general term, too.
> > > > 
> > > > That doesn't make sense to me.
> > > > 
> > > > Zram is a swap backend, its traffic is accounted in PSWPIN/OUT. Zswap
> > > > is a writeback cache on top of the swap backend. It has pages
> > > > entering, refaulting, and being written back to the swap backend
> > > > (PSWPOUT). A zswpout and a zramout are different things.
> > > 
> > > Think about that system has two swap devices (storage + zram).
> > > I think it's useful to know how many swap IO comes from zram
> > > and rest of them are storage.
> > 
> > Hm, isn't this comparable to having one swap on flash and one swap on
> > a rotating disk? /sys/block/*/stat should be able to tell you how
> > traffic is distributed, no?
> 
> That raises me a same question. Could you also look at the zswap stat
> instead of adding it into vmstat? (If zswap doesn't have the counter,
> couldn't we simply add new stat in sysfs?)

My point is that for regular swap backends there is already
PSWP*. Distinguishing traffic between two swap backends is legitimate
of course, but zram is not really special compared to other backends
from that POV. It's only special in its memory consumption.

zswap *is* special, though. Even though some people use it *like* a
swap backend, it's also a cache on top of swap. zswap loads and stores
do not show up in PSWP*. And they shouldn't, because in a cache
configuration, you still need the separate PSWP* stats to understand
cache eviction behavior and cache miss ratio. memory -> zswap is
ZSWPOUT; zswap -> disk is PSWPOUT; PSWPIN is a cache miss etc.

> I thought the patch aims for exposting statistics to grab easier
> using popular meminfo and vmstat and wanted to leverage it for
> zram, too.

Right. zram and zswap overlap in their functionality and have similar
deficits in their stats. Both should be fixed, I'm not opposing
that. But IMO we should be careful about conflating
them. Fundamentally, one is a block device, the other is an MM-native
cache layer that sits on top of block devices. Drawing false
equivalencies between them will come back to haunt us.
