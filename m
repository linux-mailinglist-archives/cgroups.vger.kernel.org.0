Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA3956E50
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 18:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZQF7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 12:05:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36147 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQF7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 12:05:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so4082586edq.3
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 09:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A+EpXpfoJ8iYiW+nfqWZW0jNTe/ono+nTDZMvRVkbH8=;
        b=d7bBjSNgp+vldolslUXxoCWY9e+2SDCKiE5QbbVNcm5KhUhkoG4ezACJi/VM3xn88M
         LeZ4lYAH7ipougUM6Tq7vRa7paOuD8DJ0i1okXstIw7pq0ZG7drj0ekFLcZQKp0G63JR
         B9ZazqeOhtc1cpybjYAjLmU9dYUOcgnEN+YaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A+EpXpfoJ8iYiW+nfqWZW0jNTe/ono+nTDZMvRVkbH8=;
        b=Rw14xWHWhRvJpN0xKGzyzRF5m2wee/+Hps1d4gKrMs1a1/4Kj6PMffDtwZUWI0Obcb
         y4x4aV5Hj+qhRfzChEDoAVgQ9B3YwsleXoIkFWq1n3B/frrE4+MVGTEGfh2EuRRk3oHK
         c6tdxMI1sFdoKaNO4rc+aSgZ+qJpz6VltJWYCBPIG/8SEbwR6f37cWs1sV2SHxaVZTlF
         jLXXArgXcYWpJ3jka8e76X3jmvsw5+Gui5jmybguiSyeabU+YRiXeF2V5Ygsr7Qcr8uh
         wBTAnp/he4UcQmqBHnV3dCaoFPUuvqGY62i2UFfGT+sr9CQbU4Vc9lGhi59EfpiW7j4b
         koFQ==
X-Gm-Message-State: APjAAAUhZQOu8uMcsGfbnOIx3Q/dZEzVkcmLCS0Q4MyxcFKLmBWNjV9t
        N6NLNKoGwM2WeRzbmByBYz+qZg==
X-Google-Smtp-Source: APXvYqwbhA3pBgieHde0c5d8BHChR4ve3IhSz1xiGO7u4jqNZCw1KVdQ16WChSXWUa4LdDHcVNK5eg==
X-Received: by 2002:a50:9203:: with SMTP id i3mr6448122eda.302.1561565156356;
        Wed, 26 Jun 2019 09:05:56 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id j13sm1152951ejt.13.2019.06.26.09.05.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 09:05:55 -0700 (PDT)
Date:   Wed, 26 Jun 2019 18:05:53 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 04/11] drm, cgroup: Add total GEM buffer
 allocation limit
Message-ID: <20190626160553.GR12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-5-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626150522.11618-5-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:05:15AM -0400, Kenny Ho wrote:
> The drm resource being measured and limited here is the GEM buffer
> objects.  User applications allocate and free these buffers.  In
> addition, a process can allocate a buffer and share it with another
> process.  The consumer of a shared buffer can also outlive the
> allocator of the buffer.
> 
> For the purpose of cgroup accounting and limiting, ownership of the
> buffer is deemed to be the cgroup for which the allocating process
> belongs to.  There is one cgroup limit per drm device.
> 
> In order to prevent the buffer outliving the cgroup that owns it, a
> process is prevented from importing buffers that are not own by the
> process' cgroup or the ancestors of the process' cgroup.  In other
> words, in order for a buffer to be shared between two cgroups, the
> buffer must be created by the common ancestors of the cgroups.
> 
> drm.buffer.stats
>         A read-only flat-keyed file which exists on all cgroups.  Each
>         entry is keyed by the drm device's major:minor.
> 
>         Total GEM buffer allocation in bytes.
> 
> drm.buffer.default
>         A read-only flat-keyed file which exists on the root cgroup.
>         Each entry is keyed by the drm device's major:minor.
> 
>         Default limits on the total GEM buffer allocation in bytes.

