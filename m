Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF6A2745D0
	for <lists+cgroups@lfdr.de>; Tue, 22 Sep 2020 17:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIVPyj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 22 Sep 2020 11:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgIVPyj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 22 Sep 2020 11:54:39 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A5C0613CF
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 08:54:39 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so18580945lfq.11
        for <cgroups@vger.kernel.org>; Tue, 22 Sep 2020 08:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DhBF2jTvMWCeriVUASDADc+szYByXALrPY3a1EYhNro=;
        b=P3Ay9SRHDAkztQKMKlq51qYwGa0G4GvghvS429uCrJf/zHMee0gjHpu7fkwDoCuDim
         1ydzqB/8qgvIZNmYdbdVu5uUlbiWFOUCKtVCVkQJhlbt7dhgC7slXv4qIcTwI6H747q2
         uVh1OmoTZVd2o5jfD141skL1dsqraDkdAAHRyFhgq0xqW58sFC8R2TIykHf1blGeHq48
         eyjactwu6LwP6ujN/Yli9NeIlLdyKOa7h9jgHQvTirbTFhCcZSXLXDueom+1COnZcD+p
         En+P60VJbdZwZ7li+eZb/rQntxvREWU+lD4i6IGaD8a5HCZw9iAeWJhqXTyVjjdiG1y1
         TsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DhBF2jTvMWCeriVUASDADc+szYByXALrPY3a1EYhNro=;
        b=VNZEz8uMGK1QxJMrhkA3GsC1A1UUUTYNlmQ3W5l/3jdVhtwBKakl0VTZvU2oBOf0DA
         +vJNZ+k+g+sZTNYAFVxq3KstYHpVKUatLwLkF48/dl7O0aOVm16CM5NrlcAZDyB6MHha
         2f9EIRwrOiRTkv+IGyNnq24isrsDgwMXdH6JFpgXJYqR1Di3s7rO9AGDRZF6rWQjAPXR
         PoH92RiCiJq0fWSPuutusmtphejZB7z/kBVPKYStAb0DQCU4oen1CroVvLM1iIlRfc+c
         Tqub2JFStxaN+x07/E93HY2H4oucoaGPkJZGw06ze+izZkQceVR+oC40BGP0IZc4qU1s
         KY8Q==
X-Gm-Message-State: AOAM532e0IuR8Jo2OIaA5wEpR5AqtHBul7XBtC37nBjBzJgxiwwLmR0I
        1OilUs3KdUZW3u0L7dThzRUDQwJzMwHBy88WoyHbig==
X-Google-Smtp-Source: ABdhPJz9THFykcuDwM1ucynB6yeLrG0lINVX7zrsFgjYHGIPLzWNr0W4g4HXO9WFHaBCAxZYK55VcbuQCtAHokYS3H0=
X-Received: by 2002:ac2:59da:: with SMTP id x26mr2037249lfn.346.1600790076981;
 Tue, 22 Sep 2020 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200921163055.GQ12990@dhcp22.suse.cz>
 <CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com> <20200922114908.GZ12990@dhcp22.suse.cz>
In-Reply-To: <20200922114908.GZ12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 22 Sep 2020 08:54:25 -0700
Message-ID: <CALvZod4FvE12o53BpeH5WB_McTdCkFTFXgc9gcT1CEHXzQLy_A@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 22, 2020 at 4:49 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 21-09-20 10:50:14, Shakeel Butt wrote:
> > On Mon, Sep 21, 2020 at 9:30 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Wed 09-09-20 14:57:52, Shakeel Butt wrote:
> > > > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> > > >
> > > > Use cases:
> > > > ----------
> > > >
> > > > 1) Per-memcg uswapd:
> > > >
> > > > Usually applications consists of combination of latency sensitive and
> > > > latency tolerant tasks. For example, tasks serving user requests vs
> > > > tasks doing data backup for a database application. At the moment the
> > > > kernel does not differentiate between such tasks when the application
> > > > hits the memcg limits. So, potentially a latency sensitive user facing
> > > > task can get stuck in high reclaim and be throttled by the kernel.
> > > >
> > > > Similarly there are cases of single process applications having two set
> > > > of thread pools where threads from one pool have high scheduling
> > > > priority and low latency requirement. One concrete example from our
> > > > production is the VMM which have high priority low latency thread pool
> > > > for the VCPUs while separate thread pool for stats reporting, I/O
> > > > emulation, health checks and other managerial operations. The kernel
> > > > memory reclaim does not differentiate between VCPU thread or a
> > > > non-latency sensitive thread and a VCPU thread can get stuck in high
> > > > reclaim.
> > >
> > > As those are presumably in the same cgroup what does prevent them to get
> > > stuck behind shared resources with taken during the reclaim performed by
> > > somebody else? I mean, memory reclaim might drop memory used by the high
> > > priority task. Or they might simply stumble over same locks.
> > >
> >
> > Yes there are a lot of challenges in providing isolation between
> > latency sensitive and latency tolerant jobs/threads. This proposal
> > aims to solve one specific challenge memcg limit reclaim.
>
> I am fully aware that a complete isolation is hard to achieve. I am just
> trying evaluate how is this specific usecase worth a new interface that
> we will have to maintain for ever. Especially when I suspect that the
> interface will likely only paper over immediate problems rather than
> offer a long term maintainable solution for it.
>

