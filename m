Return-Path: <cgroups+bounces-11142-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72678C0631B
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 14:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E5BC347F2D
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCE030DD00;
	Fri, 24 Oct 2025 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="c7OuYzGD"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D603F1DB127
	for <cgroups@vger.kernel.org>; Fri, 24 Oct 2025 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761308060; cv=none; b=sJDoSRG7poKU4me1Yg2VP2Z1ZpXSlWRpK+R1yil5+yaHCGMVVsm3UkxwquEjnSk1nUu7SxX0lVXDAm6w0yOz5FBhTGT2sSQ4aSE6YCmFOItFDT+LFAYkMHx5qUcIVcrN2paYZHj/8mM4wzmb6sRJq/Wkk1FqhLhwZCOvVD1UqJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761308060; c=relaxed/simple;
	bh=mUgGclEUJP/YsOpejxVN9sM5jH/lJrFVRct1ALyKjN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSM2/YyC/WVRTFxh3YNSNjyCqHWsOfAI3QtiimwwLx8MA+NguKtU3W7/YM7Rs6yXvKijcTaY/MscWu+Aj4lHos+/MusnQIbdxobqZyBU/aYOFRMB+0A5IlKfNOOmziypWR/zyfkQW+m035GCfA50q3VE7KFVl+IfJQxDcn82h4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=c7OuYzGD; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1761308056;
	bh=mUgGclEUJP/YsOpejxVN9sM5jH/lJrFVRct1ALyKjN8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c7OuYzGDap91qKnBfI3gDMMCNWroCRiOL7wZTxy6/HYviLCNVQMcXFxojAmT9Ku1W
	 n177/zaiOkaJUNsQVAsoffVr0kFuB13+M5Fi9CBhX44qSdpEpB2216WLZCRiAOs5jx
	 Be4smAeSpDRy1MOO3avp3EKbXyCd4P0R1TluB5dt6xLpuyFA3XSI9wnCx+NCCnVHPO
	 cBMR77thagPAxAv/wy3V/ecBVrR5CJg3RpO7rEajUV0W0fB2y8dY+kvcCtdTMzluDD
	 WYbKqoWNjM/NPlS4y+npJLrWTTYHGCqm0zfkR877L0C8WxTAKSuKw/nt1tbdJu79v8
	 afSRIHZnRrAGA==
Message-ID: <1ebc018f-fee0-4813-8e2e-7a704d3334b0@lankhorst.se>
Date: Fri, 24 Oct 2025 14:14:14 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/ttm: Be more aggressive when allocating below
 protection limit
To: Natalie Vock <natalie.vock@gmx.de>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
 <20251015-dmemcg-aggressive-protect-v2-4-36644fb4e37f@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20251015-dmemcg-aggressive-protect-v2-4-36644fb4e37f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2025-10-15 kl. 15:57, skrev Natalie Vock:
> When the cgroup's memory usage is below the low/min limit and allocation
> fails, try evicting some unprotected buffers to make space. Otherwise,
> application buffers may be forced to go into GTT even though usage is
> below the corresponding low/min limit, if other applications filled VRAM
> with their allocations first.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c       | 43 ++++++++++++++++++++++++++++------
>  drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++++++++++-----------
>  include/drm/ttm/ttm_resource.h     |  6 ++++-
>  3 files changed, 76 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 829d99479883594f8be5b9ceed4cc53c4864ace5..7f7872ab2090cc8db188e08ddfdcd12fe924f743 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -490,8 +490,12 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
>  }
>  
>  struct ttm_bo_alloc_state {
> +	/** @charge_pool: The memory pool the resource is charged to */
> +	struct dmem_cgroup_pool_state *charge_pool;
>  	/** @limit_pool: Which pool limit we should test against */
>  	struct dmem_cgroup_pool_state *limit_pool;
> +	/** @only_evict_unprotected: If eviction should be restricted to unprotected BOs */
> +	bool only_evict_unprotected;
I'm not entirely sure we should put 'low' and 'min' limits together here.
>  };
>  
>  /**
> @@ -546,7 +550,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>  	evict_walk->evicted++;
>  	if (evict_walk->res)
>  		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +					  evict_walk->res, evict_walk->alloc_state->charge_pool);
>  	if (lret == 0)
>  		return 1;
>  out:
> @@ -589,7 +593,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>  	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>  
>  	/* One more attempt if we hit low limit? */
> -	if (!lret && evict_walk.hit_low) {
> +	if (!lret && evict_walk.hit_low && !state->only_evict_unprotected) {
>  		evict_walk.try_low = true;
>  		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>  	}
> @@ -610,7 +614,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>  	} while (!lret && evict_walk.evicted);
>  
>  	/* We hit the low limit? Try once more */
> -	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
> +	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
> +			!state->only_evict_unprotected) {
>  		evict_walk.try_low = true;
>  		goto retry;
>  	}
> @@ -719,20 +724,40 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>  				 struct ttm_resource **res,
>  				 struct ttm_bo_alloc_state *alloc_state)
>  {
> -	bool may_evict;
> +	bool may_evict, is_protected = false;
>  	int ret;
>  
>  	may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
> +	ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
> +				      force_space ? &alloc_state->limit_pool : NULL);
> +	if (ret) {
> +		/*
> +		 * -EAGAIN means the charge failed, which we treat like an
> +		 * allocation failure. Allocation failures are indicated
> +		 * by -ENOSPC, so return that instead.
> +		 */
> +		if (ret == -EAGAIN && !may_evict)
> +			ret = -ENOSPC;
> +		return ret;
> +	}
>  
> -	ret = ttm_resource_alloc(bo, place, res,
> -				 force_space ? &alloc_state->limit_pool : NULL);
> +	is_protected = dmem_cgroup_below_min(NULL, alloc_state->charge_pool) ||
> +		       dmem_cgroup_below_low(NULL, alloc_state->charge_pool);
> +	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
> +	alloc_state->only_evict_unprotected = !may_evict && is_protected;

