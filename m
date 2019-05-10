Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B92F419FAC
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfEJO6J (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 10:58:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41677 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbfEJO6J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 10:58:09 -0400
Received: by mail-oi1-f196.google.com with SMTP id y10so4714214oia.8
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 07:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZNukLxHLYqOgz3KFm/gDcl1LP54QqCv58XglXz+3WIM=;
        b=QFfYp4VrHzZ6rxOiFkS614oskcEZaHsDXiINrSWdu1RZfl4g176uCgB0ZWXOhoxR1U
         meK03VkqOELmYm0P50+GJv5umylty2kezZMvFI+zHwwWs7xsRNvn8XCIKHU1D/uzq8GS
         mZcfiM+2Bz9ihR6kaix7NwjccCSv+qRv+8ZyHkQpH8dnQ9TzFVJHQx3V4pRfNlrkkFnF
         GkhPnH5r8f2Tph6PJlJmhQAGarzZFwFO7E1vh1Ee3vM+iHPcXktafjogVDMpW3C5//mZ
         nGTHtmfBsam1qHErgkW6kdB6dB5VJ0uli+YmvtNDKDhcqVvQNm9w3HqCQ8jt+9e7A0CF
         0iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZNukLxHLYqOgz3KFm/gDcl1LP54QqCv58XglXz+3WIM=;
        b=C15UjFPELCrA/u3j/nHAKvEj7on/XHHc6QKVQRdoAS1qozhM47QhslnnpePJTNWKIL
         7j7U5Nf4ptGs7nusomNlFu5Pf7OPPDHEyK7rgE3ztaiD40Za6KignJBTZX/lexXqzg77
         pApmj0pq7RBHpVt9aK4KekUgTgISs7CoWpTJxpBA7uqxt/tKwQqi7valuql7AvJnOWFi
         uG5BVmXXHC0zAVufKm1WA1CMKICLWnRtXj8TEzYQKfvQ+EI9eWAmz+lpsDo4JFlduEIK
         /d7gMHQp/9a5r5dRLzd404TNqKiCd3kiTK+tYxywaaIyYe+A56Oj1EVaa2BQhPA8eEGz
         FlTQ==
X-Gm-Message-State: APjAAAXLHFvAIzzYEfOFG5nqRJbGNhaOMY9i6nMBUTjNmW2IHfhsTcQo
        4CXp1rQmfKI43PL+PPMDD+3njsIVu2q04G5966Y=
X-Google-Smtp-Source: APXvYqzUwOO1ogl5P3GxTtfCLrF+FcERXZSRs687nPdciMYRY0NP9Dm+I2Ch/9Z0nW8QF3oKqqp2jOb6GOD6vZGSyhI=
X-Received: by 2002:aca:fc95:: with SMTP id a143mr4383491oii.128.1557500287327;
 Fri, 10 May 2019 07:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181120185814.13362-1-Kenny.Ho@amd.com> <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com> <f63c8d6b-92a4-2977-d062-7e0b7036834e@gmail.com>
In-Reply-To: <f63c8d6b-92a4-2977-d062-7e0b7036834e@gmail.com>
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 10 May 2019 10:57:55 -0400
Message-ID: <CAOWid-fpHqvq35C+gfHmLnuHM9Lj+iiHFXE=3RPrkAiFL2=wvQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation limit
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Kenny Ho <Kenny.Ho@amd.com>, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        Tejun Heo <tj@kernel.org>, sunnanyong@huawei.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Brian Welty <brian.welty@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, May 10, 2019 at 8:28 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 09.05.19 um 23:04 schrieb Kenny Ho:
> > +     /* only allow bo from the same cgroup or its ancestor to be impor=
ted */
> > +     if (drmcgrp !=3D NULL &&
> > +                     !drmcgrp_is_self_or_ancestor(drmcgrp, obj->drmcgr=
p)) {
> > +             ret =3D -EACCES;
> > +             goto out_unlock;
> > +     }
> > +
>
> This will most likely go up in flames.
>
> If I'm not completely mistaken we already use
> drm_gem_prime_fd_to_handle() to exchange handles between different
> cgroups in current container usages.
This is something that I am interested in getting more details from
the broader community because the details affect how likely this will
go up in flames ;).  Note that this check does not block sharing of
handles from cgroup parent to children in the hierarchy, nor does it
blocks sharing of handles within a cgroup.

