Return-Path: <cgroups+bounces-14521-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JrKBR3EpWnEFgAAu9opvQ
	(envelope-from <cgroups+bounces-14521-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 18:08:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC25A1DD8B1
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 18:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0F1C30039B5
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 17:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C865B425CE3;
	Mon,  2 Mar 2026 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="oTCdo1BH"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA152EACEF
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470925; cv=none; b=EiVDCHYLgKdGmggxh3mwIh7Y08rcuzHTB+cJqUZM+UJT9h0uIYr3oMVwuB/8YKRpWZpL9z4hOyxA0tO+NhlZ+S67zhdlrANK/5rBmsJeD+j6mYNbseUfapMEaf1zVDxC/IpCiPrgCJO9Oe0ftuvvtpjpJ0/VWkT7/XdHa824ChU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470925; c=relaxed/simple;
	bh=BRAy7ZbLCiGT6dhJwyaFJ80rqHQpZxSDm2do8couWGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC1+xDP2jCETNeqolhTxv1ifMSCe++HwAFjPlF6544QmLBAvNZmtsJMeVxEQDcjsYVEpd1zTXctpweVWveSmx20b1/4NyMZw02B4nyGxDFWlZoW24nChLi//YWXlMAbIL8Fe/5ck1vgWJM00tmC2MjiTWG809y24e1nhr4/iFek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=oTCdo1BH; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65f771c6b89so6914866a12.3
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 09:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1772470922; x=1773075722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKMuMJCSdxxmw3RSD5uAPmfVmq1uYJz0WuSv/dBgVQs=;
        b=oTCdo1BHAaV/nl+Ed48jCxZ7xT1RTEH7MjiG2rdyVGKxCUKmxePsre0TKLMvejSZD6
         RqK1tIHD2SEMHnzy+vOjgT9ByEHT/w+Zj6UjEUC04ddHWUkfePvDF6Iu15v7wRSNNr35
         FksBA0Cn8jG0ceOn9JYTuTHIobglEaNQ37echN7jNg0pQSjNYWx3pJV4odoiN9HT0hz6
         GWwV3g1cWc2SJBvY9yyunmcgEDSpHYYhhzAt81P3xdwDuLH8PPP8HpBz3oCR2+c9jXRt
         5pHAaizsW6EXJ+eOrd4ImzRIXGHh0Y+C+29QNh/sknqxqCTSnZT4vryvSro40Ho3jK3W
         /vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772470922; x=1773075722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKMuMJCSdxxmw3RSD5uAPmfVmq1uYJz0WuSv/dBgVQs=;
        b=T/q/kiy0J0fJNu6n+mREkOwBlLXn1QGt7Pv/0ESdpvHsqZJDe2kMJJykS/WApouz5K
         cFM1tTzfgzx25ABNqu4Fhfb5eWHZHhbiV0QGvmy2uGcYQqkd7I1QZ0BNJq3OsvV7KYE/
         ospCrCVkYsQFpzL1DfxVnJd7hXjooTZhT19mUzquCZEoBCR9f4XRyM+qUT0SyQ3Ocx1L
         GmFvgZAPh8iD+1gXEJJc54Ac957dDn38enaxAsSLLklqjYXlSh4Ya1We4VbhL7KT7nu5
         cl/e3OJ1+vEqff0chJFKCZZYQmRfDShNn+iOpaKRUL9pqXCQfCmcCcSId9Suq1b8w4sA
         prDw==
X-Gm-Message-State: AOJu0YwkDkWnjUzpCyrKtqKpzPQoiDfv3hJ92HmpQsJfZLTaCydy5RsN
	7av5Jf5zNuCz5/BkfXCf+OZg+kPPkl+izj2KEyz9dzTiRJOMdYRw9tIgh5G2cILEDN8=
X-Gm-Gg: ATEYQzwt8kXZ/RV0zwVgLFRvKSSxRJK8GAz0BvDdgD9OvvJeTsiJF2GLb+8zVuPtJib
	GPMw4jJovozWz0uESlrZmZt2AvG2qEg7aADNOEfC9CvuRFbnkhbUYozWlR8RXwq3aHzugbb13VK
	RZptuu0Xay2EIE4OBgZTvhGoqbjIAMHRfk3gblCZX+2A9uydRpLuJOQtOZ6UEuFSZJ/578tbPqy
	r+Sy2sNsax2gsqBwU6h1iv8xJ+ZCIGT2AFBU1wvsDBYgx0L8Wa93xkzGSAd0lTCPvOETcL+6nQ8
	Nd8fqHKnhU0+sIwn9CbhCfISpDUlxewNjYI1X/P7RHPqVRfmqweYBapK20Au4SkQAjBr/8cK7V9
	+/An7LaGFHbDwIloERSNdK8v6CabEAgkjZAwTKfUwsAHlCr4OITFHpTA98eRN10bBqiAAAsqDum
	LVcuLbBOBJXjVarIPfad/ty7PiKivA+6e6kQSYrP6J/2VI
X-Received: by 2002:a17:907:7fac:b0:b93:cae3:5832 with SMTP id a640c23a62f3a-b93cae3ae31mr47113266b.22.1772470922107;
        Mon, 02 Mar 2026 09:02:02 -0800 (PST)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b935ac84863sm499538966b.29.2026.03.02.09.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 09:02:01 -0800 (PST)
Message-ID: <86ef0e02-ac40-4bd4-bfcb-173d4312acb2@ursulin.net>
Date: Mon, 2 Mar 2026 17:02:00 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/ttm: Be more aggressive when allocating below
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
References: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
 <20260302-dmemcg-aggressive-protect-v5-5-ffd3a2602309@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260302-dmemcg-aggressive-protect-v5-5-ffd3a2602309@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AC25A1DD8B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14521-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ursulin.net:dkim,ursulin.net:mid]
