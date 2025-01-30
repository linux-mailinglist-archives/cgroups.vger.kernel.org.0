Return-Path: <cgroups+bounces-6392-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 632EDA230C8
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2939816322E
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537DE1E9B2A;
	Thu, 30 Jan 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiAYEW4V"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F48C13FEE
	for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738249542; cv=none; b=Xv0pusreAXy8hNB1WshDLQLZwwLJsGEFTxddjEN5l70/WXh012xAnxhMtVPzEP3KqQg93XX5D27NwocWpKplX3+pegJOMTXI1Y299l+Qgwg/JOYkUMcHYqMqrmExHcQeCcSs0LeuLE06UppxWxpu0yxWuc1CH9ailiolWLYpTHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738249542; c=relaxed/simple;
	bh=xz6HTttNyAohBekFqEUq7BEwVmYybpKGfGnf2Wz7mPw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=QBfdpXw7omNCG6oBgNCaMwb/eYEt2qro0hSeDOmgTm0rrwAQVZKOVyRCvBkBzK8LhTnUCF5j3+ss12MYMA+r1iV3+/TMVyVGS+ab/6o80YRESiQueE+1SbKyZY+6xm9hqAwNrgF5hs8SBMY5jveTMODxP8+RtYyP3VbcA9Ckl3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiAYEW4V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738249538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UAngit6M03LgRRaR1K5FI0V6z65Vw9FPDcpq2Hs9JbE=;
	b=LiAYEW4VmBkug+NMtnGoiF1dp7qBiAz0r1vBOKPRTCGRQZVeJQE8nD30TNKOyTsH9hR6I5
	gK5sCHjsa3M3dBsUH+/sKcfEbl3JKCKbcOwNB+19taNlLJFJcDgkROIsVZfUitYIL58q6X
	Wxg2twrVOBvs8Tw35VDFIhgCdLtMlvY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-odSIj06_PMiIahp1wNfCAQ-1; Thu, 30 Jan 2025 10:05:37 -0500
X-MC-Unique: odSIj06_PMiIahp1wNfCAQ-1
X-Mimecast-MFC-AGG-ID: odSIj06_PMiIahp1wNfCAQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6df9ac8dcbeso27112586d6.3
        for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 07:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738249537; x=1738854337;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UAngit6M03LgRRaR1K5FI0V6z65Vw9FPDcpq2Hs9JbE=;
        b=j7DyBIYJUOX+BbAMn7kXDcCZHBldb0JoNS78B8g4IgmRQWc7UgidGVqHClMoUpldGM
         LZT1bJQBjimh3nYf7sOvs0OdybV1XKsNjr0me4PdMtcyiDRUg1ToApJfdMNHNfV5/Mb7
         +4GqGh6CoE9r2nZLnrKKfJgsDRislok4nv/chTKgc6GYva/Z0NKCZLlLEH17edYkVqWK
         6CSpdNtdjpRdRcWEeGXaX56VDaYdOeRpGfq3gtJLXaihmH1MrTIElma70TpCQ5tBzPs7
         LU0m2dK2yXTmCiUrAiXhgX3lQi6ImoBeJ2Ud5L3yDRYAvGta5quCyDxpxI5o0nawjO7n
         z2kA==
X-Forwarded-Encrypted: i=1; AJvYcCXa/mFYCIuc6uAHva22X9sXj1WeDb1vdVrqkL90cp4Yx/5Nkq/CkQWBcIzXWzyB6deZjO8V2aTL@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrGzX/+TU2dIjTHRxL+sXF3cmijYLor2tozg4aKK0CrFqTXQf
	8TDvVg4C8cF2EiAY/4z7ZiWtr1CnPo2YN2MLLsk72bLpor23HhSk6OpPyFxwkIlwr/tMeT6RDAH
	SBLCQ9ndWH76LwBLeU4p3VtN7d1g+uxi/+ZjlIZAd0kE2iKEPLnfig0Y=
