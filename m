Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E14A7E86
	for <lists+cgroups@lfdr.de>; Wed,  4 Sep 2019 10:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfIDIyk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Sep 2019 04:54:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40657 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfIDIyj (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Sep 2019 04:54:39 -0400
Received: by mail-ed1-f65.google.com with SMTP id v38so15786890edm.7
        for <cgroups@vger.kernel.org>; Wed, 04 Sep 2019 01:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7M8KqRr09YF2rG8v6AhiYJ7DMek/7P3q9PGby+XNdwE=;
        b=K5c+5IU7CQQBJ63s79t0CUwN/Dcwlx65PillLY/bzbxkCxxMQv/vFW0lYLR1cBC6eQ
         KDlVWPuaxe6u1DIFg5JPjlAi74ec1cYC+NsGqmTIqm0lMf1jHL8tc97UK+V9R0Q9biBz
         77Cw3FQnRblBQpCcLtfLhjUnsbdppoZB7vvGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7M8KqRr09YF2rG8v6AhiYJ7DMek/7P3q9PGby+XNdwE=;
        b=JJyWP2DFfxgQvxCbdJbB13m4KlvGy4bzO4vQpUMHyEFaMinxcwal3eioDTQRhTbYal
         7pkt2M7KQ8zYIEvzLlCrEAufvwuAo9Aummw/E+diupr1FJVI8GUZwq/kYU3VkBBxhaG7
         8eWaMBeWs/o/bqcOS8D7K5rXYaaWQRpZduCBT0RdEnE0kzPxkeDANTkmzzowbArbOh7u
         BkXnPQSHt7mZuYT6drnJ2wHd/Sdm4iHMpcQijrlRV9Npfy7Dmr8wbTzm1LxfhNPuk1AZ
         z4XuCR59yJqHEJLcy0mr39Oy2ueAG9ik396/I87XEn/Uie1GtQrQYeDdkuui1bdszAjM
         08zA==
X-Gm-Message-State: APjAAAX34fiSpRSSS6ltTzvsLAgtMdXAkd52t+rQnJFNkU8jvBqnNVst
        EnnBdnEtGbebonDzdmpXvo8LoQ==
X-Google-Smtp-Source: APXvYqwafUqSHorSCctZ9Hg75EMvqHVYqAbeN+Q+inZcpQnZ04EnucMAsmDpuIPvzsxHSWa/S/pEoQ==
X-Received: by 2002:a05:6402:168f:: with SMTP id a15mr39835890edv.5.1567587277371;
        Wed, 04 Sep 2019 01:54:37 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id v8sm1615204ejk.29.2019.09.04.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 01:54:36 -0700 (PDT)
Date:   Wed, 4 Sep 2019 10:54:34 +0200
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
Message-ID: <20190904085434.GF2112@phenom.ffwll.local>
References: <20190829060533.32315-1-Kenny.Ho@amd.com>
 <20190829060533.32315-2-Kenny.Ho@amd.com>
 <20190903075719.GK2112@phenom.ffwll.local>
 <CAOWid-dxxDhyxP2+0R0oKAk29rR-1TbMyhshR1+gbcpGJCAW6g@mail.gmail.com>
 <CAKMK7uEofjdVURu+meonh_YdV5eX8vfNALkW3A_+kLapCV8j+w@mail.gmail.com>
 <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOWid-eUVztW4hNVpznnJRcwHcjCirGL2aS75p4OY8XoGuJqUg@mail.gmail.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Sep 03, 2019 at 04:43:45PM -0400, Kenny Ho wrote:
> On Tue, Sep 3, 2019 at 4:12 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Tue, Sep 3, 2019 at 9:45 PM Kenny Ho <y2kenny@gmail.com> wrote:
> > > On Tue, Sep 3, 2019 at 3:57 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > > Iterating over minors for cgroups sounds very, very wrong. Why do we care
> > > > whether a buffer was allocated through kms dumb vs render nodes?
> > > >
> > > > I'd expect all the cgroup stuff to only work on drm_device, if it does
> > > > care about devices.
> > > >
> > > > (I didn't look through the patch series to find out where exactly you're
> > > > using this, so maybe I'm off the rails here).
> > >
> > > I am exposing this to remove the need to keep track of a separate list
> > > of available drm_device in the system (to remove the registering and
> > > unregistering of drm_device to the cgroup subsystem and just use
> > > drm_minor as the single source of truth.)  I am only filtering out the
> > > render nodes minor because they point to the same drm_device and is
> > > confusing.
> > >
> > > Perhaps I missed an obvious way to list the drm devices without
> > > iterating through the drm_minors?  (I probably jumped to the minors
> > > because $major:$minor is the convention to address devices in cgroup.)
> >
> > Create your own if there's nothing, because you need to anyway:
> > - You need special locking anyway, we can't just block on the idr lock
> > for everything.
> > - This needs to refcount drm_device, no the minors.
> >
> > Iterating over stuff still feels kinda wrong still, because normally
> > the way we register/unregister userspace api (and cgroups isn't
> > anything else from a drm driver pov) is by adding more calls to
> > drm_dev_register/unregister. If you put a drm_cg_register/unregister
> > call in there we have a clean separation, and you can track all the
> > currently active devices however you want. Iterating over objects that
> > can be hotunplugged any time tends to get really complicated really
> > quickly.
> 
> Um... I thought this is what I had previously.  Did I misunderstood
> your feedback from v3?  Doesn't drm_minor already include all these
> facilities so isn't creating my own kind of reinventing the wheel?
> (as I did previously?)  drm_minor_register is called inside
> drm_dev_register so isn't leveraging existing drm_minor facilities
> much better solution?

Hm the previous version already dropped out of my inbox, so hard to find
it again. And I couldn't find this in archieves. Do you have pointers?

I thought the previous version did cgroup init separately from drm_device
setup, and I guess I suggested that it should be moved int
drm_dev_register/unregister?

Anyway, I don't think reusing the drm_minor registration makes sense,
since we want to be on the drm_device, not on the minor. Which is a bit
awkward for cgroups, which wants to identify devices using major.minor
pairs. But I guess drm is the first subsystem where 1 device can be
exposed through multiple minors ...

Tejun, any suggestions on this?

Anyway, I think just leveraging existing code because it can be abused to
make it fit for us doesn't make sense. E.g. for the kms side we also don't
piggy-back on top of drm_minor_register (it would be technically
possible), but instead we have drm_modeset_register_all().
-Daniel

> 
> Kenny
> 
> >
> >
> > >
> > > Kenny
> > >
> > > > -Daniel
> > > >
> > > > > ---
> > > > >  drivers/gpu/drm/drm_drv.c      | 19 +++++++++++++++++++
> > > > >  drivers/gpu/drm/drm_internal.h |  4 ----
> > > > >  include/drm/drm_drv.h          |  4 ++++
> > > > >  3 files changed, 23 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > > > index 862621494a93..000cddabd970 100644
> > > > > --- a/drivers/gpu/drm/drm_drv.c
> > > > > +++ b/drivers/gpu/drm/drm_drv.c
> > > > > @@ -254,11 +254,13 @@ struct drm_minor *drm_minor_acquire(unsigned int minor_id)
> > > > >
> > > > >       return minor;
> > > > >  }
> > > > > +EXPORT_SYMBOL(drm_minor_acquire);
> > > > >
> > > > >  void drm_minor_release(struct drm_minor *minor)
> > > > >  {
> > > > >       drm_dev_put(minor->dev);
> > > > >  }
> > > > > +EXPORT_SYMBOL(drm_minor_release);
> > > > >
> > > > >  /**
> > > > >   * DOC: driver instance overview
> > > > > @@ -1078,6 +1080,23 @@ int drm_dev_set_unique(struct drm_device *dev, const char *name)
> > > > >  }
> > > > >  EXPORT_SYMBOL(drm_dev_set_unique);
> > > > >
> > > > > +/**
> > > > > + * drm_minor_for_each - Iterate through all stored DRM minors
> > > > > + * @fn: Function to be called for each pointer.
> > > > > + * @data: Data passed to callback function.
> > > > > + *
> > > > > + * The callback function will be called for each @drm_minor entry, passing
> > > > > + * the minor, the entry and @data.
> > > > > + *
> > > > > + * If @fn returns anything other than %0, the iteration stops and that
> > > > > + * value is returned from this function.
> > > > > + */
> > > > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data)
> > > > > +{
> > > > > +     return idr_for_each(&drm_minors_idr, fn, data);
> > > > > +}
> > > > > +EXPORT_SYMBOL(drm_minor_for_each);
> > > > > +
> > > > >  /*
> > > > >   * DRM Core
> > > > >   * The DRM core module initializes all global DRM objects and makes them
> > > > > diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
> > > > > index e19ac7ca602d..6bfad76f8e78 100644
> > > > > --- a/drivers/gpu/drm/drm_internal.h
> > > > > +++ b/drivers/gpu/drm/drm_internal.h
> > > > > @@ -54,10 +54,6 @@ void drm_prime_destroy_file_private(struct drm_prime_file_private *prime_fpriv);
> > > > >  void drm_prime_remove_buf_handle_locked(struct drm_prime_file_private *prime_fpriv,
> > > > >                                       struct dma_buf *dma_buf);
> > > > >
> > > > > -/* drm_drv.c */
> > > > > -struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > > > -void drm_minor_release(struct drm_minor *minor);
> > > > > -
> > > > >  /* drm_vblank.c */
> > > > >  void drm_vblank_disable_and_save(struct drm_device *dev, unsigned int pipe);
> > > > >  void drm_vblank_cleanup(struct drm_device *dev);
> > > > > diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> > > > > index 68ca736c548d..24f8d054c570 100644
> > > > > --- a/include/drm/drm_drv.h
> > > > > +++ b/include/drm/drm_drv.h
> > > > > @@ -799,5 +799,9 @@ static inline bool drm_drv_uses_atomic_modeset(struct drm_device *dev)
> > > > >
> > > > >  int drm_dev_set_unique(struct drm_device *dev, const char *name);
> > > > >
> > > > > +int drm_minor_for_each(int (*fn)(int id, void *p, void *data), void *data);
> > > > > +
> > > > > +struct drm_minor *drm_minor_acquire(unsigned int minor_id);
> > > > > +void drm_minor_release(struct drm_minor *minor);
> > > > >
> > > > >  #endif
> > > > > --
> > > > > 2.22.0
> > > > >
> > > >
> > > > --
> > > > Daniel Vetter
> > > > Software Engineer, Intel Corporation
> > > > http://blog.ffwll.ch
> >
> >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > +41 (0) 79 365 57 48 - http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
