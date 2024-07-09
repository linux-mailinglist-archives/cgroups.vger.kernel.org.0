Return-Path: <cgroups+bounces-3581-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AA792BB9C
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 15:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37EE4B2633A
	for <lists+cgroups@lfdr.de>; Tue,  9 Jul 2024 13:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6315ECC0;
	Tue,  9 Jul 2024 13:42:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD215CD58;
	Tue,  9 Jul 2024 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720532575; cv=none; b=H8AAk8SfkKbNkMZWjQvpWotTSO25Nj0tfC9D4phmh+jSgz9P8TIwXDFHXt99vbyiU9nxj2z57R82MgBUTHc29TNg8ga3SMwb9KYi9L7VnpQeuHKjjXJ5snCOlSLxLTWChvsQhT+SkBpDsvkEUBmqEvl9h6QbW/MH0E6k+NqKvTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720532575; c=relaxed/simple;
	bh=K5bWMkilYzE+7AHKbGFVswWAZRBv+UhZ3bRPC9spQeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H+mepj5vkwE54mnYrnIY7lbrZkICAecHn+BZJ5FVM180gmHdBHrXufsLHr79T5HJ/Onsnb/yPjgfsHrNq7EWJxcUS8lGV3hrPN1daaKAazhPX2/grFO6sDiEsLS3rUciNbL7EKfHeeuGHTaFgmu4ByrlIEi/QtA04Uoncz8eF7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WJMXB6mNzzQksH;
	Tue,  9 Jul 2024 21:38:50 +0800 (CST)
Received: from kwepemd100013.china.huawei.com (unknown [7.221.188.163])
	by mail.maildlp.com (Postfix) with ESMTPS id BB195140257;
	Tue,  9 Jul 2024 21:42:45 +0800 (CST)
Received: from [10.67.109.79] (10.67.109.79) by kwepemd100013.china.huawei.com
 (7.221.188.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 9 Jul
 2024 21:42:44 +0800
Message-ID: <300f9efa-cc15-4bee-b710-25bff796bf28@huawei.com>
Date: Tue, 9 Jul 2024 21:42:44 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] cgroup: Fix AA deadlock caused by
 cgroup_bpf_release
To: Roman Gushchin <roman.gushchin@linux.dev>
CC: <martin.lau@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>, <tj@kernel.org>,
	<lizefan.x@bytedance.com>, <hannes@cmpxchg.org>, <bpf@vger.kernel.org>,
	<cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240607110313.2230669-1-chenridong@huawei.com>
 <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
Content-Language: en-US
From: chenridong <chenridong@huawei.com>
In-Reply-To: <67B5A5C8-68D8-499E-AFF1-4AFE63128706@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100013.china.huawei.com (7.221.188.163)



