Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C727141B3D
	for <lists+cgroups@lfdr.de>; Sun, 19 Jan 2020 03:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgASCrY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 18 Jan 2020 21:47:24 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33649 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgASCrY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 18 Jan 2020 21:47:24 -0500
Received: by mail-vk1-f196.google.com with SMTP id i78so7698757vke.0
        for <cgroups@vger.kernel.org>; Sat, 18 Jan 2020 18:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=toJ/dnCaKUSYfpH7tLiOydB3QUX8Gl8IYduDGUuWEgM=;
        b=PnMv387GbmMOGujE1lDwixDkYb4ixdfXzDrv2X6l5ZcYUl0I5vxsJeAUrMQbeNwkac
         A71NTX+4Pv76cdrabckoePKN1bx3hhnmfgEzMp8Fe4T1a75MpHY3CD/Ysu4rxVRO7J5I
         NT0/60FeNRS+5DzjZQpbbntsTqzOQeYiULNa1ldeGZJfpXGKNgVoYRG5e12qSxpz/xpj
         vN7HYTNo0xLEXLcxx3PB5r1SvycuYRQn199WTJpsy322n+mSPdReOUPxRkOy2Om/JRjM
         UC19iCH4hBSqrjYPdrPAIRiVMdihp1+YMTgHaVpkaGEXC75ccV0404uS1iKtV1401G7T
         gfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=toJ/dnCaKUSYfpH7tLiOydB3QUX8Gl8IYduDGUuWEgM=;
        b=NpapATyFhQ/QtdeE0oyxDrmigWl4L5jiGVa/v1jDui2oejNDFlVAX5KU/hAlLBIY5Z
         L7c+PHsygWnyAhIVJjDRY/U2M5S1mGGolSN8FTC1yFAUXjDQyBcNaBolCSOJXSjgG1nv
         RPhIeIA879RyJSfPJp1srsYf5lb7cjB2iKGVH9YRkkUTnbsQ1rf0A6wfjY+7zQyHO9MJ
         fBwQDcN9oswvi8KEW4TC9mw2VeYThbcVtifSk77+SE0rJdjHL4DeOyLaMwtqh5iDtYAp
         ShpvZB6eEXMJlw0/P4OC2e/yy1pqMcIwH02KLjj7OT+E/Gcoaa8wJVRoUyKSH2DAtuic
         0vYQ==
X-Gm-Message-State: APjAAAU0JVxgkHjjJnVE0atGjK0ifbT41E/C3oAaGV6v62jEB91hDUF2
        7nZuoRgSeZz7IojKWrtdpnkQAzWndRaHnBf2gmoDPejC
X-Google-Smtp-Source: APXvYqwGG6ncU/DsmC8PKCzZb+17/D+wcLK8GRPL5vs0sLXHwXUSBA6llHcXMMVV6d/ckr21GKacOYh9/x/4SYS0J1I=
X-Received: by 2002:a1f:db81:: with SMTP id s123mr25585681vkg.45.1579402042030;
 Sat, 18 Jan 2020 18:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20200113153543.24957-1-qiang.yu@amd.com> <20200113153543.24957-4-qiang.yu@amd.com>
 <f2075f28-94a2-1206-ba58-a3a6a32393f3@amd.com>
In-Reply-To: <f2075f28-94a2-1206-ba58-a3a6a32393f3@amd.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 19 Jan 2020 10:47:10 +0800
Message-ID: <CAKGbVbv7P-S_NUYpqQ5opDbXBHRb4rq6m95372nOuZ8kMvGnBQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] drm/ttm: support memcg for ttm_tt
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Qiang Yu <qiang.yu@amd.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        cgroups@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>, Kenny Ho <kenny.ho@amd.com>,
        Michal Hocko <mhocko@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 13, 2020 at 11:56 PM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 13.01.20 um 16:35 schrieb Qiang Yu:
> > Charge TTM allocated system memory to memory cgroup which will
> > limit the memory usage of a group of processes.
>
> NAK to the whole approach. This belongs into the GEM or driver layer,
> but not into TTM.
>
Sorry for responding late.

