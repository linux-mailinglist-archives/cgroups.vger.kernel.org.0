Return-Path: <cgroups+bounces-4599-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D424965517
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 04:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817591C228B8
	for <lists+cgroups@lfdr.de>; Fri, 30 Aug 2024 02:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA6D54278;
	Fri, 30 Aug 2024 02:08:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50BB1D1300;
	Fri, 30 Aug 2024 02:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724983708; cv=none; b=sdwLwT9YY4TCPgUIKC5nBWNvzLWKvz3tAxniX2DD+m8GNrpktx4WFu1++bvppWMhH1yo1mwkfSQM/fS8fQsvfR4eWqopKHanBxBpbJ2gWz7ahmB9IHfOrJzA5QfeuZ6wHQ2LWYHn3zfl29/jv7KG+8eCchLYQtUfRks4UDt298g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724983708; c=relaxed/simple;
	bh=wOgvntKYQmYohnFZGu07J+B7vsxAmgNnANMJIoUIDlI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Im/h5uyfId1dSn4FLOluV+V56CU2+muc+48aaOIDwNSdVd2Sqm0NR+sAwHRMVLvAWyQNm7KgBKqTEHURlhf+nvo5xP9d/uSn4RRXR4TqGpZoy3PPTGxBHe+FJmoJoz5bPneH9eG/4T+RC3t07pkyJdJdGQDctOqYWBjBhUgqb7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ww1lC71sWz4f3jJC;
	Fri, 30 Aug 2024 10:08:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A5A8E1A06D7;
	Fri, 30 Aug 2024 10:08:22 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgAHtrSTKdFmeZoADA--.9512S2;
	Fri, 30 Aug 2024 10:08:20 +0800 (CST)
Message-ID: <cd2bc5bf-ac78-4121-80eb-9b5c7fd4549c@huaweicloud.com>
Date: Fri, 30 Aug 2024 10:08:19 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] cgroup: fix deadlock caused by cgroup_mutex and
 cpu_hotplug_lock
From: Chen Ridong <chenridong@huaweicloud.com>
To: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
 lizefan.x@bytedance.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240817093334.6062-1-chenridong@huawei.com>
 <20240817093334.6062-2-chenridong@huawei.com>
 <8c1ccd1b-47cd-43b6-b961-2829a5a24513@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <8c1ccd1b-47cd-43b6-b961-2829a5a24513@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHtrSTKdFmeZoADA--.9512S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw43CF4fWr43Zr1fZr4Utwb_yoW3ZFWrpr
	n5JryUJ3yrCr1ktr4Utw1UXryrKr40q3WUJr18J3WUAr47Jr1jqr1UZr1jgFyUJFs7Cr1U
	AF1Yvry2vr1jqw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/8/22 8:57, Chen Ridong wrote:
