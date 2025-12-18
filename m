Return-Path: <cgroups+bounces-12464-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A340FCC9EAD
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 01:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 633E930275C0
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 00:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C32225791;
	Thu, 18 Dec 2025 00:44:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92931EEA54;
	Thu, 18 Dec 2025 00:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766018662; cv=none; b=Xkle1sWOJCCkm/r3zK1NCpdxIW/qhY2mh3mRVnRzw/3zAKWn/9yxJoqtXxe5pk0En6KQIkWk7ah366Pimu9PI5NSzIcRSO/wOmAjYxz3iDd0XxibVOSw6LjMX1EPxN5UauhQYX9sqrHP2I67kTJsNIZwrO+y9a716HA0Ef0QEcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766018662; c=relaxed/simple;
	bh=Vl1c1gQBc8Mwn2kWWV8werKvpdd8VEt3hXM0R/om9+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e9h2tk+UPmoYUDuCzKN2HjxbvBBcBMp0XvDcgsxo/2coZXHbOtrn1f9vqT+Xa5ID2IOOXFBYyJjJNGfqjwUW94AeNOFkJdu5Kw1WkVwwIsUxjW0wTnsTjFT3+yxT1D9nqUejCPvnkgHPGZWmB/XUctIFeRV1yGEghyH+Q00kVVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWsNj4tMFzYQthg;
	Thu, 18 Dec 2025 08:43:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6745F40574;
	Thu, 18 Dec 2025 08:44:17 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgCnB_hgTkNpcgpHAg--.12339S2;
	Thu, 18 Dec 2025 08:44:17 +0800 (CST)
Message-ID: <3d9464bd-77ee-4ff7-a9e8-90930b994d00@huaweicloud.com>
Date: Thu, 18 Dec 2025 08:44:15 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 4/6] cpuset: move update_domain_attr_tree to
 cpuset_v1.c
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-5-chenridong@huaweicloud.com>
 <249786b2-f715-4a46-be47-d6d3d6f35c10@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <249786b2-f715-4a46-be47-d6d3d6f35c10@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnB_hgTkNpcgpHAg--.12339S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AFW7Jw4xtr1xWw1xXF47Arb_yoW7uF4DpF
	ykGay3J3y5Cr18Cw18G34UXa4Ygw18t3WUtr10ga48JF42yF1j9FyUXrn09FyUAFWkCr4U
	AF1jvr43uFnrJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/18 1:09, Waiman Long wrote:
> 
> On 12/17/25 3:49 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Since relax_domain_level is only applicable to v1, move
>> update_domain_attr_tree() to cpuset-v1.c, which solely updates
>> relax_domain_level,
>>
>> Additionally, relax_domain_level is now initialized in cpuset1_inited.
>> Accordingly, the initialization of relax_domain_level in top_cpuset is
>> removed. The unnecessary remote_partition initialization in top_cpuset
>> is also cleaned up.
>>
>> As a result, relax_domain_level can be defined in cpuset only when
>> CONFIG_CPUSETS_V1=y.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h | 11 ++++++++---
>>   kernel/cgroup/cpuset-v1.c       | 28 ++++++++++++++++++++++++++++
>>   kernel/cgroup/cpuset.c          | 31 -------------------------------
>>   3 files changed, 36 insertions(+), 34 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index a32517da8231..677053ffb913 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -150,9 +150,6 @@ struct cpuset {
>>        */
>>       int attach_in_progress;
>>   -    /* for custom sched domain */
>> -    int relax_domain_level;
>> -
>>       /* partition root state */
>>       int partition_root_state;
>>   @@ -182,6 +179,9 @@ struct cpuset {
>>     #ifdef CONFIG_CPUSETS_V1
>>       struct fmeter fmeter;        /* memory_pressure filter */
>> +
>> +    /* for custom sched domain */
>> +    int relax_domain_level;
>>   #endif
>>   };
>>   @@ -296,6 +296,8 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>   int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>>   void cpuset1_init(struct cpuset *cs);
>>   void cpuset1_online_css(struct cgroup_subsys_state *css);
>> +void update_domain_attr_tree(struct sched_domain_attr *dattr,
>> +                    struct cpuset *root_cs);
>>   #else
>>   static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
>>                       struct task_struct *tsk) {}
>> @@ -307,6 +309,9 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
>>                   struct cpuset *trial) { return 0; }
>>   static inline void cpuset1_init(struct cpuset *cs) {}
>>   static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>> +static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
>> +                    struct cpuset *root_cs) {}
>> +
>>   #endif /* CONFIG_CPUSETS_V1 */
>>     #endif /* __CPUSET_INTERNAL_H */
>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> index 574df740f21a..95de6f2a4cc5 100644
>> --- a/kernel/cgroup/cpuset-v1.c
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -502,6 +502,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>>   void cpuset1_init(struct cpuset *cs)
>>   {
>>       fmeter_init(&cs->fmeter);
>> +    cs->relax_domain_level = -1;
>>   }
>>     void cpuset1_online_css(struct cgroup_subsys_state *css)
>> @@ -552,6 +553,33 @@ void cpuset1_online_css(struct cgroup_subsys_state *css)
>>       cpuset_callback_unlock_irq();
>>   }
>>   +static void
>> +update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
>> +{
>> +    if (dattr->relax_domain_level < c->relax_domain_level)
>> +        dattr->relax_domain_level = c->relax_domain_level;
>> +}
>> +
>> +void update_domain_attr_tree(struct sched_domain_attr *dattr,
>> +                    struct cpuset *root_cs)
>> +{
>> +    struct cpuset *cp;
>> +    struct cgroup_subsys_state *pos_css;
>> +
>> +    rcu_read_lock();
>> +    cpuset_for_each_descendant_pre(cp, pos_css, root_cs) {
>> +        /* skip the whole subtree if @cp doesn't have any CPU */
>> +        if (cpumask_empty(cp->cpus_allowed)) {
>> +            pos_css = css_rightmost_descendant(pos_css);
>> +            continue;
>> +        }
>> +
>> +        if (is_sched_load_balance(cp))
>> +            update_domain_attr(dattr, cp);
>> +    }
>> +    rcu_read_unlock();
>> +}
>> +
>>   /*
>>    * for the common functions, 'private' gives the type of file
>>    */
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index e836a1f2b951..88ca8b40e01a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -215,8 +215,6 @@ static struct cpuset top_cpuset = {
>>       .flags = BIT(CS_CPU_EXCLUSIVE) |
>>            BIT(CS_MEM_EXCLUSIVE) | BIT(CS_SCHED_LOAD_BALANCE),
>>       .partition_root_state = PRS_ROOT,
>> -    .relax_domain_level = -1,
> 
> As the cpuset1_init() function will not be called for top_cpuset, you should not remove the
> initialization of relax_domain_level. Instead, put it inside a "ifdef CONFIG_CPUSETS_V1 block.
> 

In patch 3/6, I've made cpuset_init call cpuset1_init to initialize top_cpuset.fmeter. Thus, I think
we could remove the relax_domain_level initialization here.

>> -    .remote_partition = false,
> 
> Yes, this is not really needed and can be removed.
> 
> Cheers,
> Longman
> 

-- 
Best regards,
Ridong


