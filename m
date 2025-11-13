Return-Path: <cgroups+bounces-11918-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBA6C55FE3
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 08:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DBE64E12E0
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 07:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70056301004;
	Thu, 13 Nov 2025 07:03:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81E2A1CF;
	Thu, 13 Nov 2025 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763017405; cv=none; b=Yre3uj4nmDquF1TObBO2PIBzar0vvgZSnx6P/OeZ5dljFD1zBrUZzlJZYMvAZtRqIUeXf5UsOAhyF6ATs1D/bNcTTeWnWAb7SseaJ6n+oKs6sEx8TRKhBP4fSWhLuIjww2FRNHfbgIW+AawifNeVc2Zhk28AMbHJUvwnBZZMuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763017405; c=relaxed/simple;
	bh=I3SOh6jRlurIISZfw38ut0G2vxBbXgNkWvMzTt+lrn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuvjLHY7b3Y9zufICOuKhGbRfYu/IkLeVvEG6y3tkjtwT9O1yKppMj/l6v+W1BAr1LaXRevUC7VSdRk8tUegLjRuMwkkG+LdEUUmNCw2HJRJ/wQXPy2Jk4yDgcEZo+zIWVfvbtIX+v0UfWaihC/sagjRZ4SNX/ynVET3Hs09Nbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d6WS84T9JzYQv6p;
	Thu, 13 Nov 2025 15:02:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5473B1A144C;
	Thu, 13 Nov 2025 15:03:18 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDnDly0ghVpihdPAg--.59079S2;
	Thu, 13 Nov 2025 15:03:18 +0800 (CST)
