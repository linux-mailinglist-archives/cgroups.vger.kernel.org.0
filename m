Return-Path: <cgroups+bounces-10260-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF2B858A0
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 17:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64681B246B4
	for <lists+cgroups@lfdr.de>; Thu, 18 Sep 2025 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84A30CB27;
	Thu, 18 Sep 2025 15:15:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3554238C03;
	Thu, 18 Sep 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758208553; cv=none; b=reozKYxYo9gL1p+bguWCI8kYUKslQRzVlpzM0fbEZ0EpeRTO/dchlxx9Qn5q96HAfPiyazTxb+G+VGEKgpeOGIMehFjQ2ahmNIzIAwg78Mfz8chm47d5U5GcqJGrDp0ZO4pId2fjDoOzzmrHEbU2EfUk8fPptFs3W+J08agYjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758208553; c=relaxed/simple;
	bh=QG5FFQCxXGaQzcMssCNYE2pAQd10n1EQxwi0VVDiW8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qasQd8ILCDCQodv+SCBXAJKkkMd8pvQSNJHzgkoQjFHumoDIYW+9UtHlb6adzpemSd3FW7C2LHmbdPK6GMJtMaYkFi6UMZTHYDhbEL0hqlhUFKlQCv6pPoAy/+giVjyafvSQYmLfZ2qstHh/PIU6/lf7DfuFAtp8YrNWwi1MLCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C70C61764;
	Thu, 18 Sep 2025 08:15:42 -0700 (PDT)
