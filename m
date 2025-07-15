Return-Path: <cgroups+bounces-8737-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74231B04DD7
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 04:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D7A3A646C
	for <lists+cgroups@lfdr.de>; Tue, 15 Jul 2025 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6724E019;
	Tue, 15 Jul 2025 02:31:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836AD2E3703;
	Tue, 15 Jul 2025 02:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752546673; cv=none; b=gChGCaSWhaItYdgXmuTCFVn/GvehyrMqMg2bD2Fbzs6PlDSSnXFkD7kB0I+dQzk4PIQOFqP1wjao1FnY8n9SJ9f3uD/jEEcCvAl6bH9rO6Qk9yBZXVDnloEo6Os0LgSz9nca9bKdX0VGok0e4FQcY+KpuQrvqneFp4zYq8doFuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752546673; c=relaxed/simple;
	bh=GxIv2V8JoPMVQEEkfpu6r+ystxkjYjq1B9i/XhKf2Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyxfLVi2P9Q+F7mmxYUWR7VRrM3BB4IamXPYj4HwDSLANqU3wg3SqyJc+0WevEo/8+3SR9h2ozNdmfGoGGt2G6rsBXrE8wyybF6zYH/5IrpbF7spcaTtUDw6BvtA/o0USw5WVkZD7LyHuQ/a/sUeDzkI4rWHAovMCkJERO67NJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4bh38X4cWSzYQvFx;
	Tue, 15 Jul 2025 10:31:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 677171A0847;
	Tue, 15 Jul 2025 10:31:07 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgC3dbdqvXVoYzI0AQ--.36790S2;
	Tue, 15 Jul 2025 10:31:07 +0800 (CST)
Message-ID: <4afb9640-a61f-4807-a211-5d2a3cfbdda9@huaweicloud.com>
Date: Tue, 15 Jul 2025 10:31:06 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: fix warning when attaching tasks with
 offline CPUs
To: Waiman Long <llong@redhat.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com, peterz@infradead.org
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250714032311.3570157-1-chenridong@huaweicloud.com>
 <0dac8a78-79d1-41d0-bc82-0c8af8db9104@redhat.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <0dac8a78-79d1-41d0-bc82-0c8af8db9104@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3dbdqvXVoYzI0AQ--.36790S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyDJrW3Jr1fJr13Wr4UArb_yoW7Wr18pF
	yktFyUJ3y5XF18Gw47J34DXry0gw4kG3WDJFn5Ga4rJF47GF1jvr4UXrn0gry5Jr48Gr1U
	Jr1DXr42vFnrJ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/15 3:46, Waiman Long wrote:
> On 7/13/25 11:23 PM, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A kernel warning was observed in the cpuset migration path:
>>
>>      WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
>>      cgroup_migrate_execute+0x8df/0xf30
>>      Call Trace:
>>       cgroup_transfer_tasks+0x2f3/0x3b0
>>       cpuset_migrate_tasks_workfn+0x146/0x3b0
>>       process_one_work+0x5ba/0xda0
>>       worker_thread+0x788/0x1220
>>
>> The issue can be reliably reproduced with:
>>
>>      # Setup test cpuset
>>      mkdir /sys/fs/cgroup/cpuset/test
>>      echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>>      echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
>>
>>      # Start test process
>>      sleep 100 &
>>      pid=$!
>>      echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
>>      taskset -p 0xC $pid  # Bind to CPUs 2-3
>>
>>      # Take CPUs offline
>>      echo 0 > /sys/devices/system/cpu/cpu3/online
>>      echo 0 > /sys/devices/system/cpu/cpu2/online
>>
>> Root cause analysis:
>> When tasks are migrated to top_cpuset due to CPUs going offline,
>> cpuset_attach_task() sets the CPU affinity using cpus_attach which
>> is initialized from cpu_possible_mask. This mask may include offline
>> CPUs. When __set_cpus_allowed_ptr() computes the intersection between:
>> 1. cpus_attach (possible CPUs, may include offline)
>> 2. p->user_cpus_ptr (original user-set mask)
>> The resulting new_mask may contain only offline CPUs, causing the
>> operation to fail.
>>
>> The fix changes cpus_attach initialization to use cpu_active_mask
>> instead of cpu_possible_mask, ensuring we only consider online CPUs
>> when setting the new affinity. This prevents the scenario where
>> the intersection would result in an invalid CPU set.
>>
>> Fixes: da019032819a ("sched: Enforce user requested affinity")
>> Reported-by: Yang Lijin <yanglijin@huawei.com>
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/cgroup/cpuset.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index f74d04429a29..5401adbdffa6 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>>       if (cs != &top_cpuset)
>>           guarantee_active_cpus(task, cpus_attach);
>>       else
>> -        cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
>> +        cpumask_andnot(cpus_attach, cpu_active_mask,
>>                      subpartitions_cpus);
>>       /*
>>        * can_attach beforehand should guarantee that this doesn't
> 
> Offline CPUs are explicitly included for tasks in top_cpuset. Can you try the following patch to see
> if it works?
> 

Thank you very much. I tried this patch and it worked. I will resend the new patch.

Best regards
Ridong

> Thanks,
> Longman
> 
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3bc4301466f3..acd70120228c 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -3114,6 +3114,10 @@ static void cpuset_cancel_attach(struct cgroup_taskset *tset)
>  static cpumask_var_t cpus_attach;
>  static nodemask_t cpuset_attach_nodemask_to;
> 
> +/*
> + * Note that tasks in the top cpuset won't get update to their cpumasks when
> + * a hotplug event happens. So we include offline CPUs as well.
> + */
>  static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>  {
>         lockdep_assert_held(&cpuset_mutex);
> @@ -3127,7 +3131,16 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>          * can_attach beforehand should guarantee that this doesn't
>          * fail.  TODO: have a better way to handle failure here
>          */
> -       WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> +       if (unlikely(set_cpus_allowed_ptr(task, cpus_attach))) {
> +               /*
> +                * Since offline CPUs are included for top_cpuset,
> +                * set_cpus_allowed_ptr() can fail if user_cpus_ptr contains
> +                * only offline CPUs. Take out the offline CPUs and retry.
> +                */
> +               if (cs == &top_cpuset)
> +                       cpumask_and(cpus_attach, cpus_attach, cpu_active_mask);
> +               WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
> +       }
> 
>         cpuset_change_task_nodemask(task, &cpuset_attach_nodemask_to);
>         cpuset1_update_task_spread_flags(cs, task);


