Return-Path: <cgroups+bounces-14222-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDg1Kq/NnWnfSAQAu9opvQ
	(envelope-from <cgroups+bounces-14222-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 17:11:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 273FF189990
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 17:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1133030120
	for <lists+cgroups@lfdr.de>; Tue, 24 Feb 2026 16:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E539B4AD;
	Tue, 24 Feb 2026 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="MGNRQgzY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECD3783A0
	for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771949352; cv=none; b=VYh9ZdVzGmUihfBF9QJsSpWD3hSSkvFlOOHmBncmVOGWcUIInCm/sL6BWL+hgS3NicZJMCS5kWPsdTuXyEDJJfBtY9bf3NLDAZ+qoGHOiGl0e6BF0vDYjhIrxy1XI5oetlZyiidJJNnH9fHPrYqr5tXeaPMiFoXMIXWa6Bi8+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771949352; c=relaxed/simple;
	bh=gcOVIWxso//u5STCAsSUyqcj9HENSM+7z2h4r2LOA9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LqqrdJ2wqUsM8WnNiScPBcoTmpCEqBDy4jljoFC97PrXXxUf1qLmBUzMN8CT4Cg6NcxPFYY0YvvmNwMdKLvrAtAlPKL7pHEvAwAkWlUHD+mZa+rsby6rcYayIH5Wai3BD67WOevWXYBFyS97vaKvN8D+Ebhcfoq5l3lTDbQtgkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=MGNRQgzY; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4836f4cbe0bso43401835e9.3
        for <cgroups@vger.kernel.org>; Tue, 24 Feb 2026 08:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1771949349; x=1772554149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xEMwUsFe80O7FQT2pky6cbdem5vVaUv5gBoDleT5nkE=;
        b=MGNRQgzYtkzjDr8D+7g8YRa0PeV/wIQ7ERCL9kKDNlzQ0xCNDBXttHrWpx1FGNbTj+
         WVLrUFexv9Ng4cOpb1/Oq4+6eWx0AG8Kc3PfsTuE9rPR8o7cnfal9LpehmwwQJL0W5UY
         lHDt4DaKOsxKviZwSaXp7Y8cGL1jeXuRwG42mo1oQ+qlKCp0XEUKmzNw7EQ+gne7yaSK
         X8iFuGrckHrxnSMh8YsX+23blVnZcDgWcwrpdVjCGUbWVQ9oTS3T6m2U0aC7OhYjiY62
         N8t+Hp1rHg03iXLdlAdZ7zFjxfaegaym6GCh88beJDmDeYgFhSpdG+Ejb+JL3eOToXzt
         zGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771949349; x=1772554149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEMwUsFe80O7FQT2pky6cbdem5vVaUv5gBoDleT5nkE=;
        b=unlWyUW6XjemKcgTYnBjy7l9yp90pwvbaEIUYUlalgo+osXc3ZgCd+THVNjFB3eLfJ
         1fnZy5gB7dmnwuyR1+LrXR1UkOAlbXcVr/3DRaGhq9T96QxheXk0W6BfW3/GApMa4QS0
         mkELOui0r93HJRIsgq345UipU0Ktjcp0GqL9gd5eRmyU2158kabqf2g+oCnqUlhty7fV
         10XqGBYd7ZN1xjmSYMiim98ZCEI40RHFgAIH1mnaN8Ew6eXh89zf6TlVCW7nmG1GB1LF
         BUGfJV6b6+fGoxXiuSKVLCPkE6SYgCHvCBnoRIfOiIKQMFnto9hWYG42HBCyZGH+WFJF
         Q4Gg==
X-Gm-Message-State: AOJu0Yx4fVu/zcoNWEcgyG9+ME+FBwQpxHRB7IlidBLoNnMG/ehao42E
	3f344kwepPMgjEfrP/DrzMBHDrSpOY7YB2bkV14i7/NYzSnxKoqRd14FvHylIunLeQ0=
X-Gm-Gg: AZuq6aLOYUxzY59OEtMCGr2u5kKHVs5yF0rOEodL+JRLrlOIsR+/oRW0khgIAaU38Uv
	VV1qmAC9ORoxDB3qK7w1yqY57Eq9S2l/wiURqfMx0N14zNpPBb2MpGekRaQEpyQPQ3PKLHAGseU
	tahM6aB1mkQtNX4I/AoaVPKTN3rREGQZxQLPgk0NF3P0NqPTfPEAi68kwzwtn6GsJtiAC/gqBQ3
	uOi1cQdT5RBbeF6museuJmZgl/W5aRNGfEhDxnd+em0xITJIcFWzuvrRMkJXqKyvrDJM/92RD21
	gtxH4TxK2VG84Tu+Cx0XM1Q6nUx2Xi46/JQULTXMaWU02BROgysekSYm3Yts+nuPWj7xW31/AZI
	iGFJ0l0130YM3/cDxObyAlDzifkM2s0kezjNtiHsciOuSYFJTEPc9liue7KVs5zavs53/lyC44h
	EgmeZKs5zRS9qJy7XWgkgWn44Qe4KNqtHQk2EUr+yKGFyB
X-Received: by 2002:a05:600c:c4a5:b0:483:7783:5382 with SMTP id 5b1f17b1804b1-483a95e6b64mr191933505e9.27.1771949348294;
        Tue, 24 Feb 2026 08:09:08 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm7650265e9.14.2026.02.24.08.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 08:09:07 -0800 (PST)
Message-ID: <3e820754-681c-4def-8e70-e1b88ed092e5@ursulin.net>
Date: Tue, 24 Feb 2026 16:09:07 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/ttm: Make a helper for attempting allocation
 in a place
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
 <20251110-dmemcg-aggressive-protect-v3-3-219ffcfc54e9@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20251110-dmemcg-aggressive-protect-v3-3-219ffcfc54e9@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14222-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ursulin.net:mid,ursulin.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 273FF189990
X-Rspamd-Action: no action


On 10/11/2025 12:37, Natalie Vock wrote:
> ttm_bo_alloc_place is a new helper function to make an attempt at
> allocating a bo's resource in a specific place. It also makes decisions
> on whether eviction should be attempted: If -ENOSPC is returned,
> allocation should not be retried.

At first I thought the new helper will get used from more than one call 
site but it seems that is not the case? No objections to extract some 
code to be clear, just that when I see a patch title of "making a 
helper" I expect something different.

Is there any functional difference here or it is just prep to enable 
easier extending in the following patch? If no functional difference it 
is good to state that in the commit message. If functional difference 
please explain what and why.

Also please explain that the patch is only adding a new struct parameter 
as a preparation for it being extended.

> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 98 +++++++++++++++++++++++++++++++++-----------
>   1 file changed, 73 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index f4d9e68b21e70..829d994798835 100644
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
> +	/** @alloc_state: */
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
> @@ -688,6 +695,47 @@ static int ttm_bo_add_move_fence(struct ttm_buffer_object *bo,
>   	return ret;
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
> + * -EBUSY: No space available, but allocation should be retried with eviction.

With or after eviction?

> + * -ENOSPC: No space available, allocation should not be retried.
> + * -ERESTARTSYS: An interruptible sleep was interrupted by a signal.

-EAGAIN cannot get out from ttm_resource_alloc()? In the current 
codebase or only with this patch?

> + *
> + */
> +static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
> +				 const struct ttm_place *place,
> +				 struct ttm_operation_ctx *ctx,
> +				 bool force_space,
> +				 struct ttm_resource **res,
> +				 struct ttm_bo_alloc_state *alloc_state)

Maybe you did not write this but I am curious and thinking out loud 
here. The documentation for struct ttm_operation_ctx among other things 
says:

"""
  * Context for TTM operations like changing buffer placement or general 
memory
  * allocation.
"""

Hence I am wondering if the new alloc_state couldn't simply go in there? 
Which would make the function prototype identical to the existing 
ttm_bo_alloc_resource and is also already passed through the relevant 
call chains. Which raises another question - why did 
ttm_bo_evict_alloc() need to have struct dmem_cgroup_pool_state as a 
separate argument and why it couldn't be passed in the context?

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
> +		if ((ret == -ENOSPC || ret == -EAGAIN) && may_evict)
> +			ret = -EBUSY;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /**
>    * ttm_bo_alloc_resource - Allocate backing store for a BO
>    *
> @@ -713,7 +761,9 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				 bool force_space,
>   				 struct ttm_resource **res)
>   {
> +	struct ttm_bo_alloc_state alloc_state = {0};

= {}; is usually enough.

Any particular reason to move this and the manager outside of the loop?

>   	struct ttm_device *bdev = bo->bdev;
> +	struct ttm_resource_manager *man;
>   	struct ww_acquire_ctx *ticket;
>   	int i, ret;
>   
> @@ -724,9 +774,6 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   
>   	for (i = 0; i < placement->num_placement; ++i) {
>   		const struct ttm_place *place = &placement->placement[i];
> -		struct dmem_cgroup_pool_state *limit_pool = NULL;
> -		struct ttm_resource_manager *man;
> -		bool may_evict;
>   
>   		man = ttm_manager_type(bdev, place->mem_type);
>   		if (!man || !ttm_resource_manager_used(man))
> @@ -736,25 +783,26 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
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

I always disliked the TTM eviction logic and now I remember why. It 
requires a brain size of a small planet to figure out the flow.. :) I'd 
say this change makes it more readable.

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
> +				if (ret != -ENOSPC && ret != -EBUSY)
> +					return ret;
>   				continue;

Is this a functional change and why? Before only EBUSY went to the next 
placement. Now ENOSPC does as well.

Regards,

Tvrtko

> -			if (ret)
> -				return ret;
> +			}
> +		} else if (ret) {
> +			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
> +			return ret;
>   		}
>   
>   		ret = ttm_bo_add_move_fence(bo, man, ctx->no_wait_gpu);
> 


