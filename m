Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53581A809D
	for <lists+cgroups@lfdr.de>; Tue, 14 Apr 2020 17:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405521AbgDNPB1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Apr 2020 11:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405178AbgDNPBZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Apr 2020 11:01:25 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C79AC061A0C
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 08:01:25 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b13so8831824oti.3
        for <cgroups@vger.kernel.org>; Tue, 14 Apr 2020 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87uEDRgYBCTZ9ZGhNXT345rhZUziBXz/6VeMrHYuaGA=;
        b=Uo45K4TIq0I/2MTkOMo7tBXwHslmlFNCEPrwQOGU6huiC2UfFPZm8/aA9fEfDGKGPJ
         aoh+PoIHZQ7b/H4Wcg1X0FXPFh9MFmmW92cStC9UklR9JxawoMK043lyrJdNOU4lpVT0
         UDU5qR9LNOuY7628tO8avdsttXnWgVppmtnag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87uEDRgYBCTZ9ZGhNXT345rhZUziBXz/6VeMrHYuaGA=;
        b=Z+9nfjtENL9seOQooSfKvDRK1VME1hfL7rrGoytHp+odgS1nhmP+i1mkLTXv3X+TGv
         ZPjw8gjIVES9n15kE/c328Bob9HOFjLGh1FM42STq3Du+9IH2CNaNyWwyobRU0zgiXJ8
         qG9S8q5LWkII6UE0lToEDa+KtZ2hXEPN3ObBnMJ0YTE4DnsM01Dp/C8VHWjqcbc/K4p4
         UUFBXa80bM2plH14vVCs21L2InbmVmVxKMzjxMjoo1AJg9Hj+raqvL912GTcHQoYGD48
         2YtPYQFsIPhk7ZcMvoFZdI4I0mccYauz5VCSGj74No95ro8atZNQ6MKbGWGXcoW9QG46
         7k3Q==
X-Gm-Message-State: AGi0PuZNQ3c03sp8AzVp/3LWNzFiuA4vyySfk3rVMeoBdk0jfxuY0uOO
        tIudL9H3ncdrOHE4ykqTtd2phbB8kk/V3nxfD/T9gg==
X-Google-Smtp-Source: APiQypLsDckd5C3Ayxm+9gczcKu0ywgbnwPMo0nORZ4NSEMvE7h1rdKcs+sMfl8JmNGvl1EKI0yjchpM+qcVdBJqtOc=
X-Received: by 2002:a05:6830:1599:: with SMTP id i25mr9950851otr.188.1586876483890;
 Tue, 14 Apr 2020 08:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200226190152.16131-1-Kenny.Ho@amd.com> <CAOWid-eyMGZfOyfEQikwCmPnKxx6MnTm17pBvPeNpgKWi0xN-w@mail.gmail.com>
 <20200324184633.GH162390@mtj.duckdns.org> <CAOWid-cS-5YkFBLACotkZZCH0RSjHH94_r3VFH8vEPOubzSpPA@mail.gmail.com>
 <20200413191136.GI60335@mtj.duckdns.org> <20200414122015.GR3456981@phenom.ffwll.local>
 <CAOWid-f-XWyg0o3znH28xYndZ0OMzWfv3OOuWw08iJDKjrqFGA@mail.gmail.com>
 <CAKMK7uEs5QvUrxKcTFksO30D+x=XJnV+_TA-ebawcihtLqDG0Q@mail.gmail.com>
 <CAOWid-fwEOk+4CvUAumo=byWpq4vVUoCiwW1N6F-0aEd6G7d4A@mail.gmail.com>
 <CAKMK7uHwX9NbGb1ptnP=CAwxDayfM_z9kvFMMb=YiH+ynjNqKQ@mail.gmail.com>
 <CAOWid-dJckd8kV57MKNA_W83SN4OHnOGPURL7oOm-SqoYRLX=w@mail.gmail.com>
 <CAKMK7uGWxE-gDa25mi4EtLqPKZZfacm0VhTem=StHAQABRAkUQ@mail.gmail.com> <CAOWid-eaASFFdA5zLxaLO72OGsUVz_BgM-sGP2OQykXCzizmnw@mail.gmail.com>
