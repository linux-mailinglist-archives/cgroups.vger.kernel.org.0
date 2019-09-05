Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B59CCAACB7
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 22:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbfIEUGh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 16:06:37 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36411 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfIEUGh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 16:06:37 -0400
Received: by mail-oi1-f193.google.com with SMTP id k20so3010487oih.3
        for <cgroups@vger.kernel.org>; Thu, 05 Sep 2019 13:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k4ypuIpayyWKmJJyO4GpAnw75e1QJlJS93LZJJcwPUU=;
        b=flA0IkoFZxtNZ9HJYOAgrVnLC+FVIpnI0ZD8SS7UZVpH01UV4YZcem53VUGxSCa0m2
         Q7l85/XeTs2Q4MCSnggx5Ioorluw7KYEYdJi8bJeZczkZ/vGuebGFytW6aBJevLq3Ug+
         Q/tosbYyv1Wm05ovdycqsE7TsgKNnGHEhoLHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k4ypuIpayyWKmJJyO4GpAnw75e1QJlJS93LZJJcwPUU=;
        b=GMhYKw+qsQoB5SR/sJFgbut7ivtpImv4ckUU5me5QiIhlIDbZtAsic5ffSkVDkrfSC
         IP9K3yuJt4ZCCFVOucY4L020oge1Jb+c134hEGj2NR9SnC0YBjS/nmQsAyhzlId+Q25U
         DWV45N80VB+nZ1PnV5Vaxwp3F/DDrPBCatBWXAIk0oVsM86ZlzdeEmm/dg+t4eO7bxVr
         59T60yDISTUgHEXXt/ULZz2FV+od7NksMzNyD9ANCdaLCR21AMntpEo1Gb4lqmbMQfSr
         wn23pziXsAzIWiSQD5Lv4oHK06MPF0FMFiFExwiTzqrzUXAhglYmGM6OEsPr5KaTefmN
         lLPw==
X-Gm-Message-State: APjAAAUKUfR/7oHIBzn2X2U3NfWD5VAtvNIUhvII2qTo59x3E95SHd59
        liXBFUzH8f35s+32+4i5MFzbM5R0NMKW3F+u748XGQ==
X-Google-Smtp-Source: APXvYqx+7I3jZv7TGCmVvr9Tde1xyubYESajuKQBsbvSb3Mx+NpQ+VWbLOwuhWeLvaI+pH6YRk2FEiLYwZnCyIdEH4A=
X-Received: by 2002:aca:5c45:: with SMTP id q66mr2738386oib.132.1567713995836;
 Thu, 05 Sep 2019 13:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local> <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
 <20190904085434.GF2112@phenom.ffwll.local> <CAOWid-fiEOmPw1z=aF6E4VE03xikREKt-X8VVKGGUGBQd3i=Kw@mail.gmail.com>
In-Reply-To: <CAOWid-fiEOmPw1z=aF6E4VE03xikREKt-X8VVKGGUGBQd3i=Kw@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 5 Sep 2019 22:06:24 +0200
Message-ID: <CAKMK7uGSrscs-WAv0pYfcxaUGXvx7M6JYbiPHTY=1hxRbFK1sg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
To:     Kenny Ho <y2kenny@gmail.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Tejun Heo <tj@kernel.org>,
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

On Thu, Sep 5, 2019 at 8:28 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> (resent in plain text mode)
>
> Hi Daniel,
>
> This is the previous patch relevant to this discussion:
> https://patchwork.freedesktop.org/patch/314343/

Ah yes, thanks for finding that.

> So before I refactored the code to leverage drm_minor, I kept my own
> list of "known" drm_device inside the controller and have explicit
> register and unregister function to init per device cgroup defaults.
> For v4, I refactored the per device cgroup properties and embedded
> them into the drm_device and continue to only use the primary minor as
> a way to index the device as v3.

