Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9533B56E70
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 18:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFZQNA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 12:13:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43501 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFZQNA (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 12:13:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id e3so4065963edr.10
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 09:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SWXNmb7GUeHHEkLzaXYll8rDGNvnyCU3wZ5YDgqleLA=;
        b=d0jCQ0+pode9KR2pHRHz9CvtaGcSgbYLb4crTkh+309/waJwgL8bw+pc6mdSvR2ojg
         w+ihaM1BcCiBOO77wTcO377PXU1HqmHmZOjgzDwxeWK1aW/BVmooZTwi23vq0XxDNG8v
         FuraJ8JW7AaACZBeYunue6ZJph4ydCQFVpgaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SWXNmb7GUeHHEkLzaXYll8rDGNvnyCU3wZ5YDgqleLA=;
        b=EUg1DpQ7csZXUF63lwd9MY/p4vNQaiSe5zFmgStqyt9KoSownNOSI4/fhWllCCOmSd
         8nOWYcSPvpBymJBuemCBb6FaNxmdiwE2sbue1DgBRoUNkGhcj7GnbKtQdl0QOlQCqMP0
         Rd4U4k+MUaOayklY+4h/CMrGiLsD1H0m66AiAz8d3X/yMJYx1Fnvqv3IlYE/hWue945F
         csyHky2Bc+8MkFzGstVH5GZgkLJWkhF+K5R2Gz7EbUCkk8+gr6hH/vo5p1hrlMekBx05
         19+LYA5YUrJo46sTjlGsRAMYlynjlAaOvc2xpJDszKpldpzYpqYH7awk+GBWoZrUdeZc
         kilQ==
X-Gm-Message-State: APjAAAX8MJjni/ssDiSTMroBiwVUb2AuxdVXSJ8ovOyD285RpJFtE2PE
        UMHKgvGctTxFPy0PY4Imt9BF0w==
X-Google-Smtp-Source: APXvYqyuyYlERpxvdx2wwhrT/NDF/Iy6a6vJ3Xnu/kk2CFuDtlT7dzNXv+B4hHQmDmfAolSCO+jLSQ==
X-Received: by 2002:a17:906:5813:: with SMTP id m19mr4819488ejq.6.1561565577169;
        Wed, 26 Jun 2019 09:12:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id z10sm5834037edl.35.2019.06.26.09.12.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:12:56 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:12:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 07/11] drm, cgroup: Add TTM buffer allocation stats
Message-ID: <20190626161254.GS12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-8-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626150522.11618-8-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:05:18AM -0400, Kenny Ho wrote:
> The drm resource being measured is the TTM (Translation Table Manager)
> buffers.  TTM manages different types of memory that a GPU might access.
> These memory types include dedicated Video RAM (VRAM) and host/system
> memory accessible through IOMMU (GART/GTT).  TTM is currently used by
> multiple drm drivers (amd, ast, bochs, cirrus, hisilicon, maga200,
> nouveau, qxl, virtio, vmwgfx.)
> 
> drm.memory.stats
>         A read-only nested-keyed file which exists on all cgroups.
>         Each entry is keyed by the drm device's major:minor.  The
>         following nested keys are defined.
> 
>           ======         =============================================
>           system         Host/system memory

Shouldn't that be covered by gem bo stats already? Also, system memory is
definitely something a lot of non-ttm drivers want to be able to track, so
that needs to be separate from ttm.

>           tt             Host memory used by the drm device (GTT/GART)
>           vram           Video RAM used by the drm device
>           priv           Other drm device, vendor specific memory

So what's "priv". In general I think we need some way to register the
different kinds of memory, e.g. stuff not in your list:

- multiple kinds of vram (like numa-style gpus)
- cma (for all those non-ttm drivers that's a big one, it's like system
  memory but also totally different)
- any carveouts and stuff
>           ======         =============================================
> 
>         Reading returns the following::
> 
>         226:0 system=0 tt=0 vram=0 priv=0
>         226:1 system=0 tt=9035776 vram=17768448 priv=16809984
>         226:2 system=0 tt=9035776 vram=17768448 priv=16809984
> 
> drm.memory.evict.stats
>         A read-only flat-keyed file which exists on all cgroups.  Each
>         entry is keyed by the drm device's major:minor.
> 
>         Total number of evictions.
> 
> Change-Id: Ice2c4cc845051229549bebeb6aa2d7d6153bdf6a
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>

