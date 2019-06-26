Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBEE5748E
	for <lists+cgroups@lfdr.de>; Thu, 27 Jun 2019 00:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfFZWxF (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 18:53:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40215 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfFZWxF (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 18:53:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id p11so174218wre.7
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 15:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SS2shp3mQopgi1vy4YYq3FubM30esVvxJIb8teQu3Zk=;
        b=BJ0lJtRKMVG4uL8G+16377TCWCoww9rPvBbv8kq15qH+lspE4KT63yQiTBc/9/r5Fl
         ghdpiNYwVOJz0cOCucI4re3QpEMFhRY62COUpme2HY9SN649/lgVcMwk8auSFwTI1zuS
         41m7c+eoFR6KBWtZO6HK2io4H0dDK8Z2UlELrQOXVgDhWr+xs4PPz7lJ5ZOKFHWQ2jKD
         hXWHZ4sqlMmH7Puj/tIOv4g+WbjOiERxG/1KzJGLqVKauKHlodmRsEj2UI2v8F2YZSZI
         vbjU1GlS86gA0sH7552dbGWdNme5YG+U/KUBEIETWJxYXal2YRwiN7IdeafCSzpG9GIL
         Q6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SS2shp3mQopgi1vy4YYq3FubM30esVvxJIb8teQu3Zk=;
        b=Kky7iNUZENy2ci7M235drp6PyovK/BjnVEj9J+7VmdJwv59OPGkhuEILTm1RqiDrp2
         7Q+YpO3k5FOMeBe6Ewn+aOCegJyFaPdDuLufFEL5gagM6UQxFvHCimficoPaK1JMyGtL
         UAKYaXkSHU6PqKjwLGoL6vMOGUjmrN93GHtqM+9tGi18X+osQFuwaBlr9nXfkJvSauig
         pLj9UxtIpDis7Int6/xXbUjIptwsFNOiYfxQwXKQNWrl3CiX/GUxQSGRgtvJ8mSEbMdq
         4sVBgDuhuSor5T7s33te6sH/9fuDx61bLp+gSIOJOfWVZMy5+5riXZ0mU1+AT86+H6pi
         7ztw==
X-Gm-Message-State: APjAAAXSZn+h6/82EbWCZGoOMzFyE653d7J7cyNSYnzzelO0/wTWEKn3
        5yLqEza3pKcBQnNBLBY+5nF/D8gnjz5feqlbX+w=
X-Google-Smtp-Source: APXvYqzhNDdsz2mnspVuK62GWYvNc0epl9L2hZk04XwfncoHq0gf+qjHj6R21tA/7ZjcieY3/FzLaQELUTyV9jbQHpU=
X-Received: by 2002:adf:e442:: with SMTP id t2mr154881wrm.286.1561589581691;
 Wed, 26 Jun 2019 15:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190626150522.11618-1-Kenny.Ho@amd.com> <20190626150522.11618-12-Kenny.Ho@amd.com>
 <20190626164444.GX12905@phenom.ffwll.local>
In-Reply-To: <20190626164444.GX12905@phenom.ffwll.local>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Wed, 26 Jun 2019 18:52:50 -0400
Message-ID: <CAOWid-dr8eQfJiUWXMeD_O_jm0wmxSd9k0aSqD9kmTKNapk6Kw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 11/11] drm, cgroup: Allow more aggressive memory reclaim
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

Ok.  I am not too familiar with shrinker but I will dig into it.  Just
so that I am looking into the right things, you are referring to
things like struct shrinker and struct shrink_control?

Regards,
Kenny

On Wed, Jun 26, 2019 at 12:44 PM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Wed, Jun 26, 2019 at 11:05:22AM -0400, Kenny Ho wrote:
> > Allow DRM TTM memory manager to register a work_struct, such that, when
> > a drmcgrp is under memory pressure, memory reclaiming can be triggered
> > immediately.
> >
> > Change-Id: I25ac04e2db9c19ff12652b88ebff18b44b2706d8
> > Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> > ---
> >  drivers/gpu/drm/ttm/ttm_bo.c    | 47 +++++++++++++++++++++++++++++++++
> >  include/drm/drm_cgroup.h        | 14 ++++++++++
> >  include/drm/ttm/ttm_bo_driver.h |  2 ++
> >  kernel/cgroup/drm.c             | 33 +++++++++++++++++++++++
> >  4 files changed, 96 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > index 79c530f4a198..5fc3bc5bd4c5 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -1509,6 +1509,44 @@ int ttm_bo_evict_mm(struct ttm_bo_device *bdev, unsigned mem_type)
> >  }
> >  EXPORT_SYMBOL(ttm_bo_evict_mm);
> >
> > +static void ttm_bo_reclaim_wq(struct work_struct *work)
> > +{
>
> I think a design a bit more inspired by memcg aware core shrinkers would
> be nice, i.e. explicitly passing:
> - which drm_cgroup needs to be shrunk
> - which ttm_mem_reg (well the fancy new abstracted out stuff for tracking
>   special gpu memory resources like tt or vram or whatever)
> - how much it needs to be shrunk
>
> I think with that a lot more the book-keeping could be pushed into the
> drm_cgroup code, and the callback just needs to actually shrink enough as
> requested.
> -Daniel
>
> > +     struct ttm_operation_ctx ctx = {
> > +             .interruptible = false,
> > +             .no_wait_gpu = false,
> > +             .flags = TTM_OPT_FLAG_FORCE_ALLOC
> > +     };
> > +     struct ttm_mem_type_manager *man =
> > +         container_of(work, struct ttm_mem_type_manager, reclaim_wq);
> > +     struct ttm_bo_device *bdev = man->bdev;
> > +     struct dma_fence *fence;
> > +     int mem_type;
> > +     int ret;
> > +
> > +     for (mem_type = 0; mem_type < TTM_NUM_MEM_TYPES; mem_type++)
> > +             if (&bdev->man[mem_type] == man)
> > +                     break;
> > +
> > +     BUG_ON(mem_type >= TTM_NUM_MEM_TYPES);
> > +
> > +     if (!drmcgrp_mem_pressure_scan(bdev, mem_type))
> > +             return;
> > +
> > +     ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx);
> > +     if (ret)
> > +             return;
> > +
> > +     spin_lock(&man->move_lock);
> > +     fence = dma_fence_get(man->move);
> > +     spin_unlock(&man->move_lock);
> > +
> > +     if (fence) {
> > +             ret = dma_fence_wait(fence, false);
> > +             dma_fence_put(fence);
> > +     }
> > +
> > +}
> > +
> >  int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
> >                       unsigned long p_size)
> >  {
> > @@ -1543,6 +1581,13 @@ int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
> >               INIT_LIST_HEAD(&man->lru[i]);
> >       man->move = NULL;
> >
> > +     pr_err("drmcgrp %p type %d\n", bdev->ddev, type);
> > +
> > +     if (type <= TTM_PL_VRAM) {
> > +             INIT_WORK(&man->reclaim_wq, ttm_bo_reclaim_wq);
> > +             drmcgrp_register_device_mm(bdev->ddev, type, &man->reclaim_wq);
> > +     }
> > +
> >       return 0;
> >  }
> >  EXPORT_SYMBOL(ttm_bo_init_mm);
> > @@ -1620,6 +1665,8 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
> >               man = &bdev->man[i];
> >               if (man->has_type) {
> >                       man->use_type = false;
> > +                     drmcgrp_unregister_device_mm(bdev->ddev, i);
> > +                     cancel_work_sync(&man->reclaim_wq);
> >                       if ((i != TTM_PL_SYSTEM) && ttm_bo_clean_mm(bdev, i)) {
> >                               ret = -EBUSY;
> >                               pr_err("DRM memory manager type %d is not clean\n",
> > diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> > index 360c1e6c809f..134d6e5475f3 100644
> > --- a/include/drm/drm_cgroup.h
> > +++ b/include/drm/drm_cgroup.h
> > @@ -5,6 +5,7 @@
> >  #define __DRM_CGROUP_H__
> >
> >  #include <linux/cgroup_drm.h>
> > +#include <linux/workqueue.h>
> >  #include <drm/ttm/ttm_bo_api.h>
> >  #include <drm/ttm/ttm_bo_driver.h>
> >
> > @@ -12,6 +13,9 @@
> >
> >  int drmcgrp_register_device(struct drm_device *device);
> >  int drmcgrp_unregister_device(struct drm_device *device);
> > +void drmcgrp_register_device_mm(struct drm_device *dev, unsigned type,
> > +             struct work_struct *wq);
> > +void drmcgrp_unregister_device_mm(struct drm_device *dev, unsigned type);
> >  bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
> >               struct drmcgrp *relative);
> >  void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> > @@ -40,6 +44,16 @@ static inline int drmcgrp_unregister_device(struct drm_device *device)
> >       return 0;
> >  }
> >
> > +static inline void drmcgrp_register_device_mm(struct drm_device *dev,
> > +             unsigned type, struct work_struct *wq)
> > +{
> > +}
> > +
> > +static inline void drmcgrp_unregister_device_mm(struct drm_device *dev,
> > +             unsigned type)
> > +{
> > +}
> > +
> >  static inline bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
> >               struct drmcgrp *relative)
> >  {
> > diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> > index 4cbcb41e5aa9..0956ca7888fc 100644
> > --- a/include/drm/ttm/ttm_bo_driver.h
> > +++ b/include/drm/ttm/ttm_bo_driver.h
> > @@ -205,6 +205,8 @@ struct ttm_mem_type_manager {
> >        * Protected by @move_lock.
> >        */
> >       struct dma_fence *move;
> > +
> > +     struct work_struct reclaim_wq;
> >  };
> >
> >  /**
> > diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> > index 1ce13db36ce9..985a89e849d3 100644
> > --- a/kernel/cgroup/drm.c
> > +++ b/kernel/cgroup/drm.c
> > @@ -31,6 +31,8 @@ struct drmcgrp_device {
> >       s64                     mem_bw_avg_bytes_per_us_default;
> >
> >       s64                     mem_highs_default[TTM_PL_PRIV+1];
> > +
> > +     struct work_struct      *mem_reclaim_wq[TTM_PL_PRIV];
> >  };
> >
> >  #define DRMCG_CTF_PRIV_SIZE 3
> > @@ -793,6 +795,31 @@ int drmcgrp_unregister_device(struct drm_device *dev)
> >  }
> >  EXPORT_SYMBOL(drmcgrp_unregister_device);
> >
> > +void drmcgrp_register_device_mm(struct drm_device *dev, unsigned type,
> > +             struct work_struct *wq)
> > +{
> > +     if (dev == NULL || dev->primary->index > max_minor
> > +                     || type >= TTM_PL_PRIV)
> > +             return;
> > +
> > +     mutex_lock(&drmcgrp_mutex);
> > +     known_drmcgrp_devs[dev->primary->index]->mem_reclaim_wq[type] = wq;
> > +     mutex_unlock(&drmcgrp_mutex);
> > +}
> > +EXPORT_SYMBOL(drmcgrp_register_device_mm);
> > +
> > +void drmcgrp_unregister_device_mm(struct drm_device *dev, unsigned type)
> > +{
> > +     if (dev == NULL || dev->primary->index > max_minor
> > +                     || type >= TTM_PL_PRIV)
> > +             return;
> > +
> > +     mutex_lock(&drmcgrp_mutex);
> > +     known_drmcgrp_devs[dev->primary->index]->mem_reclaim_wq[type] = NULL;
> > +     mutex_unlock(&drmcgrp_mutex);
> > +}
> > +EXPORT_SYMBOL(drmcgrp_unregister_device_mm);
> > +
> >  bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self, struct drmcgrp *relative)
> >  {
> >       for (; self != NULL; self = parent_drmcgrp(self))
> > @@ -1004,6 +1031,12 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
> >
> >               ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
> >                       -= move_in_bytes;
> > +
> > +             if (known_dev->mem_reclaim_wq[new_mem_type] != NULL &&
> > +                        ddr->mem_stats[new_mem_type] >
> > +                             ddr->mem_highs[new_mem_type])
> > +                     schedule_work(
> > +                             known_dev->mem_reclaim_wq[new_mem_type]);
> >       }
> >       mutex_unlock(&known_dev->mutex);
> >  }
> > --
> > 2.21.0
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
