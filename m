Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B4A316711
	for <lists+cgroups@lfdr.de>; Wed, 10 Feb 2021 13:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhBJMrZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 10 Feb 2021 07:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhBJMqm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 10 Feb 2021 07:46:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A352C0613D6
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 04:46:01 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id u14so2396909wri.3
        for <cgroups@vger.kernel.org>; Wed, 10 Feb 2021 04:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rum60VafaxlPAbiRsaYr/mrmV1krBfLh/3W2IYL9TJU=;
        b=cNgfqlzpYh6Dvez+FOYeoCbiQ3L1YjnDX3dHfkb84DKmr1b6KDoW9WhiKQIjnvtK4z
         J+TJe1Ug8vVoPhZDx+qZrdHRhLbuSQa8xXbJpAuzBCsPXJAxSviNxwX4aYY+7bW3p5XU
         ZRhR8v/bpXuELMHojpUsjzyoPO85NlEcIqc0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rum60VafaxlPAbiRsaYr/mrmV1krBfLh/3W2IYL9TJU=;
        b=FHVgDI9Qn9dJL/8cMxMuasGoaIhj7/cTe1Et+L3t7kD8521XTqlVm9AROwYFPkdr6Y
         S3rYlwa9AYf5CaJebM0Cv5y5EguTY3Xpesayo9QLG4lUNsbMqEcv0Wc78+6qs7WaPCX+
         Xiv7+0Z+N2n38FK+O/7S6lwyMdvf7gsXDgvgYgEicvAp9s1HLiKcanN8tmYD018rrcUB
         b/t/HMZap5XGKpVnHvcc/xaLtTY0oqTvNEVQCEM8NKG8OkJsgP7M65A7K4T7X/nNSZaI
         I6qqCKccAiEGPqXdjAC7ZEFEDeAW6o/IBOgR6iSVTORk3ryIZChtNjKdnrszfmEedYY7
         y22w==
X-Gm-Message-State: AOAM533ntkhkEneOhEq2LPGazNmpJFLdTb4auQ2sTFda/xynGiw+Zj7M
        V1J9kWfLnHC/Vp8U6/2tjjg2sw==
X-Google-Smtp-Source: ABdhPJxJrAvgSXX5w7P1juJ8Jbk+pBUHP84DH+1F8ehtKz9QqG6WckIdOgsKZbFxS7mzeDziW06siA==
X-Received: by 2002:a05:6000:4e:: with SMTP id k14mr3432513wrx.281.1612961160148;
        Wed, 10 Feb 2021 04:46:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d5sm3196863wrb.14.2021.02.10.04.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 04:45:59 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:45:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Brian Welty <brian.welty@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Eero Tamminen <eero.t.tamminen@intel.com>,
        David Airlie <airlied@linux.ie>, Kenny Ho <Kenny.Ho@amd.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        amd-gfx@lists.freedesktop.org, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [RFC PATCH 8/9] drm/gem: Associate GEM objects with drm cgroup
Message-ID: <YCPVhc+HwiMhfjdF@phenom.ffwll.local>
References: <20210126214626.16260-1-brian.welty@intel.com>
 <20210126214626.16260-9-brian.welty@intel.com>
 <YCJp//kMC7YjVMXv@phenom.ffwll.local>
 <faeaef17-3656-ca31-3be9-49354db3116e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faeaef17-3656-ca31-3be9-49354db3116e@suse.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 10, 2021 at 08:52:29AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.02.21 um 11:54 schrieb Daniel Vetter:
> > *: vmwgfx is the only non-gem driver, but there's plans to move at least
> > vmwgfx internals (maybe not the uapi, we'll see) over to gem. Once that's
> > done it's truly all gpu memory.
> 
> Do you have a URL to the discussion?
> 
> While I recent worked on GEM, I thought that vmwgfx could easily switch to
> the GEM internals without adopting the interface.

Zack Rusin pinged me on irc I think, not sure there's anything on
dri-devel. zackr on freenode. I think he's working on this already.

> Personally, I think we should consider renaming struct drm_gem_object et al.
> It's not strictly GEM UAPI, but nowadays anything memory-related. Maybe
> drm_mem_object would fit.

I think abbrevations we've created that have been around for long enough
can stay. Otherwise we'd need to rename drm into something less confusing
too :-)