X-Rspamd-Action: no action


On 02/03/2026 12:37, Natalie Vock wrote:
> When the cgroup's memory usage is below the low/min limit and allocation
> fails, try evicting some unprotected buffers to make space. Otherwise,
> application buffers may be forced to go into GTT even though usage is
> below the corresponding low/min limit, if other applications filled VRAM
> with their allocations first.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 52 +++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 53c4de4bcc1e3..86f99237f6490 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -494,6 +494,10 @@ struct ttm_bo_alloc_state {
>   	struct dmem_cgroup_pool_state *charge_pool;
>   	/** @limit_pool: Which pool limit we should test against */
>   	struct dmem_cgroup_pool_state *limit_pool;
> +	/** @only_evict_unprotected: If only unprotected BOs, i.e. BOs whose cgroup
> +	 *  is exceeding its dmem low/min protection, should be considered for eviction
> +	 */
> +	bool only_evict_unprotected;
>   };
>   
>   /**
> @@ -598,8 +602,12 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
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
> +	if (!lret && evict_walk.hit_low && !state->only_evict_unprotected) {
>   		evict_walk.try_low = true;
>   		lret = ttm_lru_walk_for_evict(&evict_walk.walk, bdev, man, 1);
>   	}
> @@ -620,7 +628,8 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
>   	} while (!lret && evict_walk.evicted);
>   
>   	/* We hit the low limit? Try once more */
> -	if (!lret && evict_walk.hit_low && !evict_walk.try_low) {
> +	if (!lret && evict_walk.hit_low && !evict_walk.try_low &&
> +			!state->only_evict_unprotected) {
>   		evict_walk.try_low = true;
>   		goto retry;
>   	}
> @@ -730,7 +739,7 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   				 struct ttm_resource **res,
>   				 struct ttm_bo_alloc_state *alloc_state)
>   {
> -	bool may_evict;
> +	bool may_evict, below_low;
>   	int ret;
>   
>   	may_evict = (force_space && place->mem_type != TTM_PL_SYSTEM);
> @@ -749,9 +758,42 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
>   		return ret;
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
> +	may_evict |= dmem_cgroup_below_min(NULL, alloc_state->charge_pool);

It may make sense to group the two lines which "calculate" may_evict 
together. which would probably mean also pulling two lines below to 
before try charge, so that the whole logical block is not split.

> +	below_low = dmem_cgroup_below_low(NULL, alloc_state->charge_pool);
> +	alloc_state->only_evict_unprotected = !may_evict && below_low;

Would it work to enable may_evict also if below_low is true, and assign 
below_low directly to only_evict_unprotected? I mean along the lines of:

may_evict = force_space && place->mem_type != TTM_PL_SYSTEM;
may_evict |= dmem_cgroup_below_min(NULL, alloc_state->charge_pool);
alloc_state->only_evict_unprotected = dmem_cgroup_below_low(NULL, 
alloc_state->charge_pool);

It would allow the if condition below to be simpler. Evict callback 
would remain the same I guess.

And maybe only_evict_unprotected could be renamed to "try_low" to align 
with the naming in there? Then in the callback the condition would be like:

  	/* We hit the low limit? Try once more */
	if (!lret && evict_walk.hit_low &&
	    !(evict_walk.try_low | state->try_low))
  		evict_walk.try_low = true;
  		goto retry;

Give or take.. Would that be more readable eg. obvious? Although I am 
endlessly confused how !try_low ends up being try_low = true in this 
condition so maybe I am mixing something up. You get my gist though? 
Unifying the naming and logic for easier understanding in essence if you 
can find some workable way in this spirit I think it is worth thinking 
about it.

Regards,

Tvrtko

> +
>   	ret = ttm_resource_alloc(bo, place, res, alloc_state->charge_pool);
>   	if (ret) {
> -		if (ret == -ENOSPC && may_evict)
> +		if (ret == -ENOSPC && (may_evict || below_low))
>   			ret = -EBUSY;
>   		return ret;
>   	}
> 


