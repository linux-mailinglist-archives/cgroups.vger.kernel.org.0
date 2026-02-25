Return-Path: <cgroups+bounces-14353-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mFTGAZfhnmmCXgQAu9opvQ
	(envelope-from <cgroups+bounces-14353-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 12:48:39 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70473196DBE
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 12:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 886F930CC22A
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 11:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48A39A7FF;
	Wed, 25 Feb 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="JRbIKZTb"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165732BE7CD
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772019934; cv=none; b=YdBsEqvov3+mWrmDwqazRif3AujktRwyLYt9SUNaOSCHRfEXBnsCJPBg9fh5qIRepVhfeH9YT45wZHcmXwcuhfxPK19J/oFezXgIYFxvpYs4UDzwyKPppFmGDX6yHFUAilJUwpCaXVVEmrigrDUwLWYKyTCUtwkoVhI+9GlDkzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772019934; c=relaxed/simple;
	bh=9T3mohY4vV6QslUtMEOtDfHeMlKpehyUITRk4J9Q5cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiIRHaW65HAYM/05hWzJYlqB6tBBHLwGGuYDwTdVk3hi9fJQ9ZrdsrZt5fQLtzzNNQGp2W/6ctqCk/5lA9+Jha75H3BxkP/ZPWjw1SoyZwPrQBNxC0icPh+vVEEIJGK4cjNWMbzWJ1Fy5blEQRm9sM9ypOn1ih9Y1hKbBuYtVFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=JRbIKZTb; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43638a33157so6130718f8f.1
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 03:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772019924; x=1772624724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2o8kIvcCPgtBizkCcHTsZPCsnJ3kiwKwkx0W/HNxFc=;
        b=JRbIKZTbJOJvsyerVSUt5FEE3GD04x3RuIrMeXBvcfdRsBL7/uwaSzshmIDcLu8s94
         vJE+o67d1RF9VF75RTEp+O2s1fMYkKlWU5PvYALZy0UxNsH2qH4xFwdGd6EU6IIZPJFi
         pk9E8+hGDyVvhhDqN3DTO6weIVJEo8LA4qj7RQQRZYjUS66wQxgyofwNnoRu6fDFDdDv
         MmcvSj/hdlyBD6Uk68ZzBdh0ad4rj6QEj1mHT5+17GZvisXTNPovT3NCP7/aqlwfvrsb
         pZDQbRBpsip7IL2FQ0TWdUWI3NoKD4PZqNAf1ROz1xOL7ea0n12Fo0F88Iv//mLMSSZp
         nh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772019924; x=1772624724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2o8kIvcCPgtBizkCcHTsZPCsnJ3kiwKwkx0W/HNxFc=;
        b=R7Qn71nJmWkt0qb4//TmQEhN+npRCXNLF3rbff8GdLEDEJR68GfUGQEp1KVF1fxQCd
         NmS/qgi5YcGZNcUNQJVRAQL7IXL/covIgFA5HEyCM26klnoP/hqq9iyd3x81rqDPLsS+
         wRfFTgZAXL9EQ09U4TB6Y2zowz4l5Pn5ryGJFT5iwxllZKc7v5fYRPg7pm9d3fYQJZtd
         Mij9mp1NekDIHII/Bni1FR3kIpftD8Bwc0KVwIBArBNIdalVpfSXfJuUw4I5TyDouv2S
         rKkvQtUb9vMXeUD4z9f+OFhHsdBSlwPLahs8HAkZsu2uFwzzfcc66rSaTchjz2feTxBA
         r2mg==
X-Gm-Message-State: AOJu0YxJQF5i55PWql1OQhAttpjIIVAib1VoNYyMrhTanJtuHAeqI3Yc
	NRNcHlrTy3qT1hdV3j9p9F9f7oNxDaILJjYM65PGtSKFFgEP+lxh3LAzIPLm61kG+GU=
X-Gm-Gg: ATEYQzzu8PClguTHmxLSmX7J20iJt9qqdcHdF82PSMNnPhpRFGHCrpf7UtIuafyDYEm
	XnzZz/p0vcWWBmYw6DvmjOsXikfTrTvIkXlhlXQ9yxaGgTgnrg1bwc8kF7IwEGt5o7bXeIiddK6
	kjOc+sJTeI3SL5XaHi3zPBLoBN3K7NjfiSYede+0CSi/QAmB4LeYCXYM6xR4+VtWvwmAceU99dR
	6Mg5//vFH5nS0jRTtQ0XLAVPP9uwxv4GGPZdFyXGR/nu6bWd9PsX7P2Ii3Kv/64mKNv1z9Op0/t
	DPzYN2H4T6v6mCFZ9B8jCd0RoGwnnX6DHXTvT+TiwsZ/mwl0nbrUPEUszewTTQKAA6VwKButd69
	nWzjzqIwOo+6EgVUFqDUBQ5CucfKEFyC3Kgyp/FM67zidsySEbZ3jOmzp8iiXilwKPHtKsSsycb
	pUj+Am3fyaI4mjOSW19hidHgQtYwreE3KrHrgHp2MINYMMf2VbgSYd4og=
X-Received: by 2002:a05:6000:4014:b0:439:664d:e9b7 with SMTP id ffacd0b85a97d-4396f14c9e4mr27774517f8f.7.1772019923588;
        Wed, 25 Feb 2026 03:45:23 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4398a09aad0sm9041947f8f.2.2026.02.25.03.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 03:45:22 -0800 (PST)
Message-ID: <99d1bcbd-6df2-4b71-8c79-9e1c2ee31562@ursulin.net>
Date: Wed, 25 Feb 2026 11:45:22 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/ttm: Be more aggressive when allocating below
 protection limit
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
References: <20251110-dmemcg-aggressive-protect-v3-0-219ffcfc54e9@gmx.de>
 <20251110-dmemcg-aggressive-protect-v3-4-219ffcfc54e9@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251110-dmemcg-aggressive-protect-v3-4-219ffcfc54e9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14353-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email,ursulin.net:mid,ursulin.net:dkim]
