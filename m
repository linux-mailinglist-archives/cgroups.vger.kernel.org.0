Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4218C03D
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2019 20:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfHMSOf (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 13 Aug 2019 14:14:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43759 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfHMSOf (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 13 Aug 2019 14:14:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id k3so644419pgb.10
        for <cgroups@vger.kernel.org>; Tue, 13 Aug 2019 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EgcOWrbU42e6Bz/dNCaGzvQRlmmBX/ILwM0rAxK2QB8=;
        b=Xpgr53VvIkeiIKN7I509QxwJNBY38P1bS8Gb57ABqKGEjIDZT7FL7kvsq8TSUDicYz
         AV6mOPsUxwsdTmvxxhluwI1qmfupgIQR8/IJ38jYSTypC7rVcRM8NGi8WUEZipLoKVMZ
         Jz+1huobQe+KyeLD0c32pDcLoBiGynF7flJHDuhqOZmZo5qI/3OrbNwAjYVpzdxDsHSL
         twFboR4cqTfiADNZva+/cfsaEWD8i+bJqlvjgvQIb87GVugh+f0uW+pjcchomLVu2CtH
         16hyjA1yiWexmWe3OiNgDC1fxkbGApsvS3TU9O4P3UTG+oYTuGJ3zNimp3etPg43xIKQ
         TdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EgcOWrbU42e6Bz/dNCaGzvQRlmmBX/ILwM0rAxK2QB8=;
        b=mT42z9pTLFJfr+QTjAA7SRtPQgvHKvP4edlX50krUK+XQ6Zd87V44I6QxwB1Kff7iT
         XwoebzSJEgJRuIVFGof2WSUSn6A5rfYwU0vJLur5juJmFC8rhniPRSrJ050N/ILz+s0c
         BBS/sPP3ejJBKr90AWeUVbf/M0eFd6OVKbh5OXvZSwU2P+2n0c5pKYxIiDhxByV1NWRq
         sVL8P688stIyNhYsW5LcAV2da8dwUKmIcy88pj/YT7wQ8j73DY3HPqjuvMJJBhPg0RGt
         q1xFs0AvC3XocprXntt4norfqBIQ9tf1Zu1V/+o/B7k918aOOutcMF4z0Mtdl0R5oiEL
         Nn6Q==
X-Gm-Message-State: APjAAAXqcivIbT1A3uv+xSZ6JYDSiZ3n7uFUiRr6WQ2tJNJuaCAnA8YA
        yqJPwZifZEBh3t31dwTzqnNgUg==
X-Google-Smtp-Source: APXvYqxm4rEwQVbBW1raq/7+W9mNweWzI0asgIirQw+hy7Tc8jMSIH3VXXZpkTVVJNolRGgIV23cFg==
X-Received: by 2002:a65:5c02:: with SMTP id u2mr35599324pgr.367.1565720073850;
        Tue, 13 Aug 2019 11:14:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:674])
        by smtp.gmail.com with ESMTPSA id e9sm1925110pge.39.2019.08.13.11.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2019 11:14:33 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:14:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: do not share cgroup iteration between
 reclaimers
Message-ID: <20190813181431.GA23056@cmpxchg.org>
References: <20190812192316.13615-1-hannes@cmpxchg.org>
 <20190813132938.GJ17933@dhcp22.suse.cz>
 <CAHbLzkrRvoVLH16Cxq-f6hn-CLJjh=tJnYnF8P0xNiZ9=eEg8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkrRvoVLH16Cxq-f6hn-CLJjh=tJnYnF8P0xNiZ9=eEg8A@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 13, 2019 at 08:59:38AM -0700, Yang Shi wrote:
> On Tue, Aug 13, 2019 at 6:29 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 12-08-19 15:23:16, Johannes Weiner wrote:
> > > One of our services observed a high rate of cgroup OOM kills in the
> > > presence of large amounts of clean cache. Debugging showed that the
> > > culprit is the shared cgroup iteration in page reclaim.
> > >
> > > Under high allocation concurrency, multiple threads enter reclaim at
> > > the same time. Fearing overreclaim when we first switched from the
> > > single global LRU to cgrouped LRU lists, we introduced a shared
> > > iteration state for reclaim invocations - whether 1 or 20 reclaimers
> > > are active concurrently, we only walk the cgroup tree once: the 1st
> > > reclaimer reclaims the first cgroup, the second the second one etc.
> > > With more reclaimers than cgroups, we start another walk from the top.
> > >
> > > This sounded reasonable at the time, but the problem is that reclaim
> > > concurrency doesn't scale with allocation concurrency. As reclaim
> > > concurrency increases, the amount of memory individual reclaimers get
> > > to scan gets smaller and smaller. Individual reclaimers may only see
> > > one cgroup per cycle, and that may not have much reclaimable
> > > memory. We see individual reclaimers declare OOM when there is plenty
> > > of reclaimable memory available in cgroups they didn't visit.
> > >
> > > This patch does away with the shared iterator, and every reclaimer is
> > > allowed to scan the full cgroup tree and see all of reclaimable
> > > memory, just like it would on a non-cgrouped system. This way, when
> > > OOM is declared, we know that the reclaimer actually had a chance.
> > >
> > > To still maintain fairness in reclaim pressure, disallow cgroup
> > > reclaim from bailing out of the tree walk early. Kswapd and regular
> > > direct reclaim already don't bail, so it's not clear why limit reclaim
> > > would have to, especially since it only walks subtrees to begin with.
> >
> > The code does bail out on any direct reclaim - be it limit or page
> > allocator triggered. Check the !current_is_kswapd part of the condition.
> 
> Yes, please see commit 2bb0f34fe3c1 ("mm: vmscan: do not iterate all
> mem cgroups for global direct reclaim")

This patch is a workaround for the cgroup tree blowing up with zombie
cgroups. Roman's slab reparenting patches are fixing the zombies, so
we shouldn't need this anymore.

Because with or without the direct reclaim rule, we still don't want
offline cgroups to accumulate like this. They also slow down kswapd,
and they eat a ton of RAM.

> > > This change completely eliminates the OOM kills on our service, while
> > > showing no signs of overreclaim - no increased scan rates, %sys time,
> > > or abrupt free memory spikes. I tested across 100 machines that have
> > > 64G of RAM and host about 300 cgroups each.
> >
> > What is the usual direct reclaim involvement on those machines?
> >
> > > [ It's possible overreclaim never was a *practical* issue to begin
> > >   with - it was simply a concern we had on the mailing lists at the
> > >   time, with no real data to back it up. But we have also added more
> > >   bail-out conditions deeper inside reclaim (e.g. the proportional
> > >   exit in shrink_node_memcg) since. Regardless, now we have data that
> > >   suggests full walks are more reliable and scale just fine. ]
> >
> > I do not see how shrink_node_memcg bail out helps here. We do scan up-to
> > SWAP_CLUSTER_MAX pages for each LRU at least once. So we are getting to
> > nr_memcgs_with_pages multiplier with the patch applied in the worst case.
> >
> > How much that matters is another question and it depends on the
> > number of cgroups and the rate the direct reclaim happens. I do not
> > remember exact numbers but even walking a very large memcg tree was
> > noticeable.
> 
> I'm concerned by this too. It might be ok to cgroup v2, but v1 still
> dominates. And, considering offline memcgs it might be not unusual to
> have quite large memcg tree.

cgroup2 was affected by the offline memcgs just as much as cgroup1 -
probably even more so because it tracks more types of memory per
default. That's why Roman worked tirelessly on a solution.

But we shouldn't keep those bandaid patches around forever.
