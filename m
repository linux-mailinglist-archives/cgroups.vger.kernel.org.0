Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34E84A1D33
	for <lists+cgroups@lfdr.de>; Thu, 29 Aug 2019 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfH2Oj5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 29 Aug 2019 10:39:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44189 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfH2Oj4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 29 Aug 2019 10:39:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id b6so905753wrv.11
        for <cgroups@vger.kernel.org>; Thu, 29 Aug 2019 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HEEvYqpbIBBSddwe107UXktHEBs4C3oiZ3ZX2qGo/A8=;
        b=O5nCbLYS7HmGZ+Zv3tLy2NewtP1akcw4UZ0fsyS8Fwt1hRcuTChM14zZ8vh857ZhZ6
         LZdKLTHSBg6ia1ZC+e0t0TCEodPoUmaxXQuDChBCTBUW71FizCi00oVZpgqnXSNmKzIv
         oXSsT7wfLa3bMefvo5eKtcksCsG8wSzFWN4q+dRCCrvYO/hRN6o9jl3DrRdmD4eyFIkK
         qEPRAtUoRFcZltMIGLJFJP0SqwrheWSOmRwFIK/NEPlIMLKRWR6NkzNvRkErS0AvJSM1
         Kt13eXzDlmygRcBuSPVFvQb8qnrgCctSjIID9Kx8BDqrk+iy+5F3UULQlat3fRS5GQAt
         A08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HEEvYqpbIBBSddwe107UXktHEBs4C3oiZ3ZX2qGo/A8=;
        b=EFWfLU07rfGOQA8Jelm3X2J6Ro5R0eZLRBgUsVGllZ1F1KK24lMvt/b/jS6w37cfzb
         N5hY8k/8XxSpcghAJ6w79TfrlTqOC4DuEzevtyifn5Kgn7vJL1wkf1KKxV7Zc7m9OgtT
         G814MVNR/g+mRPvd7Iuwc4EBHPFJ/YDnsekS2bUZlREpwuokRFnptWFKKgg+8bRQjcCL
         Nj/qLuzvfl1NH6IjNy6g7NE+9M9OI+efjtTdYeuC0S4qnobCrgO74am95uSFzg3tGRA+
         4U54tAUPjKrRzPUDKaaYS/60BPIXU5PPiMU6nVcyeTOsGOcbsUUFQsz5DqqHR4KwzhPZ
         qT4A==
X-Gm-Message-State: APjAAAV4LaqPqUqIv4O7CeBXtB6RlJgPmW6Addg8nBdRyCvkmN5/bGWn
        iHyNiASO6gibD3EK8QaQdl91qm3CMyGFRdTL1+M=
X-Google-Smtp-Source: APXvYqwX8DAaXygNFPLXMmjCnSxOeUyWISnDC54GKHZZQjOfVnFt/9OwReHp0RkfQ1jv9HwXHm6DVm+gVg1pEE288wc=
X-Received: by 2002:a05:6000:1603:: with SMTP id u3mr12215236wrb.286.1567089594064;
 Thu, 29 Aug 2019 07:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190829060533.32315-1-Kenny.Ho@amd.com> <20190829060533.32315-14-Kenny.Ho@amd.com>
 <464ad318-48dd-3f78-d82b-83a8e7175ff9@amd.com> <CAOWid-dzJiqjH9+=36fFYh87OKOzToMDcJZpepOWdjoXpBSF8A@mail.gmail.com>
 <f6963293-bebe-0dca-b509-799f9096ca91@amd.com>
In-Reply-To: <f6963293-bebe-0dca-b509-799f9096ca91@amd.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Thu, 29 Aug 2019 10:39:42 -0400
Message-ID: <CAOWid-c0Pbu+akFeBDVkqLuO2Rw-SPPuPDTx829WvjYeCQZygQ@mail.gmail.com>
Subject: Re: [PATCH RFC v4 13/16] drm, cgroup: Allow more aggressive memory reclaim
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "Ho, Kenny" <Kenny.Ho@amd.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Greathouse, Joseph" <Joseph.Greathouse@amd.com>,
        "jsparks@cray.com" <jsparks@cray.com>,
        "lkaplan@cray.com" <lkaplan@cray.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Yes, and I think it has quite a lot of coupling with mm's page and