Don't we need a "0 means no limit" semantics here?

> drm.buffer.max
>         A read-write flat-keyed file which exists on all cgroups.  Each
>         entry is keyed by the drm device's major:minor.
> 
>         Per device limits on the total GEM buffer allocation in byte.
>         This is a hard limit.  Attempts in allocating beyond the cgroup
>         limit will result in ENOMEM.  Shorthand understood by memparse
>         (such as k, m, g) can be used.
> 
>         Set allocation limit for /dev/dri/card1 to 1GB
>         echo "226:1 1g" > drm.buffer.total.max
> 
>         Set allocation limit for /dev/dri/card0 to 512MB
>         echo "226:0 512m" > drm.buffer.total.max

I think we need a new drm-cgroup.rst which contains all this
documentation.

With multiple GPUs, do we need an overall GEM bo limit, across all gpus?
For other stuff later on like vram/tt/... and all that it needs to be
per-device, but I think one overall limit could be useful.

> 
> Change-Id: I4c249d06d45ec709d6481d4cbe87c5168545c5d0
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +
>  drivers/gpu/drm/drm_gem.c                  |   8 +
>  drivers/gpu/drm/drm_prime.c                |   9 +
>  include/drm/drm_cgroup.h                   |  34 ++-
>  include/drm/drm_gem.h                      |  11 +
>  include/linux/cgroup_drm.h                 |   2 +
>  kernel/cgroup/drm.c                        | 321 +++++++++++++++++++++
>  7 files changed, 387 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 93b2c5a48a71..b4c078b7ad63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -34,6 +34,7 @@
>  #include <drm/drmP.h>
>  #include <drm/amdgpu_drm.h>
>  #include <drm/drm_cache.h>
> +#include <drm/drm_cgroup.h>
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_amdkfd.h"
> @@ -446,6 +447,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>  	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
>  		return -ENOMEM;
>  
> +	if (!drmcgrp_bo_can_allocate(current, adev->ddev, size))
> +		return -ENOMEM;

So what happens when you start a lot of threads all at the same time,
allocating gem bo? Also would be nice if we could roll out at least the
accounting part of this cgroup to all GEM drivers.

