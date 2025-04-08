Return-Path: <cgroups+bounces-7423-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C8BA80BCD
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10BB1BC6811
	for <lists+cgroups@lfdr.de>; Tue,  8 Apr 2025 13:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F01CAA99;
	Tue,  8 Apr 2025 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAl9Fr5t"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CD1C5F08;
	Tue,  8 Apr 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117453; cv=none; b=ZRAXZkn2ARbH3cUqBJG/3M4x2DM1yJsvWwDCaXKT5Tx/v7wejoAr3hWMxxHafMYy9blEFGFMcDtLBNxzz+8vExNIa/2hxiDOo06A6+GTjl8O414lN5U/Nj9cRvXjcvXtwSTvwAXHvHa+wbP0vjo9ZmHUBxX1Qode8uLX42MMeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117453; c=relaxed/simple;
	bh=phvG9LGBV5uu7snUj6raZk7nsiIEVPDHKML9MQ6RgRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJmfdyg3azFDNemkGBsihRdK2W/W080a4acwy1JiDOl6mk8q3Ankfq6DN72kebkF92pfFaMkEv5I9doW5/077c861eStj/fsfA7auI3Vv/+zGDY3lK/ID8Hh7c6x/DzVL++6i00iJVi5vrES3S/niRRzUxgODSnoQ/fm6yK7Pew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAl9Fr5t; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac298c8fa50so927187166b.1;
        Tue, 08 Apr 2025 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744117450; x=1744722250; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=609ZDUaaXCTvHp63HLV78FTKwEGS1VrIa2wh0r/CJ10=;
        b=BAl9Fr5tzHDAPY16tix2yGkHCF4e1zDhdk7MQq1gillR2LATJo7cfMmTPRhlIQETKs
         srwgDyFa3ZdV8xDPqb8V7+Wm5Ni3fza83eMs4mcLll9FRkAVnZAZV9JIE6NqetBuQX8J
         8ST+7moWeQoABRM8pfksnUjkjixloSsIYoF9iSnhM9BSXZhtbBSaJFl9vrEoy5AWTS+O
         jgf2+h2qTcz40reGnUmp4oN155ndr/Fm90aSavIUhMeMU83AIbylnoxdYjXav70CglQV
         xdNttv+xXQN1Eo2Q5ADVLzXSh6/gHgX2/AWEw41hGSQvo/7+pcHGPD2PVX3+VY3oSMQG
         FZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744117450; x=1744722250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=609ZDUaaXCTvHp63HLV78FTKwEGS1VrIa2wh0r/CJ10=;
        b=sb8VZlZfoGdwaTRr4OufnUogMkM8FIx61NdhBhbeF2hbPPUSyqyOtzG/olXfCIdTJ/
         59mk2ERV1olI+eWhhe8gVuyF93geD5LK1kOahnCRswydqTHDQO9kIwmjQDVWRaBVM8kE
         65AChAEUtBWFhfGbHfqdPcFXLGc4x/LQPuAHYR+6XcTYskoE1KMSxH4YZlu4iobWBHGd
         G74+mXgNu47BClSbjCZbM7D3RAcLGDeWlz6Rb68mYa0f2hKBCVtu16pASIl7z8wEu/CH
         ai7xXcBlmkBUirIv1JgZRYqwwRY2MFMOkazc4vU/CKpNsmumEmTqWRcBP/O+4VEnV4cx
         Mg7g==
X-Forwarded-Encrypted: i=1; AJvYcCU37RJOoUJ2z1cfXzC7GbsMTKsCpprVbpLiI/mV5TZRm0cfUgi6PoieyIuw6vc12kZzUAZ3ute6aZA=@vger.kernel.org, AJvYcCWW7s9CAqkyBdOMUQm38lCfKC1lqRTQCZ/2t5sgtj/kzs7IU0urXDDAFi9UhBFjUotkQElfSefieM5/MpvS@vger.kernel.org, AJvYcCWfo2uqdawENiQ9EURX14fgxpJPHacSJeD6jdLaUvl6CpBqP9akyZLiZJK7yW0qRHjVZGLDqsGa@vger.kernel.org
X-Gm-Message-State: AOJu0YwxA/5VR5bNEMfGTyEmt+6kS8PZjUM8z9H9dXSj4MnN1nKUSGR/
	GBgyrJ6TQok/9KFcZ05E9JBDC0hKRvLT+JpTjrykxg3fKmRqcvsN
