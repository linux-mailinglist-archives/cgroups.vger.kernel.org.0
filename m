Return-Path: <cgroups+bounces-8297-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F3AC00C6
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 01:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EE49E1612
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 23:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBC923DEB6;
	Wed, 21 May 2025 23:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czWr4DEJ"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119E8DF58;
	Wed, 21 May 2025 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871226; cv=none; b=i5IdSAHGWLINdhLZ+illMUAwuLymfHOMDwMEcMAvxtIMnKdiX1aRyXSkjL5DP5mhZjnxBvH2tHbrU48m+d3L+0p3kEGgy+RDocQv+fXfvmGdEtn8+k4258XGM79JY1UojEVJKe5eNc6WFPTrNG6UJvPvgOYZLYq+rRAjyOnVuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871226; c=relaxed/simple;
	bh=otohYz3W4Xd+tXFfw8N4x3gMATB9y/rlP1PXTEN17M8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLLzE8Hc11VkxjUmugKh5EBXihhNKtzRTj4cBHdmq1l9quxouFcOLmfnYG+eq6c6yQU86upeZdDrVVnfaf5n0IWq5rdIZggTndpdmvTfplowt/4Phg093Yu/AnVfXY8DMXZWGvrtxskNfAj6zinixaMuzskSSVbYaa5HkZwFdW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czWr4DEJ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-742b0840d98so4315447b3a.1;
        Wed, 21 May 2025 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747871224; x=1748476024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sRl5UoFXBWBhlff+4RMnGLgcFMuNhbpLtXyzr1qDabc=;
        b=czWr4DEJoHFKvQ+dltl30DQ5Cs7DdmufWwBas/5OYStQuuOgNBHFugtqjtOYNrkj8O
         WjEFGsXGSLe3zlFFZ5rdQ49FRqn8r5U6EXMXflFS2o3FBecoJSBY/P42/eBCCM7SMGxN
         87GVt+iF8fnpxxFWQkJTu1cnHRW6LB3LzfwdKeA59WZBdTJqACcWSjUoDCbH7gFDwe0Z
         qb+omtEP9/xGlQzdDPb4x2KXUfzUnl9iwMaI2hNX1+Of6+ODlj1efeDENmF/qNBpRofa
         oHJyRKsW5PDn2xJ5dhGhnbQFu9z9poqpGTxo6VIEQZh0X28CcJde8Kq9k1RH+lVU4lcX
         vqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747871224; x=1748476024;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sRl5UoFXBWBhlff+4RMnGLgcFMuNhbpLtXyzr1qDabc=;
        b=LinsENw9KAjzTmDjOBlnRKj1ZM6k+OD3T22n7huOa3w+HLXhUdp/FMVhl2RSDW3ZrS
         b6elLOGx1VAVCMpuquIslv6lMqK+/kbFHDfAUn1emnUGvcsUKlsmR7Tcoq+9rKWZ9tbZ
         SHR0ne6uie/CE+2sCep+rhkTZ6xSSktFovD4fx3Fj9bH1NGm5TeVymd8aLPWd0nBeyWJ
         jwpmWn6H2z1CS5StxJWVwq4UgJ8v1oaXWom54SsCvNt2uemkuxOm0KBVf9i5DBNNiJWI
         TRsa/KBAZw1w4+iKvFOEyJt70I7KUtyaMBU0STAZ+O8yVbEScZdwMBqGxsyk9O0Bi6UK
         Kuiw==
X-Forwarded-Encrypted: i=1; AJvYcCULEoxe1VBpvFuJHIi9tROM2CTDsCYfTsw6B4ix/zyZR/ePoyXFroRQRmHrI8ZDaboJkg/pycZGOJCg2neb@vger.kernel.org, AJvYcCWl3T745wym0fLZtqO/QoA6hJN8iDZthawrBmS3msG0JAmGqjulmPsGlJcoFE8r6m4y9NY=@vger.kernel.org, AJvYcCXCqxxVJFr1wDHblqCaTNL6zUrFM9yyeqH551k14iCYKAwWUk7zFJwMkutWxbFgwVKjNgZZ4KCf0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx83+4fsJmTNSjgPIt6FZ5jNq/tf2PeDbBYlXjJhJNKC5suC6Ks
	LHcQajOaNxlT52GgXCFGgcT9QoiWufr63+ZjME2101VJE2bpdpBtqigv