On 2024/6/10 10:47, Roman Gushchin wrote:
> Hi Chen!
> 
> Was this problem found in the real life? Do you have a LOCKDEP splash available?
> 
Sorry for the late email response.
Yes, it was. The issue occurred after a long period of stress testing, 
with a very low probability.
>> On Jun 7, 2024, at 4:09 AM, Chen Ridong <chenridong@huawei.com> wrote:
>>
>> ﻿We found an AA deadlock problem as shown belowed:
>>
>> cgroup_destroy_wq        TaskB                WatchDog            system_wq
>>
>> ...
>> css_killed_work_fn:
>> P(cgroup_mutex)
>> ...
>>                                 ...
>>                                 __lockup_detector_reconfigure:
>>                                 P(cpu_hotplug_lock.read)
>>                                 ...
>>                 ...
>>                 percpu_down_write:
>>                 P(cpu_hotplug_lock.write)
>>                                                 ...
>>                                                 cgroup_bpf_release:
>>                                                 P(cgroup_mutex)
>>                                 smp_call_on_cpu:
>>                                 Wait system_wq
>>
>> cpuset_css_offline:
>> P(cpu_hotplug_lock.read)
>>
>> WatchDog is waiting for system_wq, who is waiting for cgroup_mutex, to
>> finish the jobs, but the owner of the cgroup_mutex is waiting for
>> cpu_hotplug_lock. This problem caused by commit 4bfc0bb2c60e ("bpf:
>> decouple the lifetime of cgroup_bpf from cgroup itself")
>> puts cgroup_bpf release work into system_wq. As cgroup_bpf is a member of
>> cgroup, it is reasonable to put cgroup bpf release work into
>> cgroup_destroy_wq, which is only used for cgroup's release work, and the
>> preblem is solved.
> 
> I need to think more on this, but at first glance the fix looks a bit confusing. cgroup_bpf_release() looks quite innocent, it only takes a cgroup_mutex. It’s not obvious why it’s not ok and requires a dedicated work queue. What exactly is achieved by placing it back on the dedicated cgroup destroy queue?
> 
> I’m not trying to say your fix won’t work, but it looks like it might cover a more serious problem.

The issue lies in the fact that different tasks require the cgroup_mutex 
and cpu_hotplug_lock locks, eventually forming a deadlock. Placing 
cgroup bpf release work on cgroup destroy queue can break loop.

The issue can be reproduced by the following method(with qemu -smp 4).
1.mkdir and rmdir cgroup repeatly
#!/bin/bash
timestamp=$(date +%s)
for ((i=0; i<2000; i++))
do
	mkdir /sys/fs/cgroup/cpuset/test$timestamp_$i &
	mkdir /sys/fs/cgroup/memory/test$timestamp_$i &
done

for ((i=0; i<2000; i++))
do
	rmdir /sys/fs/cgroup/cpuset/test$timestamp_$i &
	rmdir /sys/fs/cgroup/memory/test$timestamp_$i &
done
2. set cpu on and off repeatly
#!/bin/bash

while true
do
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 0 > /sys/devices/system/cpu/cpu2/online
done
3.set watchdog_thresh repeatly
#!/bin/bash

while true
do
echo 12 > /proc/sys/kernel/watchdog_thresh
echo 11 > /proc/sys/kernel/watchdog_thresh
echo 10 > /proc/sys/kernel/watchdog_thresh
done

4.add mdelay to reproduce(it is hard to reproduce if we do not have this 
helper)
#include "../cgroup/cgroup-internal.h"
+#include <linux/delay.h>

  DEFINE_STATIC_KEY_ARRAY_FALSE(cgroup_bpf_enabled_key, 
MAX_CGROUP_BPF_ATTACH_TYPE);
  EXPORT_SYMBOL(cgroup_bpf_enabled_key);
@@ -281,7 +282,7 @@ static void cgroup_bpf_release(struct work_struct *work)
         struct bpf_cgroup_storage *storage, *stmp;

         unsigned int atype;
-
+       mdelay(50);
         cgroup_lock();

         for (atype = 0; atype < ARRAY_SIZE(cgrp->bpf.progs); atype++) {
diff --git a/kernel/smp.c b/kernel/smp.c
index f085ebcdf9e7..77325566ea69 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -25,6 +25,7 @@
  #include <linux/nmi.h>
  #include <linux/sched/debug.h>
  #include <linux/jump_label.h>
+#include <linux/delay.h>

  #include <trace/events/ipi.h>
  #define CREATE_TRACE_POINTS
@@ -1113,7 +1114,7 @@ int smp_call_on_cpu(unsigned int cpu, int 
(*func)(void *), void *par, bool phys)
         };

         INIT_WORK_ONSTACK(&sscs.work, smp_call_on_cpu_callback);
-
+       mdelay(10);
         if (cpu >= nr_cpu_ids || !cpu_online(cpu))
                 return -ENXIO;

5.Before 616db8779b1e ("workqueue: Automatically mark CPU-hogging work 
items CPU_INTENSIVE"), the issue can be reproduced with just the four 
steps mentioned above.
After 616db8779b1e ("workqueue: Automatically mark CPU-hogging work 
items CPU_INTENSIVE") ,cpu_intensive_thresh_us is needed to set as below:
#echo 100000 > /sys/module/workqueue/parameters/cpu_intensive_thresh_us



LOCKDEP splash for 6.6:


[  955.350702] INFO: task kworker/0:0:8 blocked for more than 327 seconds.
[  955.357885]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.358344] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.359987] task:kworker/0:0     state:D stack:13920 pid:8     ppid:2 
      flags:0x00004000
[  955.362182] Workqueue: events cgroup_bpf_release
[  955.363867] Call Trace:
[  955.364588]  <TASK>
[  955.365156]  __schedule+0x5a2/0x2050
[  955.366576]  ? find_held_lock+0x33/0x100
[  955.366790]  ? wq_worker_sleeping+0x9e/0xe0
[  955.366980]  schedule+0x9f/0x180
[  955.367150]  schedule_preempt_disabled+0x25/0x50
[  955.367501]  __mutex_lock+0x512/0x740
[  955.367774]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.367946]  ? cgroup_bpf_release+0xcf/0x4d0
[  955.368097]  ? process_scheduled_works+0x161/0x8a0
[  955.368254]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.368566]  ? mutex_lock_nested+0x2b/0x40
[  955.368732]  ? __pfx_delay_tsc+0x10/0x10
[  955.368901]  mutex_lock_nested+0x2b/0x40
[  955.369098]  cgroup_bpf_release+0xcf/0x4d0
[  955.369271]  ? process_scheduled_works+0x161/0x8a0
[  955.369621]  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
[  955.369852]  ? process_scheduled_works+0x161/0x8a0
[  955.370043]  process_scheduled_works+0x23a/0x8a0
[  955.370260]  worker_thread+0x231/0x5b0
[  955.370569]  ? __pfx_worker_thread+0x10/0x10
[  955.370735]  kthread+0x14d/0x1c0
[  955.370890]  ? __pfx_kthread+0x10/0x10
[  955.371055]  ret_from_fork+0x59/0x70
[  955.371219]  ? __pfx_kthread+0x10/0x10
[  955.371519]  ret_from_fork_asm+0x1b/0x30
[  955.371813]  </TASK>
[  955.372136] INFO: task kworker/3:1:44 blocked for more than 327 seconds.
[  955.372632]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.372870] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.373079] task:kworker/3:1     state:D stack:14256 pid:44    ppid:2 
      flags:0x00004000
