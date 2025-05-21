Return-Path: <cgroups+bounces-8300-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD3DAC00D1
	for <lists+cgroups@lfdr.de>; Thu, 22 May 2025 01:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89F398C7E34
	for <lists+cgroups@lfdr.de>; Wed, 21 May 2025 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2323D2A1;
	Wed, 21 May 2025 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JiQkMwhF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69821E0A2;
	Wed, 21 May 2025 23:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747871576; cv=none; b=XuHmnPu71lKxT8Eim59vgn2qJHqtOAfnqL1pG+kRRMIxioZkDORz9fHx27snOIjf4HSbd49oQeSlHXi+xKdErcsoJcHgYam1klnuhzOOUIncjgh2vlU74KI9nLnxcYdDatLg8hL0DFMs3CbUhgYbYfNZWwDRsxv5X0cy1R/as84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747871576; c=relaxed/simple;
	bh=2qOpZHk8xt+g9fBaYg5YSi7uL4/V0iw7NjE1UcKvEVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2g5/gsYeayJqcb09ch2bCQcy/sKLTECBwXC/kFE6bzqAzlYiTYgbKMfvaQNfKQhOQcBVLgWQXl6TR09QnHo701r3HxjK4Hh3qTyB4fAX4bKC2nQX7aXP6yRR28gZtD+SW9UhSlXzN3iIx0Qy9jdChvrmUy5U68ynzrBRqIp3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JiQkMwhF; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so7631868a12.0;
        Wed, 21 May 2025 16:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747871574; x=1748476374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tv8ABiZjTSsX7/N5+xUlPIqutk3RS4YiHeo90v4eMFk=;
        b=JiQkMwhFlCkAwj41xM4ImEnQxZ0j/DyFX1yWN3oQ8H9IW/vp2TjC/EqP1Inns03BOp
         3w+boEftfVroDTwulutNsncH4ziKmUJJNcvfSU21DMNhbNIWkTCKVun5oIGIGyCIcKX+
         Yiq+gontYZBR+N3mZvGiAO6lzAQax28/sjAx6UCuHfImoDv5khpxFxVwoWUymO/MQYJV
         YlFVEbL7hbkYViopLQK1twLZFzwJ7+zmVT1ifHSd0a7UsqyjAbZHrapumJ3TtSZHKfHd
         Z+SHOFjQTCoemADCXLMBmWYUmDiAbtv84SELAM2XgJILhOQ1iUxla5DyopDgpanS/Rp2
         JsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747871574; x=1748476374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tv8ABiZjTSsX7/N5+xUlPIqutk3RS4YiHeo90v4eMFk=;
        b=U7+j0hVsBQBu7nFqrY9EEaIV8/U33YS4l3RW/ywNZpRQLDUoOYAD1Qw2CGKgp+GftR
         rfQ/DJqU+Gwt7uCA2fQiC2hqOitpBxqnRsAR9l/CI2GvzuLcDsgoTbIzJIFc1y9tx6tp
         2BGoERW+0OL/uyRXVuXSwEwKtd/e/7saT6Fe6S4TcwXgo6/hZ5JGHeeZX5mDlCKAU9+J
         zQee0KaOtnlqJMIFZB3M6jwY+M4ORxwO8GrRTBoo7eNQCclNSqZko1Jjcln5sYJbfQSM
         JYdxLq16je0QCrnLx5OSDDd2ukwC8xCW0ERYrmStgJzLnZkz2GUxwyxrZJmolb/sunVE
         +31w==
X-Forwarded-Encrypted: i=1; AJvYcCVPzSfbtH7E357LHPudtuUt6jFFNqG9wC2mS5L3Avrb1JjVEjL0dAgNNTdxX0gKjhLpASaYrY7XdQ==@vger.kernel.org, AJvYcCWOnWKLgzOyJQTkn2VYGADD8zePD7+CqijrAIeOBpnkyHjYabgRkfOg2azEQhj0nVKE7PePqgAt8gmAmikn@vger.kernel.org, AJvYcCWc4fkS46afkcMr04LlO2f8BbwfJNXprGzwaddbz7trFDoUbA+N9yf4r49Thvj7gnBlgQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFOFCg7LOWGZE/PWqqUhGiMDNQncZMestqMGPy1oQoB9oxB4YH
	IZ9ClesFCB7M+6RC4ATvNoAzQcC/wfsSC0WQLcDQ0pp7mHVedUFwt7Jj
