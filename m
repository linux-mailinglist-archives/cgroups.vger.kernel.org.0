Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1656F07
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 18:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFZQou (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 12:44:50 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39753 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfFZQot (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 12:44:49 -0400
Received: by mail-ed1-f68.google.com with SMTP id m10so4202767edv.6
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oselr/m9/Hr9+JHt7Arm6QQl9sjyCVJ1rC0IMcg5BPE=;
        b=clKAKTua6QkxD6qqZp04/CEGb2tdY1HTGdrxWHox6zSXhiwzZmQ5vYGYOT1X0uplJH
         tY5fntPval8PTYEMxuzfsigEquFbFQz8fxNARWRye04EZcE8xzuj+6jQx+YYeSTxsXJH
         TPAiQkQDwEG9VSRZAsVk/0abjppeVscqmeucQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=oselr/m9/Hr9+JHt7Arm6QQl9sjyCVJ1rC0IMcg5BPE=;
        b=dtzPVh+JfJDAghgszcn+P1wBNc8R1S5FjSTSucnfSwVCv/dy6YiGoLXrgMwZAdH3zm
         9bFWpfLAQWcJRT5+KLMqqmPEAMEiJro4hzyFJTMlPC3//R7vTkLfsknd8s8XwiemBrY5
         H188/dbZYAUUzHsS917BrvRfqDEbX5OrIGYLQT/Sakt8YE8T8xwmS0aeES+aLEzAhRNF
         9kxhGQ2W+I5hQUzGeU7Euo9fybLP7xDDE0nOPbwku3EAKvLw6rpxAy84yaaf06iWfwlZ
         4/EyZf9yINu3kJ7Eby76nUdnrBhdp2U3Zv5GWv9wSBsDo8+NHHjN/8bRioOxmKpIGElj
         trpA==
X-Gm-Message-State: APjAAAUK8VLudsW14q8sDpsABhHt+XC3RK2kN9JA7xb8nEocrXKMCgwP
        9sZV8VzuYG9soi8DHeTziP0WMg==
X-Google-Smtp-Source: APXvYqzftAq+Swr9G4SiESjI5/0fCVjo3NAsNB3MzQFX+QBB4Q8XwSJP976qbep4Gws1n7OXjeK1tQ==
X-Received: by 2002:a17:906:1953:: with SMTP id b19mr4949984eje.309.1561567487243;
        Wed, 26 Jun 2019 09:44:47 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j30sm5803242edb.8.2019.06.26.09.44.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:44:46 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:44:44 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 11/11] drm, cgroup: Allow more aggressive memory
 reclaim
Message-ID: <20190626164444.GX12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-12-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626150522.11618-12-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:05:22AM -0400, Kenny Ho wrote:
> Allow DRM TTM memory manager to register a work_struct, such that, when
> a drmcgrp is under memory pressure, memory reclaiming can be triggered
> immediately.
> 
> Change-Id: I25ac04e2db9c19ff12652b88ebff18b44b2706d8
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c    | 47 +++++++++++++++++++++++++++++++++
>  include/drm/drm_cgroup.h        | 14 ++++++++++
>  include/drm/ttm/ttm_bo_driver.h |  2 ++
>  kernel/cgroup/drm.c             | 33 +++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 79c530f4a198..5fc3bc5bd4c5 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -1509,6 +1509,44 @@ int ttm_bo_evict_mm(struct ttm_bo_device *bdev, unsigned mem_type)
>  }
>  EXPORT_SYMBOL(ttm_bo_evict_mm);
>  
> +static void ttm_bo_reclaim_wq(struct work_struct *work)
> +{

I think a design a bit more inspired by memcg aware core shrinkers would
be nice, i.e. explicitly passing:
- which drm_cgroup needs to be shrunk
- which ttm_mem_reg (well the fancy new abstracted out stuff for tracking
  special gpu memory resources like tt or vram or whatever)
- how much it needs to be shrunk

I think with that a lot more the book-keeping could be pushed into the
drm_cgroup code, and the callback just needs to actually shrink enough as
requested.
-Daniel

> +	struct ttm_operation_ctx ctx = {
> +		.interruptible = false,
> +		.no_wait_gpu = false,
> +		.flags = TTM_OPT_FLAG_FORCE_ALLOC
> +	};
> +	struct ttm_mem_type_manager *man =
> +	    container_of(work, struct ttm_mem_type_manager, reclaim_wq);
> +	struct ttm_bo_device *bdev = man->bdev;
> +	struct dma_fence *fence;
> +	int mem_type;
> +	int ret;
> +
> +	for (mem_type = 0; mem_type < TTM_NUM_MEM_TYPES; mem_type++)
> +		if (&bdev->man[mem_type] == man)
> +			break;
> +
> +	BUG_ON(mem_type >= TTM_NUM_MEM_TYPES);
> +
> +	if (!drmcgrp_mem_pressure_scan(bdev, mem_type))
> +		return;
> +
> +	ret = ttm_mem_evict_first(bdev, mem_type, NULL, &ctx);
> +	if (ret)
> +		return;
> +
> +	spin_lock(&man->move_lock);
> +	fence = dma_fence_get(man->move);
> +	spin_unlock(&man->move_lock);
> +
> +	if (fence) {
> +		ret = dma_fence_wait(fence, false);
> +		dma_fence_put(fence);
> +	}
> +
> +}
> +
>  int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
>  			unsigned long p_size)
>  {
> @@ -1543,6 +1581,13 @@ int ttm_bo_init_mm(struct ttm_bo_device *bdev, unsigned type,
>  		INIT_LIST_HEAD(&man->lru[i]);
>  	man->move = NULL;
>  
> +	pr_err("drmcgrp %p type %d\n", bdev->ddev, type);
> +
> +	if (type <= TTM_PL_VRAM) {
> +		INIT_WORK(&man->reclaim_wq, ttm_bo_reclaim_wq);
> +		drmcgrp_register_device_mm(bdev->ddev, type, &man->reclaim_wq);
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(ttm_bo_init_mm);
> @@ -1620,6 +1665,8 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
>  		man = &bdev->man[i];
>  		if (man->has_type) {
>  			man->use_type = false;
> +			drmcgrp_unregister_device_mm(bdev->ddev, i);
> +			cancel_work_sync(&man->reclaim_wq);
>  			if ((i != TTM_PL_SYSTEM) && ttm_bo_clean_mm(bdev, i)) {
>  				ret = -EBUSY;
>  				pr_err("DRM memory manager type %d is not clean\n",
> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> index 360c1e6c809f..134d6e5475f3 100644
> --- a/include/drm/drm_cgroup.h
> +++ b/include/drm/drm_cgroup.h
> @@ -5,6 +5,7 @@
>  #define __DRM_CGROUP_H__
>  
>  #include <linux/cgroup_drm.h>
> +#include <linux/workqueue.h>
>  #include <drm/ttm/ttm_bo_api.h>
>  #include <drm/ttm/ttm_bo_driver.h>
>  
> @@ -12,6 +13,9 @@
>  
>  int drmcgrp_register_device(struct drm_device *device);
>  int drmcgrp_unregister_device(struct drm_device *device);
> +void drmcgrp_register_device_mm(struct drm_device *dev, unsigned type,
> +		struct work_struct *wq);
> +void drmcgrp_unregister_device_mm(struct drm_device *dev, unsigned type);
>  bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
>  		struct drmcgrp *relative);
>  void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> @@ -40,6 +44,16 @@ static inline int drmcgrp_unregister_device(struct drm_device *device)
>  	return 0;
>  }
>  
> +static inline void drmcgrp_register_device_mm(struct drm_device *dev,
> +		unsigned type, struct work_struct *wq)
> +{
> +}
> +
> +static inline void drmcgrp_unregister_device_mm(struct drm_device *dev,
> +		unsigned type)
> +{
> +}
> +
>  static inline bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
>  		struct drmcgrp *relative)
>  {
> diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
> index 4cbcb41e5aa9..0956ca7888fc 100644
> --- a/include/drm/ttm/ttm_bo_driver.h
> +++ b/include/drm/ttm/ttm_bo_driver.h
> @@ -205,6 +205,8 @@ struct ttm_mem_type_manager {
>  	 * Protected by @move_lock.
>  	 */
>  	struct dma_fence *move;
> +
> +	struct work_struct reclaim_wq;
>  };
>  
>  /**
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index 1ce13db36ce9..985a89e849d3 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -31,6 +31,8 @@ struct drmcgrp_device {
>  	s64			mem_bw_avg_bytes_per_us_default;
>  
>  	s64			mem_highs_default[TTM_PL_PRIV+1];
> +
> +	struct work_struct	*mem_reclaim_wq[TTM_PL_PRIV];
>  };
>  
>  #define DRMCG_CTF_PRIV_SIZE 3
> @@ -793,6 +795,31 @@ int drmcgrp_unregister_device(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(drmcgrp_unregister_device);
>  
> +void drmcgrp_register_device_mm(struct drm_device *dev, unsigned type,
> +		struct work_struct *wq)
> +{
> +	if (dev == NULL || dev->primary->index > max_minor
> +			|| type >= TTM_PL_PRIV)
> +		return;
> +
> +	mutex_lock(&drmcgrp_mutex);
> +	known_drmcgrp_devs[dev->primary->index]->mem_reclaim_wq[type] = wq;
> +	mutex_unlock(&drmcgrp_mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_register_device_mm);
> +
> +void drmcgrp_unregister_device_mm(struct drm_device *dev, unsigned type)
> +{
> +	if (dev == NULL || dev->primary->index > max_minor
> +			|| type >= TTM_PL_PRIV)
> +		return;
> +
> +	mutex_lock(&drmcgrp_mutex);
> +	known_drmcgrp_devs[dev->primary->index]->mem_reclaim_wq[type] = NULL;
> +	mutex_unlock(&drmcgrp_mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_unregister_device_mm);
> +
>  bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self, struct drmcgrp *relative)
>  {
>  	for (; self != NULL; self = parent_drmcgrp(self))
> @@ -1004,6 +1031,12 @@ void drmcgrp_mem_track_move(struct ttm_buffer_object *old_bo, bool evict,
>  
>  		ddr->mem_bw_stats[DRMCGRP_MEM_BW_ATTR_BYTE_CREDIT]
>  			-= move_in_bytes;
> +
> +		if (known_dev->mem_reclaim_wq[new_mem_type] != NULL &&
> +                        ddr->mem_stats[new_mem_type] >
> +				ddr->mem_highs[new_mem_type])
> +			schedule_work(
> +				known_dev->mem_reclaim_wq[new_mem_type]);
>  	}
>  	mutex_unlock(&known_dev->mutex);
>  }
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
