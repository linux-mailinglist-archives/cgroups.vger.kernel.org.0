Return-Path: <cgroups+bounces-12226-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B5C8C9F0
	for <lists+cgroups@lfdr.de>; Thu, 27 Nov 2025 02:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B902E4E1D18
	for <lists+cgroups@lfdr.de>; Thu, 27 Nov 2025 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E631B23C519;
	Thu, 27 Nov 2025 01:57:41 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392D239E88;
	Thu, 27 Nov 2025 01:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764208661; cv=none; b=EIElLqBBrxKXLxlRCYaZ5iK2cSkvYzJfK5ENPxPKFZk6A80stCS/L4TdqGICgsv8qmrWU7gDAUMCLP2WxbT0Toe5pkz6PXtxoLLLh6O0iHQd+iiv7LP9dmAfiWKQleh5m8V4+dm+DPFO+9MQ4SOg3N29lCwbOmftPDVf/2sDadE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764208661; c=relaxed/simple;
	bh=S6ib4nnk4AXQZ/AVvdcrunHT9R0symghRJHkUxJbcIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UD1WcrsEFvF1sOOt7QYCZp3jRkiQWpiN4UxKj6DeYzVFpk9jfK4RZwQlgEjH4dHm3gPymesEG23loy6zlSibEW41l+wP6SoJENsIwq7WUkCkM2eqoEi7Ypr19lVvSyVK5D02/iuZvwBTdtV0qaj2xeZVDDBAzZEZnB9SINocb28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dH00Q15mrzYQtjL;
	Thu, 27 Nov 2025 09:56:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id F1AAF1A0B3B;
	Thu, 27 Nov 2025 09:57:30 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgDHO1kKsCdpRGCYCA--.59044S2;
	Thu, 27 Nov 2025 09:57:30 +0800 (CST)
Message-ID: <362d011f-dfc8-44ed-ab6e-8b393dc04619@huaweicloud.com>
Date: Thu, 27 Nov 2025 09:57:30 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] cpuset: Remove unnecessary checks in
 rebuild_sched_domains_locked
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251126091158.1610673-1-chenridong@huaweicloud.com>
 <518ffa19-fcb2-4131-942d-02aa8328a815@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <518ffa19-fcb2-4131-942d-02aa8328a815@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHO1kKsCdpRGCYCA--.59044S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWfKFyrurW3Zw4fAryUtrb_yoWrKryrpF
	ykGrW7XrWUKr18C3yUJryUXryrtw4kJa1DJr1kXF18Ar47AF1jgr1jqr90gr1UZr48Wr18
	Ar1jqrnruF9xArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1aZX5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/27 3:47, Waiman Long wrote:
> On 11/26/25 4:11 AM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> Commit 406100f3da08 ("cpuset: fix race between hotplug work and later CPU
>> offline") added a check for empty effective_cpus in partitions for cgroup
>> v2. However, this check did not account for remote partitions, which were
>> introduced later.
>>
>> After commit 2125c0034c5d ("cgroup/cpuset: Make cpuset hotplug processing
>> synchronous"), cpuset hotplug handling is now synchronous. This eliminates
>> the race condition with subsequent CPU offline operations that the original
>> check aimed to fix.
>>
>> Instead of extending the check to support remote partitions, this patch
>> removes all the redundant effective_cpus check. Additionally, it adds a
>> check and warning to verify that all generated sched domains consist of
>> active CPUs, preventing partition_sched_domains from being invoked with
>> offline CPUs.
>>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 50 +++++++++++++-----------------------------
>>   1 file changed, 15 insertions(+), 35 deletions(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index 6e6eb09b8db6..fea577b4016a 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -1103,53 +1103,33 @@ void dl_rebuild_rd_accounting(void)
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
>>       force_sd_rebuild = false;
>>   -    /*
>> -     * If we have raced with CPU hotplug, return early to avoid
>> -     * passing doms with offlined cpu to partition_sched_domains().
>> -     * Anyways, cpuset_handle_hotplug() will rebuild sched domains.
>> -     *
>> -     * With no CPUs in any subpartitions, top_cpuset's effective CPUs
>> -     * should be the same as the active CPUs, so checking only top_cpuset
>> -     * is enough to detect racing CPU offlines.
>> -     */
>> -    if (cpumask_empty(subpartitions_cpus) &&
>> -        !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>> -        return;
>> +    /* Generate domain masks and attrs */
>> +    ndoms = generate_sched_domains(&doms, &attr);
>>         /*
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
>> +    * cpuset_hotplug_workfn is invoked synchronously now, thus this
>> +    * function should not race with CPU hotplug. And the effective CPUs
>> +    * must not include any offline CPUs. Passing an offline CPU in the
>> +    * doms to partition_sched_domains() will trigger a kernel panic.
>> +    *
>> +    * We perform a final check here: if the doms contains any
>> +    * offline CPUs, a warning is emitted and we return directly to
>> +    * prevent the panic.
>> +    */
>> +    for (i = 0; i < ndoms; ++i) {
>> +        if (WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)))
>> +            return;
>>       }
>>   -    /* Generate domain masks and attrs */
>> -    ndoms = generate_sched_domains(&doms, &attr);
>> -
>>       /* Have scheduler rebuild the domains */
>>       partition_sched_domains(ndoms, doms, attr);
>>   }
> Reviewed-by: Waiman Long <longman@redhat.com>
> 
> Thanks!
> 

Thanks.

-- 
Best regards,
Ridong


