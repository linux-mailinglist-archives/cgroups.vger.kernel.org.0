Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB74573F4
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 23:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfFZV6d (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 17:58:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43513 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfFZV6d (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 17:58:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so47144wru.10
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 14:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PjJc1xqUwMoNZYdPXiJ0bqpqYxBHZbKMocYaShEMxpI=;
        b=OA3/ZVhuHJ9kRK9Stp7sRbUcoaTnEMC017hzleupit9TgdCjqEGbpvGvamDUeltYp6
         PeHuF3Y/yDmQkNngbC+0I2p2uwh9vROctSvIMUvQa/+g1JLjN2xnhGY15OaJchd+pv+4
         csudVRk5Yko2o7YO/l0JRr1RTyd4+Nzq2/S4v9ZEm6vCmV29c2brFaT0CDshnpBH9sET
         0uphoEx3wEejmLnooM5W8I64ouY0j6G35lmlsNB3EJr7O2sy/5OH7c5Wk95/b786szbA
         fQh8r92kHja8sUQymPsp6dRcR75P0zSJRiq6FjEtL/Nw3Xu2laK4FbKlEEN91Kg0Stqz
         ELDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PjJc1xqUwMoNZYdPXiJ0bqpqYxBHZbKMocYaShEMxpI=;
        b=Dbkr1gzC1ln5O3Oc7GfqEUEoJJX4YpyGMdehwR/IFeqx8RoRzoeSL78LmE27HffW9z
         EUFplBuGFjXoj4ud58e/+yzcNB6WGufoxwma3mRlTl8kWQObsvsdFJqmtRsG7PlkoP1r
         /sWac+HEClo2+QiRJo7ILmvMKrIwzfvOSN6PzBnBfYYArR7ulEu/kN5FNNt2o4bnGsTI
         XSUrY5sbf9jMdE6aTcH8fQ+pS+Q/q7+jZuERAOOTRJWIBypo1mz8BPPPhYwmE0khZGu7
         jWAg+qtNsGZoOdw6Ykt87OP++mOY8rSNK2vet3DZ1hJrToZ2bLjg+COuJDk14rjEP3Aq
         2loQ==
X-Gm-Message-State: APjAAAV8MzZZDBMncN8W0lEOdt+vrOBZyRtuMC1T9q9MZtzH4M9exIOM
        URYpQh7fovObWUrGyOcmeSMWW6eptIKNTwEFbmo=
X-Google-Smtp-Source: APXvYqzs7wbJwwppIXTwNkzk/UwxEdAf3XwQVn7RYgtTFOe+H1Sebsu/ctx6nCfRzL3pcBdQ5SU7sy9PF7qvGjsH38k=
X-Received: by 2002:adf:e442:: with SMTP id t2mr36340wrm.286.1561586311171;
 Wed, 26 Jun 2019 14:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-3-Kenny.Ho@amd.com>
 <20190626155605.GQ12905@phenom.ffwll.local> <CAOWid-cDopwjMns+c=fRpUA-z51zU=YbDC2QCVUXDjjTiyRcXw@mail.gmail.com>
 <CAKMK7uERvn7Ed2trGQShM94Ozp6+x8bsULFyGj9CYWstuzb56A@mail.gmail.com>
In-Reply-To: <CAKMK7uERvn7Ed2trGQShM94Ozp6+x8bsULFyGj9CYWstuzb56A@mail.gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 26 Jun 2019 17:58:19 -0400
Message-ID: <CAOWid-eeVcsb-rJfY9rxM4vDqGz=3XcZH0G=Qz9sq97L-NduCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/11] cgroup: Add mechanism to register DRM devices
To:     Daniel Vetter <daniel@ffwll.ch>
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

On Wed, Jun 26, 2019 at 5:04 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jun 26, 2019 at 10:37 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > (sending again, I keep missing the reply-all in gmail.)
> You can make it the default somewhere in the gmail options.
Um... interesting, my option was actually not set (neither reply or reply-all.)

> > On Wed, Jun 26, 2019 at 11:56 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > Why the separate, explicit registration step? I think a simpler design for
> > > drivers would be that we set up cgroups if there's anything to be
> > > controlled, and then for GEM drivers the basic GEM stuff would be set up
> > > automically (there's really no reason not to I think).
> >
> > Is this what you mean with the comment about drm_dev_register below?
> > I think I understand what you are saying but not super clear.  Are you
> > suggesting the use of driver feature bits (drm_core_check_feature,
> > etc.) similar to the way Brian Welty did in his proposal in May?
>
> Also not exactly a fan of driver feature bits tbh. What I had in mind was:
>
> - For stuff like the GEM accounting which we can do for all drivers
> easily (we can't do the enforcment, that needs a few changes), just
> roll it out for everyone. I.e. if you enable the DRMCG Kconfig, all
> DRIVER_GEM would get that basic gem cgroup accounting.
>
> - for other bits the driver just registers certain things, like "I can
> enforce gem limits" or "I have gpu memory regions vram, tt, and system
> and can enforce them" in their normal driver setup. Then at
> drm_dev_register time we register all these additional cgroups, like
> we today register all the other interafaces and pieces of a drm_device
> (drm_minor, drm_connectors, debugfs files, sysfs stuff, all these
> things).
>
> Since the concepts are still a bit in flux, let's take an example from
> the modeset side:
> - driver call drm_connector_init() to create connector object
> - drm_dev_register() also sets up all the public interfaces for that
> connector (debugfs, sysfs, ...)
>
> I think a similar setup would be good for cgroups here, you just
> register your special ttm_mem_reg or whatever, and the magic happens
> automatically.

Ok, I will look into those (I am not too familiar about those at this point.)

> > > I have no idea, but is this guaranteed to get them all?
> >
> > I believe so, base on my understanding about
> > css_for_each_descendant_pre and how I am starting from the root
> > cgroup.  Hopefully I didn't miss anything.
>
> Well it's rcu, so I expect it'll race with concurrent
> addition/removal. And the kerneldoc has some complicated sounding
> comments about how to synchronize that with some locks that I don't
> fully understand, but I think you're also not having any additional
> locking so not sure this all works correctly ...
>
> Do we still need the init_dmcgrp stuff if we'd just embedd? That would
> probably be the simplest way to solve this all :-)

I will need to dig into it a bit more to know for sure.  I think I
still need the init_drmcgrp stuff. I implemented it like this because
the cgroup subsystem appear to be initialized before the drm subsystem
so the root cgroup does not know any drm devices and the per device
default limits are not set.  In theory, I should only need to set the
root cgroup (so I don't need to use css_for_each_descendant_pre, which
requires the rcu_lock.)  But I am not 100% confident there won't be
any additional cgroup being added to the hierarchy between cgroup
subsystem init and drm subsystem init.

Alternatively I can protect it with an additional mutex but I am not
sure if that's needed.

Regards,
Kenny
