Return-Path: <cgroups+bounces-12466-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15CCC9FE8
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 02:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E107B305D407
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 01:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1C626059B;
	Thu, 18 Dec 2025 01:39:51 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781BB23F417;
	Thu, 18 Dec 2025 01:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021991; cv=none; b=LJgEE3JvoQFpDJYVYK9KzOUa5AsDwpB8YfSlKmZW5y3dLb0eUu7AG43J4BBR1p8Hw3yIt5kIAe+zg82s4cGSFcLbZw8YoAL68pVV3+DNqJzL10lGDXOzc49dPMB5/9rIOn6CsOrkWfy+o5PvvChF43yfJCfcgtPSVq+tIuPyxTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021991; c=relaxed/simple;
	bh=sM00u4i3d+2xCFxvTwyr3vSrnyufjFDi25OoOw24MqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQvx8vVT40d9B56KOD3pSEfIA6a1YM94l6Z1VdR9q9l2+8QZRLQdSDVIr53iQUqz2IQmd1SqxzzG9EbuFUrTjSZqPl5hk7UBkb70gvl4O4KxvgvrqJmR+rRMLgOcx+SeL+dAGG96Xglou9KzN8XaFY2V68pki2Zt0j4LmVJg6Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWtcj2QPtzYQtf3;
	Thu, 18 Dec 2025 09:39:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 249544057A;
	Thu, 18 Dec 2025 09:39:45 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgB31_dfW0Npep1LAg--.22642S2;
	Thu, 18 Dec 2025 09:39:45 +0800 (CST)
Message-ID: <c6dfcbc9-c7e1-4221-b79c-b4c745e5b167@huaweicloud.com>
Date: Thu, 18 Dec 2025 09:39:43 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 6/6] cpuset: remove v1-specific code from
 generate_sched_domains
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-7-chenridong@huaweicloud.com>
 <47029555-aba6-4d85-ace3-0580ec606e5d@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <47029555-aba6-4d85-ace3-0580ec606e5d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB31_dfW0Npep1LAg--.22642S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWrWFWrWw1xWryrJw4fZrb_yoW3Xry7pF
	1kGFyUJrW5Gr18Gw18Jw1UX34UKw4Uta1Utw1UXa48Jr47JF1q9FyUXFn09FyUur4kCr17
	AF1jqr47ZF1DJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/18 3:05, Waiman Long wrote:
> On 12/17/25 3:49 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Following the introduction of cpuset1_generate_sched_domains() for v1
>> in the previous patch, v1-specific logic can now be removed from the
>> generic generate_sched_domains(). This patch cleans up the v1-only
>> code and ensures uf_node is only visible when CONFIG_CPUSETS_V1=y.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h |  10 +--
>>   kernel/cgroup/cpuset-v1.c       |   2 +-
>>   kernel/cgroup/cpuset.c          | 144 +++++---------------------------
>>   3 files changed, 27 insertions(+), 129 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index bd767f8cb0ed..ef7b7c5afd4c 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -175,14 +175,14 @@ struct cpuset {
>>       /* Handle for cpuset.cpus.partition */
>>       struct cgroup_file partition_file;
>>   -    /* Used to merge intersecting subsets for generate_sched_domains */
>> -    struct uf_node node;
>> -
>>   #ifdef CONFIG_CPUSETS_V1
>>       struct fmeter fmeter;        /* memory_pressure filter */
>>         /* for custom sched domain */
>>       int relax_domain_level;
>> +
>> +    /* Used to merge intersecting subsets for generate_sched_domains */
>> +    struct uf_node node;
>>   #endif
>>   };
>>   @@ -315,8 +315,6 @@ void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>   int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>>   void cpuset1_init(struct cpuset *cs);
>>   void cpuset1_online_css(struct cgroup_subsys_state *css);
>> -void update_domain_attr_tree(struct sched_domain_attr *dattr,
>> -                    struct cpuset *root_cs);
>>   int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>>               struct sched_domain_attr **attributes);
>>   @@ -331,8 +329,6 @@ static inline int cpuset1_validate_change(struct cpuset *cur,
>>                   struct cpuset *trial) { return 0; }
>>   static inline void cpuset1_init(struct cpuset *cs) {}
>>   static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>> -static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
>> -                    struct cpuset *root_cs) {}
>>   static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>>               struct sched_domain_attr **attributes) { return 0; };
>>   diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> index 5c0bded46a7c..0226350e704f 100644
>> --- a/kernel/cgroup/cpuset-v1.c
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -560,7 +560,7 @@ update_domain_attr(struct sched_domain_attr *dattr, struct cpuset *c)
>>           dattr->relax_domain_level = c->relax_domain_level;
>>   }
>>   -void update_domain_attr_tree(struct sched_domain_attr *dattr,
>> +static void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>                       struct cpuset *root_cs)
>>   {
>>       struct cpuset *cp;
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 6bb0b201c34b..3e3468d928f3 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -789,18 +789,13 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>   {
>>       struct cpuset *cp;    /* top-down scan of cpusets */
>>       struct cpuset **csa;    /* array of all cpuset ptrs */
>> -    int csn;        /* how many cpuset ptrs in csa so far */
>>       int i, j;        /* indices for partition finding loops */
>>       cpumask_var_t *doms;    /* resulting partition; i.e. sched domains */
>>       struct sched_domain_attr *dattr;  /* attributes for custom domains */
>>       int ndoms = 0;        /* number of sched domains in result */
>> -    int nslot;        /* next empty doms[] struct cpumask slot */
>>       struct cgroup_subsys_state *pos_css;
>> -    bool root_load_balance = is_sched_load_balance(&top_cpuset);
>> -    bool cgrpv2 = cpuset_v2();
>> -    int nslot_update;
>>   -    if (!cgrpv2)
>> +    if (!cpuset_v2())
>>           return cpuset1_generate_sched_domains(domains, attributes);
>>         doms = NULL;
>> @@ -808,70 +803,25 @@ static int generate_sched_domains(cpumask_var_t **domains,
>>       csa = NULL;
>>         /* Special case for the 99% of systems with one, full, sched domain */
>> -    if (root_load_balance && cpumask_empty(subpartitions_cpus)) {
>> -single_root_domain:
>> +    if (cpumask_empty(subpartitions_cpus)) {
>>           ndoms = 1;
>> -        doms = alloc_sched_domains(ndoms);
>> -        if (!doms)
>> -            goto done;
>> -
>> -        dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
>> -        if (dattr) {
>> -            *dattr = SD_ATTR_INIT;
>> -            update_domain_attr_tree(dattr, &top_cpuset);
>> -        }
>> -        cpumask_and(doms[0], top_cpuset.effective_cpus,
>> -                housekeeping_cpumask(HK_TYPE_DOMAIN));
>> -
>> -        goto done;
>> +        goto generate_doms;
> 
> That is not correct. The code under the generate_doms label will need to access csa[0] which is not
> allocated yet and may cause panic. You either need to keep the current code or move it after the csa
> allocation and assign top_cpuset to csa[0].
> 

Thank you, Longman.

Sorry, I should note that I made a small change. I added a !csa check: if csa is not allocated, then
ndoms should equal 1, and we only need the top_cpuset (no csa is indeed required). I think it's
cleaner to avoid allocating csa when there's no valid partition.

```
+	for (i = 0; i < ndoms; i++) {
+		/*
+		 * The top cpuset may contain some boot time isolated
+		 * CPUs that need to be excluded from the sched domain.
+		 */
+		if (!csa || csa[i] == &top_cpuset)
+			cpumask_and(doms[i], top_cpuset.effective_cpus,
+				    housekeeping_cpumask(HK_TYPE_DOMAIN));
+		else
+			cpumask_copy(doms[i], csa[i]->effective_cpus);
+		if (dattr)
+			dattr[i] = SD_ATTR_INIT;
 	}
```

Tested with single‑domain generation — no panic or warning observed.

>>       }
>>         csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
>>       if (!csa)
>>           goto done;
>> -    csn = 0;
>>   +    /* Find how many partitions and cache them to csa[] */
>>       rcu_read_lock();
>> -    if (root_load_balance)
>> -        csa[csn++] = &top_cpuset;
>>       cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
> 
> The cpuset_for_each_descendant_pre() macro will visit the root (top_cpuset) first and so it should
> be OK to remove the above 2 lines of code.
> 
> Cheers,
> Longman
> 

-- 
Best regards,
Ridong


