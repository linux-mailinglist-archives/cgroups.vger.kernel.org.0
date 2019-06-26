Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFB55747E
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfFZWlq (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 18:41:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33165 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfFZWlq (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 18:41:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id h19so5666568wme.0
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oEk9c6rcfgsFV1f3BugDwH4/J+lL0d5bXa7gtOdSJTE=;
        b=VmI1bH04pNkd0CL5IkpERmOB+KURGmjrJCw/yvxG1slphXockhe1xg7/fWITeobzUp
         6OuUWf77dPWZZWR2qV96C8CTB52YI8vDlpzkSb6RGFnLjJDGnahi8tjDHyfddX8gFO81
         mbSSIKjQ1WOsJfJsMz+bdcnd1+TjZTQA9PqPjYTmXUlfRpXHtR3IKtMR09bylFCn/Boz
         5ZhAC2rYt94rI22H7oBxtVbIKCHdG0CjGrecFaSMqWkquOi/+XDo0az/jakV8tZdP5Xc
         irqad9L4gXHQ8DB+y/oi2xkxpfy7uhmIIwlkHK1tbjyzcKlLlohw9iY7+gXpAWsbSLzP
         +IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oEk9c6rcfgsFV1f3BugDwH4/J+lL0d5bXa7gtOdSJTE=;
        b=TFcBEJb0Y3tlC82BipqcrafyoDB0ZqQU0Bvdi1Wr2Sexgqz82cfriSMNLHyABx3WsA
         oZjHNK793NbQ2iKL6nsAqfoMUh6Rry85CejQoS1vAHhoHJe5sXt9jN6egMcwsffnSuWr
         +Roxppik/gXkqNe++PYcZOBp9bUoGAKXPyFa+k94ZB8/R951D5Mh1ej/CRSQ+fB2IQdz
         2UriLP9Be1DxzgXM/EDdZ5eP4osOdjcGCi6BpwK342l3baqqdAA6/Quek48WPk39cI/d
         mgRv9maRiekQu4AXOpySvfMG9hJwCGKM26dyvlINpAonOEWxmm3u4t8fZ77v1/tKj3TD
         Ne1A==
X-Gm-Message-State: APjAAAVjtvmgC2H0vWo/ZWKdIh2YTZXQ8SthUhNwDyp2CDsW5suhD/Q8
        m7nqdzTa/nI62sO5McK/Gx/aSLBk+Vr/0RoSGoQ=
X-Google-Smtp-Source: APXvYqzmoXHdPYuv6s+EduQlkuq28YQYlzr1RnQXDGSO1WmcfjRXBcHwYylw0kaQFIOirmE2It3/XbYGpg63X6nuwMI=
X-Received: by 2002:a1c:9c8a:: with SMTP id f132mr722267wme.29.1561588903724;
 Wed, 26 Jun 2019 15:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local> <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
 <20190626214113.GA12905@phenom.ffwll.local>
In-Reply-To: <20190626214113.GA12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 26 Jun 2019 18:41:32 -0400
Message-ID: <CAOWid-egYGijS0a6uuG4mPUmOWaPwF-EKokR=LFNJ=5M+akVZw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer allocation limit
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

On Wed, Jun 26, 2019 at 5:41 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jun 26, 2019 at 05:27:48PM -0400, Kenny Ho wrote:
> > On Wed, Jun 26, 2019 at 12:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > So what happens when you start a lot of threads all at the same time,
> > > allocating gem bo? Also would be nice if we could roll out at least the
> > > accounting part of this cgroup to all GEM drivers.
> >
> > When there is a large number of allocation, the allocation will be
> > checked in sequence within a device (since I used a per device mutex
> > in the check.)  Are you suggesting the overhead here is significant
> > enough to be a bottleneck?  The accounting part should be available to
> > all GEM drivers (unless I missed something) since the chg and unchg
> > function is called via the generic drm_gem_private_object_init and
> > drm_gem_object_release.
>
> thread 1: checks limits, still under the total
>
> thread 2: checks limits, still under the total
>
> thread 1: allocates, still under
>
> thread 2: allocates, now over the limit
>
> I think the check and chg need to be one step, or this wont work. Or I'm
> missing something somewhere.

Ok, I see what you are saying.

> Wrt rolling out the accounting for all drivers: Since you also roll out
> enforcement in this patch I'm not sure whether the accounting part is
> fully stand-alone. And as discussed a bit on an earlier patch, I think for
> DRIVER_GEM we should set up the accounting cgroup automatically.
I think I should be able to split the commit and restructure things a bit.

> > > What's the underlying technical reason for not allowing sharing across
> > > cgroups?
> > To be clear, sharing across cgroup is allowed, the buffer just needs
> > to be allocated by a process that is parent to the cgroup.  So in the
> > case of xorg allocating buffer for client, the xorg would be in the
> > root cgroup and the buffer can be passed around by different clients
> > (in root or other cgroup.)  The idea here is to establish some form of
> > ownership, otherwise there wouldn't be a way to account for or limit
> > the usage.
>
> But why? What's the problem if I allocate something and then hand it to
> someone else. E.g. one popular use of cgroups is to isolate clients, so
> maybe you'd do a cgroup + namespace for each X11 client (ok wayland, with
> X11 this is probably pointless).
>
> But with your current limitation those clients can't pass buffers to the
> compositor anymore, making cgroups useless. Your example here only works
> if Xorg is in the root and allocates all the buffers. That's not even true
> for DRI3 anymore.
>
> So pretty serious limitation on cgroups, and I'm not really understanding
> why we need this. I think if we want to prevent buffer sharing, what we
> need are some selinux hooks and stuff so you can prevent an import/access
> by someone who's not allowed to touch a buffer. But that kind of access
> right management should be separate from resource control imo.
So without the sharing restriction and some kind of ownership
structure, we will have to migrate/change the owner of the buffer when
the cgroup that created the buffer die before the receiving cgroup(s)
and I am not sure how to do that properly at the moment.  1) Should
each cgroup keep track of all the buffers that belongs to it and
migrate?  (Is that efficient?)  2) which cgroup should be the new
owner (and therefore have the limit applied?)  Having the creator
being the owner is kind of natural, but let say the buffer is shared
with 5 other cgroups, which of these 5 cgroups should be the new owner
of the buffer?

Regards,
Kenny
