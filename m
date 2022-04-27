Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68BB51251B
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 00:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbiD0WPd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 18:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiD0WPd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 18:15:33 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D886E32;
        Wed, 27 Apr 2022 15:12:20 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id z21so2476560pgj.1;
        Wed, 27 Apr 2022 15:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XXb42XiH+ukC9z7j3bBup8sRRl4KaGc4g7+LlMYSHsA=;
        b=Ws495q2rl2PRGj/zVnW5ZArxK3DYt6X/R641/Rg4daUGK5XREH0QoEi3vo4dOrnylv
         nP3eMrTlYZWHRUyOoBu/xrKPZ2+lmrhsSlg9egRevjW/NgcxcSBcwPi27LwUCBj6owub
         kcJkjnYF1BYOUc2SQz1i21KiLaGf3zKZxIK9Ff5IoHm/vhFuwWVc1xa15T7n334wy8Xf
         fMRPixKczaNFkniv3DoL5k3q+7DL86Pig/zQIONH8YyaTzxbDMqHdPA16yAu/5RKeusa
         dOse573kLTyhajewwEJzfifVdlrEfSxKvsC87iTJ29vMlS+9nttNB572LQsHcf9BbcKF
         zD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XXb42XiH+ukC9z7j3bBup8sRRl4KaGc4g7+LlMYSHsA=;
        b=4D4k41OTZVCGm3XJQ9Sewmvsg7jjVRvDrHZUJS7Ym6vW7V0/+k6hEnOIBHgmfRgR2+
         M6CtBVvJGWkQgrAFEFvm68gMwsDr2mkHbdPpla5Wu7u5MGA3BEDkdbg3ThHG1iyJ5l/a
         2eiX4XCkyXcKMc1NpNh+vIw2CeE0KodiqfW1Qtx9QsEjmHKdleTAzjfi1a7hh95vHH/A
         0NQxEwElYTksV/aGED/r4uIXaMWyoJgOTNWsG4RUBGHEVP9wJZ5yLQXFvan9sCJw99X6
         LsPy3M2gBH4Cq4xr1He0owDWNDByKTMQaAIFge6IP7ZaNJHT7wU10UbYPvCzc/don4yv
         WRgw==
X-Gm-Message-State: AOAM530iZzgwLfd/58eWFCNRbwGNxM5++MG/3Tl7B2Lm63yluh619ez2
        0AlO8hoTZh6FoIS0OeTmXmI=
X-Google-Smtp-Source: ABdhPJzwmVF1HrfAv/PhFstcfrhOoUkpUM8r6eZpLrOQwgydnwT6oOkkV1+/wj3E5aYvB2gTl78USw==
X-Received: by 2002:a63:2266:0:b0:39c:f643:ee69 with SMTP id t38-20020a632266000000b0039cf643ee69mr25066170pgm.288.1651097539917;
        Wed, 27 Apr 2022 15:12:19 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:546a:2875:2a75:1b94])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a1a1200b001da160621d1sm3693495pjk.45.2022.04.27.15.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:12:19 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 27 Apr 2022 15:12:17 -0700
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
Message-ID: <Ymm/wayEB3MH6ZRY@google.com>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymm3WpvJWby4gaD/@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 05:36:26PM -0400, Johannes Weiner wrote:
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
> > > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > > +#ifdef CONFIG_ZSWAP
> > > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > > > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > > +		   (PAGE_SHIFT - 10));
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

My usecase with zram is Android which doesn't use memcg.
