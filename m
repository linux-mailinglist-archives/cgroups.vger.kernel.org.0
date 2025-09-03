Return-Path: <cgroups+bounces-9634-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A26B41176
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 02:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 929B31B21D0A
	for <lists+cgroups@lfdr.de>; Wed,  3 Sep 2025 00:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9844112C544;
	Wed,  3 Sep 2025 00:51:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22F313D8A4;
	Wed,  3 Sep 2025 00:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860671; cv=none; b=T2RA/e1nzoxzFuhMa0N7k47ST0gx6mQzAJH0tVWYNTZuUlLot5hrGk5abY1VP6iG/yWJd677KhAge0hVt8z7XpTRwmzKP26f5wIkvLyiBF2U7MUgFmL5vNax13i1dyWyqdK3Coa5s6OpT2vhhSIT7UWaz8NQaXeM34wIEHLVM0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860671; c=relaxed/simple;
	bh=C3cZzaStfc/7OYgj3ybp5ir4kuijBqq8oHaxOoVLGKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+20UnBullZBwz7di2MTA82feByXTVzY5H75ilhsqBsWxeOPmrcyUfl2duklejcMqXwa4VwPF26iobR5dJjB0wBMv8ltBpXGTXY2OnMxhgN/AxPQhTin872gZOaaIrFPjouU/aZOJzg/vKOkTudUoZn8SZuOTV6coFAvNgfu+SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGkZ23NbbzKHMW3;
	Wed,  3 Sep 2025 08:51:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 51EC01A0D1D;
	Wed,  3 Sep 2025 08:51:06 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgAXYY34kLdoYBnNBA--.25852S2;
	Wed, 03 Sep 2025 08:51:06 +0800 (CST)
Message-ID: <5a8b0ebe-95a5-4144-a1d5-b1a96c2312b9@huaweicloud.com>
Date: Wed, 3 Sep 2025 08:51:04 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 09/11] cpuset: refactor partition_cpus_change
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-10-chenridong@huaweicloud.com>
 <632cd2ab-9803-4b84-8dd9-cd07fbe73c95@redhat.com>
 <031d83b6-bc67-4941-8c49-e1d12df74062@huaweicloud.com>
 <2a6759fa-841a-4185-ae94-b8215c93daf5@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <2a6759fa-841a-4185-ae94-b8215c93daf5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXYY34kLdoYBnNBA--.25852S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr15Gr43Jr4xKrWDCF1kuFg_yoW7WryDpF
	1kJFWUJrW5Jr1rKw12qr1UWr9xtr1DJ3Zrtrn7X3WrJFy2yFnFgF1jqwn09r1xJr4xJr1U
	XF1jqrZruFy3ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUotCzDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/9/2 21:30, Waiman Long wrote:
> On 8/29/25 10:01 PM, Chen Ridong wrote:
>>
>> On 2025/8/30 4:32, Waiman Long wrote:
>>> On 8/28/25 8:56 AM, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> Refactor the partition_cpus_change function to handle both regular CPU
>>>> set updates and exclusive CPU modifications, either of which may trigger
>>>> partition state changes. This generalized function will also be utilized
>>>> for exclusive CPU updates in subsequent patches.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>>    kernel/cgroup/cpuset.c | 59 ++++++++++++++++++++++++++----------------
>>>>    1 file changed, 36 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index 75ad18ab40ae..e3eb87a33b12 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -2447,6 +2447,41 @@ static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
>>>>        return retval;
>>>>    }
>>>>    +/**
>>>> + * partition_cpus_change - Handle partition state changes due to CPU mask updates
>>>> + * @cs: The target cpuset being modified
>>>> + * @trialcs: The trial cpuset containing proposed configuration changes
>>>> + * @tmp: Temporary masks for intermediate calculations
>>>> + *
>>>> + * This function handles partition state transitions triggered by CPU mask changes.
>>>> + * CPU modifications may cause a partition to be disabled or require state updates.
>>>> + */
>>>> +static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>>>> +                    struct tmpmasks *tmp)
>>>> +{
>>>> +    if (cs_is_member(cs))
>>>> +        return;
>>>> +
>>>> +    invalidate_cs_partition(trialcs);
>>>> +    if (trialcs->prs_err)
>>>> +        cs->prs_err = trialcs->prs_err;
>>>> +
>>>> +    if (is_remote_partition(cs)) {
>>>> +        if (trialcs->prs_err)
>>>> +            remote_partition_disable(cs, tmp);
>>>> +        else
>>>> +            remote_cpus_update(cs, trialcs->exclusive_cpus,
>>>> +                       trialcs->effective_xcpus, tmp);
>>>> +    } else {
>>>> +        if (trialcs->prs_err)
>>>> +            update_parent_effective_cpumask(cs, partcmd_invalidate,
>>>> +                            NULL, tmp);
>>>> +        else
>>>> +            update_parent_effective_cpumask(cs, partcmd_update,
>>>> +                            trialcs->effective_xcpus, tmp);
>>>> +    }
>>>> +}
>>>> +
>>>>    /**
>>>>     * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
>>>>     * @cs: the cpuset to consider
>>>> @@ -2483,29 +2518,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>>>>         */
>>>>        force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>>>>    -    invalidate_cs_partition(trialcs);
>>>> -    if (trialcs->prs_err)
>>>> -        cs->prs_err = trialcs->prs_err;
>>>> -
>>>> -    if (is_partition_valid(cs) ||
>>>> -       (is_partition_invalid(cs) && !trialcs->prs_err)) {
>>>> -        struct cpumask *xcpus = trialcs->effective_xcpus;
>>>> -
>>>> -        if (cpumask_empty(xcpus) && is_partition_invalid(cs))
>>>> -            xcpus = trialcs->cpus_allowed;
>>> This if statement was added in commit 46c521bac592 ("cgroup/cpuset: Enable invalid to valid local
>>> partition transition") that is missing in your new partition_cpus_change() function. Have you run
>>> the test_cpuset_prs.sh selftest with a patched kernel to make sure that there is no test failure?
>>>
>>> Cheers,
>>> Longman
>> Thank you Longman,
>>
>> I did run the self-test for every patch, and I appreciate the test script test_cpuset_prs.sh you
>> provided.
>>
>> The trialcs->effective_xcpus will be updated using compute_trialcs_excpus, which was introduced in
>> Patch 4. The corresponding logic was then added in Patch 5:
>>
>> -    cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
>> +    /* trialcs is member, cpuset.cpus has no impact to excpus */
>> +    if (cs_is_member(cs))
>> +        cpumask_and(excpus, trialcs->exclusive_cpus,
>> +                parent->effective_xcpus);
>> +    else
>> +        cpumask_and(excpus, user_xcpus(trialcs), parent->effective_xcpus);
>> +
>>
>> Therefore, as long as excpus is computed correctly, I believe this implementation can handle the
>> scenario appropriately.
> 
> It will be helpful to put down a note in the commit log that the missing logic will be re-introduced
> in a subsequent patch.
> 
> Thanks,
> Longman

Thank you Longman,

I will update the commit message.

-- 
Best regards,
Ridong