> 
> 
> On 2024/8/17 17:33, Chen Ridong wrote:
>> We found a hung_task problem as shown below:
>>
>> INFO: task kworker/0:0:8 blocked for more than 327 seconds.
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>> task:kworker/0:0     state:D stack:13920 pid:8     ppid:2       
>> flags:0x00004000
>> Workqueue: events cgroup_bpf_release
>> Call Trace:
>>   <TASK>
>>   __schedule+0x5a2/0x2050
>>   ? find_held_lock+0x33/0x100
>>   ? wq_worker_sleeping+0x9e/0xe0
>>   schedule+0x9f/0x180
>>   schedule_preempt_disabled+0x25/0x50
>>   __mutex_lock+0x512/0x740
>>   ? cgroup_bpf_release+0x1e/0x4d0
>>   ? cgroup_bpf_release+0xcf/0x4d0
>>   ? process_scheduled_works+0x161/0x8a0
>>   ? cgroup_bpf_release+0x1e/0x4d0
>>   ? mutex_lock_nested+0x2b/0x40
>>   ? __pfx_delay_tsc+0x10/0x10
>>   mutex_lock_nested+0x2b/0x40
>>   cgroup_bpf_release+0xcf/0x4d0
>>   ? process_scheduled_works+0x161/0x8a0
>>   ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
>>   ? process_scheduled_works+0x161/0x8a0
>>   process_scheduled_works+0x23a/0x8a0
>>   worker_thread+0x231/0x5b0
>>   ? __pfx_worker_thread+0x10/0x10
>>   kthread+0x14d/0x1c0
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork+0x59/0x70
>>   ? __pfx_kthread+0x10/0x10
>>   ret_from_fork_asm+0x1b/0x30
>>   </TASK>
>>
>> This issue can be reproduced by the following pressuse test:
>> 1. A large number of cpuset cgroups are deleted.
>> 2. Set cpu on and off repeatly.
>> 3. Set watchdog_thresh repeatly.
>> The scripts can be obtained at LINK mentioned above the signature.
>>
>> The reason for this issue is cgroup_mutex and cpu_hotplug_lock are
>> acquired in different tasks, which may lead to deadlock.
>> It can lead to a deadlock through the following steps:
>> 1. A large number of cpusets are deleted asynchronously, which puts a
>>     large number of cgroup_bpf_release works into system_wq. The 
>> max_active
>>     of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works 
>> are
>>     cgroup_bpf_release works, and many cgroup_bpf_release works will 
>> be put
>>     into inactive queue. As illustrated in the diagram, there are 256 (in
>>     the acvtive queue) + n (in the inactive queue) works.
>> 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
>>     smp_call_on_cpu work into system_wq. However step 1 has already 
>> filled
>>     system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
>>     to wait until the works that were put into the inacvtive queue 
>> earlier
>>     have executed (n cgroup_bpf_release), so it will be blocked for a 
>> while.
>> 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by 
>> step 2.
>> 4. Cpusets that were deleted at step 1 put cgroup_release works into
>>     cgroup_destroy_wq. They are competing to get cgroup_mutex all the 
>> time.
>>     When cgroup_metux is acqured by work at css_killed_work_fn, it will
>>     call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
>>     However, cpuset_css_offline will be blocked for step 3.
>> 5. At this moment, there are 256 works in active queue that are
>>     cgroup_bpf_release, they are attempting to acquire cgroup_mutex, 
>> and as
>>     a result, all of them are blocked. Consequently, sscs.work can not be
>>     executed. Ultimately, this situation leads to four processes being
>>     blocked, forming a deadlock.
>>
>> system_wq(step1)        WatchDog(step2)            cpu 
>> offline(step3)    cgroup_destroy_wq(step4)
>> ...
>> 2000+ cgroups deleted asyn
>> 256 actives + n inactives
>>                 __lockup_detector_reconfigure
>>                 P(cpu_hotplug_lock.read)
>>                 put sscs.work into system_wq
>> 256 + n + 1(sscs.work)
>> sscs.work wait to be executed
>>                 warting sscs.work finish
>>                                 percpu_down_write
>>                                 P(cpu_hotplug_lock.write)
>>                                 ...blocking...
>>                                             css_killed_work_fn
>>                                             P(cgroup_mutex)
>>                                             cpuset_css_offline
>>                                             P(cpu_hotplug_lock.read)
>>                                             ...blocking...
>> 256 cgroup_bpf_release
>> mutex_lock(&cgroup_mutex);
>> ..blocking...
>>
>> To fix the problem, place cgroup_bpf_release works on cgroup_destroy_wq,
>> which can break the loop and solve the problem. System wqs are for misc
>> things which shouldn't create a large number of concurrent work items.
>> If something is going to generate >WQ_DFL_ACTIVE(256) concurrent work
>> items, it should use its own dedicated workqueue.
>>
>> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from 
>> cgroup itself")
>> Link: 
>> https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>> ---
>>   kernel/bpf/cgroup.c             | 2 +-
>>   kernel/cgroup/cgroup-internal.h | 1 +
>>   kernel/cgroup/cgroup.c          | 2 +-
>>   3 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index 8ba73042a239..a611a1274788 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -334,7 +334,7 @@ static void cgroup_bpf_release_fn(struct 
>> percpu_ref *ref)
>>       struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
>>       INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
>> -    queue_work(system_wq, &cgrp->bpf.release_work);
>> +    queue_work(cgroup_destroy_wq, &cgrp->bpf.release_work);
>>   }
>>   /* Get underlying bpf_prog of bpf_prog_list entry, regardless if 
>> it's through
>> diff --git a/kernel/cgroup/cgroup-internal.h 
>> b/kernel/cgroup/cgroup-internal.h
>> index c964dd7ff967..17ac19bc8106 100644
>> --- a/kernel/cgroup/cgroup-internal.h
>> +++ b/kernel/cgroup/cgroup-internal.h
>> @@ -13,6 +13,7 @@
>>   extern spinlock_t trace_cgroup_path_lock;
>>   extern char trace_cgroup_path[TRACE_CGROUP_PATH_LEN];
>>   extern void __init enable_debug_cgroup(void);
>> +extern struct workqueue_struct *cgroup_destroy_wq;
>>   /*
>>    * cgroup_path() takes a spin lock. It is good practice not to take
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 75058fbf4450..77fa9ed69c86 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -124,7 +124,7 @@ DEFINE_PERCPU_RWSEM(cgroup_threadgroup_rwsem);
>>    * destruction work items don't end up filling up max_active of 
>> system_wq
>>    * which may lead to deadlock.
>>    */
>> -static struct workqueue_struct *cgroup_destroy_wq;
>> +struct workqueue_struct *cgroup_destroy_wq;
>>   /* generate an array of cgroup subsystem pointers */
>>   #define SUBSYS(_x) [_x ## _cgrp_id] = &_x ## _cgrp_subsys,
> 
> Ping.
> Hi,TJ, Roman and Michal, I have updated commit message, I think it can 
> be much clearer now, can you review it again?
> 
> Thanks,
> Ridong
> 
Friendly ping.