X-Gm-Gg: ASbGncvunYLjvVnarPNlwAr3Q7a6xFWhbfo+MF0Ra+oOgUyIEEhhhn8ssEPVYSyj0up
	r5E1yGEvX6Gyk/XGqYOf0uWO9jiSmV/yGYQShcMQYkMdx7Yof5sfEUGhxzlYzucGpzBWbZSrZ3R
	GLGyv5JtTDcRDimueTR43+3BAyLHgzJlG0yrHQMDdcmJ81nlsnbxmVWNCEduTidRsvS7MFcZ/b3
	RqyHOedyB7KFSw90irMM0bXcuiPEzbwMjoe1Agl5eeMeRJUoVAtSyM2MKobX1mjxCzJHga88wA9
	fFE7RYIFRe1bfZUH3ZbBPHNzeSrrKGBhMVXMI9kRL8ERWvDoy8I=
X-Received: by 2002:a05:6214:d48:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6e243c67537mr126629396d6.34.1738249536669;
        Thu, 30 Jan 2025 07:05:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUK7lLnq0YpD0cZmVruuYg19C46zZhFDKnof0uqIEU4K98pvy7EmVxD4asUaHatzWO9jD7dg==
X-Received: by 2002:a05:6214:d48:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6e243c67537mr126628996d6.34.1738249536237;
        Thu, 30 Jan 2025 07:05:36 -0800 (PST)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2548357f9sm7038796d6.63.2025.01.30.07.05.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 07:05:35 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <211b394b-3b9a-4872-8c07-b185386487d3@redhat.com>
Date: Thu, 30 Jan 2025 10:05:34 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm, memcg: introduce memory.high.throttle
To: Michal Hocko <mhocko@suse.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Peter Hunt <pehunt@redhat.com>
References: <20250129191204.368199-1-longman@redhat.com>
 <Z5s1DG2YVH78RWpR@tiehlicka>
Content-Language: en-US
In-Reply-To: <Z5s1DG2YVH78RWpR@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 3:15 AM, Michal Hocko wrote:
> On Wed 29-01-25 14:12:04, Waiman Long wrote:
>> Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
>> reclaim over memory.high"), the amount of allocator throttling had
>> increased substantially. As a result, it could be difficult for a
>> misbehaving application that consumes increasing amount of memory from
>> being OOM-killed if memory.high is set. Instead, the application may
>> just be crawling along holding close to the allowed memory.high memory
>> for the current memory cgroup for a very long time especially those
>> that do a lot of memcg charging and uncharging operations.
>>
>> This behavior makes the upstream Kubernetes community hesitate to
>> use memory.high. Instead, they use only memory.max for memory control
>> similar to what is being done for cgroup v1 [1].
> Why is this a problem for them?
My understanding is that a mishaving container will hold up memory.high 
amount of memory for a long time instead of getting OOM killed sooner 
and be more productively used elsewhere.
>
>> To allow better control of the amount of throttling and hence the
>> speed that a misbehving task can be OOM killed, a new single-value
>> memory.high.throttle control file is now added. The allowable range
>> is 0-32.  By default, it has a value of 0 which means maximum throttling
>> like before. Any non-zero positive value represents the corresponding
>> power of 2 reduction of throttling and makes OOM kills easier to happen.
> I do not like the interface to be honest. It exposes an implementation
> detail and casts it into a user API. If we ever need to change the way
> how the throttling is implemented this will stand in the way because
> there will be applications depending on a behavior they were carefuly
> tuned to.
>
> It is also not entirely sure how is this supposed to be used in
> practice? How do people what kind of value they should use?
Yes, I agree that a user may need to run some trial runs to find a 
proper value. Perhaps a simpler binary interface of "off" and "on" may 
be easier to understand and use.
>
>> System administrators can now use this parameter to determine how easy
>> they want OOM kills to happen for applications that tend to consume
>> a lot of memory without the need to run a special userspace memory
>> management tool to monitor memory consumption when memory.high is set.
> Why cannot they achieve the same with the existing events/metrics we
> already do provide? Most notably PSI which is properly accounted when
> a task is throttled due to memory.high throttling.

That will require the use of a userspace management agent that looks for 
these stalling conditions and make the kill, if necessary. There are 
certainly users out there that want to get some benefit of using 
memory.high like early memory reclaim without the trouble of handling 
these kind of stalling conditions.

Cheers,
Longman


