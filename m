Return-Path: <cgroups+bounces-5193-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B59AC20E
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 10:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12FF2849C7
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76848158845;
	Wed, 23 Oct 2024 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YN64kBkJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0AC16A930;
	Wed, 23 Oct 2024 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673125; cv=none; b=so7S51UeXXYTmO45Tj/f6R4JgBM5JRV9VgnksFTb7MEe05w5NJj34sE0lF+t2U3GWYgmgrEbxP/k+F14ZV8eApxZf96u0klYVMgY8B7x9uSeFMV5uqKV0jkjzldkhChtfwNgMSw38vSLKDYaFA30jCoKnLRXYAddARWFhSHv99E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673125; c=relaxed/simple;
	bh=A5ndovx0/E0It2utNkxkAGR1H8VRnlib7bnSfF4/6Vk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fm3FpkGW0scZQD5UkaHYw5C8UoP8aGLxqYv9SV4Rq6XzDhqVi+nNT5MLXPQslsX+E3N5qb8XPIfJmRhYFDq/IsLfZGchwhEE4BWoE0dpixwd4RMsMn5SwX7IeYgMCVQkyQ7YM5KXGZfJOlaK21cUHCrWHp5DutHd5kdptrxOwgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YN64kBkJ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729673123; x=1761209123;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=A5ndovx0/E0It2utNkxkAGR1H8VRnlib7bnSfF4/6Vk=;
  b=YN64kBkJCbq6dQBuOLEbo/Bndydiy9ojo8wOP/RCN122yiFFyv8Gpgba
   AXyfgpQskkHH8+LI+7SjaEgYbj8yvJ2dLu0IN5i4BpKKi+ECX3SsMn/Ba
   lNwW9HLO9NJKVg5/YeUfHPrxKK8SZjfa1hkMLn9XNRnx7yMKKcQxkni53
   Fh8IBpeqfbnAH3EJFAaFeeOex0GgQicppVKAlKshmAM8qlbqOhWGEcPJL
   dQPcJGrXYIHr26PNkquAi8zppMzc+16xIophGyeNBYvfjdkxGhQ9c5jYO
   WMxm0wKBB1sELvzQvNsqn8rxBo1EvaecXSmjHtxRIPLtK4X1qpsw3l2GR
   A==;
X-CSE-ConnectionGUID: pAywiv9mQLydljyEvoTyOg==
X-CSE-MsgGUID: ZV1adXRPRjuzW1SKbpR5hg==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29472830"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="29472830"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:45:22 -0700
X-CSE-ConnectionGUID: ax+KPFUmQt+be2JCEmOxDA==
X-CSE-MsgGUID: Ot6elf/iQsK9c2xwI0Y3/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="84759588"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.84])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:45:18 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew
 Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 2/7] drm/drv: Add drmm cgroup registration for dev cgroups.
In-Reply-To: <20241023075302.27194-3-maarten.lankhorst@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <20241023075302.27194-3-maarten.lankhorst@linux.intel.com>
Date: Wed, 23 Oct 2024 11:45:15 +0300
Message-ID: <878qufus10.fsf@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 23 Oct 2024, Maarten Lankhorst <maarten.lankhorst@linux.intel.com> wrote:
> From: Maxime Ripard <mripard@kernel.org>
>
> Drivers will need to register a cgroup device at probe time, so let's
> give them a drm-managed helper.
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 21 +++++++++++++++++++++
>  include/drm/drm_drv.h     |  4 ++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index c2c172eb25df7..251d1d69b09c5 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -26,6 +26,7 @@
>   * DEALINGS IN THE SOFTWARE.
>   */
>  
> +#include <linux/cgroup_dev.h>
>  #include <linux/debugfs.h>
>  #include <linux/fs.h>
>  #include <linux/module.h>
> @@ -820,6 +821,26 @@ void drm_dev_put(struct drm_device *dev)
>  }
>  EXPORT_SYMBOL(drm_dev_put);
>  
> +static inline void drmm_cg_unregister_device(struct drm_device *dev, void *arg)

Nitpick, inline in .c files is mostly useless, just use static and let
the compiler do its job.

BR,
Jani.

> +{
> +	dev_cgroup_unregister_device(arg);
> +}
> +
> +int drmm_cgroup_register_device(struct drm_device *dev,
> +				struct dev_cgroup_device *cgdev)
> +{
> +	int ret;
> +	char dev_name[32];
> +
> +	snprintf(dev_name, sizeof(dev_name), "drm/%s", dev->unique);
> +	ret = dev_cgroup_register_device(cgdev, dev_name);
> +	if (ret)
> +		return ret;
> +
> +	return drmm_add_action_or_reset(dev, drmm_cg_unregister_device, cgdev);
> +}
> +EXPORT_SYMBOL_GPL(drmm_cgroup_register_device);
> +
>  static int create_compat_control_link(struct drm_device *dev)
>  {
>  	struct drm_minor *minor;
> diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
> index 1bbbcb8e2d231..3e83c7ce7f2d0 100644
> --- a/include/drm/drm_drv.h
> +++ b/include/drm/drm_drv.h
> @@ -34,6 +34,7 @@
>  
>  #include <drm/drm_device.h>
>  
> +struct dev_cgroup_device;
>  struct drm_fb_helper;
>  struct drm_fb_helper_surface_size;
>  struct drm_file;
> @@ -438,6 +439,9 @@ void *__devm_drm_dev_alloc(struct device *parent,
>  			   const struct drm_driver *driver,
>  			   size_t size, size_t offset);
>  
> +int drmm_cgroup_register_device(struct drm_device *dev,
> +				struct dev_cgroup_device *cgdev);
> +
>  /**
>   * devm_drm_dev_alloc - Resource managed allocation of a &drm_device instance
>   * @parent: Parent device object

-- 
Jani Nikula, Intel