[  955.373500] Workqueue: events cgroup_bpf_release
[  955.373701] Call Trace:
[  955.373803]  <TASK>
[  955.373911]  __schedule+0x5a2/0x2050
[  955.374055]  ? find_held_lock+0x33/0x100
[  955.374196]  ? wq_worker_sleeping+0x9e/0xe0
[  955.374343]  schedule+0x9f/0x180
[  955.374608]  schedule_preempt_disabled+0x25/0x50
[  955.374768]  __mutex_lock+0x512/0x740
[  955.374911]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.375057]  ? cgroup_bpf_release+0xcf/0x4d0
[  955.375220]  ? process_scheduled_works+0x161/0x8a0
[  955.375540]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.375735]  ? mutex_lock_nested+0x2b/0x40
[  955.375926]  ? __pfx_delay_tsc+0x10/0x10
[  955.376076]  mutex_lock_nested+0x2b/0x40
[  955.376220]  cgroup_bpf_release+0xcf/0x4d0
[  955.376517]  ? process_scheduled_works+0x161/0x8a0
[  955.376724]  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
[  955.376982]  ? process_scheduled_works+0x161/0x8a0
[  955.377192]  process_scheduled_works+0x23a/0x8a0
[  955.377541]  worker_thread+0x231/0x5b0
[  955.377742]  ? __pfx_worker_thread+0x10/0x10
[  955.377931]  kthread+0x14d/0x1c0
[  955.378076]  ? __pfx_kthread+0x10/0x10
[  955.378231]  ret_from_fork+0x59/0x70
[  955.378550]  ? __pfx_kthread+0x10/0x10
[  955.378709]  ret_from_fork_asm+0x1b/0x30
[  955.378880]  </TASK>
[  955.379069] INFO: task systemd-journal:93 blocked for more than 327 
seconds.
[  955.379294]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.379759] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.380041] task:systemd-journal state:D stack:12064 pid:93    ppid:1 
      flags:0x00000002
