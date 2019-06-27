Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A871E57BA0
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 07:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0Fn0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 Jun 2019 01:43:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45251 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0Fn0 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 Jun 2019 01:43:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so5782548edv.12
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 22:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qgn9IR2QmcvNfUYnBrywMUurBX3TO7Q1KJTZoJ8FHBE=;
        b=JTrixo4hkZP+Q0hcfUZ8+DZ2B+hxtewjUhjhbXYgcrPxyRUMdKt0xaDtOdAXLk9A/O
         wvhov762axL+scQkWb9NwB9DuITKWeyKtYiDw7KNK3Gw+UD1S1kIvqmnN9IUAaZrxhkB
         0boqMSHpSZ4reIu2dphjBTi8fg0anpcyD4EH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qgn9IR2QmcvNfUYnBrywMUurBX3TO7Q1KJTZoJ8FHBE=;
        b=K30kjFxqP26TlRM3vJ/oiTjjfEgm6dlax7PSdKY57LTo1ERA/wZNyE8wU9CVTwOC9q
         DTKc2aJ5fEGmtS1Gbchfmo163/Ad6UpAiCwCHSCBY2HEmwlMIuMuvepWD6gIzDc3kSM2
         i/twl2AzOqxZOZuaoypeqo7UgFuNZ8NJ8X2QjHf/Ls/3eIF4Quzyr3vxe9wnnGAEIFBS
         D1yhAThaF5usnv61WS+y5qDn/d33HdLUOeq4vR3yjlCi29R9aFRKVDPTnfDhdqNM3w/k
         9k0FV7IqS1Z0WrWbNEeEL9iohCGgmUGagsyd3nFxpIH2vosRLt+KVmbm2Afi0GyItab4
         GWbg==
X-Gm-Message-State: APjAAAVsZWoY8hnHkcY/lPjkNVCXUxrDVZS1xDzJ+4tc7PfwnPHlbGyK
        a2MGA2rb75Hcg+BK7S969ROyyw==
X-Google-Smtp-Source: APXvYqwhBXQC4UnB5lxSBZaTatG4NCBAAWoA+G8bC5PVedBA9vd9Chet4N9Y1Tk8C/Oc5Kd01zqxdg==
X-Received: by 2002:a17:907:2130:: with SMTP id qo16mr1362102ejb.235.1561614203924;
        Wed, 26 Jun 2019 22:43:23 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id b21sm231154ejb.12.2019.06.26.22.43.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 22:43:23 -0700 (PDT)
Date:   Thu, 27 Jun 2019 07:43:20 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer
 allocation limit
Message-ID: <20190627054320.GB12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-5-Kenny.Ho@amd.com>
 <20190626160553.GR12905@phenom.ffwll.local>
 <CAOWid-eurCMx1F7ciUwx0e+p=s=NP8=UxQUhhF-hdK-iAna+fA@mail.gmail.com>
 <20190626214113.GA12905@phenom.ffwll.local>
 <CAOWid-egYGijS0a6uuG4mPUmOWaPwF-EKokR=LFNJ=5M+akVZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-egYGijS0a6uuG4mPUmOWaPwF-EKokR=LFNJ=5M+akVZw@mail.gmail.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 06:41:32PM -0400, Kenny Ho wrote:
> On Wed, Jun 26, 2019 at 5:41 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Wed, Jun 26, 2019 at 05:27:48PM -0400, Kenny Ho wrote:
> > > On Wed, Jun 26, 2019 at 12:05 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > So what happens when you start a lot of threads all at the same time,
> > > > allocating gem bo? Also would be nice if we could roll out at least the
> > > > accounting part of this cgroup to all GEM drivers.
> > >
> > > When there is a large number of allocation, the allocation will be
> > > checked in sequence within a device (since I used a per device mutex
> > > in the check.)  Are you suggesting the overhead here is significant
> > > enough to be a bottleneck?  The accounting part should be available to
> > > all GEM drivers (unless I missed something) since the chg and unchg
> > > function is called via the generic drm_gem_private_object_init and
> > > drm_gem_object_release.
> >
> > thread 1: checks limits, still under the total
> >
> > thread 2: checks limits, still under the total
> >
> > thread 1: allocates, still under
> >
> > thread 2: allocates, now over the limit
> >
> > I think the check and chg need to be one step, or this wont work. Or I'm
> > missing something somewhere.
> 
> Ok, I see what you are saying.
> 
> > Wrt rolling out the accounting for all drivers: Since you also roll out
> > enforcement in this patch I'm not sure whether the accounting part is
> > fully stand-alone. And as discussed a bit on an earlier patch, I think for
> > DRIVER_GEM we should set up the accounting cgroup automatically.
> I think I should be able to split the commit and restructure things a bit.
> 
> > > > What's the underlying technical reason for not allowing sharing across
> > > > cgroups?
> > > To be clear, sharing across cgroup is allowed, the buffer just needs
> > > to be allocated by a process that is parent to the cgroup.  So in the
> > > case of xorg allocating buffer for client, the xorg would be in the
> > > root cgroup and the buffer can be passed around by different clients
> > > (in root or other cgroup.)  The idea here is to establish some form of
> > > ownership, otherwise there wouldn't be a way to account for or limit
> > > the usage.
> >
> > But why? What's the problem if I allocate something and then hand it to
> > someone else. E.g. one popular use of cgroups is to isolate clients, so
> > maybe you'd do a cgroup + namespace for each X11 client (ok wayland, with
> > X11 this is probably pointless).
> >
> > But with your current limitation those clients can't pass buffers to the
> > compositor anymore, making cgroups useless. Your example here only works
> > if Xorg is in the root and allocates all the buffers. That's not even true
> > for DRI3 anymore.
> >
> > So pretty serious limitation on cgroups, and I'm not really understanding
> > why we need this. I think if we want to prevent buffer sharing, what we
> > need are some selinux hooks and stuff so you can prevent an import/access
> > by someone who's not allowed to touch a buffer. But that kind of access
> > right management should be separate from resource control imo.
> So without the sharing restriction and some kind of ownership
> structure, we will have to migrate/change the owner of the buffer when
> the cgroup that created the buffer die before the receiving cgroup(s)
> and I am not sure how to do that properly at the moment.  1) Should
> each cgroup keep track of all the buffers that belongs to it and
> migrate?  (Is that efficient?)  2) which cgroup should be the new
> owner (and therefore have the limit applied?)  Having the creator
> being the owner is kind of natural, but let say the buffer is shared
> with 5 other cgroups, which of these 5 cgroups should be the new owner
> of the buffer?

Different answers:

- Do we care if we leak bos like this in a cgroup, if the cgroup
  disappears before all the bo are cleaned up?

- Just charge the bo to each cgroup it's in? Will be quite a bit more
  tracking needed to get that done ...

- Also, there's the legacy way of sharing a bo, with the FLINK and
  GEM_OPEN ioctls. We need to plug these holes too.

Just feels like your current solution is technically well-justified, but
it completely defeats the point of cgroups/containers and buffer sharing
...

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
