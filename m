Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53D19D3C
	for <lists+cgroups@lfdr.de>; Fri, 10 May 2019 14:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfEJM21 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 10 May 2019 08:28:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39938 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbfEJM20 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 10 May 2019 08:28:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so7691857wre.7
        for <cgroups@vger.kernel.org>; Fri, 10 May 2019 05:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VyipZYnOqA+ocOrReFp15qI2bA0IF4Q28CKXaKiV9bw=;
        b=S8zCLbBEZNhofiFoiPsiqz8teOLbY5wF60cJSC9GcRQuhAtSjBmuluTPbLtLwrh7FV
         WO6esPFHxXhqHnOg5bx+QyNSUF3g9jjApKIF8wmDsacMQ0avt0qkloAXhuu++LEjaIxx
         i4ST3fWY94n9sn5h2BBEhxt/9jFpjZ+fuSp3sCBpDRpfgD7gaK6Sd/yVrgQ8JELqboKg
         VU24OmEZA/StXLZGOJaVYKd3fJcJMfCX8tkGPkMKUlon3BTihD+Vj67gEfljPx3yrKB5
         TPyTfauetwh610rmuV09QmdPvT9HSLnEjtZn/SvHsR74Q9rQtPAptfO4pP6BUwNc6ctF
         npVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VyipZYnOqA+ocOrReFp15qI2bA0IF4Q28CKXaKiV9bw=;
        b=fZImIit/ghEAs4eLunYiP7+6uYRO03mwyPDAemIPO2CrTBghR1AwxspeUIvoDaixih
         63AlT8l/43ccg701kWs1yfyw+YngcHtNf0K3yYsluj14xLBM+BAp/hF0dWOJQE5eGyOv
         J8iCIKWHKDm4DoIZ11Dbf+w9/fDQbS18QbA7wOfodqhxMtD44FMAI//8pPHiUtHWrWGx
         MVjQlVNSnyONy2YOBaP/FCIb7mpZtrAJc9h5geygghCi31fdk3W7uCNBb7qt57/qGq6Y
         UntHnJ5Wj0ozRQUEWoYtgASqVtmri8HMSJoWeuJlswXHLiH3JVAKxvt1Eocu02Jk3Yev
         6zlA==
X-Gm-Message-State: APjAAAXt6i/5Z8r7i6K96iDg6WdJ4YoEuOKUgdLgj4vZ+uVgVnzTnezR
        uYh7qTjQOyu/7JPubHcLbXQ=
X-Google-Smtp-Source: APXvYqxl+IHhAZInb1TuhRDgyA0G9zyny9u1Oc1xV8vCIhgFFOLjStUtG5L20juHiCwkZMoCyD8qmg==
X-Received: by 2002:adf:e6ce:: with SMTP id y14mr345495wrm.217.1557491303169;
        Fri, 10 May 2019 05:28:23 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id o16sm4112559wro.63.2019.05.10.05.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 05:28:21 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC PATCH v2 4/5] drm, cgroup: Add total GEM buffer allocation
 limit
To:     Kenny Ho <Kenny.Ho@amd.com>, y2kenny@gmail.com,
        cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, tj@kernel.org,
        sunnanyong@huawei.com, alexander.deucher@amd.com,
        brian.welty@intel.com
References: <20181120185814.13362-1-Kenny.Ho@amd.com>
 <20190509210410.5471-1-Kenny.Ho@amd.com>
 <20190509210410.5471-5-Kenny.Ho@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <f63c8d6b-92a4-2977-d062-7e0b7036834e@gmail.com>
