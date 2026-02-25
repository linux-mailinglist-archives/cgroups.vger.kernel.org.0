Return-Path: <cgroups+bounces-14368-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJbnKNMVn2nWYwQAu9opvQ
	(envelope-from <cgroups+bounces-14368-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:31:31 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B891999FE
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C0B3101099
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 15:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4F36C0C6;
	Wed, 25 Feb 2026 15:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="QCF76hYS"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E23161BF
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032735; cv=none; b=OW2/EghXssk3f7qmlmmzc9Gjili2Aeaq9Lk5umNyMfQm+P4WpGOETFgP46v3oXXSGLD69vaoLfcLGEb3Q+MVHR5hqJc6QWsxzyGrgabSKM3aUZSFgrPNkzJbOkkw4a3v9iGduLlgrwmr/Kcsp7U3YWy75hG/XMESNpqbgnkGmDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032735; c=relaxed/simple;
	bh=qsttKbpdMEUkjX5I8ZL7nD75w7r30zc4LM9jUzVcT40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qp6IQENO8aS+OJVpvYpUiKumfDX4Z6MDsE6aKtuQaElcth11Clny7n3F0SrNwpWuGmzdH8K7FHRTJ+E7qGZDVsRTHaF8nxBblWYGY1dziVvRUDw1NZTcKfiU+EU0GJVvH6cdjsPTs3wRdTQQAHKfExBpI76y4U/28oqotW4WUkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=QCF76hYS; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-483bd7354efso15345265e9.2
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772032732; x=1772637532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0duHEWtI6kL/XWFNZl4sr8GMAyb2xz6UvQc7MNO8wek=;
        b=QCF76hYSRcmZj3RqkdRz+X5ALNp1FWXb+yqtogmSKlQnOA6f/XFZYc6NMEqoHM3mVo
         rCQ5lz0vZMenjB9ko/jobKeYTeJpArIi6tFMN9FgGC0BtLVam1TKyYxEbXyMLm0MIQwA
         wd6K9yTpS34WhlLyd+pB9mow+35Yl6hzcFVvPOs5Lhr3iQ+vCLZltEOu+Yyjc0ys+IS9
         ySqYkrmDtd8XiBFmuq7AOu20pLpENpa/V2B+3KJSHm+QsoHe0/gMu2eYpRS1ncFiPLZ1
         ppPR/eOyVR4v0IMQO4Cyh1TAJcx6olkoC985OjvgWUwl9oDevWoTTOYZYyFLbSuaQcES
         ViPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772032732; x=1772637532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0duHEWtI6kL/XWFNZl4sr8GMAyb2xz6UvQc7MNO8wek=;
        b=Q0sjq6zWvDmpWxCHgnEZUqrsmPcliGo3V850JCcd9L+THYPa+8PR4Np1RQZR56ktJN
         A5WY+qvZvtSFzX5NRs12iZef6wQ2Pya39b3q4ysxKS6Oz5Wycz94rASV4AIOWQvKsIaQ
         JONU7GidGDkETGzSy0BBnRFewM9cVlr5jRWXaL4d8M0TeLa9E2LHtqv9+qs+u1at+yjl
         ech17VN0JIe7j6mMxrOcLwS8DJDvfuXbAUpp0TRiyJa7Z+rof1EKOOuXcxYxz3ZFFq8Z
         8NZ5pVIBgLV8zSCzTJ+fs9DpaWcr7mgeFpkt9uQUqPny4zPT+QZVCcYqWsKWh7S7W9mY
         lTjA==
X-Gm-Message-State: AOJu0YyuZPHB+VxilzvQU5nxrCAytMtUvY+ScucCUOdO84xGXRr/VcFX
	Nz3zeEycUj1PGKKN5jLMKPcYyywsM6ydB17VyVM3JGREie8RwMJBFZcMmPs3QmOVqdI=
X-Gm-Gg: ATEYQzwZ5PJ1yNpN78hvFMY1U1FWf9OigD+jeg3S5IvuHR8EJEcaY2QoCiDatDfJJT+
	PnWeyPYNJN7Ae8qeCDJPspIiIEtWF5X3+jrM/GHuRxff9rOYL9GB7gDezXA7GobNNACdoVBFphe
	e0kb5qEoRqAmaugdUum8jX9X5mqEyuPfYoqdgIvuSs3pMxjNZxQqOAvyIgcrHLwP81QP/0cUUyH
	k6MJuRRfWx5rzFehSr8nIgWOjlucurOTM7LQ+H88+HwoMU3etZSvoDYuxuy6nljz+OtknoeWWdP
	YhvQKSN3HKQa1wDV6yKoQLl+xUS+MtiO70Mw3k0IzhzCfc/cJKNOf8brcjABpI3wo+xAk39Zv8n
	GYVHLfccuhDjg5EFFHX23U89BxYVynyDBihULT3q6qDEIot9+ILeKuEEFwKif6QAsKnrJLNddt0
	W3m+xkFHckKlLVvJRaJyhGUyMQc4phSm+ebeO49H7a7d6y
X-Received: by 2002:a05:600c:6815:b0:47e:e946:3a72 with SMTP id 5b1f17b1804b1-483c21a10c5mr13759935e9.27.1772032731307;
        Wed, 25 Feb 2026 07:18:51 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd739087sm74940165e9.14.2026.02.25.07.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 07:18:48 -0800 (PST)
Message-ID: <8c3db886-72d1-49c1-ac6c-7640af735e51@ursulin.net>
Date: Wed, 25 Feb 2026 15:18:47 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/ttm: Extract code for attempting allocation in
 a place
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
References: <20260225-dmemcg-aggressive-protect-v4-0-de847ab35184@gmx.de>
 <20260225-dmemcg-aggressive-protect-v4-3-de847ab35184@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260225-dmemcg-aggressive-protect-v4-3-de847ab35184@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14368-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email,igalia.com:email]
