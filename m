Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7E81A7ED5
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 15:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732988AbgDNNvK (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 09:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732959AbgDNNu5 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 09:50:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9646C061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 06:50:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z6so14059426wml.2
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XR6wXNItEYNWu6o1RZxk9MH20aHAx2gBzummh9jAxy4=;
        b=ZrpzyggDbOUgs2Vgs3Y6ZtNLBDX/4xYt+cQgeSVGNVIDl/di2F5DvK8yArZ92Z4MQQ
         cGGXfCSSQvk+GXf6GXxu4B6N63LxxmRg9KgQ2O08nEz4ThJbIRf/VqXwKgtFKp2zhWrk
         f0sV1TzSB0zu57pnSjWxQh+hchbAXt/6fsuAP9iI+6qPgJNqiLZGkJLztyDHiW3dqNI/
         NyCXODjBwwzNFcdv59tOT/4PQOr0wIKEk4XISFv2o1i4cjdwDNny0w4HVet4dkAnpWqQ
         RcOQ7w5emujykLdANHBPsDtIreQUkkeA/V3hUrr5irJPkZpCXGlO4Ed3WeMMpv/mJXyG
         26cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XR6wXNItEYNWu6o1RZxk9MH20aHAx2gBzummh9jAxy4=;
        b=b5uSJnqMYXy+AcFOS1B9O2zpVhFsAvLTDcFaVwIzrO0QSGW7e5dpIW1e4A+x1xsMsU
         FBPga+Sio5Y0VBKw+TlOPqvk0kglo4UlEEFQldXpXd7RXuVL2hFVuwgdvW+QL3lthqGO
         4VUwo/1qmBM6JIPvGa05Pd/7Z+CTO3zQoO1sfb4aLz4CJl01HBETeuVt/W5SuaEIC4cU
         a+BfXWV1flAEd6OfPLDyKumfqkOH65Pwp7U+Sa73I5hC6122vp9X0iNThZlGD5Xw0y5b
         I3e9ekaNHQjCP2i5lBkvntxqLGK4X3yZKeqMmPpIfvTYuE9ZH1UdATzlQC4vMb+xlPj5
         hacA==
X-Gm-Message-State: AGi0PuaRgFR5oC5EGAe4hr+H7LI/Ld1r7FffVS9xkbhgETcddtdRIcqC
        7YyWKkWkhcjxveelhykivIANO5gIaFWIMo4A2ao=
X-Google-Smtp-Source: APiQypJ/MIb8WScQ8OMCaoQIIUZSWESIr/e/wptylz7IRNlW+x9Eqtr/+JcBFI1U3aLByWYhQA7DCphcxSKw3tp3EQI=
X-Received: by 2002:a1c:9a87:: with SMTP id c129mr22431150wme.149.1586872255522;
 Tue, 14 Apr 2020 06:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org> <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org> <20200414122015.GR3456981@phenom.ffwll.local>
 <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com>
 <CAKMK7uEs5QvUrxKcTFksO30D+x=XJnV+_TA-ebawcihtLqDG0Q@mail.gmail.com>
 <CAOWid-fwEOk+4CvUAumo=byWpq4vVUoCiwW1N6F-0aEd6G7d4A@mail.gmail.com> <CAKMK7uHwX9NbGb1ptnP=CAwxDayfM_z9kvFMMb=YiH+ynjNqKQ@mail.gmail.com>
In-Reply-To: <CAKMK7uHwX9NbGb1ptnP=CAwxDayfM_z9kvFMMb=YiH+ynjNqKQ@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 14 Apr 2020 09:50:44 -0400
Message-ID: <CAOWid-dJckd8kV57MKNA_W83SN4OHnOGPURL7oOm-SqoYRLX=w@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Tejun Heo <tj@kernel.org>, Kenny Ho <Kenny.Ho@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>, jsparks@cray.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        cgroups@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Daniel,

I appreciate many of your review so far and I much prefer keeping
things technical but that is very difficult to do when I get Intel
developers calling my implementation "most AMD-specific solution
possible" and objecting to an implementation because their hardware
cannot support it.  Can you help me with a more charitable
interpretation of what has been happening?

Perhaps the following questions can help keep the discussion technical:
1)  Is it possible to implement non-work-conserving distribution of
GPU without spatial sharing?  (If yes, I'd love to hear a suggestion,
if not...question 2.)
2)  If spatial sharing is required to support GPU HPC use cases, what
would you implement if you have the hardware support today?

