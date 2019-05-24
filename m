Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDD7A2A0F6
	for <lists+cgroups@lfdr.de>; Sat, 25 May 2019 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbfEXWHY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 18:07:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42451 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729552AbfEXWHX (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 18:07:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so16224669eda.9
        for <cgroups@vger.kernel.org>; Fri, 24 May 2019 15:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aqOH77AFv2fQ8WuNNOzGfaD62FQFznjbgv+BXyATBoQ=;
        b=L92ErfkuKLNpSCuWOJZZYzzlKOxrRVdqgQOBcjLPbFUroWQMmZvZtNA6dAB+17Wp41
         TsoWakbK40NRsG9ef9j62ZTdS7xdavC+K/GMFLsgIqhT5cQwUFhyoj1NnjH+LjGJrsVH
         HetgkYR02HOFa1rwZRMQjk+Ko62kS32RL5MPtPpnF4g8GH7EB2lQvXKB6GXnmsAFtmOo
         mAioyfEYLn/Jhgp/OG/syHn2KTY47nYNyLDMGNa4IPECUm79DRux4xABUByvt8Ltc23W
         izpv+UC8EJNqgiKju3Z8eKxd8rGxXsWyUAQKoubEVoRhQqB7ELWwWq4Qqi7MhaQzdrVT
         G9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aqOH77AFv2fQ8WuNNOzGfaD62FQFznjbgv+BXyATBoQ=;
        b=NPAxufUobkKSuG2uBZGG0gCTmovolO02nJGru8jTsiThMNSLF3szQSOpt+URsihfQV
         Mgv/4jq8IiciRgbBAN4feIG6S0nsIIt6ZIj/HFfTGrG2iajgivSc4R+5tvcBUm0alj++
         RK7WdBAmkxO5csnUYaBmapcKDXRpb+i/K+Xov21+cCQV7s2N/XcIQf3l4lR7rQIV0Gki
         F941UFxeou3NOHHcq1HmkvjcG1QZNI24kx2EQ9mSY8K9VUN/lgrE6tPNw9kCGKeBGdu3
         q9BIrjVrX9HDJ6xfkatlPyoEgvzvCFjm8nvIiJtKe6Etn2NUePSdxK0ovgd3gp3U6XlR
         Sttw==
X-Gm-Message-State: APjAAAUcjaME8NruzO2gCOQEmfylbMUukibRqRDX/zTRlrjTltLVO97x
        SYGSGnDVsO25L2t9OayfZR/GstXFYKwCGn1kP10CEg==
X-Google-Smtp-Source: APXvYqwm0syJ2uvbnJzuayuTIzucKMGjLKTBqqb04IwuxhvLNtPc31ycK/h5Y88aVdOST0pL3yfJjj5rxMjP2l6qA9E=
X-Received: by 2002:a17:906:4e87:: with SMTP id v7mr78014607eju.150.1558735641658;
 Fri, 24 May 2019 15:07:21 -0700 (PDT)
MIME-Version: 1.0
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-1-git-send-email-chiluk+linux@indeed.com>
 <1558637087-20283-2-git-send-email-chiluk+linux@indeed.com>
 <CAFTs51W0KdK4nw6wydn2HjNYvFRC8DYMmVeKX9FAe+4YUGEAZg@mail.gmail.com>
 <20190524143204.GB4684@lorien.usersys.redhat.com> <CAC=E7cXxsyMLw1PR+8QchTH8FYL7WX6_8LBVdqueR1yjW+VVkQ@mail.gmail.com>
 <CAFTs51Vm258CkDXi_Jj_cGOMotTvhdYR_VW8aUwAUvgistZOFQ@mail.gmail.com> <CAC=E7cXVrGRKMNkJPhd4fJi7wgdYk=YcXPV7B8GVNL5M69BarQ@mail.gmail.com>
In-Reply-To: <CAC=E7cXVrGRKMNkJPhd4fJi7wgdYk=YcXPV7B8GVNL5M69BarQ@mail.gmail.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Fri, 24 May 2019 15:07:10 -0700
Message-ID: <CAFTs51VhpDk9iW5UT62CkPCN3SjgUHHO1nVqhe+ssHMYqou6Bg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] sched/fair: Fix low cpu usage with high throttling
 by removing expiration of cpu-local slices
To:     Dave Chiluk <chiluk+linux@indeed.com>
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