Message-ID: <fd98e16d-0602-4ecd-9f8b-9ee494ddaa1d@huaweicloud.com>
Date: Thu, 13 Nov 2025 15:03:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/22] cpuset: introduce
 local_partition_invalidate()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-13-chenridong@huaweicloud.com>
 <f9a3fffb-922c-4d4a-81ad-9eeb489cef07@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <f9a3fffb-922c-4d4a-81ad-9eeb489cef07@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDnDly0ghVpihdPAg--.59079S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw15WF4Dtr18XrW5WFWDtwb_yoWfGryDpr
	18JrW7JrWUJr1rC347JFs7JryrGw1DJ3WDtr1kXF1rJr17Jw1qqF1jq34vgr1UJr4kJr1U
	ZF1UXrsrZF17ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2025/11/13 6:54, Waiman Long wrote:
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Build on the partition_disable() infrastructure introduced in the previous
>> patch to handle local partition invalidation.
>>
>> The local_partition_invalidate() function factors out the local partition
>> invalidation logic from update_parent_effective_cpumask(), which delegates
>> to partition_disable() to complete the invalidation process.
>>
>> Additionally, correct the transition logic in cpuset_hotplug_update_tasks()
>> when determining whether to transition an invalid partition root, the check
>> should be based on non-empty user_cpus rather than non-empty
>> effective_xcpus. This correction addresses the scenario where
>> exclusive_cpus is not set but cpus_allowed is configured - in this case,
>> effective_xcpus may be empty even though the partition should be considered
>> for re-enablement. The user_cpus-based check ensures proper partition state
>> transitions under these conditions.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 66 +++++++++++++++++++++++++++---------------
>>   1 file changed, 43 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index f36d17a4d8cd..73a43ab58f72 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1914,6 +1914,40 @@ static void local_partition_disable(struct cpuset *cs, enum prs_errcode
>> part_err
>>       }
>>   }
>>   +/**
>> + * local_partition_invalidate - Invalidate a local partition
>> + * @cs: Target cpuset (local partition root) to invalidate
>> + * @tmp: Temporary masks
>> + */
>> +static void local_partition_invalidate(struct cpuset *cs, struct tmpmasks *tmp)
>> +{
>> +    struct cpumask *xcpus = user_xcpus(cs);
>> +    struct cpuset *parent = parent_cs(cs);
>> +    int new_prs = cs->partition_root_state;
>> +    bool cpumask_updated = false;
>> +
>> +    lockdep_assert_held(&cpuset_mutex);
>> +    WARN_ON_ONCE(is_remote_partition(cs));    /* For local partition only */
>> +
>> +    if (!is_partition_valid(cs))
>> +        return;
>> +
>> +    /*
>> +     * Make the current partition invalid.
>> +     */
>> +    if (is_partition_valid(parent))
>> +        cpumask_updated = cpumask_and(tmp->addmask,
>> +                          xcpus, parent->effective_xcpus);
> Invalidation is different from disable. It can be called when parent is no longer a valid partition
> root. So the check here is appropriate.

In patch 17, I’ve unified local_partition_disable() and local_partition_invalidate() into a single
local_partition_disable() function—this simplifies the logic significantly. For remote partitions,
only remote_partition_disable() is used, making the interface symmetrical.

I split this into a separate patch solely to make the review clearer and easier.

Maybe I should directly replace the relevant logic in update_parent_effective_cpumask() with
local_partition_disable()?

>> +    if (cs->partition_root_state > 0)
>> +        new_prs = -cs->partition_root_state;
>> +
>> +    partition_disable(cs, parent, new_prs, cs->prs_err);
>> +    if (cpumask_updated) {
> 
> The cpumask_and() operation above is no longer relevant as it should be done inside
> partition_disable(). Instead of cpumask_updated, we can just do a "is_partition_valid(parent))"
> check here to decide if the following two helpers should be called.
> 
> Cheers,
> Longman
> 

Similar to local_partition_disable, cpumask_updated indicates whether any CPUs need to be returned
to the parent. partition_disable will return the CPUs to the parent if tmp->addmask is empty.
However, since tmp->addmask may indeed be empty, I believe cpumask_updated is necessary.

In the next version, I’ll try directly replacing the relevant logic in
update_parent_effective_cpumask() with local_partition_disable()—this should make the code much clearer.

> 
>> +        cpuset_update_tasks_cpumask(parent, tmp->addmask);
>> +        update_sibling_cpumasks(parent, cs, tmp);
>> +    }
>> +}
>> +
>>   /**
>>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>>    * @cs:      The cpuset that requests change in partition root state
>> @@ -1974,22 +2008,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>       adding = deleting = false;
>>       old_prs = new_prs = cs->partition_root_state;
>>   -    if (cmd == partcmd_invalidate) {
>> -        if (is_partition_invalid(cs))
>> -            return 0;
>> -
>> -        /*
>> -         * Make the current partition invalid.
>> -         */
>> -        if (is_partition_valid(parent))
>> -            adding = cpumask_and(tmp->addmask,
>> -                         xcpus, parent->effective_xcpus);
>> -        if (old_prs > 0)
>> -            new_prs = -old_prs;
>> -
>> -        goto write_error;
>> -    }
>> -
>>       /*
>>        * The parent must be a partition root.
>>        * The new cpumask, if present, or the current cpus_allowed must
>> @@ -2553,7 +2571,7 @@ static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset
>> *trialc
>>               if (is_partition_valid(cp) &&
>>                   cpumask_intersects(xcpus, cp->effective_xcpus)) {
>>                   rcu_read_unlock();
>> -                update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
>> +                local_partition_invalidate(cp, tmp);
>>                   rcu_read_lock();
>>               }
>>           }
>> @@ -2593,8 +2611,7 @@ static void partition_cpus_change(struct cpuset *cs, struct cpuset *trialcs,
>>                          trialcs->effective_xcpus, tmp);
>>       } else {
>>           if (trialcs->prs_err)
>> -            update_parent_effective_cpumask(cs, partcmd_invalidate,
>> -                            NULL, tmp);
>> +            local_partition_invalidate(cs, tmp);
>>           else
>>               update_parent_effective_cpumask(cs, partcmd_update,
>>                               trialcs->effective_xcpus, tmp);
>> @@ -4040,18 +4057,21 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks
>> *tmp)
>>        *    partitions.
>>        */
>>       if (is_local_partition(cs) && (!is_partition_valid(parent) ||
>> -                tasks_nocpu_error(parent, cs, &new_cpus)))
>> +                tasks_nocpu_error(parent, cs, &new_cpus))) {
>>           partcmd = partcmd_invalidate;
>> +        local_partition_invalidate(cs, tmp);
>> +    }
>>       /*
>>        * On the other hand, an invalid partition root may be transitioned
>> -     * back to a regular one with a non-empty effective xcpus.
>> +     * back to a regular one with a non-empty user xcpus.
>>        */
>>       else if (is_partition_valid(parent) && is_partition_invalid(cs) &&
>> -         !cpumask_empty(cs->effective_xcpus))
>> +         !cpumask_empty(user_xcpus(cs))) {
>>           partcmd = partcmd_update;
>> +        update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
>> +    }
>>         if (partcmd >= 0) {
>> -        update_parent_effective_cpumask(cs, partcmd, NULL, tmp);
>>           if ((partcmd == partcmd_invalidate) || is_partition_valid(cs)) {
>>               compute_partition_effective_cpumask(cs, &new_cpus);
>>               cpuset_force_rebuild();
> 

-- 
Best regards,
Ridong