I am interested to find out, when existing apps share handles between
containers, if there are any expectations on resource management.
Since there are no drm cgroup for current container usage, I expect
the answer to be no.  In this case, the drm cgroup controller can be
disabled on its own (in the context of cgroup-v2's unified hierarchy),
or the process can remain at the root for the drm cgroup hierarchy (in
the context of cgroup-v1.)  If I understand the cgroup api correctly,
that means all process would be part of the root cgroup as far as the
drm controller is concerned and this block will not come into effect.
I have verified that this is indeed the current default behaviour of a
container runtime (runc, which is used by docker, podman and others.)
The new drm cgroup controller is simply ignored and all processes
remain at the root of the hierarchy (since there are no other
cgroups.)  I plan to make contributions to runc (so folks can actually
use this features with docker/podman/k8s, etc.) once things stabilized
on the kernel side.

On the other hand, if there are expectations for resource management
between containers, I would like to know who is the expected manager
and how does it fit into the concept of container (which enforce some
level of isolation.)  One possible manager may be the display server.
But as long as the display server is in a parent cgroup of the apps'
cgroup, the apps can still import handles from the display server
under the current implementation.  My understanding is that this is
most likely the case, with the display server simply sitting at the
default/root cgroup.  But I certainly want to hear more about other
use cases (for example, is running multiple display servers on a
single host a realistic possibility?  Are there people running
multiple display servers inside peer containers?  If so, how do they
coordinate resources?)

I should probably summarize some of these into the commit message.

Regards,
Kenny



> Christian.
>
> >       if (obj->dma_buf) {
> >               WARN_ON(obj->dma_buf !=3D dma_buf);
> >       } else {
> > diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> > index ddb9eab64360..8711b7c5f7bf 100644
> > --- a/include/drm/drm_cgroup.h
> > +++ b/include/drm/drm_cgroup.h
> > @@ -4,12 +4,20 @@
> >   #ifndef __DRM_CGROUP_H__
> >   #define __DRM_CGROUP_H__
> >
> > +#include <linux/cgroup_drm.h>
> > +
> >   #ifdef CONFIG_CGROUP_DRM
> >
> >   int drmcgrp_register_device(struct drm_device *device);
> > -
> >   int drmcgrp_unregister_device(struct drm_device *device);
> > -
> > +bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
> > +             struct drmcgrp *relative);
> > +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *=
dev,
> > +             size_t size);
> > +void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device=
 *dev,