pressure mechanisms.  My current thought is to just copy the API but
have a separate implementation of "ttm_shrinker" and
"ttm_shrinker_control" or something like that.  I am certainly happy
to listen to additional feedbacks and suggestions.

Regards,
Kenny


On Thu, Aug 29, 2019 at 10:12 AM Koenig, Christian
<Christian.Koenig@amd.com> wrote:
>
> Yeah, that's also a really good idea as well.
>
> The problem with the shrinker API is that it only applies to system memor=
y currently.
>
> So you won't have a distinction which domain you need to evict stuff from=
.
>
> Regards,
> Christian.
>
> Am 29.08.19 um 16:07 schrieb Kenny Ho:
>
> Thanks for the feedback Christian.  I am still digging into this one.  Da=
niel suggested leveraging the Shrinker API for the functionality of this co=
mmit in RFC v3 but I am still trying to figure it out how/if ttm fit with s=
hrinker (though the idea behind the shrinker API seems fairly straightforwa=
rd as far as I understand it currently.)
>
> Regards,
> Kenny
>
> On Thu, Aug 29, 2019 at 3:08 AM Koenig, Christian <Christian.Koenig@amd.c=
om> wrote:
>>
>> Am 29.08.19 um 08:05 schrieb Kenny Ho:
>> > Allow DRM TTM memory manager to register a work_struct, such that, whe=
n
>> > a drmcgrp is under memory pressure, memory reclaiming can be triggered
>> > immediately.
>> >
>> > Change-Id: I25ac04e2db9c19ff12652b88ebff18b44b2706d8
>> > Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
>> > ---
>> >   drivers/gpu/drm/ttm/ttm_bo.c    | 49 +++++++++++++++++++++++++++++++=
++
>> >   include/drm/drm_cgroup.h        | 16 +++++++++++
>> >   include/drm/ttm/ttm_bo_driver.h |  2 ++
>> >   kernel/cgroup/drm.c             | 30 ++++++++++++++++++++
>> >   4 files changed, 97 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo=
.c
>> > index d7e3d3128ebb..72efae694b7e 100644
>> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> > @@ -1590,6 +1590,46 @@ int ttm_bo_evict_mm(struct ttm_bo_device *bdev,=
 unsigned mem_type)