X-Gm-Gg: ASbGnct0wl7MiSdtqF5AorbGB3u1stAF/UZdNVkpAf1J2IjtZE+FFxAr7OqaZa/n0EK
	Pt/096f0e8K1r6Yowr/vAgDrkN5pJRLWlRTNhDaGQ2qSnoWffacl7O/WXanp1XquQ8hjVc8yDru
	/Q8T2c2MDvRQ1XeO6Uea/gV+bzNSaiLCooVspeYg6j0Sc6JsJhN6PVo9TtfqwqmWyyQFr4ePr0I
	DF6BIlNrBoFeEPGWvtFOimCM2NhDs241CF4s8g8oPVlHH5iKgxxJlyh7+1RSKu7Qq2MuO+fgnoI
	muyr6reyDCH0W1H6AYVcxfCFu1qveiAJeg0jOi565NqUf495mQU4/LiqgeqDap2KUj+ZmJMJ/8C
	MSWb5nEscJrssoeNGMbSzFg==
X-Google-Smtp-Source: AGHT+IEhRtWayz2wO/NANMbY77CLzICf7dbwLdeAITjL7G45qTo7ZKomEFbV0bEm0TWCBrjPtFfTWQ==
X-Received: by 2002:a05:6a21:103:b0:1f5:7c6f:6c96 with SMTP id adf61e73a8af0-21621902a69mr37008453637.22.1747871574344;
        Wed, 21 May 2025 16:52:54 -0700 (PDT)
Received: from [192.168.2.117] (c-67-188-127-15.hsd1.ca.comcast.net. [67.188.127.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a970c86asm10504612b3a.57.2025.05.21.16.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 16:52:53 -0700 (PDT)
Message-ID: <71f67d74-c2fa-4ca3-9bbc-7f239f24e97d@gmail.com>
Date: Wed, 21 May 2025 16:52:52 -0700
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [OFFLIST PATCH 2/2] cgroup: use subsystem-specific rstat locks to
 avoid contention
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Klara Modin <klarasmodin@gmail.com>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 <9151095d-98dc-4497-9a64-b2eb7f8f96ea@gmail.com>
 <fyu3eohrzarujgjwtpg6b2jultwntihm5kreoqx3b3gqlamum3@imbouehlyhle>
Content-Language: en-US
From: JP Kobryn <inwardvessel@gmail.com>
In-Reply-To: <fyu3eohrzarujgjwtpg6b2jultwntihm5kreoqx3b3gqlamum3@imbouehlyhle>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/21/25 4:50 PM, Shakeel Butt wrote:
> On Wed, May 21, 2025 at 04:47:01PM -0700, JP Kobryn wrote:
>>
>>
>> On 5/21/25 4:33 PM, Shakeel Butt wrote:
>>> On Wed, May 21, 2025 at 04:23:44PM -0700, Shakeel Butt wrote:
>>>> On Thu, May 22, 2025 at 12:23:44AM +0200, Klara Modin wrote:
>>>>> Hi,
>>>>>
>>>>> On 2025-04-28 23:15:58 -0700, Shakeel Butt wrote:
>>>>>> Please ignore this patch as it was sent by mistake.
>>>>>
>>>>> This seems to have made it into next:
>>>>>
>>>>> 748922dcfabd ("cgroup: use subsystem-specific rstat locks to avoid contention")
>>>>>
>>>>> It causes a BUG and eventually a panic on my Raspberry Pi 1:
>>>>>
>>>>> WARNING: CPU: 0 PID: 0 at mm/percpu.c:1766 pcpu_alloc_noprof (mm/percpu.c:1766 (discriminator 2))
>>>>> illegal size (0) or align (4) for percpu allocation
>>>>
>>>> Ok this config is without CONFIG_SMP and on such configs we have:
>>>>
>>>> typedef struct { } arch_spinlock_t;
>>>>
>>>> So, we are doing ss->rstat_ss_cpu_lock = alloc_percpu(0).
>>>>
>>>> Hmm, let me think more on how to fix this.
>>>>
>>>
>>> I think following is the simplest fix:
>>>
>>> diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
>>> index 7dd396ae3c68..aab09495192e 100644
>>> --- a/kernel/cgroup/rstat.c
>>> +++ b/kernel/cgroup/rstat.c
>>> @@ -511,7 +511,10 @@ int __init ss_rstat_init(struct cgroup_subsys *ss)
>>>    	int cpu;
>>>    	if (ss) {
>>> -		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
>>> +		size_t size = sizeof(raw_spinlock_t) ?: 1;
>>> +
>>> +		ss->rstat_ss_cpu_lock = __alloc_percpu(size,
>>> +						__alignof__(raw_spinlock_t));
>>
>> Thanks for narrowing this one down so fast. Would this approach be more
>> straightforward?
>>
>> if (ss) {
>> #ifdef CONFIG_SMP
>> 	ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
>> #endif
>>
>> Since on non-smp the lock functions are no-ops, leaving the ss cpu lock
>> can perhaps be left NULL. I could include a comment as well explaining
>> why.
>>
>>>    		if (!ss->rstat_ss_cpu_lock)
>>>    			return -ENOMEM;
> 
> Include this check and return -ENOMEM in the ifdef as well.

Good call. I will get a patch out tonight.

> 
>>>    	}
>>


