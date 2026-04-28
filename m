Return-Path: <cgroups+bounces-15540-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBkFJMjW8GkSZQEAu9opvQ
	(envelope-from <cgroups+bounces-15540-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 17:48:24 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F15AA48833F
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 17:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91114301A40A
	for <lists+cgroups@lfdr.de>; Tue, 28 Apr 2026 15:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAD3BED23;
	Tue, 28 Apr 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="Es0gDkrM"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (unknown [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033722BCF45
	for <cgroups@vger.kernel.org>; Tue, 28 Apr 2026 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391291; cv=none; b=H02BtngiDI9pAy1sYgwX3acxvwbBi1nmNIWHcU5iuBD5tXauJZWkumkGK1HtkaKgYvYE0D3QE0GBm44XdxbxS4iA69+OffwlkfyvDz/O3Jwr1qyvlIgZBLboZW9Q9dTp6XEtJgo8iLgarLPtJxop3gxbZTVeBjjCZkZbJ8Tq2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391291; c=relaxed/simple;
	bh=TZC4L6MlXcgK9rO/7VN9fiRkGEjyFb7Kv4VYhjGEJ10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THrEMtMZixS+I7gnX50ptoGJoN3gRhKUwA2E8eNEEfT/wdqRMbsmISyEH41k4uNzStytJyni5NRufbdL5dwTdsguBRAwoFCQ4JNyWu2lRIBOzPdK+UF5U/Owz1KVNyOvgijoxwIZr3mwIVMMa0rZCWzQxd++lypDZdAJGnGXpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=Es0gDkrM; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1777391286;
	bh=TZC4L6MlXcgK9rO/7VN9fiRkGEjyFb7Kv4VYhjGEJ10=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Es0gDkrM0CDN0fbH0f80SuUvlhGSdv6nu93m4m2wd8KyqFWZfm3Ht4QjiDIoA1M+I
	 g+0Uwhu61Tok66n1WU7YHNwoiE8S8xasDandAlhCrj1Von9a02gEf9XMVp8SSjFJgy
	 04v4C8zyN+/DzPpuyubEX9iCWtiZq9H8KaQpJYM32uxn5jgeG6BOXgetolg3wYev9m
	 mMv4xrFAvEomXug06GoTk9COmNFT0Y/7qPcu7cwF+BgCpljZBCIw9lahusRjmZNaQl
	 U2wV+Mlgcdp7gt2A8pLKiI7dUaRsNgR+U5nFK8m9uqR7jPa5EM993sW2dbWuX1W/Bs
	 Peii6QTuWsNIA==
Message-ID: <d8c1c4d6-ddc6-4519-b7fe-fc54cd14da3a@lankhorst.se>
Date: Tue, 28 Apr 2026 17:48:07 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] drm/ttm: Split cgroup charge and resource
 allocation
To: Natalie Vock <natalie.vock@gmx.de>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-4-7c71cc1492db@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-4-7c71cc1492db@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F15AA48833F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lankhorst.se,none];
	R_DKIM_ALLOW(-0.20)[lankhorst.se:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15540-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@lankhorst.se,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[lankhorst.se:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gitlab.freedesktop.org:url,lankhorst.se:email,lankhorst.se:dkim,lankhorst.se:mid,gmx.de:email]

Hey,

I've been looking at the series, and it's looking good for me.

For entire series:

Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>

One point of mild concern is that the TTM code has been changed
around a lot, and it will change even further when we start supporting
system memory cgroups.

I think at this point it may make sense that before merging, you get
someone from the TTM side to ACK the changes too,
and that we have some IGT testcases excercising the changes.

For AMD, you can use Dave Airlie's cgroup changes as base,
https://gitlab.freedesktop.org/airlied/igt-gpu-tools/-/tree/amdgpu-cgroups?ref_type=heads

For xe, there are some basic functionality tests for min and max, but
I've not yet added testcases that exercise the exact paths
in igt/tests/intel/xe_cg_dmem.c

So please wait with merging until we have the IGT testcase ready to go with it,
and reviews from ttm reviewers/maintainers?

Kind regards,
~Maarten Lankhorst

Den 2026-03-13 kl. 12:40, skrev Natalie Vock:
> Coupling resource allocation and cgroup charging is racy when charging
> succeeds, but subsequent resource allocation fails. Certain eviction
> decisions are made on the basis of whether the allocating cgroup is
> protected, i.e. within its min/low limits, but with the charge being
> tied to resource allocation (and uncharged when the resource allocation
> fails), this check is done at a point where the allocation is not actually
> charged to the cgroup.
> 
> This is subtly wrong if the allocation were to cause the cgroup to exceed
> the min/low protection, but it's even more wrong if the same cgroup tries
> allocating multiple buffers concurrently: In this case, the min/low
> protection may pass for all allocation attempts when the real min/low
> protection covers only some, or potentially none of the allocated
> buffers.
> 
> Instead, charge the allocation to the cgroup once and keep the charge
> for as long as we try to allocate a ttm_resource, and only undo the charge
> if allocating the resource is ultimately unsuccessful and we move on to
> a different ttm_place.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/ttm/ttm_bo.c       | 66 ++++++++++++++++++++++++++------------
>  drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++--------
>  include/drm/ttm/ttm_resource.h     |  6 +++-
>  3 files changed, 85 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 5cca0d6edbaf6..4adc9b80cba4a 100644
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
> +	/** @in_evict: Whether we are currently evicting buffers */
> +	bool in_evict;
>  };
>  
>  /**
> @@ -520,28 +524,39 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>  	bool may_evict;
>  	int ret;
>  
> -	may_evict = force_space && place->mem_type != TTM_PL_SYSTEM;
> -
> -	ret = ttm_resource_alloc(bo, place, res,
> -				 force_space ? &alloc_state->limit_pool : NULL);
> +	may_evict = !alloc_state->in_evict && force_space &&
> +		    place->mem_type != TTM_PL_SYSTEM;
> +	if (!alloc_state->charge_pool) {
> +		ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
> +					      force_space ? &alloc_state->limit_pool
> +							  : NULL);
> +		if (ret) {
> +			/*
> +			 * -EAGAIN means the charge failed, which we treat
> +			 * like an allocation failure. Therefore, return an
> +			 * error code indicating the allocation failed -
> +			 * either -EBUSY if the allocation should be
> +			 * retried with eviction, or -ENOSPC if there should
> +			 * be no second attempt.
> +			 */
> +			if (ret == -EAGAIN)
> +				ret = may_evict ? -EBUSY : -ENOSPC;
> +			return ret;
> +		}
> +	}
>  
> +	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>  	if (ret) {
> -		/*
> -		 * -EAGAIN means the charge failed, which we treat like an
> -		 * allocation failure. Therefore, return an error code indicating
> -		 * the allocation failed - either -EBUSY if the allocation should
> -		 * be retried with eviction, or -ENOSPC if there should be no second
> -		 * attempt.
> -		 */
> -		if (ret == -EAGAIN)
> -			return may_evict ? -EBUSY : -ENOSPC;
> -
>  		if (ret == -ENOSPC && may_evict)
> -			return -EBUSY;
> -
> +			ret = -EBUSY;
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
> @@ -596,8 +611,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>  
>  	evict_walk->evicted++;
>  	if (evict_walk->res)
> -		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +		lret = ttm_bo_alloc_at_place(evict_walk->evictor, evict_walk->place,
> +					     walk->arg.ctx, false, evict_walk->res,
> +					     evict_walk->alloc_state);
>  	if (lret == 0)
>  		return 1;
>  out:
> @@ -636,6 +652,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>  	};
>  	s64 lret;
>  
> +	state->in_evict = true;
> +
>  	evict_walk.walk.arg.trylock_only = true;
>  	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>  
> @@ -666,6 +684,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>  		goto retry;
>  	}
>  out:
> +	state->in_evict = false;
>  	if (lret < 0)
>  		return lret;
>  	if (lret == 0)
> @@ -798,6 +817,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>  				res, &alloc_state);
>  
>  		if (ret == -ENOSPC) {
> +			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
>  			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>  			continue;
>  		} else if (ret == -EBUSY) {
> @@ -806,11 +826,15 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>  
>  			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>  
> -			if (ret == -EBUSY)
> -				continue;
> -			else if (ret)
> +			if (ret) {
> +				dmem_cgroup_uncharge(alloc_state.charge_pool,
> +						bo->base.size);
> +				if (ret == -EBUSY)
> +					continue;
>  				return ret;
> +			}
>  		} else if (ret) {
> +			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
>  			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>  			return ret;
>  		}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 192fca24f37e4..a8a836f6e376a 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -373,30 +373,52 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
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
> index 33e80f30b8b82..549b5b796884d 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -456,10 +456,14 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
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


