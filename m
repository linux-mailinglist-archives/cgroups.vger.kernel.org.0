Return-Path: <cgroups+bounces-10616-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C057BC94D4
	for <lists+cgroups@lfdr.de>; Thu, 09 Oct 2025 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 739A919E83EA
	for <lists+cgroups@lfdr.de>; Thu,  9 Oct 2025 13:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604902557A;
	Thu,  9 Oct 2025 13:30:11 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C5282EB;
	Thu,  9 Oct 2025 13:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760016611; cv=none; b=OkmbcPzg54uiybGq80gKCr3dPs0DTZqZ4fKUKhP2WBK38GkNtMdlNXuWtMLGFRVRStM78CUUubhFBeK7pzBjCuU3g7GOZmOSy9O4KmROeL7y2WpJpeSIJe3RHiNagmJFg78zgNaLVe8Fv6oDSjj42u8/x+m6qpl2F+Js6SHBx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760016611; c=relaxed/simple;
	bh=N7HoqQExRcLPi/a/OT37UWSWJ51fMskEpk6eCLaiU/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7MRPYQZPzqQ5sVPbcwolbJYIMTvsFV1LmwYQabpIwNy4rxhFifzXnbe61M/X7goskd1PRIVzHM+5+o9t6tfmmtaXI7lDcurKZRHSJUQboSJkjzAT2JHCXW3hel0LBip3fEph2HZsW9uKO3yMh8OpNjGQlDUDKqYfnc2553XWdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 197C0176A;
	Thu,  9 Oct 2025 06:30:00 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91F893F59E;
	Thu,  9 Oct 2025 06:30:04 -0700 (PDT)
Message-ID: <02452879-8998-47e0-9679-d2ff00503901@arm.com>
Date: Thu, 9 Oct 2025 15:30:02 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] sched: Fold sched_class::switch{ing,ed}_{to,from}()
 into the change pattern
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, longman@redhat.com,
 hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com,
 changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev,
 liuwenfang@honor.com, tglx@linutronix.de
References: <20251006104402.946760805@infradead.org>
 <20251006104526.861755244@infradead.org>
Content-Language: en-GB
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20251006104526.861755244@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06.10.25 12:44, Peter Zijlstra wrote:
> Add {DE,EN}QUEUE_CLASS and fold the sched_class::switch* methods into
> the change pattern. This completes and makes the pattern more
> symmetric.
> 
> This changes the order of callbacks slightly:
> 
> 				|
> 				|  switching_from()
>   dequeue_task();		|  dequeue_task()
>   put_prev_task();		|  put_prev_task()
> 				|  switched_from()
> 				|
>   ... change task ...		|  ... change task ...
> 				|
>   switching_to();		|  switching_to()
>   enqueue_task();		|  enqueue_task()
>   set_next_task();		|  set_next_task()
>   prev_class->switched_from()	|
>   switched_to()			|  switched_to()
> 				|
> 
> Notably, it moves the switched_from() callback right after the
> dequeue/put. Existing implementations don't appear to be affected by
> this change in location -- specifically the task isn't enqueued on the
> class in question in either location.
> 
> Make (CLASS)^(SAVE|MOVE), because there is nothing to save-restore
> when changing scheduling classes.

This one causes a DL bw related warning when I run a simple 1 DL task
rt-app workload:

# rt-app ./rt-app/dl10.json 

[rt-app] <notice> thread_data_set_unique_name 0 thread0-0
[rt-app] <notice> [0] starting thread ...

