Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5912A572A4
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 22:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfFZUho (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 16:37:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46809 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZUho (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 16:37:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so4220719wrw.13
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 13:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PoKojTv4DP1CTaPk4hl31T1ZiHUB+yaY0GHfGPmG7PM=;
        b=eUqmKVHgMpukYvvbovqdh1LhXRpdrgqpQKey28jlQCM+Z2NyKA/h27OpNMKUxV6bYV
         5BX8neOV3Bed+Va0CkiQNd8/4a2FU5bIPkS2HLD8lmbJRZAlAdnU5nbCHNPmSw/+pch2
         AbPIIiiK+qSWrkNz7jfKIZv5FX/Yzoz63Uam7VUJtTjKCm/iKPYKzNEPGKvI5EjBHXb8
         vQ9Ub1oczsHWAS2GDPptvCvvWA5kaivBOQrZ2jPY4H7CUedY352otYLsf0cbTAuqcEgx
         3jqkv84tdl7nSmo5Ez2hl1q8jt5RnBv1CMU9ZCsBS6NQ5yfdIXHOilRrGNQ0dJxTx2VM
         Nw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PoKojTv4DP1CTaPk4hl31T1ZiHUB+yaY0GHfGPmG7PM=;
        b=o9iFyfyBKewTYKd99HfPA1MMRx+xUHkBTD3XiK/0Kdl0x4290XbFK1tBIJtw7aqLGK
         Suruhq+kmZfL9tiEW6H+N8m0VjHLeO1u29D1U1fFY5k8RYaVQY19yZGTBTT2iqtXWgXX
         jSJkIafYGe0vk7v3L3AXBiQZ0iqKFHz7nUUiZuFj4bxIKSAbsrVUCmDFMTZ+3ilrFZMM
         s+czvvzZ4y+zC4rHmB5xJgdZ4FYTTchjWrI7fn8Q1PbBrsYrMtAImQMn27/rkmww0sU4
         RASMNr2FIIvFmC7UppOvnCPKd2FYJh5bNjd2AWS2A7gogAB0hhleyAFD4BuDW++mOtes
         x+VA==
X-Gm-Message-State: APjAAAV3r4JgioduTcSYQor4QdbasocF6SCnBYIlIBUZSMjLYEBJ+gu2
        7z7cEYE6o1M6P3c92zCvnJr4AvMJRAwE3Bm6rJw=
X-Google-Smtp-Source: APXvYqwtqlEbO8+EMh/ywP0aoBCzVSiuqXGkS4Jdu/wv5ptIaGrtHk2EKqYsmvsmVqAnmd6ZpSYApKlu1XeSlNhqCKo=
X-Received: by 2002:adf:e9c6:: with SMTP id l6mr5384686wrn.216.1561581462095;
 Wed, 26 Jun 2019 13:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-3-Kenny.Ho@amd.com>
 <20190626155605.GQ12905@phenom.ffwll.local>
In-Reply-To: <20190626155605.GQ12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 26 Jun 2019 16:37:30 -0400
Message-ID: <CAOWid-cDopwjMns+c=fRpUA-z51zU=YbDC2QCVUXDjjTiyRcXw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/11] cgroup: Add mechanism to register DRM devices
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

(sending again, I keep missing the reply-all in gmail.)

On Wed, Jun 26, 2019 at 11:56 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Why the separate, explicit registration step? I think a simpler design for
> drivers would be that we set up cgroups if there's anything to be
> controlled, and then for GEM drivers the basic GEM stuff would be set up
> automically (there's really no reason not to I think).

Is this what you mean with the comment about drm_dev_register below?
I think I understand what you are saying but not super clear.  Are you
suggesting the use of driver feature bits (drm_core_check_feature,
etc.) similar to the way Brian Welty did in his proposal in May?

> Also tying to the minor is a bit funky, since we have multiple of these.
> Need to make sure were at least consistent with whether we use the primary
> or render minor - I'd always go with the primary one like you do here.

Um... come to think of it, I can probably embed struct drmcgrp_device
into drm_device and that way I don't really need to keep a separate
array of
known_drmcgrp_devs and get rid of that max_minor thing.  Not sure why
I didn't think of this before.

> > +
> > +int drmcgrp_register_device(struct drm_device *dev)
>
> Imo this should be done as part of drm_dev_register (maybe only if the
> driver has set up a controller or something). Definitely with the
> unregister logic below. Also anything used by drivers needs kerneldoc.
>
>
> > +     /* init cgroups created before registration (i.e. root cgroup) */
> > +     if (root_drmcgrp != NULL) {
> > +             struct cgroup_subsys_state *pos;
> > +             struct drmcgrp *child;
> > +
> > +             rcu_read_lock();
> > +             css_for_each_descendant_pre(pos, &root_drmcgrp->css) {
> > +                     child = css_drmcgrp(pos);
> > +                     init_drmcgrp(child, dev);
> > +             }
> > +             rcu_read_unlock();
>
> I have no idea, but is this guaranteed to get them all?

I believe so, base on my understanding about
css_for_each_descendant_pre and how I am starting from the root
cgroup.  Hopefully I didn't miss anything.

Regards,
Kenny
