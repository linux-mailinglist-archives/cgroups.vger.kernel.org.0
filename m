Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 857EDA7452
	for <lists+cgroups@lfdr.de>; Tue,  3 Sep 2019 22:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfICUMb (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Sep 2019 16:12:31 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37089 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICUMb (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Sep 2019 16:12:31 -0400
Received: by mail-oi1-f194.google.com with SMTP id b25so13903591oib.4
        for <cgroups@vger.kernel.org>; Tue, 03 Sep 2019 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBNhrgat7SqOwv5lTSVhG2XRfqa3tzpTzrApa1HJXSE=;
        b=GdP7Sm5XGrkj9WnMFdPbDTxX0uwPg4yKIQX5Q/b4dmOSyjAINsl3Rz+bSgE3jCD3a2
         xipuE76hUcNdAIzVfgOsZVYElyJBHcI6+EHD8WnxRc9zZZ7h8+RbUdRG/lBumRb5crf6
         azQt8RiHS0wxK8Bsrrrll9k3nc0IMcpm29d0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBNhrgat7SqOwv5lTSVhG2XRfqa3tzpTzrApa1HJXSE=;
        b=oaTBAMt3g9WLhb0BD8Dcww6axC0/lYa6d2ZkajQfkz+mlcxGXKyZKRwUWbic7WlN7l
         6wLm1aQNK6Y8MraGxnsvSqDPVy5XHiw+Wk0P7MfiicSyVpcQRBSgg5XoAHdqJSuObnfO
         83DObA5gGeg2WkzQaVu8axYcWrJvKZ2A9hKyZ+35oTvGwMpghFSjMteBDRCGhxSbJunr
         2iY0TR99fkvZx/DQ0k/IQlkVcOX5T7YC6N08HbNaCk3REjrBe6SJjbEdxO02lWAJ6FFa
         JzLQ3bxVmw1JcZSJ66wMxLMxGCbPNCHKBc2BS9SZffOkfgXrw5jHtslfgu7CSw6LP+v7
         9tuA==
X-Gm-Message-State: APjAAAX+iC64h6cUrbSkCJPXV8lvWJDYyCBQVxFYs9y6XewdvEMD784V
        S29lTZPR51mgqSu6o/y78/atPR7lFc/xuraAB5lZSg==
X-Google-Smtp-Source: APXvYqxzOhWY/ESyU6GYsj/cHZQYZH8TSxiR02OEyHjs/DSAbSQeFU9WjB5pjvVwNmDfgq6dDedbYzHobV4kLlbTF78=
X-Received: by 2002:aca:e182:: with SMTP id y124mr809156oig.132.1567541550047;
 Tue, 03 Sep 2019 13:12:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local> <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
In-Reply-To: <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 3 Sep 2019 22:12:18 +0200
Message-ID: <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
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

On Tue, Sep 3, 2019 at 9:45 PM Kenny Ho <y2kenny@gmail.com> wrote:
>
> On Tue, Sep 3, 2019 at 3:57 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Thu, Aug 29, 2019 at 02:05:18AM -0400, Kenny Ho wrote:
> > > To allow other subsystems to iterate through all stored DRM minors and
> > > act upon them.
> > >
> > > Also exposes drm_minor_acquire and drm_minor_release for other subsystem
> > > to handle drm_minor.  DRM cgroup controller is the initial consumer of
> > > this new features.
> > >
> > > Change-Id: I7c4b67ce6b31f06d1037b03435386ff5b8144ca5
> > > Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> >
> > Iterating over minors for cgroups sounds very, very wrong. Why do we care
> > whether a buffer was allocated through kms dumb vs render nodes?
> >
> > I'd expect all the cgroup stuff to only work on drm_device, if it does
> > care about devices.
> >
> > (I didn't look through the patch series to find out where exactly you're
> > using this, so maybe I'm off the rails here).
>
> I am exposing this to remove the need to keep track of a separate list
> of available drm_device in the system (to remove the registering and
> unregistering of drm_device to the cgroup subsystem and just use
> drm_minor as the single source of truth.)  I am only filtering out the
> render nodes minor because they point to the same drm_device and is
> confusing.
>
> Perhaps I missed an obvious way to list the drm devices without
> iterating through the drm_minors?  (I probably jumped to the minors
> because $major:$minor is the convention to address devices in cgroup.)

Create your own if there's nothing, because you need to anyway:
- You need special locking anyway, we can't just block on the idr lock
for everything.
- This needs to refcount drm_device, no the minors.

Iterating over stuff still feels kinda wrong still, because normally
the way we register/unregister userspace api (and cgroups isn't
anything else from a drm driver pov) is by adding more calls to
drm_dev_register/unregister. If you put a drm_cg_register/unregister
call in there we have a clean separation, and you can track all the
currently active devices however you want. Iterating over objects that
can be hotunplugged any time tends to get really complicated really
quickly.
-Daniel


>
> Kenny
>
> > -Daniel
> >
> > > ---
> > >  drivers/gpu/drm/drm_drv.c      | 19 +++++++++++++++++++
> > >  drivers/gpu/drm/drm_internal.h |  4 ----
> > >  include/drm/drm_drv.h          |  4 ++++
> > >  3 files changed, 23 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > index 862621494a93..000cddabd970 100644
> > > --- a/drivers/gpu/drm/drm_drv.c
> > > +++ b/drivers/gpu/drm/drm_drv.c
> > > @@ -254,11 +254,13 @@ struct drm_minor *drm_minor_acquire(unsigned int minor_id)
> > >
> > >       return minor;
> > >  }
> > > +EXPORT_SYMBOL(drm_minor_acquire);
> > >
> > >  void drm_minor_release(struct drm_minor *minor)
> > >  {
> > >       drm_dev_put(minor->dev);
> > >  }
> > > +EXPORT_SYMBOL(drm_minor_release);
> > >
> > >  /**
> > >   * DOC: driver instance overview
> > > @@ -1078,6 +1080,23 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
> > >  }
> > >  EXPORT_SYMBOL(drm_dev_set_unique);
> > >
> > > +/**
> > > + * drm_minor_for_each - Iterate through all stored DRM minors
> > > + * @fn: Function to be called for each pointer.
> > > + * @data: Data passed to callback function.
> > > + *
> > > + * The callback function will be called for each @drm_minor entry, passing
> > > + * the minor, the entry and @data.
> > > + *
> > > + * If @fn returns anything other than %0, the iteration stops and that
> > > + * value is returned from this function.
> > > + */
> > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data)
> > > +{
> > > +     return idr_for_each(&drm_minors_idr, fn, data);
> > > +}
> > > +EXPORT_SYMBOL(drm_minor_for_each);
> > > +
> > >  /*
> > >   * DRM Core
> > >   * The DRM core module initializes all global DRM objects and makes them
> > > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > > index e19ac7ca602d..6bfad76f8e78 100644
> > > --- a/drivers/gpu/drm/drm_internal.h
> > > +++ b/drivers/gpu/drm/drm_internal.h
> > > @@ -54,10 +54,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
> > >  void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpriv,
> > >                                       struct dma_buf *dma_buf);
> > >
> > > -/* drm_drv.c */
> > > -struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > -void drm_minor_release(struct drm_minor *minor);
> > > -
> > >  /* drm_vblank.c */
> > >  void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
> > >  void drm_vblank_cleanup(struct drm_device *dev);
> > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > > index 68ca736c548d..24f8d054c570 100644
> > > --- a/include/drm/drm_drv.h
> > > +++ b/include/drm/drm_drv.h
> > > @@ -799,5 +799,9 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
> > >
> > >  int drm_dev_set_unique(struct drm_device *dev, const char *name);
> > >
> > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data);
> > > +
> > > +struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > +void drm_minor_release(struct drm_minor *minor);
> > >
> > >  #endif
> > > --
> > > 2.22.0
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
