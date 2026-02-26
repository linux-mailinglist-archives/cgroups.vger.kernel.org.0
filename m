Return-Path: <cgroups+bounces-14419-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sF7bC4gMoGnbfQQAu9opvQ
	(envelope-from <cgroups+bounces-14419-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 10:04:08 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F371A314D
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0552430B995C
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 08:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8355A396D2C;
	Thu, 26 Feb 2026 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="mnkRsm7N"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A3838F23D
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772096216; cv=none; b=gKouoRFGgG6jGEgRIb8U+Igq2GKJhyrEvXdOzlaj8msOtg8dwlsdd/ezW1anOBH/nrW3QssKYD2K+2AFV7kb3ymKRm7U/pVkU3NP2DVKOCROX1pZgxlTBY3IcsSRquIWIQBvSkxxJssBjEOPmyj+MvDj+zRoi6UpTLcQREnICKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772096216; c=relaxed/simple;
	bh=pSdykfVuyLhFk3tK9EbFS906VhNtuRhbLUwYXfg/kAU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P015VsT2bP3WN03UU1vk/0qaemrNRrMd3f5YyUdKHYZpxU/qF8j4syV2Sfs7RewxH2W8KB9BCN91YmgLWb3RHRzJ6FXRs8bskUBQAt/m+hLHDlwgbECwCaJxeRsb2FiBs04yMzH/2qwT5RyUuXslGdrWZyIqPozsQX7gFFNxA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=mnkRsm7N; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4837907f535so5422125e9.3
        for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772096213; x=1772701013; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3pO8yIEbAexJAFnCsvgrzJYhoU8FdG0mP6bKvQFCxc=;
        b=mnkRsm7NX2HtGik+xFEeEBYswDxzXHJOoiE3iGstKiuTCOIBhTuUMY06Qhdz5G6uGm
         lmPmaqqTR/ixJAX4JNJOolstMAFvMg54Rq0B+jZNbOlzHsyjgjYii+cy5VEPHmGSOyAE
         4JgCuR3E870T9xgbu9ef6lW1Cc7FU14MlbmhBvCxaZYe6cUEurg0dblR65latSmJO23F
         9z9Gt9mZ+dabYYEt5Wxb/qMmhFOzq2WE6DLziXyCS1eVZQ9AhYQWst+7JI3RlH4Hspdt
         dZJABAnY+dUPhSIwNTEd8W94eRvpm3GzdCW5ZMvmBB+bfhGZLbflIFoBOESOagYg08m8
         TJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772096213; x=1772701013;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M3pO8yIEbAexJAFnCsvgrzJYhoU8FdG0mP6bKvQFCxc=;
        b=KfCn/6Jp9XP3jzGNCXWO0VYzQQA1SWwdCTrYgYGc7UofJ8fw0UVXgMr5HsdWN+81ad
         vfadyWXazNRNDh8RJ9jrq6yQE6kKCWqiuFcy/YJV8nGtGtAtUrZ8QW1b2MNvS9D902oO
         cxHf9eKi2G/c4Ltm8KzF6+C3U06cKbQVw7AA+ymHlGkJpyyKC8EqZSNf0b7Q4hFRLjWV
         VcMdjhUgyIJVcUZ/t0y1p07jQfXLzGX0FaSkwAZrkoGugEmnshPlvdiEwQMo3aOZV5Do
         TkbLbc1OxXyWD4owso8HpMSra77QF3snhizseFDqEDZYFTMdunOyd2R31ixeps/8HY78
         6fww==
X-Gm-Message-State: AOJu0Yy8prGH5LUG28BjL9apG75LWWjW/f40kvvedOLJMRIg0DnXPVnw
	mgs1VIRUSMLSU2WcFH+Bh7PfxxfeaVa+SAxXxw3/w1idhU2m0phULVMlOKSQ/Q6djyQ=
X-Gm-Gg: ATEYQzwImcaCsDzefuOJmgjSKOjWwBVp+F2Zp2H75t2wgWX87Q5YiC7FUsq8xeBwQr7
	jmg40WTMLulivd5vsno5ZaFlTx3kp8sSb9xI4RB0GPFAj399posMhuW4m5AVxwa5fEWTvXJ0Qul
	e8dKi6g5Biq9rcDOIqT2XMpAmXN7tuMrb7sYMZEsQ+ZKh2q0LX+ZKB94paIukQQkyPChx5sL42o
	N5VSI6ngxgzHzILcSVLBTiHSBv3cDAGWBZe9BqGJBFRZtydikk3G3GHpaM1jdP/rlJXCfKP3yqG
	jzhMLEFFE9uYwCaeiFrj2uIsCNcNwhzfDWaSxe2GDjbmO6QiZ4beR1LKwqu77bjX3X7U4EMGuQh
	ztrRYyN1E4NFrxpKKA5Gg3WAsb3CcXFemXsN9ltQnfEGY6WFSEoIWt5I9+Hy33Y4vsgvCRVwuXC
	/nKZxYxRLRL8tay5zUeZlFmv7j4hB+QngsTzHuudFNIgsM
X-Received: by 2002:a05:600c:3acf:b0:483:6d4a:7e6d with SMTP id 5b1f17b1804b1-483c21a747bmr58697185e9.30.1772096212494;
        Thu, 26 Feb 2026 00:56:52 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bffc17dasm57003635e9.2.2026.02.26.00.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 00:56:52 -0800 (PST)
Message-ID: <bf4d04be-880e-4605-bdfc-46e38e312835@ursulin.net>
Date: Thu, 26 Feb 2026 08:56:51 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/ttm: Extract code for attempting allocation in
 a place
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
 <20260225-dmemcg-aggressive-protect-v4-3-de847ab35184@gmx.de>
 <235fd4f7-dbb7-44c8-9bbc-f1d8297fb8b9@ursulin.net>
Content-Language: en-GB
In-Reply-To: <235fd4f7-dbb7-44c8-9bbc-f1d8297fb8b9@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14419-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ursulin.net:mid,ursulin.net:dkim,gmx.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88F371A314D
X-Rspamd-Action: no action


On 25/02/2026 15:27, Tvrtko Ursulin wrote:
> 
> On 25/02/2026 12:10, Natalie Vock wrote:
>> Move all code for attempting allocation for a specific place to
>> ttm_bo_alloc_place. With subsequent patches, this logic is going to get
>> more complicated, so it helps readability to have this separate.
>>
>> ttm_bo_alloc_at_place takes a pointer to a struct ttm_bo_alloc_state.
>> This struct holds various state produced by the allocation (e.g. cgroup
>> resource associated with the allocation) that the caller needs to keep
>> track of (and potentially dispose of). This is just the limiting cgroup
>> pool for now, but future patches will add more state needing to be 
>> tracked.
>>
>> ttm_bo_alloc_at_place also communicates via return codes if eviction
>> using ttm_bo_evict_alloc should be attempted. This is preparation for
>> attempting eviction in more cases than just force_space being set.
>>
>> No functional change intended.
>>
>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 109 ++++++++++++++++++++++++++++++++ 
>> +----------
>>   1 file changed, 84 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index acb9197db8798..48dbaaa46824c 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -489,6 +489,11 @@ int ttm_bo_evict_first(struct ttm_device *bdev, 
>> struct ttm_resource_manager *man
>>       return ret;
>>   }
>> +struct ttm_bo_alloc_state {
>> +    /** @limit_pool: Which pool limit we should test against */
>> +    struct dmem_cgroup_pool_state *limit_pool;
>> +};
>> +
>>   /**
>>    * struct ttm_bo_evict_walk - Parameters for the evict walk.
>>    */
>> @@ -504,12 +509,13 @@ struct ttm_bo_evict_walk {
>>       /** @evicted: Number of successful evictions. */
>>       unsigned long evicted;
>> -    /** @limit_pool: Which pool limit we should test against */
>> -    struct dmem_cgroup_pool_state *limit_pool;
>>       /** @try_low: Whether we should attempt to evict BO's with low 
>> watermark threshold */
>>       bool try_low;
>>       /** @hit_low: If we cannot evict a bo when @try_low is false 
>> (first pass) */
>>       bool hit_low;
>> +
>> +    /** @alloc_state: State associated with the allocation attempt. */
>> +    struct ttm_bo_alloc_state *alloc_state;
>>   };
>>   static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct 
>> ttm_buffer_object *bo)
>> @@ -518,8 +524,9 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk 
>> *walk, struct ttm_buffer_object *
>>           container_of(walk, typeof(*evict_walk), walk);
>>       s64 lret;
>> -    if (!dmem_cgroup_state_evict_valuable(evict_walk->limit_pool, bo- 
>> >resource->css,
>> -                          evict_walk->try_low, &evict_walk->hit_low))
>> +    if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state- 
>> >limit_pool,
>> +                          bo->resource->css, evict_walk->try_low,
>> +                          &evict_walk->hit_low))
>>           return 0;
>>       if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, 
>> evict_walk->place))
>> @@ -561,7 +568,7 @@ static int ttm_bo_evict_alloc(struct ttm_device 
>> *bdev,
>>                     struct ttm_operation_ctx *ctx,
>>                     struct ww_acquire_ctx *ticket,
>>                     struct ttm_resource **res,
>> -                  struct dmem_cgroup_pool_state *limit_pool)
>> +                  struct ttm_bo_alloc_state *state)
>>   {
>>       struct ttm_bo_evict_walk evict_walk = {
>>           .walk = {
>> @@ -574,7 +581,7 @@ static int ttm_bo_evict_alloc(struct ttm_device 
>> *bdev,
>>           .place = place,
>>           .evictor = evictor,
>>           .res = res,
>> -        .limit_pool = limit_pool,
>> +        .alloc_state = state,
>>       };
>>       s64 lret;
>> @@ -689,6 +696,58 @@ static int 
>> ttm_bo_add_pipelined_eviction_fences(struct ttm_buffer_object *bo,
>>       return dma_resv_reserve_fences(bo->base.resv, 1);
>>   }
>> +
>> +/**
>> + * ttm_bo_alloc_at_place - Attempt allocating a BO's backing store in 
>> a place
>> + *
>> + * @bo: The buffer to allocate the backing store of
>> + * @place: The place to attempt allocation in
>> + * @ctx: ttm_operation_ctx associated with this allocation
>> + * @force_space: If we should evict buffers to force space
>> + * @res: On allocation success, the resulting struct ttm_resource.
>> + * @alloc_state: Object holding allocation state such as charged 
>> cgroups.
>> + *
>> + * Returns:
>> + * -EBUSY: No space available, but allocation should be retried with 
>> ttm_bo_evict_alloc.
>> + * -ENOSPC: No space available, allocation should not be retried.
>> + * -ERESTARTSYS: An interruptible sleep was interrupted by a signal.
>> + *
>> + */
>> +static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>> +                 const struct ttm_place *place,
>> +                 struct ttm_operation_ctx *ctx,
>> +                 bool force_space,
>> +                 struct ttm_resource **res,
>> +                 struct ttm_bo_alloc_state *alloc_state)
>> +{
>> +    bool may_evict;
>> +    int ret;
>> +
>> +    may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
>> +
>> +    ret = ttm_resource_alloc(bo, place, res,
>> +                 force_space ? &alloc_state->limit_pool : NULL);
>> +
>> +    if (ret) {
>> +        /*
>> +         * -EAGAIN means the charge failed, which we treat like an
>> +         * allocation failure. Therefore, return an error code 
>> indicating
>> +         * the allocation failed - either -EBUSY if the allocation 
>> should
>> +         * be retried with eviction, or -ENOSPC if there should be no 
>> second
>> +         * attempt.
>> +         */
> 
> Ah having started reading 4/6 I see this comment actually is one patch 
> premature. So please fix that and keep my r-b.

Or perhaps you are talking about charge here, not because in a later 
patch the call to try charge is put right here, but because even now it 
is happening inside the ttm_resource_alloc? I guess that's passable 
although not immediately obvious from just the context of this function. 
Okay, I think the comment can stay as is since in the next patch it 
becomes immediately obvious, sorry for the noise.

Regards,

Tvrtko

>> +        if (ret == -EAGAIN)
>> +            return may_evict ? -EBUSY : -ENOSPC;
>> +
>> +        if (ret == -ENOSPC && may_evict)
>> +            return -EBUSY;
>> +
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /**
>>    * ttm_bo_alloc_resource - Allocate backing store for a BO
>>    *
>> @@ -714,7 +773,9 @@ static int ttm_bo_alloc_resource(struct 
>> ttm_buffer_object *bo,
>>                    bool force_space,
>>                    struct ttm_resource **res)
>>   {
>> +    struct ttm_bo_alloc_state alloc_state = {0};
>>       struct ttm_device *bdev = bo->bdev;
>> +    struct ttm_resource_manager *man;
>>       struct ww_acquire_ctx *ticket;
>>       int i, ret;
>> @@ -725,9 +786,6 @@ static int ttm_bo_alloc_resource(struct 
>> ttm_buffer_object *bo,
>>       for (i = 0; i < placement->num_placement; ++i) {
>>           const struct ttm_place *place = &placement->placement[i];
>> -        struct dmem_cgroup_pool_state *limit_pool = NULL;
>> -        struct ttm_resource_manager *man;
>> -        bool may_evict;
>>           man = ttm_manager_type(bdev, place->mem_type);
>>           if (!man || !ttm_resource_manager_used(man))
>> @@ -737,25 +795,26 @@ static int ttm_bo_alloc_resource(struct 
>> ttm_buffer_object *bo,
>>                       TTM_PL_FLAG_FALLBACK))
>>               continue;
>> -        may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
>> -        ret = ttm_resource_alloc(bo, place, res, force_space ? 
>> &limit_pool : NULL);
>> -        if (ret) {
>> -            if (ret != -ENOSPC && ret != -EAGAIN) {
>> -                dmem_cgroup_pool_state_put(limit_pool);
>> -                return ret;
>> -            }
>> -            if (!may_evict) {
>> -                dmem_cgroup_pool_state_put(limit_pool);
>> -                continue;
>> -            }
>> +        ret = ttm_bo_alloc_at_place(bo, place, ctx, force_space,
>> +                res, &alloc_state);
>> +        if (ret == -ENOSPC) {
>> +            dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>> +            continue;
>> +        } else if (ret == -EBUSY) {
>>               ret = ttm_bo_evict_alloc(bdev, man, place, bo, ctx,
>> -                         ticket, res, limit_pool);
>> -            dmem_cgroup_pool_state_put(limit_pool);
>> -            if (ret == -EBUSY)
>> +                         ticket, res, &alloc_state);
>> +
>> +            dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>> +
>> +            if (ret) {
>> +                if (ret != -EBUSY)
>> +                    return ret;
>>                   continue;
>> -            if (ret)
>> -                return ret;
>> +            }
>> +        } else if (ret) {
>> +            dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>> +            return ret;
>>           }
>>           ret = ttm_bo_add_pipelined_eviction_fences(bo, man, ctx- 
>> >no_wait_gpu);
>>
> 


