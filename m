Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B4513A93
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbiD1RDM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbiD1RDL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 13:03:11 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0319B6E6C;
        Thu, 28 Apr 2022 09:59:56 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id h1so4737737pfv.12;
        Thu, 28 Apr 2022 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZDYp2Y77Y0buY8pwqMtyLcOAE+45dX/zsVX064x7LX0=;
        b=T5FFCS6UotdYG74iCBtYERNBWBj0bDr3newq9MZ2CU9iAU7Mvp0pkO5CiXjERw7Z4h
         dtH/fRg2OWCurCYY/v6eAgs86zEARY/k+6a8gV+KFp5cnuwhIc+5wD3LrAQy89ZpYjGn
         zh4XBjGCMww1+wmz3wu4aESExAsU5U3STiPkEsu5tnyY86NbVyZRjEGc1jDnJahB9RoI
         akO6N05QtWT7jO5Nq0Op+bDPxkkBcZqWYPxqRyT/l6r+xlIU6CgdduGLX8sp2gwYd8TJ
         5Y4/YsTIot25E8QLmvce9ubCcCd/jkHViC+wf9ZWxyci0PT7D76bJhMzp9dpPEi16tdZ
         /xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ZDYp2Y77Y0buY8pwqMtyLcOAE+45dX/zsVX064x7LX0=;
        b=NxhGK5NRmQm4A+imMm06k3557NXc8+fMT2lrTnLBFuXDltWwozgW3HDFcYA9p19Rp5
         oX6eIogeCpzHtkEoplJUvXiJ699YywX31w9at0cJV2NX0A4O2WUvNwigUvnrXJ+sqqtH
         T52oFPPxZYUZkrPqo5pxQagiqalWy5JpM1IxeQJuM0+w0y8BSVEwgNxfxvzg4Iyed4AX
         xJrSZe6IFBnoLAkuu7qy6MzdUE1ycDc5hf0/l6EqtjYB9wyEyfm1imRqjzze7mYc4Tzc
         M0pe9CfWcWdxElq5i8V9Dz1m/7z+G73JV8AkmNL8Wp8fg+5zpO0rnXW04leW77wNeqO8
         kiRQ==
X-Gm-Message-State: AOAM530vyqYLKF4OuFJi4pkp4t4Rz+LtGMiZOXAuOlwHAOJ6LiuhPY3j
        mfRuQGJIRtrJ0GSWh4V9lHSYa2yFZNs=
X-Google-Smtp-Source: ABdhPJwPPcw3VwBhysd0ZeuGi4yi13I/NUSthjo0ZKPGjaYuM6U1k+/xijgpEn8AmcNANaQZXubH8w==
X-Received: by 2002:aa7:9f1d:0:b0:50d:3ae5:9cac with SMTP id g29-20020aa79f1d000000b0050d3ae59cacmr23636951pfr.9.1651165196014;
        Thu, 28 Apr 2022 09:59:56 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:dc95:713b:f72c:4ad4])
        by smtp.gmail.com with ESMTPSA id x126-20020a628684000000b0050d3f600ed0sm379077pfd.40.2022.04.28.09.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:59:55 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 28 Apr 2022 09:59:53 -0700
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
Message-ID: <YmrICbP6bDJqDv5R@google.com>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <YmnA0Da90IURbxrM@google.com>
 <Ymqj93gEEzu2Gb3U@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymqj93gEEzu2Gb3U@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 10:25:59AM -0400, Johannes Weiner wrote:
> On Wed, Apr 27, 2022 at 03:16:48PM -0700, Minchan Kim wrote:
> > On Wed, Apr 27, 2022 at 05:20:29PM -0400, Johannes Weiner wrote:
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
> > > > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > +#ifdef CONFIG_ZSWAP
> > > > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > > > > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > +		   (PAGE_SHIFT - 10));
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
> > Thanks! Please consider ZSWPIN to rename more general term, too.
> 
> That doesn't make sense to me.
> 
> Zram is a swap backend, its traffic is accounted in PSWPIN/OUT. Zswap
> is a writeback cache on top of the swap backend. It has pages
> entering, refaulting, and being written back to the swap backend
> (PSWPOUT). A zswpout and a zramout are different things.

Think about that system has two swap devices (storage + zram).
I think it's useful to know how many swap IO comes from zram
and rest of them are storage.
