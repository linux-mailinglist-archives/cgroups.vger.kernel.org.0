Return-Path: <cgroups+bounces-11920-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40009C56098
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 08:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC69C4E46B0
	for <lists+cgroups@lfdr.de>; Thu, 13 Nov 2025 07:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675F72D592A;
	Thu, 13 Nov 2025 07:22:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5BE29CEB;
	Thu, 13 Nov 2025 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763018575; cv=none; b=AvUmemO2PS0fvUL5GKcZa/12F/P5ZxeUKGwCSlrI/UjcHk30wCHe2fSgQz7CZzZjd+2EIjRJtI2sK0/uOdQkrO22X5HyR03kkzzQIa2zJRl+69fQp73ioEHx4KoqTHprbYUQ4A3oMm/opAuhSV2u74kVpuBBwDC1Spjh53Lt/QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763018575; c=relaxed/simple;
	bh=9uzDul7xU+IYfDVHTobYR5OBReoUp+7YXwn8iZMNyVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXj/7qedck8myWVoF+br59jq9WfH4/gybO4skg/aXEmIg6rZeStrpY4FPy1Kd7kHdvTFv6BNskZnHqPTaST2IoS0A3Ni7+6QWhYu8djqAbPAW3OD8B5qhx1HCoQO3oyQZtlrV6KrlaUJEIrNzMcPVegkk75PtReMK9QmqZoDS2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d6Wtm3GYGzKHMcn;
	Thu, 13 Nov 2025 15:22:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 33DEA1A15C4;
	Thu, 13 Nov 2025 15:22:43 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgCnBXxChxVp8tVQAg--.5581S2;
	Thu, 13 Nov 2025 15:22:43 +0800 (CST)
Message-ID: <34aae8cd-fc41-46ef-875f-84d0cdafeca7@huaweicloud.com>
Date: Thu, 13 Nov 2025 15:22:42 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 06/22] cpuset: introduce partition_update()
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251025064844.495525-1-chenridong@huaweicloud.com>
 <20251025064844.495525-7-chenridong@huaweicloud.com>
 <91e163ac-4379-4875-9f08-bddebb1e616c@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <91e163ac-4379-4875-9f08-bddebb1e616c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCnBXxChxVp8tVQAg--.5581S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45Xw1rGFyDJF4DGr13twb_yoWrXFW7pF
	ykJFW3JayUKr1fu34aqFs7CrWrKws7t3Wqyrn7XF18JFy2yw10qr1j93s0gr4UXrZ3Gr1U
	ZF1qgrsF9F17ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ha0DUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/13 4:58, Waiman Long wrote:
> On 10/25/25 2:48 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Introduce partition_update() to centralize updates to key cpuset structures
>> during a partition update, including:
>> - effective_xcpus
>> - exclusive_cpus
>>
>> Key operations performed:
>> - Adding and removing exclusive CPUs via partition_xcpus_add()/del()
>> - Synchronizing the effective exclusive CPUs mask
>> - Updating the exclusive CPUs mask when modification is required
>> - Triggering necessary system updates and workqueue synchronization
>> - Updating the partition's exclusive flag
>> - Sending partition change notifications
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 47 insertions(+)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 4a79db1cdec1..3e414e19ae31 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1604,6 +1604,53 @@ static void partition_disable(struct cpuset *cs, struct cpuset *parent,
>>       notify_partition_change(cs, old_prs);
>>   }
>>   +/**
>> + * partition_update - Update an existing partition configuration
>> + * @cs: The cpuset to update
>> + * @prs: Partition root state (must be positive)
>> + * @xcpus: New exclusive CPUs mask for the partition (NULL to keep current)
>> + * @excpus: New effective exclusive CPUs mask
>> + * @tmp: Temporary masks
>> + *
>> + * Updates partition-related fields. The tmp->addmask is the CPU mask that
>> + * will be added to the subpartitions_cpus and removed from parent's
>> + * effective_cpus, and the tmp->delmask vice versa.
>> + */
>> +static void partition_update(struct cpuset *cs, int prs, struct cpumask *xcpus,
>> +                  struct cpumask *excpus, struct tmpmasks *tmp)
>> +{
>> +    bool isolcpus_updated;
>> +    bool excl_updated;
>> +    struct cpuset *parent;
>> +    int old_prs;
>> +
>> +    lockdep_assert_held(&cpuset_mutex);
>> +    WARN_ON_ONCE(!cpuset_v2());
>> +    WARN_ON_ONCE(prs <= 0);
>> +
>> +    parent = is_remote_partition(cs) ? NULL : parent_cs(cs);
>> +    old_prs = cs->partition_root_state;
>> +    excl_updated = !cpumask_empty(tmp->addmask) ||
>> +               !cpumask_empty(tmp->delmask);
> Should partition_update() only be called if at least one of addmask/delmask is not empty? If they
> are both empty, no update is really needed. Right?

Right, it can return directly.

>> +
>> +    spin_lock_irq(&callback_lock);
>> +    isolcpus_updated = partition_xcpus_add(prs, parent, tmp->addmask);
>> +    isolcpus_updated |= partition_xcpus_del(prs, parent, tmp->delmask);
> 
> I see now that there is no adding and deleting boolean flags to indicate if the cpumasks are empty
> or not, so you have to add the empty cpumask check in those helpers. Please state that in your patch 2.
> 

Will update.

>> +    /*
>> +     * Need to update effective_xcpus and exclusive_cpus now as
>> +     * update_sibling_cpumasks() below may iterate back to the same cs.
>> +     */
>> +    cpumask_copy(cs->effective_xcpus, excpus);
>> +    if (xcpus)
>> +        cpumask_copy(cs->exclusive_cpus, xcpus);
>> +    spin_unlock_irq(&callback_lock);
>> +    update_unbound_workqueue_cpumask(isolcpus_updated);
>> +    if (excl_updated)
>> +        cpuset_force_rebuild();
>> +    update_partition_exclusive_flag(cs, prs);
>> +    notify_partition_change(cs, old_prs);
>> +}
>> +
>>   /*
>>    * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
>>    * @prstate: partition root state to be checked
> 

-- 
Best regards,
Ridong


