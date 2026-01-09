Return-Path: <cgroups+bounces-13007-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C00D0716E
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 05:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60A033008F4E
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 04:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401272D8771;
	Fri,  9 Jan 2026 04:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ae0+TRgm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLjGaz7n"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F32C11F7
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767932076; cv=none; b=ZQAqls0gPSkSqFF1PLDkPf2OWhnhGHnN1vsnFKIitTf0ny5BYSZBkyfnXYrXS3ja84AGliK0wN4SVq+sFLuU0prYTGupft1P58QSMKXVBxrBT8sMVCIBry67RK1srMe4T2C0v/6j6i2W073PMSgdhHYNC5xfMgORsjUFnpUC7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767932076; c=relaxed/simple;
	bh=i1fLrSbyd81f0S0PiHsOLrXgKUHshwekbk4YumK+lKk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fkY1jXk7T0UKYmzCIeX3U/3OoCoZJuMispMKFpVNy6mUsJ+D92tm7kLI/iujXt4RLZU22fgF6U6xCsDsWQoPlW8ppsRVjyZbsFWI/2LDVO8qm5za1Y1z2D1fZsKmBzlVDJ/TqIjvU7sNRG8vw+nateyzgtHS55b+D/cof8AykM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ae0+TRgm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PLjGaz7n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767932073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nghXJ/jMMYOZQxSCZgT2jI2VxzkfVAzdpBsOhl57SOs=;
	b=Ae0+TRgm8FJnjtxgd9755m8pWzci3SXr9NIlTz8Ydz5lFJLyxVkrf8/PXEtivXkcONYtsJ
	+LdoEi4d3lZ+Q171h+QcOa1B5ynsIzGUVe0Lql199YTOX842Ig+DGPPj6/AmhBIheCRhc6
	9KEFG/K2V9Ek7toKxvPb3FizNBj07mY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-f5KzmjqHNQ-1H0-QW70nZA-1; Thu, 08 Jan 2026 23:14:32 -0500
X-MC-Unique: f5KzmjqHNQ-1H0-QW70nZA-1
X-Mimecast-MFC-AGG-ID: f5KzmjqHNQ-1H0-QW70nZA_1767932072
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b2e2342803so977499485a.3
        for <cgroups@vger.kernel.org>; Thu, 08 Jan 2026 20:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767932072; x=1768536872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nghXJ/jMMYOZQxSCZgT2jI2VxzkfVAzdpBsOhl57SOs=;
        b=PLjGaz7nWTId2VHn6Uav8QWh9xGVRMUtP04PZuZlRnyHeUtp5anTHLN5E90RcU79qe
         BYfkLmqgFbvQAWz/qncfzKPjzX5EWzYtQcDxhOVB5fSjzm7n1y+zpCib1xCPb1LuEeTf
         r71GHWejbPtBl5+QcelfIsCeyLpgXYeDnjgXDQXnQpFkyan5x4oh6LuQvUgmVnpRs35o
         7TjUEy+5pMPAioHYp2CnBRK4xXJiMIRAnlmHMfKuPFFaiW0qwAe+ctXi3xHWQ5ez3q0q
         JNkitT8obJ80z0VCkSr+OARIgjLseVmfC6H6PD5S8mX4IKj9EVPW4k7mSrJZ51cezj0r
         3iHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767932072; x=1768536872;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nghXJ/jMMYOZQxSCZgT2jI2VxzkfVAzdpBsOhl57SOs=;
        b=CyC+VA5L8909jZOBVLfymXF7wMqvoOQRrf/T1KOzTRTYvbdRvKCVCE3zrFz5+nnVcd
         bA15i+ImHcCadCOR8N9Yg050FmX2CFfv4tWam6GUvP6tTVT5pL8UWquTh/BfTZGbRnWU
         3uO1QY8bBzq+LEudmkKnH4hz29x7Ijzku/9RQakm8RFcYfoSZhfCesS8VakVKav1uf9X
         FIBANMAW6buAIky2DK65TyLW69LfMxgWFHMPNrMmhHzF8H6Ef1ZooOEcL6fq8OyPGKU+
         4xp7pCH6ZyoW/cJKlmtEGp3kg3ftVh7ktOUA3h9Ka6+LGm67zY0+BqKKLY8XFWNbKYrW
         LDuA==
X-Forwarded-Encrypted: i=1; AJvYcCWIAchMtupAM8l3jEstbj3bHzB/cYrjmG8sIgPiLZPA/lVaic3HgYGnHHMzv8FuUc22vjLMXjH+@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0tnnwdSZfeHbJDW3CZUp/G8xvvS9C8KGYI1WuxPuHOhE9Uqf
	3tJgVKti+54I2GoAEh5/4Us59so8Y6X82rhv5fKMUB5pEcYNwFdE0R6oBCyS2q68tFO12QWKslz
	ispdhLhIi2PU/aIvoEbf1mTHhXg2PEVkv+h4j7GLNWsb+DFW5GjUq/6Sr12Y=
X-Gm-Gg: AY/fxX5iuoAvp8mRBnv9GMQhYHuydteOaAzmziV1TbfQjvMCwFsI358XvlFPP2KVYj8
	ZkALUZxTbzqrChTdoGsAFkwJ3geXnsvKzOILQdkiV2fiSeSg81iKAKPEDgerVVEKPSKpzjzvwrN
	HWB+opwkSLQJ2IrOOJClBDdDsjF0zrTy9J6/bNOltW9D8+hMvqFv8AunWyN2h7tnh9IhF6HZwsl
	U7pICZx/ED6bbOQ+e5AxyCfEaoMxfwkqRs9elISpxTzA8GX/TZN/TcUN0BsgPMvmEn8L9EwCPxG
	z7dwINzsraOo2GBP6Yg7ksqpJrda6kuPn9Ojoco+wUgh/lQ27R+LDgPnKacY3Uc6cQ6PRauZ2nv
	89Jm+HAY3YvMa+XFpjivEZRZJt77+ZW4KiMNpoiLBFD00+9tNuQvoZRk7