Regards,
Kenny

On Tue, Apr 14, 2020 at 9:26 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Apr 14, 2020 at 3:14 PM Kenny Ho <y2kenny@gmail.com> wrote:
> >
> > Ok.  I was hoping you can clarify the contradiction between the
> > existance of the spec below and your "not something any other gpu can
> > reasonably support" statement.  I mean, OneAPI is Intel's spec and
> > doesn't that at least make SubDevice support "reasonable" for one more
> > vendor?
> >
> > Partisanship aside, as a drm co-maintainer, do you really not see the
> > need for non-work-conserving way of distributing GPU as a resource?
> > You recognized the latencies involved (although that's really just
> > part of the story... time sharing is never going to be good enough
> > even if your switching cost is zero.)  As a drm co-maintainer, are you
> > suggesting GPU has no place in the HPC use case?
>
>  So I did chat with people and my understanding for how this subdevice
> stuff works is roughly, from least to most fine grained support:
> - Not possible at all, hw doesn't have any such support
> - The hw is actually not a single gpu, but a bunch of chips behind a
> magic bridge/interconnect, and there's a scheduler load-balancing
> stuff and you can't actually run on all "cores" in parallel with one
> compute/3d job. So subdevices just give you some of these cores, but
> from client api pov they're exactly as powerful as the full device. So
> this kinda works like assigning an entire NUMA node, including all the
> cpu cores and memory bandwidth and everything.
> - Hw has multiple "engines" which share resources (like compute cores
> or whatever) behind the scenes. There's no control over how this
> sharing works really, and whether you have guarantees about minimal
> execution resources or not. This kinda works like hyperthreading.
> - Then finally we have the CU mask thing amdgpu has. Which works like
> what you're proposing, works on amd.
>
> So this isn't something that I think we should standardize in a
> resource management framework like cgroups. Because it's a complete
> mess. Note that _all_ the above things (including the "no subdevices"
> one) are valid implementations of "subdevices" in the various specs.
>
> Now on your question on "why was this added to various standards?"
> because opencl has that too (and the rocm thing, and everything else
> it seems). What I heard is that a few people pushed really hard, and
> no one objected hard enough (because not having subdevices is a
> standards compliant implementation), so that's why it happened. Just
> because it's in various standards doesn't mean that a) it's actually
> standardized in a useful fashion and b) something we should just
> blindly adopt.
>
> Also like where exactly did you understand that I'm against gpus in
> HPC uses cases. Approaching this in a slightly less tribal way would
> really, really help to get something landed (which I'd like to see
> happen, personally). Always spinning this as an Intel vs AMD thing
> like you do here with every reply really doesn't help moving this in.
>
> So yeah stricter isolation is something customers want, it's just not
> something we can really give out right now at a level below the
> device.
> -Daniel
>
> >
> > Regards,
> > Kenny
> >
> > On Tue, Apr 14, 2020 at 8:52 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > On Tue, Apr 14, 2020 at 2:47 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > > > On Tue, Apr 14, 2020 at 8:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > My understanding from talking with a few other folks is that
> > > > > the cpumask-style CU-weight thing is not something any other gpu can
> > > > > reasonably support (and we have about 6+ of those in-tree)
> > > >
> > > > How does Intel plan to support the SubDevice API as described in your
> > > > own spec here:
> > > > https://spec.oneapi.com/versions/0.7/oneL0/core/INTRO.html#subdevice-support
> > >
> > > I can't talk about whether future products might or might not support
> > > stuff and in what form exactly they might support stuff or not support
> > > stuff. Or why exactly that's even in the spec there or not.
> > >
> > > Geez
> > > -Daniel
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