X-Gm-Gg: ASbGncvlNd5v4r9wyk4scPzSuHllyecsERRJZzl2K2Ljiz2dF/ylGd94Zkg0Xg+77FV
	K2J+GVr5QOGWUVHaZd9sr8QdDW7ZruTwQ0RcKeuW3/IG/Ig85kO3TaV24EiVirABMSmDyS5Affo
	CCYBwevqSLtkK2vI/nNq1aiX2vS5xg/A/B2LKUQjEpBmQ5OkfqhDSIQ+IMhVvZsUgmE6ar5M/0v
	OmcAIyp4mPjrj1Dc+ch/yzg3dNrptPiZAwICfv8MFEB7cxF0mgO7NP1aKWsd2gaWdGgLsY8aY7f
	0BdiOYxgDf4YXQ8CGLc15W0jkGbdRGc5gQyoXv7ehb5e2ViIhpXwKpYm/1kmUixHTZj+KRV/y6r
	0qEiCXPnM95uRDoEBWSeNQw==
X-Google-Smtp-Source: AGHT+IFpmGP8PXJrewf0QIOeukhOjrHtY0pSwwTqGyQPEVHBdRSkaE6V9yXrLL5dYQILdBR8dfXnIg==
X-Received: by 2002:a05:6a20:c6c9:b0:1f5:7710:fd18 with SMTP id adf61e73a8af0-2170cc70700mr31020612637.17.1747871224143;
        Wed, 21 May 2025 16:47:04 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829b9dsm10117474b3a.88.2025.05.21.16.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 16:47:03 -0700 (PDT)
Message-ID: <9151095d-98dc-4497-9a64-b2eb7f8f96ea@gmail.com>
Date: Wed, 21 May 2025 16:47:01 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks to
 avoid contention
To: Shakeel Butt <shakeel.butt@linux.dev>, Klara Modin <klarasmodin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosry.ahmed@linux.dev>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, bpf@vger.kernel.org,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Meta kernel team <kernel-team@meta.com>
References: <20250428174943.69803-1-inwardvessel@gmail.com>
 <20250428174943.69803-2-inwardvessel@gmail.com>
 <ad2otaw2zrzql4dch72fal6hlkyu2mt7h2eeg4rxgofzyxsb2f@7cfodklpbexu>
 <gzwa67k6i35jw5h3qfdajuzxa2zgm6ws2x5rjiisont4xiz4bp@kneusjz5bxwb>
 <a6le7a3gzao7acxzo4i2sfnoxffmz2vhd34gzlgsow4uy7lv6k@tigt33bel4fi>
 <netbpt5aylanmxb6pxdvvkgket7hjbtxyjyceb6h6v2yyr4tcd@rc5zbyhsms2e>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <netbpt5aylanmxb6pxdvvkgket7hjbtxyjyceb6h6v2yyr4tcd@rc5zbyhsms2e>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/21/25 4:33 PM, Shakeel Butt wrote:
> On Wed, May 21, 2025 at 04:23:44PM -0700, Shakeel Butt wrote:
>> On Thu, May 22, 2025 at 12:23:44AM +0200, Klara Modin wrote:
>>> Hi,
>>>
>>> On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
>>>> Please ignore this patch as it was sent by mistake.
>>>
>>> This seems to have made it into next:
>>>
>>> 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
>>>
>>> It causes a BUG and eventually a panic on my Raspberry Pi 1:
>>>
>>> WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2))
>>> illegal size (0) or align (4) for percpu allocation
>>
>> Ok this config is without CONFIG_SMP and on such configs we have:
>>
>> typedef struct { } arch_spinlock_t;
>>
>> So, we are doing ss->rstat_ss_cpu_lock = alloc_percpu(0).
>>
>> Hmm, let me think more on how to fix this.
>>
> 
> I think following is the simplest fix:
> 
> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
> index 7dd396ae3c68..aab09495192e 100644
> --- a/kernel/cgroup/rstat.c
> +++ b/kernel/cgroup/rstat.c
> @@ -511,7 +511,10 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
>   	int cpu;
>   
>   	if (ss) {
> -		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
> +		size_t size = sizeof(raw_spinlock_t) ?: 1;
> +
> +		ss->rstat_ss_cpu_lock = __alloc_percpu(size,
> +						__alignof__(raw_spinlock_t));

Thanks for narrowing this one down so fast. Would this approach be more
straightforward?

if (ss) {
#ifdef CONFIG_SMP
	ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
#endif

Since on non-smp the lock functions are no-ops, leaving the ss cpu lock
can perhaps be left NULL. I could include a comment as well explaining
why.

>   		if (!ss->rstat_ss_cpu_lock)
>   			return -ENOMEM;
>   	}


