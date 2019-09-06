Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA052AB4AC
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 11:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388916AbfIFJMp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 05:12:45 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34618 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfIFJMp (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 6 Sep 2019 05:12:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id s49so5691939edb.1
        for <cgroups@vger.kernel.org>; Fri, 06 Sep 2019 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8pEqT/7PVhOn5E1RdOfZNt4oxSI4VkCztNjkHiJeFiY=;
        b=WPdT/JVxl7Dt9NVmLhjoXgL48l1X+TvNqNDy9dHcH8vfUaLdt4QEEFFJClMquLVwuN
         RV77Hq/Oo7P+6hmVXsBoQTlqK0H9SJX8djO6rGLa5WFkBTU5SrhCBMIgQBcXM+VkxPoS
         e6p0KgpYhvrPR0heyT7/katg1/W8HDChjE8XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8pEqT/7PVhOn5E1RdOfZNt4oxSI4VkCztNjkHiJeFiY=;
        b=l+LFBG/mlp07NJ5O+S1BFIeW6VPVjThSiQTI9wiKUlVg2TK/lIcs1Hbzd87K97GrSf
         rod3gM4F0t8fzeex2AsMmYzFIVmi/k4ozYamDETq1QvIJuTHRLTcQsCWer1SVEIYmHiY
         9koyuFhtraMMpFgA7yVLEiryZMCCnmizyIb2+frQTEpHKXRmGW6zDMh2or5z7hHtwLY1
         3bC/RukpIwirnD/LU2ybKNuXlvHhs/xYcTnIg37H9YTBh0QdkoA623w5ni8t9U/j9BTG
         096HvUydPEYmV5xM4YuoRqUFAtwyGomzLKAOSDUDfyGsQR7v+DdeJdbxahkF2rcLgY/B
         MOZQ==
X-Gm-Message-State: APjAAAUybqM/7UXzQ7pyQYJflSZtuVlhFZvMpBnajyD5Q2fg6c1s7neX
        GAsFAgEBJ8aXfBdtJWvcLwKliku0r+0=
X-Google-Smtp-Source: APXvYqzl/nleXKkE9hdjksK2Ymyu6lmcILfEkJq8BVbCQj4bR/80R37+Lw/J5Ykrq9sWREIA/hAdFQ==
X-Received: by 2002:aa7:ca41:: with SMTP id j1mr8291121edt.63.1567761163294;
        Fri, 06 Sep 2019 02:12:43 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id j1sm215348ejc.13.2019.09.06.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2019 02:12:42 -0700 (PDT)
Date:   Fri, 6 Sep 2019 11:12:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Kenny Ho <Kenny.Ho@amd.com>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kuehling, Felix" <felix.kuehling@amd.com>,
        "Greathouse, Joseph" <joseph.greathouse@amd.com>, jsparks@cray.com,
        lkaplan@cray.com
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
Message-ID: <20190906091240.GB3958@phenom.ffwll.local>
References: <20190903075719.GK2112@phenom.ffwll.local>
 <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
 <20190904085434.GF2112@phenom.ffwll.local>
 <CAOWid-fiEOmPw1z=aF6E4VE03xikREKt-X8VVKGGUGBQd3i=Kw@mail.gmail.com>
 <CAKMK7uGSrscs-WAv0pYfcxaUGXvx7M6JYbiPHTY=1hxRbFK1sg@mail.gmail.com>
 <CAOWid-eRZGxWzHw4qFqtSOCixQXvY4bEP91QnVH0Nmm13J9F-g@mail.gmail.com>
 <CAKMK7uHy+GRAcpLDuz6STCBW+GNfNWr-i=ZERF3uqkO7jfynnQ@mail.gmail.com>
 <CAOWid-cRP1T2gr2U_ZN+QhS7jFM0kFTWiYy8JPPXXmGW7xBPzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-cRP1T2gr2U_ZN+QhS7jFM0kFTWiYy8JPPXXmGW7xBPzA@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Sep 05, 2019 at 05:26:08PM -0400, Kenny Ho wrote:
> On Thu, Sep 5, 2019 at 4:32 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> *snip*
> > drm_dev_unregister gets called on hotunplug, so your cgroup-internal
> > tracking won't get out of sync any more than the drm_minor list gets
> > out of sync with drm_devices. The trouble with drm_minor is just that
> > cgroup doesn't track allocations on drm_minor (that's just the uapi
> > flavour), but on the underlying drm_device. So really doesn't make
> > much sense to attach cgroup tracking to the drm_minor.
> 
> Um... I think I get what you are saying, but isn't this a matter of
> the cgroup controller doing a drm_dev_get when using the drm_minor?
> Or that won't work because it's possible to have a valid drm_minor but
> invalid drm_device in it? I understand it's an extra level of
> indirection but since the convention for addressing device in cgroup
> is using $major:$minor I don't see a way to escape this.  (Tejun
> actually already made a comment on my earlier RFC where I didn't
> follow the major:minor convention strictly.)

drm_device is the object that controls lifetime and everything, that's why
you need to do a drm_dev_get and all that in some places. Going through
the minor really feels like a distraction.

And yes we have a bit a mess between cgroups insisting on using the minor,
and drm_device having more than 1 minor for the same underlying physical
resource. Just because the uapi is a bit a mess in that regard doesn't
mean we should pull that mess into the kernel implementation imo.
-Daniel

> 
> Kenny
> 
> > > > Just doing a drm_cg_register/unregister pair that's called from
> > > > drm_dev_register/unregister, and then if you want, looking up the
> > > > right minor (I think always picking the render node makes sense for
> > > > this, and skipping if there's no render node) would make most sense.
> > > > At least for the basic cgroup controllers which are generic across
> > > > drivers.
> > >
> > > Why do we want to skip drm devices that does not have a render node
> > > and not just use the primary instead?
> >
> > I guess we could also take the primary node, but drivers with only
> > primary node are generaly display-only drm drivers. Not sure we want
> > cgroups on those (but I guess can't hurt, and more consistent). But
> > then we'd always need to pick the primary node for cgroup
> > identification purposes.
> > -Daniel
> >
> > >
> > > Kenny
> > >
> > >
> > >
> > > > -Daniel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