[  955.380515] Call Trace:
[  955.380661]  <TASK>
[  955.380770]  __schedule+0x5a2/0x2050
[  955.380938]  ? __lock_acquire.constprop.0+0x24f/0x8d0
[  955.381115]  ? find_held_lock+0x33/0x100
[  955.381271]  schedule+0x9f/0x180
[  955.381579]  schedule_preempt_disabled+0x25/0x50
[  955.381769]  __mutex_lock+0x512/0x740
[  955.381922]  ? proc_cgroup_show+0x66/0x3e0
[  955.382091]  ? mutex_lock_nested+0x2b/0x40
[  955.382250]  mutex_lock_nested+0x2b/0x40
[  955.382550]  proc_cgroup_show+0x66/0x3e0
[  955.382740]  proc_single_show+0x64/0xa0
[  955.382900]  seq_read_iter+0x155/0x660
[  955.383045]  ? _copy_to_user+0x34/0x60
[  955.383186]  ? cp_new_stat+0x14a/0x190
[  955.383341]  seq_read+0xd5/0x110
[  955.383650]  vfs_read+0xae/0x1a0
[  955.383792]  ksys_read+0x81/0x180
[  955.383940]  __x64_sys_read+0x21/0x30
[  955.384090]  x64_sys_call+0x2608/0x4630
[  955.384238]  do_syscall_64+0x44/0xb0
[  955.384394]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[  955.384994] RIP: 0033:0x7fe91e2be81c
[  955.385530] RSP: 002b:00007ffc1f490df0 EFLAGS: 00000246 ORIG_RAX: 
0000000000000000
[  955.385849] RAX: ffffffffffffffda RBX: 00005609cd32d2f0 RCX: 
00007fe91e2be81c
[  955.386095] RDX: 0000000000000400 RSI: 00005609cd32d520 RDI: 
0000000000000019
[  955.386312] RBP: 00007fe91e3c1600 R08: 0000000000000000 R09: 
0000000000000001
[  955.386815] R10: 0000000000001000 R11: 0000000000000246 R12: 
00007fe91d8ecd88
[  955.387093] R13: 0000000000000d68 R14: 00007fe91e3c0a00 R15: 
0000000000000d68
[  955.387683]  </TASK>
[  955.387824] INFO: task kworker/3:2:103 blocked for more than 327 seconds.
[  955.388071]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.388313] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.388792] task:kworker/3:2     state:D stack:14688 pid:103   ppid:2 
      flags:0x00004000
[  955.389143] Workqueue: events cgroup_bpf_release
[  955.389332] Call Trace:
[  955.389610]  <TASK>
[  955.389725]  __schedule+0x5a2/0x2050
[  955.389895]  ? find_held_lock+0x33/0x100
[  955.390046]  ? wq_worker_sleeping+0x9e/0xe0
[  955.390208]  schedule+0x9f/0x180
[  955.390478]  schedule_preempt_disabled+0x25/0x50
[  955.390670]  __mutex_lock+0x512/0x740
[  955.390816]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.390989]  ? cgroup_bpf_release+0xcf/0x4d0
[  955.391161]  ? process_scheduled_works+0x161/0x8a0
[  955.391487]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.391677]  ? mutex_lock_nested+0x2b/0x40
[  955.391825]  ? __pfx_delay_tsc+0x10/0x10
[  955.391991]  mutex_lock_nested+0x2b/0x40
[  955.392146]  cgroup_bpf_release+0xcf/0x4d0
[  955.392307]  ? process_scheduled_works+0x161/0x8a0
[  955.392728]  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
[  955.392957]  ? process_scheduled_works+0x161/0x8a0
[  955.393118]  process_scheduled_works+0x23a/0x8a0
[  955.393276]  worker_thread+0x231/0x5b0
[  955.393565]  ? __pfx_worker_thread+0x10/0x10
[  955.393726]  kthread+0x14d/0x1c0
[  955.393865]  ? __pfx_kthread+0x10/0x10
[  955.394014]  ret_from_fork+0x59/0x70
[  955.394150]  ? __pfx_kthread+0x10/0x10
[  955.394288]  ret_from_fork_asm+0x1b/0x30
[  955.394619]  </TASK>
[  955.394737] INFO: task kworker/0:2:154 blocked for more than 327 seconds.
[  955.394947]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.395167] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.395564] task:kworker/0:2     state:D stack:14632 pid:154   ppid:2 
      flags:0x00004000
