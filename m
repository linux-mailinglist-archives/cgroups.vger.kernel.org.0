Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43676513ACA
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 19:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239747AbiD1R1P (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236557AbiD1R1O (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 13:27:14 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06D55BD2C
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 10:23:58 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id hh4so3981426qtb.10
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9SmhuH9L8EteTfK00zaW2y4ppXf8qMlwYgDRccWGmt8=;
        b=muYbbgHfo9WGJ1lQRYahawpH/mrMNBfK7mzuL6u28IeAbj+iYGwzrcpKpmnim+KBUZ
         5zkJFG9NzPq3+fKpOGZOAOCrXhf1wnatHjmKIAJUsMQs5U0pugjuVBY2Z7AgfvG4w+UV
         GwUMTlFqZrpnjMRWFeuK056BahnHxRCPKIVERaYT1ttVL6koUM8tI9eLPPI8y6nh9S2h
         MsMQWashOIjoU1ALQwCGF9oKu1uSxRIMYVl11VzzxDSKsalcUzJEheKrtsHyEtXmJG40
         tJ3Xv6dwPjHqkXwnMbRYE8iYiEZDw1H010FE9plnpaCbA12V/gFpErMKMqYXYn3TC5FN
         UvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9SmhuH9L8EteTfK00zaW2y4ppXf8qMlwYgDRccWGmt8=;
        b=0mwP7nHlGvtYhkRUirDJjhH/DuanzGkHJrplbFr5fBciUVvCLoWdHQfGvaaMxR8QS+
         nNemEqhaNCdgSNpn9dFFkGDbIAxOmLoRETDMizUVG1oT6gxJbT1q620KlyC6uYiwZYVH
         dIOMw1mtpmzkQeQSLJA1OPpTBkmDQsEwOd3ga+u29CItc1G5+SgnSCaIc8PlFXTaMQoK
         1SlmRAhGGnhZONS/9A4FyGk3sp6U25Q41sUrKrT+1l8MO/aH0uIylgYycEhe7RHL0PBK
         ly2U6PEhEZZ5qAti4RdPusTGBnS1z7M3OS2WItmC4de77H9AoI4yYKA2QvV0gYqHPNzs
         eyyQ==
X-Gm-Message-State: AOAM5321cFRw8Hwdf7b7obSoA2MxGvkxXkF69Fz1pwwqZSY4k3MrNPJB
        mHFBXWaJhf+XTwqufkFXwevJaA==
X-Google-Smtp-Source: ABdhPJwPBY/yZrmknEwO4veeRiADb88VVdN+HFu5zetzKWqgqCrSrcG/aNqmjS33EJPEa7e9C7+Xgw==
X-Received: by 2002:ac8:6ce:0:b0:2f0:29dd:bbc5 with SMTP id j14-20020ac806ce000000b002f029ddbbc5mr24591969qth.216.1651166637780;
        Thu, 28 Apr 2022 10:23:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id y13-20020a05622a164d00b002f1ff52c518sm337931qtj.28.2022.04.28.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:23:57 -0700 (PDT)
Date:   Thu, 28 Apr 2022 13:23:21 -0400
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
Message-ID: <YmrNiY3VhdMbfTq1@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <YmnA0Da90IURbxrM@google.com>
 <Ymqj93gEEzu2Gb3U@cmpxchg.org>
 <YmrICbP6bDJqDv5R@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmrICbP6bDJqDv5R@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 09:59:53AM -0700, Minchan Kim wrote:
> On Thu, Apr 28, 2022 at 10:25:59AM -0400, Johannes Weiner wrote:
> > On Wed, Apr 27, 2022 at 03:16:48PM -0700, Minchan Kim wrote:
> > > On Wed, Apr 27, 2022 at 05:20:29PM -0400, Johannes Weiner wrote:
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
> > > > > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > +		   (PAGE_SHIFT - 10));
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
> > > Thanks! Please consider ZSWPIN to rename more general term, too.
> > 
> > That doesn't make sense to me.
> > 
> > Zram is a swap backend, its traffic is accounted in PSWPIN/OUT. Zswap
> > is a writeback cache on top of the swap backend. It has pages
> > entering, refaulting, and being written back to the swap backend
> > (PSWPOUT). A zswpout and a zramout are different things.
> 
> Think about that system has two swap devices (storage + zram).
> I think it's useful to know how many swap IO comes from zram
> and rest of them are storage.

Hm, isn't this comparable to having one swap on flash and one swap on
a rotating disk? /sys/block/*/stat should be able to tell you how
traffic is distributed, no?

What I'm more worried about is the fact that in theory you can stack
zswap on top of zram. Consider a fast compression cache on top of a
higher compression backend. Is somebody doing this now? I doubt
it. But as people look into memory tiering more and more, this doesn't
sound entirely implausible. If the stacked layers then share the same
in/out events, it would be quite confusing.

If you think PSWPIN/OUT and per-device stats aren't enough, I'm not
opposed to adding zramin/out to /proc/vmstat as well. I think we're
less worried there than with /proc/meminfo. I'd just prefer to keep
them separate from the zswap events.

Does that sound reasonable?
