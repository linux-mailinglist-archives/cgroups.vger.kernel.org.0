Return-Path: <cgroups+bounces-12205-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E89C87EA6
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 04:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CF1C4E05AD
	for <lists+cgroups@lfdr.de>; Wed, 26 Nov 2025 03:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B79309EFA;
	Wed, 26 Nov 2025 03:17:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0E1A9F9F;
	Wed, 26 Nov 2025 03:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127042; cv=none; b=Cp2p2qHvRdNJ4qdDjzYxRh/oYPYu7b8F3Kub//yNgH7V7X3GzveAgMtPYrIpXphpyryeMjCreRdTEalRulwFEfvwYf2v0xldCjHK22L72aWxkLtQUa6UT5XacZzybYc8gPYMf8hTXC2gZXaNBgVSNzUyiag87gwsUV3Lm9Y/4yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127042; c=relaxed/simple;
	bh=PmU2sMRmDxo4tQm5TlRrSYeD2BI/8sKWIUHetouC7F0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDByznRFpE7EfG++3ccldipipgU6ri+1XleuHZndp8ou6biLY6uogQWi3NWlFFSohbfMcImqytTz9W+3wcY70waXuXwSjjLB06nRUlj3cV0/hMwKi2zkX5f3ZJ8hkMAeBflZzLHWLFYSLo5BGPt1E2cMJZuWzlGz2xRNoAVJvNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dGPqB4c80zKHMQD;
	Wed, 26 Nov 2025 11:16:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C95011A0A33;
	Wed, 26 Nov 2025 11:17:16 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgC3Klg7cSZp2ggrCA--.32712S2;
	Wed, 26 Nov 2025 11:17:16 +0800 (CST)
Message-ID: <d1c656bd-6d81-4f8b-96ab-41ace3509feb@huaweicloud.com>
Date: Wed, 26 Nov 2025 11:17:15 +0800
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
 <0ecb1476-2886-430f-a698-cabbe9302129@huaweicloud.com>
 <eaedf7d3-31dd-448b-9b00-60542e54260e@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <eaedf7d3-31dd-448b-9b00-60542e54260e@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3Klg7cSZp2ggrCA--.32712S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW8KryrCr17ZF1fGF4UJwb_yoW5CF1rpF
	95tFW7ArW5Kr18C34jv3yjqryFgw4kJa17J3Z8GF1rArsrAF1vvF1jgF4Y9ryUXrWfGr4U
	Ar1agay3uFyDArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/11/26 10:33, Waiman Long wrote:
> 
> On 11/25/25 8:01 PM, Chen Ridong wrote:
>>
>> On 2025/11/26 2:16, Waiman Long wrote:
>>>> active CPUs, preventing partition_sched_domains from being invoked with
>>>> offline CPUs.
>>>>
>>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>>> ---
>>>>    kernel/cgroup/cpuset.c | 29 ++++++-----------------------
>>>>    1 file changed, 6 insertions(+), 23 deletions(-)
>>>>
>>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>>> index daf813386260..1ac58e3f26b4 100644
>>>> --- a/kernel/cgroup/cpuset.c
>>>> +++ b/kernel/cgroup/cpuset.c
>>>> @@ -1084,11 +1084,10 @@ void dl_rebuild_rd_accounting(void)
>>>>     */
>>>>    void rebuild_sched_domains_locked(void)
>>>>    {
>>>> -    struct cgroup_subsys_state *pos_css;
>>>>        struct sched_domain_attr *attr;
>>>>        cpumask_var_t *doms;
>>>> -    struct cpuset *cs;
>>>>        int ndoms;
>>>> +    int i;
>>>>          lockdep_assert_cpus_held();
>>>>        lockdep_assert_held(&cpuset_mutex);
>>> In fact, the following code and the comments above in rebuild_sched_domains_locked() are also no
>>> longer relevant. So you may remove them as well.
>>>
>>>          if (!top_cpuset.nr_subparts_cpus &&
>>>              !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
>>>                  return;
>>>
>> Thank you for reminding me.
>>
>> I initially retained this code because I believed it was still required for cgroup v1, as I recalled
>> that synchronous operation is exclusive to cgroup v2.
>>
>> However, upon re-examining the code, I confirm it can be safely removed. For cgroup v1,
>> rebuild_sched_domains_locked is called synchronously, and only the migration task (handled by
>> cpuset_migrate_tasks_workfn) operates asynchronously. Consequently, cpuset_hotplug_workfn is
>> guaranteed to complete before the hotplug workflow finishes.
> 
> Yes, v1 still have a task migration part that is done asynchronously because of the lock ordering
> issue. Even if this code has to be left because of v1, you should still update the comment to
> reflect that. Please try to keep the comment updated to help others to have a better understanding
> of what the code is doing.
> 
> Thanks,
> Longman
> 

Hi Longman,

Just to confirm (in case I misunderstood): I believe it is safe to remove the check on
top_cpuset.effective_cpus (for both cgroup v1 and v2). I will proceed to remove both the
corresponding code and its associated comment(not update the comment).

          if (!top_cpuset.nr_subparts_cpus &&
              !cpumask_equal(top_cpuset.effective_cpus, cpu_active_mask))
                  return;

Additionally, I should add a comment to clarify the rationale for introducing the
WARN_ON_ONCE(!cpumask_subset(doms[i], cpu_active_mask)) warning.

Does this approach look good to you? Please let me know if I’ve missed anything or if further
adjustments are needed.

-- 
Best regards,
Ridong


