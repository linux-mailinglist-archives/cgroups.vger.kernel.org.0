Return-Path: <cgroups+bounces-13019-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DF7D0C29D
	for <lists+cgroups@lfdr.de>; Fri, 09 Jan 2026 21:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CDD7304EF7A
	for <lists+cgroups@lfdr.de>; Fri,  9 Jan 2026 20:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1854B366DD9;
	Fri,  9 Jan 2026 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDP1ehfe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="boG82I/d"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61394366DDA
	for <cgroups@vger.kernel.org>; Fri,  9 Jan 2026 20:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989765; cv=none; b=CmVbyak8+UXlcGmFjLXAY5LD0ASriV0Z86BK/DqfFaiahM7w2G3FSUx3Z756CMVFb4C1+LsKujOEHw4lhz70sf3hVrf38F1w06UYCLslqDi7leH7/0mruK+S7VNXY452hr1ypLCKlQBbcIXXTv3DwMz18cPouWJr78OoXpJ2fuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989765; c=relaxed/simple;
	bh=rvJ38UMzE8ZlTaHPsSbXdymEzp3uBM8+aX58pIa4PJU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GpZrLjA36SEVR/fh5Qdb/PTjk1uaUs5WK4816i6Br56bgGLPD7qCSDCCD9L4Mfvss2E85j83F5WMzmlw0QarKdooOQHz7TD+QL+F4mLW9lnQS4dxGNNDj0ekM2bqjcs2s1uw5GJtC/oefP3Pk3xePYQiECMnyP+41g6c8gq/MEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDP1ehfe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=boG82I/d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767989763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wHNNo39ERes87rvUHSVM+mGvySKBMq9Lj/fLe+R3e2U=;
	b=ZDP1ehfexCOz6bjQEQcJ94wgZMbOaUf9S0DbZGIOW2ZrOLnf0VRnIADVTAZDCwnXgi6SOv
	xGh3L9ZhxHiiwDmVS66lgebKYyZn5OE87XeAbINBFYSDWePNkoAVHWAIDCNstJoYmBhOlH
	doeJB6AM7Aejg8fvxvU7N9aQfGwxpNk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Ssw_TYWHP7OW3-cpZ7s8EQ-1; Fri, 09 Jan 2026 15:16:02 -0500
X-MC-Unique: Ssw_TYWHP7OW3-cpZ7s8EQ-1
X-Mimecast-MFC-AGG-ID: Ssw_TYWHP7OW3-cpZ7s8EQ_1767989762
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b17194d321so704703985a.0
        for <cgroups@vger.kernel.org>; Fri, 09 Jan 2026 12:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767989762; x=1768594562; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wHNNo39ERes87rvUHSVM+mGvySKBMq9Lj/fLe+R3e2U=;
        b=boG82I/d0tvZWk/gb+wphDOeJwNkNYqleHDt1omjn4j5Z5GtMcg6yWjTmqi4Rxm+Gd
         TlbwjC3zfUUCZ93jc2H+3jBCuFLJYxfkOjgOduRUg0nbrbxgVb+Jux+bKv4Fqwxku2WV
         Zw/yXLKf29oDmTrxIb/xzpEDQ0P3rAgeIC3P8VPzxh/yJoNCZnihEOY+MLT6mFjhNxyT
         keog1SGqaC+zkqrtdUTrzzrXe118TodfOu8jv6HiSHr84mWKLhswjLW18ij5ttlzm8I2
         mMxR+sCzTC9AnpwMarZdGW6ifX7r95pLjiZF7rVgaKSY8yNCvxwuhhvCS//+VkaXCmOK
         G1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767989762; x=1768594562;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wHNNo39ERes87rvUHSVM+mGvySKBMq9Lj/fLe+R3e2U=;
        b=deWz2L+J0RAA0aXHoE1aHCKlt1xJQ1JYRL5ESZF4Fs6v6CJJtguI9e65046+1ql8PV
         YzTBtHUVXltJOvseUrhxx+f+ZhO5nd2hBRoZOpJ9U16zAM5GaztJ2eg984D9hbQP4lht
         zHWoThrkPmDlAUU8WHAYpi5CWXrOvtLJz+dqBDjM7GQphAs9Z9iNYnVsRukdP6tLol9+
         FwEKCFLySUNj+XhVCPXSQoPUMU1YhaiLsFON92CAY0Mgcqtn+T0N6nVBCi20cN3x5nKw
         jWlaxKYvLbCoUycLABppMUa6TUY9Rij4j+yI94IdEHsbaSiNaeMDoj8SrR+plYadSv2o
         dQCg==
X-Forwarded-Encrypted: i=1; AJvYcCVvS+lTr3OGnj52RQJsPkvb3YFLYM/Tua4VmEnBIhsU/yX4a8kGEDg6RnaGhSyHX1nTr8ukTsrs@vger.kernel.org
X-Gm-Message-State: AOJu0YwzFPAAczmAr8eQnXG664i5rG42vOZxmY4LqcVl7lrBLHiwA8zV
	DcpOloCA/Myq7hOJIMotRxWb0wekIo/A8bwU6LK85DYDvLZaEhoWkEE+LFipxHyMp0NX6QDlTse
	upoc+uee33PlpGgWmngpZ1XuDEZw1J3621I+7+lXHMDUxtdeSfgNMYzDMk7s=
