Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75EA556E0B
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2019 17:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZPte (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Jun 2019 11:49:34 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46972 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZPte (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 26 Jun 2019 11:49:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so3956430edr.13
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2019 08:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Es6EeAoseHYZOX9Z+FPHHYaVmxeOxFwx/XOxr6xH0RQ=;
        b=Ii3UhXUUfacip4L9yCh1pax20++rbhqzgKL+K3IL81wxwvMS7vBaFHjo+psnoV0ozM
         YeRQyEULvuQwglRDU/CMkZZWyvIoNF6hgv2ve9pUobtZlMLNljnQYg6/vAvkhddua7Le
         OFxxsR+Rw0uRItAc7vRkTail6fvhceTxuewzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Es6EeAoseHYZOX9Z+FPHHYaVmxeOxFwx/XOxr6xH0RQ=;
        b=bUESqBgUC3SMh/56PxJbWuXC5WoFAvgWV04wyipBjYtS/tAl+zgv7TzLr7JPx5D767
         xxDFffyTLz/N6JVm+Vf4Q02J3IZNb7o8NiL9jgbnkTmBJFzlnWU0zJ5kztItK3YQ8+I9
         Ib1vBvvocedSmIGPiLu30o0hyaGOXA8eRHMEpQEyb+LEwfHt1VVRX2nbYxHtO8w/lhhf
         JEembAFFEdlgHz/6oq1uXcRH6p6RIcl2q6T0SSMyKi3uie9Z4p61GE9+BrbKFnk/R7fc
         EVOiR4EgqUG+T8OKbnE0+3eOB+7OZn2MmGpX9BtBTqhGm7xI0bQLwVu/v07Vu/25C0PA
         Mcaw==
X-Gm-Message-State: APjAAAWx+SyDo2A1RYlV5vUgIXjmTywNkdx++ajsPJAR+SA9kbr5lQM9
        gX/fD/uYCCHg2EaLmb8Nb90S0A==
X-Google-Smtp-Source: APXvYqxPeH0sMk9gk1iWWvIZw38Pr++ewNa+PhvQ8RbjjmdLGanrzILoOJxpdVxzSyAEAGi33vsASQ==
X-Received: by 2002:a17:906:4bcb:: with SMTP id x11mr4880010ejv.1.1561564172520;
        Wed, 26 Jun 2019 08:49:32 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id e43sm5989586ede.62.2019.06.26.08.49.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 08:49:31 -0700 (PDT)
Date:   Wed, 26 Jun 2019 17:49:29 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kenny Ho <Kenny.Ho@amd.com>
Cc:     y2kenny@gmail.com, cgroups@vger.kernel.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        tj@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com,
        joseph.greathouse@amd.com, jsparks@cray.com, lkaplan@cray.com
Subject: Re: [RFC PATCH v3 01/11] cgroup: Introduce cgroup for drm subsystem
Message-ID: <20190626154929.GP12905@phenom.ffwll.local>
References: <20190626150522.11618-1-Kenny.Ho@amd.com>
 <20190626150522.11618-2-Kenny.Ho@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626150522.11618-2-Kenny.Ho@amd.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Jun 26, 2019 at 11:05:12AM -0400, Kenny Ho wrote:
Needs a bit more commit message here I htink.

> Change-Id: I6830d3990f63f0c13abeba29b1d330cf28882831
> Signed-off-by: Kenny Ho <Kenny.Ho@amd.com>

Bunch of naming bikesheds
> ---
>  include/linux/cgroup_drm.h    | 76 +++++++++++++++++++++++++++++++++++
>  include/linux/cgroup_subsys.h |  4 ++
>  init/Kconfig                  |  5 +++
>  kernel/cgroup/Makefile        |  1 +
>  kernel/cgroup/drm.c           | 42 +++++++++++++++++++
>  5 files changed, 128 insertions(+)
>  create mode 100644 include/linux/cgroup_drm.h
>  create mode 100644 kernel/cgroup/drm.c

> 
> diff --git a/include/linux/cgroup_drm.h b/include/linux/cgroup_drm.h
> new file mode 100644
> index 000000000000..9928e60037a5
> --- /dev/null
> +++ b/include/linux/cgroup_drm.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: MIT
> + * Copyright 2019 Advanced Micro Devices, Inc.
> + */
> +#ifndef _CGROUP_DRM_H
> +#define _CGROUP_DRM_H
> +
> +#ifdef CONFIG_CGROUP_DRM
> +
> +#include <linux/cgroup.h>
> +
> +struct drmcgrp {

drm_cgroup for more consistency how we usually call these things.

> +	struct cgroup_subsys_state	css;
> +};
> +
> +static inline struct drmcgrp *css_drmcgrp(struct cgroup_subsys_state *css)

ccs_to_drm_cgroup

> +{
> +	return css ? container_of(css, struct drmcgrp, css) : NULL;
> +}
> +
> +static inline struct drmcgrp *drmcgrp_from(struct task_struct *task)

task_get_drm_cgroup for consistency with task_get_css?

> +{
> +	return css_drmcgrp(task_get_css(task, drm_cgrp_id));
> +}
> +
> +static inline struct drmcgrp *get_drmcgrp(struct task_struct *task)
> +{
> +	struct cgroup_subsys_state *css = task_get_css(task, drm_cgrp_id);
> +
> +	if (css)
> +		css_get(css);
> +
> +	return css_drmcgrp(css);
> +}
> +
> +static inline void put_drmcgrp(struct drmcgrp *drmcgrp)

In drm we generally put _get/_put at the end, cgroup seems to do the same.

> +{
> +	if (drmcgrp)
> +		css_put(&drmcgrp->css);
> +}
> +
> +static inline struct drmcgrp *parent_drmcgrp(struct drmcgrp *cg)

I'd also call this drm_cgroup_parent or so.

Also all the above needs a bit of nice kerneldoc for the final version.
-Daniel

> +{
> +	return css_drmcgrp(cg->css.parent);
> +}
> +
> +#else /* CONFIG_CGROUP_DRM */
> +
> +struct drmcgrp {
> +};
> +
> +static inline struct drmcgrp *css_drmcgrp(struct cgroup_subsys_state *css)
> +{
> +	return NULL;
> +}
> +
> +static inline struct drmcgrp *drmcgrp_from(struct task_struct *task)
> +{
> +	return NULL;
> +}
> +
> +static inline struct drmcgrp *get_drmcgrp(struct task_struct *task)
> +{
> +	return NULL;
> +}
> +
> +static inline void put_drmcgrp(struct drmcgrp *drmcgrp)
> +{
> +}
> +
> +static inline struct drmcgrp *parent_drmcgrp(struct drmcgrp *cg)
> +{
> +	return NULL;
> +}
> +
> +#endif	/* CONFIG_CGROUP_DRM */
> +#endif	/* _CGROUP_DRM_H */
> diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
> index acb77dcff3b4..ddedad809e8b 100644
> --- a/include/linux/cgroup_subsys.h
> +++ b/include/linux/cgroup_subsys.h
> @@ -61,6 +61,10 @@ SUBSYS(pids)
>  SUBSYS(rdma)
>  #endif
>  
> +#if IS_ENABLED(CONFIG_CGROUP_DRM)
> +SUBSYS(drm)
> +#endif
> +
>  /*
>   * The following subsystems are not supported on the default hierarchy.
>   */
> diff --git a/init/Kconfig b/init/Kconfig
> index d47cb77a220e..0b0f112eb23b 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -839,6 +839,11 @@ config CGROUP_RDMA
>  	  Attaching processes with active RDMA resources to the cgroup
>  	  hierarchy is allowed even if can cross the hierarchy's limit.
>  
> +config CGROUP_DRM
> +	bool "DRM controller (EXPERIMENTAL)"
> +	help
> +	  Provides accounting and enforcement of resources in the DRM subsystem.
> +
>  config CGROUP_FREEZER
>  	bool "Freezer controller"
>  	help
> diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
> index bfcdae896122..6af14bd93050 100644
> --- a/kernel/cgroup/Makefile
> +++ b/kernel/cgroup/Makefile
> @@ -4,5 +4,6 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o
>  obj-$(CONFIG_CGROUP_FREEZER) += freezer.o
>  obj-$(CONFIG_CGROUP_PIDS) += pids.o
>  obj-$(CONFIG_CGROUP_RDMA) += rdma.o
> +obj-$(CONFIG_CGROUP_DRM) += drm.o
>  obj-$(CONFIG_CPUSETS) += cpuset.o
>  obj-$(CONFIG_CGROUP_DEBUG) += debug.o
> diff --git a/kernel/cgroup/drm.c b/kernel/cgroup/drm.c
> new file mode 100644
> index 000000000000..66cb1dda023d
> --- /dev/null
> +++ b/kernel/cgroup/drm.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: MIT
> +// Copyright 2019 Advanced Micro Devices, Inc.
> +#include <linux/slab.h>
> +#include <linux/cgroup.h>
> +#include <linux/cgroup_drm.h>
> +
> +static struct drmcgrp *root_drmcgrp __read_mostly;
> +
> +static void drmcgrp_css_free(struct cgroup_subsys_state *css)
> +{
> +	struct drmcgrp *drmcgrp = css_drmcgrp(css);
> +
> +	kfree(drmcgrp);
> +}
> +
> +static struct cgroup_subsys_state *
> +drmcgrp_css_alloc(struct cgroup_subsys_state *parent_css)
> +{
> +	struct drmcgrp *parent = css_drmcgrp(parent_css);
> +	struct drmcgrp *drmcgrp;
> +
> +	drmcgrp = kzalloc(sizeof(struct drmcgrp), GFP_KERNEL);
> +	if (!drmcgrp)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!parent)
> +		root_drmcgrp = drmcgrp;
> +
> +	return &drmcgrp->css;
> +}
> +
> +struct cftype files[] = {
> +	{ }	/* terminate */
> +};
> +
> +struct cgroup_subsys drm_cgrp_subsys = {
> +	.css_alloc	= drmcgrp_css_alloc,
> +	.css_free	= drmcgrp_css_free,
> +	.early_init	= false,
> +	.legacy_cftypes	= files,
> +	.dfl_cftypes	= files,
> +};
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
