Return-Path: <cgroups+bounces-6396-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DCA232B2
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 18:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D303A28C9
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B412A1EE7CB;
	Thu, 30 Jan 2025 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ecCjZEFu"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E192C1E9B39
	for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738257587; cv=none; b=CAgL8vmhfr3brdTX8hzukLhSXn+unioHavovPkD/e4tqpqIlUfIlJ1rpn621WAVG1hvpoKq3ooBcpwV+vc35itD3XBO0lPHF7w6Mxs5FU1KSIR9qbcMGW94rxe5PL8szIDkfCgBJVudNuwwNYRjMVGPkS+chwtZs67bCqXlsuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738257587; c=relaxed/simple;
	bh=Vtiz1noff7UBW9h8Hf2OkTnw2ywNN7YazG3F+I5mBxw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jp/VnxbzERW2fotnzbi/eDE/qbUEUkEhlpDr2M5quqPcHRmctQCcpXINQubN2WG7koOCa7qYN8pTGXezRT4rY8Ck+ol5g4eaIKfHOUdvU1VO4DZs8W2oLMxcf/LwGkIk70bcUC/E0c692WrL+PHXaAa0fqAupPwoapTd5aFYVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecCjZEFu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738257584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Fa6Fgsa1RBhChBXyZSptjF+ocBVY25XthbUA+IR9Lc=;
	b=ecCjZEFuaxne/mPr5QTzB0bfCUYBn4a6c8Zh2DH4EWknTQn4MS+8TUQ2yoCNsy1iOzrhNw
	OpXrSqf+OQphY0a+UTB+k+yPpgRISluXxZdU4hpc/KpBXSThS6etWFKrEr9wX1ErapZre4
	JwhDey0ygBIAcCNbUGsJUGTBZDuD5GY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-sPdGIXw4M1uxJs4JtzawYQ-1; Thu, 30 Jan 2025 12:19:41 -0500
X-MC-Unique: sPdGIXw4M1uxJs4JtzawYQ-1
X-Mimecast-MFC-AGG-ID: sPdGIXw4M1uxJs4JtzawYQ
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e2378169a4so23082386d6.2
        for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 09:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738257581; x=1738862381;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Fa6Fgsa1RBhChBXyZSptjF+ocBVY25XthbUA+IR9Lc=;
        b=XGk2wD78s0zedjmpQ3VwZezfg6y0mGFPNW2Yu7nGbY4dvHNOs8h/80HGFiZxhZQMSF
         8v/yUUYep3QouAju273uuOEdbKv/Fo32dMC+lKtK7k3b8cLHUn0OScvL15rr3lTWrtRn
         q/lcXf5ZXS+xfd7ABWwz7m0R20RcsfJsQeBuH+2d7yq59/cy+mxWB91xGfSyGEGnym1Q
         FLGxcyK1zJ4sfO0qu5rQa+PrsNaihe5OY5R1a8ch9nDk112nJa9GwHeMr3IaA1i5itXW
         G/2pYGawbJaNBH8HIUIUgdYXXZjZ7VDRIsufBdFgOk397yKkL/9cv0X7ioo1F1vlC50v
         BZsA==
X-Forwarded-Encrypted: i=1; AJvYcCXn9WZezze0xL+VR6rufu0S/0Z0btB61MGxB7cdtsMldUHII0g80pfhi2v462p2vegUT5qgrE1K@vger.kernel.org
X-Gm-Message-State: AOJu0YwTKXe0r+/UKf6mObC+AwNHz4wuOaPzzEGowM8taOtfLerkAWp8
	rVql09kjo4uVY05Kc3MHnaovmBXjBMMuFMwKBZlyZr9SVbymftPirQBTwpgLvTRPtVC/t5owohX
	3JCckPM491nBQgB5fGPFj2K2g8FpOtUFjdqs4Ot/3DHZbt0ubHeulmKM=
X-Gm-Gg: ASbGncu1bbUzV7WUW/lyAMd4czKa/HP5DUytvmDfg2L084K+9YujFbh19OKXMtcFD4F
	RTcfiX56DxWPmkJbvDzziZ7P6aocpLGY7MnC5AUZohzsFCo2pk01P6/MPPvCNdDwiLhZ3C5/PWd
	P+OS60++LFRaoxt8LmZ5mfWSYyFSLuEWa/jwYlbZYubSw/LZMt7HHSmnhLRgKj87OIW6Wlgc32d
	HXLOkzrrFk/m+BqD7t01blIul8M4BYqPaw7zrciD7eJ/fkEYwu9m1PToxQ93xAgWU87+zeF1cet
	tO+jkn743qUov3xCltb2Q7Ea8kUAizQp0tLc4A+ENdV4M7QAaL0=