X-Gm-Gg: AY/fxX6iej+aW22LRk42CLxN8L9lsfk3z+EqLY3aGTJcC5tPtXKereJ/ctsD+DVD6pN
	B1zm329RwU06pXGHLaEHq+GrWGwKRdjWGNda3xUi1lA1JY0iJQK13MeQHr9DrbP7iKffmra0mFU
	YhrbBC2beJZcbMFSkOWCUxa9Wa7gFtETabD2ihmk1QwCNeAp6uvkRNFPXCXtWl5vpvGa6gxIg6b
	/kE6kjctpiDZbiFd6lOazuHTFWgvNQeToWGeVxXYzwHTYXKbV5ymAZGr1yuofwR3RY+E2Wtbyw4
	Xd3ZPxVLVTAUcYM7DEiLyeFeJcdM+H5JbuKYRanfqCwKZZdS1130Xe2eq1Etb/2OCiKPCNd5iS9
	mp3hY9rV6KCL0glMx0UOKJlF87x+cMhV01NaZgH9QJiF4IrFijtvuvTXx
X-Received: by 2002:a05:6214:2347:b0:7f5:eda2:a54b with SMTP id 6a1803df08f44-890842e1b55mr158596656d6.62.1767989760541;
        Fri, 09 Jan 2026 12:16:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7TVCdYN8leHhBwHPD8xom1NBdADFr0CHJ5abumSLsDJvK3oiOK+Hvt1acvPLkIJZlhitrww==
X-Received: by 2002:a05:6214:2347:b0:7f5:eda2:a54b with SMTP id 6a1803df08f44-890842e1b55mr158596076d6.62.1767989759917;
        Fri, 09 Jan 2026 12:15:59 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8907725ffc7sm81022946d6.44.2026.01.09.12.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jan 2026 12:15:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <0384dc28-bfff-4a74-9153-66d287888ce7@redhat.com>
Date: Fri, 9 Jan 2026 15:15:57 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.20 PATCH v2 2/4] cgroup/cpuset: Consistently
 compute effective_xcpus in update_cpumasks_hier()
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 Sun Shaojie <sunshaojie@kylinos.cn>
References: <20260101191558.434446-1-longman@redhat.com>
 <20260101191558.434446-3-longman@redhat.com>
 <758f42df-52c2-4660-8ef7-1cbacb9323d2@huaweicloud.com>
 <f8539426-92b0-42f3-99c4-70962c2db96d@redhat.com>
 <c17051c3-82ac-4ca5-8823-33327cadd073@huaweicloud.com>
 <ec6e1ee4-b52e-417f-9413-3dfca0ec8eb3@redhat.com>
 <d49cc8af-509b-44b8-ada4-f8bbdbd37f89@huaweicloud.com>
 <f541b93b-7bbf-4530-bca6-dc5b5b1f481c@redhat.com>
 <556672f7-b9b9-46a2-8a67-54ac615383d4@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <556672f7-b9b9-46a2-8a67-54ac615383d4@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/5/26 1:29 AM, Chen Ridong wrote:
>
> On 2026/1/5 12:06, Waiman Long wrote:
>> On 1/4/26 10:58 PM, Chen Ridong wrote:
>>> On 2026/1/5 11:50, Waiman Long wrote:
>>>> On 1/4/26 8:15 PM, Chen Ridong wrote:
>>>>> On 2026/1/5 5:25, Waiman Long wrote:
>>>>>> On 1/3/26 9:48 PM, Chen Ridong wrote:
>>>>>>> On 2026/1/2 3:15, Waiman Long wrote:
>>>>>>>> Since commit f62a5d39368e ("cgroup/cpuset: Remove remote_partition_check()
>>>>>>>> & make update_cpumasks_hier() handle remote partition"), the
>>>>>>>> compute_effective_exclusive_cpumask() helper was extended to
>>>>>>>> strip exclusive CPUs from siblings when computing effective_xcpus
>>>>>>>> (cpuset.cpus.exclusive.effective). This helper was later renamed to
>>>>>>>> compute_excpus() in commit 86bbbd1f33ab ("cpuset: Refactor exclusive
>>>>>>>> CPU mask computation logic").
>>>>>>>>
>>>>>>>> This helper is supposed to be used consistently to compute
>>>>>>>> effective_xcpus. However, there is an exception within the callback
>>>>>>>> critical section in update_cpumasks_hier() when exclusive_cpus of a
>>>>>>>> valid partition root is empty. This can cause effective_xcpus value to
>>>>>>>> differ depending on where exactly it is last computed. Fix this by using
>>>>>>>> compute_excpus() in this case to give a consistent result.
>>>>>>>>
>>>>>>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>>>>>>> ---
>>>>>>>>      kernel/cgroup/cpuset.c | 14 +++++---------
>>>>>>>>      1 file changed, 5 insertions(+), 9 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>>>>>> index da2b3b51630e..37d118a9ad4d 100644
>>>>>>>> --- a/kernel/cgroup/cpuset.c
>>>>>>>> +++ b/kernel/cgroup/cpuset.c
>>>>>>>> @@ -2168,17 +2168,13 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks
>>>>>>>> *tmp,
>>>>>>>>              spin_lock_irq(&callback_lock);
>>>>>>>>              cpumask_copy(cp->effective_cpus, tmp->new_cpus);
>>>>>>>>              cp->partition_root_state = new_prs;
>>>>>>>> -        if (!cpumask_empty(cp->exclusive_cpus) && (cp != cs))
>>>>>>>> -            compute_excpus(cp, cp->effective_xcpus);
>>>>>>>> -
>>>>>>>>              /*
>>>>>>>> -         * Make sure effective_xcpus is properly set for a valid
>>>>>>>> -         * partition root.
>>>>>>>> +         * Need to compute effective_xcpus if either exclusive_cpus
>>>>>>>> +         * is non-empty or it is a valid partition root.
>>>>>>>>               */
>>>>>>>> -        if ((new_prs > 0) && cpumask_empty(cp->exclusive_cpus))
>>>>>>>> -            cpumask_and(cp->effective_xcpus,
>>>>>>>> -                    cp->cpus_allowed, parent->effective_xcpus);
>>>>>>>> -        else if (new_prs < 0)
>>>>>>>> +        if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
>>>>>>>> +            compute_excpus(cp, cp->effective_xcpus);
>>>>>>>> +        if (new_prs < 0)
>>>>>>>>                  reset_partition_data(cp);
>>>>>>>>              spin_unlock_irq(&callback_lock);
>>>>>>>>      
>>>>>>> The code resets partition data only for new_prs < 0. My understanding is that a partition is
>>>>>>> invalid
>>>>>>> when new_prs <= 0. Shouldn't reset_partition_data() also be called when new_prs = 0? Is there a
>>>>>>> specific reason to skip the reset in that case?
>>>>>> update_cpumasks_hier() is called when changes in a cpuset or hotplug affects other cpusets in the
>>>>>> hierarchy. With respect to changes in partition state, it is either from valid to invalid or vice
>>>>>> versa. It will not change from a valid partition to member. The only way new_prs = 0 is when
>>>>>> old_prs
>>>>>> = 0. Even if the affected cpuset is processed again in update_cpumask_hier(), any state change
>>>>>> from
>>>>>> valid partition to member (update_prstate()), reset_partition_data() should have been called
>>>>>> there.
>>>>>> That is why we only care about when new_prs != 0.
>>>>>>
>>>>> Thank you for your patience.
>>>>>
>>>>>> The code isn't wrong here. However I can change the condition to (new_prs <= 0) if it makes it
>>>>>> easier to understand.
>>>>>>
>>>>> I agree there's nothing wrong with the current logic. However, for clarity, I suggest changing the
>>>>> condition to (new_prs <= 0). This allows the function's logic to be fully self-consistent and
>>>>> focused on a single responsibility. This approach would allow us to simplify the code to:
>>>>>
>>>>>       if (new_prs > 0)
>>>>>           compute_excpus(cp, cp->effective_xcpus);
>>>>>       else
>>>>>           reset_partition_data(cp);
>>>>>
>>>>> Since reset_partition_data() already handles cases whether cp->exclusive_cpus is empty or not, this
>>>>> implementation would be more concise while correctly covering all scenarios.
>>>> effective_xcpus should be set when exclusive_cpus is not empty or when the cpuset is a valid
>>>> partition root. So just checking new_prs for compute_excpus() is not enough.
>>>>
>>> If we change the condition to (new_prs <= 0), it will reset the partition data even when we call
>>> compute_excpus (for !cpumask_empty(cp->exclusive_cpus)), so we should still get the same result,
>>> right?
>> Changing the condition to (new_prs <= 0) won't affect the result except for a bit of wasted cpu
>> cycles. That is why I am planning to make the change in the next version to make it easier to
>> understand.
>>
> Sorry, I should have been clearer. If we change the condition, the code would essentially be:
>
> 	if ((new_prs > 0) || !cpumask_empty(cp->exclusive_cpus))
> 		compute_excpus(cp, cp->effective_xcpus);
>          if (new_prs <= 0)
> 		reset_partition_data(cp);
>
> For cases where new_prs <= 0 && !cpumask_empty(cp->exclusive_cpus), both compute_excpus() and
> reset_partition_data() would be called.
>
> Is this functionally equivalent to:
>
> 	if (new_prs > 0)
> 		compute_excpus(cp, cp->effective_xcpus);
>          else (new_prs <= 0)
> 		reset_partition_data(cp);

They are not equivalent because reset_partition_data() won't do a 
compute_excpus(). In fact, one of the tests in test_cpuset_prs.sh will 
fail if we make this change.

Cheers,
Longman


