Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB59F51249D
	for <lists+cgroups@lfdr.de>; Wed, 27 Apr 2022 23:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiD0Vkt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 17:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbiD0Vkh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 17:40:37 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F007D8148F
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 14:37:05 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id jt15so1968613qvb.13
        for <cgroups@vger.kernel.org>; Wed, 27 Apr 2022 14:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jf9KoOg1H3jqjBGppZ/xxewMSo8dDOurdWUb3cYmU3c=;
        b=J86DG36ucbx0DlDChH/QyA2qGW9ZzuTV7lPr4Yhhk3+pV9+Qw+iYZfs23hrlx4+rfD
         giclbY4+1PxmOyj+mAHsv9VmlcODeRZorL+++DJBAt9RJIWnhq1wlvZL0JvKpHuHICLm
         dxEKItjNOKe2JxdIPAzsQ5baFAnBGf2Vh3niiGtwf9zwcMz93g13wjD3YEk9QkeLE+YK
         eFBdwJmwsg7s6P8IKgVpVGlIcKASf75RQGMzBKCQ7cQziovaXYvVEqGxP7AJ5aMa2M26
         RzZiEP14nT+f6jEpI0c9BCalzL328U8Fwv1zPeSnLj5NaVl3egPq1TcLnDuB8YzNCPxq
         C43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jf9KoOg1H3jqjBGppZ/xxewMSo8dDOurdWUb3cYmU3c=;
        b=V6dLbOAyJOblSXO6cFwbwJ/USdmrGi0WpK3thXc4J8kdeHXSNpwmHp7GPYOeDmZhGR
         XlrhTYevSl06xf+JAL4Lj0ZwJJgJ9V7gXnwKIjS+xy0yZvPUUEHN4j1c9S5+XBfpPp5E
         hZT7sd+wTo4Lfb2jhz+lgc6UtqsE1MtpbOBt5RLaQVOBOo22RyBWuDkvdZQsoN41tc1r
         H7N4Fftfj8XfNaQB+nuxlahhcRrvcfhZAU4phniiqu0UgU5cDffeTJNUJ+HagStdULci
         67LG+aLC8ribO35vyar77U6FR9wTFb4fCD0/xg190eSAVPFu2pAwsZ0rHwZDvPgVg0pn
         DsiA==
X-Gm-Message-State: AOAM533wmPgLAyY6M48swzx5jgp2RNDFG1c7qG33hh4DlXDD0gvkJs3q
        +VSo6+wwagCsV5VKO+mnvlQFJQ==
X-Google-Smtp-Source: ABdhPJyq+J76gHLpln3JZEsplM+ovXJH6AdQaG55HLv9cJpdF5NGETNJmQVeoVqtoV2YZmZe7GOcPQ==
X-Received: by 2002:a0c:f3d2:0:b0:456:34aa:5978 with SMTP id f18-20020a0cf3d2000000b0045634aa5978mr13519939qvm.59.1651095423111;
        Wed, 27 Apr 2022 14:37:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id b9-20020a05620a0f8900b0069e84c5352asm8370423qkn.47.2022.04.27.14.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:37:02 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:36:26 -0400
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
Message-ID: <Ymm3WpvJWby4gaD/@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmmznQ8AO5RLxicA@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
> On Wed, Apr 27, 2022 at 01:29:34PM -0700, Minchan Kim wrote:
> > Hi Johannes,
> > 
> > On Wed, Apr 27, 2022 at 12:00:15PM -0400, Johannes Weiner wrote:
> > > Currently it requires poking at debugfs to figure out the size and
> > > population of the zswap cache on a host. There are no counters for
> > > reads and writes against the cache. As a result, it's difficult to
> > > understand zswap behavior on production systems.
> > > 
> > > Print zswap memory consumption and how many pages are zswapped out in
> > > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > > ---
> > >  fs/proc/meminfo.c             |  7 +++++++
> > >  include/linux/swap.h          |  5 +++++
> > >  include/linux/vm_event_item.h |  4 ++++
> > >  mm/vmstat.c                   |  4 ++++
> > >  mm/zswap.c                    | 13 ++++++-------
> > >  5 files changed, 26 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> > > index 6fa761c9cc78..6e89f0e2fd20 100644
> > > --- a/fs/proc/meminfo.c
> > > +++ b/fs/proc/meminfo.c
> > > @@ -86,6 +86,13 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> > >  
> > >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> > >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> > > +#ifdef CONFIG_ZSWAP
> > > +	seq_printf(m,  "Zswap:          %8lu kB\n",
> > > +		   (unsigned long)(zswap_pool_total_size >> 10));
> > > +	seq_printf(m,  "Zswapped:       %8lu kB\n",
> > > +		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > > +		   (PAGE_SHIFT - 10));
> > > +#endif
> > 
> > I agree it would be very handy to have the memory consumption in meminfo
> > 
> > https://lore.kernel.org/all/YYwZXrL3Fu8%2FvLZw@google.com/
> > 
> > If we really go this Zswap only metric instead of general term
> > "Compressed", I'd like to post maybe "Zram:" with same reason
> > in this patchset. Do you think that's better idea instead of
> > introducing general term like "Compressed:" or something else?
> 
> I'm fine with changing it to Compressed. If somebody cares about a
> more detailed breakdown, we can add Zswap, Zram subsets as needed.

It does raise the question what to do about cgroup, though. Should the
control files (memory.zswap.current & memory.zswap.max) apply to zram
in the future? If so, we should rename them, too.

I'm not too familiar with zram, maybe you can provide some
background. AFAIU, Google uses zram quite widely; all the more
confusing why there is no container support for it yet.

Could you shed some light?

Thanks
