Return-Path: <cgroups+bounces-11910-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 163F3C5591B
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 04:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFE3D4EE8BA
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 03:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0B02BD58C;
	Thu, 13 Nov 2025 03:27:20 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168E929B224;
	Thu, 13 Nov 2025 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763004440; cv=none; b=V/sKg5SIENWIG+HETTSCXF3MMxJX3LaUKtbWfkxESQ9v0aoTvIaukKvxWEGIUexNNy6CQeQBY9jB6s6+dM1yCb1JKXmuV8WHJhx/Z8l8g0dlIMnSEglKlZ1ENXu+yNCGeIbKJtMe11hpFMiIf2AP0kDAl3e9Ox0fj402gCQa6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763004440; c=relaxed/simple;
	bh=+oOlVIJ7BW7dBmztUdrHhfLWJiEumgnsRlrxm4aLDq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ropBzps7WsGtShF5zRFjtz8LRWJLjG3XEslq2gTK4hzOQa8V+g5klzt4DKuL9EzGmpzZXCG9C+xTChbjHSU5PqaEJxEg4zdh1YU0cUITfJ+PdU5YZT8sQAeYP90B23tnCi6RoIpkj4r32b9FJdoS/LeMP0FVKtzY/A+m4asFL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d6Qfs25jWzYQv0v;
	Thu, 13 Nov 2025 11:26:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id BACF21A0A22;
	Thu, 13 Nov 2025 11:27:14 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgBnxXsRUBVpUqM9Ag--.21141S2;
	Thu, 13 Nov 2025 11:27:14 +0800 (CST)
Message-ID: <3569d5d9-1a5d-4e01-a24b-4d5817181899@huaweicloud.com>
Date: Thu, 13 Nov 2025 11:27:13 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 11/22] cpuset: introduce local_partition_disable()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-12-chenridong@huaweicloud.com>
 <c4adcc3d-577d-4065-b419-581f67d5e724@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <c4adcc3d-577d-4065-b419-581f67d5e724@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBnxXsRUBVpUqM9Ag--.21141S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XrWkWr47CF4DWr4DJr1DWrg_yoW7Gw1xpr
	1kJrW7GrWUXr1rC347JFnrJryrJw4DJ3WDtwn7X3WrJr17Jw1vgF1jq34qg3WUXrWkJryU
	ZF1UXr47uF17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/11/13 6:10, Waiman Long wrote:
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The partition_disable() function introduced earlier can be extended to
>> handle local partition disablement.
>>
>> The local_partition_disable() functions is introduced, which extracts the
>> local partition disable logic from update_parent_effective_cpumask(). It
>> calls partition_disable() to complete the disablement process.
>>
>> This refactoring establishes a clear separation between local and remote
>> partition operations while promoting code reuse through the shared
>> partition_disable() infrastructure.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 55 ++++++++++++++++++++++++++++++------------
>>   1 file changed, 39 insertions(+), 16 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index b308d9f80eef..f36d17a4d8cd 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1877,6 +1877,43 @@ static int local_partition_enable(struct cpuset *cs,
>>       return 0;
>>   }
>>   +/**
>> + * local_partition_disable - Disable a local partition
>> + * @cs: Target cpuset (local partition root) to disable
>> + * @part_error: partition error when @cs is disabled
>> + * @tmp: Temporary masks for CPU calculations
>> + */
>> +static void local_partition_disable(struct cpuset *cs, enum prs_errcode part_error,
>> +                    struct tmpmasks *tmp)
>> +{
>> +    struct cpuset *parent = parent_cs(cs);
>> +    bool cpumask_updated = false;
>> +    int new_prs;
>> +
>> +    lockdep_assert_held(&cpuset_mutex);
>> +    WARN_ON_ONCE(is_remote_partition(cs));    /* For local partition only */
>> +
>> +    if (!is_partition_valid(cs))
>> +        return;
>> +
>> +    new_prs = part_error ? -cs->partition_root_state : 0;
>> +    /*
>> +     * May need to add cpus back to parent's effective_cpus
>> +     * (and maybe removed from subpartitions_cpus/isolated_cpus)
>> +     * for valid partition root. xcpus may contain CPUs that
>> +     * shouldn't be removed from the two global cpumasks.
>> +     */
>> +    if (is_partition_valid(parent))
>> +        cpumask_updated = !cpumask_empty(cs->effective_xcpus);
> 
> If cs is a valid local partition, parent must be a valid partition. So the
> is_partition_valid(parent) check is meaningless. Also the effective_xcpus must not be empty. IOW,
> cpumask_updated must be true.
> 
> Cheers,
> Longman
> 

I believe is_partition_valid(parent) is meaningless and can be removed. We do support valid
partitions with empty effective CPUs—meaning cs->effective_xcpus may be empty.

>> +
>> +    partition_disable(cs, parent, new_prs, part_error);
>> +
>> +    if (cpumask_updated) {
>> +        cpuset_update_tasks_cpumask(parent, tmp->addmask);
>> +        update_sibling_cpumasks(parent, cs, tmp);
>> +    }
>> +}
>> +
>>   /**
>>    * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
>>    * @cs:      The cpuset that requests change in partition root state
>> @@ -1967,19 +2004,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>         nocpu = tasks_nocpu_error(parent, cs, xcpus);
>>   -    if (cmd == partcmd_disable) {
>> -        /*
>> -         * May need to add cpus back to parent's effective_cpus
>> -         * (and maybe removed from subpartitions_cpus/isolated_cpus)
>> -         * for valid partition root. xcpus may contain CPUs that
>> -         * shouldn't be removed from the two global cpumasks.
>> -         */
>> -        if (is_partition_valid(cs)) {
>> -            cpumask_copy(tmp->addmask, cs->effective_xcpus);
>> -            adding = true;
>> -        }
>> -        new_prs = PRS_MEMBER;
>> -    } else if (newmask) {
>> +    if (newmask) {
>>           /*
>>            * Empty cpumask is not allowed
>>            */
>> @@ -3110,9 +3135,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>           if (is_remote_partition(cs))
>>               remote_partition_disable(cs, &tmpmask);
>>           else
>> -            update_parent_effective_cpumask(cs, partcmd_disable,
>> -                            NULL, &tmpmask);
>> -
>> +            local_partition_disable(cs, PERR_NONE, &tmpmask);
>>           /*
>>            * Invalidation of child partitions will be done in
>>            * update_cpumasks_hier().
> 

-- 
Best regards,
Ridong


