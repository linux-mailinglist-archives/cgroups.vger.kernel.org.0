Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900B9512526
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 00:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234434AbiD0WUE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 27 Apr 2022 18:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiD0WUD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 27 Apr 2022 18:20:03 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FE6496A8;
        Wed, 27 Apr 2022 15:16:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id i62so2471168pgd.6;
        Wed, 27 Apr 2022 15:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2RoFaE1ytRBTyXgweqhP00vnNCFBWuqPT9MahXuxpik=;
        b=TXgc7SpRW4PY86E79NxGxT/h7KY/SJkkCDx3kBxe7VJ98gCHJ86n8sPgZeFo9p/O6c
         ulCHi53fjQKhKCqe6S8lFxfrbHxZSPxC9kPYHdh9+c7XDZzS90uxFvp3agkHKJe+0Or4
         TjPdNh5MxypqyG2xi3F8z3EmdTA8UGKCgbLbVVRingY9D+XGHRAAKkVkIzyMOv1Xm7zG
         o6Lh4eMvgjkeCHqaZVNCdpuAg0SQ+/QSpPpaAhH2UOBGT49H1VSN3WZwbOTPsqSlhU8T
         DtrssrAqFHr5TMYpTrQpCvE345AEgT292jIPY3U2lbtqPLbIX4Ftn6BAxNnUcj2onBFZ
         pnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2RoFaE1ytRBTyXgweqhP00vnNCFBWuqPT9MahXuxpik=;
        b=oG+QikTTpwwiOFc7lItRG8ZhpV3WHg3YkMpaeYvMlYYe+QVv2o0bOUUt7WRjoUFrjp
         XeVFvsbV00SN5HF4ncLDsVIEO5kyTFUX/kTRrRKRWysNKkoC7xNmoOTzLMuAC2eHHxb3
         zh3ett+oPyn8sIGS65sqx7RAi2A6Uxrh/2DqhoK2mDoZgH0UFRMfwTajhxhOiGEvCxkM
         jqKe/Ixsz3DMIzLtgnsNzrfe8gt8PedTqjaha4NfIrhwPk8Ad5Tqa+a526R/necpU1FO
         NYTZQK6SSRZksJNdzq8c7+eDubRHLIdl0unY7TEVU2kcEetA0jx2TTcuDsEjD/9Bmj+D
         BNSw==
X-Gm-Message-State: AOAM533blN0EtJUX3I4nvR3XgDKmFmJO1nTqlhKeEbfhSPu5mo26uPhH
        oTUci8n15qasei+R6/8VcPM=
X-Google-Smtp-Source: ABdhPJxG8fhTyLclRTDp7SI0nqPDWxAD3Pb244ovq9B02YRPOPT0/gNbh0cMUp+VSmNA5FRn3wH87Q==
X-Received: by 2002:a05:6a00:22c7:b0:50d:605d:2d28 with SMTP id f7-20020a056a0022c700b0050d605d2d28mr9896981pfj.80.1651097810561;
        Wed, 27 Apr 2022 15:16:50 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:546a:2875:2a75:1b94])
        by smtp.gmail.com with ESMTPSA id h19-20020a63df53000000b003c14af50634sm307625pgj.76.2022.04.27.15.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:16:50 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 27 Apr 2022 15:16:48 -0700
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
Message-ID: <YmnA0Da90IURbxrM@google.com>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmmznQ8AO5RLxicA@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 05:20:29PM -0400, Johannes Weiner wrote:
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

Thanks! Please consider ZSWPIN to rename more general term, too.

> 
> From 8e9e2d6490b7082c41743fbdb9ffd2db4e3ce962 Mon Sep 17 00:00:00 2001
> From: Johannes Weiner <hannes@cmpxchg.org>
> Date: Wed, 27 Apr 2022 17:15:15 -0400
> Subject: [PATCH] mm: zswap: add basic meminfo and vmstat coverage fix fix
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  Documentation/filesystems/proc.rst | 7 ++++---
>  fs/proc/meminfo.c                  | 2 +-
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 8b5a94cfa722..93edcf233464 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -964,7 +964,7 @@ Example output. You may not have all of these fields.
>      Mlocked:               0 kB
>      SwapTotal:             0 kB
>      SwapFree:              0 kB
> -    Zswap:              1904 kB
> +    Compressed:         1904 kB
>      Zswapped:           7792 kB
>      Dirty:                12 kB
>      Writeback:             0 kB
> @@ -1057,8 +1057,9 @@ SwapTotal
>  SwapFree
>                Memory which has been evicted from RAM, and is temporarily
>                on the disk
> -Zswap
> -              Memory consumed by the zswap backend (compressed size)
> +Compressed
> +              Memory consumed by compression backends, such as zswap
> +              (compressed size)
>  Zswapped
>                Amount of anonymous memory stored in zswap (original size)
>  Dirty
> diff --git a/fs/proc/meminfo.c b/fs/proc/meminfo.c
> index 6e89f0e2fd20..554d6f230e67 100644
> --- a/fs/proc/meminfo.c
> +++ b/fs/proc/meminfo.c
> @@ -87,7 +87,7 @@ static int meminfo_proc_show(struct seq_file *m, void *v)
>  	show_val_kb(m, "SwapTotal:      ", i.totalswap);
>  	show_val_kb(m, "SwapFree:       ", i.freeswap);
>  #ifdef CONFIG_ZSWAP
> -	seq_printf(m,  "Zswap:          %8lu kB\n",
> +	seq_printf(m,  "Compressed:     %8lu kB\n",
>  		   (unsigned long)(zswap_pool_total_size >> 10));
>  	seq_printf(m,  "Zswapped:       %8lu kB\n",
>  		   (unsigned long)atomic_read(&zswap_stored_pages) <<
> -- 
> 2.35.3
> 
