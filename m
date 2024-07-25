Return-Path: <cgroups+bounces-3889-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078F793BA68
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 03:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2698284195
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2024 01:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B56FB8;
	Thu, 25 Jul 2024 01:48:50 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD415567F;
	Thu, 25 Jul 2024 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721872130; cv=none; b=d7MJcysbLxP83VDeizsWkIJN9dJOjk2fWP8nynKMPw7CZQz6HcUbEhSi75CuklQGmc0qIPb5yaAzVRMOQ8gyNa0skZTzwMuO5/1UlkDvrcE6UBXEoOHgg20jE8yI5cyjGwPfplv/sFcCPcLyc1JwKURXKp+hNJubfeBDylYCg9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721872130; c=relaxed/simple;
	bh=ZOqUap9ZIFAa0oA5dK3qqGY70Hb+gcTYUSfSf/CUZ1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=llQTy+ctgwb4Nhvg+v8lmmhSOcTG8l4XaY9a3NAvpMwPm+vhgtWgvvaMKOWbd6rZvedDStjPdpRyyf5FQf7QaSy4vmwS8YOhlA4LBR+2bYQItiYCM9rTZxy5PS5x6MwICOGg8+Xi1v4emQna24Q3xjEWKH6oqPz87nsYq/R9+tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WTtzG4NRDzMqrD;
	Thu, 25 Jul 2024 09:46:50 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A70D180088;
	Thu, 25 Jul 2024 09:48:38 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 25 Jul
 2024 09:48:37 +0800
Message-ID: <53ed023b-c86c-498a-b1fc-2b442059f6af@huawei.com>
Date: Thu, 25 Jul 2024 09:48:36 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v2] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
To: Hillf Danton <hdanton@sina.com>
CC: Roman Gushchin <roman.gushchin@linux.dev>, <tj@kernel.org>,
	<bpf@vger.kernel.org>, <cgroups@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240724110834.2010-1-hdanton@sina.com>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <20240724110834.2010-1-hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/7/24 19:08, Hillf Danton wrote:
> On Fri, 19 Jul 2024 02:52:32 +0000 Chen Ridong <chenridong@huawei.com>
>> We found a hung_task problem as shown below:
>>
>> INFO: task kworker/0:0:8 blocked for more than 327 seconds.
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:kworker/0:0     state:D stack:13920 pid:8     ppid:2       flags:0x00004000
>> Workqueue: events cgroup_bpf_release
>> Call Trace:
>>   <TASK>
>>   __schedule+0x5a2/0x2050
>>   ? find_held_lock+0x33/0x100
>>   ? wq_worker_sleeping+0x9e/0xe0
>>   schedule+0x9f/0x180
>>   schedule_preempt_disabled+0x25/0x50
>>   __mutex_lock+0x512/0x740
>>   ? cgroup_bpf_release+0x1e/0x4d0
>>   ? cgroup_bpf_release+0xcf/0x4d0
>>   ? process_scheduled_works+0x161/0x8a0
>>   ? cgroup_bpf_release+0x1e/0x4d0
>>   ? mutex_lock_nested+0x2b/0x40
>>   ? __pfx_delay_tsc+0x10/0x10
>>   mutex_lock_nested+0x2b/0x40
>>   cgroup_bpf_release+0xcf/0x4d0
>>   ? process_scheduled_works+0x161/0x8a0
>>   ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
>>   ? process_scheduled_works+0x161/0x8a0
>>   process_scheduled_works+0x23a/0x8a0
>>   worker_thread+0x231/0x5b0
>>   ? __pfx_worker_thread+0x10/0x10
>>   kthread+0x14d/0x1c0
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x59/0x70
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1b/0x30
>>   </TASK>
>>
>> This issue can be reproduced by the following methods:
>> 1. A large number of cpuset cgroups are deleted.
>> 2. Set cpu on and off repeatly.
>> 3. Set watchdog_thresh repeatly.
>>
>> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
>> acquired in different tasks, which may lead to deadlock.
>> It can lead to a deadlock through the following steps:
>> 1. A large number of cgroups are deleted, which will put a large
>>     number of cgroup_bpf_release works into system_wq. The max_active
>>     of system_wq is WQ_DFL_ACTIVE(256). When cgroup_bpf_release can not
>>     get cgroup_metux, it may cram system_wq, and it will block work
>>     enqueued later.
>> 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
>>     smp_call_on_cpu work into system_wq. However it may be blocked by
>>     step 1.
>> 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
>> 4. When a cpuset is deleted, cgroup release work is placed on
>>     cgroup_destroy_wq, it will hold cgroup_metux and acquire
>>     cpu_hotplug_lock.read. Acquiring cpu_hotplug_lock.read is blocked by
>>     cpu_hotplug_lock.write as mentioned by step 3. Finally, it forms a
>>     loop and leads to a deadlock.
>>
>> cgroup_destroy_wq(step4)	cpu offline(step3)		WatchDog(step2)			system_wq(step1)
>> 												......
>> 								__lockup_detector_reconfigure:
>> 								P(cpu_hotplug_lock.read)
>> 								...
>> 				...
>> 				percpu_down_write:
>> 				P(cpu_hotplug_lock.write)
>> 												...256+ works
>> 												cgroup_bpf_release:
>> 												P(cgroup_mutex)
>> 								smp_call_on_cpu:
>> 								Wait system_wq
>> ...
>> css_killed_work_fn:
>> P(cgroup_mutex)
>> ...
>> cpuset_css_offline:
>> P(cpu_hotplug_lock.read)
>>
> 	worker_thread()
> 	manage_workers()
> 	maybe_create_worker()
> 	create_worker() // has nothing to do with WQ_DFL_ACTIVE
> 	process_scheduled_works()
> 
> Given idle worker created independent of WQ_DFL_ACTIVE before handling
> work item, no deadlock could rise in your scenario above.

Hello Hillf, did you mean to say this issue couldn't happen?
I wish it hadn't happen, as it took me a long time to figure out.
However, it did happen. It could be reproduced with the method I 
offered, You can access the scripts using this link: 
https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t.

It's not about how the pool's workers were created, but rather the 
limit(system_wq ) of workqueue. If system_wq reaches its max_active 
limit, the work enqueued afterward will be placed on 
pwq->inactive_works. In this scenario described above, the problem is 
all active works(cgroup_bpf_release) are blocked, and the 
inactive_works(smp_call_on_cpu) couldn't be executed when it forms a loop.

We have discussed this before in V1, you can find in the Link.

Thanks
Ridong

