Return-Path: <cgroups+bounces-14511-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNCKJCuupWleEQAAu9opvQ
	(envelope-from <cgroups+bounces-14511-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 16:35:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFF01DBF08
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76E48303AB74
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9431741160D;
	Mon,  2 Mar 2026 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="kWKOCUjQ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FE4014A3
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 15:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465125; cv=none; b=Dol6TT1SXxktV7GMWIrkAxjWtb4bbgn3ttLpezPnwrmUlC2qv++/ktx0AjqbdVam1+fUX1sdRFbNrS5wDyHMUbEbvENI+JnpD+5Xwu9IvO7yKF37kQ7HYa5/orWE/Fftqife3F0PRQjD8hwLOBrkRsaJnaCT2+CGVgZvMmALxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465125; c=relaxed/simple;
	bh=TYc9O/whSYAcXmQ7lSM+W1VSXXw+klReSs5OCmu3IO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhqo8CvbGgOrQLhCn+NBz8u/PD+nFJx2qanoJOHQM6l2FMwNH5cm4IFWJL7CVblXkWkg9g4PzOKR8pZH/Ei4qRJOY0Mt1gcHx9ElyHqZOL9Fa4nOLUafZS+424DzhtxWcEskzkb0bih/HBtAloNCa1H/yq8NRoSUO61ynMvZXoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=kWKOCUjQ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-482f454be5bso50401285e9.0
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 07:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772465122; x=1773069922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+2ah/ixbAU4QGEREsYn+BhbPbrQH9g+qI8tzdOSG8e0=;
        b=kWKOCUjQiionD4S/Lwyyk/juzWZ7p8JYVnCT4kZl3CXWvBmGXI7ZJXMopYtmSugDRh
         3KK58/CO1/tc1/ueBEYVtRXQWunNxYxvZV4sl7ZLrZ/WvdpmsN7E9oTW2zvnwAFPWj8p
         c/qFs/9SZLWd9mfSzj4OvODkPpbiwUEoSxLFZKtq9YVJqaCVhGd3S8+bd+7Ke9i2MFnQ
         H09MyKp6bkzAjCjCVKX8H7EsOwnt3g6l39Kp0bpcuGOUFn08+qJlpM21BFvB9Yh0CQzc
         FfrBvyeuouIUB3SiNwrayaVQMr3x0itgHMUl3rTc/zer4xY0JPTyHn1++F/2RW03djMI
         BqVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772465122; x=1773069922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+2ah/ixbAU4QGEREsYn+BhbPbrQH9g+qI8tzdOSG8e0=;
        b=UajNG7h+sqyjNYtuLmkaNU6/ASA6eSDWnq/Impi2OznxS02HMLETyeKAepisGqGOrQ
         R9W+eNnBjUjQRVPbwkvMVrNpyxChhCo83JL5F2VsPQ7LXq/qyyM8Dqpvn0WX0qQlYTwd
         FxO/M+b3ovYIA7qLgtMoZLoxD/Byu8k+noo1ru9YTv18fUeBzJcxbrWBani+fk94BLN9
         0OlR8A9NdRHBcuQGCLduwomeE//yPCe8eOhhndeCeWHXi+CnUTUrvb5Qtk8V1C6vzmJ9
         k3hF8RY/S9kk4f1H89qUygaohOryCm9yWypOsMli3pG0+L/xBhOaVX48TAlbuTCc6alZ
         0szg==
X-Gm-Message-State: AOJu0YxYUH1jamDtR2u2pdXi08EpkQP+n4LeJbbOotLODHaSYNHXQ6Ve
	fmOLYrkfw45asOdkGQnIPlnPgPfssmcGgxwbuSmN6a8iQUISMDg7/FG6dczmngvcgnM=
X-Gm-Gg: ATEYQzzSy1lLB3gJgfnuIVeg0DO8Y7hj+z1GDfLW5viwDHwN8i0G0TiwpiqRJ5cGJvK
	tGREYau/hRc+PSiySSNRPmlyhYqp4vR2r/Tf+v3Cwr9KAJ6Rj5x9eqN2XRtl9mHfxGyjJmCqTbw
	FJBSZjBeoSwQ0z2kYMhP9jBYPXwHWl90/543+rxAil33bLpaD6uMubEPllHOxEJWKx3FjNRibbb
	dPCLjZALIpRURlqW02kQqz35fgtB0P4HzjwyVRwiJgt3k2h/Wbe6dCap50LohH8Nb5es26GOzDA
	cxkGFTW62TvmKE51Qa7Xz1KTObezCTgHz41rDtKhIpiVWKCa80UUm5Pdfl/99OVUSsEay1cH1No
	FtQDnh/ok0SuD8YAUwWD83EZJKGvG1pAKQQKfygV/AWoJWgQSTtr9+S7Ue6xNOi1KPcissjh5nP
	OY/NR/PsthYYuMMKtEyofU4PNFwG6OKmZlXlUWhuY/5G2a
X-Received: by 2002:a05:600c:c16e:b0:475:ddad:c3a9 with SMTP id 5b1f17b1804b1-483c99348c5mr226517205e9.13.1772465121744;
        Mon, 02 Mar 2026 07:25:21 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfcbf673sm164562955e9.19.2026.03.02.07.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:25:21 -0800 (PST)
Message-ID: <ff49aade-ba31-43d2-b057-f5af56dd672b@ursulin.net>
Date: Mon, 2 Mar 2026 15:25:20 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] drm/ttm: Split cgroup charge and resource
 allocation
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
 <20260302-dmemcg-aggressive-protect-v5-4-ffd3a2602309@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260302-dmemcg-aggressive-protect-v5-4-ffd3a2602309@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7DFF01DBF08
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14511-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[ursulin.net];
	FREEMAIL_TO(0.00)[gmx.de,lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,linux.intel.com,suse.de,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ursulin.net:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tursulin@ursulin.net,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ursulin.net:dkim,ursulin.net:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,gmx.de:email]