[  955.395896] Workqueue: events cgroup_bpf_release
[  955.396072] Call Trace:
[  955.396172]  <TASK>
[  955.396266]  __schedule+0x5a2/0x2050
[  955.396576]  ? find_held_lock+0x33/0x100
[  955.396739]  ? wq_worker_sleeping+0x9e/0xe0
[  955.396906]  schedule+0x9f/0x180
[  955.397049]  schedule_preempt_disabled+0x25/0x50
[  955.397221]  __mutex_lock+0x512/0x740
[  955.397585]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.397758]  ? cgroup_bpf_release+0xcf/0x4d0
[  955.397943]  ? process_scheduled_works+0x161/0x8a0
[  955.398129]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.398317]  ? mutex_lock_nested+0x2b/0x40
[  955.398620]  ? __pfx_delay_tsc+0x10/0x10
[  955.398781]  mutex_lock_nested+0x2b/0x40
[  955.398946]  cgroup_bpf_release+0xcf/0x4d0
[  955.399096]  ? process_scheduled_works+0x161/0x8a0
[  955.399290]  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
[  955.399729]  ? process_scheduled_works+0x161/0x8a0
[  955.399927]  process_scheduled_works+0x23a/0x8a0
[  955.400113]  worker_thread+0x231/0x5b0
[  955.400274]  ? __pfx_worker_thread+0x10/0x10
[  955.400618]  kthread+0x14d/0x1c0
[  955.400768]  ? __pfx_kthread+0x10/0x10
[  955.400928]  ret_from_fork+0x59/0x70
[  955.401070]  ? __pfx_kthread+0x10/0x10
[  955.401216]  ret_from_fork_asm+0x1b/0x30
[  955.401506]  </TASK>
[  955.401714] INFO: task cpu_up_down.sh:374 blocked for more than 327 
seconds.
[  955.401938]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.402154] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.402502] task:cpu_up_down.sh  state:D stack:13248 pid:374   ppid:1 
      flags:0x00004002
[  955.402793] Call Trace:
[  955.402903]  <TASK>
[  955.402999]  __schedule+0x5a2/0x2050
[  955.403148]  schedule+0x9f/0x180
[  955.403301]  percpu_down_write+0x100/0x230
[  955.403697]  _cpu_up+0x3a/0x230
[  955.403872]  cpu_up+0xf0/0x180
[  955.404010]  cpu_device_up+0x21/0x30
[  955.404172]  cpu_subsys_online+0x59/0x140
[  955.404330]  device_online+0xab/0xf0
[  955.404643]  online_store+0xce/0x100
[  955.404785]  dev_attr_store+0x1f/0x40
[  955.404942]  sysfs_kf_write+0x58/0x80
[  955.405095]  kernfs_fop_write_iter+0x194/0x290
[  955.405288]  new_sync_write+0xeb/0x160
[  955.405659]  vfs_write+0x16f/0x1d0
[  955.405807]  ksys_write+0x81/0x180
[  955.405947]  __x64_sys_write+0x21/0x30
[  955.406082]  x64_sys_call+0x2f25/0x4630
[  955.406220]  do_syscall_64+0x44/0xb0
[  955.406493]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[  955.406725] RIP: 0033:0x7fc5a1d36887
[  955.406889] RSP: 002b:00007ffc8a71f498 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[  955.407183] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 
00007fc5a1d36887
[  955.407563] RDX: 0000000000000002 RSI: 0000560415993ac0 RDI: 
0000000000000001
[  955.407794] RBP: 0000560415993ac0 R08: 00007fc5a1df3460 R09: 
000000007fffffff
[  955.408011] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000002
[  955.408230] R13: 00007fc5a1e3d780 R14: 00007fc5a1e39600 R15: 
00007fc5a1e38a00
[  955.408631]  </TASK>
[  955.408746] INFO: task watchdog.sh:375 blocked for more than 327 seconds.
[  955.408963]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.409187] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.409584] task:watchdog.sh     state:D stack:13248 pid:375   ppid:1 
      flags:0x00004002
