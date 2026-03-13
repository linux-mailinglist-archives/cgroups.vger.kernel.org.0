Return-Path: <cgroups+bounces-14809-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aC+IF34ctGlLhQAAu9opvQ
	(envelope-from <cgroups+bounces-14809-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:17:34 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CA7284C45
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B07230849FD
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 14:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A9E37268C;
	Fri, 13 Mar 2026 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b="KqRmv8xJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7FA33A702
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411095; cv=none; b=kUJmWMtWEoZzwtlf/ou0XoblkL7oFMDV8CkIbh8NU08r3nyIL4MYa8rcjH0a36H8LdrRn6odQAclgcpUID78+z9ytVT+8RonFij1SPKW9bcJZlbbTRlojFtMvkfDQam/9vWySPk6WAQE7fojH7s01N5Stch9TjGMGg8CkOZX96E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411095; c=relaxed/simple;
	bh=t/2amWgQLcHmCxqm8guQT5B+nch5AtnkD5UItqvubJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IhPNJY/HPG+9qzC3ye81We9zH2rIG+CZFjPxElcAN4PPzLKK4Aa+0yxqbAqC6+5RVH/Af4aAE2YPuq7Zmt+Ce2gDZ+SWxObm9StA/6kC3PbjeG2W4oC568nfRM2WiAfsM0OU17l5x/zwTiLl8zMNZZnzboYZOn19Ptom+IuwGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=pass smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin.net header.i=@ursulin.net header.b=KqRmv8xJ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ursulin.net
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439d8df7620so1670698f8f.0
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 07:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin.net; s=google; t=1773411092; x=1774015892; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LafAaegGRU7i9rzjjUW1sBiK+ZDukEKzI9QIgeF8Beg=;
        b=KqRmv8xJZj4Lt6y/xbJfG9KIKIb22JSNFd2CvCdl0+CVJ3Z1vH78q/Q/WVdGvNJJxm
         eKKVXt3by5FPIxU5MikVwdd1ks7D16tOGaoI+wiV1eJaPT2LhUAdeRAJ/sDR1CoO7Lb+
         jWJQzXnpBG/6ARe1oJXjSMsfYFlq/UAs5tTy6OsY2T8ZHWsKTntYBXDzKOoaefDcOkM1
         BV454U4qjvPCpzYgtWe3c1jyv3DgrxCNuVZyA3984sdcyeYKOLIF2TWok4gdqwHU8B5k
         Uz4kb0xK+VuQXPX8ykCTM06zzAxeBns0u4DM/spFdLipOqJ51NpTndZfln5Esr0cwF5c
         0ENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411092; x=1774015892;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LafAaegGRU7i9rzjjUW1sBiK+ZDukEKzI9QIgeF8Beg=;
        b=iBqxxFT5fGrhS5Hdy0W+zJho+CKCKDMnN7Ltew4x33CDy1nl0DcJxe7ZlBQ8tWFZIR
         xgluHRVqe0jcUxXZB2IGVWHHDXZ1Q9Ykii+JuLmpezLhy46F0+vkJ0cKVmvzcUmXV4hF
         IoqlnDECwog9SINgpdlH7pI5FrD82qs/NqPhJLyuulk/vxGMuHb7kka0gwy9iuX6PEXI
         f4hgV9+kWuJv1V4dHDzQcdmwzHrZLi4w3A22B/KydMWTqQ0au4wrdh8py6YTkEVN3Tcm
         5pN+46F/BMhvntS/XbweAP6VfatBMgH1/m4iBEYFVdoP8XDlB8OpBLyl/41g8ghEljaR
         Jrig==
X-Gm-Message-State: AOJu0YyrweWFWJst9SH9rxRcdRTWTKKJYAji6nVmom/6vLvhgzPqVExh
	G3Jo0k12ejAapu3Az+5WuguMal7AFmkoCmcp+WJXgDHhXaM/Smep/iBjl8H84OlliXY=
X-Gm-Gg: ATEYQzw4nyaVltO4vRKC5BsZFBewUGlxvlgESJM5QuvcFiACSHdwNIclCqBFOLe1PXa
	x9CVHxPZopUOZ41eRvMS6vVpPdpm1Qu3jIKjDfUIzMhhDQzFjYU9PVqA14Du3JLjRs3mcs23ZRE
	+yzuFgP3p30lVPOdtLQYPml+KoW+NHNh8Tz0KN1WWTclYxbkN2uFs6b3+3H9/FM8efIYKNfoOmi
	Kb0G4IyuXMCJnLKNAo9Z/Sfcny7CC8/LVtvi158ertRKulEGYew620YBAzAJlSs1Pb1Eh1BLpxD
	iySDhDLqV0NCzJdT+kl0jHvcPL0FLvcBqXipXihlNzz8LlLSt07pg76DwnvJoFVwyiqzRuvgMGm
	y91pJ06K7eG+viU6l2S/bwAzZ2OvPG1Wvpm/5iEqr5nyAzG444qmS3l1pSCX72PWKTImOxX7G+L
	rVaxV1rMnUJ+sn1Lk5w1edKNYk/KO0pFxlAa7Y41KCyLqF
X-Received: by 2002:a05:600c:5247:b0:485:3c8f:e4c5 with SMTP id 5b1f17b1804b1-485566fcaaemr55645355e9.17.1773411091876;
        Fri, 13 Mar 2026 07:11:31 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a732cesm21788415e9.12.2026.03.13.07.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2026 07:11:31 -0700 (PDT)
Message-ID: <cf522bc4-09ef-4e19-afc4-2c8a9d8a1abc@ursulin.net>
Date: Fri, 13 Mar 2026 14:11:30 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] drm/ttm: Use common ancestor of evictor and
 evictee as limit pool
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
 <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260313-dmemcg-aggressive-protect-v6-6-7c71cc1492db@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ursulin.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14809-lists,cgroups=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ursulin.net:dkim,ursulin.net:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: 20CA7284C45
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13/03/2026 11:40, Natalie Vock wrote:
> When checking whether to skip certain buffers because they're protected
> by dmem.low, we're checking the effective protection of the evictee's
> cgroup, but depending on how the evictor's cgroup relates to the
> evictee's, the semantics of effective protection values change.
> 
> When testing against cgroups from different subtrees, page_counter's
> recursive protection propagates memory protection afforded to a parent
> down to the child cgroups, even if the children were not explicitly
> protected. This prevents cgroups whose parents were afforded no
> protection from stealing memory from cgroups whose parents were afforded
> more protection, without users having to explicitly propagate this
> protection.
> 
> However, if we always calculate protection from the root cgroup, this
> breaks prioritization of sibling cgroups: If one cgroup was explicitly
> protected and its siblings were not, the protected cgroup should get
> higher priority, i.e. the protected cgroup should be able to steal from
> unprotected siblings. This only works if we restrict the protection
> calculation to the subtree shared by evictor and evictee.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>   drivers/gpu/drm/ttm/ttm_bo.c | 43 ++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 40 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index 7300b91b77dd3..df4f4633a3a53 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -628,11 +628,48 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
>   {
>   	struct ttm_bo_evict_walk *evict_walk =
>   		container_of(walk, typeof(*evict_walk), walk);
> +	struct dmem_cgroup_pool_state *limit_pool, *ancestor = NULL;
> +	bool evict_valuable;
>   	s64 lret;
>   
> -	if (!dmem_cgroup_state_evict_valuable(evict_walk->alloc_state->limit_pool,
> -					      bo->resource->css, evict_walk->try_low,
> -					      &evict_walk->hit_low))
> +	/*
> +	 * If may_try_low is not set, then we're trying to evict unprotected
> +	 * buffers in favor of a protected allocation for charge_pool. Explicitly skip
> +	 * buffers belonging to the same cgroup here - that cgroup is definitely protected,
> +	 * even though dmem_cgroup_state_evict_valuable would allow the eviction because a
> +	 * cgroup is always allowed to evict from itself even if it is protected.
> +	 */
> +	if (!evict_walk->alloc_state->may_try_low &&
> +			bo->resource->css == evict_walk->alloc_state->charge_pool)
> +		return 0;

Hm.. should this hunk go into the previous patch?

> +
> +	limit_pool = evict_walk->alloc_state->limit_pool;
> +	/*
> +	 * If there is no explicit limit pool, find the root of the shared subtree between
> +	 * evictor and evictee. This is important so that recursive protection rules can
> +	 * apply properly: Recursive protection distributes cgroup protection afforded
> +	 * to a parent cgroup but not used explicitly by a child cgroup between all child
> +	 * cgroups (see docs of effective_protection in mm/page_counter.c). However, when
> +	 * direct siblings compete for memory, siblings that were explicitly protected
> +	 * should get prioritized over siblings that weren't. This only happens correctly
> +	 * when the root of the shared subtree is passed to
> +	 * dmem_cgroup_state_evict_valuable. Otherwise, the effective-protection
> +	 * calculation cannot distinguish direct siblings from unrelated subtrees and the
> +	 * calculated protection ends up wrong.
> +	 */
> +	if (!limit_pool) {
> +		ancestor = dmem_cgroup_get_common_ancestor(bo->resource->css,
> +							   evict_walk->alloc_state->charge_pool);
> +		limit_pool = ancestor;
> +	}
> +
> +	evict_valuable = dmem_cgroup_state_evict_valuable(limit_pool, bo->resource->css,
> +							  evict_walk->try_low,
> +							  &evict_walk->hit_low);
> +	if (ancestor)
> +		dmem_cgroup_pool_state_put(ancestor);
> +
> +	if (!evict_valuable)

This part is probably better reviewed by someone more familiar with the 
dmem controller. One question I have though is whether this patch is 
independent from the rest of the series or it really makes sense for it 
to be last?

Regards,

Tvrtko

>   		return 0;
>   
>   	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk->place))
> 