GEM layer seems not a proper place to handle this as:
1. it is not aware of the back storage (system mem or device mem) unless
we add this information up to GEM which I think is not appropriate
2. system memory allocated by GEM with drm_gem_get_pages() is already
charged to memcg, it's only the ttm system memory not charged to memcg

Implement in driver like amdgpu is an option. But seems the problem is insi=
de
TTM which does not charge pages allocated by itself to memcg, won't it be
better to solve it in TTM so that all drivers using it can benefit? Or you =
just
think we should not rely on memcg for GPU system memory limitation?

> > The memory is always charged to the control group of task which
> > create this buffer object and when it's created. For example,
> > when a buffer is created by process A and exported to process B,
> > then process B populate this buffer, the memory is still charged
> > to process A's memcg; if a buffer is created by process A when in
> > memcg B, then A is moved to memcg C and populate this buffer, it
> > will charge memcg B.
>
> This is actually the most common use case for graphics application where
> the X server allocates most of the backing store.
>
> So we need a better handling than just accounting the memory to whoever
> allocated it first.
>
You mean the application based on DRI2 and X11 protocol draw? I think this
is still reasonable to charge xserver for the memory, because xserver alloc=
ate
the buffer and share to application which is its design and implementation
nature. With DRI3, the buffer is allocated by application, also
suitable for this
approach.

Regards,
Qiang

> Regards,
> Christian.
>
> >
> > Signed-off-by: Qiang Yu <qiang.yu@amd.com>
> > ---
> >   drivers/gpu/drm/ttm/ttm_bo.c         | 10 ++++++++++
> >   drivers/gpu/drm/ttm/ttm_page_alloc.c | 18 +++++++++++++++++-
> >   drivers/gpu/drm/ttm/ttm_tt.c         |  3 +++
> >   include/drm/ttm/ttm_bo_api.h         |  5 +++++
> >   include/drm/ttm/ttm_tt.h             |  4 ++++
> >   5 files changed, 39 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.=
c
> > index 8d91b0428af1..4e64846ee523 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -42,6 +42,7 @@
> >   #include <linux/module.h>
> >   #include <linux/atomic.h>
> >   #include <linux/dma-resv.h>
> > +#include <linux/memcontrol.h>
> >
> >   static void ttm_bo_global_kobj_release(struct kobject *kobj);
> >
> > @@ -162,6 +163,10 @@ static void ttm_bo_release_list(struct kref *list_=
kref)
> >       if (!ttm_bo_uses_embedded_gem_object(bo))
> >               dma_resv_fini(&bo->base._resv);
> >       mutex_destroy(&bo->wu_mutex);
> > +#ifdef CONFIG_MEMCG
> > +     if (bo->memcg)
> > +             css_put(&bo->memcg->css);
> > +#endif
> >       bo->destroy(bo);
> >       ttm_mem_global_free(&ttm_mem_glob, acc_size);
> >   }
> > @@ -1330,6 +1335,11 @@ int ttm_bo_init_reserved(struct ttm_bo_device *b=
dev,
> >       }
> >       atomic_inc(&ttm_bo_glob.bo_count);
> >
> > +#ifdef CONFIG_MEMCG
> > +     if (bo->type =3D=3D ttm_bo_type_device)
> > +             bo->memcg =3D mem_cgroup_driver_get_from_current();
> > +#endif
> > +
> >       /*
> >        * For ttm_bo_type_device buffers, allocate
> >        * address space from the device.
> > diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm=
/ttm_page_alloc.c
> > index b40a4678c296..ecd1831a1d38 100644
> > --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
> > +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> > @@ -42,7 +42,7 @@
> >   #include <linux/seq_file.h> /* for seq_printf */
> >   #include <linux/slab.h>
> >   #include <linux/dma-mapping.h>
> > -
> > +#include <linux/memcontrol.h>
> >   #include <linux/atomic.h>
> >
> >   #include <drm/ttm/ttm_bo_driver.h>
> > @@ -1045,6 +1045,11 @@ ttm_pool_unpopulate_helper(struct ttm_tt *ttm, u=
nsigned mem_count_update)
> >       ttm_put_pages(ttm->pages, ttm->num_pages, ttm->page_flags,
> >                     ttm->caching_state);
> >       ttm->state =3D tt_unpopulated;
> > +
> > +#ifdef CONFIG_MEMCG
> > +     if (ttm->memcg)
> > +             mem_cgroup_uncharge_drvmem(ttm->memcg, ttm->num_pages);
> > +#endif
> >   }
> >
> >   int ttm_pool_populate(struct ttm_tt *ttm, struct ttm_operation_ctx *c=
tx)
> > @@ -1059,6 +1064,17 @@ int ttm_pool_populate(struct ttm_tt *ttm, struct=
 ttm_operation_ctx *ctx)
