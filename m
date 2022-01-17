Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7C1490030
	for <lists+cgroups@lfdr.de>; Mon, 17 Jan 2022 03:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiAQCZ1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 16 Jan 2022 21:25:27 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:31092 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbiAQCZ1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sun, 16 Jan 2022 21:25:27 -0500
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JcbJ64ftSz1FCgs;
        Mon, 17 Jan 2022 10:21:42 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 10:25:24 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 10:25:24 +0800
Message-ID: <c618f413-8b58-d1d8-3129-bb5624fc140a@huawei.com>
Date:   Mon, 17 Jan 2022 10:25:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [Question] set_cpus_allowed_ptr() call failed at cpuset_attach()
To:     Waiman Long <longman@redhat.com>
CC:     <lizefan.x@bytedance.com>, <hannes@cmpxchg.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>
References: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
 <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
 <YeGi2yjRi/uZIF/2@slm.duckdns.org>
 <8bda2a8d-7faf-621d-c3c0-6351a49219ea@redhat.com>
From:   Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <8bda2a8d-7faf-621d-c3c0-6351a49219ea@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

hello

在 2022/1/15 4:33, Waiman Long 写道:
> On 1/14/22 11:20, Tejun Heo wrote:
>> (cc'ing Waiman and Michal and quoting whole body)
>>
>> Seems sane to me but let's hear what Waiman and Michal think.
>>
>> On Fri, Jan 14, 2022 at 09:15:06AM +0800, Zhang Qiao wrote:
>>> Hello everyone
>>>
>>>     I found the following warning log on qemu. I migrated a task from one cpuset cgroup to
>>> another, while I also performed the cpu hotplug operation, and got following calltrace.
>>>
>>>     This may lead to a inconsistency between the affinity of the task and cpuset.cpus of the
>>> dest cpuset, but this task can be successfully migrated to the dest cpuset cgroup.
>>>
>>>     Can we use cpus_read_lock()/cpus_read_unlock() to guarantee that set_cpus_allowed_ptr()
>>> doesn't fail, as follows:
>>>
>>> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
>>> index d0e163a02099..2535d23d2c51 100644
>>> --- a/kernel/cgroup/cpuset.c
>>> +++ b/kernel/cgroup/cpuset.c
>>> @@ -2265,6 +2265,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>>          guarantee_online_mems(cs, &cpuset_attach_nodemask_to);
>>>
>>>          cgroup_taskset_for_each(task, css, tset) {
>>> +               cpus_read_lock();
>>>                  if (cs != &top_cpuset)
>>>                          guarantee_online_cpus(task, cpus_attach);
>>>                  else
>>> @@ -2274,6 +2275,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
>>>                   * fail.  TODO: have a better way to handle failure here
>>>                   */
>>>                  WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
>>> +               cpus_read_unlock();
>>>
>>>
>>>     Is there a better solution?
>>>
>>>     Thanks
> 
> The change looks OK to me. However, we may need to run the full set of regression test to make sure that lockdep won't complain about potential deadlock.
> 
I run the test with lockdep enabled, and got lockdep warning like that below.
so we should take the cpu_hotplug_lock first, then take the cpuset_rwsem lock.

thanks,
Zhang Qiao

[   38.420372] ======================================================
[   38.421339] WARNING: possible circular locking dependency detected
[   38.422312] 5.16.0-rc4+ #13 Not tainted
[   38.422920] ------------------------------------------------------
[   38.423883] bash/594 is trying to acquire lock:
[   38.424595] ffffffff8286afc0 (cpu_hotplug_lock){++++}-{0:0}, at: cpuset_attach+0xc2/0x1e0
[   38.425880]
[   38.425880] but task is already holding lock:
[   38.426787] ffffffff8296a5a0 (&cpuset_rwsem){++++}-{0:0}, at: cpuset_attach+0x3e/0x1e0
[   38.428015]
[   38.428015] which lock already depends on the new lock.
[   38.428015]
[   38.429279]
[   38.429279] the existing dependency chain (in reverse order) is:
[   38.430445]
[   38.430445] -> #1 (&cpuset_rwsem){++++}-{0:0}:
[   38.431371]        percpu_down_write+0x42/0x130
[   38.432085]        cpuset_css_online+0x2b/0x2e0
[   38.432808]        online_css+0x24/0x80
[   38.433411]        cgroup_apply_control_enable+0x2fa/0x330
[   38.434273]        cgroup_mkdir+0x396/0x4c0
[   38.434930]        kernfs_iop_mkdir+0x56/0x80
[   38.435614]        vfs_mkdir+0xde/0x190
[   38.436220]        do_mkdirat+0x7d/0xf0
[   38.436824]        __x64_sys_mkdir+0x21/0x30
[   38.437495]        do_syscall_64+0x3a/0x80
[   38.438145]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   38.439015]
[   38.439015] -> #0 (cpu_hotplug_lock){++++}-{0:0}:
[   38.439980]        __lock_acquire+0x17f6/0x2260
[   38.440691]        lock_acquire+0x277/0x320
[   38.441347]        cpus_read_lock+0x37/0xc0
[   38.442011]        cpuset_attach+0xc2/0x1e0
[   38.442671]        cgroup_migrate_execute+0x3a6/0x490
[   38.443461]        cgroup_attach_task+0x22c/0x3d0
[   38.444197]        __cgroup1_procs_write.constprop.21+0x10d/0x170
[   38.445145]        cgroup_file_write+0x6f/0x230
[   38.445860]        kernfs_fop_write_iter+0x130/0x1b0
[   38.446636]        new_sync_write+0x120/0x1b0
[   38.447319]        vfs_write+0x359/0x3b0
[   38.447937]        ksys_write+0xa2/0xe0
[   38.448540]        do_syscall_64+0x3a/0x80
[   38.449183]        entry_SYSCALL_64_after_hwframe+0x44/0xae
[   38.450057]
[   38.450057] other info that might help us debug this:
[   38.450057]
[   38.451297]  Possible unsafe locking scenario:
[   38.451297]
[   38.452218]        CPU0                    CPU1
[   38.452935]        ----                    ----
[   38.453650]   lock(&cpuset_rwsem);
[   38.454188]                                lock(cpu_hotplug_lock);
[   38.455148]                                lock(&cpuset_rwsem);
[   38.456069]   lock(cpu_hotplug_lock);
[   38.456645]
[   38.456645]  *** DEADLOCK ***
[   38.456645]
[   38.457572] 5 locks held by bash/594:
[   38.458156]  #0: ffff888100d67470 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0xa2/0xe0
[   38.459392]  #1: ffff888100d06290 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xfe/0x1b0
[   38.460761]  #2: ffffffff82967330 (cgroup_mutex){+.+.}-{4:4}, at: cgroup_kn_lock_live+0xcf/0x1d0
[   38.462137]  #3: ffffffff82967100 (cgroup_threadgroup_rwsem){++++}-{0:0}, at: cgroup_procs_write_start+0x78/0x240
[   38.463749]  #4: ffffffff8296a5a0 (&cpuset_rwsem){++++}-{0:0}, at: cpuset_attach+0x3e/0x1e0
[   38.465052]
[   38.465052] stack backtrace:
[   38.465747] CPU: 0 PID: 594 Comm: bash Not tainted 5.16.0-rc4+ #13
[   38.466712] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[   38.468507] Call Trace:
[   38.468900]  <TASK>
[   38.469241]  dump_stack_lvl+0x56/0x7b
[   38.469827]  check_noncircular+0x126/0x140
[   38.470476]  ? __lock_acquire+0x17f6/0x2260
[   38.471136]  __lock_acquire+0x17f6/0x2260
[   38.471772]  lock_acquire+0x277/0x320
[   38.472352]  ? cpuset_attach+0xc2/0x1e0
[   38.472961]  cpus_read_lock+0x37/0xc0
[   38.473550]  ? cpuset_attach+0xc2/0x1e0
[   38.474159]  cpuset_attach+0xc2/0x1e0
[   38.474742]  cgroup_migrate_execute+0x3a6/0x490
[   38.475457]  cgroup_attach_task+0x22c/0x3d0
[   38.476121]  ? __cgroup1_procs_write.constprop.21+0x10d/0x170
[   38.477021]  __cgroup1_procs_write.constprop.21+0x10d/0x170
[   38.477904]  cgroup_file_write+0x6f/0x230
[   38.478540]  kernfs_fop_write_iter+0x130/0x1b0
[   38.479241]  new_sync_write+0x120/0x1b0
[   38.479849]  vfs_write+0x359/0x3b0
[   38.480391]  ksys_write+0xa2/0xe0
[   38.480920]  do_syscall_64+0x3a/0x80
[   38.481488]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   38.482289] RIP: 0033:0x7f229f42b224
[   38.482857] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 45
[   38.485758] RSP: 002b:00007fffaa3eadd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   38.486937] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f229f42b224
[   38.488051] RDX: 0000000000000004 RSI: 0000562679dc5410 RDI: 0000000000000001
[   38.489164] RBP: 0000562679dc5410 R08: 000000000000000a R09: 0000000000000003
[   38.490282] R10: 000000000000000a R11: 0000000000000246 R12: 00007f229f707760
[   38.491395] R13: 0000000000000004 R14: 00007f229f7032a0 R15: 00007f229f702760
[   38.492516]  </TASK>


> Cheers,
> Longman
> 
> .