> +
>  	*bo_ptr = NULL;
>  
>  	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6a80db077dc6..e20c1034bf2b 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -37,10 +37,12 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/dma-buf.h>
>  #include <linux/mem_encrypt.h>
> +#include <linux/cgroup_drm.h>
>  #include <drm/drmP.h>
>  #include <drm/drm_vma_manager.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_print.h>
> +#include <drm/drm_cgroup.h>
>  #include "drm_internal.h"
>  
>  /** @file drm_gem.c
> @@ -154,6 +156,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
>  	obj->handle_count = 0;
>  	obj->size = size;
>  	drm_vma_node_reset(&obj->vma_node);
> +
> +	obj->drmcgrp = get_drmcgrp(current);
> +	drmcgrp_chg_bo_alloc(obj->drmcgrp, dev, size);
>  }
>  EXPORT_SYMBOL(drm_gem_private_object_init);
>  
> @@ -804,6 +809,9 @@ drm_gem_object_release(struct drm_gem_object *obj)
>  	if (obj->filp)
>  		fput(obj->filp);
>  
> +	drmcgrp_unchg_bo_alloc(obj->drmcgrp, obj->dev, obj->size);
> +	put_drmcgrp(obj->drmcgrp);
> +
>  	drm_gem_free_mmap_offset(obj);
>  }
>  EXPORT_SYMBOL(drm_gem_object_release);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 231e3f6d5f41..eeb612116810 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -32,6 +32,7 @@
>  #include <drm/drm_prime.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drmP.h>
> +#include <drm/drm_cgroup.h>
>  
>  #include "drm_internal.h"
>  
> @@ -794,6 +795,7 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>  {
>  	struct dma_buf *dma_buf;
>  	struct drm_gem_object *obj;
> +	struct drmcgrp *drmcgrp = drmcgrp_from(current);
>  	int ret;
>  
>  	dma_buf = dma_buf_get(prime_fd);
> @@ -818,6 +820,13 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>  		goto out_unlock;
>  	}
>  
> +	/* only allow bo from the same cgroup or its ancestor to be imported */
> +	if (drmcgrp != NULL &&

Quite a serious limitation here ...

> +			!drmcgrp_is_self_or_ancestor(drmcgrp, obj->drmcgrp)) {

Also what happens if you actually share across devices? Then importing in
the 2nd group is suddenly possible, and I think will be double-counted.

What's the underlying technical reason for not allowing sharing across
cgroups?

> +		ret = -EACCES;
> +		goto out_unlock;
> +	}
> +
>  	if (obj->dma_buf) {
>  		WARN_ON(obj->dma_buf != dma_buf);
>  	} else {
> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> index ddb9eab64360..8711b7c5f7bf 100644
> --- a/include/drm/drm_cgroup.h
> +++ b/include/drm/drm_cgroup.h
> @@ -4,12 +4,20 @@
>  #ifndef __DRM_CGROUP_H__
>  #define __DRM_CGROUP_H__
>  
> +#include <linux/cgroup_drm.h>
> +
>  #ifdef CONFIG_CGROUP_DRM
>  
>  int drmcgrp_register_device(struct drm_device *device);
> -
>  int drmcgrp_unregister_device(struct drm_device *device);
> -
> +bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
> +		struct drmcgrp *relative);
> +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> +		size_t size);
> +void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> +		size_t size);
> +bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
> +		size_t size);
>  #else
>  static inline int drmcgrp_register_device(struct drm_device *device)
>  {
> @@ -20,5 +28,27 @@ static inline int drmcgrp_unregister_device(struct drm_device *device)
>  {
>  	return 0;
>  }
> +
> +static inline bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
> +		struct drmcgrp *relative)
> +{
> +	return false;
> +}
> +
> +static inline void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp,
> +		struct drm_device *dev,	size_t size)
> +{
> +}
> +
> +static inline void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp,
> +		struct drm_device *dev,	size_t size)
> +{
> +}
> +
> +static inline bool drmcgrp_bo_can_allocate(struct task_struct *task,
> +		struct drm_device *dev,	size_t size)
> +{
> +	return true;
> +}
>  #endif /* CONFIG_CGROUP_DRM */
>  #endif /* __DRM_CGROUP_H__ */
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index c95727425284..09d1c69a3f0c 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -272,6 +272,17 @@ struct drm_gem_object {
>  	 *
>  	 */
>  	const struct drm_gem_object_funcs *funcs;
> +
> +	/**
> +	 * @drmcgrp:
> +	 *
> +	 * DRM cgroup this GEM object belongs to.
> +	 *
> +	 * This is used to track and limit the amount of GEM objects a user
> +	 * can allocate.  Since GEM objects can be shared, this is also used
> +	 * to ensure GEM objects are only shared within the same cgroup.
> +	 */
> +	struct drmcgrp *drmcgrp;
>  };
>  
>  /**
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> index 27497f786c93..efa019666f1c 100644
> --- a/include/linux/cgroup_drm.h
> +++ b/include/linux/cgroup_drm.h
> @@ -15,6 +15,8 @@
>  
>  struct drmcgrp_device_resource {
>  	/* for per device stats */
> +	s64			bo_stats_total_allocated;
> +	s64			bo_limits_total_allocated;
>  };
>  
>  struct drmcgrp {
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index 7da6e0d93991..cfc1fe74dca3 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -9,6 +9,7 @@
>  #include <linux/cgroup_drm.h>
>  #include <linux/kernel.h>
>  #include <drm/drm_device.h>
> +#include <drm/drm_ioctl.h>
>  #include <drm/drm_cgroup.h>
>  
>  static DEFINE_MUTEX(drmcgrp_mutex);
> @@ -16,6 +17,26 @@ static DEFINE_MUTEX(drmcgrp_mutex);
>  struct drmcgrp_device {
>  	struct drm_device	*dev;
>  	struct mutex		mutex;
> +
> +	s64			bo_limits_total_allocated_default;
> +};
> +
> +#define DRMCG_CTF_PRIV_SIZE 3
> +#define DRMCG_CTF_PRIV_MASK GENMASK((DRMCG_CTF_PRIV_SIZE - 1), 0)
> +#define DRMCG_CTF_PRIV(res_type, f_type)  ((res_type) <<\
> +		DRMCG_CTF_PRIV_SIZE | (f_type))
> +#define DRMCG_CTF_PRIV2RESTYPE(priv) ((priv) >> DRMCG_CTF_PRIV_SIZE)
> +#define DRMCG_CTF_PRIV2FTYPE(priv) ((priv) & DRMCG_CTF_PRIV_MASK)
> +
> +
> +enum drmcgrp_res_type {
> +	DRMCGRP_TYPE_BO_TOTAL,
> +};
> +
> +enum drmcgrp_file_type {
> +	DRMCGRP_FTYPE_STATS,
> +	DRMCGRP_FTYPE_LIMIT,
> +	DRMCGRP_FTYPE_DEFAULT,
>  };
>  
>  /* indexed by drm_minor for access speed */
> @@ -54,6 +75,10 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
>  	}
>  
>  	/* set defaults here */
> +	if (known_drmcgrp_devs[minor] != NULL) {
> +		ddr->bo_limits_total_allocated =
> +		  known_drmcgrp_devs[minor]->bo_limits_total_allocated_default;
> +	}
>  
>  	return 0;
>  }
> @@ -100,7 +125,225 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
>  	return &drmcgrp->css;
>  }
>  
> +static inline void drmcgrp_print_stats(struct drmcgrp_device_resource *ddr,
> +		struct seq_file *sf, enum drmcgrp_res_type type)
> +{
> +	if (ddr == NULL) {
> +		seq_puts(sf, "\n");
> +		return;
> +	}
> +
> +	switch (type) {
> +	case DRMCGRP_TYPE_BO_TOTAL:
> +		seq_printf(sf, "%lld\n", ddr->bo_stats_total_allocated);
> +		break;
> +	default:
> +		seq_puts(sf, "\n");
> +		break;
> +	}
> +}
> +
> +static inline void drmcgrp_print_limits(struct drmcgrp_device_resource *ddr,
> +		struct seq_file *sf, enum drmcgrp_res_type type)
> +{
> +	if (ddr == NULL) {
> +		seq_puts(sf, "\n");
> +		return;
> +	}
> +
> +	switch (type) {
> +	case DRMCGRP_TYPE_BO_TOTAL:
> +		seq_printf(sf, "%lld\n", ddr->bo_limits_total_allocated);
> +		break;
> +	default:
> +		seq_puts(sf, "\n");
> +		break;
> +	}
> +}
> +
> +static inline void drmcgrp_print_default(struct drmcgrp_device *ddev,
> +		struct seq_file *sf, enum drmcgrp_res_type type)
> +{
> +	if (ddev == NULL) {
> +		seq_puts(sf, "\n");
> +		return;
> +	}
> +
> +	switch (type) {
> +	case DRMCGRP_TYPE_BO_TOTAL:
> +		seq_printf(sf, "%lld\n",
> +				ddev->bo_limits_total_allocated_default);
> +		break;
> +	default:
> +		seq_puts(sf, "\n");
> +		break;
> +	}
> +}
> +
> +int drmcgrp_bo_show(struct seq_file *sf, void *v)
> +{
> +	struct drmcgrp *drmcgrp = css_drmcgrp(seq_css(sf));
> +	struct drmcgrp_device_resource *ddr = NULL;
> +	enum drmcgrp_file_type f_type =
> +		DRMCG_CTF_PRIV2FTYPE(seq_cft(sf)->private);
> +	enum drmcgrp_res_type type =
> +		DRMCG_CTF_PRIV2RESTYPE(seq_cft(sf)->private);
> +	struct drmcgrp_device *ddev;
> +	int i;
> +
> +	for (i = 0; i <= max_minor; i++) {
> +		ddr = drmcgrp->dev_resources[i];
> +		ddev = known_drmcgrp_devs[i];
> +
> +		seq_printf(sf, "%d:%d ", DRM_MAJOR, i);
> +
> +		switch (f_type) {
> +		case DRMCGRP_FTYPE_STATS:
> +			drmcgrp_print_stats(ddr, sf, type);
> +			break;
> +		case DRMCGRP_FTYPE_LIMIT:
> +			drmcgrp_print_limits(ddr, sf, type);
> +			break;
> +		case DRMCGRP_FTYPE_DEFAULT:
> +			drmcgrp_print_default(ddev, sf, type);
> +			break;
> +		default:
> +			seq_puts(sf, "\n");
> +			break;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void drmcgrp_pr_cft_err(const struct drmcgrp *drmcgrp,
> +		const char *cft_name, int minor)
> +{
> +	pr_err("drmcgrp: error parsing %s, minor %d ",
> +			cft_name, minor);
> +	pr_cont_cgroup_name(drmcgrp->css.cgroup);
> +	pr_cont("\n");
> +}
> +
> +static inline int drmcgrp_process_limit_val(char *sval, bool is_mem,
> +			s64 def_val, s64 max_val, s64 *ret_val)
> +{
> +	int rc = strcmp("max", sval);
> +
> +
> +	if (!rc)
> +		*ret_val = max_val;
> +	else {
> +		rc = strcmp("default", sval);
> +
> +		if (!rc)
> +			*ret_val = def_val;
> +	}
> +
> +	if (rc) {
> +		if (is_mem) {
> +			*ret_val = memparse(sval, NULL);
> +			rc = 0;
> +		} else {
> +			rc = kstrtoll(sval, 0, ret_val);
> +		}
> +	}
> +
> +	if (*ret_val > max_val)
> +		*ret_val = max_val;
> +
> +	return rc;
> +}
> +
> +ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
> +		size_t nbytes, loff_t off)
> +{
> +	struct drmcgrp *drmcgrp = css_drmcgrp(of_css(of));
> +	struct drmcgrp *parent = parent_drmcgrp(drmcgrp);
> +	enum drmcgrp_res_type type =
> +		DRMCG_CTF_PRIV2RESTYPE(of_cft(of)->private);
> +	char *cft_name = of_cft(of)->name;
> +	char *limits = strstrip(buf);
> +	struct drmcgrp_device *ddev;
> +	struct drmcgrp_device_resource *ddr;
> +	char *line;
> +	char sattr[256];
> +	s64 val;
> +	s64 p_max;
> +	int rc;
> +	int minor;
> +
> +	while (limits != NULL) {
> +		line =  strsep(&limits, "\n");
> +
> +		if (sscanf(line,
> +			__stringify(DRM_MAJOR)":%u %255[^\t\n]",
> +							&minor, sattr) != 2) {
> +			pr_err("drmcgrp: error parsing %s ", cft_name);
> +			pr_cont_cgroup_name(drmcgrp->css.cgroup);
> +			pr_cont("\n");
> +
> +			continue;
> +		}
> +
> +		if (minor < 0 || minor > max_minor) {
> +			pr_err("drmcgrp: invalid minor %d for %s ",
> +					minor, cft_name);
> +			pr_cont_cgroup_name(drmcgrp->css.cgroup);
> +			pr_cont("\n");
> +
> +			continue;
> +		}
> +
> +		ddr = drmcgrp->dev_resources[minor];
> +		ddev = known_drmcgrp_devs[minor];
> +		switch (type) {
> +		case DRMCGRP_TYPE_BO_TOTAL:
> +			p_max = parent == NULL ? S64_MAX :
> +				parent->dev_resources[minor]->
> +				bo_limits_total_allocated;
> +
> +			rc = drmcgrp_process_limit_val(sattr, true,
> +				ddev->bo_limits_total_allocated_default,
> +				p_max,
> +				&val);
> +
> +			if (rc || val < 0) {
> +				drmcgrp_pr_cft_err(drmcgrp, cft_name, minor);
> +				continue;
> +			}
> +
> +			ddr->bo_limits_total_allocated = val;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return nbytes;
> +}
> +
>  struct cftype files[] = {
> +	{
> +		.name = "buffer.total.stats",
> +		.seq_show = drmcgrp_bo_show,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_TOTAL,
> +						DRMCGRP_FTYPE_STATS),
> +	},
> +	{
> +		.name = "buffer.total.default",
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_TOTAL,
> +						DRMCGRP_FTYPE_DEFAULT),
> +	},
> +	{
> +		.name = "buffer.total.max",
> +		.write = drmcgrp_bo_limit_write,
> +		.seq_show = drmcgrp_bo_show,
> +		.private = DRMCG_CTF_PRIV(DRMCGRP_TYPE_BO_TOTAL,
> +						DRMCGRP_FTYPE_LIMIT),
> +	},
>  	{ }	/* terminate */
>  };
>  
> @@ -121,6 +364,8 @@ int drmcgrp_register_device(struct drm_device *dev)
>  		return -ENOMEM;
>  
>  	ddev->dev = dev;
> +	ddev->bo_limits_total_allocated_default = S64_MAX;
> +
>  	mutex_init(&ddev->mutex);
>  
>  	mutex_lock(&drmcgrp_mutex);
> @@ -156,3 +401,79 @@ int drmcgrp_unregister_device(struct drm_device *dev)
>  	return 0;
>  }
>  EXPORT_SYMBOL(drmcgrp_unregister_device);
> +
> +bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self, struct drmcgrp *relative)
> +{
> +	for (; self != NULL; self = parent_drmcgrp(self))
> +		if (self == relative)
> +			return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL(drmcgrp_is_self_or_ancestor);
> +
> +bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
> +		size_t size)
> +{
> +	struct drmcgrp *drmcgrp = drmcgrp_from(task);
> +	struct drmcgrp_device_resource *ddr;
> +	struct drmcgrp_device_resource *d;
> +	int devIdx = dev->primary->index;
> +	bool result = true;
> +	s64 delta = 0;
> +
> +	if (drmcgrp == NULL || drmcgrp == root_drmcgrp)
> +		return true;
> +
> +	ddr = drmcgrp->dev_resources[devIdx];
> +	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> +	for ( ; drmcgrp != root_drmcgrp; drmcgrp = parent_drmcgrp(drmcgrp)) {
> +		d = drmcgrp->dev_resources[devIdx];
> +		delta = d->bo_limits_total_allocated -
> +				d->bo_stats_total_allocated;
> +
> +		if (delta <= 0 || size > delta) {
> +			result = false;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> +
> +	return result;
> +}
> +EXPORT_SYMBOL(drmcgrp_bo_can_allocate);
> +
> +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> +		size_t size)
> +{
> +	struct drmcgrp_device_resource *ddr;
> +	int devIdx = dev->primary->index;
> +
> +	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
> +		return;
> +
> +	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> +	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp)) {
> +		ddr = drmcgrp->dev_resources[devIdx];
> +
> +		ddr->bo_stats_total_allocated += (s64)size;
> +	}
> +	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_chg_bo_alloc);
> +
> +void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> +		size_t size)
> +{
> +	int devIdx = dev->primary->index;
> +
> +	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
> +		return;
> +
> +	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> +	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp))
> +		drmcgrp->dev_resources[devIdx]->bo_stats_total_allocated
> +			-= (s64)size;
> +	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_unchg_bo_alloc);
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
