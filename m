Return-Path: <cgroups+bounces-4598-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 324EA9654A8
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 03:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 863E8B2177D
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 01:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0FDFC11;
	Fri, 30 Aug 2024 01:24:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E04A2F;
	Fri, 30 Aug 2024 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981051; cv=none; b=DbFg0zl07XpZqi5/AnnPDHtKXc5sC1guV5SRDijbrfFZjZOBjTmgMEkj7tztY2CQlyWHIEyVhDZJmMT5Y7FhcuRpl+m1f6pwVhL65rInEcJ/fqJC1R8elhUHlbvgAYOIoz1jmhnEyYJG5YyFBXisQNxBxMSHJWcQLZJNENAQR4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981051; c=relaxed/simple;
	bh=29kRJKo/lR/9SlgT9IHc1DxunpKsINW2XYVxZ3Kx8MA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtxMK8QCzwcbMC8cL7wBwbPtXZts1wmgKCN6tuBvZ6liz03/2kHXYXmnM/enCousmQjCCuc4G+gndlNf8WfIKzh4pSdGT1Kj+RtPTDR5DbtAJkxFLaLPy6mQMHH3EP5W2rRKhf+xfnRfTFNI7EyoUr8zeqDBtax8e0QitwpCc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Ww0m5377Qz4f3l22;
	Fri, 30 Aug 2024 09:23:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id E84CE1A058E;
	Fri, 30 Aug 2024 09:24:04 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgCHNbQzH9Fm7Mb9Cw--.39198S2;
	Fri, 30 Aug 2024 09:24:04 +0800 (CST)
Message-ID: <54cdfc51-0c93-4ed4-b20a-41dff2cea9b4@huaweicloud.com>
Date: Fri, 30 Aug 2024 09:24:03 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next 10/12] cgroup/cpuset: rename functions shared
 between v1 and v2
To: Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huawei.com>,
 tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
 adityakali@google.com, sergeh@kernel.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240827062111.580296-1-chenridong@huawei.com>
 <20240827062111.580296-11-chenridong@huawei.com>
 <e2f03a4c-0a86-42b4-b760-60d3164181e7@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <e2f03a4c-0a86-42b4-b760-60d3164181e7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHNbQzH9Fm7Mb9Cw--.39198S2
X-Coremail-Antispam: 1UD129KBjvAXoWfCrW5ArWxKw1UZw4rCw1DAwb_yoW5GF1rXo
	W3KF4rJr1rX3WDKrWDJr15Ary5Xw1DKrnrtw1jqrnxXr18Ar17Ja47JrWjq3yrXr18Kr4U
	JF1UJr10yFW2kF18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYz7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/8/29 22:04, Waiman Long wrote:
> 
> On 8/27/24 02:21, Chen Ridong wrote:
>> Some functions name declared in cpuset-internel.h are generic. To avoid
>> confilicting with other variables for the same name, rename these
>> functions with cpuset_/cpuset1_ prefix to make them unique to cpuset.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset-internal.h | 22 +++++-----
>>   kernel/cgroup/cpuset-v1.c       | 44 ++++++++++----------
>>   kernel/cgroup/cpuset.c          | 72 ++++++++++++++++-----------------
>>   3 files changed, 69 insertions(+), 69 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset-internal.h 
>> b/kernel/cgroup/cpuset-internal.h
>> index a6c71c86e58d..683fcf8bc743 100644
>> --- a/kernel/cgroup/cpuset-internal.h
>> +++ b/kernel/cgroup/cpuset-internal.h
>> @@ -266,12 +266,12 @@ static inline int is_spread_slab(const struct 
>> cpuset *cs)
>>       css_for_each_descendant_pre((pos_css), &(root_cs)->css)        \
>>           if (is_cpuset_online(((des_cs) = css_cs((pos_css)))))
>> -void rebuild_sched_domains_locked(void);
>> -void callback_lock_irq(void);
>> -void callback_unlock_irq(void);
>> -void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus);
>> -void update_tasks_nodemask(struct cpuset *cs);
>> -int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int 
>> turning_on);
>> +void cpuset_rebuild_sched_domains_locked(void);
> There is already a "rebuild_sched_domain()" function that is externally 
> visible and the name is pretty unique. I don't think we need to add the 
> "cpuset_" prefix for consistency.
>> +void cpuset_callback_lock_irq(void);
>> +void cpuset_callback_unlock_irq(void);
>> +void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask 
>> *new_cpus);
>> +void cpuset_update_tasks_nodemask(struct cpuset *cs);
>> +int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int 
>> turning_on);
>>   ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>>                       char *buf, size_t nbytes, loff_t off);
>>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
>> @@ -280,13 +280,13 @@ int cpuset_common_seq_show(struct seq_file *sf, 
>> void *v);
>>    * cpuset-v1.c
>>    */
>>   extern struct cftype legacy_files[];
>> -void fmeter_init(struct fmeter *fmp);
>> -void cpuset_update_task_spread_flags(struct cpuset *cs,
>> +void cpuset1_fmeter_init(struct fmeter *fmp);
> 
> Similarly, there are other fmeter_* functions available and fmeter is a 
> unique prefix. The cpuset_ prefix shouldn't be needed.
> 
> OTOH, the legacy_files should be changed to cpuset1_files.
> 
> Other than that, the rest of the series looks good to me.
> 
> Cheers,
> Longman
> 
Thank you, I will update later.

Best regards,
Ridong

>> +void cpuset1_update_task_spread_flags(struct cpuset *cs,
>>                       struct task_struct *tsk);
>> -void update_tasks_flags(struct cpuset *cs);
>> -void hotplug_update_tasks_legacy(struct cpuset *cs,
>> +void cpuset1_update_tasks_flags(struct cpuset *cs);
>> +void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>                   struct cpumask *new_cpus, nodemask_t *new_mems,
>>                   bool cpus_updated, bool mems_updated);
>> -int validate_change_legacy(struct cpuset *cur, struct cpuset *trial);
>> +int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial);
>>   #endif /* __CPUSET_INTERNAL_H */
>> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
>> index 0ccc440c468a..ab10852b4a76 100644
>> --- a/kernel/cgroup/cpuset-v1.c
>> +++ b/kernel/cgroup/cpuset-v1.c
>> @@ -15,7 +15,7 @@ struct cpuset_remove_tasks_struct {
>>    *
>>    * These routines manage a digitally filtered, constant time based,
>>    * event frequency meter.  There are four routines:
>> - *   fmeter_init() - initialize a frequency meter.
>> + *   cpuset1_fmeter_init() - initialize a frequency meter.
>>    *   fmeter_markevent() - called each time the event happens.
>>    *   fmeter_getrate() - returns the recent rate of such events.
>>    *   fmeter_update() - internal routine used to update fmeter.
>> @@ -61,7 +61,7 @@ struct cpuset_remove_tasks_struct {
>>   #define FM_SCALE 1000        /* faux fixed point scale */
>>   /* Initialize a frequency meter */
>> -void fmeter_init(struct fmeter *fmp)
>> +void cpuset1_fmeter_init(struct fmeter *fmp)
>>   {
>>       fmp->cnt = 0;
>>       fmp->val = 0;
>> @@ -155,7 +155,7 @@ static int update_relax_domain_level(struct cpuset 
>> *cs, s64 val)
>>           cs->relax_domain_level = val;
>>           if (!cpumask_empty(cs->cpus_allowed) &&
>>               is_sched_load_balance(cs))
>> -            rebuild_sched_domains_locked();
>> +            cpuset_rebuild_sched_domains_locked();
>>       }
>>       return 0;
>> @@ -209,7 +209,7 @@ static s64 cpuset_read_s64(struct 
>> cgroup_subsys_state *css, struct cftype *cft)
>>    * Call with callback_lock or cpuset_mutex held. The check can be 
>> skipped
>>    * if on default hierarchy.
>>    */
>> -void cpuset_update_task_spread_flags(struct cpuset *cs,
>> +void cpuset1_update_task_spread_flags(struct cpuset *cs,
>>                       struct task_struct *tsk)
>>   {
>>       if (cgroup_subsys_on_dfl(cpuset_cgrp_subsys))
>> @@ -227,21 +227,21 @@ void cpuset_update_task_spread_flags(struct 
>> cpuset *cs,
>>   }
>>   /**
>> - * update_tasks_flags - update the spread flags of tasks in the cpuset.
>> + * cpuset1_update_tasks_flags - update the spread flags of tasks in 
>> the cpuset.
>>    * @cs: the cpuset in which each task's spread flags needs to be 
>> changed
>>    *
>>    * Iterate through each task of @cs updating its spread flags.  As this
>>    * function is called with cpuset_mutex held, cpuset membership stays
>>    * stable.
>>    */
>> -void update_tasks_flags(struct cpuset *cs)
>> +void cpuset1_update_tasks_flags(struct cpuset *cs)
>>   {
>>       struct css_task_iter it;
>>       struct task_struct *task;
>>       css_task_iter_start(&cs->css, 0, &it);
>>       while ((task = css_task_iter_next(&it)))
>> -        cpuset_update_task_spread_flags(cs, task);
>> +        cpuset1_update_task_spread_flags(cs, task);
>>       css_task_iter_end(&it);
>>   }
>> @@ -282,27 +282,27 @@ static void cpuset_migrate_tasks_workfn(struct 
>> work_struct *work)
>>       kfree(s);
>>   }
>> -void hotplug_update_tasks_legacy(struct cpuset *cs,
>> +void cpuset1_hotplug_update_tasks(struct cpuset *cs,
>>                   struct cpumask *new_cpus, nodemask_t *new_mems,
>>                   bool cpus_updated, bool mems_updated)
>>   {
>>       bool is_empty;
>> -    callback_lock_irq();
>> +    cpuset_callback_lock_irq();
>>       cpumask_copy(cs->cpus_allowed, new_cpus);
>>       cpumask_copy(cs->effective_cpus, new_cpus);
>>       cs->mems_allowed = *new_mems;
>>       cs->effective_mems = *new_mems;
>> -    callback_unlock_irq();
>> +    cpuset_callback_unlock_irq();
>>       /*
>> -     * Don't call update_tasks_cpumask() if the cpuset becomes empty,
>> +     * Don't call cpuset_update_tasks_cpumask() if the cpuset becomes 
>> empty,
>>        * as the tasks will be migrated to an ancestor.
>>        */
>>       if (cpus_updated && !cpumask_empty(cs->cpus_allowed))
>> -        update_tasks_cpumask(cs, new_cpus);
>> +        cpuset_update_tasks_cpumask(cs, new_cpus);
>>       if (mems_updated && !nodes_empty(cs->mems_allowed))
>> -        update_tasks_nodemask(cs);
>> +        cpuset_update_tasks_nodemask(cs);
>>       is_empty = cpumask_empty(cs->cpus_allowed) ||
>>              nodes_empty(cs->mems_allowed);
>> @@ -345,10 +345,10 @@ static int is_cpuset_subset(const struct cpuset 
>> *p, const struct cpuset *q)
>>   }
>>   /*
>> - * validate_change_legacy() - Validate conditions specific to legacy 
>> (v1)
>> + * cpuset1_validate_change() - Validate conditions specific to legacy 
>> (v1)
>>    *                            behavior.
>>    */
>> -int validate_change_legacy(struct cpuset *cur, struct cpuset *trial)
>> +int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
>>   {
>>       struct cgroup_subsys_state *css;
>>       struct cpuset *c, *par;
>> @@ -421,28 +421,28 @@ static int cpuset_write_u64(struct 
>> cgroup_subsys_state *css, struct cftype *cft,
>>       switch (type) {
>>       case FILE_CPU_EXCLUSIVE:
>> -        retval = update_flag(CS_CPU_EXCLUSIVE, cs, val);
>> +        retval = cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, val);
>>           break;
>>       case FILE_MEM_EXCLUSIVE:
>> -        retval = update_flag(CS_MEM_EXCLUSIVE, cs, val);
>> +        retval = cpuset_update_flag(CS_MEM_EXCLUSIVE, cs, val);
>>           break;
>>       case FILE_MEM_HARDWALL:
>> -        retval = update_flag(CS_MEM_HARDWALL, cs, val);
>> +        retval = cpuset_update_flag(CS_MEM_HARDWALL, cs, val);
>>           break;
>>       case FILE_SCHED_LOAD_BALANCE:
>> -        retval = update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>> +        retval = cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, val);
>>           break;
>>       case FILE_MEMORY_MIGRATE:
>> -        retval = update_flag(CS_MEMORY_MIGRATE, cs, val);
>> +        retval = cpuset_update_flag(CS_MEMORY_MIGRATE, cs, val);
>>           break;
>>       case FILE_MEMORY_PRESSURE_ENABLED:
>>           cpuset_memory_pressure_enabled = !!val;
>>           break;
>>       case FILE_SPREAD_PAGE:
>> -        retval = update_flag(CS_SPREAD_PAGE, cs, val);
>> +        retval = cpuset_update_flag(CS_SPREAD_PAGE, cs, val);
>>           break;
>>       case FILE_SPREAD_SLAB:
>> -        retval = update_flag(CS_SPREAD_SLAB, cs, val);
>> +        retval = cpuset_update_flag(CS_SPREAD_SLAB, cs, val);
>>           break;
>>       default:
>>           retval = -EINVAL;
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 2f52fe488f3a..f215311eab62 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -233,12 +233,12 @@ void cpuset_unlock(void)
>>   static DEFINE_SPINLOCK(callback_lock);
>> -void callback_lock_irq(void)
>> +void cpuset_callback_lock_irq(void)
>>   {
>>       spin_lock_irq(&callback_lock);
>>   }
>> -void callback_unlock_irq(void)
>> +void cpuset_callback_unlock_irq(void)
>>   {
>>       spin_unlock_irq(&callback_lock);
>>   }
>> @@ -534,7 +534,7 @@ static int validate_change(struct cpuset *cur, 
>> struct cpuset *trial)
>>       rcu_read_lock();
>>       if (!is_in_v2_mode())
>> -        ret = validate_change_legacy(cur, trial);
>> +        ret = cpuset1_validate_change(cur, trial);
>>       if (ret)
>>           goto out;
>> @@ -975,7 +975,7 @@ partition_and_rebuild_sched_domains(int ndoms_new, 
>> cpumask_var_t doms_new[],
>>    *
>>    * Call with cpuset_mutex held.  Takes cpus_read_lock().
>>    */
>> -void rebuild_sched_domains_locked(void)
>> +void cpuset_rebuild_sched_domains_locked(void)
>>   {
>>       struct cgroup_subsys_state *pos_css;
>>       struct sched_domain_attr *attr;
>> @@ -1027,7 +1027,7 @@ void rebuild_sched_domains_locked(void)
>>       partition_and_rebuild_sched_domains(ndoms, doms, attr);
>>   }
>>   #else /* !CONFIG_SMP */
>> -void rebuild_sched_domains_locked(void)
>> +void cpuset_rebuild_sched_domains_locked(void)
>>   {
>>   }
>>   #endif /* CONFIG_SMP */
>> @@ -1035,7 +1035,7 @@ void rebuild_sched_domains_locked(void)
>>   static void rebuild_sched_domains_cpuslocked(void)
>>   {
>>       mutex_lock(&cpuset_mutex);
>> -    rebuild_sched_domains_locked();
>> +    cpuset_rebuild_sched_domains_locked();
>>       mutex_unlock(&cpuset_mutex);
>>   }
>> @@ -1047,7 +1047,7 @@ void rebuild_sched_domains(void)
>>   }
>>   /**
>> - * update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
>> + * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the 
>> cpuset.
>>    * @cs: the cpuset in which each task's cpus_allowed mask needs to 
>> be changed
>>    * @new_cpus: the temp variable for the new effective_cpus mask
>>    *
>> @@ -1057,7 +1057,7 @@ void rebuild_sched_domains(void)
>>    * is used instead of effective_cpus to make sure all offline CPUs 
>> are also
>>    * included as hotplug code won't update cpumasks for tasks in 
>> top_cpuset.
>>    */
>> -void update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
>> +void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask 
>> *new_cpus)
>>   {
>>       struct css_task_iter it;
>>       struct task_struct *task;
>> @@ -1120,11 +1120,11 @@ static int update_partition_exclusive(struct 
>> cpuset *cs, int new_prs)
>>       bool exclusive = (new_prs > PRS_MEMBER);
>>       if (exclusive && !is_cpu_exclusive(cs)) {
>> -        if (update_flag(CS_CPU_EXCLUSIVE, cs, 1))
>> +        if (cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, 1))
>>               return PERR_NOTEXCL;
>>       } else if (!exclusive && is_cpu_exclusive(cs)) {
>>           /* Turning off CS_CPU_EXCLUSIVE will not return error */
>> -        update_flag(CS_CPU_EXCLUSIVE, cs, 0);
>> +        cpuset_update_flag(CS_CPU_EXCLUSIVE, cs, 0);
>>       }
>>       return 0;
>>   }
>> @@ -1133,7 +1133,7 @@ static int update_partition_exclusive(struct 
>> cpuset *cs, int new_prs)
>>    * Update partition load balance flag and/or rebuild sched domain
>>    *
>>    * Changing load balance flag will automatically call
>> - * rebuild_sched_domains_locked().
>> + * cpuset_rebuild_sched_domains_locked().
>>    * This function is for cgroup v2 only.
>>    */
>>   static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
>> @@ -1160,7 +1160,7 @@ static void update_partition_sd_lb(struct cpuset 
>> *cs, int old_prs)
>>       }
>>       if (rebuild_domains && !force_sd_rebuild)
>> -        rebuild_sched_domains_locked();
>> +        cpuset_rebuild_sched_domains_locked();
>>   }
>>   /*
>> @@ -1374,7 +1374,7 @@ static int remote_partition_enable(struct cpuset 
>> *cs, int new_prs,
>>       /*
>>        * Proprogate changes in top_cpuset's effective_cpus down the 
>> hierarchy.
>>        */
>> -    update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>> +    cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>>       update_sibling_cpumasks(&top_cpuset, NULL, tmp);
>>       return 0;
>>   }
>> @@ -1410,7 +1410,7 @@ static void remote_partition_disable(struct 
>> cpuset *cs, struct tmpmasks *tmp)
>>       /*
>>        * Proprogate changes in top_cpuset's effective_cpus down the 
>> hierarchy.
>>        */
>> -    update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>> +    cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>>       update_sibling_cpumasks(&top_cpuset, NULL, tmp);
>>   }
>> @@ -1462,7 +1462,7 @@ static void remote_cpus_update(struct cpuset 
>> *cs, struct cpumask *newmask,
>>       /*
>>        * Proprogate changes in top_cpuset's effective_cpus down the 
>> hierarchy.
>>        */
>> -    update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>> +    cpuset_update_tasks_cpumask(&top_cpuset, tmp->new_cpus);
>>       update_sibling_cpumasks(&top_cpuset, NULL, tmp);
>>       return;
>> @@ -1508,7 +1508,7 @@ static void remote_partition_check(struct cpuset 
>> *cs, struct cpumask *newmask,
>>               disable_cnt++;
>>           }
>>       if (disable_cnt && !force_sd_rebuild)
>> -        rebuild_sched_domains_locked();
>> +        cpuset_rebuild_sched_domains_locked();
>>   }
>>   /*
>> @@ -1834,7 +1834,7 @@ static int 
>> update_parent_effective_cpumask(struct cpuset *cs, int cmd,
>>           update_partition_exclusive(cs, new_prs);
>>       if (adding || deleting) {
>> -        update_tasks_cpumask(parent, tmp->addmask);
>> +        cpuset_update_tasks_cpumask(parent, tmp->addmask);
>>           update_sibling_cpumasks(parent, cs, tmp);
>>       }
>> @@ -2017,7 +2017,7 @@ static void update_cpumasks_hier(struct cpuset 
>> *cs, struct tmpmasks *tmp,
>>           /*
>>            * update_parent_effective_cpumask() should have been called
>>            * for cs already in update_cpumask(). We should also call
>> -         * update_tasks_cpumask() again for tasks in the parent
>> +         * cpuset_update_tasks_cpumask() again for tasks in the parent
>>            * cpuset if the parent's effective_cpus changes.
>>            */
>>           if ((cp != cs) && old_prs) {
>> @@ -2074,7 +2074,7 @@ static void update_cpumasks_hier(struct cpuset 
>> *cs, struct tmpmasks *tmp,
>>           WARN_ON(!is_in_v2_mode() &&
>>               !cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
>> -        update_tasks_cpumask(cp, cp->effective_cpus);
>> +        cpuset_update_tasks_cpumask(cp, cp->effective_cpus);
>>           /*
>>            * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
>> @@ -2109,7 +2109,7 @@ static void update_cpumasks_hier(struct cpuset 
>> *cs, struct tmpmasks *tmp,
>>       if (need_rebuild_sched_domains && !(flags & HIER_NO_SD_REBUILD) &&
>>           !force_sd_rebuild)
>> -        rebuild_sched_domains_locked();
>> +        cpuset_rebuild_sched_domains_locked();
>>   }
>>   /**
>> @@ -2501,14 +2501,14 @@ static void cpuset_change_task_nodemask(struct 
>> task_struct *tsk,
>>   static void *cpuset_being_rebound;
>>   /**
>> - * update_tasks_nodemask - Update the nodemasks of tasks in the cpuset.
>> + * cpuset_update_tasks_nodemask - Update the nodemasks of tasks in 
>> the cpuset.
>>    * @cs: the cpuset in which each task's mems_allowed mask needs to 
>> be changed
>>    *
>>    * Iterate through each task of @cs updating its mems_allowed to the
>>    * effective cpuset's.  As this function is called with cpuset_mutex 
>> held,
>>    * cpuset membership stays stable.
>>    */
>> -void update_tasks_nodemask(struct cpuset *cs)
>> +void cpuset_update_tasks_nodemask(struct cpuset *cs)
>>   {
>>       static nodemask_t newmems;    /* protected by cpuset_mutex */
>>       struct css_task_iter it;
>> @@ -2606,7 +2606,7 @@ static void update_nodemasks_hier(struct cpuset 
>> *cs, nodemask_t *new_mems)
>>           WARN_ON(!is_in_v2_mode() &&
>>               !nodes_equal(cp->mems_allowed, cp->effective_mems));
>> -        update_tasks_nodemask(cp);
>> +        cpuset_update_tasks_nodemask(cp);
>>           rcu_read_lock();
>>           css_put(&cp->css);
>> @@ -2693,7 +2693,7 @@ bool current_cpuset_is_being_rebound(void)
>>   }
>>   /*
>> - * update_flag - read a 0 or a 1 in a file and update associated flag
>> + * cpuset_update_flag - read a 0 or a 1 in a file and update 
>> associated flag
>>    * bit:        the bit to update (see cpuset_flagbits_t)
>>    * cs:        the cpuset to update
>>    * turning_on:     whether the flag is being set or cleared
>> @@ -2701,7 +2701,7 @@ bool current_cpuset_is_being_rebound(void)
>>    * Call with cpuset_mutex held.
>>    */
>> -int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
>> +int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
>>                  int turning_on)
>>   {
>>       struct cpuset *trialcs;
>> @@ -2734,10 +2734,10 @@ int update_flag(cpuset_flagbits_t bit, struct 
>> cpuset *cs,
>>       if (!cpumask_empty(trialcs->cpus_allowed) && 
>> balance_flag_changed &&
>>           !force_sd_rebuild)
>> -        rebuild_sched_domains_locked();
>> +        cpuset_rebuild_sched_domains_locked();
>>       if (spread_flag_changed)
>> -        update_tasks_flags(cs);
>> +        cpuset1_update_tasks_flags(cs);
>>   out:
>>       free_cpuset(trialcs);
>>       return err;
>> @@ -3002,7 +3002,7 @@ static void cpuset_attach_task(struct cpuset 
>> *cs, struct task_struct *task)
>>       WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>>       cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
>> -    cpuset_update_task_spread_flags(cs, task);
>> +    cpuset1_update_task_spread_flags(cs, task);
>>   }
>>   static void cpuset_attach(struct cgroup_taskset *tset)
>> @@ -3373,7 +3373,7 @@ cpuset_css_alloc(struct cgroup_subsys_state 
>> *parent_css)
>>       }
>>       __set_bit(CS_SCHED_LOAD_BALANCE, &cs->flags);
>> -    fmeter_init(&cs->fmeter);
>> +    cpuset1_fmeter_init(&cs->fmeter);
>>       cs->relax_domain_level = -1;
>>       INIT_LIST_HEAD(&cs->remote_sibling);
>> @@ -3458,7 +3458,7 @@ static int cpuset_css_online(struct 
>> cgroup_subsys_state *css)
>>   /*
>>    * If the cpuset being removed has its flag 'sched_load_balance'
>>    * enabled, then simulate turning sched_load_balance off, which
>> - * will call rebuild_sched_domains_locked(). That is not needed
>> + * will call cpuset_rebuild_sched_domains_locked(). That is not needed
>>    * in the default hierarchy where only changes in partition
>>    * will cause repartitioning.
>>    *
>> @@ -3478,7 +3478,7 @@ static void cpuset_css_offline(struct 
>> cgroup_subsys_state *css)
>>       if (!cgroup_subsys_on_dfl(cpuset_cgrp_subsys) &&
>>           is_sched_load_balance(cs))
>> -        update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
>> +        cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
>>       cpuset_dec();
>>       clear_bit(CS_ONLINE, &cs->flags);
>> @@ -3645,7 +3645,7 @@ int __init cpuset_init(void)
>>       cpumask_setall(top_cpuset.exclusive_cpus);
>>       nodes_setall(top_cpuset.effective_mems);
>> -    fmeter_init(&top_cpuset.fmeter);
>> +    cpuset1_fmeter_init(&top_cpuset.fmeter);
>>       INIT_LIST_HEAD(&remote_children);
>>       BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
>> @@ -3670,9 +3670,9 @@ hotplug_update_tasks(struct cpuset *cs,
>>       spin_unlock_irq(&callback_lock);
>>       if (cpus_updated)
>> -        update_tasks_cpumask(cs, new_cpus);
>> +        cpuset_update_tasks_cpumask(cs, new_cpus);
>>       if (mems_updated)
>> -        update_tasks_nodemask(cs);
>> +        cpuset_update_tasks_nodemask(cs);
>>   }
>>   void cpuset_force_rebuild(void)
>> @@ -3773,7 +3773,7 @@ static void cpuset_hotplug_update_tasks(struct 
>> cpuset *cs, struct tmpmasks *tmp)
>>           hotplug_update_tasks(cs, &new_cpus, &new_mems,
>>                        cpus_updated, mems_updated);
>>       else
>> -        hotplug_update_tasks_legacy(cs, &new_cpus, &new_mems,
>> +        cpuset1_hotplug_update_tasks(cs, &new_cpus, &new_mems,
>>                           cpus_updated, mems_updated);
>>   unlock:
>> @@ -3858,7 +3858,7 @@ static void cpuset_handle_hotplug(void)
>>               top_cpuset.mems_allowed = new_mems;
>>           top_cpuset.effective_mems = new_mems;
>>           spin_unlock_irq(&callback_lock);
>> -        update_tasks_nodemask(&top_cpuset);
>> +        cpuset_update_tasks_nodemask(&top_cpuset);
>>       }
>>       mutex_unlock(&cpuset_mutex);
> 


