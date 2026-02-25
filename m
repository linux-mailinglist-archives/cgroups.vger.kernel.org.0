Return-Path: <cgroups+bounces-14371-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGSIHhEen2lcZAQAu9opvQ
	(envelope-from <cgroups+bounces-14371-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:06:41 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED67A19A3D4
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 17:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D2B305510F
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CB73AEF34;
	Wed, 25 Feb 2026 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="W7J3xppH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAC3D7D68
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035283; cv=none; b=ufJdhavB5vG8hkQFu4WOGkly51/OpXuGyxn4N1J/OB74jeuKjCC5+oGTfjMZCFWVDWEcyhgOkPDoNkEQHhScc05qmwVcrOVCEDyeK1iPO0C+8BfCBFVtjeMI/nqgEYzTxeGGU+EsmjEilNHFkY3e+au/VzPFyec0BTWwt9KRxEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035283; c=relaxed/simple;
	bh=Kl3CZOY1zuRMTagbD7pb4e45jsoBnrNl/T5XItSlkCA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mASJVioyWnrUsZa9Q037N6rV5/esfbyR25o0YXHDi//4k8WJbFWY5zSg+2+9QVUcwReleSty1b78o940YVOfr8/BhPuBIxVUr4dWOtoIe6JTWHv35XPHxU9yFNnDNQA+eGkWO3iq1DU18IFe2ghOnjZNyc0ukVK+tOzC5lIOJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=W7J3xppH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so84584995e9.2
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 08:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772035279; x=1772640079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QYTH6TRxaDTqbQ4lt+lqgj9OS3vmhH7j+1w2VyEOxF0=;
        b=W7J3xppHLIDR/AWta6/QtM3g/ZiH6b6angYYW67h3BWAxKTxG2LP3GXw+PL8ANQDgM
         RTHrKxQvdJE93ANXkwGIyIXTptKtTcd8V4JFHrteXZ/TI3eQyA9wV+6T5Jz9R+Qw4ENd
         Aiuajxziwz5VSJCJrqZZ+OzwRCzCxmoa75tU8c+Nl8pdp3ow10Omm30mnVzXeUOrUraS
         IO45MPEdr1JiB03pv/HUE/zq2BvRvJGBYHHrnijUyV6zMylbQbQCYU2CJpzyaFH5v/9r
         nEVBLhtrz/ZfoL5V8rbG7GcUhQaf18nT+I95JElgMhZrmBMBA0AhfGFaqdD0xgBsPvyY
         Pf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772035279; x=1772640079;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYTH6TRxaDTqbQ4lt+lqgj9OS3vmhH7j+1w2VyEOxF0=;
        b=UBCH9dh75A7kHltqhToBEp6BidcLyEb4HYJtR5dV3r4itIh1Q1LqZ+JMqLfjViHj7z
         kQRqkT2ibR4C/51JlNk8CQV1O6k5FRBR56PI6uU+P3M/AUJJxVzU+DTNgrHNK9Tp/sOy
         2SYDUz1RtSGJLP+GZa79exGL8R8raAo+nY6zlXSVbXoa7UP0oUQc4+dPiftoxRnB/stu
         SX770+cN+NwIPbWnRcZ/E1eYHZ4PqWXcyleRFnfUEYD7fqVKgHF84Mhsfj44zkr21Sk6
         xrMvwMCnk4wjwczgBmSZx7iHtP/lU+R/rq8+ML6ROyDpK66l9YlrkpFux5Sp3cvzJ1Wv
         iihQ==
X-Gm-Message-State: AOJu0YyHOM+Azv8fTKSxsFOxHkHZndAOsvdyhr/XTbTYfuWKNdWVXZDb
	rP/sxNOBwKxaQtaRYMG4KmSulK7OHcgtXuTskoLFdADJLKAKsHSDQ4dDDPM25LdClJ8=
X-Gm-Gg: ATEYQzzpAYyRrYDwlDEcVsq5UzXJfDOBqWptJiV/49JiM9kS6kGMHnlYUC55xCKYzW6
	spK0ml0VeLIUQyDdE+E0seiDCfBHa69dO7KL9pysJk10GBZ/RRxRHwRCLpFjhT5RX06VytSjX1O
	McFxsdMtBM03gf2zzD3DR6ZSehVpdbn6BFOTIGysmXSmruXwz0kvpYJyU3QExqkM4SXeagcvxow
	MNotQGeb1efESpezfR/zoc4P514mCUfSkyuDKCPzx37646X3upNNxukEsb7Y701ubrhqK4fgrYu
	sS+6YrnmXFeVS+0ZtAVUURSdu169vld4C5GGuKOWlkdRVuHwvIvM2eHoDEtbzwBWDIzVxrrgv59
	KzyTNqTxft5ZjCKpRn12VbJkXTgmOLWZX8C2DmFl3ycWtudGzRHiW6gTaDSk3JB+/s6NKrbFMbZ
	WmjxsSoEenj2NgjVpgMCcSGSh3gjNWPMnEZUwlTbgvZfz7
X-Received: by 2002:a05:600c:6291:b0:477:8985:4036 with SMTP id 5b1f17b1804b1-483a95b5a7dmr281901675e9.1.1772035277667;
        Wed, 25 Feb 2026 08:01:17 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df9fsm81675695e9.13.2026.02.25.08.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 08:01:16 -0800 (PST)
Message-ID: <dee1922d-9905-484e-b161-641fe8db4d51@ursulin.net>
Date: Wed, 25 Feb 2026 16:01:15 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] drm/ttm: Split cgroup charge and resource
 allocation
