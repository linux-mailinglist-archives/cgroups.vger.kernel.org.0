Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E8513AFA
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbiD1RfF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346684AbiD1RfE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 13:35:04 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F02A66F89;
        Thu, 28 Apr 2022 10:31:49 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id h1so4810810pfv.12;
        Thu, 28 Apr 2022 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O5rgxxNLcUoozxHrIfe6C8PWavZ3F1iuN11i5Agtycw=;
        b=KMkykjjprAhd2Vr1vJN0LmzavMT/mYNHAeeP6qnDg/LDjvFS1l7VaFA1jIBQzfV5qL
         wvsUvg+GNSRoEivJ5V+jCqOqpoXT1LIgwKb0WGg6a7blsMb9xbx6tDxcd+Eah050FzO4
         X5iswbbw4P9MbdCL7Dc7qsi/g1f5VgUYCcEBjoZX0V8fAHyGbtgz7qU+JNmOp4D5Ed6a
         kNOJ/4wYxG/2NksSGYuDSHdye5mUCZmpx3YYyqfrav20k6V3hRiyJWozrNNRLX6o03VG
         stGCIaQzY94lwV991u5G3Bx3xzsQMgT6h5R0XoJT55V7uOEKw8YqQhVIOv5/QfHoyhDD
         hmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=O5rgxxNLcUoozxHrIfe6C8PWavZ3F1iuN11i5Agtycw=;
        b=S1AsG/gD4voMdKzy74+NN5GZbn3TePsTWlpQYrxgEyqfgrtSDg91Ef/FDdkh0825en
         ho9w1jDZUQiy3skYENik3n9pvY9CTIoDd2T7sh4H60GI9k4O3vOahD85vhxcimXj2gJL
         r0b+D+IyQs48FrwxebGgx115otMntGucO7mJS6g3znRS2ALxt3XgxdEVFlyrATmLGUqb
         sv5ma2RTWdDYPi+wf4gE/ermM8hLqwZCvrZ9lmQTIVuKYcTSZj99nSLdq/MV0CAEQCI2
         LH+yc0upzUDZtKXvhH2dFsiHtQAjLPPy+VxWzDAkz5Xvw58dIKmh3MJxrWGJja39QklX
         9l2w==
X-Gm-Message-State: AOAM531KgEXWy7nAL3VdbDK6HAx+Gf/uFoUsXszmJhKEx9xA+70XX85j
        upIYHx7FuZ4U+SalSeV0axc=
X-Google-Smtp-Source: ABdhPJxq0c+k6KVhZYOQptiZKD/wqkp6LW7t+ndte7xfGjJjErK73Be3Hq6U1Twa0p/aoUgr8eRGzA==
X-Received: by 2002:a65:4848:0:b0:39c:c393:688c with SMTP id i8-20020a654848000000b0039cc393688cmr28566847pgs.376.1651167108932;
        Thu, 28 Apr 2022 10:31:48 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:dc95:713b:f72c:4ad4])
        by smtp.gmail.com with ESMTPSA id b29-20020a62a11d000000b0050d8d39892bsm429362pff.166.2022.04.28.10.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:31:47 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 28 Apr 2022 10:31:45 -0700
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
Message-ID: <YmrPgWs5WPabIBQk@google.com>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <YmnA0Da90IURbxrM@google.com>
 <Ymqj93gEEzu2Gb3U@cmpxchg.org>
 <YmrICbP6bDJqDv5R@google.com>
 <YmrNiY3VhdMbfTq1@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmrNiY3VhdMbfTq1@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 01:23:21PM -0400, Johannes Weiner wrote:
> On Thu, Apr 28, 2022 at 09:59:53AM -0700, Minchan Kim wrote:
> > On Thu, Apr 28, 2022 at 10:25:59AM -0400, Johannes Weiner wrote:
> > > On Wed, Apr 27, 2022 at 03:16:48PM -0700, Minchan Kim wrote:
> > > > On Wed, Apr 27, 2022 at 05:20:29PM -0400, Johannes Weiner wrote:
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
> > > > > > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > > > > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > > > > +#ifdef CONFIG_ZSWAP
> > > > > > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > > > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > > > > > > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > > > > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > > > > +		   (PAGE_SHIFT - 10));
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
> > > > Thanks! Please consider ZSWPIN to rename more general term, too.
> > > 
> > > That doesn't make sense to me.
> > > 
> > > Zram is a swap backend, its traffic is accounted in PSWPIN/OUT. Zswap
> > > is a writeback cache on top of the swap backend. It has pages
> > > entering, refaulting, and being written back to the swap backend
> > > (PSWPOUT). A zswpout and a zramout are different things.
> > 
> > Think about that system has two swap devices (storage + zram).
> > I think it's useful to know how many swap IO comes from zram
> > and rest of them are storage.
> 
> Hm, isn't this comparable to having one swap on flash and one swap on
> a rotating disk? /sys/block/*/stat should be able to tell you how
> traffic is distributed, no?

That raises me a same question. Could you also look at the zswap stat
instead of adding it into vmstat? (If zswap doesn't have the counter,
couldn't we simply add new stat in sysfs?)

I thought the patch aims for exposting statistics to grab easier
using popular meminfo and vmstat and wanted to leverage it for
zram, too.

> 
> What I'm more worried about is the fact that in theory you can stack
> zswap on top of zram. Consider a fast compression cache on top of a
> higher compression backend. Is somebody doing this now? I doubt
> it. But as people look into memory tiering more and more, this doesn't
> sound entirely implausible. If the stacked layers then share the same
> in/out events, it would be quite confusing.
> 
> If you think PSWPIN/OUT and per-device stats aren't enough, I'm not
> opposed to adding zramin/out to /proc/vmstat as well. I think we're
> less worried there than with /proc/meminfo. I'd just prefer to keep
> them separate from the zswap events.
> 
> Does that sound reasonable?
> 