Date:   Fri, 10 May 2019 14:28:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509210410.5471-5-Kenny.Ho@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Am 09.05.19 um 23:04 schrieb Kenny Ho:
> The drm resource being measured and limited here is the GEM buffer
> objects.  User applications allocate and free these buffers.  In
> addition, a process can allocate a buffer and share it with another
> process.  The consumer of a shared buffer can also outlive the
> allocator of the buffer.
>
> For the purpose of cgroup accounting and limiting, ownership of the
> buffer is deemed to be the cgroup for which the allocating process
> belongs to.  There is one limit per drm device.
>
> In order to prevent the buffer outliving the cgroup that owns it, a
> process is prevented from importing buffers that are not own by the
> process' cgroup or the ancestors of the process' cgroup.
>
> For this resource, the control files are prefixed with drm.buffer.total.
>
> There are four control file types,
> stats (ro) - display current measured values for a resource
> max (rw) - limits for a resource
> default (ro, root cgroup only) - default values for a resource
> help (ro, root cgroup only) - help string for a resource
>
> Each file is multi-lined with one entry/line per drm device.
>
> Usage examples:
> // set limit for card1 to 1GB
> sed -i '2s/.*/1073741824/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
>
> // set limit for card0 to 512MB
> sed -i '1s/.*/536870912/' /sys/fs/cgroup/<cgroup>/drm.buffer.total.max
>
> Change-Id: I4c249d06d45ec709d6481d4cbe87c5168545c5d0
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |   4 +
>   drivers/gpu/drm/drm_gem.c                  |   7 +
>   drivers/gpu/drm/drm_prime.c                |   9 +
>   include/drm/drm_cgroup.h                   |  34 ++-
>   include/drm/drm_gem.h                      |  11 +
>   include/linux/cgroup_drm.h                 |   3 +
>   kernel/cgroup/drm.c                        | 280 +++++++++++++++++++++
>   7 files changed, 346 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 93b2c5a48a71..b4c078b7ad63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -34,6 +34,7 @@
>   #include <drm/drmP.h>
>   #include <drm/amdgpu_drm.h>
>   #include <drm/drm_cache.h>
> +#include <drm/drm_cgroup.h>
>   #include "amdgpu.h"
>   #include "amdgpu_trace.h"
>   #include "amdgpu_amdkfd.h"
> @@ -446,6 +447,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
>   	if (!amdgpu_bo_validate_size(adev, size, bp->domain))
>   		return -ENOMEM;
>   
> +	if (!drmcgrp_bo_can_allocate(current, adev->ddev, size))
> +		return -ENOMEM;
> +
>   	*bo_ptr = NULL;
>   
>   	acc_size = ttm_bo_dma_acc_size(&adev->mman.bdev, size,
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 6a80db077dc6..cbd49bf34dcf 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -37,10 +37,12 @@
>   #include <linux/shmem_fs.h>
>   #include <linux/dma-buf.h>
>   #include <linux/mem_encrypt.h>
> +#include <linux/cgroup_drm.h>
>   #include <drm/drmP.h>
>   #include <drm/drm_vma_manager.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drm_print.h>
> +#include <drm/drm_cgroup.h>
>   #include "drm_internal.h"
>   
>   /** @file drm_gem.c
> @@ -154,6 +156,9 @@ void drm_gem_private_object_init(struct drm_device *dev,
>   	obj->handle_count = 0;
>   	obj->size = size;
>   	drm_vma_node_reset(&obj->vma_node);
> +
> +	obj->drmcgrp = get_drmcgrp(current);
> +	drmcgrp_chg_bo_alloc(obj->drmcgrp, dev, size);
>   }
>   EXPORT_SYMBOL(drm_gem_private_object_init);
>   
> @@ -804,6 +809,8 @@ drm_gem_object_release(struct drm_gem_object *obj)
>   	if (obj->filp)
>   		fput(obj->filp);
>   
> +	drmcgrp_unchg_bo_alloc(obj->drmcgrp, obj->dev, obj->size);
> +
>   	drm_gem_free_mmap_offset(obj);
>   }
>   EXPORT_SYMBOL(drm_gem_object_release);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 231e3f6d5f41..faed5611a1c6 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -32,6 +32,7 @@
>   #include <drm/drm_prime.h>
>   #include <drm/drm_gem.h>
>   #include <drm/drmP.h>
> +#include <drm/drm_cgroup.h>
>   
>   #include "drm_internal.h"
>   
> @@ -794,6 +795,7 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>   {
>   	struct dma_buf *dma_buf;
>   	struct drm_gem_object *obj;
> +	struct drmcgrp *drmcgrp = get_drmcgrp(current);
>   	int ret;
>   
>   	dma_buf = dma_buf_get(prime_fd);
> @@ -818,6 +820,13 @@ int drm_gem_prime_fd_to_handle(struct drm_device *dev,
>   		goto out_unlock;
>   	}
>   
> +	/* only allow bo from the same cgroup or its ancestor to be imported */
> +	if (drmcgrp != NULL &&
> +			!drmcgrp_is_self_or_ancestor(drmcgrp, obj->drmcgrp)) {
> +		ret = -EACCES;
> +		goto out_unlock;
> +	}
> +

This will most likely go up in flames.

If I'm not completely mistaken we already use 
drm_gem_prime_fd_to_handle() to exchange handles between different 
cgroups in current container usages.

Christian.

>   	if (obj->dma_buf) {
>   		WARN_ON(obj->dma_buf != dma_buf);
>   	} else {
> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> index ddb9eab64360..8711b7c5f7bf 100644
> --- a/include/drm/drm_cgroup.h
> +++ b/include/drm/drm_cgroup.h
> @@ -4,12 +4,20 @@
>   #ifndef __DRM_CGROUP_H__
>   #define __DRM_CGROUP_H__
>   
> +#include <linux/cgroup_drm.h>
> +
>   #ifdef CONFIG_CGROUP_DRM
>   
>   int drmcgrp_register_device(struct drm_device *device);
> -
>   int drmcgrp_unregister_device(struct drm_device *device);
> -
> +bool drmcgrp_is_self_or_ancestor(struct drmcgrp *self,
> +		struct drmcgrp *relative);
> +void drmcgrp_chg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> +		size_t size);
> +void drmcgrp_unchg_bo_alloc(struct drmcgrp *drmcgrp, struct drm_device *dev,
> +		size_t size);
> +bool drmcgrp_bo_can_allocate(struct task_struct *task, struct drm_device *dev,
> +		size_t size);
>   #else
>   static inline int drmcgrp_register_device(struct drm_device *device)
>   {
> @@ -20,5 +28,27 @@ static inline int drmcgrp_unregister_device(struct drm_device *device)
>   {
>   	return 0;
>   }
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
>   #endif /* CONFIG_CGROUP_DRM */
>   #endif /* __DRM_CGROUP_H__ */
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index c95727425284..02854c674b5c 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -272,6 +272,17 @@ struct drm_gem_object {
>   	 *
>   	 */
>   	const struct drm_gem_object_funcs *funcs;
> +
> +	/**
> +	 * @drmcgrp:
> +	 *
> +	 * DRM cgroup this GEM object belongs to.
> +         *
> +         * This is used to track and limit the amount of GEM objects a user
> +         * can allocate.  Since GEM objects can be shared, this is also used
> +         * to ensure GEM objects are only shared within the same cgroup.
> +	 */
> +	struct drmcgrp *drmcgrp;
>   };
>   
>   /**
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> index d7ccf434ca6b..fe14ba7bb1cf 100644
> --- a/include/linux/cgroup_drm.h
> +++ b/include/linux/cgroup_drm.h
> @@ -15,6 +15,9 @@
>   
>   struct drmcgrp_device_resource {
>   	/* for per device stats */
> +	s64			bo_stats_total_allocated;
> +
> +	s64			bo_limits_total_allocated;
>   };
>   
>   struct drmcgrp {
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index f9ef4bf042d8..bc3abff09113 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -15,6 +15,22 @@ static DEFINE_MUTEX(drmcgrp_mutex);
>   struct drmcgrp_device {
>   	struct drm_device	*dev;
>   	struct mutex		mutex;
> +
> +	s64			bo_limits_total_allocated_default;
> +};
> +
> +#define DRMCG_CTF_PRIV_SIZE 3
> +#define DRMCG_CTF_PRIV_MASK GENMASK((DRMCG_CTF_PRIV_SIZE - 1), 0)
> +
> +enum drmcgrp_res_type {
> +	DRMCGRP_TYPE_BO_TOTAL,
> +};
> +
> +enum drmcgrp_file_type {
> +	DRMCGRP_FTYPE_STATS,
> +	DRMCGRP_FTYPE_MAX,
> +	DRMCGRP_FTYPE_DEFAULT,
> +	DRMCGRP_FTYPE_HELP,
>   };
>   
>   /* indexed by drm_minor for access speed */
> @@ -53,6 +69,10 @@ static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int i)
>   	}
>   
>   	/* set defaults here */
> +	if (known_drmcgrp_devs[i] != NULL) {
> +		ddr->bo_limits_total_allocated =
> +		  known_drmcgrp_devs[i]->bo_limits_total_allocated_default;
> +	}
>   
>   	return 0;
>   }
> @@ -99,7 +119,187 @@ drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
>   	return &drmcgrp->css;
>   }
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
> +		seq_printf(sf, "%lld\n", ddev->bo_limits_total_allocated_default);
> +		break;
> +	default:
> +		seq_puts(sf, "\n");
> +		break;
> +	}
> +}
> +
> +static inline void drmcgrp_print_help(int cardNum, struct seq_file *sf,
> +		enum drmcgrp_res_type type)
> +{
> +	switch (type) {
> +	case DRMCGRP_TYPE_BO_TOTAL:
> +		seq_printf(sf,
> +		"Total amount of buffer allocation in bytes for card%d\n",
> +		cardNum);
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
> +	enum drmcgrp_file_type f_type = seq_cft(sf)->
> +		private & DRMCG_CTF_PRIV_MASK;
> +	enum drmcgrp_res_type type = seq_cft(sf)->
> +		private >> DRMCG_CTF_PRIV_SIZE;
> +	struct drmcgrp_device *ddev;
> +	int i;
> +
> +	for (i = 0; i <= max_minor; i++) {
> +		ddr = drmcgrp->dev_resources[i];
> +		ddev = known_drmcgrp_devs[i];
> +
> +		switch (f_type) {
> +		case DRMCGRP_FTYPE_STATS:
> +			drmcgrp_print_stats(ddr, sf, type);
> +			break;
> +		case DRMCGRP_FTYPE_MAX:
> +			drmcgrp_print_limits(ddr, sf, type);
> +			break;
> +		case DRMCGRP_FTYPE_DEFAULT:
> +			drmcgrp_print_default(ddev, sf, type);
> +			break;
> +		case DRMCGRP_FTYPE_HELP:
> +			drmcgrp_print_help(i, sf, type);
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
> +ssize_t drmcgrp_bo_limit_write(struct kernfs_open_file *of, char *buf,
> +		size_t nbytes, loff_t off)
> +{
> +	struct drmcgrp *drmcgrp = css_drmcgrp(of_css(of));
> +	enum drmcgrp_res_type type = of_cft(of)->private >> DRMCG_CTF_PRIV_SIZE;
> +	char *cft_name = of_cft(of)->name;
> +	char *limits = strstrip(buf);
> +	struct drmcgrp_device_resource *ddr;
> +	char *sval;
> +	s64 val;
> +	int i = 0;
> +	int rc;
> +
> +	while (i <= max_minor && limits != NULL) {
> +		sval =  strsep(&limits, "\n");
> +		rc = kstrtoll(sval, 0, &val);
> +
> +		if (rc) {
> +			pr_err("drmcgrp: %s: minor %d, err %d. ",
> +				cft_name, i, rc);
> +			pr_cont_cgroup_name(drmcgrp->css.cgroup);
> +			pr_cont("\n");
> +		} else {
> +			ddr = drmcgrp->dev_resources[i];
> +			switch (type) {
> +			case DRMCGRP_TYPE_BO_TOTAL:
> +                                if (val < 0) continue;
> +				ddr->bo_limits_total_allocated = val;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +
> +		i++;
> +	}
> +
> +	if (i <= max_minor) {
> +		pr_err("drmcgrp: %s: less entries than # of drm devices. ",
> +				cft_name);
> +		pr_cont_cgroup_name(drmcgrp->css.cgroup);
> +		pr_cont("\n");
> +	}
> +
> +	return nbytes;
> +}
> +
>   struct cftype files[] = {
> +	{
> +		.name = "buffer.total.stats",
> +		.seq_show = drmcgrp_bo_show,
> +		.private = (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_STATS,
> +	},
> +	{
> +		.name = "buffer.total.default",
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_DEFAULT,
> +	},
> +	{
> +		.name = "buffer.total.help",
> +		.seq_show = drmcgrp_bo_show,
> +		.flags = CFTYPE_ONLY_ON_ROOT,
> +		.private = (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_HELP,
> +	},
> +	{
> +		.name = "buffer.total.max",
> +		.write = drmcgrp_bo_limit_write,
> +		.seq_show = drmcgrp_bo_show,
> +		.private = (DRMCGRP_TYPE_BO_TOTAL << DRMCG_CTF_PRIV_SIZE) |
> +			DRMCGRP_FTYPE_MAX,
> +	},
>   	{ }	/* terminate */
>   };
>   
> @@ -122,6 +322,8 @@ int drmcgrp_register_device(struct drm_device *dev)
>   		return -ENOMEM;
>   
>   	ddev->dev = dev;
> +	ddev->bo_limits_total_allocated_default = S64_MAX;
> +
>   	mutex_init(&ddev->mutex);
>   
>   	mutex_lock(&drmcgrp_mutex);
> @@ -156,3 +358,81 @@ int drmcgrp_unregister_device(struct drm_device *dev)
>   	return 0;
>   }
>   EXPORT_SYMBOL(drmcgrp_unregister_device);
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
> +	struct drmcgrp *drmcgrp = get_drmcgrp(task);
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
> +	struct drmcgrp_device_resource *ddr;
> +	int devIdx = dev->primary->index;
> +
> +	if (drmcgrp == NULL || known_drmcgrp_devs[devIdx] == NULL)
> +		return;
> +
> +	ddr = drmcgrp->dev_resources[devIdx];
> +	mutex_lock(&known_drmcgrp_devs[devIdx]->mutex);
> +	for ( ; drmcgrp != NULL; drmcgrp = parent_drmcgrp(drmcgrp))
> +		drmcgrp->dev_resources[devIdx]->bo_stats_total_allocated
> +			-= (s64)size;
> +	mutex_unlock(&known_drmcgrp_devs[devIdx]->mutex);
> +}
> +EXPORT_SYMBOL(drmcgrp_unchg_bo_alloc);

