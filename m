Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D461A325
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 20:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfEJSuw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 14:50:52 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45436 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfEJSuv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 14:50:51 -0400
Received: by mail-ot1-f66.google.com with SMTP id a10so4177882otl.12
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Foxz7qrv4t3w/FL4IJaClc6QijaTM6xy9xLnPK+xt20=;
        b=OyZfn7M14VP4zvADwLc+u5sRTLBG2hYOREY/eeTqyV/6AAd6AuyhSOB3xuts9Fuz1u
         JYEW87c5W1jwSZ/Zn6bLrw9xbCYgNCQ6kcg5yod8xhv5CLW2YffnL7P62rQs1kWDnpY6
         OKKWt2UdSQsMo/qdeQtCg9J2hEY4XgRkmMkv2efcIoU62clqeRCIU5DiRRLFQEUPIrDK
         HcW/y0lAjZ/LhCykagSFNP61xuUhA3n1vuU80Pk8QyjYl8LR3kgTvyMHwQOFJwwIg2r/
         /TOIl3fgBvsFJHvLbrz2Di1GySr47fl9hjoeWSZjDTYMrWySF70Q1hjPv3K/KY+WCcZm
         KWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Foxz7qrv4t3w/FL4IJaClc6QijaTM6xy9xLnPK+xt20=;
        b=CJc6ETufIeSyAJ6sOm4+sxE8NZu6bS/hzx0izD3gMB05ynFl9XhXxnqriEh9174KHY
         RosVyFUxuvDFXagbprYg+2P1832xbMHsqQ7yJ/7xYUy6EyH6l97eJFROxw1Ms08Pzx2M
         ANlNyvSmsNbGlE8bGxa2psABel41TP7JEgtZ3voyOO/gFPiGS6wJ+JRR9G/8+/f22JR/
         r4K+vFyttMtUwqkouZwUvxrmrm3pHN0NR8/qjwhD0TGOmGPhNRtcy042ttGStJNHY0uU
         Ng3ammtfVCfjXa1zoRfh1rhGtnv3Tnlhor13AFzyqXZtsRvvKRzFBpsW1wM8sbfCv9GN
         xdww==
X-Gm-Message-State: APjAAAXkBP0GaCwVGgxoagvDK9Xvt2cmQPCjYtE5/Vahet8PWzgiUPLl
        F2M62QDjc5aGVm/hlY/U3DT/pm7otnIQ1jpCz2qFg+ngZyyZyA==
X-Google-Smtp-Source: APXvYqwhqclELIcCu2uKuIKLR2wBYJ06SIsw5N9E6Iha0pq8+aotYPyhX4o7xg9jPNhninKWSCO+5ztOBUzJGQUV22A=
X-Received: by 2002:a9d:2208:: with SMTP id o8mr8012675ota.236.1557514250742;
 Fri, 10 May 2019 11:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com> <f63c8d6b-92a4-2977-d062-7e0b7036834e@gmail.com>
 <CAOWid-fpHqvq35C+gfHmLnuHM9Lj+iiHFXE=3RPrkAiFL2=wvQ@mail.gmail.com>
 <1ca1363e-b39c-c299-1d24-098b1059f7ff@amd.com> <CAOWid-eVz4w-hN=4tPZ1AOu54xMH_2ztDDZaMEKRCAeBgt9Dyw@mail.gmail.com>
 <64d12227-a0b9-acee-518c-8c97c5da4136@amd.com>
In-Reply-To: <64d12227-a0b9-acee-518c-8c97c5da4136@amd.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 10 May 2019 14:50:39 -0400
Message-ID: <CAOWid-es+C_iStQUkM52mO3TeP8eS9MX+emZDQNH2PyZCf=RHQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation limit
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Ho, Kenny" <Kenny.Ho@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Brian Welty <brian.welty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 10, 2019 at 1:48 PM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
> Well another question is why do we want to prevent that in the first place?
>
> I mean the worst thing that can happen is that we account a BO multiple
> times.
That's one of the problems.  The other one is the BO outliving the
lifetime of a cgroup and there's no good way to un-charge the usage
when the BO is free so the count won't be accurate.

I have looked into two possible solutions.  One is to prevent cgroup
from being removed when there are BOs owned by the cgroup still alive
(similar to how cgroup removal will fail if it still has processes
attached to it.)  My concern here is the possibility of not able to
remove a cgroup forever due to the lifetime of a BO (continuously
being shared and reuse and never die.)  Perhaps you can shed some
light on this possibility.

The other one is to keep track of all the buffers and migrate them to
the parent if a cgroup is closed.  My concern here is the performance
overhead on tracking all the buffers.

> And going into the same direction where is the code to handle an open
> device file descriptor which is send from one cgroup to another?
I looked into this before but I forgot what I found.  Perhaps folks
familiar with device cgroup can chime in.

Actually, just did another quick search right now.  Looks like the
access is enforced at the inode level (__devcgroup_check_permission)
so the fd sent to another cgroup that does not have access to the
device should still not have access.

Regards,
Kenny


> Regards,
> Christian.
>
> >
> > Regards,
> > Kenny
> >
> >>> On the other hand, if there are expectations for resource management
> >>> between containers, I would like to know who is the expected manager
> >>> and how does it fit into the concept of container (which enforce some
> >>> level of isolation.)  One possible manager may be the display server.
> >>> But as long as the display server is in a parent cgroup of the apps'
> >>> cgroup, the apps can still import handles from the display server
> >>> under the current implementation.  My understanding is that this is
> >>> most likely the case, with the display server simply sitting at the
> >>> default/root cgroup.  But I certainly want to hear more about other
> >>> use cases (for example, is running multiple display servers on a
> >>> single host a realistic possibility?  Are there people running
> >>> multiple display servers inside peer containers?  If so, how do they
> >>> coordinate resources?)
> >> We definitely have situations with multiple display servers running
> >> (just think of VR).
> >>
> >> I just can't say if they currently use cgroups in any way.
> >>
> >> Thanks,
> >> Christian.
> >>
> >>> I should probably summarize some of these into the commit message.
> >>>
> >>> Regards,
> >>> Kenny
> >>>
> >>>
> >>>
> >>>> Christian.
> >>>>
>
