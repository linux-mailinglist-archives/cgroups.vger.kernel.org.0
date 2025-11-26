Return-Path: <cgroups+bounces-12197-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3070DC87A26
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 02:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0883B58E5
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 01:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB202C190;
	Wed, 26 Nov 2025 01:01:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2658F3C1F;
	Wed, 26 Nov 2025 01:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764118884; cv=none; b=Ap5TijGnwxbum1cd4rNw2GxOyt1DuaEXtC5yAHGTlnqurTTYM22MYq6OWJPpmx9vl3zt1Ok8M5HKIO8P79h8gBjHrqSNNF6V3uQFBDP3U2cFz+VeEKMeQsPENtZP36AHYtv+PQ0uN1HGjeVL6wf9BFSnp25rlHMwhY+zBWIxPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764118884; c=relaxed/simple;
	bh=Rm2zmhpRt25dnkA7MjYVo3Cd8MqiTTXhaDDf+KLkxCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eBIxQHaS/8SDoF2QC5IqX7T/QYrGrIWt++Z9reSQwgsPj13Ncq8qEbXdwxg2VqEfRylIL/jvftm1cRn74adBcL84ocJitDHLE1HP776K2supChOF97+47NcNXDsAoVBl6mLiLWEwabK5ODG0IvTN/tlMzl/0FVYVrjTOnSv3ZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dGLnx5RzzzYQtnm;
	Wed, 26 Nov 2025 09:00:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D11C71A07BD;
	Wed, 26 Nov 2025 09:01:12 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgBXgF1XUSZpMyMgCA--.25134S2;
	Wed, 26 Nov 2025 09:01:12 +0800 (CST)
Message-ID: <0ecb1476-2886-430f-a698-cabbe9302129@huaweicloud.com>
Date: Wed, 26 Nov 2025 09:01:11 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 daniel.m.jordan@oracle.com, lujialin4@huawei.com, chenridong@huawei.com
References: <20251118083643.1363020-1-chenridong@huaweicloud.com>
 <27ed2c0b-7b00-4be0-a134-3c370cf85d8e@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <27ed2c0b-7b00-4be0-a134-3c370cf85d8e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXgF1XUSZpMyMgCA--.25134S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr48ZF43Kw1xJr4UGr18uFg_yoW7Gr1DpF
	1kKrW7XrW5Kr18C3yUJ347Xry8Kw4kJanrJrn8XF18ArW7AF1v9r1jqrn0grWUXrs3Wr1U
	Ar1UXrnrZF1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/26 2:16, Waiman Long wrote:
> On 11/18/25 3:36 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Commit 406100f3da08 ("cpuset: fix race between hotplug work and later CPU
>> offline")added a check for empty effective_cpus in partitions for cgroup
>> v2. However, thischeck did not account for remote partitions, which were
>> introduced later.
>>
>> After commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug processing
>> synchronous"),cgroup v2's cpuset hotplug handling is now synchronous. This
>> eliminates the race condition with subsequent CPU offline operations that
>> the original check aimed to fix.
> That is true. The original asynchronous cpuset_hotplug_workfn() is called after the hotplug
> operation finishes. So cpuset can be in a state where cpu_active_mask was updated, but not the
> effective cpumasks in cpuset.
>>
>> Instead of extending the check to support remote partitions, this patch
>> removes the redundant partition effective_cpus check. Additionally, it adds
>> a check and warningto verify that all generated sched domains consist of
> "warningto" => "warning to"

Thank you Longman,

will update.

>> active CPUs, preventing partition_sched_domains from being invoked with
>> offline CPUs.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 29 ++++++-----------------------
>>   1 file changed, 6 insertions(+), 23 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index daf813386260..1ac58e3f26b4 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1084,11 +1084,10 @@ void dl_rebuild_rd_accounting(void)
>>    */
>>   void rebuild_sched_domains_locked(void)
>>   {
>> -    struct cgroup_subsys_state *pos_css;
>>       struct sched_domain_attr *attr;
>>       cpumask_var_t *doms;
>> -    struct cpuset *cs;
>>       int ndoms;
>> +    int i;
>>         lockdep_assert_cpus_held();
>>       lockdep_assert_held(&cpuset_mutex);
> 
> In fact, the following code and the comments above in rebuild_sched_domains_locked() are also no
> longer relevant. So you may remove them as well.
> 
>         if (!top_cpuset.nr_subparts_cpus &&
>             !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>                 return;
> 

Thank you for reminding me.

I initially retained this code because I believed it was still required for cgroup v1, as I recalled
that synchronous operation is exclusive to cgroup v2.

However, upon re-examining the code, I confirm it can be safely removed. For cgroup v1,
rebuild_sched_domains_locked is called synchronously, and only the migration task (handled by
cpuset_migrate_tasks_workfn) operates asynchronously. Consequently, cpuset_hotplug_workfn is
guaranteed to complete before the hotplug workflow finishes.

>> @@ -1107,30 +1106,14 @@ void rebuild_sched_domains_locked(void)
>>           !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>>           return;
>>   -    /*
>> -     * With subpartition CPUs, however, the effective CPUs of a partition
>> -     * root should be only a subset of the active CPUs.  Since a CPU in any
>> -     * partition root could be offlined, all must be checked.
>> -     */
>> -    if (!cpumask_empty(subpartitions_cpus)) {
>> -        rcu_read_lock();
>> -        cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
>> -            if (!is_partition_valid(cs)) {
>> -                pos_css = css_rightmost_descendant(pos_css);
>> -                continue;
>> -            }
>> -            if (!cpumask_subset(cs->effective_cpus,
>> -                        cpu_active_mask)) {
>> -                rcu_read_unlock();
>> -                return;
>> -            }
>> -        }
>> -        rcu_read_unlock();
>> -    }
>> -
>>       /* Generate domain masks and attrs */
>>       ndoms = generate_sched_domains(&doms, &attr);
>>   +    for (i = 0; i < ndoms; ++i) {
>> +        if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
>> +            return;
>> +    }
>> +
> 
> If it is not clear about the purpose of the WARN_ON_ONCE() call, we should add a comment to explain
> that cpu_active_mask will not be out of sync with cpuset's effective cpumasks. So the warning should
> not be triggered.
> 

Will add.

> Cheers,
> Longman
> 
>>       /* Have scheduler rebuild the domains */
>>       partition_sched_domains(ndoms, doms, attr);
>>   }
> 

-- 
Best regards,
Ridong


