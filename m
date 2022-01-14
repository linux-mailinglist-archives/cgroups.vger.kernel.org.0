Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD4F48E20E
	for <lists+cgroups@lfdr.de>; Fri, 14 Jan 2022 02:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235783AbiANBPL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 13 Jan 2022 20:15:11 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:30276 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiANBPL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 13 Jan 2022 20:15:11 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JZjxv121Wzbjxn;
        Fri, 14 Jan 2022 09:14:27 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 09:15:07 +0800
Received: from [10.67.111.186] (10.67.111.186) by
 dggpeml500018.china.huawei.com (7.185.36.186) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 09:15:07 +0800
Message-ID: <4415cd09-6de3-bb2d-386d-8beb4927fb46@huawei.com>
Date:   Fri, 14 Jan 2022 09:15:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
From:   Zhang Qiao <zhangqiao22@huawei.com>
Subject: [Question] set_cpus_allowed_ptr() call failed at cpuset_attach()
References: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
To:     Tejun Heo <tj@kernel.org>, <lizefan.x@bytedance.com>,
        <hannes@cmpxchg.org>
CC:     <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <09ce5796-798e-83d0-f1a6-ba38a787bfc5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.186]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


Hello everyone

	I found the following warning log on qemu. I migrated a task from one cpuset cgroup to
another, while I also performed the cpu hotplug operation, and got following calltrace.

	This may lead to a inconsistency between the affinity of the task and cpuset.cpus of the
dest cpuset, but this task can be successfully migrated to the dest cpuset cgroup.

	Can we use cpus_read_lock()/cpus_read_unlock() to guarantee that set_cpus_allowed_ptr()
doesn't fail, as follows:

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d0e163a02099..2535d23d2c51 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2265,6 +2265,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
        guarantee_online_mems(cs, &cpuset_attach_nodemask_to);

        cgroup_taskset_for_each(task, css, tset) {
+               cpus_read_lock();
                if (cs != &top_cpuset)
                        guarantee_online_cpus(task, cpus_attach);
                else
@@ -2274,6 +2275,7 @@ static void cpuset_attach(struct cgroup_taskset *tset)
                 * fail.  TODO: have a better way to handle failure here
                 */
                WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpus_attach));
+               cpus_read_unlock();


	Is there a better solution?

	Thanks

log:
[   43.853794] ------------[ cut here ]------------
[   43.853798] WARNING: CPU: 7 PID: 463 at ../kernel/cgroup/cpuset.c:2279 cpuset_attach+0xee/0x1f0
[   43.853806] Modules linked in:
[   43.853807] CPU: 7 PID: 463 Comm: bash Not tainted 5.16.0-rc4+ #10
[   43.853810] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
[   43.853811] RIP: 0010:cpuset_attach+0xee/0x1f0
[   43.853814] Code: ff ff 48 85 c0 48 89 c3 74 24 48 81 fd 40 42 54 82 75 96 80 bb 38 07 00 00 6f 48 8b 05 93 b3 55 01 48 89 05 bc 05 bb 01 75 97 <0f> 0b eb b3 48 8b 85 e8 00 00 00 48 85
[   43.853816] RSP: 0018:ffffc90000623c30 EFLAGS: 00010246
[   43.853818] RAX: 0000000000000000 RBX: ffff888101f39c80 RCX: 0000000000000001
[   43.853819] RDX: 0000000000007fff RSI: ffffffff82cd5708 RDI: ffff888101f39c80
[   43.853821] RBP: ffff8881001afe00 R08: 0000000000000000 R09: ffffc90000623d00
[   43.853822] R10: ffffc900000a3de8 R11: 0000000000000001 R12: ffffc90000623cf0
[   43.853823] R13: ffffffff82cd56d0 R14: ffffffff82544240 R15: 0000000000000001
[   43.853824] FS:  00007f012414d740(0000) GS:ffff8882b5bc0000(0000) knlGS:0000000000000000
[   43.853828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   43.853829] CR2: 000055cfdb27de28 CR3: 00000001020cc000 CR4: 00000000000006e0
[   43.853830] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   43.853831] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   43.853832] Call Trace:
[   43.853846]  <TASK>
[   43.853848]  cgroup_migrate_execute+0x319/0x410
[   43.853853]  cgroup_attach_task+0x159/0x200
[   43.853857]  ? __cgroup1_procs_write.constprop.21+0x10d/0x170
[   43.853858]  __cgroup1_procs_write.constprop.21+0x10d/0x170
[   43.853860]  cgroup_file_write+0x65/0x160
[   43.853863]  kernfs_fop_write_iter+0x12a/0x1a0
[   43.853870]  new_sync_write+0x11d/0x1b0
[   43.853877]  vfs_write+0x232/0x290
[   43.853880]  ksys_write+0x9c/0xd0
[   43.853882]  ? fpregs_assert_state_consistent+0x19/0x40
[   43.853886]  do_syscall_64+0x3a/0x80
[   43.853896]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   43.853902] RIP: 0033:0x7f012381f224
[   43.853904] Code: 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 8d 05 c1 07 2e 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 f3 c3 66 90 45
[   43.853906] RSP: 002b:00007ffd3f411f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   43.853908] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f012381f224
[   43.853909] RDX: 0000000000000004 RSI: 000055cfdb297a70 RDI: 0000000000000001
[   43.853910] RBP: 000055cfdb297a70 R08: 000000000000000a R09: 0000000000000003
[   43.853911] R10: 000000000000000a R11: 0000000000000246 R12: 00007f0123afb760
[   43.853913] R13: 0000000000000004 R14: 00007f0123af72a0 R15: 00007f0123af6760
[   43.853914]  </TASK>
[   43.853915] ---[ end trace 8292bcee7ea90403 ]---
