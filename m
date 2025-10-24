Return-Path: <cgroups+bounces-11143-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DEF8C06397
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 14:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A55D1C04DBE
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 12:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253D315D31;
	Fri, 24 Oct 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="R8fGSHTH"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B798A28488D
	for <cgroups@vger.kernel.org>; Fri, 24 Oct 2025 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308515; cv=none; b=QCWPr9UgsNxp5f7x50bT9paZ2WbJKDAboiPHCY+40E4DlNI5vMcm0t6BlAgRy3pIyhM4/YAV9PWPLAitLZSiDtLUpfzz+xfa+dB3F9fy7Wk9p6AIb6N59OIZdKNFzUy81M9R7Hxv6N1SaxGhjY3SX1g/BMLkVTJwFYAMKmVw6WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308515; c=relaxed/simple;
	bh=bmy9Tj/bLBPRfIA4F0G8CfYnpaUPg4TaSrOWBi4bz4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XJVumsjWPSSgJZPLXyf3MASZBHoEbxLkbFXn0FHgD0TnYJJ8USDDA6Ui8vdAPAY84elwZwehaAldNb5JAA0tqq1FpinnAy7O72lvUie9gV00yEafWljTJOBh3LJCcMlq0if77OclfolxBmIDyuVXMeKWMvz8bDDbfWG54LavtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=R8fGSHTH; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1761308512;
	bh=bmy9Tj/bLBPRfIA4F0G8CfYnpaUPg4TaSrOWBi4bz4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R8fGSHTHRV/2fYFa8xSQhPdTirNc290VsZBWmaxUCpdqZuZSBKJfDDP24Fr0ID4I0
	 iXmwA9W3W+5lv/2/oVUbVNrG+pLk2Kkqn7GVoY3FQqXNMMH4H6tjeyXBgW4DmjZaH/
	 E6Mdl+90KflZhAp7Afa0ZP/GG1O/Ek4nLxZjb5gbBZhVXQ4ScWM4SU5/Q3ZE6QbZiW
	 JdPhYCKKxQGdzmd0J+7rmY7GddZKkMD7Fa6Izc2mImP6gC+1Ds3qf2pPfDX8r0kJoD
	 Gy/UVrFkGvZkW21eEZIjvRsb0b4ZMAMLw7dzRqLPLBrI1RE7bybU1vxmJRC7cfo+lI
	 4dcvUx1wDQ+0w==
Message-ID: <a825aed9-c217-4864-807d-9fce40076388@lankhorst.se>
Date: Fri, 24 Oct 2025 14:21:50 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
To: Natalie Vock <natalie.vock@gmx.de>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
 <20251015-dmemcg-aggressive-protect-v2-5-36644fb4e37f@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20251015-dmemcg-aggressive-protect-v2-5-36644fb4e37f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2025-10-15 kl. 15:57, skrev Natalie Vock:
> When checking whether to skip certain buffers because they're protected
> by dmem.low, we're checking the effective protection of the evictee's
> cgroup, but depending on how the evictor's cgroup relates to the
> evictee's, the semantics of effective protection values change.
> 
> When testing against cgroups from different subtrees, page_counter's
> recursive protection propagates memory protection afforded to a parent
> down to the child cgroups, even if the children were not explicitly
> protected. This prevents cgroups whose parents were afforded no
> protection from stealing memory from cgroups whose parents were afforded
> more protection, without users having to explicitly propagate this
> protection.
> 
> However, if we always calculate protection from the root cgroup, this
> breaks prioritization of sibling cgroups: If one cgroup was explicitly
> protected and its siblings were not, the protected cgroup should get
> higher priority, i.e. the protected cgroup should be able to steal from
> unprotected siblings. This only works if we restrict the protection
> calculation to the subtree shared by evictor and evictee.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 7f7872ab2090cc8db188e08ddfdcd12fe924f743..bc88941c0aadb9a1d6fbaa470ccdeae4f91c41fb 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -524,13 +524,29 @@ struct ttm_bo_evict_walk {
>  
>  static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
>  {
> +	struct dmem_cgroup_pool_state *limit_pool;
>  	struct ttm_bo_evict_walk *evict_walk =
>  		container_of(walk, typeof(*evict_walk), walk);
>  	s64 lret;
>  
> -	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_pool,
> -					      bo->resource->css, evict_walk->try_low,
> -					      &evict_walk->hit_low))
> +	/*
> +	 * If only_evict_unprotected is set, then we're trying to evict unprotected
> +	 * buffers in favor of a protected allocation for charge_pool. Explicitly skip
> +	 * buffers belonging to the same cgroup here - that cgroup is definitely protected,
> +	 * even though dmem_cgroup_state_evict_valuable would allow the eviction because a
> +	 * cgroup is always allowed to evict from itself even if it is protected.
> +	 */
> +	if (evict_walk->alloc_state->only_evict_unprotected &&
> +			bo->resource->css == evict_walk->alloc_state->charge_pool)
> +		return 0;
> +
> +	limit_pool = evict_walk->alloc_state->limit_pool;
> +	if (!limit_pool)
> +		limit_pool = dmem_cgroup_common_ancestor(bo->resource->css,
> +							 evict_walk->alloc_state->charge_pool);
> +
> +	if (!dmem_cgroup_state_evict_valuable(limit_pool, bo->resource->css,
> +					      evict_walk->try_low, &evict_walk->hit_low))
>  		return 0;
>  
>  	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
> 
Patches themselves look good, I think it would help to add a bit more documentation since
cgroup related dmem eviction is already complicated, and while I believe those changes are
correct, it will help others to understand the code in case bugs show up.

Perhaps even add a global overview of how dmem eviction interacts with TTM eviction.

This will need review from the TTM maintainers/reviewers too before being accepted.

With the extra documentation added:
Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>

