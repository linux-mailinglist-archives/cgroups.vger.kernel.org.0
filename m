Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26DF273126
	for <lists+cgroups@lfdr.de>; Mon, 21 Sep 2020 19:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgIURu1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 13:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgIURu1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 13:50:27 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484C2C0613CF
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 10:50:27 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so14984441lfy.10
        for <cgroups@vger.kernel.org>; Mon, 21 Sep 2020 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fU34l7YxeD2C4TJGstKuQVh5OhgRVbQTmIsDH4TDtHA=;
        b=uawmf0NTdlD+Im+9mFd3lJDOqDo2Lsnv+KTjz98QMlHh4Ee2SL3Q4WOCovv/niPzcs
         IQvZtZsqpBQUtlDfI434b4iCVueJIG8k2HdnhSDdOzgriUDUB4SVTywrvcq+7aynv+G4
         9QCetox6w2Iny8/vuNondiSTlvkdSI+R3t4rh3P36hw6LyiB2jDb5YIF0PTishVgYV/9
         Kwuc5EX6vamTecE5s7JWTqU5JEJzWHi4ysKhDHOt8VHVJfESBMPkBJsuA8OQxo7P/98X
         DA0/OBG/CSSpaZEDOzbGRqCJIK9Iybw04BGzjfmgvpxLck7bWBDAhN9jySLBLBpI4CW5
         DxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fU34l7YxeD2C4TJGstKuQVh5OhgRVbQTmIsDH4TDtHA=;
        b=QIH8OY6n2WczZEzft6prK55S5spNQCua7hRSMjCmfTV/5LP5Hiay+SN3gNaBXCyEGu
         5F5du3D0MlKFBuXzOXqena2JPJ9oCwUZHiICwdecelKXQU8jUxip16t3kLir/2ZPqGDy
         iYwYsRRKg5P/cMJFZbkqvQQSEMGlftPRVU1DVOrFqTnOo/dZIqbMVky6VoQsIKXtEpZh
         yAjdzuyXiJHqpnt4FZV94dh1JukSTgAKTZzgDdkWm9ljK7zWXBqwfb2Z3kxofdPzhv7z
         EcKTjlXzw7sH+GztRSdPzu2fGdlZU3Kj1v4NgXtyScbQu+AoP0D/qC7Uz/JzGO57R+Pj
         vX7g==
X-Gm-Message-State: AOAM533WpomHjcUvmNyGYFvbBKah+Jqn0LFNPvBtzgr9R2RcLvqoN3sn
        NU99T6M8yZiA/gZQ76LAM/0iH3YMJyQvyIbDXAm/ug==
X-Google-Smtp-Source: ABdhPJw+gk5dv0k2lyN2dCiAOCx1GJch0WhuKQXBQLMc65N97gQksXGsg5JZYxQjydE4zX3xDLbNjN5yKXNRkBmhx0o=
X-Received: by 2002:a19:4084:: with SMTP id n126mr323748lfa.54.1600710625211;
 Mon, 21 Sep 2020 10:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200921163055.GQ12990@dhcp22.suse.cz>
In-Reply-To: <20200921163055.GQ12990@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 21 Sep 2020 10:50:14 -0700
Message-ID: <CALvZod43VXKZ3StaGXK_EZG_fKcW3v3=cEYOWFwp4HNJpOOf8g@mail.gmail.com>
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

On Mon, Sep 21, 2020 at 9:30 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 09-09-20 14:57:52, Shakeel Butt wrote:
> > Introduce an memcg interface to trigger memory reclaim on a memory cgroup.
> >
> > Use cases:
> > ----------
> >
> > 1) Per-memcg uswapd:
> >
> > Usually applications consists of combination of latency sensitive and
> > latency tolerant tasks. For example, tasks serving user requests vs
> > tasks doing data backup for a database application. At the moment the
> > kernel does not differentiate between such tasks when the application
> > hits the memcg limits. So, potentially a latency sensitive user facing
> > task can get stuck in high reclaim and be throttled by the kernel.
> >
> > Similarly there are cases of single process applications having two set
> > of thread pools where threads from one pool have high scheduling
> > priority and low latency requirement. One concrete example from our
> > production is the VMM which have high priority low latency thread pool
> > for the VCPUs while separate thread pool for stats reporting, I/O
> > emulation, health checks and other managerial operations. The kernel
> > memory reclaim does not differentiate between VCPU thread or a
> > non-latency sensitive thread and a VCPU thread can get stuck in high
> > reclaim.
>
> As those are presumably in the same cgroup what does prevent them to get
> stuck behind shared resources with taken during the reclaim performed by
> somebody else? I mean, memory reclaim might drop memory used by the high
> priority task. Or they might simply stumble over same locks.
>

Yes there are a lot of challenges in providing isolation between
latency sensitive and latency tolerant jobs/threads. This proposal
aims to solve one specific challenge memcg limit reclaim.

> I am also more interested in actual numbers here. The high limit reclaim
> is normally swift and should be mostly unnoticeable. If the reclaim gets
> more expensive then it can get really noticeable for sure. But for the
> later the same can happen with the external pro-activee reclaimer as

I think you meant 'uswapd' here instead of pro-active reclaimer.

> well, right? So there is no real "guarantee". Do you have any numbers
> from your workloads where you can demonstrate that the external reclaim
> has saved you this amount of effective cpu time of the sensitive
> workload? (Essentially measure how much time it has to consume in the
> high limit reclaim)
>

What we actually use in our production is the 'proactive reclaim'
which I have explained in the original message but I will add a couple
more sentences below.

For the uswapd use-case, let me point to the previous discussions and
feature requests by others [1, 2]. One of the limiting factors of
these previous proposals was the lack of CPU accounting of the
background reclaimer which the current proposal solves by enabling the
user space solution.

[1] https://lwn.net/Articles/753162/
[2] http://lkml.kernel.org/r/20200219181219.54356-1-hannes@cmpxchg.org

Let me add one more point. Even if the high limit reclaim is swift, it
can still take 100s of usecs. Most of our jobs are anon-only and we
use zswap. Compressing a page can take a couple usec, so 100s of usecs
in limit reclaim is normal. For latency sensitive jobs, this amount of
hiccups do matters.

For the proactive reclaim, based on the refault medium, we define
tolerable refault rate of the applications. Then we proactively
reclaim memory from the applications and monitor the refault rates.
Based on the refault rates, the memory overcommit manager controls the
aggressiveness of the proactive reclaim.

This is exactly what we do in the production. Please let me know if
you want to know why we do proactive reclaim in the first place.

> To the feature itself, I am not yet convinced we want to have a feature
> like that. It surely sounds easy to use and attractive for a better user
> space control. It is also much well defined than drop_caches/force_empty
> because it is not all or nothing. But it also sounds like something too
> easy to use incorrectly (remember drop_caches). I am also a bit worried
> about corner cases wich would be easier to hit - e.g. fill up the swap
> limit and turn anonymous memory into unreclaimable and who knows what
> else.

The corner cases you are worried about are already possible with the
existing interfaces. We can already do all such things with
memory.high interface but with some limitations. This new interface
resolves that limitation as explained in the original email.

Please let me know if you have more questions.

thanks,
Shakeel
