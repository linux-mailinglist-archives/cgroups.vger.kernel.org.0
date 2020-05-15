Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89CAE1D4F72
	for <lists+cgroups@lfdr.de>; Fri, 15 May 2020 15:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEONo6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 May 2020 09:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgEONo5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 15 May 2020 09:44:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51DC05BD09
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 06:44:57 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so2274740ljg.12
        for <cgroups@vger.kernel.org>; Fri, 15 May 2020 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQZCcj+2JGTArdtmPobmCtQJjTTWbjUcr2DcXN7Bysk=;
        b=bwcQeZtvBT3ap8qSUelaXtkjqURtDK5YcwFZzgcqAgSRVcOkFMG5yGPE3TtE6wzG7m
         4md+3sb7p7V3v/G+O9IQ2N+yCfuKfOjZb++cX7f0PHWHkNV0WdfJ7LtnFac8/YevP94m
         GApLJt9dk/ILL20YUAo40ph7QY7oMe/UkMPnQpf+9hk6LFOtAGuG8y9MUm81qsHXFCfM
         orlyEE330bK4FFvOAOcEbBw8dVrabURiFe/LxJoSShaobqKdSkCIlIkHf9zjU6VEFXZN
         yDYbTRYjc5ujLi8DMoIxvGrXee2VIZgv/VYCEq/Qj3jkBVg1+opR1mPkZFG04US7RoQD
         zr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQZCcj+2JGTArdtmPobmCtQJjTTWbjUcr2DcXN7Bysk=;
        b=PT5XtO68MSUrWqhjDoHKLpJb5fbmESog95DMUqKJbs3GwA2BGlNF3du8EThBHeLzk/
         X1VQdxtO94khHvjDdso+6xjayj5qP9Tk/e1FtmPM4i7WhCPiXSN9DREqFHz8A5KaS/dF
         f7Puod/3e2bq4L6KchQkKMIO7rFDn8kOXAbU6yNVCBZFrpj1MnKEHX+PhSXI9kve6K/s
         U6jO1svhzJxDLuXpDsh8FZhjfU5lSIlI7S9mqaA+VtZYClXtaz6pKnXauUfzV8DRGbPc
         pM5ap8Mb+DDX7NNc7VmrP1lT4o/K5Nm+pJAyee/ND/8FV/2Xx5xWQyl6D41WbCrtsUcX
         CE8g==
X-Gm-Message-State: AOAM531xrfy55eaf0InlFbN2WLZNXZ+Ueums28ozGFbLN2b3RwwoG6Fb
        ka3iXHTinZrsU07MhI1niBsuTgaV8HT6oZphfDdT/Q==
X-Google-Smtp-Source: ABdhPJy4axkqYK5Ps1y4CemlDYwXND6nG68gA6azFpJh3sKJsMxHGHKkm+IZyiZgCuvlFQtsIKx5GlaOidGcZErf2eQ=
X-Received: by 2002:a2e:b0c8:: with SMTP id g8mr73575ljl.270.1589550295489;
 Fri, 15 May 2020 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200508170630.94406-1-shakeelb@google.com> <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
 <20200515082955.GJ29153@dhcp22.suse.cz> <20200515132421.GC591266@cmpxchg.org>
In-Reply-To: <20200515132421.GC591266@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 15 May 2020 06:44:44 -0700
Message-ID: <CALvZod7SdgXv0Dmm3q5H=EH4dzg8pXZenMUaDObfoRv5EX-Pkw@mail.gmail.com>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>,
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

On Fri, May 15, 2020 at 6:24 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 15, 2020 at 10:29:55AM +0200, Michal Hocko wrote:
> > On Sat 09-05-20 07:06:38, Shakeel Butt wrote:
> > > On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > > > > One way to measure the efficiency of memory reclaim is to look at the
> > > > > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > > > > not updated consistently at the system level and the ratio of these are
> > > > > not very meaningful. The pgsteal and pgscan are updated for only global
> > > > > reclaim while pgrefill gets updated for global as well as cgroup
> > > > > reclaim.
> > > > >
> > > > > Please note that this difference is only for system level vmstats. The
> > > > > cgroup stats returned by memory.stat are actually consistent. The
> > > > > cgroup's pgsteal contains number of reclaimed pages for global as well
> > > > > as cgroup reclaim. So, one way to get the system level stats is to get
> > > > > these stats from root's memory.stat, so, expose memory.stat for the root
> > > > > cgroup.
> > > > >
> > > > >       from Johannes Weiner:
> > > > >       There are subtle differences between /proc/vmstat and
> > > > >       memory.stat, and cgroup-aware code that wants to watch the full
> > > > >       hierarchy currently has to know about these intricacies and
> > > > >       translate semantics back and forth.
> >
> > Can we have those subtle differences documented please?
> >
> > > > >
> > > > >       Generally having the fully recursive memory.stat at the root
> > > > >       level could help a broader range of usecases.
> > > >
> > > > The changelog begs the question why we don't just "fix" the
> > > > system-level stats. It may be useful to include the conclusions from
> > > > that discussion, and why there is value in keeping the stats this way.
> > > >
> > >
> > > Right. Andrew, can you please add the following para to the changelog?
> > >
> > > Why not fix the stats by including both the global and cgroup reclaim
> > > activity instead of exposing root cgroup's memory.stat? The reason is
> > > the benefit of having metrics exposing the activity that happens
> > > purely due to machine capacity rather than localized activity that
> > > happens due to the limits throughout the cgroup tree. Additionally
> > > there are userspace tools like sysstat(sar) which reads these stats to
> > > inform about the system level reclaim activity. So, we should not
> > > break such use-cases.
> > >
> > > > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > > >
> > > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > >
> > > Thanks a lot.
> >
> > I was quite surprised that the patch is so simple TBH. For some reason
> > I've still had memories that we do not account for root memcg (likely
> > because mem_cgroup_is_root(memcg) bail out in the try_charge. But stats
> > are slightly different here.
>
> Yep, we skip the page_counter for root, but keep in mind that cgroup1
> *does* have a root-level memory.stat, so (for the most part) we've
> been keeping consumer stats for the root level the whole time.
>
> > counters because they are not really all the same. E.g.
> > - mem_cgroup_charge_statistics accounts for each memcg
>
> Yep, that's heritage from cgroup1.
>
> > - memcg_charge_kernel_stack relies on pages being associated with a
> >   memcg and that in turn relies on __memcg_kmem_charge_page which bails
> >   out on root memcg
>
> You're right. It should only bypass the page_counter, but still set
> page->mem_cgroup = root_mem_cgroup, just like user pages.
>
> This counter also doesn't get exported on cgroup1, so it would indeed
> be a new bug. It needs to be fixed before this patch here.
>
> > - memcg_charge_slab (NR_SLAB*) skips over root memcg as well
>
> Same thing with these two.

Yes, we skip page_counter for root but not the stats. I will go over
all the stats and make sure we are not skipping the stats for root.
