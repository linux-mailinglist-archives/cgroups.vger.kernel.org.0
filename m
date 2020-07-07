Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405092174AA
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2020 19:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgGGRDE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Jul 2020 13:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbgGGRDD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Jul 2020 13:03:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29591C08C5DC
        for <cgroups@vger.kernel.org>; Tue,  7 Jul 2020 10:03:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so47182269ljp.6
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2020 10:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWtqhQ1RMjRjpz8jm0pj/37FDxLQZ8+O9P8GTDhdm3U=;
        b=OOGSMxRhcoi7zXdpuHNOLamUQAGE/1dJvH57Oa2F7Dps70haKJ/iXRSThoOAl+4HDt
         fxUVYRoUA639HuyMtcTbnCZxTWFpur1enHcLY1+ZB/a92EhFjm5MZYW7Oq0HKUalGr6i
         dD8QbODR2513m2AsU5nK7RzbWo62rfxGu9YG6A3Wl8BAp1/uN7OtGoeinAkh7R6J850w
         oN8H0zGgpLNnOwE+o/kncGTkpwg8SwGs71l4ROffLmqLjjwkmXF5IDwDV+b7x9zm5WLk
         lkwKAiOezp0G9ojA7UL4URciZn3b0RSBk8z4v+JBUZUqnUvEMklVvRgfZAm8zqvahHrw
         1nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWtqhQ1RMjRjpz8jm0pj/37FDxLQZ8+O9P8GTDhdm3U=;
        b=XllTac4DzUpqAgh/GiOo9M58ryQx29PISZ0edeRBCuTEgpEbT4GLxbuC0MFMXwXQm+
         BC+rDrwKvFG7btHi73h/IDGeFMZoKnBcZNv/8ntGqk6Q82oL7AS+XvdjD4M+PVH3yA+6
         BjjSVKif38EZjPN7cuQsZIefY7HYcrnkK1nJzrjiofDFgjDGxA3lJWzQg14v8MHX/y4o
         LVWA6xrWzTWxTuTPCSkGGfs+Cg9czXqq8j4VsOVsdrSvP+jylL3O1OJRwb5cWyhygYee
         m48cH/VR02vIM7w3A+1KkHWjvk6i3OfTW2rw2LM1BT6/XBzxN2eZcnZcn5p01RYEdTZr
         RttA==
X-Gm-Message-State: AOAM533rmZgIh+2uw4YLQB4ayRfVkMuQ8OvcTdb4NC+9juPN10NQ1wM0
        Otr53A5x6fJD5iGfMoHfrxtAhEyABhS+LTrs6mCEuA==
X-Google-Smtp-Source: ABdhPJw4yPDo5/19AZW3fu7bt8YjrigxHvmkSzn5gvdi7ni0uhX8fx1MsMUD4Yqp646UBmzEk0B7lJQWf/IXp7CS3IE=
X-Received: by 2002:a05:651c:10f:: with SMTP id a15mr29464307ljb.192.1594141381178;
 Tue, 07 Jul 2020 10:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152222.2630760-1-shakeelb@google.com> <20200703063548.GM18446@dhcp22.suse.cz>
 <CALvZod5gthVX5m6o50OiYsXa=0_NpXK-tVvjTF42Oj4udr4Nuw@mail.gmail.com> <20200707121422.GP5913@dhcp22.suse.cz>
In-Reply-To: <20200707121422.GP5913@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 7 Jul 2020 10:02:50 -0700
Message-ID: <CALvZod5ty=piw6czyVyMhxQMBWGghC3ujxbrkVPr0fzwqogwrw@mail.gmail.com>
Subject: Re: [RFC PROPOSAL] memcg: per-memcg user space reclaim interface
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jul 7, 2020 at 5:14 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 03-07-20 07:23:14, Shakeel Butt wrote:
> > On Thu, Jul 2, 2020 at 11:35 PM Michal Hocko <mhocko@kernel.org> wrote:
> > >
> > > On Thu 02-07-20 08:22:22, Shakeel Butt wrote:
> > > [...]
> > > > Interface options:
> > > > ------------------
> > > >
> > > > 1) memcg interface e.g. 'echo 10M > memory.reclaim'
> > > >
> > > > + simple
> > > > + can be extended to target specific type of memory (anon, file, kmem).
> > > > - most probably restricted to cgroup v2.
> > > >
> > > > 2) fadvise(PAGEOUT) on cgroup_dir_fd
> > > >
> > > > + more general and applicable to other FSes (actually we are using
> > > > something similar for tmpfs).
> > > > + can be extended in future to just age the LRUs instead of reclaim or
> > > > some new use cases.
> > >
> > > Could you explain why memory.high as an interface to trigger pro-active
> > > memory reclaim is not sufficient. Also memory.low limit to protect
> > > latency sensitve workloads?
> >
> > Yes, we can use memory.high to trigger [proactive] reclaim in a memcg
> > but note that it can also introduce stalls in the application running
> > in that memcg. Let's suppose the memory.current of a memcg is 100MiB
> > and we want to reclaim 20MiB from it, we can set the memory.high to
> > 80MiB but any allocation attempt from the application running in that
> > memcg can get stalled/throttled. I want the functionality of the
> > reclaim without potential stalls.
>
> It would be great if the proposal mention this limitation.
>

Will do in the next version.


> > The memory.min is for protection against the global reclaim and is
> > unrelated to this discussion.
>
> Well, I was talkingg about memory.low. It is not meant only to protect
> from the global reclaim. It can be used for balancing memory reclaim
> from _any_ external memory pressure source. So it is somehow related to
> the usecase you have mentioned.
>

For the uswapd use-case, I am not concerned about the external memory
pressure source but the application hitting its own memory.high limit
and getting throttled.

> What you consider a latency sensitive workload could be protected from
> directly induced reclaim latencies. You could use low events to learn
> about the external memory pressure and update your protection to allow
> for some reclaim. I do understand that this wouldn't solve your problem
> who gets reclaimed and maybe that is the crux on why it is not
> applicable but that should really be mentioned explicitly.
>

The main aim for the proactive reclaim is to not cause an external
memory pressure. The low events can be another source of information
to tell the system level situation to the 'Memory Overcommit
Controller'. So, I see the low events as complementary, not the
replacement for the reclaim interface.

BTW by "low events from external memory pressure" am I correct in
understanding that you meant an unrelated job reclaiming and
triggering low events on a job of interest. Or do you mean to
partition a job into sub-jobs and then use the low events between
these sub-jobs somehow?
