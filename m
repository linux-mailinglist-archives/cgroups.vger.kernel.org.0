Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C591CC200
	for <lists+cgroups@lfdr.de>; Sat,  9 May 2020 16:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgEIOGw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 9 May 2020 10:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgEIOGw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 9 May 2020 10:06:52 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E655BC05BD09
        for <cgroups@vger.kernel.org>; Sat,  9 May 2020 07:06:51 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id s9so3705606lfp.1
        for <cgroups@vger.kernel.org>; Sat, 09 May 2020 07:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3sW6gGxSFYLbQMqiE2OgOKIm35ARKyWWruHIK3w6PQ=;
        b=CPCRxhMfKQFuwDgy/ZmcW/xhfqV9MdzE0YYS6RcYSPljXI+g3UHNduR7qxy2YGhc02
         GoaSSHkPldIsQRT8xbeolWkO3usdS1kv3Dhxp0Ca4hBTTQrWvNsZJuNkYkZLVpuXFoB8
         oI8WDKM34ouq9Js46hM3qWS8zrhxK2DBmWc9mPr/tqH1XX5lNSnvx6Yvw+vTiuNiFV2U
         Z+p5NLf4IIdQ4G5rPcYJbwweK01tArCoId4O6qFw7jvLqx2MJ87hZaMXC9WrTuzzQAXY
         OdOS/3YRXvUFDzEYQlGiyGA/TdrvopOsFm+IJyLwCx+BAU+35ZByFSjxEAknOiwmj5Yv
         E+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3sW6gGxSFYLbQMqiE2OgOKIm35ARKyWWruHIK3w6PQ=;
        b=IibVScdZZH4lOqWKHluUYZyynrraWZSY08oGbPkvrPwoMmJWfnvhAEeNKxhmP6obZj
         FIa6j7pZHulqjCVsaOTUh1DeuqNd8R/i0lHIWMPStNorVZ26SRuFqAI3/0J7g8HD0ElY
         xG8dj28UX3GwpR7x1FBAK8ecX8HOJB4S+nrWx0MsW8Xo11NDtOyBpCx6K8heYZvC5J3q
         AePwmAjR2mG5B8MyGJGoVTNO0H8ClqbEaLPa9zwumRNgDRojTphtEAxCZiV9zLulEx6+
         kRimk9I59n0wYOoWLaDa1hHK6YbI/xORFC3OvOfGyMTd5t9zKVWdHa4lrPwKqPS85z9I
         vJNg==
X-Gm-Message-State: AOAM530GBDDlWO+QrrewDnYKXbWmuiQ8bW2CkkFRyoh5tk/fVjM1eXxb
        rkFotGWUPQ2lesQzi4Apjpxj3Rbp3EUfKUAArvH0hQ==
X-Google-Smtp-Source: ABdhPJyWWhFBVG4eHjWySAi6pwQCblm+7itP1oOjJ6xL2tX+stPpmpIqFW5098YtOuNnNxwD27REHPC+dSfHiPA65c0=
X-Received: by 2002:a19:ee19:: with SMTP id g25mr5288736lfb.124.1589033209912;
 Sat, 09 May 2020 07:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200508170630.94406-1-shakeelb@google.com> <20200508214405.GA226164@cmpxchg.org>
In-Reply-To: <20200508214405.GA226164@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sat, 9 May 2020 07:06:38 -0700
Message-ID: <CALvZod5VHHUV+_AXs4+5sLOPGyxm709kQ1q=uHMPVxW8pwXZ=g@mail.gmail.com>
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
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

On Fri, May 8, 2020 at 2:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> > One way to measure the efficiency of memory reclaim is to look at the
> > ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> > not updated consistently at the system level and the ratio of these are
> > not very meaningful. The pgsteal and pgscan are updated for only global
> > reclaim while pgrefill gets updated for global as well as cgroup
> > reclaim.
> >
> > Please note that this difference is only for system level vmstats. The
> > cgroup stats returned by memory.stat are actually consistent. The
> > cgroup's pgsteal contains number of reclaimed pages for global as well
> > as cgroup reclaim. So, one way to get the system level stats is to get
> > these stats from root's memory.stat, so, expose memory.stat for the root
> > cgroup.
> >
> >       from Johannes Weiner:
> >       There are subtle differences between /proc/vmstat and
> >       memory.stat, and cgroup-aware code that wants to watch the full
> >       hierarchy currently has to know about these intricacies and
> >       translate semantics back and forth.
> >
> >       Generally having the fully recursive memory.stat at the root
> >       level could help a broader range of usecases.
>
> The changelog begs the question why we don't just "fix" the
> system-level stats. It may be useful to include the conclusions from
> that discussion, and why there is value in keeping the stats this way.
>

Right. Andrew, can you please add the following para to the changelog?

Why not fix the stats by including both the global and cgroup reclaim
activity instead of exposing root cgroup's memory.stat? The reason is
the benefit of having metrics exposing the activity that happens
purely due to machine capacity rather than localized activity that
happens due to the limits throughout the cgroup tree. Additionally
there are userspace tools like sysstat(sar) which reads these stats to
inform about the system level reclaim activity. So, we should not
break such use-cases.

> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks a lot.
