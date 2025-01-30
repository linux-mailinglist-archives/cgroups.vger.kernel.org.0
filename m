Return-Path: <cgroups+bounces-6398-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55593A23342
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 18:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18517A2648
	for <lists+cgroups@lfdr.de>; Thu, 30 Jan 2025 17:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762AC1EF0B7;
	Thu, 30 Jan 2025 17:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ayw9lkZ2"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8647917597
	for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 17:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258900; cv=none; b=RA1UF5nozjG1N4FdGnaIaJpAZay6CdNsCVyW8qhXF34GaAPYKeTmkabdXabTlpZ5mry5rufRfT1lfpG2y7aLFAuwza/++yfH0zNmpU0q++YSbgHxpt2TqlUXwvuSR/Q8+fcPrrpODvHyRb7auDTSCw9oXSFjq0fV4j3BulTxEtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258900; c=relaxed/simple;
	bh=54+R2sjbPzxH95p1aLqpNRduh3BFRRBTsu4iZaeg+WI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=SG0cIOFWdLq8B9C+FdFzBNhq/ntDJxtkS547zLZOAiM3lqAiBynug4te8/18oJGq93zl1sMNcjLCh19iOLigt3FrwzvnHHaJYkBiFsGv43OADnPxFdZvUI34GHphA/iYsrO6PHNxb5uKDdiMR7mhWSy7rZx6fKuke31FBB6gQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ayw9lkZ2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738258897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+Tm4MMuMgMNaWCuqAB5supWyn/zNxaUSBKarskhg04=;
	b=Ayw9lkZ2nnpM+1YQSeyAtvSi1qLTOUmTR/+oupC26aS1ZQQZUd7qc4agDqz+wk/oN772a8
	Phjle1SloaPKYdFqwT8P0HPxFq8WJZxl7rUHmgYIuD8CHqbVb+os+0enFQf0+lN4WQiupm
	XpARf9V2LIvAAo3WoC1fUddJMCX2MUs=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-lX3jeivxOZSwGu0IAw6ODA-1; Thu, 30 Jan 2025 12:41:36 -0500
X-MC-Unique: lX3jeivxOZSwGu0IAw6ODA-1
X-Mimecast-MFC-AGG-ID: lX3jeivxOZSwGu0IAw6ODA
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5fc10e8abebso511564eaf.3
        for <cgroups@vger.kernel.org>; Thu, 30 Jan 2025 09:41:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738258894; x=1738863694;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+Tm4MMuMgMNaWCuqAB5supWyn/zNxaUSBKarskhg04=;
        b=IoTB/h2A5pjApZBGk/LGuD70Sn39v7fUbMlC6ZFcvdwhSan3Cs2tWO3uISxVscXvj4
         HzMwpoLE3lpjuOrTPwxUBcBwcnKICw7vKYgP4xv4tR5Manyat9Mee2M/80AkxyGzOpoN
         lltNd5BB0UhsDV5WYfGSExeSXWGkZ8xPhb/Dj/k+l41SUI6iNHL6Qzgv4aK0keFHijQQ
         wW5CO+7rQon+9wNRWMGpIv++c8TJZhJjaaSskYtqEoBrn2n9wwM/9wVg4Q5rHXXUXGaO
         /XpgYVgncdDcC31OgCx1qHLufSdRQfD+t3+nPwd6pb7O1NMO7l20xHwaymYkfHQqWMpl
         gFug==
X-Forwarded-Encrypted: i=1; AJvYcCUiRr5PSgIuieCKL8nq3BVishm60IE1Ptocu2NiggvHkLoFDrA65YLQDh376RzpPoEKDhoBY5Ih@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCYTekEhukMK/rUJhSIIuR7WLfYC5yFczmh+vwMDNnXX2Sp42
	dkacrw+2zbyhaTy7BOcsSpYeLyiEAhMMlLTNphIox5KFj7mcqqeS3ggEln/1M8ncb/tbVso0vJA
	V6tfwNu+16ZakynmKHkzXu0Y5SeVc7N5wfXu0jRpnuaxGOLaVrXCKuRGEgotztSwx4A==
X-Gm-Gg: ASbGnctucFdG4TQWvQwUM3I1h3ipLrOqnkcam2SyU+wumjOHDFP0gZLI4vpBrT1J6QK
	zVVttgOYZBs5vvCjv9IHk4Z82bS/pUmkqkCnWAypAD+RDf9oMOOCfH7xskgV7qfghiBtCh2n6fw
	PN4vqAdsXwRLNIzLDB6TNrm+Tap20MIzyePXPaDEELOibUoqDwUGNhpGgOJI0R9v7kkO9PupBkf
	fDI4Og86fx7kWXAt9ex2W/1EqFFTGfbvUyVRwXiOFtV8smB3Eu5OaLRdWSnxKG3nTb3Jg4e1MM6
	VZUP2nELsH+t/34bxTgVleqwpr6+4bZeJZiy3hgmFZy8HI+SYqI=
X-Received: by 2002:a05:6871:3a8a:b0:289:2126:6826 with SMTP id 586e51a60fabf-2b32f286165mr4962793fac.30.1738258893894;
        Thu, 30 Jan 2025 09:41:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGKmbRw3DSmtj5+GCkf1IDjlUIoa6aTSZ6+uzH9hTvj6m3TrzQxzX+gu+fF8o1zU4D3OZgNQ==
X-Received: by 2002:ac8:5f88:0:b0:467:4f0a:1b5d with SMTP id d75a77b69052e-46fd0b68880mr124572611cf.42.1738258881566;
        Thu, 30 Jan 2025 09:41:21 -0800 (PST)
