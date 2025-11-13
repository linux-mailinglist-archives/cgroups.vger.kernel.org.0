Return-Path: <cgroups+bounces-11909-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 268FCC557DD
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 03:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 966C934AA7D
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B3327EFF1;
	Thu, 13 Nov 2025 02:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O70Oa0Ig";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnyAeb1M"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3F267386
	for <cgroups@vger.kernel.org>; Thu, 13 Nov 2025 02:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002699; cv=none; b=VEsoCtm5+SAOOE9F1kV/YNzKeuW/B4J+Fs5AsC+4boWzwTmW+Cq+NBW+6USuOObIqPzbcP0rmHo4qJEmIpghNeRzmv0f5dGAO5mJyBDzPeCARisRWwMChYldFN3O3Crxs+oMK/yPe9rbbBebcAiCc699l/qSNpN7Yw8lCeJPBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002699; c=relaxed/simple;
	bh=URr2GWgMqg4/UZy/ikV0oAg3d42BB6TjJ0Lgy33cXr8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fdwl4fYO7aPXBXoJWnMLLITjhS1yKfLu4wqcsxLKdrEY4+/kK288e6TmHhO881pRp/U5ISj1Yor3CZGfokP9lsfWF5pv3wnDrEV3PmECzdb5TIfCeRn1QYfpdf5XdkenCqTskSo6zTnJxJk9KBk+KxfkktebM1x8Y8FgGdsdKT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O70Oa0Ig; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnyAeb1M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763002694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qYahr3l6S8/lLKHWsnHDWpWEX+v5P3nHJi3oVBsaZAA=;
	b=O70Oa0IgQz1Rbjr/EgeAzkeCBjTmfceOVlQwNvpebvb7WGjZD7TEhHc9BEMzGwuT/rvhjm
	v6gPVMvIux22dopV8ZWP/TWJv2xEmyILAg1AN1EzHjU+UB/VtxCjTRBTUzFETOWNA2j42r
	cLek5OCXG1dZUqk5SZd1MewlqhwQfHM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102--CbI9xPSN2ez8vI5eRoX5Q-1; Wed, 12 Nov 2025 21:58:11 -0500
X-MC-Unique: -CbI9xPSN2ez8vI5eRoX5Q-1
X-Mimecast-MFC-AGG-ID: -CbI9xPSN2ez8vI5eRoX5Q_1763002691
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8804b991a54so16905356d6.2
        for <cgroups@vger.kernel.org>; Wed, 12 Nov 2025 18:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763002691; x=1763607491; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qYahr3l6S8/lLKHWsnHDWpWEX+v5P3nHJi3oVBsaZAA=;
        b=AnyAeb1Mmygv3vDS7gf0t8ixAyqHeaMwTYkq6Z8cAPU2ofMB0MTfTmnnESA/XNO/RR
         mVlYYtv9lio1A0H8x7uQGcOB7yZNlsHsP6nnfhh6yOZo1IKcWpSa9msU7aWHXBzH/Wrf
         VQu9OTPr+rr7KfeZfwNnRlD5JsUuiXgX71PURPvcalVJHvUgZAY/qjDOxGc8p1groR0q
         VrhzoYT0edqHjuEW1KyvOrl7bocW6CSeI3o4iA3jSdTb/RBaSaZs2KsLBuq2RcUiGUgf
         s+tRZHwMYeDdZnG/kASneozsqCnKeEt9MisqX+PegLi6dYG9Mi38WE54+Ny7oawgG0Aj
         /Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763002691; x=1763607491;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qYahr3l6S8/lLKHWsnHDWpWEX+v5P3nHJi3oVBsaZAA=;
        b=ZfckZXGfhVxO24NwPnvugh7Efoqvv51avuwT+79NSk46Iom8OssKeELYI8Gy7S+YW3
         wmCyKckipB1pr1JoxkYJS2uelJFdAgYb0rAj9bJA5cplwpk6wTnWOi5b0VtfV7/IKg+F
         FXmQpVcCVC2VxjC4ZIEUvbRAV0cAftY4GwWVzeXbNJ10c00Ueong2Xmgjn9+PE3ILIRt
         miROf5cIMjBg9LQ6fNLketxg5srsyjYK1uCI305zD5KyxtdYzKAmr1fbVAFRkiwH3MX6
         +X6pODTzexeZLIUgsEzWPc63nZ7GQ3Bf7OzvDvck2HqF+h1oe2vCqqDdu1NNdYH8Knwe
         7qeA==
X-Gm-Message-State: AOJu0YzJN7F3asrPvt4ZvNzAIBWzFV1KyFWi6tV9/wHvLx6S7CWe/X3Y
	WtpBxiCzUzE4wJUPNvxL6/4KupfoQ+75jWtwnkbY3H3BFVHzIQnNkKnGfxfwvqauXu1TYo+9dPj
	ABFPPnuxIWr4gTj7w2ScCXjKC7KcYlHvSIKe3pQdTQ+b/l5Wqzt6/xZMSoPc=