In-Reply-To: <CAOWid-eaASFFdA5zLxaLO72OGsUVz_BgM-sGP2OQykXCzizmnw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 14 Apr 2020 17:01:12 +0200
Message-ID: <CAKMK7uFhKf+OTDccATmB7UU2DBgGjVThCkaXR09YTjjyMOUbQw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] new cgroup controller for gpu/drm subsystem
To:     Kenny Ho <y2kenny@gmail.com>
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

On Tue, Apr 14, 2020 at 4:29 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> On Tue, Apr 14, 2020 at 10:04 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > This has _nothing_ to do with Intel (I think over the past 25 years or
> > so intel has implemented all 4 versions of gpu splitting that I
> > listed, but not entirely sure).
> >
> > So again pls less tribal fighting, more collaboration. If you can't do
> > that, let's pick nouveau/nvidia as arbitrary neutral ground.
>
> So are you saying Intel has implemented a form of masking before?  I
> don't think we need to just pick a vendor as a neutral ground.  The
> idea of spatial sharing vs time sharing is not vendor specific... it's
> not even GPU specific.  This is why I asked the two questions below.
>
> > > Perhaps the following questions can help keep the discussion technical:
> > > 1)  Is it possible to implement non-work-conserving distribution of
> > > GPU without spatial sharing?  (If yes, I'd love to hear a suggestion,
> > > if not...question 2.)
> > > 2)  If spatial sharing is required to support GPU HPC use cases, what
> > > would you implement if you have the hardware support today?
> >
> > The thing we can currently do in upstream (from how I'm understanding
> > hw) is assign entire PCI devices to containers, so essentially only
> > the entire /dev/dri/* cdev. That works, and it works across all
> > drivers we have in upstream right now.
> >
> > Anything more fine-grained I don't think is currently possible,
> > because everyone has a different idea of how to split up gpus. It
> > would be nice to have it, but in upstream, cross-vendor, I'm just not
> > seeing it happen right now.
>
> I understand the reality, but what would you implement to support the
> concept (GPU in HPC, which you said you are not against) if you have
> the hw support today?  How would you support low-jitter/low-latency
> sharing of a single GPU if you have whatever hardware support you need
> today?

Whatever works on my gpu.

But there's a huge difference between what I can do for Intel, with my
Intel hat on, and ship that on some random intel-only repo or DKMS.
And what makes sense to push to upstream, because on upstream it needs
to be cross vendor and have reasonably clear semantics so that admins
understand it no matter whether you plug in an amd, nvidia or whatever
else gpu.

Yes this sucks, but as long as all the hw vendors insist on
differentiating here there's not much we can do. Maybe in the future
the VF stuff might help, but I'm not super hopeful that's actually
going to happen all that well. And the VF stuff at least works the
same way as what we currently can do already, with assigning an entire
/dev/dri/render* node to a container.

If you want more fine-grained then you (as a user) need to have
containers for amd, and different container isolation for nvidia, and
different container isolation for intel, and different container
isolation for $next_vendor, and so on. We can't just wish that there's
a standard way to manage this when there isn't. And merging
non-standard ways to split up gpus with cgroups, one for each gpu
vendor (generation maybe even?) just isn't going to work in upstream.

And really that's not a huge deal, because on the userspace side for
HPC it's the exact same sorry state of affairs, with cuda, rocm and
the oneapie effort from intel (not counting a bunch of things various
vendors tried to pull off on the soc side of things, there's even more
fun there). Standardizing the kernel management while you still need
to have different container images (these userspace generally have a
really hard time co-existing) isn't solving any real-world user
problems.

So yeah it sucks if you're a gpu compute user in some kind of server
setting :-/ And there's not really much I can do to fix this, except
tell vendors that everyone doing their own thing wont work (in
upstream, it'll work totally in all the vendor driver trees and
stacks, can't stop that).
-Daniel

> Regards,
> Kenny
>
>
> > > On Tue, Apr 14, 2020 at 9:26 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > >
> > > > On Tue, Apr 14, 2020 at 3:14 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > > > >
> > > > > Ok.  I was hoping you can clarify the contradiction between the
> > > > > existance of the spec below and your "not something any other gpu can
> > > > > reasonably support" statement.  I mean, OneAPI is Intel's spec and
> > > > > doesn't that at least make SubDevice support "reasonable" for one more
> > > > > vendor?
> > > > >
> > > > > Partisanship aside, as a drm co-maintainer, do you really not see the
> > > > > need for non-work-conserving way of distributing GPU as a resource?
> > > > > You recognized the latencies involved (although that's really just
> > > > > part of the story... time sharing is never going to be good enough
> > > > > even if your switching cost is zero.)  As a drm co-maintainer, are you
> > > > > suggesting GPU has no place in the HPC use case?
> > > >
> > > >  So I did chat with people and my understanding for how this subdevice
> > > > stuff works is roughly, from least to most fine grained support:
> > > > - Not possible at all, hw doesn't have any such support
> > > > - The hw is actually not a single gpu, but a bunch of chips behind a
> > > > magic bridge/interconnect, and there's a scheduler load-balancing
> > > > stuff and you can't actually run on all "cores" in parallel with one
> > > > compute/3d job. So subdevices just give you some of these cores, but
> > > > from client api pov they're exactly as powerful as the full device. So
> > > > this kinda works like assigning an entire NUMA node, including all the
> > > > cpu cores and memory bandwidth and everything.
> > > > - Hw has multiple "engines" which share resources (like compute cores
> > > > or whatever) behind the scenes. There's no control over how this
> > > > sharing works really, and whether you have guarantees about minimal
> > > > execution resources or not. This kinda works like hyperthreading.
> > > > - Then finally we have the CU mask thing amdgpu has. Which works like
> > > > what you're proposing, works on amd.
> > > >
> > > > So this isn't something that I think we should standardize in a
> > > > resource management framework like cgroups. Because it's a complete
> > > > mess. Note that _all_ the above things (including the "no subdevices"
> > > > one) are valid implementations of "subdevices" in the various specs.
> > > >
> > > > Now on your question on "why was this added to various standards?"
> > > > because opencl has that too (and the rocm thing, and everything else
> > > > it seems). What I heard is that a few people pushed really hard, and
> > > > no one objected hard enough (because not having subdevices is a
> > > > standards compliant implementation), so that's why it happened. Just
> > > > because it's in various standards doesn't mean that a) it's actually
> > > > standardized in a useful fashion and b) something we should just
> > > > blindly adopt.
> > > >
> > > > Also like where exactly did you understand that I'm against gpus in
> > > > HPC uses cases. Approaching this in a slightly less tribal way would
> > > > really, really help to get something landed (which I'd like to see
> > > > happen, personally). Always spinning this as an Intel vs AMD thing
> > > > like you do here with every reply really doesn't help moving this in.
> > > >
> > > > So yeah stricter isolation is something customers want, it's just not
> > > > something we can really give out right now at a level below the
> > > > device.
> > > > -Daniel
> > > >
> > > > >
> > > > > Regards,
> > > > > Kenny
> > > > >
> > > > > On Tue, Apr 14, 2020 at 8:52 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > >
> > > > > > On Tue, Apr 14, 2020 at 2:47 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > > > > > > On Tue, Apr 14, 2020 at 8:20 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > > > > My understanding from talking with a few other folks is that
> > > > > > > > the cpumask-style CU-weight thing is not something any other gpu can
> > > > > > > > reasonably support (and we have about 6+ of those in-tree)
> > > > > > >
> > > > > > > How does Intel plan to support the SubDevice API as described in your
> > > > > > > own spec here:
> > > > > > > https://spec.oneapi.com/versions/0.7/oneL0/core/INTRO.html#subdevice-support
> > > > > >
> > > > > > I can't talk about whether future products might or might not support
> > > > > > stuff and in what form exactly they might support stuff or not support
> > > > > > stuff. Or why exactly that's even in the spec there or not.
> > > > > >
> > > > > > Geez
> > > > > > -Daniel
> > > > > > --
> > > > > > Daniel Vetter
> > > > > > Software Engineer, Intel Corporation
> > > > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