[  955.409895] Call Trace:
[  955.410039]  <TASK>
[  955.410146]  __schedule+0x5a2/0x2050
[  955.410289]  ? __lock_acquire.constprop.0+0x24f/0x8d0
[  955.410649]  ? msr_event_update+0x20/0xf0
[  955.410814]  schedule+0x9f/0x180
[  955.410955]  schedule_timeout+0x146/0x160
[  955.411100]  ? do_wait_for_common+0x7e/0x260
[  955.411268]  ? __lock_acquire.constprop.0+0x24f/0x8d0
[  955.411641]  do_wait_for_common+0x92/0x260
[  955.411813]  ? __pfx_schedule_timeout+0x10/0x10
[  955.411994]  ? __pfx_softlockup_start_fn+0x10/0x10
[  955.412161]  wait_for_completion+0x5e/0x90
[  955.412327]  smp_call_on_cpu+0x1ba/0x220
[  955.412655]  ? __pfx_smp_call_on_cpu_callback+0x10/0x10
[  955.412842]  ? __pfx_softlockup_start_fn+0x10/0x10
[  955.413032]  __lockup_detector_reconfigure+0x218/0x260
[  955.413209]  proc_watchdog_thresh+0xcd/0xe0
[  955.413574]  proc_sys_call_handler+0x1ea/0x390
[  955.413792]  ? raw_spin_rq_unlock+0x30/0x90
[  955.413982]  proc_sys_write+0x1b/0x30
[  955.414151]  new_sync_write+0xeb/0x160
[  955.414329]  vfs_write+0x16f/0x1d0
[  955.414684]  ksys_write+0x81/0x180
[  955.414870]  __x64_sys_write+0x21/0x30
[  955.415027]  x64_sys_call+0x2f25/0x4630
[  955.415208]  do_syscall_64+0x44/0xb0
[  955.415518]  entry_SYSCALL_64_after_hwframe+0x78/0xe2
[  955.415708] RIP: 0033:0x7f6eb323d887
[  955.415842] RSP: 002b:00007fffb86753c8 EFLAGS: 00000246 ORIG_RAX: 
0000000000000001
[  955.416084] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 
00007f6eb323d887
[  955.416288] RDX: 0000000000000003 RSI: 000055b2e5ea4d30 RDI: 
0000000000000001
[  955.416734] RBP: 000055b2e5ea4d30 R08: 00007f6eb32fa460 R09: 
000000007fffffff
[  955.416965] R10: 0000000000000000 R11: 0000000000000246 R12: 
0000000000000003
[  955.417172] R13: 00007f6eb3344780 R14: 00007f6eb3340600 R15: 
00007f6eb333fa00
[  955.417545]  </TASK>
[  955.417665] INFO: task kworker/0:3:413 blocked for more than 327 seconds.
[  955.417923]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.418175] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.418586] task:kworker/0:3     state:D stack:14648 pid:413   ppid:2 
      flags:0x00004000
[  955.418898] Workqueue: events cgroup_bpf_release
[  955.419087] Call Trace:
[  955.419240]  <TASK>
[  955.419529]  __schedule+0x5a2/0x2050
[  955.419684]  ? find_held_lock+0x33/0x100
[  955.419837]  ? wq_worker_sleeping+0x9e/0xe0
[  955.420041]  schedule+0x9f/0x180
[  955.420206]  schedule_preempt_disabled+0x25/0x50
[  955.420587]  __mutex_lock+0x512/0x740
[  955.420751]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.420968]  ? cgroup_bpf_release+0xcf/0x4d0
[  955.421166]  ? process_scheduled_works+0x161/0x8a0
[  955.421333]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.421678]  ? mutex_lock_nested+0x2b/0x40
[  955.421840]  ? __pfx_delay_tsc+0x10/0x10
[  955.421994]  mutex_lock_nested+0x2b/0x40
[  955.422135]  cgroup_bpf_release+0xcf/0x4d0
[  955.422281]  ? process_scheduled_works+0x161/0x8a0
[  955.422652]  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
[  955.422877]  ? process_scheduled_works+0x161/0x8a0
[  955.423036]  process_scheduled_works+0x23a/0x8a0
[  955.423210]  worker_thread+0x231/0x5b0
[  955.423467]  ? __pfx_worker_thread+0x10/0x10
[  955.423644]  kthread+0x14d/0x1c0
[  955.423784]  ? __pfx_kthread+0x10/0x10
[  955.423948]  ret_from_fork+0x59/0x70
[  955.424118]  ? __pfx_kthread+0x10/0x10
[  955.424256]  ret_from_fork_asm+0x1b/0x30
[  955.424581]  </TASK>
[  955.424729] INFO: task kworker/0:1:3950 blocked for more than 327 
seconds.
[  955.424984]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.425213] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.425598] task:kworker/0:1     state:D stack:14840 pid:3950  ppid:2 
      flags:0x00004000