[rt-app] <notice> [0] Starting with SCHED_DEADLINE policy with priority 0
[   16.390272] sched: DL replenish lagged too much
[   16.390327] ------------[ cut here ]------------
[   16.390329] WARNING: CPU: 2 PID: 591 at kernel/sched/deadline.c:239 sub_running_bw.isra.0+0xf4/0x150
[   16.391849] Modules linked in:
[   16.392107] CPU: 2 UID: 0 PID: 591 Comm: thread0-0 Not tainted 6.17.0-rc4-00020-ga6b63e5ce187 #46 PREEMPT 
[   16.392885] Hardware name: linux,dummy-virt (DT)
[   16.393265] pstate: 014000c5 (nzcv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   16.393783] pc : sub_running_bw.isra.0+0xf4/0x150
[   16.394153] lr : sub_running_bw.isra.0+0x118/0x150
[   16.394636] sp : ffff80008137bb10
[   16.394864] x29: ffff80008137bb10 x28: ffff0000ff7b39c0 x27: ffff0000ce73dd60
[   16.395333] x26: 0000000000000000 x25: ffffa1134d945000 x24: ffff0000ff7b42c8
[   16.395805] x23: ffffa1134d944000 x22: ffffa1134d944000 x21: 000000000000cccc
[   16.396267] x20: 0000000000060000 x19: ffff0000ff7b42c8 x18: fffffffffffe6f58
[   16.396742] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
[   16.397202] x14: fffffffffffc6f57 x13: 0a6863756d206f6f x12: ffffa1134e743f60
[   16.397674] x11: 00000000000000c0 x10: 0000000000000001 x9 : 0000000000000000
[   16.398130] x8 : ffff0000c001e490 x7 : 0000000000000008 x6 : ffff0000c0029968
[   16.398883] x5 : 00000000ffffffff x4 : 0000000000000064 x3 : ffff0000c0029fa8
[   16.399432] x2 : ffff5eedb1f6e000 x1 : 000000000000cccc x0 : fffffffffffacccc
[   16.399962] Call trace:
[   16.400147]  sub_running_bw.isra.0+0xf4/0x150 (P)
[   16.400510]  task_non_contending+0x248/0x2ac
[   16.400831]  dequeue_task_dl+0x178/0x2d4
[   16.401122]  __schedule+0x6ac/0x1038
[   16.401401]  schedule+0x4c/0x164
[   16.401627]  do_nanosleep+0x6c/0x190
[   16.401862]  hrtimer_nanosleep+0xbc/0x200
[   16.402156]  common_nsleep_timens+0x50/0x90
[   16.402522]  __arm64_sys_clock_nanosleep+0xd0/0x150
[   16.402813]  invoke_syscall+0x48/0x104
[   16.403043]  el0_svc_common.constprop.0+0x40/0xe0
[   16.403327]  do_el0_svc+0x1c/0x28
[   16.403520]  el0_svc+0x4c/0x160
[   16.403711]  el0t_64_sync_handler+0xa0/0xf0
[   16.403950]  el0t_64_sync+0x198/0x19c
[   16.404226] irq event stamp: 196
[   16.404451] hardirqs last  enabled at (195): [<ffffa1134c8021d8>] _raw_spin_unlock_irqrestore+0x6c/0x74
[   16.405086] hardirqs last disabled at (196): [<ffffa1134c7f7850>] __schedule+0x4e8/0x1038
[   16.405629] softirqs last  enabled at (154): [<ffffa1134b4e157c>] handle_softirqs+0x44c/0x498
[   16.406218] softirqs last disabled at (145): [<ffffa1134b410774>] __do_softirq+0x14/0x20

with extra logging and removing underflow WARN_ON_ONCE:

# rt-app ./rt-app/dl10.json 

[rt-app] <notice> thread_data_set_unique_name 0 thread0-0
[rt-app] <notice> [0] starting thread ...

[rt-app] <notice> [0] Starting with SCHED_DEADLINE policy with priority 0
[   18.494469] sched: DL replenish lagged too much
[   18.494483] cpu=3 p->comm=thread0-0 p->pid=592
               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[   18.494486] __sub_running_bw() cpu=3 dl_rq->running_bw=18446744073709210828 dl_bw=393216 old=52428
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                        dl_rq->running_bw underflow in task_non_contending()

[   18.494492] CPU: 3 UID: 0 PID: 592 Comm: thread0-0 Not tainted 6.17.0-rc4-00020-ga6b63e5ce187-dirty #44 PREEMPT 
[   18.494495] Hardware name: linux,dummy-virt (DT)
[   18.494497] Call trace:
[   18.494498]  show_stack+0x18/0x24 (C)
[   18.494510]  dump_stack_lvl+0x70/0x98
[   18.494514]  dump_stack+0x18/0x24
[   18.494516]  sub_running_bw.isra.0+0x164/0x180
[   18.494539]  task_non_contending+0x298/0x2e8
[   18.494541]  dequeue_task_dl+0x188/0x31c
[   18.494544]  __schedule+0x6ac/0x1038
[   18.494574]  schedule+0x4c/0x164
[   18.494578]  do_nanosleep+0x6c/0x190
[   18.494580]  hrtimer_nanosleep+0xbc/0x200
[   18.494594]  common_nsleep_timens+0x50/0x90
[   18.494599]  __arm64_sys_clock_nanosleep+0xd0/0x150
[   18.494602]  invoke_syscall+0x48/0x104
[   18.494610]  el0_svc_common.constprop.0+0x40/0xe0
[   18.494612]  do_el0_svc+0x1c/0x28
[   18.494615]  el0_svc+0x4c/0x160
[   18.494617]  el0t_64_sync_handler+0xa0/0xf0
[   18.494620]  el0t_64_sync+0x198/0x19c

Not sure yet how this is related to switched_from_dl() being now called earlier?

[...]