Received: from [10.1.32.55] (e127648.arm.com [10.1.32.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62A2E3F66E;
	Thu, 18 Sep 2025 08:15:47 -0700 (PDT)
Message-ID: <02811bd7-b401-4e16-bb7d-4edeb0b89ffd@arm.com>
Date: Thu, 18 Sep 2025 16:15:45 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] sched: Support shared runqueue locking
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
References: <20250910154409.446470175@infradead.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20250910154409.446470175@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/25 16:44, Peter Zijlstra wrote:
> Hi,
> 
> As mentioned [1], a fair amount of sched ext weirdness (current and proposed)
> is down to the core code not quite working right for shared runqueue stuff.
> 
> Instead of endlessly hacking around that, bite the bullet and fix it all up.
> 
> With these patches, it should be possible to clean up pick_task_scx() to not
> rely on balance_scx(). Additionally it should be possible to fix that RT issue,
> and the dl_server issue without further propagating lock breaks.
> 
> As is, these patches boot and run/pass selftests/sched_ext with lockdep on.
> 
> I meant to do more sched_ext cleanups, but since this has all already taken
> longer than I would've liked (real life interrupted :/), I figured I should
> post this as is and let TJ/Andrea poke at it.
> 
> Patches are also available at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
> 
> 
> [1] https://lkml.kernel.org/r/20250904202858.GN4068168@noisy.programming.kicks-ass.net
> 
> 
> ---
>  include/linux/cleanup.h  |   5 +
>  include/linux/sched.h    |   6 +-
>  kernel/cgroup/cpuset.c   |   2 +-
>  kernel/kthread.c         |  15 +-
>  kernel/sched/core.c      | 370 +++++++++++++++++++++--------------------------
>  kernel/sched/deadline.c  |  26 ++--
>  kernel/sched/ext.c       | 104 +++++++------
>  kernel/sched/fair.c      |  23 ++-
>  kernel/sched/idle.c      |  14 +-
>  kernel/sched/rt.c        |  13 +-
>  kernel/sched/sched.h     | 225 ++++++++++++++++++++--------
>  kernel/sched/stats.h     |   2 +-
>  kernel/sched/stop_task.c |  14 +-
>  kernel/sched/syscalls.c  |  80 ++++------
>  14 files changed, 495 insertions(+), 404 deletions(-)
> 
> 

Hi Peter, A couple of issues popped up when testing this [1] (that don't trigger on [2]):

When booting (arm64 orion o6) I get:

[    1.298020] sched: DL replenish lagged too much
[    1.298364] ------------[ cut here ]------------
[    1.298377] WARNING: CPU: 4 PID: 0 at kernel/sched/deadline.c:239 inactive_task_timer+0x3d0/0x474
[    1.298413] Modules linked in:
[    1.298436] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G S                  6.17.0-rc4-cix-build+ #56 PREEMPT 
[    1.298455] Tainted: [S]=CPU_OUT_OF_SPEC
[    1.298463] Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Orion O6, BIOS 0.3.0-1 2025-04-28T03:35:34+00:00
[    1.298473] pstate: 034000c9 (nzcv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[    1.298486] pc : inactive_task_timer+0x3d0/0x474
[    1.298505] lr : inactive_task_timer+0x394/0x474
[    1.298522] sp : ffff800083d4be00
[    1.298530] x29: ffff800083d4be20 x28: ffff00008362d888 x27: ffff800082ab1f88
[    1.298561] x26: ffff800082ab4a98 x25: ffff0001fef50c18 x24: 0000000000019999
[    1.298589] x23: 000000000000cccc x22: ffff0001fef51708 x21: ffff00008362d640
[    1.298616] x20: ffff0001fef50c00 x19: ffff00008362d7f0 x18: fffffffffff0b580
[    1.298642] x17: ffff80017c966000 x16: ffff800083d48000 x15: 0000000000000028
[    1.298669] x14: 0000000000000000 x13: 00000000000c4000 x12: 00000000000000c5
[    1.298695] x11: 0000000000004bb8 x10: 0000000000004bb8 x9 : 0000000000000000
[    1.298722] x8 : 0000000000000000 x7 : 0000000000000011 x6 : ffff0001fef51bc0
[    1.298747] x5 : ffff0001fef50c00 x4 : 00000000000000cc x3 : 0000000000000000
[    1.298773] x2 : ffff80017c966000 x1 : 0000000000000000 x0 : ffffffffffff3333
[    1.298800] Call trace:
[    1.298808]  inactive_task_timer+0x3d0/0x474 (P)
[    1.298830]  __hrtimer_run_queues+0x3c4/0x440
[    1.298852]  hrtimer_interrupt+0xe4/0x244
[    1.298871]  arch_timer_handler_phys+0x2c/0x44
[    1.298893]  handle_percpu_devid_irq+0xa8/0x1f0
[    1.298916]  handle_irq_desc+0x40/0x58
[    1.298933]  generic_handle_domain_irq+0x1c/0x28
[    1.298950]  gic_handle_irq+0x4c/0x11c
[    1.298965]  call_on_irq_stack+0x30/0x48
[    1.298982]  do_interrupt_handler+0x80/0x84
[    1.299001]  el1_interrupt+0x34/0x64
[    1.299022]  el1h_64_irq_handler+0x18/0x24
[    1.299037]  el1h_64_irq+0x6c/0x70
[    1.299052]  finish_task_switch.isra.0+0xac/0x2bc (P)
[    1.299070]  __schedule+0x45c/0xffc
[    1.299088]  schedule_idle+0x28/0x48
[    1.299104]  do_idle+0x184/0x27c
[    1.299121]  cpu_startup_entry+0x34/0x3c
[    1.299137]  secondary_start_kernel+0x134/0x154
[    1.299158]  __secondary_switched+0xc0/0xc4
[    1.299179] irq event stamp: 1634
[    1.299189] hardirqs last  enabled at (1633): [<ffff800081486354>] el1_interrupt+0x54/0x64
[    1.299210] hardirqs last disabled at (1634): [<ffff800081486324>] el1_interrupt+0x24/0x64
[    1.299229] softirqs last  enabled at (1614): [<ffff8000800bf7b0>] handle_softirqs+0x4a0/0x4b8
[    1.299248] softirqs last disabled at (1609): [<ffff800080010600>] __do_softirq+0x14/0x20
[    1.299262] ---[ end trace 0000000000000000 ]---

and when running actual tests (e.g. iterating through all scx schedulers under load):

[  146.532691] ================================                                                                                                                                                                                                                                    
[  146.536947] WARNING: inconsistent lock state                                                                                                                                                                                                                                    
[  146.541204] 6.17.0-rc4-cix-build+ #58 Tainted: G S      W                                                                                                                                                                                                                       
[  146.547457] --------------------------------                                                                                                                                                                                                                                    
[  146.551713] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.                                                                                                                                                                                                                
[  146.557705] rcu_tasks_trace/79 [HC0[0]:SC0[0]:HE0:SE1] takes:                                                                                                                                                                                                                   
[  146.563438] ffff000089c90e58 (&dsq->lock){?.-.}-{2:2}, at: __task_rq_lock+0x88/0x194                                                                                                                                                                                            
[  146.571179] {IN-HARDIRQ-W} state was registered at:                                                                                                                                                                                                                             
[  146.576042]   lock_acquire+0x1c8/0x338                                                                                                                                                                                                                                          
[  146.579788]   _raw_spin_lock+0x48/0x60                                                                                                                                                                                                                                          
[  146.583536]   dispatch_enqueue+0x130/0x3e8                                                                                                                                                                                                                                      
[  146.587632]   do_enqueue_task+0x2f0/0x464                                                                                                                                                                                                                                       
[  146.591629]   enqueue_task_scx+0x1b0/0x290                                                                                                                                                                                                                                      
[  146.595712]   enqueue_task+0x84/0x18c                                                                                                                                                                                                                                           
[  146.599360]   ttwu_do_activate+0x84/0x25c                                                                                                                                                                                                                                       
[  146.603361]   try_to_wake_up+0x310/0x5f8                                                                                                                                                                                                                                        
[  146.607271]   wake_up_process+0x18/0x24                                                                                                                                                                                                                                         
[  146.611094]   kick_pool+0x9c/0x17c                                                                                                                                                                                                                                              
[  146.614483]   __queue_work+0x544/0x7a8                                                                                                                                                                                                                                          
[  146.618223]   __queue_delayed_work+0x118/0x15c                                                                                                                                                                                                                                  
[  146.622653]   mod_delayed_work_on+0xcc/0xe0                                                                                                                                                                                                                                     
[  146.626823]   kblockd_mod_delayed_work_on+0x20/0x30                                                                                                                                                                                                                             
[  146.631696]   blk_mq_kick_requeue_list+0x1c/0x28                                                                                                                                                                                                                                
[  146.636307]   blk_flush_complete_seq+0xd4/0x2a4                                                                                                                                                                                                                                 
[  146.640824]   flush_end_io+0x1e0/0x3f4                                                                                                                                                                                                                                          
[  146.644559]   blk_mq_end_request+0x60/0x154                                                                                                                                                                                                                                     
[  146.648733]   nvme_end_req+0x30/0x78                                                                                                                                                                                                                                            
[  146.652306]   nvme_complete_rq+0x7c/0x218                                                                                                                                                                                                                                       
[  146.656302]   nvme_pci_complete_rq+0x98/0x110                                                                                                                                                                                                                                   
[  146.660650]   nvme_poll_cq+0x1cc/0x3b4                                                                                                                                                                                                                                          
[  146.664385]   nvme_irq+0x34/0x88                                                                                                                                                                                                                                                
[  146.667600]   __handle_irq_event_percpu+0x88/0x304                                                                                                                                                                                                                              
[  146.672384]   handle_irq_event+0x4c/0xa8                                                                                                                                                                                                                                        
[  146.676293]   handle_fasteoi_irq+0x108/0x20c                                                                                                                                                                                                                                    
[  146.680555]   handle_irq_desc+0x40/0x58                                                                                                                                                                                                                                         
[  146.684378]   generic_handle_domain_irq+0x1c/0x28                                                                                                                                                                                                                               
[  146.689068]   gic_handle_irq+0x4c/0x11c                                                                                                                                                                                                                                         
[  146.692891]   call_on_irq_stack+0x30/0x48                                                                                                                                                                                                                                       
[  146.696891]   do_interrupt_handler+0x80/0x84                                                                                                                                                                                                                                    
[  146.701151]   el1_interrupt+0x34/0x64                                                                                                                                                                                                                                           
[  146.704810]   el1h_64_irq_handler+0x18/0x24                                                                                                                                                                                                                                     
[  146.708979]   el1h_64_irq+0x6c/0x70                                                                                                                                                                                                                                             
[  146.712453]   cpuidle_enter_state+0x12c/0x53c                                                                                                                                                                                                                                   
[  146.716796]   cpuidle_enter+0x38/0x50                                                                                                                                                                                                                                           
[  146.720458]   do_idle+0x204/0x27c                                                                                                                                                                                                                                               
[  146.723759]   cpu_startup_entry+0x38/0x3c                                                                                                                                                                                                                                       
[  146.727755]   secondary_start_kernel+0x134/0x154                                                                                                                                                                                                                                
[  146.732370]   __secondary_switched+0xc0/0xc4                                                                                                                                                                                                                                    
[  146.736638] irq event stamp: 1754                                                                                                                                                                                                                                               
[  146.739938] hardirqs last  enabled at (1753): [<ffff800081497184>] _raw_spin_unlock_irqrestore+0x6c/0x70                                                                                                                                                                        
[  146.749405] hardirqs last disabled at (1754): [<ffff8000814965e4>] _raw_spin_lock_irqsave+0x84/0x88                                                                                                                                                                             
[  146.758437] softirqs last  enabled at (1664): [<ffff800080195598>] rcu_tasks_invoke_cbs+0x100/0x394                                                                                                                                                                             
[  146.767476] softirqs last disabled at (1660): [<ffff800080195598>] rcu_tasks_invoke_cbs+0x100/0x394                                                                                                                                                                             
[  146.776506]                                                                                                                                                                                                                                                                     
[  146.776506] other info that might help us debug this:                                                                                                                                                                                                                           
[  146.783019]  Possible unsafe locking scenario:                                                                                                                                                                                                                                  
[  146.783019]                                                                                                                                                                                                                                                                     
[  146.788923]        CPU0                                                                                                                                                                                                                                                         
[  146.791356]        ----                                                                                                                                                                                                                                                         
[  146.793788]   lock(&dsq->lock);                                                                                                                                                                                                                                                 
[  146.796915]   <Interrupt>                                                                                                                                                                                                                                                       
[  146.799521]     lock(&dsq->lock);                                                                                                                                                                                                                                               
[  146.802821]                                                                                                                                                                                                                                                                     
[  146.802821]  *** DEADLOCK ***                                                                                                                                                                                                                                                   
[  146.802821]                                                                                                                                                                                                                                                                     
[  146.808725] 3 locks held by rcu_tasks_trace/79:                                                                                                                                                                                                                                 
[  146.813242]  #0: ffff800082e6e650 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x328/0x570                                                                                                                                                                
[  146.823403]  #1: ffff800082adc1f0 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c                                                                                                                                                                                  
[  146.832014]  #2: ffff000089c90e58 (&dsq->lock){?.-.}-{2:2}, at: __task_rq_lock+0x88/0x194                                                                                                                                                                                       
[  146.840178]                                                                                                                                                                                     
[  146.813242]  #0: ffff800082e6e650 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{4:4}, at: rcu_tasks_one_gp+0x328/0x570                                                                                                                                                                
[  146.823403]  #1: ffff800082adc1f0 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c                                                                                                                                                                                  
[  146.832014]  #2: ffff000089c90e58 (&dsq->lock){?.-.}-{2:2}, at: __task_rq_lock+0x88/0x194                                                                                                                                                                                       
[  146.840178] 

[  146.840178] stack backtrace:
[  146.844521] CPU: 10 UID: 0 PID: 79 Comm: rcu_tasks_trace Tainted: G S      W           6.17.0-rc4-cix-build+ #58 PREEMPT 
[  146.855463] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[  146.860240] Hardware name: Radxa Computer (Shenzhen) Co., Ltd. Radxa Orion O6/Radxa Orion O6, BIOS 0.3.0-1 2025-04-28T03:35:34+00:00
[  146.872136] Sched_ext: simple (enabled+all), task: runnable_at=-4ms
[  146.872138] Call trace:
[  146.880822]  show_stack+0x18/0x24 (C)
[  146.884471]  dump_stack_lvl+0x90/0xd0
[  146.888131]  dump_stack+0x18/0x24
[  146.891432]  print_usage_bug.part.0+0x29c/0x364
[  146.895950]  mark_lock+0x778/0x978
[  146.899338]  mark_held_locks+0x58/0x90
[  146.903074]  lockdep_hardirqs_on_prepare+0x100/0x210
[  146.908025]  trace_hardirqs_on+0x5c/0x1cc
[  146.912025]  _raw_spin_unlock_irqrestore+0x6c/0x70
[  146.916803]  task_call_func+0x110/0x164
[  146.920625]  trc_wait_for_one_reader.part.0+0x5c/0x3b8
[  146.925750]  check_all_holdout_tasks_trace+0x124/0x480
[  146.930874]  rcu_tasks_wait_gp+0x1f0/0x3b4
[  146.934957]  rcu_tasks_one_gp+0x4a4/0x570
[  146.938953]  rcu_tasks_kthread+0xd4/0xe0
[  146.942862]  kthread+0x148/0x208
[  146.946079]  ret_from_fork+0x10/0x20
              

(This actually locks up the system without any further print FWIW).

I'll keep testing and start debugging now, but if I can help you with anything immediately, please
do shout.


[1]
This referring to sched/cleanup at time of writing:
e127838bf8f9 sched: Cleanup NOCLOCK
ce024feefe1c sched/ext: Implement p->srq_lock support
6ef342071dd7 sched: Add {DE,EN}QUEUE_LOCKED
ed738ce6f9fb sched: Add shared runqueue locking to __task_rq_lock()
94f197f28834 sched: Add flags to {put_prev,set_next}_task() methods
254d43c94105 sched: Add locking comments to sched_class methods
f8864b505a17 sched: Make __do_set_cpus_allowed() use the sched_change pattern
d0e9cfb835d3 sched: Rename do_set_cpus_allowed()
cfcabf45249d sched: Fix do_set_cpus_allowed() locking
f7b9b39041fb sched: Fix migrate_disable_switch() locking
91128b33456a sched: Move sched_class::prio_changed() into the change pattern
c59dc6ce071b sched: Cleanup sched_delayed handling for class switches
13ea43940095 sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern
f0b336327a1b sched: Re-arrange the {EN,DE}QUEUE flags
b55442cb4ec1 sched: Employ sched_change guards

[2]
5b726e9bf954 sched/fair: Get rid of throttled_lb_pair()


