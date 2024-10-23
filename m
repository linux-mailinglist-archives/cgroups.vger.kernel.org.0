Return-Path: <cgroups+bounces-5194-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F05109AC238
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 10:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293031C23DD4
	for <lists+cgroups@lfdr.de>; Wed, 23 Oct 2024 08:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821E215E5C2;
	Wed, 23 Oct 2024 08:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPZU7jIP"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC59148FF3;
	Wed, 23 Oct 2024 08:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729673556; cv=none; b=fO8r4Wz+x59NY2aC9QRGfjdnmJlQlWw1BqNdrGcCBYQJKkpHgY0lkLJdbvjur4hkl7qYerZe4nRsOi+/D3pbse6OvYwNonAtgCsc+iew1ij2klX+uvhe0mrxqXxk6Sq3uvktgE+obf08QHuU/vzx/+CAw3T/wzvafs1GR+KtYoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729673556; c=relaxed/simple;
	bh=Q5ucK7d7uRJd+cvR1lR4/2r90nHVsOJOCPAxYH7QWpM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IvtqLe0t8aKspJouAsTKrJUnWfXe0VDFQCYu4I01y/2BoSxAOeNxkxVAvjbtlAB56ZMebCc7qj1R1yrsKdBQsJNfr6Gz1z91w0knVaIyezMS8QeeX1RoDZ85W+McYIwJADiEpoFyAIKFECEriyRVpInyhWP5etDO3xQJEBrUc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPZU7jIP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729673555; x=1761209555;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Q5ucK7d7uRJd+cvR1lR4/2r90nHVsOJOCPAxYH7QWpM=;
  b=CPZU7jIPlvZOyxXa9SHDDHms3Xs7ynSgrwi2/BjqWVqN3z+/OcWvvd6b
   V7knGh6vvUQfF6kLU9kHDhFhEL2mJKo6Dm8mi3LOSf1VUR4lUYKH+REKs
   VlUTE3ALyWfcFoU5LFdCO6tsYpJAe56M9+Sc1f50EVkek+k7yEPXLNgLm
   RUTu35olRWgF6/3v7PkoyeQbL1pUf5NlGvMrqpFsyqVx5fSPfwLmxQltL
   42Qg2JTrBxrJa5ylBYGY6iYrYdeiPzmeEk3gdBSWI1q1CiavP2sdqMmAy
   Fh8NWhL57NSqf1BESrNjsXA+i+7HhIywcLrLwvL/qjjcxEvqNiMPBxlqY
   A==;
X-CSE-ConnectionGUID: UZGhIBulRPac0n1QqOyCAA==
X-CSE-MsgGUID: +erpfj5wRiagXnf5DDfWHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51792573"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51792573"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:52:33 -0700
X-CSE-ConnectionGUID: h73qZ12oSHigC3GIMnT0gA==
X-CSE-MsgGUID: ZVHijG1OSPSJdXDXnmMvjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="80207426"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 01:52:29 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, Zefan Li
 <lizefan.x@bytedance.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew
 Morton <akpm@linux-foundation.org>
Cc: Friedrich Vock <friedrich.vock@gmx.de>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 6/7] [HACK] drm/xe: Hack to test with mapped pages
 instead of vram.
In-Reply-To: <20241023075302.27194-7-maarten.lankhorst@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20241023075302.27194-1-maarten.lankhorst@linux.intel.com>
 <20241023075302.27194-7-maarten.lankhorst@linux.intel.com>
Date: Wed, 23 Oct 2024 11:52:26 +0300
Message-ID: <875xpjurp1.fsf@intel.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 23 Oct 2024, Maarten Lankhorst <maarten.lankhorst@linux.intel.com> wrote:
> We will probably want to make this a proper region in TTM for
> everything, so that we can charge VRAM twice, once for mapped
> in sysmem, once for mapped in vram. That way we don't need to
> deal with evict failing from lack of available memory in mapped.
>
> Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/xe/xe_ttm_sys_mgr.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c b/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
> index 9844a8edbfe19..20fa8ec8925ef 100644
> --- a/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
> +++ b/drivers/gpu/drm/xe/xe_ttm_sys_mgr.c
> @@ -101,6 +101,18 @@ static void ttm_sys_mgr_fini(struct drm_device *drm, void *arg)
>  	ttm_set_driver_manager(&xe->ttm, XE_PL_TT, NULL);
>  }
>  
> +static inline void apply_cg(struct xe_device *xe,
> +			    struct ttm_resource_manager *man,
> +			    u64 gtt_size)

Ditto here about static inline in .c.

> +{
> +	int cgregion = xe->cg.num_regions++;
> +
> +	xe->cg.regions[cgregion].size = gtt_size;
> +	xe->cg.regions[cgregion].name = "mapped";
> +	man->cgdev = &xe->cg;
> +	man->cgidx = cgregion;
> +
> +}
>  int xe_ttm_sys_mgr_init(struct xe_device *xe)
>  {
>  	struct ttm_resource_manager *man = &xe->mem.sys_mgr;
> @@ -116,6 +128,8 @@ int xe_ttm_sys_mgr_init(struct xe_device *xe)
>  	man->func = &xe_ttm_sys_mgr_func;
>  	ttm_resource_manager_init(man, &xe->ttm, gtt_size >> PAGE_SHIFT);
>  	ttm_set_driver_manager(&xe->ttm, XE_PL_TT, man);
> +	apply_cg(xe, man, gtt_size);
> +
>  	ttm_resource_manager_set_used(man, true);
>  	return drmm_add_action_or_reset(&xe->drm, ttm_sys_mgr_fini, xe);
>  }

-- 
Jani Nikula, Intel