I think you are getting too focused on the uswapd use-case only. The
proposed interface enables the proactive reclaim as well which we
actually use in production.

> > > I am also more interested in actual numbers here. The high limit reclaim
> > > is normally swift and should be mostly unnoticeable. If the reclaim gets
> > > more expensive then it can get really noticeable for sure. But for the
> > > later the same can happen with the external pro-activee reclaimer as
> >
> > I think you meant 'uswapd' here instead of pro-active reclaimer.
> >
> > > well, right? So there is no real "guarantee". Do you have any numbers
> > > from your workloads where you can demonstrate that the external reclaim
> > > has saved you this amount of effective cpu time of the sensitive
> > > workload? (Essentially measure how much time it has to consume in the
> > > high limit reclaim)
> > >
> >
> > What we actually use in our production is the 'proactive reclaim'
> > which I have explained in the original message but I will add a couple
> > more sentences below.
> >
> > For the uswapd use-case, let me point to the previous discussions and
> > feature requests by others [1, 2]. One of the limiting factors of
> > these previous proposals was the lack of CPU accounting of the
> > background reclaimer which the current proposal solves by enabling the
> > user space solution.
> >
> > [1] https://lwn.net/Articles/753162/
> > [2] http://lkml.kernel.org/r/20200219181219.54356-1-hannes@cmpxchg.org
>
> I remember those. My understanding was that the only problem is to
> properly account for CPU on behalf of the reclaimed cgroup and that has
> been work in progress for that.
>
> Outsourcing all that to userspace surely sounds like an attractive
> option but it comes with usual user API price. More on that later.
>
> > Let me add one more point. Even if the high limit reclaim is swift, it
> > can still take 100s of usecs. Most of our jobs are anon-only and we
> > use zswap. Compressing a page can take a couple usec, so 100s of usecs
> > in limit reclaim is normal. For latency sensitive jobs, this amount of
> > hiccups do matters.
>
> Understood. But isn't this an implementation detail of zswap? Can it
> offload some of the heavy lifting to a different context and reduce the
> general overhead?
>

Are you saying doing the compression asynchronously? Similar to how
the disk-based swap triggers the writeback and puts the page back to
LRU, so the next time reclaim sees it, it will be instantly reclaimed?
Or send the batch of pages to be compressed to a different CPU and
wait for the completion?

BTW the proactive reclaim naturally offloads that to a different context.

> > For the proactive reclaim, based on the refault medium, we define
> > tolerable refault rate of the applications. Then we proactively
> > reclaim memory from the applications and monitor the refault rates.
> > Based on the refault rates, the memory overcommit manager controls the
> > aggressiveness of the proactive reclaim.
> >
> > This is exactly what we do in the production. Please let me know if
> > you want to know why we do proactive reclaim in the first place.
>
> This information is definitely useful and having it in the changelog
> would be useful. IIUC the only reason why you cannot use high limit
> to control this pro-active reclaim is the potential throttling due to
> expensive reclaim, correct?
>

Yes.

> > > To the feature itself, I am not yet convinced we want to have a feature
> > > like that. It surely sounds easy to use and attractive for a better user
> > > space control. It is also much well defined than drop_caches/force_empty
> > > because it is not all or nothing. But it also sounds like something too
> > > easy to use incorrectly (remember drop_caches). I am also a bit worried
> > > about corner cases wich would be easier to hit - e.g. fill up the swap
> > > limit and turn anonymous memory into unreclaimable and who knows what
> > > else.
> >
> > The corner cases you are worried about are already possible with the
> > existing interfaces. We can already do all such things with
> > memory.high interface but with some limitations. This new interface
> > resolves that limitation as explained in the original email.
>
> You are right that misconfigured limits can result in problems. But such
> a configuration should be quite easy to spot which is not the case for
> targetted reclaim calls which do not leave any footprints behind.
> Existing interfaces are trying to not expose internal implementation
> details as much as well. You are proposing a very targeted interface to
> fine control the memory reclaim. There is a risk that userspace will
> start depending on a specific reclaim implementation/behavior and future
> changes would be prone to regressions in workloads relying on that. So
> effectively, any user space memory reclaimer would need to be tuned to a
> specific implementation of the memory reclaim.

I don't see the exposure of internal memory reclaim implementation.
The interface is very simple. Reclaim a given amount of memory. Either
the kernel will reclaim less memory or it will over reclaim. In case
of reclaiming less memory, the user space can retry given there is
enough reclaimable memory. For the over reclaim case, the user space
will backoff for a longer time. How are the internal reclaim
implementation details exposed?

> My past experience tells
> me that this is not a great thing for maintainability of neither kernel
> nor the userspace part.
>
> All that being said, we really should consider whether the proposed
> interface is trying to work around existing limitations in the reclaim
> or the interface. If this is the former then I do not think we should be
> adding it. If the later then we should discuss on how to improve our
> existing interfaces (or their implementations) to be better usable and
> allow your usecase to work better.

It is the limitation of the interface. My concern is in fixing the
interface we might convolute the memory.high interface making it more
burden to maintain than simply adding a new interface.

>
> What is your take on that Johannes?
> --
> Michal Hocko
> SUSE Labs
