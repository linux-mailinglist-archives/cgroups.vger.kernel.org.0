Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E45FA573CB
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 23:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFZVlT (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 17:41:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37559 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfFZVlS (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 17:41:18 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so5102600eds.4
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 14:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gxVUCi4cNIK8bwVHvMcAgASe/+ccVSCoBq9NMRB61Mw=;
        b=h+8lN/rQYnO10W7RmdPtkHkpAXpunaUPN9dEIgXHubHo1zltMfEweJxmfm6UMfuYkz
         EXZ48o1XIJkxRxrW4TZz9TwoL0986i8y6HNsgZxdYahqZr/J4BPtskpEoxLLTBuELhzd
         votgoHKnKWBY4qkFbkFJL7OzTPx8Gmk1TGqQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gxVUCi4cNIK8bwVHvMcAgASe/+ccVSCoBq9NMRB61Mw=;
        b=OcoYR6+Dmq5UYJ86/bEjyEpKY0bp/Bi77J+6qKkIITE+g4jHOWE2YJndZRcRNQexhY
         VDtv/Kim4ltbcdSXkS25SVEC4i2dokA6x4914g681MRlpZB0u9gPWQc83fZHbvsInbZ9
         O7454vHe86mT57L1Kiw7FdVqS2PI2PC/oBK2iisE+jpg7X843P6bMxuniIsjw+hw/2OS
         lAy7as2lwWrkrpmtzQInkWPBt/id2cAMnUrFROxfQ/EDIBDDjR/+68nC693YVaAi9XMO
         OLueM8AZsH9TXfbvI5k7vx0iRz7lx1xKg+kRrTM87hOF4BaFysYCQkcFRzUOBNd6ILr3
         bc6A==
X-Gm-Message-State: APjAAAUuMPJlht295fp3egyNFxUSB7Bp3cENl8SU2bAKm3qkLnd283M0
        wHNcDWRSc8JuEDeVCkKTuayG6g==
X-Google-Smtp-Source: APXvYqwC9y3uxGi4hcve/LEFrwv5G7OPGP24WoM1kPVU1uUlzsXbzQLuCbE6lXWG093TecocBN8cvw==
X-Received: by 2002:a17:906:3098:: with SMTP id 24mr8444ejv.106.1561585276304;
        Wed, 26 Jun 2019 14:41:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id o22sm44390edc.37.2019.06.26.14.41.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:41:15 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:41:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer
 allocation limit
Message-ID: <20190626214113.GA12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local>
 <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 05:27:48PM -0400, Kenny Ho wrote:
> On Wed, Jun 26, 2019 at 12:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > > drm.buffer.default
> > >         A read-only flat-keyed file which exists on the root cgroup.
> > >         Each entry is keyed by the drm device's major:minor.
> > >
> > >         Default limits on the total GEM buffer allocation in bytes.
> >
> > Don't we need a "0 means no limit" semantics here?
> 
> I believe the convention is to use the 'max' keyword.
> 
> >
> > I think we need a new drm-cgroup.rst which contains all this
> > documentation.
> 
> Yes I planned to do that when things are more finalized.  I am
> actually writing the commit message following the current doc format
> so I can reuse it in the rst.

Awesome.

> > With multiple GPUs, do we need an overall GEM bo limit, across all gpus?
> > For other stuff later on like vram/tt/... and all that it needs to be
> > per-device, but I think one overall limit could be useful.
> 
> This one I am not sure but should be fairly straightforward to add.
> I'd love to hear more feedbacks on this as well.
> 
> > >       if (!amdgpu_bo_validate_size(adev, size, bp->domain))
> > >               return -ENOMEM;
> > >
> > > +     if (!drmcgrp_bo_can_allocate(current, adev->ddev, size))
> > > +             return -ENOMEM;
> >
> > So what happens when you start a lot of threads all at the same time,
> > allocating gem bo? Also would be nice if we could roll out at least the
> > accounting part of this cgroup to all GEM drivers.
> 
> When there is a large number of allocation, the allocation will be
> checked in sequence within a device (since I used a per device mutex
> in the check.)  Are you suggesting the overhead here is significant
> enough to be a bottleneck?  The accounting part should be available to
> all GEM drivers (unless I missed something) since the chg and unchg
> function is called via the generic drm_gem_private_object_init and
> drm_gem_object_release.

thread 1: checks limits, still under the total

thread 2: checks limits, still under the total

thread 1: allocates, still under

thread 2: allocates, now over the limit

I think the check and chg need to be one step, or this wont work. Or I'm
missing something somewhere.

Wrt rolling out the accounting for all drivers: Since you also roll out
enforcement in this patch I'm not sure whether the accounting part is
fully stand-alone. And as discussed a bit on an earlier patch, I think for
DRIVER_GEM we should set up the accounting cgroup automatically.

> > > +     /* only allow bo from the same cgroup or its ancestor to be imported */
> > > +     if (drmcgrp != NULL &&
> >
> > Quite a serious limitation here ...
> >
> > > +                     !drmcgrp_is_self_or_ancestor(drmcgrp, obj->drmcgrp)) {
> >
> > Also what happens if you actually share across devices? Then importing in
> > the 2nd group is suddenly possible, and I think will be double-counted.
> >
> > What's the underlying technical reason for not allowing sharing across
> > cgroups?
> 
> With the current implementation, there shouldn't be double counting as
> the counting is done during the buffer init.

If you share across devices there will be two drm_gem_obect structures, on
on each device. But only one underlying bo.

Now the bo limit is per-device too, so that's all fine, but for a global
bo limit we'd need to make sure we count these only once.

> To be clear, sharing across cgroup is allowed, the buffer just needs
> to be allocated by a process that is parent to the cgroup.  So in the
> case of xorg allocating buffer for client, the xorg would be in the
> root cgroup and the buffer can be passed around by different clients
> (in root or other cgroup.)  The idea here is to establish some form of
> ownership, otherwise there wouldn't be a way to account for or limit
> the usage.

But why? What's the problem if I allocate something and then hand it to
someone else. E.g. one popular use of cgroups is to isolate clients, so
maybe you'd do a cgroup + namespace for each X11 client (ok wayland, with
X11 this is probably pointless).

But with your current limitation those clients can't pass buffers to the
compositor anymore, making cgroups useless. Your example here only works
if Xorg is in the root and allocates all the buffers. That's not even true
for DRI3 anymore.

So pretty serious limitation on cgroups, and I'm not really understanding
why we need this. I think if we want to prevent buffer sharing, what we
need are some selinux hooks and stuff so you can prevent an import/access
by someone who's not allowed to touch a buffer. But that kind of access
right management should be separate from resource control imo.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
