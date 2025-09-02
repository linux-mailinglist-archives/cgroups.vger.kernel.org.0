Return-Path: <cgroups+bounces-9618-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D820B403A7
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 15:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 669F23B37A9
	for <lists+cgroups@lfdr.de>; Tue,  2 Sep 2025 13:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9A9324B02;
	Tue,  2 Sep 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q4j9hcfj"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828E30F813
	for <cgroups@vger.kernel.org>; Tue,  2 Sep 2025 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819825; cv=none; b=bsaGA0m2IuuAa96Nb4pVXORJ+QHYdoiw8hv264dSWWjVwmQ7JVg2I1muiMmsxwMgSUvsGFBcAvCDsZz9Uc81WGG3yk+oYiADQLr9d6YPrd4OXfl1wZf0Lpc4dFNWj8TCmxZbYx1OjYT2U6A+BbkFKjy8DXxJRnBIER9NejCDzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819825; c=relaxed/simple;
	bh=g3sifc9TW5tsJF8SxDzkpDMgfvwIfT1Q5I/5Dy+fJ6I=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FcoCeQEGAh9/WO5ARKLEFCu839Nh6J/EgGg5zYwUbnvJfX3vDH9rGmVKClDWggxHwGIlst7HdNRNSYB6cHKLXJRdfQZxaWHKd1THItpaeoJ88RwMfT1nNBcyB/W9mwRLr9eyj/YCqVY0zii30AMcc4StIRdbUFGMl0Y//V/5rj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q4j9hcfj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756819822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b5rIBDXadKc0Riamv/Bxc9wrw9KFcdiEe2g6YluW24E=;
	b=Q4j9hcfj0pxelvjHskWwLGEcP/UWeCJXFlvo1qLZg1QICLV2kIG+7dlRH/WETHBqBNISZs
	KFMvj/E/FFXWfhRqfXeUoiWpEChVx6aLm7jltlhkQkqmIZLiIHTti/ypRwPUOQwiJk2mzn
	mRqXJ0K7U9BX/dnoC1/ydTkOq9WwAmM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-XrXUuzBuMLGSsjhEzIJs_A-1; Tue, 02 Sep 2025 09:30:21 -0400
X-MC-Unique: XrXUuzBuMLGSsjhEzIJs_A-1
X-Mimecast-MFC-AGG-ID: XrXUuzBuMLGSsjhEzIJs_A_1756819821
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b311414656so120278431cf.3
        for <cgroups@vger.kernel.org>; Tue, 02 Sep 2025 06:30:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756819820; x=1757424620;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5rIBDXadKc0Riamv/Bxc9wrw9KFcdiEe2g6YluW24E=;
        b=tGPzw1ZQuQRWHQpm3mNpULoI6hblnUwUgXeib/PJjy3PyknI8txule5lBz29rCmrfI
         41drCJktBl7C6vMvi1UEVaTFy8eJflcJNLqzmVkPdjAuvRBzd0cyMX3OcxY/jSD5O5v1
         v5P3eGb2EViinaAK2W/YzhVWWcMBdLGmgFIY9eRywyGNDdV8Kj5dtPwfN7KWFvERUZhe
         SsPA3kBdtPfrfpDOfCmd1EEJbEjVsiMA4vjcgKptFpanW6+JX5EPGDqs7TFjhCFPt3V+
         g/Nwd4MQOE9yOLHvaaZ2FzqhvIsTWiNuHSohDlOOVudWtDixV4kYQf9e1peB8JKDiPau
         bBlQ==
X-Gm-Message-State: AOJu0Yz+ny42aSWWxCCf1KRKseub0zmJi1GiUeYu1uxmm9JsY52K5s7p
	TFfPtKeUe/0nc99jhRZRRmtozJSTbZXy0khXFR5n5V9EaPA6XRYuL7i1c1lteGzE7zzResoQFkB
	p10ygz9afbqpWCNTvOmImoS53VPKtyu2iZCTNSSq3o9RBk4POlFMX/h5IvkTNpHp7JWQ=
X-Gm-Gg: ASbGncvQUkCi3omWtAtEnFdXfeNUdO/vt1LIZFCmDSTp3ZS2373Lh2Oc/qsRR8M49rn
	yFcjy+dl5EK2tQh8fI+mbwPuHQEE8YzieeRVjHzHoeOrkueM/X1llpw+K+vf2mBp+dXZ3ghFAFc
	ZBSxFhBeMibEsb+MYjvOiyZQYbZJ5nxK/n4FVJdB/EoZ0jn5V/j8jKBBnkgYQG4g+qjKixwxJ20
	99KrFQV/QGEt/ra9lA8aakdUy/Va/USonFPU1sQ9pEil6mGiJWpkV2k4hzsWNCbrzHrNBLL2Cxm
	9sSxGf2ZmtWfctNjKoMsgEJRSfhxWYoGT1PGxZp507Y/wlntxzHGzDciemudNPzM+DlbnFbsH/T
	6HR/IYRULug==
