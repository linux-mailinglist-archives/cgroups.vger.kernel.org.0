Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0375136D7
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 16:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348334AbiD1O3x (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 10:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348134AbiD1O3w (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 10:29:52 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36193ED19
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:26:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s4so3760485qkh.0
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k2xk0VfPUZZR4PgPEBFE7KbYEWH+FmFopnCFIlm7PdU=;
        b=BV94KuxAotFnCW2rpxR5ikP/WxESDoIazAhKPFkO1eGzDxo7hawOoKkHC0UbhoIeQy
         kZg8jfkxgeybcxSbVkPKyf/R8j319H1hEEjldKPErEBwufuhSw5mT4aclDQzGTGmOQ4z
         vfMoivqIpG4ELDuBcZ0Lo3UjNSF9EOuclEjFk4kMkAuHZnXHnZGbiU71bRjNAWpZoXdE
         OVtUxqBbeYfV85GYLzG9DEZSYCi7JYWgpRIAP4TxPtab35D28kaePo90gYcCyWnoTDSJ
         nh0zCTTwNRYmmxH3C3h+6DAcalHEbjnTNIOcg75fSF6dIHkflMcrL1mdWIN+kjqV2eZ+
         euow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k2xk0VfPUZZR4PgPEBFE7KbYEWH+FmFopnCFIlm7PdU=;
        b=KK2xgAJSX6iwzHUKA11O3vQgGW6tF8lwFMIaLRSB9OAkRH3PkReJJug8ATPpqnSuUC
         6f5vihgoKhLvXG7tgQT1vOjs2nskRAIoqfKmAGQ9y7AYXwEbu+AGRofa8Bm3det7oFy2
         FJ1PyyPG8uGJWbQJTb2SGUYXsgKhjPdkldE2PygajH3QjnxhPv30CJYzoi7eXLNXqP8H
         y4zVJelBDbLmWWM8VWBqMR9YpQl1Bf5ePC5t/Mpp50kvrsxffA9HOUVc9SlnBJ4QlDWz
         t9A2H3KQgKlJoLBHlWiHZd3/tekLKMay2mbiNQS8+rj4uMA71ftWF6qIrOWdZrHjOvWd
         qd/A==
X-Gm-Message-State: AOAM530Qz1dI59PVVhGCAw3ZS5YR3LYoGZV+0+To8PdSTpYp9WmHhBt/
        XhKrrh4eurOnx3Ux7zSDS4s04g==
X-Google-Smtp-Source: ABdhPJxHZfOb9UMTvMfY0TOYnsyNy3pAynw8UhikG/kgqUZQDoSwCT+rqvbeUsQFKMN84pGDPsTDfQ==
X-Received: by 2002:a05:620a:d85:b0:67b:a4:2036 with SMTP id q5-20020a05620a0d8500b0067b00a42036mr19369088qkl.112.1651155995814;
        Thu, 28 Apr 2022 07:26:35 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id 21-20020ac85755000000b002f390bd8ac0sm84027qtx.53.2022.04.28.07.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:26:35 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:25:59 -0400
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
Message-ID: <Ymqj93gEEzu2Gb3U@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <YmnA0Da90IURbxrM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmnA0Da90IURbxrM@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 03:16:48PM -0700, Minchan Kim wrote:
> On Wed, Apr 27, 2022 at 05:20:29PM -0400, Johannes Weiner wrote:
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
> Thanks! Please consider ZSWPIN to rename more general term, too.

That doesn't make sense to me.

Zram is a swap backend, its traffic is accounted in PSWPIN/OUT. Zswap
is a writeback cache on top of the swap backend. It has pages
entering, refaulting, and being written back to the swap backend
(PSWPOUT). A zswpout and a zramout are different things.

> > From 8e9e2d6490b7082c41743fbdb9ffd2db4e3ce962 Mon Sep 17 00:00:00 2001
> > From: Johannes Weiner <hannes@cmpxchg.org>
> > Date: Wed, 27 Apr 2022 17:15:15 -0400
> > Subject: [PATCH] mm: zswap: add basic meminfo and vmstat coverage fix fix
> > 
> > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Just for completeness,

Nacked-by: Johannes Weiner <hannes@cmxpchg.org>

> > @@ -87,7 +87,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
> >  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
> >  	show_val_kb(m, "SwapFree:       ", i.freeswap);
> >  #ifdef CONFIG_ZSWAP
> > -	seq_printf(m,  "Zswap:          %8lu kB\n",
> > +	seq_printf(m,  "Compressed:     %8lu kB\n",
> >  		   (unsigned long)(zswap_pool_total_size >> 10));
> >  	seq_printf(m,  "Zswapped:       %8lu kB\n",
> >  		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> > -- 
> > 2.35.3
> > 