X-Rspamd-Action: no action


On 02/03/2026 12:37, Natalie Vock wrote:
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
>   drivers/gpu/drm/ttm/ttm_bo.c       | 45 +++++++++++++++++++++++++----------
>   drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++++++++++-----------
>   include/drm/ttm/ttm_resource.h     |  6 ++++-
>   3 files changed, 73 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 3e62cab51f870..53c4de4bcc1e3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -490,6 +490,8 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
>   }
>   
>   struct ttm_bo_alloc_state {
> +	/** @charge_pool: The memory pool the resource is charged to */
> +	struct dmem_cgroup_pool_state *charge_pool;
>   	/** @limit_pool: Which pool limit we should test against */
>   	struct dmem_cgroup_pool_state *limit_pool;
>   };
> @@ -544,9 +546,17 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   		goto out;
>   
>   	evict_walk->evicted++;
> +	if (!evict_walk->alloc_state->charge_pool) {
> +		lret = ttm_resource_try_charge(bo, evict_walk->place,
> +					       &evict_walk->alloc_state->charge_pool, NULL);

Right, this is if charging against the 1st attempted placement failed. 
It is a bit sub-optimal that the two placec doing the charge is split 
like this.

Would it work to use ttm_bo_alloc_at_place() here as well?

Regards,

Tvrtko

> +		if (lret == -EAGAIN)
> +			return -EBUSY;
> +		else if (lret)
> +			return lret;
> +	}
>   	if (evict_walk->res)
>   		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +					  evict_walk->res, evict_walk->alloc_state->charge_pool);
>   	if (lret == 0)
>   		return 1;
>   out:
> @@ -724,10 +734,8 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   	int ret;
>   
>   	may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
> -
> -	ret = ttm_resource_alloc(bo, place, res,
> -				 force_space ? &alloc_state->limit_pool : NULL);
> -
> +	ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
> +				      force_space ? &alloc_state->limit_pool : NULL);
>   	if (ret) {
>   		/*
>   		 * -EAGAIN means the charge failed, which we treat like an
> @@ -737,14 +745,22 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   		 * attempt.
>   		 */
>   		if (ret == -EAGAIN)
> -			return may_evict ? -EBUSY : -ENOSPC;
> +			ret = may_evict ? -EBUSY : -ENOSPC;
> +		return ret;
> +	}
>   
> +	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
> +	if (ret) {
>   		if (ret == -ENOSPC && may_evict)
> -			return -EBUSY;
> -
> +			ret = -EBUSY;
>   		return ret;
>   	}
>   
> +	/*
> +	 * Ownership of charge_pool has been transferred to the TTM resource,
> +	 * don't make the caller think we still hold a reference to it.
> +	 */
> +	alloc_state->charge_pool = NULL;
>   	return 0;
>   }
>   
> @@ -799,6 +815,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				res, &alloc_state);
>   
>   		if (ret == -ENOSPC) {
> +			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			continue;
>   		} else if (ret == -EBUSY) {
> @@ -807,11 +824,15 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   
> -			if (ret == -EBUSY)
> -				continue;
> -			else if (ret)
> -				return;
> +			if (ret) {
> +				dmem_cgroup_uncharge(alloc_state.charge_pool,
> +						bo->base.size);
> +				if (ret == -EBUSY)
> +					continue;
> +				return ret;
> +			}
>   		} else if (ret) {
> +			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			return ret;
>   		}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index 192fca24f37e4..a8a836f6e376a 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -373,30 +373,52 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
>   }
>   EXPORT_SYMBOL(ttm_resource_fini);
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
>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>   		       const struct ttm_place *place,
>   		       struct ttm_resource **res_ptr,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool)
> +		       struct dmem_cgroup_pool_state *charge_pool)
>   {
>   	struct ttm_resource_manager *man =
>   		ttm_manager_type(bo->bdev, place->mem_type);
> -	struct dmem_cgroup_pool_state *pool = NULL;
>   	int ret;
>   
> -	if (man->cg) {
> -		ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, ret_limit_pool);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	ret = man->func->alloc(man, bo, place, res_ptr);
> -	if (ret) {
> -		if (pool)
> -			dmem_cgroup_uncharge(pool, bo->base.size);
> +	if (ret)
>   		return ret;
> -	}
>   
> -	(*res_ptr)->css = pool;
> +	(*res_ptr)->css = charge_pool;
>   
>   	spin_lock(&bo->bdev->lru_lock);
>   	ttm_resource_add_bulk_move(*res_ptr, bo);
> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
> index 33e80f30b8b82..549b5b796884d 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -456,10 +456,14 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
>   void ttm_resource_fini(struct ttm_resource_manager *man,
>   		       struct ttm_resource *res);
>   
> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
> +			    const struct ttm_place *place,
> +			    struct dmem_cgroup_pool_state **ret_pool,
> +			    struct dmem_cgroup_pool_state **ret_limit_pool);
>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>   		       const struct ttm_place *place,
>   		       struct ttm_resource **res,
> -		       struct dmem_cgroup_pool_state **ret_limit_pool);
> +		       struct dmem_cgroup_pool_state *charge_pool);
>   void ttm_resource_free(struct ttm_buffer_object *bo, struct ttm_resource **res);
>   bool ttm_resource_intersects(struct ttm_device *bdev,
>   			     struct ttm_resource *res,
> 


