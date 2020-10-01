Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E93280153
	for <lists+cgroups@lfdr.de>; Thu,  1 Oct 2020 16:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbgJAOdd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 1 Oct 2020 10:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732020AbgJAOdc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 1 Oct 2020 10:33:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66002C0613D0
        for <cgroups@vger.kernel.org>; Thu,  1 Oct 2020 07:33:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so5496320qkf.4
        for <cgroups@vger.kernel.org>; Thu, 01 Oct 2020 07:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jO3BB8sVqiM7vkvwS1XKzZc6N0X8KTzVoqftN8TqfgY=;
        b=pFDbQq9H6572Zep0T0kiBK6O7gvcomiDy/QnxFgocFInKglLtah5+pLzvUOj3o9TPH
         +3da9GlUc4tqby6bzqiaELI5lmPN4OaxP9JadjXiNAl5peWgjvHsOEIxXZA8itf2TpYA
         JNviktKQyP0nsSSMAAW0MxjfMd7rEyANGzxySxkDh3bWE6xluydotD90yrNYtye8EqJ3
         BvGaoNvS9pYwjfzCTbatP3d1ysGa5OH4ZqBeiLCC1vB107nF4lHhgKPjdxaGOrd5gfbM
         k2XnQf/MNMGoG7ONN84busjIoH2e/uYBL+MszKJcAeZxGFSM/C2lshGLybQO/xFPCg06
         QReg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jO3BB8sVqiM7vkvwS1XKzZc6N0X8KTzVoqftN8TqfgY=;
        b=Bp34KZUoGA0/aapndSRwyOHsVd6qcvxePGXQrac9sHkihkcf0RZEwV0N4XtZLSQtak
         kbpFwHW6iv9vIESWMoElX1kyiMg+wX8ZUO96Uq1BemtLyFzxMu4w6cqOmYQIaFwS5S3t
         a4N0NVBT1OH9jy5DnTry62ILuuAuu7+lTLuN5bA7ZwOSkvATEeQoBdxaUWtqVs9WiOsm
         lIp8imWaiyWQfcfpVkrrGy3lMVbF03YIQOmlmqs4DbSLlbwCsnzMw2BDiw1EJzPsVn8C
         sLg0P7LJvCRFbknQFBLnQlEjPWmBzZfaxtCU+TEFGnnSjnS3VKLO1tOdA4oFupEm3j8M
         j2hQ==
X-Gm-Message-State: AOAM5316j8k6aR/GYgHvCXW8HOKm8ZQkSg5Az5w5UojUlLLL/ZzWBhol
        O2n3blEIv+R6Y3txgDKbZhR/ZA==
X-Google-Smtp-Source: ABdhPJxL3ROIE5EEr8xfyH9JXGHvkoQMCRX5NFXfsVuxPCSEzPGogJNQe2fKUfXyH7bAIptu5sJr8g==
X-Received: by 2002:a37:4f90:: with SMTP id d138mr7888531qkb.451.1601562811437;
        Thu, 01 Oct 2020 07:33:31 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:4e22])
        by smtp.gmail.com with ESMTPSA id m3sm6483356qkh.10.2020.10.01.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:33:29 -0700 (PDT)
Date:   Thu, 1 Oct 2020 10:31:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
Message-ID: <20201001143149.GA493631@cmpxchg.org>
References: <20200909215752.1725525-1-shakeelb@google.com>
 <20200928210216.GA378894@cmpxchg.org>
 <20200929150444.GG2277@dhcp22.suse.cz>
 <20200929215341.GA408059@cmpxchg.org>
 <CALvZod5eN0PDtKo8SEp1n-xGvgCX9k6-OBGYLT3RmzhA+Q-2hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5eN0PDtKo8SEp1n-xGvgCX9k6-OBGYLT3RmzhA+Q-2hw@mail.gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Sep 30, 2020 at 08:45:17AM -0700, Shakeel Butt wrote:
> On Tue, Sep 29, 2020 at 2:55 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Sep 29, 2020 at 05:04:44PM +0200, Michal Hocko wrote:
> > > On Mon 28-09-20 17:02:16, Johannes Weiner wrote:
> > > [...]
> > > > My take is that a proactive reclaim feature, whose goal is never to
> > > > thrash or punish but to keep the LRUs warm and the workingset trimmed,
> > > > would ideally have:
> > > >
> > > > - a pressure or size target specified by userspace but with
> > > >   enforcement driven inside the kernel from the allocation path
> > > >
> > > > - the enforcement work NOT be done synchronously by the workload
> > > >   (something I'd argue we want for *all* memory limits)
> > > >
> > > > - the enforcement work ACCOUNTED to the cgroup, though, since it's the
> > > >   cgroup's memory allocations causing the work (again something I'd
> > > >   argue we want in general)
> > > >
> > > > - a delegatable knob that is independent of setting the maximum size
> > > >   of a container, as that expresses a different type of policy
> > > >
> > > > - if size target, self-limiting (ha) enforcement on a pressure
> > > >   threshold or stop enforcement when the userspace component dies
> > > >
> > > > Thoughts?
> > >
> > > Agreed with above points. What do you think about
> > > http://lkml.kernel.org/r/20200922190859.GH12990@dhcp22.suse.cz.
> >
> > I definitely agree with what you wrote in this email for background
> > reclaim. Indeed, your description sounds like what I proposed in
> > https://lore.kernel.org/linux-mm/20200219181219.54356-1-hannes@cmpxchg.org/
> > - what's missing from that patch is proper work attribution.
> >
> > > I assume that you do not want to override memory.high to implement
> > > this because that tends to be tricky from the configuration POV as
> > > you mentioned above. But a new limit (memory.middle for a lack of a
> > > better name) to define the background reclaim sounds like a good fit
> > > with above points.
> >
> > I can see that with a new memory.middle you could kind of sort of do
> > both - background reclaim and proactive reclaim.
> >
> > That said, I do see advantages in keeping them separate:
> >
> > 1. Background reclaim is essentially an allocation optimization that
> >    we may want to provide per default, just like kswapd.
> >
> >    Kswapd is tweakable of course, but I think actually few users do,
> >    and it works pretty well out of the box. It would be nice to
> >    provide the same thing on a per-cgroup basis per default and not
> >    ask users to make decisions that we are generally better at making.
> >
> > 2. Proactive reclaim may actually be better configured through a
> >    pressure threshold rather than a size target.
> >
> >    As per above, the goal is not to be punitive or containing. The
> >    goal is to keep the LRUs warm and move the colder pages to disk.
> >
> >    But how aggressively do you run reclaim for this purpose? What
> >    target value should a user write to such a memory.middle file?
> >
> >    For one, it depends on the job. A batch job, or a less important
> >    background job, may tolerate higher paging overhead than an
> >    interactive job. That means more of its pages could be trimmed from
> >    RAM and reloaded on-demand from disk.
> >
> >    But also, it depends on the storage device. If you move a workload
> >    from a machine with a slow disk to a machine with a fast disk, you
> >    can page more data in the same amount of time. That means while
> >    your workload tolerances stays the same, the faster the disk, the
> >    more aggressively you can do reclaim and offload memory.
> >
> >    So again, what should a user write to such a control file?
> >
> >    Of course, you can approximate an optimal target size for the
> >    workload. You can run a manual workingset analysis with page_idle,
> >    damon, or similar, determine a hot/cold cutoff based on what you
> >    know about the storage characteristics, then echo a number of pages
> >    or a size target into a cgroup file and let kernel do the reclaim
> >    accordingly. The drawbacks are that the kernel LRU may do a
> >    different hot/cold classification than you did and evict the wrong
> >    pages, the storage device latencies may vary based on overall IO
> >    pattern, and two equally warm pages may have very different paging
> >    overhead depending on whether readahead can avert a major fault or
> >    not. So it's easy to overshoot the tolerance target and disrupt the
> >    workload, or undershoot and have stale LRU data, waste memory etc.
> >
> >    You can also do a feedback loop, where you guess an optimal size,
> >    then adjust based on how much paging overhead the workload is
> >    experiencing, i.e. memory pressure. The drawbacks are that you have
> >    to monitor pressure closely and react quickly when the workload is
> >    expanding, as it can be potentially sensitive to latencies in the
> >    usec range. This can be tricky to do from userspace.
> >
> 
> This is actually what we do in our production i.e. feedback loop to
> adjust the next iteration of proactive reclaim.

That's what we do also right now. It works reasonably well, the only
two pain points are/have been the reaction time under quick workload
expansion and inadvertently forcing the workload into direct reclaim.

> We eliminated the IO or slow disk issues you mentioned by only
> focusing on anon memory and doing zswap.

Interesting, may I ask how the file cache is managed in this setup?

> >    So instead of asking users for a target size whose suitability
> >    heavily depends on the kernel's LRU implementation, the readahead
> >    code, the IO device's capability and general load, why not directly
> >    ask the user for a pressure level that the workload is comfortable
> >    with and which captures all of the above factors implicitly? Then
> >    let the kernel do this feedback loop from a per-cgroup worker.
> 
> I am assuming here by pressure level you are referring to the PSI like
> interface e.g. allowing the users to tell about their jobs that X
> amount of stalls in a fixed time window is tolerable.

Right, essentially the same parameters that psi poll() would take.
