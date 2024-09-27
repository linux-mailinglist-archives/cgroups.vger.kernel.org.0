Return-Path: <cgroups+bounces-4967-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75A19881DC
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 11:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE3A1C222A8
	for <lists+cgroups@lfdr.de>; Fri, 27 Sep 2024 09:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6251BB693;
	Fri, 27 Sep 2024 09:50:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C31C187FEE;
	Fri, 27 Sep 2024 09:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727430659; cv=none; b=hoIhMS8Yw8bf8sAWgvcDF3eQkC2VeVBGqvn5y7b+GNbDmRw4G8qPWWgSMyqF3UD6+lPuzQaBMyPuKzZaUVtKMeoQTu0jHSa8NPA7XHHYN66qW74fbR3Vs5ttb9pXlUr+0VgpO7kB3NIsXg1l0+b6Aw3CSVbiVeuknkb/UvKbEg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727430659; c=relaxed/simple;
	bh=/DWH+WZXk7PC9u/Ait8jHc5bLQKJGCBwTC2MmP/783E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=m+mQWoMBzXM6tQ3e6TFZHFhqfxhCYme9mAnZVdZn4g3XngYfHrw64F2QBtQu7ee3i0fSc9JShKIcLl+CXQkIHHR6c2piNMhvGTN8JrEKdQOdE27pTXorLwtXviRfKx+X+yZfaLPJkboGF/E/Dxevi64/T0lyfiThwvnhRCLasck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XFQh066YBz4f3jq6;
	Fri, 27 Sep 2024 17:50:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 275841A07BA;
	Fri, 27 Sep 2024 17:50:52 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP2 (Coremail) with SMTP id Syh0CgCHvGH5f_ZmOhXoCQ--.32277S2;
	Fri, 27 Sep 2024 17:50:50 +0800 (CST)
Message-ID: <22f11b9d-a33e-4ff4-8cb4-01b865069ce7@huaweicloud.com>
Date: Fri, 27 Sep 2024 17:50:49 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] cgroup/bpf: use a dedicated workqueue for cgroup
 bpf destruction
To: Vishal Chourasia <vishalc@linux.ibm.com>,
 "tj@kernel.org >> Tejun Heo" <tj@kernel.org>,
 Zefan Li <lizefan.x@bytedance.com>, Waiman Long <longman@redhat.com>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
References: <20240923114352.4001560-2-chenridong@huaweicloud.com>
 <ZvYzIcYSJa3Loq4G@linux.ibm.com>
Content-Language: en-US
Cc: cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <ZvYzIcYSJa3Loq4G@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCHvGH5f_ZmOhXoCQ--.32277S2
X-Coremail-Antispam: 1UD129KBjvAXoWfJr1rCw47WF47WF48XrWkZwb_yoW8Jr13to
	WrXF1kJa1kWr1UJ3WrJwnrX3y3uws2ga9rAr1Ygr4DA3W8Wry5trn8GF13J3yfXF1jyF4k
	ZFy3Xa45Zw1DJwn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUU5M7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbiF4tUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/9/27 12:22, Vishal Chourasia wrote:
> On Mon, Sep 23, 2024 at 11:43:50AM +0000, Chen Ridong wrote:
>> I found a hung_task problem as shown below:
>>
>> INFO: task kworker/0:0:8 blocked for more than 327 seconds.
>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
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
>>     large number of cgroup_bpf_release works into system_wq. The max_active
>>     of system_wq is WQ_DFL_ACTIVE(256). Consequently, all active works are
>>     cgroup_bpf_release works, and many cgroup_bpf_release works will be put
>>     into inactive queue. As illustrated in the diagram, there are 256 (in
>>     the acvtive queue) + n (in the inactive queue) works.
>> 2. Setting watchdog_thresh will hold cpu_hotplug_lock.read and put
>>     smp_call_on_cpu work into system_wq. However step 1 has already filled
>>     system_wq, 'sscs.work' is put into inactive queue. 'sscs.work' has
>>     to wait until the works that were put into the inacvtive queue earlier
>>     have executed (n cgroup_bpf_release), so it will be blocked for a while.
>> 3. Cpu offline requires cpu_hotplug_lock.write, which is blocked by step 2.
>> 4. Cpusets that were deleted at step 1 put cgroup_release works into
>>     cgroup_destroy_wq. They are competing to get cgroup_mutex all the time.
>>     When cgroup_metux is acqured by work at css_killed_work_fn, it will
>>     call cpuset_css_offline, which needs to acqure cpu_hotplug_lock.read.
>>     However, cpuset_css_offline will be blocked for step 3.
>> 5. At this moment, there are 256 works in active queue that are
>>     cgroup_bpf_release, they are attempting to acquire cgroup_mutex, and as
>>     a result, all of them are blocked. Consequently, sscs.work can not be
>>     executed. Ultimately, this situation leads to four processes being
>>     blocked, forming a deadlock.
>>
>> system_wq(step1)		WatchDog(step2)			cpu offline(step3)	cgroup_destroy_wq(step4)
>> ...
>> 2000+ cgroups deleted asyn
>> 256 actives + n inactives
>> 				__lockup_detector_reconfigure
>> 				P(cpu_hotplug_lock.read)
>> 				put sscs.work into system_wq
>> 256 + n + 1(sscs.work)
>> sscs.work wait to be executed
>> 				warting sscs.work finish
>> 								percpu_down_write
>> 								P(cpu_hotplug_lock.write)
>> 								...blocking...
>> 											css_killed_work_fn
>> 											P(cgroup_mutex)
>> 											cpuset_css_offline
>> 											P(cpu_hotplug_lock.read)
>> 											...blocking...
>> 256 cgroup_bpf_release
>> mutex_lock(&cgroup_mutex);
>> ..blocking...
>>
>> To fix the problem, place cgroup_bpf_release works on a dedicated
>> workqueue which can break the loop and solve the problem. System wqs are
>> for misc things which shouldn't create a large number of concurrent work
>> items. If something is going to generate >WQ_DFL_ACTIVE(256) concurrent
>> work items, it should use its own dedicated workqueue.
>>
>> Fixes: 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf from cgroup itself")
>> Link: https://lore.kernel.org/cgroups/e90c32d2-2a85-4f28-9154-09c7d320cb60@huawei.com/T/#t
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
> 
> Thank you Chen, for sharing the details on how to reproduce, and for the
> patchset.
> 
> Steps I followed to reproduce:
> 1) run cgroup-make.sh
> 2) run hotplug.sh
> 3) run watchdog.sh
> 
> # cat cgroup-make.sh
> #!/bin/bash
> 
> echo 30 > /proc/sys/kernel/hung_task_timeout_secs
> cat /proc/sys/kernel/hung_task_timeout_secs
> 
> echo +cpuset > /sys/fs/cgroup/cgroup.subtree_control
> mkdir /sys/fs/cgroup/memory
> # echo +memory > /sys/fs/cgroup/memory/cgroup.subtree_control
> mkdir /sys/fs/cgroup/cpuset
> echo +cpuset > /sys/fs/cgroup/cpuset/cgroup.subtree_control
> echo +cpu > /sys/fs/cgroup/cpuset/cgroup.subtree_control
> 
> 
> timestamp=$(date +%s)
> echo $timestamp
> while true; do
>          for i in {0..2000}; do
>                  mkdir /sys/fs/cgroup/cpuset/test${timestamp}_${i} &
>                  mkdir /sys/fs/cgroup/memory/test${timestamp}_${i} &
>          done
> 
>          for i in {0..2000}; do
>                  rmdir /sys/fs/cgroup/cpuset/test${timestamp}_${i} &
>                  rmdir /sys/fs/cgroup/memory/test${timestamp}_${i} &
>          done
> done
> 
> # cat hotplug.sh
> #!/bin/bash
> 
> while true
> do
> echo 1 > /sys/devices/system/cpu/cpu2/online
> echo 1 > /sys/devices/system/cpu/cpu3/online
> echo 0 > /sys/devices/system/cpu/cpu2/online
> echo 0 > /sys/devices/system/cpu/cpu3/online
> done
> 
> # cat watchdog.sh
> #!/bin/bash
> 
> while true
> do
> echo 12 > /proc/sys/kernel/watchdog_thresh
> echo 11 > /proc/sys/kernel/watchdog_thresh
> echo 10 > /proc/sys/kernel/watchdog_thresh
> done
> 
> With these steps I able to get the hung_task timeout log messages
> INFO: task kworker/7:1:84 blocked for more than 30 seconds.
>        Not tainted 6.11.0-chenridong_base-10547-g684a64bf32b6-dirty #59
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/7:1     state:D stack:0     pid:84    tgid:84    ppid:2      flags:0x00000000
> Workqueue: events cgroup_bpf_release
> Call Trace:
> [c00000000ee779a0] [c00000000ee779e0] 0xc00000000ee779e0 (unreliable)
> [c00000000ee77b50] [c00000000001f79c] __switch_to+0x14c/0x220
> [c00000000ee77bb0] [c0000000010e8cd0] __schedule+0x2c0/0x840
> [c00000000ee77c90] [c0000000010e9290] schedule+0x40/0x110
> [c00000000ee77d00] [c0000000010e95b0] schedule_preempt_disabled+0x20/0x30
> [c00000000ee77d20] [c0000000010ec408] __mutex_lock.constprop.0+0x5e8/0xbe0
> [c00000000ee77db0] [c000000000472f58] cgroup_bpf_release+0x98/0x3d0
> [c00000000ee77e40] [c0000000001886a8] process_one_work+0x1f8/0x520
> [c00000000ee77ef0] [c00000000018a01c] worker_thread+0x33c/0x4f0
> [c00000000ee77f90] [c0000000001970c8] kthread+0x138/0x140
> [c00000000ee77fe0] [c00000000000dd58] start_kernel_thread+0x14/0x18
> INFO: task kworker/4:1:98 blocked for more than 30 seconds.
>        Not tainted 6.11.0-chenridong_base-10547-g684a64bf32b6-dirty #59
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/4:1     state:D stack:0     pid:98    tgid:98    ppid:2      flags:0x00000000
> Workqueue: events cgroup_bpf_release
> Call Trace:
> [c00000000ee1f9a0] [c00000000ee1f9e0] 0xc00000000ee1f9e0 (unreliable)
> [c00000000ee1fb50] [c00000000001f79c] __switch_to+0x14c/0x220
> [c00000000ee1fbb0] [c0000000010e8cd0] __schedule+0x2c0/0x840
> [c00000000ee1fc90] [c0000000010e9290] schedule+0x40/0x110
> [c00000000ee1fd00] [c0000000010e95b0] schedule_preempt_disabled+0x20/0x30
> [c00000000ee1fd20] [c0000000010ec408] __mutex_lock.constprop.0+0x5e8/0xbe0
> [c00000000ee1fdb0] [c000000000472f58] cgroup_bpf_release+0x98/0x3d0
> [c00000000ee1fe40] [c0000000001886a8] process_one_work+0x1f8/0x520
> [c00000000ee1fef0] [c00000000018a01c] worker_thread+0x33c/0x4f0
> [c00000000ee1ff90] [c0000000001970c8] kthread+0x138/0x140
> [c00000000ee1ffe0] [c00000000000dd58] start_kernel_thread+0x14/0x18
> INFO: task kworker/5:1:110 blocked for more than 30 seconds.
>        Not tainted 6.11.0-chenridong_base-10547-g684a64bf32b6-dirty #59
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:kworker/5:1     state:D stack:0     pid:110   tgid:110   ppid:2      flags:0x00000000
> Workqueue: events cgroup_bpf_release
> Call Trace:
> [c0000000608bf9a0] [c0000000608bf9e0] 0xc0000000608bf9e0 (unreliable)
> [c0000000608bfb50] [c00000000001f79c] __switch_to+0x14c/0x220
> [c0000000608bfbb0] [c0000000010e8cd0] __schedule+0x2c0/0x840
> [c0000000608bfc90] [c0000000010e9290] schedule+0x40/0x110
> [c0000000608bfd00] [c0000000010e95b0] schedule_preempt_disabled+0x20/0x30
> [c0000000608bfd20] [c0000000010ec408] __mutex_lock.constprop.0+0x5e8/0xbe0
> [c0000000608bfdb0] [c000000000472f58] cgroup_bpf_release+0x98/0x3d0
> [c0000000608bfe40] [c0000000001886a8] process_one_work+0x1f8/0x520
> [c0000000608bfef0] [c00000000018a01c] worker_thread+0x33c/0x4f0
> [c0000000608bff90] [c0000000001970c8] kthread+0x138/0x140
> [c0000000608bffe0] [c00000000000dd58] start_kernel_thread+0x14/0x18
> Future hung task reports are suppressed, see sysctl kernel.hung_task_warnings
> 
> After applying this patchset, I didn't see any log messages being
> printed in dmesg.
> 
> State of the git repo:
> $git log --oneline
> a40aebb33934 (HEAD -> patches/v5_20240923_chenridong_add_dedicated_wq_for_cgroup_bpf_and_adjust_wq_max_active) workqueue: Adjust WQ_MAX_ACTIVE from 512 to 2048
> 08a2979a9e59 workqueue: doc: Add a note saturating the system_wq is not permitted
> 0e6f5ea2955f cgroup/bpf: use a dedicated workqueue for cgroup bpf destruction
> 684a64bf32b6 Merge tag 'nfs-for-6.12-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
> 
> 
> 
>> ---
>>   kernel/bpf/cgroup.c | 18 +++++++++++++++++-
>>   1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>> index e7113d700b87..1a7609f61d44 100644
>> --- a/kernel/bpf/cgroup.c
>> +++ b/kernel/bpf/cgroup.c
>> @@ -24,6 +24,22 @@
>>   DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, MAX_CGROUP_BPF_ATTACH_TYPE);
>>   EXPORT_SYMBOL(cgroup_bpf_enabled_key);
>>   
>> +/*
>> + * cgroup bpf destruction makes heavy use of work items and there can be a lot
>> + * of concurrent destructions.  Use a separate workqueue so that cgroup bpf
>> + * destruction work items don't end up filling up max_active of system_wq
>> + * which may lead to deadlock.
>> + */
>> +static struct workqueue_struct *cgroup_bpf_destroy_wq;
>> +
>> +static int __init cgroup_bpf_wq_init(void)
>> +{
>> +	cgroup_bpf_destroy_wq = alloc_workqueue("cgroup_bpf_destroy", 0, 1);
>> +	WARN_ON_ONCE(!cgroup_bpf_destroy_wq);
>> +	return 0;
>> +}
>> +core_initcall(cgroup_bpf_wq_init);
>> +
>>   /* __always_inline is necessary to prevent indirect call through run_prog
>>    * function pointer.
>>    */
>> @@ -334,7 +350,7 @@ static void cgroup_bpf_release_fn(struct percpu_ref *ref)
>>   	struct cgroup *cgrp = container_of(ref, struct cgroup, bpf.refcnt);
>>   
>>   	INIT_WORK(&cgrp->bpf.release_work, cgroup_bpf_release);
>> -	queue_work(system_wq, &cgrp->bpf.release_work);
>> +	queue_work(cgroup_bpf_destroy_wq, &cgrp->bpf.release_work);
>>   }
>>   
>>   /* Get underlying bpf_prog of bpf_prog_list entry, regardless if it's through
>> -- 
>> 2.34.1

Thank you for doing that.

Best regards,
Ridong


