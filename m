Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EADA1D481E
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgEOI37 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 04:29:59 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35826 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgEOI37 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 04:29:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id n5so1683111wmd.0;
        Fri, 15 May 2020 01:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AffiWICTihWrD0jhH/25k+Jany7wx9bJeNI7R897D5A=;
        b=pPrK8V4Bvs2P/6Up5OEof3JuOkE+GAsxF303ofEiR56PcMIqluYiUk+ylVyfn3vHa/
         Ho7gtRbOSYnw+swh6bqAGnDnxZEDy4bPMYZLSdq7iuwSQPh4ozB1Hs92xQscGyLH11vM
         Qgg14FBBjXITUcE4Dz5XDDRD9axxRcGbOtHNSMxjJgtYMKV219Iyz2oum5/2WxGWLPhc
         c2qSYkchZS4hDLDemLWJyDY2nodgpPUNpt+WplT6mrZ+pkuVp42pa1CKIroj+wY54XSe
         UZv4spn/Iq10FbJeCuPEWlC3NU/o6LtPL2cGNo+ZqXwmHt/472QBqwkBVicFCJ5Gp39q
         y2/w==
X-Gm-Message-State: AOAM531oho4D6yDWvvztZ6ZrbrRXypDRskR9wB0QercZnnfOQFXhzfVZ
        9z6XRrfzlCrYnrsxh2cG+Yg=
X-Google-Smtp-Source: ABdhPJwIeOGeKtkO402/Kz2PFC3Ze6Zk4Xt5gmJSEXDWr6dlaKMniPW1X/R4tk3nopbtZrNkt/8Dyg==
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr2882752wmo.59.1589531396993;
        Fri, 15 May 2020 01:29:56 -0700 (PDT)
Received: from localhost (ip-37-188-249-36.eurotel.cz. [37.188.249.36])
        by smtp.gmail.com with ESMTPSA id h137sm54689649wme.0.2020.05.15.01.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:29:56 -0700 (PDT)
Date:   Fri, 15 May 2020 10:29:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
Message-ID: <20200515082955.GJ29153@dhcp22.suse.cz>
References: <20200508170630.94406-1-shakeelb@google.com>
 <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat 09-05-20 07:06:38, Shakeel Butt wrote:
> On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > > One way to measure the efficiency of memory reclaim is to look at the
> > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > not updated consistently at the system level and the ratio of these are
> > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > reclaim while pgrefill gets updated for global as well as cgroup
> > > reclaim.
> > >
> > > Please note that this difference is only for system level vmstats. The
> > > cgroup stats returned by memory.stat are actually consistent. The
> > > cgroup's pgsteal contains number of reclaimed pages for global as well
> > > as cgroup reclaim. So, one way to get the system level stats is to get
> > > these stats from root's memory.stat, so, expose memory.stat for the root
> > > cgroup.
> > >
> > >       from Johannes Weiner:
> > >       There are subtle differences between /proc/vmstat and
> > >       memory.stat, and cgroup-aware code that wants to watch the full
> > >       hierarchy currently has to know about these intricacies and
> > >       translate semantics back and forth.

Can we have those subtle differences documented please?

> > >
> > >       Generally having the fully recursive memory.stat at the root
> > >       level could help a broader range of usecases.
> >
> > The changelog begs the question why we don't just "fix" the
> > system-level stats. It may be useful to include the conclusions from
> > that discussion, and why there is value in keeping the stats this way.
> >
> 
> Right. Andrew, can you please add the following para to the changelog?
> 
> Why not fix the stats by including both the global and cgroup reclaim
> activity instead of exposing root cgroup's memory.stat? The reason is
> the benefit of having metrics exposing the activity that happens
> purely due to machine capacity rather than localized activity that
> happens due to the limits throughout the cgroup tree. Additionally
> there are userspace tools like sysstat(sar) which reads these stats to
> inform about the system level reclaim activity. So, we should not
> break such use-cases.
> 
> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> 
> Thanks a lot.

I was quite surprised that the patch is so simple TBH. For some reason
I've still had memories that we do not account for root memcg (likely
because mem_cgroup_is_root(memcg) bail out in the try_charge. But stats
are slightly different here. I have started looking at different stat
counters because they are not really all the same. E.g. 
- mem_cgroup_charge_statistics accounts for each memcg
- memcg_charge_kernel_stack relies on pages being associated with a
  memcg and that in turn relies on __memcg_kmem_charge_page which bails
  out on root memcg
- memcg_charge_slab (NR_SLAB*) skips over root memcg as well
- __mod_lruvec_page_state relies on page->mem_cgroup as well but this
  one is ok for paths which go through commit_charge path.

That being said we should really double check which stats are
accounted properly. At least MEMCG_KERNEL_STACK_KB won't unless I am
misreading the code.

I do not mind displaying the root's memcg stats but a) a closer look had
to be done for each counter and b) a clarification of differences from
the global vmstat counters would be really handy.

-- 
Michal Hocko
SUSE Labs
