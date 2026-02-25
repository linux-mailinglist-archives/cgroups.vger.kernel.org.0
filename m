Return-Path: <cgroups+bounces-14370-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPcZJpwXn2n/YwQAu9opvQ
	(envelope-from <cgroups+bounces-14370-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:39:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FFE199CA1
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2BB4308108B
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7E212566;
	Wed, 25 Feb 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="tJyOWKr0"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0726E3D6684
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772033641; cv=none; b=f/+0/KYvSlXyNXx3erzUe7fH0tghqlw3uCtahdx0hu4SS7rfN//CageBNNL6238mPd+tZ5iwtt4sjQEDhM6lz91f5kFeYjbAeh7BsgvBjjZS0IC+h6hSokIpBmUTAsOWV7fjRVsfaWMdn6PKcWp/V5xieA9tPUGuB7sOrT0ZAoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772033641; c=relaxed/simple;
	bh=jXtfesAX2htllnCwF22Rl8f+k4wJsQF0zSk2/q/e7sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcLeJYamFTk5rH1vofTA1fw/HVrYytkhZ1Ml6ArexMt7FJ//TCdSU8AF1XFcHSvwVWsCPdxTi1DBtPjr0/yH2mH/gAypobYLkKhLEm/wIZbytEHdOQ28855ZtspshhrPhGq3s8IYtNLP7u7LSzxr+k2j9ValJQPdEwUoXCATCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=tJyOWKr0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4398c7083d7so1384123f8f.3
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 07:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772033637; x=1772638437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRoBJ5wBmIwmVhoK9FjJRI7xDRFw7wcPEg9WE+yquRI=;
        b=tJyOWKr0XDXqVhCgmN1x9xjNefuclZt4/UJP5WhghNw24NeTVvCPT5X2XV503IFSkU
         +ZHera0j4zW3TxPai7HlM6rm4PV8RqIuJdoaPnCO0B0HaYIJk+lXde6L3BPULCTEsaKh
         pJoTT2xekFWJQVA1BPi+fDdX/kiCWbCwZqpqxgDXZoLTNMJ27GtqNjC6tE2i4qNQ9+bU
         pJ5/g8zS3KEl6oksQFqv+vERk32LlxJtvFvonT5mkRyAQD1N0iD8DyrNPeNYySRLaIOk
         rpyILOLwTd2Y/AKHKJGH5g3rUlFzsigFPBp9G/oCWd7N29sCsqJ1xhdSevaExx5hZ8lk
         soyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772033637; x=1772638437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cRoBJ5wBmIwmVhoK9FjJRI7xDRFw7wcPEg9WE+yquRI=;
        b=iZjM2YMVy2VuYcQXZjx29vImywkvLZYyaR0PN/ScEtgVZWaxQLJ1WVElJJYDOao9Bu
         umTu1tvHVhUBffu/E1DQojLH1dgV8DG+LegRSN2LhNOscCjQmNPTvywRlbVC9fp4d8K8
         3ceHyFirEv6Y9xlZfKRWozILQgG97hbvDrIsj/oJYMDbgyjaANLXPhxj0k5ze+30mfl9
         oLPEj16ePjnCkF7eA6Ix+xNDLcSKEOjHVy9V+dnz5iT/MDXcDQnHE9NyCcTpTAjbhjUB
         ugnsYQjJyERq3AfQK+atsnP5voDvzxLpyjBgvm4KGj46cKV3+LOgLOoppukRuLGzG7Vi
         vcHg==
X-Gm-Message-State: AOJu0YxJ0FZ0Q8XuLe87akd77ZM/CR/4xure5Wc08sRn6sXfwYAf0U6K
	iBPo2Lb88rCaDUUV1FB6SCdgMn40c7LAAraUWCm5Au0J090nkqhe3o00QE39CTMiM7c=
X-Gm-Gg: ATEYQzzTW/WdIhhh6KHLUHF5x2i8MQDs0TnNxmzpnFnxttChovqutQd5vAIbhyMnTiS
	mHwmMLP5Jd6a036NWMRcQ6eypl3YNnLro7+gd0U99VB3aRqAWpjecPyIJ/QO33uEg08fzTIhCcu
	JBpKPs12S/LM7eSyobtBib+XJtdm5y9gh0bz5PPTyDmp4grizapBTI9zdpW/IDuEaULW1Lvi/XS
	gO/FgXACyJjPHkZOLMCnNO7CqHvcduEoYlQN8C3lWTUhldpZgOv394LFbQk8rMVNdsz1AYPw71E
	mZ2zNvPXwI9ZYfjfvWjsO4bRrHNdrhmDWOnTaGqH7+WF1zc5ftOrGK9bl5t8f8vaTkPta37oa3z
	0mNhe4yvyJjA1G3n829gWz2aqf9Vmz44f0EkIuE4w0b91AvjiizL7Mx8Umm+eCwQKmJsntv5XyO
	ldaUQ6gnsvXRdM1wQhq9vh72z3OuoS1YxEbCD4QqZwx+ZVYbWLn9rQmow=
X-Received: by 2002:a05:6000:1acc:b0:439:8bb9:dae2 with SMTP id ffacd0b85a97d-4398bb9df45mr10015275f8f.4.1772033637108;
        Wed, 25 Feb 2026 07:33:57 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d4c60bsm33910443f8f.27.2026.02.25.07.33.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 07:33:56 -0800 (PST)
Message-ID: <9f726505-cce3-430a-8d16-fd9695dc4577@ursulin.net>
Date: Wed, 25 Feb 2026 15:33:55 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] drm/ttm: Split cgroup charge and resource
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
References: <20260225-dmemcg-aggressive-protect-v4-0-de847ab35184@gmx.de>
 <20260225-dmemcg-aggressive-protect-v4-4-de847ab35184@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260225-dmemcg-aggressive-protect-v4-4-de847ab35184@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14370-lists,cgroups=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gmx.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B5FFE199CA1
