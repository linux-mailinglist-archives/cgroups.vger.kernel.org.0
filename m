Return-Path: <cgroups+bounces-14808-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OORVM8MUtGlkgwAAu9opvQ
	(envelope-from <cgroups+bounces-14808-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 14:44:35 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4699D284237
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 14:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E13EE313A124
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B153A257B;
	Fri, 13 Mar 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="IKvUhoWE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625E258CD9
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408553; cv=none; b=Ehg9KUPb/CBC01QsgxgAE/Y8IaOJ4zXOahYbfRYeDLGVOrpUZYCbxDGwpdX68YxWTxeJADWPtb/8r+26XoCNV8qNCcCmMSMhSmqzMHjJXeEt5SeXyrQiZTJ2lCelTqOqzAT2tuLQOxquDyEQ6B1adNQafe5thSi1YnKtBoWcNLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408553; c=relaxed/simple;
	bh=LZXIYkuKtyK+BFFxd5GBr9JATiQaB0j+unkXzepFu5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cvo2gn+YCGByUJT7/OHvJaucfMjJcIoXTK8ry2eE5yo5dVo3Z9Z6sZkwOgGj5cm6m3yGV6BMCDAgPcsrJdREXzHh3YvPhBrzjtB573Nsag5ew5LqX/xJ8RmnCWAUTAOhT10gNOpH12Ca4Q90v+ifgecrBk/jNedyWGIaxA0AtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=IKvUhoWE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso32935385e9.0
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 06:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1773408549; x=1774013349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRHdwoAhh6Z6VJ1IOXt8YpVwRbA24oij+up+nK+z+qQ=;
        b=IKvUhoWEk3RakNWb21z+2xcQSmUld2HDymWVjETUryIpxvAn8Rm1QclPnZDVpUH43K
         fiLVRIPGoFJyIJxpuRsNZgLuqpUIXQHPp9OVDNTVudgkK/VNDzGd8vFBwJ1cFFYRM9FJ
         LP5Bmo79Fz/iCuwft5/lFrqSgdbVppA31aMnyHMQ9nDlXwiZA8NnzLUlwSjbaut8WQIL
         nxvV3tP9l/n7ECcY4fN4/QfzQguIcmrP4EzgSyzJz0GXRbJU6ybFjOP2qItK+UaC7wYY
         m7hFdXPeB+A5IV6j/JYkfUAQBsHwrFKvq6fa27L8UHLE6QRvvSNdYWnLYnlFILMg961n
         9a8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773408549; x=1774013349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JRHdwoAhh6Z6VJ1IOXt8YpVwRbA24oij+up+nK+z+qQ=;
        b=GyLa2/KFlqWRTJkPABnwbWwqTGrYpt+uxDxjKWLbMbWRk530JF7AOqQw39g5EyWIex
         dfLEauttHDWUMVOYF5erdzLgjNpOD/VvYSf0I+TrpZbig8DMlOxppHmSaFysTFBLPBtE
         FTb1cbbwMLWcNAkI5fOlZt8B9QuZXNKw5XpB4vdEQx1Dd7gbnfpYL7UnIf1ChxoOMf3g
         lTUwTokvkRGwpuryFMeHOn5rzV3MPrIAVpEnmnfddAN4dBLyUk2GQoPgfUBEsGe+so2b
         UN8y1p36W7fL40WiurTumBARHQ9ICB5E/yU9K35SKKjI3Cu++cta/rl7h1tv29MYJQoY
         O+og==
X-Gm-Message-State: AOJu0YyExijiB2+Ydp/dpkhxvw3EMG9Rwu7AtjJEl7xHa7DxN7Gx9jio
	y6Pzkuxdci9hBYBYbim3NXUKKgg6lVsaI+54eThq9SfACOvr6lwf80/0oVOLcZtWngE=
X-Gm-Gg: ATEYQzw5+OqH5AJDNuiw11+NEoBhtSic4Y3N9+eO+CWUSW2OOiOKijaIkpMPQQIVekg
	H7wjA8ggL144gxRUx8UF/ZRD0pxOEEBXxfbw+vBDHRXlzRnC947M3ubJRFMnxhgxawY+v3fYrsA
	vQ1KzwGeS+3j+0YYhKrLmP2qUWk4vnd9DwKzgmDvZniXs8Swvz9C/1wQWDlYnYwEXgrdgyZyFgI
	uMnHW0fPBBjsyFBpZUbsjQcZlnvXkOS821Z0qNh/XZefWOdyc7gEQNR0iMI2JzgFg0OqLqSjywR
	F5lFigTkx+QqpsXxa0FOKm2jF42ybS7nZNTcIra0gsKELlFh5mhvOLznTg3c190AOYVRnJE8A6N
	G8iWUQzMSd8jGu8zje+mun6vKeF4oxlFI13vK526EmCpk8UhPOPLvjvQEHp0ozyTdaT3mrlQGoQ
	aNZYHL+P9E6nTrGBpr8FRirNWnYNp9+O7OrOpszbadkPV3
X-Received: by 2002:a05:600c:2295:b0:483:a2b0:d210 with SMTP id 5b1f17b1804b1-4854f56d693mr91452245e9.7.1773408549051;
        Fri, 13 Mar 2026 06:29:09 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20bb90sm18046479f8f.19.2026.03.13.06.29.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 06:29:08 -0700 (PDT)
Message-ID: <c1b8d304-09d3-47cf-a314-4a8777b85e6f@ursulin.net>
Date: Fri, 13 Mar 2026 13:29:07 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] drm/ttm: Be more aggressive when allocating below
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
References: <20260313-dmemcg-aggressive-protect-v6-0-7c71cc1492db@gmx.de>
 <20260313-dmemcg-aggressive-protect-v6-5-7c71cc1492db@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-5-7c71cc1492db@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14808-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 4699D284237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13/03/2026 11:40, Natalie Vock wrote:
