Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBD3D2A073
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 23:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404279AbfEXVfa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 17:35:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34813 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbfEXVfa (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 17:35:30 -0400
Received: by mail-io1-f68.google.com with SMTP id g84so8892369ioa.1
        for <cgroups@vger.kernel.org>; Fri, 24 May 2019 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=indeed.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=noDnUncx7v00BxHdUohQoEvRvQhcGRS8pbc3im08Y6w=;
        b=XkGCSwkf+gvLn+XdjFi6oK3HPEzI0RUs4ZqtQ0lOHGrQKFa0hwHkkjkQDO+7jwA6gC
         WYWPee8sG9gbw27iFQteMwZ78ZN7XW9kKpMa23LGy1HbSfZblj4tEItFv0nC1wtzn8XL
         0pfiZab5hvshimfRZ1ThgNinG45tn30mJAPM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=noDnUncx7v00BxHdUohQoEvRvQhcGRS8pbc3im08Y6w=;
        b=ofy0B6bNq8xxT8ztZPWmEBdIoU/3SCPJnM6Lc0uUYLrR+S0scQULOl9X2AwBUlueon
         wUUutirGr92b2RxmJgOfcUdQerGLDbiBNxp5uNhlcR53FSE4A9o/cd+VnZR89xV0RHCV
         deLWd/NT0gLDNkp39WRO86XJ5P/2qN9+IH7lsuDbkBGQ5RD/ZIec/Hmt88abb66V4WeD
         XMMsBB0MUbHmymOu9RAWQ/jVAWvjP/Gq3NdyxwsK1p8jA6j+dNKgdxTV3g8DT06q0nNd
         cBahLEmaLOGr+xJu5Ukwm3D/vdkb6+3CFbpsgmnFizpDEjs196+nNa7SRX9NCtVcbpiM
         nexA==
X-Gm-Message-State: APjAAAXbRv1HNGM8tvVRaHSyIVyIOwiPg0H83rxGn0hzc5/yyc0A1iUP
        OLWmtTUDNrohuT/IipgqL3OszLXuJ3772uf9qQ+x+Q==
X-Google-Smtp-Source: APXvYqwXlEws9qaOfIVvBaoZGOZu72Hu818IkDE74Ow2/24+Q2FfYTdCzpHB2Gq57suTYF9vMHF8CBjqBuFn6VHf7ws=
X-Received: by 2002:a05:6602:4f:: with SMTP id z15mr20771387ioz.108.1558733728840;
 Fri, 24 May 2019 14:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-2-git-send-email-chiluk+linux@indeed.com>
 <CAFTs51W0KdK4nw6wydn2HjNYvFRC8DYMmVeKX9FAe+4YUGEAZg@mail.gmail.com>
 <20190524143204.GB4684@lorien.usersys.redhat.com> <CAC=E7cXxsyMLw1PR+8QchTH8FYL7WX6_8LBVdqueR1yjW+VVkQ@mail.gmail.com>
 <CAFTs51Vm258CkDXi_Jj_cGOMotTvhdYR_VW8aUwAUvgistZOFQ@mail.gmail.com>
In-Reply-To: <CAFTs51Vm258CkDXi_Jj_cGOMotTvhdYR_VW8aUwAUvgistZOFQ@mail.gmail.com>
From:   Dave Chiluk <chiluk+linux@indeed.com>
Date:   Fri, 24 May 2019 16:35:02 -0500
Message-ID: <CAC=E7cXVrGRKMNkJPhd4fJi7wgdYk=YcXPV7B8GVNL5M69BarQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched/fair: Fix low cpu usage with high throttling
 by removing expiration of cpu-local slices
To:     Peter Oskolkov <posk@posk.io>
Cc:     Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ben Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 24, 2019 at 11:28 AM Peter Oskolkov <posk@posk.io> wrote:
>
> On Fri, May 24, 2019 at 8:15 AM Dave Chiluk <chiluk+linux@indeed.com> wrote:
> >
> > On Fri, May 24, 2019 at 9:32 AM Phil Auld <pauld@redhat.com> wrote:
> > > On Thu, May 23, 2019 at 02:01:58PM -0700 Peter Oskolkov wrote:
> >
> > > > If the machine runs at/close to capacity, won't the overallocation
> > > > of the quota to bursty tasks necessarily negatively impact every other
> > > > task? Should the "unused" quota be available only on idle CPUs?
> > > > (Or maybe this is the behavior achieved here, and only the comment and
> > > > the commit message should be fixed...)
> > > >
> > >
> > > It's bounded by the amount left unused from the previous period. So
> > > theoretically a process could use almost twice its quota. But then it
> > > would have nothing left over in the next period. To repeat it would have
> > > to not use any that next period. Over a longer number of periods it's the
> > > same amount of CPU usage.
> > >
> > > I think that is more fair than throttling a process that has never used
> > > its full quota.
> > >
> > > And it removes complexity.
> > >
> > > Cheers,
> > > Phil
> >
> > Actually it's not even that bad.  The overallocation of quota to a
> > bursty task in a period is limited to at most one slice per cpu, and
> > that slice must not have been used in the previous periods.  The slice
> > size is set with /proc/sys/kernel/sched_cfs_bandwidth_slice_us and
> > defaults to 5ms.  If a bursty task goes from underutilizing quota to
> > using it's entire quota, it will not be able to burst in the
> > subsequent periods.  Therefore in an absolute worst case contrived
> > scenario, a bursty task can add at most 5ms to the latency of other
> > threads on the same CPU.  I think this worst case 5ms tradeoff is
> > entirely worth it.
> >
> > This does mean that a theoretically a poorly written massively
> > threaded application on an 80 core box, that spreads itself onto 80
> > cpu run queues, can overutilize it's quota in a period by at most 5ms
> > * 80 CPUs in a sincle period (slice * number of runqueues the
> > application is running on).  But that means that each of those threads
> >  would have had to not be use their quota in a previous period, and it
> > also means that the application would have to be carefully written to
> > exacerbate this behavior.
> >
> > Additionally if cpu bound threads underutilize a slice of their quota
> > in a period due to the cfs choosing a bursty task to run, they should
> > theoretically be able to make it up in the following periods when the
> > bursty task is unable to "burst".
>
> OK, so it is indeed possible that CPU bound threads will underutilize a slice
> of their quota in a period as a result of this patch. This should probably
> be clearly stated in the code comments and in the commit message.
>
> In addition, I believe that although many workloads will indeed be
> indifferent to getting their fair share "later", some latency-sensitive
> workloads will definitely be negatively affected by this temporary
> CPU quota stealing by bursty antagonists. So there should probably be
> a way to limit this behavior; for example, by making it tunable
> per cgroup.
>
This patch restores the behavior that existed from at least
v3.16..v4.18, and the current Redhat 7 kernels.  So you are kind of
championing a moot point as no one has noticed this "bursting"
behavior in over 5 years.  By removing this slice expiration
altogether we restore the behavior and also solve the root issue of
'commit 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift
condition")'.

Since 512ac999d275, many people are now noticing the slice expiration
and very displeased with the behavior change.
see: https://github.com/kubernetes/kubernetes/issues/67577

I would love to hear if you know of a single complaint during that 5
year time window, where someone noticed this bursting and reported
that it negatively affected their application.

As for the documentation, I thought about documenting the possible
adverse side-effect, but I didn't feel it was worthwhile since no one
had noticed that corner case in the 5 years.  I also could not figure
out a concise way of describing the slight corner case issue without
overly complicating the documentation.  I felt that adding that corner
case would have detracted rather than added to the documentation's
usefulness.  As far as commenting in code, considering most of this
commit removes lines, there's not a really great place for it.  That's
why I did my best to describe the behavior in the documentation.
Smart people can draw conclusions from there as you have done.  Please
keep in mind that this "bursting" is again limited to a single slice
on each per-cpu run-queue.

Thank you,
Dave
