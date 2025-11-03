Return-Path: <cgroups+bounces-11488-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A03C2A006
	for <lists+cgroups@lfdr.de>; Mon, 03 Nov 2025 04:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B0854E4358
	for <lists+cgroups@lfdr.de>; Mon,  3 Nov 2025 03:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A872882D7;
	Mon,  3 Nov 2025 03:59:15 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149FB1A238F;
	Mon,  3 Nov 2025 03:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762142355; cv=none; b=CKBPuWvUu4BYl4jh3ZYroYmVmgewP3CrtVM+k2v3GCuil5sJKnedDOxXke4UZBJKVCRQBewKOrwgL41ItBKsxMX1NFplLdUc/W9I8L8DT6js1UXCEa/LHuNNMtGe2vBR+szJCDFzhP2J2RurEfQiVuoKB4soqmFkM+QfRgFCNY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762142355; c=relaxed/simple;
	bh=NmOtSZllADgVq47E8i86uit98ckf+dLKzNBtsMHFGR0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HeerjcVlTzaYj4uBD+F4pb8wXK6BYeBaYfsS1QO/CdVlB2y1YW05tm8Tdnre154McO9JPYXbfJ4cMPfuMF1IA7/5Lrj4UuK01E4vrNz1nSKArpuJ9HcyZN1oYi5mjvh0zvhBZR5gKFKRUoaV/A5vNR/1Ndd8uinaFbbkLbdZSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d0Hrm75GbzKHLxd;
	Mon,  3 Nov 2025 11:59:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C295B1A0FAF;
	Mon,  3 Nov 2025 11:59:08 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgDXekOLKAhpuOggCg--.38559S2;
	Mon, 03 Nov 2025 11:59:08 +0800 (CST)
Message-ID: <e4bde91c-fc82-4c40-8f6c-7fc044ddf79b@huaweicloud.com>
Date: Mon, 3 Nov 2025 11:59:07 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH 2/3] cgroup/cpuset: Fail if isolated and
 nohz_full don't leave any housekeeping
From: Chen Ridong <chenridong@huaweicloud.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chen Ridong <chenridong@huawei.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>
References: <20251103013411.239610-1-longman@redhat.com>
 <20251103013411.239610-3-longman@redhat.com>
 <474e7133-0d43-4eb8-ae75-5e9a352c0eec@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <474e7133-0d43-4eb8-ae75-5e9a352c0eec@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDXekOLKAhpuOggCg--.38559S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyDXFykKrykZry7AFWDurg_yoW7tryxpF
	yUGFW3CayUtr13C34aqF1q9r1Skw4ktr12kasxGa4rZFnFv3WktryUu3Z8Cayru39xGryU
	ZrWqgrs2g3W8ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UG-e
	OUUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/3 11:47, Chen Ridong wrote:
> 
> 
> On 2025/11/3 9:34, Waiman Long wrote:
>> From: Gabriele Monaco <gmonaco@redhat.com>
>>
>> Currently the user can set up isolated cpus via cpuset and nohz_full in
>> such a way that leaves no housekeeping CPU (i.e. no CPU that is neither
>> domain isolated nor nohz full). This can be a problem for other
>> subsystems (e.g. the timer wheel imgration).
>>
>> Prevent this configuration by blocking any assignation that would cause
>> the union of domain isolated cpus and nohz_full to covers all CPUs.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Waiman Long <longman@redhat.com>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/cgroup/cpuset.c | 67 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 66 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index da770dac955e..d6d459c95d82 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1329,6 +1329,19 @@ static void isolated_cpus_update(int old_prs, int new_prs, struct cpumask *xcpus
>>  		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
>>  }
>>  
>> +/*
>> + * isolated_cpus_should_update - Returns if the isolated_cpus mask needs update
>> + * @prs: new or old partition_root_state
>> + * @parent: parent cpuset
>> + * Return: true if isolated_cpus needs modification, false otherwise
>> + */
>> +static bool isolated_cpus_should_update(int prs, struct cpuset *parent)
>> +{
>> +	if (!parent)
>> +		parent = &top_cpuset;
>> +	return prs != parent->partition_root_state;
>> +}
>> +
>>  /*
>>   * partition_xcpus_add - Add new exclusive CPUs to partition
>>   * @new_prs: new partition_root_state
>> @@ -1393,6 +1406,42 @@ static bool partition_xcpus_del(int old_prs, struct cpuset *parent,
>>  	return isolcpus_updated;
>>  }
>>  
>> +/*
>> + * isolated_cpus_can_update - check for isolated & nohz_full conflicts
>> + * @add_cpus: cpu mask for cpus that are going to be isolated
>> + * @del_cpus: cpu mask for cpus that are no longer isolated, can be NULL
>> + * Return: false if there is conflict, true otherwise
>> + *
>> + * If nohz_full is enabled and we have isolated CPUs, their combination must
>> + * still leave housekeeping CPUs.
>> + */
>> +static bool isolated_cpus_can_update(struct cpumask *add_cpus,
>> +				     struct cpumask *del_cpus)
>> +{
>> +	cpumask_var_t full_hk_cpus;
>> +	int res = true;
>> +
>> +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
>> +		return true;
>> +
>> +	if (del_cpus && cpumask_weight_and(del_cpus,
>> +			housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
>> +		return true;
>> +
>> +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
>> +		return false;
>> +
>> +	cpumask_and(full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
>> +		    housekeeping_cpumask(HK_TYPE_DOMAIN));
>> +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
>> +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_active_mask);
>> +	if (!cpumask_weight_andnot(full_hk_cpus, add_cpus))
>> +		res = false;
>> +
>> +	free_cpumask_var(full_hk_cpus);
>> +	return res;
>> +}
>> +
>>  static void update_isolation_cpumasks(bool isolcpus_updated)
>>  {
>>  	int ret;
>> @@ -1551,6 +1600,9 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>>  	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) ||
>>  	    cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>>  		return PERR_INVCPUS;
>> +	if (isolated_cpus_should_update(new_prs, NULL) &&
>> +	    !isolated_cpus_can_update(tmp->new_cpus, NULL))
>> +		return PERR_HKEEPING;
>>  
>>  	spin_lock_irq(&callback_lock);
>>  	isolcpus_updated = partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
>> @@ -1650,6 +1702,9 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
>>  		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
>>  			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
>>  			cs->prs_err = PERR_NOCPUS;
>> +		else if (isolated_cpus_should_update(prs, NULL) &&
>> +			 !isolated_cpus_can_update(tmp->addmask, tmp->delmask))
>> +			cs->prs_err = PERR_HKEEPING;
>>  		if (cs->prs_err)
>>  			goto invalidate;
>>  	}
>> @@ -1988,6 +2043,12 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>  			return err;
>>  	}
>>  
>> +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
>> +	    !isolated_cpus_can_update(tmp->delmask, tmp->addmask)) {
>> +		cs->prs_err = PERR_HKEEPING;
>> +		return PERR_HKEEPING;
>> +	}
>> +
>>  	/*
>>  	 * Change the parent's effective_cpus & effective_xcpus (top cpuset
>>  	 * only).
>> @@ -2994,7 +3055,11 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>>  		 * A change in load balance state only, no change in cpumasks.
>>  		 * Need to update isolated_cpus.
>>  		 */
>> -		isolcpus_updated = true;
>> +		if ((new_prs == PRS_ISOLATED) &&
>> +		    !isolated_cpus_can_update(cs->effective_xcpus, NULL))
>> +			err = PERR_HKEEPING;
>> +		else
>> +			isolcpus_updated = true;
>>  	} else {
>>  		/*
>>  		 * Switching back to member is always allowed even if it
> 
> I'm considering whether I should introduce a new function that consolidates
> isolated_cpus_should_update, isolated_cpus_can_update, and prstate_housekeeping_conflict.
> 

Sorry, we should introduce a new ...

> Just like:
> 
> bool housekeeping_conflict(...)
> {
> 	if (isolated_cpus_should_update && !isolated_cpus_can_update) {
> 		return ture;
> 	}
> 	return prstate_housekeeping_conflict();
> }
> 
> Since all of these are related to isolated CPUs, putting them into a centralized function would make
> the code much easier to maintain.
> 

-- 
Best regards,
Ridong


