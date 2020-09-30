Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9496727EDB4
	for <lists+cgroups@lfdr.de>; Wed, 30 Sep 2020 17:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgI3Ppd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 30 Sep 2020 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbgI3Ppc (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 30 Sep 2020 11:45:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B82C0613D0
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 08:45:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c2so1991593ljj.12
        for <cgroups@vger.kernel.org>; Wed, 30 Sep 2020 08:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjGyYmsLAMjsI4Vd+JJ6aVnyc9ajioRKaKMFxKhxaik=;
        b=NjAmdQm8MXZaLnWlGnp/SJHX6VYj0DS/7Gez+83AyXBMoNvk+/jPA1SbFRqQcqtBwO
         Ok/o36HzVVkUY3ru2aZxBs+wGU4DRrhw+hiDOzyytPNaO5JSw/Wf6d8Rri3vItQ4G2EM
         /Ek+Q+OZpsDOEL19Frebd8dK6g78mhoubgOLsJkyY+EC+TnjsmNR7Gao6ZLzC/8UMC5l
         f5wnBiQ4/mjBsrjkH0LrsRRzwlK0f18AfRnxg+Pdie3iMZ6Orfb+K5jq2KEmj7u+r/fE
         dfZQL7UGluptFcNBHGODab7Xi3NvTFTVox6i6gTovbv4j5iaq+2W5lMbaA2aphOu5YS0
         3uKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjGyYmsLAMjsI4Vd+JJ6aVnyc9ajioRKaKMFxKhxaik=;
        b=kIuQx85iW1zZVdSc2XSxwHHXb8jtW8dAAI+LSwS1fl9cnmvl/aamS7Mq8e+LkiCPwi
         bllZPxlQJraMXtZChID4nBSE4BHIObjVWr3Cf1y31UZB131+f4jUkKez4Bj/ZMmhbXbY
         jDWJfrXyvl5tzE34tHy8gNsxoxl/HXaTySf3CGdUvNuFUJosx+wN/DFbNwC1FgvvPadx
         S0JdvSS98GbN0SzOIbAYbmASYJHjvBPLLROGvPFVAALgRgJRRrHql9CSHYz4HAtMZkRK
         Fn2c7cS5Ic+PLVgvhjSHOLcAh6/MtjBey3HjlAzZgwbdNDsfK5XhraWjQm4FITjpD5v8
         ajYg==
X-Gm-Message-State: AOAM5316v5ftNxFnI/jy4MlW/LPQyx3cKndpRCkOipCnGQfqobFr3Ga8
        rw/mUNZN0QHfHAQGaghXfMS8UvXJPYB61zpRxdu8Mg==
X-Google-Smtp-Source: ABdhPJy7Kpt7Q45UX41ep+M5rkizj38eD5g+4Z6l7TCfVZ1MzlbY3Yz8+VarznH/8FMlSNQWRSVWMedxWqjPqxxv7Dk=
X-Received: by 2002:a2e:98cf:: with SMTP id s15mr1169162ljj.446.1601480729013;
 Wed, 30 Sep 2020 08:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200909215752.1725525-1-shakeelb@google.com> <20200928210216.GA378894@cmpxchg.org>
 <20200929150444.GG2277@dhcp22.suse.cz> <20200929215341.GA408059@cmpxchg.org>
In-Reply-To: <20200929215341.GA408059@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 30 Sep 2020 08:45:17 -0700
Message-ID: <CALvZod5eN0PDtKo8SEp1n-xGvgCX9k6-OBGYLT3RmzhA+Q-2hw@mail.gmail.com>
Subject: Re: [PATCH] memcg: introduce per-memcg reclaim interface
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Greg Thelen <gthelen@google.com>,
        David Rientjes <rientjes@google.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 29, 2020 at 2:55 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Tue, Sep 29, 2020 at 05:04:44PM +0200, Michal Hocko wrote:
> > On Mon 28-09-20 17:02:16, Johannes Weiner wrote:
> > [...]
> > > My take is that a proactive reclaim feature, whose goal is never to
> > > thrash or punish but to keep the LRUs warm and the workingset trimmed,
> > > would ideally have:
> > >
> > > - a pressure or size target specified by userspace but with
> > >   enforcement driven inside the kernel from the allocation path
> > >
> > > - the enforcement work NOT be done synchronously by the workload
> > >   (something I'd argue we want for *all* memory limits)
> > >
> > > - the enforcement work ACCOUNTED to the cgroup, though, since it's the
> > >   cgroup's memory allocations causing the work (again something I'd
> > >   argue we want in general)
> > >
> > > - a delegatable knob that is independent of setting the maximum size
> > >   of a container, as that expresses a different type of policy
> > >
> > > - if size target, self-limiting (ha) enforcement on a pressure
> > >   threshold or stop enforcement when the userspace component dies
> > >
> > > Thoughts?
> >
> > Agreed with above points. What do you think about
> > http://lkml.kernel.org/r/20200922190859.GH12990@dhcp22.suse.cz.
>
> I definitely agree with what you wrote in this email for background
> reclaim. Indeed, your description sounds like what I proposed in
> https://lore.kernel.org/linux-mm/20200219181219.54356-1-hannes@cmpxchg.org/
> - what's missing from that patch is proper work attribution.
>
> > I assume that you do not want to override memory.high to implement
> > this because that tends to be tricky from the configuration POV as
> > you mentioned above. But a new limit (memory.middle for a lack of a
> > better name) to define the background reclaim sounds like a good fit
> > with above points.
>
> I can see that with a new memory.middle you could kind of sort of do
> both - background reclaim and proactive reclaim.
>
> That said, I do see advantages in keeping them separate:
>
> 1. Background reclaim is essentially an allocation optimization that
>    we may want to provide per default, just like kswapd.
>
>    Kswapd is tweakable of course, but I think actually few users do,
>    and it works pretty well out of the box. It would be nice to
>    provide the same thing on a per-cgroup basis per default and not
>    ask users to make decisions that we are generally better at making.
>
> 2. Proactive reclaim may actually be better configured through a
>    pressure threshold rather than a size target.
>
>    As per above, the goal is not to be punitive or containing. The
>    goal is to keep the LRUs warm and move the colder pages to disk.
>
>    But how aggressively do you run reclaim for this purpose? What
>    target value should a user write to such a memory.middle file?
>
>    For one, it depends on the job. A batch job, or a less important
>    background job, may tolerate higher paging overhead than an
>    interactive job. That means more of its pages could be trimmed from
>    RAM and reloaded on-demand from disk.
>
>    But also, it depends on the storage device. If you move a workload
>    from a machine with a slow disk to a machine with a fast disk, you
>    can page more data in the same amount of time. That means while
>    your workload tolerances stays the same, the faster the disk, the
>    more aggressively you can do reclaim and offload memory.
>
>    So again, what should a user write to such a control file?
>
>    Of course, you can approximate an optimal target size for the
>    workload. You can run a manual workingset analysis with page_idle,
>    damon, or similar, determine a hot/cold cutoff based on what you
>    know about the storage characteristics, then echo a number of pages
>    or a size target into a cgroup file and let kernel do the reclaim
>    accordingly. The drawbacks are that the kernel LRU may do a
>    different hot/cold classification than you did and evict the wrong
>    pages, the storage device latencies may vary based on overall IO
>    pattern, and two equally warm pages may have very different paging
>    overhead depending on whether readahead can avert a major fault or
>    not. So it's easy to overshoot the tolerance target and disrupt the
>    workload, or undershoot and have stale LRU data, waste memory etc.
>
>    You can also do a feedback loop, where you guess an optimal size,
>    then adjust based on how much paging overhead the workload is
>    experiencing, i.e. memory pressure. The drawbacks are that you have
>    to monitor pressure closely and react quickly when the workload is
>    expanding, as it can be potentially sensitive to latencies in the
>    usec range. This can be tricky to do from userspace.
>

This is actually what we do in our production i.e. feedback loop to
adjust the next iteration of proactive reclaim.

We eliminated the IO or slow disk issues you mentioned by only
focusing on anon memory and doing zswap.

>    So instead of asking users for a target size whose suitability
>    heavily depends on the kernel's LRU implementation, the readahead
>    code, the IO device's capability and general load, why not directly
>    ask the user for a pressure level that the workload is comfortable
>    with and which captures all of the above factors implicitly? Then
>    let the kernel do this feedback loop from a per-cgroup worker.

I am assuming here by pressure level you are referring to the PSI like
interface e.g. allowing the users to tell about their jobs that X
amount of stalls in a fixed time window is tolerable.

Seems promising though I would like flexibility for giving the
resource to the per-cgroup worker.

Are you planning to work on this or should I give it a try?