X-Received: by 2002:a05:6214:4603:b0:6d4:215d:91c3 with SMTP id 6a1803df08f44-6e243c62dddmr131733516d6.28.1738257581141;
        Thu, 30 Jan 2025 09:19:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8ypqrhL6idza3miOhUWJjRsaz1USTPrfph2cDh2w5Kr5q2g9rBY4V4Gt+j9lmXVuYoB025g==
X-Received: by 2002:a05:6214:4603:b0:6d4:215d:91c3 with SMTP id 6a1803df08f44-6e243c62dddmr131733076d6.28.1738257580864;
        Thu, 30 Jan 2025 09:19:40 -0800 (PST)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e25495e76bsm8107936d6.125.2025.01.30.09.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 09:19:40 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a309f420-4a25-4cf5-b6f0-750059c8467c@redhat.com>
Date: Thu, 30 Jan 2025 12:19:38 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm, memcg: introduce memory.high.throttle
To: Roman Gushchin <roman.gushchin@linux.dev>, Waiman Long <llong@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Peter Hunt <pehunt@redhat.com>
References: <20250129191204.368199-1-longman@redhat.com>
 <Z5s1DG2YVH78RWpR@tiehlicka>
 <211b394b-3b9a-4872-8c07-b185386487d3@redhat.com>
 <Z5uxVzFf7Pk7yk9f@google.com>
Content-Language: en-US
In-Reply-To: <Z5uxVzFf7Pk7yk9f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 12:05 PM, Roman Gushchin wrote:
> On Thu, Jan 30, 2025 at 10:05:34AM -0500, Waiman Long wrote:
>> On 1/30/25 3:15 AM, Michal Hocko wrote:
>>> On Wed 29-01-25 14:12:04, Waiman Long wrote:
>>>> Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
>>>> reclaim over memory.high"), the amount of allocator throttling had
>>>> increased substantially. As a result, it could be difficult for a
>>>> misbehaving application that consumes increasing amount of memory from
>>>> being OOM-killed if memory.high is set. Instead, the application may
>>>> just be crawling along holding close to the allowed memory.high memory
>>>> for the current memory cgroup for a very long time especially those
>>>> that do a lot of memcg charging and uncharging operations.
>>>>
>>>> This behavior makes the upstream Kubernetes community hesitate to
>>>> use memory.high. Instead, they use only memory.max for memory control
>>>> similar to what is being done for cgroup v1 [1].
>>> Why is this a problem for them?
>> My understanding is that a mishaving container will hold up memory.high
>> amount of memory for a long time instead of getting OOM killed sooner and be
>> more productively used elsewhere.
>>>> To allow better control of the amount of throttling and hence the
>>>> speed that a misbehving task can be OOM killed, a new single-value
>>>> memory.high.throttle control file is now added. The allowable range
>>>> is 0-32.  By default, it has a value of 0 which means maximum throttling
>>>> like before. Any non-zero positive value represents the corresponding
>>>> power of 2 reduction of throttling and makes OOM kills easier to happen.
>>> I do not like the interface to be honest. It exposes an implementation
>>> detail and casts it into a user API. If we ever need to change the way
>>> how the throttling is implemented this will stand in the way because
>>> there will be applications depending on a behavior they were carefuly
>>> tuned to.
>>>
>>> It is also not entirely sure how is this supposed to be used in
>>> practice? How do people what kind of value they should use?
>> Yes, I agree that a user may need to run some trial runs to find a proper
>> value. Perhaps a simpler binary interface of "off" and "on" may be easier to
>> understand and use.
>>>> System administrators can now use this parameter to determine how easy
>>>> they want OOM kills to happen for applications that tend to consume
>>>> a lot of memory without the need to run a special userspace memory
>>>> management tool to monitor memory consumption when memory.high is set.
>>> Why cannot they achieve the same with the existing events/metrics we
>>> already do provide? Most notably PSI which is properly accounted when
>>> a task is throttled due to memory.high throttling.
>> That will require the use of a userspace management agent that looks for
>> these stalling conditions and make the kill, if necessary. There are
>> certainly users out there that want to get some benefit of using memory.high
>> like early memory reclaim without the trouble of handling these kind of
>> stalling conditions.
> So you basically want to force the workload into some sort of a proactive
> reclaim but without an artificial slow down?
> It makes some sense to me, but
> 1) Idk if it deserves a new API, because it can be relatively easy implemented
>    in userspace by a daemon which monitors cgroups usage and reclaims the memory
>    if necessarily. No kernel changes are needed.
> 2) If new API is introduced, I think it's better to introduce a new limit,
>    e.g. memory.target, keeping memory.high semantics intact.

Yes, you are right about that. Introducing a new "memory.target" without 
disturbing the existing "memory.high" semantics will work for me too.

Cheers,
Longman