X-Received: by 2002:a05:620a:4804:b0:8b2:e0ad:eb97 with SMTP id af79cd13be357-8c3894172cbmr1167824985a.83.1767932071827;
        Thu, 08 Jan 2026 20:14:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfApg85dIzy0/UVGbmmnaqdWN/LcvlttlnRbWN6UZZYR6Gg703S6psJlUfwcLoLX8mA87/aw==
X-Received: by 2002:a05:620a:4804:b0:8b2:e0ad:eb97 with SMTP id af79cd13be357-8c3894172cbmr1167822485a.83.1767932071381;
        Thu, 08 Jan 2026 20:14:31 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a6145sm730500485a.5.2026.01.08.20.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 20:14:30 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <828377cf-4a64-48b4-887e-8f71ebed502c@redhat.com>
Date: Thu, 8 Jan 2026 23:14:28 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 3/4] cgroup/cpuset: Don't fail
 cpuset.cpus change in v2
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-4-longman@redhat.com>
 <efdcd90c-95ed-4cfc-af9a-3dc0e8f0a488@huaweicloud.com>
 <6eedf67b-3538-4fd1-903b-b7d8db4ff43d@redhat.com>
 <7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com>
 <85f4bca2-e355-49ce-81e9-3b8080082545@redhat.com>
 <38ab0503-3176-43a0-b6b5-09de0fd9eb75@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <38ab0503-3176-43a0-b6b5-09de0fd9eb75@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/5/26 2:00 AM, Chen Ridong wrote:
>
> On 2026/1/5 11:59, Waiman Long wrote:
>> On 1/4/26 8:35 PM, Chen Ridong wrote:
>>> On 2026/1/5 5:48, Waiman Long wrote:
>>>> On 1/4/26 2:09 AM, Chen Ridong wrote:
>>>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>>>> Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
>>>>>> until valid partition") introduced a new check to disallow the setting
>>>>>> of a new cpuset.cpus.exclusive value that is a superset of a sibling's
>>>>>> cpuset.cpus value so that there will at least be one CPU left in the
>>>>>> sibling in case the cpuset becomes a valid partition root. This new
>>>>>> check does have the side effect of failing a cpuset.cpus change that
>>>>>> make it a subset of a sibling's cpuset.cpus.exclusive value.
>>>>>>
>>>>>> With v2, users are supposed to be allowed to set whatever value they
>>>>>> want in cpuset.cpus without failure. To maintain this rule, the check
>>>>>> is now restricted to only when cpuset.cpus.exclusive is being changed
>>>>>> not when cpuset.cpus is changed.
>>>>>>
>>>>> Hi, Longman,
>>>>>
>>>>> You've emphasized that modifying cpuset.cpus should never fail. While I haven't found this
>>>>> explicitly documented. Should we add it?
>>>>>
>>>>> More importantly, does this mean the "never fail" rule has higher priority than the exclusive CPU
>>>>> constraints? This seems to be the underlying assumption in this patch.
>>>> Before the introduction of cpuset partition, writing to cpuset.cpus will only fail if the cpu list
>>>> is invalid like containing CPUs outside of the valid cpu range. What I mean by "never-fail" is that
>>>> if the cpu list is valid, the write action should not fail. The rule is not explicitly stated in the
>>>> documentation, but it is a pre-existing behavior which we should try to keep to avoid breaking
>>>> existing applications.
>>>>
>>> There are two conditions that can cause a cpuset.cpus write operation to fail: ENOSPC (No space left
>>> on device) and EBUSY.
>>>
>>> I just want to ensure the behavior aligns with our design intent.
>>>
>>> Consider this example:
>>>
>>> # cd /sys/fs/cgroup/
>>> # mkdir test
>>> # echo 1 > test/cpuset.cpus
>>> # echo $$ > test/cgroup.procs
>>> # echo 0 > /sys/devices/system/cpu/cpu1/online
>>> # echo > test/cpuset.cpus
>>> -bash: echo: write error: No space left on device
>>>
>>> In cgroups v2, if the test cgroup becomes empty, it could inherit the parent's effective CPUs. My
>>> question is: Should we still fail to clear cpuset.cpus (returning an error) when the cgroup is
>>> populated?
>> Good catch. This error is for v1. It shouldn't apply for v2. Yes, I think we should fix that for v2.
>>
> The EBUSY check (through cpuset_cpumask_can_shrink) is necessary, correct?

Yes, it is a check needed by the deadline scheduler irrespective of if 
v1 or v2 is used.


>
> Since the subsequent patch modifies exclusive checking for v1, should we consolidate all v1-related
> code into a separate function like cpuset1_validate_change() (maybe come duplicate code)?, it would
> allow us to isolate v1 logic and avoid having to account for v1 implementation details in future
> features.
>
> In other words:
>
> validate_change(...)
> {
>      if (!is_in_v2_mode())
>          return cpuset1_validate_change(cur, trial);
>      ...
>      // only v2 code here
> }
>
Yes, we could move the code to cpuset1_validate_change().

Cheers,
Longman

cpuset1_validate_change