Received: from ?IPV6:2601:408:c101:1d00:6621:a07c:fed4:cbba? ([2601:408:c101:1d00:6621:a07c:fed4:cbba])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0c62d4sm8874501cf.17.2025.01.30.09.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 09:41:20 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8785134d-3012-42c1-a67c-b64862d89fc5@redhat.com>
Date: Thu, 30 Jan 2025 12:41:19 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm, memcg: introduce memory.high.throttle
To: Shakeel Butt <shakeel.butt@linux.dev>, Waiman Long <llong@redhat.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko
 <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Peter Hunt <pehunt@redhat.com>
References: <20250129191204.368199-1-longman@redhat.com>
 <Z5s1DG2YVH78RWpR@tiehlicka>
 <211b394b-3b9a-4872-8c07-b185386487d3@redhat.com>
 <Z5uxVzFf7Pk7yk9f@google.com>
 <a309f420-4a25-4cf5-b6f0-750059c8467c@redhat.com>
 <eyl6rcqdwinppl4cyvqrli5pqugxdhrsgpvu64oomgvqd7m7c4@q4gz5v2zovwe>
Content-Language: en-US
In-Reply-To: <eyl6rcqdwinppl4cyvqrli5pqugxdhrsgpvu64oomgvqd7m7c4@q4gz5v2zovwe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/30/25 12:32 PM, Shakeel Butt wrote:
> On Thu, Jan 30, 2025 at 12:19:38PM -0500, Waiman Long wrote:
>> On 1/30/25 12:05 PM, Roman Gushchin wrote:
>>> On Thu, Jan 30, 2025 at 10:05:34AM -0500, Waiman Long wrote:
>>>> On 1/30/25 3:15 AM, Michal Hocko wrote:
>>>>> On Wed 29-01-25 14:12:04, Waiman Long wrote:
>>>>>> Since commit 0e4b01df8659 ("mm, memcg: throttle allocators when failing
>>>>>> reclaim over memory.high"), the amount of allocator throttling had
>>>>>> increased substantially. As a result, it could be difficult for a
>>>>>> misbehaving application that consumes increasing amount of memory from
>>>>>> being OOM-killed if memory.high is set. Instead, the application may
>>>>>> just be crawling along holding close to the allowed memory.high memory
>>>>>> for the current memory cgroup for a very long time especially those
>>>>>> that do a lot of memcg charging and uncharging operations.
>>>>>>
>>>>>> This behavior makes the upstream Kubernetes community hesitate to
>>>>>> use memory.high. Instead, they use only memory.max for memory control
>>>>>> similar to what is being done for cgroup v1 [1].
>>>>> Why is this a problem for them?
>>>> My understanding is that a mishaving container will hold up memory.high
>>>> amount of memory for a long time instead of getting OOM killed sooner and be
>>>> more productively used elsewhere.
>>>>>> To allow better control of the amount of throttling and hence the
>>>>>> speed that a misbehving task can be OOM killed, a new single-value
>>>>>> memory.high.throttle control file is now added. The allowable range
>>>>>> is 0-32.  By default, it has a value of 0 which means maximum throttling
>>>>>> like before. Any non-zero positive value represents the corresponding
>>>>>> power of 2 reduction of throttling and makes OOM kills easier to happen.
>>>>> I do not like the interface to be honest. It exposes an implementation
>>>>> detail and casts it into a user API. If we ever need to change the way
>>>>> how the throttling is implemented this will stand in the way because
>>>>> there will be applications depending on a behavior they were carefuly
>>>>> tuned to.
>>>>>
>>>>> It is also not entirely sure how is this supposed to be used in
>>>>> practice? How do people what kind of value they should use?
>>>> Yes, I agree that a user may need to run some trial runs to find a proper
>>>> value. Perhaps a simpler binary interface of "off" and "on" may be easier to
>>>> understand and use.
>>>>>> System administrators can now use this parameter to determine how easy
>>>>>> they want OOM kills to happen for applications that tend to consume
>>>>>> a lot of memory without the need to run a special userspace memory
>>>>>> management tool to monitor memory consumption when memory.high is set.
>>>>> Why cannot they achieve the same with the existing events/metrics we
>>>>> already do provide? Most notably PSI which is properly accounted when
>>>>> a task is throttled due to memory.high throttling.
>>>> That will require the use of a userspace management agent that looks for
>>>> these stalling conditions and make the kill, if necessary. There are
>>>> certainly users out there that want to get some benefit of using memory.high
>>>> like early memory reclaim without the trouble of handling these kind of
>>>> stalling conditions.
>>> So you basically want to force the workload into some sort of a proactive
>>> reclaim but without an artificial slow down?
> I wouldn't call it a proactive reclaim as reclaim will happen
> synchronously in allocating thread.
>
>>> It makes some sense to me, but
>>> 1) Idk if it deserves a new API, because it can be relatively easy implemented
>>>     in userspace by a daemon which monitors cgroups usage and reclaims the memory
>>>     if necessarily. No kernel changes are needed.
>>> 2) If new API is introduced, I think it's better to introduce a new limit,
>>>     e.g. memory.target, keeping memory.high semantics intact.
>> Yes, you are right about that. Introducing a new "memory.target" without
>> disturbing the existing "memory.high" semantics will work for me too.
>>
> So, what happens if reclaim can not reduce usage below memory.target?
> Infinite reclaim cycles or just give up?

Just give up in this case. It is used mainly to reduce the chance of 
reaching max and cause OOM kill.

Cheers,
Longman


