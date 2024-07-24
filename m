Return-Path: <cgroups+bounces-3874-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A33B993AB58
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 04:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35F6B2852FD
	for <lists+cgroups@lfdr.de>; Wed, 24 Jul 2024 02:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67E117C68;
	Wed, 24 Jul 2024 02:44:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453954A00;
	Wed, 24 Jul 2024 02:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721789075; cv=none; b=YT7EJZQCDoj+Wxjo93dnwA7oWwcn/EhlxFzUtVWo8IdJhcmSHQ/qBAK8WeQ/SunI5tGOkThtPK7nqgPaWN6yG/Sjawu2A3EvvZ1cJ+0d5j0oU2UbuEfW4O265q9Er3F7hBoJznZdo+o/BIPStU8JzSg+Cd4JcpbvVAPU1kY+PYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721789075; c=relaxed/simple;
	bh=tVPxZP1UbTHoUqJjhd9W2PlwJuOZ8IZJegTS8gYKny4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fXE8Ay+z2XkFiuBIfnuCwicUJifG2ShYb0L+i4eao8hzqOIv4GpjLZcSh+pn6mnTIcaXcHWZPQHgC4KxNffyDWwy62AtXa/ezUidK5N5B5N0E90jBRrggTNoLwx3eaWcXCqOyM3uwL3zuyBAdASRZlP5bgQBVA271Rn6/3X5rxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WTJF73JF3z1HFVy;
	Wed, 24 Jul 2024 10:41:47 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 418561402D0;
	Wed, 24 Jul 2024 10:44:28 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 24 Jul
 2024 10:44:27 +0800
Message-ID: <0c685c5e-bb9d-4b96-8cce-1be1bca59059@huawei.com>
Date: Wed, 24 Jul 2024 10:44:26 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup/cpuset: remove child_ecpus_count
To: Waiman Long <longman@redhat.com>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <adityakali@google.com>,
	<sergeh@kernel.org>, <mkoutny@suse.com>
CC: <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240724010803.2195033-1-chenridong@huawei.com>
 <145e04fe-1e21-4e64-a825-807af3d4434d@redhat.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <145e04fe-1e21-4e64-a825-807af3d4434d@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/24 10:16, Waiman Long wrote:
> On 7/23/24 21:08, Chen Ridong wrote:
>> The child_ecpus_count variable was previously used to update
>> sibling cpumask when parent's effective_cpus is updated. However, it 
>> became
>> obsolete after commit e2ffe502ba45 ("cgroup/cpuset: Add
>> cpuset.cpus.exclusive for v2"). It should be removed.
> Thanks for finding that.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 13 -------------
>>   1 file changed, 13 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 40ec4abaf440..146bf9258db2 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -188,10 +188,8 @@ struct cpuset {
>>       /*
>>        * Default hierarchy only:
>>        * use_parent_ecpus - set if using parent's effective_cpus
>> -     * child_ecpus_count - # of children with use_parent_ecpus set
>>        */
>>       int use_parent_ecpus;
>> -    int child_ecpus_count;
>>       /*
>>        * number of SCHED_DEADLINE tasks attached to this cpuset, so 
>> that we
>> @@ -1512,7 +1510,6 @@ static void reset_partition_data(struct cpuset *cs)
>>       if (!cpumask_and(cs->effective_cpus,
>>                parent->effective_cpus, cs->cpus_allowed)) {
>>           cs->use_parent_ecpus = true;
>> -        parent->child_ecpus_count++;
>>           cpumask_copy(cs->effective_cpus, parent->effective_cpus);
>>       }
>>   }
>> @@ -1689,10 +1686,7 @@ static int remote_partition_enable(struct 
>> cpuset *cs, int new_prs,
>>       isolcpus_updated = partition_xcpus_add(new_prs, NULL, 
>> tmp->new_cpus);
>>       list_add(&cs->remote_sibling, &remote_children);
>>       if (cs->use_parent_ecpus) {
>> -        struct cpuset *parent = parent_cs(cs);
>> -
>>           cs->use_parent_ecpus = false;
>> -        parent->child_ecpus_count--;
>>       }
> You can also remove { } or just set use_parent_ecpus to false.
>>       spin_unlock_irq(&callback_lock);
>>       update_unbound_workqueue_cpumask(isolcpus_updated);
>> @@ -2320,12 +2314,9 @@ static void update_cpumasks_hier(struct cpuset 
>> *cs, struct tmpmasks *tmp,
>>               cpumask_copy(tmp->new_cpus, parent->effective_cpus);
>>               if (!cp->use_parent_ecpus) {
>>                   cp->use_parent_ecpus = true;
>> -                parent->child_ecpus_count++;
>>               }
> Just set it to true.
>>           } else if (cp->use_parent_ecpus) {
>>               cp->use_parent_ecpus = false;
>> -            WARN_ON_ONCE(!parent->child_ecpus_count);
>> -            parent->child_ecpus_count--;
>>           }
> Remove {} or set it to false.
>>           if (remote)
>> @@ -4139,7 +4130,6 @@ static int cpuset_css_online(struct 
>> cgroup_subsys_state *css)
>>           cpumask_copy(cs->effective_cpus, parent->effective_cpus);
>>           cs->effective_mems = parent->effective_mems;
>>           cs->use_parent_ecpus = true;
>> -        parent->child_ecpus_count++;
>>       }
>>       spin_unlock_irq(&callback_lock);
>> @@ -4206,10 +4196,7 @@ static void cpuset_css_offline(struct 
>> cgroup_subsys_state *css)
>>           update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
>>       if (cs->use_parent_ecpus) {
>> -        struct cpuset *parent = parent_cs(cs);
>> -
>>           cs->use_parent_ecpus = false;
>> -        parent->child_ecpus_count--;
>>       }
> Just set it to false.
> 
> Cheers,
> Longman
> 
> 
> 

Thank you, Longman, I will do that.

I am considering the necessity of use_parent_ecpus. Currently, the 
use_parent_ecpus variable is only utilized within the 
update_sibling_cpumasks function. This implies that if a cpuset is not 
configured to use its parent's effective_cpus, it might not need to 
invoke update_cpumasks_hier. However, the invocation of 
update_cpumasks_hier may not be necessary for a cpuset, regardless of 
whether it uses its parent's effective_cpus, if there is no change in 
the cpuset's effective_cpus.

Is use_parent_ecpus still relevant?
Or, do I miss something?

Thanks
Ridong