So gem just becomes the buffer based memory management thing in drm, which
is the accelerator and display framework in upstream. And ttm is our
memory manager for discrete gpus - ttm means translation table manager,
and that part just got moved out as a helper so drivers call we needed :-)

I mean we haven't even managed to rename the cma helpers to dma helpers.
The one thing we did manage is rename struct fence to struct dma_fence,
because no prefix was just really bad naming accident.

Cheers, Daniel

> 
> Best regards
> Thomas
> 
> > > ---
> > >   drivers/gpu/drm/drm_gem.c | 89 +++++++++++++++++++++++++++++++++++++++
> > >   include/drm/drm_gem.h     | 17 ++++++++
> > >   2 files changed, 106 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> > > index c2ce78c4edc3..a12da41eaafe 100644
> > > --- a/drivers/gpu/drm/drm_gem.c
> > > +++ b/drivers/gpu/drm/drm_gem.c
> > > @@ -29,6 +29,7 @@
> > >   #include <linux/slab.h>
> > >   #include <linux/mm.h>
> > >   #include <linux/uaccess.h>
> > > +#include <linux/cgroup_drm.h>
> > >   #include <linux/fs.h>
> > >   #include <linux/file.h>
> > >   #include <linux/module.h>
> > > @@ -112,6 +113,89 @@ drm_gem_init(struct drm_device *dev)
> > >   	return drmm_add_action(dev, drm_gem_init_release, NULL);
> > >   }
> > > +/**
> > > + * drm_gem_object_set_cgroup - associate GEM object with a cgroup
> > > + * @obj: GEM object which is being associated with a cgroup
> > > + * @task: task associated with process control group to use
> > > + *
> > > + * This will acquire a reference on cgroup and use for charging GEM
> > > + * memory allocations.
> > > + * This helper could be extended in future to migrate charges to another
> > > + * cgroup, print warning if this usage occurs.
> > > + */
> > > +void drm_gem_object_set_cgroup(struct drm_gem_object *obj,
> > > +			       struct task_struct *task)
> > > +{
> > > +	/* if object has existing cgroup, we migrate the charge... */
> > > +	if (obj->drmcg) {
> > > +		pr_warn("DRM: need to migrate cgroup charge of %lld\n",
> > > +			atomic64_read(&obj->drmcg_bytes_charged));
> > > +	}
> > > +	obj->drmcg = drmcg_get(task);
> > > +}
> > > +EXPORT_SYMBOL(drm_gem_object_set_cgroup);
> > > +
> > > +/**
> > > + * drm_gem_object_unset_cgroup - clear GEM object's associated cgroup
> > > + * @obj: GEM object
> > > + *
> > > + * This will release a reference on cgroup.
> > > + */
> > > +void drm_gem_object_unset_cgroup(struct drm_gem_object *obj)
> > > +{
> > > +	WARN_ON(atomic64_read(&obj->drmcg_bytes_charged));
> > > +	drmcg_put(obj->drmcg);
> > > +}
> > > +EXPORT_SYMBOL(drm_gem_object_unset_cgroup);
> > > +
> > > +/**
> > > + * drm_gem_object_charge_mem - try charging size bytes to DRM cgroup
> > > + * @obj: GEM object which is being charged
> > > + * @size: number of bytes to charge
> > > + *
> > > + * Try to charge @size bytes to GEM object's associated DRM cgroup.  This
> > > + * will fail if a successful charge would cause the current device memory
> > > + * usage to go above the cgroup's GPU memory maximum limit.
> > > + *
> > > + * Returns 0 on success.  Otherwise, an error code is returned.
> > > + */
> > > +int drm_gem_object_charge_mem(struct drm_gem_object *obj, u64 size)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = drm_cgroup_try_charge(obj->drmcg, obj->dev,
> > > +				    DRMCG_TYPE_MEM_CURRENT, size);
> > > +	if (!ret)
> > > +		atomic64_add(size, &obj->drmcg_bytes_charged);
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL(drm_gem_object_charge_mem);
> > > +
> > > +/**
> > > + * drm_gem_object_uncharge_mem - uncharge size bytes from DRM cgroup
> > > + * @obj: GEM object which is being uncharged
> > > + * @size: number of bytes to uncharge
> > > + *
> > > + * Uncharge @size bytes from the DRM cgroup associated with specified
> > > + * GEM object.
> > > + *
> > > + * Returns 0 on success.  Otherwise, an error code is returned.
> > > + */
> > > +void drm_gem_object_uncharge_mem(struct drm_gem_object *obj, u64 size)
> > > +{
> > > +	u64 charged = atomic64_read(&obj->drmcg_bytes_charged);
> > > +
> > > +	if (WARN_ON(!charged))
> > > +		return;
> > > +	if (WARN_ON(size > charged))
> > > +		size = charged;
> > > +
> > > +	atomic64_sub(size, &obj->drmcg_bytes_charged);
> > > +	drm_cgroup_uncharge(obj->drmcg, obj->dev, DRMCG_TYPE_MEM_CURRENT,
> > > +			    size);
> > > +}
> > > +EXPORT_SYMBOL(drm_gem_object_uncharge_mem);
> > > +
> > >   /**
> > >    * drm_gem_object_init - initialize an allocated shmem-backed GEM object
> > >    * @dev: drm_device the object should be initialized for
> > > @@ -156,6 +240,8 @@ void drm_gem_private_object_init(struct drm_device *dev,
> > >   	obj->dev = dev;
> > >   	obj->filp = NULL;
> > > +	drm_gem_object_set_cgroup(obj, current);
> > > +
> > >   	kref_init(&obj->refcount);
> > >   	obj->handle_count = 0;
> > >   	obj->size = size;
> > > @@ -950,6 +1036,9 @@ drm_gem_object_release(struct drm_gem_object *obj)
> > >   	dma_resv_fini(&obj->_resv);
> > >   	drm_gem_free_mmap_offset(obj);
> > > +
> > > +	/* Release reference on cgroup used with GEM object charging */
> > > +	drm_gem_object_unset_cgroup(obj);
> > >   }
> > >   EXPORT_SYMBOL(drm_gem_object_release);
> > > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > > index 240049566592..06ea10fc17bc 100644
> > > --- a/include/drm/drm_gem.h
> > > +++ b/include/drm/drm_gem.h
> > > @@ -37,6 +37,7 @@
> > >   #include <linux/kref.h>
> > >   #include <linux/dma-resv.h>
> > > +#include <drm/drm_cgroup.h>
> > >   #include <drm/drm_vma_manager.h>
> > >   struct dma_buf_map;
> > > @@ -222,6 +223,17 @@ struct drm_gem_object {
> > >   	 */
> > >   	struct file *filp;
> > > +	/**
> > > +	 * @drmcg:
> > > +	 *
> > > +	 * cgroup used for charging GEM object page allocations against. This
> > > +	 * is set to the current cgroup during GEM object creation.
> > > +	 * Charging policy is up to the DRM driver to implement and should be
> > > +	 * charged when allocating backing store from device memory.
> > > +	 */
> > > +	struct drmcg *drmcg;
> > > +	atomic64_t drmcg_bytes_charged;
> > > +
> > >   	/**
> > >   	 * @vma_node:
> > >   	 *
> > > @@ -417,4 +429,9 @@ int drm_gem_fence_array_add_implicit(struct xarray *fence_array,
> > >   int drm_gem_dumb_map_offset(struct drm_file *file, struct drm_device *dev,
> > >   			    u32 handle, u64 *offset);
> > > +void drm_gem_object_set_cgroup(struct drm_gem_object *obj,
> > > +			       struct task_struct *task);
> > > +void drm_gem_object_unset_cgroup(struct drm_gem_object *obj);
> > > +int drm_gem_object_charge_mem(struct drm_gem_object *obj, u64 size);
> > > +void drm_gem_object_uncharge_mem(struct drm_gem_object *obj, u64 size);
> > >   #endif /* __DRM_GEM_H__ */
> > > -- 
> > > 2.20.1
> > > 
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer
> 




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
