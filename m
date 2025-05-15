Return-Path: <cgroups+bounces-8214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA64AB8A4C
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 17:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BD8A07AC4
	for <lists+cgroups@lfdr.de>; Thu, 15 May 2025 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3039D1F8691;
	Thu, 15 May 2025 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlHWVk82"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5971E13E41A
	for <cgroups@vger.kernel.org>; Thu, 15 May 2025 15:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321475; cv=none; b=KwCYPwAdg5MwZ3a0+rJMdIuAqvuhk6+5XsVLgK0SraLXBHIsMYXpgkPnthExi1nJN1We6cEO43uQEGib1l9WufdZOaa/TZ2NehdwJ4VzGm8ZrYx5CceM2m/qcwDNLltggiyxxgsYT/4L5vKRdcq4TBGhC/Dw13Ek/GptLHXlpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321475; c=relaxed/simple;
	bh=t9PySZ0VBU1axL/lXcwGk0yZ3wHp57t23ggTR737eSw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=of9TSgiTasXfveAT9CjTd4Z1bIv+2AtvhXxHEXJ1nvt0UPavgPyoYiMSesAxnBpX0d4nVI20HAWzzS6rn4fHMCDDmuV9MZMMgBLUzUnO+YMJgICY9GatkPHuBbp1s/vTptOBL/BlqgqiGUvy97qt0m7e92ubMSXXBH3x2OyEsSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VlHWVk82; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747321472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Be4KEquqHLgMFgrTaQhow/F5UFD9Qx8DOcirjEfZuRY=;
	b=VlHWVk82ZjREgfvC5+sOX+BRwe1bqTWRR63M84+aeWRmcj+IR75XFaClxaPRKgoa5KAALH
	Ul5YzqzpWwxfJZVwMygIB+aEz4+FEzPa6V+66Mh/TONx4t0v03SSu9v6wEJdfq4wwMFIms
	hYTLFuqLtSHEhkLjrPpWKXs23CBtGXI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-KFTNZkEbO4iUxj-_5ZtNeg-1; Thu, 15 May 2025 11:04:31 -0400
X-MC-Unique: KFTNZkEbO4iUxj-_5ZtNeg-1
X-Mimecast-MFC-AGG-ID: KFTNZkEbO4iUxj-_5ZtNeg_1747321470
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-476623ba226so16179281cf.0
        for <cgroups@vger.kernel.org>; Thu, 15 May 2025 08:04:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747321470; x=1747926270;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Be4KEquqHLgMFgrTaQhow/F5UFD9Qx8DOcirjEfZuRY=;
        b=mYOYPFDj131qGBPtoSRsuh4ueyxlQ+BMAxYLsA5zsOw9wvTmNivzrYPnefaLMt/WPR
         mtYYIgn4YJiOxNhkIy52BEGsVeN9lg6LnwhbBSPfoC087U1vTbXu5UxjZlAEoCwwR427
         rJVh0R/sD4hWZlWG4GTgo93BNn7gCC52KGlZTY13/GFVDjjwgEWdrpC60ATbXDtigwPl
         LyFBrb7jFF4cQ7gVlUWG6xLuFR/cjIvPEFTWe+PTLi4uC62iK5ZKcUXwhH79cHKwSUq9
         9rPCeNvQ/Kb6vh34iwUotSVPLpHNRpAxQAKuELZK8LeBxVi3BD8j4eVSx2c6MthkXAbb
         OahA==
X-Forwarded-Encrypted: i=1; AJvYcCV5FTmNvHRRKDMqv02cKZ2CyhF4zgQ/tOuNCj9rq5GF2Fmoitmn8zoZuYSRQfWHuYU9yYj+UnL+@vger.kernel.org
X-Gm-Message-State: AOJu0YxnOxPEfSNGAAQL6S/hlZpXFE0XQ7YsSMkHKwXAyxJMZeOvTp3K
	jciUeE9Sn/vz1DZI8j2dpJEANhjDpkx/7EAv8nP18yiAuOxbwqiX+S2zu7+wzniIJ/pcLrN75f1
	TpIB0GEXkSgkpGIfGeHCKNue3YlE1EFXQmJCdtCWD9hSH9qfXUN3SU24=
X-Gm-Gg: ASbGncsj2vYoIPsBGKFHPh+QaIDM8w0cV6lunp0dZsFHxOcTs6mvEQvwU/vRCzLnRdZ
	n9mXHhsag0af1vmkjIjl9fGEjZSSi8wZzRz+vdbWo9bIK+Q+hpKNZNJ22ZJNDI4EdDP4sF5Jqqf
	rA5iP1pF5qrqmbchsBpbfOgrtjBpOg37+2LojeEQCQvcqeDQUBIEiRNFrh/Mzyu7Q+SPL4tAnux
	VpmcisyzmOqNfJKxrVf/fL7aMhOriEYYUJQ9u8OvvZOQS8LsDVDKIoM2TP2turWX3eqUkKHs1IS
	aUw+1PEKiAIOwbaCLVxY1WeIpZLRY+f89+wckR5tqYpkVbk19llLIHFHmg==