[  955.425933] Workqueue: events cgroup_bpf_release
[  955.426167] Call Trace:
[  955.426291]  <TASK>
[  955.426578]  __schedule+0x5a2/0x2050
[  955.426774]  ? find_held_lock+0x33/0x100
[  955.426961]  ? wq_worker_sleeping+0x9e/0xe0
[  955.427170]  schedule+0x9f/0x180
[  955.427331]  schedule_preempt_disabled+0x25/0x50
[  955.427664]  __mutex_lock+0x512/0x740
[  955.427814]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.427994]  ? cgroup_bpf_release+0xcf/0x4d0
[  955.428180]  ? process_scheduled_works+0x161/0x8a0
[  955.428597]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.428787]  ? mutex_lock_nested+0x2b/0x40
[  955.428966]  ? __pfx_delay_tsc+0x10/0x10
[  955.429135]  mutex_lock_nested+0x2b/0x40
[  955.429283]  cgroup_bpf_release+0xcf/0x4d0
[  955.429766]  ? process_scheduled_works+0x161/0x8a0
[  955.429960]  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
[  955.430176]  ? process_scheduled_works+0x161/0x8a0
[  955.430480]  process_scheduled_works+0x23a/0x8a0
[  955.430713]  worker_thread+0x231/0x5b0
[  955.430875]  ? __pfx_worker_thread+0x10/0x10
[  955.431028]  kthread+0x14d/0x1c0
[  955.431168]  ? __pfx_kthread+0x10/0x10
[  955.431333]  ret_from_fork+0x59/0x70
[  955.431662]  ? __pfx_kthread+0x10/0x10
[  955.431811]  ret_from_fork_asm+0x1b/0x30
[  955.431973]  </TASK>
[  955.432108] INFO: task kworker/0:4:4452 blocked for more than 327 
seconds.
[  955.432326]       Tainted: G          I 
6.6.0-10483-g37a510c04997-dirty #253
[  955.432749] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[  955.432979] task:kworker/0:4     state:D stack:14920 pid:4452  ppid:2 
      flags:0x00004000
