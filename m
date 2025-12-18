Return-Path: <cgroups+bounces-12465-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B0FCC9FB4
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 02:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C876D300ACF4
	for <lists+cgroups@lfdr.de>; Thu, 18 Dec 2025 01:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72AC2459ED;
	Thu, 18 Dec 2025 01:28:45 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F0486331;
	Thu, 18 Dec 2025 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766021325; cv=none; b=HDdP8ydXRpc49PeUbqPUhoubw3BAia/d0qR7ReXnJJy0HrUKCje3aKHLN+UWdvMgmckRjhcmz4xUjKO15p/Gbq1k+AvEUOukP0kzqxw4AQUP0mfJAhB/8gfVzA8OHD35pgh4I1XGx49u72pBnWsxwv0c/niGD8FgGf0oq2wEOCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766021325; c=relaxed/simple;
	bh=EnF4UNzPQ87zBB1zg0zZD+PGvEejtiP+SQnHhxFsBqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N1LG5oYcKf5DnVGm5JKIEnjJfwwNoqbyG9v9PR8gXkXxVip3TIBNDo3iStYIMMeLTK1VtWOXXCg0IZUjlXW3C29uE1sAGY+sQZGZcvByzq2YhXmfCFaP1WKngpGMxvrdYxWasNdh3knGYClt5kV17cKe3JTJ9KTogx/PHCcnuL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dWtMv4HGjzYQtJB;
	Thu, 18 Dec 2025 09:28:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5FC374056F;
	Thu, 18 Dec 2025 09:28:39 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgAniPjGWENpy65KAg--.15121S2;
	Thu, 18 Dec 2025 09:28:39 +0800 (CST)
Message-ID: <3ca5c423-1b9e-4e59-acf0-ffe3f1086b7e@huaweicloud.com>
Date: Thu, 18 Dec 2025 09:28:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 5/6] cpuset: separate generate_sched_domains for v1
 and v2
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com
References: <20251217084942.2666405-1-chenridong@huaweicloud.com>
 <20251217084942.2666405-6-chenridong@huaweicloud.com>
 <8d0ef5fc-f392-40f8-9803-50807c172800@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <8d0ef5fc-f392-40f8-9803-50807c172800@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAniPjGWENpy65KAg--.15121S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw4Dtw1xJw1fKry8GryDKFg_yoWDJry7pF
	1kGrWUJrWUJrn5Gw1UJr1UXFyakw1UJa1Dtr1rX3WUJr47AF1j9r1UXF9I9r15Ar4kGr1U
	Ar1jqrsruF1DtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/18 1:48, Waiman Long wrote:
Thank you Longman:
> On 12/17/25 3:49 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> The generate_sched_domains() function currently handles both v1 and v2
>> logic. However, the underlying mechanisms for building scheduler domains
>> differ significantly between the two versions. For cpuset v2, scheduler
>> domains are straightforwardly derived from valid partitions, whereas
>> cpuset v1 employs a more complex union-find algorithm to merge overlapping
>> cpusets. Co-locating these implementations complicates maintenance.
>>
>> This patch, along with subsequent ones, aims to separate the v1 and v2
>> logic. For ease of review, this patch first copies the
>> generate_sched_domains() function into cpuset-v1.c as
>> cpuset1_generate_sched_domains() and removes v2-specific code. Common
>> helpers and top_cpuset are declared in cpuset-internal.h. When operating
>> in v1 mode, the code now calls cpuset1_generate_sched_domains().
>>
>> Currently there is some code duplication, which will be largely eliminated
>> once v1-specific code is removed from v2 in the following patch.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h |  24 +++++
>>   kernel/cgroup/cpuset-v1.c       | 167 ++++++++++++++++++++++++++++++++
>>   kernel/cgroup/cpuset.c          |  31 +-----
>>   3 files changed, 195 insertions(+), 27 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
>> index 677053ffb913..bd767f8cb0ed 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -9,6 +9,7 @@
>>   #include <linux/cpuset.h>
>>   #include <linux/spinlock.h>
>>   #include <linux/union_find.h>
>> +#include <linux/sched/isolation.h>
>>     /* See "Frequency meter" comments, below. */
>>   @@ -185,6 +186,8 @@ struct cpuset {
>>   #endif
>>   };
>>   +extern struct cpuset top_cpuset;
>> +
>>   static inline struct cpuset *css_cs(struct cgroup_subsys_state *css)
>>   {
>>       return css ? container_of(css, struct cpuset, css) : NULL;
>> @@ -242,6 +245,22 @@ static inline int is_spread_slab(const struct cpuset *cs)
>>       return test_bit(CS_SPREAD_SLAB, &cs->flags);
>>   }
>>   +/*
>> + * Helper routine for generate_sched_domains().
>> + * Do cpusets a, b have overlapping effective cpus_allowed masks?
>> + */
>> +static inline int cpusets_overlap(struct cpuset *a, struct cpuset *b)
>> +{
>> +    return cpumask_intersects(a->effective_cpus, b->effective_cpus);
>> +}
>> +
>> +static inline int nr_cpusets(void)
>> +{
>> +    assert_cpuset_lock_held();
> 
> For a simple helper like this one which only does an atomic_read(), I don't think you need to assert
> that cpuset_mutex is held.
> 

Will remove it.

I added the lock because the location where it’s removed already includes the comment:
/* Must be called with cpuset_mutex held.  */

>> +    /* jump label reference count + the top-level cpuset */
>> +    return static_key_count(&cpusets_enabled_key.key) + 1;
>> +}
>> +
>>   /**
>>    * cpuset_for_each_child - traverse online children of a cpuset
>>    * @child_cs: loop cursor pointing to the current child
>> @@ -298,6 +317,9 @@ void cpuset1_init(struct cpuset *cs);
>>   void cpuset1_online_css(struct cgroup_subsys_state *css);
>>   void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>                       struct cpuset *root_cs);
>> +int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>> +            struct sched_domain_attr **attributes);
>> +
>>   #else
>>   static inline void cpuset1_update_task_spread_flags(struct cpuset *cs,
>>                       struct task_struct *tsk) {}
>> @@ -311,6 +333,8 @@ static inline void cpuset1_init(struct cpuset *cs) {}
>>   static inline void cpuset1_online_css(struct cgroup_subsys_state *css) {}
>>   static inline void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>                       struct cpuset *root_cs) {}
>> +static inline int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>> +            struct sched_domain_attr **attributes) { return 0; };
>>     #endif /* CONFIG_CPUSETS_V1 */
>>   diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> index 95de6f2a4cc5..5c0bded46a7c 100644
>> --- a/kernel/cgroup/cpuset-v1.c
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -580,6 +580,173 @@ void update_domain_attr_tree(struct sched_domain_attr *dattr,
>>       rcu_read_unlock();
>>   }
>>   +/*
>> + * cpuset1_generate_sched_domains()
>> + *
>> + * Finding the best partition (set of domains):
>> + *    The double nested loops below over i, j scan over the load
>> + *    balanced cpusets (using the array of cpuset pointers in csa[])
>> + *    looking for pairs of cpusets that have overlapping cpus_allowed
>> + *    and merging them using a union-find algorithm.
>> + *
>> + *    The union of the cpus_allowed masks from the set of all cpusets
>> + *    having the same root then form the one element of the partition
>> + *    (one sched domain) to be passed to partition_sched_domains().
>> + */
>> +int cpuset1_generate_sched_domains(cpumask_var_t **domains,
>> +            struct sched_domain_attr **attributes)
>> +{
>> +    struct cpuset *cp;    /* top-down scan of cpusets */
>> +    struct cpuset **csa;    /* array of all cpuset ptrs */
>> +    int csn;        /* how many cpuset ptrs in csa so far */
>> +    int i, j;        /* indices for partition finding loops */
>> +    cpumask_var_t *doms;    /* resulting partition; i.e. sched domains */
>> +    struct sched_domain_attr *dattr;  /* attributes for custom domains */
>> +    int ndoms = 0;        /* number of sched domains in result */
>> +    int nslot;        /* next empty doms[] struct cpumask slot */
>> +    struct cgroup_subsys_state *pos_css;
>> +    bool root_load_balance = is_sched_load_balance(&top_cpuset);
>> +    int nslot_update;
>> +
>> +    assert_cpuset_lock_held();
>> +
>> +    doms = NULL;
>> +    dattr = NULL;
>> +    csa = NULL;
>> +
>> +    /* Special case for the 99% of systems with one, full, sched domain */
>> +    if (root_load_balance) {
>> +single_root_domain:
>> +        ndoms = 1;
>> +        doms = alloc_sched_domains(ndoms);
>> +        if (!doms)
>> +            goto done;
>> +
>> +        dattr = kmalloc(sizeof(struct sched_domain_attr), GFP_KERNEL);
>> +        if (dattr) {
>> +            *dattr = SD_ATTR_INIT;
>> +            update_domain_attr_tree(dattr, &top_cpuset);
>> +        }
>> +        cpumask_and(doms[0], top_cpuset.effective_cpus,
>> +                housekeeping_cpumask(HK_TYPE_DOMAIN));
>> +
>> +        goto done;
>> +    }
>> +
>> +    csa = kmalloc_array(nr_cpusets(), sizeof(cp), GFP_KERNEL);
>> +    if (!csa)
>> +        goto done;
>> +    csn = 0;
>> +
>> +    rcu_read_lock();
>> +    if (root_load_balance)
>> +        csa[csn++] = &top_cpuset;
>> +    cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
>> +        if (cp == &top_cpuset)
>> +            continue;
>> +
>> +        /*
>> +         * v1:
> Remove this v1 line.

Will do.

>> +         * Continue traversing beyond @cp iff @cp has some CPUs and
>> +         * isn't load balancing.  The former is obvious.  The
>> +         * latter: All child cpusets contain a subset of the
>> +         * parent's cpus, so just skip them, and then we call
>> +         * update_domain_attr_tree() to calc relax_domain_level of
>> +         * the corresponding sched domain.
>> +         */
>> +        if (!cpumask_empty(cp->cpus_allowed) &&
>> +            !(is_sched_load_balance(cp) &&
>> +              cpumask_intersects(cp->cpus_allowed,
>> +                     housekeeping_cpumask(HK_TYPE_DOMAIN))))
>> +            continue;
>> +
>> +        if (is_sched_load_balance(cp) &&
>> +            !cpumask_empty(cp->effective_cpus))
>> +            csa[csn++] = cp;
>> +
>> +        /* skip @cp's subtree */
>> +        pos_css = css_rightmost_descendant(pos_css);
>> +        continue;
>> +    }
>> +    rcu_read_unlock();
>> +
>> +    /*
>> +     * If there are only isolated partitions underneath the cgroup root,
>> +     * we can optimize out unneeded sched domains scanning.
>> +     */
>> +    if (root_load_balance && (csn == 1))
>> +        goto single_root_domain;
> 
> This check is v2 specific and you can remove it as well as the "single_root_domain" label.
> 

Thank you.

Will remove.

Just a note — I removed this code for cpuset v2. Please confirm if that's acceptable. If we drop the
v1-specific logic, handling this case wouldn’t take much extra work.

-- 
Best regards,
Ridong


