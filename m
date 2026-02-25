Return-Path: <cgroups+bounces-14350-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CM5oB87Lnmm0XQQAu9opvQ
	(envelope-from <cgroups+bounces-14350-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 11:15:42 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 886FA1959D3
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 11:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48EC530FCEF2
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 10:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776C7374180;
	Wed, 25 Feb 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="OfhL7qIp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE61838F93E
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014351; cv=none; b=J/nGxWVg5DAyct2XcFtzJDlwOYq2kKfqyUeKSohdSHhNBejhjpCbTw18jizwkceRrEXDAgK88cTvhFrm8b4yyDDNFo2he8hl3kASu2ILZczKLYPx95josUcy1cPR5VxtQr+uIGkL743jTY7Q9mFqx/hWg65NB3h3p2XCOvyZ8dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014351; c=relaxed/simple;
	bh=ghpM6khjSxZkBLhSQyAomHQ+sD8JZ5LTgogROdOex+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OPV68PsBEsGQsJIXRGJmP+7yrhJ1UvtZDih/pkiMAlvF8beqdxG8x9kpziITXRq0cyCZfFU4l+7alJB9jaaNYtTXLXFrHVu9wz8Wzsnqy2H7/9uMNSDWcVChz8gq66kyMHYVdLKTi/F+dKJwebz0uz3HLtVDOYkVpDuH7rTv9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=OfhL7qIp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so80045695e9.2
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 02:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772014343; x=1772619143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aw12o64ZQ+b31ud7bMQ0ZbBMNE3G6BKIOfe+4rhRyHU=;
        b=OfhL7qIpx9b+zLfDFAptzbRJnGGNtYcIWO7tj+/sZBswbdulrtB6JlQheGcv9pypV+
         rwB7GLIzrT4eKz8twLlff17z2q3kZI2vODnPorORqGHX/u2RTW592fdDqSXpv/sa8/eC
         qjM65tJfNKbcMgdpTD2wxMGDRVftd/uOnYNk3HUI586TU9pnFtpsAQ6GGMvlHjtbWrkx
         4x5atilM6eai8WQL5WVdbiuuSyF0uY1Ef+SytwqzKKFFzqXeHuwHxdiVXZKNGLabMviq
         zhiBYelhOEjbPs1ABy3YnBtF34dYTGWXM4YjBV9Q6/8h4n92EuAC++W7GkMBWcWEj8YD
         2x9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014343; x=1772619143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aw12o64ZQ+b31ud7bMQ0ZbBMNE3G6BKIOfe+4rhRyHU=;
        b=xQslkNfNBGQAZbtldNCM5EcC4TONWwGbZ6L1qObr7jw5PHqsr0xdlJezBeiflYjSeP
         39HC9jhayVkUq1BLtOXxp0snVAxxA29wAInVSOmuKuAXJWcBFELmUn/0h+fVB8D3/AsZ
         NMr07MZVH5XNELUPotO7K+UEaZlIJ96P+PN6lRJoaXDV5Kzey0s/e+Js6lcLFQXjUoHH
         ynhSMmy22J0z5czZS9S/HkHm4jY5QYgrEisGL4Ls3zvLxQKtvKkJOKUrOc8aZ6g6sLaz
         HneU8ZpOU0BY6c2UzYe8p1LVgFEs1rvNqYBioFmGoiApDkoTS8rBS4GaZxc0kCNAYzzG
         TV6w==
X-Gm-Message-State: AOJu0YzenSVUMk0t1KRv5RWwyCVaUrZRHos+0LG7VCVQCKL2cvRzV2pM
	U0svgHuDq/lwkvAJeoUnBlhwM2fbCGay3PgKxzWCEM3ZCqPnoc+MGKOBhQeFWhmXEXw=
X-Gm-Gg: ATEYQzzuzR1CqhICT8HX5bLVzVDGEbU7REWsIJh122k17WxfZlffEmI01ycwlnX25YP
	CbpPx6KTPqBVgv9tFXX/CxYbvlv1lbEf6ZwDFUgvDEV4PswQabYH2RASmFUSQnquGoOjE6CP9wq
	9R+nDrlmy0G8RQjk0IWP6FsD4YEEEV2NjSF/CCd+DR1BvyEo0wEn9FLmxUBUdwEsK39Nff7fJtZ
	Rw2RBSsX0lHYXwaPrjgp5oyNXJSuEvdiYOAyyHcMg3+qH391jBWhswuy3FpS7HMegGtW9n/a0Ac
	DFKRAQVhkefKC77X2thgQSfPIF5rLTpQbvHwsIpo56dDtdeqDMB1e2/URHAcyYpAzH+E/iqBVQa
	Zs33f5tdBf8232Gweg/JWR+9wVzxsysC6sn7FKQGrUdg/QqNhl4ByO+uQYTRg4wLTUXjWqh6dSG
	nkQtpmUGWzwiZtnY61SyDfEegODbuXd6m0Dv2N7uxV7gRE
X-Received: by 2002:a05:600c:3e8d:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-483a95f5a48mr238388485e9.28.1772014342664;
        Wed, 25 Feb 2026 02:12:22 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa015sm33188082f8f.8.2026.02.25.02.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 02:12:22 -0800 (PST)
Message-ID: <e097bf9b-0078-4de4-929c-0b9e0b26af8e@ursulin.net>
Date: Wed, 25 Feb 2026 10:12:21 +0000
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
 <4d9e2fb9-1cea-476e-b7f8-d2caaef4a579@ursulin.net>
 <fdf710df-8991-4ee1-9eca-78b21ecdc828@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <fdf710df-8991-4ee1-9eca-78b21ecdc828@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14350-lists,cgroups=lfdr.de];
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
X-Rspamd-Queue-Id: 886FA1959D3
X-Rspamd-Action: no action


