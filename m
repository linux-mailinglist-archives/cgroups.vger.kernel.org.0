Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD29156E1C
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZP4L (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:56:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44943 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZP4L (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 11:56:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so3989379edr.11
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b8N0XuHLMqrJQXmLm+2uSL4Ak/YQzhUfppEvcpxNhdU=;
        b=N7ULXVSeuODxCVqizNpydWEDzjxIgR+bf2Gz5O2lwAQCWTmMUcdKhVnghCAIua43V/
         qIuHcSxiSBaJQop5snrzrT1vj6L9KTfwLQFamSsk9zblhONsYs1kPGWFcQcsAG0wk46C
         b25QJr8CvO1ih8AlI7876pz2KuENh1VppYoos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b8N0XuHLMqrJQXmLm+2uSL4Ak/YQzhUfppEvcpxNhdU=;
        b=UO633wt7OmjtNNSEy2WuPzXSV5Y7OYq1ml3/PLI3p7AZmmUfc7zaMB/XPEV+mdxnmP
         bOnOKk6p3ejPzpZNCJJAHc6rIGtOKt3ZScfSVieE42Lt04gCpzj8kjiH6VNDptGy2Sii
         KGCfOD3pPumRqpy2pfo9IM/5019VL8l3fJSxG5kFeMwGiwsr/3uGzUwu7iAtO9tirF6a
         ejLW00hxtRgxaO2v848U4n0UUppExdzPg7cr7jEXbCOUuObagIc8gNvct4mm+T5EgWhZ
         J5TaNV4JOuV5e0xHBYE470a/pQCPMHrExngO2mDCb86bU34XbzvLbks7igYN9qO7nImm
         BC+Q==
X-Gm-Message-State: APjAAAVFbA4YNzJDD2AMV9t1k2lmOl8i2n5+RdjxzHYEIXW42UaexT9h
        C8SuEnJ1vhq9jS7XUvvnt4bqrlT28Cw=
X-Google-Smtp-Source: APXvYqxj5iQ8cgJzXif/pPyy4Sja3143s1j9ggVAk9qGMS7fXVtVMugZW1UWF3d14w6P7GQnc9gk+A==
X-Received: by 2002:a05:6402:397:: with SMTP id o23mr6350378edv.68.1561564568630;
        Wed, 26 Jun 2019 08:56:08 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id n5sm3050587ejc.62.2019.06.26.08.56.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:56:07 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:56:05 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 02/11] cgroup: Add mechanism to register DRM
 devices
Message-ID: <20190626155605.GQ12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-3-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626150522.11618-3-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:05:13AM -0400, Kenny Ho wrote:
> Change-Id: I908ee6975ea0585e4c30eafde4599f87094d8c65
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>

Why the separate, explicit registration step? I think a simpler design for
drivers would be that we set up cgroups if there's anything to be
controlled, and then for GEM drivers the basic GEM stuff would be set up
automically (there's really no reason not to I think).

Also tying to the minor is a bit funky, since we have multiple of these.
Need to make sure were at least consistent with whether we use the primary
or render minor - I'd always go with the primary one like you do here.

> ---
>  include/drm/drm_cgroup.h   |  24 ++++++++
>  include/linux/cgroup_drm.h |  10 ++++
>  kernel/cgroup/drm.c        | 116 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 include/drm/drm_cgroup.h
> 
> diff --git a/include/drm/drm_cgroup.h b/include/drm/drm_cgroup.h
> new file mode 100644
> index 000000000000..ddb9eab64360
> --- /dev/null
> +++ b/include/drm/drm_cgroup.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: MIT
> + * Copyright 2019 Advanced Micro Devices, Inc.
> + */
> +#ifndef __DRM_CGROUP_H__
> +#define __DRM_CGROUP_H__
> +
> +#ifdef CONFIG_CGROUP_DRM
> +
> +int drmcgrp_register_device(struct drm_device *device);
> +
> +int drmcgrp_unregister_device(struct drm_device *device);
> +
> +#else
> +static inline int drmcgrp_register_device(struct drm_device *device)
> +{
> +	return 0;
> +}
> +
> +static inline int drmcgrp_unregister_device(struct drm_device *device)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_CGROUP_DRM */
> +#endif /* __DRM_CGROUP_H__ */
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> index 9928e60037a5..27497f786c93 100644
> --- a/include/linux/cgroup_drm.h
> +++ b/include/linux/cgroup_drm.h
> @@ -6,10 +6,20 @@
>  
>  #ifdef CONFIG_CGROUP_DRM
>  
> +#include <linux/mutex.h>
>  #include <linux/cgroup.h>
> +#include <drm/drm_file.h>
> +
> +/* limit defined per the way drm_minor_alloc operates */
> +#define MAX_DRM_DEV (64 * DRM_MINOR_RENDER)
> +
> +struct drmcgrp_device_resource {
> +	/* for per device stats */
> +};
>  
>  struct drmcgrp {
>  	struct cgroup_subsys_state	css;
> +	struct drmcgrp_device_resource	*dev_resources[MAX_DRM_DEV];
>  };
>  
>  static inline struct drmcgrp *css_drmcgrp(struct cgroup_subsys_state *css)
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> index 66cb1dda023d..7da6e0d93991 100644
> --- a/kernel/cgroup/drm.c
> +++ b/kernel/cgroup/drm.c
> @@ -1,28 +1,99 @@
>  // SPDX-License-Identifier: MIT
>  // Copyright 2019 Advanced Micro Devices, Inc.
> +#include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/cgroup.h>
> +#include <linux/fs.h>
> +#include <linux/seq_file.h>
> +#include <linux/mutex.h>
>  #include <linux/cgroup_drm.h>
> +#include <linux/kernel.h>
> +#include <drm/drm_device.h>
> +#include <drm/drm_cgroup.h>
> +
> +static DEFINE_MUTEX(drmcgrp_mutex);
> +
> +struct drmcgrp_device {
> +	struct drm_device	*dev;
> +	struct mutex		mutex;
> +};
> +
> +/* indexed by drm_minor for access speed */
> +static struct drmcgrp_device	*known_drmcgrp_devs[MAX_DRM_DEV];
> +
> +static int max_minor;

Uh no global stuff like this please. Or some explanation in the commit
message why we really cant avoid this.

> +
>  
>  static struct drmcgrp *root_drmcgrp __read_mostly;
>  
>  static void drmcgrp_css_free(struct cgroup_subsys_state *css)
>  {
>  	struct drmcgrp *drmcgrp = css_drmcgrp(css);
> +	int i;
> +
> +	for (i = 0; i <= max_minor; i++) {
> +		if (drmcgrp->dev_resources[i] != NULL)
> +			kfree(drmcgrp->dev_resources[i]);
> +	}
>  
>  	kfree(drmcgrp);
>  }
>  
> +static inline int init_drmcgrp_single(struct drmcgrp *drmcgrp, int minor)
> +{
> +	struct drmcgrp_device_resource *ddr = drmcgrp->dev_resources[minor];
> +
> +	if (ddr == NULL) {
> +		ddr = kzalloc(sizeof(struct drmcgrp_device_resource),
> +			GFP_KERNEL);
> +
> +		if (!ddr)
> +			return -ENOMEM;
> +
> +		drmcgrp->dev_resources[minor] = ddr;
> +	}
> +
> +	/* set defaults here */
> +
> +	return 0;
> +}
> +
> +static inline int init_drmcgrp(struct drmcgrp *drmcgrp, struct drm_device *dev)
> +{
> +	int rc = 0;
> +	int i;
> +
> +	if (dev != NULL) {
> +		rc = init_drmcgrp_single(drmcgrp, dev->primary->index);
> +		return rc;
> +	}
> +
> +	for (i = 0; i <= max_minor; i++) {
> +		rc = init_drmcgrp_single(drmcgrp, i);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
>  static struct cgroup_subsys_state *
>  drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
>  {
>  	struct drmcgrp *parent = css_drmcgrp(parent_css);
>  	struct drmcgrp *drmcgrp;
> +	int rc;
>  
>  	drmcgrp = kzalloc(sizeof(struct drmcgrp), GFP_KERNEL);
>  	if (!drmcgrp)
>  		return ERR_PTR(-ENOMEM);
>  
> +	rc = init_drmcgrp(drmcgrp, NULL);
> +	if (rc) {
> +		drmcgrp_css_free(&drmcgrp->css);
> +		return ERR_PTR(rc);
> +	}
> +
>  	if (!parent)
>  		root_drmcgrp = drmcgrp;
>  
> @@ -40,3 +111,48 @@ struct cgroup_subsys drm_cgrp_subsys = {
>  	.legacy_cftypes	= files,
>  	.dfl_cftypes	= files,
>  };
> +
> +int drmcgrp_register_device(struct drm_device *dev)

Imo this should be done as part of drm_dev_register (maybe only if the
driver has set up a controller or something). Definitely with the
unregister logic below. Also anything used by drivers needs kerneldoc.


> +{
> +	struct drmcgrp_device *ddev;
> +
> +	ddev = kzalloc(sizeof(struct drmcgrp_device), GFP_KERNEL);
> +	if (!ddev)
> +		return -ENOMEM;
> +
> +	ddev->dev = dev;
> +	mutex_init(&ddev->mutex);
> +
> +	mutex_lock(&drmcgrp_mutex);
> +	known_drmcgrp_devs[dev->primary->index] = ddev;
> +	max_minor = max(max_minor, dev->primary->index);
> +	mutex_unlock(&drmcgrp_mutex);
> +
> +	/* init cgroups created before registration (i.e. root cgroup) */
> +	if (root_drmcgrp != NULL) {
> +		struct cgroup_subsys_state *pos;
> +		struct drmcgrp *child;
> +
> +		rcu_read_lock();
> +		css_for_each_descendant_pre(pos, &root_drmcgrp->css) {
> +			child = css_drmcgrp(pos);
> +			init_drmcgrp(child, dev);
> +		}
> +		rcu_read_unlock();

I have no idea, but is this guaranteed to get them all?
-Daniel

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drmcgrp_register_device);
> +
> +int drmcgrp_unregister_device(struct drm_device *dev)
> +{
> +	mutex_lock(&drmcgrp_mutex);
> +
> +	kfree(known_drmcgrp_devs[dev->primary->index]);
> +	known_drmcgrp_devs[dev->primary->index] = NULL;
> +
> +	mutex_unlock(&drmcgrp_mutex);
> +	return 0;
> +}
> +EXPORT_SYMBOL(drmcgrp_unregister_device);
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