This probably deserves a comment to explaing it's ok if we haven't hit low/min yet to evict from
those cgroups that did those limits already. It took me a bit of time to understand the idea.

>  
>  	if (ret) {
> -		if ((ret == -ENOSPC || ret == -EAGAIN) && may_evict)
> +		if ((ret == -ENOSPC || ret == -EAGAIN) &&
> +				(may_evict || is_protected))
>  			ret = -EBUSY;
>  		return ret;
>  	}
>  
> +	/*
> +	 * Ownership of charge_pool has been transferred to the TTM resource,
> +	 * don't make the caller think we still hold a reference to it.
> +	 */
> +	alloc_state->charge_pool = NULL;
>  	return 0;
>  }
>  
> @@ -787,6 +812,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>  				res, &alloc_state);
>  
>  		if (ret == -ENOSPC) {
> +			dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>  			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>  			continue;
>  		} else if (ret == -EBUSY) {
> @@ -796,11 +822,14 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>  			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>  
>  			if (ret) {
> +				dmem_cgroup_pool_state_put(
> +						alloc_state.charge_pool);
>  				if (ret != -ENOSPC && ret != -EBUSY)
>  					return ret;
>  				continue;
>  			}
>  		} else if (ret) {
> +			dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>  			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>  			return ret;
>  		}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index e2c82ad07eb44b5e88bf5b5db1ef54dd6d27823b..fcfa8b51b033745f46a01e40a9dc83e0c69165fc 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -372,30 +372,52 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
>  }
>  EXPORT_SYMBOL(ttm_resource_fini);
>  
> +/**
> + * ttm_resource_try_charge - charge a resource manager's cgroup pool
> + * @bo: buffer for which an allocation should be charged
> + * @place: where the allocation is attempted to be placed
> + * @ret_pool: on charge success, the pool that was charged
> + * @ret_limit_pool: on charge failure, the pool responsible for the failure
> + *
> + * Should be used to charge cgroups before attempting resource allocation.
> + * When charging succeeds, the value of ret_pool should be passed to
> + * ttm_resource_alloc.
> + *
> + * Returns: 0 on charge success, negative errno on failure.
> + */
> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
> +			    const struct ttm_place *place,
> +			    struct dmem_cgroup_pool_state **ret_pool,
> +			    struct dmem_cgroup_pool_state **ret_limit_pool)
> +{
> +	struct ttm_resource_manager *man =
> +		ttm_manager_type(bo->bdev, place->mem_type);
> +
> +	if (!man->cg) {
> +		*ret_pool = NULL;
> +		if (ret_limit_pool)
> +			*ret_limit_pool = NULL;
> +		return 0;
> +	}
> +
> +	return dmem_cgroup_try_charge(man->cg, bo->base.size, ret_pool,
> +				      ret_limit_pool);
> +}
> +
>  int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  		       const struct ttm_place *place,
>  		       struct ttm_resource **res_ptr,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool)
> +		       struct dmem_cgroup_pool_state *charge_pool)
>  {
>  	struct ttm_resource_manager *man =
>  		ttm_manager_type(bo->bdev, place->mem_type);
> -	struct dmem_cgroup_pool_state *pool = NULL;
>  	int ret;
>  
> -	if (man->cg) {
> -		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
> -		if (ret)
> -			return ret;
> -	}
> -
>  	ret = man->func->alloc(man, bo, place, res_ptr);
> -	if (ret) {
> -		if (pool)
> -			dmem_cgroup_uncharge(pool, bo->base.size);
> +	if (ret)
>  		return ret;
> -	}
>  
> -	(*res_ptr)->css = pool;
> +	(*res_ptr)->css = charge_pool;
>  
>  	spin_lock(&bo->bdev->lru_lock);
>  	ttm_resource_add_bulk_move(*res_ptr, bo);
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index e52bba15012f78e352f392232ac2e89a83afd311..3aef7efdd7cfb8fd93071db85e632b975b53cf81 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -442,10 +442,14 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
>  void ttm_resource_fini(struct ttm_resource_manager *man,
>  		       struct ttm_resource *res);
>  
> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
> +			    const struct ttm_place *place,
> +			    struct dmem_cgroup_pool_state **ret_pool,
> +			    struct dmem_cgroup_pool_state **ret_limit_pool);
>  int ttm_resource_alloc(struct ttm_buffer_object *bo,
>  		       const struct ttm_place *place,
>  		       struct ttm_resource **res,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool);
> +		       struct dmem_cgroup_pool_state *charge_pool);
>  void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res);
>  bool ttm_resource_intersects(struct ttm_device *bdev,
>  			     struct ttm_resource *res,
> 


