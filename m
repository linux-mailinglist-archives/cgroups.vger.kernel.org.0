Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F6C513A9C
	for <lists+cgroups@lfdr.de>; Thu, 28 Apr 2022 19:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348697AbiD1RGF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 28 Apr 2022 13:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiD1RGE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 28 Apr 2022 13:06:04 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB8119011;
        Thu, 28 Apr 2022 10:02:49 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id v10so4455999pgl.11;
        Thu, 28 Apr 2022 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1sufCTYCLbGKk0BAZFmsNvzFa0UhjdUJOvJQoQRI648=;
        b=cBQg+ifk+oeqvEyzYXxBdQYlVT+tzlR+9BrZGKEuW1gu6RNFA0OdJ8627DwDqOCV+R
         LEXmub0Ru5JIlBhic3IoSI4y8nuQOP/KMm3LvUpqpunN4KyxQDjHkzK4RrOgh1JIgKl7
         /cCyYzWluaoh0m+ZSve3a1+DQtZkMFgAWT4ULTeHiYGhrRGIQ3vDV1kUkSIyt/0dWcyC
         FznWnfA5GRq83HqEa+fyH9AOB5a6bD02zK6CIPbQBFxYTxj3iQWSRE0rmUDZeV2LRBeT
         juJpoPlOkxgcljlhz+BwZLgRoLIKhH6chNAvGHTiJHljY5fV3BosUyyGoNLO75lL5+Vx
         fXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1sufCTYCLbGKk0BAZFmsNvzFa0UhjdUJOvJQoQRI648=;
        b=Sbd0/VmR4NsQD4N20MgFNy4yo8ZIhilwAxOLinfyr7uaXgJ+hhx+hPFmPFbPtvj8ng
         zzeXXfSCGgSwufK8vnX+vkV9tH1JC1rEdvrUqqJBpRptchybAr/qdJok1BUMPyMGsOhm
         56dakRaNavvGXo9WQD5o5FtY2MudNm28zWRmXcchXIAcYrpuxHma14NiyPxt5D36IRbs
         xq+XhW9zUDkIJneFPnC0mik13CeW2Hs8w/uvdNaeVO917/wZCg8u1i5m0nJrFLfTXuDG
         o0g930rFu+ni1ZeeEjqRh9lyODzckKYvLU2756g6X4ceGI5ybF0nUF4Shq8N2gkUpVlI
         uFEg==
X-Gm-Message-State: AOAM532FqR6db5qPTMTEJUCWTU0YFgjuce2leGwZm2FmYIfoiD7DCyii
        XNfQd1FydJEWoAEFD6GpJjCZkAuJxY0=
X-Google-Smtp-Source: ABdhPJwbDxlnYtnl8vL56MtbmsRjUBKiRSOhIqzNEUzjC44cNYgYGSeTeWJ+M3Qory86KG5Ni1+fsQ==
X-Received: by 2002:a63:f058:0:b0:3c1:42e9:eb40 with SMTP id s24-20020a63f058000000b003c142e9eb40mr8323765pgj.236.1651165369227;
        Thu, 28 Apr 2022 10:02:49 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:dc95:713b:f72c:4ad4])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090abd0300b001cd630f301fsm11132285pjr.36.2022.04.28.10.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 10:02:48 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 28 Apr 2022 10:02:46 -0700
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
Message-ID: <YmrItoe1W9dya+An@google.com>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com>
 <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org>
 <Ymm/wayEB3MH6ZRY@google.com>
 <YmqfGaIhE8W+Z1mo@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmqfGaIhE8W+Z1mo@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Apr 28, 2022 at 10:05:13AM -0400, Johannes Weiner wrote:
> On Wed, Apr 27, 2022 at 03:12:17PM -0700, Minchan Kim wrote:
> > On Wed, Apr 27, 2022 at 05:36:26PM -0400, Johannes Weiner wrote:
> > > On Wed, Apr 27, 2022 at 05:20:31PM -0400, Johannes Weiner wrote:
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
> > > It does raise the question what to do about cgroup, though. Should the
> > > control files (memory.zswap.current & memory.zswap.max) apply to zram
> > > in the future? If so, we should rename them, too.
> > > 
> > > I'm not too familiar with zram, maybe you can provide some
> > > background. AFAIU, Google uses zram quite widely; all the more
> > > confusing why there is no container support for it yet.
> > 
> > My usecase with zram is Android which doesn't use memcg.
> 
> Ok.
> 
> After more thought, my take is that in the future it could make sense
> to track zram pages in a cgroup's memory.current. But it should NOT be
> included in the dedicated memory.zswap.* files. Zswap is an in-kernel
> writeback cache, and those files allow userspace to tune writeback
> thresholds depending on the composition of the workload's
> workingset. This doesn't translate to zram: the wb facility that it
> has is triggered by hand, based on criteria such as idle pages and
> compression rate. It's not based on size. From a cgroup POV, it's a
> memory consumer that should be subject to memory.max, nothing more.
> 
> This distinction applies to meminfo as well, though. While I think it
> makes sense to have a combined "Compressed" counter for zram and
> zswap, it's still important to understand zswap behavior on its own to
> tune the system-wide writeback threshold in max_pool_percent. (And
> again, while zram can also be limited, it's not a writeback threshold,
> it's just a red line for returning -ENOMEM).
> 
> So I'm going to keep the Zswap and Zswapped items and retract the
> delta patch for renaming it to Compressed.
> 
> But I'd ack a patch that adds a combined "Compressed" counter for zram
> + zswap if you send it, Minchan.

If we really want to go separate stat for zswap and zram, it would
be better to use direct name "Zram: " instead of comrpessed.