I didn't really like the explicit registration step, at least for the
basic cgroup controls (like gem buffer limits), and suggested that
should happen automatically at drm_dev_register/unregister time. I
also talked about picking a consistent minor (if we have to use
minors, still would like Tejun to confirm what we should do here), but
that was an unrelated comment. So doing auto-registration on drm_minor
was one step too far.

Just doing a drm_cg_register/unregister pair that's called from
drm_dev_register/unregister, and then if you want, looking up the
right minor (I think always picking the render node makes sense for
this, and skipping if there's no render node) would make most sense.
At least for the basic cgroup controllers which are generic across
drivers.
-Daniel



>
> Regards,
> Kenny
>
>
> On Wed, Sep 4, 2019 at 4:54 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, Sep 03, 2019 at 04:43:45PM -0400, Kenny Ho wrote:
> > > On Tue, Sep 3, 2019 at 4:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > On Tue, Sep 3, 2019 at 9:45 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > > > > On Tue, Sep 3, 2019 at 3:57 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > > Iterating over minors for cgroups sounds very, very wrong. Why do we care
> > > > > > whether a buffer was allocated through kms dumb vs render nodes?
> > > > > >
> > > > > > I'd expect all the cgroup stuff to only work on drm_device, if it does
> > > > > > care about devices.
> > > > > >
> > > > > > (I didn't look through the patch series to find out where exactly you're
> > > > > > using this, so maybe I'm off the rails here).
> > > > >
> > > > > I am exposing this to remove the need to keep track of a separate list
> > > > > of available drm_device in the system (to remove the registering and
> > > > > unregistering of drm_device to the cgroup subsystem and just use
> > > > > drm_minor as the single source of truth.)  I am only filtering out the
> > > > > render nodes minor because they point to the same drm_device and is
> > > > > confusing.
> > > > >
> > > > > Perhaps I missed an obvious way to list the drm devices without
> > > > > iterating through the drm_minors?  (I probably jumped to the minors
> > > > > because $major:$minor is the convention to address devices in cgroup.)
> > > >
> > > > Create your own if there's nothing, because you need to anyway:
> > > > - You need special locking anyway, we can't just block on the idr lock
> > > > for everything.
> > > > - This needs to refcount drm_device, no the minors.
> > > >
> > > > Iterating over stuff still feels kinda wrong still, because normally
> > > > the way we register/unregister userspace api (and cgroups isn't
> > > > anything else from a drm driver pov) is by adding more calls to
> > > > drm_dev_register/unregister. If you put a drm_cg_register/unregister
> > > > call in there we have a clean separation, and you can track all the
> > > > currently active devices however you want. Iterating over objects that
> > > > can be hotunplugged any time tends to get really complicated really
> > > > quickly.
> > >
> > > Um... I thought this is what I had previously.  Did I misunderstood
> > > your feedback from v3?  Doesn't drm_minor already include all these
> > > facilities so isn't creating my own kind of reinventing the wheel?
> > > (as I did previously?)  drm_minor_register is called inside
> > > drm_dev_register so isn't leveraging existing drm_minor facilities
> > > much better solution?
> >
> > Hm the previous version already dropped out of my inbox, so hard to find
> > it again. And I couldn't find this in archieves. Do you have pointers?
> >
> > I thought the previous version did cgroup init separately from drm_device
> > setup, and I guess I suggested that it should be moved int
> > drm_dev_register/unregister?
> >
> > Anyway, I don't think reusing the drm_minor registration makes sense,
> > since we want to be on the drm_device, not on the minor. Which is a bit
> > awkward for cgroups, which wants to identify devices using major.minor
> > pairs. But I guess drm is the first subsystem where 1 device can be
> > exposed through multiple minors ...
> >
> > Tejun, any suggestions on this?
> >
> > Anyway, I think just leveraging existing code because it can be abused to
> > make it fit for us doesn't make sense. E.g. for the kms side we also don't
> > piggy-back on top of drm_minor_register (it would be technically
> > possible), but instead we have drm_modeset_register_all().
> > -Daniel
> >
> > >
> > > Kenny
> > >
> > > >
> > > >
> > > > >
> > > > > Kenny
> > > > >
> > > > > > -Daniel
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/gpu/drm/drm_drv.c      | 19 +++++++++++++++++++
> > > > > > >  drivers/gpu/drm/drm_internal.h |  4 ----
> > > > > > >  include/drm/drm_drv.h          |  4 ++++
> > > > > > >  3 files changed, 23 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > > > > > index 862621494a93..000cddabd970 100644
> > > > > > > --- a/drivers/gpu/drm/drm_drv.c
> > > > > > > +++ b/drivers/gpu/drm/drm_drv.c
> > > > > > > @@ -254,11 +254,13 @@ struct drm_minor *drm_minor_acquire(unsigned int minor_id)
> > > > > > >
> > > > > > >       return minor;
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(drm_minor_acquire);
> > > > > > >
> > > > > > >  void drm_minor_release(struct drm_minor *minor)
> > > > > > >  {
> > > > > > >       drm_dev_put(minor->dev);
> > > > > > >  }
> > > > > > > +EXPORT_SYMBOL(drm_minor_release);
> > > > > > >
> > > > > > >  /**
> > > > > > >   * DOC: driver instance overview
> > > > > > > @@ -1078,6 +1080,23 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL(drm_dev_set_unique);
> > > > > > >
> > > > > > > +/**
> > > > > > > + * drm_minor_for_each - Iterate through all stored DRM minors
> > > > > > > + * @fn: Function to be called for each pointer.
> > > > > > > + * @data: Data passed to callback function.
> > > > > > > + *
> > > > > > > + * The callback function will be called for each @drm_minor entry, passing
> > > > > > > + * the minor, the entry and @data.
> > > > > > > + *
> > > > > > > + * If @fn returns anything other than %0, the iteration stops and that
> > > > > > > + * value is returned from this function.
> > > > > > > + */
> > > > > > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data)
> > > > > > > +{
> > > > > > > +     return idr_for_each(&drm_minors_idr, fn, data);
> > > > > > > +}
> > > > > > > +EXPORT_SYMBOL(drm_minor_for_each);
> > > > > > > +
> > > > > > >  /*
> > > > > > >   * DRM Core
> > > > > > >   * The DRM core module initializes all global DRM objects and makes them
> > > > > > > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > > > > > > index e19ac7ca602d..6bfad76f8e78 100644
> > > > > > > --- a/drivers/gpu/drm/drm_internal.h
> > > > > > > +++ b/drivers/gpu/drm/drm_internal.h
> > > > > > > @@ -54,10 +54,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
> > > > > > >  void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpriv,
> > > > > > >                                       struct dma_buf *dma_buf);
> > > > > > >
> > > > > > > -/* drm_drv.c */
> > > > > > > -struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > > > > > -void drm_minor_release(struct drm_minor *minor);
> > > > > > > -
> > > > > > >  /* drm_vblank.c */
> > > > > > >  void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
> > > > > > >  void drm_vblank_cleanup(struct drm_device *dev);
> > > > > > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > > > > > > index 68ca736c548d..24f8d054c570 100644
> > > > > > > --- a/include/drm/drm_drv.h
> > > > > > > +++ b/include/drm/drm_drv.h
> > > > > > > @@ -799,5 +799,9 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
> > > > > > >
> > > > > > >  int drm_dev_set_unique(struct drm_device *dev, const char *name);
> > > > > > >
> > > > > > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data);
> > > > > > > +
> > > > > > > +struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > > > > > +void drm_minor_release(struct drm_minor *minor);
> > > > > > >
> > > > > > >  #endif
> > > > > > > --
> > > > > > > 2.22.0
> > > > > > >
> > > > > >
> > > > > > --
> > > > > > Daniel Vetter
> > > > > > Software Engineer, Intel Corporation
> > > > > > http://blog.ffwll.ch
> > > >
> > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