>> >   }
>> >   EXPORT_SYMBOL(ttm_bo_evict_mm);
>> >
>> > +static void ttm_bo_reclaim_wq(struct work_struct *work)
>> > +{
>> > +     struct ttm_operation_ctx ctx =3D {
>> > +             .interruptible =3D false,
>> > +             .no_wait_gpu =3D false,
>> > +             .flags =3D TTM_OPT_FLAG_FORCE_ALLOC
>> > +     };
>> > +     struct ttm_mem_type_manager *man =3D
>> > +         container_of(work, struct ttm_mem_type_manager, reclaim_wq);
>> > +     struct ttm_bo_device *bdev =3D man->bdev;
>> > +     struct dma_fence *fence;
>> > +     int mem_type;
>> > +     int ret;
>> > +
>> > +     for (mem_type =3D 0; mem_type < TTM_NUM_MEM_TYPES; mem_type++)
>> > +             if (&bdev->man[mem_type] =3D=3D man)
>> > +                     break;
>> > +
>> > +     WARN_ON(mem_type >=3D TTM_NUM_MEM_TYPES);
>> > +     if (mem_type >=3D TTM_NUM_MEM_TYPES)
>> > +             return;
>> > +
>> > +     if (!drmcg_mem_pressure_scan(bdev, mem_type))
>> > +             return;
>> > +
>> > +     ret =3D ttm_mem_evict_first(bdev, mem_type, NULL, &ctx, NULL);
>> > +     if (ret)
>> > +             return;
>> > +
>> > +     spin_lock(&man->move_lock);
>> > +     fence =3D dma_fence_get(man->move);
>> > +     spin_unlock(&man->move_lock);
>> > +
>> > +     if (fence) {
>> > +             ret =3D dma_fence_wait(fence, false);
>> > +             dma_fence_put(fence);
>> > +     }
>>
>> Why do you want to block for the fence here? That is a rather bad idea
>> and would break pipe-lining.
>>
>> Apart from that I don't think we should put that into TTM.
>>
>> Instead drmcg_register_device_mm() should get a function pointer which
>> is called from a work item when the group is under pressure.
>>
>> TTM can then provides the function which can be called, but the actually
>> registration is job of the device and not TTM.
>>
>> Regards,
>> Christian.
>>
>> > +
>> > +}
>> > +
>> >   int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
>> >                       unsigned long p_size)
>> >   {
>> > @@ -1624,6 +1664,13 @@ int ttm_bo_init_mm(struct ttm_bo_device *bdev, =
unsigned type,
>> >               INIT_LIST_HEAD(&man->lru[i]);
>> >       man->move =3D NULL;
>> >
>> > +     pr_err("drmcg %p type %d\n", bdev->ddev, type);
>> > +
>> > +     if (type <=3D TTM_PL_VRAM) {
>> > +             INIT_WORK(&man->reclaim_wq, ttm_bo_reclaim_wq);
>> > +             drmcg_register_device_mm(bdev->ddev, type, &man->reclaim=
_wq);
>> > +     }
>> > +
>> >       return 0;
>> >   }
>> >   EXPORT_SYMBOL(ttm_bo_init_mm);
>> > @@ -1701,6 +1748,8 @@ int ttm_bo_device_release(struct ttm_bo_device *=
bdev)
>> >               man =3D &bdev->man[i];
>> >               if (man->has_type) {
>> >                       man->use_type =3D false;
>> > +                     drmcg_unregister_device_mm(bdev->ddev, i);
>> > +                     cancel_work_sync(&man->reclaim_wq);
>> >                       if ((i !=3D TTM_PL_SYSTEM) && ttm_bo_clean_mm(bd=
ev, i)) {
>> >                               ret =3D -EBUSY;
>> >                               pr_err("DRM memory manager type %d is no=
t clean\n",
>> > diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
>> > index c11df388fdf2..6d9707e1eb72 100644
>> > --- a/include/drm/drm_cgroup.h
>> > +++ b/include/drm/drm_cgroup.h
>> > @@ -5,6 +5,7 @@
>> >   #define __DRM_CGROUP_H__
>> >
>> >   #include <linux/cgroup_drm.h>
>> > +#include <linux/workqueue.h>
>> >   #include <drm/ttm/ttm_bo_api.h>
>> >   #include <drm/ttm/ttm_bo_driver.h>
>> >
>> > @@ -25,12 +26,17 @@ struct drmcg_props {
>> >       s64                     mem_bw_avg_bytes_per_us_default;
>> >
>> >       s64                     mem_highs_default[TTM_PL_PRIV+1];
>> > +
>> > +     struct work_struct      *mem_reclaim_wq[TTM_PL_PRIV];
>> >   };
>> >
>> >   #ifdef CONFIG_CGROUP_DRM
>> >
>> >   void drmcg_device_update(struct drm_device *device);
>> >   void drmcg_device_early_init(struct drm_device *device);
>> > +void drmcg_register_device_mm(struct drm_device *dev, unsigned int ty=
pe,
>> > +             struct work_struct *wq);
>> > +void drmcg_unregister_device_mm(struct drm_device *dev, unsigned int =
type);
>> >   bool drmcg_try_chg_bo_alloc(struct drmcg *drmcg, struct drm_device *=
dev,
>> >               size_t size);
>> >   void drmcg_unchg_bo_alloc(struct drmcg *drmcg, struct drm_device *de=
v,
>> > @@ -53,6 +59,16 @@ static inline void drmcg_device_early_init(struct d=
rm_device *device)
>> >   {
>> >   }
>> >
>> > +static inline void drmcg_register_device_mm(struct drm_device *dev,
>> > +             unsigned int type, struct work_struct *wq)
>> > +{
>> > +}
>> > +
>> > +static inline void drmcg_unregister_device_mm(struct drm_device *dev,
>> > +             unsigned int type)
>> > +{
>> > +}
>> > +
>> >   static inline void drmcg_try_chg_bo_alloc(struct drmcg *drmcg,
>> >               struct drm_device *dev, size_t size)
>> >   {
>> > diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_=
driver.h
>> > index e1a805d65b83..529cef92bcf6 100644
>> > --- a/include/drm/ttm/ttm_bo_driver.h
>> > +++ b/include/drm/ttm/ttm_bo_driver.h
>> > @@ -205,6 +205,8 @@ struct ttm_mem_type_manager {
>> >        * Protected by @move_lock.
>> >        */
>> >       struct dma_fence *move;
>> > +
>> > +     struct work_struct reclaim_wq;
>> >   };
>> >
>> >   /**
>> > diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
>> > index 04fb9a398740..0ea7f0619e25 100644
>> > --- a/kernel/cgroup/drm.c
>> > +++ b/kernel/cgroup/drm.c
>> > @@ -804,6 +804,29 @@ void drmcg_device_early_init(struct drm_device *d=
ev)
>> >   }
>> >   EXPORT_SYMBOL(drmcg_device_early_init);
>> >
>> > +void drmcg_register_device_mm(struct drm_device *dev, unsigned int ty=
pe,
>> > +             struct work_struct *wq)
>> > +{
>> > +     if (dev =3D=3D NULL || type >=3D TTM_PL_PRIV)
>> > +             return;
>> > +
>> > +     mutex_lock(&drmcg_mutex);
>> > +     dev->drmcg_props.mem_reclaim_wq[type] =3D wq;
>> > +     mutex_unlock(&drmcg_mutex);
>> > +}
>> > +EXPORT_SYMBOL(drmcg_register_device_mm);
>> > +
>> > +void drmcg_unregister_device_mm(struct drm_device *dev, unsigned int =
type)
>> > +{
>> > +     if (dev =3D=3D NULL || type >=3D TTM_PL_PRIV)
>> > +             return;
>> > +
>> > +     mutex_lock(&drmcg_mutex);
>> > +     dev->drmcg_props.mem_reclaim_wq[type] =3D NULL;
>> > +     mutex_unlock(&drmcg_mutex);
>> > +}
>> > +EXPORT_SYMBOL(drmcg_unregister_device_mm);
>> > +
>> >   /**
>> >    * drmcg_try_chg_bo_alloc - charge GEM buffer usage for a device and=
 cgroup
>> >    * @drmcg: the DRM cgroup to be charged to
>> > @@ -1013,6 +1036,13 @@ void drmcg_mem_track_move(struct ttm_buffer_obj=
ect *old_bo, bool evict,
>> >
>> >               ddr->mem_bw_stats[DRMCG_MEM_BW_ATTR_BYTE_CREDIT]
>> >                       -=3D move_in_bytes;
>> > +
>> > +             if (dev->drmcg_props.mem_reclaim_wq[new_mem_type]
>> > +                     !=3D NULL &&
>> > +                     ddr->mem_stats[new_mem_type] >
>> > +                             ddr->mem_highs[new_mem_type])
>> > +                     schedule_work(dev->
>> > +                             drmcg_props.mem_reclaim_wq[new_mem_type]=
);
>> >       }
>> >       mutex_unlock(&dev->drmcg_mutex);
>> >   }
>>
>
