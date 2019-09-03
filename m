Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8215BA73E1
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfICTpv (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 15:45:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52180 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfICTpv (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 15:45:51 -0400
Received: by mail-wm1-f67.google.com with SMTP id k1so761775wmi.1
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYsl+WnBNOSzkzGcFs1LuQIIp7KdKnXoVt1TdYqbhNg=;
        b=SsANTSRz7Bro8WAvrKynQVHMXjfwfbW/kmB/QSt8ynaeOeWpgyX8RCaZwmyrTTjEUx
         uGG2RqmhiRKyeN5Q3WW0o+hxlgqEXRGVMGBHGw+Yhar1zdyY7u8XSaW1ZVU5qc530EZk
         bFdF/ojhK+OWxuQSV0Si5FTmbFwbvdwRiEIRs5yHNn+cvGv9hUNAG+eMcIPJaATfhvDY
         ib/pJA4FOCujGemDl8SMrPDcydb+hv1mz+81gExfwWmCFJtpwpMAAgLOtpGQSvaOvxhN
         f08g0X5g5n51JfDPGmWrSTYwhFYQcOImAF58AAgTByC6E7TM9lYKXBqqgYM6Dg/FZVTs
         yOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYsl+WnBNOSzkzGcFs1LuQIIp7KdKnXoVt1TdYqbhNg=;
        b=Bosz4LkOVnkoMcZI6KGOSu5oJQQ8refWYdNVIRY69x5RNDkqVI7g4l6oCKnVl39Ius
         N3/MAVJhDG4MEbAAjORKHfU7DIuhBNoBU0GTTiXfflIRJYdM8bFe4IqxY1Fydod7MuK5
         DFqgAeHDs0nodtzIiHAg+ATAYTwi/0mz2VGdRZu+4li7GKQOtLI/yCvlyVhk11t2ohsD
         Kr6voj8XyrfzvOlZtl4Q6d7QSC40Wke0p7S+pOuOFthR9FRMUOMmB3k7vkhH7iQRFD7s
         6LdMpgnFAB2D2/JeHdLlKguGjrzO67IcFVqmIiwjeGwKX4s1zUHncMDBd2lMCKK6duCH
         eqUQ==
X-Gm-Message-State: APjAAAWZMwn8SC3VUPl/xgNfRiLpg0/XUItTfc4pXIKYBEdSqmjKmMT3
        bQcLZRpdvQ3nDjPXqqPAzkRlkJoWzBQYnS0O8nY=
X-Google-Smtp-Source: APXvYqxQh47GOErjlT0YtgDIsGVuiGJ4BB6C7zMaZtm3tHHYDANfiEYckETqYawXwDVuvSwbJ1A+W6mo5UO6YgJA8oI=
X-Received: by 2002:a7b:c761:: with SMTP id x1mr1240453wmk.100.1567539948476;
 Tue, 03 Sep 2019 12:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local>
In-Reply-To: <20190903075719.GK2112@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Tue, 3 Sep 2019 15:45:37 -0400
Message-ID: <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
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

On Tue, Sep 3, 2019 at 3:57 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Aug 29, 2019 at 02:05:18AM -0400, Kenny Ho wrote:
> > To allow other subsystems to iterate through all stored DRM minors and
> > act upon them.
> >
> > Also exposes drm_minor_acquire and drm_minor_release for other subsystem
> > to handle drm_minor.  DRM cgroup controller is the initial consumer of
> > this new features.
> >
> > Change-Id: I7c4b67ce6b31f06d1037b03435386ff5b8144ca5
> > Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
>
> Iterating over minors for cgroups sounds very, very wrong. Why do we care
> whether a buffer was allocated through kms dumb vs render nodes?
>
> I'd expect all the cgroup stuff to only work on drm_device, if it does
> care about devices.
>
> (I didn't look through the patch series to find out where exactly you're
> using this, so maybe I'm off the rails here).

I am exposing this to remove the need to keep track of a separate list
of available drm_device in the system (to remove the registering and
unregistering of drm_device to the cgroup subsystem and just use
drm_minor as the single source of truth.)  I am only filtering out the
render nodes minor because they point to the same drm_device and is
confusing.

Perhaps I missed an obvious way to list the drm devices without
iterating through the drm_minors?  (I probably jumped to the minors
because $major:$minor is the convention to address devices in cgroup.)

Kenny

> -Daniel
>
> > ---
> >  drivers/gpu/drm/drm_drv.c      | 19 +++++++++++++++++++
> >  drivers/gpu/drm/drm_internal.h |  4 ----
> >  include/drm/drm_drv.h          |  4 ++++
> >  3 files changed, 23 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > index 862621494a93..000cddabd970 100644
> > --- a/drivers/gpu/drm/drm_drv.c
> > +++ b/drivers/gpu/drm/drm_drv.c
> > @@ -254,11 +254,13 @@ struct drm_minor *drm_minor_acquire(unsigned int minor_id)
> >
> >       return minor;
> >  }
> > +EXPORT_SYMBOL(drm_minor_acquire);
> >
> >  void drm_minor_release(struct drm_minor *minor)
> >  {
> >       drm_dev_put(minor->dev);
> >  }
> > +EXPORT_SYMBOL(drm_minor_release);
> >
> >  /**
> >   * DOC: driver instance overview
> > @@ -1078,6 +1080,23 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
> >  }
> >  EXPORT_SYMBOL(drm_dev_set_unique);
> >
> > +/**
> > + * drm_minor_for_each - Iterate through all stored DRM minors
> > + * @fn: Function to be called for each pointer.
> > + * @data: Data passed to callback function.
> > + *
> > + * The callback function will be called for each @drm_minor entry, passing
> > + * the minor, the entry and @data.
> > + *
> > + * If @fn returns anything other than %0, the iteration stops and that
> > + * value is returned from this function.
> > + */
> > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data)
> > +{
> > +     return idr_for_each(&drm_minors_idr, fn, data);
> > +}
> > +EXPORT_SYMBOL(drm_minor_for_each);
> > +
> >  /*
> >   * DRM Core
> >   * The DRM core module initializes all global DRM objects and makes them
> > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > index e19ac7ca602d..6bfad76f8e78 100644
> > --- a/drivers/gpu/drm/drm_internal.h
> > +++ b/drivers/gpu/drm/drm_internal.h
> > @@ -54,10 +54,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
> >  void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpriv,
> >                                       struct dma_buf *dma_buf);
> >
> > -/* drm_drv.c */
> > -struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > -void drm_minor_release(struct drm_minor *minor);
> > -
> >  /* drm_vblank.c */
> >  void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
> >  void drm_vblank_cleanup(struct drm_device *dev);
> > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > index 68ca736c548d..24f8d054c570 100644
> > --- a/include/drm/drm_drv.h
> > +++ b/include/drm/drm_drv.h
> > @@ -799,5 +799,9 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
> >
> >  int drm_dev_set_unique(struct drm_device *dev, const char *name);
> >
> > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data);
> > +
> > +struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > +void drm_minor_release(struct drm_minor *minor);
> >
> >  #endif
> > --
> > 2.22.0
> >
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
