Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E712F60D9
	for <lists+cgroups@lfdr.de>; Thu, 14 Jan 2021 13:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbhANMNp (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 07:13:45 -0500
Received: from foss.arm.com ([217.140.110.172]:48906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbhANMNp (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 14 Jan 2021 07:13:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C8FAED1;
        Thu, 14 Jan 2021 04:12:59 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99AF83F719;
        Thu, 14 Jan 2021 04:12:56 -0800 (PST)
Subject: Re: [PATCH 3/6] sched/deadline: Allow DL tasks on empty (cgroup v2)
 cpusets
To:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Marco Perronet <perronet@mpi-sws.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        cgroups@vger.kernel.org
References: <cover.1610463999.git.bristot@redhat.com>
 <8380113688bd64a6deb3241ff6a0fff62b157f47.1610463999.git.bristot@redhat.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <17db52d5-9967-969f-de03-ae6aec03c53e@arm.com>
Date:   Thu, 14 Jan 2021 13:12:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8380113688bd64a6deb3241ff6a0fff62b157f47.1610463999.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 12/01/2021 16:53, Daniel Bristot de Oliveira wrote:
> cgroups v2 allows the cpuset controller to be enabled/disabled on
> demand. On Fedora 32, cpuset is disabled by default. To enable it,
> a user needs to:
> 
>   # cd /sys/fs/cgroup/
>   # echo +cpuset > cgroup.subtree_control
> 
> Existing cgroups will expose the cpuset interface (e.g., cpuset.cpus
> file). By default, cpuset.cpus has no CPU assigned, which means that
> existing tasks will move to a cpuset without cpus.
> 
> With that in mind, look what happens if a SCHED_DEADLINE task exists
> on any cgroup (user.slice by default on Fedora):
> 
> ----- %< -----
>   # chrt -d --sched-period 1000000000 --sched-runtime 100000000 0 sleep 100 &

Like you mentioned above, to see the issue the DL task has to be moved
into the cgroup (e.g. user.slice) here:

echo $PID > /sys/fs/cgroup/user.slice/cgroup.procs

>   # cd /sys/fs/cgroup/
>   # echo '+cpuset' > cgroup.subtree_control
>   [   65.384041] BUG: unable to handle page fault for address: ffffffffb720f7e0
>   [   65.384551] #PF: supervisor read access in kernel mode
>   [   65.384923] #PF: error_code(0x0000) - not-present page
>   [   65.385298] PGD 61a15067 P4D 61a15067 PUD 61a16063 PMD 800fffff9ddff062
>   [   65.385781] Oops: 0000 [#1] SMP PTI
>   [   65.386042] CPU: 0 PID: 799 Comm: sh Not tainted 5.10.0-rc3 #1
>   [   65.386461] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
>   [   65.387077] RIP: 0010:dl_task_can_attach+0x40/0x250
>   [   65.387429] Code: 54 55 53 48 83 ec 18 48 89 3c 24 bf ff ff ff ff e8 05 a2 52 00
>                        4c 63 f0 48 c7 c5 00 9e 02 00 4a 8b 04 f5 00 09 47 b6 48 89 ea
>                        <4c> 8b a4 10 e0 09 00 00 49 8d 44 24 40 48 89 c7 48 89 44 24
>                        08 e8
>   [   65.388768] RSP: 0018:ffffaee8c056fcd8 EFLAGS: 00010283
>   [   65.389148] RAX: ffffffffb71e5000 RBX: ffffaee8c056fdd0 RCX: 0000000000000040
>   [   65.389661] RDX: 0000000000029e00 RSI: ffff9db202534e48 RDI: ffffffffb6d3a3e0
>   [   65.390174] RBP: 0000000000029e00 R08: 0000000000000000 R09: 0000000000000004
>   [   65.390686] R10: 0000000000000001 R11: 00000000ffa6fbff R12: ffffaee8c056fbf0
>   [   65.391196] R13: ffff9db2024e1400 R14: 0000000000000004 R15: ffff9db20ebb31e0
>   [   65.391710] FS:  00007f6df41b1740(0000) GS:ffff9db377c00000(0000) knlGS:0000000000000000
>   [   65.392289] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [   65.392705] CR2: ffffffffb720f7e0 CR3: 000000010680a003 CR4: 0000000000370ef0
>   [   65.393220] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>   [   65.393732] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>   [   65.394244] Call Trace:
>   [   65.394437]  cpuset_can_attach+0x8b/0x110
>   [   65.394732]  cgroup_migrate_execute+0x70/0x430
>   [   65.395057]  cgroup_update_dfl_csses+0x222/0x230
>   [   65.395392]  cgroup_subtree_control_write+0x2c6/0x3c0
>   [   65.395759]  kernfs_fop_write+0xce/0x1b0
>   [   65.396048]  vfs_write+0xc2/0x230
>   [   65.396291]  ksys_write+0x4f/0xc0
>   [   65.396533]  do_syscall_64+0x33/0x40
>   [   65.396797]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>   [   65.397166] RIP: 0033:0x7f6df42a6537
>   [   65.397428] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f
>                        1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05
>                        <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89
>                        74 24
>   [   65.398766] RSP: 002b:00007ffee4128018 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
>   [   65.399838] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f6df42a6537
>   [   65.400923] RDX: 0000000000000008 RSI: 000055b3f7e549e0 RDI: 0000000000000001
>   [   65.402003] RBP: 000055b3f7e549e0 R08: 000000000000000a R09: 0000000000000007
>   [   65.403082] R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000000008
>   [   65.404156] R13: 00007f6df4378500 R14: 0000000000000008 R15: 00007f6df4378700
>   [   65.405218] Modules linked in: <lots of modules>
>   [   65.414172] CR2: ffffffffb720f7e0
>   [   65.415117] ---[ end trace 2dbff1a688549e65 ]---
> ----- >% -----
> 
> That happens because on dl_task_can_attach():
>         dest_cpu = cpumask_any_and(cpu_active_mask, cs_cpus_allowed);
> 
> returns a non active cpu.

Since cs_cpus_allowed is empty dest_cpu should be an invalid CPU (>=
nr_cpu_ids) here.

> Initially, I thought about returning an error and blocking the
> operation. However, that is indeed not needed. The cpuset without
> CPUs assigned will be a non-root cpuset, hence its cpu mask will
> be the same as the root one. So, the bandwidth was already accounted,
> and the task can proceed.

LGTM.

After the '/sys/fs/cgroup# echo '+cpuset' > cgroup.subtree_control':

root's cpuset.cpus.effective == user.slice's cpuset.cpus.effective

> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> ---
>  kernel/sched/deadline.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 943aa32cc1bc..788a391657a5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2871,6 +2871,13 @@ int dl_task_can_attach(struct task_struct *p,
>  	bool overflow;
>  	int ret;
>  
> +	/*
> +	 * The cpuset has no cpus assigned, so the thread will not
> +	 * change its affinity.
> +	 */
> +	if (cpumask_empty(cs_cpus_allowed))
> +		return 0;
> +
>  	/*
>  	 * The task is not moving to another root domain, so it is
>  	 * already accounted.
> 
