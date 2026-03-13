Return-Path: <cgroups+bounces-14807-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE54I8QItGlvfwAAu9opvQ
	(envelope-from <cgroups+bounces-14807-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 13:53:24 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83F283444
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 13:53:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBD4C302FB9F
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7A237F8B2;
	Fri, 13 Mar 2026 12:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="A/3qlpc3"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1342637F745
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773406388; cv=none; b=ip8kJMCw0Uhiz12FWos5oKJhO7wPNpgPbDDerD4tw9Xuad283/gBAPwhS2qY1lr1rC7+lQEonQgWjnlppdoRdPi78OBrLRvKXl0LgMCPBV6/B5ICdFmikhe5P8kIKKoK0CviZKg1D6pdzyXkdr1XSUnXi34sPMDsXAOQClA1nGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773406388; c=relaxed/simple;
	bh=cBYFhSp9O3onnpDfaReQLPovlsT58jUabhGyPq/FR7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKAENip3YtWEvHLpJE3KkiD38nmn6QUkHGHLRaCUxMMDfrjVtfDfZoeKou+eCTXCxt7Cxig6NGhFU45PnLQgWoj2mw09U3tM9lHgSN111MvjhTpMhyC/CKfYFSsfHus2dlELzvZyxe9dffpfpxL1j8V6qNXsEJ1SGpVRkUtcvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=A/3qlpc3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48535a0ef86so17900615e9.1
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 05:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1773406384; x=1774011184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUAXZOch+j8GBQV9ng35Tf6PnvC1xmx52FcG64eQxFc=;
        b=A/3qlpc3LR283Fb3bXPdq2bNYwf4XgJSmZbn4+/oUclcTlvWHE4gHy0NyNkCZA38iw
         dxeHPwmB0gI8/Kvq0W7yTHNC+ii4SmpW4muoFJtZwV2QR0cKw5prfoXx3eNePnNgsCOZ
         XL8B+JTtyvJu8yeKhO3j4MxeQwr313K8+fBjZtbQ98vz6P0xbONxRu8U7jMqXf/AzHQC
         3+o2k2MgG7rfOwUNSfxEhwe+QCaDwIVREOaWTL1eI3+XkskFcgh7Cj21mbqW430W9BG+
         PdBUfzeIBaH9l57PKY9lWWCnvLp2lE/MCOGYfJZNI0XPn8djR4P8tD3b0ZzrW/YG2zL5
         gOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773406384; x=1774011184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUAXZOch+j8GBQV9ng35Tf6PnvC1xmx52FcG64eQxFc=;
        b=bEnP34LJALJh6Lewzghe5TNfdJy869sXSsyQPRnkowdoiJie4LO+Z13ocrp79AdjgN
         nU1g1Mp2AXqsDztCY+KP7h+TOChjuG4j1bFwFxxhKKzNB31ZaBp7jIcty6l8FrAq7ehQ
         imclseWlz3YkhB2vb6slAQy6oUKi4RYNFh71GZR8H8QeUpUSMSadQ+yle7hfCBQZ4GsP
         aeHo5wU7e4/EBrCoBMGjvbpvLcQpzkb9QUWSI+kDibCbRgKsORz462ktGoBh5+R20lG5
         gl6nlGyHAHE1bIPGAsHwOwmAKk8SlizCiIy9LdJR+XcUW8FagVb4pPJJV84OCv0JWQ71
         nWBw==
X-Gm-Message-State: AOJu0YyJcIm+36Ka1lZukXObvv9hbmXyzNFPmgoIrHY/X/IYROgC1Ilz
	TtlBl3h8vttBqSH5WS0aGeUUFYh3+iU6M/+lczT46GIMdMoWc+iBFs9GPLK1DHLFXdM=
X-Gm-Gg: ATEYQzwxNgUBl0OKbVdRUR8quGHg1xlsNEFR1E8WYwDorERJj0zKGoWBjcmdW5X91qA
	z7QCK+iA5xcbuZ5EKkaW6iFwS52+ZER4D4ZJ3NZpd3wu8KHZ2JGkcHsxe6f21djzBY8Z7+ER9AM
	PAUausF3fhLvz91zC0kWhBDksUTLOZ7a8l387sJeeA7GmV7NbYxGaB395QZrQS6IqXxHsmbuoyg
	5sERi93wRNy6mNM+9nETWMKiOBZeOIlnrCj4WXPAVSLk9QtDdeK9DQLRJ4ru75VI1kmBHt7hjhm
	9FWxvrTXe346hRVu84XJkRtLl/4AAGEA04+DUc9szyVFM6nvijEALsqqQIHsCg1P7ii5qmpKq69
	bqZz5Q00L/psd5PUz8CbPs+xVEomgHnJUajQUgZ4D9B9v9nVjbrMFOMoxGbVfaqkawDox0k0nwc
	SCUbYEnoDEJ9xjd7OCs9XCgwTVI+sR/UlGCKsPwP3q2/K1
X-Received: by 2002:a05:600c:4e15:b0:485:3f1c:d887 with SMTP id 5b1f17b1804b1-4855670e6e8mr48910125e9.26.1773406383716;
        Fri, 13 Mar 2026 05:53:03 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm19741899f8f.34.2026.03.13.05.53.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 05:53:03 -0700 (PDT)
Message-ID: <fd77dce5-39f9-446e-b78e-3304ca3de4ac@ursulin.net>
Date: Fri, 13 Mar 2026 12:53:02 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] drm/ttm: Split cgroup charge and resource
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
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-4-7c71cc1492db@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-4-7c71cc1492db@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14807-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gmx.de:email,ursulin.net:dkim,ursulin.net:mid]
X-Rspamd-Queue-Id: 8F83F283444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13/03/2026 11:40, Natalie Vock wrote:
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
>   drivers/gpu/drm/ttm/ttm_bo.c       | 66 ++++++++++++++++++++++++++------------
>   drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++--------
>   include/drm/ttm/ttm_resource.h     |  6 +++-
>   3 files changed, 85 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 5cca0d6edbaf6..4adc9b80cba4a 100644
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
> +	/** @in_evict: Whether we are currently evicting buffers */
> +	bool in_evict;
>   };
>   
>   /**
> @@ -520,28 +524,39 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   	bool may_evict;
>   	int ret;
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
>   	if (ret) {
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
> @@ -596,8 +611,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   
>   	evict_walk->evicted++;
>   	if (evict_walk->res)
> -		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +		lret = ttm_bo_alloc_at_place(evict_walk->evictor, evict_walk->place,
> +					     walk->arg.ctx, false, evict_walk->res,
> +					     evict_walk->alloc_state);

Oh I am glad this worked out. I will not go as far to say TTM eviction 
logic is now easy to follow but at least the new state machine logic is 
consolidated. Anyway, I went back and forth many many times and it all 
looks good to me.

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Btw have you looked at the TTM kunit tests? Does any cover the new paths 
or it would make sense to add some coverage with this series, or as a 
follow up?

Regards,

Tvrtko

>   	if (lret == 0)
>   		return 1;
>   out:
> @@ -636,6 +652,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	};
>   	s64 lret;
>   
> +	state->in_evict = true;
> +
>   	evict_walk.walk.arg.trylock_only = true;
>   	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   
> @@ -666,6 +684,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   		goto retry;
>   	}
>   out:
> +	state->in_evict = false;
>   	if (lret < 0)
>   		return lret;
>   	if (lret == 0)
> @@ -798,6 +817,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				res, &alloc_state);
>   
>   		if (ret == -ENOSPC) {
> +			dmem_cgroup_uncharge(alloc_state.charge_pool, bo->base.size);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			continue;
>   		} else if (ret == -EBUSY) {
> @@ -806,11 +826,15 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   
> -			if (ret == -EBUSY)
> -				continue;
> -			else if (ret)
> +			if (ret) {
> +				dmem_cgroup_uncharge(alloc_state.charge_pool,
> +						bo->base.size);
> +				if (ret == -EBUSY)
> +					continue;
>   				return ret;
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


