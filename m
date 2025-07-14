Return-Path: <cgroups+bounces-8726-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9445CB03D69
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 13:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60CF188308C
	for <lists+cgroups@lfdr.de>; Mon, 14 Jul 2025 11:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216CE1FF1B2;
	Mon, 14 Jul 2025 11:30:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41824A1A;
	Mon, 14 Jul 2025 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752492650; cv=none; b=DJDeYMcW4GDkGBd8soiC4xLrheMWtyF/09FOk1ti7e/7RGz3gV2UIgrapwIZfy7nAaTy6UMZf9fE6UI6lA77Ue2dfFuGa/vD9GWBKWM85MXP5YkK7JwE93uC7yn45QX77n70IgEmuElJN4czJWMBoNM48JMgJqfuFMA5zEvCsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752492650; c=relaxed/simple;
	bh=XijAc5LD8/FYOXcf1sRJdmMJmeauIcztzfZ3YUc6O1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftJhzCSlACZA4WSP7IHzfpa372UbmTtE4htbi5KOFYupXdsN8ysCiKb6dt9vp8xpuCJQP7fzU5fxRusPd3hIoweF0J5O80neMkphp73BWmNEQdbinLRg8Jmrf0Q65iVnI4xRCXgpFEykthMd6FIuzV0w8OGOF4p+gnEhNq0vYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bgg9b0xs3zKHMwn;
	Mon, 14 Jul 2025 19:30:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id AB5D71A06D7;
	Mon, 14 Jul 2025 19:30:41 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgAn57hg6nRo61HuAA--.5341S2;
	Mon, 14 Jul 2025 19:30:41 +0800 (CST)
Message-ID: <090bd627-95dc-49ef-a4f6-d78d8f6d6cec@huaweicloud.com>
Date: Mon, 14 Jul 2025 19:30:39 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] cpuset: fix warning when attaching tasks with
 offline CPUs
To: Peter Zijlstra <peterz@infradead.org>
Cc: longman@redhat.com, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com,
 cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, lujialin4@huawei.com,
 chenridong@huawei.com
References: <20250714032311.3570157-1-chenridong@huaweicloud.com>
 <20250714084109.GK905792@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20250714084109.GK905792@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAn57hg6nRo61HuAA--.5341S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr45WrykZryrJr1UGF1Utrb_yoW5uF47pa
	yIka4jyw45Jr1UC39Fv39FqFyFqa1kGF17GFn7KF4rJFWfCF109a17t3W5ZFyFqrs8u3W2
	vF90vw42gFnFv3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/7/14 16:41, Peter Zijlstra wrote:
> On Mon, Jul 14, 2025 at 03:23:11AM +0000, Chen Ridong wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> A kernel warning was observed in the cpuset migration path:
>>
>>     WARNING: CPU: 3 PID: 123 at kernel/cgroup/cpuset.c:3130
>>     cgroup_migrate_execute+0x8df/0xf30
>>     Call Trace:
>>      cgroup_transfer_tasks+0x2f3/0x3b0
>>      cpuset_migrate_tasks_workfn+0x146/0x3b0
>>      process_one_work+0x5ba/0xda0
>>      worker_thread+0x788/0x1220
>>
>> The issue can be reliably reproduced with:
>>
>>     # Setup test cpuset
>>     mkdir /sys/fs/cgroup/cpuset/test
>>     echo 2-3 > /sys/fs/cgroup/cpuset/test/cpuset.cpus
>>     echo 0 > /sys/fs/cgroup/cpuset/test/cpuset.mems
>>
>>     # Start test process
>>     sleep 100 &
>>     pid=$!
>>     echo $pid > /sys/fs/cgroup/cpuset/test/cgroup.procs
>>     taskset -p 0xC $pid  # Bind to CPUs 2-3
>>
>>     # Take CPUs offline
>>     echo 0 > /sys/devices/system/cpu/cpu3/online
>>     echo 0 > /sys/devices/system/cpu/cpu2/online
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
>>  kernel/cgroup/cpuset.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>> index f74d04429a29..5401adbdffa6 100644
>> --- a/kernel/cgroup/cpuset.c
>> +++ b/kernel/cgroup/cpuset.c
>> @@ -3121,7 +3121,7 @@ static void cpuset_attach_task(struct cpuset *cs, struct task_struct *task)
>>  	if (cs != &top_cpuset)
>>  		guarantee_active_cpus(task, cpus_attach);
>>  	else
>> -		cpumask_andnot(cpus_attach, task_cpu_possible_mask(task),
>> +		cpumask_andnot(cpus_attach, cpu_active_mask,
>>  			       subpartitions_cpus);
> 
> This breaks things. Any task mask must be a subset of
> task_cpu_possible_mask() at all times. It might not be able to run
> outside of that mask.

Hi Peter,

Thanks for your feedback. I'm afraid I don't fully understand what you mean by "breaks things".
Could you please explain in more detail?

To clarify my current understanding: this patch simply changes the cpus_attach initialization from
task_cpu_possible_mask(task) to cpu_active_mask. The intention is that when CPUs are offlined and
tasks get migrated to root cpuset, we shouldn't try to migrate tasks to offline CPUs. And since
cpu_active_mask is a subset of cpu_possible_mask, I thought this would be safe. Did I miss anything?

Best regards
Ridong


