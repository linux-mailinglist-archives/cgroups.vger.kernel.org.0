Return-Path: <cgroups+bounces-11908-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC76C557B0
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 03:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4352A4E36C2
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 02:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB6B25BEE5;
	Thu, 13 Nov 2025 02:50:00 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1AA1D5ADE;
	Thu, 13 Nov 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002200; cv=none; b=M/AI4TC16fTPOcyb6lidCyLa3pdiyL2Girx80n+8EJN4x9lEy/eEx/BSf3kEZupkSY/6a7N9R0zR4c/vaoo3+FYdIuTwTG53H6DHSOON7IP5PoXh8t3mb4SQFc/AM53sAl6oyV46dlr5fprDAwbaGQQs8Bx4xYy1aiVESZ0gmGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002200; c=relaxed/simple;
	bh=xCebPx/DTTumY++I8/5MsUa5fN4CVr48wYQ7/7nwxIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXpZ15wTBzCJor5meVCBUGQUFdCRZYj+Jb44fGkpcApNEFMsRuAJm3ggLjUJ2DDKoz0DJRtA+PVGk73WzrvsSr8YQO4mggv8WVhcwe/3h/eFw4qaGAHEAoDX6Q0kb61vFn+9e3iH0QW+G5N0cTbflvs2fe2TZS6ePzGBPIH/5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6Pqz5GpPzKHMWr;
	Thu, 13 Nov 2025 10:49:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 32BDD1A13E6;
	Thu, 13 Nov 2025 10:49:54 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXf1xQRxVpsWU6Ag--.29421S2;
	Thu, 13 Nov 2025 10:49:54 +0800 (CST)