X-Rspamd-Queue-Id: 06B891999FE
X-Rspamd-Action: no action


On 25/02/2026 12:10, Natalie Vock wrote:
> Move all code for attempting allocation for a specific place to
> ttm_bo_alloc_place. With subsequent patches, this logic is going to get
> more complicated, so it helps readability to have this separate.
> 
> ttm_bo_alloc_at_place takes a pointer to a struct ttm_bo_alloc_state.
> This struct holds various state produced by the allocation (e.g. cgroup
> resource associated with the allocation) that the caller needs to keep
> track of (and potentially dispose of). This is just the limiting cgroup
> pool for now, but future patches will add more state needing to be tracked.
> 
> ttm_bo_alloc_at_place also communicates via return codes if eviction
> using ttm_bo_evict_alloc should be attempted. This is preparation for
> attempting eviction in more cases than just force_space being set.
> 
> No functional change intended.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 109 +++++++++++++++++++++++++++++++++----------
>   1 file changed, 84 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index acb9197db8798..48dbaaa46824c 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -489,6 +489,11 @@ int ttm_bo_evict_first(struct ttm_device *bdev, struct ttm_resource_manager *man
>   	return ret;
>   }
>   
> +struct ttm_bo_alloc_state {
> +	/** @limit_pool: Which pool limit we should test against */
> +	struct dmem_cgroup_pool_state *limit_pool;
> +};
> +
>   /**
>    * struct ttm_bo_evict_walk - Parameters for the evict walk.
>    */
> @@ -504,12 +509,13 @@ struct ttm_bo_evict_walk {
>   	/** @evicted: Number of successful evictions. */
>   	unsigned long evicted;
>   
> -	/** @limit_pool: Which pool limit we should test against */
> -	struct dmem_cgroup_pool_state *limit_pool;
>   	/** @try_low: Whether we should attempt to evict BO's with low watermark threshold */
>   	bool try_low;
>   	/** @hit_low: If we cannot evict a bo when @try_low is false (first pass) */
>   	bool hit_low;
> +
> +	/** @alloc_state: State associated with the allocation attempt. */
> +	struct ttm_bo_alloc_state *alloc_state;
>   };
>   
>   static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
> @@ -518,8 +524,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   		container_of(walk, typeof(*evict_walk), walk);
>   	s64 lret;
>   
> -	if (!dmem_cgroup_state_evict_valuable(evict_walk->limit_pool, bo->resource->css,
> -					      evict_walk->try_low, &evict_walk->hit_low))
> +	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_pool,
> +					      bo->resource->css, evict_walk->try_low,
> +					      &evict_walk->hit_low))
>   		return 0;
>   
>   	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
> @@ -561,7 +568,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   			      struct ttm_operation_ctx *ctx,
>   			      struct ww_acquire_ctx *ticket,
>   			      struct ttm_resource **res,
> -			      struct dmem_cgroup_pool_state *limit_pool)
> +			      struct ttm_bo_alloc_state *state)
>   {
>   	struct ttm_bo_evict_walk evict_walk = {
>   		.walk = {
> @@ -574,7 +581,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   		.place = place,
>   		.evictor = evictor,
>   		.res = res,
> -		.limit_pool = limit_pool,
> +		.alloc_state = state,
>   	};
>   	s64 lret;
>   
> @@ -689,6 +696,58 @@ static int ttm_bo_add_pipelined_eviction_fences(struct ttm_buffer_object *bo,
>   	return dma_resv_reserve_fences(bo->base.resv, 1);
>   }
>   
> +
> +/**
> + * ttm_bo_alloc_at_place - Attempt allocating a BO's backing store in a place
> + *
> + * @bo: The buffer to allocate the backing store of
> + * @place: The place to attempt allocation in
> + * @ctx: ttm_operation_ctx associated with this allocation
> + * @force_space: If we should evict buffers to force space
> + * @res: On allocation success, the resulting struct ttm_resource.
> + * @alloc_state: Object holding allocation state such as charged cgroups.
> + *
> + * Returns:
> + * -EBUSY: No space available, but allocation should be retried with ttm_bo_evict_alloc.
> + * -ENOSPC: No space available, allocation should not be retried.
> + * -ERESTARTSYS: An interruptible sleep was interrupted by a signal.
> + *
> + */
> +static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
> +				 const struct ttm_place *place,
> +				 struct ttm_operation_ctx *ctx,
> +				 bool force_space,
> +				 struct ttm_resource **res,
> +				 struct ttm_bo_alloc_state *alloc_state)
> +{
> +	bool may_evict;
> +	int ret;
> +
> +	may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
> +
> +	ret = ttm_resource_alloc(bo, place, res,
> +				 force_space ? &alloc_state->limit_pool : NULL);
> +
> +	if (ret) {
> +		/*
> +		 * -EAGAIN means the charge failed, which we treat like an
> +		 * allocation failure. Therefore, return an error code indicating
> +		 * the allocation failed - either -EBUSY if the allocation should
> +		 * be retried with eviction, or -ENOSPC if there should be no second
> +		 * attempt.
> +		 */
> +		if (ret == -EAGAIN)
> +			return may_evict ? -EBUSY : -ENOSPC;
> +
> +		if (ret == -ENOSPC && may_evict)
> +			return -EBUSY;
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * ttm_bo_alloc_resource - Allocate backing store for a BO
>    *
> @@ -714,7 +773,9 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				 bool force_space,
>   				 struct ttm_resource **res)
>   {
> +	struct ttm_bo_alloc_state alloc_state = {0};

= {};

>   	struct ttm_device *bdev = bo->bdev;
> +	struct ttm_resource_manager *man;

I don't mind if you pull the above two out of the loop too much, but I 
have to re-point it out since I am sure you know the principle of not 
making changes which are not strictly needed, especially if they are not 
a clear win on readability or something.

>   	struct ww_acquire_ctx *ticket;
>   	int i, ret;
>   
> @@ -725,9 +786,6 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   
>   	for (i = 0; i < placement->num_placement; ++i) {
>   		const struct ttm_place *place = &placement->placement[i];
> -		struct dmem_cgroup_pool_state *limit_pool = NULL;
> -		struct ttm_resource_manager *man;
> -		bool may_evict;
>   
>   		man = ttm_manager_type(bdev, place->mem_type);
>   		if (!man || !ttm_resource_manager_used(man))
> @@ -737,25 +795,26 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				    TTM_PL_FLAG_FALLBACK))
>   			continue;
>   
> -		may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
> -		ret = ttm_resource_alloc(bo, place, res, force_space ? &limit_pool : NULL);
> -		if (ret) {
> -			if (ret != -ENOSPC && ret != -EAGAIN) {
> -				dmem_cgroup_pool_state_put(limit_pool);
> -				return ret;
> -			}
> -			if (!may_evict) {
> -				dmem_cgroup_pool_state_put(limit_pool);
> -				continue;
> -			}
> +		ret = ttm_bo_alloc_at_place(bo, place, ctx, force_space,
> +				res, &alloc_state);
>   
> +		if (ret == -ENOSPC) {
> +			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
> +			continue;
> +		} else if (ret == -EBUSY) {
>   			ret = ttm_bo_evict_alloc(bdev, man, place, bo, ctx,
> -						 ticket, res, limit_pool);
> -			dmem_cgroup_pool_state_put(limit_pool);
> -			if (ret == -EBUSY)
> +						 ticket, res, &alloc_state);
> +
> +			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
> +
> +			if (ret) {
> +				if (ret != -EBUSY)
> +					return ret;
>   				continue;
> -			if (ret)
> -				return ret;
> +			}

Would keeping the ret checks at one level of indentation look better? Eg 
like the current version:

if (ret == -EBUSY)
	continue;
else if (ret)
	return ret;

Up to you.

Btw, it is an interesting design that there are eviction errors which 
prevent trying the next placement. A bit surprising to me but it is out 
of scope here.

Anyway, I went back and forth a few times over the logic and it indeed 
looks to me that there are no functional changes. Thanks for improving 
the commit message as well, now it is completely clear what the patch is 
about. With or without the nitpicks:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +		} else if (ret) {
> +			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
> +			return ret;
>   		}
>   
>   		ret = ttm_bo_add_pipelined_eviction_fences(bo, man, ctx->no_wait_gpu);
> 