I think with all the ttm refactoring going on I think we need to de-ttm
the interface functions here a bit. With Gerd Hoffmans series you can just
use a gem_bo pointer here, so what's left to do is have some extracted
structure for tracking memory types. I think Brian Welty has some ideas
for this, even in patch form. Would be good to keep him on cc at least for
the next version. We'd need to explicitly hand in the ttm_mem_reg (or
whatever the specific thing is going to be).

-Daniel
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |   3 +-
>  drivers/gpu/drm/ttm/ttm_bo.c            |  30 +++++++
>  drivers/gpu/drm/ttm/ttm_bo_util.c       |   4 +
>  include/drm/drm_cgroup.h                |  19 ++++
>  include/drm/ttm/ttm_bo_api.h            |   2 +
>  include/drm/ttm/ttm_bo_driver.h         |   8 ++
>  include/linux/cgroup_drm.h              |   4 +
>  kernel/cgroup/drm.c                     | 113 ++++++++++++++++++++++++
>  8 files changed, 182 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e9ecc3953673..a8dfc78ed45f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1678,8 +1678,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  	mutex_init(&adev->mman.gtt_window_lock);
>  
>  	/* No others user of address space so set it to 0 */
> -	r = ttm_bo_device_init(&adev->mman.bdev,
> +	r = ttm_bo_device_init_tmp(&adev->mman.bdev,
>  			       &amdgpu_bo_driver,
> +			       adev->ddev,
>  			       adev->ddev->anon_inode->i_mapping,
>  			       adev->need_dma32);
>  	if (r) {
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 2845fceb2fbd..e9f70547f0ad 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -34,6 +34,7 @@
>  #include <drm/ttm/ttm_module.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_placement.h>
> +#include <drm/drm_cgroup.h>
>  #include <linux/jiffies.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
> @@ -42,6 +43,7 @@
>  #include <linux/module.h>
>  #include <linux/atomic.h>
>  #include <linux/reservation.h>
> +#include <linux/cgroup_drm.h>
>  
>  static void ttm_bo_global_kobj_release(struct kobject *kobj);
>  
> @@ -151,6 +153,10 @@ static void ttm_bo_release_list(struct kref *list_kref)
>  	struct ttm_bo_device *bdev = bo->bdev;
>  	size_t acc_size = bo->acc_size;
>  
> +	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
> +		drmcgrp_unchg_mem(bo);
> +	put_drmcgrp(bo->drmcgrp);
> +
>  	BUG_ON(kref_read(&bo->list_kref));
>  	BUG_ON(kref_read(&bo->kref));
>  	BUG_ON(atomic_read(&bo->cpu_writers));
> @@ -353,6 +359,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>  		if (bo->mem.mem_type == TTM_PL_SYSTEM) {
>  			if (bdev->driver->move_notify)
>  				bdev->driver->move_notify(bo, evict, mem);
> +			if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
> +				drmcgrp_mem_track_move(bo, evict, mem);
>  			bo->mem = *mem;
>  			mem->mm_node = NULL;
>  			goto moved;
> @@ -361,6 +369,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>  
>  	if (bdev->driver->move_notify)
>  		bdev->driver->move_notify(bo, evict, mem);
> +	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
> +		drmcgrp_mem_track_move(bo, evict, mem);
>  
>  	if (!(old_man->flags & TTM_MEMTYPE_FLAG_FIXED) &&
>  	    !(new_man->flags & TTM_MEMTYPE_FLAG_FIXED))
> @@ -374,6 +384,8 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>  		if (bdev->driver->move_notify) {
>  			swap(*mem, bo->mem);
>  			bdev->driver->move_notify(bo, false, mem);
> +			if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
> +				drmcgrp_mem_track_move(bo, evict, mem);
>  			swap(*mem, bo->mem);
>  		}
>  
> @@ -1275,6 +1287,10 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
>  		WARN_ON(!locked);
>  	}
>  
> +	bo->drmcgrp = get_drmcgrp(current);
> +	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
> +		drmcgrp_chg_mem(bo);
> +
>  	if (likely(!ret))
>  		ret = ttm_bo_validate(bo, placement, ctx);
>  
> @@ -1666,6 +1682,20 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>  }
>  EXPORT_SYMBOL(ttm_bo_device_init);
>  
> +/* TODO merge with official function when implementation finalized*/
> +int ttm_bo_device_init_tmp(struct ttm_bo_device *bdev,
> +		struct ttm_bo_driver *driver,
> +		struct drm_device *ddev,
> +		struct address_space *mapping,
> +		bool need_dma32)
> +{
> +	int ret = ttm_bo_device_init(bdev, driver, mapping, need_dma32);
> +
> +	bdev->ddev = ddev;
> +	return ret;
> +}
> +EXPORT_SYMBOL(ttm_bo_device_init_tmp);
> +
>  /*
>   * buffer object vm functions.
>   */
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
> index 895d77d799e4..4ed7847c21f4 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -32,6 +32,7 @@
>  #include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/ttm/ttm_placement.h>
>  #include <drm/drm_vma_manager.h>
> +#include <drm/drm_cgroup.h>
>  #include <linux/io.h>
>  #include <linux/highmem.h>
>  #include <linux/wait.h>
> @@ -522,6 +523,9 @@ static int ttm_buffer_object_transfer(struct ttm_buffer_object *bo,
>  	ret = reservation_object_trylock(fbo->base.resv);
>  	WARN_ON(!ret);
>  
> +	if (bo->bdev->ddev != NULL) // TODO: remove after ddev initiazlied for all
> +		drmcgrp_chg_mem(bo);
> +
>  	*new_obj = &fbo->base;
>  	return 0;
>  }
> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> index 8711b7c5f7bf..48ab5450cf17 100644
> --- a/include/drm/drm_cgroup.h
> +++ b/include/drm/drm_cgroup.h
> @@ -5,6 +5,7 @@
>  #define __DRM_CGROUP_H__
>  
>  #include <linux/cgroup_drm.h>
> +#include <drm/ttm/ttm_bo_api.h>
>  
>  #ifdef CONFIG_CGROUP_DRM
>  
> @@ -18,6 +19,11 @@ void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
>  		size_t size);
>  bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
>  		size_t size);
> +void drmcgrp_chg_mem(struct ttm_buffer_object *tbo);
> +void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo);
> +void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
> +		struct ttm_mem_reg *new_mem);
> +
>  #else
>  static inline int drmcgrp_register_device(struct drm_device *device)
>  {
> @@ -50,5 +56,18 @@ static inline bool drmcgrp_bo_can_allocate(struct task_struct *task,
>  {
>  	return true;
>  }
> +
> +static inline void drmcgrp_chg_mem(struct ttm_buffer_object *tbo)
> +{
> +}
> +
> +static inline void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo)
> +{
> +}
> +
> +static inline void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo,
> +		bool evict, struct ttm_mem_reg *new_mem)
> +{
> +}
>  #endif /* CONFIG_CGROUP_DRM */
>  #endif /* __DRM_CGROUP_H__ */
> diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
> index 49d9cdfc58f2..ae1bb6daec81 100644
> --- a/include/drm/ttm/ttm_bo_api.h
> +++ b/include/drm/ttm/ttm_bo_api.h
> @@ -128,6 +128,7 @@ struct ttm_tt;
>   * struct ttm_buffer_object
>   *
>   * @bdev: Pointer to the buffer object device structure.
> + * @drmcgrp: DRM cgroup this object belongs to.
>   * @type: The bo type.
>   * @destroy: Destruction function. If NULL, kfree is used.
>   * @num_pages: Actual number of pages.
> @@ -174,6 +175,7 @@ struct ttm_buffer_object {
>  	 */
>  
>  	struct ttm_bo_device *bdev;
> +	struct drmcgrp *drmcgrp;
>  	enum ttm_bo_type type;
>  	void (*destroy) (struct ttm_buffer_object *);
>  	unsigned long num_pages;
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index c008346c2401..4cbcb41e5aa9 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -30,6 +30,7 @@
>  #ifndef _TTM_BO_DRIVER_H_
>  #define _TTM_BO_DRIVER_H_
>  
> +#include <drm/drm_device.h>
>  #include <drm/drm_mm.h>
>  #include <drm/drm_vma_manager.h>
>  #include <linux/workqueue.h>
> @@ -442,6 +443,7 @@ extern struct ttm_bo_global {
>   * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
>   * @man: An array of mem_type_managers.
>   * @vma_manager: Address space manager
> + * @ddev: Pointer to struct drm_device that this ttm_bo_device belongs to
>   * lru_lock: Spinlock that protects the buffer+device lru lists and
>   * ddestroy lists.
>   * @dev_mapping: A pointer to the struct address_space representing the
> @@ -460,6 +462,7 @@ struct ttm_bo_device {
>  	struct ttm_bo_global *glob;
>  	struct ttm_bo_driver *driver;
>  	struct ttm_mem_type_manager man[TTM_NUM_MEM_TYPES];
> +	struct drm_device *ddev;
>  
>  	/*
>  	 * Protected by internal locks.
> @@ -598,6 +601,11 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
>  		       struct address_space *mapping,
>  		       bool need_dma32);
>  
> +int ttm_bo_device_init_tmp(struct ttm_bo_device *bdev,
> +		       struct ttm_bo_driver *driver,
> +		       struct drm_device *ddev,
> +		       struct address_space *mapping,
> +		       bool need_dma32);
>  /**
>   * ttm_bo_unmap_virtual
>   *
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> index e4400b21ab8e..141bea06f74c 100644
> --- a/include/linux/cgroup_drm.h
> +++ b/include/linux/cgroup_drm.h
> @@ -9,6 +9,7 @@
>  #include <linux/mutex.h>
>  #include <linux/cgroup.h>
>  #include <drm/drm_file.h>
> +#include <drm/ttm/ttm_placement.h>
>  
>  /* limit defined per the way drm_minor_alloc operates */
>  #define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
> @@ -22,6 +23,9 @@ struct drmcgrp_device_resource {
>  	size_t			bo_limits_peak_allocated;
>  
>  	s64			bo_stats_count_allocated;
> +
> +	s64			mem_stats[TTM_PL_PRIV+1];
> +	s64			mem_stats_evict;
>  };
>  
>  struct drmcgrp {
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index 9144f93b851f..5aee42a628c1 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -8,6 +8,8 @@
>  #include <linux/mutex.h>
>  #include <linux/cgroup_drm.h>
>  #include <linux/kernel.h>
> +#include <drm/ttm/ttm_bo_api.h>
> +#include <drm/ttm/ttm_bo_driver.h>
>  #include <drm/drm_device.h>
>  #include <drm/drm_ioctl.h>
>  #include <drm/drm_cgroup.h>
> @@ -34,6 +36,8 @@ enum drmcgrp_res_type {
>  	DRMCGRP_TYPE_BO_TOTAL,
>  	DRMCGRP_TYPE_BO_PEAK,
>  	DRMCGRP_TYPE_BO_COUNT,
> +	DRMCGRP_TYPE_MEM,
> +	DRMCGRP_TYPE_MEM_EVICT,
>  };
>  
>  enum drmcgrp_file_type {
> @@ -42,6 +46,13 @@ enum drmcgrp_file_type {
>  	DRMCGRP_FTYPE_DEFAULT,
>  };
>  
> +static char const *ttm_placement_names[] = {
> +	[TTM_PL_SYSTEM] = "system",
> +	[TTM_PL_TT]     = "tt",
> +	[TTM_PL_VRAM]   = "vram",
> +	[TTM_PL_PRIV]   = "priv",
> +};
> +
>  /* indexed by drm_minor for access speed */
>  static struct drmcgrp_device	*known_drmcgrp_devs[MAX_DRM_DEV];
>  
> @@ -134,6 +145,7 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
>  static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
>  		struct seq_file *sf, enum drmcgrp_res_type type)
>  {
> +	int i;
>  	if (ddr == NULL) {
>  		seq_puts(sf, "\n");
>  		return;
> @@ -149,6 +161,16 @@ static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
>  	case DRMCGRP_TYPE_BO_COUNT:
>  		seq_printf(sf, "%lld\n", ddr->bo_stats_count_allocated);
>  		break;
> +	case DRMCGRP_TYPE_MEM:
> +		for (i = 0; i <= TTM_PL_PRIV; i++) {
> +			seq_printf(sf, "%s=%lld ", ttm_placement_names[i],
> +					ddr->mem_stats[i]);
> +		}
> +		seq_puts(sf, "\n");
> +		break;
> +	case DRMCGRP_TYPE_MEM_EVICT:
> +		seq_printf(sf, "%lld\n", ddr->mem_stats_evict);
> +		break;
>  	default:
>  		seq_puts(sf, "\n");
>  		break;
> @@ -406,6 +428,18 @@ struct cftype files[] = {
>  		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_COUNT,
>  						DRMCGRP_FTYPE_STATS),
>  	},
> +	{
> +		.name = "memory.stats",
> +		.seq_show = drmcgrp_bo_show,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM,
> +						DRMCGRP_FTYPE_STATS),
> +	},
> +	{
> +		.name = "memory.evict.stats",
> +		.seq_show = drmcgrp_bo_show,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_MEM_EVICT,
> +						DRMCGRP_FTYPE_STATS),
> +	},
>  	{ }	/* terminate */
>  };
>  
> @@ -555,3 +589,82 @@ void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
>  	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
>  }
>  EXPORT_SYMBOL(drmcgrp_unchg_bo_alloc);
> +
> +void drmcgrp_chg_mem(struct ttm_buffer_object *tbo)
> +{
> +	struct drm_device *dev = tbo->bdev->ddev;
> +	struct drmcgrp *drmcgrp = tbo->drmcgrp;
> +	int devIdx = dev->primary->index;
> +	s64 size = (s64)(tbo->mem.size);
> +	int mem_type = tbo->mem.mem_type;
> +	struct drmcgrp_device_resource *ddr;
> +
> +	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
> +		return;
> +
> +	mem_type = mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : mem_type;
> +
> +	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> +	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
> +		ddr = drmcgrp->dev_resources[devIdx];
> +		ddr->mem_stats[mem_type] += size;
> +	}
> +	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_chg_mem);
> +
> +void drmcgrp_unchg_mem(struct ttm_buffer_object *tbo)
> +{
> +	struct drm_device *dev = tbo->bdev->ddev;
> +	struct drmcgrp *drmcgrp = tbo->drmcgrp;
> +	int devIdx = dev->primary->index;
> +	s64 size = (s64)(tbo->mem.size);
> +	int mem_type = tbo->mem.mem_type;
> +	struct drmcgrp_device_resource *ddr;
> +
> +	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
> +		return;
> +
> +	mem_type = mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : mem_type;
> +
> +	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> +	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
> +		ddr = drmcgrp->dev_resources[devIdx];
> +		ddr->mem_stats[mem_type] -= size;
> +	}
> +	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_unchg_mem);
> +
> +void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
> +		struct ttm_mem_reg *new_mem)
> +{
> +	struct drm_device *dev = old_bo->bdev->ddev;
> +	struct drmcgrp *drmcgrp = old_bo->drmcgrp;
> +	s64 move_in_bytes = (s64)(old_bo->mem.size);
> +	int devIdx = dev->primary->index;
> +	int old_mem_type = old_bo->mem.mem_type;
> +	int new_mem_type = new_mem->mem_type;
> +	struct drmcgrp_device_resource *ddr;
> +	struct drmcgrp_device *known_dev;
> +
> +	known_dev = known_drmcgrp_devs[devIdx];
> +
> +	if (drmcgrp == NULL || known_dev == NULL)
> +		return;
> +
> +	old_mem_type = old_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : old_mem_type;
> +	new_mem_type = new_mem_type > TTM_PL_PRIV ? TTM_PL_PRIV : new_mem_type;
> +
> +	mutex_lock(&known_dev->mutex);
> +	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
> +		ddr = drmcgrp->dev_resources[devIdx];
> +		ddr->mem_stats[old_mem_type] -= move_in_bytes;
> +		ddr->mem_stats[new_mem_type] += move_in_bytes;
> +
> +		if (evict)
> +			ddr->mem_stats_evict++;
> +	}
> +	mutex_unlock(&known_dev->mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_mem_track_move);
> -- 
> 2.21.0
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