On 25/02/2026 09:49, Natalie Vock wrote:
> On 2/24/26 17:40, Tvrtko Ursulin wrote:
>>
>> On 10/11/2025 12:37, Natalie Vock wrote:
>>> When the cgroup's memory usage is below the low/min limit and allocation
>>> fails, try evicting some unprotected buffers to make space. Otherwise,
>>> application buffers may be forced to go into GTT even though usage is
>>> below the corresponding low/min limit, if other applications filled VRAM
>>> with their allocations first.
>>>
>>> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
>>> ---
>>>   drivers/gpu/drm/ttm/ttm_bo.c       | 75 +++++++++++++++++++++++++++ 
>>> + ++++++----
>>>   drivers/gpu/drm/ttm/ttm_resource.c | 48 +++++++++++++++++-------
>>>   include/drm/ttm/ttm_resource.h     |  6 ++-
>>>   3 files changed, 108 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>> index 829d994798835..bd467c965e1bc 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -490,8 +490,12 @@ int ttm_bo_evict_first(struct ttm_device *bdev, 
>>> struct ttm_resource_manager *man
>>>   }
>>>   struct ttm_bo_alloc_state {
>>> +    /** @charge_pool: The memory pool the resource is charged to */
>>> +    struct dmem_cgroup_pool_state *charge_pool;
>>>       /** @limit_pool: Which pool limit we should test against */
>>>       struct dmem_cgroup_pool_state *limit_pool;
>>> +    /** @only_evict_unprotected: If eviction should be restricted to 
>>> unprotected BOs */
>>> +    bool only_evict_unprotected;
>>>   };
>>>   /**
>>> @@ -546,7 +550,7 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk 
>>> *walk, struct ttm_buffer_object *
>>>       evict_walk->evicted++;
>>>       if (evict_walk->res)
>>>           lret = ttm_resource_alloc(evict_walk->evictor, evict_walk- 
>>> >place,
>>> -                      evict_walk->res, NULL);
>>> +                      evict_walk->res, evict_walk->alloc_state- 
>>> >charge_pool);
>>>       if (lret == 0)
>>>           return 1;
>>>   out:
>>> @@ -589,7 +593,7 @@ static int ttm_bo_evict_alloc(struct ttm_device 
>>> *bdev,
>>>       lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>>>       /* One more attempt if we hit low limit? */
>>> -    if (!lret && evict_walk.hit_low) {
>>> +    if (!lret && evict_walk.hit_low && !state- 
>>> >only_evict_unprotected) {
>>
>> What is unprotected synonymous with? No low watermark set? Should 
>> dmem_cgroup_state_evict_valuable() even set *hit_low = true for if low 
>> is not set to begin with?
> 
> In terms of cgroup usage, a cgroup (and by extension, its BOs) is 
> protected as long as its usage stays under the low watermark (if not 
> set, that watermark is zero and any BO is trivially unprotected). If the 
> usage exceeds the low watermark, the cgroup/its BOs become unprotected 
> and can be evicted (more easily), until the usage goes below the 
> watermark again.

Got it thanks, so either no low set, or usage above low. Makes sense.

> With only_evict_unprotected, what we're trying to do is evict buffers 
> from any cgroup that currently exceeds its low (or min) watermark, but 
> leave alone cgroups that are within their limits. I've elaborated on the 
> rationale more in the cover letter, but essentially, this is supposed to 
> make TTM honor the low/min protection better for cgroups that are 
> allocating and currently within their low/min watermark, by allowing 
> them to push out BOs from cgroups that exceed their respective watermarks.

Yep, I got that part. Just that I will need a second pass to fully grasp 
the extended logic. Problem being more booleans and passes make things 
more complex. That is why I made this side question on whether it even 
makes sense for dmem_cgroup_state_evict_valuable() to set hit_low if the 
low is not even set. Assuming I got it right it can happen:

	if (!ignore_low) {
		low = READ_ONCE(ctest->elow);
		if (used > low)
			return true;

		*ret_hit_low = true;
		return false;
	}

So I was wondering what would be the effect of making that like this:

	if (!ignore_low) {
		low = READ_ONCE(ctest->elow);
		if (used > low)
			return true;

+		if (low)
+			*ret_hit_low = true;

		return false;
	}


Could that somehow simplify the logic, maybe allow for not having to add 
the additional condition above. Possibly not, it seems more complex than 
that. But I am just thinking out loud at this point. Again, I need to 
make a second reading pass.

> I'll add some comments to the only_evict_unprotected docs to explain 
> what "unprotected" means here.
> 
>>
>>>           evict_walk.try_low = true;
>>>           lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>>>       }
>>> @@ -610,7 +614,8 @@ static int ttm_bo_evict_alloc(struct ttm_device 
>>> *bdev,
>>>       } while (!lret && evict_walk.evicted);
>>>       /* We hit the low limit? Try once more */
>>> -    if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
>>> +    if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
>>> +            !state->only_evict_unprotected) {
>>>           evict_walk.try_low = true;
>>>           goto retry;
>>>       }
>>> @@ -719,20 +724,72 @@ static int ttm_bo_alloc_at_place(struct 
>>> ttm_buffer_object *bo,
>>>                    struct ttm_resource **res,
>>>                    struct ttm_bo_alloc_state *alloc_state)
>>>   {
>>> -    bool may_evict;
>>> +    bool may_evict, below_low = false;
>>>       int ret;
>>>       may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
>>> +    ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
>>> +                      force_space ? &alloc_state->limit_pool : NULL);
>>> +    if (ret) {
>>> +        /*
>>> +         * -EAGAIN means the charge failed, which we treat like an
>>> +         * allocation failure. Therefore, return an error code 
>>> indicating
>>> +         * the allocation failed - either -EBUSY if the allocation 
>>> should
>>> +         * be retried with eviction, or -ENOSPC if there should be 
>>> no second
>>> +         * attempt.
>>> +         */
>>> +        if (ret == -EAGAIN)
>>> +            ret = may_evict ? -EBUSY : -ENOSPC;
>>> +        return ret;
>>> +    }
>>> -    ret = ttm_resource_alloc(bo, place, res,
>>> -                 force_space ? &alloc_state->limit_pool : NULL);
>>> +    /*
>>> +     * cgroup protection plays a special role in eviction.
>>> +     * Conceptually, protection of memory via the dmem cgroup 
>>> controller
>>> +     * entitles the protected cgroup to use a certain amount of memory.
>>> +     * There are two types of protection - the 'low' limit is a
>>> +     * "best-effort" protection, whereas the 'min' limit provides a 
>>> hard
>>> +     * guarantee that memory within the cgroup's allowance will not be
>>> +     * evicted under any circumstance.
>>> +     *
>>> +     * To faithfully model this concept in TTM, we also need to take 
>>> cgroup
>>> +     * protection into account when allocating. When allocation in one
>>> +     * place fails, TTM will default to trying other places first 
>>> before
>>> +     * evicting.
>>> +     * If the allocation is covered by dmem cgroup protection, however,
>>> +     * this prevents the allocation from using the memory it is 
>>> "entitled"
>>> +     * to. To make sure unprotected allocations cannot push new 
>>> protected
>>> +     * allocations out of places they are "entitled" to use, we should
>>> +     * evict buffers not covered by any cgroup protection, if this
>>> +     * allocation is covered by cgroup protection.
>>> +     *
>>> +     * Buffers covered by 'min' protection are a special case - the 
>>> 'min'
>>> +     * limit is a stronger guarantee than 'low', and thus buffers 
>>> protected
>>> +     * by 'low' but not 'min' should also be considered for eviction.
>>> +     * Buffers protected by 'min' will never be considered for eviction
>>> +     * anyway, so the regular eviction path should be triggered here.
>>> +     * Buffers protected by 'low' but not 'min' will take a special
>>> +     * eviction path that only evicts buffers covered by neither 
>>> 'low' or
>>> +     * 'min' protections.
>>> +     */
>>> +    may_evict |= dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
>>> +    below_low = dmem_cgroup_below_low(NULL, alloc_state->charge_pool);
>>> +    alloc_state->only_evict_unprotected = !may_evict && below_low;
>>> +
>>> +    ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>>>       if (ret) {
>>> -        if ((ret == -ENOSPC || ret == -EAGAIN) && may_evict)
>>> +        if ((ret == -ENOSPC || ret == -EAGAIN) &&
>>> +                (may_evict || below_low))
>>>               ret = -EBUSY;
>>>           return ret;
>>>       }
>>> +    /*
>>> +     * Ownership of charge_pool has been transferred to the TTM 
>>> resource,
>>> +     * don't make the caller think we still hold a reference to it.
>>> +     */
>>> +    alloc_state->charge_pool = NULL;
>>>       return 0;
>>>   }
>>> @@ -787,6 +844,7 @@ static int ttm_bo_alloc_resource(struct 
>>> ttm_buffer_object *bo,
>>>                   res, &alloc_state);
>>>           if (ret == -ENOSPC) {
>>> +            dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>>>               dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>>>               continue;
>>>           } else if (ret == -EBUSY) {
>>> @@ -796,11 +854,14 @@ static int ttm_bo_alloc_resource(struct 
>>> ttm_buffer_object *bo,
>>>               dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>>>               if (ret) {
>>> +                dmem_cgroup_pool_state_put(
>>> +                        alloc_state.charge_pool);
>>
>> Funky line break.
> 
> Will fix.
> 
>>
>>>                   if (ret != -ENOSPC && ret != -EBUSY)
>>>                       return ret;
>>>                   continue;
>>>               }
>>>           } else if (ret) {
>>> +            dmem_cgroup_pool_state_put(alloc_state.charge_pool);
>>>               dmem_cgroup_pool_state_put(alloc_state.limit_pool);
>>>               return ret;
>>>           }
>>> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ 
>>> ttm/ ttm_resource.c
>>> index e2c82ad07eb44..fcfa8b51b0337 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_resource.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
>>> @@ -372,30 +372,52 @@ void ttm_resource_fini(struct 
>>> ttm_resource_manager *man,
>>>   }
>>>   EXPORT_SYMBOL(ttm_resource_fini);
>>> +/**
>>> + * ttm_resource_try_charge - charge a resource manager's cgroup pool
>>> + * @bo: buffer for which an allocation should be charged
>>> + * @place: where the allocation is attempted to be placed
>>> + * @ret_pool: on charge success, the pool that was charged
>>> + * @ret_limit_pool: on charge failure, the pool responsible for the 
>>> failure
>>> + *
>>> + * Should be used to charge cgroups before attempting resource 
>>> allocation.
>>> + * When charging succeeds, the value of ret_pool should be passed to
>>> + * ttm_resource_alloc.
>>> + *
>>> + * Returns: 0 on charge success, negative errno on failure.
>>> + */
>>> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
>>> +                const struct ttm_place *place,
>>> +                struct dmem_cgroup_pool_state **ret_pool,
>>> +                struct dmem_cgroup_pool_state **ret_limit_pool)
>>> +{
>>> +    struct ttm_resource_manager *man =
>>> +        ttm_manager_type(bo->bdev, place->mem_type);
>>> +
>>> +    if (!man->cg) {
>>> +        *ret_pool = NULL;
>>> +        if (ret_limit_pool)
>>> +            *ret_limit_pool = NULL;
>>> +        return 0;
>>> +    }
>>> +
>>> +    return dmem_cgroup_try_charge(man->cg, bo->base.size, ret_pool,
>>> +                      ret_limit_pool);
>>> +}
>>> +
>>>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>>>                  const struct ttm_place *place,
>>>                  struct ttm_resource **res_ptr,
>>> -               struct dmem_cgroup_pool_state **ret_limit_pool)
>>> +               struct dmem_cgroup_pool_state *charge_pool)
>>>   {
>>>       struct ttm_resource_manager *man =
>>>           ttm_manager_type(bo->bdev, place->mem_type);
>>> -    struct dmem_cgroup_pool_state *pool = NULL;
>>>       int ret;
>>> -    if (man->cg) {
>>> -        ret = dmem_cgroup_try_charge(man->cg, bo->base.size, &pool, 
>>> ret_limit_pool);
>>> -        if (ret)
>>> -            return ret;
>>> -    }
>>> -
>>>       ret = man->func->alloc(man, bo, place, res_ptr);
>>> -    if (ret) {
>>> -        if (pool)
>>> -            dmem_cgroup_uncharge(pool, bo->base.size);
>>> +    if (ret)
>>>           return ret;
>>> -    }
>>> -    (*res_ptr)->css = pool;
>>> +    (*res_ptr)->css = charge_pool;
>>
>> Is it possible to somehow split this patch into two? I mean first a 
>> patch which changes the prototype of ttm_resource_alloc(), adjusting 
>> the callers, set out new rules for owning the charge pool, etc, then 
>> the patch which only adds the cgroup smarts to 
>> ttm_bo_alloc_at_place(). If that could be made without creating any 
>> functional difference to the eviction alone I think it could make it 
>> easier to review.
> 
> Will try.

Only if it sounds plausible that it can be sensibly done. Otherwise 
don't spend too much time if you think it makes no sense. I'll wait for 
the verdict, or for v4 to appear and then have another go of making 
sense of the existing vs new eviction logic.

Regards,

Tvrtko


> Thanks,
> Natalie
> 
>>
>> Regards,
>>
>> Tvrtko
>>
>>>       spin_lock(&bo->bdev->lru_lock);
>>>       ttm_resource_add_bulk_move(*res_ptr, bo);
>>> diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ 
>>> ttm_resource.h
>>> index e52bba15012f7..3aef7efdd7cfb 100644
>>> --- a/include/drm/ttm/ttm_resource.h
>>> +++ b/include/drm/ttm/ttm_resource.h
>>> @@ -442,10 +442,14 @@ void ttm_resource_init(struct ttm_buffer_object 
>>> *bo,
>>>   void ttm_resource_fini(struct ttm_resource_manager *man,
>>>                  struct ttm_resource *res);
>>> +int ttm_resource_try_charge(struct ttm_buffer_object *bo,
>>> +                const struct ttm_place *place,
>>> +                struct dmem_cgroup_pool_state **ret_pool,
>>> +                struct dmem_cgroup_pool_state **ret_limit_pool);
>>>   int ttm_resource_alloc(struct ttm_buffer_object *bo,
>>>                  const struct ttm_place *place,
>>>                  struct ttm_resource **res,
>>> -               struct dmem_cgroup_pool_state **ret_limit_pool);
>>> +               struct dmem_cgroup_pool_state *charge_pool);
>>>   void ttm_resource_free(struct ttm_buffer_object *bo, struct 
>>> ttm_resource **res);
>>>   bool ttm_resource_intersects(struct ttm_device *bdev,
>>>                    struct ttm_resource *res,
>>>
>>
> 