> When the cgroup's memory usage is below the low/min limit and allocation
> fails, try evicting some unprotected buffers to make space. Otherwise,
> application buffers may be forced to go into GTT even though usage is
> below the corresponding low/min limit, if other applications filled VRAM
> with their allocations first.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 51 +++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 4adc9b80cba4a..7300b91b77dd3 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -496,6 +496,10 @@ struct ttm_bo_alloc_state {
>   	struct dmem_cgroup_pool_state *limit_pool;
>   	/** @in_evict: Whether we are currently evicting buffers */
>   	bool in_evict;
> +	/** @may_try_low: If only unprotected BOs, i.e. BOs whose cgroup
> +	 *  is exceeding its dmem low/min protection, should be considered for eviction
> +	 */
> +	bool may_try_low;
>   };
>   
>   /**
> @@ -545,6 +549,42 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   		}
>   	}
>   
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
> +	if (!alloc_state->in_evict) {
> +		may_evict |= dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
> +		alloc_state->may_try_low = may_evict;
> +
> +		may_evict |= dmem_cgroup_below_low(NULL, alloc_state->charge_pool);

For some value of optimisation you could combine the two calls of 
dmem_cgroup_below_min/low into a single helper which returns both min 
and low, given how it is the only callers, saving a pair of function 
calls and tree traversing calculations. Or.. I am not sure if simply 
exporting dmem_cgroup_calculate_protection() and making it return 
page_counters would be okay, or a copy of them, or a new data structure 
would need to be added.

Anyway, that can be discussed separately. In the meantime this patch 
looks good to me:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> +	}
> +
>   	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>   	if (ret) {
>   		if (ret == -ENOSPC && may_evict)
> @@ -657,8 +697,12 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	evict_walk.walk.arg.trylock_only = true;
>   	lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   
> -	/* One more attempt if we hit low limit? */
> -	if (!lret && evict_walk.hit_low) {
> +	/* If we failed to find enough BOs to evict, but we skipped over
> +	 * some BOs because they were covered by dmem low protection, retry
> +	 * evicting these protected BOs too, except if we're told not to
> +	 * consider protected BOs at all.
> +	 */
> +	if (!lret && evict_walk.hit_low && state->may_try_low) {
>   		evict_walk.try_low = true;
>   		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   	}
> @@ -679,7 +723,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	} while (!lret && evict_walk.evicted);
>   
>   	/* We hit the low limit? Try once more */
> -	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
> +	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
> +			state->may_try_low) {
>   		evict_walk.try_low = true;
>   		goto retry;
>   	}
> 