> >       if (ttm_check_under_lowerlimit(mem_glob, ttm->num_pages, ctx))
> >               return -ENOMEM;
> >
> > +#ifdef CONFIG_MEMCG
> > +     if (ttm->memcg) {
> > +             gfp_t gfp_flags =3D GFP_USER;
> > +             if (ttm->page_flags & TTM_PAGE_FLAG_NO_RETRY)
> > +                     gfp_flags |=3D __GFP_RETRY_MAYFAIL;
> > +             ret =3D mem_cgroup_charge_drvmem(ttm->memcg, gfp_flags, t=
tm->num_pages);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +#endif
> > +
> >       ret =3D ttm_get_pages(ttm->pages, ttm->num_pages, ttm->page_flags=
,
> >                           ttm->caching_state);
> >       if (unlikely(ret !=3D 0)) {
> > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.=
c
> > index e0e9b4f69db6..1acb153084e1 100644
> > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > @@ -233,6 +233,9 @@ void ttm_tt_init_fields(struct ttm_tt *ttm, struct =
ttm_buffer_object *bo,
> >       ttm->state =3D tt_unpopulated;
> >       ttm->swap_storage =3D NULL;
> >       ttm->sg =3D bo->sg;
> > +#ifdef CONFIG_MEMCG
> > +     ttm->memcg =3D bo->memcg;
> > +#endif
> >   }
> >
> >   int ttm_tt_init(struct ttm_tt *ttm, struct ttm_buffer_object *bo,
> > diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.=
h
> > index 65e399d280f7..95a08e81a73e 100644
> > --- a/include/drm/ttm/ttm_bo_api.h
> > +++ b/include/drm/ttm/ttm_bo_api.h
> > @@ -54,6 +54,8 @@ struct ttm_place;
> >
> >   struct ttm_lru_bulk_move;
> >
> > +struct mem_cgroup;
> > +
> >   /**
> >    * struct ttm_bus_placement
> >    *
> > @@ -180,6 +182,9 @@ struct ttm_buffer_object {
> >       void (*destroy) (struct ttm_buffer_object *);
> >       unsigned long num_pages;
> >       size_t acc_size;
> > +#ifdef CONFIG_MEMCG
> > +     struct mem_cgroup *memcg;
> > +#endif
> >
> >       /**
> >       * Members not needing protection.
> > diff --git a/include/drm/ttm/ttm_tt.h b/include/drm/ttm/ttm_tt.h
> > index c0e928abf592..10fb5a557b95 100644
> > --- a/include/drm/ttm/ttm_tt.h
> > +++ b/include/drm/ttm/ttm_tt.h
> > @@ -33,6 +33,7 @@ struct ttm_tt;
> >   struct ttm_mem_reg;
> >   struct ttm_buffer_object;
> >   struct ttm_operation_ctx;
> > +struct mem_cgroup;
> >
> >   #define TTM_PAGE_FLAG_WRITE           (1 << 3)
> >   #define TTM_PAGE_FLAG_SWAPPED         (1 << 4)
> > @@ -116,6 +117,9 @@ struct ttm_tt {
> >               tt_unbound,
> >               tt_unpopulated,
> >       } state;
> > +#ifdef CONFIG_MEMCG
> > +     struct mem_cgroup *memcg;
> > +#endif
> >   };
> >
> >   /**
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