X-Received: by 2002:a05:622a:22a6:b0:48a:6af8:58a5 with SMTP id d75a77b69052e-49495cf9359mr115871531cf.29.1747321470128;
        Thu, 15 May 2025 08:04:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHw/c5TKHyoij8GGYCAmY2jQxbRtsvyzNfyutXVO25tG8IdumpngugYMLx+TE/G1RpwhKqcYw==
X-Received: by 2002:a05:622a:22a6:b0:48a:6af8:58a5 with SMTP id d75a77b69052e-49495cf9359mr115871051cf.29.1747321469430;
        Thu, 15 May 2025 08:04:29 -0700 (PDT)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f8b08c024fsm234256d6.65.2025.05.15.08.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 08:04:28 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <4ec2dd5a-3cdb-48cf-a459-4d384a48c671@redhat.com>
Date: Thu, 15 May 2025 11:04:27 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 cgroups@vger.kernel.org, simona@ffwll.ch
References: <20250502034046.1625896-1-airlied@gmail.com>
 <20250507175238.GB276050@cmpxchg.org>
 <CAPM=9tw0hn=doXVdH_hxQMvUhyAQvWOp+HT24RVGA7Hi=nhwRA@mail.gmail.com>
 <20250513075446.GA623911@cmpxchg.org>
 <CAPM=9txLcFNt-5hfHtmW5C=zhaC4pGukQJ=aOi1zq_bTCHq4zg@mail.gmail.com>
 <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>
Content-Language: en-US
In-Reply-To: <b0953201-8d04-49f3-a116-8ae1936c581c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/15/25 4:55 AM, Christian König wrote:
> On 5/15/25 05:02, Dave Airlie wrote:
>>> I have to admit I'm pretty clueless about the gpu driver internals and
>>> can't really judge how feasible this is. But from a cgroup POV, if you
>>> want proper memory isolation between groups, it seems to me that's the
>>> direction you'd have to take this in.
>> Thanks for this insight, I think you have definitely shown me where
>> things need to go here, and I agree that the goal should be to make
>> the pools and the shrinker memcg aware is the proper answer,
>> unfortunately I think we are long way from that at the moment, but
>> I'll need to do a bit more research. I wonder if we can agree on some
>> compromise points in order to move things forward from where they are
>> now.
>>
>> Right now we have 0 accounting for any system memory allocations done
>> via GPU APIs, never mind the case where we have pools and evictions.
>>
>> I think I sort of see 3 stages:
>> 1. Land some sort of accounting so you can at least see the active GPU
>> memory usage globally, per-node and per-cgroup - this series mostly
>> covers that, modulo any other feedback I get.
>> 2. Work on making the ttm subsystem cgroup aware and achieve the state
>> where we can shrink inside the cgroup first.
>> 3. Work on what to do with evicted memory for VRAM allocations, and
>> how best to integrate with dmem to possibly allow userspace to define
>> policy for this.
>>
>>> Ah, no need to worry about it. The name is just a historical memcgism,
>>> from back when we first started charging "kernel" allocations, as
>>> opposed to the conventional, pageable userspace memory. It's no longer
>>> a super meaningful distinction, tbh.
>>>
>>> You can still add a separate counter for GPU memory.
>> Okay that's interesting, so I guess the only question vs the bespoke
>> ones is whether we use __GFP_ACCOUNT and whether there is benefit in
>> having page->memcg set.
>>
>>> I agree this doesn't need to be a goal in itself. It would just be a
>>> side effect of charging through __GFP_ACCOUNT and uncharging inside
>>> __free_pages(). What's more important is that the charge lifetime is
>>> correlated with the actual memory allocation.
>> How much flexibility to do we have to evolve here, like if we start
>> with where the latest series I posted gets us (maybe with a CONFIG
>> option), then work on memcg aware shrinkers for the pools, then with
>> that in place it might make more sense to account across the complete
>> memory allocation. I think I'm also not sure if passing __GFP_ACCOUNT
>> to the dma allocators is supported, which is also something we need to
>> do, and having the bespoke API allows that to be possible.
> Stop for a second.
>
> As far as I can see the shrinker for the TTM pool should *not* be memcg aware. Background is that pages who enter the pool are considered freed by the application.
>
> The only reason we have the pool is to speed up allocation of uncached and write combined pages as well as work around for performance problems of the coherent DMA API.
>
> The shrinker makes sure that the pages can be given back to the core memory management at any given time.

I think what Johannes is suggesting that we can have a separate cgroup 
just for the memory pool so that if the system is running into global 
memory pressure, the shrinker can force the uncached pool to release 
memory back into the system.

Cheers,
Longman


