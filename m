Return-Path: <cgroups+bounces-4344-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795969563B8
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 08:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8611C214A4
	for <lists+cgroups@lfdr.de>; Mon, 19 Aug 2024 06:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D717211CA0;
	Mon, 19 Aug 2024 06:25:43 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36CA14B95A;
	Mon, 19 Aug 2024 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724048743; cv=none; b=J0r8FVMIUpmfS4d5OU8ly5bwE9atCIVFfdaFzfs9r7TEsB3EiDgxdVfc2d0bZgIZaibn1dRTN3EdD+s58nGYbngw/sAbku+4X9lHvulPNEHdHIw5ztD4raVoXXmIbvW86CKtKIG2Na7jd6+TIgd2b4DdB0Axzo8G9CQcoNtlpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724048743; c=relaxed/simple;
	bh=uKftt/xyf0unfmJe7wdprT0uTWTQKoQ3fQp9bUqW2Ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=i4b1wuMXSq+GCaB8gdqBHsAAETEbiOI7laSxtJkCBcs7dcluowC2lUQwPoSSCZqxUOjj+hRlvRRu3Y3o+hcdd963fB6/7WUjxL1VQE0oy2LRgOCBmwwNbb06vSNqADeRZ1mpCIfeUZ/HJFJ1RsagR6aAfPtKTH9euhHtFcdyiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WnMyX6FJwz13Vjb;
	Mon, 19 Aug 2024 14:24:52 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id ECA4F140138;
	Mon, 19 Aug 2024 14:25:28 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Mon, 19 Aug
 2024 14:25:28 +0800
Message-ID: <68fa943a-68e8-44d6-ad08-97519a151a79@huawei.com>
Date: Mon, 19 Aug 2024 14:25:27 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 1/3] cgroup/cpuset: Correct invalid remote parition
 prs
To: Waiman Long <longman@redhat.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <adityakali@google.com>,
	<sergeh@kernel.org>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240816082727.2779-1-chenridong@huawei.com>
 <20240816082727.2779-2-chenridong@huawei.com>
 <dc4672a0-bff4-493f-81da-9dfdda9018f2@redhat.com>
 <ff059171-d38e-41a3-86e0-e092a34ba970@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <ff059171-d38e-41a3-86e0-e092a34ba970@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/8/19 10:18, Waiman Long wrote:
