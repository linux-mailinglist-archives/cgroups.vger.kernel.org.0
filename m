Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D15A757340
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 23:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZVEC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 17:04:02 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42742 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZVEB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 17:04:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id l15so3996812otn.9
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTgSwImCroOFj856c6bJv9eV5qY46L9dV95K0+Zih2Q=;
        b=UCE+WsZGunsOBF8nMXHJLfgwTPfDujf3BDyDgts1yhNw10gFaR5g1/EMEWZKRQy6a6
         VI81wvq6y7nRQ5uxKintPFtS3/NVMIlQu3reNMg3WMEMY9f4FFwUy2Lgr22jvJvGuZG+
         qlof6vkk4miibq5fDI8IVWWJr5emfHN12X/Fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTgSwImCroOFj856c6bJv9eV5qY46L9dV95K0+Zih2Q=;
        b=eIhK+8GCiLwNJ//B1bbQRWrj3Qzlsi9e18AuO22banB/P99BICNh50eQmxFrlmhB4X
         LPedjsbu35E5ojT7CPKSuKJDDbpGLO0vj5SvbwyGUTpCyTbNZxtTvHNBjQ99N7IvWQ7y
         ribZqVBygWNT8ZguLT44QM5yGuPC2VnH8yoEA8iDLN9fEIpGppDpQYkjc+rphJjxa7ew
         m8uSqAaqfegdOF13M9S4xtnQQ60Sl9NlvPpw3qzcrIi/D15YcrFvW0UFGd1KlhnB80jy
         OcwSossjx+npdugExdkA4tEO5oW0qJExi83Gxxy7+nHvnn1WmYcUPmbAT7rrGNFfY9PV
         zLXg==
X-Gm-Message-State: APjAAAX0JyIrCd1fx2/degL/x2kx+ivAeSyx4jPrpTQKZ6Z+XHuHdIAj
        O8FhmM8QLrsauj0scJ4N1hQFkx4OjJovWDUN2/mBWQ==
X-Google-Smtp-Source: APXvYqw4UC5SHZdLwBOG2SzDRa0FhoUc+zkZjiOVFNDtOGAE1f36qyXXcR9ig2SS1vvXmMMoZwnvP8V4Fgg753rQnOk=
X-Received: by 2002:a9d:6e8d:: with SMTP id a13mr244064otr.303.1561583040687;
 Wed, 26 Jun 2019 14:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-3-Kenny.Ho@amd.com>
 <20190626155605.GQ12905@phenom.ffwll.local> <CAOWid-cDopwjMns+c=fRpUA-z51zU=YbDC2QCVUXDjjTiyRcXw@mail.gmail.com>
In-Reply-To: <CAOWid-cDopwjMns+c=fRpUA-z51zU=YbDC2QCVUXDjjTiyRcXw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 26 Jun 2019 23:03:49 +0200
Message-ID: <CAKMK7uERvn7Ed2trGQShM94Ozp6+x8bsULFyGj9CYWstuzb56A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/11] cgroup: Add mechanism to register DRM devices
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 10:37 PM Kenny Ho <y2kenny@gmail.com> wrote:
> (sending again, I keep missing the reply-all in gmail.)

You can make it the default somewhere in the gmail options.

(also resending, I missed that you didn't group-replied).

On Wed, Jun 26, 2019 at 10:25 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> On Wed, Jun 26, 2019 at 11:56 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > Why the separate, explicit registration step? I think a simpler design for
> > drivers would be that we set up cgroups if there's anything to be
> > controlled, and then for GEM drivers the basic GEM stuff would be set up
> > automically (there's really no reason not to I think).
>
> Is this what you mean with the comment about drm_dev_register below?
> I think I understand what you are saying but not super clear.  Are you
> suggesting the use of driver feature bits (drm_core_check_feature,
> etc.) similar to the way Brian Welty did in his proposal in May?

Also not exactly a fan of driver feature bits tbh. What I had in mind was:

- For stuff like the GEM accounting which we can do for all drivers
easily (we can't do the enforcment, that needs a few changes), just
roll it out for everyone. I.e. if you enable the DRMCG Kconfig, all
DRIVER_GEM would get that basic gem cgroup accounting.

- for other bits the driver just registers certain things, like "I can
enforce gem limits" or "I have gpu memory regions vram, tt, and system
and can enforce them" in their normal driver setup. Then at
drm_dev_register time we register all these additional cgroups, like
we today register all the other interafaces and pieces of a drm_device
(drm_minor, drm_connectors, debugfs files, sysfs stuff, all these
things).

Since the concepts are still a bit in flux, let's take an example from
the modeset side:
- driver call drm_connector_init() to create connector object
- drm_dev_register() also sets up all the public interfaces for that
connector (debugfs, sysfs, ...)

I think a similar setup would be good for cgroups here, you just
register your special ttm_mem_reg or whatever, and the magic happens
automatically.

> > Also tying to the minor is a bit funky, since we have multiple of these.
> > Need to make sure were at least consistent with whether we use the primary
> > or render minor - I'd always go with the primary one like you do here.
>
> Um... come to think of it, I can probably embed struct drmcgrp_device
> into drm_device and that way I don't really need to keep a separate
> array of
> known_drmcgrp_devs and get rid of that max_minor thing.  Not sure why
> I didn't think of this before.

Yeah if that's possible, embedding is definitely the preferred way.
drm_device is huge already, and the per-device overhead really doesn't
matter.

> > > +
> > > +int drmcgrp_register_device(struct drm_device *dev)
> >
> > Imo this should be done as part of drm_dev_register (maybe only if the
> > driver has set up a controller or something). Definitely with the
> > unregister logic below. Also anything used by drivers needs kerneldoc.
> >
> >
> > > +     /* init cgroups created before registration (i.e. root cgroup) */
> > > +     if (root_drmcgrp != NULL) {
> > > +             struct cgroup_subsys_state *pos;
> > > +             struct drmcgrp *child;
> > > +
> > > +             rcu_read_lock();
> > > +             css_for_each_descendant_pre(pos, &root_drmcgrp->css) {
> > > +                     child = css_drmcgrp(pos);
> > > +                     init_drmcgrp(child, dev);
> > > +             }
> > > +             rcu_read_unlock();
> >
> > I have no idea, but is this guaranteed to get them all?
>
> I believe so, base on my understanding about
> css_for_each_descendant_pre and how I am starting from the root
> cgroup.  Hopefully I didn't miss anything.

Well it's rcu, so I expect it'll race with concurrent
addition/removal. And the kerneldoc has some complicated sounding
comments about how to synchronize that with some locks that I don't
fully understand, but I think you're also not having any additional
locking so not sure this all works correctly ...

Do we still need the init_dmcgrp stuff if we'd just embedd? That would
probably be the simplest way to solve this all :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