X-Rspamd-Queue-Id: 70473196DBE
X-Rspamd-Action: no action


On 10/11/2025 12:37, Natalie Vock wrote:
> When the cgroup's memory usage is below the low/min limit and allocation
> fails, try evicting some unprotected buffers to make space. Otherwise,
> application buffers may be forced to go into GTT even though usage is
> below the corresponding low/min limit, if other applications filled VRAM
> with their allocations first.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c       | 75 ++++++++++++++++++++++++++++++++++----
>   drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++-------
>   include/drm/ttm/ttm_resource.h     |  6 ++-
>   3 files changed, 108 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 829d994798835..bd467c965e1bc 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -490,8 +490,12 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
>   }
>   
>   struct ttm_bo_alloc_state {
> +	/** @charge_pool: The memory pool the resource is charged to */
> +	struct dmem_cgroup_pool_state *charge_pool;
>   	/** @limit_pool: Which pool limit we should test against */
>   	struct dmem_cgroup_pool_state *limit_pool;
> +	/** @only_evict_unprotected: If eviction should be restricted to unprotected BOs */
> +	bool only_evict_unprotected;
>   };
>   
>   /**
> @@ -546,7 +550,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   	evict_walk->evicted++;
>   	if (evict_walk->res)
>   		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +					  evict_walk->res, evict_walk->alloc_state->charge_pool);
>   	if (lret == 0)
>   		return 1;
>   out:
> @@ -589,7 +593,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   
>   	/* One more attempt if we hit low limit? */
> -	if (!lret && evict_walk.hit_low) {
> +	if (!lret && evict_walk.hit_low && !state->only_evict_unprotected) {
>   		evict_walk.try_low = true;
>   		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   	}
> @@ -610,7 +614,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	} while (!lret && evict_walk.evicted);
>   
>   	/* We hit the low limit? Try once more */
> -	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
> +	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
> +			!state->only_evict_unprotected) {
>   		evict_walk.try_low = true;
>   		goto retry;
>   	}
> @@ -719,20 +724,72 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   				 struct ttm_resource **res,
>   				 struct ttm_bo_alloc_state *alloc_state)
>   {
> -	bool may_evict;
> +	bool may_evict, below_low = false;

No need to init below_low.

>   	int ret;
>   
>   	may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
> +	ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
> +				      force_space ? &alloc_state->limit_pool : NULL);
> +	if (ret) {
> +		/*
> +		 * -EAGAIN means the charge failed, which we treat like an
> +		 * allocation failure. Therefore, return an error code indicating
> +		 * the allocation failed - either -EBUSY if the allocation should
> +		 * be retried with eviction, or -ENOSPC if there should be no second
> +		 * attempt.
> +		 */
> +		if (ret == -EAGAIN)
> +			ret = may_evict ? -EBUSY : -ENOSPC;
> +		return ret;
> +	}
>   
> -	ret = ttm_resource_alloc(bo, place, res,
> -				 force_space ? &alloc_state->limit_pool : NULL);
> +	/*
> +	 * cgroup protection plays a special role in eviction.
> +	 * Conceptually, protection of memory via the dmem cgroup controller
> +	 * entitles the protected cgroup to use a certain amount of memory.
> +	 * There are two types of protection - the 'low' limit is a
> +	 * "best-effort" protection, whereas the 'min' limit provides a hard
> +	 * guarantee that memory within the cgroup's allowance will not be
> +	 * evicted under any circumstance.
> +	 *
> +	 * To faithfully model this concept in TTM, we also need to take cgroup
> +	 * protection into account when allocating. When allocation in one
> +	 * place fails, TTM will default to trying other places first before
> +	 * evicting.
> +	 * If the allocation is covered by dmem cgroup protection, however,
> +	 * this prevents the allocation from using the memory it is "entitled"
> +	 * to. To make sure unprotected allocations cannot push new protected
> +	 * allocations out of places they are "entitled" to use, we should
> +	 * evict buffers not covered by any cgroup protection, if this
> +	 * allocation is covered by cgroup protection.
> +	 *
> +	 * Buffers covered by 'min' protection are a special case - the 'min'
> +	 * limit is a stronger guarantee than 'low', and thus buffers protected
> +	 * by 'low' but not 'min' should also be considered for eviction.
> +	 * Buffers protected by 'min' will never be considered for eviction
> +	 * anyway, so the regular eviction path should be triggered here.
> +	 * Buffers protected by 'low' but not 'min' will take a special
> +	 * eviction path that only evicts buffers covered by neither 'low' or
> +	 * 'min' protections.
> +	 */
> +	may_evict |= dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
> +	below_low = dmem_cgroup_below_low(NULL, alloc_state->charge_pool);

