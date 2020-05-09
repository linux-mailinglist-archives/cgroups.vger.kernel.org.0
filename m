Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119EC1CC238
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 16:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgEIOob (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 9 May 2020 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726782AbgEIOob (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 9 May 2020 10:44:31 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3489C061A0C;
        Sat,  9 May 2020 07:44:29 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c18so4203470ile.5;
        Sat, 09 May 2020 07:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hI9ycgQ4zeirYCayZqlQtbGCMAV/8BVRrWbFIPSt1Y=;
        b=hQVS4ZPoIo4VxX/5nd1aSmJN4WU/ZZmJHcLAK0FoUrWJBAcRAM/ZH0kP2mDH9c2Mcb
         SWM22Nu6jFYtWbCx6oRXIx6unbYZBjWZofzLjkBui4reST6xR05xkE87GIrR5C1m3dzn
         /92kWXQcQ9kk25WbZeFThY2H4xFK1gR/Z3VpDt8RMZSIKOLT9SWOYaFBQ2j34qWqxxIC
         pzM5kaLcIFLGXym3nG8SWO6bc5ZFMNw7EKTB96AW9LEYwK740cX1fJUNN7qoMIvsgLY4
         5QMAeF0dqAoP2FmIxH0TTchL4SnXXtgR5qK5+41JQbkbw6btTdrYU7O4T8pNf1QtWZRR
         xqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hI9ycgQ4zeirYCayZqlQtbGCMAV/8BVRrWbFIPSt1Y=;
        b=l3WqGezqsxNBlaOipwBMrRoEui4e+kSJ+AcruQyIeFhLbc/2Wxe2v1FrY/i10gsZyI
         nPEr79sb8zUnSf6nuKvYXRB2B0XiB+spyuhnJfIh7BO1k7/oWgjo60KbJBt2e3xgN6ii
         eSi55rmOz4qJ0q1/IOTEqPI9tHOrdgdZHHpSbolUtMCvtSVa0DciZ0tSAykQRqbXFu+P
         w3mbVHA+xmqXUzRvFpj9hd+WSrjUfve0KBRCPcusgeF6uaDRYieJ6ICiPvZx1DgM/QJy
         46ICpQftHcRYOYpJSWfMC0Zogq4FsvDGerfzVcB6PhoyGoHPNoyzmzs7crXQlb1V7HO/
         l21g==
X-Gm-Message-State: AGi0Pub/Z7Blr/skS4ZFWw6V5RDWKuttBTpj44FU2FNyKGb9Iakn8JRr
        QVvDKydimHH1pLKh1qzjl/Wt7t9Hfo6XPl02dU/UWUpx
X-Google-Smtp-Source: APiQypJeZbqR8cOxrIaCuTPsIeig2FGnuaB6IFS+w/IMBZaiGq2pK3JXRXRsR8/B4ve1cSseku7gziAyJDlCxouLxY4=
X-Received: by 2002:a92:5c57:: with SMTP id q84mr8328572ilb.203.1589035469351;
 Sat, 09 May 2020 07:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200508170630.94406-1-shakeelb@google.com> <20200508214405.GA226164@cmpxchg.org>
 <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
In-Reply-To: <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Sat, 9 May 2020 22:43:53 +0800
Message-ID: <CALOAHbBK9XasDO9Wd1Jw9QzjSN--aEd2zuVkQSyVyitVmU8DAg@mail.gmail.com>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Mel Gorman <mgorman@suse.de>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 9, 2020 at 10:06 PM Shakeel Butt <shakeelb@google.com> wrote:
>
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

Acked-by: Yafang Shao <laoar.shao@gmail.com>

> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> >
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Thanks a lot.



-- 
Thanks
Yafang
