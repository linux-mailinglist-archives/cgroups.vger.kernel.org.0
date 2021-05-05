Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985903733CD
	for <lists+cgroups@lfdr.de>; Wed,  5 May 2021 04:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhEEDAW (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 4 May 2021 23:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEEDAV (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 4 May 2021 23:00:21 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2078C06174A
        for <cgroups@vger.kernel.org>; Tue,  4 May 2021 19:59:25 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z1so802269ybf.6
        for <cgroups@vger.kernel.org>; Tue, 04 May 2021 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ihGAn22hJSR8rjyLL6L+pknKJgzhwSZEEzawq0VbAU0=;
        b=knXCpejnyh18gszj8Evz817ERM+apdbOpGzltW5BoTfCfnWvkFNz7GwzqeSqpjJRhq
         2Z5VxkeCwMz7CbctjqLVsv439h0ie60LIOjkJhgR2nLQfn3LTZw4zle3XxJGId4AeKiX
         SHItgrHqyo0S1OJB1a8ohnLE58ZALqyq0WwlAexypypDblVxzJ5GwCnXQ2TudbBZj9l/
         5NGj2T+jKrZQGcDLnsIb4kL2F7GM2XCD39p2MntbG30uZk1PEjwXqh+kWwy2Gi6SXfFw
         eky1yep288Y0OPlcPIQSbDnaPQUzvvPRAdS6WIravUuliHYFpzJ9BP65Ip1o1K451gsI
         QSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ihGAn22hJSR8rjyLL6L+pknKJgzhwSZEEzawq0VbAU0=;
        b=Ufw72fVNzPyTRE4uwyWCK+Rf7omerc5MhwLhTya3ot/V1IQMQh5WLNAZGNro7f4UGm
         SS64NGfk0Ms7qyFE0BYK49eBfNcsFgOZmzDXhbm13mylpdIo/XAn91OWZ09kBw9vMFAm
         /JIBOve/zKDBmVSCzFIixuWaDy34QE4rLbd95swndMqut0kcBLSKryMiT8MvSjVnkWeG
         NLUCa1OBz+w3/UQfCcbR6rPYnfIVnjxOfRxyf6y/jVR8W8cm/y1R7GfFsPkiyxaaEaKK
         RB7eoy6futisVsXbFA0dxggCWaE327ZYxAhbM2xjHqha41eL20QNDqsNLKigqIrScWZv
         owoQ==
X-Gm-Message-State: AOAM532gUFEx8xTzGZ021ZBcCQzrijL9/tiSugIbfpTS2AmGh7jeHXAs
        xAH/4JffAM8xIeCMKDlReS33PICB/7vYILZ0WCrrXw==
X-Google-Smtp-Source: ABdhPJxxNqPNHSOoLbLktWw+OgpqGe/rmbsMooN4hPamGsw+4Yzkcdu6/fR3RYL0B9Y4vjDcX5m68e+0T5PrU6Fck2A=
X-Received: by 2002:a25:7ec4:: with SMTP id z187mr36919159ybc.136.1620183564909;
 Tue, 04 May 2021 19:59:24 -0700 (PDT)
MIME-Version: 1.0
References: <CALvZod7vtDxJZtNhn81V=oE-EPOf=4KZB2Bv6Giz+u3bFFyOLg@mail.gmail.com>
 <YH54pyRWSi1zLMw4@dhcp22.suse.cz> <CALvZod4kjdgMU=8T_bx6zFufA1cGtt2p1Jg8jOgi=+g=bs-Evw@mail.gmail.com>
 <YH/RPydqhwXdyG80@dhcp22.suse.cz> <CALvZod4kRWDQuZZQ5F+z6WMcUWLwgYd-Kb0mY8UAEK4MbSOZaA@mail.gmail.com>
 <YIA2rB0wgqKzfUfi@dhcp22.suse.cz> <CALvZod4_L7GSHnivQTSdDzo=fb4i3z=katjzVCHfLz9WWGK8uQ@mail.gmail.com>
 <CAJuCfpEXyG9x1nUsg+6yVWTP+-A4OwuCg9XHLAciu39=JNY7DQ@mail.gmail.com> <CALvZod4pqkY84Od67=aEnpWL7V3bXnH4pduBQAh89Byp=snD+Q@mail.gmail.com>
In-Reply-To: <CALvZod4pqkY84Od67=aEnpWL7V3bXnH4pduBQAh89Byp=snD+Q@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 4 May 2021 19:59:13 -0700
Message-ID: <CAJuCfpGD8xBh2nepB0zmxRjzjQQbxKj_o9OzQPQMkw5rUcovMQ@mail.gmail.com>
Subject: Re: [RFC] memory reserve for userspace oom-killer
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Dragos Sbirlea <dragoss@google.com>,
        Priya Duraisamy <padmapriyad@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 4, 2021 at 7:45 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, May 4, 2021 at 6:26 PM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Tue, May 4, 2021 at 5:37 PM Shakeel Butt <shakeelb@google.com> wrote:
> > >
> > > On Wed, Apr 21, 2021 at 7:29 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > [...]
> > > > > > What if the pool is depleted?
> > > > >
> > > > > This would mean that either the estimate of mempool size is bad or
> > > > > oom-killer is buggy and leaking memory.
> > > > >
> > > > > I am open to any design directions for mempool or some other way where
> > > > > we can provide a notion of memory guarantee to oom-killer.
> > > >
> > > > OK, thanks for clarification. There will certainly be hard problems to
> > > > sort out[1] but the overall idea makes sense to me and it sounds like a
> > > > much better approach than a OOM specific solution.
> > > >
> > > >
> > > > [1] - how the pool is going to be replenished without hitting all
> > > > potential reclaim problems (thus dependencies on other all tasks
> > > > directly/indirectly) yet to not rely on any background workers to do
> > > > that on the task behalf without a proper accounting etc...
> > > > --
> > >
> > > I am currently contemplating between two paths here:
> > >
> > > First, the mempool, exposed through either prctl or a new syscall.
> > > Users would need to trace their userspace oom-killer (or whatever
> > > their use case is) to find an appropriate mempool size they would need
> > > and periodically refill the mempools if allowed by the state of the
> > > machine. The challenge here is to find a good value for the mempool
> > > size and coordinating the refilling of mempools.
> > >
> > > Second is a mix of Roman and Peter's suggestions but much more
> > > simplified. A very simple watchdog with a kill-list of processes and
> > > if userspace didn't pet the watchdog within a specified time, it will
> > > kill all the processes in the kill-list. The challenge here is to
> > > maintain/update the kill-list.
> >
> > IIUC this solution is designed to identify cases when oomd/lmkd got
> > stuck while allocating memory due to memory shortages and therefore
> > can't feed the watchdog. In such a case the kernel goes ahead and
> > kills some processes to free up memory and unblock the blocked
> > process. Effectively this would limit the time such a process gets
> > stuck by the duration of the watchdog timeout. If my understanding of
> > this proposal is correct,
>
> Your understanding is indeed correct.
>
> > then I see the following downsides:
> > 1. oomd/lmkd are still not prevented from being stuck, it just limits
> > the duration of this blocked state. Delaying kills when memory
> > pressure is high even for short duration is very undesirable.
>
> Yes I agree.
>
> > I think
> > having mempool reserves could address this issue better if it can
> > always guarantee memory availability (not sure if it's possible in
> > practice).
>
> I think "mempool ... always guarantee memory availability" is
> something I should quantify with some experiments.
>
> > 2. What would be performance overhead of this watchdog? To limit the
> > duration of a process being blocked to a small enough value we would
> > have to have quite a small timeout, which means oomd/lmkd would have
> > to wake up quite often to feed the watchdog. Frequent wakeups on a
> > battery-powered system is not a good idea.
>
> This is indeed the downside i.e. the tradeoff between acceptable stall
> vs frequent wakeups.
>
> > 3. What if oomd/lmkd gets stuck for some memory-unrelated reason and
> > can't feed the watchdog? In such a scenario the kernel would assume
> > that it is stuck due to memory shortages and would go on a killing
> > spree.
>
> This is correct but IMHO killing spree is not worse than oomd/lmkd
> getting stuck for some other reason.
>
> > If there is a sure way to identify when a process gets stuck
> > due to memory shortages then this could work better.
>
> Hmm are you saying looking at the stack traces of the userspace
> oom-killer or some metrics related to oom-killer? It will complicate
> the code.

Well, I don't know of a sure and easy way to identify the reasons for
process blockage but maybe there is one I don't know of? My point is
that we would need some additional indications of memory being the
culprit for the process blockage before resorting to kill.

>
> > 4. Additional complexity of keeping the list of potential victims in
> > the kernel. Maybe we can simply reuse oom_score to choose the best
> > victims?
>
> Your point of additional complexity is correct. Regarding oom_score I
> think you meant oom_score_adj, I would avoid putting more
> policies/complexity in the kernel but I got your point that the
> simplest watchdog might not be helpful at all.
>
> > Thanks,
> > Suren.
> >
> > >
> > > I would prefer the direction which oomd and lmkd are open to adopt.
> > >
> > > Any suggestions?