From: Tvrtko Ursulin <tursulin@ursulin.net>
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
 <9f726505-cce3-430a-8d16-fd9695dc4577@ursulin.net>
Content-Language: en-GB
In-Reply-To: <9f726505-cce3-430a-8d16-fd9695dc4577@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14371-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: ED67A19A3D4
X-Rspamd-Action: no action


On 25/02/2026 15:33, Tvrtko Ursulin wrote:
> 
> On 25/02/2026 12:10, Natalie Vock wrote:
>> Coupling resource allocation and cgroup charging is racy when charging
>> succeeds, but subsequent resource allocation fails. Certain eviction
>> decisions are made on the basis of whether the allocating cgroup is
>> protected, i.e. within its min/low limits, but with the charge being
>> tied to resource allocation (and uncharged when the resource allocation
>> fails), this check is done at a poin where the allocation is not actually
> 
> s/poin/point/
> 
>> charged to the cgroup.
>>
>> This is subtly wrong if the allocation were to cause the cgroup to exceed
>> the min/low protection, but it's even more wrong if the same cgroup tries
>> allocating multiple buffers concurrently: In this case, the min/low
>> protection may pass for all allocation attempts when the real min/low
>> protection covers only some, or potentially none of the allocated
>> buffers.
> 
> Interesting! Do I understand correctly this would be a scenario with 
> multi-threaded buffer allocation or there is another path to it?
> 
> In any case moving the charge to before allocation makes sense to me. 
> With a caveat that I wasn't involved in the dmem cgroup controller 
> design so may be missing something.
> 
>> Instead, charge the allocation to the cgroup once and keep the charge
>> for as long as we try to allocate a ttm_resource, and only undo the 
>> charge
>> if allocating the resource is ultimately unsuccessful and we move on to
>> a different ttm_place.
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c       | 28 +++++++++++++++-------
>>   drivers/gpu/drm/ttm/ttm_resource.c | 48 ++++++++++++++++++++++++++ 
>> +-----------
>>   include/drm/ttm/ttm_resource.h     |  6 ++++-
>>   3 files changed, 60 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index 48dbaaa46824c..a8914d20b0c32 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -490,6 +490,8 @@ int ttm_bo_evict_first(struct ttm_device *bdev, 
>> struct ttm_resource_manager *man
>>   }
>>   struct ttm_bo_alloc_state {
>> +    /** @charge_pool: The memory pool the resource is charged to */
>> +    struct dmem_cgroup_pool_state *charge_pool;
>>       /** @limit_pool: Which pool limit we should test against */
>>       struct dmem_cgroup_pool_state *limit_pool;
>>   };
>> @@ -546,7 +548,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk 
>> *walk, struct ttm_buffer_object *
>>       evict_walk->evicted++;
>>       if (evict_walk->res)
>>           lret = ttm_resource_alloc(evict_walk->evictor, evict_walk- 
>> >place,
>> -                      evict_walk->res, NULL);
>> +                      evict_walk->res, evict_walk->alloc_state- 
>> >charge_pool);
>>       if (lret == 0)
>>           return 1;
>>   out:
>> @@ -724,10 +726,8 @@ static int ttm_bo_alloc_at_place(struct 
>> ttm_buffer_object *bo,
>>       int ret;
>>       may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
>> -
>> -    ret = ttm_resource_alloc(bo, place, res,
>> -                 force_space ? &alloc_state->limit_pool : NULL);
>> -
>> +    ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
>> +                      force_space ? &alloc_state->limit_pool : NULL);
>>       if (ret) {
>>           /*
>>            * -EAGAIN means the charge failed, which we treat like an
>> @@ -737,14 +737,23 @@ static int ttm_bo_alloc_at_place(struct 
>> ttm_buffer_object *bo,
>>            * attempt.
>>            */
>>           if (ret == -EAGAIN)
>> -            return may_evict ? -EBUSY : -ENOSPC;
>> +            ret = may_evict ? -EBUSY : -ENOSPC;
>> +        return ret;
>> +    }
>> -        if (ret == -ENOSPC && may_evict)
>> -            return -EBUSY;
>> +    ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
> 
> No need for a blank line here.
> 
>> +    if (ret) {
>> +        if (ret == -ENOSPC && may_evict)
>> +            ret = -EBUSY;
> 
> Why did you remove EAGAIN handling from after ttm_resource_alloc()?

I figured this part out. I guess EAGAIN can only come out 
dmem_cgroup_try_charge() which is no longer here. Makes sense.

Return code handling changes look fine to me in this case. Just the 
question of uncharging remains.

Regards,

Tvrtko

> 
>>           return ret;
>>       }
>> +    /*
>> +     * Ownership of charge_pool has been transferred to the TTM 
>> resource,
>> +     * don't make the caller think we still hold a reference to it.
>> +     */
>> +    alloc_state->charge_pool = NULL;
>>       return 0;
>>   }
>> @@ -799,6 +808,7 @@ static int ttm_bo_alloc_resource(struct 
>> ttm_buffer_object *bo,
>>                   res, &alloc_state);
>>           if (ret == -ENOSPC) {
>> +            dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>>               dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>>               continue;
>>           } else if (ret == -EBUSY) {
>> @@ -808,11 +818,13 @@ static int ttm_bo_alloc_resource(struct 
>> ttm_buffer_object *bo,
>>               dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>>               if (ret) {
>> +                dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>>                   if (ret != -EBUSY)
>>                       return ret;
>>                   continue;
>>               }
>>           } else if (ret) {
>> +            dmem_cgroup_pool_state_put(alloc_state.charge_pool);
> 
> Is uncharge in the failure case hidden in dmem_cgroup_pool_state_put() 
> somehow?
> 
> Regards,
> 
> Tvrtko
> 
>>               dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>>               return ret;
>>           }
>> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ 
>> ttm_resource.c
>> index 192fca24f37e4..a8a836f6e376a 100644
>> --- a/drivers/gpu/drm/ttm/ttm_resource.c
>> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
>> @@ -373,30 +373,52 @@ void ttm_resource_fini(struct 
>> ttm_resource_manager *man,
>>   }
>>   EXPORT_SYMBOL(ttm_resource_fini);
>> +/**
>> + * ttm_resource_try_charge - charge a resource manager's cgroup pool
>> + * @bo: buffer for which an allocation should be charged
>> + * @place: where the allocation is attempted to be placed
>> + * @ret_pool: on charge success, the pool that was charged
>> + * @ret_limit_pool: on charge failure, the pool responsible for the 
>> failure
>> + *
>> + * Should be used to charge cgroups before attempting resource 
>> allocation.
>> + * When charging succeeds, the value of ret_pool should be passed to
>> + * ttm_resource_alloc.
>> + *
>> + * Returns: 0 on charge success, negative errno on failure.
>> + */
>> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
>> +                const struct ttm_place *place,
>> +                struct dmem_cgroup_pool_state **ret_pool,
>> +                struct dmem_cgroup_pool_state **ret_limit_pool)
>> +{
>> +    struct ttm_resource_manager *man =
>> +        ttm_manager_type(bo->bdev, place->mem_type);
>> +
>> +    if (!man->cg) {
>> +        *ret_pool = NULL;
>> +        if (ret_limit_pool)
>> +            *ret_limit_pool = NULL;
>> +        return 0;
>> +    }
>> +
>> +    return dmem_cgroup_try_charge(man->cg, bo->base.size, ret_pool,
>> +                      ret_limit_pool);
>> +}
>> +
>>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>>                  const struct ttm_place *place,
>>                  struct ttm_resource **res_ptr,
>> -               struct dmem_cgroup_pool_state **ret_limit_pool)
>> +               struct dmem_cgroup_pool_state *charge_pool)
>>   {
>>       struct ttm_resource_manager *man =
>>           ttm_manager_type(bo->bdev, place->mem_type);
>> -    struct dmem_cgroup_pool_state *pool = NULL;
>>       int ret;
>> -    if (man->cg) {
>> -        ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, 
>> ret_limit_pool);
>> -        if (ret)
>> -            return ret;
>> -    }
>> -
>>       ret = man->func->alloc(man, bo, place, res_ptr);
>> -    if (ret) {
>> -        if (pool)
>> -            dmem_cgroup_uncharge(pool, bo->base.size);
>> +    if (ret)
>>           return ret;
>> -    }
>> -    (*res_ptr)->css = pool;
>> +    (*res_ptr)->css = charge_pool;
>>       spin_lock(&bo->bdev->lru_lock);
>>       ttm_resource_add_bulk_move(*res_ptr, bo);
>> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ 
>> ttm_resource.h
>> index 33e80f30b8b82..549b5b796884d 100644
>> --- a/include/drm/ttm/ttm_resource.h
>> +++ b/include/drm/ttm/ttm_resource.h
>> @@ -456,10 +456,14 @@ void ttm_resource_init(struct ttm_buffer_object 
>> *bo,
>>   void ttm_resource_fini(struct ttm_resource_manager *man,
>>                  struct ttm_resource *res);
>> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
>> +                const struct ttm_place *place,
>> +                struct dmem_cgroup_pool_state **ret_pool,
>> +                struct dmem_cgroup_pool_state **ret_limit_pool);
>>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>>                  const struct ttm_place *place,
>>                  struct ttm_resource **res,
>> -               struct dmem_cgroup_pool_state **ret_limit_pool);
>> +               struct dmem_cgroup_pool_state *charge_pool);
>>   void ttm_resource_free(struct ttm_buffer_object *bo, struct 
>> ttm_resource **res);
>>   bool ttm_resource_intersects(struct ttm_device *bdev,
>>                    struct ttm_resource *res,
>>
> 


