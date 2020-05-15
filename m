Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A401D1D5845
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 19:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgEORtg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 13:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726298AbgEORtg (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 13:49:36 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C417AC05BD09
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 10:49:35 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id v5so2508500lfp.13
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 10:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UaYQTSaq9VZj8MAel6SAXsrwR35YF1SYRI2VQ4Ly89w=;
        b=ByCFc5MixtBs6AIiuvjXgLX8ciepEzcgMdBfkabVnYTEguZvFgct4xZxiY5o28FfEo
         /PBXJDk4bkppu1q48kIDeQC++nBqpVLtTif9qjyJETTP9M3e+pnxJkYmtcgOTkLsERga
         AA7gynk9XbG6MPGlazZvj+UUttrdRaeKr36ULZmiDOHwd8AoLTkl1NP4XRtXOPYsJMOz
         yvHiTJCMMd3aKBelaqHfPXPxzszh5IFHoBWdsGR2ucpZOzNa9FbE/xPsZSySmoAuRw0+
         UUyYMytNomyz+jTuObIOKbCJwnuQ0PkBPQhWfvtoco6xTPkkLwCx1S4kJ2FTycMc7gFt
         FaZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UaYQTSaq9VZj8MAel6SAXsrwR35YF1SYRI2VQ4Ly89w=;
        b=dgviuxQ5lSa163Z1FwVzX4XM7D6w+zC5TwtoGUcFKQA9lKvLQG5ZncMLXKsEnbHEbt
         4z9k5+ecUel0Ozlg4OWsynuv3i6Ixu7zoKwHuTNODDE1FefPfgdnnBMWk8YASr+7NvKB
         kbNn6BKDQI/AhazTNHSN0Y5stdXUty+xJs3iXfONYjeIC2DBpY+VRwyk+WCyMHMYIGIf
         naG37mjZlOyBBZ6TCmppg/jwL1UyWWjj+nd2YlWs/R0xdP9WpyAaQPzV9upPMXO8SbBu
         kLzwdd/oWNj4efIVPC76tYb69qPYUIg80N9cY18ZwBVvcD83WiFMb5b9fATdqmlDloqw
         rTiw==
X-Gm-Message-State: AOAM531GKX95PV+RSmqVndsDRGqufDhtbNA0X5AXJejhlB/dTln2PDCx
        xahWbgX1edRlBf3Z+G7oh4qvoE3peamQAsBVgxh6Qw==
X-Google-Smtp-Source: ABdhPJxFY7EwOuokBF16WspLae1APA6Q7qnODWtV/Ot7OuSI12mNYEij3/T9g8jKQkXPrJRRbR3Y270E7KoyMm2RVWA=
X-Received: by 2002:a19:c85:: with SMTP id 127mr3181989lfm.189.1589564973821;
 Fri, 15 May 2020 10:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200508170630.94406-1-shakeelb@google.com> <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz> <20200515132421.GC591266@cmpxchg.org>
 <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com> <20200515150026.GA94522@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200515150026.GA94522@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 May 2020 10:49:22 -0700
Message-ID: <CALvZod5EHzK-UzS9WgkzpZ2T+WwA8LottxrTzUi3qFwvUbOk4w@mail.gmail.com>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 15, 2020 at 8:00 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Fri, May 15, 2020 at 06:44:44AM -0700, Shakeel Butt wrote:
> > On Fri, May 15, 2020 at 6:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > >
> > > On Fri, May 15, 2020 at 10:29:55AM +0200, Michal Hocko wrote:
> > > > On Sat 09-05-20 07:06:38, Shakeel Butt wrote:
> > > > > On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > >
> > > > > > On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > > > > > > One way to measure the efficiency of memory reclaim is to look at the
> > > > > > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > > > > > not updated consistently at the system level and the ratio of these are
> > > > > > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > > > > > reclaim while pgrefill gets updated for global as well as cgroup
> > > > > > > reclaim.
> > > > > > >
> > > > > > > Please note that this difference is only for system level vmstats. The
> > > > > > > cgroup stats returned by memory.stat are actually consistent. The
> > > > > > > cgroup's pgsteal contains number of reclaimed pages for global as well
> > > > > > > as cgroup reclaim. So, one way to get the system level stats is to get
> > > > > > > these stats from root's memory.stat, so, expose memory.stat for the root
> > > > > > > cgroup.
> > > > > > >
> > > > > > >       from Johannes Weiner:
> > > > > > >       There are subtle differences between /proc/vmstat and
> > > > > > >       memory.stat, and cgroup-aware code that wants to watch the full
> > > > > > >       hierarchy currently has to know about these intricacies and
> > > > > > >       translate semantics back and forth.
> > > >
> > > > Can we have those subtle differences documented please?
> > > >
> > > > > > >
> > > > > > >       Generally having the fully recursive memory.stat at the root
> > > > > > >       level could help a broader range of usecases.
> > > > > >
> > > > > > The changelog begs the question why we don't just "fix" the
> > > > > > system-level stats. It may be useful to include the conclusions from
> > > > > > that discussion, and why there is value in keeping the stats this way.
> > > > > >
> > > > >
> > > > > Right. Andrew, can you please add the following para to the changelog?
> > > > >
> > > > > Why not fix the stats by including both the global and cgroup reclaim
> > > > > activity instead of exposing root cgroup's memory.stat? The reason is
> > > > > the benefit of having metrics exposing the activity that happens
> > > > > purely due to machine capacity rather than localized activity that
> > > > > happens due to the limits throughout the cgroup tree. Additionally
> > > > > there are userspace tools like sysstat(sar) which reads these stats to
> > > > > inform about the system level reclaim activity. So, we should not
> > > > > break such use-cases.
> > > > >
> > > > > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > > >
> > > > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > > >
> > > > > Thanks a lot.
> > > >
> > > > I was quite surprised that the patch is so simple TBH. For some reason
> > > > I've still had memories that we do not account for root memcg (likely
> > > > because mem_cgroup_is_root(memcg) bail out in the try_charge. But stats
> > > > are slightly different here.
> > >
> > > Yep, we skip the page_counter for root, but keep in mind that cgroup1
> > > *does* have a root-level memory.stat, so (for the most part) we've
> > > been keeping consumer stats for the root level the whole time.
> > >
> > > > counters because they are not really all the same. E.g.
> > > > - mem_cgroup_charge_statistics accounts for each memcg
> > >
> > > Yep, that's heritage from cgroup1.
> > >
> > > > - memcg_charge_kernel_stack relies on pages being associated with a
> > > >   memcg and that in turn relies on __memcg_kmem_charge_page which bails
> > > >   out on root memcg
> > >
> > > You're right. It should only bypass the page_counter, but still set
> > > page->mem_cgroup = root_mem_cgroup, just like user pages.
>
> What about kernel threads? We consider them belonging to the root memory
> cgroup. Should their memory consumption being considered in root-level stats?
>
> I'm not sure we really want it, but I guess we need to document how
> kernel threads are handled.
>

What will be the cons of updating root-level stats for kthreads?

> > >
> > > This counter also doesn't get exported on cgroup1, so it would indeed
> > > be a new bug. It needs to be fixed before this patch here.
> > >
> > > > - memcg_charge_slab (NR_SLAB*) skips over root memcg as well
> > >
> > > Same thing with these two.
> >
> > Yes, we skip page_counter for root but not the stats. I will go over
> > all the stats and make sure we are not skipping the stats for root.
