Return-Path: <cgroups+bounces-11839-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6BC5023B
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 01:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CD67A34BFA8
	for <lists+cgroups@lfdr.de>; Wed, 12 Nov 2025 00:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86711E5718;
	Wed, 12 Nov 2025 00:45:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF033F3;
	Wed, 12 Nov 2025 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762908302; cv=none; b=PkN7aLwAhMMDVe8uCSPpoEyTAw5W9XZKCzs8G3iwwmw8GKmgpEZx+Sy16RIq7l0fuUCPJUWWGW+W0vJS/BlvTTd9BTzOiz2ddQMCge1t9CUBk5nRL57D57WyeIgq26D1Ltp58rDOHuVV4n19DJTpVklAS/eAOvkKygbbIOWhGcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762908302; c=relaxed/simple;
	bh=a1BOEu2pejaHCZiL5XfB9WFufKW13R6QgWRNxhGxDXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sdSippNTYnK5MXOdR0rWGGhsbw5FjiWZxYAComDjrCYHOdxqhXmX50Q8mImAifsA75wn5J+DEic9Zclisa0Bha008rrKxQmChZLWzTSppUFjlz9pI9xhyt6TzHbLdROsqEdNxFGKgmuaGltlB9MIZSFMkA/ad6Ei+AV4qFLXjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5l6516SfzYQtfT;
	Wed, 12 Nov 2025 08:44:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B836C1A0BB3;
	Wed, 12 Nov 2025 08:44:56 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP3 (Coremail) with SMTP id _Ch0CgAX4BGH2BNpdqizAQ--.9685S2;
	Wed, 12 Nov 2025 08:44:56 +0800 (CST)
Message-ID: <b94504d5-0a2b-48f4-a445-f2c83898e8d0@huaweicloud.com>
Date: Wed, 12 Nov 2025 08:44:55 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2 2/3] cpuset: remove global remote_children list
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251111132429.950343-1-chenridong@huaweicloud.com>
 <20251111132429.950343-3-chenridong@huaweicloud.com>
 <307e7687-4320-4b2b-a552-5d8409522cfe@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <307e7687-4320-4b2b-a552-5d8409522cfe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAX4BGH2BNpdqizAQ--.9685S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWDZr4fZr4xGrWktr47Arb_yoW7Cr4UpF
	1kGFWrJFW5Krn5C347JF1Uu3sxtw1DJ3WDtw1fXa4rJF43ZF1j9Fyj934q934UZ3ykGry5
	ZFn8ZrZ7ZF17AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/11 22:56, Waiman Long wrote:
> On 11/11/25 8:24 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The remote_children list is used to track all remote partitions attached
>> to a cpuset. However, it serves no other purpose. Using a boolean flag to
>> indicate whether a cpuset is a remote partition is a more direct approach,
>> making remote_children unnecessary.
>>
>> This patch replaces the list with a remote_partition flag in the cpuset
>> structure and removes remote_children entirely.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h | 10 +++++++---
>>   kernel/cgroup/cpuset.c          | 13 ++++---------
>>   2 files changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index 5cac42c5fd97..01976c8e7d49 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -158,6 +158,13 @@ struct cpuset {
>>       /* partition root state */
>>       int partition_root_state;
>>   +    /*
>> +     * Whether cpuset is a remote partition.
>> +     * It used to be a list anchoring all remote partitions — we can switch back
>> +     * to a list if we need to iterate over the remote partitions.
>> +     */
>> +    bool remote_partition;
>> +
>>       /*
>>        * number of SCHED_DEADLINE tasks attached to this cpuset, so that we
>>        * know when to rebuild associated root domain bandwidth information.
>> @@ -172,9 +179,6 @@ struct cpuset {
>>       /* Handle for cpuset.cpus.partition */
>>       struct cgroup_file partition_file;
>>   -    /* Remote partition silbling list anchored at remote_children */
>> -    struct list_head remote_sibling;
>> -
>>       /* Used to merge intersecting subsets for generate_sched_domains */
>>       struct uf_node node;
>>   };
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index c90476d52f09..aff3ddc67393 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -94,9 +94,6 @@ static bool isolated_cpus_updating;
>>   static cpumask_var_t    boot_hk_cpus;
>>   static bool        have_boot_isolcpus;
>>   -/* List of remote partition root children */
>> -static struct list_head remote_children;
>> -
>>   /*
>>    * A flag to force sched domain rebuild at the end of an operation.
>>    * It can be set in
>> @@ -219,7 +216,7 @@ static struct cpuset top_cpuset = {
>>            BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>       .partition_root_state = PRS_ROOT,
>>       .relax_domain_level = -1,
>> -    .remote_sibling = LIST_HEAD_INIT(top_cpuset.remote_sibling),
>> +    .remote_partition = false,
> I forgot to notify you that this init is also not needed. Anyway, this is a minor issue.

Hmm, I should have noticed that. This could be fixed if we send a related patch in the future, but I
don't think it's worth submitting a standalone patch.

>>   };
>>     /*
>> @@ -1572,7 +1569,7 @@ static int compute_trialcs_excpus(struct cpuset *trialcs, struct cpuset *cs)
>>     static inline bool is_remote_partition(struct cpuset *cs)
>>   {
>> -    return !list_empty(&cs->remote_sibling);
>> +    return cs->remote_partition;
>>   }
>>     static inline bool is_local_partition(struct cpuset *cs)
>> @@ -1621,7 +1618,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
>>         spin_lock_irq(&callback_lock);
>>       partition_xcpus_add(new_prs, NULL, tmp->new_cpus);
>> -    list_add(&cs->remote_sibling, &remote_children);
>> +    cs->remote_partition = true;
>>       cpumask_copy(cs->effective_xcpus, tmp->new_cpus);
>>       spin_unlock_irq(&callback_lock);
>>       update_isolation_cpumasks();
>> @@ -1651,7 +1648,7 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
>>       WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
>>         spin_lock_irq(&callback_lock);
>> -    list_del_init(&cs->remote_sibling);
>> +    cs->remote_partition = false;
>>       partition_xcpus_del(cs->partition_root_state, NULL, cs->effective_xcpus);
>>       if (cs->prs_err)
>>           cs->partition_root_state = -cs->partition_root_state;
>> @@ -3603,7 +3600,6 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>>       __set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>>       fmeter_init(&cs->fmeter);
>>       cs->relax_domain_level = -1;
>> -    INIT_LIST_HEAD(&cs->remote_sibling);
>>         /* Set CS_MEMORY_MIGRATE for default hierarchy */
>>       if (cpuset_v2())
>> @@ -3874,7 +3870,6 @@ int __init cpuset_init(void)
>>       nodes_setall(top_cpuset.effective_mems);
>>         fmeter_init(&top_cpuset.fmeter);
>> -    INIT_LIST_HEAD(&remote_children);
>>         BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>>   
> Reviewed-by: Waiman Long <longman@redhat.com>
> 

Thanks.

-- 
Best regards,
Ridong