Are these some magic macros? Couldn't grep for them.

> +	alloc_state->only_evict_unprotected = !may_evict && below_low;
 > +> +	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>   
>   	if (ret) {
> -		if ((ret == -ENOSPC || ret == -EAGAIN) && may_evict)
> +		if ((ret == -ENOSPC || ret == -EAGAIN) &&
> +				(may_evict || below_low))
>   			ret = -EBUSY;
>   		return ret;

Where does the uncharge happen on the failure path?

Regards,

Tvrtko

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
> @@ -787,6 +844,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				res, &alloc_state);
>   
>   		if (ret == -ENOSPC) {
> +			dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			continue;
>   		} else if (ret == -EBUSY) {
> @@ -796,11 +854,14 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   
>   			if (ret) {
> +				dmem_cgroup_pool_state_put(
> +						alloc_state.charge_pool);
>   				if (ret != -ENOSPC && ret != -EBUSY)
>   					return ret;
>   				continue;
>   			}
>   		} else if (ret) {
> +			dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			return ret;
>   		}
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
> index e2c82ad07eb44..fcfa8b51b0337 100644
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
> @@ -372,30 +372,52 @@ void ttm_resource_fini(struct ttm_resource_manager *man,
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
> index e52bba15012f7..3aef7efdd7cfb 100644
> --- a/include/drm/ttm/ttm_resource.h
> +++ b/include/drm/ttm/ttm_resource.h
> @@ -442,10 +442,14 @@ void ttm_resource_init(struct ttm_buffer_object *bo,
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


