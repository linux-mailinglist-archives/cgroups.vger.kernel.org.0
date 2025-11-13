Return-Path: <cgroups+bounces-11919-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A7AC56083
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 08:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 169583A4348
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 07:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311DB320CBA;
	Thu, 13 Nov 2025 07:17:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71629CEB;
	Thu, 13 Nov 2025 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018224; cv=none; b=j8gpfCQ3AXgWrv19ql1hs16+Zq76LC2YPcmoHLj0HhOUHrldcY6ktKmOHlqBf9WhzHrsSHuvGQNDwHYwS/5/AJ3uVkWlkoxR5V/nTiHfufLnazA3oHn4WYO9/QQ/rH+oIdR44X58ixXWPG0LdjqrAOH+1OVVnu9FuZu23EKAG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018224; c=relaxed/simple;
	bh=BTwv5flOpOPjfAlSyHCLyPf3T1Do2Q8gfgJtQ78dzis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hf77+Xc9Uv0ITQmYTH9APpcbEyvhkiz9Lg7Vp4kknrhYm0PUI4t644FGdrjS+NkrAOTr+d1LT2QoHNzpPXI/8RyO94YtcISM1Lamy9Pko/O2hhzaf03NJunHKbpfO9fVE14JK+xFJgREz/KmcBoOIW9As9BYjFQo8aulwGokBys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d6Wlx5TjXzYQtx9;
	Thu, 13 Nov 2025 15:16:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 78EBF1A0ADD;
	Thu, 13 Nov 2025 15:16:59 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgCX9HrqhRVpxGFQAg--.1286S2;
	Thu, 13 Nov 2025 15:16:59 +0800 (CST)
Message-ID: <90939118-df03-4c26-9351-1a4ec67116eb@huaweicloud.com>
Date: Thu, 13 Nov 2025 15:16:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 10/22] cpuset: introduce local_partition_enable()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-11-chenridong@huaweicloud.com>
 <71121d12-0cb2-4ffe-92e5-caf25bf4596e@redhat.com>
 <47c20c78-9f7f-4134-8835-3c4f5bff4c30@huaweicloud.com>
 <8bb19728-8611-4266-aa8e-6dd4783c4702@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <8bb19728-8611-4266-aa8e-6dd4783c4702@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCX9HrqhRVpxGFQAg--.1286S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCw4rKw45Aw1fZFy3Kr4xtFb_yoWrCF43pr
	ykGFWUt3y5Jr1rC3sFg3WkCas3K3ykJ3WDXwn3X3WrXrnFyrnFgF1jv3yq9F18XrWkJryU
	Zr1qqrsruFy3ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ha0DUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 10:58, Waiman Long wrote:
> On 11/12/25 9:49 PM, Chen Ridong wrote:
>>
>> On 2025/11/13 5:47, Waiman Long wrote:
>>> On 10/25/25 2:48 AM, Chen Ridong wrote:
>>>> From: Chen Ridong <chenridong@huawei.com>
>>>>
>>>> The partition_enable() function introduced in the previous patch can be
>>>> reused to enable local partitions.
>>>>
>>>> The local_partition_enable() function is introduced, which factors out the
>>>> local partition enablement logic from update_parent_effective_cpumask().
>>>> After passing local partition validation checks, it delegates to
>>>> partition_enable() to complete the partition setup.
>>>>
>>>> This refactoring creates a clear separation between local and remote
>>>> partition operations while maintaining code reuse through the shared
>>>> partition_enable() infrastructure.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>>    kernel/cgroup/cpuset.c | 94 ++++++++++++++++++++++++++----------------
>>>>    1 file changed, 59 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index 5b57c5370641..b308d9f80eef 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -1822,6 +1822,61 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>>>>        remote_partition_disable(cs, tmp);
>>>>    }
>>>>    +/**
>>>> + * local_partition_enable - Enable local partition for a cpuset
>>>> + * @cs: Target cpuset to become a local partition root
>>>> + * @new_prs: New partition root state to apply
>>>> + * @tmp: Temporary masks for CPU calculations
>>>> + *
>>>> + * This function enables local partition root capability for a cpuset by
>>>> + * validating prerequisites, computing exclusive CPUs, and updating the
>>>> + * partition hierarchy.
>>>> + *
>>>> + * Return: 0 on success, error code on failure
>>>> + */
>>>> +static int local_partition_enable(struct cpuset *cs,
>>>> +                int new_prs, struct tmpmasks *tmp)
>>>> +{
>>>> +    struct cpuset *parent = parent_cs(cs);
>>>> +    enum prs_errcode part_error;
>>>> +    bool cpumask_updated = false;
>>>> +
>>>> +    lockdep_assert_held(&cpuset_mutex);
>>>> +    WARN_ON_ONCE(is_remote_partition(cs));    /* For local partition only */
>>>> +
>>>> +    /*
>>>> +     * The parent must be a partition root.
>>>> +     * The new cpumask, if present, or the current cpus_allowed must
>>>> +     * not be empty.
>>>> +     */
>>>> +    if (!is_partition_valid(parent)) {
>>>> +        return is_partition_invalid(parent)
>>>> +            ? PERR_INVPARENT : PERR_NOTPART;
>>>> +    }
>>>> +
>>>> +    /*
>>>> +     * Need to call compute_excpus() in case
>>>> +     * exclusive_cpus not set. Sibling conflict should only happen
>>>> +     * if exclusive_cpus isn't set.
>>>> +     */
>>>> +    if (compute_excpus(cs, tmp->new_cpus))
>>>> +        WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
>>>> +
>>>> +    part_error = validate_partition(cs, new_prs, tmp->new_cpus);
>>>> +    if (part_error)
>>>> +        return part_error;
>>>> +
>>>> +    cpumask_updated = cpumask_andnot(tmp->addmask, tmp->new_cpus,
>>>> +                     parent->effective_cpus);
>>> What is the purpose of this cpumask_andnot() operation? Is it just to create the cpumask_updated
>>> boolean? At this point, cpumask_updated should always be true. If not, we have to add validation
>>> check to return an error.
>>>
>>> Cheers,
>>> Longman
>>>
>> I want to support switching the root partition’s state between "root" and "isolated"—for example, an
>> isolated partition switching to root without changing its CPU mask.
>>
>> Adding a comment to clarify this behavior would be helpful.
> 
> For state switching, I would suggest to use a separate helper just for state switching as such
> switching can be done to both local and remote partition.
> 
> Cheers,
> Longman
> 

Thanks, I will try to introduce a new helper to handle it.

-- 
Best regards,
Ridong