Message-ID: <47c20c78-9f7f-4134-8835-3c4f5bff4c30@huaweicloud.com>
Date: Thu, 13 Nov 2025 10:49:52 +0800
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
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <71121d12-0cb2-4ffe-92e5-caf25bf4596e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXf1xQRxVpsWU6Ag--.29421S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFy7ArWfAr4UKF4kCr1rWFg_yoWxKw15pF
	1kJrWUJrWUJr1rC347JFnrGryrGw4DJ3WDtw1kX3WrXr17Ar10gr1jq3yqgr1UJrWkJr15
	Xr1UXrsruF13ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 5:47, Waiman Long wrote:
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The partition_enable() function introduced in the previous patch can be
>> reused to enable local partitions.
>>
>> The local_partition_enable() function is introduced, which factors out the
>> local partition enablement logic from update_parent_effective_cpumask().
>> After passing local partition validation checks, it delegates to
>> partition_enable() to complete the partition setup.
>>
>> This refactoring creates a clear separation between local and remote
>> partition operations while maintaining code reuse through the shared
>> partition_enable() infrastructure.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 94 ++++++++++++++++++++++++++----------------
>>   1 file changed, 59 insertions(+), 35 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 5b57c5370641..b308d9f80eef 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1822,6 +1822,61 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>>       remote_partition_disable(cs, tmp);
>>   }
>>   +/**
>> + * local_partition_enable - Enable local partition for a cpuset
>> + * @cs: Target cpuset to become a local partition root
>> + * @new_prs: New partition root state to apply
>> + * @tmp: Temporary masks for CPU calculations
>> + *
>> + * This function enables local partition root capability for a cpuset by
>> + * validating prerequisites, computing exclusive CPUs, and updating the
>> + * partition hierarchy.
>> + *
>> + * Return: 0 on success, error code on failure
>> + */
>> +static int local_partition_enable(struct cpuset *cs,
>> +                int new_prs, struct tmpmasks *tmp)
>> +{
>> +    struct cpuset *parent = parent_cs(cs);
>> +    enum prs_errcode part_error;
>> +    bool cpumask_updated = false;
>> +
>> +    lockdep_assert_held(&cpuset_mutex);
>> +    WARN_ON_ONCE(is_remote_partition(cs));    /* For local partition only */
>> +
>> +    /*
>> +     * The parent must be a partition root.
>> +     * The new cpumask, if present, or the current cpus_allowed must
>> +     * not be empty.
>> +     */
>> +    if (!is_partition_valid(parent)) {
>> +        return is_partition_invalid(parent)
>> +            ? PERR_INVPARENT : PERR_NOTPART;
>> +    }
>> +
>> +    /*
>> +     * Need to call compute_excpus() in case
>> +     * exclusive_cpus not set. Sibling conflict should only happen
>> +     * if exclusive_cpus isn't set.
>> +     */
>> +    if (compute_excpus(cs, tmp->new_cpus))
>> +        WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
>> +
>> +    part_error = validate_partition(cs, new_prs, tmp->new_cpus);
>> +    if (part_error)
>> +        return part_error;
>> +
>> +    cpumask_updated = cpumask_andnot(tmp->addmask, tmp->new_cpus,
>> +                     parent->effective_cpus);
> 
> What is the purpose of this cpumask_andnot() operation? Is it just to create the cpumask_updated
> boolean? At this point, cpumask_updated should always be true. If not, we have to add validation
> check to return an error.
> 
> Cheers,
> Longman
> 

I want to support switching the root partition’s state between "root" and "isolated"—for example, an
isolated partition switching to root without changing its CPU mask.

Adding a comment to clarify this behavior would be helpful.

>> +    partition_enable(cs, parent, new_prs, tmp->new_cpus);
>> +
>> +    if (cpumask_updated) {
>> +        cpuset_update_tasks_cpumask(parent, tmp->addmask);
>> +        update_sibling_cpumasks(parent, cs, tmp);
>> +    }
>> +    return 0;
>> +}
>> +
>>   /**
>>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>>    * @cs:      The cpuset that requests change in partition root state
>> @@ -1912,34 +1967,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>         nocpu = tasks_nocpu_error(parent, cs, xcpus);
>>   -    if ((cmd == partcmd_enable) || (cmd == partcmd_enablei)) {
>> -        /*
>> -         * Need to call compute_excpus() in case
>> -         * exclusive_cpus not set. Sibling conflict should only happen
>> -         * if exclusive_cpus isn't set.
>> -         */
>> -        xcpus = tmp->delmask;
>> -        if (compute_excpus(cs, xcpus))
>> -            WARN_ON_ONCE(!cpumask_empty(cs->exclusive_cpus));
>> -        new_prs = (cmd == partcmd_enable) ? PRS_ROOT : PRS_ISOLATED;
>> -
>> -        part_error = validate_partition(cs, new_prs, xcpus);
>> -        if (part_error)
>> -            return part_error;
>> -        /*
>> -         * This function will only be called when all the preliminary
>> -         * checks have passed. At this point, the following condition
>> -         * should hold.
>> -         *
>> -         * (cs->effective_xcpus & cpu_active_mask) ⊆ parent->effective_cpus
>> -         *
>> -         * Warn if it is not the case.
>> -         */
>> -        cpumask_and(tmp->new_cpus, xcpus, cpu_active_mask);
>> -        WARN_ON_ONCE(!cpumask_subset(tmp->new_cpus, parent->effective_cpus));
>> -
>> -        deleting = true;
>> -    } else if (cmd == partcmd_disable) {
>> +    if (cmd == partcmd_disable) {
>>           /*
>>            * May need to add cpus back to parent's effective_cpus
>>            * (and maybe removed from subpartitions_cpus/isolated_cpus)
>> @@ -3062,14 +3090,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>            * If parent is valid partition, enable local partiion.
>>            * Otherwise, enable a remote partition.
>>            */
>> -        if (is_partition_valid(parent)) {
>> -            enum partition_cmd cmd = (new_prs == PRS_ROOT)
>> -                           ? partcmd_enable : partcmd_enablei;
>> -
>> -            err = update_parent_effective_cpumask(cs, cmd, NULL, &tmpmask);
>> -        } else {
>> +        if (is_partition_valid(parent))
>> +            err = local_partition_enable(cs, new_prs, &tmpmask);
>> +        else
>>               err = remote_partition_enable(cs, new_prs, &tmpmask);
>> -        }
>>       } else if (old_prs && new_prs) {
>>           /*
>>            * A change in load balance state only, no change in cpumasks.
> 

-- 
Best regards,
Ridong