X-Received: by 2002:a05:622a:5443:b0:4b3:4d20:2f6 with SMTP id d75a77b69052e-4b34d200c44mr11166171cf.19.1756819819612;
        Tue, 02 Sep 2025 06:30:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDYAIOyEc9Fw0i0zuOWxfALXYIKNMMLAs3fedzZX/lCIFNOzBsogoQf3qUBhtg2wrUl6dh1A==
X-Received: by 2002:a05:622a:5443:b0:4b3:4d20:2f6 with SMTP id d75a77b69052e-4b34d200c44mr11165501cf.19.1756819818750;
        Tue, 02 Sep 2025 06:30:18 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8069ccec9besm130589885a.53.2025.09.02.06.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 06:30:18 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <2a6759fa-841a-4185-ae94-b8215c93daf5@redhat.com>
Date: Tue, 2 Sep 2025 09:30:17 -0400
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 09/11] cpuset: refactor partition_cpus_change
To: Chen Ridong <chenridong@huaweicloud.com>, Waiman Long <llong@redhat.com>,
 tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-10-chenridong@huaweicloud.com>
 <632cd2ab-9803-4b84-8dd9-cd07fbe73c95@redhat.com>
 <031d83b6-bc67-4941-8c49-e1d12df74062@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <031d83b6-bc67-4941-8c49-e1d12df74062@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/29/25 10:01 PM, Chen Ridong wrote:
>
> On 2025/8/30 4:32, Waiman Long wrote:
>> On 8/28/25 8:56 AM, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> Refactor the partition_cpus_change function to handle both regular CPU
>>> set updates and exclusive CPU modifications, either of which may trigger
>>> partition state changes. This generalized function will also be utilized
>>> for exclusive CPU updates in subsequent patches.
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>    kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++----------------
>>>    1 file changed, 36 insertions(+), 23 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index 75ad18ab40ae..e3eb87a33b12 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -2447,6 +2447,41 @@ static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>>>        return retval;
>>>    }
>>>    +/**
>>> + * partition_cpus_change - Handle partition state changes due to CPU mask updates
>>> + * @cs: The target cpuset being modified
>>> + * @trialcs: The trial cpuset containing proposed configuration changes
>>> + * @tmp: Temporary masks for intermediate calculations
>>> + *
>>> + * This function handles partition state transitions triggered by CPU mask changes.
>>> + * CPU modifications may cause a partition to be disabled or require state updates.
>>> + */
>>> +static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>>> +                    struct tmpmasks *tmp)
>>> +{
>>> +    if (cs_is_member(cs))
>>> +        return;
>>> +
>>> +    invalidate_cs_partition(trialcs);
>>> +    if (trialcs->prs_err)
>>> +        cs->prs_err = trialcs->prs_err;
>>> +
>>> +    if (is_remote_partition(cs)) {
>>> +        if (trialcs->prs_err)
>>> +            remote_partition_disable(cs, tmp);
>>> +        else
>>> +            remote_cpus_update(cs, trialcs->exclusive_cpus,
>>> +                       trialcs->effective_xcpus, tmp);
>>> +    } else {
>>> +        if (trialcs->prs_err)
>>> +            update_parent_effective_cpumask(cs, partcmd_invalidate,
>>> +                            NULL, tmp);
>>> +        else
>>> +            update_parent_effective_cpumask(cs, partcmd_update,
>>> +                            trialcs->effective_xcpus, tmp);
>>> +    }
>>> +}
>>> +
>>>    /**
>>>     * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>>>     * @cs: the cpuset to consider
>>> @@ -2483,29 +2518,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>>         */
>>>        force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>>>    -    invalidate_cs_partition(trialcs);
>>> -    if (trialcs->prs_err)
>>> -        cs->prs_err = trialcs->prs_err;
>>> -
>>> -    if (is_partition_valid(cs) ||
>>> -       (is_partition_invalid(cs) && !trialcs->prs_err)) {
>>> -        struct cpumask *xcpus = trialcs->effective_xcpus;
>>> -
>>> -        if (cpumask_empty(xcpus) && is_partition_invalid(cs))
>>> -            xcpus = trialcs->cpus_allowed;
>> This if statement was added in commit 46c521bac592 ("cgroup/cpuset: Enable invalid to valid local
>> partition transition") that is missing in your new partition_cpus_change() function. Have you run
>> the test_cpuset_prs.sh selftest with a patched kernel to make sure that there is no test failure?
>>
>> Cheers,
>> Longman
> Thank you Longman,
>
> I did run the self-test for every patch, and I appreciate the test script test_cpuset_prs.sh you
> provided.
>
> The trialcs->effective_xcpus will be updated using compute_trialcs_excpus, which was introduced in
> Patch 4. The corresponding logic was then added in Patch 5:
>
> -	cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +	/* trialcs is member, cpuset.cpus has no impact to excpus */
> +	if (cs_is_member(cs))
> +		cpumask_and(excpus, trialcs->exclusive_cpus,
> +				parent->effective_xcpus);
> +	else
> +		cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
> +
>
> Therefore, as long as excpus is computed correctly, I believe this implementation can handle the
> scenario appropriately.

It will be helpful to put down a note in the commit log that the missing 
logic will be re-introduced in a subsequent patch.

Thanks,
Longman