X-Rspamd-Action: no action


On 25/02/2026 12:10, Natalie Vock wrote:
> Coupling resource allocation and cgroup charging is racy when charging
> succeeds, but subsequent resource allocation fails. Certain eviction
> decisions are made on the basis of whether the allocating cgroup is
> protected, i.e. within its min/low limits, but with the charge being
> tied to resource allocation (and uncharged when the resource allocation
> fails), this check is done at a poin where the allocation is not actually

s/poin/point/

> charged to the cgroup.
> 
> This is subtly wrong if the allocation were to cause the cgroup to exceed
> the min/low protection, but it's even more wrong if the same cgroup tries
> allocating multiple buffers concurrently: In this case, the min/low
> protection may pass for all allocation attempts when the real min/low
> protection covers only some, or potentially none of the allocated
> buffers.

Interesting! Do I understand correctly this would be a scenario with 
multi-threaded buffer allocation or there is another path to it?

In any case moving the charge to before allocation makes sense to me. 
With a caveat that I wasn't involved in the dmem cgroup controller 
design so may be missing something.

> Instead, charge the allocation to the cgroup once and keep the charge
> for as long as we try to allocate a ttm_resource, and only undo the charge
> if allocating the resource is ultimately unsuccessful and we move on to
> a different ttm_place.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c       | 28 +++++++++++++++-------
>   drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++++++++++++-----------
>   include/drm/ttm/ttm_resource.h     |  6 ++++-
>   3 files changed, 60 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 48dbaaa46824c..a8914d20b0c32 100644
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
> @@ -546,7 +548,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   	evict_walk->evicted++;
>   	if (evict_walk->res)
>   		lret = ttm_resource_alloc(evict_walk->evictor, evict_walk->place,
> -					  evict_walk->res, NULL);
> +					  evict_walk->res, evict_walk->alloc_state->charge_pool);
>   	if (lret == 0)
>   		return 1;
>   out:
> @@ -724,10 +726,8 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
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
> @@ -737,14 +737,23 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   		 * attempt.
>   		 */
>   		if (ret == -EAGAIN)
> -			return may_evict ? -EBUSY : -ENOSPC;
> +			ret = may_evict ? -EBUSY : -ENOSPC;
> +		return ret;
> +	}
>   
> -		if (ret == -ENOSPC && may_evict)
> -			return -EBUSY;
> +	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>   

No need for a blank line here.

> +	if (ret) {
> +		if (ret == -ENOSPC && may_evict)
> +			ret = -EBUSY;

Why did you remove EAGAIN handling from after ttm_resource_alloc()?

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
> @@ -799,6 +808,7 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   				res, &alloc_state);
>   
>   		if (ret == -ENOSPC) {
> +			dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   			continue;
>   		} else if (ret == -EBUSY) {
> @@ -808,11 +818,13 @@ static int ttm_bo_alloc_resource(struct ttm_buffer_object *bo,
>   			dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>   
>   			if (ret) {
> +				dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>   				if (ret != -EBUSY)
>   					return ret;
>   				continue;
>   			}
>   		} else if (ret) {
> +			dmem_cgroup_pool_state_put(alloc_state.charge_pool);

Is uncharge in the failure case hidden in dmem_cgroup_pool_state_put() 
somehow?

Regards,

Tvrtko

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


