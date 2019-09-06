Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB6EABC92
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 17:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394866AbfIFPe3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 11:34:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46511 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392617AbfIFPe3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 11:34:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id g19so6057964otg.13
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 08:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ppR1ejIdmoMdmFzd4J4iqjNlUMz11jQtEfCtpdCs14=;
        b=juPmQ+LQdXBdT5tkqV2d42QW/0LRBUdLFInrxu2rWNhVEmId21obgUqGIaEVV4uPHr
         G5I15+usAam2qHyOyCGFfxYjKdPCcbt2DpErbrbZuX/Fey6enud2MqL80io2Cui26RRN
         lIfojzvv9XUAAauZXVCOQ4/82iGROH5CefF+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ppR1ejIdmoMdmFzd4J4iqjNlUMz11jQtEfCtpdCs14=;
        b=PQpv5jQedZFgv155NwUFbbidd8fRj1vkAKdehJ1jBput1MC/0dC900+4WOrj66dghh
         qgwmSYjB0mdP4XmT6x50dYjdhn5lC+vVfnRDdQVGo+d8/6meCyzOyYHpr7qoMlEnyjxo
         YIgqLdkCM6rqQYc9DzKEA+BPYUCQDjUe8W2MqwMDlcRsNGZpP3lHaP4vwOZXsl+5m/Hg
         gWfHBqVXgY1YrLs0zwV5nWYmcuCl6o0J6ikPO5OFBAT1/QyIwGWAwzN8a0KGfBgox6ht
         lhM846mXfQ3qPNdscHCGus/RErEslqZ+wIZ4CiqmHJis9NsZYjSeSCOUe/GgjSbdCB9a
         VzXA==
X-Gm-Message-State: APjAAAUg8yE2DlB+aNv0CjURCBknMrAXd//xkVOQfRzzOQ4RV3+Ek6qo
        YU75P46XToq8pgk4whEaWllGfxbVg//EWn6/jl6A9w==
X-Google-Smtp-Source: APXvYqzrVl01DWJ0e00i6mKoGRVZcWS0BQamdh0dU9O2bqE7YzwptXaJDkkPtaaKA7+E0aoIa5tWx2bUt3jIVPemnD0=
X-Received: by 2002:a05:6830:1594:: with SMTP id i20mr8167134otr.188.1567784067543;
 Fri, 06 Sep 2019 08:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190831042857.GD2263813@devbig004.ftw2.facebook.com>
 <20190903075550.GJ2112@phenom.ffwll.local> <20190903185013.GI2263813@devbig004.ftw2.facebook.com>
 <CAKMK7uE5Bj-3cJH895iqnLpwUV+GBDM1Y=n4Z4A3xervMdJKXg@mail.gmail.com> <20190906152320.GM2263813@devbig004.ftw2.facebook.com>
In-Reply-To: <20190906152320.GM2263813@devbig004.ftw2.facebook.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 6 Sep 2019 17:34:16 +0200
Message-ID: <CAKMK7uEXP7XLFB2aFU6+E0TH_DepFRkfCoKoHwkXtjZRDyhHig@mail.gmail.com>
Subject: Re: [PATCH RFC v4 00/16] new cgroup controller for gpu/drm subsystem
To:     Tejun Heo <tj@kernel.org>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, Kenny Ho <y2kenny@gmail.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Sep 6, 2019 at 5:23 PM Tejun Heo <tj@kernel.org> wrote:
>
> Hello, Daniel.
>
> On Tue, Sep 03, 2019 at 09:48:22PM +0200, Daniel Vetter wrote:
> > I think system memory separate from vram makes sense. For one, vram is
> > like 10x+ faster than system memory, so we definitely want to have
> > good control on that. But maybe we only want one vram bucket overall
> > for the entire system?
> >
> > The trouble with system memory is that gpu tasks pin that memory to
> > prep execution. There's two solutions:
> > - i915 has a shrinker. Lots (and I really mean lots) of pain with
> > direct reclaim recursion, which often means we can't free memory, and
> > we're angering the oom killer a lot. Plus it introduces real bad
> > latency spikes everywhere (gpu workloads are occasionally really slow,
> > think "worse than pageout to spinning rust" to get memory freed).
> > - ttm just has a global limit, set to 50% of system memory.
> >
> > I do think a global system memory limit to tame the shrinker, without
> > the ttm approach of possible just wasting half your memory, could be
> > useful.
>
> Hmm... what'd be the fundamental difference from slab or socket memory
> which are handled through memcg?  Is system memory used by GPUs have
> further global restrictions in addition to the amount of physical
> memory used?

Sometimes, but that would be specific resources (kinda like vram),
e.g. CMA regions used by a gpu. But probably not something you'll run
in a datacenter and want cgroups for ...

I guess we could try to integrate with the memcg group controller. One
trouble is that aside from i915 most gpu drivers do not really have a
full shrinker, so not sure how that would all integrate.

The overall gpu memory controller would still be outside of memcg I
think, since that would include swapped-out gpu objects, and stuff in
special memory regions like vram.

> > I'm also not sure of the bw limits, given all the fun we have on the
> > block io cgroups side. Aside from that the current bw limit only
> > controls the bw the kernel uses, userspace can submit unlimited
> > amounts of copying commands that use the same pcie links directly to
> > the gpu, bypassing this cg knob. Also, controlling execution time for
> > gpus is very tricky, since they work a lot more like a block io device
> > or maybe a network controller with packet scheduling, than a cpu.
>
> At the system level, it just gets folded into cpu time, which isn't
> perfect but is usually a good enough approximation of compute related
> dynamic resources.  Can gpu do someting similar or at least start with
> that?

So generally there's a pile of engines, often of different type (e.g.
amd hw has an entire pile of copy engines), with some ill-defined
sharing charateristics for some (often compute/render engines use the
same shader cores underneath), kinda like hyperthreading. So at that
detail it's all extremely hw specific, and probably too hard to
control in a useful way for users. And I'm not sure we can really do a
reasonable knob for overall gpu usage, e.g. if we include all the copy
engines, but the workloads are only running on compute engines, then
you might only get 10% overall utilization by engine-time. While the
shaders (which is most of the chip area/power consumption) are
actually at 100%. On top, with many userspace apis those engines are
an internal implementation detail of a more abstract gpu device (e.g.
opengl), but with others, this is all fully exposed (like vulkan).

Plus the kernel needs to use at least copy engines for vram management
itself, and you really can't take that away. Although Kenny here has
some proposal for a separate cgroup resource just for that.

I just think it's all a bit too ill-defined, and we might be better
off nailing the memory side first and get some real world experience
on this stuff. For context, there's not even a cross-driver standard
for how priorities are handled, that's all driver-specific interfaces.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