X-Gm-Gg: ASbGncvgMv0LKmneHiFoH7Uvm919YnTfMv22vO8fZL2D0Y73TbVNH7mtqIeMudHmCLE
	vKFtQrFmtE8mCG0FrwJNMeOYp/yrwn/CMDnumfyAVf3LMysUyHHJUB5RwmXnAKVAjz3LcE7fowg
	lO5GL68iUZRer3vKlNTyiN80ED4FJj51CJTSibAvykUhc9KTHiZrL+XSw6NKwAzQ3bxc5rhrrgq
	NyVBv+0b+8vbprz5B6F4qqb3woFboL3AKgjiJXxYV0u1pNk56kyHmpgBqaFm7PV0oePgEuPRCF5
	lrDuc+pNE+FFvNhJidSVaq/SFIdmDsTOIB3b3UIQOWlBqj6JuuP3hd1DZxYO16Rws+R4tisd7pp
	Y
X-Google-Smtp-Source: AGHT+IGzSGm+pF8QY7moyCNfRsEXqKQ2FCB+iJZLi5PsFvzZo1B3MvlWqhsuKTJSbqBEzIrbkZYGNw==
X-Received: by 2002:a17:907:3d92:b0:ac3:ccf7:3a11 with SMTP id a640c23a62f3a-ac7d198f6d6mr1424146766b.44.1744117449142;
        Tue, 08 Apr 2025 06:04:09 -0700 (PDT)
Received: from [172.17.139.17] ([163.114.131.192])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7bfe99c7dsm919058366b.57.2025.04.08.06.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 06:04:08 -0700 (PDT)
Message-ID: <983965b6-2262-4f72-a672-39085dcdaa3c@gmail.com>
Date: Tue, 8 Apr 2025 14:04:06 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] Virtual Swap Space
To: Nhat Pham <nphamcs@gmail.com>, linux-mm@kvack.org
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com,
 yosry.ahmed@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
 shakeel.butt@linux.dev, muchun.song@linux.dev, len.brown@intel.com,
 chengming.zhou@linux.dev, kasong@tencent.com, chrisl@kernel.org,
 huang.ying.caritas@gmail.com, ryan.roberts@arm.com, viro@zeniv.linux.org.uk,
 baohua@kernel.org, osalvador@suse.de, lorenzo.stoakes@oracle.com,
 christophe.leroy@csgroup.eu, pavel@kernel.org, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-pm@vger.kernel.org
References: <20250407234223.1059191-1-nphamcs@gmail.com>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <20250407234223.1059191-1-nphamcs@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 08/04/2025 00:42, Nhat Pham wrote:
> 
> V. Benchmarking
> 
> As a proof of concept, I run the prototype through some simple
> benchmarks:
> 
> 1. usemem: 16 threads, 2G each, memory.max = 16G
> 
> I benchmarked the following usemem commands:
> 
> time usemem --init-time -w -O -s 10 -n 16 2g
> 
> Baseline:
> real: 33.96s
> user: 25.31s
> sys: 341.09s
> average throughput: 111295.45 KB/s
> average free time: 2079258.68 usecs
> 
> New Design:
> real: 35.87s
> user: 25.15s
> sys: 373.01s
> average throughput: 106965.46 KB/s
> average free time: 3192465.62 usecs
> 
> To root cause this regression, I ran perf on the usemem program, as
> well as on the following stress-ng program:
> 
> perf record -ag -e cycles -G perf_cg -- ./stress-ng/stress-ng  --pageswap $(nproc) --pageswap-ops 100000
> 
> and observed the (predicted) increase in lock contention on swap cache
> accesses. This regression is alleviated if I put together the
> following hack: limit the virtual swap space to a sufficient size for
> the benchmark, range partition the swap-related data structures (swap
> cache, zswap tree, etc.) based on the limit, and distribute the
> allocation of virtual swap slotss among these partitions (on a per-CPU
> basis):
> 
> real: 34.94s
> user: 25.28s
> sys: 360.25s
> average throughput: 108181.15 KB/s
> average free time: 2680890.24 usecs
> 
> As mentioned above, I will implement proper dynamic swap range
> partitioning in a follow up work.
> 
> 2. Kernel building: zswap enabled, 52 workers (one per processor),
> memory.max = 3G.
> 
> Baseline:
> real: 183.55s
> user: 5119.01s
> sys: 655.16s
> 
> New Design:
> real: mean: 184.5s
> user: mean: 5117.4s
> sys: mean: 695.23s
> 
> New Design (Static Partition)
> real: 183.95s
> user: 5119.29s
> sys: 664.24s
> 

Hi Nhat,

Thanks for the patches! I have glanced over a couple of them, but this was the main question that came to my mind.

Just wanted to check if you had a look at the memory regression during these benchmarks?

Also what is sizeof(swp_desc)? Maybe we can calculate the memory overhead as sizeof(swp_desc) * swap size/PAGE_SIZE?

For a 64G swap that is filled with private anon pages, the overhead in MB might be (sizeof(swp_desc) in bytes * 16M) - 16M (zerobitmap) - 16M*8 (swap map)?

This looks like a sizeable memory regression?

Thanks,
Usama


