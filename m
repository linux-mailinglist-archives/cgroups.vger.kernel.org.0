Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 609BFAAAF8
	for <lists+cgroups@lfdr.de>; Thu,  5 Sep 2019 20:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403897AbfIES2y (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 5 Sep 2019 14:28:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35437 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731541AbfIES2y (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 5 Sep 2019 14:28:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id g7so3940693wrx.2
        for <cgroups@vger.kernel.org>; Thu, 05 Sep 2019 11:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhaS2dFa+tX8/QLVQELyAd3709dfP+CSIXKHmdkHh5c=;
        b=k3R9B9fQWXOMHQItMnmpn2ST5KSrWbaVPsCw3aQnRMQdfO18LHYPu3cFtFCapiP8n1
         sZJ2H913FKe0YqsYwpUHSCxxDbPj4Tfe1qq1DiKiMqG2SEczTr7N5EUfWraOXjR5+1YF
         3m9eUXURRe89oQKHfK43LXQi8F+9mN5dIIljw6SE5aKRBuXrHK1t7hwYQ029hbtY/nZs
         IfCkCWCBZXJUMrgeMNVqFX5fJJiu+EBQn75Mk+p3KROfXCkYcclHdkYdgxfseqyWN02O
         5cIEAWPn8AjzmX6UILHCNqxvbiO1dFKDWB6mO9HGS48FTbIyoMoswos0P+txNybmP9Uh
         GmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhaS2dFa+tX8/QLVQELyAd3709dfP+CSIXKHmdkHh5c=;
        b=ELhgwA9QR23jeMM8FLOdk77E0csbKfQvJvuP1vis4GgUCPpc6dTG3K6vyxmKtRWfUX
         5iaT/D8IXbb7vruJWW/H3QWRk4CPkSKmljtHRAGO94LfSIguNVBPu8zB+XnvGwg1l/26
         FeddfdHEI6hl42lGoUqe9+hNN1RFoA+gvffrkHvtYauqNRq7kfIfudeSMLrD86DL28ej
         vtmp5bw9yywTAoylJRm0vMtsNbnVVrPlIJY8t5pjKh7UxGghPXYje1wgGZvqj8r6cD6F
         yoyqOkJV7vGyog3egMhAu4C6dPhosLbjHuv0+foia8ONyS/KqjOhKh3Ly5klqDJWACdy
         DjzQ==
X-Gm-Message-State: APjAAAUhfunTKxgZQt350XzfYRNy6HZrcqTbkv22MK4xtF1rjSqwqWTn
        ru2jYOwmnMjV+aa+eEHfcgtKoqLdYjL/5kzFAZw=
X-Google-Smtp-Source: APXvYqybwAEt2IY6u4zMAch6vCFoCRLZa2IdRAn/XCikxGvH+WFIG4vz8ta0DE1EoXd9dVHmgQbxJCxYmWJQj5KY51U=
X-Received: by 2002:adf:dec8:: with SMTP id i8mr3943618wrn.286.1567708131083;
 Thu, 05 Sep 2019 11:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local> <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com> <20190904085434.GF2112@phenom.ffwll.local>
In-Reply-To: <20190904085434.GF2112@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 5 Sep 2019 14:28:39 -0400
Message-ID: <CAOWid-fiEOmPw1z=aF6E4VE03xikREKt-X8VVKGGUGBQd3i=Kw@mail.gmail.com>
Subject: Re: [PATCH RFC v4 01/16] drm: Add drm_minor_for_each
To:     Daniel Vetter <daniel@ffwll.ch>
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

(resent in plain text mode)

Hi Daniel,

This is the previous patch relevant to this discussion:
https://patchwork.freedesktop.org/patch/314343/

So before I refactored the code to leverage drm_minor, I kept my own
list of "known" drm_device inside the controller and have explicit
register and unregister function to init per device cgroup defaults.
For v4, I refactored the per device cgroup properties and embedded
them into the drm_device and continue to only use the primary minor as
a way to index the device as v3.

Regards,
Kenny


On Wed, Sep 4, 2019 at 4:54 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, Sep 03, 2019 at 04:43:45PM -0400, Kenny Ho wrote:
> > On Tue, Sep 3, 2019 at 4:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Tue, Sep 3, 2019 at 9:45 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > > > On Tue, Sep 3, 2019 at 3:57 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > > Iterating over minors for cgroups sounds very, very wrong. Why do we care
> > > > > whether a buffer was allocated through kms dumb vs render nodes?
> > > > >
> > > > > I'd expect all the cgroup stuff to only work on drm_device, if it does
> > > > > care about devices.
> > > > >
> > > > > (I didn't look through the patch series to find out where exactly you're
> > > > > using this, so maybe I'm off the rails here).
> > > >
> > > > I am exposing this to remove the need to keep track of a separate list
> > > > of available drm_device in the system (to remove the registering and
> > > > unregistering of drm_device to the cgroup subsystem and just use
> > > > drm_minor as the single source of truth.)  I am only filtering out the
> > > > render nodes minor because they point to the same drm_device and is
> > > > confusing.
> > > >
> > > > Perhaps I missed an obvious way to list the drm devices without
> > > > iterating through the drm_minors?  (I probably jumped to the minors
> > > > because $major:$minor is the convention to address devices in cgroup.)
> > >
> > > Create your own if there's nothing, because you need to anyway:
> > > - You need special locking anyway, we can't just block on the idr lock
> > > for everything.
> > > - This needs to refcount drm_device, no the minors.
> > >
> > > Iterating over stuff still feels kinda wrong still, because normally
> > > the way we register/unregister userspace api (and cgroups isn't
> > > anything else from a drm driver pov) is by adding more calls to
> > > drm_dev_register/unregister. If you put a drm_cg_register/unregister
> > > call in there we have a clean separation, and you can track all the
> > > currently active devices however you want. Iterating over objects that
> > > can be hotunplugged any time tends to get really complicated really
> > > quickly.
> >
> > Um... I thought this is what I had previously.  Did I misunderstood
> > your feedback from v3?  Doesn't drm_minor already include all these
> > facilities so isn't creating my own kind of reinventing the wheel?
> > (as I did previously?)  drm_minor_register is called inside
> > drm_dev_register so isn't leveraging existing drm_minor facilities
> > much better solution?
>
> Hm the previous version already dropped out of my inbox, so hard to find
> it again. And I couldn't find this in archieves. Do you have pointers?
>
> I thought the previous version did cgroup init separately from drm_device
> setup, and I guess I suggested that it should be moved int
> drm_dev_register/unregister?
>
> Anyway, I don't think reusing the drm_minor registration makes sense,
> since we want to be on the drm_device, not on the minor. Which is a bit
> awkward for cgroups, which wants to identify devices using major.minor
> pairs. But I guess drm is the first subsystem where 1 device can be
> exposed through multiple minors ...
>
> Tejun, any suggestions on this?
>
> Anyway, I think just leveraging existing code because it can be abused to
> make it fit for us doesn't make sense. E.g. for the kms side we also don't
> piggy-back on top of drm_minor_register (it would be technically
> possible), but instead we have drm_modeset_register_all().
> -Daniel
>
> >
> > Kenny
> >
> > >
> > >
> > > >
> > > > Kenny
> > > >
> > > > > -Daniel
> > > > >
> > > > > > ---
> > > > > >  drivers/gpu/drm/drm_drv.c      | 19 +++++++++++++++++++
> > > > > >  drivers/gpu/drm/drm_internal.h |  4 ----
> > > > > >  include/drm/drm_drv.h          |  4 ++++
> > > > > >  3 files changed, 23 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > > > > index 862621494a93..000cddabd970 100644
> > > > > > --- a/drivers/gpu/drm/drm_drv.c
> > > > > > +++ b/drivers/gpu/drm/drm_drv.c
> > > > > > @@ -254,11 +254,13 @@ struct drm_minor *drm_minor_acquire(unsigned int minor_id)
> > > > > >
> > > > > >       return minor;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(drm_minor_acquire);
> > > > > >
> > > > > >  void drm_minor_release(struct drm_minor *minor)
> > > > > >  {
> > > > > >       drm_dev_put(minor->dev);
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(drm_minor_release);
> > > > > >
> > > > > >  /**
> > > > > >   * DOC: driver instance overview
> > > > > > @@ -1078,6 +1080,23 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(drm_dev_set_unique);
> > > > > >
> > > > > > +/**
> > > > > > + * drm_minor_for_each - Iterate through all stored DRM minors
> > > > > > + * @fn: Function to be called for each pointer.
> > > > > > + * @data: Data passed to callback function.
> > > > > > + *
> > > > > > + * The callback function will be called for each @drm_minor entry, passing
> > > > > > + * the minor, the entry and @data.
> > > > > > + *
> > > > > > + * If @fn returns anything other than %0, the iteration stops and that
> > > > > > + * value is returned from this function.
> > > > > > + */
> > > > > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data)
> > > > > > +{
> > > > > > +     return idr_for_each(&drm_minors_idr, fn, data);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(drm_minor_for_each);
> > > > > > +
> > > > > >  /*
> > > > > >   * DRM Core
> > > > > >   * The DRM core module initializes all global DRM objects and makes them
> > > > > > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > > > > > index e19ac7ca602d..6bfad76f8e78 100644
> > > > > > --- a/drivers/gpu/drm/drm_internal.h
> > > > > > +++ b/drivers/gpu/drm/drm_internal.h
> > > > > > @@ -54,10 +54,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
> > > > > >  void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpriv,
> > > > > >                                       struct dma_buf *dma_buf);
> > > > > >
> > > > > > -/* drm_drv.c */
> > > > > > -struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > > > > -void drm_minor_release(struct drm_minor *minor);
> > > > > > -
> > > > > >  /* drm_vblank.c */
> > > > > >  void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
> > > > > >  void drm_vblank_cleanup(struct drm_device *dev);
> > > > > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > > > > > index 68ca736c548d..24f8d054c570 100644
> > > > > > --- a/include/drm/drm_drv.h
> > > > > > +++ b/include/drm/drm_drv.h
> > > > > > @@ -799,5 +799,9 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
> > > > > >
> > > > > >  int drm_dev_set_unique(struct drm_device *dev, const char *name);
> > > > > >
> > > > > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data);
> > > > > > +
> > > > > > +struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > > > > +void drm_minor_release(struct drm_minor *minor);
> > > > > >
> > > > > >  #endif
> > > > > > --
> > > > > > 2.22.0
> > > > > >
> > > > >
> > > > > --
> > > > > Daniel Vetter
> > > > > Software Engineer, Intel Corporation
> > > > > http://blog.ffwll.ch
> > >
> > >
> > >
> > > --
> > > Daniel Vetter
> > > Software Engineer, Intel Corporation
> > > +41 (0) 79 365 57 48 - http://blog.ffwll.ch
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
