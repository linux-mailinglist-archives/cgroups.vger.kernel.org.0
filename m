Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4F0513651
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346042AbiD1OJM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348335AbiD1OJG (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 10:09:06 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A91C205EB
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:05:51 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id c1so3602651qkf.13
        for <cgroups@vger.kernel.org>; Thu, 28 Apr 2022 07:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EWNhQ6rVh6eXAW1cPKtOkkQDFiBPnV60f02tyxwR5Yc=;
        b=nibOfdXs0pW9RsNjEJkkttSRKnNqlNrv3VGuEoDx+NjanzQTMrPiHJBi6jLuBYlEBX
         NcO/5bG7QV10FdfyjroVW7zjvHmRCL6rESoVffMrL0roquyhR0RiqvnKOugcVXNzxQUv
         k+KjGFlWbI1y1+uZBSyBAhb5DLIo4mcmwiJJWFRu2M4LMUruthwmPcQm1TZjTnVUbevG
         iUldqaSPXn3+1z5uyqObupucLM6SHgKfNXHInYKV6a7ZZmUdMxKwRsdHyfT2sAGbHgZF
         D760Af4oY/VmKyobDe06ICDwWWOcI7CqP4m48CjvnuCsv6BaaaKe/enYr7XQgP56Ehbf
         7YeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EWNhQ6rVh6eXAW1cPKtOkkQDFiBPnV60f02tyxwR5Yc=;
        b=pmV7xNJhRL+X69nKw/NCsb6yfUz+Oc+nAU15jWl2c7HlWdrF5zUSiyL4jOAD19RSvd
         JWxa24TBulsednB1gcaunNGiOW9KXrdQ7AAS3j96+a20mFajr7Fq9hoPTWGP6yBxvIO4
         uu3+QLdxQu3AJiobXOj6U5wnisuZDK+gtIvArE+rD+sMN7rCjTAdBF7qyKyQp1d9ooR6
         QIabZk6S6dokPwyyZHHlF6waaz2ErinVFHFF0kB/F07VeXTjrU8PBNx7SFUzPu/k4hDw
         zRcS0hlMAs8/SaXArVhrBEefKQvkbrPbWQ2dyqEx15MF1hEWauv99gKV4CySarXK56ZX
         Ip8g==
X-Gm-Message-State: AOAM531QcYYxYdtb+zC2RIDDO6R2dgnA92iuMQ7/Efr0YuQDKcZ//nBI
        De/DL35vZ3bkIM2jpPGgSs1Zhw==
X-Google-Smtp-Source: ABdhPJzYZvJDZXce9yZA3Kg+yP+dJzbTC8DyT0C7ZcSkd7lrwBMQGBGM5G6sPvmBbM9uR/KzYMco7Q==
X-Received: by 2002:a05:620a:3195:b0:69f:ac68:4cae with SMTP id bi21-20020a05620a319500b0069fac684caemr1107547qkb.292.1651154750168;
        Thu, 28 Apr 2022 07:05:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:d588])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a0e8400b0067b1bcd081csm13278qkm.66.2022.04.28.07.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:05:49 -0700 (PDT)
Date:   Thu, 28 Apr 2022 10:05:13 -0400
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
Message-ID: <YmqfGaIhE8W+Z1mo@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org>
 <Ymm/wayEB3MH6ZRY@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymm/wayEB3MH6ZRY@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Apr 27, 2022 at 03:12:17PM -0700, Minchan Kim wrote:
> On Wed, Apr 27, 2022 at 05:36:26PM -0400, Johannes Weiner wrote:
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
> > It does raise the question what to do about cgroup, though. Should the
> > control files (memory.zswap.current & memory.zswap.max) apply to zram
> > in the future? If so, we should rename them, too.
> > 
> > I'm not too familiar with zram, maybe you can provide some
> > background. AFAIU, Google uses zram quite widely; all the more
> > confusing why there is no container support for it yet.
> 
> My usecase with zram is Android which doesn't use memcg.

Ok.

After more thought, my take is that in the future it could make sense
to track zram pages in a cgroup's memory.current. But it should NOT be
included in the dedicated memory.zswap.* files. Zswap is an in-kernel
writeback cache, and those files allow userspace to tune writeback
thresholds depending on the composition of the workload's
workingset. This doesn't translate to zram: the wb facility that it
has is triggered by hand, based on criteria such as idle pages and
compression rate. It's not based on size. From a cgroup POV, it's a
memory consumer that should be subject to memory.max, nothing more.

This distinction applies to meminfo as well, though. While I think it
makes sense to have a combined "Compressed" counter for zram and
zswap, it's still important to understand zswap behavior on its own to
tune the system-wide writeback threshold in max_pool_percent. (And
again, while zram can also be limited, it's not a writeback threshold,
it's just a red line for returning -ENOMEM).

So I'm going to keep the Zswap and Zswapped items and retract the
delta patch for renaming it to Compressed.

But I'd ack a patch that adds a combined "Compressed" counter for zram
+ zswap if you send it, Minchan.
