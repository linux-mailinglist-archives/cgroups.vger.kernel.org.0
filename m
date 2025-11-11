Return-Path: <cgroups+bounces-11798-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F76C4BA10
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 07:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381191887FF4
	for <lists+cgroups@lfdr.de>; Tue, 11 Nov 2025 06:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957F52D063C;
	Tue, 11 Nov 2025 06:18:06 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B756D2882B6;
	Tue, 11 Nov 2025 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762841886; cv=none; b=MrUMtuDZHXtr4NBfeo8Xaz0kosvKcStTJHgiPMPmEmvvlR1x6T22p2bPrGYKeMGVk7DnNUzhackOK8HQmTu/i5EeuZnQ4nTyGPRpuvahB1DsHiM0u4UglP52+y2PdG/lr8pYRiLuWZh73vJiAEOgvznXlHnnQOmLsbeXrbKnPBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762841886; c=relaxed/simple;
	bh=OtrNNdU7jkbrpGjCrmplHiJcqcdjmGgIiJSaGQ0XCW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nDCPQhoNRVhgPwID/v8duF9Zn7U50QqwvKdCIg04emr+jtubjoCBA3alUKqRlljcmOzM0EZkQnTyy1FSkFqoE4DhmBblC6PsZEptGxOdhYTkHpbNQgl5pplVIMvSt62KQUNjxP33nX3CCxEnHrU5sBsk9qlQF7ySb0aHYiFV/ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4d5GY356FNzKHMQG;
	Tue, 11 Nov 2025 14:17:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 69E801A1797;
	Tue, 11 Nov 2025 14:17:59 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgBnoksX1RJpcH5fAQ--.31345S2;
	Tue, 11 Nov 2025 14:17:59 +0800 (CST)
Message-ID: <8c56fa6b-1e7f-457a-9314-47f50e625c50@huaweicloud.com>
Date: Tue, 11 Nov 2025 14:17:58 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/3] cpuset: remove global remote_children list
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251110015228.897736-1-chenridong@huaweicloud.com>
 <20251110015228.897736-3-chenridong@huaweicloud.com>
 <51ee41f3-02d7-4b76-acfc-882abe9a003d@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <51ee41f3-02d7-4b76-acfc-882abe9a003d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnoksX1RJpcH5fAQ--.31345S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4xWry7tFy7KryktrWxCrg_yoW7WFy7pF
	1kGFWrJrW5Grn5C347JF1DW3s8twnrJ3Zrtw1fXa4fJr47Zr1qgF1j93909a4UX3ykGry5
	ZFn0vrZrZF17AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/11 12:34, Waiman Long wrote:
> On 11/9/25 8:52 PM, Chen Ridong wrote:
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
>>   kernel/cgroup/cpuset-internal.h |  4 ++--
>>   kernel/cgroup/cpuset.c          | 14 +++++---------
>>   2 files changed, 7 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index 5cac42c5fd97..7308e8bc4dde 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -172,8 +172,8 @@ struct cpuset {
>>       /* Handle for cpuset.cpus.partition */
>>       struct cgroup_file partition_file;
>>   -    /* Remote partition silbling list anchored at remote_children */
>> -    struct list_head remote_sibling;
>> +    /* Whether cpuset is a remote partition */
>> +    bool remote_partition;
>>   
> 
> The original purpose of adding a linked list for remote children is to enable us iterate the list of
> remote children when needed. This capability is not currently being used. So we can simplify it for
> now, but I would like to add a comment saying that we can switch it back to a list in case we need
> to iterate the remote children list in the future. Also I would suggest moving the bool up before
> partition_file to reduce the number of holes in the cpuset structure.
> 

Thanks, will update.

> 
>>       /* Used to merge intersecting subsets for generate_sched_domains */
>>       struct uf_node node;
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index c90476d52f09..c357bfb69fe2 100644
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
>> @@ -3603,7 +3600,7 @@ cpuset_css_alloc(struct cgroup_subsys_state *parent_css)
>>       __set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>>       fmeter_init(&cs->fmeter);
>>       cs->relax_domain_level = -1;
>> -    INIT_LIST_HEAD(&cs->remote_sibling);
>> +    cs->remote_partition = false;
>>   
> 
> We don't need to initialize remote_partition here as the structure is zalloc'ed.
> 

Thanks, will update.

> 
>>       /* Set CS_MEMORY_MIGRATE for default hierarchy */
>>       if (cpuset_v2())
>> @@ -3874,7 +3871,6 @@ int __init cpuset_init(void)
>>       nodes_setall(top_cpuset.effective_mems);
>>         fmeter_init(&top_cpuset.fmeter);
>> -    INIT_LIST_HEAD(&remote_children);
>>         BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>>   
> 

-- 
Best regards,
Ridong