On Fri, May 24, 2019 at 2:35 PM Dave Chiluk <chiluk+linux@indeed.com> wrote:
>
> On Fri, May 24, 2019 at 11:28 AM Peter Oskolkov <posk@posk.io> wrote:
> >
> > On Fri, May 24, 2019 at 8:15 AM Dave Chiluk <chiluk+linux@indeed.com> wrote:
> > >
> > > On Fri, May 24, 2019 at 9:32 AM Phil Auld <pauld@redhat.com> wrote:
> > > > On Thu, May 23, 2019 at 02:01:58PM -0700 Peter Oskolkov wrote:
> > >
> > > > > If the machine runs at/close to capacity, won't the overallocation
> > > > > of the quota to bursty tasks necessarily negatively impact every other
> > > > > task? Should the "unused" quota be available only on idle CPUs?
> > > > > (Or maybe this is the behavior achieved here, and only the comment and
> > > > > the commit message should be fixed...)
> > > > >
> > > >
> > > > It's bounded by the amount left unused from the previous period. So
> > > > theoretically a process could use almost twice its quota. But then it
> > > > would have nothing left over in the next period. To repeat it would have
> > > > to not use any that next period. Over a longer number of periods it's the
> > > > same amount of CPU usage.
> > > >
> > > > I think that is more fair than throttling a process that has never used
> > > > its full quota.
> > > >
> > > > And it removes complexity.
> > > >
> > > > Cheers,
> > > > Phil
> > >
> > > Actually it's not even that bad.  The overallocation of quota to a
> > > bursty task in a period is limited to at most one slice per cpu, and
> > > that slice must not have been used in the previous periods.  The slice
> > > size is set with /proc/sys/kernel/sched_cfs_bandwidth_slice_us and
> > > defaults to 5ms.  If a bursty task goes from underutilizing quota to
> > > using it's entire quota, it will not be able to burst in the
> > > subsequent periods.  Therefore in an absolute worst case contrived
> > > scenario, a bursty task can add at most 5ms to the latency of other
> > > threads on the same CPU.  I think this worst case 5ms tradeoff is
> > > entirely worth it.
> > >
> > > This does mean that a theoretically a poorly written massively
> > > threaded application on an 80 core box, that spreads itself onto 80
> > > cpu run queues, can overutilize it's quota in a period by at most 5ms
> > > * 80 CPUs in a sincle period (slice * number of runqueues the
> > > application is running on).  But that means that each of those threads
> > >  would have had to not be use their quota in a previous period, and it
> > > also means that the application would have to be carefully written to
> > > exacerbate this behavior.
> > >
> > > Additionally if cpu bound threads underutilize a slice of their quota
> > > in a period due to the cfs choosing a bursty task to run, they should
> > > theoretically be able to make it up in the following periods when the
> > > bursty task is unable to "burst".
> >
> > OK, so it is indeed possible that CPU bound threads will underutilize a slice
> > of their quota in a period as a result of this patch. This should probably
> > be clearly stated in the code comments and in the commit message.
> >
> > In addition, I believe that although many workloads will indeed be
> > indifferent to getting their fair share "later", some latency-sensitive
> > workloads will definitely be negatively affected by this temporary
> > CPU quota stealing by bursty antagonists. So there should probably be
> > a way to limit this behavior; for example, by making it tunable
> > per cgroup.
> >
> This patch restores the behavior that existed from at least
> v3.16..v4.18, and the current Redhat 7 kernels.  So you are kind of
> championing a moot point as no one has noticed this "bursting"
> behavior in over 5 years.  By removing this slice expiration
> altogether we restore the behavior and also solve the root issue of
> 'commit 512ac999d275 ("sched/fair: Fix bandwidth timer clock drift
> condition")'.
>
> Since 512ac999d275, many people are now noticing the slice expiration
> and very displeased with the behavior change.
> see: https://github.com/kubernetes/kubernetes/issues/67577
>
> I would love to hear if you know of a single complaint during that 5
> year time window, where someone noticed this bursting and reported
> that it negatively affected their application.

Linux CPU scheduling tail latency is a well-known issue and a major
pain point in some workloads:
https://www.google.com/search?q=linux+cpu+scheduling+tail+latency

Even assuming that nobody noticed this particular cause
of CPU scheduling latencies, it does not mean the problem should be waved
away. At least it should be documented, if at this point it decided that
it is difficult to address it in a meaningful way. And, preferably, a way
to address the issue later on should be discussed and hopefully agreed to.

>
> As for the documentation, I thought about documenting the possible
> adverse side-effect, but I didn't feel it was worthwhile since no one
> had noticed that corner case in the 5 years.  I also could not figure
> out a concise way of describing the slight corner case issue without
> overly complicating the documentation.  I felt that adding that corner
> case would have detracted rather than added to the documentation's
> usefulness.  As far as commenting in code, considering most of this
> commit removes lines, there's not a really great place for it.  That's
> why I did my best to describe the behavior in the documentation.
> Smart people can draw conclusions from there as you have done.  Please
> keep in mind that this "bursting" is again limited to a single slice
> on each per-cpu run-queue.
>
> Thank you,
> Dave