X-Gm-Gg: ASbGncsZ67MvXcFSiAwalgIbiwOJ7i9CuTLzYh8YXo26diRe0jI8TovY2e2V5I5TGUC
	ygn1H/5wVvVCMCJJBP58Xd9zoYAmVBF0cy1XgLFuPiWOBfk0pzaM6i+6DK1I2gXIQosrA1D8SEZ
	T4utm6AqzHbQphsp3AmMqF3mlvkZNjMN5dwH1LPvH6HlC8AgOFwC3aO1wOfyGAfUF9a/GYrOt+9
	TJ+85Y3ZBMuxp9Es76LceOowU0o/yipd7tXPoEY1jyX1oWFvjUurlYBCtmLNj+R2s5lykO02y00
	8jsNRnsiKEhhz7kBOTqmZP/oSsK6b5jBOH4+t0bpNLZXpKDgGcijat/MwKDDpKNcYuiYxzpv48W
	gpTTtTzO7/1oq2RR1fRIpPyKtqgwa1b4NYebf5BNdSvhneQ==
X-Received: by 2002:ad4:5c4b:0:b0:882:401c:e384 with SMTP id 6a1803df08f44-88271a513d0mr81048156d6.61.1763002691104;
        Wed, 12 Nov 2025 18:58:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZrmW3eaQyu9gAhAVlHHtsho+Fotz/bD7BkEK7Pfn0BzFZfwqltc0jfxsdXtb9Zq62O6mbRQ==
X-Received: by 2002:ad4:5c4b:0:b0:882:401c:e384 with SMTP id 6a1803df08f44-88271a513d0mr81048086d6.61.1763002690759;
        Wed, 12 Nov 2025 18:58:10 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865abc2asm3758176d6.54.2025.11.12.18.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 18:58:10 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8bb19728-8611-4266-aa8e-6dd4783c4702@redhat.com>
Date: Wed, 12 Nov 2025 21:58:08 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 10/22] cpuset: introduce local_partition_enable()
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-11-chenridong@huaweicloud.com>
 <71121d12-0cb2-4ffe-92e5-caf25bf4596e@redhat.com>
 <47c20c78-9f7f-4134-8835-3c4f5bff4c30@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <47c20c78-9f7f-4134-8835-3c4f5bff4c30@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/12/25 9:49 PM, Chen Ridong wrote:
>
> On 2025/11/13 5:47, Waiman Long wrote:
>> On 10/25/25 2:48 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> The partition_enable() function introduced in the previous patch can be
>>> reused to enable local partitions.
>>>
>>> The local_partition_enable() function is introduced, which factors out the
>>> local partition enablement logic from update_parent_effective_cpumask().
>>> After passing local partition validation checks, it delegates to
>>> partition_enable() to complete the partition setup.
>>>
>>> This refactoring creates a clear separation between local and remote
>>> partition operations while maintaining code reuse through the shared
>>> partition_enable() infrastructure.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 94 ++++++++++++++++++++++++++----------------
>>>    1 file changed, 59 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 5b57c5370641..b308d9f80eef 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -1822,6 +1822,61 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>>>        remote_partition_disable(cs, tmp);
>>>    }
>>>    +/**
>>> + * local_partition_enable - Enable local partition for a cpuset
>>> + * @cs: Target cpuset to become a local partition root
>>> + * @new_prs: New partition root state to apply
>>> + * @tmp: Temporary masks for CPU calculations
>>> + *
>>> + * This function enables local partition root capability for a cpuset by
>>> + * validating prerequisites, computing exclusive CPUs, and updating the
>>> + * partition hierarchy.
>>> + *
>>> + * Return: 0 on success, error code on failure
>>> + */
>>> +static int local_partition_enable(struct cpuset *cs,
>>> +                int new_prs, struct tmpmasks *tmp)
>>> +{
>>> +    struct cpuset *parent = parent_cs(cs);
>>> +    enum prs_errcode part_error;
>>> +    bool cpumask_updated = false;
>>> +
>>> +    lockdep_assert_held(&cpuset_mutex);
>>> +    WARN_ON_ONCE(is_remote_partition(cs));    /* For local partition only */
>>> +
>>> +    /*
>>> +     * The parent must be a partition root.
>>> +     * The new cpumask, if present, or the current cpus_allowed must
>>> +     * not be empty.
>>> +     */
>>> +    if (!is_partition_valid(parent)) {
>>> +        return is_partition_invalid(parent)
>>> +            ? PERR_INVPARENT : PERR_NOTPART;
>>> +    }
>>> +
>>> +    /*
>>> +     * Need to call compute_excpus() in case
>>> +     * exclusive_cpus not set. Sibling conflict should only happen
>>> +     * if exclusive_cpus isn't set.
>>> +     */
>>> +    if (compute_excpus(cs, tmp->new_cpus))
>>> +        WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
>>> +
>>> +    part_error = validate_partition(cs, new_prs, tmp->new_cpus);
>>> +    if (part_error)
>>> +        return part_error;
>>> +
>>> +    cpumask_updated = cpumask_andnot(tmp->addmask, tmp->new_cpus,
>>> +                     parent->effective_cpus);
>> What is the purpose of this cpumask_andnot() operation? Is it just to create the cpumask_updated
>> boolean? At this point, cpumask_updated should always be true. If not, we have to add validation
>> check to return an error.
>>
>> Cheers,
>> Longman
>>
> I want to support switching the root partition’s state between "root" and "isolated"—for example, an
> isolated partition switching to root without changing its CPU mask.
>
> Adding a comment to clarify this behavior would be helpful.

For state switching, I would suggest to use a separate helper just for 
state switching as such switching can be done to both local and remote 
partition.

Cheers,
Longman