> > +             size_t size);
> > +bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_devi=
ce *dev,
> > +             size_t size);
> >   #else
> >   static inline int drmcgrp_register_device(struct drm_device *device)
> >   {
> > @@ -20,5 +28,27 @@ static inline int drmcgrp_unregister_device(struct d=
rm_device *device)
> >   {
> >       return 0;
> >   }
> > +
> > +static inline bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
> > +             struct drmcgrp *relative)
> > +{
> > +     return false;
> > +}
> > +
> > +static inline void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp,
> > +             struct drm_device *dev, size_t size)
> > +{
> > +}
> > +
> > +static inline void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp,
> > +             struct drm_device *dev, size_t size)
> > +{
> > +}
> > +
> > +static inline bool drmcgrp_bo_can_allocate(struct task_struct *task,
> > +             struct drm_device *dev, size_t size)
> > +{
> > +     return true;
> > +}
> >   #endif /* CONFIG_CGROUP_DRM */
> >   #endif /* __DRM_CGROUP_H__ */
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index c95727425284..02854c674b5c 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -272,6 +272,17 @@ struct drm_gem_object {
> >        *
> >        */
> >       const struct drm_gem_object_funcs *funcs;
> > +
> > +     /**
> > +      * @drmcgrp:
> > +      *
> > +      * DRM cgroup this GEM object belongs to.
> > +         *
> > +         * This is used to track and limit the amount of GEM objects a=
 user
> > +         * can allocate.  Since GEM objects can be shared, this is als=
o used
> > +         * to ensure GEM objects are only shared within the same cgrou=
p.
> > +      */
> > +     struct drmcgrp *drmcgrp;
> >   };
> >
> >   /**
> > diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> > index d7ccf434ca6b..fe14ba7bb1cf 100644
> > --- a/include/linux/cgroup_drm.h
> > +++ b/include/linux/cgroup_drm.h
> > @@ -15,6 +15,9 @@
> >
> >   struct drmcgrp_device_resource {
> >       /* for per device stats */
> > +     s64                     bo_stats_total_allocated;
> > +
> > +     s64                     bo_limits_total_allocated;
> >   };
> >
> >   struct drmcgrp {
> > diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> > index f9ef4bf042d8..bc3abff09113 100644
> > --- a/kernel/cgroup/drm.c
> > +++ b/kernel/cgroup/drm.c
> > @@ -15,6 +15,22 @@ static DEFINE_MUTEX(drmcgrp_mutex);
> >   struct drmcgrp_device {
> >       struct drm_device       *dev;
> >       struct mutex            mutex;
> > +
> > +     s64                     bo_limits_total_allocated_default;
> > +};
> > +
> > +#define DRMCG_CTF_PRIV_SIZE 3
> > +#define DRMCG_CTF_PRIV_MASK GENMASK((DRMCG_CTF_PRIV_SIZE - 1), 0)
> > +
> > +enum drmcgrp_res_type {
> > +     DRMCGRP_TYPE_BO_TOTAL,
> > +};
> > +
> > +enum drmcgrp_file_type {
> > +     DRMCGRP_FTYPE_STATS,
> > +     DRMCGRP_FTYPE_MAX,
> > +     DRMCGRP_FTYPE_DEFAULT,
> > +     DRMCGRP_FTYPE_HELP,
> >   };
> >
> >   /* indexed by drm_minor for access speed */
> > @@ -53,6 +69,10 @@ static inline int init_drmcgrp_single(struct drmcgrp=
 *drmcgrp, int i)
> >       }
> >
> >       /* set defaults here */
> > +     if (known_drmcgrp_devs[i] !=3D NULL) {
> > +             ddr->bo_limits_total_allocated =3D
> > +               known_drmcgrp_devs[i]->bo_limits_total_allocated_defaul=
t;
> > +     }
> >
> >       return 0;
> >   }
> > @@ -99,7 +119,187 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *pare=
nt_css)
> >       return &drmcgrp->css;
> >   }
> >
> > +static inline void drmcgrp_print_stats(struct drmcgrp_device_resource =
*ddr,
> > +             struct seq_file *sf, enum drmcgrp_res_type type)
> > +{
> > +     if (ddr =3D=3D NULL) {
> > +             seq_puts(sf, "\n");
> > +             return;
> > +     }
> > +
> > +     switch (type) {
> > +     case DRMCGRP_TYPE_BO_TOTAL:
> > +             seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
> > +             break;
> > +     default:
> > +             seq_puts(sf, "\n");
> > +             break;
> > +     }
> > +}
> > +
> > +static inline void drmcgrp_print_limits(struct drmcgrp_device_resource=
 *ddr,
> > +             struct seq_file *sf, enum drmcgrp_res_type type)
> > +{
> > +     if (ddr =3D=3D NULL) {
> > +             seq_puts(sf, "\n");
> > +             return;
> > +     }
> > +
> > +     switch (type) {
> > +     case DRMCGRP_TYPE_BO_TOTAL:
> > +             seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
> > +             break;
> > +     default:
> > +             seq_puts(sf, "\n");
> > +             break;
> > +     }
> > +}
> > +
> > +static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
> > +             struct seq_file *sf, enum drmcgrp_res_type type)
> > +{
> > +     if (ddev =3D=3D NULL) {
> > +             seq_puts(sf, "\n");
> > +             return;
> > +     }
> > +
> > +     switch (type) {
> > +     case DRMCGRP_TYPE_BO_TOTAL:
> > +             seq_printf(sf, "%lld\n", ddev->bo_limits_total_allocated_=
default);
> > +             break;
> > +     default:
> > +             seq_puts(sf, "\n");
> > +             break;
> > +     }
> > +}
> > +
> > +static inline void drmcgrp_print_help(int cardNum, struct seq_file *sf=
,
> > +             enum drmcgrp_res_type type)
> > +{
> > +     switch (type) {
> > +     case DRMCGRP_TYPE_BO_TOTAL:
> > +             seq_printf(sf,
> > +             "Total amount of buffer allocation in bytes for card%d\n"=
,
> > +             cardNum);
> > +             break;
> > +     default:
> > +             seq_puts(sf, "\n");
> > +             break;
> > +     }
> > +}
> > +
> > +int drmcgrp_bo_show(struct seq_file *sf, void *v)
> > +{
> > +     struct drmcgrp *drmcgrp =3D css_drmcgrp(seq_css(sf));
> > +     struct drmcgrp_device_resource *ddr =3D NULL;
> > +     enum drmcgrp_file_type f_type =3D seq_cft(sf)->
> > +             private & DRMCG_CTF_PRIV_MASK;
> > +     enum drmcgrp_res_type type =3D seq_cft(sf)->
> > +             private >> DRMCG_CTF_PRIV_SIZE;
> > +     struct drmcgrp_device *ddev;
> > +     int i;
> > +
> > +     for (i =3D 0; i <=3D max_minor; i++) {
> > +             ddr =3D drmcgrp->dev_resources[i];
> > +             ddev =3D known_drmcgrp_devs[i];
> > +
> > +             switch (f_type) {
> > +             case DRMCGRP_FTYPE_STATS:
> > +                     drmcgrp_print_stats(ddr, sf, type);
> > +                     break;
> > +             case DRMCGRP_FTYPE_MAX:
> > +                     drmcgrp_print_limits(ddr, sf, type);
> > +                     break;
> > +             case DRMCGRP_FTYPE_DEFAULT:
> > +                     drmcgrp_print_default(ddev, sf, type);
> > +                     break;
> > +             case DRMCGRP_FTYPE_HELP:
> > +                     drmcgrp_print_help(i, sf, type);
> > +                     break;
> > +             default:
> > +                     seq_puts(sf, "\n");
> > +                     break;
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
> > +             size_t nbytes, loff_t off)
> > +{
> > +     struct drmcgrp *drmcgrp =3D css_drmcgrp(of_css(of));
> > +     enum drmcgrp_res_type type =3D of_cft(of)->private >> DRMCG_CTF_P=
RIV_SIZE;
> > +     char *cft_name =3D of_cft(of)->name;
> > +     char *limits =3D strstrip(buf);
> > +     struct drmcgrp_device_resource *ddr;
> > +     char *sval;
> > +     s64 val;
> > +     int i =3D 0;
> > +     int rc;
> > +
> > +     while (i <=3D max_minor && limits !=3D NULL) {
> > +             sval =3D  strsep(&limits, "\n");
> > +             rc =3D kstrtoll(sval, 0, &val);
> > +
> > +             if (rc) {
> > +                     pr_err("drmcgrp: %s: minor %d, err %d. ",
> > +                             cft_name, i, rc);
> > +                     pr_cont_cgroup_name(drmcgrp->css.cgroup);
> > +                     pr_cont("\n");
> > +             } else {
> > +                     ddr =3D drmcgrp->dev_resources[i];
> > +                     switch (type) {
> > +                     case DRMCGRP_TYPE_BO_TOTAL:
> > +                                if (val < 0) continue;
> > +                             ddr->bo_limits_total_allocated =3D val;
> > +                             break;
> > +                     default:
> > +                             break;
> > +                     }
> > +             }
> > +
> > +             i++;
> > +     }
> > +
> > +     if (i <=3D max_minor) {
> > +             pr_err("drmcgrp: %s: less entries than # of drm devices. =
",
> > +                             cft_name);
> > +             pr_cont_cgroup_name(drmcgrp->css.cgroup);
> > +             pr_cont("\n");
> > +     }
> > +
> > +     return nbytes;
> > +}
> > +
> >   struct cftype files[] =3D {
> > +     {
> > +             .name =3D "buffer.total.stats",
> > +             .seq_show =3D drmcgrp_bo_show,
> > +             .private =3D (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZ=
E) |
> > +                     DRMCGRP_FTYPE_STATS,
> > +     },
> > +     {
> > +             .name =3D "buffer.total.default",
> > +             .seq_show =3D drmcgrp_bo_show,
> > +             .flags =3D CFTYPE_ONLY_ON_ROOT,
> > +             .private =3D (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZ=
E) |
> > +                     DRMCGRP_FTYPE_DEFAULT,
> > +     },
> > +     {
> > +             .name =3D "buffer.total.help",
> > +             .seq_show =3D drmcgrp_bo_show,
> > +             .flags =3D CFTYPE_ONLY_ON_ROOT,
> > +             .private =3D (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZ=
E) |
> > +                     DRMCGRP_FTYPE_HELP,
> > +     },
> > +     {
> > +             .name =3D "buffer.total.max",
> > +             .write =3D drmcgrp_bo_limit_write,
> > +             .seq_show =3D drmcgrp_bo_show,
> > +             .private =3D (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZ=
E) |
> > +                     DRMCGRP_FTYPE_MAX,
> > +     },
> >       { }     /* terminate */
> >   };
> >
> > @@ -122,6 +322,8 @@ int drmcgrp_register_device(struct drm_device *dev)
> >               return -ENOMEM;
> >
> >       ddev->dev =3D dev;
> > +     ddev->bo_limits_total_allocated_default =3D S64_MAX;
> > +
> >       mutex_init(&ddev->mutex);
> >
> >       mutex_lock(&drmcgrp_mutex);
> > @@ -156,3 +358,81 @@ int drmcgrp_unregister_device(struct drm_device *d=
ev)
> >       return 0;
> >   }
> >   EXPORT_SYMBOL(drmcgrp_unregister_device);
> > +
> > +bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self, struct drmcgrp =
*relative)
> > +{
> > +     for (; self !=3D NULL; self =3D parent_drmcgrp(self))
> > +             if (self =3D=3D relative)
> > +                     return true;
> > +
> > +     return false;
> > +}
> > +EXPORT_SYMBOL(drmcgrp_is_self_or_ancestor);
> > +
> > +bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_devi=
ce *dev,
> > +             size_t size)
> > +{
> > +     struct drmcgrp *drmcgrp =3D get_drmcgrp(task);
> > +     struct drmcgrp_device_resource *ddr;
> > +     struct drmcgrp_device_resource *d;
> > +     int devIdx =3D dev->primary->index;
> > +     bool result =3D true;
> > +     s64 delta =3D 0;
> > +
> > +     if (drmcgrp =3D=3D NULL || drmcgrp =3D=3D root_drmcgrp)
> > +             return true;
> > +
> > +     ddr =3D drmcgrp->dev_resources[devIdx];
> > +     mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> > +     for ( ; drmcgrp !=3D root_drmcgrp; drmcgrp =3D parent_drmcgrp(drm=
cgrp)) {
> > +             d =3D drmcgrp->dev_resources[devIdx];
> > +             delta =3D d->bo_limits_total_allocated -
> > +                             d->bo_stats_total_allocated;
> > +
> > +             if (delta <=3D 0 || size > delta) {
> > +                     result =3D false;
> > +                     break;
> > +             }
> > +     }
> > +     mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> > +
> > +     return result;
> > +}
> > +EXPORT_SYMBOL(drmcgrp_bo_can_allocate);
> > +
> > +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *=
dev,
> > +             size_t size)
> > +{
> > +     struct drmcgrp_device_resource *ddr;
> > +     int devIdx =3D dev->primary->index;
> > +
> > +     if (drmcgrp =3D=3D NULL || known_drmcgrp_devs[devIdx] =3D=3D NULL=
)
> > +             return;
> > +
> > +     mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> > +     for ( ; drmcgrp !=3D NULL; drmcgrp =3D parent_drmcgrp(drmcgrp)) {
> > +             ddr =3D drmcgrp->dev_resources[devIdx];
> > +
> > +             ddr->bo_stats_total_allocated +=3D (s64)size;
> > +     }
> > +     mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> > +}
> > +EXPORT_SYMBOL(drmcgrp_chg_bo_alloc);
> > +
> > +void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device=
 *dev,
> > +             size_t size)
> > +{
> > +     struct drmcgrp_device_resource *ddr;
> > +     int devIdx =3D dev->primary->index;
> > +
> > +     if (drmcgrp =3D=3D NULL || known_drmcgrp_devs[devIdx] =3D=3D NULL=
)
> > +             return;
> > +
> > +     ddr =3D drmcgrp->dev_resources[devIdx];
> > +     mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> > +     for ( ; drmcgrp !=3D NULL; drmcgrp =3D parent_drmcgrp(drmcgrp))
> > +             drmcgrp->dev_resources[devIdx]->bo_stats_total_allocated
> > +                     -=3D (s64)size;
> > +     mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> > +}
> > +EXPORT_SYMBOL(drmcgrp_unchg_bo_alloc);
>
