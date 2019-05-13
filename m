Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 377BB1B990
	for <lists+cgroups@lfdr.de>; Mon, 13 May 2019 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730173AbfEMPK3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 May 2019 11:10:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45286 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbfEMPK3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 13 May 2019 11:10:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id g57so18048467edc.12
        for <cgroups@vger.kernel.org>; Mon, 13 May 2019 08:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4ss32JgU9JDPulCVT/Q8Bkdh5NJh1QTi0J8W0yRxriY=;
        b=Mh0wCOY6EaThV+62KOziiRmjlazWjTKIQN5KVPkWwtOgFIKq1TJyIWfUSYxqgx/XTV
         i4g7DcyOQP5J8xgMcY+Ki7XHSiX8JR5wM5224ALR0T7Vto7lODvPL/6pTptf8Uw0oQSI
         0fx8d/VMPs6/Ov/aeI7eZS4Uq6VVzcd4wK8v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=4ss32JgU9JDPulCVT/Q8Bkdh5NJh1QTi0J8W0yRxriY=;
        b=nD3uCGwylzgOi/bdRjmIDOpnJk7OICySuXspgYJuk87wG8cCOhOajoGdXPUmUVxX0s
         0/eUYvvwlYMmHiUP+TqONPy8EW6AQ7tWJ1PSblE/ISdYCvpoC6sBSeXT/aMfKaZfpZDR
         vS4Rphwx4l0yzjGyOhs+kqGrHf2qzOdaplL/2pDZJDKIVpOXlFhhNtXnCn1BwYRFQ+7x
         1+r78iLDsuJttc+li2SrBhttFYepBkQgmR04hc6YG3fsK2YD9I3cpzh5Zy4SkjGS12Sx
         CzD6KeJbBGD2WBXHq8j3ogf/lCy4FMlvpFpx6/vc5v1Luz6Cjr7rIq6twJYDvOqY4ga3
         /+7A==
X-Gm-Message-State: APjAAAXXVbRlgXJ/+WM6dDkY3dtfNEHDX2eto4eK630yToUVFdAPkFl+
        UCCHEHkW/pMJO0o+KYY+PdIc1g==
X-Google-Smtp-Source: APXvYqx5/YxBRFLIRa8u4qxoG88hs4XFG5w7LiUMSIJS+T1x3h3umvHJ3/FBJ0LyytRqGKJHmE2UPQ==
X-Received: by 2002:a17:906:6050:: with SMTP id p16mr22771616ejj.173.1557760226759;
        Mon, 13 May 2019 08:10:26 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id l50sm540160edd.46.2019.05.13.08.10.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 08:10:26 -0700 (PDT)
Date:   Mon, 13 May 2019 17:10:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "Ho, Kenny" <Kenny.Ho@amd.com>,
        Brian Welty <brian.welty@intel.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation
 limit
Message-ID: <20190513151022.GU17751@phenom.ffwll.local>
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com>
 <f63c8d6b-92a4-2977-d062-7e0b7036834e@gmail.com>
 <CAOWid-fpHqvq35C+gfHmLnuHM9Lj+iiHFXE=3RPrkAiFL2=wvQ@mail.gmail.com>
 <1ca1363e-b39c-c299-1d24-098b1059f7ff@amd.com>
 <CAOWid-eVz4w-hN=4tPZ1AOu54xMH_2ztDDZaMEKRCAeBgt9Dyw@mail.gmail.com>
 <64d12227-a0b9-acee-518c-8c97c5da4136@amd.com>
 <CAOWid-es+C_iStQUkM52mO3TeP8eS9MX+emZDQNH2PyZCf=RHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-es+C_iStQUkM52mO3TeP8eS9MX+emZDQNH2PyZCf=RHQ@mail.gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 10, 2019 at 02:50:39PM -0400, Kenny Ho wrote:
> On Fri, May 10, 2019 at 1:48 PM Koenig, Christian
> <Christian.Koenig@amd.com> wrote:
> > Well another question is why do we want to prevent that in the first place?
> >
> > I mean the worst thing that can happen is that we account a BO multiple
> > times.
> That's one of the problems.  The other one is the BO outliving the
> lifetime of a cgroup and there's no good way to un-charge the usage
> when the BO is free so the count won't be accurate.
> 
> I have looked into two possible solutions.  One is to prevent cgroup
> from being removed when there are BOs owned by the cgroup still alive
> (similar to how cgroup removal will fail if it still has processes
> attached to it.)  My concern here is the possibility of not able to
> remove a cgroup forever due to the lifetime of a BO (continuously
> being shared and reuse and never die.)  Perhaps you can shed some
> light on this possibility.
> 
> The other one is to keep track of all the buffers and migrate them to
> the parent if a cgroup is closed.  My concern here is the performance
> overhead on tracking all the buffers.

My understanding is that other cgroups already use reference counting to
make sure the data structure in the kernel doesn't disappear too early. So
you can delete the cgroup, but it might not get freed completely until all
the BO allocated from that cgroup are released. There's a recent lwn
article on how that's not all that awesome for the memory cgroup
controller, and what to do about it:

https://lwn.net/Articles/787614/

We probably want to align with whatever the mem cgroup folks come up with
(so _not_ prevent deletion of the cgroup, since that's different
behaviour).

> > And going into the same direction where is the code to handle an open
> > device file descriptor which is send from one cgroup to another?
> I looked into this before but I forgot what I found.  Perhaps folks
> familiar with device cgroup can chime in.
> 
> Actually, just did another quick search right now.  Looks like the
> access is enforced at the inode level (__devcgroup_check_permission)
> so the fd sent to another cgroup that does not have access to the
> device should still not have access.

That's the device cgroup, not the memory accounting stuff.

Imo for memory allocations we should look at what happens when you pass a
tempfs file around to another cgroup and then extend it there. I think
those allocations are charged against the cgroup which actually allocates
stuff.

So for drm, if you pass around a device fd, then we always charge ioctl
calls to create a BO against the process doing the ioctl call, not against
the process which originally opened the device fd. For e.g. DRI3 that's
actually the only reasonable thing to do, since otherwise we'd charge
everything against the Xserver.
-Daniel

> 
> Regards,
> Kenny
> 
> 
> > Regards,
> > Christian.
> >
> > >
> > > Regards,
> > > Kenny
> > >
> > >>> On the other hand, if there are expectations for resource management
> > >>> between containers, I would like to know who is the expected manager
> > >>> and how does it fit into the concept of container (which enforce some
> > >>> level of isolation.)  One possible manager may be the display server.
> > >>> But as long as the display server is in a parent cgroup of the apps'
> > >>> cgroup, the apps can still import handles from the display server
> > >>> under the current implementation.  My understanding is that this is
> > >>> most likely the case, with the display server simply sitting at the
> > >>> default/root cgroup.  But I certainly want to hear more about other
> > >>> use cases (for example, is running multiple display servers on a
> > >>> single host a realistic possibility?  Are there people running
> > >>> multiple display servers inside peer containers?  If so, how do they
> > >>> coordinate resources?)
> > >> We definitely have situations with multiple display servers running
> > >> (just think of VR).
> > >>
> > >> I just can't say if they currently use cgroups in any way.
> > >>
> > >> Thanks,
> > >> Christian.
> > >>
> > >>> I should probably summarize some of these into the commit message.
> > >>>
> > >>> Regards,
> > >>> Kenny
> > >>>
> > >>>
> > >>>
> > >>>> Christian.
> > >>>>
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