> On 8/18/24 22:14, Waiman Long wrote:
>>
>> On 8/16/24 04:27, Chen Ridong wrote:
>>> When enable a remote partition, I found that:
>>>
>>> cd /sys/fs/cgroup/
>>> mkdir test
>>> mkdir test/test1
>>> echo +cpuset > cgroup.subtree_control
>>> echo +cpuset >  test/cgroup.subtree_control
>>> echo 3 > test/test1/cpuset.cpus
>>> echo root > test/test1/cpuset.cpus.partition
>>> cat test/test1/cpuset.cpus.partition
>>> root invalid (Parent is not a partition root)
>>>
>>> The parent of a remote partition could not be a root. This is due to the
>>> emtpy effective_xcpus. It would be better to prompt the message "invalid
>>> cpu list in cpuset.cpus.exclusive".
>>>
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>   kernel/cgroup/cpuset.c | 42 +++++++++++++++++++++++-------------------
>>>   1 file changed, 23 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index e34fd6108b06..fdd5346616d3 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -80,6 +80,7 @@ enum prs_errcode {
>>>       PERR_HOTPLUG,
>>>       PERR_CPUSEMPTY,
>>>       PERR_HKEEPING,
>>> +    PERR_PMT,
> 
> One more thing, the "PMT" acronym for the error code is hard to decode. 
> I will suggest you either use the "PERMISSION" or "ACCESS" like the 
> EACCESS errno.
> 
> Cheers,
> Longman
> 
Thanks, will do.
>>>   };
>>>     static const char * const perr_strings[] = {
>>> @@ -91,6 +92,7 @@ static const char * const perr_strings[] = {
>>>       [PERR_HOTPLUG]   = "No cpu available due to hotplug",
>>>       [PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are 
>>> empty",
>>>       [PERR_HKEEPING]  = "partition config conflicts with 
>>> housekeeping setup",
>>> +    [PERR_PMT]       = "Enable partition not permitted",
>>>   };
>>>     struct cpuset {
>>> @@ -1669,7 +1671,7 @@ static int remote_partition_enable(struct 
>>> cpuset *cs, int new_prs,
>>>        * The user must have sysadmin privilege.
>>>        */
>>>       if (!capable(CAP_SYS_ADMIN))
>>> -        return 0;
>>> +        return PERR_PMT;
>>>         /*
>>>        * The requested exclusive_cpus must not be allocated to other
>>> @@ -1683,7 +1685,7 @@ static int remote_partition_enable(struct 
>>> cpuset *cs, int new_prs,
>>>       if (cpumask_empty(tmp->new_cpus) ||
>>>           cpumask_intersects(tmp->new_cpus, subpartitions_cpus) ||
>>>           cpumask_subset(top_cpuset.effective_cpus, tmp->new_cpus))
>>> -        return 0;
>>> +        return PERR_INVCPUS;
>>>         spin_lock_irq(&callback_lock);
>>>       isolcpus_updated = partition_xcpus_add(new_prs, NULL, 
>>> tmp->new_cpus);
>>> @@ -1698,7 +1700,7 @@ static int remote_partition_enable(struct 
>>> cpuset *cs, int new_prs,
>>>        */
>>>       update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>>>       update_sibling_cpumasks(&top_cpuset, NULL, tmp);
>>> -    return 1;
>>> +    return 0;
>>>   }
>>
>> Since you are changing the meaning of the function returned value, you 
>> should also update the return value comment as well.
>>
Will do.
>>>     /*
>>> @@ -3151,24 +3153,26 @@ static int update_prstate(struct cpuset *cs, 
>>> int new_prs)
>>>           goto out;
>>>         if (!old_prs) {
>>> -        enum partition_cmd cmd = (new_prs == PRS_ROOT)
>>> -                       ? partcmd_enable : partcmd_enablei;
>>> -
>>>           /*
>>> -         * cpus_allowed and exclusive_cpus cannot be both empty.
>>> -         */
>>> -        if (xcpus_empty(cs)) {
>>> -            err = PERR_CPUSEMPTY;
>>> -            goto out;
>>> -        }
>>> +        * If parent is valid partition, enable local partiion.
>>> +        * Otherwise, enable a remote partition.
>>> +        */
>>> +        if (is_partition_valid(parent)) {
>>> +            enum partition_cmd cmd = (new_prs == PRS_ROOT)
>>> +                           ? partcmd_enable : partcmd_enablei;
>>>   -        err = update_parent_effective_cpumask(cs, cmd, NULL, 
>>> &tmpmask);
>>> -        /*
>>> -         * If an attempt to become local partition root fails,
>>> -         * try to become a remote partition root instead.
>>> -         */
>>> -        if (err && remote_partition_enable(cs, new_prs, &tmpmask))
>>> -            err = 0;
>>> +            /*
>>> +             * cpus_allowed and exclusive_cpus cannot be both empty.
>>> +             */
>>> +            if (xcpus_empty(cs)) {
>>> +                err = PERR_CPUSEMPTY;
>>> +                goto out;
>>> +            }
>>
>> The xcpus_empty() check should be done for both local and remote 
>> partition.
>>
>> Cheers,
>> Longman
>>
Thanks, I will do it at V2.

Thanks,
Ridong
>>> +
>>> +            err = update_parent_effective_cpumask(cs, cmd, NULL, 
>>> &tmpmask);
>>> +        } else {
>>> +            err = remote_partition_enable(cs, new_prs, &tmpmask);
>>> +        }
>>>       } else if (old_prs && new_prs) {
>>>           /*
>>>            * A change in load balance state only, no change in cpumasks.
> 
> 