[  955.433278] Workqueue: events cgroup_bpf_release
[  955.433697] Call Trace:
[  955.433819]  <TASK>
[  955.433925]  __schedule+0x5a2/0x2050
[  955.434068]  ? find_held_lock+0x33/0x100
[  955.434220]  ? wq_worker_sleeping+0x9e/0xe0
[  955.434503]  schedule+0x9f/0x180
[  955.434660]  schedule_preempt_disabled+0x25/0x50
[  955.434824]  __mutex_lock+0x512/0x740
[  955.434975]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.435131]  ? cgroup_bpf_release+0xcf/0x4d0
[  955.435307]  ? process_scheduled_works+0x161/0x8a0
[  955.435680]  ? cgroup_bpf_release+0x1e/0x4d0
[  955.435849]  ? mutex_lock_nested+0x2b/0x40
[  955.436009]  ? __pfx_delay_tsc+0x10/0x10
[  955.436149]  mutex_lock_nested+0x2b/0x40
[  955.436293]  cgroup_bpf_release+0xcf/0x4d0
[  955.436629]  ? process_scheduled_works+0x161/0x8a0
[  955.436799]  ? trace_event_raw_event_workqueue_execute_start+0x64/0xd0
[  955.437009]  ? process_scheduled_works+0x161/0x8a0
[  955.437162]  process_scheduled_works+0x23a/0x8a0
[  955.437319]  worker_thread+0x231/0x5b0
[  955.437634]  ? __pfx_worker_thread+0x10/0x10
[  955.437806]  kthread+0x14d/0x1c0
[  955.437961]  ? __pfx_kthread+0x10/0x10
[  955.438140]  ret_from_fork+0x59/0x70
[  955.438292]  ? __pfx_kthread+0x10/0x10
[  955.438641]  ret_from_fork_asm+0x1b/0x30
[  955.438841]  </TASK>
[  955.439021] Future hung task reports are suppressed, see sysctl 
kernel.hung_task_warnings
[  955.822134]
[  955.822134] Showing all locks held in the system:
[  955.822946] 2 locks held by systemd/1:
[  955.823225]  #0: ffff888100f28440 (&p->lock){....}-{3:3}, at: 
seq_read_iter+0x69/0x660
[  955.824341]  #1: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
proc_cgroup_show+0x66/0x3e0
[  955.825068] 3 locks held by kworker/0:0/8:
[  955.825221]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.825751]  #1: ffffc9000004be60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.826203]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.826794] 1 lock held by khungtaskd/39:
[  955.826975]  #0: ffffffff83e24840 (rcu_read_lock){....}-{1:2}, at: 
debug_show_all_locks+0x46/0x1d0
[  955.827482] 3 locks held by kworker/3:1/44:
[  955.827651]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.828073]  #1: ffffc9000018fe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.828699]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.829076] 2 locks held by systemd-journal/93:
[  955.829235]  #0: ffff8881046a69b0 (&p->lock){....}-{3:3}, at: 
seq_read_iter+0x69/0x660
[  955.829729]  #1: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
proc_cgroup_show+0x66/0x3e0
[  955.830101] 3 locks held by kworker/3:2/103:
[  955.830254]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.830785]  #1: ffffc90000d33e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.831221]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.831737] 3 locks held by kworker/0:2/154:
[  955.831895]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.832256]  #1: ffffc90000df3e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.832853]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.833244] 1 lock held by in:imklog/187:
[  955.833625] 6 locks held by rs:main Q:Reg/188:
[  955.833847] 7 locks held by cpu_up_down.sh/374:
[  955.834045]  #0: ffff888103c913e0 (sb_writers#5){....}-{0:0}, at: 
vfs_write+0xae/0x1d0
[  955.834892]  #1: ffff8881046fba88 (&of->mutex){....}-{3:3}, at: 
kernfs_fop_write_iter+0x143/0x290
[  955.835324]  #2: ffff888101423cf8 (kn->active#57){....}-{0:0}, at: 
kernfs_fop_write_iter+0x153/0x290
[  955.835885]  #3: ffffffff8428b168 (device_hotplug_lock){....}-{3:3}, 
at: lock_device_hotplug_sysfs+0x1d/0x80
[  955.836329]  #4: ffff888237d2d3a0 (&dev->mutex){....}-{3:3}, at: 
device_online+0x29/0xf0
[  955.836813]  #5: ffffffff83cd5068 (cpu_add_remove_lock){....}-{3:3}, 
at: cpu_up+0x54/0x180
[  955.837196]  #6: ffffffff83cd4fd0 (cpu_hotplug_lock){....}-{0:0}, at: 
_cpu_up+0x3a/0x230
[  955.837753] 3 locks held by watchdog.sh/375:
[  955.837927]  #0: ffff888103c903e0 (sb_writers#4){....}-{0:0}, at: 
vfs_write+0xae/0x1d0
[  955.838250]  #1: ffffffff83e71148 (watchdog_mutex){....}-{3:3}, at: 
proc_watchdog_thresh+0x37/0xe0
[  955.838760]  #2: ffffffff83cd4fd0 (cpu_hotplug_lock){....}-{0:0}, at: 
__lockup_detector_reconfigure+0x14/0x260
[  955.839163] 3 locks held by kworker/0:3/413:
[  955.839319]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.839839]  #1: ffffc90000d63e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.840234]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.840756] 3 locks held by kworker/0:1/3950:
[  955.840918]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.841272]  #1: ffffc900057abe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.841836]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.842169] 3 locks held by kworker/0:4/4452:
[  955.842314]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.842847]  #1: ffffc90000e3fe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.843307]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.843825] 3 locks held by kworker/3:0/4453:
[  955.843994]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.844598]  #1: ffffc90000e23e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.845023]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.845341] 3 locks held by kworker/0:5/4460:
[  955.845678]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.846045]  #1: ffffc90006273e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.846677]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.847062] 3 locks held by kworker/3:3/4461:
[  955.847262]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.847828]  #1: ffffc9000627be60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.848285]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.848794] 3 locks held by kworker/3:4/4464:
[  955.848954]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.849332]  #1: ffffc9000629be60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.849900]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.850245] 3 locks held by kworker/0:6/4468:
[  955.850568]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.850947]  #1: ffffc900062bbe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.851492]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.851870] 3 locks held by kworker/3:5/4472:
[  955.852014]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.852499]  #1: ffffc900062dbe60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.852911]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.853302] 3 locks held by kworker/3:6/4474:
[  955.853645]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.854040]  #1: ffffc900062e3e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.854643]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.854994] 3 locks held by kworker/0:7/4476:
[  955.855140]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.855747]  #1: ffffc900062f3e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.856188]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.856707] 3 locks held by kworker/3:7/4479:
[  955.856879]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.857285]  #1: ffffc90006313e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.857929]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.858318] 3 locks held by kworker/0:8/4483:
[  955.858669]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.859082]  #1: ffffc90006333e60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.859766]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.860173] 3 locks held by kworker/3:8/4484:
[  955.860352]  #0: ffff888100062538 
((wq_completion)events){....}-{0:0}, at: process_scheduled_works+0x161/0x8a0
[  955.860911]  #1: ffffc9000633be60 
((work_completion)(&cgrp->bpf.release_work)){....}-{0:0}, at: 
process_scheduled_0
[  955.861286]  #2: ffffffff83e5ab88 (cgroup_mutex){....}-{3:3}, at: 
cgroup_bpf_release+0xcf/0x4d0
[  955.861811] 3 locks held by kworker/0:9/4491:

Regards,
Ridong

